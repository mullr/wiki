= Other tutorials =

== Introduction to Coq ==

 * [[http://www.youtube.com/view_play_list?p=DD40A96C2ED54E99|Beginners video tutorials]], by Andrej Bauer
 * [[http://cel.archives-ouvertes.fr/inria-00001173|Coq in a Hurry]], tutorial by Yves Bertot
 * Material from the Coq summer school [[http://moscova.inria.fr/~zappa/teaching/coq/ecole10/|Modelling and verifying algorithms in Coq: an introduction]].
 * Material from courses in French:
   * [[http://www.irisa.fr/celtique/pichardie/teaching/M2/MDV/| by David Pichardie]]
   * [[http://www.pps.jussieu.fr/~letouzey/teaching.fr.html| by Pierre Letouzey]]
   * [[http://specfun.inria.fr/mahboubi/ens.html| by Assia Mahboubi]]
   * [[http://www.pps.jussieu.fr/~miquel/enseignement/mpri/index.html| by Alexandre Miquel]]
 * Material from course [[http://specfun.inria.fr/mahboubi/cirm14.html|Semantic of Proofs and Certified Mathematics]]
 * Material from the [[http://www.cis.upenn.edu/~plclub/popl08-tutorial/code/index.html|Using Proof Assistants for Programming Language Research]] tutorial.
  See also the page [[BindingRepresentation|Technique for formalization of variable binding]].
 * [[http://coq.inria.fr/coq-itp-2015|ITP'15 tutorial on Coq]]

== Specific techniques ==

Warning: the rest of this page may contain deprecated information.

=== Tips ===

 * Induction
   * How do I do [[Mutual Induction|mutual induction]]?
   * How do I do [[Induction over a type containing pairs|induction over a type containing pairs]]?
   * How can I do [[InductionWithSelfDefinedCases|induction with self defined cases]] ?
 * [[Extraction|Tips on code extraction]]
 * [[Performance|Tips on improving performance]]
 * [[ListComprehensionNotation|Tips on notation (Haskell-style list comprehension)]]


=== Ltac tactics ===

 * [[Case (tactic)|Marking cases and subcases in proofs]]
 * [[Folding tactics|Folding definitions in multiple places]]
 * [[if/then/else (tactical)|A conditional tactical]]
 * [[subst++ (tactic)|An aggressive version of subst]]
 * [[decompose records (tactic)|Decomposing all record-like structures]]
 * [[solve by inversion (tactic)|Solving a goal by inversion on an unspecified hypothesis]]
 * [[InTac|Solve goals about list inclusion]]
 * [[AppFwdRev|Apply <-> forwards and backwards]]
 * [[LhsRhsTactic|Manipulate equalities in the goal]]
 * Automatically [[LinearTactics|cleaning your hypothesis like in linear programming]] (contains also an example of a way to have list of hypothesis in a custom tactic)


=== OCaml tactics ===

 * A [[evar_match|simple example]] of a tactic written in OCaml
 * [[UnfoldFixpointOnce|Unfold a fixpoint once]] (in OCaml)
