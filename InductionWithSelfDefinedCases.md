[This](http://permalink.gmane.org/gmane.science.mathematics.logic.coq.club/5170) Coq-club thread discusses how to do induction using self defined cases. For example, `induction x` with `x : Z` leads to three cases : x = 0, x &lt; 0, x &gt; 0. One can improve on this by proving one's own induction principle. (In this example, the use of the tactic lia is convenient.) The main idea is to prove a lemma, with one premises for each desired case.

```coq
Require Import ZArith.
Require Import Psatz.
Section zind.
  Variable P : Z -> Prop.
  (* Here, we want to split the induction into 4 cases : z < 0, 0 <=z<= 10, z = 11, 11 < z, so  *)
  Hypothesis Hneg : forall z, Zlt z 0 -> P z.
  Hypothesis H_0_to_10 : forall (z : Z), Zle 0 z -> Zle z 10 -> P z.
  Hypothesis H_11 : P 11.
  Hypothesis H_gt_11 : forall z, Zlt 11 z -> P z.
  (* here, we provide an helper lemma to split cases *)
  Lemma case_split : forall (z : Z), Zle 0 z -> (Zle z 10 \/ z = 11%Z \/ Zlt 11 z).
    intros. lia.
  Qed.
  (* This lemma is required to solve some cases for Lia *)
  Lemma lia_helper :forall p,  (0 <= Zpos p)%Z.
  Proof.
    intros. unfold Zle; discriminate.
  Qed.
  Hint Immediate lia_helper.
  (* The main lemma *)
  Lemma Zind : forall z, P z.
  Proof.
    induction z. apply H_0_to_10; lia.
    destruct (case_split _ (lia_helper p)) as [H |[H |H]].
    apply H_0_to_10; try lia; auto.
    rewrite H. assumption.
    apply H_gt_11. auto.
    apply Hneg. unfold Zlt. simpl. auto.
  Qed.
End zind.
Check Zind.
```

One can now use the new induction principles in proofs.

```coq
induction z using Zind.
```
