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
 1. Pierre-Yves Strub

(*) To be confirmed

== Coding ideas ==

 * coqide:
   1. Make the goal window display all goals, not only the focused one.  Consider using a notebook widget to let the user look at any goal by changing page.  Think about creative uses for the notebook page labels.
   1. Give more structure to the internal representation of document to confine failures to sub-branches.  Like an unfinished branch started with a bullet or {.  This way Coq could continue checking the rest of the proof.
   1. Add a "quick compile" button, as in coqc -quick

 * tools:
   1. Coq_makefile: use a real template engine to generate the Makefile, instead of playing with OCaml strings.
   1. coqobjinfo (like ocamlobjinfo) reusing some code from votour to get infos about a .vo or .vio file
   1. make it possible to hide all support files (e.g. .glob files) to make directory listing and file selection/auto-completion operation simpler.  (comment: very much in the spirit of what .coq-native/ does for native_compute files).

 * type inference:
   1. Print canonical structures inference failures in error messages.  E.g. "typing error... + during type inference this CS inference failed"

 * bench system:
   1. honor branches named like bench/v8.4/this-experiment and publish the report somewhere so that we can have feedback on an experiment without pushing it to the main branch.
   1. fix "coqc -quick -time" [[https://coq.inria.fr/bugs/show_bug.cgi?id=3934|Bug 3934]]

 * improving Search:
   1. finding theorems that fit a pattern thanks to type classes, canonical structures, or modulo iota-reduction...
   1. Improving display mechanism: trigger "Set Printing All" only for a sub-expression given by a pattern (using the pattern language).
   1. Invent a "search" that works for tactics: search the patterns used in the tactic, or use patterns given by the user. ([[http://staff.computing.dundee.ac.uk/katya/ML4PG/|related work]])

 * developers manual:
   1. Enrich the document started by Wojciech Jedynak [[https://github.com/wjzz/Coq-Developers-Manual/releases/download/0.1/devman.pdf]],
      [[https://github.com/wjzz/Coq-Developers-Manual|github]].
   1. Write down the policies (a real document): how to submit code to Coq, how to submit a contrib, how opam packages should be written...
 
 * tactics:
   1. decouple the prelude from the tactics

 * Notation:
   1. fine grained control on enabled notations and coercions
   1. control notation/implicits/coercions display on a sub term

 * stdlib:
   1. uniform names/notations see [[https://coq.inria.fr/bugs/show_bug.cgi?id=4110|Bug 4110]]
