## My goal is ..., how can I prove it?

### My goal is a conjunction, how can I prove it?

Use some theorem or assumption or use the `split` tactic:

```coq
Coq < Goal forall A B:Prop, A->B-> A/\B.

1 subgoal

  ============================
  forall A B : Prop, A -> B -> A /\ B

Unnamed_thm < intros.

1 subgoal
  
  A : Prop
  B : Prop
  H : A
  H0 : B
  ============================
  A /\ B

Unnamed_thm < split.

2 subgoals
  
  A : Prop
  B : Prop
  H : A
  H0 : B
  ============================
  A
subgoal 2 is:
 B

Unnamed_thm < assumption.

1 subgoal
  
  A : Prop
  B : Prop
  H : A
  H0 : B
  ============================
  B

Unnamed_thm < assumption.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```
### My goal contains a conjunction as an hypothesis, how can I use it?

If you want to decompose your hypothesis into other hypothesis you can use the `decompose` tactic:

```coq
Coq < Goal forall A B:Prop, A /\ B-> B.

1 subgoal
  
  ============================
  forall A B : Prop, A /\ B -> B

Unnamed_thm < intros.

1 subgoal
  
  A : Prop
  B : Prop
  H : A /\ B
  ============================
  B

Unnamed_thm < decompose [and] H.

1 subgoal
  
  A : Prop
  B : Prop
  H : A /\ B
  H0 : A
  H1 : B
  ============================
  B

Unnamed_thm < assumption.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

You can also perform the destruction at the time of introduction:

```coq
Coq < Goal forall A B:Prop, A /\ B -> B.

1 subgoal

  ============================
  forall A B : Prop, A /\ B -> B

Unnamed_thm < intros A B [H1 H2].

1 subgoal

  A, B : Prop
  H1 : A
  H2 : B
  ============================
  B

Unnamed_thm < assumption.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### My goal is a disjunction, how can I prove it?

You can prove the left part or the right part of the disjunction using the `left` or `right` tactics. If you want to do a classical reasoning step, use the `classic` axiom to prove the right part with the assumption that the left part of the disjunction is false.

```coq
Coq < Goal forall A B:Prop, A-> A\/B.

1 subgoal
  
  ============================
  forall A B : Prop, A -> A \/ B

Unnamed_thm < intros.

1 subgoal
  
  A : Prop
  B : Prop
  H : A
  ============================
  A \/ B

Unnamed_thm < left.

1 subgoal
  
  A : Prop
  B : Prop
  H : A
  ============================
  A

Unnamed_thm < assumption.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

An example using classical reasoning:

```coq
Coq < Require Import Classical.

Coq < Ltac classical_right := 
      match goal with 
      | _:_ |-?X1 \/ _ => (elim (classic X1);intro;[left;trivial|right])
      end.
classical_right is defined

Coq < Ltac classical_left := 
      match goal with 
      | _:_ |- _ \/?X1 => (elim (classic X1);intro;[right;trivial|left])
      end.
classical_left is defined

Coq < Goal forall A B:Prop, (~A -> B) -> A \/ B.

1 subgoal
  
  ============================
  forall A B : Prop, (~ A -> B) -> A \/ B

Unnamed_thm < intros.

1 subgoal
  
  A : Prop
  B : Prop
  H : ~ A -> B
  ============================
  A \/ B

Unnamed_thm < classical_right.

1 subgoal
  
  A : Prop
  B : Prop
  H : ~ A -> B
  H0 : ~ A
  ============================
  B

Unnamed_thm < auto.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### My goal is an universally quantified statement, how can I prove it?

Use some theorem or assumption or introduce the quantified variable in the context using the `intro` tactic. If there are several variables you can use the `intros` tactic. A good habit is to provide names for these variables: Coq will do it anyway, but such automatic naming decreases legibility and robustness.

### My goal contains an universally quantified statement, how can I use it?

If the universally quantified assumption matches the goal you can use the `apply` tactic. If it is an
equation you can use the `rewrite` tactic. Otherwise you can use the `specialize` tactic to instantiate
the quantified variables with terms. The variant `assert(Ht := H t)` makes a copy of assumption `H`
before instantiating it.

