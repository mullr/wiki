=== LHS & RHS ===
{{{LHS}}} means “left-hand side”.  It returns the term on the left hand side of an equality or inequality.
{{{#!coq
Ltac LHS :=
match goal with
| |-(?a = _) => constr: a
| |-(_ ?a _) => constr: a
end.
}}}

For example you can use this to write a tactic that proves the cofixpoint equations of streams:

{{{#!coq
Ltac decomp_stream := intros; let L := LHS in rewrite (Streams.unfold_Stream L); reflexivity.
}}}

{{{RHS}}} means “right-hand side”.  It returns the term on the left hand side of an equality or inequality.
{{{#!coq
Ltac RHS :=
match goal with
| |-(_ = ?a) => constr: a
| |-(_ _ ?a) => constr: a
end.
}}}

We can make special tactics for {{{replace LHS}}} and {{{replace RHS}}} that give similar functionality to {{{step}}}.

{{{#!coq
Tactic Notation "replace" "LHS" "with" constr (a) "by" tactic (t) :=
match goal with
| |-(?r ?b ?c) =>
  let Z := fresh "Z" in 
  (change (let Z:=b in r Z c);intro Z;setoid_replace Z with a;
   [unfold Z; clear Z|unfold Z; clear Z; solve [ t ]])
end.

Tactic Notation "replace" "LHS" "with" constr (a) :=
match goal with
| |-(?r ?b ?c) =>
  let Z := fresh "Z" in 
  (change (let Z:=b in r Z c);intro Z;setoid_replace Z with a;
   unfold Z; clear Z)
end.

Tactic Notation "replace" "RHS" "with" constr (a) "by" tactic (t) :=
match goal with
| |-(?r ?b ?c) =>
  let Z := fresh "Z" in 
  (change (let Z:=c in r b Z);intro Z;setoid_replace Z with a;
   [unfold Z; clear Z|unfold Z; clear Z; solve [ t ]])
end.

Tactic Notation "replace" "RHS" "with" constr (a) :=
match goal with
| |-(?r ?b ?c) =>
  let Z := fresh "Z" in 
  (change (let Z:=c in r b Z);intro Z;setoid_replace Z with a;
   unfold Z; clear Z)
end.
}}}
