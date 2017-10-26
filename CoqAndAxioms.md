This page lists the key axioms that one may consider using in his Coq development.

Proof irrelevance / Axiom K
===========================

Proof irrelevance asserts that two proofs of a same proposition are equal.

```coq
Axiom proof_irrelevance :
  forall (P : Prop) (p q : P), p = q.
```

Streicher's axiom K is a restricted form of proof irrelevance which only applies to proofs of propositions of the form \[x = x\]. It is stated as follows.

```coq
Axiom streicher_K : forall (A : Type) (x : A) (P : x = x -> Prop),
  P (refl_equal x) -> forall (p : x = x), P p.
```

The axiom K is needed for performing non-trivial inversions on definitions involving dependent types. Proof irrelevance is needed for proving equalities between values of types of the form `{x | P x}` (especially when P is not decidable).

Proof irrelevance is derivable from propositional extensionality.

Functional extensionality
=========================

Functional extensionality asserts that two functions that produce equal results on all arguments are equal. For dependently-typed functions, the axiom is as follows.

```coq
Axiom func_ext_dep : forall (A:Type) (B:A->Type) (f g : forall x, B x),
  (forall x, f x = g x) -> f = g.
```

In the particular case of functions with a non-dependent type, the axiom admits the following simpler form.

```coq
Lemma func_ext : forall A B (f g : A -> B),
  (forall x, f x = g x) -> f = g.
```

Extensionality results for functions of several arguments can be derived from the basic axiom.

Propositional extensionality
============================

Propositional extensionality asserts that two equivalent propositions are equal.

```coq
Axiom prop_ext : forall (P Q : Prop),
  (P <-> Q) -> P = Q.
```

Propositional extensional is convenient for performing rewriting. It is needed for using Hilbert's epsilon operator in practice and, in particular, to build quotient structures in the general case.

Propositional extensionality combined with functional extensionality entails predicate extensionality.

Excluded middle (classical logic)
=================================

The excluded middle asserts that any proposition is either true or false. The excluded middle is needed to establish some mathematical results, in particular those related to undecidable properties or formal semantics about Turing-complete languages (e.g., equivalence between big-step and small-step semantics).

```coq
Axiom classic : forall (P : Prop), P \/ ~ P.
```

The above axiom is provable form indefinite description and proof irrelevance. With propositional extensionality, the excluded middle can also be stated in the following way.

```coq
Axiom prop_degeneracy : forall (P : Prop),
   P = True \/ P = False.
```

Strong excluded middle
======================

The strong excluded middle asserts that one can build a value by dynamically testing whether a proposition is true or false. This axiom is non-constructive.

```coq
Axiom classicT : forall (P : Prop), {P} + {~ P}.
```

With this axiom, one can write `If P then x else y` for any proposition P.

This axiom is derivable from indefinite description and the excluded middle.

Axiom of choice
===============

The axiom of choice is required for proving certain mathematical results. The axiom of choice can take many different forms. The functional choice is one of the most common.

```coq
Axiom func_choice : forall A B (R:A->B->Prop),
  (forall x, exists y, R x y) ->
  (exists f, forall x, R x (f x)).
```

A useful strengthened version is the omniscient choice axiom, which involves a pre-condition and delays the need for exhibiting the proof of functionality. (Below, `{Inhab B}` asserts that B is inhabited.)

```coq
Axiom omniscient_func_choice : forall A `{Inhab B} (R : A->B->Prop),
  exists f, forall x, (exists y, R x y) -> R x (f x).
```

The axiom of functional choice is a direct consequence of the indefinite description axiom. The omniscient version moreover require classical logic to be derived.

Indefinite description / Hilbert's epsilon operator
===================================================

The indefinite description axiom asserts that from a proof of type `exists x, P x` one can construct a value of type `{x | P x}`. This axiom is non-constructive.

```coq
Axiom indefinite_description : forall (A : Type) (P : A->Prop),
   ex P -> sig P.
```

Indefinite description can be used for example to build quotient structures in the general case, or to build the fixed point of an arbitrarily-complex functional.

Equivalently, one can take as axiom Hilbert's epsilon operator which, given a predicate P, returns a value x satisfying P if there exists one, otherwise returns an arbitrary value.

```coq
Axiom epsilon : forall `{Inhab A} (P : A -> Prop), A.
Axiom epsilon_spec : forall `{Inhab A} (P : A->Prop),
  (exists x, P x) -> P (epsilon P).
```

Above `Inhab A` indicates that the type A is inhabited, but without specifying which inhabitant is considered. This notion can be defined using a type class as follows.

```coq
Class Inhab (A:Type) : Prop :=
  { inhabited : exists x:A, True }.
```

Summary
=======

All the axioms listed above can be derived from the three following axioms:

-   dependent functional extensionality,
-   propositional extensionality,
-   indefinite description.