### My goal is an existential, how can I prove it?

Use some theorem or assumption or exhibit the witness using the `exists` tactic.

```coq
Coq < Goal exists x:nat, forall y, x + y = y.

1 subgoal
  
  ============================
  exists x : nat, forall y : nat, x + y = y

Unnamed_thm < exists 0.

1 subgoal
  
  ============================
  forall y : nat, 0 + y = y

Unnamed_thm < intros.

1 subgoal
  
  y : nat
  ============================
  0 + y = y

Unnamed_thm < auto.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### My goal is solvable by some lemma, how can I prove it?

Just use the `apply` tactic.

```coq
Coq < Lemma mylemma : forall x, x + 0 = x.

1 subgoal
  
  ============================
  forall x : nat, x + 0 = x

mylemma < auto.
No more subgoals.

mylemma < Qed.
mylemma is defined

Coq < Goal 3 + 0 = 3.
1 subgoal
  
  ============================
  3 + 0 = 3

Unnamed_thm < apply mylemma.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### My goal contains `False` as a hypothesis, how can I prove it?

You can use the `contradiction` or `intuition` tactics.

### My goal is an equality of two convertible terms, how can I prove it?

Just use the `reflexivity` tactic.

```coq
Coq < Goal forall x, 0 + x = x.

1 subgoal
  
  ============================
  forall x : nat, 0 + x = x

Unnamed_thm < intros.

1 subgoal
  
  x : nat
  ============================
  0 + x = x

Unnamed_thm < reflexivity.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### My goal is `a let x := a in ...` , how can I prove it?

Just use the `intro` tactic.

### My goal is `a let (a, ..., b) := c in`, how can I prove it?

Just use the `destruct c as (a,...,b)` tactic.

### My goal contains some existential hypotheses, how can I use it?

As with conjunctive hypotheses, you can use the `destruct` tactic or the `intros` tactic to decompose
them into several hypotheses.

```coq
Coq < Require Import Arith.

Coq < Goal forall x, (exists y, x * y = 1) -> x = 1.

1 subgoal
  ============================
  forall x : nat, (exists y : nat, x * y = 1) -> x = 1

Unnamed_thm < intros x [y H].

1 subgoal

  x, y : nat
  H : x * y = 1
  ============================
  x = 1

Unnamed_thm < apply mult_is_one in H.

1 subgoal

  x, y : nat
  H : x = 1 /\ y = 1
  ============================
  x = 1

Unnamed_thm < easy.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### My goal is an equality, how can I swap the left and right hand terms?

Just use the `symmetry` tactic.

```coq
Coq < Goal forall x y : nat, x = y -> y = x.

1 subgoal
  
  ============================
  forall x y : nat, x = y -> y = x

Unnamed_thm < intros.

1 subgoal
  
  x : nat
  y : nat
  H : x = y
  ============================
  y = x

Unnamed_thm < symmetry.

1 subgoal
  
  x : nat
  y : nat
  H : x = y
  ============================
  x = y

Unnamed_thm < assumption.
No more subgoals.

Unnamed_thm  < Qed.
Unnamed_thm is defined
```

### My hypothesis is an equality, how can I swap the left and right hand terms?

Just use the `symmetry in` tactic.

```coq
Coq < Goal forall x y : nat, x=y -> y=x.

1 subgoal
  
  ============================
  forall x y : nat, x = y -> y = x

Unnamed_thm < intros.

1 subgoal
  
  x : nat
  y : nat
  H : x = y
  ============================
  y = x

Unnamed_thm < symmetry in H.

1 subgoal
  
  x : nat
  y : nat
  H : y = x
  ============================
  y = x

Unnamed_thm < assumption.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### My goal would be solvable using `apply;assumption` if it would not create meta-variables, how can I prove it?

You can use `eapply yourtheorem;eauto` but it won't work in all cases! (for example if more than one hypothesis matches one of the subgoals generated by `eapply`) so you should rather use `try solve [eapply yourtheorem;eauto]`, otherwise some metavariables may be incorrectly instantiated.

```coq
Coq < Lemma trans : forall x y z : nat, x=y -> y=z -> x=z.

