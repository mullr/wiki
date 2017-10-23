Cocorico Main Page (V2)
=======================

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

Formal Developments and Coq Pearls
----------------------------------

-   [SquareRootTwo](SquareRootTwo): A very short proof that the square root of 2 is non rational.
-   [UntypedLambdaTerms](UntypedLambdaTerms): various data structures for implementing the untyped lambda calculus in Coq.
-   [QuickSort](http://www.lri.fr/~sozeau/research/russell/quicksort.html): an implementation of quicksort in Coq using `Program`.
-   [ExistsFromPropToSet](ExistsFromPropToSet): Existential implies Sigma for decidable properties on `nat`.
-   [HandMul](HandMul): A fun way of doing multiplication by hand
-   [Monads in Coq](AUGER_Monad)
-   [A short tutorial on extraction](AUGER_ExtractionTuto)
-   [Math Classes](MathClasses): Mathematics using [TypeClasses](TypeClasses)
-   Where can I see other examples of [formalization and verification](FormalizedAndVerified)?

Proof-General and CoqIDE Tips
-----------------------------

-   How do I change the [Proof General Error Color](Proof%20General%20Error%20Color)?
-   I'm using Proof General. [Where did my proof state go](Proof%20General%20Missing%20Proof%20State)?
-   How to [deal with multiple coq binaries and path settings](http://agda.posterous.com/multiple-coq-configurations-with-proof-genera)
-   [CoqIDE crashes in KDE. Help!](CoqIDE_crashes_under_KDE)

Meta
----

-   Where is the [old front page](OldFront)?
-   Where can I learn [about this wiki](AboutCocorico!)?
-   How do I [edit this wiki](EditingCocorico)?
-   Where did that [old article](OtherContents) go?

Cocorico Main Page (V1)
=======================

This site is a WikiWikiWeb dedicated to the [Coq](http://coq.inria.fr) proof assistant.

|*The Coq Community* | *Documentation* | *Formalisations* | *Software* |
|---|---|---|---|
|[The newbie zone](CoqNewbie) | [Books and Manuals](Documentation)         |[Standard Library](StandardLibrary)         |[Interfaces](Tools)             |
|[Coq-club on Nabble](http://www.nabble.com/Coq-f2323.html)|[Tutorials](Tutorials)                     |[Formalized in Coq...](FormalizedAndVerified)|[Software Verification](Tools) |
|[irc channel](irc://irc.freenode.net/#coq)                |[Frequently asked questions](FrequentlyAskedQuestions) |[Coq pearls](CoqPearls)      |[Tactic plugins](Tools)             |
|[Coq in the classroom](CoqInTheClassroom)                |[Logical foundations](TheoryBehindCoq)                 |[Tactic pearls](LtacPearls)  |[Documentation tools](Tools)        |
|                                                         |[Misc. documentation](SpecializedDocumentation)        |[Project ideas](ProjectIdeas)| |
|                                                         |[About Coq code source](CoqSource)                     |[Coq's style](CoqStyle)      | |
|                                                         |[About This Wiki](AboutCocorico!)                     | | |
