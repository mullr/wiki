[[http://coq.inria.fr/library-eng.html|The Coq Standard Library]]

ReflectionOnStandardLibrary mostly discusses organizational aspects

== Reworking the Standard Library ==

Discussion on what users would like to see in a standard library.

=== Finite Types ===

Finite Types should be part of the Standard Library.  Either InductiveFiniteTypes or FixpointFiniteTypes would be reasonable candidates for inclusion in the standard library. 

=== Extensional Equality ===

There should be a library for [[extensional_equality]] for functions.

 The axiom of functional extensionality is declared in {{{Coq.Program.FunctionalExtensionality}}} (Coq SVN):
 {{{#!coq

Axiom fun_extensionality_dep : forall A, forall B : (A -> Type), 
  forall (f g : forall x : A, B x), 
  (forall x, f x = g x) -> f = g.

Lemma fun_extensionality : forall A B (f g : A -> B), 
  (forall x, f x = g x) -> f = g.
}}}

 Is this what's meant here?

=== Wf ===

{{{Acc_Iter}}}  and {{{Fix_F}}} are almost identical, but, until Coq 8.1, they had different theories following from them. From Coq 8.2, the notions are merged.  See [[http://coq.inria.fr/library/Coq.Init.Wf.html|Coq.Init.Wf]]

=== Theory of relations ===

The {{{Coq.Sets.Relations_*}}} modules duplicate the theory of relations provided by {{{Coq.Relations.Relations}}}, with different theorems following from each.  These notions should be unified.  {{{Coq.Relations.Rstar}}} and {{{Coq.Relations.Newman}}} have been removed from SVN due to similar issues; they're still accessible from Coq-contribs. (Note that an inductive definition for R* is given in {{{Coq.Relations.Relation_Operators}}}, and Newman's lemma is proven in {{{Coq.Sets.Relations_3_facts}}}.)

{{{Coq.Classes}}} includes a typeclass-based theory of relations which depends on {{{Coq.Relations}}}.  It probably has some duplications

Now that nested directories are being supported for {{{theories/Numbers}}}, the {{{Wellfounded}}} directory should probably be moved under {{{Relations}}} for clarity, as it was in Coq 6.x

Add a theory of heterogeneous relations {{{R: A -> B -> Prop}}}. 

 Add a {{{functional_rel}}} property: {{{forall x: A, exists! y: B, R x y}}} and some kind of coercion from CIC functions {{{A -> B}}} to functional relations.  This is useful in math, logic, program specification...

=== Order stuff (8.3) ===
The theories library for Coq 8.3 adds some module-based support for decidable total orders.  But the names chosen ({{{OrderType}}} and similar) are arguably inappropriate.

=== Consistent Definition of Operators ===

It would be nice if the standard library was more consistent with the definitions it uses.  As it stands {{{a < b}}} for {{{nat}}} is an inductive definition while {{{a < b}}} for {{{Z}}} is defined to be {{{a ?= b = LT}}}.

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

This process uses SmallScaleReflection advocated by GeorgesGonthier, i.e. coercing bools to propositions and treating them as equivalent when working on a decidable domain. 

==== Is_true vs (true=) ====
Some may argue that the function {{{(true=)}}} should be the coercion because it allows access to the extensive array of rewrite tactics.  I think the above definition is more beautiful.  Discuss.

I would advocate for using the following definition as the canonical coercion from `bool` to `Prop`:

{{{
Inductive eq_true : bool -> Prop := is_eq_true : eq_true true.
}}}

It directly expresses what it means, it does not interfere with other potentially independent uses of {{{true=}}} and it is easy
to use for rewriting expressions into {{{true}}} using {{{destruct}}}. [HH]

=== Arithmetic ===

Coq includes a plethora of arithmetical libraries ({{{Arith}}}, {{{NArith}}}, {{{ZArith}}}, {{{Ints}}}...), many of them implementing the same theories in different ways.  The developments are highly redundant with each other and even internally incoherent.

Coq 8.2 will include a library of abstract theories for arithmetic, with support for concrete implementations.  As a result, much of {{{Arith}}}, etc. will be all but  deprecated, except for the concrete implementation of the theory axioms.  The same considerations apply to {{{ZArith}}}, etc.  The remaining sections should probably be rewritten so that they build on the abstract theories of N, Z, etc.

=== Set theory ===

Both the {{{A -> Set}}} and the {{{forall I:Type, I -> A}}} notions of subsets of A should be perused in the standard library.

 Note that the {{{Program}}} feature relies on yet another(?) notion of subset: {{{ { x : T | P } }}} is an x of type T endowed with a proof that x satisfies P.  The {{{Ensemble}}} type from {{{Coq.Sets}}} seems to be a version of {{{ { x : T | P } }}} endowed with an extensionality axiom. (is this correct???)  How much of {{{Coq.Sets}}} can be rephrased without needing extensionality?  

I also suggest a theory of decidable sets {{{A -> bool}}} (This is apparently provided by {{{Coq.Sets.Uniset}}}) and semi-decidable sets {{{A -> conat}}} where

{{{#!coq
CoInductive conat : Set :=
| coO : conat
| coS : conat -> conat.
}}}

 Of course, we should try to establish connections among these notions whenever possible.

See  Carlos Simpson, ''Computer theorem proving in math'' ([[http://arxiv.ccsd.cnrs.fr/abs/math/0311260 | arXiv:math/0311260 ]]) and ''Set theoretical mathematics in Coq'' ([[http://arxiv.ccsd.cnrs.fr/abs/math/0402336v1 | arXiv:math/0402336v1 ]]) for an overview.

=== Abstract algebra ===

The Coq standard library should include the abstract theory of the most common algebraic structures at least (monoids, groups, rings, fields).  (Semi-)rings and fields are already defined as part of the {{{ring}}} and {{{field}}} tactic families. 

=== Double-negation mapping of classical logic ===

It would be nice to standardize the double-negation embedding of classical logic into intuitionistic logic.  This would make it easier to investigate the constructive implications of classical theories, by avoiding reliance on additional axioms.  

* Classical reasoning is currently required for much of {{{Coq.Reals}}}; it would be nice if it was rewritten to use double-negation. 

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

There should be clean list of common problems defined in both existing and to-be-written code. One should be able to easily find the problem and solve it. (See ProjectIdeas?)

----

Let there be less tactics but let them be more powerful than now. For example, replace tactic in theory can be used to replace one 1/2 with 2/4. Or even sin pi with sin 3*pi. But now it's not possible. 
