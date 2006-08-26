==== Proof ====
I can prove :
{{{#!coq
Variable U : Type.
Variables P1 P2 : U -> Prop.

Definition def1 := forall x:U, P1 x -> P2 x.
Definition def2 := (forall x:U, P1 x) -> forall x:U, P2 x.

Theorem theo1 : def1 -> def2.
}}}
but not :
{{{#!coq
Theorem theo2 : def2 -> def1.
}}}
It seems easy but I'm blocked. How can I prove ?
Thanks in advance.
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

===== Can commutivity of or be proven? =====

{{{#!coq 
Lemma or_comm : forall (A B:Prop), (A \/ B) = (B \/ A).
}}}
[[Date(2006-06-18T22:32:50Z)]]

No, but coq can prove
{{{#!coq 
Lemma or_comm : forall (A B:Prop), (A \/ B) <-> (B \/ A).
}}}
