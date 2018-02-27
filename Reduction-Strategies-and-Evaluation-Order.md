This page contains concrete some examples of reduction strategies described at <https://coq.inria.fr/refman/tactics.html#Conversion-tactics>.

~~~~~~~~~~~~~~~~~~~~
Require Import ZArith. Local Open Scope Z_scope.

Local Notation slow := (1000000000^1000000000).
Fail Timeout 1 Eval cbv        in slow.
Fail Timeout 1 Eval vm_compute in slow.
Fail Timeout 1 Eval lazy       in slow.

(* Evaluation order of function applications: cbv and vm_compute
reduce arguments to a function application, then plug the value of the
arguments into the function and reduce the function. lazy first
reduces the function as much as possible, then plugs in the argument
and continues reducing. *)

Fail Timeout 1 Eval cbv        in bool_rect (fun _ => Z) 0 slow true.
Fail Timeout 1 Eval vm_compute in bool_rect (fun _ => Z) 0 slow true.
     Timeout 1 Eval lazy       in bool_rect (fun _ => Z) 0 slow true.

(* Evaluation order of matches: argument before cases, except dummy matches are reduced immediately. *)

     Timeout 1 Eval cbv        in if true then 0 else slow.
     Timeout 1 Eval vm_compute in if true then 0 else slow.
     Timeout 1 Eval lazy       in if true then 0 else slow. (* 0s *)

Fail Timeout 1 Eval cbv        in match slow with Z0 => 0 | _ => 0 end.
Fail Timeout 1 Eval vm_compute in match slow with Z0 => 0 | _ => 0 end.
Fail Timeout 1 Eval lazy       in match slow with Z0 => 0 | _ => 0 end.

     Timeout 1 Eval cbv        in match slow with _ => 0 end.
     Timeout 1 Eval vm_compute in match slow with _ => 0 end.
     Timeout 1 Eval lazy       in match slow with _ => 0 end.

(* Evaluation of lambdas: lambdas are substituted into functions
before their contents are reduced. If a lambda cannot be substituted,
its body is reduced. *)

     Timeout 1 Eval cbv        in bool_rect (fun _ => unit -> Z) (fun _ => 0) (fun _ => slow) true.
     Timeout 1 Eval vm_compute in bool_rect (fun _ => unit -> Z) (fun _ => 0) (fun _ => slow) true.
     Timeout 1 Eval lazy       in bool_rect (fun _ => unit -> Z) (fun _ => 0) (fun _ => slow) true.

Fail Timeout 1 Eval cbv        in (fun _:unit => slow).
Fail Timeout 1 Eval vm_compute in (fun _:unit => slow).
Fail Timeout 1 Eval lazy       in (fun _:unit => slow).

(* Evaluation of let binders: same as function arguments *)

Fail Timeout 1 Eval cbv        in let x := slow in 0.
Fail Timeout 1 Eval vm_compute in let x := slow in 0.
     Timeout 1 Eval lazy       in let x := slow in 0.

     Timeout 1 Eval cbv        in let x := (fun _:unit => slow) in 0.
     Timeout 1 Eval vm_compute in let x := (fun _:unit => slow) in 0.
     Timeout 1 Eval lazy       in let x := (fun _:unit => slow) in 0.
~~~~~~~~~~~~~~~~~~~~