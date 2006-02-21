## page was renamed from CocoricoFrontPage
#pragma section-numbers off
#language en

[[TableOfContents]]

Here we will present ideas of what constitutes a well written Coq source file. We discuss the general issues that affect the ''shape'' of the Coq scripts and consequently their  ''legibility'' and ''re-usability''. Yes, we are interested in reading and editting ascii Coq sources!

This is intended to be a collection of suggestions for good style and good practice, acknowledging that usually more than one way is possible. 

For the discussion of issues related to the content of specific formalisations and general (type theoretic) tips and traps to avoid please use TipsAndTricks.

= File Structure =

 * Following the shape of the files in the standard library of Coq, start the Coq files with a comment of the form

{{{
(************************************************************************)
(* Copyright <YEAR> <AUTHOR>                                                          *)
(* <LICENSE>                                                                                           *)
(************************************************************************)
}}}

 This will credit the author(s) and clarifies any license issues, which is necessary for reusability of your code.

 *  Use [http://coq.inria.fr/doc/Reference-Manual015.html#toc80 coqdoc]-style comments graciously, to clarify the structure of your formalisation. (However, try not to use them ''inside'' proofs. Instead use ordinary `(*  *)` comments.) This is beause proofs are less likely to be processed via coqdoc and usually they are suppressed.
 
 * Use blank lines consistently (I.e. use the same number of blank lines between all lemmas in a section)

 * End the file with a newline character.

= Layout =

== Layouts of Proofs ==

 * Start the proofs using a line containing  `Proof.`
 
 * When a tactic generates more than one subgoal indetify tactics that are used so solve each subgoal.

 * When a tactics solves a subgoal use `...` (triple dot) insetad of `.` (single dot). 

 * Use comments when using coplicated or lengthy proof segments on subgoals of `case`, `induction`, `destruct` and their freinds.

 * Use blank lines to separate different segements of the proof. 

{{{#!coq
Lemma foo:
Proof.
 <body of tactics before case>.
 case (compare_with_zero X).
  (* 0 < X *)
   <body of tactics>...
  (* X < 0  *)
   <body of tactics>... 
  (* X = 0  *)
   <body of tactics>... 
 
 <body of tactics after case>.
Qed.
}}}

= Naming =

== lemmas and datatypes ==

== variables inside proofs ==
