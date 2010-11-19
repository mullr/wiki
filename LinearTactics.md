I tried to have a small set of tactics which clean the hypothesis they use:
 * clean (removes some hypothesis and recursively all dependent hypothesis)
 * purge/purge_goal (same job as clean but fails if ALL dependent hypothesis cannot be cleared, so purge_goal is a good cleaner, but also very dangerous as you can get silently rid of hypothesis)
 * linear forward (an assert cleaning its hypothesis)
 * linear backward (an apply cleaning its hypothesis)

See and run the last example.

{{{#!coq
(** * cleaning tactic *)
Ltac clean H :=
 match H with
 | ?a ?b => clean a; clean b; try clean a
 | ?a _ => clean a
 | _ ?b => clean b
 | forall (a: ?A), ?B => clean B; clean A
 | ?A -> ?B => clean B; clean A
 | fun u => ?f => idtac "not tested feature"; clean f
 | ?x => clean_aux x
 end
with clean_aux H :=
 match type of H with
 | Type => try clear H
 | Prop => try clear H
 | ?t => try (clear H; clean t)
 end.

(** this tactics fails if it cannot completely clean some hypothesis *)
Ltac purge H :=
 match H with
 | ?a ?b => purge a; purge b
 | ?a ?b => purge b; purge a
 | forall (a: ?A), ?B => purge B; purge A
 | ?A -> ?B => purge B; purge A
 | fun u => ?f => idtac "not tested feature"; purge f
 | ?x => purge_aux x
 end
with purge_aux H :=
 match type of H with
 | Type => clear H
 | Prop => clear H
 | ?t => clear H; purge t
 end.

Ltac purge_goal :=
 repeat
 match goal with
 | H: _ |- _ => purge_aux H
 end.

(** * The forward and backward linear tactics *)
(** ** It performs an [assert] and [clean] all no more needed hypothesis *)
(** It uses same kind of hack as [exploit] tactic in Compcert *)

(** we don't care about induction principles generation;
    we do not use the predefined "list" type constructor,
    but it is cleaner not to do so, so the user cannot be
    confused *)
CoInductive TacList :=
| TacListNil
| TacListCons: forall A, A -> TacList -> TacList.
Notation "'forward' x .. y 'as'" :=
 (TacListCons _ x .. (TacListCons _ y TacListNil) .., true)
 (x at level 0).
Notation "'backward' x .. y" :=
 (TacListCons _ x .. (TacListCons _ y TacListNil) .., false)
 (x at level 0, at level 0).

Ltac fwx H t l :=
match l with
| TacListNil => let h := fresh H in
                assert (h := t);
                clean t;
                rename h into H
| TacListCons ?A ?a ?b =>
(  fwx H (t a) b
|| fwx H (t _ a) b
|| fwx H (t _ _ a) b
|| fwx H (t _ _ _ a) b
|| fwx H (t _ _ _ _ a) b
|| fwx H (t _ _ _ _ _ a) b
|| fwx H (t _ _ _ _ _ _ a) b
|| fwx H (t _ _ _ _ _ _ _ a) b)
end.

(** ** The backward tactic *)
(** *** not a very smart tactic; it is a [linear forward] followed by [apply] *)
Tactic Notation "linear" constr(t) :=
(match t with
 | (TacListCons ?A ?a ?l, false) => let H := fresh in
                                    fwx H a l;
                                    apply H; clean H
 | _ => fail "Sorry, I couldn't combine the given terms"
 end).

(** ** The forward tactic *)
Tactic Notation "linear" constr(t) ident(H) :=
(match t with
 | (TacListCons ?A ?a ?l, true) => fwx H a l
 | _ => fail "Sorry, I couldn't combine the given terms"
 end).

(** * Improved now *)
(** in Coq 8.2, "easy" can be slower than auto,
    so here is a patch to correct it *)
Tactic Notation "now" tactic (a) := (a; auto; easy).

Example cleaning_test:
 forall (A B C D E F: Prop),
  (A -> B -> C) ->
  ((B -> C) -> D -> E -> F) ->
  (A -> E) ->
  A -> D -> F.
Proof.
 intros A B C D E F HABC HBCDEF HAE HA HD.
 (* we will use two time A, so we need to duplicate it *)
 assert (A_backup := HA).
 linear forward HABC HA as HBC. (* now H and H2 do not exist anymore *)
 linear forward HAE A_backup as HE.
        (* now HAE and HE do not exist anymore, and neither does A *)
 linear backward HBCDEF. (* now HBCDEF does not exist anymore *)
   purge_goal. (* keeps all hypothesis depending on B and C *)
   assumption.
  clear -HD. (* clear all but D and HD *)
  assumption.
 easy.
 (* I know this tactic is sufficient to do all the job,
    but not for illustrate *)
Qed.
}}}
