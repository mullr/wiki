```coq
Require Import List.
```

Theorem incl_nil
=================

A stupid theorem that is missing from the database datatypes

```coq
Theorem incl_nil: forall A, forall l : list A, (incl nil l).
intros A l a; simpl; intros H; case  H.
Qed.
Hint Resolve incl_nil: datatypes.
```

Tactic incl_tac_rec
=====================

This local tactic tries to remove append and cons on the right-hand side of the incl

```coq
Ltac incl_tac_rec := (auto with datatypes; fail)
                                   || (apply incl_appl; incl_tac_rec)
                                   || (apply incl_appr; incl_tac_rec)
                                   || (apply incl_tl; incl_tac_rec)
                                   || (apply in_cons; incl_tac_rec)
                                   || (apply in_or_app; left; incl_tac_rec)
                                   || (apply in_or_app; right; incl_tac_rec).
```

Tactic incl_tac
================

This tactic proves goals of the type *incl ((1 :: l1) ++ l2) (l2 ++ (1 :: l1))*. It first removes append and cons on the left-hand side of the incl, then calls incl_tac_rec.

```coq
Ltac incl_tac := (repeat  (apply incl_cons || apply incl_app); incl_tac_rec ).
```

Tactic in_tac
==============

This tactic proves goals of the type *in a ((1 :: l1) ++ l2) (l2 ++ (1 :: l1))* where there is an assumption of the type *in a ((1 :: l1) ++ l2) (l2 ++ (1 :: l1))*.

```coq
Ltac in_tac :=
  match goal with
 |- (In ?x ?L1) =>
      match goal with
          H : (In x  ?L2) |- _  => let H1 := fresh "H" in
                                   (   assert  (H1: (incl L2 L1));
                                     [ incl_tac | apply (H1 x)]); auto; fail
     |  _ => fail
      end
  end.
```

Examples
========

```coq
Goal forall a (l1 l2 l3 l4: (list nat)),  
  (In a (l1 ++ l2 ++ (1::l3))) -> (In a l4) -> (In a (l3 ++ (1::l1) ++ l2)) .
intros.
in_tac.
Qed.
Goal forall a (l1 l2 l3 l4: (list nat)),  
  (In a (l1 ++ l2 ++ (1::l3))) -> (In a l4) -> (In a (l3 ++ (2::(l1 ++ (1::l1)) ++ l2)) ).
intros.
in_tac.
Qed.
Goal forall a (l1 l2 l3 l4: (list nat)),  
  (In a (l1 ++ (1::nil) ++ (1::l3))) -> (In a l4) -> (In a (l3 ++ (2::(l1 ++ (1::l1)) ++ l2)) ).
intros.
in_tac.
Qed.
```
