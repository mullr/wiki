{{{#!coq
Require Export Ring.
}}}

== ringsimpl ==

The idea is to put all ring expressions occuring in the goal into normal form.  This tactic could use lots of improvement.

{{{#!coq
Ltac ringsimpl :=
match goal with
| |- (_ ?a ?b) => ring a b
| |- (?a ?b ?c) => try ringsimpl a; try ringsimpl b; try ringsimpl c
end.
}}}

== ringreplace ==

Instead of this tactic, you can now do {{{replace a with b by ring}}} in Coq.  Unfortuately this doesn't work for {{{setoid_replace}}}

This runs {{{replace a with b}}} and uses ring to solve the equality.  Works great with wiki:Self:TacticExts#LHS and wiki:Self:TacticExts#RHS.

{{{#!coq
Ltac ringreplace a b :=
replace a with b ; [idtac | solve [ ring ]].
}}}

Alternative:

{{{#!coq
Tactic Notation "ringreplace" constr (a) "with" constr (b) :=
replace a with b ; [idtac | solve [ ring ]].
}}}

The above alternative doesn't support {{{LHS}}} and {{{RHS}}}; however you can add two more tactic notations:

{{{#!coq
Tactic Notation "ringreplace" "LHS" "with" constr (b) :=
let a := LHS in ringreplace a with b
Tactic Notation "ringreplace" "RHS" "with" constr (b) :=
let a := RHS in ringreplace a with b.
}}}

but if someone has a variable named {{{LHS}}} or {{{RHS}}}, they are on their own. ;)
