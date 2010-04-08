[[http://pauillac.inria.fr/pipermail/coq-club/2007/003224.html|This]] Coq-club thread discusses the '''fix''' Coq language construct and the Fix tactic.  These are useful for defining your own induction principles, such as for inductive types which include nested lists.

The Coq Reference Manual discusses the language construct (see [[http://pauillac.inria.fr/coq/doc/Reference-Manual006.html#@default333|here]]), but not the tactic.  When Coq is checking a '''fix''' or '''fixpoint''' definition, it must ensure that recursive calls are guarded.  This
[[http://pauillac.inria.fr/pipermail/coq-club/2008/003390.html|thread]]
discusses the guardedness conditions.

As tactic fix waits for "Qed" to check guardedness, it is not advisable to use it (unless you know what you do); use "induction" to avoid this problem, as "induction" produces a guarded hypothesis.
For "cofix", there is no equivalent.
