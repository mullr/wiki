[http://coq.inria.fr/library-eng.html The Coq Standard Library]

== Reworking the Standard Library ==

Discussion on what users would like to see in a standard library.

=== Extensional Equality ===

There should be a library for extential equality for functions.

=== Wf ===

{{{Acc_Iter}}}  and {{{Fix_F}}} are almost identical, but they have different theories following from them.  This should be cleaned up by having the two theories merged into one.  See [http://coq.inria.fr/library/Coq.Init.Wf.html Coq.Init.Wf]

=== Consistent Definition of Operators ===
I would be nice if the standard library was more consistent with the definitions it uses.  As it stands {{{a < b}}} for {{{nat}}} is an inductive definition while {{{a < b}}} for {{{Z}}} is defined to be {{{a ?= b = LT}}}.

I think that a consistent set of definitions would be easy to achived by writing a general module (or modules) that are instantiated for various types ({{{nat}}}, {{{binPos}}}, {{{Z}}}, rationals, etc.)

More speficially for decidable total orders I am thinking of module with {{{compare : A -> A -> comparison}}} as primitive and with

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

=== Sets ===

Both the {{{A -> Set}}} and the {{{forall I:Type, I -> A}}} notions of subsets of A should be purused in the standard library.

I also suggest a theory of decideable sets {{{A -> bool}}} and semi-decidable sets {{{A -> conat}}} where

{{{#!coq
CoInductive conat : Set :=
| coO : conat
| coS : conat -> conat.
}}}
