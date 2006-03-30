= TacticExts =
[[TableOfContents]]
== General tactics ==
=== Dependent case ===

{{{dcase}}} is a version of case that remembers the case you are in.
{{{#!coq
Ltac dcase x := generalize (refl_equal x); pattern x at -1; case x.
}}}
=== ApplyFwd ===

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

=== ApplyRev ===

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

=== Expand until ===

This tactic is useful when carefully unfolding definitions, for instance inductive ones.
It also shows the use of [http://pauillac.inria.fr/coq/doc/Reference-Manual013.html#toc71 tactic notation].
{{{#!coq
Tactic Notation "expand" reference (t) "until" constr (s):=
  let x:=fresh"x" in 
  set (x:=s); unfold t; fold t;  unfold x.
}}}

This tactic doesn't seem to work if x is a variable name used in the current context?  Is there a fix? -- RussellOConnor

It has been suggested that the following will work.  Can someone verify this? -- RussellOConnor

{{{#!coq
Tactic Notation "expand" reference (t) "until" constr (s):=
  let x:=fresh"x" in 
  (set (x:=s); unfold t; fold t;  unfold x).
}}}

-----

This has proved useful in a situation like:

{{{
   sorted (b :: a :: a0)

> unfold sorted; fold sorted

   cmp b a = true /\
   match a0 with
   | nil => True
   | a'' :: _ => cmp a a'' = true /\ sorted a0
   end
}}}

there's two levels expanded! Solution was "expand sorted until (a::a0)." (thanks roconnor)

=== Clean duplicated hypothesis ===

This tactic removes redundant hypothesis from the context.

{{{#!coq 
Ltac exist_hyp t := match goal with
  | H1:t |- _ => idtac
 end.

Ltac clean_duplicated_hyps :=
  repeat match goal with
      | H:?X1 |- _ => clear H; exist_hyp X1
end.
}}}

=== Assert if necessary ===

This tactic assert a fact only if does not already exists in the context. This is intended to be used in more complex tactics.
{{{#!coq
Ltac not_exist_hyp t := match goal with
  | H1:t |- _ => fail 2
 end || idtac.

Ltac assert_if_not_exist H :=
  not_exist_hyp H;assert H.
}}}

== Tactics about equality ==

[[Anchor(LHS)]]
=== LHS ===
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




[[Anchor(RHS)]]
=== RHS ===
{{{RHS}}} means “right-hand side”.  It returns the term on the left hand side of an equality or inequality.
{{{#!coq
Ltac RHS :=
match goal with
| |-(_ = ?a) => constr: a
| |-(_ _ ?a) => constr: a
end.
}}}


[[Anchor(RewriteAll)]]
=== RewriteAll ===

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


[[Anchor(eecideEquality)]]
=== Decide Equality ===

Coq's [http://coq.inria.fr/doc/Reference-Manual010.html#@tactic78 decide equality] should be more accepting.  It ought to behave more like the following.

{{{#!coq
Ltac decideEquality :=
match goal with
| |- forall x y, {x = y}+{~x=y} => decide equality
| |- {?a=?b}+{~?a=?b} => decide equality a b
| |- {~?a=?b}+{?a=?b} => cut ({a=b}+{~a=b});[tauto | decide equality a b]
end.
}}}
