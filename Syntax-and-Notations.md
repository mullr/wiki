### I do not want to type `forall` because it is too long, what can I do?

You can define your own notation for `forall`:

```coq
Notation "fa x : t, P" := (forall x:t, P) (at level 200, x ident).
```

or if your are using CoqIde you can define a pretty symbol for `forall` and an input method (see [this section](CoqIde#how-to-use-those-forall-and-exists-pretty-symbols)).

### How can I define a notation for square?

You can use for instance:

```coq
Require Import Coq.Reals.Rdefinitions.
Notation "x ^ 2" := (Rmult x x) (at level 20).
```

Note that you can not use:

Notation "x<sup>2</sup>" := (Rmult x x) (at level 20).

because “<sup>2</sup>” is an iso-latin character. If you really want this kind of notation you should use UTF-8.

### Why don't "no associativity" and "left associativity" work at the same level?

Because we rely on Camlp4 for syntactical analysis and Camlp4 does not really implement no associativity. By default, non-associative operators are defined as right-associative.

### How can I know the associativity associated with a level?

You can do “Print Grammar constr”, and decode the output from Camlp4, good luck!