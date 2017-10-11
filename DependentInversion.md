Dependent Inversion
===================

Inversion is used when you have an object of an inductively defined dependent type, whose parameters are not pure variables, but have constructors in them.  Dependent inversion is used when this object occurs inside another type, such as the goal (vector is defined here: http://coq.inria.fr/library/Coq.Bool.Bvector.html#vector) .

An Easy Case
------------

::

   P : forall n : nat, vector bool n -> Prop
   n : nat
   a : vector bool (S n)
   ______________________________________(1/1)
   P (S n) a

In this case ``dependent inversion_clear a`` does a case analysis on a, and figures out that ``a`` cannot be ``Vnil``, so it leaves only the ``Vcons`` case.

::

   P : forall n : nat, vector bool n -> Prop
   n : nat
   a0 : bool
   v : vector bool n
   ______________________________________(1/1)
   P (S n) (Vcons bool a0 n v)

Using ``Show Proof`` we can inspect the code that the inversion tactic generates.

::

    (*...*)
    let H :=
     match a as v in (vector _ n0) return (n0 = S n -> P n0 v) with
     | Vnil => (*...*)
     | Vcons a0 n0 v => (*...*)
     end in (*...*)

It is important to see that the inversion tactic has determined that the ``(S n)`` parameter of ``P`` needs to be the same as the ``(S n)`` parameter of ``Bvector`` in the type of ``a``.  So inside the MatchAsInReturn_ statement a fresh variable, ``n0``, takes the place of ``(S n)`` in the type of the return statement ``P n0 v``.

A Harder Case
-------------

Things become more difficult if another term has a type that depends on the same expression that the type to invert depends on.

::

   Q : forall n : nat, vector bool n -> vector bool n -> Prop
   n : nat
   a : vector bool (S n)
   b : vector bool (S n)
   ______________________________________(1/1)
   Q (S n) a b

Now ``a`` and ``b`` both depend on ``(S n)`` and they are linked together through ``Q`` because the one parameter ``(S n)`` in ``Q`` constrains the type of both ``a`` and ``b``.  Now ``dependent inversion_clear a`` fails with the following error.

::

   Error: Illegal application (Type Error):
   The term "Q" of type "forall n : nat, vector bool n -> vector bool n -> Prop"
   cannot be applied to the terms
    "n0" : "nat"
    "a0" : "vector bool n0"
    "b" : "vector bool (S n)"
   The 3th term has type "vector bool (S n)" which should be coercible to
    "vector bool n0"

What has happened is that, like before, the inversion has replaced the ``(S n)`` parameter to ``Q`` with a fresh variable ``n0``, but now the parameter ``b`` has the wrong type.  ``b`` has type ``(vector bool (S n)``, but needs to have the type ``(vector bool n0)``.

This problem can be solved by putting ``b`` (and everything that depends on ``b``) into the goal so that the inversion tactic knows to generalize the (S n) term occurring inside the type of ``b``.  The tactical ``generalize b; clear b; dependent inversion_clear a; intro b`` works yielding:

::

   Q : forall n : nat, vector bool n -> vector bool n -> Prop
   n : nat
   a0 : bool
   v : vector bool n
   b : vector bool (S n)
   ______________________________________(1/1)
   Q (S n) (Vcons bool a0 n v) b

A Very Hard Case
----------------

Sometimes instead of a single variable ``b``, as above, we have a complicated term.  Consider where we left off above

::

   Q : forall n : nat, vector bool n -> vector bool n -> Prop
   n : nat
   a0 : bool
   v : vector bool n
   b : vector bool (S n)
   ______________________________________(1/1)
   Q (S n) (Vcons bool a0 n v) b

Suppose, as would be common, we now want to run dependent inversion on ``b``.  This time it is the entire expression ``(Vcons bool a0 n v)`` that is linked to ``b``.  So if we do ``dependent inversion_clear b`` we get

::

   Error: Illegal application (Type Error):
   The term "Q" of type "forall n : nat, vector bool n -> vector bool n -> Prop"
   cannot be applied to the terms
    "n0" : "nat"
    "Vcons bool a0 n v" : "vector bool (S n)"
    "b0" : "vector bool n0"
   The 2nd term has type "vector bool (S n)" which should be coercible to
    "vector bool n0"

We could generalize ``(Vcons bool a0 n v)`` away, like before, and then the inversion would go through; however by doing such a generalization we would be throwing away information.  This information may be required to solve the problem.  

Instead we make a fresh variable, ``a1``, of a vector type with fresh parameters, ``m``, and a bunch of equalities to constrain the fresh variable to be equal to ``(Vcons bool a0 n v)``. 

::

   cut (forall m (a1:vector bool m) ,
           (forall p, (eq_rec m (vector bool) a1 (S n) p)=(Vcons bool a0 n v)) ->
           forall (p:(m=(S n))),
           Q (S n) (eq_rec m (vector bool) a1 (S n) p) b);
   [intro H;
    apply H with (a1:=(Vcons bool a0 n v)) (p:=(refl_equal (S n)));
    intro p;
    elim p using (K_dec_set eq_nat_dec);
    reflexivity
   |intros m a H].

This has reformulated the problem as:

::

   Q : forall n : nat, vector bool n -> vector bool n -> Prop
   n : nat
   a0 : bool
   v : vector bool n
   b : vector bool (S n)
   m : nat
   a : vector bool m
   H : forall p : m = S n, eq_rec m (vector bool) a (S n) p = Vcons bool a0 n v
   ______________________________________(1/1)
   forall p : m = S n, Q (S n) (eq_rec m (vector bool) a (S n) p) b

Because ``a1`` has type ``vector bool m`` and ``(Vcons bool a0 n v)`` has a different type ``vector bool (S n)`` we cannot directly declare them equal.  Instead we can only compare ``(eq_rec m (vector bool) a1 (S n) p)`` for some ``p : m = (S n)`` which has type ``vector bool (S n)``.  Also note this technique uses ``K_dec_set``, so the type of the dependent terms, in this case ``nat``, must be decidable.

Now we can do ``dependent inversion_clear b``.

::

   Q : forall n : nat, vector bool n -> vector bool n -> Prop
   n : nat
   a0 : bool
   v : vector bool n
   m : nat
   a : vector bool m
   H : forall p : m = S n, eq_rec m (vector bool) a (S n) p = Vcons bool a0 n v
   a1 : bool
   v0 : vector bool n
   ______________________________________(1/1)
   forall p : m = S n,
   Q (S n) (eq_rec m (vector bool) a (S n) p) (Vcons bool a1 n v0)

All that remains is to rewrite ``(eq_rec m (vector bool) a (S n) p)`` back into ``(Vcons bool a0 n v)``.  This can be done with ``intro p; rewrite H; clear H p a.``

::

   Q : forall n : nat, vector bool n -> vector bool n -> Prop
   n : nat
   a0 : bool
   v : vector bool n
   m : nat
   a1 : bool
   v0 : vector bool n
   ______________________________________(1/1)
   Q (S n) (Vcons bool a0 n v) (Vcons bool a1 n v0)

Example Source
--------------

You can follow the development of the harder and very hard cases above with the following Coq source code.

::

   Require Import Bvector.
   Require Import Eqdep_dec.
   Require Import Peano_dec.
   Goal forall (Q:forall n, vector bool n -> vector bool n -> Prop) n (a b:vector bool (S n)), Q (S n) a b.
   (* A Harder Case *)
   intros.
   generalize b;
   clear b;
   dependent inversion_clear a;
   intros b.
   Show Proof.
   (*A Very Hard Case *)
   cut (forall m (a1:vector bool m) ,
           (forall p, (eq_rec m (vector bool) a1 (S n) p)=(Vcons bool a0 n v)) ->
           forall (p:(m=(S n))),
           Q (S n) (eq_rec m (vector bool) a1 (S n) p) b);
   [intro H;
    apply H with (a1:=(Vcons bool a0 n v)) (p:=(refl_equal (S n)));
    intro p;
    elim p using (K_dec_set eq_nat_dec);
    reflexivity
   |intros m a H].
   dependent inversion_clear b.
   intro;
   rewrite H;
   clear H p a.

.. ############################################################################

.. _MatchAsInReturn: ../MatchAsInReturn

