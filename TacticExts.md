== ApplyFwd ==

{{{ApplyFwd}}} is intended to allow you to apply lemmas of the form
{{{forall a0:T0, ..., forall an:Tn, Phi <-> Psi}}} to reduce a goal of {{{Psi}}} to {{{Phi}}}.
Because {{{ApplyFwd}}} uses {{{Refine}}} also can be used with lemmas of the form
{{{forall a0:T0, ..., forall an:Tn, Phi -> Psi}}}, and will try harder than {{{Apply}}} to match {{{Psi}}} with the goal.
{{{#!coq
Ltac applyFwd l :=
first
[refine l
|refine (proj1 l _)
|refine (l _)
|refine (proj1 (l _) _)
|refine (l _ _)
|refine (proj1 (l _ _) _)
|refine (l _ _ _)
|refine (proj1 (l _ _ _) _)
|refine (l _ _ _ _)
|refine (proj1 (l _ _ _ _) _)
|refine (l _ _ _ _ _)
|refine (proj1 (l _ _ _ _ _) _)
|refine (l _ _ _ _ _ _)
|refine (proj1 (l _ _ _ _ _ _) _)
|refine (l _ _ _ _ _ _ _)
|refine (proj1 (l _ _ _ _ _ _ _) _)
|refine (l _ _ _ _ _ _ _ _)
].
}}}

== ApplyRev ==

{{{ApplyRev}}} is intended to allow you to apply lemmas of the form
{{{forall a0:T0, ..., forall an:Tn, Phi <-> Psi}}} to reduce a goal of {{{Phi}}} to {{{Psi}}}.
{{{#!coq
Ltac applyRev l :=
first
[refine (proj2 l _)
|refine (proj2 (l _) _)
|refine (proj2 (l _ _) _)
|refine (proj2 (l _ _ _) _)
|refine (proj2 (l _ _ _ _) _)
|refine (proj2 (l _ _ _ _ _) _)
|refine (proj2 (l _ _ _ _ _ _) _)
|refine (proj2 (l _ _ _ _ _ _ _) _)
].
}}}

[[Anchor(LHS)]]
== LHS ==
{{{LHS}}} means “left-hand side”.  It returns the term on the left hand side of an equality or inequality.
{{{#!coq
Ltac LHS :=
match goal with
| |-(?a = _) => constr: a
| |-(_ ?a _) => constr: a
end.
}}}

[[Anchor(RHS)]]
== RHS ==
{{{RHS}}} means “right-hand side”.  It returns the term on the left hand side of an equality or inequality.
{{{#!coq
Ltac RHS :=
match goal with
| |-(_ = ?a) => constr: a
| |-(_ _ ?a) => constr: a
end.
}}}


[[Anchor RewriteAll]]
== RewriteAll ==

Given an assumption {{{H : t1 = t2}}}, 
the tactic {{{rewrite_all H}}} replaces {{{t1}}} with {{{t2}}} 
both in goal and local context.
We have to take care that {{{H}}} does not rewrite itself, 
for then we'd get {{{H : t2 = t2}}}, and a loop is entered.

{{{#!coq
Ltac rewrite_in_cxt H :=
  let T := type of H in
  match T with
  | ?t1 = ?t2 =>
      repeat
      (
      generalize H; clear H; 
      match goal with
      | id : context[t1] |- _ =>
          intro H; rewrite H in id
      end
      )
  end.

Ltac rewrite_all H :=
  rewrite_in_cxt H; rewrite H.

Ltac replace_in_cxt t1 t2 :=
  let H := fresh "H" in
  (cut (t1 = t2); [ intro H; rewrite_in_cxt H; clear H | idtac ]).

Ltac replace_all t1 t2 :=
  let H := fresh "H" in
  (cut (t1 = t2); [ intro H; rewrite_all H; clear H | idtac ]).
}}}
