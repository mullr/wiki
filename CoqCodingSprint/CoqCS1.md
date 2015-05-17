= First Coq Coding Sprint, June 22-25 2015 Sophia-Antipolis =

This page collects useful infos for the participants to the first Coq Coding Sprint

== What is a Coding Sprint? ==

A coding sprint is an event that brings together the core developers of Coq
and people willing to understand, improve or extend the system.

== Location ==

The coding sprint will take place at the Inria Center in Sophia-Antipolis ([[https://team.inria.fr/marelle/venue/|how to reach the Inria center]], [[https://team.inria.fr/marelle/accomodation-information/|accommodation infos]]).

== Program ==

[[attachment:schedule-coqcs1.pdf| Tentative schedule]]

== Registration ==

For organization purposes we require the participants to register (free of charge) by following these two steps:

 1. subscribe to the [[https://sympa.inria.fr/sympa/info/coq-coding-sprint|coordination mailing list]]
 2. post a [[mailto:coq-coding-sprint@inria.fr?subject=REGISTER|message with subject REGISTER]].  In case you already have an project in mind, please include a short description of it in the registration email.

The mailing list is also the preferred channel to contact the organizers.
Subscription is required in order to post.

== List of participants ==

 1. Yves Bertot (*)
 1. Pierre Boutillier
 1. Maxime Dénès
 1. Hugo Herbelin
 1. Matthieu Sozeau
 1. Enrico Tassi
 1. Bruno Barras (*)
 1. Benjamin Gregoire (*)
 1. Pierre Letouzey (*)
 1. Yann Régis-Gianas (*)
 1. Jaap Boender
 1. Arthur Charguéraud
 1. Nicolas Magaud
 1. Gabriel Scherer
 1. Jason Gross
 1. Assia Mahboubi
 1. Arnaud Spiwack
 1. Pierre-Marie Pédrot (*)
 1. Laurence Rideau
 1. Jacques-Henri Jourdan
 1. Reynald Affeldt
 1. Guilhem Jaber
 1. Jasmin Blanchette
 1. Cyril Cohen
 1. Nico Lehmann

(*) To be confirmed

== Coding ideas ==

 * coqide:
   1. Make the goal window display all goals, not only the focused one.  Consider using a notebook widget to let the user look at any goal by changing page.  Think about creative uses for the notebook page labels.
   1. Add a "quick compile" button, as in coqc -quick
   1. Make coqide silently kill coqtop and save the current position when too many tabs are opened and restart coqtop qhen the user re-opens an old tab.
   1. Remove use of threads in coqide back end: use CPS+Unix.select to code a cooperative threads library (in the LWT style).

 * tools:
   1. Coq_makefile: use a real template engine to generate the Makefile, instead of playing with OCaml strings; alternatively make coq_makefile just generate a Makefile.conf snippet with the user setting and copy in the current directory a standard Makefile that uses conditionals at run time (not at generation time as it is done now).  In both cases the Makefile should be easier to read from the sources of coq_makefile, now it is really hard to do so.
   1. coqobjinfo (like ocamlobjinfo) reusing some code from votour to get infos about a .vo or .vio file: modules/lemmas included, axioms, ...
   1. make it possible to hide all support files (e.g. .glob files) to make directory listing and file selection/auto-completion operation simpler.  (comment: very much in the spirit of what .coq-native/ does for native_compute files).  One could also say that a .vo file is a directory, that the segments in which the .vo file are organized are files with standard names in these directories and that all extra metadata are again files in such directory. E.g. foo.vo/{lib,opaque,glob}.  This is also compatible with Makefiles, since it is possible to target a single components (a .vio could be foo.vo/stmprooftasks and no-or-partial foo.vo/opaque).

 * type inference, unification:
   1. Print canonical structures inference failures in error messages.  E.g. "typing error... + during type inference this CS inference failed"
   1. Add proper categories to unification variables (goals, typeclass constraints, implicits that should be solved...)
   1. Reimplement and merge typeclasses eauto, auto and eauto using the new tactic engine.
   1. Let the user tell TI when the expected type should be propagated down via an Argument directive.  E.g. with "Arguments cons {A} | x xs" type inference should unify A (probably an implicit) with the A in the expected type before processing x and xs.  If the expected type is "list Q" and "x" is a "nat", then "N->Q" coercion could be inserted.  If we wait, we may infer that the list is "list nat" and there is not coercion to "list Q".

 * bench system:
   1. honor branches named like bench/v8.4/this-experiment and publish the report somewhere so that we can have feedback on an experiment without pushing it to the main branch.
   1. plug decent graphs into ci.inria.fr/coq
   1. fix "coqc -quick -time" [[https://coq.inria.fr/bugs/show_bug.cgi?id=3934|Bug 3934]]

 * improving Search:
   1. finding theorems that fit a pattern thanks to type classes, canonical structures, or modulo iota-reduction, or delta steps (see also [[https://coq.inria.fr/bugs/show_bug.cgi?id=3904|#3940]])
   1. Improving display mechanism: trigger "Set Printing All" only for a sub-expression given by a pattern (using the pattern language).
   1. Invent a "search" that works for tactics: search the patterns used in the tactic, or use patterns given by the user. ([[http://staff.computing.dundee.ac.uk/katya/ML4PG/|related work]])
   1. Sort search result according to a priority heuristic to display more relevant results first.

 * developers manual:
   1. Enrich the document started by Wojciech Jedynak [[https://github.com/wjzz/Coq-Developers-Manual/releases/download/0.1/devman.pdf]],
      [[https://github.com/wjzz/Coq-Developers-Manual|github]].
   1. Write down the policies (a real document): how to submit code to Coq, how to submit a contrib, how opam packages should be written...
 
 * tactics:
   1. decouple the prelude from the tactics
   1. Coding the tactics of the `logic.ml` file in the new proof engine. These were the primitive tactics of the old proof engine and are currently implemented using a compatibility layer which, in particular, makes the `Info` command unaware of their semantics.
   1. Implement a "debug" trace for tactics. The `Info` command gives a trace of the tactics which were effectively applied. In order to debug scripts, it may be useful to also have a trace of all the tactics which were attempted.

 * declarative proof mode
   1. More robust implementation of the declarative proof mode. The declarative mode, because it's older, doesn't really take advantage of the disciplined focus API of the new proof engine and re-implements its features in a fragile way. To move forward, the code must be cleaned up and use the modern API.

 * Notation:
   1. fine grained control on enabled notations and coercions
   1. control notation/implicits/coercions display on a sub term

 * stdlib:
   1. uniform names/notations see [[https://coq.inria.fr/bugs/show_bug.cgi?id=4110|Bug 4110]]
   1. document the axiom used in each file/file-group
   
