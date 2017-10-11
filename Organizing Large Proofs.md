This Coq-club [thread](http://pauillac.inria.fr/pipermail/coq-club/2007/003006.html) contains an interesting discussion about how to stay oriented while doing large inductive proofs.

Benjamin Pierce suggests using a [Case tactic](../Case%20(tactic)) to mark your progress.

Since Coq version 8.2, the best way of organizing a large proof is probably using [C-zar](../C-zar), Coq's [DeclarativeProof](../DeclarativeProof) language \[<http://www.lix.polytechnique.fr/coq/distrib/current/refman/Reference-Manual014.html>\]. You can use `escape` and `return` commands to include a procedural block in a declarative script, or `proof` and `end proof` to nest a declarative proof block inside a procedural proof script.
