[[http://pauillac.inria.fr/pipermail/coq-club/2006/002545.html|This]] Coq-club thread discusses how to do induction over types such as
{{{#!coq
  Inductive foo : nat * nat -> Prop :=
  | foo1 : forall i j k, i = j + k -> foo (i, j)
  | foo2 : forall i j k, foo (i, j + k) -> foo (i, j).
}}}
Naively applying induction will forget the structure of foo's argument.
