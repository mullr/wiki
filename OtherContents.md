List of other pages stored on this Wiki.

Coq Pearls
----------

-   [QuickSort](QuickSort): an implementation of quicksort in Coq.
-   [InductiveFiniteTypes](InductiveFiniteTypes) or alternatively [FixpointFiniteTypes](FixpointFiniteTypes).
-   [An other version of InductiveFiniteTypes](AUGER_Enumerates) not using nat.
-   [ListOfPredecessors](ListOfPredecessors) for binary numbers.
-   [ExcludedMiddleOnNegativeFormulasFromCoqRealAxioms](ExcludedMiddleOnNegativeFormulasFromCoqRealAxioms)
-   A proof of [Lagrange's Theorem](LagrangesTheorem).
-   [SquareRootTwo](SquareRootTwo): A very short proof that the square root of 2 is non rational.
-   [UntypedLambdaTerms](UntypedLambdaTerms): various data structures for implementing the untyped lambda calculus in Coq.
-   [ExistsFromPropToSet](ExistsFromPropToSet): Existential implies Sigma for decidable properties on `nat`.
-   [HandMul](HandMul): A fun way of doing multiplication by hand
-   [Monads in Coq](AUGER_Monad)
-   [A short tutorial on extraction](AUGER_ExtractionTuto)
-   [Math Classes](MathClasses): Mathematics using Type Classes
- [Tactic pearls](LtacPearls)

Proof-General tips
-----------------------------

-   How do I change the [Proof General Error Color](Proof%20General%20Error%20Color)?
-   I'm using Proof General. [Where did my proof state go](Proof%20General%20Missing%20Proof%20State)?
-   How to [deal with multiple coq binaries and path settings](http://agda.posterous.com/multiple-coq-configurations-with-proof-genera)

Discussion
----------

-   A discussion about [Coq Style](CoqStyle).
-   A discussion suggesting [preferring Set to Prop](ExistsConsideredHarmful).
-   What is the difference between [Require Import and Require Export](Require_Import_and_Require_Export)?
-   Do objects living in Prop ever need to be evaluated? See [PropsGuardingIotaReduction](PropsGuardingIotaReduction).
-   A discussion about [intensional equality](IntensionalEquality).
-   How can use the [module system](ModuleSystem) effectively?

Threads to remove
-----------------

-   [Another QuickSort](http://www.lri.fr/~sozeau/research/russell/quicksort.html): an implementation of quicksort in Coq using Program and definitions from the standard library.
-   How can I [build the CoqIDE under Mac OS X without X11](BuildingCoqOnMac)
-   How can I input unicode characters for Coq independently of my editor using [XCompose](XComposeAndNotations) (X graphical servers only) or the [TeX input method](TeXInputMethodForUnicodeNotations) (Unix systems).
-   [HowToContributeToTheStandardLibrary](HowToContributeToTheStandardLibrary)?
-   How can I avoid [non-instantiated existential variables with eauto](http://pauillac.inria.fr/pipermail/coq-club/2007/003186.html)?

Threads to update/remove
------------------------

-   [Resources for Coq Newbies](CoqNewbie)
-   How does the [pattern match](MatchAsInReturn) syntax work?
-   How does [dependent inversion](DependentInversion) work?
-   When using `eapply`, how can I [instantiate the question marks](ExistentialVariablesInEapply)?
-   Why doesn't Coq support [extension equality](extensional_equality)? (Why can't I prove `forall x, f x = g x) -> f = g`?)
-   Where can I see other examples of [formalization and verification](FormalizedAndVerified)?
- [Project ideas](ProjectIdeas)

High-Level Advice and Guidance
------------------------------

-   Beginners [Video Tutorials](http://www.youtube.com/view_play_list?p=DD40A96C2ED54E99) by Andrej Bauer
-   How do I do [mutual induction](Mutual%20Induction)?
-   How should I [organize large inductive proofs](Organizing%20Large%20Proofs)?
-   How do I do [induction over a type containing pairs](Induction%20over%20a%20type%20containing%20pairs)?
-   Where else can I [learn about Coq](Other%20Coq%20Resources)?
-   Where can I read research papers about [Coq's theoretical foundations](TheoryBehindCoq)?
-   How can use the [module system](ModuleSystem) effectively?
-   What [tools and tactic packages](Interfaces:) are available for Coq?
-   Where can I learn about proofs for languages with [variable binding](BindingRepresentation)?
-   How can I get better [Performance](Performance) out of Coq?
-   What hints can you give me about [Extraction](Extraction) of OCaml/Haskell/Scheme code?
-   How can I do [induction with self defined cases](InductionWithSelfDefinedCases) ?
-   How do [TypeClasses](TypeClasses) work?
-   How do [ImplicitArguments](ImplicitArguments) work?
-   How can I input unicode characters for Coq independently of my editor using [XCompose](XComposeAndNotations) (X graphical servers only) or the [TeX input method](TeXInputMethodForUnicodeNotations) (Unix systems).
-   How can I [build the CoqIDE under Mac OS X without X11](BuildingCoqOnMac)

Community
---------

-   Who is using [Coq in their programming languages research](List%20of%20Coq%20PL%20Projects)?
-   Who is using [Coq for the formalization of mathematics](List%20of%20Coq%20Math%20Projects)?
-   How is Coq [being taught and used to teach](CoqInTheClassroom)?
-   [HowToContributeToTheStandardLibrary](HowToContributeToTheStandardLibrary)?

Language Constructs and Built-In Tactics
----------------------------------------

-   What exactly does [simpl](simpl%20(tactic)) do?
-   How can I avoid [non-instantiated existential variables with eauto](http://pauillac.inria.fr/pipermail/coq-club/2007/003186.html)?
-   How does the [pattern match](MatchAsInReturn) syntax work?
-   How does [dependent inversion](DependentInversion) work?
-   When using `eapply`, how can I [instantiate the question marks](ExistentialVariablesInEapply)?
-   How can I make Coq [always print universes](PrintingUniverses)?
-   Why doesn't Coq support [extension equality](extensional_equality)? (Why can't I prove `forall x, f x = g x) -> f = g`?)
-   Why does Coq use inductive types and not [W-Types](WTypeInsteadOfInductiveTypes)?
-   Why can I [eliminate False](FalseEqAcc) (a `Prop`) when constructing a member of `Set`?
-   How does the [fix tactic](Fix%20(tactic)) work?
-   Why do I get "Error: Abstracting over the term ... [leads to a term which is ill-typed](AbstractingOverTheTermLeadsToATermWhichIsIllTyped)" when rewriting with equalities?

Some Useful Custom Tactics and Notation
---------------------------------------

-   [Marking cases and subcases in proofs](Case%20(tactic))
-   [Folding definitions in multiple places](Folding%20tactics)
-   [A conditional tactical](if/then/else%20(tactical))
-   [An aggressive version of subst](subst++%20(tactic))
-   [Decomposing all record-like structures](decompose%20records%20(tactic))
-   [Solving a goal by inversion on an unspecified hypothesis](solve%20by%20inversion%20(tactic))
-   [Solve goals about list inclusion](InTac)
-   [Apply &lt;-&gt; forwards and backwards](AppFwdRev)
-   [Manipulate equalities in the goal](LhsRhsTactic)
-   [Haskell-like notation for list comprehension](ListComprehensionNotation)
-   Automatically [cleaning your hypothesis like in linear programming](LinearTactics) (contains also an example of a way to have list of hypothesis in a custom tactic)
-   A [simple example](evar_match) of a tactic written in OCaml
-   [Unfold a fixpoint once](UnfoldFixpointOnce) (in OCaml)
