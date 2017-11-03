This page is for collecting unification problems which Coq (or [UniCoq](https://github.com/unicoq/unicoq)) are not able to solve (yet, i.e. July 2016).

Missing backtracking
====================

Missing backtracking on successful first-order unification
----------------------------------------------------------

This example is a simplification of a [realistic example](files/monoid.v) about proving properties of the composition of morphisms of monoids:

```coq
Axiom H : forall {a b : nat * unit}, fst a = fst b -> a = b.
Lemma lem1 (a : nat) (x y:unit) : (a, x) = (a, y).
Fail apply (H eq_refl).
Fail refine (H eq_refl).
(* fails, because "fst a ≡ fst b" entails too eagerly that "a ≡ b" w/o possibility of backtracking/postponing *)
```

Missing backtracking/postponing on failing too complex problem
--------------------------------------------------------------

[Bug \#1214](../issues/1214) shows a failure in unifying `(if ?b then true else false) = ?b) ≡ (true = true)`. Contrastingly, `?b = if ?b then true else false)) ≡ (true = true)` works.

Inverting tuples in instances of existential variables
======================================================

There is a pretty common pattern where an argument of an existential variable is a tuple of which components can be projected.

See e.g. [Bug \#5264](../issues/5264) and [Bug \#3126](../issues/3126) (or, more distantly, [Bug \#3823](../issues/3823)):

```coq
Goal forall T1 (P1 : T1 -> Type), sigT P1 -> sigT P1.
intros T1 P1 H1.
eexists ?[x].
destruct H1 as [x1 H1].
Fail apply H1.
instantiate (x:=projT1 H1).
apply H1.
```

Indeed, the first `apply H1` has to solve `?x[H1:=existT P1 x1 H1] ≡ x1` which it could do by projecting `x1` but it is not (yet) able to do it.

Inverting case analysis on existential variables
================================================

It is common to have unification problems of the form `negb ?b = true` or `INR ?n = 2` (see Coq-club, 12 Nov 2016) which are canonically solvable, or even `ifzero ?n = false` or `match ?n with 0 | 1 -> true | _ -> false end` which are refinable (using candidates for the second one).

The price to pay is to reduce the problem to filtering on a disjunction of subproblems. So we shall need heuristics to control the risk of combinatorial explosion. Maybe by attaching subproblems to candidates?

Solvable second-order problems
==============================

Let us consider the following successful problems:

```coq
Import EqNotations.
Check fun x y (a : x = y)     (b : x = 0)   => rew [fun z => z = 0] a in b : (y = 0). (* 1 *)
Check fun x   (a : x = 0)     (b : x = 0)   => rew [fun z => z = 0] a in b : (0 = 0). (* 2 *)
Check fun   y (a : 0 = y)     (b : 0 = 0)   => rew [fun z => z = 0] a in b : (y = 0). (* 3 *)
Check fun x y (a : S x = y)   (b : S x = 0) => rew [fun z => z = 0] a in b : (y = 0). (* 4 *)
Check fun   y (a : S 0 = y)   (b : S 0 = 0) => rew [fun z => z = 0] a in b : (y = 0). (* 5 *)
Check fun x y (a : x = S y)   (b : x = 0)   => rew [fun z => z = 0] a in b : (S y = 0). (* 6 *)
Check fun x   (a : x = S 0)   (b : x = 0)   => rew [fun z => z = 0] a in b : (S 0 = 0). (* 7 *)
Check fun x y (a : S x = S y) (b : S x = 0) => rew [fun z => z = 0] a in b : (S y = 0). (* 8 *)
Check fun   y (a : S 0 = S y) (b : S 0 = 0) => rew [fun z => z = 0] a in b : (S y = 0). (* 9 *)
Check fun x   (a : S x = S 0) (b : S x = 0) => rew [fun z => z = 0] a in b : (S 0 = 0). (* 10 *)
```

Let us add the following successful problem, derived from a [realistic](files/monoid.v) situation.

```coq
Check fun x   (a : fst x = 0) (b : fst x = 0) => rew [fun z => z = 0] a in b : (0 = 0). (* 11 *)
```

In cases 1 to 7 and 11, there is a unique solution which is not found.

```coq
Import EqNotations.
Fail Check fun x y (a : x = y)     (b : x = 0)   => rew a in b : (y = 0).
Fail Check fun x   (a : x = 0)     (b : x = 0)   => rew a in b : (0 = 0).
Fail Check fun   y (a : 0 = y)     (b : 0 = 0)   => rew a in b : (y = 0).
Fail Check fun x y (a : S x = y)   (b : S x = 0) => rew a in b : (y = 0).
Fail Check fun   y (a : S 0 = y)   (b : S 0 = 0) => rew a in b : (y = 0).
Fail Check fun x y (a : x = S y)   (b : x = 0)   => rew a in b : (S y = 0).
Fail Check fun x   (a : x = S 0)   (b : x = 0)   => rew a in b : (S 0 = 0).
Fail Check fun x   (a : fst x = 0) (b : fst x = 0) => rew a in b : (0 = 0).
```

Indeed the problems are conjunctions of equations of the form `?P[x:=x,y:=y] t ≡ t = 0` and `?P[x:=x,y:=y] u ≡ u = 0` with `t` and `u` not unifiable and one of `t` or `u` neutral, i.e. an eliminated variable, an eliminated axiom, an inductive type, or a sort. The solution is unique, since `t` and `u` are in rigid position.

Assuming `t`, `u` and the right-hand sides in normal form, these are flexible/rigid problems canonically solvable by imitation (assuming none of `t` or `u` start with `=`, until obtaining `?P'[x:=x,y:=y] t ≡ t` and `?P'[x:=x,y:=y] u ≡ u` (and possibly extra equations if `t` or `u` is `0`. Let us assume that it is `t` which is neutral. One can then use candidates to express that `?P'` has two solutions for the first equation (namely `?P'[x:=x,y:=y] z := z` or `?P'[x:=x,y:=y] z := t` (`t` being assumed to have only `x` and `y` as free variables). The second equation now ensures that only the first solution is acceptable.

If `t` and `u` are not in normal form, should we head-normalize them, something that is done in the first-order unification heuristic and which does not seem inducing efficiency penalty in practice?

As for problems 8 to 10, which do not have a unique solution as they can also be solved e.g. using `?P := fun z => S (pred z) = 0`, a heuristic could still be used as discussed in the next section.

Investigation in further heuristics
===================================

Extending the first-order unification heuristic into a "pattern-unification" heuristic
--------------------------------------------------------------------------------------

In some sense, Coq's exitential variables have two levels of instance: the instance of the existential variable properly speaking and the arguments applied to the existential variables. For example, in context

```coq
x:nat
H:forall y (P:nat->Prop), P y -> True
p:x=0
```

the term

```coq
H x ?[P] p
```

generates the problem `(?P[x:=x] x) ≡ (x=0)` where `?P` depends on `x` both because it is declared in the context containing `x` and because it is applied to `x`. The two solutions of the equation do not seem to have same value. The dependency on the applied `x` seems more expected than the other one and one might find the solution `?P[x] := fun x => x=0` more intuitive.

This is what happens with the first-order unification heuristic. If we had to solve `(?P[x:=x] x) ≡ Q x)`, one would find ok that `?P` is defined to be `Q`, i.e. `fun x => Q x` even though another solution is `fun _ => Q x`.

So, why not to solve `(?P[x:=x] x) ≡ (x=0)` the same way, giving priority to the purposely applied `x` over the `x` which is in the context by default.

Here is an example which is not solved with `b : x = 0` while it would be if we had `b : 0 = x`, thanks to the first-order heuristic:

```coq
Import EqNotations.
Check fun x (a : x = 0) (b : x = 0) => rew a in b.
(* Problem is "(?P[x:=x] x) ≡ (x = 0)" *)
```

Drawbacks: abstracting over all occurrences, especially in the presence of closed subterms is maybe too strong. In

```coq
Check fun x (a : 0 = x) (b : 0 = 0) => rew a in b.
```

Do we really want to infer `P[x] := fun y => y = y`, or do we want to consider that `P[x] := fun y => y = 0` or `P[x] := fun y => 0 = y` are equally good?

Extending the first-order unification heuristic into a Libal-Miller functions-as-constructors heuristic
-------------------------------------------------------------------------------------------------------

This example is a simplification of a [realistic example](files/monoid.v). It is similar to the one in the previous section but using functions-as-constructors extended pattern-unification rather than basic pattern-unification:

```coq
Check fun x (a : S x = 0) (b : S (S x) = 0) => rew a in b.
(* Problem is "(?P[x:=x] (S x)) ≡ (S (S x) = 0)" *)
```

See also
========

[A raw list of bugs mentioning unification](https://coq.inria.fr/bugs/buglist.cgi?quicksearch=unification&list_id=150125).
