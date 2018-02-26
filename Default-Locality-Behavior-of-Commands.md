This page describes the scope behavior of various commands without any locality modifier.

| Command  | Modality | Effect on Require | Effect on Import | Survives Module | Survives Section |
| ------------- | --| ------------ | ------------- | ------------- | ------------- |
| Set/Unset | Local | Nothing | Nothing | No | Yes |
| Set/Unset | | Nothing | Nothing | No | Yes |
| Set/Unset | Global | Nothing | Nothing | No | Yes |

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
Standard Proposition Elimination Names
Refolding Reduction
REDUCTION-EFFECT
REDUCTIONBEHAVIOUR
Debug RAKAM
RENAME-ARGUMENTS
Debug Cbv
STRUCTURE
CANONICAL-STRUCTURE
Debug Unification
Typeclasses Unique Solutions
type classes state
type classes instances state
Automatic Coercions Import
COERCION
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
SCOPE
ARGUMENTS-SCOPE
SYNTAXCONSTANT
Asymmetric Patterns
RESERVED-TYPE
IMPLICITS
GENERALIZED-IDENT
Printing Records
Printing Record
Printing Constructor
CONSTANT
VARIABLE
INDUCTIVE
Global universe context state
Global universe name state
Global universe constraints
Bullet Behavior
Default Goal Selector
Default Proof Mode
Proof Using Clear Unused
SimplIsCbn
STRATEGY
REDUCTION
Solve Unification Constraints
Printing Unfocused
Printing Goal Tags
Printing Goal Names
Hyps Limit
Printing Dependent Evars Line
Short Module Printing
SCHEME
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
AUTOHINT
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
HINT_REWRITE
proofusing-nameset
Suggest Proof Using
Default Proof Using
Keep Admitted Variables
TOKEN
SYNTAX-EXTENSION
NOTATION
DELIMITERS
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
ML-MODULE
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
TAC-DEFINITION
Ltac Batch Debug
TacticGrammar
Ltac Profiling
Ltac Debug
Debug Ltac
Program tactic
TRANSITIVITY-STEPS
IMPLICIT-TACTIC
Info Level
Intuition Negation Unfolding
Intuition Iff Unfolding
Congruence Verbose
Firstorder Depth
Congruence Depth
Firstorder default solver
```