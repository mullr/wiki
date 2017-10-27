This is Diaconescu-style argument showing that the total ordering of `R` and the completeness axiom in Coq's axiomatization of real numbers yields classical logic for negative formulas.

Because the total ordering and the completeness axioms are asserted in a computational way (in `sumbool` and `sig` respectively), one can also show `{~~A} + {~A}` . We guess that using `fun (x : R) => x = 0 \/ exists n, x = 1 / (INR n + 1) /\ Q n` for `P` would allow to more generally decide arithmetical statements of the form `{forall n:nat, ~ Q n} + { n | Q n}` with `Q` decidable, and, by succesive iteration, any arbitrary arithmetical statement.

```coq
Require Import Raxioms.
Require Import Rbase.
Open Scope R_scope.
Section EM_neg.
Variable A : Prop.
Let P (x : R) := x = 0 \/ x = 1 /\ A.
Theorem EM_neg : ~ ~ A \/ ~ A.
Proof.
assert (Hnonempty : exists x : _, P x) by (exists 0; red in |- *; tauto).
assert (Hbound : bound P).
  exists 1. intros x [Hx_eq_0| (Hx_eq_1, _)].
  rewrite Hx_eq_0; left; apply Rlt_0_1.
  rewrite Hx_eq_1; right; reflexivity.
destruct (completeness P Hbound Hnonempty) as (y,(Hy_bound,Hy_lub)).
destruct (Rlt_le_dec y 1) as [ Hy_lt_1 | H_1_le_y ].
(* y < 1 *)
right; intro Ha.
  assert (H_1_in_P : P 1) by (red; tauto).
  assert (H_1_inf_y : 1 <= y) by (apply Hy_bound with (1 := H_1_in_P)).
  apply Rlt_not_le with (1 := Hy_lt_1).
  apply H_1_inf_y.
(* y >= 1 *)
left; intro Hna.
assert (~ (forall z : R, 0 < z -> ~ P z)).
  intro H.
  assert (H_0_lub : is_upper_bound P 0).
    intros r Hr_in_P.
    destruct (Rlt_le_dec 0 r) as [ H_0_lt_r | H_r_le_0 ].
      elim (H r H_0_lt_r Hr_in_P).
      assumption.
  assert (Hy_le_0 : y <= 0) by (apply Hy_lub; assumption).
  apply Rlt_irrefl with y.
  apply Rle_lt_trans with 0.
    exact Hy_le_0.
  apply Rlt_le_trans with 1.
  apply Rlt_0_1.
  exact H_1_le_y.
apply H; intros z Hz_lt_0 [Hz_eq_0| (Hz_eq_1, Ha)].
  (* z = 0, mais 0 < z *)
  rewrite Hz_eq_0 in Hz_lt_0.
  apply Rlt_irrefl with (1 := Hz_lt_0).
  (* z = 1 et A, mais ~A *)
  apply (Hna Ha).
Qed.
End EM_neg.
```

The excluded-middle proof has been formalized by Hugo Herbelin from an idea of Benjamin Werner. The obvious generalization to computational excluded-middle and the presumably provable extension to arbitrary artithmetical statement has been inspired by similar works from Russell O'Connor and Cezary Kaliszyk.
