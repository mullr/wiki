This page is an attempt to sum up the Coq Dev discussion about where Coq looks for what on hard-disks.

This question can be rephrased as what is accessible by {{{Require}}} and {{{Declare ML Module}}} commands.

The motivation for changing things are of 2 kinds:
 * Scalability: We want users to use more external libraries (using the opam engine). Therefore, we want users to be able to have a lot of different libraries installed on their systems. Installing a library mustn't break an existing setting.
 * Library development simplification: We want to make life easier for people working on a development that depends on the current development version of a library they develop.

== Terminology ==

OCaml paths and Coq one behave differently. But {{{Declare ML Module}}} lives in the OCaml world so Coq interacts with OCaml paths.
In OCaml, a subdirectory is ignored. In Coq, it represents a sub-library. That can be rephrased as: In Coq, files in subdirectories are put in a proper "namespace" but are __always__ in the load path.

While you set up a path for look up by coq top, you can __sometime__ give it a prefix that we call its ''logical'' prefix.

Coq introduce a notion of recursive include whose specification is : act as if all subdirectories have been include.
Lets insist more : in the OCaml word, it adds new accessible files. In Coq one, it gives shorter names for already accessible files!

''Recursively include with logical prefix Bla'' is not really correct. It is a shorten for ''include with logical prefix Bla'' and recursively include (with no logical prefix).

There is a path called COQLIB that represents where Coq stuff are and is computed from coqtop location (standard one is $(dirmane $(which coqtop))../share/coq/) 

== LoadPath ==

 * COQLIB/theories is __recursively__ included in Coq world with logical prefix Coq 
 * COQLIB/plugins is __recursively__ included in Coq world with logical prefix Coq. It is also recursively included in OCaml world.
 * COQLIB/user-contrib is included in Coq world with no logical path. It is also recursively included in OCaml world.

 This is where {{{make install}}} of coq_makefile install stuff.

 There are discussion about not recursively include it in the OCaml world but making coq_makefile install OCaml stuff in a flat directory COQLIB/user-contrib-plugins. This would have the benefit to illustrate on the file system that 2 independently distributed myplugin.cmxs will destroy everybody Coq installation. The opposite proposal is to implement inside Coq namespaces for OCaml but no realistic way to make OCaml load both super/myplugin.cmxs and great/myplugin.cmxs has been found.

 * for i in $XDG_DATA_DIRS; $i/coq are included with no logical prefix. It is also recursively included in OCaml world.

 This is where {{{make user install}}} of coq_makefile can install stuff.

 Same remark about the badness of name clash with the recursive inclusion in OCaml world. There is where an extra difficulty. A free desktop application is supposed to use only one dir in each XDG_DATA_DIR but $i/coq/plugins would be include (in the sub library plugins) in the Coq world if we use this canevas which is not clean.

 * for i in $COQPATH; $i/coq are included with no logical prefix. It is also recursively included in OCaml world.

  Same remark as above.

  There is also an idea of allowing the syntax {{{COQPATH="/toto=Foo;tata=Bar"}}} to give logical path Foo to /toto and Bar to tata instead of the empty one.

 * On coqtop command line {-I ''path''} includes ''path'' in the OCaml world. (Nothing in the Coq world)

 * On coqtop command line {{{-Q ''path'' Name}}} includes ''path'' in the coq world with the logical prefix Name. (nothing in the OCaml world) (TODO : if {{{-Q . ""}}} works is unclear)

 Remember subdirs are there but in their namespace.

 * On coqtop command line {{{-R ''path'' Name}}} recursively includes ''path'' in the coq world with logical prefix Name. (Nothing in the OCaml world)

== Namespace awareness ==

Compiled Coq files are aware of their longest possible Logical names but how and what it use used for is questonnable.

 * How they learn their name reuse -R -Q mechanism in a questionable way. Coqc asks itself "what is the longest logical path I know for this physical path I am compiling, Good this will be its full logical name"

 * How they use they name is "I am load using a name but would the full logical name I know I have be a correct name for loading me" If not, I fail (This is the annoying error Bar is compiled as Foo.Bar)

I'm late I must go c u :-)
