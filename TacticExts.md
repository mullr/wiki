<<TableOfContents>>

<<Anchor(LtacUnderBinders)>>
=== Recursion under binders ===

Using typeclasses, it is possible to recurse under binders.  Here is an example of a tactic that recurses under binders to turn a proof of "A -> B -> C /\ D" into a proof of "A -> B -> C":
{{{#!coq
Class ret_and_left {T} (arg : T) {R} := make_recur_ret_and_left : R.

Ltac ret_and_left_helper f :=
  let T := type of f in
  lazymatch eval hnf in T with
    | ?a /\ ?b => exact (proj1 f)
    | ?T' -> _
      => exact (fun x' : T' => _ : ret_and_left (f x'))
  end.

Hint Extern 0 (@ret_and_left _ ?f _) => ret_and_left_helper f : typeclass_instances.

Arguments ret_and_left / .

Goal forall A B : Prop, (A -> A -> A /\ B) -> True.
  intros A B H.
  pose (_ : ret_and_left H) as H'; simpl in H'.
(* fun x' x'0 : A => proj1 (H x' x'0) : A -> A -> A *)
}}}

'''NB''': In Coq >= 8.5, it will be possible to do this using tactics in terms rather than a separate typeclass for each tactic, and without having to "simpl" at the end:
{{{#!coq
Ltac ret_and_left f :=
  let tac := ret_and_left in
  let T := type of f in
  match eval hnf in T with
    | ?a /\ ?b => exact (proj1 f)
    | ?T' -> _ =>
      let ret := constr:(fun x' : T' => let fx := f x' in
                                        $(tac fx)$) in
      let ret' := (eval cbv zeta in ret) in
      exact ret'
  end.

Goal forall A B : Prop, (A -> A -> A -> A /\ B) -> True.
  intros A B H.
  pose $(ret_and_left H)$.
  (** [fun x' x'0 : A => proj1 (H x' x'0) : A -> A -> A] *)
}}}


=== Dependent case ===

{{{dcase}}} is a version of case that remembers the case you are in.
{{{#!coq
Ltac dcase x := generalize (refl_equal x); pattern x at -1; case x.
}}}
'''NB''': This tactic has been integrated in Coq >= 8.1beta under the name {{{case_eq}}}

=== Expand until ===

This tactic is useful when carefully unfolding definitions, for instance inductive ones.
It also shows the use of [[http://pauillac.inria.fr/coq/doc/Reference-Manual013.html#toc71|tactic notation]].

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

<<Anchor(RewriteAll)>>
=== RewriteAll ===

'''NB''': A similar {{{rewrite_all}}} has been integrated in Coq >= 8.1beta
(see file {{{theories/Init/Tactics.v}}}). Moreover, in the release following 8.1beta,
the newly allowed syntax {{{rewrite ... in *}}} permits to define {{{rewrite_all}}}
with a simple {{{repeat rewrite ... in *}}}.


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


<<Anchor(RewriteAll2)>>
=== RewriteAll, expert version ===

Given an assumption {{{H : t1 = t2}}},
the tactic {{{rewrite_all H}}} replaces {{{t1}}} with {{{t2}}}
both in goal and local context.
We have to take care that {{{H}}} does not rewrite itself,
for then we'd get {{{H : t2 = t2}}}, and a loop is entered;
this version generates a smarter proof term than the previous one.

{{{#!coq
Ltac rewrite_all H :=
 match type of H with
 | ?t1 = ?t2 =>
   let rec aux H :=
     match goal with
     | id : context [t1] |- _ =>
       match type of id with
       | t1 = t2 => fail 1
       | _ => generalize id;clear id; try aux H; intro id
       end
     | _ => try rewrite H
     end in
   aux H
 end.
}}}


<<Anchor(DecideEquality)>>
=== Decide Equality ===

Coq's [[http://coq.inria.fr/doc/Reference-Manual010.html#@tactic78|decide equality]] should be more accepting.  It ought to behave more like the following.

{{{#!coq
Ltac decideEquality :=
match goal with
| |- forall x y, {x = y}+{~x=y} => decide equality
| |- {?a=?b}+{~?a=?b} => decide equality a b
| |- {~?a=?b}+{?a=?b} => cut ({a=b}+{~a=b});[tauto | decide equality a b]
end.
}}}
