This development requires that the K_dec_set theory be [[Eqdep_dec_Type|extended to work on predicates going to Type]].

{{{#!coq
Require Import Image.
Require Import List.
Require Import Eqdep_dec_Type.
Require Import Peano_dec.

Set Implicit Arguments.

Inductive Fin : nat -> Set :=
| FinOld : forall n, Fin n -> Fin (S n)
| FinNew : forall n, Fin (S n).

Derive Inversion FinO_rect with (Fin 0) Sort Type.

Lemma FinSn_rect :
 forall n,
 forall (P:Fin (S n)->Type),
 (forall y:Fin n, P (FinOld y)) ->
 P (FinNew n) ->
 forall x, P x.
Proof.
intros n P H0 H1 x.
change x with (eq_rect (S n) Fin x (S n) (refl_equal (S n))).
generalize (refl_equal (S n)).
set (t:= (S n)) in *.
unfold t at 2 4.
dependent inversion x;
unfold t in *.
subst n0.
intros.
pattern e.
apply K_dec_set_Type.
apply eq_nat_dec.
simpl.
auto.
rewrite H2.
clear x t n0 H2.
intro.
pattern e.
apply K_dec_set_Type.
apply eq_nat_dec.
simpl.
auto.
Defined.

Lemma FinOldOrNew : forall n, 
forall y:Fin (S n), 
{z:Fin n | y=(FinOld z)}+{y=FinNew n}.
Proof.
intros n.
destruct y using FinSn_rect; auto.
left.
exists y; auto.
Defined.

Lemma FinOldInject : forall n, forall x y:Fin n, (FinOld x)=(FinOld y) -> x=y.
Proof.
intros n x y H.
inversion H.
apply inj_right_pair2 with (P:=(fun n : nat => Fin n)); auto.
apply eq_nat_dec.
Qed.

Hint Resolve FinOldInject : fin.

Lemma FinDecideEquality : forall n, forall (x y:Fin n), {x=y}+{x<>y}.
Proof.
induction x;
destruct y using FinSn_rect; auto; try (right; discriminate).
destruct (IHx y).
left; intuition; congruence.
right; intuition; congruence.
Defined.

Lemma FinForallOrExist : forall n 
(P Q:Fin n->Prop), 
(forall x, {P x}+{Q x}) -> 
{x:Fin n | P x}+{forall x, Q x}.
Proof.
induction n.
intros; right; inversion x.
intros P Q H.
destruct (H (FinNew n)).
left.
exists (FinNew n); auto.
destruct (IHn (fun x=>(P (FinOld x)))
              (fun x=>(Q (FinOld x)))
              (fun x=> (H (FinOld x)))).
destruct s.
left.
exists (FinOld x); auto.
right.
intros x.
destruct x using FinSn_rect; auto.
Defined.

Definition FinList : forall n, {l:list (Fin n) | forall x, In x l}.
induction n.
exists (@nil (Fin 0)).
abstract inversion x.
destruct IHn.
exists (cons (FinNew n) (map (@FinOld n) x)).
intros x0.
destruct x0 using FinSn_rect; simpl; auto.
right.
apply in_map.
apply i.
Defined.

Lemma FinInjectionInjection : forall n m, forall f:Fin (S n) -> Fin (S m), injective _ _ f -> {g:Fin n -> Fin m | injective _ _ g}.
Proof.
intros n m f H.
destruct (FinOldOrNew (f (FinNew n))).
destruct s.
exists (fun a:Fin n=>
match (FinOldOrNew (f (FinOld a))) with
| inleft p => proj1_sig p
| inright _ => x
end).
intros a b A.
destruct (FinOldOrNew (f (FinOld a))); try destruct s;
destruct (FinOldOrNew (f (FinOld b))); try destruct s;
simpl in A.
apply FinOldInject.
apply H.
congruence.
assert ((FinOld a)=(FinNew n)).
apply H.
congruence.
discriminate H0.
assert ((FinOld b)=(FinNew n)).
apply H.
congruence.
discriminate H0.
apply FinOldInject.
apply H.
congruence.
assert (forall x, {y:Fin m | f (FinOld x) = FinOld y}).
intros x.
destruct (FinOldOrNew (f (FinOld x))).
auto.
assert ((FinNew n)=(FinOld x)).
apply H.
congruence.
discriminate H0.
exists (fun x=>(proj1_sig (H0 x))).
intros a b A.
destruct (H0 a).
destruct (H0 b).
simpl in A.
apply FinOldInject.
apply H.
congruence.
Defined.

Lemma FinInjectionLt : forall n m, forall f:Fin n -> Fin m, injective _ _ f -> n <= m.
Proof.
induction n; auto with *.
destruct m.
intro f.
set (s:=(f (FinNew n))).
inversion s.
intros f H.
apply le_n_S.
destruct (FinInjectionInjection H).
firstorder.
Qed.
}}}