1 subgoal
  
  ============================
  forall x y z : nat, x = y -> y = z -> x = z

trans < intros.

1 subgoal
  
  x, y, z : nat
  H : x = y
  H0 : y = z
  ============================
  x = z

trans < transitivity y;assumption.
No more subgoals.

trans < Qed.
trans is defined

Coq < Goal forall x y z : nat, x=y -> y=z -> x=z.

1 subgoal
  
  ============================
  forall x y z : nat, x = y -> y = z -> x = z

Unnamed_thm < intros.

1 subgoal
  
  x, y, z : nat
  H : x = y
  H0 : y = z
  ============================
  x = z

Unnamed_thm < eapply trans;eauto.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined

Coq < Goal forall x y z t : nat, x=y -> x=t -> y=z -> x=z.

1 subgoal
  
  ============================
  forall x y z t : nat, x = y -> x = t -> y = z -> x = z

Unnamed_thm0 < intros.

1 subgoal
  
  x, y, z, t : nat
  H : x = y
  H0 : x = t
  H1 : y = z
  ============================
  x = z

Unnamed_thm0 < eapply trans;eauto.

1 subgoal
  
  x, y, z, t : nat
  H : x = y
  H0 : x = t
  H1 : y = z
  ============================
  t = z

Unnamed_thm0 < Undo.

1 subgoal
  
  x, y, z, t : nat
  H : x = y
  H0 : x = t
  H1 : y = z
  ============================
  x = z

Unnamed_thm0 < eapply trans.

2 subgoals
  
  x, y, z, t : nat
  H : x = y
  H0 : x = t
  H1 : y = z
  ============================
   x = ?y

subgoal 2 is:
 ?y = z

Unnamed_thm0 < apply H.

1 subgoal
  
  x, y, z, t : nat
  H : x = y
  H0 : x = t
  H1 : y = z
  ============================
  y = z

Unnamed_thm0 < auto.
No more subgoals.

Unnamed_thm0 < Qed.
Unnamed_thm0 is defined

Coq < Goal forall x y z t : nat, x=y -> x=t -> y=z -> x=z.

1 subgoal
  
  ============================
  forall x y z t : nat, x = y -> x = t -> y = z -> x = z

Unnamed_thm1 < intros.

1 subgoal
  
  x, y, z, t : nat
  H : x = y
  H0 : x = t
  H1 : y = z
  ============================
  x = z

Unnamed_thm1 < eapply trans;eauto.

1 subgoal
  
  x, y, z, t : nat
  H : x = y
  H0 : x = t
  H1 : y = z
  ============================
  t = z

Unnamed_thm1 < Undo.

1 subgoal
  
  x, y, z, t : nat
  H : x = y
  H0 : x = t
  H1 : y = z
  ============================
  x = z

Unnamed_thm1 < try solve [eapply trans;eauto].

1 subgoal
  
  x, y, z, t : nat
  H : x = y
  H0 : x = t
  H1 : y = z
  ============================
  x = z

Unnamed_thm1 < eapply trans.

2 subgoals
  
  x, y, z, t : nat
  H : x = y
  H0 : x = t
  H1 : y = z
  ============================
  x = ?y

subgoal 2 is:
 ?y = z

Unnamed_thm1 < apply H.
1 subgoal
  
  x , y, z, t : nat
  H : x = y
  H0 : x = t
  H1 : y = z
  ============================
  y = z

Unnamed_thm1 < auto.
No more subgoals.

Unnamed_thm1 < Qed.
Unnamed_thm1 is defined
```

### My goal is solvable by some lemma within a set of lemmas and I don't want to remember which one, how can I prove it?

You can use what is called a "hints' base".

```coq
Coq < Require Import ZArith.
Coq < Require Ring.
Coq < Local Open Scope Z_scope.

Coq < Lemma toto1 : 1 + 1 = 2.

1 subgoal
  
  ============================
  1 + 1 = 2

toto1 < ring.
No more subgoals.

toto1 < Qed.
toto1 is defined

