This page describes the scope behavior of various commands without any locality modifier. Click on the command to go to the source code defining its behavior.

| Command  | Effect on Require | Effect on Import | Survives Module | Survives Section |
| ------------- | ------------ | ------------- | ------------- | ------------- |
| [Set/Unset](https://github.com/coq/coq/blob/e3124e098ef8170dac2b348b91757a7034bc4999/library/goptions.ml#L91) | Nothing | Nothing | No | Yes |
| [MODULE](https://github.com/coq/coq/blob/e3124e098ef8170dac2b348b91757a7034bc4999/library/declaremods.ml#L211) | | | | |
| [MODULE KEEP](https://github.com/coq/coq/blob/e3124e098ef8170dac2b348b91757a7034bc4999/library/declaremods.ml#L242) | | | | |
| [MODULE TYPE](https://github.com/coq/coq/blob/e3124e098ef8170dac2b348b91757a7034bc4999/library/declaremods.ml#L276) | | | | |
| [INCLUDE](https://github.com/coq/coq/blob/e3124e098ef8170dac2b348b91757a7034bc4999/library/declaremods.ml#L302) | | | | |
| [IMPORT MODULE](https://github.com/coq/coq/blob/e3124e098ef8170dac2b348b91757a7034bc4999/library/declaremods.ml#L947) | | | | |
| [IMPORT LIBRARY](https://github.com/coq/coq/blob/e3124e098ef8170dac2b348b91757a7034bc4999/library/library.ml#L259) | | | | |
| [REQUIRE](https://github.com/coq/coq/blob/e3124e098ef8170dac2b348b91757a7034bc4999/library/library.ml#L543) | | | | |
| HEAD | | | | |
| KEYS | | | | |
| universe binder | | | | |
| REDUCTION-EFFECT | | | | |
| REDUCTIONBEHAVIOUR | | | | |
| RENAME-ARGUMENTS | | | | |
| STRUCTURE | | | | |
| CANONICAL-STRUCTURE | Nothing | Applies | Yes | Yes |
| COERCION | Nothing | Register | Yes | Yes |
| SCOPE | Nothing | Register | Yes | No (flagged Local) |
| ARGUMENTS-SCOPE | | | | |
| SYNTAXCONSTANT | | | | |
| RESERVED-TYPE | | | | |
| IMPLICITS | | | | |
| GENERALIZED-IDENT | | | | |
| CONSTANT | | | | |
| VARIABLE | | | | |
| INDUCTIVE | | | | |
| STRATEGY | | | | |
| REDUCTION | | | | |
| SCHEME | | | | |
| AUTOHINT | | | | |
| HINT_REWRITE | | | | |
| TOKEN | | | | |
| SYNTAX-EXTENSION | | | | |
| NOTATION | Register scopes | Add notation | Yes | Yes |
| DELIMITERS | | | | |
| ML-MODULE | Applies | Nothing | Yes | |
| TAC-DEFINITION | Registers | Shorten name | Yes | Yes |
| TRANSITIVITY-STEPS | | | | |
| IMPLICIT-TACTIC | | | | |

This is the list of all objects with lifetime when the prelude is loaded:
```
MODULE
MODULE KEEP
MODULE TYPE
INCLUDE
IMPORT MODULE
IMPORT LIBRARY
REQUIRE
HEAD
KEYS
universe binder
REDUCTION-EFFECT
REDUCTIONBEHAVIOUR
RENAME-ARGUMENTS
STRUCTURE
CANONICAL-STRUCTURE
COERCION
SCOPE
ARGUMENTS-SCOPE
SYNTAXCONSTANT
RESERVED-TYPE
IMPLICITS
GENERALIZED-IDENT
CONSTANT
VARIABLE
INDUCTIVE
STRATEGY
REDUCTION
SCHEME
AUTOHINT
HINT_REWRITE
TOKEN
SYNTAX-EXTENSION
NOTATION
DELIMITERS
ML-MODULE
TAC-DEFINITION
TRANSITIVITY-STEPS
IMPLICIT-TACTIC
```

Options are uniform but they get their own entry too so they can be handled individually:

```
Asymmetric Patterns
Debug Unification
Typeclasses Unique Solutions
type classes state
type classes instances state
Automatic Coercions Import
Printing Records
Printing Record
Printing Constructor
Global universe context state
Global universe name state
Global universe constraints
Bullet Behavior
Default Goal Selector
Default Proof Mode
Proof Using Clear Unused
SimplIsCbn
Solve Unification Constraints
Printing Unfocused
Printing Goal Tags
Printing Goal Names
Hyps Limit
Printing Dependent Evars Line
Short Module Printing
Typeclass Resolution After Apply
Default Clearing Used Hypotheses
Universal Lemma Under Conjunction
Shrink Abstract
Bracketing Last Introduction Pattern
Discriminate Introduction
Injection L2R Pattern Order
Structural Injection
Keep Proof Equalities
Regular Subst Tactic
Loose Hint Behavior
Global universe context
Debug Trivial
Debug Auto
Info Trivial
Info Auto
Debug Eauto
Info Eauto
Typeclasses Modulo Eta
Typeclasses Limit Intros
Typeclasses Dependency Order
Typeclasses Iterative Deepening
Typeclasses Legacy Resolution
Typeclasses Filtered Unification
Typeclasses Debug
Debug Typeclasses
Typeclasses Debug Verbosity
Typeclasses Depth
proofusing-nameset
Suggest Proof Using
Default Proof Using
Keep Admitted Variables
Search Blacklist
Elimination Schemes
Nonrecursive Elimination Schemes
Record Elimination Schemes
Case Analysis Schemes
Boolean Equality Schemes
Decidable Equality Schemes
Rewriting Schemes
Hide Obligations
Shrink Obligations
Program state
Typeclasses Axioms Are Instances
Refine Instance Mode
Primitive Projections
Typeclasses Strict Resolution
Typeclasses Unique Instances
Printing Coercion
Transparent Obligations
Program Cases
Program Generalized Coercion
Typeclass Resolution For Conversion
Printing If
Printing Let
Printing Wildcard
Printing Synth
Printing Matching
Printing Primitive Projection Parameters
Printing Primitive Projection Compatibility
Printing Factorizable Match Patterns
Printing Allow Match Default Clause
Strict Universe Declaration
Universe Minimization ToSet
Keyed Unification
Debug Tactic Unification
Tactic Pattern Unification
Silent
Implicit Arguments
Strict Implicit
Strongly Strict Implicit
Contextual Implicit
Reversible Pattern Implicit
Maximal Implicit Insertion
Automatic Introduction
Printing Coercions
Printing Existential Instances
Printing Implicit
Printing Implicit Defensive
Printing Projections
Printing Notations
Printing All
Program Mode
Universe Polymorphism
Polymorphic Inductive Cumulativity
Inline Level
Kernel Term Sharing
Printing Compact Contexts
Printing Depth
Printing Width
Printing Universes
Dump Bytecode
Dump Lambda
Parsing Explicit
Warnings
NativeCompute Profile Filename
NativeCompute Profiling
Search Output Name Only
Default Timeout
Ltac Batch Debug
TacticGrammar
Ltac Profiling
Ltac Debug
Debug Ltac
Program tactic
Info Level
Intuition Negation Unfolding
Intuition Iff Unfolding
Congruence Verbose
Firstorder Depth
Congruence Depth
Firstorder default solver
Standard Proposition Elimination Names
Refolding Reduction
Debug RAKAM
Debug Cbv
```
