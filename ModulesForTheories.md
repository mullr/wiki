= Using Modules for the Universal Theory of Abstract Algebra =

It is often the case that one mathematical structure is related to another mathematical structure, and can reuse part of the theory.  Take for example gorups and finite groups.  Clearly a finite group is a group and therefore can make use of the universal theory of group.

== Universal Theory ==

The universal theory of groups includes the theorems that are universally quantified over groups, but that do not construct new groups as part of the proof.  For example

{{{#!coq
Theorem left_cancel_law : forall G:Group, forall (a b c:G), GroupEq G (a*b) (a*c) -> GroupEq G b c.
}}}

is part of the universal theory of groups, while the theorem stating the existance of product groups is not.

== Reusing Theory without Modules ==

It is possible to reuse the universal theory of groups and apply it to finite groups without using modules.  But the result is tedious and difficult to update.

One can define FiniteGroups and Groups in many different ways.  Let us assume for sake of arguement that Groups are implemented using Setoid equaity, while FiniteGroups are implemented using Leibniz equality.  In any case, every finite group is a group, so there will be some function (probably a coercion) from FintiteGroup to Group.

{{{#!coq
Coercion FiniteGroupisGroup : FiniteGroup >-> Group.
}}}

To reuse the left_cancel_law for finite groups requres restating the theorem and proving it using the original theorem

{{{#!coq
Definition finite_left_cancel_law : forall G:FiniteGroup, forall (a b c:G), (a*b)=(a*c) -> b=c :=
(fun G:FiniteGroup => left_cancel_law (FiniteGroupisGroup G)).
}}}

It is neccessary to repeat this process for every theorem in the universal theory of groups.

One cannot omit this process and use left_cancel_law directly because Groups use setoid equality while FiniteGroups use Leibniz equality.  This means in the context 
{{{
G : FiniteGroup
a b c : G
=====================
b = c
}}}

{{{apply left_cancel_law.}}} will not work because the inference engine cannot unify {{{b = c}}} with {{{(GroupEq G b c)}}}.
