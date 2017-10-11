Proof of Langranges Theorem. Compatable with Coq 8.0pl2.

    Require Import List.
    Require Import Relations_1.
    Require Import Eqdep_dec.
    Require Import Peano_dec.
    Set Implicit Arguments.
    Record isSetoid (SetoidType : Type)
                     (Seq:SetoidType -> SetoidType -> Prop) : Prop
    := {
    Seq_refl : Reflexive SetoidType Seq;
    Seq_sym : Symmetric SetoidType Seq;
    Seq_trans : Transitive SetoidType Seq
    }.
    Record Setoid : Type := {
    SetoidType :> Type;
    Seq : SetoidType -> SetoidType -> Prop;
    SetoidProof : isSetoid Seq
    }.
    Implicit Arguments Seq [s].
    Lemma Type_isSetoid : forall X:Type, isSetoid (@eq X).
    Proof.
    intros.
    constructor.
    intros x.
    reflexivity.
    intros x y.
    auto.
    intros x y z.
    congruence.
    Qed.
    Definition TypeSetoid (X:Type) : Setoid := Build_Setoid (Type_isSetoid X).
    Definition isSFunction (X Y:Setoid) (f:X -> Y): Prop :=
    forall x y, Seq x y -> Seq (f x) (f y).
    Record SFunction (X Y:Setoid) : Type := {
    morphism :> X -> Y;
    SFunctionProof : isSFunction X Y morphism
    }.
    Definition SFunction_eq (X Y:Setoid) (f g:SFunction X Y) := forall x, Seq (f x) (g x).
    Lemma SFun_isSetoid : forall X Y, isSetoid (@SFunction_eq X Y).
    Proof.
    intros.
    constructor.
    intros x y.
    apply Seq_refl.
    apply SetoidProof.
    intros a b H x.
    apply Seq_sym.
    apply SetoidProof.
    apply H.
    intros a b c H0 H1 x.
    apply Seq_trans with (y:=(b x));
    auto.
    apply SetoidProof with (s:=Y).
    Qed.
    Definition SFunSetoid (X Y:Setoid) : Setoid := Build_Setoid (SFun_isSetoid X Y).
    Lemma id_isSFunction : forall X, isSFunction X X (fun (x:X) => x).
    Proof.
    unfold isSFunction.
    auto.
    Qed.
    Definition SFunId (X:Setoid) : SFunSetoid X X := Build_SFunction (id_isSFunction X).
    Lemma SFunCompose_isSFunction (X Y Z:Setoid) (g:SFunSetoid Y Z) (f:SFunSetoid X Y) : isSFunction X Z (fun x => g (f x)).
    Proof.
    simpl.
    unfold isSFunction.
    intros.
    destruct g; simpl.
    destruct f; simpl.
    auto.
    Qed.
    Definition SFunCompose (X Y Z:Setoid)
                           (g:SFunSetoid Y Z)
                           (f:SFunSetoid X Y) : SFunSetoid X Z
    := Build_SFunction (SFunCompose_isSFunction g f).
    Lemma SFunComposeAssoc : forall (W X Y Z:Setoid),
      forall (h:SFunSetoid Y Z),
      forall (g:SFunSetoid X Y),
      forall (f:SFunSetoid W X),
      (Seq (SFunCompose (SFunCompose h g) f) (SFunCompose h (SFunCompose g f))).
    Proof.
    simpl.
    unfold SFunction_eq.
    intros.
    apply Seq_refl.
    apply SetoidProof.
    Qed.
    Record isSBijection (X Y:Setoid) (f:SFunction X Y) (g:SFunction Y X) : Type := {
    left_inverse : forall x, Seq (g (f x)) x;
    right_inverse : forall y, Seq (f (g y)) y
    }.
    Record SBijection (X Y:Setoid) : Type := {
    forward :> SFunction X Y;
    reverse : SFunction Y X;
    SBijectionProof : isSBijection forward reverse
    }.
    Definition SBijection_eq (X Y:Setoid) (f g:SBijection X Y) :=
    SFunction_eq f g.
    Lemma SBij_isSetoid : forall X Y, isSetoid (@SBijection_eq X Y).
    Proof.
    intros.
    unfold SBijection_eq.
    simpl.
    destruct (SFun_isSetoid X Y).
    constructor.
    intro x.
    apply Seq_refl0.
    intros x y.
    apply Seq_sym0.
    intros x y z.
    apply Seq_trans0.
    Qed.
    Definition SBijSetoid (X Y:Setoid) : Setoid :=
    Build_Setoid (SBij_isSetoid X Y).
    Lemma id_isBijection : forall X, isSBijection (SFunId X) (SFunId X).
    Proof.
    intros.
    constructor;
    unfold SFunId; simpl;
    apply Seq_refl;
    apply SetoidProof.
    Qed.
    Definition SBijId X : SBijSetoid X X := Build_SBijection (id_isBijection X).
    Lemma SBijInverse_isBijection X Y (f:SBijSetoid X Y) : isSBijection (reverse f) (forward f).
    Proof.
    intros.
    destruct f.
    destruct SBijectionProof0.
    constructor;
    auto.
    Qed.
    Definition SBijInverse (X Y:Setoid) (f:SBijSetoid X Y) : SBijSetoid Y X :=
    Build_SBijection (SBijInverse_isBijection f).
    Lemma SBijInverseMorph : forall (X Y:Setoid) (f g:SBijSetoid X Y), (Seq f g) -> (Seq (SBijInverse f) (SBijInverse g)).
    Proof.
    intros.
    intros y.
    destruct (SBijectionProof f).
    destruct (SBijectionProof g).
    simpl in *.
    apply Seq_trans with (y:= (reverse f) (g (reverse g y))).
    apply SetoidProof with (s:=X).
    apply (SFunctionProof (reverse f)).
    apply Seq_sym.
    apply SetoidProof with (s:=Y).
    auto.
    apply Seq_trans with (y:= (reverse f (f (reverse g y)))).
    apply SetoidProof with (s:=X).
    apply (SFunctionProof (reverse f)).
    apply Seq_sym.
    apply SetoidProof with (s:=Y).
    apply H.
    apply left_inverse0.
    Qed.
    Lemma SBijCompose_isSBijection X Y Z (g:SBijection Y Z) (f:SBijection X Y)
                               : isSBijection (SFunCompose g f) (SFunCompose (SBijInverse f) (SBijInverse g)).
    Proof.
    simpl.
    intros.
    constructor; intros; simpl.
    apply Seq_trans with (y:=(SBijInverse f (f x))).
    apply SetoidProof with (s:=X).
    apply SFunctionProof.
    apply left_inverse.
    destruct g; auto.
    apply left_inverse.
    destruct f; auto.
    apply Seq_trans with (y:=(g (SBijInverse g y))).
    apply SetoidProof with (s:=Z).
    apply SFunctionProof.
    apply right_inverse.
    destruct f; auto.
    apply right_inverse.
    destruct g; auto.
    Qed.
    Definition SBijCompose (X Y Z:Setoid) (g:SBijSetoid Y Z) (f:SBijSetoid X Y) : SBijSetoid X Z
    := Build_SBijection (SBijCompose_isSBijection g f).
    Lemma SBijComposeMorph2 :
    forall (X Y Z:Setoid)
           (f g:SBijSetoid X Y)
           (h:SBijSetoid Y Z),
           (Seq f g) -> (Seq (SBijCompose h f) (SBijCompose h g)).
    Proof.
    intros.
    intros y.
    simpl in *.
    apply (SFunctionProof h).
    apply H.
    Qed.
    Lemma SBijComposeMorph1 :
    forall (X Y Z:Setoid)
           (h:SBijSetoid X Y)
           (f g:SBijSetoid Y Z),
           (Seq f g) -> (Seq (SBijCompose f h) (SBijCompose g h)).
    Proof.
    intros.
    intros y.
    simpl in *.
    apply H.
    Qed.
    Lemma SBijComposeMorph :
    forall (X Y Z:Setoid)
           (a b:SBijSetoid X Y)
           (c d:SBijSetoid Y Z),
           (Seq a b) -> (Seq c d) -> (Seq (SBijCompose c a) (SBijCompose d b)).
    Proof.
    intros.
    apply Seq_trans with (y:= (SBijCompose c b)).
    apply SetoidProof with (s:=SBijSetoid X Z).
    apply SBijComposeMorph2.
    assumption.
    apply SBijComposeMorph1.
    assumption.
    Qed.
    Inductive Fin : nat -> Set :=
    | New : forall n, Fin (S n)
    | Old : forall n, Fin n -> Fin (S n).
    Definition K_dec_Type :=
    fun A : Type =>
    let comp :=
      fun (x y y' : A) (eq1 : x = y) (eq2 : x = y') =>
      eq_ind x (fun a : A => a = y') eq2 y eq1 in
    fun (eq_dec : forall x y : A, x = y \/ x <> y) (x : A) =>
    let nu :=
      fun (y : A) (u : x = y) =>
      match eq_dec x y with
      | or_introl eqxy => eqxy
      | or_intror neqxy => False_ind (x = y) (neqxy u)
      end in
    let nu_constant :=
      fun (y : A) (u v : x = y) =>
      match
        eq_dec x y as o
        return
          (match o with
           | or_introl eqxy => eqxy
           | or_intror neqxy => False_ind (x = y) (neqxy u)
           end =
           match o with
           | or_introl eqxy => eqxy
           | or_intror neqxy => False_ind (x = y) (neqxy v)
           end)
      with
      | or_introl e => refl_equal e
      | or_intror n =>
          match
            n u as f return (False_ind (x = y) f = False_ind (x = y) (n v))
          with
          end
      end in
    let nu_inv :=
      fun (y : A) (v : x = y) => comp x x y (nu x (refl_equal x)) v in
    fun (P : x = x -> Type) (H : P (refl_equal x)) (p : x = x) =>
    eq_rect (refl_equal x) (fun p0 : x = x => P p0) H p
      (eq_proofs_unicity eq_dec (refl_equal x) p).
    Definition K_dec_set_Type :=
    fun (A : Set) (H : forall x y : A, {x = y} + {x <> y}) (x : A)
      (P : x = x -> Type) (H0 : P (refl_equal x)) (p : x = x) =>
    eq_rect_r P
      (K_dec_Type
         (fun x0 y : A =>
          match H x0 y with
          | left e =>
              eq_ind x0 (fun y0 : A => x0 = y0 \/ x0 <> y0)
                (or_introl (x0 <> x0) (refl_equal x0)) y e
          | right n =>
              or_intror (x0 = y)
                (fun neq : x0 = y =>
                 n (eq_ind x0 (fun y0 : A => x0 = y0) (refl_equal x0) y neq))
          end) (fun e : x = x => P (eqT2eq e)) H0 (eq2eqT p)) (eq_eqT_bij p).
    Lemma inj_right_pair2 :
     forall A : Set,
     (forall x y : A, {x = y} + {x <> y}) ->
     forall (x : A) (P : A -> Set) (y y' : P x),
     existS P x y = existS P x y' -> y = y'.
    Proof.
    intros.
    set
     (Proj :=
      fun (e : sigS P) (def : P x) =>
      match e with
      | existS x' dep =>
          match H x' x with
          | left eqdep => eq_rec x' P dep x eqdep
          | _ => def
          end
      end) in *.
    cut (Proj (existS P x y) y = Proj (existS P x y') y).
    simpl in |- *.
    induction (H x x).
    intro e.
    set
     (B :=
      K_dec_set H
        (fun z : x = x =>
         eq_rec x P y x z = eq_rec x P y' x z ->
         eq_rec x P y x (refl_equal x) = eq_rec x P y' x (refl_equal x))
        (fun z : eq_rec x P y x (refl_equal x) = eq_rec x P y' x (refl_equal x) =>
         z) a e) in *.
    apply B.
    elim b.
    auto.
    rewrite H0.
    reflexivity.
    Qed.
    Lemma FinOldOrNew :
     forall n,
     forall (P:Fin (S n)->Type),
     (forall y:Fin n, P (Old y)) ->
     P (New n) ->
     forall x, P x.
    Proof.
    intros n P H0 H1 x.
    change x with (eq_rect (S n) Fin x (S n) (refl_equal (S n))).
    generalize (refl_equal (S n)).
    set (t:= (S n)) in *.
    unfold t at 2 4.
    dependent inversion x;
    unfold t in *.
    rewrite H2.
    clear x t n0 H2.
    intro.
    pattern e.
    apply K_dec_set_Type.
    apply eq_nat_dec.
    simpl.
    auto.
    subst n0.
    intros.
    pattern e.
    apply K_dec_set_Type.
    apply eq_nat_dec.
    simpl.
    auto.
    Qed.
    Lemma FinEqOldOrNew : forall n,
    forall y:Fin (S n),
    {z:Fin n | y=(Old z)}+{y=New n}.
    Proof.
    intros.
    destruct y using FinOldOrNew.
    left.
    exists y.
    reflexivity.
    auto.
    Qed.
    Lemma FinDecideEquality : forall n, forall (x y:Fin n), {x=y}+{x<>y}.
    Proof.
    intros n x.
    induction x.
    intros y.
    destruct y using FinOldOrNew.
    right.
    discriminate.
    auto.
    intros y.
    destruct y using FinOldOrNew.
    destruct (IHx y).
    rewrite e.
    auto.
    right.
    injection.
    intro.
    apply n0.
    apply inj_right_pair2 with (P:=(fun n : nat => Fin n)).
    apply eq_nat_dec.
    apply H0.
    right.
    discriminate.
    Qed.
    Lemma FinForallOrExist : forall n
    (P Q:Fin n->Prop),
    (forall x, {P x}+{Q x}) ->
    {x:Fin n | P x}+{forall x, Q x}.
    Proof.
    intro.
    induction n; intros.
    right.
    intros.
    inversion x.
    set (P':=fun x => P (Old x)).
    set (Q':=fun x => Q (Old x)).
    assert (forall x, {P' x}+{Q' x}).
    intros.
    destruct (H (Old x)); auto.
    destruct (IHn (fun x => P (Old x)) (fun x => Q (Old x)) H0).
    left.
    destruct s.
    exists (Old x).
    auto.
    destruct (H (New n)).
    left.
    exists (New n).
    auto.
    right.
    intros.
    destruct x using FinOldOrNew; auto.
    Qed.
    Definition FinList : forall n, {l:list (Fin n) | forall x, In x l}.
    intros.
    induction n.
    exists (@nil (Fin 0)).
    intros.
    abstract inversion x.
    destruct IHn.
    exists (cons (New n) (map (@Old n) x)).
    intros.
    destruct x0 using FinOldOrNew.
    right.
    apply in_map.
    apply i.
    left.
    reflexivity.
    Qed.
    Lemma FinBijEqualHelp : forall n m,
      forall (X:SBijection (TypeSetoid (Fin (S n))) (TypeSetoid (Fin (S m)))),
      forall x, (Old x)=(reverse X (New m)) -> {y:(Fin m) | (Old y) = (forward X (New n))}.
    Proof.
    intros.
    destruct X.
    simpl in *.
    set (s:=forward0 (New n)).
    cut (s=s).
    pattern s at -1.
    elim s using FinOldOrNew.
    intros.
    exists y.
    reflexivity.
    unfold s.
    intros.
    clear s.
    rewrite <- H0 in H.
    destruct SBijectionProof0.
    simpl in *.
    rewrite left_inverse0 in H.
    discriminate H.
    reflexivity.
    Qed.
    Lemma FinBijEqualHelp2 : forall n m,
      forall (X:SBijection (TypeSetoid (Fin (S n))) (TypeSetoid (Fin (S m)))),
      forall x, ((Old x)<>(reverse X (New m))) ->
      {y:(Fin m) | (Old y) = (forward X (Old x))}.
    Proof.
    intros.
    cut ((X (Old x))=(X (Old x))).
    pattern (X (Old x)) at -1.
    elim (X (Old x)) using FinOldOrNew.
    intros.
    exists y.
    reflexivity.
    intros.
    elim H.
    rewrite <- H0.
    destruct (SBijectionProof X).
    simpl in *.
    symmetry.
    apply left_inverse0.
    reflexivity.
    Qed.
    Lemma FinBijEqual : forall n m, (SBijection (TypeSetoid (Fin n)) (TypeSetoid (Fin m))) -> n = m.
    Proof.
    intros n.
    induction n.
    intro.
    induction m.
    auto.
    intros.
    destruct X.
    set (a:=(reverse0 (New m))).
    inversion a.
    intro.
    induction m.
    intros.
    destruct X.
    set (a:=(forward0 (New n))).
    inversion a.
    intros.
    replace m with n.
    reflexivity.
    apply IHn.
    intros.
    set (f:=fun (x:TypeSetoid (Fin n)) =>
    match (FinDecideEquality (Old x) (reverse X (New m))) return (TypeSetoid (Fin m)) with
    | left p => proj1_sig (FinBijEqualHelp X p)
    | right p => proj1_sig (FinBijEqualHelp2 X p)
    end).
    set (Y:=SBijInverse X).
    set (g:=fun (x:TypeSetoid (Fin m)) =>
    match (FinDecideEquality (Old x) (reverse Y (New n))) return (TypeSetoid (Fin n))with
    | left p => proj1_sig (FinBijEqualHelp Y p)
    | right p => proj1_sig (FinBijEqualHelp2 Y p)
    end).
    assert (isSFunction _ _ f).
    intros x y H.
    simpl in *.
    rewrite H.
    reflexivity.
    assert (isSFunction _ _ g).
    intros x y H0.
    simpl in *.
    rewrite H0.
    reflexivity.
    exists (Build_SFunction H) (Build_SFunction H0).
    split; simpl.
    intros.
    unfold f.
    destruct (FinDecideEquality (Old x) (reverse X (New m))).
    destruct (FinBijEqualHelp X e).
    simpl.
    unfold g.
    destruct (FinDecideEquality (Old x0) (reverse Y (New n))).
    destruct (FinBijEqualHelp Y e1).
    simpl in *.
    rewrite <- e in e2.
    inversion e2.
    apply inj_right_pair2 with (P:=(fun n : nat => Fin n)).
    apply eq_nat_dec.
    apply H2.
    simpl in *.
    elim n0.
    assumption.
    simpl.
    destruct (FinBijEqualHelp2 X n0).
    simpl.
    unfold g.
    destruct (FinDecideEquality (Old x0) (reverse Y (New n))).
    assert ((New n)=(Old x)).
    destruct (SBijectionProof X).
    rewrite <- (left_inverse0 (New n)).
    rewrite <- (left_inverse0 (Old x)).
    simpl in *.
    rewrite e in e0.
    rewrite e0.
    reflexivity.
    discriminate H1.
    destruct (FinBijEqualHelp2 Y n1).
    simpl in *.
    rewrite e in e0.
    destruct (SBijectionProof X).
    rewrite left_inverse0 in e0.
    inversion e0.
    apply inj_right_pair2 with (P:=(fun n : nat => Fin n)).
    apply eq_nat_dec.
    assumption.
    intros.
    unfold g.
    destruct (FinDecideEquality (Old y) (reverse Y (New n))).
    destruct (FinBijEqualHelp Y e).
    simpl in *.
    unfold f.
    destruct (FinDecideEquality (Old x) (reverse X (New m))).
    destruct (FinBijEqualHelp X e1).
    simpl in *.
    rewrite <- e in e2.
    inversion e2.
    apply inj_right_pair2 with (P:=(fun n : nat => Fin n)).
    apply eq_nat_dec.
    apply H2.
    elim n0.
    assumption.
    destruct (FinBijEqualHelp2 Y n0).
    simpl.
    unfold f.
    destruct (FinDecideEquality (Old x) (reverse X (New m))).
    simpl in *.
    assert ((New m)=(Old y)).
    destruct (SBijectionProof X).
    rewrite <- (right_inverse0 (New m)).
    rewrite <- (right_inverse0 (Old y)).
    rewrite e in e0.
    rewrite e0.
    reflexivity.
    discriminate H1.
    destruct (FinBijEqualHelp2 X n1).
    simpl in *.
    rewrite e in e0.
    destruct (SBijectionProof X).
    rewrite right_inverse0 in e0.
    inversion e0.
    apply inj_right_pair2 with (P:=(fun n : nat => Fin n)).
    apply eq_nat_dec.
    assumption.
    Qed.
    Definition has_FiniteCardinality (n:nat) (X:Setoid) := SBijection (TypeSetoid (Fin n)) X.
    Definition SAutomorphism (X:Setoid) := SBijection X X.
    Definition SAutoSetoid (X:Setoid) := SBijSetoid X X.
    Definition Prop_eq (P Q:Prop) := P <-> Q.
    Hint Unfold Prop_eq.
    Lemma Prop_isSetoid : isSetoid Prop_eq.
    Proof.
    unfold Prop_eq.
    constructor.
    intro x.
    tauto.
    intros x y.
    tauto.
    intros x y z.
    tauto.
    Qed.
    Definition PropSetoid : Setoid := Build_Setoid Prop_isSetoid.
    Section SPredicate.
    Variable X:Setoid.
    Definition SPredicate := SFunction X PropSetoid.
    Definition SPredSetoid := SFunSetoid X PropSetoid.
    Definition Union_isSFunction :
        forall (P Q:SPredSetoid),
        isSFunction X PropSetoid (fun x => P x \/ Q x).
    Proof.
    intros P Q x y.
    destruct P.
    destruct Q.
    unfold isSFunction in *.
    simpl in *.
    unfold Prop_eq in *.
    simpl in *.
    set (M := SFunctionProof0 x y).
    set (N := SFunctionProof1 x y).
    intuition.
    Qed.
    Definition SPredUnion (P Q:SPredSetoid) : SPredSetoid :=
    Build_SFunction (Union_isSFunction P Q).
    Definition Intersect_isSFunction :
        forall (P Q:SPredSetoid),
        isSFunction X PropSetoid (fun x => P x /\ Q x).
    Proof.
    intros P Q x y.
    destruct P.
    destruct Q.
    unfold isSFunction in *.
    simpl in *.
    unfold Prop_eq in *.
    simpl in *.
    set (M := SFunctionProof0 x y).
    set (N := SFunctionProof1 x y).
    intuition.
    Qed.
    Definition SPredIntersect (P Q:SPredSetoid) : SPredSetoid :=
    Build_SFunction (Intersect_isSFunction P Q).
    Definition Empty_isSFunction : isSFunction X PropSetoid (fun x => False).
    Proof.
    intros x y.
    simpl.
    intuition.
    unfold Prop_eq.
    tauto.
    Qed.
    Definition SPredEmpty : SPredSetoid := Build_SFunction (Empty_isSFunction).
    Definition Full_isSFunction : isSFunction X PropSetoid (fun x => True).
    Proof.
    intros x y.
    simpl.
    intuition.
    unfold Prop_eq.
    tauto.
    Qed.
    Definition SPredFull : SPredSetoid := Build_SFunction (Full_isSFunction).
    Definition Disjoint (P Q:SPredSetoid) := Seq (SPredIntersect P Q) SPredEmpty.
    Definition Included (P Q:SPredSetoid) := forall x, P x -> Q x.
    Lemma IncludedUnion : forall P Q, (Included P Q) -> (Seq (SPredUnion P Q) Q).
    Proof.
    intros.
    split.
    intros.
    destruct H0.
    apply H.
    apply H0.
    apply H0.
    intros.
    simpl.
    auto.
    Qed.
    Section SubSetoid.
    Variable P:SPredicate.
    Record SSubSet : Type :={
    universe : X;
    sub : P universe
    }.
    Definition SSubSet_eq (x y:SSubSet) := Seq (universe x) (universe y).
    Lemma SSubSet_isSetoid : isSetoid SSubSet_eq.
    Proof.
    unfold SSubSet_eq.
    constructor.
    intros x.
    apply Seq_refl.
    apply SetoidProof.
    intros x y.
    apply Seq_sym with X.
    apply SetoidProof.
    intros x y z.
    apply Seq_trans with X.
    apply SetoidProof.
    Qed.
    Definition SubSetoid : Setoid := Build_Setoid SSubSet_isSetoid.
    End SubSetoid.
    Lemma SPredEqBij : forall (P Q:SPredSetoid), (Seq P Q) -> (SBijection (SubSetoid P) (SubSetoid Q)).
    Proof.
    intros.
    set (f:= fun x:(SubSetoid P) => (Build_SSubSet Q (universe x) (proj1 (H (universe x)) (sub x))):(SubSetoid Q)).
    set (g:= fun x:(SubSetoid Q) => (Build_SSubSet P (universe x) (proj2 (H (universe x)) (sub x))):(SubSetoid P)).
    assert (isSFunction _ _ f).
    intros r s J.
    apply J.
    assert (isSFunction _ _ g).
    intros r s J.
    apply J.
    exists (Build_SFunction H0) (Build_SFunction H1).
    split; simpl; intros;
    unfold f, g, SSubSet_eq;
    simpl;
    apply Seq_refl;
    apply SetoidProof.
    Qed.
    Lemma DisjointFinite : forall n m P Q,
     (Disjoint P Q) ->
     (forall x, (SPredUnion P Q x) -> {P x}+{Q x}) ->
     (has_FiniteCardinality n (SubSetoid P)) ->
     (has_FiniteCardinality m (SubSetoid Q)) ->
     (has_FiniteCardinality (n+m) (SubSetoid (SPredUnion P Q))).
    Proof.
    induction n.
    simpl.
    intros m P Q H K.
    intros.
    unfold has_FiniteCardinality.
    apply SBijCompose with (Y:=SubSetoid Q).
    simpl.
    apply SPredEqBij.
    intro x.
    split.
    intros.
    simpl.
    auto.
    intros.
    destruct H0.
    destruct X0.
    assert (Fin 0).
    apply (reverse0 (Build_SSubSet P x H0)).
    inversion H1.
    apply H0.
    apply X1.
    intros m P Q H K.
    intros.
    set (R:=fun x:X => (exists y:Fin n, (Seq (universe (X0 (Old y))) x))).
    assert (isSFunction X PropSetoid R).
    intros x y J.
    split; unfold R;
    intuition.
    destruct H0.
    exists x0.
    apply Seq_trans with (y:=x).
    apply SetoidProof with (s:=X).
    auto.
    auto.
    destruct H0.
    exists x0.
    apply Seq_trans with (y:=y).
    apply SetoidProof with (s:=X).
    auto.
    apply Seq_sym.
    apply SetoidProof with (s:=X).
    auto.
    set (R':=(Build_SFunction H0):SPredSetoid).
    assert (Disjoint R' Q).
    intro.
    simpl.
    split.
    intros.
    destruct (H x).
    apply H2.
    simpl.
    unfold R in *.
    intuition.
    destruct H4.
    destruct (SFunctionProof P _ _ (Seq_sym (SetoidProof X) _ _ H1)).
    apply H6.
    destruct (X0 (Old x0)).
    apply sub0.
    tauto.
    assert (has_FiniteCardinality n (SubSetoid R')).
    set (f:=(fun a=>(Build_SSubSet R' (universe (X0 (Old a))) (ex_intro
    (fun y=>Seq (s:=X) (universe (X0 (Old y))) (universe (X0 (Old a))))
    a (Seq_refl (SetoidProof X) (universe (X0 (Old a))))))):(Fin n) -> (SubSetoid R')).
    assert (forall x, R' x -> P x).
    intros.
    destruct H2.
    destruct (SFunctionProof P _ _ H2).
    apply H3.
    destruct (X0 (Old x0)).
    apply sub0.
    assert (forall x:SubSetoid R', {y:Fin n | Seq (universe (X0 (Old y))) (universe x)}).
    intros.
    set (y:=(reverse X0 (Build_SSubSet P _ (H2 _ (sub x))))).
    cut (y=y).
    pattern y at -1.
    elim y using FinOldOrNew.
    intros.
    exists y0.
    rewrite <- H3.
    unfold y.
    destruct (SBijectionProof X0).
    simpl in *.
    apply right_inverse0
     with (y:=Build_SSubSet P (universe x) (H2 (universe x) (sub x))).
    intros.
    unfold y in H3.
    destruct x.
    simpl in *.
    unfold R in sub0.
    apply False_rect.
    elim sub0.
    intros.
    assert (P (universe (X0 (Old x)))).
    destruct (X0 (Old x)).
    apply sub1.
    assert (Old x=New n).
    transitivity (reverse X0 (X0 (Old x))).
    destruct (SBijectionProof X0).
    simpl in *.
    symmetry.
    apply left_inverse0.
    rewrite <- H3.
    apply (SFunctionProof (reverse X0)).
    simpl.
    unfold SSubSet_eq.
    simpl.
    apply H4.
    inversion H6.
    reflexivity.
    set (g:=(fun (x:SubSetoid R') => (proj1_sig (X2 x)))).
    assert (isSFunction (TypeSetoid (Fin n)) _ f).
    intros x y J.
    rewrite J.
    apply Seq_refl.
    apply SetoidProof.
    assert (isSFunction _ (TypeSetoid (Fin n)) g).
    intros x y J.
    destruct x.
    destruct y.
    unfold g.
    simpl in *.
    destruct (X2 (Build_SSubSet R' universe0 sub0)).
    destruct (X2 (Build_SSubSet R' universe1 sub1)).
    unfold SSubSet_eq in J.
    simpl in *.
    assert (Old x=Old x0).
    destruct (SBijectionProof X0).
    simpl in *.
    rewrite <- (left_inverse0 (Old x)).
    rewrite <- (left_inverse0 (Old x0)).
    apply (SFunctionProof (reverse X0)).
    simpl.
    unfold SSubSet_eq.
    apply Seq_trans with (y:=universe0).
    apply SetoidProof with (s:=X).
    assumption.
    apply Seq_trans with (y:=universe1).
    apply SetoidProof with (s:=X).
    assumption.
    apply Seq_sym.
    apply SetoidProof with (s:=X).
    assumption.
    inversion H4.
    apply inj_right_pair2 with (P:=(fun n : nat => Fin n)).
    apply eq_nat_dec.
    assumption.
    exists (Build_SFunction H3) (Build_SFunction H4).
    split; simpl;
    intros.
    unfold g.
    destruct (X2 (f x)).
    simpl in *.
    assert (Old x=Old x0).
    destruct (SBijectionProof X0).
    simpl in *.
    rewrite <- (left_inverse0 (Old x)).
    rewrite <- (left_inverse0 (Old x0)).
    apply (SFunctionProof (reverse X0)).
    simpl.
    unfold SSubSet_eq.
    apply Seq_sym.
    apply SetoidProof with (s:=X).
    assumption.
    symmetry.
    inversion H5.
    apply inj_right_pair2 with (P:=(fun n : nat => Fin n)).
    apply eq_nat_dec.
    assumption.
    unfold SSubSet_eq.
    simpl.
    clear f H3 H4.
    unfold g.
    destruct (X2 y).
    simpl.
    assumption.
    assert (forall x : X, (SPredUnion R' Q x) -> {R' x}+{Q x}).
    intros.
    assert (SPredUnion P Q x).
    destruct H2.
    left.
    destruct H2.
    destruct (SFunctionProof P _ _ H2).
    apply H3.
    destruct (X0 (Old x0)).
    apply sub0.
    right.
    assumption.
    destruct (K _ H3).
    left.
    cut ((reverse X0 (Build_SSubSet P x m0))=(reverse X0 (Build_SSubSet P x m0))).
    pattern (reverse X0 (Build_SSubSet P x m0)) at -1.
    elim (reverse X0 (Build_SSubSet P x m0)) using FinOldOrNew.
    intros.
    exists y.
    rewrite <- H4.
    destruct (SBijectionProof X0).
    apply (right_inverse0 (Build_SSubSet P x m0)).
    intros.
    simpl in H2.
    destruct H2.
    destruct H2.
    assert ((Old x0)=(New n)).
    rewrite <- H4.
    replace (Old x0) with (reverse X0 (X0 (Old x0))).
    apply (SFunctionProof (reverse X0)).
    apply H2.
    destruct (SBijectionProof X0).
    apply (left_inverse0).
    inversion H5.
    destruct (H x).
    elim H5.
    simpl.
    auto.
    reflexivity.
    auto.
    rename X3 into K1.
    destruct (IHn _ _ _ H1 K1 X2 X1).
    simpl.
    assert (forall x, (SPredUnion R' Q x) -> (SPredUnion P Q x)).
    intros.
    destruct H2.
    left.
    destruct H2.
    destruct (SFunctionProof P _ _ H2).
    apply H3.
    destruct (X0 (Old x0)).
    apply sub0.
    right.
    apply H2.
    assert (forall x, P x -> (SPredUnion P Q x)).
    intros.
    left.
    apply H3.
    set (f:= (fun x =>
    match (FinEqOldOrNew x) with
    |inleft z => (Build_SSubSet _ _ (H2 _ (sub (forward0 (proj1_sig z)))))
    |inright _ => (Build_SSubSet _ _ (H3 _ (sub (X0 (New n)))))
    end)
     :(TypeSetoid (Fin (S (n+m))))->(SubSetoid (SPredUnion P Q))).
    assert (forall (x:SubSetoid (SPredUnion P Q)),
     {(SPredUnion R' Q (universe x))}+
     {(Seq (universe (X0 (New n))) (universe x))}).
    intros.
    destruct x.
    destruct (K _ sub0).
    destruct (FinEqOldOrNew (reverse X0 (Build_SSubSet P _ m0))).
    left.
    left.
    destruct s.
    exists x.
    rewrite <- e.
    apply (right_inverse (SBijectionProof X0) (Build_SSubSet P _ m0)).
    right.
    rewrite <- e.
    apply (right_inverse (SBijectionProof X0) (Build_SSubSet P _ m0)).
    left.
    right.
    apply m0.
    set (g:=(fun x=>
    match (X3 x) with
    |left p => Old (reverse0 (Build_SSubSet _ _ p))
    |right _ => New _
    end):(SubSetoid (SPredUnion P Q) -> TypeSetoid (Fin (S (n + m))))).
    assert (isSFunction _ _ f).
    intros x y J.
    simpl in *.
    rewrite J.
    apply Seq_refl.
    apply SetoidProof with (s:=(SubSetoid (SPredUnion P Q))).
    assert (isSFunction _ _ g).
    intros x y J.
    simpl in *.
    unfold SSubSet_eq in J.
    unfold g.
    destruct (X3 x);
    destruct (X3 y).
    replace (reverse0 (Build_SSubSet (SPredUnion R' Q) (universe x) o))
    with (reverse0 (Build_SSubSet (SPredUnion R' Q) (universe y) o0)).
    reflexivity.
    apply (SFunctionProof reverse0).
    apply Seq_sym.
    apply SetoidProof.
    apply J.
    apply False_ind.
    destruct o.
    destruct H5.
    assert ((Old x0)=(New n)).
    rewrite <- (left_inverse (SBijectionProof X0) (Old x0)).
    rewrite <- (left_inverse (SBijectionProof X0) (New n)).
    apply (SFunctionProof (reverse X0)).
    change (Seq (s:=X) (universe (X0 (Old x0))) (universe (X0 (New n)))).
    eapply (Seq_trans (SetoidProof X)).
    apply H5.
    eapply (Seq_trans (SetoidProof X)).
    apply J.
    apply Seq_sym.
    apply SetoidProof.
    assumption.
    discriminate H6.
    assert (P (universe x)).
    destruct (SFunctionProof P (universe x) (universe (X0 (New n)))).
    eapply (Seq_trans (SetoidProof X)).
    apply J.
    apply Seq_sym.
    apply SetoidProof.
    assumption.
    apply H7.
    destruct (X0 (New n)).
    assumption.
    destruct (H (universe x)).
    apply H7.
    simpl.
    auto.
    apply False_ind.
    destruct o.
    destruct H5.
    assert ((Old x0)=(New n)).
    rewrite <- (left_inverse (SBijectionProof X0) (Old x0)).
    rewrite <- (left_inverse (SBijectionProof X0) (New n)).
    apply (SFunctionProof (reverse X0)).
    change (Seq (s:=X) (universe (X0 (Old x0))) (universe (X0 (New n)))).
    eapply (Seq_trans (SetoidProof X)).
    apply H5.
    apply Seq_sym.
    apply SetoidProof.
    eapply (Seq_trans (SetoidProof X)).
    apply s.
    assumption.
    discriminate H6.
    assert (P (universe y)).
    destruct (SFunctionProof P (universe y) (universe (X0 (New n)))).
    eapply (Seq_trans (SetoidProof X)).
    apply Seq_sym.
    apply SetoidProof.
    apply J.
    apply Seq_sym.
    apply SetoidProof.
    assumption.
    apply H7.
    destruct (X0 (New n)).
    assumption.
    destruct (H (universe y)).
    apply H7.
    simpl.
    auto.
    reflexivity.
    exists (Build_SFunction H4) (Build_SFunction H5).
    split;
    intros;
    simpl in *.
    unfold f.
    destruct (FinEqOldOrNew x); simpl.
    destruct s; simpl.
    set (y:=(Build_SSubSet (SPredUnion P Q) (universe (forward0 x0))
         (H2 (universe (forward0 x0)) (sub (forward0 x0))))).
    unfold g.
    destruct (X3 y).
    simpl.
    rewrite e.
    replace (reverse0 (Build_SSubSet (SPredUnion R' Q) (universe (forward0 x0)) o)) with x0.
    reflexivity.
    transitivity (reverse0 (forward0 x0)).
    symmetry.
    apply (left_inverse SBijectionProof0).
    apply (SFunctionProof reverse0).
    simpl.
    unfold SSubSet_eq.
    simpl.
    apply Seq_refl.
    apply SetoidProof.
    simpl in s.
    destruct (forward0 x0).
    simpl in *.
    elim sub0.
    intros.
    destruct H6.
    assert ((New n)=(Old x1)).
    rewrite <- (left_inverse (SBijectionProof X0)).
    rewrite <- (left_inverse (SBijectionProof X0) (New n)).
    apply (SFunctionProof (reverse X0)).
    simpl.
    unfold SSubSet_eq.
    eapply (Seq_trans (SetoidProof X)).
    apply s.
    apply Seq_sym.
    apply SetoidProof.
    assumption.
    discriminate H7.
    intros.
    destruct (H universe0).
    elim H7.
    split.
    destruct (SFunctionProof P _ _ s).
    apply H9.
    apply sub.
    assumption.
    set (y:=(Build_SSubSet (SPredUnion P Q) (universe (X0 (New n)))
         (H3 (universe (X0 (New n))) (sub (X0 (New n)))))).
    unfold g.
    destruct (X3 y).
    simpl in o.
    apply False_ind.
    destruct o.
    destruct H6.
    assert ((Old x0)=(New n)).
    rewrite <- (left_inverse (SBijectionProof X0)).
    rewrite <- (left_inverse (SBijectionProof X0) (Old x0)).
    apply (SFunctionProof (reverse X0)).
    apply H6.
    discriminate H7.
    destruct (X0 (New n)).
    simpl in *.
    destruct (H universe0).
    apply H7.
    simpl.
    auto.
    auto.
    unfold SSubSet_eq.
    unfold g.
    destruct (X3 y).
    set (x:=(Old (reverse0 (Build_SSubSet (SPredUnion R' Q) (universe y) o)))).
    unfold f.
    destruct (FinEqOldOrNew x).
    destruct s.
    simpl in *.
    unfold x in e.
    inversion e.
    replace x0 with (reverse0 (Build_SSubSet (SPredUnion R' Q) (universe y) o)).
    apply (right_inverse (SBijectionProof0) (Build_SSubSet (SPredUnion R' Q) _ o)).
    apply (inj_right_pair2 (eq_nat_dec) H7).
    discriminate e.
    unfold f.
    destruct (FinEqOldOrNew (New (n + m))).
    destruct s0.
    discriminate e.
    assumption.
    Qed.
    Lemma EmptyCardinality : has_FiniteCardinality 0 (SubSetoid SPredEmpty).
    Proof.
    unfold has_FiniteCardinality.
    assert ((TypeSetoid (Fin 0)) -> (SubSetoid SPredEmpty)).
    simpl.
    intros.
    inversion H.
    assert ((SubSetoid SPredEmpty) -> (TypeSetoid (Fin 0))).
    simpl.
    intros.
    destruct X1.
    destruct sub0.
    assert (isSFunction _ _ X0).
    intros x.
    inversion x.
    assert (isSFunction _ _ X1).
    intros x.
    destruct x.
    destruct sub0.
    apply Build_SBijection with (Build_SFunction H) (Build_SFunction H0).
    constructor.
    intros.
    inversion x.
    intros.
    destruct y.
    destruct sub0.
    Qed.
    Lemma FullBijection : SBijSetoid X (SubSetoid SPredFull).
    Proof.
    set (f:= fun x:X => (Build_SSubSet SPredFull x I):(SubSetoid SPredFull)).
    set (g:= @universe SPredFull).
    assert (isSFunction _ _ f).
    intros x y H.
    apply H.
    assert (isSFunction (SubSetoid SPredFull) _ g).
    intros x y H0.
    apply H0.
    exists (Build_SFunction H) (Build_SFunction H0).
    split;
    simpl.
    intros.
    apply Seq_refl.
    apply SetoidProof.
    intros.
    unfold f, g.
    simpl.
    destruct y.
    simpl.
    dependent inversion sub0.
    apply Seq_refl.
    apply SetoidProof with (s:=(SubSetoid SPredFull)).
    Qed.
    End SPredicate.
    Record isGroup (X:Setoid) (P:SPredicate (SAutoSetoid X)) : Prop := {
    has_id : (P (SBijId X));
    closed_inv : forall x, (P x) -> (P (SBijInverse x));
    closed_compose : forall x y, (P x) -> (P y) -> (P (SBijCompose x y))
    }.
    Record Group : Type := {
    objects : Setoid;
    action : SPredicate (SAutoSetoid objects);
    groupProof : isGroup action
    }.
    Coercion GroupUniverse (G:Group) := SubSetoid (action G).
    Section GroupOperations.
    Variable G:Group.
    Definition GroupInverse (x:G) : G.
    intros.
    exists (SBijInverse (universe x)).
    elim (GroupUniverse G).
    intros.
    destruct G.
    destruct action0.
    simpl in *.
    case groupProof0; intros.
    apply closed_inv0.
    destruct x.
    simpl in *.
    auto.
    Defined.
    Definition GroupOp (x y:G) : G.
    intros.
    exists (SBijCompose (universe x) (universe y)).
    elim (GroupUniverse G).
    intros.
    destruct G.
    destruct action0.
    simpl in *.
    case groupProof0; intros.
    apply closed_compose0.
    destruct x.
    auto.
    destruct y.
    auto.
    Defined.
    Definition GroupId : G.
    exists (SBijId (objects G)).
    apply (has_id (groupProof G)).
    Defined.
    Lemma GroupInvMorph : forall x y, (Seq x y) -> (Seq (GroupInverse x) (GroupInverse y)).
    Proof.
    intros.
    simpl.
    apply SBijInverseMorph.
    apply H.
    Qed.
    Lemma GroupOpMorph1 : forall x y z, (Seq x y) -> (Seq (GroupOp x z) (GroupOp y z)).
    Proof.
    intros.
    simpl.
    apply SBijComposeMorph1.
    apply H.
    Qed.
    Lemma GroupOpMorph2 : forall x y z, (Seq x y) -> (Seq (GroupOp z x) (GroupOp z y)).
    Proof.
    intros.
    simpl.
    apply SBijComposeMorph2.
    apply H.
    Qed.
    Lemma GroupOpMorph : forall a b c d, (Seq a b) -> (Seq c d) -> (Seq (GroupOp a c) (GroupOp b d)).
    Proof.
    intros.
    simpl.
    apply SBijComposeMorph; auto.
    Qed.
    Lemma GroupEq_refl : forall (a:G), (Seq a a).
    Proof.
    intros.
    apply Seq_refl.
    apply SetoidProof.
    Qed.
    Lemma GroupEq_sym : forall (a b:G), (Seq a b) -> (Seq b a).
    Proof.
    intros.
    apply Seq_sym.
    apply SetoidProof.
    assumption.
    Qed.
    Lemma GroupEq_trans : forall (a b c:G), (Seq a b) -> (Seq b c) -> (Seq a c).
    Proof.
    intros.
    apply Seq_trans with (y:=b); try assumption.
    apply SetoidProof with (s:=G).
    Qed.
    Lemma GroupIdLeft : forall (a:G), (Seq (GroupOp GroupId a) a).
    Proof.
    intros.
    intros x.
    simpl.
    apply Seq_refl.
    apply SetoidProof.
    Qed.
    Lemma GroupIdRight : forall (a:G), (Seq (GroupOp a GroupId) a).
    Proof.
    intros.
    intros x.
    simpl.
    apply Seq_refl.
    apply SetoidProof.
    Qed.
    Lemma GroupInvLeft : forall a, (Seq (GroupOp (GroupInverse a) a) GroupId).
    Proof.
    intros.
    intros x.
    simpl.
    destruct (SBijectionProof (universe a)).
    auto.
    Qed.
    Lemma GroupInvRight : forall a, (Seq (GroupOp a (GroupInverse a)) GroupId).
    Proof.
    intros.
    intros x.
    simpl.
    destruct (SBijectionProof (universe a)).
    auto.
    Qed.
    Lemma GroupOpAssoc : forall a b c, (Seq (GroupOp (GroupOp a b) c) (GroupOp a (GroupOp b c))).
    Proof.
    intros.
    intros x.
    simpl.
    apply Seq_refl.
    apply SetoidProof.
    Qed.
    Lemma GroupOpAssocBack : forall a b c, (Seq (GroupOp a (GroupOp b c)) (GroupOp (GroupOp a b) c)).
    Proof.
    intros.
    intros x.
    simpl.
    apply Seq_refl.
    apply SetoidProof.
    Qed.
    Lemma GroupCancelLeft : forall a b c, (Seq (GroupOp a b) (GroupOp a c)) -> (Seq b c).
    Proof.
    intros.
    apply GroupEq_trans with (GroupOp GroupId b).
    apply GroupEq_sym.
    apply GroupIdLeft.
    apply GroupEq_trans with (GroupOp GroupId c).
    apply GroupEq_trans with (GroupOp (GroupOp (GroupInverse a) a) b).
    apply GroupOpMorph1.
    apply GroupEq_sym.
    apply GroupInvLeft.
    apply GroupEq_trans with (GroupOp (GroupOp (GroupInverse a) a) c).
    eapply GroupEq_trans.
    apply GroupOpAssoc.
    eapply GroupEq_trans.
    apply GroupOpMorph2.
    apply H.
    apply GroupOpAssocBack.
    apply GroupOpMorph1.
    apply GroupInvLeft.
    apply GroupIdLeft.
    Qed.
    Lemma GroupCancelRight : forall a b c, (Seq (GroupOp b a) (GroupOp c a)) -> (Seq b c).
    Proof.
    intros.
    apply GroupEq_trans with (GroupOp b GroupId).
    apply GroupEq_sym.
    apply GroupIdRight.
    apply GroupEq_trans with (GroupOp c GroupId).
    apply GroupEq_trans with (GroupOp b (GroupOp a (GroupInverse a))).
    apply GroupOpMorph2.
    apply GroupEq_sym.
    apply GroupInvRight.
    apply GroupEq_trans with (GroupOp c (GroupOp a (GroupInverse a))).
    eapply GroupEq_trans.
    apply GroupOpAssocBack.
    eapply GroupEq_trans.
    apply GroupOpMorph1.
    apply H.
    apply GroupOpAssoc.
    apply GroupOpMorph2.
    apply GroupInvRight.
    apply GroupIdRight.
    Qed.
    End GroupOperations.
    Record is_GroupHomomorphism (G H:Group) (f:SFunSetoid H G) : Prop := {
    preserve_inv : forall x:H, Seq (f (GroupInverse x)) (GroupInverse (f x));
    preserve_compose : forall (x y:H), Seq (f (GroupOp x y)) (GroupOp (f x) (morphism f y))
    }.
    Lemma preserve_id : forall (G H:Group) (f:SFunSetoid H G),
    is_GroupHomomorphism f -> Seq (f (GroupId H)) (GroupId G).
    Proof.
    intros.
    apply GroupEq_trans with (f (GroupOp (GroupId H) (GroupInverse (GroupId H)))).
    destruct f.
    apply SFunctionProof0.
    apply GroupEq_sym.
    apply GroupInvRight.
    apply GroupEq_trans with (GroupOp (f (GroupId H)) (GroupInverse (f (GroupId H)))).
    eapply GroupEq_trans.
    apply (preserve_compose H0).
    apply GroupOpMorph2.
    apply (preserve_inv H0).
    apply GroupInvRight.
    Qed.
    Record GroupHomomorphism (H G:Group) : Type := {
    homomorphism :> SFunSetoid H G;
    homomorphismProof : is_GroupHomomorphism homomorphism
    }.
    Definition GroupHomoFunClass (H G:Group) (f:GroupHomomorphism H G) (x:H) := (morphism (homomorphism f) x).
    Coercion GroupHomoFunClass : GroupHomomorphism >-> Funclass.
    Definition Coset (G H:Group) (f:GroupHomomorphism H G) (x:G) : SPredSetoid G.
    intros.
    apply (@Build_SFunction G PropSetoid (fun y => exists h:H, Seq (GroupOp (f h) x) y)).
    intros a b H0.
    simpl in *.
    unfold Prop_eq.
    split.
    intro.
    destruct H1.
    exists x0.
    apply Seq_trans with (y:=(universe a)); try assumption.
    apply SetoidProof with (s:=SBijSetoid (objects G) (objects G)).
    intro.
    destruct H1.
    exists x0.
    apply Seq_trans with (y:=(universe b)); try assumption.
    apply SetoidProof with (s:=SBijSetoid (objects G) (objects G)).
    apply Seq_sym.
    apply SetoidProof with (s:=SBijSetoid (objects G) (objects G)).
    assumption.
    Defined.
    Lemma CosetRefl : forall H G, forall (f:GroupHomomorphism H G), forall x, (morphism (Coset f x) x).
    intros.
    simpl.
    exists (GroupId H).
    change (Seq (GroupOp (f (GroupId H)) x) x).
    eapply GroupEq_trans with (GroupOp (GroupId G) x).
    apply GroupOpMorph1.
    apply preserve_id with (f:=(homomorphism f)).
    apply homomorphismProof.
    apply GroupIdLeft.
    Qed.
    Lemma CosetSym : forall H G, forall (f:GroupHomomorphism H G), forall x y, (morphism (Coset f x) y) -> (morphism (Coset f y) x).
    intros.
    simpl.
    destruct H0.
    exists (GroupInverse x0).
    change (Seq (GroupOp (f (GroupInverse x0)) y) x).
    eapply GroupEq_trans.
    apply GroupOpMorph2.
    apply GroupEq_sym.
    apply H0.
    eapply GroupEq_trans.
    apply GroupOpAssocBack.
    eapply GroupEq_trans.
    apply GroupOpMorph1.
    apply GroupEq_sym.
    apply (preserve_compose (homomorphismProof f) (GroupInverse x0) x0).
    eapply GroupEq_trans.
    apply GroupOpMorph1.
    apply (SFunctionProof (homomorphism f)) with (x:=(GroupOp(GroupInverse x0) x0)) (y:=GroupId H).
    apply GroupInvLeft.
    eapply GroupEq_trans.
    eapply GroupOpMorph1.
    apply preserve_id.
    apply homomorphismProof.
    apply GroupIdLeft.
    Qed.
    Record FiniteGroup : Type := {
    group :> Group;
    order : nat;
    size : has_FiniteCardinality order (SubSetoid (action group))
    }.
    Lemma FinGroupDecideEquality : forall (G:FiniteGroup), forall (x y:G), {Seq x y}+{~Seq x y}.
    Proof.
    intros.
    destruct (size G).
    destruct SBijectionProof0.
    destruct (FinDecideEquality (reverse0 x) (reverse0 y)).
    left.
    simpl in *.
    apply Seq_trans with (y:=(universe (forward0 (reverse0 x)))).
    apply SetoidProof with (s:=SBijSetoid (objects G) (objects G)).
    apply Seq_sym.
    apply SetoidProof with (s:=SBijSetoid (objects G) (objects G)).
    apply right_inverse0.
    rewrite e.
    apply right_inverse0.
    right.
    intro.
    apply n.
    simpl in *.
    destruct reverse0.
    unfold isSFunction in *.
    simpl in *.
    apply SFunctionProof0.
    assumption.
    Qed.
    Inductive sumT (A B:Type) : Type :=
    | leftT : A -> sumT A B
    | rightT : B -> sumT A B.
    Definition SetoidJoin_eq (X Y:Setoid) (x y:sumT X Y) : Prop.
    intros.
    destruct x;
    destruct y.
    exact (Seq s s0).
    exact False.
    exact False.
    exact (Seq s s0).
    Defined.
    Definition SetoidJoin (X Y:Setoid) : Setoid.
    intros.
    exists (sumT X Y) (SetoidJoin_eq X Y).
    split; intro x; intros.
    destruct x.
    simpl.
    apply Seq_refl.
    apply SetoidProof.
    simpl.
    apply Seq_refl.
    apply SetoidProof.
    destruct x; destruct y; try elim H; simpl in *;
    (apply Seq_sym;[apply SetoidProof|apply H]).
    destruct x; destruct y; destruct z; try elim H; try elim H0; simpl in *.
    (apply Seq_trans with (y:= s0);[apply SetoidProof with (s:=X)|apply H|apply H0]).
    (apply Seq_trans with (y:= s0);[apply SetoidProof with (s:=Y)|apply H|apply H0]).
    Defined.
    Lemma FinGroupForallOrExist : forall (G:FiniteGroup) (P Q:SPredSetoid G), (forall x, {morphism P x}+{morphism Q x}) -> sumT (sigT (fun x => morphism P x)) (forall x, morphism Q x).
    Proof.
    intros.
    destruct (size G).
    destruct SBijectionProof0.
    set (P':=(fun a => morphism P (forward0 a))).
    set (Q':=(fun a => morphism Q (forward0 a))).
    destruct (FinForallOrExist P' Q').
    intros a.
    unfold P', Q'.
    apply X.
    left.
    destruct s.
    exists (forward0 x).
    unfold P' in p.
    apply p.
    right.
    intros.
    unfold Q' in q.
    destruct Q.
    unfold isSFunction in SFunctionProof0.
    simpl in *.
    assert (Prop_eq (morphism0 x) (morphism0 (forward0 (reverse0 x)))).
    apply SFunctionProof0.
    apply Seq_sym.
    apply SetoidProof with (s:=SBijSetoid (objects G) (objects G)).
    apply right_inverse0.
    destruct H.
    auto.
    Qed.
    Section Lagrange.
    Variable G H:FiniteGroup.
    Variable subgroup:GroupHomomorphism H G.
    Hypothesis subgroupProof:forall x y, (Seq (subgroup x) (subgroup y)) -> (Seq x y).
    Lemma CosetLemma1 : forall x y,
    sumT (sigT (fun h:H => Seq (GroupOp (subgroup h) x) y))
    (forall h, ~(Seq (GroupOp (subgroup h) x) y)).
    Proof.
    intros.
    set (P:=(fun h=>Seq (s:=G) (GroupOp (subgroup h) x) y)).
    set (Q:=(fun h=>~P h)).
    change (sumT (sigT P) (forall h, Q h)).
    assert (isSFunction H PropSetoid P).
    intros a b I.
    unfold P.
    split.
    intros.
    apply Seq_trans with (y:= (GroupOp (subgroup a) x)).
    apply SetoidProof with (s:=G).
    apply GroupOpMorph1.
    apply (SFunctionProof (homomorphism subgroup)) with (x:=b) (y:=a).
    apply GroupEq_sym.
    assumption.
    assumption.
    intros.
    apply Seq_trans with (y:= (GroupOp (subgroup b) x)).
    apply SetoidProof with (s:=G).
    apply GroupOpMorph1.
    apply (SFunctionProof (homomorphism subgroup)) with (x:=a) (y:=b).
    assumption.
    assumption.
    assert (isSFunction H PropSetoid Q).
    intros a b I.
    unfold Q.
    destruct (H0 a b I).
    simpl.
    unfold Prop_eq.
    tauto.
    set (P' := Build_SFunction H0).
    set (Q' := Build_SFunction H1).
    destruct (FinGroupForallOrExist H P' Q').
    intros.
    simpl.
    unfold Q, P.
    apply (FinGroupDecideEquality).
    left.
    destruct s.
    exists x0.
    apply m.
    right.
    simpl in *.
    intros.
    apply (m h).
    Qed.
    Lemma CosetsIso : forall x, SBijection (SubSetoid (Coset subgroup x)) H.
    Proof.
    intros x.
    set (f := (fun h:H => (GroupOp (subgroup h) x)) : H->G).
    assert (forall h, (morphism (Coset subgroup x) (f h))).
    intros.
    simpl.
    exists h.
    unfold f.
    apply Seq_refl.
    apply SetoidProof with (s:=(SAutoSetoid (objects G))).
    set (f':=(fun h:H=>(Build_SSubSet (Coset subgroup x) _ (H0 h)))).
    assert (forall (y:G) (p:morphism (Coset subgroup x) y), sigT (fun h=> Seq (GroupOp (subgroup h) x) y)).
    intros.
    destruct (CosetLemma1 x y).
    assumption.
    unfold Coset in p.
    simpl in *.
    (*******************************************)
    (*Notice that destruct p doesn't work here *)
    (*******************************************)
    apply False_rect.
    destruct p.
    apply (n x0).
    apply H1.
    set (g':=fun (y:(SubSetoid (Coset subgroup x)))=>(projT1 (X (universe y) (sub y)))).
    assert (isSFunction H (SubSetoid (Coset subgroup x)) f').
    intros a b I.
    unfold f'.
    simpl.
    apply SBijComposeMorph1.
    apply (SFunctionProof (homomorphism subgroup)) with (x:=a) (y:=b).
    assumption.
    assert (isSFunction (SubSetoid (Coset subgroup x)) H g').
    intros a b I.
    unfold g'.
    destruct (X (universe a) (sub a)).
    destruct (X (universe b) (sub b)).
    simpl in *.
    apply subgroupProof.
    change (Seq (s:=G) (subgroup x0) (subgroup x1)).
    apply GroupCancelRight with x.
    eapply GroupEq_trans with (universe a).
    apply s.
    eapply GroupEq_trans with (universe b).
    assumption.
    apply GroupEq_sym.
    assumption.
    set (f'':=Build_SFunction H1).
    set (g'':=Build_SFunction H2).
    assert (isSBijection g'' f'').
    split.
    intros.
    simpl.
    unfold g'.
    destruct (X (universe x0) (sub x0)).
    simpl.
    apply s.
    intros.
    simpl.
    unfold g', f'.
    simpl.
    destruct (X (f y) (H0 y)).
    simpl in *.
    apply subgroupProof.
    change (Seq (s:=G) (subgroup x0) (subgroup y)).
    apply GroupCancelRight with x.
    apply s.
    apply (Build_SBijection X0).
    Qed.
    Lemma CosetsSize : forall x, has_FiniteCardinality (order H) (SubSetoid (Coset subgroup x)).
    Proof.
    intros.
    unfold has_FiniteCardinality.
    eapply SBijCompose with (X:=(TypeSetoid (Fin (order H))))
                           (Y:=H)
                           (Z:=(SubSetoid (Coset subgroup x))).
    apply SBijInverse.
    apply (CosetsIso x).
    apply (size H).
    Qed.
    Lemma CosetsDisjoint : forall x y, {Disjoint (Coset subgroup x) (Coset subgroup y)}+{Seq (Coset subgroup x) (Coset subgroup y)}.
    Proof.
    intros.
    destruct (CosetLemma1 x y).
    right.
    destruct s.
    split; simpl; intros;
    destruct H0.
    exists (GroupOp x2 (GroupInverse x0)).
    change (Seq (GroupOp (subgroup (GroupOp x2 (GroupInverse x0))) y) x1).
    eapply GroupEq_trans.
    apply GroupOpMorph1.
    destruct (homomorphismProof subgroup).
    eapply GroupEq_trans.
    apply (preserve_compose0 x2 (GroupInverse x0)).
    apply GroupOpMorph2.
    apply preserve_inv0.
    apply GroupEq_trans with (GroupOp (subgroup x2) x);[idtac |apply H0].
    eapply GroupEq_trans.
    apply GroupOpAssoc.
    apply GroupOpMorph2.
    apply GroupCancelLeft with (subgroup x0).
    eapply GroupEq_trans.
    apply GroupOpAssocBack.
    eapply GroupEq_trans.
    apply GroupOpMorph1.
    apply GroupInvRight.
    eapply GroupEq_trans.
    apply GroupIdLeft.
    apply GroupEq_sym.
    assumption.
    exists (GroupOp x2 x0).
    change (Seq (GroupOp (subgroup (GroupOp x2 x0)) x) x1).
    eapply GroupEq_trans.
    apply GroupOpMorph1.
    apply (preserve_compose (homomorphismProof subgroup) x2 x0).
    apply GroupEq_trans with (GroupOp (subgroup x2) y);[idtac |apply H0].
    eapply GroupEq_trans.
    apply GroupOpAssoc.
    apply GroupOpMorph2.
    assumption.
    left.
    unfold Disjoint.
    simpl.
    intro a.
    simpl.
    split.
    intros.
    (* problem with decompose record H0 here *)
    destruct H0.
    destruct H0.
    destruct H1.
    set (b:=(GroupOp (GroupInverse x1) x0)).
    apply (n b).
    unfold b.
    clear b.
    eapply GroupEq_trans.
    apply GroupOpMorph1.
    eapply GroupEq_trans.
    apply (preserve_compose (homomorphismProof subgroup) (GroupInverse x1) x0).
    apply GroupOpMorph1.
    apply (preserve_inv (homomorphismProof subgroup)).
    eapply GroupEq_trans.
    apply GroupOpAssoc.
    apply GroupCancelLeft with (subgroup x1).
    apply GroupEq_trans with a.
    eapply GroupEq_trans.
    apply GroupOpAssocBack.
    eapply GroupEq_trans.
    apply GroupOpMorph1.
    apply GroupInvRight.
    eapply GroupEq_trans.
    apply GroupIdLeft.
    apply H0.
    apply GroupEq_sym.
    apply H1.
    intros.
    destruct H0.
    Qed.
    Fixpoint CosetUnion (l:(list (Fin (order G)))) {struct l} : (SPredSetoid G) :=
    match l with
    | nil => (SPredEmpty G)
    | cons a m => SPredUnion (Coset subgroup ((size G) a)) (CosetUnion m)
    end.
    Lemma CosetUnionDisjoint : forall l x, {Disjoint (Coset subgroup x) (CosetUnion l)}+{Included (Coset subgroup x) (CosetUnion l)}.
    Proof.
    intros.
    induction l.
    simpl.
    left.
    unfold Disjoint.
    simpl.
    split;
    simpl;
    tauto.
    simpl.
    destruct IHl.
    destruct (CosetsDisjoint (size G a) x).
    left.
    unfold Disjoint in *.
    simpl in *.
    split;
    simpl.
    intros.
    destruct H0.
    destruct H1.
    destruct (d0 x0).
    clear H3.
    apply H2.
    split.
    apply H1.
    apply H0.
    destruct (d x0).
    apply H2.
    split.
    apply H0.
    apply H1.
    tauto.
    right.
    unfold Included.
    intros.
    simpl.
    simpl in s.
    destruct (s x0).
    destruct (H2 H0).
    simpl in x1.
    left.
    exists x1.
    apply H3.
    right.
    unfold Included in *.
    intros.
    simpl.
    right.
    apply i.
    apply H0.
    Qed.
    Lemma CosetUnionList : forall (l:(list (Fin (order G)))),
     forall x, In x l -> (morphism (CosetUnion l) ((size G) x)).
    Proof.
    intro.
    induction l; intros.
    destruct H0.
    destruct H0.
    subst a.
    simpl.
    left.
    exists (GroupId H).
    set (a:=(size G x)).
    change (Seq (GroupOp (subgroup (GroupId H)) a) a).
    eapply GroupEq_trans.
    apply GroupOpMorph1.
    apply (preserve_id) with (f:=(homomorphism subgroup)).
    apply homomorphismProof.
    apply GroupIdLeft.
    change (In x l) in H0.
    right.
    auto.
    Qed.
    Lemma AllCosetsFull : (Seq (SPredFull G) (CosetUnion (proj1_sig (FinList (order G))))).
    intro x.
    split; intros.
    destruct (SBijectionProof (size G)).
    simpl in *.
    set (f:=(CosetUnion (proj1_sig (FinList (order G))))).
    destruct (SFunctionProof f (forward (size G) (reverse (size G) x)) x).
    apply (right_inverse0 x).
    apply H1.
    unfold f.
    apply CosetUnionList.
    destruct (FinList (order G)).
    auto.
    constructor.
    Qed.
    Lemma BigPushTowardsEnd : forall (l:(list (Fin (order G)))),
     sigT (fun m:nat => has_FiniteCardinality (m*(order H)) (SubSetoid (CosetUnion l))).
    Proof.
    intros.
    induction l.
    exists 0.
    simpl.
    apply EmptyCardinality.
    destruct IHl.
    destruct (CosetUnionDisjoint l (size G a)).
    Focus 2.
    exists x.
    unfold has_FiniteCardinality in *.
    (* Focus 2 <-- Focus bug *)
    apply SBijCompose with (Y:=(SubSetoid (CosetUnion l)));
    [idtac | apply h].
    simpl.
    apply SPredEqBij.
    apply Seq_sym.
    apply SetoidProof.
    apply IncludedUnion.
    auto.
    exists (S x).
    simpl.
    apply DisjointFinite.
    assumption.
    intros.
    destruct (CosetLemma1 (size G a) x0).
    left.
    simpl.
    destruct s.
    exists x1.
    apply s.
    right.
    destruct H0.
    destruct H0.
    elim (n x1).
    assumption.
    assumption.
    apply CosetsSize.
    apply h.
    Qed.
    Definition divides a b := {c:nat | c*a=b}.
    Theorem Lagrange : divides (order H) (order G).
    Proof.
    destruct (BigPushTowardsEnd (proj1_sig (FinList (order G)))).
    exists x.
    apply FinBijEqual.
    apply (SBijCompose (X:=(TypeSetoid (Fin (x * order H))))
                        (Y:=G)
                        (Z:=(TypeSetoid (Fin (order G))))).
    apply SBijInverse.
    apply (size G).
    apply (SBijCompose (X:=(TypeSetoid (Fin (x * order H))))
    (Y:=(SubSetoid (SPredFull G)))
    (Z:=G)).
    apply SBijInverse.
    apply FullBijection.
    apply (SBijCompose (X:=(TypeSetoid (Fin (x * order H))))
    (Y:= (SubSetoid (CosetUnion (proj1_sig (FinList (order G))))))).
    simpl.
    apply SPredEqBij.
    apply Seq_sym.
    apply SetoidProof.
    apply AllCosetsFull.
    apply h.
    Qed.
    End Lagrange.
    Check Lagrange.

I wrote this on my vacation.

-- RussellOConnor
