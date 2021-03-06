This page is for collecting wishes for Coq and possibly discuss their feasibility. For [CoqIde](CoqIde) see [CoqIDE wishes page](CoqIDEWishes). For the standard library, see [StandardLibrary](StandardLibrary) and [ReflectionOnStandardLibrary](ReflectionOnStandardLibrary)

High-level language
===================

Syntax of terms
---------------

### Support for custom numeral notations

A possible approach for printing terms of some type T as numerals is to provide two functions:

-   A Coq term of type `Z -> option T` which is used for parsing and which returns the closed term of type T corresponding to an integer (if interpretable, i.e., if T denotes e.g. positive numbers, the function will return None on negative numbers)
-   an Ltac function which analyzes if a term is closed expression in `T` and returns the corresponding term in `Z` if it is. It fails otherwise.

### Support for specific constr grammar entries

### A more expressive language for Coq binders

Note: The 2nd and 3rd examples are available from Coq 8.6.

The notion of binders could be more general than it is. For instance it would be convenient to be able to write

`Definition f x (y1,y2) z := ....` or `Definition f x ((y1,y2) as y) z := ....`

meaning

`Definition f x y z := let (y1,y2) := y in ...`

or

`Definition f x '(C y1 y2 y3) z := ....`

meaning

`Definition f x y z := let '(C y1 y2 y3) := y in ...`

or, for records, something like

`Definition f x {|snd:=y2;fst:=y1|} z := ....`

meaning

`Definition f x y z := let '(y1,y2) := y in ...`

For implicit arguments, one could force to have a surrounding '{... as y}' ??

Induction schemes
-----------------

### Extended detection of computationally-void inductive propositions

Automatically build `_rect` eliminators for inductive propositions with several constructors whose constructors have disjoint conclusions and whose constructors have only propositional (possibly recursive) arguments as in, e.g.:

```coq
Inductive le_list a : list nat -> Prop :=
  | le_list_nil : le_list a nil
  | le_list_cons b l : a <= b -> le_list a (b :: l).

Lemma le_list_inv : forall a b l, le_list a (b :: l) -> a <= b.
Proof. intros; inversion H; trivial. Defined.

Lemma le_list_rect : forall a (P : list nat -> Type),
     P nil -> (forall b l, a <= b -> P (b :: l)) -> forall l : list nat, le_list a l -> P l.
Proof. induction l; firstorder using le_list_inv. Defined.
```

### Total ordering of algebraic data-types

Automatically equip simple algebraic data-types with a canonical total ordering of it

### Equality induction principle for records

