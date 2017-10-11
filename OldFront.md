Cocorico Main Page (V2)
=======================

High-Level Advice and Guidance
------------------------------

* Beginners `Video Tutorials`_ by Andrej Bauer

* How do I do `mutual induction`_?

* How should I `organize large inductive proofs`_?

* How do I do `induction over a type containing pairs`_?

* Where else can I `learn about Coq`_?

* Where can I read research papers about `Coq's theoretical foundations`_?

* How can use the `module system`_ effectively?

* What `tools and tactic packages`_ are available for Coq?

* Where can I learn about proofs for languages with `variable binding`_?

* How can I get better Performance_ out of Coq?

* What hints can you give me about Extraction_ of OCaml/Haskell/Scheme code?

* How can I do `induction with self defined cases`_ ?

* How do TypeClasses_ work?

* How do ImplicitArguments_ work?

* How can I input unicode characters for Coq independently of my editor using XCompose_ (X graphical servers only) or the `TeX input method`_ (Unix systems).

* How can I `build the CoqIDE under Mac OS X without X11`_

Community
---------

* Who is using `Coq in their programming languages research`_?

* Who is using `Coq for the formalization of mathematics`_?

* How is Coq `being taught and used to teach`_?

* HowToContributeToTheStandardLibrary_?

Language Constructs and Built-In Tactics
----------------------------------------

* What exactly does simpl_ do?

* How can I avoid `non-instantiated existential variables with eauto`_?

* How does the `pattern match`_ syntax work?

* How does `dependent inversion`_ work?

* When using ``eapply``, how can I `instantiate the question marks`_?

* How can I make Coq `always print universes`_?

* Why doesn't Coq support `extension equality`_? (Why can't I prove ``forall x, f x = g x) -> f = g``?)

* Why does Coq use inductive types and not W-Types_?

* Why can I `eliminate False`_ (a ``Prop``) when constructing a member of ``Set``?

* How does the `fix tactic`_ work?

* Why do I get "Error: Abstracting over the term ... `leads to a term which is ill-typed`_" when rewriting with equalities?

Some Useful Custom Tactics and Notation
---------------------------------------

* `Marking cases and subcases in proofs`_

* `Folding definitions in multiple places`_

* `A conditional tactical`_

* `An aggressive version of subst`_

* `Decomposing all record-like structures`_

* `Solving a goal by inversion on an unspecified hypothesis`_

* `Solve goals about list inclusion`_

* `Apply <-> forwards and backwards`_

* `Manipulate equalities in the goal`_

* `Haskell-like notation for list comprehension`_

* Automatically `cleaning your hypothesis like in linear programming`_ (contains also an example of a way to have list of hypothesis in a custom tactic)

* A `simple example`_ of a tactic written in OCaml

* `Unfold a fixpoint once`_ (in OCaml)

Formal Developments and Coq Pearls
----------------------------------

* SquareRootTwo_: A very short proof that the square root of 2 is non rational.

* UntypedLambdaTerms_: various data structures for implementing the untyped lambda calculus in Coq.

* QuickSort_: an implementation of quicksort in Coq using ``Program``.

* ExistsFromPropToSet_: Existential implies Sigma for decidable properties on ``nat``.

* HandMul_: A fun way of doing multiplication by hand

* `Monads in Coq`_

* `A short tutorial on extraction`_

* `Math Classes`_: Mathematics using TypeClasses_

* Where can I see other examples of `formalization and verification`_?

Proof-General and CoqIDE Tips
-----------------------------

* How do I change the `Proof General Error Color`_?

* I'm using Proof General.  `Where did my proof state go`_?

* How to `deal with multiple coq binaries and path settings`_

* `CoqIDE crashes in KDE. Help!`_

Meta
----

* Where is the `old front page`_?

* Where can I learn `about this wiki`_?

* How do I `edit this wiki`_?

* Where did that `old article`_ go?

Cocorico Main Page (V1)
=======================

This site is a WikiWikiWeb dedicated to the Coq_ proof assistant.

<strong class="highlight">.. raw:: html

</strong>[Table not converted]

.. ############################################################################

.. _Video Tutorials: http://www.youtube.com/view_play_list?p=DD40A96C2ED54E99

.. _mutual induction: ../Mutual Induction

.. _organize large inductive proofs: ../Organizing Large Proofs

.. _induction over a type containing pairs: ../Induction over a type containing pairs

.. _learn about Coq: ../Other Coq Resources

.. _Coq's theoretical foundations:
.. _Logical foundations: ../TheoryBehindCoq

