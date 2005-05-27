= Module System =

== A Tutorial on Using Modules ==

Coq's module system can be used parameterise proofs over structures.  For instance rather than writing {{{min}}} and {{{max}}} functions, lemma and tactics for {{{nat}}}, {{{Z}}}, {{{Q}}}, etc., we can write the proofs once for an abstract decidable total order and then instanciate these functions, lemmas and tactics for each structure.

This tutorial uses unicode characher and hence requires the ["UTF8Module"].

{{{#!coq
Require Import utf8.
}}}

The first step is to write a {{{Module Type}}} in a file that contains the signature of the abstract structure to work from.  This will be the signature of a decidable total order.  A {{{Module Type}}} is just a listing of {{{Parameter}}}s and {{{Axiom}}}s.  In this case we also add a ["Notation"] to make the sytax nicer.

{{{#!coq
(* File: DecidableOrder.v
 * Part 1
 *)
Module Type Sig.
Parameter A : Type.
Parameter le : A ⇒ A ⇒ Prop.

Infix "≤" := le : order_scope.
Open Scope order_scope.

Axiom le_refl : ∀ x, x ≤ x.
Axiom le_antisym : ∀ x y, x ≤ y ⇒ y ≤ x ⇒ x = y.
Axiom le_trans : ∀ x y z, x ≤ y ⇒ y ≤ z ⇒ x ≤ z.
Axiom le_total : ∀ x y, {x ≤ y} + {y ≤ x}.

Parameter le_dec : ∀ x y, {x ≤ y} +{¬ x ≤ y}. 
End Sig.
}}}

Now we can write a module functor.  A module functor is a {{{Module}}} that takes one or more {{{Module}}}s of some {{{Module Type}}}s as parameters.  For example we can create a {{{Module}}} that defines a {{{min}}} function and lemmas for any {{{Module}}} that has the above {{{Module Type}}} signature.  The first thing we do is import the {{{Modle}}} parameter in order to have access to its parameters without having to use the DotNotation.  Notice that we also get access to the ["Notation"] defined in the {{{Module Type}}}.

{{{#!coq
(* File: DecidableOrder.v
 * Part 2
 *)
Module Min (Ord : Sig).
Import Ord.

Hint Resolve le_refl.

Definition min a b : A := if (le_dec a b) then a else b.

Lemma case_min : ∀ P : A ⇒ Type, ∀ x y, (x ≤ y ⇒ P x) ⇒ (y ≤ x ⇒ P y) ⇒ P (min x y).
Proof.
intros.
unfold min.
destruct (le_dec x y).
tauto.
destruct (le_total x y).
absurd (le x y); assumption.
tauto.
Qed.

Lemma min_glb : ∀ x y z, z ≤ x ⇒ z ≤ y ⇒ z ≤ min x y.
Proof.
intros.
apply case_min; tauto.
Qed.

Lemma min_sym : ∀ x y, min x y = min y x.
Proof.
intros.
set (H:=le_antisym).
do 2 apply case_min; auto.
Qed.

Lemma min_left : ∀ x y, min x y ≤ x.
Proof.
intros.
apply case_min; auto.
Qed.

Lemma min_right : ∀ x y, min x y ≤ y.
Proof.
intros.
apply case_min; auto.
Qed.

End Min.
}}}

