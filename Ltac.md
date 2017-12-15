### What is Ltac?

Ltac is the tactic language for Coq. It provides the user with a high-level “toolbox” for tactic creation.

### Is there any printing command in Ltac?

You can use the `idtac` tactic with a string argument. This string will be printed out. The same applies
to the `fail` tactic.

### What is the syntax for `let` in Ltac?

If _x<sub>i</sub>_ are identifiers and _e<sub>i</sub>_ and _expr_ are tactic expressions, then `let` reads:

let x<sub>1</sub> := e<sub>1</sub> with x<sub>2</sub> := e<sub>2</sub> ... with x<sub>n</sub> := e<sub>n</sub> in expr.

Beware that if _expr_ is complex (i.e. features at least a sequence) parentheses should be added around it. For example:

```coq
Ltac twoIntro := let x:=intro in (x;x).
```

### What is the syntax for pattern matching in Ltac?

Pattern matching on a term _expr_ (non-linear first order unification) with patterns _p<sub>i</sub> and tactic expressions _e<sub>i</sub>_ reads:

match expr with p<sub>1</sub> => e<sub>1</sub> | p<sub>2</sub> => e<sub>2</sub> ... | p<sub>n</sub> => e<sub>n</sub> | _ => e<sub>n+1</sub> end.

Underscore matches all terms.

### What are the semantics for `match goal`?

The semantics of `match goal` depend on whether it returns tactics or not. The `match goal` expression matches the current goal against a series of patterns: _hyp<sub>1</sub> ...hyp<sub>n</sub> |- ccl_. It uses a first-order unification algorithm and in case of success, if the right-hand-side is an expression, it tries to type it while if the right-hand-side is a tactic, it tries to apply it. If the typing or the tactic application fails, the `match goal` tries all the possible combinations of _hyp<sub>i</sub> before dropping the branch and moving to the next one. Underscore matches all terms.

### Why can’t I use a `match goal` returning a tactic in a non tail-recursive position?

This is precisely because the semantics of `match goal` is to apply the tactic on the right as soon as a
pattern unifies what is meaningful only in tail-recursive uses.

The semantics in non tail-recursive call could have been the one used for terms (i.e. fail if the tactic
expression is not typable, but don’t try to apply it). For uniformity of semantics though, this has been
rejected.

### How can I generate a new name?
You can use the following syntax: `let id:=fresh in ...` For example:

```coq
Ltac introIdGen := let id:=fresh in intro id.
```
