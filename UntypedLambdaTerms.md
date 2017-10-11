This work is inspired by the article [De Bruijn Notation as a Nested Datatype](http://www.soi.city.ac.uk/~ross/papers/debruijn.html) by Richard Bird and Ross Paterson. Journal of Functional Programming, 9(1):77-91, January 1999.

In this paper they define the following Haskell datatype:

    data Term v = Var v | App (Term v) (Term v) | Lam (Term (Maybe v))

for lambda expression. For example K = λx. λy. x = λ λ 1 would be

    Lam (Lam (Just Nothing))

A data type for generalized de Bruijn notation is also given.

    data TermE a = VarE a
                 | AppE (TermE a) (TermE a)
                 | LamE (TermE (Maybe (TermE a)))

Both data types, along with suitable functions, are monads, and have return, bind, and join operations.

A generic recursion function called `gfold` is created for these data types.

I give several examples of data types to represent untyped lambda calculus terms.

    Set Implicit Arguments.
    Set Contextual Implicit.
    (*This is the same as option, but at the type level*)
    Inductive Maybe (A : Type) : Type :=
     | Nothing : Maybe A
     | Just : A -> Maybe A.
    (*Maybe is also a monad*)
    Definition lift_Maybe A B (h : A -> B) (t : Maybe A) : (Maybe B) :=
      match t with
      | Nothing => Nothing
      | Just a => Just (h a)
      end.

Non-uniform De Bruijn Indices
=============================

Properties
----------

-   -   Is a Monad.
-   -   Bound and Free Variables work in the same way.
-   -   Variables can be over any Set.
-   -   `(Term Empty_Set)` are closed terms.
-   -   Even better polymorphic `(Term A)` are also closed terms and can be instantiated for any set of variables.
-   -   Join is not definable without impredicative Set.

<!-- -->

    Module NonUniform_De_Bruijn.
    Inductive Term : Type -> Type :=
     | Var : forall A, A -> Term A
     | App : forall A, Term A -> Term A -> Term A
     | Lam : forall A, Term (Maybe A) -> Term A.
    (* Examples *)
    Definition I A : Term A := Lam (Var Nothing).
    Definition K A : Term A := Lam (Lam (Var (Just Nothing))).
    Definition S A : Term A :=
    Lam (Lam (Lam
    (App
     (App (Var (Just (Just Nothing))) (Var Nothing))
     (App (Var (Just Nothing)) (Var Nothing))))).                               
    (* It is to define lift then bind, even though lift could be defined in terms of bind. *)
    This code was created by GeorgesGonthier. *)
    Fixpoint lift_Term A B (h : A -> B) (t : Term A) {struct t} : Term B :=
      (match t in Term A return (A -> B) -> Term B with
      | Var _ x     => fun h => Var (h x)
      | App _ t1 t2 => fun h => App (lift_Term h t1) (lift_Term h t2)
      | Lam _ t1    => fun h => Lam (lift_Term (lift_Maybe h) t1)
      end) h.
    Fixpoint bind_Term A B (t : Term A) {struct t} : (A -> Term B) -> Term B
    :=
      match t in Term A return (A -> Term B) -> Term B with
      | Var _ x => fun h => h x
      | App _ t1 t2 => fun h => App (bind_Term t1 h) (bind_Term t2 h)
      | Lam _ t1 => fun h => Lam (bind_Term t1 (fun x =>
        match x with
        | Nothing => Var Nothing
        | Just y => lift_Term (@Just B) (h y)
        end))
      end.
    Section Gfold.
    (*In principle operations on terms, such as bind, should be
    definable using gfold *)
    Variable M N : Type -> Type.
    Variable v : forall A, M A -> N A.
    Variable a : forall A, N A -> N A -> N A.
    Variable f : forall A, N (Maybe A) -> N A.
    Variable k : forall A, Maybe (M A) -> M (Maybe A).
    Fixpoint gfold_lift A (t : Term A) B {struct t} : (A -> M B) -> N B
    :=
      match t in Term A return (A -> M B) -> N B with
      | Var _ x     => fun h => v (h x)
      | App _ t1 t2 => fun h => a (gfold_lift t1 h) (gfold_lift t2
    h)
      | Lam _ t1    => fun h => f (gfold_lift t1 (fun x => k (lift_Maybe h
    x)))
      end.
    Definition gfold A t : N A := gfold_lift t (fun x => x).
    End Gfold.
    (* Join cannot be defined without impredicative set *)
    End NonUniform_De_Bruijn.

Non-uniform Generalized de Bruijn Indices
=========================================

