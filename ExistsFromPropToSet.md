Because of Coq's constructivist foundations, an *exists* statement in the Prop domain cannot ordinarily be used to build a proof in the concrete Set domain.

However, if a predicate on a natural number is decidable, then the existence in Prop of a natural number verifying this property is equivalent to existence in Set of such a number. It's a nice exercise to try to prove it :

```coq
Theorem prop_to_set : (exists x, P x) -> {x : nat | P x}.
```

Here is a first solution, but it's surely not the smallest nor the most elegant.

```coq
Module Decida.
Require Import Wf_nat.
Require Import Le.
Require Import Lt.
Variable P : nat -> Prop.
Hypothesis P_dec : forall x, {P x} + {~ P x}.
Inductive decr : nat -> nat -> Prop :=
| decr_0 : ~ P 0 -> decr 1 0
| decr_1 : forall y, ~ P (S y) -> decr (S y) y -> decr (S (S y)) (S y).
```

The previous predicate ensures that all the natural numbers we met before don't verify the property P. Morally, the algorithm is approaching closer to the witness, and the recursion is based on that.

```coq
Lemma decr_lt : forall y z, decr y z -> z < y.
Proof.
intros y z h. inversion_clear h.
apply lt_n_Sn. apply lt_n_Sn.
Qed.

Lemma decr_Sn_n : forall z y, decr z y -> forall x, x <= y -> decr (S x) x.
Proof.
intros z y h. elim h ; clear h z y.
  intros h x h'. inversion_clear h'. apply decr_0 ; trivial.
  intros y h h1 h2 z h3. inversion_clear h3.
    apply decr_1 ; trivial.
    apply h2 ; trivial.
Qed.

Lemma decr_notP : forall z x, decr z x -> forall y, y < z -> ~ P y.
Proof.
intros z x h. induction h.
  intros y h'. inversion_clear h' ; trivial. 
    inversion H0.
  intros z h'. inversion_clear h' ; trivial.
    apply IHh ; trivial.
Qed.
Lemma minus_ind : forall (Q : nat -> Prop) y, Q y -> (forall z, Q z -> Q (pred z)) -> forall n, n <= y -> Q n.
Proof.
intros Q y. induction y ; intros h1 h2 n h3.
  inversion_clear h3. exact h1.
  inversion_clear h3. 
    exact h1.
    apply IHy ; trivial.
      rewrite pred_Sn. apply h2. exact h1.
Qed.
Lemma lt_decr : forall y, P y -> forall a, a < y -> Acc decr a.
Proof.
intros y Py a h. apply minus_ind with y.
  apply Acc_intro.
    intros z h'. elim decr_notP with z y y ; trivial.
      apply decr_lt ; trivial.
  intro z. destruct z ; intro h'.
    trivial.
    simpl. apply Acc_intro.
      intros x h''. destruct h'' ; trivial.
  apply lt_le_weak ; trivial.
Qed.
Theorem wf_decr_aux : forall y, P y -> well_founded decr.
Proof.
intros y Py.
  intro a. case (le_or_lt y a) ; intro h.
    apply Acc_intro.
      intros z h'. elim decr_notP with z a y ; trivial.
        apply le_lt_trans with a ; trivial.
          apply decr_lt ; trivial.
    apply lt_decr with y ; trivial.
Qed.
Theorem wf_decr : (exists y, P y) -> well_founded decr.
Proof.
intro h. destruct h.
  apply wf_decr_aux with x ; trivial.
Qed.
```

My algorithm is based on the predicate 'decr' and is very simple : it begins with 0, test it, and continue if 0 cannot be a witness.

```coq
Definition algo : forall x : nat, (forall y : nat, decr y x -> {z : nat | P z}) -> {z : nat | P z}.
intro x. induction x.
  intro rh. case (P_dec 0) ; intro h.
    exists 0. exact h.
    apply rh with 1.
      apply decr_0 ; trivial.
  intros rh. case (P_dec (S x)) ; intro h.
    exists (S x) ; trivial.
    apply IHx. intros y h'. apply rh with (S (S x)).
      apply decr_1 ; trivial. inversion h' ; subst ; trivial.
Qed.
```

Here is the final theorem :

```coq
Theorem prop_to_set : (exists x, P x) -> {x : nat | P x}.
Proof.
intro h.
  exact (Fix (wf_decr h) (fun _ => {z : nat | P z}) algo 0).
Qed.
End Decida.
```

> The extraction of this code gives something like a functional "while".