Suppose you have a data type, such as [http://coq.inria.fr/contribs/QArith-Stern-Brocot.html Qpositive], that has a decidable total order and we want to make an instance of {{{min}}} and its lemmas for it.  We first must create a module satisfying the module signature.  The {{{<:}}} notation says that we are making a {{{Module}}} that (transparently) satisfies a given {{{Module Type}}}.  We are then required to have inside our module a list of {{{Definition}}}s and {{{Lemma}}}s that have the same name and types as those listed in the module type's signature. This work is specific to {{{Qpositive}}} and therefore it should go into a different file.

{{{#!coq
(* File: QpositiveOrder.v
 * Part 1
 *)
Require Import utf8.
Require Export Qpositive_order.
Require DecidableOrder.

Module QDecidableOrderSig <: DecidableOrder.Sig.

Definition A := Qpositive.
Definition le := Qpositive_le.
Definition le_refl := Qpositive_le_refl.
Definition le_antisym := Qpositive_le_antisym.
Definition le_trans := Qpositive_le_trans.
Definition le_total := Qpositive_le_total.
Infix "≤" := le : Qpos_scope.
Bind Scope Qpos_scope with Qpositive. 
Open Scope Qpos_scope.

Lemma le_dec : ∀ x y, {x ≤ y} +{¬ x ≤ y}.
Proof.
intros.
unfold le, Qpositive_le.
decide equality (Qpositive_le_bool x y) true.
Defined.

End QDecidableOrderSig.
}}}

To use the module functor, we must apply it to this module and give the resulting module a name.  Then we can dow whatever we want with the resulting module, such as exporting it.

{{{#!coq
Module Order := DecidableOrder.Min QDecidableOrderSig.
Export QDecidableOrderSig.
Export Order.

Print min.
}}}

{{{#!coq
min = fun a b : A => if le_dec a b then a else b
     : A ⇒  A ⇒  A
}}}

That is the basics of how to use modules.

=== Advanced Module Work ===

Suppose we want to also define a {{{max}}} function.  We could redo all the same sort of work that we did for {{{min}}}; however the proofs are all almost identical.  We would like to reuse that work we did creating {{{min}}} to also create {{{max}}}.  To accomplish this we note that {{{max}}} is dual to {{{min}}}.  That is to say that {{{max}}} is the {{{min}}} function of the reversed ordering.  For any decidable total ordering, the reverse ordering is also a decidable total ordering.  We can make a module functor that creates this dual order.
The {{{Dual}}} module defined below will take a module of our decidable total order signature, but also produce a moudle statisfying our decidable total order signature.

{{{#!coq
(* File: DecidableOrder.v
 * Part 3
 *)
Module Dual (Ord : Sig) <: Sig.
Definition A := Ord.A.
Definition le a b : Prop := Ord.le b a.

Infix "≤" := le : order_scope.
Open Scope order_scope.

Definition le_refl := Ord.le_refl.

Lemma le_antisym : ∀ x y, x ≤ y ⇒ y ≤ x ⇒ x=y.
Proof.
unfold le.
set (H:=Ord.le_antisym).
auto.
Qed.

Lemma le_trans : ∀ x y z, x ≤ y ⇒ y ≤ z ⇒ x ≤ z.
Proof.
unfold le.
intuition.
apply Ord.le_trans with y; assumption.
Qed.

Lemma le_total : ∀ x y, {x ≤ y} +{y ≤ x}.
Proof.
unfold le.
set (H:=Ord.le_total).
auto.
Defined.

Definition le_dec : ∀ x y, {x ≤ y} +{¬x ≤ y}. 
unfold le.
set (H:=Ord.le_dec).
auto.
Defined.

End Dual.
}}}

Now we create a {{{Max}}} module that imports that creates an instance of the {{{Min}}} module for the dual ordering.  We cannot just export the {{{Max}}} module because the names are all wrong.  Instead we create the proper names and types for the items in the {{{Max}}} module as follows.

{{{#!coq
(* File: DecidableOrder.v
 * Part 4
 *)
Module Max (Ord : Sig).
Import Ord.
Module DualOrd := Dual Ord.
Module Max := Min DualOrd.

Definition max := Max.min.
Definition case_max : ∀ P : A ⇒ Type, ∀ x y, (y ≤ x ⇒ P x) ⇒ (x ≤ y ⇒ P y) ⇒ P (max x y) := Max.case_min.
Definition max_lub : ∀ x y z, x ≤ z ⇒ y ≤ z ⇒ max x y ≤ z := Max.min_glb.
Definition max_sym : ∀ x y, max x y = max y x := Max.min_sym.
Definition max_left : ∀ x y, x ≤ (max x y) := Max.min_left.
Definition max_right : ∀ x y, y ≤ (max x y) := Max.min_right.
End Max.
}}}

Finally we can create a single module that exports both the {{{Min}}} and {{{Max}}} modules.

{{{#!coq
(* File: DecidableOrder.v
 * Part 5
 *)
Module MinMax (Ord : Sig).
Export Ord.

Module MinOrd := Min Ord.
Export MinOrd.

Module MaxOrd := Max Ord.
Export MaxOrd.
End MinMax.
}}}
