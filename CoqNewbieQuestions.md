===== Debugging output for tactics =====

idtac can be used to give output when writing ltac tactics for debugging reasons. However, I cannot work out how to convert Coq terms to strings. For example, I would like to see what the failed match is below:

{{{#!coq 
Ltac test x :=
  match x with
  |  x+y => idtac "Hello world!"
  | _ => idtac x (* Doesn't work! *)
 end.
}}}

"idtac x" doesn't work because x isn't a string. How do I convert x to a string?

'''Suggested solution:''' Use `pose (name := x)` in place of `idtac x`.

===== Can commutivity of or be proven? =====

{{{#!coq 
Lemma or_comm : forall (A B:Prop), (A \/ B) = (B \/ A).
}}}
[[Date(2006-06-18T22:32:50Z)]]

No, but coq can prove
{{{#!coq 
Lemma or_comm : forall (A B:Prop), (A \/ B) <-> (B \/ A).
}}}

Is it consistent to add as an axiom
{{{#!coq
Hypothesis extprop : forall (C D:Prop), (C <-> D) -> (C = D).
}}}
? (I don't suppose it's ''useful''.)


===== Syntax Question: What does ... mean? =====
What do the triple elipses mean  after a tactic? E.g. how is {{{induction 1... }}} different than just {{{induction 1.}}}

 If you start your proof with 
{{{#!coq
Proof with foo.
}}}
 where {{{foo}}} is a tactic, then 
{{{#!coq
induction 1...
}}}
 is equivalent to
{{{#!coq
induction 1; foo.
}}}
 This is explained in the Reference Manual in [http://coq.inria.fr/V8.1/refman/Reference-Manual010.html#@command186]. 

===== Operational Semantics of Coq =====

Is there a paper which describes a small-(or big) step operational semantics for core coq? 
