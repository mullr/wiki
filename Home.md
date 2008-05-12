[[http://coq.inria.fr/|Coq]] is proof assistant based on the calculus of constructions.  It is used to formalize proofs in a variety of fields, including mathematics and programming languages.  Cocorico is a Coq wiki.

== High-Level Advice and Guidance ==

 * How do I do [[Mutual Induction|mutual induction]]?

 * How should I [[Organizing Large Proofs | organize large inductive proofs]]?

 * How do I do [[Induction over a type containing pairs|induction over a type containing pairs]]?

 * Where else can I [[Other Coq Resources|learn about Coq]]?

 * Where can I read research papers about [[TheoryBehindCoq|Coq's theoretical foundations]]?

 * How can use the [[ModuleSystem|module system]] effectively?

 * What [[Tools|tools and tactic packages]] are available for Coq?

 * Where can I learn about proofs for languages with [[BindingRepresentation|variable binding]]?

== Community ==

 * Who is using [[List of Coq PL Projects|Coq in their programming languages research]]?

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

== Proof-General and CoqIDE Tips ==

 * How do I change the [[Proof General Error Color]]?

 * I'm using Proof General.  [[Proof General Missing Proof State|Where did my proof state go]]?

 * [[CoqIDE_crashes_under_KDE|CoqIDE crashes in KDE. Help!]]

== Meta ==

 * Where is the [[OldFront|old front page]]?

 * Where can I learn [[AboutCocorico!|about this wiki]]?
