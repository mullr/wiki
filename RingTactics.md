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

This runs {{{replace a with b}}} and uses ring to solve the equality.  Works great with wiki:Self:TacticExts#LHS and wiki:Self:TacticExts#RHS.

{{{#!coq
Ltac ringreplace a b :=
replace a with b ; [idtac | solve [ ring ]].
}}}
