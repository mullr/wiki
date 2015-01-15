This page is an attempt to sum up the Coq Dev discussion about where Coq looks for what on hard-disks.

This question can be rephrased as "what is accessible by {{{Require}}} and {{{Declare ML Module}}} commands".

The motivation for changing things are of 2 kinds:
 * Scalability: We want users to use more external libraries (using the opam engine). Therefore, we want users to be able to have a lot of different libraries installed on their systems. Installing a library mustn't break an existing setting.
 * Library development simplification: We want to make life easier for people working on a development that depends on the current development version of a library they develop.

== Terminology ==

OCaml paths and Coq one behave differently. But {{{Declare ML Module}}} lives in the OCaml world, so Coq interacts with OCaml paths.
In OCaml, a subdirectory is ignored. In Coq, it represents a sub-library. That can be rephrased as: In Coq, files in subdirectories are put in a proper "namespace" but are __always__ in the load path.

While you set up a path for look up to coqtop, you can __sometime__ give it a prefix that we call its ''logical'' prefix.

Coq introduce a notion of recursive include whose specification is : act as if all subdirectories have been include.
Let's insist more on the OCaml/Coq difference : in the OCaml word, it adds new accessible files. In Coq one, it gives shorter names for already accessible files!

''Recursively include with logical prefix Foo'' is not really correct. It is a shorten for ''include with logical prefix Fla'' and recursively include (with no logical prefix).

There is a path called COQLIB that represents where Coq stuff are installed. It is computed from '''coqtop''' location (standard one is {{{$(dirname $(which coqtop))../share/coq/}}})

== LoadPath ==

 * COQLIB/theories is __recursively__ included in Coq world with logical prefix Coq 
 * COQLIB/plugins is __recursively__ included in Coq world with logical prefix Coq. It is also recursively included in OCaml world.
 * COQLIB/user-contrib is included in Coq world with no logical path. It is also recursively included in OCaml world.
 This is where {{{make install}}} of '''coq_makefile''' install stuff.
 ||There are discussion about not recursively include it in the OCaml world but making coq_makefile install OCaml stuff in a flat directory COQLIB/user-contrib-plugins. This would have the benefit to illustrate on the file system that 2 independently distributed myplugin.cmxs will destroy everybody Coq installation. The opposite proposal is to implement inside Coq namespaces for OCaml but no realistic way to make OCaml load both super/myplugin.cmxs and great/myplugin.cmxs has been found.||

 * for i in $XDG_DATA_DIRS; $i/coq are included with no logical prefix. They are also recursively included in OCaml world.
 This is where {{{make userinstall}}} of coq_makefile can install stuff.
 Same remark about the badness of name clash with the recursive inclusion in OCaml world. There is where an extra difficulty. A free desktop application is supposed to use only one dir in each XDG_DATA_DIR but $i/coq/plugins would be include (in the sub library plugins) in the Coq world if we use this canevas which is not clean.

 * for i in $COQPATH; $i/coq are included with no logical prefix. It is also recursively included in OCaml world.
 Same remark as above.
 ||There is also an idea of allowing the syntax {{{COQPATH="/toto=Foo;tata=Bar"}}} to give logical path Foo to /toto and Bar to tata instead of the empty one.||

 * On '''coqtop''' command line {{{-I path}}} includes ''path'' in the OCaml world. (Nothing in the Coq world)

 * On '''coqtop''' command line {{{-Q path Name}}} includes ''path'' in the coq world with the logical prefix Name. (nothing in the OCaml world) (TODO : if {{{-Q . ""}}} works is unclear)

 Remember that subdirs are there but in their namespaces.

 * On '''coqtop''' command line {{{-R path Name}}} recursively includes ''path'' in the coq world with logical prefix Name. (Nothing in the OCaml world)

== Namespace awareness ==

Compiled Coq files (.vo) are aware of their full(/absolute?) Logical name. How and what for is questonnable.

 * How they learn their name reuse -R -Q mechanism in a questionable way. Coqc asks itself "what is the longest logical path I know for this file (that have physical path foo/bar) I am compiling This will be its full logical name."
 ||This auto naming using a kind of overload of -R and -Q semantic may be less clear than an explicit naming. On the opposite, the latter would create a kind of redundancy.||

 * How they use their name is "I am loaded using a given logical name but would the full logical name I know I have be a correct name for loading me" If not, I fail (This is the annoying error "Bar is compiled as Foo.Bar" if you don't write the correct -R)

 ||We could say that for now on the filesystem gives to a file a logical name and that when loaded the file check it accepts to take this name. It is belt and suspenders. But, since the file knows its full logical name, we could let a vo file be in the logical library and sub libraries he wants to be independently for where it is on the filesystem. We could then imagine a setting where all vo file in all the subdirectories of all the included directories are Requirable. There is no question of logical prefix anymore. All include are in a way recursive but the difference is whether one has to use its full logical name to require a file or can use any suffix of it.||
 ||Indeed, the necessity of the logical prefix is only to conduct the auto generation of full logical name so that is what should be adapted. The argument against is that the flexibility of this solution may go in the opposite direction of scalability. What if 2 files in different logical path want to take the same logical name, There could be 2 files with different logical names that install themselves at the same place (that would be correct as long as I don't install both), Is it really a good thing that for example you make a new module for the already existing library. Once again what if someone else find the this module is really missing in the first library and copy your extra file in its source tree, ... ||

== More facts ==
 * There must be mention that relying on file system semantic is fragile. Especially when we have in mind that, by default, MacOS HFS+ is case aware but case insensitive and that you cannot count on it to distinguish List and list!

 * '''Coq_makefile''' overload even more -R and -Q command line arguments. They mean to it "the paths you mention are part of the current development" and for example {{{make clean}}} cleans the mention physical paths. Logical paths are use to infer how to make the doc, where to install the vo, etc ...

 ||This is the critical problem in presence of a chain of dependant library as {{{-argument -Q ../deps Deps}}} would say to '''coqtop''' include that without telling to coq_makefile this is what you have to take care by '''coqdep''' also need the -Q and don't get it this way. (Thus the only solution is the COQPATH global variable game)||
 ||We may imagine on the opposite make '''coqdep''' (and '''coqdoc''') accepts all '''coqtop''' argument but ignores the majority of them even it is a bit sad!||

 * Requiring a .vo file requires recursively all its dependencies, that are expressed as full logical paths.  Coq searches for the .vo file using the logical
   path that today it is almost a physical path too, since .vo are installed in theories/ or user-contribs/ following their logical path. 

 * A .vo file is not easy to relocate, since the file is produced by marshaling and there is no way decent to traverse the data and apply a mapping to all 
   logical names.
