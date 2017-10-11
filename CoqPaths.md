This page is an attempt to sum up the Coq Dev discussion about where Coq looks for what on hard-disks.

This question can be rephrased as "what is accessible by `Require` and `Declare ML Module` commands".

The motivation for changing things are of 2 kinds:

-   Scalability: We want users to use more external libraries (using the opam engine). Therefore, we want users to be able to have a lot of different libraries installed on their systems. Installing a library mustn't break an existing setting.
-   Library development simplification: We want to make life easier for people working on a development that depends on the current development version of a library they develop.

Terminology
===========

OCaml paths and Coq ones behave differently. But `Declare ML Module` lives in the OCaml world, so Coq interacts with OCaml paths. In OCaml, a subdirectory is ignored. In Coq, it represents a sub-library. That can be rephrased as: In Coq, files in subdirectories are put in a proper "namespace" but are always in the load path.

While you set up a path for look up to coqtop, you can sometimes give it a prefix that we call its *logical* prefix.

Coq introduces a notion of recursive include whose specification is: act as if all subdirectories have been include. Let's insist more on the OCaml/Coq difference: in the OCaml world, it adds new accessible files. In Coq's one, it gives shorter names for already accessible files!

*Recursively include with logical prefix Foo* is not really correct. It is a shortening for *include with logical prefix Fla* and recursively include (with no logical prefix).

There is a path called COQLIB that represents where Coq stuff are installed. It is computed from **coqtop** location (standard one is `$(dirname $(which coqtop))../share/coq/`)

LoadPath
========

-   COQLIB/theories is recursively included in Coq world with logical prefix Coq
-   COQLIB/plugins is recursively included in Coq world with logical prefix Coq. It is also recursively included in OCaml world.
-   COQLIB/user-contrib is included in Coq world with no logical path. It is also recursively included in OCaml world. This is where `make install` of **coq\_makefile** installs stuff.

    \[Table not converted\]

-   for i in $XDG\_DATA\_DIRS; $i/coq are included with no logical prefix. They are also recursively included in the OCaml world. This is where `make userinstall` of coq\_makefile can install stuff. Same remark about the badness of name clash with the recursive inclusion in OCaml world. This is where an extra difficulty comes. A free desktop application is supposed to use only one dir in each XDG\_DATA\_DIR but $i/coq/plugins would be include (in the sub library plugins) in the Coq world if we use this canvas which is not clean.
-   for i in $COQPATH; $i/coq are included with no logical prefix. It is also recursively included in OCaml world. Same remark as above.

    \[Table not converted\]

-   On **coqtop** command line `-I path` includes *path* in the OCaml world. (Nothing in the Coq world, **this is a change w.r.t. coq v8.4**, people porting from v8.4 should replace -I foo by -Q foo "" in their project files and regenerate makefiles, and keep -I foo for OCaml files if any. To reduce risks of overloading when installed in concurrency with files from other projects, it is even recommended to use -Q foo Name for some appropriate root Name.)
-   On **coqtop** command line `-Q path Name` includes *path* in the coq world with the logical prefix Name. (Nothing in the OCaml world, **new in coq v8.5**)

    Remember that subdirectories of *path* are visible using a qualified name.

-   On **coqtop** command line `-R path Name` recursively includes *path* in the coq world with logical prefix Name. (Nothing in the OCaml world, which is a change w.r.t. coq v8.4.)

Namespace awareness
===================

Compiled Coq files (.vo) are aware of their full(/absolute?) Logical name. How and what for is questonnable.

-   How they learn their name reuse -R -Q mechanism in a questionable way. Coqc asks itself "What is the longest logical path I know for this file (that have physical path foo/bar) I am compiling. This will be its full logical name."

    \[Table not converted\]

-   How they use their name is "I am loaded using a given logical name but would the full logical name I know I have be a correct name for loading me" If not, I fail (This is the annoying error "Bar is compiled as Foo.Bar" if you don't write the correct -R)

    \[Table not converted\]

More facts
==========

-   There must be mention that relying on file system semantic is fragile. Especially when we have in mind that, by default, MacOS HFS+ is case aware but case insensitive and that you cannot count on it to distinguish List and list!
-   **Coq\_makefile** overloads even more -R and -Q command line arguments. They mean to it "the paths you mention are part of the current development" and for example `make clean` cleans the mention physical paths. Logical paths are use to infer how to make the doc, where to install the vo, etc ...

    \[Table not converted\]

-   Requiring a .vo file requires recursively all its dependencies, that are expressed as full logical paths. Coq searches for the .vo file using the logical path that today it is almost a physical path too, since .vo are installed in theories/ or user-contribs/ following their logical path.
-   A .vo file is not easy to relocate, since the file is produced by marshalling and there is no way decent to traverse the data and apply a mapping to all logical names.

