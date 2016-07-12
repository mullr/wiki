This page is for collecting unification problems which Coq is not able to solve yet.

=== Missing backtracking ===

This example is a simplification of a [[attachment:monoid.v|realistic example]] about proving properties of the composition of morphisms of monoids:
{{{
Axiom H : forall {a b : nat * unit}, fst a = fst b -> a = b.
Lemma lem1 (a : nat) (x y:unit) : (a, x) = (a, y).
apply (H eq_refl).
(* fails, because "fst a = fst b" entails too eagerly that "a ≡ b" w/o possibility of backtracking *)
}}}

=== Extending the first-order unification heuristic into a "pattern-unification" heuristic ===

In some sense, Coq's evars have two kinds of instance: the instance of the existential variable properly speaking and the arguments applied to the existential variables. For example, in context
{{{
x:nat
H:forall y (P:nat->Prop), P y -> True
p:x=0
}}}
the term
{{{
H x ?[P] p
}}}
generates the problem {{{(?P[x:=x] x) ≡ (x=0)}}} where {{{?P}}} depends on {{{x}}} both because it is declared in the context containing {{{x}}} and because it is applied to {{{x}}}. Not both solutions seem equivalent. The dependency on the applied {{{x}}} seems more expected than the other one and one might find the solution {{{?P := fun x => x=0}}} more intuitive.

This is what happens with the first-order unification heuristic. If we had to solve {{{(?P[x:=x] x) ≡ Q x)}}}, one would find ok that {{{?P}}} is defined to be {{{Q}}}, even though another solution is {{{fun _ => Q x}}}.

So, why not solve {{{(?P[x:=x] x) ≡ (x=0)}}} the same way, giving priority to the intentionally applied {{{x}}} over the {{{x}}} which is in the context by default.

Here is an example which is not solved with {{{b : x = 0}}} while it would be if we had {{{b : 0 = x}}}, thanks to the first-order heuristic:
{{{
Import EqNotations.
Check fun x (a : x = 0) (b : x = 0) => rew a in b.
(* Problem is ?P[x:=x] x ≡ x = 0 *)
}}}

=== Extending the first-order unification heuristic into a Libal-Miller functions-as-constructors heuristic ===

This example is a simplification of a [[attachment:monoid.v|realistic example]]. It is similar to the one in the previous section but using functions-as-constructors extended pattern-unification rather than basic pattern-unification:
{{{
Check fun x (a : S x = 0) (b : S (S x) = 0) => rew a in b.
(* Problem is ?P[x:=x] (S x) ≡ S (S x) = 0 *)
}}}
