This extends [Eqdep\_dec](http://coq.inria.fr/library/Coq.Logic.Eqdep_dec.html) to work on predicates over Type

    Require Export Eqdep_dec.
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
      (K_dec_Type _
         (fun x0 y : A =>
          match H x0 y with
          | left e =>
              eq_ind x0 (fun y0 : A => x0 = y0 \/ x0 <> y0)
                (or_introl (x0 <> x0) (refl_equal x0)) y e
          | right n =>
              or_intror (x0 = y)
                (fun neq : x0 = y =>
                 n (eq_ind x0 (fun y0 : A => x0 = y0) (refl_equal x0) y neq))
          end) _ (fun e : x = x => P (eqT2eq e)) H0 (eq2eqT p)) (eq_eqT_bij p).
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
