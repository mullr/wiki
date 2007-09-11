= Extensional Equality =

Extensional equality is an equality such that when {{{forall x, f x = gx}}} then {{{f = g}}}

== Why does Coq not have Extensional Equality? ==

ConorMcbride noted that the following four properties cannot be satisfied simultaneously

 1. Extensional equality
 1. Inductive families
 1. Cannonicity
 1. Decidable type checking

Consider the following inductive family.
{{{#!coq
Inductive NatId : (nat -> nat) -> Prop :=
 mkNatId : NatId (fun x:nat => x).
}}}

Suppose that Coq had Extensional equality.  This would mean that there would be theorems such as {{{Zero_Right_Id : (fun x:nat => x+0) = (fun x:nat => x)}}}.  This could be used to make an instance of the {{{NatId}}} family.
{{{#!coq
Definition mkNatId2 : NatId (fun x:nat => x+0) :=
 (eq_ind_r NatId mkNatId Zero_Right_Id).
}}}

Because {{{mkNatId2}}} is a closed term of an inductive type, by cannonicity its normal form must begin with a constructor.  However, {{{NatId}}} only has one constructor therefore {{{mkNatId2}}} must reduce to {{{mkNatId}}} and therefore their types must also  be convertible

{{{
NatId (fun x:nat => x+0) <===> NatId (fun x:nat => x)
}}}

and therefore {{{(fun x:nat => x+0)}}} and {{{(fun x:nat => x)}}} must be convertible.  In general, this convertibility check must work for any two extensionally equal functions and that is undecidable in general.

Coq chooses to not have extensional equality by default.  Users can add an exentensionality axiom to get extensional equality by losing canonicity.  Other proof systems may make other choices.  For instance, Epigram 2 has no inductive families, while other system may drop decidable type checking.

This article is misleading. Epigram 2 is going to have inductive families upto extensional equality. I don't agree with the claim at the top. Thorsten
