Predecessors of Binary Numbers
==============================

Often one wants to do Peano-style recursion over the binary number such as `positive` or `N`. The standard library `Coq.ZArith.Wf_Z` includes functions `natlike_rec`, `natlike_rec2`, and `natlike_rec3` for this; however these functions cannot be used to compute within Coq because they depend on opaque lemmas. Even if the lemmas were not opaque, the computation is quite slow.

Sometimes one does no care about the order one processes the numbers, such as when computing the partial sum of a sequence. With the binary numbers it seems easier to sum the points out of order. To illustrate how to do this, here are two implementations that produce a list of the first `n` numbers (No proof of correctness is currently provided). These examples can be easily modified to be useful in more general situations.

Solution for N
--------------

```coq
Fixpoint predecessorsInNHelp (cont:N -> N) (x:positive) {struct x} : list N -> list N :=
match x with
|xI x'=> (fun l => (cont (Npos (xO x')))::
         ((predecessorsInNHelp (fun n => cont (Ndouble n)) x')
         ((predecessorsInNHelp (fun n => cont (Ndouble_plus_one n)) x') l)))
|xO x'=> (fun l =>
         ((predecessorsInNHelp (fun n => cont (Ndouble n)) x')
         ((predecessorsInNHelp (fun n => cont (Ndouble_plus_one n)) x') l)))
|xH => (cons (cont N0))
end.
Definition predecessorsInN (n:positive) := predecessorsInNHelp (fun x => x) n nil.
Eval compute in predecessorsInN 10.
```

`predecessorsInN` takes a `positive` number `n` and returns a `list N` of numbers {0, ..., `n - 1`}

This solution was developed by [BasSpitters](BasSpitters) and [RussellOconnor](RussellOconnor)

Solution for positive
---------------------

```coq
Fixpoint positiveFold (A:Type) (comb:positive -> A -> A) (limit:positive)
(above:bool)
 (init:A) {struct limit} : A :=
 match limit with
 |xI x'=>
 comb xH
 (positiveFold A (fun n => comb (xI n)) x' above
 (positiveFold A (fun n => comb (xO n)) x' false init
 ))
 |xO x'=>
 comb xH
 (positiveFold A (fun n => comb (xI n)) x' true
 (positiveFold A (fun n => comb (xO n)) x' above init
 ))
 |xH => if above then init else comb xH init
end.
Definition predecessorsInPositive (n:positive) :=
 positiveFold (list positive) (@cons positive) n false nil.
Definition predecessorsInPositiveStrict (n:positive) :=
 positiveFold (list positive) (@cons positive) n true nil.
Eval compute in predecessorsInPositive 10.
Eval compute in predecessorsInPositiveStrict 10.
```

`predecessorsInPositive` takes a `positive` number `n` and returns a `list positive` of numbers {1, ..., `n`} `predecessorsInPositiveStrict` takes a `positive` number `n` and returns a `list positive` of numbers {1, ..., `n - 1`}

This solution was developed by [PierreCorbineau](PierreCorbineau).

Future Work
-----------

Feel free to edit these routines to generalize them and make improvements and/or documentation.
