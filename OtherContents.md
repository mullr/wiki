List of other pages stored on this Wiki.

== Coq Pearls ==

 * QuickSort: an implementation of quicksort in Coq.
 * InductiveFiniteTypes or alternatively FixpointFiniteTypes.
 * ListOfPredecessors for binary numbers.
 * ExcludedMiddleOnNegativeFormulasFromCoqRealAxioms
 * A proof of [[LagrangesTheorem|Lagrange's Theorem]].
 * A proof that there are [[NotFinitePrimes|not finitely many primes]].
 * SquareRootTwo: A very short proof that the square root of 2 is non rational.
 * UntypedLambdaTerms: various data structures for implementing the untyped lambda calculus in Coq.
 * ExistsFromPropToSet: Existential implies Sigma for decidable properties on {{{nat}}}.
 * HandMul: A fun way of doing multiplication by hand
 * [[AUGER_Monad|Monads in Coq]]
 * [[AUGER_ExtractionTuto|A short tutorial on extraction]]
 * [[MathClasses|Math Classes]]: Mathematics using [[TypeClasses]]

== Discussion ==

 * A discussion about [[CoqStyle|Coq Style]].
 * A discussion suggesting [[ExistsConsideredHarmful|preferring Set to Prop]].
 * What is the difference between [[Require_Import_and_Require_Export|Require Import and Require Export]]?
 * Do objects living in Prop ever need to be evaluated? See [[PropsGuardingIotaReduction]].
 * A discussion about [[IntensionalEquality|intensional equality]].
 * How should I [[Organizing Large Proofs|organize large inductive proofs]]?
 * How can use the [[ModuleSystem|module system]] effectively?

== Threads to remove ==

 * [[http://www.lri.fr/~sozeau/research/russell/quicksort.html|Another QuickSort]]: an implementation of quicksort in Coq using Program and definitions from the standard library.
 * Information about [[TheSource|Coq's source code]].
 * How do [[TypeClasses]] work?
 * How can I [[BuildingCoqOnMac|build the CoqIDE under Mac OS X without X11]]
 * How can I input unicode characters for Coq independently of my editor using [[XComposeAndNotations|XCompose]] (X graphical servers only) or the [[TeXInputMethodForUnicodeNotations|TeX input method]] (Unix systems).
 * [[HowToContributeToTheStandardLibrary]]?
 * How can I avoid [[http://pauillac.inria.fr/pipermail/coq-club/2007/003186.html|non-instantiated existential variables with eauto]]?
 * What exactly does [[simpl (tactic)|simpl]] do?
 * How can I make Coq [[PrintingUniverses|always print universes]]?

== Threads to update/remove ==

 * How does the [[MatchAsInReturn|pattern match]] syntax work?
 * How does [[DependentInversion|dependent inversion]] work?
 * When using `eapply`, how can I [[ExistentialVariablesInEapply|instantiate the question marks]]?
 * Why doesn't Coq support [[extensional_equality|extension equality]]? (Why can't I prove `forall x, f x = g x) -> f = g`?)
 * Why can I [[FalseEqAcc|eliminate False]] (a `Prop`) when constructing a member of `Set`?
 * How does the [[Fix (tactic)|fix tactic]] work?
 * Why do I get "Error: Abstracting over the term ... [[AbstractingOverTheTermLeadsToATermWhichIsIllTyped|leads to a term which is ill-typed]]" when rewriting with equalities?
 * Where can I see other examples of [[FormalizedAndVerified|formalization and verification]]?
 * [[CoqIDE_crashes_under_KDE|CoqIDE crashes in KDE. Help!]]
