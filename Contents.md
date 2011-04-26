#acl Known:read,write,revert All:read
== High-Level Advice and Guidance ==
 * How do I do [[Mutual Induction|mutual induction]]?

 * How should I [[Organizing Large Proofs|organize large inductive proofs]]?

 * How do I do [[Induction over a type containing pairs|induction over a type containing pairs]]?

 * Where else can I [[Other Coq Resources|learn about Coq]]?

 * Where can I read research papers about [[TheoryBehindCoq|Coq's theoretical foundations]]?

 * How can use the [[ModuleSystem|module system]] effectively?

 * What [[Tools|tools and tactic packages]] are available for Coq?

 * Where can I learn about proofs for languages with [[BindingRepresentation|variable binding]]?

 * How can I get better [[Performance]] out of Coq?

 * What hints can you give me about [[Extraction]] of OCaml/Haskell/Scheme code?

 * How can I do [[InductionWithSelfDefinedCases|induction with self defined cases]] ?

 * How do [[TypeClasses]] work?

 * How do [[ImplicitArguments]] work?

 * How can I input unicode characters for Coq independently of my editor using [[XComposeAndNotations|XCompose]] (X graphical servers only) or the [[TeXInputMethodForUnicodeNotations|TeX input method]] (Unix systems).

== Community ==
 * Who is using [[List of Coq PL Projects|Coq in their programming languages research]]?

 * Who is using [[List of Coq Math Projects|Coq for the formalization of mathematics]]?

 * How is Coq [[CoqInTheClassroom|being taught and used to teach]]?

== Language Constructs and Built-In Tactics ==
 * What exactly does [[simpl (tactic)|simpl]] do?

 * How can I avoid [[http://pauillac.inria.fr/pipermail/coq-club/2007/003186.html|non-instantiated existential variables with eauto]]?

 * How does the [[MatchAsInReturn|pattern match]] syntax work?

 * How does [[DependentInversion|dependent inversion]] work?

 * When using `eapply`, how can I [[ExistentialVariablesInEapply|instantiate the question marks]]?

 * How can I make Coq [[PrintingUniverses|always print universes]]?

 * Why doesn't Coq support [[extensional_equality|extension equality]]? (Why can't I prove `forall x, f x = g x) -> f = g`?)

 * Why does Coq use inductive types and not [[WTypeInsteadOfInductiveTypes|W-Types]]?

 * Why can I [[FalseEqAcc|eliminate False]] (a `Prop`) when constructing a member of `Set`?

 * How does the [[Fix (tactic)|fix tactic]] work?

 * Why do I get "Error: Abstracting over the term ... [[AbstractingOverTheTermLeadsToATermWhichIsIllTyped|leads to a term which is ill-typed]]" when rewriting with equalities?

== Some Useful Custom Tactics and Notation ==
 * [[Case (tactic)|Marking cases and subcases in proofs]]

 * [[Folding tactics|Folding definitions in multiple places]]

 * [[if/then/else (tactical)|A conditional tactical]]

 * [[subst++ (tactic)|An aggressive version of subst]]

 * [[decompose records (tactic)|Decomposing all record-like structures]]

 * [[solve by inversion (tactic)|Solving a goal by inversion on an unspecified hypothesis]]

 * [[InTac|Solve goals about list inclusion]]

 * [[AppFwdRev|Apply <-> forwards and backwards]]

 * [[LhsRhsTactic|Manipulate equalities in the goal]]

 * [[ListComprehensionNotation|Haskell-like notation for list comprehension]]

 * Automatically [[LinearTactics|cleaning your hypothesis like in linear programming]] (contains also an example of a way to have list of hypothesis in a custom tactic)

== Formal Developments and Coq Pearls ==
 * SquareRootTwo: A very short proof that the square root of 2 is non rational.

 * UntypedLambdaTerms: various data structures for implementing the untyped lambda calculus in Coq.

 * [[http://www.lri.fr/~sozeau/research/russell/quicksort.html|QuickSort]]: an implementation of quicksort in Coq using `Program`.

 * ExistsFromPropToSet: Existential implies Sigma for decidable properties on {{{nat}}}.

 * HandMul: A fun way of doing multiplication by hand

 * [[AUGER_Monad|Monads in Coq]]

 * Where can I see other examples of [[FormalizedAndVerified|formalization and verification]]?

== Proof-General and CoqIDE Tips ==
 * How do I change the [[Proof General Error Color]]?

 * I'm using Proof General.  [[Proof General Missing Proof State|Where did my proof state go]]?

 * [[CoqIDE_crashes_under_KDE|CoqIDE crashes in KDE. Help!]]

== Meta ==
 * Where is the [[OldFront|old front page]]?

 * Where can I learn [[AboutCocorico!|about this wiki]]?

 * How do I [[EditingCocorico|edit this wiki]]?

 * Where did that [[OtherContents|old article]] go?
