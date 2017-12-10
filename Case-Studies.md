### How to prove that two sets are different?

You need to find a property true on one set and false on the other one. As an example we show how to prove that bool and nat are discriminable. As discrimination property we take the property to have no more than two elements.

```coq
Coq < Theorem nat_bool_discr : bool <> nat.

Coq < Proof.

Coq < pose (discr :=
       fun X:Set =>
         ~ (forall a b:X, ~ (forall x:X, x <> a -> x <> b -> False))).

Coq < intro Heq; assert (H: discr bool).
Coq < intro H; apply (H true false); destruct x; auto.
Coq < rewrite Heq in H; apply H; clear H.
Coq < destruct a; destruct b as [|n]; intro H0; eauto.
Coq < destruct n; [ apply (H0 2); discriminate | eauto ].
Coq < Qed.
```

### Is there an axiom-free proof of Streicher's axiom _K_ for the equality on `nat`?

Yes, because equality is decidable on `nat`. Here is the proof:

```coq
Coq < Require Import Eqdep_dec.
Coq < Require Import Peano_dec.

Coq < Theorem K_nat :
        forall (x:nat) (P:x = x -> Prop), P (refl_equal x) -> forall p:x = x, P p.

Coq < Proof.
Coq < intros; apply K_dec_set with (p := p).
Coq < apply eq_nat_dec.
Coq < assumption.
Coq < Qed.
```

Similarly, we have:

```coq
Coq < Theorem eq_rect_eq_nat :
        forall (p:nat) (Q:nat->Type) (x:Q p) (h:p=p), x = eq_rect p Q x p h.

Coq < Proof.
Coq < intros; apply K_nat with (p := h); reflexivity.
Coq < Qed. 
```

### How to prove that two proofs of `n <= m` on `nat` are equal?

This is provable without requiring any axiom because axiom _K_ directly holds on `nat`. Here is a proof using the work [above](#is-there-an-axiom-free-proof-of-streichers-axiom-k-for-the-equality-on-nat).

```coq
Coq < Require Import Arith.

Coq < Scheme le_ind' := Induction for le Sort Prop.

Coq < Theorem le_uniqueness_proof : forall (n m : nat) (p q : n <= m), p = q.

Coq < Proof.
Coq < induction p using le_ind'; intro q.
Coq < replace (le_n n) with
        (eq_rect _ (fun n0 => n <= n0) (le_n n) _ (refl_equal n)).
Coq < 2:reflexivity.
Coq <   generalize (refl_equal n).
Coq <     pattern n at 2 4 6 10, q; case q; [intro | intros m l e].
Coq <     rewrite <- eq_rect_eq_nat; trivial.
Coq <     contradiction (le_Sn_n m); rewrite <- e; assumption.
Coq < replace (le_S n m p) with
Coq <   (eq_rect _ (fun n0 => n <= n0) (le_S n m p) _ (refl_equal (S m))).
Coq < 2:reflexivity.
Coq <   generalize (refl_equal (S m)).
Coq <     pattern (S m) at 1 3 4 6, q; case q; [intro Heq | intros m0 l HeqS].
Coq <     contradiction (le_Sn_n m); rewrite Heq; assumption.
Coq <     injection HeqS; intro Heq; generalize l HeqS.
Coq <       rewrite <- Heq; intros; rewrite <- eq_rect_eq_nat.
Coq <       rewrite (IHp l0); reflexivity.
Coq < Qed.

### How to exploit equalities on sets?

To extract information from an equality on sets, you need to find a predicate of sets satisfied by the
elements of the sets. As an example, let’s consider the following theorem:

```coq
Coq < Theorem interval_discr :
        forall m n:nat,
          {x : nat | x <= m} = {x : nat | x <= n} -> m = n.
```

We have a proof requiring the axiom of proof-irrelevance. We conjecture that proof-irrelevance can be
circumvented by introducing a primitive definition of discrimination of the proofs of `{x : nat | x <= m}`.

The proof can be found in file [interval_discr.v](https://github.com/coq/www/blob/master/files/interval_discr.v).

### I have a problem of dependent elimination on proofs, how to solve it?

```coq
Coq < Inductive Def1 : Set := c1 : Def1.

Coq < Inductive DefProp : Def1 -> Prop :=
        c2 : forall d:Def1, DefProp d.

Coq < Inductive Comb : Set :=
        c3 : forall d:Def1, DefProp d -> Comb.

Coq < Lemma eq_comb :
        forall (d1 d1':Def1) (d2:DefProp d1) (d2':DefProp d1'),
          d1 = d1' -> c3 d1 d2 = c3 d1' d2'.
```

You need to derive the dependent elimination scheme for `DefProp` by hand using `Scheme`.

```coq
Coq < Scheme DefProp_elim := Induction for DefProp Sort Prop.

Coq < Lemma eq_comb :
        forall d1 d1':Def1,
          d1 = d1' ->
          forall (d2:DefProp d1) (d2':DefProp d1'), c3 d1 d2 = c3 d1' d2'.

Coq < intros.
Coq < destruct H.
Coq < destruct d2 using DefProp_elim.
Coq < destruct d2' using DefProp_elim.
Coq < reflexivity.
Coq < Qed.
```

### And what if I want to prove the following?

```coq
Coq < Inductive natProp : nat -> Prop :=
        | p0 : natProp 0
        | pS : forall n:nat, natProp n -> natProp (S n).

Coq < Inductive package : Set :=
        pack : forall n:nat, natProp n -> package.

Coq < Lemma eq_pack :
        forall n n':nat,
          n = n' ->
          forall (np:natProp n) (np':natProp n'), pack n np = pack n' np'.

Coq < Scheme natProp_elim := Induction for natProp Sort Prop.

Coq < Definition pack_S : package -> package.
Coq < destruct 1.
Coq < apply (pack (S n)).
Coq < apply pS; assumption.
Coq < Defined.

Coq < Lemma eq_pack :
        forall n n':nat,
          n = n' ->
          forall (np:natProp n) (np':natProp n'), pack n np = pack n' np'.

Coq < intros n n' Heq np np'.
Coq < generalize dependent n'.
Coq < induction np using natProp_elim.
Coq < induction np' using natProp_elim; intros; auto.
Coq < discriminate Heq.
Coq < induction np' using natProp_elim; intros; auto.
Coq < discriminate Heq.
Coq < change (pack_S (pack n np) = pack_S (pack n0 np')).
Coq < apply (f_equal (A:=package)).
Coq < apply IHnp.
Coq < auto.
Coq < Qed.
```