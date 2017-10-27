For the most part, the ability to define inductive Props doesn't increase the Props which it's technically possible to define. The notable exceptions are things like eq\_rect, False\_rect, ... (Which is not to downplay the incredible expressive power of the syntax. In fact, this page should be taken as just a curiosity.)

This is because, if you take the generated \_ind property, and remove references to the inductively defined Prop, you end up with a statement which is equivalent to the original property. Some examples:

```coq
(* A basic example of the translation technique: *)
Inductive pow2_ind : nat -> Prop :=
  | pow2_ind_base: pow2_ind 1
  | pow2_ind_mult: forall n:nat, pow2_ind n -> pow2_ind (2*n).
(* Print pow2_ind_ind. *)
(* pow2_ind_ind has type
   forall P:nat->Prop, P 1 ->
   (forall m:nat, pow2_ind m -> P m -> P (2*m)) ->
   forall n:nat, pow2_ind n -> P n.
   So we define: *)
Definition pow2 (n:nat) : Prop :=
  forall P:nat->Prop, P 1 -> (forall m:nat, P m -> P (2*m)) -> P n.
Lemma pow2_base: pow2 1.
Proof.
red.
auto.
Qed.
Lemma pow2_mult: forall n:nat, pow2 n -> pow2 (2*n).
Proof.
intros n Hpow2_n.
red; intros P Hbase Hmult.
apply Hmult.
apply Hpow2_n.
trivial.
trivial.
Qed.
Lemma pow2_equiv_pow2_ind: forall n:nat, pow2 n <-> pow2_ind n.
Proof.
split.
intro Hpow2.
apply Hpow2.
exact pow2_ind_base.
exact pow2_ind_mult.
induction 1.
exact pow2_base.
apply pow2_mult; trivial.
Qed.
(* An example of reasoning using the "noninductive" version of pow2. *)
Lemma pow2_prod: forall m n:nat, pow2 m -> pow2 n -> pow2 (m*n).
Proof.
Require Import Arith.
intros m n Hpow2_m Hpow2_n.
apply Hpow2_n. (* rough equivalent to "induction Hpow2_n." *)
replace (m*1) with m by auto with arith.
exact Hpow2_m.
intros m' Hpow2_ind.
replace (m*(2*m')) with (2*(m*m')) by ring.
apply pow2_mult.
exact Hpow2_ind.
Qed.
(* Some more basic examples of the translation. *)
Definition False2 : Prop :=
  forall P:Prop, P.
Definition True2 : Prop :=
  forall P:Prop, P -> P.
Definition and2 (P Q:Prop) : Prop :=
  forall R:Prop, (P->Q->R) -> R.
Definition conj2 {P Q:Prop} (p:P) (q:Q) : and2 P Q :=
  fun R pqr => pqr p q.
Definition or2 (P Q:Prop) : Prop :=
  forall R:Prop, (P->R) -> (Q->R) -> R.
Definition or_introl2 {P:Prop} (Q:Prop) (p:P) : or2 P Q :=
  fun R pr qr => pr p.
Definition or_intror2 (P:Prop) {Q:Prop} (q:Q) : or2 P Q :=
  fun R pr qr => qr q.
Definition im {X Y:Type} (f:X->Y) (y:Y) : Prop :=
  forall P:Y->Prop, (forall x:X, P (f x)) -> P y.
Definition im_intro {X Y:Type} (f:X->Y) (x:X) : im f (f x) :=
  fun P pf => pf x.
Definition ex2 {X:Type} (P:X->Prop) : Prop :=
  forall Q:Prop, (forall x:X, P x -> Q) -> Q.
(* Interestingly, in this definition, the classical statement that
   exists x:X, P x <-> ~ forall x:X, ~ P x just means that it's sufficient
   to prove the case Q = False. *)
Definition ex2_intro {X:Type} (P:X->Prop) (x:X) (p:P x) : ex2 P :=
  fun Q pq => pq x p.
Definition eq2 {X:Type} (x y:X) : Prop :=
  forall P:X->Prop, P x -> P y.
Lemma eq2_refl: forall {X} (x:X), eq2 x x.
Proof.
unfold eq2.
trivial.
Qed.
Lemma eq2_sym: forall {X} (x y:X), eq2 x y -> eq2 y x.
Proof.
intros.
apply H.
apply eq2_refl.
Qed.
Lemma eq2_trans: forall {X} (x y z:X), eq2 x y -> eq2 y z -> eq2 x z.
Proof.
intros.
apply H0.
exact H.
Qed.
Lemma im_ex_eq: forall {X Y} (f:X->Y) (y:Y), and2
  (im f y -> ex2 (fun x:X => eq2 (f x) y))
  (ex2 (fun x:X => eq2 (f x) y) -> im f y).
Proof.
intros.
apply conj2.
(* forward implication *)
intros.
apply H.  (* "induction" on the im hypothesis *)
intros.
apply ex2_intro with x.
apply eq2_refl.
(* reverse implication *)
intros.
apply H.  (* "induction" on the ex2 hypothesis *)
intros.
apply H0.
apply im_intro.
Qed.
(* Now getting back to the first example, here's how to prove the
   full-strength inductive principle. *)
Lemma pow2_strong_ind: forall P:nat->Prop,
  P 1 -> (forall m:nat, pow2 m -> P m -> P (2*m)) ->
  forall n:nat, pow2 n -> P n.
Proof.
intros P Hbase Hmult.
assert (forall n:nat, pow2 n -> and2 (pow2 n) (P n)).
intros.
apply H.
apply conj2.
exact pow2_base.
exact Hbase.
intros.
apply H0; intros; clear H0.
apply conj2.
apply pow2_mult; trivial.
apply Hmult; trivial.
intros.
pose proof (H _ H0).
apply H1; intros.
trivial.
Qed.
(* And based on this, we can create a "destruct" principle. *)
Lemma pow2_destruct: forall (P:nat->Prop) (n:nat), pow2 n ->
  P 1 -> (forall m:nat, pow2 m -> P (2*m)) ->
  P n.
Proof.
intros.
apply pow2_strong_ind.
trivial.
auto.
trivial.
Qed.
(* Example of usage of pow2_destruct: *)
Lemma pow2_1_or_even: forall n:nat, pow2 n -> or2 (eq2 n 1)
                                             (ex2 (fun m:nat => eq2 n (2*m))).
Proof.
intros.
apply pow2_destruct with (1:=H); clear n H; intros.  (* equiv to "destruct H." *)
(* pow2_base case *)
apply or_introl2.
apply eq2_refl.
(* pow2_mult case *)
apply or_intror2.
apply ex2_intro with m.
apply eq2_refl.
Qed.
(* And an example of translating a mutually inductive definition... *)
Definition even (n:nat) := forall (P Q:nat->Prop),
  P 0 -> (forall n:nat, P n -> Q (S n)) -> (forall n:nat, Q n -> P (S n)) ->
  P n.
Definition odd (n:nat) := forall (P Q:nat->Prop),
  P 0 -> (forall n:nat, P n -> Q (S n)) -> (forall n:nat, Q n -> P (S n)) ->
  Q n.
Lemma even_O: even 0.
Proof.
red; intros.
trivial.
Qed.
Lemma odd_S: forall n:nat, even n -> odd (S n).
Proof.
intros.
red; intros.
apply H1.
apply H with (Q:=Q); trivial.
Qed.
Lemma even_S: forall n:nat, odd n -> even (S n).
Proof.
intros.
red; intros.
apply H2.
apply H with (P:=P); trivial.
Qed.
```

