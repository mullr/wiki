(** * cleaning tactic *)
Ltac clean H :=
 match H with
 | ?a ?b => clean a; clean b; try clean a
 | ?a _ => clean a
 | _ ?b => clean b
 | forall (a: ?A), ?B => clean B; clean A
 | ?A -> ?B => idtac "harmless but surprising"; clean B; clean A
 | fun u => ?f => idtac "not tested feature"; clean f
 | ?x => clean_aux x
 end
with clean_aux H :=
 match type of H with
 | Type => try clear H
 | ?t => try (clear H; clean t)
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
