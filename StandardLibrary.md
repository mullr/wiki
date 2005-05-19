[http://coq.inria.fr/library-eng.html The Coq Standard Library]

== Reworking the Standard Library ==

Discussion on what users would like to see in a standard library.

=== Consistent Definition of Operators ===
I would be nice if the standard library was more consistent with the definitions it uses.  As it stands {{{a < b}}} for {{{nat}}} is an inductive definition while {{{a < b}}} for {{{Z}}} is defined to be {{{a ?= b = LT}}}.

I think that a consistent set of definitions would be easy to achive by writing a general module (or modules) that are instantiated for various types ({{{nat}}}, {{{binPos}}}, {{{Z}}}, rationals, etc.)

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

Coercion Is_true : bool>->SortClass
}}}

This process uses SmallScaleReflection advocated by GeorgesGonthier.

==== Is_true vs (true=) ====
Some may argue that the function {{{(true=)}}} should be the coercion because it allows access to the extensive array of rewrite tactics.  I think the above definition is more beautiful.  Discuss.

=== Sets ===

Both the {{{A -> Set}}} and the {{{forall I:Type, I -> A}}} notions of subsets of A should be purused in the standard library.
