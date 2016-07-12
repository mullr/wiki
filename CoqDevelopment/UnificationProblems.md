This page is for collecting unification problems which Coq is not able to solve yet.

=== Missing backtracking ===

This example is a simplification of a [[attachment:monoid.v|realistic example]] about proving properties of the composition of morphisms of monoids:
{{{
Axiom H : forall {a b : nat * unit}, fst a = fst b -> a = b.
Lemma lem1 (a : nat) (x y:unit) : (a, x) = (a, y).
apply (H eq_refl).
(* fails, because "fst a = fst b" entails too eagerly that "a ≡ b" w/o possibility of backtracking *)
}}}

=== Too weak basic pattern unification ===

This example enters pattern-unification but is shamefully not found.
{{{
Import EqNotations.
Check fun x (a : x = 0) (b : x = 0) => rew a in b.
(* Problem is ?P x ≡ x = 0 *)
}}}

=== Libal-Miller functions-as-constructors extended pattern unification ===

This example is a simplification of a [[attachment:monoid.v|realistic example]] and enters extended pattern-unification:
{{{
Check fun x (a : S x = 0) (b : S (S x) = 0) => rew a in b.
(* Problem is ?P (S x) ≡ S (S x) = 0 *)
}}}