Coq < Lemma toto2 : 2 + 2 = 4.

1 subgoal
  
  ============================
  2 + 2 = 4

toto2 < ring.
No more subgoals.

toto2 < Qed.
toto2 is defined

Coq < Lemma toto3 : 2 + 1 = 3.

1 subgoal
  
  ============================
  2 + 1 = 3

toto3 < ring.
No more subgoals.

toto3 < Qed.
toto3 is defined

Coq < Hint Resolve toto1 toto2 toto3 : mybase.
Coq < Goal 2+(1+1)=4. 
1 subgoal
  
  ============================
   2 + (1 + 1) = 4

Unnamed_thm < auto with mybase.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### My goal is one of the hypotheses, how can I prove it?

Use the `assumption` tactic.

```coq
Coq < Goal 1 = 1 -> 1 = 1.

1 subgoal
  
  ============================
  1 = 1 -> 1 = 1

Unnamed_thm < intro.

1 subgoal
  
  H : 1 = 1
  ============================
  1 = 1

Unnamed_thm < assumption.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### My goal appears twice in the hypotheses and I want to choose which one is used, how can I do it?

Use the `exact` tactic.

```coq
Coq < Goal 1 = 1 -> 1 = 1 -> 1 = 1.

1 subgoal
  
  ============================
  1 = 1 -> 1 = 1 -> 1 = 1

Unnamed_thm < intros.

1 subgoal
  
  H : 1 = 1
  H0 : 1 = 1
  ============================
  1 = 1

Unnamed_thm < exact H0.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### What is the difference between applying one hypothesis or another in the context of the last question?

From a proof point of view it is equivalent but if you want to extract a program from your proof, the two hypotheses can lead to different programs.

### My goal is a propositional tautology, how can I prove it?

Just use the `tauto` tactic.

```coq
Coq < Goal forall A B:Prop, A -> (A \/ B) /\ A.

1 subgoal
  
  ============================
  forall A B : Prop, A -> (A \/ B) /\ A

Unnamed_thm < intros.

1 subgoal
  
  A : Prop
  B : Prop
  H : A
  ============================
  (A \/ B) /\ A

Unnamed_thm < tauto.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### My goal is a first order formula, how can I prove it?

Just use the semi-decision tactic `firstorder`.

### My goal is solvable by a sequence of rewrites, how can I prove it?

Just use the `congruence` tactic.

```coq
Coq < Goal forall a b c d e, a = d -> b = e -> c + b = d -> c + e = a.

1 subgoal
  
  ============================
  forall a b c d e : Z, a = d -> b = e -> c + b = d -> c + e = a

Unnamed_thm < intros.

1 subgoal
  
  a, b, c, d, e : Z
  H : a = d
  H0 : b = e
  H1 : c + b = d
  ============================
  c + e = a

Unnamed_thm < congruence.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### My goal is a disequality solvable by a sequence of rewrites, how can I prove it?

Just use the `congruence` tactic.

```coq
Coq < Goal forall a b c d, a <> d -> b = a -> d = c + b -> b <> c + b.

1 subgoal
  
  ============================
  forall a b c d : Z, a <> d -> b = a -> d = c + b -> b <> c + b

Unnamed_thm < intros.

1 subgoal
  
  a, b, c, d : Z
  H : a <> d
  H0 : b = a
  H1 : d = c + b
  ============================
  b <> c + b

Unnamed_thm < congruence.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### My goal is an equality on some ring (e.g. natural numbers), how can I prove it?

Just use the `ring` tactic.

```coq
Coq < Require Import ZArith.
Coq < Require Ring.
Coq < Local Open Scope Z_scope.

Coq < Goal forall a b : Z, (a + b) * (a + b) = a * a + 2 * a * b + b * b. 

1 subgoal
  
  ============================
  forall a b : Z, (a + b) * (a + b) = a * a + 2 * a * b + b * b

Unnamed_thm < intros.

1 subgoal
  
  a, b : Z
  ============================
  (a + b) * (a + b) = a * a + 2 * a * b + b * b

Unnamed_thm < ring.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### My goal is an equality on some field (e.g. real numbers), how can I prove it?