See [#6061](../issues/6061).

Coercions
---------

Coercions are from a class to another class, class being either a name, a dependent product or a sort.

A natural enhancement would be to extend classes to patterns, in such a way that e.g. `{x:nat|_}` could be seen as class and the projection of `{x:nat|_}` to `nat` be seen as coercion.

More generally, classes could be bound variables, so that e.g. the projection from `{x:A|_}` to `A` could be used as a generic coercion.

The transitive closure of coercions could then not be computed in finite time, but it could e.g. be computed lazily, or at worst dynamically.

See enhancement [#4114](../issues/4114).

Tactics
=======

Simplification tactics
----------------------

Note: command `Arguments` in version 8.4 allows to control such a reduction (e.g. `Arguments minus !n !m.`).

`simpl`, or rather a better `simpl` with a different name, should not simplify `minus O x` in the following definition:

```coq
Fixpoint minus (n m:nat) {struct n} : nat :=
   match n, m with
   | O, _ => n
   | S k, O => n
   | S k, S l => k - l
   end
```

It should wait for falling in one of the given n-ary clauses.

Injection
---------

Tactic injection should turn equations of the form "(exists P x p) = (exists P y q)" into "H : x = y" and "H': rew H in p = q" instead of keeping them as elements of sigma-types which cannot be rewritten as such. Not only this is more readable, but, then, when x or y is a variable, H can be rewritten (possibly on the fly with the "as" clause), and H' become "p = q".

Rewriting
---------

Shouldn't rewriting apply first injection and rewrite the resulting equalities so that e.g. rewrite H:(exists P x p) = (exists P y q) works on statements of the form "Q x" or "R p", where x and p do not occur as part of an exists expression?

Discriminate
------------

Should be able to work on heterogenous equalities as in:

```coq
Require Import Vector Eqdep.
Goal forall (a n : nat) (l : t nat n), eq_dep nat (t nat) 0 (nil nat) (S n) (cons nat a n l) -> False.
intros * H.
discriminate H.
```

Specialize
----------

Implicitly suggested by Iris: "specialize H with (n:=?)" could open a subgoal proving the n-th hypothesis of "H" (and specializing "H").

Referring to hypotheses by type
-------------------------------

When referring to propositional hypotheses, it would be often convenient to refer to them by type. One could for instance imagine typing "induction (le n m)" to mean induction on the (say first) hypothesis of type "(le n m)". A notation for that could be for instance "induction :(le n m)".

Optimizations
-------------

Prune the proof terms produced by tauto/intuition/omega (by removal of unnecessary steps) so that they're shorter and we can use them w/o endanger an arbitrary increase of the size of the proof.

Unification
-----------

See [CoqDevelopment/UnificationProblems](CoqDevelopment/UnificationProblems).

Inversion combined with recursion
---------------------------------

Here is an example from file [Sorted](https://coq.inria.fr/distrib/8.5pl1/stdlib/Coq.Sorting.Sorted.html) in standard library. In the proof of `Sorted_extends` one needs an inversion lemma of the following form:

```coq
Lemma inversion (P:A -> list A -> Prop)
   (base : forall a, Sorted [] -> HdRel a [] -> P a [])
   (step : forall a b l, P b l -> Sorted (b::l) -> HdRel a (b::l) -> P a (b::l)) :
   forall a l, Sorted (a::l) -> P a l.
Proof (fix f a l H :=
  match H in Sorted l return match l return Prop with [] => True | a :: l => P a l end with
  | @Sorted_cons a [] HS HH => base a HS HH
  | @Sorted_cons a (b::l) HS HH => step a b l (f b l HS) HS HH
  | @Sorted_nil => I
  end).
```

One would like that `induction` on an hypothesis of the form `Sorted (a::l)` automatically uses this schema.

See Boutillier and Braibant's [invert](https://github.com/braibant/invert) tactic for preliminary work in this direction.

The Ltac language
-----------------

Typing L\*tac\* (details to be given).

Providing functions to know the structure of inductive types, like the number of constructors (details to be given).

Support for matching terms below binders.

The Calculus of Inductive Constructions
=======================================

Support lexicographic termination in Fixpoint
---------------------------------------------

Extend the guard condition so as to support lexicographic ordering. At worst, Coq could support automatic insertion of subfixpoint in recursive function on lexicographic ordering. E.g.

```coq
Fixpoint merge l1 l2 :=
   match l1, l2 with
   | [], _ => l2
   | _, [] => l1
   | a1::l1', a2::l2' =>
       if a1 <=? a2 then a1 :: merge l1' l2 else a2 :: merge l1 l2'
   end.
```

could be accepted and produce:

```coq
Definition merge :=
   fix merge l1 l2 :=
   let fix merge_aux l2 :=
     match l1, l2 with
     | [], _ => l2
     | _, [] => l1
     | a1::l1', a2::l2' =>
         if a1 <=? a2 then a1 :: merge l1' l2 else a2 :: merge_aux l2'
   end
   in merge_aux l2.
```

This is not as useful as native support for lexicographic ordering because when exposed, `merge_aux l2` will not appear as `merge l1 l2`.

Support refolding of fixpoints in the kernel
--------------------------------------------

When unfolding a fixpoint and reducing it, we are left with a `fix` expression which in principle could be refolded when this expression is associated to a definition. What are the issues if we modify the rule for unfolding "named fixpoint" in the kernel.

Dependent mutual fixpoints
--------------------------

Support mutual fixpoints with dependencies as e.g. in:

```coq
Notation "x .1" := (projT1 x) (at level 1, left associativity, format "x .1").
Notation "x .2" := (projT2 x) (at level 1, left associativity, format "x .2").

Fixpoint f (n:nat) : Type :=
  match n with
  | 0 => unit
  | S n => {x:f n | g n x}
  end

with g (n:nat) : f n -> Prop :=
  match n with
  | 0 => fun _ => True
  | S n => fun x => g n x.1 /\ x = x
  end.
```

There is for instance an application in [constructing semi-simplicial types](http://pauillac.inria.fr/~herbelin/articles/mscs-Her14-semisimplicial.pdf). Currently, one needs to do

```coq
Fixpoint fg (n:nat) : {A:Type & A -> Prop} :=
  match n with
  | 0 => existT (fun A:Type => A -> Prop) unit (fun _ => True)
  | S n => let (fn,gn) := fg n in existT (fun A:Type => A -> Prop) {x:fn & gn x} (fun x => gn x.1 /\ x=x)
  end.

Definition f n := (fg n).1.
Definition g n := (fg n).2.
```

Recognizing uniform parameters in fixpoints
-------------------------------------------

A definition such as

```coq
Fixpoint map {A B} (f:A->B) l :=
  match l with
  | nil => nil
  | cons n l => cons (f n) (map f l)
  end.
```

cannot be used in the presence of

```coq
Inductive tree := node : nat -> list tree -> tree.
```

to define

```coq
Fixpoint map_tree f t :=
  match t with node n l => node (f n) (map (map_tree f) l) end.
```

Conversely, if one had defined map as follows:

```coq
Definition map {A B} (f:A->B) :=
  fix map l :=
  match l with
  | nil => nil
  | cons n l => cons (f n) (map l)
  end.
```

one could have define map\_tree above.

The first definition is more natural than the latter one. What is missing for the first definition to be used in map\_tree is that a fixpoint detects which of its parameters are uniform and hence substituable, as if presented with the latter form.

Relevant code is in branch Fix of function check\_rec\_call in Inductive.check\_one\_fix \[Feb 2016\].

Per-inductive parameters in mutual inductive blocks
---------------------------------------------------

A mutual inductive definition such as

```coq
Inductive Tree : bool -> Type :=
 | leaf : Tree true
 | node : forall b, TreePair b -> Tree false

with TreePair (b:bool) : Type :=
 | stp  : Tree b -> Tree b -> TreePair Tree b.
```

is not supported with the message that all parameters should be the same for all inductive type of the block. However, it can be simulated with

```coq
Inductive TreePair Tree (b:bool) : Type :=
 | stp  : Tree b -> Tree b -> TreePair Tree b.

Inductive Tree : bool -> Type :=
 | leaf : Tree true
 | node : forall b, TreePair Tree b -> Tree false.
```

Why not to provide it natively? (Agda does for instance)

See also [Coq club](http://news.gmane.org/find-root.php?message_id=%3calpine.LRH.2.00.0910161427500.28930%40theorem.ca%3e) (16 Oct 2009).

Generalizing positivity condition
---------------------------------

Positivity requirement prevents writing an inductive type of the form
```
Inductive foo :=
| Foo : forall b : bool, match bool with true => unit | false => foo end -> foo
```
because `match` blocks are always considered non-positive. Nonetheless, it is still correct to add the following clause to the strict positivity condition.

- `X` appears strictly positively in `match M as x in T return P with p₁ => u₁ | ... | pₙ => uₙ end` if
  - `X` does not appear in `T` and `P`
  - `X` appears strictly positively in `u₁` ... `uₙ`

Such a rule can be logically reduced to the use of nested inductive types, by replacing the pattern-matching clause with a parameterized inductive type whose cases encode the various branches. The above generic match can be turned into
```
Tᵣ i M
```
where
```
Inductive Tᵣ : forall (i : I) (x : T{i}), P i x -> Type :=
| cᵣ₁ => forall a₁, Tᵣ r₁ (c₁ a₁) (u₁{p₁ := a₁})
...
| cᵣₙ => forall aₙ, Tᵣ rₙ (cₙ aₙ) (uₙ{pₙ := aₙ})
```
assuming
```
Inductive T : I -> Type :=
| c₁ => forall a₁, T r₁
...
| cₙ => forall aₙ, T rₙ
```

This encoding does not provide the desired conversion rules though, which makes the pattern-matching variant better.

See #1433.

Investigation into commutative cuts
-----------------------------------

In many cases, terms could be made convertible thanks to commutative cuts, such as `(let (a,b) := x in t) u == let (a,b) := x in (t u)`.

In presence of predicate parameters (i.e. indices), commutative cuts may get quite involved. Consider the following example in context `H : x = y`:

```coq
match H in _ = z return P(z) -> Q(z) with
    eq_refl => fun H:P(x) => H'
end (t : P(y))
```

The naive commutation

```coq
match H in _ = z return P(z) -> Q(z) with
    eq_refl => (fun H:P(x) => H') t
end
```

is ill-typed but one can use the following commutation:

```coq
match H in _ = z return P(z) -> Q(z) with
  eq_refl => (fun H:P(x) => H') (match sym_eq H in _ = z return P(z) with eq_refl => t)
end
```

In presence of truly dependent pattern-matching, commutation is apparently possible only if the surrounding context is uniformly dependent on the term matched. Consider e.g.

```coq
match b as b' return P b b' -> Q b b' with
  | true => a   (* of type P b true -> Q b true *)
  | false => b  (* of type P b false-> Q b false *)
  end  t (* of type P b b)
```

we need to cast `t` into a term of type `P b true`, but how can we ensure it is possible?

Finally, traversing the fixpoints is complicated. In case of tail-recursive fixpoints, the context can directly be moved to the base case of the recursive defintion but in the general case, this seems impossible.

Making transparent the body of an opaque constant
-------------------------------------------------

Supports turning transparent a definition/proof initially declared opaque. This could e.g. be a command `Reveal cst` which definitively turns `cst` transparent (seen as an admissible rule of the CIC). (Note: Abhishek Anand started to work on a plugin which allows to replicate an existing opaque constant as a transparent one.)

Coqdoc
======

Features
--------

### Support links from within \[...\] parts of comments

E.g. support links on definition `permutation` from

`(* This is a variant of [Coq.List.List.permutation] *)`

### Index

Build up global alphabetical index of all values kind by kind (Module, Lemma, Axiom, ...)

Follow directories hierarchy : In large formalisation and in the standard library for example. Also build (module for example) index file by file and directory by directory.

### Output independant layout language

with this wiki features and :

\*

Native output format
--------------------

-   LaTeX : See the link with coq-tex
-   HTML
-   dot : graph with Lemma's name as verticle and an edge if one is used by the other. Maybe at least avoid induction principle.

Have a look to [dpdgraph-0.2](http://www-sop.inria.fr/members/Anne.Pacalet/dpdgraph/)
