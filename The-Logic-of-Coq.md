## General

### What is the logic of Coq?

Coq is based on an axiom-free type theory called the Calculus of Inductive Constructions (see Coquand [1], Luo [2] and Coquand–Paulin-Mohring [3] in the [References](#references) section below). It includes higher-order functions and predicates, inductive and co-inductive datatypes and predicates, and a stratified hierarchy of sets.

### Is Coq's logic intuitionistic or classical?

Coq's logic is modular. The core logic is intuitionistic (i.e. excluded-middle `A∨¬ A` is not granted by default). It can be extended to classical logic on demand by requiring an optional module stating `A∨¬ A`.

### Can I define non-terminating programs in Coq?

All programs in Coq are terminating. Especially, loops must come with an evidence of their termination.

Non-terminating programs can be simulated by passing around a bound on how long the program is allowed to run before dying.

### How is equational reasoning working in Coq?

Coq comes with an internal notion of computation called conversion (e.g. `(x+1)+y` is internally equivalent to `(x+y)+1`; similarly applying argument `a` to a function mapping `x` to some expression `t` converts to the expression `t` where `x` is replaced by `a`). This notion of conversion (which is decidable because Coq programs are terminating) covers a certain part of equational reasoning but is limited to sequential evaluation of expressions of (not necessarily closed) programs. Besides conversion, equations have to be treated by hand or using specialised tactics.

## Axioms

### What axioms can be safely added to Coq?
There are a few typical useful axioms that are independent from the Calculus of Inductive Constructions and that can be safely added to Coq. These axioms are stated in the directory `Logic` of the standard library of Coq. The most interesting ones are:

* Excluded-middle: `∀ A:Prop, A ∨ ¬ A`
* Proof-irrelevance: `∀ A:Prop ∀ p1 p2:A, p1=p2`
* Unicity of equality proofs (or equivalently Streicher's axiom K): `∀ A ∀ x y:A ∀ p1 p2:x=y, p1=p2`
* The axiom of unique choice: `∀ x ∃! y R(x,y) → ∃ f ∀ x R(x,f(x))`
* The functional axiom of choice: `∀ x ∃ y R(x,y) → ∃ f ∀ x R(x,f(x))`
* Extensionality of predicates: `∀ P Q:A→ Prop, (∀ x, P(x) ↔ Q(x)) → P=Q`
* Extensionality of functions: `∀ f g:A→ B, (∀ x, f(x)=g(x)) → f=g`

Here is a visual summary of the relative strength of these axioms, most proofs can be found in directory `Logic` of the standard library. (Statements in boldface are the most "interesting" ones for Coq.) The justification of their validity relies on the interpretability in set theory.

![](https://raw.githubusercontent.com/mattjquinn/coq_wiki_temp/master/axioms.jpg)

### What standard axioms are inconsistent with Coq?

The axiom of unique choice together with classical logic (e.g. excluded-middle) are inconsistent in the variant of the Calculus of Inductive Constructions where `Set` is impredicative.

As a consequence, the functional form of the axiom of choice and excluded-middle, or any form of the axiom of choice together with predicate extensionality are inconsistent in the `Set`-impredicative version of the Calculus of Inductive Constructions.

The main purpose of the `Set`-predicative restriction of the Calculus of Inductive Constructions is precisely to accommodate these axioms which are quite standard in mathematical usage.

The `Set`-predicative system is commonly considered consistent by interpreting it in a standard set-theoretic boolean model, even with classical logic, axiom of choice and predicate extensionality added.

### What is Streicher's axiom _K_?
Streicher's axiom _K_ [4] is an axiom that asserts dependent elimination of reflexive equality proofs.

```coq
Axiom Streicher_K :
  forall (A:Type) (x:A) (P: x=x -> Prop),
    P (eq_refl x) -> forall p: x=x, P p.
```

Axiom _K_ is equivalent to Uniqueness of Identity Proofs [4]:

```coq
Axiom UIP : forall (A:Set) (x y:A) (p1 p2: x=y), p1 = p2.
```

Axiom _K_ is also equivalent to Uniqueness of Reflexive Identity Proofs [4]:

```coq
Axiom UIP_refl : forall (A:Set) (x:A) (p: x=x), p = eq_refl x.
```

Axiom _K_ is also equivalent to:

```coq
Axiom eq_rec_eq :
  forall (A:Set) (x:A) (P: A->Set) (p:P x) (h: x=x),
    p = eq_rect x P p x h.
```

It is also equivalent to the injectivity of dependent equality (dependent equality is itself equivalent to equality of dependent pairs):

```coq
Inductive eq_dep (U:Set) (P:U -> Set) (p:U) (x:P p) :
  forall q:U, P q -> Prop :=
    eq_dep_intro : eq_dep U P p x p x.

Axiom eq_dep_eq :
  forall (U:Set) (u:U) (P:U -> Set) (p1 p2:P u),
    eq_dep U P u p1 u p2 -> p1 = p2.
```

In the general case, axiom _K_ is an independent statement of the Calculus of Inductive Constructions. However, it is true on decidable domains (see file [Eqdep_dec.v](https://coq.inria.fr/stdlib/Coq.Logic.Eqdep_dec.html)). It is also trivially a consequence of proof-irrelevance (see [below](#what-is-proof-irrelevance)) hence of classical logic.

### What is proof-irrelevance?

A specificity of the Calculus of Inductive Constructions is to permit statements about proofs. This leads to the question of comparing two proofs of the same proposition. Identifying all proofs of the same proposition is called proof-irrelevance:

```
∀ A: Prop , ∀ p q:A, p=q
```

Proof-irrelevance (in `Prop`) can be assumed without contradiction in Coq. It expresses that only provability matters, whatever the exact form of the proof is. This is in harmony with the common purely logical interpretation of `Prop`. Contrastingly, proof-irrelevance is inconsistent in `Set` since there are types in `Set`, such as the type of booleans, that are provably more than 2 elements.

Proof-irrelevance (in `Prop`) is a consequence of classical logic (see proofs in file [Classical.v](https://coq.inria.fr/stdlib/Coq.Logic.Classical.html) and [Berardi.v](https://coq.inria.fr/stdlib/Coq.Logic.Berardi.html)). Proof-irrelevance is also a consequence of propositional extensionality (i.e. `(A <-> B) -> A=B`, see the proof in file [ClassicalFacts.v](https://coq.inria.fr/stdlib/Coq.Logic.ClassicalFacts.html)).

Proof-irrelevance directly implies Streicher's axiom _K_.

### What about functional extensionality?

Extensionality of functions is admittedly consistent with the `Set`-predicative Calculus of Inductive Constructions.

Let `A `, `B` be types. To deal with extensionality on `A->B` without relying on a general extensionality axiom, a possible approach is to define one's own extensional equality on `A->B`.

```coq
Definition ext_eq (f g: A->B) := forall x:A, f x = g x.
```

and to reason on `A->B` as a setoid (see the Chapter on Setoids in the Reference Manual).

### Is `Prop` impredicative?

Yes, the sort `Prop` of propositions is _impredicative_. Otherwise said, a statement of the form `∀A :
Prop, P (A)` can be instantiated by itself: if `∀A : Prop, P (A)` is provable, then `P (∀A : Prop, P (A))` is.

### Is `Set` impredicative?

No, the sort `Set` lying at the bottom of the hierarchy of computational types is _predicative_ in the basic
Coq system. This means that a family of types in `Set`, e.g. `∀A : Set, A → A`, is not a type in `Set` and
it cannot be applied on itself.

However, the sort `Set` was impredicative in the original versions of Coq. For backward compatibility,
or for experiments by knowledgeable users, the logic of Coq can be set impredicative for `Set` by calling
Coq with the option `-impredicative-set`.

Set has been made predicative from version 8.0 of Coq. The main reason is to interact smoothly
with a classical mathematical world where both excluded-middle and the axiom of description are valid
(see file [ClassicalDescription.v](https://coq.inria.fr/stdlib/Coq.Logic.ClassicalDescription.html) for a proof that excluded-middle and description implies the double
negation of excluded-middle in `Set` and file [Hurkens_Set.v](https://github.com/coq-contribs/paradoxes/blob/master/Hurkens_Set.v) from the user contribution Paradoxes at
http://coq.inria.fr/contribs for a proof that impredicativity of `Set` implies the simple negation of
excluded-middle in `Set`).

### Is `Type` impredicative?

No, `Type` is stratified. This is hidden for the user, but Coq internally maintains a set of constraints ensuring stratification.

If `Type` were impredicative then it would be possible to encode Girard's systems `U−` and `U` in Coq and it is known from Girard, Coquand, Hurkens and Miquel that systems `U−` and `U` are inconsistent [Girard 1972, Coquand 1991, Hurkens 1993, Miquel 2001]. This encoding can be found in file `Logic/Hurkens.v` of the Coq standard library.

For instance, when the user see `∀ X:Type, X->X : Type`, each occurrence of `Type` is implicitly bound to a different level, say `α` and `β` and the actual statement is `forall X:Type(α), X->X : Type(β)` with the constraint `α < β`.

When a statement violates a constraint, the message `Universe inconsistency` appears. Example: `fun (x:Type) (y:∀ X:Type, X -> X) => y x x`.

### I have two proofs of the same proposition. Can I prove they are equal?

In the base Coq system, the answer is generally no. However, if classical logic is set, the answer is yes for propositions in `Prop`. The answer is also yes if proof irrelevance holds (see [above](#what-is-proof-irrelevance)).

There are also "simple enough" propositions for which you can prove the equality without requiring any extra axioms. This is typically the case for propositions defined deterministically as a first-order inductive predicate on decidable sets. See for instance in [this section](Case-Studies#how-to-prove-that-two-proofs-of-n--m-on-nat-are-equal) an axiom-free proof of the uniqueness of the proofs of the proposition `le m n` (less or equal on nat).

### I have two proofs of an equality statement. Can I prove they are equal?

Yes, if equality is decidable on the domain considered (which is the case for `nat`, `bool`, etc): see Coq file [Eqdep_dec.v](https://coq.inria.fr/library/Coq.Logic.Eqdep_dec.html)). No otherwise, unless assuming Streicher's axiom _K_ (see [4]) or a more general assumption such as proof-irrelevance (see [above]((#what-is-proof-irrelevance)) or classical logic.

All of these statements can be found in file [Eqdep.v](https://coq.inria.fr/stdlib/Coq.Logic.Eqdep.html).

### Can I prove that the second components of equal dependent pairs are equal?

The answer is the same as for proofs of equality statements. It is provable if equality on the domain of the first component is decidable (look at `inj_right_pair` from file [Eqdep_dec.v](https://coq.inria.fr/stdlib/Coq.Logic.Eqdep_dec.html)), but not provable in the general case. However, it is consistent (with the Calculus of Constructions) to assume it is true. The file [Eqdep.v](https://coq.inria.fr/stdlib/Coq.Logic.Eqdep.html) actually provides an axiom (equivalent to Streicher's axiom _K_) which entails the result (look at `inj_pair2` in [Eqdep.v](https://coq.inria.fr/stdlib/Coq.Logic.Eqdep.html)).

## Impredicativity

### Why does `injection` not work on impredicative `Set`?

E.g. in this case (this occurs only in the `Set`-impredicative variant of Coq):

```coq
Inductive I : Type :=
  intro : forall k:Set, k -> I.

Lemma eq_jdef : 
  forall x y:nat, intro _ x = intro _ y -> x = y.

Proof.
  intros x y H; injection H.
```

Injectivity of constructors is restricted to predicative types. If injectivity on large inductive types were not restricted, we would be allowed to derive an inconsistency (e.g. following the lines of Burali-Forti paradox). The question remains open whether injectivity is consistent on some large inductive types not expressive enough to encode known paradoxes (such as type I above).

### What is a “large inductive definition”?
An inductive definition in `Prop` or `Set` is called large if its constructors embed sets or propositions. As an example, here is a large inductive type:

```coq
Inductive sigST (P:Set -> Set) : Type :=
  existST : forall X:Set, P X -> sigST P.
```

In the `Set` impredicative variant of Coq, large inductive definitions in `Set` have restricted elimination schemes to prevent inconsistencies. Especially, projecting the set or the proposition content of a large inductive definition is forbidden. If it were allowed, it would be possible to encode e.g. Burali-Forti paradox [5, 6].

### Is Coq’s logic conservative over Coquand’s Calculus of Constructions?

In the `Set`-impredicative version of the Calculus of Inductive Constructions (CIC), there are two ways to
interpret the Calculus of Constructions (CC) since the impredicative sort of CC can be interpreted either
as `Prop` or as `Set`. In the `Set`-predicative CIC, the impredicative sort of CC can only be interpreted as
`Prop`.

If the impredicative sort of CC is interpreted as `Set`, there is no conservativity of CIC over CC as the
discrimination of constructors of inductive types in `Set` transports to a discrimination of constructors of
inductive types encoded impredicatively. Concretely, considering the impredicative encoding of Boolean,
equality and falsity, we can prove the following CC statement DISCR in CIC which is not provable in
CC, as CC has a “term-irrelevant” model.

```coq
Definition BOOL := forall X:Set, X -> X -> X.
Definition TRUE : BOOL := fun X x1 x2 => x1.
Definition FALSE : BOOL := fun X x1 x2 => x2.
Definition EQBOOL (x1 x2:BOOL) := forall P:BOOL->Set, P x1 -> P x2.
Definition BOT := forall X:Set, X.
Definition BOOL2bool : BOOL -> bool := fun b => b bool true false.

Theorem DISCR : EQBOOL TRUE FALSE -> BOT.
  intro X.
  assert (H : BOOL2bool TRUE = BOOL2bool FALSE).
  { apply X. trivial. }
  discriminate H.
Qed.
```

If the impredicative sort of CC is interpreted as `Prop`, CIC is presumably conservative over CC. The
general idea is that no proof-relevant information can flow from `Prop` to `Set`, even though singleton
elimination can be used. Hence types in `Set` should be smashable to the unit type and `Set` and `Type`
themselves be mapped to `Prop`.

### References

[1] Thierry Coquand and Gérard Huet. The Calculus of Constructions. Information and Computation, 76(2/3), 1988.

[2] Z. Luo. An Extended Calculus of Constructions. PhD thesis, University of Edinburgh, 1990.

[3] Thierry Coquand and Christine Paulin-Mohring. Inductively defined types. In P. Martin-Löf and G. Mints, editors, Proceedings of Colog'88, volume 417 of Lecture Notes in Computer Science. Springer-Verlag, 1990.

[4] Martin Hofmann and Thomas Streicher. The groupoid interpretation of type theory. In Proceedings of the meeting Twenty-five years of constructive type theory. Oxford University Press, 1998.

[5] Jean-Yves Girard. Une extension de l'interprétation de Gödel à l'analyse, et son application à l'élimination des coupures dans l'analyse et la théorie des types. In Proceedings of the 2nd Scandinavian Logic Symposium. North-Holland, 1970.

[6] Thierry Coquand. Une Théorie des Constructions. PhD thesis, Université Paris 7, January 1985.