You could do basically the same thing with inductively defined Types, assuming the existence of subset types. Here, though, there are more pronounced disadvantages: the big one is it raises the universe level where the inductive definition doesn't. For example:

```coq
Definition nat_cont : Type :=
  forall P:Type, P -> (P -> P) -> P.
Definition pre_O : nat_cont :=
  fun P p0 pS => p0.
Definition pre_S : nat_cont -> nat_cont :=
  fun n P p0 pS => pS (n P p0 pS).
(* Interesting how this naturally reproduces the lambda-calculus point of
   view that an natural number n is identified with the n-fold
   composition operation. *)
Definition nat2 := { n:nat_cont |
  forall P:nat_cont->Prop, P pre_O -> (forall m:nat_cont, P m -> P (pre_S m)) ->
  P n }.
Program Definition O2 : nat2 := pre_O.
Program Definition S2 : nat2 -> nat2 := pre_S.
Next Obligation.
destruct x as [n].
apply H0.
apply p; trivial.
Qed.
(* This definition fails with a universe inconsistency error.
Definition nat2_rect_aux {P:nat2 -> Type}
  (P0 : P O2) (Prec: forall n:nat2, P n -> P (S2 n)) (n:nat_cont) : sigT P :=
  n _ (existT _ O2 P0)
    (fun x:sigT P => let (m,x0):=x in
     existT _ (S2 m) (Prec m x0)).
*)
```

