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

(** * The forward tactic *)
(** ** It performs an [assert] and [clean] all no more needed hypothesis *)
(** It uses same kind of hack as [exploit] tactic in Compcert *)
Ltac forward_aux head param H :=
( assert (H := head param)
||assert (H := head _ param)
||assert (H := head _ _ param)
||assert (H := head _ _ _ param)
||assert (H := head _ _ _ _ param)
||assert (H := head _ _ _ _ _ param)
||assert (H := head _ _ _ _ _ _ param)
||assert (H := head _ _ _ _ _ _ _ param)
||fail "The head of your goal is not in good shape"
); clean head; clean param.

Tactic Notation
 "linear" "forward" constr(a) "as" ident(H)
 := (assert (H := a); clean a).
Tactic Notation
 "linear" "forward" constr(b) constr(a) "as" ident(H)
 := (let K := fresh in linear forward b as K; forward_aux K a H).
Tactic Notation
 "linear" "forward" constr(c) constr(b) constr(a) "as" ident(H)
 := (let K := fresh in linear forward c b as K; forward_aux K a H).
Tactic Notation
 "linear" "forward" constr(d) constr(c) constr(b) constr(a) "as" ident(H)
 := (let K := fresh in linear forward d c b as K; forward_aux K a H).
Tactic Notation
 "linear" "forward" constr(e) constr(d) constr(c) constr(b) constr(a) "as" ident(H)
 := (let K := fresh in linear forward e d c b as K; forward_aux K a H).
Tactic Notation
 "linear" "forward" constr(f) constr(e) constr(d) constr(c) constr(b) constr(a) "as" ident(H)
 := (let K := fresh in linear forward e d c b as K; forward_aux K a H).
Tactic Notation
 "linear" "forward" constr(g) constr(f) constr(e) constr(d) constr(c) constr(b) constr(a) "as" ident(H)
 := (let K := fresh in linear forward f e d c b as K; forward_aux K a H).

(** * The backward tactic *)
(** ** not a very smart tactic; it is a [linear forward] followed by [apply] *)
Tactic Notation
 "linear" "backward" constr(a)
 := (let K := fresh in linear forward a as K; apply K; clear K).
Tactic Notation
 "linear" "forward" constr(b) constr(a)
 := (let K := fresh in linear forward b a as K; apply K; clear K).
Tactic Notation
 "linear" "backward" constr(c) constr(b) constr(a)
 := (let K := fresh in linear forward c b a as K; apply K; clear K).
Tactic Notation
 "linear" "backward" constr(d) constr(c) constr(b) constr(a)
 := (let K := fresh in linear forward d c b a as K; apply K; clear K).
Tactic Notation
 "linear" "backward" constr(e) constr(d) constr(c) constr(b) constr(a)
 := (let K := fresh in linear forward e d c b a as K; apply K; clear K).
Tactic Notation
 "linear" "backward" constr(f) constr(e) constr(d) constr(c) constr(b) constr(a)
 := (let K := fresh in linear forward f e d c b a as K; apply K; clear K).
Tactic Notation
 "linear" "backward" constr(g) constr(f) constr(e) constr(d) constr(c) constr(b) constr(a)
 := (let K := fresh in linear forward g f e d c b a as K; apply K; clear K).


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
