The following tactic decomposes all record-like structures in the context.

{{{#!coq
 Tactic Notation "decompose" "records" :=
   repeat (
     match goal with
     | H: _ |- _ => progress (decompose record H); clear H
     end).
}}}