.. _module system: ../ModuleSystem

.. _tools and tactic packages:
.. _Interfaces:
.. _Software Verification:
.. _Tactic plugins:
.. _Documentation tools: ../Tools

.. _variable binding: ../BindingRepresentation

.. _Performance: ../Performance

.. _Extraction: ../Extraction

.. _induction with self defined cases: ../InductionWithSelfDefinedCases

.. _TypeClasses: ../TypeClasses

.. _ImplicitArguments: ../ImplicitArguments

.. _XCompose: ../XComposeAndNotations

.. _TeX input method: ../TeXInputMethodForUnicodeNotations

.. _build the CoqIDE under Mac OS X without X11: ../BuildingCoqOnMac

.. _Coq in their programming languages research: ../List of Coq PL Projects

.. _Coq for the formalization of mathematics: ../List of Coq Math Projects

.. _being taught and used to teach:
.. _Coq in the classroom: ../CoqInTheClassroom

.. _HowToContributeToTheStandardLibrary: ../HowToContributeToTheStandardLibrary

.. _simpl: ../simpl (tactic)

.. _non-instantiated existential variables with eauto: http://pauillac.inria.fr/pipermail/coq-club/2007/003186.html

.. _pattern match: ../MatchAsInReturn

.. _dependent inversion: ../DependentInversion

.. _instantiate the question marks: ../ExistentialVariablesInEapply

.. _always print universes: ../PrintingUniverses

.. _extension equality: ../extensional_equality

.. _W-Types: ../WTypeInsteadOfInductiveTypes

.. _eliminate False: ../FalseEqAcc

.. _fix tactic: ../Fix (tactic)

.. _leads to a term which is ill-typed: ../AbstractingOverTheTermLeadsToATermWhichIsIllTyped

.. _Marking cases and subcases in proofs: ../Case (tactic)

.. _Folding definitions in multiple places: ../Folding tactics

.. _A conditional tactical: ../if/then/else (tactical)

.. _An aggressive version of subst: ../subst++ (tactic)

.. _Decomposing all record-like structures: ../decompose records (tactic)

.. _Solving a goal by inversion on an unspecified hypothesis: ../solve by inversion (tactic)

.. _Solve goals about list inclusion: ../InTac

.. _Apply <-> forwards and backwards: ../AppFwdRev

.. _Manipulate equalities in the goal: ../LhsRhsTactic

.. _Haskell-like notation for list comprehension: ../ListComprehensionNotation

.. _cleaning your hypothesis like in linear programming: ../LinearTactics

.. _simple example: ../evar_match

.. _Unfold a fixpoint once: ../UnfoldFixpointOnce

.. _SquareRootTwo: ../SquareRootTwo

.. _UntypedLambdaTerms: ../UntypedLambdaTerms

.. _QuickSort: http://www.lri.fr/~sozeau/research/russell/quicksort.html

.. _ExistsFromPropToSet: ../ExistsFromPropToSet

.. _HandMul: ../HandMul

.. _Monads in Coq: ../AUGER_Monad

.. _A short tutorial on extraction: ../AUGER_ExtractionTuto

.. _Math Classes: ../MathClasses

.. _formalization and verification:
.. _Formalized in Coq...: ../FormalizedAndVerified

.. _Proof General Error Color: ../Proof General Error Color

.. _Where did my proof state go: ../Proof General Missing Proof State

.. _deal with multiple coq binaries and path settings: http://agda.posterous.com/multiple-coq-configurations-with-proof-genera

.. _CoqIDE crashes in KDE. Help!: ../CoqIDE_crashes_under_KDE

.. _old front page: OldFront

.. _about this wiki:
.. _About This Wiki: ../AboutCocorico!

.. _edit this wiki: ../EditingCocorico

.. _old article: ../OtherContents

.. _Coq: http://coq.inria.fr

.. _The newbie zone: ../CoqNewbie

.. _Books and Manuals: ../Documentation

.. _Standard Library: ../StandardLibrary

.. _Coq-club on Nabble: http://www.nabble.com/Coq-f2323.html

.. _Tutorials: ../Tutorials

.. _irc channel: irc://irc.freenode.net/#coq

.. _Frequently asked questions: ../FrequentlyAskedQuestions

.. _Coq pearls: ../CoqPearls

.. _Tactic pearls: ../LtacPearls

.. _Misc. documentation: ../SpecializedDocumentation

.. _Project ideas: ../ProjectIdeas

.. _About Coq code source: ../CoqSource

.. _Coq's style: ../CoqStyle