Just use the `field` tactic.

```coq
Coq < Require Import Reals.
Coq < Require Ring.
Coq < Local Open Scope R_scope.

Coq < Goal forall a b : R, b * a <> 0 -> (a / b) * (b / a) = 1.

1 subgoal
  
  ============================
  forall a b : R, b * a <> 0 -> a / b * (b / a) = 1

Unnamed_thm < intros.

1 subgoal
  
  a, b : R
  H : b * a <> 0
  ============================
  a / b * (b / a) = 1

Unnamed_thm < field.

1 subgoal
  
  a, b : R
  H : b * a <> 0
  ============================
  a <> 0 /\ b <> 0

Unnamed_thm < split ; auto with real.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### My goal is an inequality on integers in Presburger's arithmetic (an expression built from `+`, `-`, constants and variables), how can I prove it?

```coq
Coq < Require Import ZArith.
Coq < Require Omega.
Coq < Local Open Scope Z_scope.

Coq < Goal forall a : Z, a > 0 -> a + a > a. 

1 subgoal
  
  ============================
  forall a : Z, a > 0 -> a + a > a

Unnamed_thm < intros.

1 subgoal
  
  a : Z
  H : a > 0
  ============================
  a + a > a

Unnamed_thm < omega.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```
### My goal is an equation solvable using equational hypothesis on some ring (e.g. natural numbers), how can I prove it?

You need the `gb` tactic (see Loïc Pottier's homepage).

## Tactics usage

### I want to state a fact that I will use later as a hypothesis, how can I do it?

If you want to use forward reasoning (first proving the fact and then using it) you just need to use the `assert` tactic. If you want to use backward reasoning (proving your goal using an assumption and then proving the assumption) use the `cut` tactic.

```coq
Coq < Goal forall A B C D : Prop, (A -> B) -> (B -> C) -> A -> C.

1 subgoal
  
  ============================
  forall A B C : Prop, Prop -> (A -> B) -> (B -> C) -> A -> C

Unnamed_thm < intros.

1 subgoal
  
  A, B, C, D : Prop
  H : A -> B
  H0 : B -> C
  H1 : A
  ============================
  C

Unnamed_thm < assert (A -> C).

2 subgoals
  
  A, B, C, D : Prop
  H : A -> B
  H0 : B -> C
  H1 : A
  ============================
  A -> C

subgoal 2 is:
 C

Unnamed_thm < intro;apply H0;apply H;assumption.

1 subgoal
  
  A, B, C, D : Prop
  H : A -> B
  H0 : B -> C
  H1 : A
  H2 : A -> C
  ============================
  C

Unnamed_thm < apply H2.

1 subgoal
  
  A, B, C, D : Prop
  H : A -> B
  H0 : B -> C
  H1 : A
  H2 : A -> C
  ============================
  A

Unnamed_thm < assumption.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined

Coq < Goal forall A B C D : Prop, (A -> B) -> (B -> C) -> A -> C.

1 subgoal
  
  ============================
  forall A B C : Prop, Prop -> (A -> B) -> (B -> C) -> A -> C

Unnamed_thm0 < intros.

1 subgoal
  
  A, B, C, D : Prop
  H : A -> B
  H0 : B -> C
  H1 : A
  ============================
  C

Unnamed_thm0 < cut (A -> C).

2 subgoals
  
  A, B, C, D : Prop
  H : A -> B
  H0 : B -> C
  H1 : A
  ============================
  (A -> C) -> C

subgoal 2 is:
 A -> C

Unnamed_thm0 < intro.

2 subgoals
  
  A, B, C, D : Prop
  H : A -> B
  H0 : B -> C
  H1 : A
  H2 : A -> C
  ============================
   C

subgoal 2 is:
 A -> C

Unnamed_thm0 < apply H2;assumption.

1 subgoal
  
  A, B, C, D : Prop
  H : A -> B
  H0 : B -> C
  H1 : A
  ============================
  A -> C

Unnamed_thm0 < intro;apply H0;apply H;assumption.
No more subgoals.

