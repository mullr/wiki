= First Coq Coding Sprint, June 22-25 2015 Sophia-Antipolis =

This page collects useful infos for the participants to the first Coq Coding Sprint

== What is a Coding Sprint? ==

A coding sprint is an event that brings together the core developers of Coq
and people willing to understand, improve or extend the system.

== Location ==

The coding sprint will take place at the Inria Center in Sophia-Antipolis ([[https://team.inria.fr/marelle/venue/|how to reach the Inria center]], [[https://team.inria.fr/marelle/accomodation-information/|accommodation infos]]).

== Program ==

TBA, very likely to include a couple of tutorials on

 1. The architecture of the system.
 2. How to write a plugin.
 3. How to write a tactic.

== Registration ==

For organization purposes we require the participants to register (free of charge) by following these two steps:

 1. subscribe to the [[https://sympa.inria.fr/sympa/info/coq-coding-sprint|coordination mailing list]]
 2. post a [[mailto:coq-coding-sprint@inria.fr?subject=REGISTER|message with subject REGISTER]] and write in the body of the message a few lines draft plan of what the participant would like to work on during the sprint.

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
 1. Carst Tankink (*)

(*) To be confirmed

== Coding ideas ==

 * Coqide
   1. Make the goal window display all goals, not only the focused one.  Consider using a notebook widget to let the user look at any goal by changing page.  Think about creative uses for the notebook page labels.
   1. Give more structure to the internal representation of document to confine failures to sub-branches.  Like an unfinished branch started with a bullet or {.  This way Coq could continue checking the rest of the proof.
   1. ...

 * coq_makefile
   1. Use a real template engine to generate the Makefile, instead of playing with OCaml strings
   1. ...

 * Canonical Structures
   1. Take CS inference failures in error messages.  E.g. "typing error... + during type inference this CS inference failed"
   1. ...

 * Bench system
   1. honor branches named like bench/v8.4/this-experiment and publish the report somewhere so that we can have feedback on an experiment without pushing it to the main branch.

 * Improving Search
   1. finding theorems that fit a pattern thanks to type classes, canonical structures, or modulo iota-reduction...
   1. Improving display mechanism: trigger "Set Printing All" only for a sub-expression given by a pattern (using the pattern language).
   1. Invent a "search" that works for tactics: search the patterns used in the tactic, or use patterns given by the user. ([[http://staff.computing.dundee.ac.uk/katya/ML4PG/|related work]])

 * Developers manual
   1. Enrich the document started by Wojciech Jedynak [[https://github.com/wjzz/Coq-Developers-Manual/releases/download/0.1/devman.pdf]],
      [[https://github.com/wjzz/Coq-Developers-Manual|github]].
   1. Write down the policies (a real document): how to submit code to coq, how to submit a contrib, how opam packages should be written...
 
 * Tactics
   1. decouple the prelude from the tactics

 * Notation
   1. fine grained control on enabled notations and coercions
   1. control notation/implicits/coercions display on a sub term

 * Stdlib
   1. uniform names/notations see [[https://coq.inria.fr/bugs/show_bug.cgi?id=4110|Bug 4110]]

 * ...
