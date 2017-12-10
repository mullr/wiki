## General

### How can I prove that two constructors are different?

You can use the `discriminate` tactic.

```coq
Coq < Inductive toto : Set := | C1 : toto | C2 : toto.

Coq < Goal C1 <> C2.

1 subgoal
  
  ============================
  C1 <> C2
```
```coq
Unnamed_thm < discriminate.
No more subgoals.
```
```coq
Unnamed_thm < Qed.
Unnamed_thm is defined
```

### During an inductive proof, how do I eliminate impossible cases of an inductive definition?

Use the `inversion` tactic.

### How can I prove that two terms in an inductive set are equal? Or different?

Have a look at `decide equality` and `discriminate` in [the Reference Manual](https://coq.inria.fr/refman).

### Why is the proof of `0 + n = n` on natural numbers trivial but the proof of `n + 0 = n` is not?

Because `+` (`plus`) on natural numbers is defined by analysis on its first argument:

```coq
Coq < Print plus.
Notation plus := Init.Nat.add
```

so the expression `0 + n` evaluates to `n`. As Coq reasons modulo evaluation of expressions, `0 + n` and `n` are
considered equal and the theorem `0 + n = n` is an instance of the reflexivity of equality. On the other side,
`n + 0` does not evaluate to `n` and a proof by induction on `n` is necessary to trigger the evaluation of `+`.

### Why is dependent elimination in `Prop` not available by default?

Simply because most of the time it is not needed. To derive a dependent elimination principle in `Prop`, use the command `Scheme` and apply the elimination scheme using the `using` option of `elim`, `destruct`, or `induction`.

### Argh! I cannot write expressions like "if n <= p then p else n", as in any programming language.

The short answer: You should use `le_lt_dec n p` instead.

The long answer: That’s right, you can’t. If you type for instance the following "definition":

```coq
Coq < Fail Definition max (n p : nat) := if n <= p then p else n.
The command has indeed failed with message:
The term "n <= p" has type "Prop" which is not a (co-)inductive type.
```

As Coq says, the term `n <= p` is a proposition, i.e. a statement that belongs to the mathematical world. There are many ways to prove such a proposition, either by some computation, or using some already proven theorems. For instance, proving 3 − 2 ≤ 2<sup>45503</sup> is very easy, using some theorems on arithmetical operations. If you compute both numbers before comparing them, you risk using a lot of time and space.

On the contrary, a function for computing the greatest of two natural numbers is an algorithm which, called on two natural numbers `n` and `p`, determines whether `n ≤ p` or `p < n`. Such a function is a _decision procedure_ for the inequality of `nat`. The possibility of writing such a procedure comes directly from decidability of the order `≤` on natural numbers.

When you write a piece of code like `if n <= p then ... else ...` in a programming language like ML or Java, a call to such a decision procedure is generated. The decision procedure is in general a primitive function, written in a low-level language, in the correctness of which you have to trust.

The Coq standard library contains a (constructive) proof of decidability of the order `≤` on `nat`: the function `le_lt_dec` of the module `Compare_dec` of library `Arith`.

The following code shows how to define correctly `min` and `max`, and prove some properties of these functions.

```coq
Coq < Require Import Compare_dec.

Coq < Definition max (n p : nat) := if le_lt_dec n p then p else n.
max is defined

Coq < Definition min (n p : nat) := if le_lt_dec n p then n else p.
min is defined

Coq < Eval compute in (min 4 7).
     = 4
     : nat

Coq < Theorem min_plus_max : forall n p, min n p + max n p  = n + p.
1 subgoal
  
  ============================
  forall n p : nat, min n p + max n p = n + p

min_plus_max < Proof.
        intros n p; 
        unfold min, max; 
        case (le_lt_dec n p);
        simpl; auto with arith.
No more subgoals.

min_plus_max < Qed.
min_plus_max is defined

Coq < Theorem max_equiv : forall n p, max n p = p <-> n <= p.

1 subgoal
  
  ============================
  forall n p : nat, max n p = p <-> n <= p

max_equiv < Proof.
              unfold max; intros n p;
              case (le_lt_dec n p);simpl; auto.

2 subgoals
  
  n : nat
  p : nat
  ============================
  n <= p -> (p = p <-> n <= p)

subgoal 2 is:
 p < n -> (n = p <-> n <= p)

max_equiv < intuition auto with arith.

1 subgoal
  
  n : nat
  p : nat
  ============================
  p < n -> (n = p <-> n <= p)

max_equiv < split.

2 subgoals
  
  n : nat
  p : nat
  l : p < n
  ============================
   n = p -> n <= p

subgoal 2 is:
 n <= p -> n = p

max_equiv < intro e; rewrite e; auto with arith.

1 subgoal
  
  n : nat
  p : nat
  l : p < n
  ============================
  n <= p -> n = p

max_equiv < intro H; absurd (p < p); eauto with arith.
No more subgoals.

max_equiv < Qed.
max_equiv is defined
```

### I wrote my own decision procedure for `≤`, which is much faster than yours, but proving theorems such as `max_equiv` seems to be quite difficult.

Your code is probably the following:

```coq
Coq < Fixpoint my_le_lt_dec (n p :nat) {struct n}: bool  :=
  match n, p with 0, _ => true
             | S n', S p' => my_le_lt_dec n' p'
             | _   , _    => false
  end.
my_le_lt_dec is defined
my_le_lt_dec is recursively defined (decreasing on 1st argument)

Coq < Definition my_max (n p:nat) := if my_le_lt_dec n p then p else n.
my_max is defined

Coq < Definition my_min (n p:nat) := if my_le_lt_dec n p then n else p.
my_min is defined
```

For instance, the computation of `my_max 567 321` is almost immediate, whereas one can't wait for the result of `max 56 32`, using Coq's `le_lt_dec`.

This is normal. Your definition is a simple recursive function which returns a boolean value. Coq's `le_lt_dec` is a _certified function_, i.e. a complex object, able not only to tell whether `n ≤ p` or `p < n`, but also of building a complete proof of the correct inequality. What makes `le_lt_dec` inefficient while computing the min and max is the building of a huge proof term.

Nevertheless, `le_lt_dec` is very useful. Its type is a strong specification, using the `sumbool` type (look at the reference manual or chapter 9 of [1]). Eliminations of the form `case (le_lt_dec n p)` provide proofs of either `n ≤ p` or `p < n`, allowing you to easily prove theorems as [above](#argh-i-cannot-write-expressions-like-if-n--p-then-p-else-n-as-in-any-programming-language). Unfortunately, this not the case of your `my_le_lt_dec`, which returns a quite non-informative boolean value.

```coq
Coq < Check le_lt_dec.
le_lt_dec
     : forall n m : nat, {n <= m} + {m < n}
```

You should keep in mind that `le_lt_dec` is useful for building certified programs which need to compare natural numbers, and is not designed to compare quickly two numbers.

Nevertheless, the _extraction_ of `le_lt_dec` towards Ocaml or Haskell, is a reasonable program for comparing two natural numbers in Peano form in linear time.

It is also possible to keep your boolean function as a decision procedure, but you have to establish yourself the relationship between `my_le_lt_dec` and the propositions `n ≤ p` and `p < n`:

```coq
Coq < Theorem my_le_lt_dec_true : 
        forall n p, my_le_lt_dec n p = true <-> n <= p.

Coq < Theorem  my_le_lt_dec_false : 
        forall n p, my_le_lt_dec n p = false <-> p < n.
```

## Recursion

### Why can't I define a non-terminating program?

Because otherwise the decidability of the type-checking algorithm (which involves evaluation of programs) could not be guaranteed. Additionally, if non-terminating proofs were allowed, we could get a proof of `False`:

```coq
Coq < (* This is fortunately not allowed! *)
      Fixpoint InfiniteProof (n:nat) : False := InfiniteProof n.

Coq < Theorem Paradox : False.

Coq < Proof (InfiniteProof O).
```

### Why are only structurally well-founded loops allowed?

The structural order on inductive types is a simple and powerful notion of termination. The consistency of the Calculus of Inductive Constructions relies on it and another consistency proof would have to be made for stronger termination arguments (such as the termination of the evaluation of CIC programs themselves!).

In spite of this, all non-pathological termination orders can be mapped to a structural order. Tools to do this are provided in the file [Wf.v](https://coq.inria.fr/stdlib/Coq.Init.Wf.html) of the standard library of Coq.

### How to define loops based on non structurally smaller recursive calls?

The procedure is as follows (we consider the definition of `mergesort` as an example).

* Define the termination order, say `R` on the type `A` of the arguments of the loop.
```coq
Coq < Definition R (a b:list nat) := length a < length b.
```
* Prove that this order is well-founded (in fact that all elements in `A` are accessible along `R`).
```coq
Coq < Lemma Rwf : well_founded R.
```
* Define the step function (which needs proofs that recursive calls are on smaller arguments).
```coq
Coq < Definition split (l : list nat) 
      : {l1: list nat | R l1 l} * {l2 : list nat | R l2 l}
      := (* ... *) .
Coq < Definition concat (l1 l2 : list nat) : list nat := (* ... *) .
Coq < Definition merge_step (l : list nat) (f: forall l':list nat, R l' l -> list nat) :=
      let (lH1,lH2) := (split l) in
      let (l1,H1) := lH1 in
      let (l2,H2) := lH2 in
      concat (f l1 H1) (f l2 H2).
```
* Define the recursive function by fixpoint on the step function.
```coq
Coq < Definition merge := Fix Rwf (fun _ => list nat) merge_step.
```

### What is behind the accessibility and well-foundedness proofs?

Well-foundedness of some relation `R` on some type `A` is defined as the accessibility of all elements of `A` along `R`.

```coq
Coq < Print well_founded.
well_founded =
fun (A : Type) (R : A -> A -> Prop) => forall a : A, Acc R a
   : forall A : Type, (A -> A -> Prop) -> Prop
Argument A is implicit
Argument scopes are [type_scope function_scope]

Coq < Print Acc.
Inductive Acc (A : Type) (R : A -> A -> Prop) (x : A) : Prop :=
    Acc_intro : (forall y : A, R y x -> Acc R y) -> Acc R x
For Acc: Argument A is implicit
For Acc_intro: Arguments A, R are implicit
For Acc: Argument scopes are [type_scope function_scope _]
For Acc_intro: Argument scopes are [type_scope function_scope _
                 function_scope]
```

The structure of the accessibility predicate is a well-founded tree branching at each node `x` in `A` along all the nodes `x'` less than `x` along `R`. Any sequence of elements of `A` decreasing along the order `R` are branches in the accessibility tree. Hence any decreasing along `R` is mapped into a structural decreasing in the accessibility tree of `R`. This is emphasised in the definition of `fix` which recurs not on its argument `x:A` but on the accessibility of this argument along `R`.

See file [Wf.v](https://coq.inria.fr/stdlib/Coq.Init.Wf.html).

### How to perform simultaneous double induction?

In general a (simultaneous) double induction is simply solved by an induction on the first hypothesis followed by an inversion over the second hypothesis. Here is an example:

```coq
Coq < Inductive even : nat -> Prop :=
        | even_O : even 0
        | even_S : forall n:nat, even n -> even (S (S n)).
even is defined
even_ind is defined

Coq < Inductive odd : nat -> Prop :=
        | odd_SO : odd 1
        | odd_S : forall n:nat, odd n -> odd (S (S n)).
odd is defined
odd_ind is defined

Coq < Lemma not_even_and_odd : forall n:nat, even n -> odd n -> False.

1 subgoal
  
  ============================
  forall n : nat, even n -> odd n -> False

not_even_and_odd < induction 1.

2 subgoals
  
  ============================
  odd 0 -> False

subgoal 2 is:
 odd (S (S n)) -> False

not_even_and_odd < inversion 1.

1 subgoal
  
  n : nat
  H : even n
  IHeven : odd n -> False
  ============================
  odd (S (S n)) -> False

not_even_and_odd < inversion 1. apply IHeven; trivial.

1 subgoal
  
  n : nat
  H : even n
  IHeven : odd n -> False
  H0 : odd (S (S n))
  n0 : nat
  H2 : odd n
  H1 : n0 = n
  ============================
  False

No more subgoals.

not_even_and_odd > Qed.
not_even_and_odd is defined
```

In case the type of the second induction hypothesis is not dependent, `inversion` can just be replaced by `destruct`.

### How to define a function by simultaneous double recursion?

The same trick applies, you can even use the pattern-matching compilation algorithm to do the work for you. Here is an example:

```coq
Coq < Fixpoint minus (n m:nat) {struct n} : nat :=
        match n, m with
        | O, _ => 0
        | S k, O => S k
        | S k, S l => minus k l
        end.
minus is defined
minus is recursively defined (decreasing on 1st argument)

Coq < Print minus.
minus =
fix minus (n m : nat) {struct n} : nat :=
  match n with
  | 0 => 0
  | S k => match m with
           | 0 => S k
           | S l => minus k l
           end
  end
      : nat -> nat -> nat
Argument scopes are [nat_scope nat_scope]
```

In case of dependencies in the type of the induction objects t<sub>1</sub> and t<sub>2</sub>, an extra argument stating t<sub>1</sub> = t<sub>2</sub> must be given to the fixpoint definition.

### How to perform nested and double induction?

To reason by nested (i.e. lexicographic) induction, just reason by induction on the successive components.

Double induction (or induction on pairs) is a restriction of the lexicographic induction. Here is an example of double induction.

```coq
Coq < Lemma nat_double_ind : 
      forall P : nat -> nat -> Prop, P 0 0 -> 
        (forall m n, P m n -> P m (S n)) ->
        (forall m n, P m n -> P (S m) n) -> 
           forall m n, P m n.
1 subgoal
  
  ============================
  forall P : nat -> nat -> Prop,
  P 0 0 ->
  (forall m n : nat, P m n -> P m (S n)) ->
  (forall m n : nat, P m n -> P (S m) n) -> forall m n : nat, P m n

nat_double_ind < intros P H00 HmS HSn; induction m.

2 subgoals
  
  P : nat -> nat -> Prop
  H00 : P 0 0
  HmS : forall m n : nat, P m n -> P m (S n)
  HSn : forall m n : nat, P m n -> P (S m) n
  ============================
  forall n : nat, P 0 n

subgoal 2 is:
 forall n : nat, P (S m) n

nat_double_ind < (* case 0 *)
                 induction n; [assumption | apply HmS; apply IHn].

1 subgoal
  
  P : nat -> nat -> Prop
  H00 : P 0 0
  HmS : forall m n : nat, P m n -> P m (S n)
  HSn : forall m n : nat, P m n -> P (S m) n
  m : nat
  IHm : forall n : nat, P m n
  ============================
  forall n : nat, P (S m) n

nat_double_ind < (* case Sm *)
                 intro n; apply HSn; apply IHm.
No more subgoals.
nat_double_ind < Qed.
nat_double_ind is defined
```

### How to define a function by nested recursion?

The same trick applies. Here is the Ackermann function as an example:

```coq
Coq < Fixpoint ack (n:nat) : nat -> nat :=
        match n with
        | O => S
        | S n' =>
            (fix ack' (m:nat) : nat :=
              match m with
              | O => ack n' 1
              | S m' => ack n' (ack' m')
              end)
        end.
ack is defined
ack is recursively defined (decreasing on 1st argument)
```

## Co-Inductive Types

I have a cofixpoint `t := F(t)` and I want to prove `t = F(t)`. How to do it?

Just case-expand `F(t)` then complete by a trivial case analysis. Here is what it gives on e.g. the type of
streams on naturals:

```coq
Coq < CoInductive Stream (A:Set) : Set :=
        Cons : A -> Stream A -> Stream A.
Stream is defined

Coq < CoFixpoint nats (n:nat) : Stream nat := Cons n (nats (S n)).
nats is defined
nats is corecursively defined

Coq < Lemma Stream_unfold :
        forall n:nat, nats n = Cons n (nats (S n)).

1 subgoal
  ============================
  forall n : nat, nats n = Cons n (nats (S n))

Stream_unfold < Proof. intro;
        change (nats n = match nats n with
                         | Cons x s => Cons x s
                         end).
1 subgoal

  n : nat
  ============================
  nats n = match nats n with
           | Cons x s => Cons x s
           end

Stream_unfold < case (nats n); reflexivity.
No more subgoals.
Stream_unfold < Qed.
Stream_unfold is defined
```

## References

[1] Yves bertot and Pierre Castéran. Coq'Art. Springer-Verlag, 2004. To appear.