Unnamed_thm0 < Qed.
Unnamed_thm0 is defined
```

### I want to state a fact that I will use later as an hypothesis and prove it later, how can I do it?

You can use `cut` followed by `intro` or you can use the following Ltac command:

```coq
Ltac assert_later t := cut t;[intro|idtac]. 
```

### What is the difference between `Qed` and `Defined`?
These two commands perform type checking, but when `Defined` is used the new definition is set as transparent, otherwise it is defined as opaque (see [this section of the Glossary](Glossary#what-is-the-difference-between-opaque-and-transparent)).

### How can I know what an automation tactic does in my example?
You can use its `info` variant: info_auto, info_trivial, info_eauto.

### Why doesn't `auto` work? How can I fix it?

You can increase the depth of the proof search or add some lemmas in the base of hints. Perhaps you
may need to use `eauto`.

### What is `eauto`?

This is the same tactic as `auto`, but it relies on `eapply` instead of `apply`.

### How can I speed up `auto`?

You can use `info auto` to replace `auto` by the tactics it generates. You can split your hint bases into
smaller ones.

### What is the equivalent of `tauto` for classical logic?

Currently there are no equivalent tactic for classical logic. You can use Gödel's "not not" translation.

### I want to replace some term with another in the goal, how can I do it?

If one of your hypothesis (say `H`) states that the terms are equal you can use the `rewrite` tactic. Otherwise you can use the `replace with` tactic.

### I want to replace some term with another in an hypothesis, how can I do it?

You can use the `rewrite in` tactic.

### I want to replace some symbol with its definition, how can I do it?

You can use the `unfold` tactic.

### How can I reduce some term?

You can use the `simpl` tactic.

### How can I declare a shortcut for some term?

You can use the `set` or `pose` tactics.

### How can I perform case analysis?

You can use the `case` or `destruct` tactics.

### How can I prevent the `case` tactic from losing information?

You may want to use the (now standard) `case_eq` tactic. See page 159 of the book _Coq’Art_.

### Why should I name my intros?

When you use the `intro` tactic you don't have to give a name to your hypothesis. If you do so the name will be generated by Coq but your scripts may be less robust. If you add some hypothesis to your theorem (or change their order), you will have to change your proof to adapt to the new names.

### How can I automatize the naming?
You can use the `Show Intro` or `Show Intros` commands to generate the names and use your editor to generate a fully named `intro` tactic. This can be automatized within `xemacs`.

```coq
Coq < Goal forall A B C : Prop, A -> B -> C -> A /\ B /\ C.

1 subgoal
  
  ============================
  forall A B C : Prop, A -> B -> C -> A /\ B /\ C

Unnamed_thm < Show Intros.
A B C H H0 H1

Unnamed_thm < (* A B C H H0 H1 *)
              intros A B C H H0 H1.

1 subgoal
  
  A, B, C : Prop
  H : A
  H0 : B
  H1 : C
  ============================
  A /\ B /\ C

Unnamed_thm < repeat split;assumption.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### I want to automatize the use of some tactic, how can I do it?

You need to use the `proof with T` command and add `...` at the end of your sentences. For instance:

```coq
Coq < Goal forall A B C : Prop, A -> B /\ C -> A /\ B /\ C.

1 subgoal
  
  ============================
  forall A B C : Prop, A -> B /\ C -> A /\ B /\ C

Unnamed_thm < Proof with assumption.

1 subgoal

  ============================
  forall A B C : Prop, A -> B /\ C -> A /\ B /\ C

Unnamed_thm < intros.

1 subgoal
  
  A, B, C : Prop
  H : A
  H0 : B /\ C
  ============================
  A /\ B /\ C

Unnamed_thm < split...
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### I want to execute the `proof with` tactic only if it solves the goal, how can I do it?

You need to use the `try` and `solve` tactics. For instance:

```coq
Coq < Require Import ZArith.
Coq < Require Ring.
Coq < Local Open Scope Z_scope.

Coq < Goal forall a b c : Z, a + b = b + a.

1 subgoal
  
  ============================
  forall a b : Z, Z -> a + b = b + a

Unnamed_thm < Proof with try solve [ring].

