[[http://coq.inria.fr/library-eng.html|The Coq Standard Library]]

== Reworking the Standard Library ==

Discussion on what users would like to see in a standard library.

=== Finite Types ===

Finite Types should be part of the Standard Library.  Either InductiveFiniteTypes or FixpointFiniteTypes would be reasonable candidates for inclusion in the standard library. 

=== Extensional Equality ===

There should be a library for extential equality for functions.

Let there be less tactics but let them be more powerful than now. For example, replace tactic in theory can be used to replace one 1/2 with 2/4. Or even sin pi with sin 3*pi. But now it's not possible. 

=== Wf ===

{{{Acc_Iter}}}  and {{{Fix_F}}} are almost identical, but, until Coq 8.1, they had different theories following from them. From Coq 8.2, the notions are merged.  See [[http://coq.inria.fr/library/Coq.Init.Wf.html|Coq.Init.Wf]]

=== Consistent Definition of Operators ===
I would be nice if the standard library was more consistent with the definitions it uses.  As it stands {{{a < b}}} for {{{nat}}} is an inductive definition while {{{a < b}}} for {{{Z}}} is defined to be {{{a ?= b = LT}}}.

I think that a consistent set of definitions would be easy to achieved by writing a general module (or modules) that are instantiated for various types ({{{nat}}}, {{{binPos}}}, {{{Z}}}, rationals, etc.)

More specifically for decidable total orders I am thinking of module with {{{compare : A -> A -> comparison}}} as primitive and with

{{{#!coq
Definition ltcompare (c:compare) : bool :=
match c with
| Lt => true
| Eq => false
| Gt => false
end.

(* ... *)

Definition lt (a b:A) : bool := ltcompare (compare a b)

(* ... *)

Coercion Is_true : bool >-> Sortclass
}}}

This process uses SmallScaleReflection advocated by GeorgesGonthier.

==== Is_true vs (true=) ====
Some may argue that the function {{{(true=)}}} should be the coercion because it allows access to the extensive array of rewrite tactics.  I think the above definition is more beautiful.  Discuss.

I would advocate for using the following definition as the canonical coercion from `bool` to `Prop`:

{{{
Inductive eq_true : bool -> Prop := is_eq_true : eq_true true.
}}}

It directly expresses what it means, it does not interfere with other potentially independent uses of {{{true=}}} and it is easy
to use for rewriting expressions into {{{true}}} using {{{destruct}}}. [HH]

=== Sets ===

Both the {{{A -> Set}}} and the {{{forall I:Type, I -> A}}} notions of subsets of A should be purused in the standard library.

I also suggest a theory of decidable sets {{{A -> bool}}} and semi-decidable sets {{{A -> conat}}} where

{{{#!coq
CoInductive conat : Set :=
| coO : conat
| coS : conat -> conat.
}}}

=== Double-negation mapping of classical logic ===
It would be nice to standardize the double-negation embedding of classical logic into intuitionistic logic.  This would make it easier to investigate the constructive implications of classical theories, by avoiding reliance on additional axioms.  

=== Interfaces and Types ===

It should allow different views on the same subject - for example, different ways of the same subject definition. We need ability to define interface and to replace one it's implementation with another.

There should be way to define placeholders. Moreover, almost all current math structure should be explained with ability to prove
it's later.

More coercions to allow type conversions - CoQ should automatically expand notation of n ^ 5.4 ^ to (nat_to_real n)^5.4 ^.

=== Structure ===

It should handle very big amounts of theorems - around millions, while
I suspect none of existing systems is targeted to that.

Proofs should not be readable as usual math proofs. Programs are much more
readable than proofs. Comments to the theorems helps much more than
clean proof. User should think in terms of theorems and tactics 
application, not in term of terms elimination or induction.
  
=== Organization ===

Easy-to-contribute library is much better. Although we should keep library clean and strict we should allow user to contribute in even small part. Nobody will write thousands lines of code before contribution. If every ten lines can be submitted, then we'll have
much more active and wide community. 

There should be clean list of common problems defined in both existing and to-be-written code. One should be able to easily find the problem and solve it.
