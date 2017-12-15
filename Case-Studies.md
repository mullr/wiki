### How to prove that two sets are different?

You need to find a property true on one set and false on the other one. As an example we show how to prove that bool and nat are discriminable. As discrimination property we take the property to have no more than two elements.

```coq
Theorem nat_bool_discr : bool <> nat.
Proof.
pose (discr :=
       fun X:Set =>
         ~ (forall a b:X, ~ (forall x:X, x <> a -> x <> b -> False))).

intro Heq; assert (H: discr bool).
intro H; apply (H true false); destruct x; auto.
rewrite Heq in H; apply H; clear H.
destruct a; destruct b as [|n]; intro H0; eauto.
destruct n; [ apply (H0 2); discriminate | eauto ].
Qed.
```

### Is there an axiom-free proof of Streicher's axiom _K_ for the equality on `nat`?

Yes, because equality is decidable on `nat`. Here is the proof:

```coq
Require Import Eqdep_dec.
Require Import Peano_dec.

Theorem K_nat :
        forall (x:nat) (P:x = x -> Prop), P (eq_refl x) -> forall p:x = x, P p.
Proof.
intros; apply K_dec_set with (p := p).
apply eq_nat_dec.
assumption.
Qed.
```

Similarly, we have:

```coq
Theorem eq_rect_eq_nat :
        forall (p:nat) (Q:nat->Type) (x:Q p) (h:p=p), x = eq_rect p Q x p h.
Proof.
intros; apply K_nat with (p := h); reflexivity.
Qed. 
```

### How to prove that two proofs of `n <= m` on `nat` are equal?

This is provable without requiring any axiom because axiom _K_ directly holds on `nat`. Here is a proof using the work [above](#is-there-an-axiom-free-proof-of-streichers-axiom-k-for-the-equality-on-nat).

```coq
Require Import Arith.

Scheme le_ind' := Induction for le Sort Prop.

Theorem le_uniqueness_proof : forall (n m : nat) (p q : n <= m), p = q.

Proof.
induction p using le_ind'; intro q.
replace (le_n n) with
        (eq_rect _ (fun n0 => n <= n0) (le_n n) _ (eq_refl n)).
2:reflexivity.
  generalize (eq_refl n).
    pattern n at 2 4 6 10, q; case q; [intro | intros m l e].
    rewrite <- eq_rect_eq_nat; trivial.
    contradiction (le_Sn_n m); rewrite <- e; assumption.
replace (le_S n m p) with
  (eq_rect _ (fun n0 => n <= n0) (le_S n m p) _ (eq_refl (S m))).
2:reflexivity.
  generalize (eq_refl (S m)).
    pattern (S m) at 1 3 4 6, q; case q; [intro Heq | intros m0 l HeqS].
    contradiction (le_Sn_n m); rewrite Heq; assumption.
    injection HeqS; intro Heq; generalize l HeqS.
      rewrite <- Heq; intros; rewrite <- eq_rect_eq_nat.
      rewrite (IHp l0); reflexivity.
Qed.
```

### How to exploit equalities on sets?

To extract information from an equality on sets, you need to find a predicate of sets satisfied by the
elements of the sets. As an example, let’s consider the following theorem:

```coq
Theorem interval_discr :
        forall m n:nat,
          {x : nat | x <= m} = {x : nat | x <= n} -> m = n.
```

We have a proof requiring the axiom of proof-irrelevance. We conjecture that proof-irrelevance can be
circumvented by introducing a primitive definition of discrimination of the proofs of `{x : nat | x <= m}`.

The proof can be found in file [interval_discr.v](https://gist.github.com/letouzey/9d99b4ffb307eaf84b91486f2375dcd0).

### I have a problem of dependent elimination on proofs, how to solve it?

```coq
Inductive Def1 : Set := c1 : Def1.

Inductive DefProp : Def1 -> Prop :=
        c2 : forall d:Def1, DefProp d.

Inductive Comb : Set :=
        c3 : forall d:Def1, DefProp d -> Comb.

Lemma eq_comb :
        forall (d1 d1':Def1) (d2:DefProp d1) (d2':DefProp d1'),
          d1 = d1' -> c3 d1 d2 = c3 d1' d2'.
```

You need to derive the dependent elimination scheme for `DefProp` by hand using `Scheme`.

```coq
Scheme DefProp_elim := Induction for DefProp Sort Prop.

Lemma eq_comb :
        forall d1 d1':Def1,
          d1 = d1' ->
          forall (d2:DefProp d1) (d2':DefProp d1'), c3 d1 d2 = c3 d1' d2'.
Proof.
intros.
destruct H.
destruct d2 using DefProp_elim.
destruct d2' using DefProp_elim.
reflexivity.
Qed.
```

### And what if I want to prove the following?

```coq
Inductive natProp : nat -> Prop :=
        | p0 : natProp 0
        | pS : forall n:nat, natProp n -> natProp (S n).

Inductive package : Set :=
        pack : forall n:nat, natProp n -> package.

Lemma eq_pack :
        forall n n':nat,
          n = n' ->
          forall (np:natProp n) (np':natProp n'), pack n np = pack n' np'.
```

You need to derive the dependent elimination scheme for `natProp` by hand using `Scheme`.

```coq
Scheme natProp_elim := Induction for natProp Sort Prop.

Definition pack_S : package -> package.
destruct 1.
apply (pack (S n)).
apply pS; assumption.
Defined.

Lemma eq_pack :
        forall n n':nat,
          n = n' ->
          forall (np:natProp n) (np':natProp n'), pack n np = pack n' np'.
Proof.
intros n n' Heq np np'.
generalize dependent n'.
induction np using natProp_elim.
induction np' using natProp_elim; intros; auto.
discriminate Heq.
induction np' using natProp_elim; intros; auto.
discriminate Heq.
change (pack_S (pack n np) = pack_S (pack n0 np')).
apply (f_equal (A:=package)).
apply IHnp.
auto.
Qed.
```