1 subgoal

  ============================
  forall a b : Z, Z -> a + b = b + a

Unnamed_thm < intros...
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### How can I do the opposite of the `intro` tactic?

You can use the `generalize` tactic.

```coq
Coq < Goal forall A B : Prop, A -> B -> A /\ B.

1 subgoal
  
  ============================
  forall A B : Prop, A -> B -> A /\ B

Unnamed_thm < intros.

1 subgoal
  
  A, B : Prop
  H : A
  H0 : B
  ============================
  A /\ B

Unnamed_thm < generalize H.

1 subgoal
  
  A, B : Prop
  H : A
  H0 : B
  ============================
  A -> A /\ B

Unnamed_thm < intro.

1 subgoal
  
  A, B : Prop
  H : A
  H0 : B
  H1 : A
  ============================
  A /\ B

Unnamed_thm < auto.
No more subgoals.

Unnamed_thm < Qed.
Unnamed_thm is defined
```

### One of the hypotheses is an equality between a variable and some term. I want to get rid of this variable, how can I do it?

You can use the `subst` tactic. This will rewrite the equality everywhere and clear the assumption.

### What can I do if I get the message "generated subgoal term has metavariables in it"?

You should use the `eapply` tactic, this will generate some goals containing metavariables.

### How can I instantiate some metavariable?

Just use the `instantiate` tactic.

### What is the use of the `pattern` tactic?

The `pattern` tactic transforms the current goal, performing beta-expansion on all the applications featuring this tactic's argument. For instance, if the current goal includes a subterm `phi(t)`, then `pattern t` transforms the subterm into `(fun x:A => phi(x)) t`. This can be useful when `apply` fails on matching, to abstract the appropriate terms.

### What is the difference between `assert`, `cut`, and `generalize`?

For people that are interested in proof rendering, `assert`, `pose`, and `cut` are not rendered the same as `generalize` (see the HELM experimental rendering tool at http://helm.cs.unibo.it, link HELM, link COQ Online). Indeed, `generalize` builds a beta-expanded term while `assert`, `pose` and `cut` use a let-in.

So this:

```
(* Goal is T *)
generalize (H1 H2).
(* Goal is A->T *)
... a proof of A->T ...
```

is rendered into something like:

```
(h) ... the proof of A->T ...
    we proved A->T
(h0) by (H1 H2) we proved A
by (h h0) we proved T
```
while

```
(* Goal is T *)
assert q := (H1 H2).
(* Goal is A *)
... a proof of A ...
(* Goal is A |- T *)
... a proof of T ...
```

is rendered into something like:

```
(q) ... the proof of A ...
    we proved A
... the proof of T ...
we proved T
```

Otherwise said, `generalize` is not rendered in a forward-reasoning way, while `assert` is.

### What can I do if Coqcan does not infer some implicit argument?

You can state explicitly what this implicit argument is. See [below](#how-can-i-make-explicit-some-implicit-argument).

### How can I make explicit some implicit argument?

Just use `A:=term` where `A` is the argument. For instance, if you want to use the existence of "nil" on `nat*nat` lists:

```coq
exists (nil (A:=(nat*nat))).
```

## Proof management

### How can I change the order of the subgoals?

You can use the `Focus` command to concentrate on some goal. When the goal is proved you will see the remaining goals.

### How can I change the order of the hypotheses?

You can use the `Move ... after` command.

### How can I change the name of a hypothesis?

You can use the `Rename ... into` command.

### How can I delete hypotheses?

You can use the `clear` command.

### How can I use a proof which is not finished?

You can use the `Admitted` command to state your current proof as an axiom. You can use the `give up`
tactic to omit a portion of a proof.

### How can I state a conjecture?
You can use the `Admitted` command to state your current proof as an axiom.

### What is the difference between a lemma, a fact and a theorem?

From Coq's point of view there is no difference. But some tools can behave differently when you use a lemma rather than a theorem. For instance, `coqdoc` will not generate documentation for the lemmas within your development.

### How can I organize my proofs?

You can organize your proofs using the section mechanism of Coq. Have a look at the manual for further information.