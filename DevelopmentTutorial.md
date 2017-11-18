
The information below are valid for developing in Coq 8.7 (2017)

Developing Coq: A tutorial
==========================

Getting Coq sources
-------------------

Coq sources are hosted on [GitHub](https://github.com/coq/coq). The recommended way is to get them is:

`git clone https://github.com/coq/coq.git`

Compiling Coq sources
---------------------

Follow the instructions from the file INSTALL of the Coq archive

Basic developer setup
---------------------

Development process might be faster by working locally and not installing Coq in the path. To do so run

`./configure -local`

The `-local` option means that you will not need to install coq to `/usr/local` but instead that you will run Coq directly from the `bin` subdirectory.

<!-- The `-debug` option will allow to use the debugger. -->

Developer environment
---------------------

For compilation shortcuts under Emacs, see [CoqDevelopmentRaccourcisPourDevelopperSousEmacs](CoqDevelopmentRaccourcisPourDevelopperSousEmacs).

Directory structure
-------------------

The Coq archive contains the following subdirectories:

- `bin` where binaries are created

- `dev` miscellaneous information for developers

- `doc` the Coq documentation and User's reference manual sources

- `man` Coq man pages

- `tools` sources of `coqdoc`, `coqdep`, `coq-tex`, `coq_makefile`, etc.

- `theories` the Coq standard library

- `plugins` sources of plugins (extraction, firstorder, ...)

- `test-suite` the Coq test suite

The sources of Coq reside in the following directories

- `config` OCaml files created by the configure script

- `lib` utilities, general-purpose data structures, ...

- `kernel` the Coq kernel, which implements the type-checker of the Calculus of Inductive Constructions

- `library` global names, infrastructure for backtracking, reading/writing vo files, ...

- `intf` declares various non-kernel types

- `pretyping` unification, compilation of pattern-matching, type inference, coercions

- `engine` low-level part of the proof engine (only from post-8.5 trunk)

- `proofs` high-level part of the proof engine

- `tactics` specific tactics and the tactic language

- `interp` syntax interpretation layer: notations, implicit arguments, globalization of names, ...

- `parsing` parsers

- `printing` printers

- `stm` the state transition machine for asynchronous evaluation

- `vernac` vernacular commands

- `toplevel` interactive loop, treatment of options, ...

- `ide` source of the CoqIDE graphical interface

- `grammar` camlp4/5 grammar extensions used in the sources (this defines e.g. the TACTIC EXTEND macro) The sources of the stand-alone Coq checker are in `checker`

.ml4 files
----------

The Coq source contains the usual Objective Caml `.ml` and `.mli` files but it also contains `.ml4` files that need to be preprocessed by camlp4. The preprocessing is always done on the fly except when computing dependencies (`make depend`).

<!-- The `.ml4` should usually contain a special comment :

`(*i camlp4deps: \"parsing/grammar.cma\" i*)`

This comment is used to tell camlp4 which preprocessing module should be used. These files contain grammar extensions, see for example `tactics/extratactics.ml4`.
-->

Main developer targets
----------------------

A complete compilation is done by `make world`. It takes about 10 minutes with option -j4 on a 4 core processor.

When developing, you may use partial targets such as:

- `states` builds the initial state, this is required to run Coq.

- `byte` builds `bin/coqtop.byte` and plugins in byte code; this is the fastest target when debugging the OCaml code.

- `bin/coqtop pluginsopt` to compile Coq to native code.

- `coqide` builds CoqIDE and the initial state but no standard library.

- `coqbinaries` compiles `bin/coqtop`, `bin/coqc`, `bin/coqchk` but neither `bin/coqide` nor the library

Dependencies
------------

The compiling process require preprocessing, which requires some compiling, this is why the following sequence should better be respected when adding new files to Coq:

-   `make clean` for binary compatibility
-   `make world` to rebuild (or simply `make`)

Another way to clean the archive from all non-registered files is to use `git clean -fxd .`.

Adding a new file
-----------------

Files to be linked are registered in files named `directory/directory.mllib` (e.g. `pretyping/pretyping.mllib`). The files must be given in an order compatible with the linking dependency order.

Simple debugging with `Drop`
--------------------------

Now run `bin/coqtop.byte` and type `Drop.`. This will drop to the OCaml toplevel. Then type:

```
#use "include";;
#trace String.uppercase;; (* or any name of a function you'd like to trace *)
go();;
```

The last `go()` restarts the Coq parser. You can type any Coq command and observe when it calls the function asked to be traced.

Debugging with ocamldebug
-------------------------

Look at file `dev/doc/debugging.txt` in the archive.
