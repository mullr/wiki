Here we consider a type to be finite if there is an iterator function which enumerates all its elements.

    Require Export RelationClasses.
    Set Implicit Arguments.
    Generalizable All Variables.
    Section iterator_reachability.
    (* Our convention for iterators follows the Lua approach:
       next None is the first element, and the iteration is done when
       it reaches None again. *)
    Variable X : Type.
    Variable next : option X -> option X.
    (* In this definition we forbid "wrapping around" from None back to
       next None; this has the advantage that we can avoid the duplicated proofs
       which would otherwise arise from
       next None ~~> next None by reaches_self
       next None ~~> next None by reaches_next from next None ~~> None. *)
    Inductive iteration_reaches (x:option X): option X -> Prop :=
      | iteration_reaches_self: iteration_reaches x x
      | iteration_reaches_next: forall y:X,
          iteration_reaches x (Some y) -> iteration_reaches x (next (Some y)).
    Inductive iteration_reaches_rev (y:option X): option X -> Prop :=
      | iteration_reaches_rev_self: iteration_reaches_rev y y
      | iteration_reaches_rev_next: forall x:X,
          iteration_reaches_rev y (next (Some x)) ->
          iteration_reaches_rev y (Some x).
    Global Instance iteration_reaches_refl: Reflexive iteration_reaches :=
      iteration_reaches_self.
    Global Instance iteration_reaches_trans: Transitive iteration_reaches.
    Proof.
    intros x y z.
    induction 2; auto using iteration_reaches.
    Qed.
    Global Instance iteration_reaches_rev_refl: Reflexive iteration_reaches_rev :=
      iteration_reaches_rev_self.
    Global Instance iteration_reaches_rev_trans: Transitive iteration_reaches_rev.
    Proof.
    intros x y z.
    induction 2; auto using iteration_reaches_rev.
    Qed.
    Lemma iteration_reaches_equiv: forall x y:option X,
      iteration_reaches x y <-> iteration_reaches_rev y x.
    Proof.
    split; induction 1; auto using iteration_reaches, iteration_reaches_rev.
    transitivity (Some y); auto using iteration_reaches_rev.
    transitivity (next (Some x)); auto using iteration_reaches.
    Qed.
    Lemma iteration_reaches_rev_from_next: forall x y:option X,
      iteration_reaches_rev y x -> x <> y -> iteration_reaches_rev y (next x).
    Proof.
    intros.
    destruct H.
    contradiction H0; reflexivity.
    trivial.
    (* need to leave this transparent so that the guardedness checker will
       know this is taking a subterm of the hypothesis *)
    Defined.
    End iterator_reachability.
    Class FiniteT_iterator (X:Type) (next:option X -> option X) : Prop :=
      reaches_all: forall x:option X, iteration_reaches next (next None) x.
    Definition iterator_fun `{FiniteT_iterator X next} := next.
    Infix "~~>" := (iteration_reaches iterator_fun) (at level 70).
    Infix "<~~" := (iteration_reaches_rev iterator_fun) (at level 70).
    Class FiniteT (X:Type) : Prop :=
      iterator_exists: exists next:option X -> option X,
        FiniteT_iterator next.
    Instance FiniteT_iterator_impl_FiniteT `{FiniteT_iterator X next} :
      FiniteT X.
    Proof.
    exists next; trivial.
    Qed.
    Definition empty_next: option Empty_set -> option Empty_set :=
      fun x:option Empty_set => match x with
      | Some e => match e with end
      | None => None
      end.
    Instance empty_finite_iter: FiniteT_iterator empty_next.
    Proof.
    red.
    destruct x as [[]|].
    simpl.
    constructor.
    Qed.
    Definition unit_next: option unit -> option unit :=
      fun x:option unit => match x with
      | Some tt => None
      | None => Some tt
      end.
    Instance unit_finite_iter: FiniteT_iterator unit_next.
    Proof.
    red.
    destruct x as [[]|].
    auto using iteration_reaches.
    pattern (@None unit) at 2;
    replace (@None unit) with (unit_next (unit_next None)) by reflexivity.
    constructor 2; constructor 1.
    Qed.
    Section FiniteT_iterator_properties.
    Context `{FiniteT_iterator X next}.
    Lemma all_reaches_None: forall x:option X, None <~~ x.
    Proof.
    intros.
    induction (reaches_all x).
    Require Import Setoid.
    rewrite <- iteration_reaches_equiv.
    apply reaches_all.
    apply iteration_reaches_rev_from_next.
    exact IHi.
    discriminate.
    Qed.
    (* Technical machinery: as we'll eventually see, the iterator actually
       induces a cycle permutation on option X.  Treating this cycle as Z/nZ
       with the base point at None, this next function will correspond to the
       subtraction function. *)
    Fixpoint iterator_sub (x y:option X) (Hreach0: None <~~ y)
      { struct Hreach0 } : option X.
    refine (
      match y as y' return (y=y'->_) with
      | Some y0 => fun _ => iterator_sub (next x) (next y) _
      | None => fun _ => x
      end (eq_refl _)).
    apply iteration_reaches_rev_from_next.
    exact Hreach0.
    congruence.
    Defined.
    (* auto-implicit is overzealous and makes y implicit... *)
    Implicit Arguments iterator_sub [].
    (* The following should be obvious, but aren't to the Coq machinery because
       it needs to know the top-level form of Hreach0 before it can do
       reductions... *)
    Lemma iterator_sub_base: forall (x:option X) (Hreach0: None <~~ None),
      iterator_sub x None Hreach0 = x.
    Proof.
    intro x.
    pose (none_copy := @None X).
    assert (none_copy = @None X) by reflexivity.
    pattern (@None X) at 2 3.
    rewrite <- H0.
    destruct Hreach0.
    simpl.
    reflexivity.
    discriminate H0.
    Qed.
    Lemma iterator_sub_rec: forall (x:option X) (y:X) (Hreach0: None <~~ Some y),
      exists Hreach0': None <~~ next (Some y),
      iterator_sub x (Some y) Hreach0 =
      iterator_sub (next x) (next (Some y)) Hreach0'.
    Proof.
    intros.
    dependent inversion Hreach0.
    eexists; reflexivity.
    Qed.
    Lemma iterator_sub_indep: forall (x y:option X)
      (Hreach0 Hreach0': None <~~ y),
      iterator_sub x y Hreach0 = iterator_sub x y Hreach0'.
    Proof.
    intros.
    revert x.
    generalize Hreach0; induction Hreach0.
    intros.
    repeat rewrite iterator_sub_base; trivial.
    intros.
    destruct (iterator_sub_rec x0 Hreach1) as [Hreach_next].
    destruct (iterator_sub_rec x0 Hreach0') as [Hreach_next'].
    rewrite H0; rewrite H1.
    apply IHHreach0.
    Qed.
    Lemma iterator_sub_commutes_with_next:
      forall (x y:option X) (Hreach0: None <~~ y),
        iterator_sub (next x) y Hreach0 = next (iterator_sub x y Hreach0).
    Proof.
    intros.
    revert x.
    generalize Hreach0.
    induction Hreach0.
    intros.
    repeat rewrite iterator_sub_base.
    trivial.
    intros.
    unfold iterator_fun in Hreach0 at 2.
    simpl in Hreach0.
    destruct (iterator_sub_rec (next x0) Hreach1) as [Hreach_next].
    destruct (iterator_sub_rec x0 Hreach1) as [Hreach_next'].
    rewrite H0; rewrite H1.
    rewrite IHHreach0.
    f_equal.
    apply iterator_sub_indep.
    Qed.
    Lemma iterator_sub_self: forall (x:option X) (Hreach0: None <~~ x),
      iterator_sub x x Hreach0 = None.
    Proof.
    intros.
    generalize Hreach0; induction Hreach0.
    intros.
    apply iterator_sub_base.
    intros.
    destruct (iterator_sub_rec (Some x) Hreach1) as [Hreach_next].
    rewrite H0.
    apply IHHreach0.
    Qed.
    Lemma commutes_with_next_impl_id: forall f:option X -> option X,
      f None = None -> (forall x:option X, f (next x) = next (f x)) ->
      forall x:option X, f x = x.
    Proof.
    intros.
    induction (reaches_all x); congruence.
    Qed.
    Definition prev (x:option X) := iterator_sub x (next None) (all_reaches_None _).
    Lemma prev_next: forall x:option X, prev (next x) = x.
    Proof.
    intros.
    apply commutes_with_next_impl_id with (f:=fun x => prev (next x)).
    apply iterator_sub_self.
    intros.
    unfold prev.
    apply iterator_sub_commutes_with_next.
    Qed.
    Lemma next_prev: forall x:option X, next (prev x) = x.
    Proof.
    intros.
    rewrite <- prev_next.
    unfold prev.
    symmetry; apply iterator_sub_commutes_with_next.
    Qed.
    Corollary next_injective: forall x y:option X, next x = next y -> x = y.
    Proof.
    intros.
    pose proof prev_next; congruence.
    Qed.
    Require Export EquivDec.
    (* Using the fact that None is distinguishable, along with the injectivity of next,
       we can work backwards to decide equality of any pair of iterators. *)
    Global Instance FiniteT_iterator_eq_dec: EqDec (option X) eq.
    refine (let eq_dec :=
      fix eq_dec (x y:option X) (Hreach0: None <~~ y) {struct Hreach0} :
      {x=y} + {x<>y} :=
      match x as x', y as y' return (x=x' -> y=y' -> {x'=y'} + {x'<>y'}) with
      | Some x0, Some y0 => fun _ _ =>
        match (eq_dec (next x) (next y) _) with
        | left _ => left _ _
        | right _ => right _ _
        end
      | Some x0, None => fun _ _ => right _ _
      | None, Some y0 => fun _ _ => right _ _
      | None, None => fun _ _ => left _ _
      end (eq_refl _) (eq_refl _) in
      fun x y => eq_dec x y (all_reaches_None y));
    try congruence.
    apply iteration_reaches_rev_from_next; trivial.
    congruence.
    apply next_injective in e; congruence.
    Defined.
    Global Instance FiniteT_iterator_eq_dec_base: EqDec X eq.
    red.
    refine (fun x y =>
    match (FiniteT_iterator_eq_dec (Some x) (Some y)) with
      | left _ => left _ _
      | right _ => right _ _
    end); congruence.
    Defined.
    Require Export List.
    Fixpoint iterator_to_list_aux (x:option X) (Hreach0: None <~~ x) : list X.
    refine (match x as x' return (x=x' -> list X) with
    | Some x0 => fun _ => cons x0 (iterator_to_list_aux (next x) _)
    | None => fun _ => nil
    end (eq_refl _)).
    apply iteration_reaches_rev_from_next; trivial.
    congruence.
    Defined.
    Implicit Arguments iterator_to_list_aux [].
    Lemma iterator_to_list_aux_base: forall Hreach0: None <~~ None,
      iterator_to_list_aux None Hreach0 = nil.
    Proof.
    pose (none_copy := @None X).
    assert (none_copy = None) by reflexivity.
    pattern (@None X) at 2 3; rewrite <- H0.
    destruct Hreach0.
    reflexivity.
    discriminate H0.
    Qed.
    Lemma iterator_to_list_aux_rec: forall (x:X) (Hreach0: None <~~ Some x),
      exists Hreach_next: None <~~ next (Some x),
        iterator_to_list_aux (Some x) Hreach0 =
        cons x (iterator_to_list_aux (next (Some x)) Hreach_next).
    Proof.
    intros.
    dependent inversion Hreach0.
    eexists; reflexivity.
    Qed.
    Definition iterator_to_list :=
      iterator_to_list_aux (next None) (all_reaches_None _).
    Lemma iterator_to_list_enumerates_all: forall x:X,
      In x iterator_to_list.
    Proof.
    assert (forall (x:option X) (Hreach0: None <~~ x) (y:X),
      (x ~~> Some y) -> In y (iterator_to_list_aux x Hreach0)).
    intros.
    rewrite iteration_reaches_equiv in H0.
    remember (Some y) as sy.
    revert y Heqsy.
    induction H0.
    intros.
    revert Hreach0.
    rewrite Heqsy.
    intros.
    destruct (iterator_to_list_aux_rec Hreach0) as [Hreach_next].
    rewrite H0.
    constructor.
    trivial.
    destruct (iterator_to_list_aux_rec Hreach0) as [Hreach_next].
    intros.
    rewrite H1.
    constructor 2.
    apply IHiteration_reaches_rev.
    trivial.
    intros.
    unfold iterator_to_list.
    apply H0.
    apply reaches_all.
    Qed.
    End FiniteT_iterator_properties.
    Recursive Extraction iterator_to_list.
    Section option_iterator.
    Context `{FiniteT_iterator X next}.
    (* Assuming next maps None -> Some x1 -> ... -> Some xn -> None,
       option_next maps None -> Some None -> Some (Some x1) -> ... ->
            Some (Some xn) -> None. *)
    Definition option_next: option (option X) -> option (option X) :=
      fun x:option (option X) => match x with
      | Some o => option_map Some (next o)
      | None => Some None
      end.
    Global Instance option_finite_iter: FiniteT_iterator option_next.
    Proof.
    red.
    assert (forall x:option X,
      iteration_reaches option_next (option_next None) (option_map Some x)).
    intros.
    induction (reaches_all x).
    simpl.
    replace (option_map Some (next None)) with (option_next (Some None))
      by reflexivity.
    auto using iteration_reaches.
    replace (option_map Some (next (Some y))) with (option_next (Some (Some y)))
      by reflexivity.
    auto using iteration_reaches.
    destruct x as [[x|]|].
    exact (H0 (Some x)).
    constructor 1.
    exact (H0 None).
    Qed.
    End option_iterator.
    Instance option_finite: forall `{FiniteT X}, FiniteT (option X).
    Proof.
    destruct 1; typeclasses eauto.
    Qed.
