Record Monoid := {
 dom : Type;
 unit : dom;
 mult : dom -> dom -> dom;
 neutr : forall x, mult x unit = x;
 neutl : forall x, mult unit x = x;
 assoc : forall x y z, mult (mult x y) z = mult x (mult y z)
}.

Record morphism M1 M2 := {
 mor : dom M1 -> dom M2;
 mor_unit : mor (unit M1) = unit M2;
 mor_mult : forall x y, mor (mult M1 x y) = mult M2 (mor x) (mor y)
}.

Arguments mor {M1} {M2} _ _.
Arguments mor_unit {M1} {M2} _.
Arguments mor_mult {M1} {M2} _ _ _.

Definition comp {M1 M2 M3} (f: morphism M1 M2) (g: morphism M2 M3) : morphism M1 M3 :=
{|
 mor := fun x => mor g (mor f x);
 mor_unit := eq_trans (f_equal (mor g) (mor_unit f)) (mor_unit g);
 mor_mult := fun x y => eq_trans (f_equal (mor g) (mor_mult f x y)) (mor_mult g (mor f x) (mor f y))
|}.

Lemma comp_assoc_unit M1 M2 M3 M4 (f: morphism M1 M2) (g: morphism M2 M3) (h: morphism M3 M4) : mor_unit (comp f (comp g h)) = mor_unit (comp (comp f g) h).
Proof.
unfold comp; simpl.
rewrite eq_trans_assoc.
rewrite eq_trans_map_distr.
rewrite f_equal_compose.
reflexivity.
Qed.

Lemma comp_assoc_mult M1 M2 M3 M4 (f: morphism M1 M2) (g: morphism M2 M3) (h: morphism M3 M4) x y :
  mor_mult (comp f (comp g h)) x y = mor_mult (comp (comp f g) h) x y.
Proof.
unfold comp; simpl.
rewrite eq_trans_assoc.
rewrite eq_trans_map_distr.
rewrite f_equal_compose.
reflexivity.
Qed.

Require Import FunctionalExtensionality.

Import EqNotations.

(* A detour to provide a general purpose tactic; not really needed here, intended to be part of the standard library *)
Tactic Notation "extensionality" "in" hyp(H) :=
  let faildep _ := fail "Not a non-dependent extensional equality" in
  let rec iter_fun_ext :=
    match type of H with
    | _ = _ => exact H
    | forall x, _ =>
      eapply functional_extensionality_dep; intro x; 
      (specialize (H x) || faildep ()); iter_fun_ext
    | ?t => idtac "Not an extensional equality"
    end in
  let H' := fresh "H" in
  unshelve (refine (let H' := _ in _); clearbody H');
  [shelve|
   iter_fun_ext|
   move H' before H; (clear H; rename H' into H) ||
      faildep ()].
(* End of detour *)

Lemma morphism_extensional {M1 M2} {f g: morphism M1 M2} :
  (* Both brackets for "rew" should be ommitted: functions-as-constructors unification *)
  forall p: mor f = mor g,
  rew [fun mf => mf (unit M1) = unit M2] p in mor_unit f = mor_unit g ->
  (forall x y, rew [fun mf => mf (mult M1 x y) = mult M2 (mf x) (mf y)] p in mor_mult f x y = mor_mult g x y) ->
  f = g.
Proof.
destruct f, g; simpl.
intros ->; simpl.
intros ->.
intros.
extensionality in H.
rewrite H.
reflexivity.
Qed.

Lemma comp_assoc M1 M2 M3 M4 (f: morphism M1 M2) (g: morphism M2 M3) (h: morphism M3 M4) :
  comp f (comp g h) = comp (comp f g) h.
Proof.
eapply (morphism_extensional ?[p]). (* should work by giving "eq_refl" directly *)
[p]:reflexivity.
apply comp_assoc_unit.
apply comp_assoc_mult.
Qed.
