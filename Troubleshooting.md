(Part of [[the Coq FAQ]])

### What can I do when `Qed.` is slow?

Sometime you can use the `abstract` tactic, which makes as if you had stated some local lemma, this speeds up the typing process.

### Why does `Reset Initial.` not work when using `coqc`?

The initial state corresponds to the state of `coqtop` when the interactive session began. It does not make sense in files to compile.

### What can I do if I get "No more subgoals but non-instantiated existential variables"?

This means that `eauto` or `eapply` didn’t instantiate an existential variable which eventually got erased by some computation. You may backtrack to the faulty occurrence of `eauto` or `eapply` and give the missing argument a explicit value. Alternatively, you can use the commands `Show Existentials.` and `Existential.` to display and instantiate the remaining existential variables.

```coq
Coq < Lemma example_show_existentials : forall a b c:nat, a=b -> b=c -> a=c.

1 subgoal

  ============================
  forall a b c : nat, a = b -> b = c -> a = c

example_show_existentials < Proof.

1 subgoal

  ============================
  forall a b c : nat, a = b -> b = c -> a = c

example_show_existentials < intros.

1 subgoal

  a, b, c : nat
  H : a = b
  H0 : b = c
  ============================
  a = c

example_show_existentials < eapply eq_trans.

2 focused subgoals
(shelved: 1)

  a, b, c : nat
  H : a = b
  H0 : b = c
  ============================
  a = ?y

subgoal 2 is:
  ?y = c

example_show_existentials < Show Existentials.
Existential 1 =
?y : [a : nat b : nat c : nat H : a = b H0 : b = c |- nat]
Existential 2 =
?Goal : [a : nat b : nat c : nat H : a = b H0 : b = c |- a = ?y]
Existential 3 =
?Goal0 : [a : nat b : nat c : nat H : a = b H0 : b = c |- ?y = c]

example_show_existentials < eassumption.

1 subgoal

  a, b, c : nat
  H : a = b
  H0 : b = c
  ============================
  b = c

example_show_existentials < assumption.
No more subgoals.

example_show_existentials < Qed.
example_show_existentials is defined
```

### What can I do if I get “Cannot solve a second-order unification problem”?

You can help Coq using the `pattern` tactic.

### I copy-paste a term and Coq says it is not convertible to the original term. Sometimes it even says the copied term is not well-typed.

This is probably due to invisible implicit information (implicit arguments, coercions and Cases annotations) in the printed term, which is not re-synthesised from the copied-pasted term in the same way as it is in the original term.

Consider for instance `(@eq Type True True)`. This term is printed as `True=True` and re-parsed as `(@eq Prop True True)`. The two terms are not convertible (hence they fool tactics like pattern).

There is currently no satisfactory answer to the problem. However, the command `Set Printing All` is useful for diagnosing the problem.

Due to coercions, one may even face type-checking errors. In some rare cases, the criterion to hide coercions is a bit too loose, which may result in a typing error message if the parser is not able to find again the missing coercion.