[This](http://article.gmane.org/gmane.science.mathematics.logic.coq.club/1240) Coq-club thread discusses how to do induction over types such as

```coq
Inductive foo : nat * nat -> Prop :=
| foo1 : forall i j k, i = j + k -> foo (i, j)
| foo2 : forall i j k, foo (i, j + k) -> foo (i, j).
```

Naively applying induction will forget the structure of foo's argument.

Doing induction on a term that does not contains only variables (there is a pair and a sum in `(n, m+p)`). The first way to go is to reshape your hypothesis on which you do induction so it contains only variables. Example:

```coq
Require Import Omega.
Inductive foo : nat * nat -> Prop :=
  | foo1 : forall i j k, i = j + k -> foo (i, j)
  | foo2 : forall i j k, foo (i, j + k) -> foo (i, j).
Lemma bar : forall n m p, foo (n, m + p) -> m <= n.
intros n m p H.
assert (Haux: forall u, foo u -> forall p, u = (n, m + p) -> m <= n).
   intros u Hu; elim Hu; intros i j k.
     intros Eq1 p1 Eq2; injection Eq2; intros; omega.
   intros _ Hrec p1 Eq2; apply Hrec with (p1 + k).
   apply f_equal2 with (f := @pair nat nat); injection Eq2; intros; omega.
apply Haux with (1 := H) (p := p); trivial.
Qed.
```

The second way to go is to reshape your conclusion so it explicitly exhibits the dependancy with the term that is not a variable in your case `(n, m + p)`. Example:

```coq
Lemma bar1 : forall n m p, foo (n, m + p) -> m <= n.
intros n m p H.
replace m with ((m + p) - p); try omega.
change ((fun x => (snd x - p <= fst x)) (n, m + p)).
elim H; simpl; intros; omega.
Qed.
```
