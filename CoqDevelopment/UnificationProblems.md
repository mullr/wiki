This page is for collecting unification problems which Coq (or [[https://github.com/unicoq/unicoq|UniCoq]]) are not able to solve (yet, i.e. July 2016).

== Missing backtracking ==

=== Missing backtracking on successful first-order unification ===

This example is a simplification of a [[attachment:monoid.v|realistic example]] about proving properties of the composition of morphisms of monoids:
{{{
Axiom H : forall {a b : nat * unit}, fst a = fst b -> a = b.
Lemma lem1 (a : nat) (x y:unit) : (a, x) = (a, y).
Fail apply (H eq_refl).
Fail refine (H eq_refl).
(* fails, because "fst a ≡ fst b" entails too eagerly that "a ≡ b" w/o possibility of backtracking/postponing *)
}}}

=== Missing backtracking/postponing on failing too complex problem ===

[[https://coq.inria.fr/bugs/show_bug.cgi?id=1214|Bug #1214]] shows a failure in unifying {{{(if ?b then true else false) = ?b) ≡ (true = true)}}}. Contrastingly, {{{?b = if ?b then true else false)) ≡ (true = true)}}} works.

== Extending the first-order unification heuristic into a "pattern-unification" heuristic ==

In some sense, Coq's exitential variables have two levels of instance: the instance of the existential variable properly speaking and the arguments applied to the existential variables. For example, in context
{{{
x:nat
H:forall y (P:nat->Prop), P y -> True
p:x=0
}}}
the term
{{{
H x ?[P] p
}}}
generates the problem {{{(?P[x:=x] x) ≡ (x=0)}}} where {{{?P}}} depends on {{{x}}} both because it is declared in the context containing {{{x}}} and because it is applied to {{{x}}}. The two solutions of the equation do not seem to have same value. The dependency on the applied {{{x}}} seems more expected than the other one and one might find the solution {{{?P[x] := fun x => x=0}}} more intuitive.

This is what happens with the first-order unification heuristic. If we had to solve {{{(?P[x:=x] x) ≡ Q x)}}}, one would find ok that {{{?P}}} is defined to be {{{Q}}}, i.e. {{{fun x => Q x}}} even though another solution is {{{fun _ => Q x}}}.

So, why not to solve {{{(?P[x:=x] x) ≡ (x=0)}}} the same way, giving priority to the purposely applied {{{x}}} over the {{{x}}} which is in the context by default.

Here is an example which is not solved with {{{b : x = 0}}} while it would be if we had {{{b : 0 = x}}}, thanks to the first-order heuristic:
{{{
Import EqNotations.
Check fun x (a : x = 0) (b : x = 0) => rew a in b.
(* Problem is "(?P[x:=x] x) ≡ (x = 0)" *)
}}}

== Extending the first-order unification heuristic into a Libal-Miller functions-as-constructors heuristic ==

This example is a simplification of a [[attachment:monoid.v|realistic example]]. It is similar to the one in the previous section but using functions-as-constructors extended pattern-unification rather than basic pattern-unification:
{{{
Check fun x (a : S x = 0) (b : S (S x) = 0) => rew a in b.
(* Problem is "(?P[x:=x] (S x)) ≡ (S (S x) = 0)" *)
}}}

== Inverting tuples in instances of existential variables ==

There is a pretty common pattern where an argument of an existential variable is a tuple of which components can be projected.

See e.g. [[https://coq.inria.fr/bugs/show_bug.cgi?id=3126|Bug #3126]] (or, more distantly, [[https://coq.inria.fr/bugs/show_bug.cgi?id=3823|Bug #3823]]):

{{{
Goal forall T1 (P1 : T1 -> Type), sigT P1 -> sigT P1.
intros T1 P1 H1.
eexists ?[x].
destruct H1 as [x1 H1].
Fail apply H1.
instantiate (x:=projT1 H1).
apply H1.
}}}

Indeed, the first {{{apply H1}}} has to solve {{{?x[H1:=existT P1 x1 H1] ≡ x1}}} which it could do by projecting {{{x1}}} but it is not (yet) able to do it.

== See also ==

[[https://coq.inria.fr/bugs/buglist.cgi?quicksearch=unification&list_id=150125|A raw list of bugs mentioning unification]].