But for simple inductive definitions where the inductive type only occurs as a result, it's possible to work around this and stay in the same universe.

```coq
Axiom constructive_definite_description: forall {A:Type} (P:A->Prop),
  ex2 P -> (forall a1 a2:A, P a1 -> P a2 -> eq2 a1 a2) -> sig P.
Lemma cdd_correct: forall {A:Type} (P:A->Prop)
  (Hexist:_) (Hunique:_) (a:A), P a ->
  eq2 (proj1_sig (constructive_definite_description P Hexist Hunique)) a.
Proof.
intros.
apply Hunique.
destruct @constructive_definite_description.
exact p.
trivial.
Qed.
Definition sum_cont (A B:Type) := (A->Prop) -> (B->Prop) -> Prop.
Definition pre_inl {A B:Type} (a:A) : sum_cont A B :=
  fun Pa Pb => Pa a.
Definition pre_inr {A B:Type} (b:B) : sum_cont A B :=
  fun Pa Pb => Pb b.
Lemma pre_inl_inj: forall {A B} (a1 a2:A),
  eq2 (pre_inl a1 (B:=B)) (pre_inl a2) -> eq2 a1 a2.
Proof.
intros.
assert (pre_inl a1 (eq2 a1) (fun _ => False2) (B:=B)).
red.
apply eq2_refl.
apply H in H0.
red in H0.
exact H0.
Qed.
Lemma pre_inr_inj: forall {A B} (b1 b2:B),
  eq2 (pre_inr b1 (A:=A)) (pre_inr b2) -> eq2 b1 b2.
Proof.
intros.
assert (pre_inr b1 (fun _ => False2) (eq2 b1) (A:=A)).
apply eq2_refl.
apply H in H0.
exact H0.
Qed.
Lemma pre_inl_pre_inr_disjoint: forall {A B} (a:A) (b:B),
  eq2 (pre_inl a) (pre_inr b) -> False2.
Proof.
intros.
assert (pre_inl a (fun _ => True2) (fun _ => False2) (B:=B)).
red.
red; trivial.
apply H in H0.
red in H0.
exact H0.
Qed.
Definition sum2 (A B:Type) :=
  { x:sum_cont A B | or2 (im pre_inl x) (im pre_inr x) }.
Definition inl2 {A:Type} (B:Type) (a:A) : sum2 A B.
refine (exist _ (pre_inl a) _).
apply or_introl2.
apply im_intro.
Defined.
Definition inr2 (A:Type) {B:Type} (b:B) : sum2 A B.
refine (exist _ (pre_inr b) _).
apply or_intror2.
apply im_intro.
Defined.
Definition sum_rect2 {A B C:Type} (f:A->C) (g:B->C) (x:sum2 A B) : C.
refine (proj1_sig (constructive_definite_description
  (fun c:C => or2 (ex2 (fun a:A => and2 (eq2 (pre_inl a) (proj1_sig x))
                                        (eq2 (f a) c)))
                  (ex2 (fun b:B => and2 (eq2 (pre_inr b) (proj1_sig x))
                                        (eq2 (g b) c)))) _ _)).
destruct x as [x].
simpl.
apply o; intros.
apply H; intro a.
apply ex2_intro with (f a).
apply or_introl2.
apply ex2_intro with a.
apply conj2; apply eq2_refl.
apply H; intro b.
apply ex2_intro with (g b).
apply or_intror2.
apply ex2_intro with b.
apply conj2; apply eq2_refl.
intros c1 c2 ? ?.
apply H; clear H; intros; apply H0; clear H0; intros.
apply H; clear H; intros a1 ?.
apply H0; clear H0; intros a2 ?.
apply H; clear H; intros.
apply H0; clear H0; intros.
assert (eq2 a1 a2).
apply (pre_inl_inj (B:=B)).
apply eq2_trans with (proj1_sig x).
trivial.
apply eq2_sym; trivial.
apply H2.
apply H1.
apply H3.
apply eq2_refl.
apply H; clear H; intros a ?.
apply H0; clear H0; intros b ?.
apply H; clear H; intros.
apply H0; clear H0; intros.
assert (eq2 (pre_inl a) (pre_inr b)).
apply eq2_trans with (proj1_sig x).
trivial.
apply eq2_sym; trivial.
apply pre_inl_pre_inr_disjoint in H3.
apply H3.
apply H; clear H; intros b ?.
apply H0; clear H0; intros a ?.
apply H; clear H; intros.
apply H0; clear H0; intros.
assert (eq2 (pre_inl a) (pre_inr b)).
apply eq2_trans with (proj1_sig x).
trivial.
apply eq2_sym; trivial.
apply pre_inl_pre_inr_disjoint in H3.
apply H3.
apply H; clear H; intros b1 ?.
apply H0; clear H0; intros b2 ?.
apply H; clear H; intros.
apply H0; clear H0; intros.
assert (eq2 b1 b2).
apply (pre_inr_inj (A:=A)).
apply eq2_trans with (proj1_sig x).
trivial.
apply eq2_sym; trivial.
apply H1.
apply H2.
apply H3.
apply eq2_refl.
Defined.
Lemma sum_rect2_correct_l: forall {A B C} (f:A->C) (g:B->C) (a:A),
  eq2 (sum_rect2 f g (inl2 _ a)) (f a).
Proof.
intros.
apply cdd_correct.
apply or_introl2.
apply ex2_intro with a.
apply conj2; apply eq2_refl.
Qed.
Lemma sum_rect2_correct_r: forall {A B C} (f:A->C) (g:B->C) (b:B),
  eq2 (sum_rect2 f g (inr2 _ b)) (g b).
Proof.
intros.
apply cdd_correct.
apply or_intror2.
apply ex2_intro with b.
apply conj2; apply eq2_refl.
Qed.
Definition product_cont (A B:Type) := (A->B->Prop) -> Prop.
Definition pre_pair {A B} (a:A) (b:B) : product_cont A B :=
  fun P => P a b.
Lemma pre_pair_inj: forall {A B} (a1 a2:A) (b1 b2:B),
  eq2 (pre_pair a1 b1) (pre_pair a2 b2) ->
  and2 (eq2 a1 a2) (eq2 b1 b2).
Proof.
intros.
pose (P := fun (a:A) (b:B) => and2 (eq2 a1 a) (eq2 b1 b)).
assert (pre_pair a1 b1 P).
red; red.
apply conj2; apply eq2_refl.
apply H in H0.
exact H0.
Qed.
Definition product2 (A B:Type) :=
  { x:product_cont A B | ex2 (fun a:A => ex2 (fun b:B => eq2 x (pre_pair a b))) }.
Definition pair2 {A B} (a:A) (b:B) : product2 A B.
refine (exist _ (pre_pair a b) _).
apply ex2_intro with a; apply ex2_intro with b.
apply eq2_refl.
Defined.
Definition product2_rect {A B C} (f:A->B->C) (x:product2 A B) : C.
refine (proj1_sig (constructive_definite_description
  (fun c:C => ex2 (fun a:A => ex2 (fun b:B =>
     and2 (eq2 (proj1_sig x) (pre_pair a b)) (eq2 (f a b) c)))) _ _)).
destruct x as [x].
simpl.
apply e; clear e; intros a ?.
apply H; clear H; intros b ?.
apply ex2_intro with (f a b).
apply ex2_intro with a; apply ex2_intro with b.
apply conj2.
trivial.
apply eq2_refl.
intros c1 c2 ? ?.
apply H; clear H; intros a1 ?.
apply H; clear H; intros b1 ?.
apply H0; clear H0; intros a2 ?.
apply H0; clear H0; intros b2 ?.
apply H; clear H; intros.
apply H0; clear H0; intros.
assert (and2 (eq2 a1 a2) (eq2 b1 b2)).
apply pre_pair_inj.
apply H.
exact H0.
apply H3; clear H3; intros.
apply H1.
apply H2.
apply H3.
apply H4.
apply eq2_refl.
Defined.
Lemma product2_rect_correct: forall {A B C} (f:A->B->C) (a:A) (b:B),
  eq2 (product2_rect f (pair2 a b)) (f a b).
Proof.
intros.
apply cdd_correct.
apply ex2_intro with a; apply ex2_intro with b.
apply conj2; apply eq2_refl.
Qed.
```
