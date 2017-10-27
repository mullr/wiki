This tactic unfolds a fixpoint once. See [evar\_match](evar_match) for a more basic example of tactic written in OCaml, and instructions on how to compile it.

```ocaml
(*i camlp4deps: "parsing/grammar.cma" i*)
(*i camlp4use: "pa_extend.cmo" i*)
open Pp
open Term
open Refiner
open Tacexpr
open Util
let fail () = tclFAIL 0 (str "not an expected form")
(** Run tactic [k] with constr [x] as argument. *)
let run_cont k x =
  let k = TacDynamic(dummy_loc, Tacinterp.tactic_in (fun _ -> k)) in
  let x = TacDynamic(dummy_loc, Pretyping.constr_in x) in
  let tac = <:tactic<let cont := $k in cont $x>> in
  Tacinterp.interp tac
(** If [f] is a reference to fixpoint, return the index of its
    decreasing argument and its body, where the recursive call is a
    reference to the fixpoint. *)
let unfold_fixpoint_once env f =
  begin match kind_of_term f with
    | Const c ->
      let decl = Environ.lookup_constant c env in
      begin match Declarations.body_of_constant decl with
        | Some b ->
          begin match kind_of_term (Declarations.force b) with
            | Fix ((is, i), (ns, ts, bs)) ->
              Some (is.(i), subst1 f bs.(i))
            | _ -> None
          end
        | None -> None
      end
    | _ -> None
  end
let rec apply_and_beta_reduce f = function
  | [] -> f
  | x::xs as ys ->
    begin match kind_of_term f with
      | Lambda (_, _, b) -> apply_and_beta_reduce (subst1 x b) xs
      | _ -> mkApp (f, (Array.of_list ys))
    end
TACTIC EXTEND simpl_pottier
  | [ "simpl_pottier" constr(x) tactic(k) ] ->
    [
      let env = Global.env () in
      begin match kind_of_term x with
        | App (f, args) ->
          begin match unfold_fixpoint_once env f with
            | Some (i, b) ->
              if i < Array.length args then
                (* check that the decreasing argument is in constructor form *)
                begin match kind_of_term args.(i) with
                  | App (cc, _) when isConstruct cc ->
                    run_cont k (apply_and_beta_reduce b (Array.to_list args))
                  | _ -> fail ()
                end
              else fail ()
            | None -> fail ()
          end
        | _ -> fail ()
      end
    ]
END;;
```

This plugin provides a `simpl_pottier` tactic that takes two arguments: a Coq term `t` (constr) and a continuation tactic `k`, checks that `t` is an applied fixpoint whose decreasing argument starts with a constructor, and calls `k` with the result of unfolding the fixpoint once. Example of use, assuming the plugin is named simpl\_pottier.{cma,cmxs} (it answers [this post](http://article.gmane.org/gmane.science.mathematics.logic.coq.club/7934)):

```coq
Declare ML Module "simpl_pottier".
Ltac simpl_left :=
  match goal with
    | |- ?a = ?b => simpl_pottier a (fun x => change (x = b))
  end.
Goal forall n m, S n + m = S (n + m).
intros.
simpl_left. (* look here *)
reflexivity.
Qed.
```

Tested with Coq v8.4 r15016 (2012-03-02) and trunk r15022 (2012-03-02).
