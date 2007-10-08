= Using Modules for the Universal Theory of Abstract Algebra =

It is often the case that one mathematical structure is related to another mathematical structure, and can reuse part of the theory.  Take for example groups and finite groups.  Clearly a finite group is a group and therefore can make use of the universal theory of group.

== Universal Theory ==

The universal theory of groups includes the theorems that are universally quantified over groups, but that do not construct new groups as part of the proof.  For example

{{{#!coq
Theorem left_cancel_law : forall G:Group, forall (a b c:G), GroupEq G (a*b) (a*c) -> GroupEq G b c.
}}}

is part of the universal theory of groups, while the theorem stating the existence of product groups is not.

== Reusing Theory without Modules ==

It is possible to reuse the universal theory of groups and apply it to finite groups without using modules.  But the result is tedious and difficult to update.

One can define FiniteGroups and Groups in many different ways.  Let us assume for sake of argument that Groups are implemented using Setoid equality, while FiniteGroups are implemented using Leibniz equality.  In any case, every finite group is a group, so there will be some function (probably a coercion) from FiniteGroup to Group.

{{{#!coq
Coercion FiniteGroupisGroup : FiniteGroup >-> Group.
}}}

To reuse the {{{cancel_left}}} for finite groups requires restating the theorem and proving it using the original theorem

{{{#!coq
Definition cancel_left : forall G:FiniteGroup, forall (a b c:G), (a*b)=(a*c) -> b=c :=
(fun G:FiniteGroup => left_cancel_law (FiniteGroupisGroup G)).
}}}

It is necessary to repeat this process for '''every theorem''' in the universal theory of groups.  This could be a huge number of theorems.  Furthermore, every time someone adds to the universal theory of groups, it must be added to every theory that uses it.

One cannot omit this process and use left_cancel_law directly because Groups use setoid equality while FiniteGroups use Leibniz equality.  This means in the context
{{{
G : FiniteGroup
a b c : G
...
=====================
b = c
}}}

{{{apply cancel_left.}}} will not work because the inference engine cannot unify {{{b = c}}} with {{{(GroupEq G b c)}}}.

== Reusing Theory with Modules ==

One can use modules to contain and reexport the universal theory of groups.  The first task is to make a module signature for groups.  Something similar to the following

{{{#!coq
Module Type Sig.

Parameter record : Type.

Parameter universe : record -> Setoid.
Coercion universe : record >-> Setoid.

Parameter id : forall G:record, G.
Parameter inv : forall G:record, (morphism G G).
Parameter op : forall G:record, (morphism G (morphism G G)).

Axiom assoc : forall G:record, forall a b c, Seq (op G (op G a b) c) (op G a (op G b c)).
Axiom right_id : forall G:record, forall a, Seq (op G a (id G)) a.
Axiom right_inv : forall G:record, forall a, Seq (op G a (inv G a)) (id G).
End Sig.
}}}

This is a little different that a typical implementation of a group module signature because it contains a {{{record}}} parameter, and every other function takes this record as a parameter.  This is so that the theory can universally quantify over all {{{record}}}s, which means quantification over all groups.

This module signature gives access to the record and all fields of a typical group implementation, but there is no access to {{{Build_Group}}} to construct a record.  Because there is no access to {{{Build_Group}}} only the universal theory can be made from the functions in this signature.  The universal theory becomes a module functor.

{{{#!coq
Module UniversalTheory (Group : Sig).
Export Group.

Section Group.

Variable G:record.
Let op:=op G.
Let inv:=inv G.
Let id:=id G.
Let right_id : forall a, Seq (op a id) a := right_id G.
Let right_inv : forall a, Seq (op a (inv a)) id := right_inv G.
Let assoc : forall a b c, Seq (op (op a b) c) (op a (op b c)) := assoc G.

Lemma cancel_left : forall a b c, Seq (op a b) (op a c) -> (Seq b c).
Proof.
(* ... *)
Qed.

(* ... *)

End Group.

End UniversalTheory.
}}}

Using this module, the universal theory can be exported for both Groups and Finite Groups

=== Universal Theory for Groups ===

Given a definition of Group such as

{{{#!coq
Record Group : Type :=
{ universe :> Setoid
; id : universe
; inv : universe --> universe
; op : universe --> universe --> universe
; GroupProof : isGroup id inv op
}.
}}}

one can define a group signature as

{{{#!coq
Module GroupSig <: Sig.

Definition record := Group.
Definition universe := universe.
Definition id := @id.
Definition inv := @inv.
Definition op := @op.
Definition assoc := (fun x => assoc_law (GroupProof x)).
Definition right_id := (fun x => id_law (GroupProof x)).
Definition right_inv := (fun x => inv_law (GroupProof x)).
End GroupSig.
}}}

and export the universal theory with

{{{#!coq
Module GroupUniversalTheory := UniversalTheory GroupSig.
Export GroupUniversalTheory.
}}}

Then one can proceed to give non-universal theorems about Groups.

=== Universal Theory for Finite Groups ===

Given a definition of finite groups of

{{{#!coq
Record FiniteGroup : Type :=
{ order : nat
; universe := Fin order
; id : universe
; inv : universe -> universe
; op : universe -> universe -> universe
; GroupProof : isGroup id inv op
}.

Coercion universe : FiniteGroup>->Sortclass.
}}}

One can export the universal theory of groups in the same way as for groups, but a little work is required to satisfy the module signature.  This is the same work required to prove that every finite group is a group.

{{{#!coq
Module GroupSig <: Sig.

Definition record := FiniteGroup.
Definition universe := fun x => TypeSetoid (universe x).
Definition id := @id.
Definition inv := fun x => TypeSetoidFun (@inv x).
Definition op := fun x => TypeSetoidFun2 (@op x).
Definition assoc := (fun x => assoc_law (GroupProof x)).
Definition right_id := (fun x => id_law (GroupProof x)).
Definition right_inv := (fun x => inv_law (GroupProof x)).
End GroupSig.

Module GroupUniversalTheory := UniversalTheory GroupSig.
Export GroupUniversalTheory.
}}}

Now look at {{{Check cancel_left}}}

{{{#!coq
cancel_left
     : forall (G : record) (a b c : universe G),
       Seq (universe G) (op G a b) (op G a c) -> Seq (universe G) b c
}}}


Now {{{cancel_left}}} will unify with the goal in the context
{{{
G : FiniteGroup
a b c : G
...
=====================
b = c
}}}

because {{{Seq (s:=universe G) b c}}} simplifies to {{{b=c}}}.  Before this was impossible because the inference engine would have to magically infer (universe G) parameter which is now explicitly given.

So the entire universal theory of groups is available without any work.  If the universal theory is extended later, all users of that universal theory get the extended theorems automatically.