This definition does not work because the occurence of `Term` inside `(Maybe (Term A))` doesn't meet Coq's [PositivityRequirement](../PositivityRequirement). And even if it did `(Term (Maybe (Term A)))` would probably require [ImpredicativeSet](../ImpredicativeSet).

    Module NonUniform_Generalized_De_Bruijn.
    (* THIS DOESN'T WORK
    Inductive Term : Type -> Type :=
     | Var : forall A, A -> Term A
     | App : forall A, Term A -> Term A -> Term A
     | Lam : forall A, Term (Maybe (Term A)) -> Term A.
    *)
    End NonUniform_Generalized_De_Bruijn.

Dependent Generalized de Bruijn Indices
=======================================

This is also known as the adbmal calculus. See [DimitriHendriks](../DimitriHendriks).

Properties
----------

-   -   `(Term 0)` are closed terms
-   -   `(Term n)` are terms with n free varables.
-   -   Bound and Free variables are handled the same way.
-   -   Only finite number of free variables, and they must be given numbers.
-   -   Not a Monad.

<!-- -->

    Module Dependent_Generalized_De_Bruijn.
    Inductive Term : nat -> Set :=
    | Var : forall n:nat, Term (S n)
    | App : forall n:nat, Term n -> Term n -> Term n
    | Lam : forall n:nat, Term (S n) -> Term n
    | Succ : forall n:nat, Term n -> Term (S n).
    (* Examples *)
    Definition I : Term 0 := Lam Var.
    Definition K : Term 0 := Lam (Lam (Succ Var)).
    Definition S : Term 0 :=
    Lam (Lam (Lam
    (App
     (App (Succ (Succ Var)) Var)
     (App (Succ Var) Var)))).
    End Dependent_Generalized_De_Bruijn.

Dependent Generalized de Bruijn Indices with Free Variables
===========================================================

Properties
----------

-   -   `(Term Empty_Set 0)` are closed terms
-   -   Any Set can make the free variables.
-   -   Is a Monad I think.
-   -   I think Join is definable.
-   -   Bound and free variables are handled different ways.
-   -   `(Term A n)` has named free variable and n numbered free variables.

<!-- -->

    Module Dependent_Generalized_De_Bruijn_Free_Variables.
    Inductive Term (A:Set) : nat -> Set :=
    | Free : A -> Term A 0
    | Var : forall n:nat, Term A (S n)
    | App : forall n:nat, Term A n -> Term A n -> Term A n
    | Lam : forall n:nat, Term A (S n) -> Term A n
    | Succ : forall n:nat, Term A n -> Term A (S n).
    Definition I A : Term A 0 := Lam Var.
    Definition K A : Term A 0 := Lam (Lam (Succ Var)).
    Definition S A : Term A 0 :=
    Lam (Lam (Lam
    (App
     (App (Succ (Succ Var)) Var)
     (App (Succ Var) Var)))).
    End Dependent_Generalized_De_Bruijn_Free_Variables.

De Bruijn Indices
=================

Properties
----------

-   -   Bound and free variables are handled the same way.
-   -   Infinite number of free varaibles.
-   -   Always an infinite number of free varaibles.
-   -   No type for closed Terms.
-   -   All free variables are numbered.
-   -   Not a Monad.

<!-- -->

    Module De_Bruijn.
    Inductive Term : Set :=
    | Var : nat -> Term
    | App : Term -> Term -> Term
    | Lam : Term -> Term.
    Definition I : Term  := Lam (Var O).
    Definition K : Term := Lam (Lam (Var (S O))).
    Definition S : Term :=
    Lam (Lam (Lam
    (App
     (App (Var (S (S O))) (Var O))
     (App (Var (S O)) (Var O))))).
    End De_Bruijn.

De Bruijn Indices with Free Variables
=====================================

Properties
----------

-   -   Any Set can make the free variables.
-   -   Is a Monad I think.
-   -   I think Join is definable.
-   -   Bound and free variables are handled different ways.
-   -   No type for closed Terms.
-   -   Bad Terms exist with de Bruijn indices that refer to non-existent lambdas.

<!-- -->

    Module De_Bruijn_Free_Variables.
    Inductive Term (A:Set) : Set :=
    | Free : A -> Term A
    | Var : nat -> Term A
    | App : Term A -> Term A -> Term A
    | Lam : Term A -> Term A.
    Definition I A : Term A := Lam (Var O).
    Definition K A : Term A := Lam (Lam (Var (S O))).
    Definition S A : Term A :=
    Lam (Lam (Lam
    (App
     (App (Var (S (S O))) (Var O))
     (App (Var (S O)) (Var O))))).
    End De_Bruijn_Free_Variables.
