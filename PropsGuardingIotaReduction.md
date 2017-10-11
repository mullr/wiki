Propositions Guarding Iota Reduction
====================================

It is possible for the guard of a fix-point to be of a type inside `Prop` rather than a type inside `Set`. This can be still used [in functions whose output type is in Set](../FalseEqAcc). In fact, this is used in [well-founded recursion](http://coq.inria.fr/library/Coq.Init.Wf.html).

The [Acc](http://coq.inria.fr/library/Coq.Init.Wf.html#Acc) `x` type lives in `Prop` and an object of this types is the guard for the fix point function [Fix\_F](http://coq.inria.fr/library/Coq.Init.Wf.html#Fix_F).

It is this situation where one may be forced to evaluate an object living in `Prop`. This evaluation proves to the system that the guard is not a purely *hypothetical* object.

To be concrete, consider some function defined by well founded recursion inside the context `H:well_founded gt`, which is equivalent to `H:forall n, Acc gt n`.

    set (F:=fun (x:nat)
                (f:forall y:nat, y > x -> nat) =>
                (S (f (S x) (le_n (S x))))).
    set (P:=fun _:nat => nat).
    set (f:=Fix H P F)

Loosely speaking *f*(*x*) = 1 + *f*(*x*+1) and because we are assuming the `gt` relation is well founded (which it isn't) this function is well defined. In this context we can ask Coq to compute this function.

    Eval compute in (f 0)

The result is `(fix ...) 0 (H 0) : nat` but the fix point does not evaluate further because the guard `H 0` is in normal form, but does not have a constructor.

One can try to push the evaluation onward by giving a few constructors (`Acc_intro`) for the match to succeed on

    set (H':=(fun z => (Acc_intro z (fun y _ => (Acc_intro y (fun x _ => (H x))))))).
    set (g:=Fix H' P F).
    Eval compute in (g 0).

Here `H'` is another proof that `gt` is well founded, but this proof has some `Acc_intro` inside to allow the computation to continue further. The result of the compute is `S (S (fix ...) 0 (H 3)) : nat`. So one can get some finite number of recursions done, but in the end we always run into the assumption `H` that cannot be evaluated further.

The important point is to notice that Coq needs to evaluate the expression `H'`, defined above, in order to get to the point where (H 3) stops the evaluation. This evaluation occurs even that `H'` has type `well_founded gt` which lives in `Prop`.

Coq Session
-----------

    Goal well_founded gt->False.
    intros H.
    set (F:=fun (x:nat)
                (f:forall y:nat, y > x -> nat) =>
                (S (f (S x) (le_n (S x))))).
    set (P:=fun _:nat => nat).
    set (f:=Fix H P F).
    Eval compute in (f 0).
    set (H':=(fun z => (Acc_intro z (fun y _ => (Acc_intro y (fun x _ => (H x))))))).
    set (g:=Fix H' P F).
    Eval compute in (g 0).
