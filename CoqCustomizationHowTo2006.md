
**This document is referring to development under Coq at the period of Coq 8.1 and 8.2. It is outdated**

Coq customization: A tutorial
=============================

The object of this document is to guide the user towards the implementation of new commands or tactics for the Coq proof assistant. It assumes familiarity with Objective Caml and a basic knowledge of the use of GNU Make.

Before you start
----------------

*Written by* [PierreCorbineau](PierreCorbineau)

### Compiler

You will need the following packages:

-   Objective Caml compiler `ocaml`
-   Optionally the native compilers `ocaml-native-compilers`
-   GNU Make
-   the lablgtk2 development library for coqide: `liblablgtk2-ocaml`
-   Subversion (`svn` to get the sources from the repository)

### Source

To get the source, you have to type :

`svn checkout svn://scm.gforge.inria.fr/svn/coq/trunk coqsrc`

This will install the coq source in the coqsrc subdirectory.

To access earlier versions, use the `-r` *nnnn* option.

Basic setup
-----------

*Written by* [PierreCorbineau](PierreCorbineau)

### Running {{{./configure }}}

Before first compiling Coq, you need to setup paths for the Coq library and binaries. To do that run `./configure -local` form the `coqsrc` directory.

The `-local` option option means that you will not need to install coq to `/usr/local` but instead that you will run Coq directly from the `coqsrc/bin` subdirectory.

The `./configure` script can also be told to ignore parts of the standard library, which speeds up the compilation.

### Directory structure

The `coqsrc` directory contains the following subdirectories:

bin where binaries are created

dev files used for debugging

doc the Coq documentation and User's manual sources

man Coq man pages

tools `coqdoc`, `coqdep`, `coq-tex` and `coq_makefile` sources

theories the Coq standard library

states Contains binary images for Coq's initial state

test-suite the Coq test suite

config OCaml files created by the configure script

lib utilities (pretty printing and data structures)

kernel source for the Coq kernel

pretyping internals for unification, matching, type inference, coercions

proof source for the proof engine

tactics source for the basic tactics

interp interpretation layers (notations, implicit arguments)

library handling of the standard library

parsing parsing and pretty printing files

toplevel source for the interactive loop and treatment of options

ide source for the CoqIDE graphical interface

### .ml4 files

The Coq source contains the usual Objective Caml `.ml` and `.mli` files but it also contains `.ml4` files that need to be preprocessed by camlp4. the preprocessing is always done on the fly except when computing dependencies (`make depend`). The `.ml4` should usually contain a special comment :

`#!ocaml (*i camlp4deps: \"parsing/grammar.cma\" i*)`

This comment is used to tell camlp4 which preprocessing module should be used. These file contain grammar declaration, see for example `contrib/cc/g_congruence.ml4`.

### A first compilation cycle

We are now ready for compiling Coq for the first time, this may take a while, usually, consider compiling with at least `-j 2` if you have enough memory. A complete comiplations is done by `make world`.

Whe developping, you may use partial targets such as:

coqbinaries compiles coqtop and coqc but neither coqide nor the library

states builds the initial state, this is required to run Coq.

bin/coqtop.byte is the fastest target when debugging the OCaml code.

coqide builds CoqIDE but no standard library.

### Dependencies

The compiling process require preprocessing, which requires some compiling, this is why the following sequence should be respected when adding new files to Coq:

-   `make depend` to add the new files to the dependencies
-   `make clean` for binary compatibility
-   `make world` to rebuild

A first example
---------------

*Written by* [PierreCorbineau](PierreCorbineau)

For our example, we will add a new directory `custom` in the `contrib/` subdirectory, which is the standard place for additional files.

### New files and {{{Makefile}}}

Create a file `g_custom.ml4`, add the necessary `camlp4deps` comment. You now need to modify the `Makefile` to add this file to the Coq binaries.

-   In the definition of the `LOCALINCLUDES` variable, add

    > `-I contrib/custom`.

-   Somewhere before the definition of `CONTRIB`, add a new line:

`CUSTOMCMO=contrib/custom/g_custom.cmo`

-   append `$(CUSTOMCMO)` to the definition of `CONTRIB`
-   append `contrib/custom/g_custom.ml4` to `ML4FILES`

For each further `.ml` files you will create, add a corresponding `.cmo` entry to the `CUSTOMCMO` variable definition.

### Registering custom commands

Our first example is the echo command which prints its argument in upper case: it can be programmed using the following macro:

    VERNAC COMMAND EXTEND Echo
    | [ "Echo" string(s)] -> [ Pp.msgnl (Pp.str (String.uppercase s)) ]
    END

This magical incantation will register a toplevel command. for tactics, use `TACTIC EXTEND` instead.

### Compile and test

Run `make states`, then `bin/coqtop`. Now try typing `Echo "Echo"`

### Simple debugging with Drop

Now run `bin/coqtop.byte` and type `Drop.` This will drop to the OCaml toplevel. Then type:

    #use "include";;
    #trace String.uppercase;;
    go();;

This will restart the Coq parser. Now try `echo` again.

More internals
--------------

### The {{{constr}}} datatype

### The {{{tactic}}} datatype

### Internal tacticals

### Typing -- Unification -- Reduction -- Conversion

### Referring to (Coq) Library constants

An advanced example: Classical propositional logic
--------------------------------------------------
