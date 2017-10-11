    Require Image.
    Require Import List.
    Set Implicit Arguments.
    Fixpoint Fin (n:nat) : Set :=
    match n with
    | O => Empty_set
    | (S m) => (unit+(Fin m))%type
    end.
    Definition FinNew (n:nat) : Fin (S n) := inl (Fin n) tt.
    Definition FinOld (n:nat) (x:Fin n) : Fin (S n) := inr unit x.
    Implicit Arguments FinOld [n].
    Lemma FinO_rect : forall P:Type, Fin O -> P.
    Proof.
    destruct 1.
    Defined.
    Lemma FinSn_rect :
     forall n,
     forall (P:Fin (S n)->Type),
     (forall y:Fin n, P (FinOld y)) ->
     P (FinNew n) ->
     forall x, P x.
    Proof.
    intros n P H0 H1 [[]|]; auto.
    Defined.
    Lemma FinOldOrNew : forall n,
    forall y:Fin (S n),
    {z:Fin n | y=(FinOld z)}+{y=FinNew n}.
    Proof.
    intros n [[]|y]; auto.
    left.
    exists y; auto.
    Defined.
    Lemma FinOldInject : forall n, forall x y:Fin n, (FinOld x)=(FinOld y) -> x=y.
    Proof.
    intros n x y H.
    unfold FinOld in H.
    congruence.
    Qed.
    Hint Resolve FinOldInject : fin.
    Lemma FinDecideEquality : forall n, forall (x y:Fin n), {x=y}+{x<>y}.
    Proof.
    induction n.
    destruct x.
    simpl.
    intros [[]|x] [[]|y]; auto; try (right; discriminate).
    destruct (IHn x y).
    left; intuition; congruence.
    right; intuition; congruence.
    Defined.
    Lemma FinForallOrExist : forall n
    (P Q:Fin n->Prop),
    (forall x, {P x}+{Q x}) ->
    {x:Fin n | P x}+{forall x, Q x}.
    Proof.
    induction n.
    intros P Q H.
    right.
    destruct x.
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
    intros [[]|x]; firstorder.
    Defined.
    Definition FinList : forall n, {l:list (Fin n) | forall x, In x l}.
    intros.
    induction n.
    exists (@nil (Fin 0)).
    destruct x.
    destruct IHn.
    exists (cons (FinNew n) (map (@FinOld n) x)).
    intros [[]|y]; simpl; auto.
    right.
    change (In (FinOld y) (map (FinOld (n:=n)) x)).
    apply in_map; auto with *.
    Defined.
    Lemma FinInjectionInjection : forall n m, forall f:Fin (S n) -> Fin (S m), Image.injective _ _ f -> {g:Fin n -> Fin m | Image.injective _ _ g}.
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
    Lemma FinInjectionLt : forall n m, forall f:Fin n -> Fin m, Image.injective _ _ f -> n <= m.
    Proof.
    induction n; auto with *.
    destruct m.
    intro f.
    destruct (f (FinNew n)).
    intros f H.
    apply Le.le_n_S.
    destruct (FinInjectionInjection H).
    firstorder.
    Qed.
