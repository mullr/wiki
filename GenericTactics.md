#format wiki
== GenericTactics ==

=== Rationale ===
A tactic like auto is powerful in theory, but often in practice it can not do anything on the goal just because in a series of, say, 5 steps, the last can not be done by auto. So in practice, it is sometimes better just to try to write some domain-specific tactic ''t'' in Ltac, doing just some invertible steps and, to call {{{repeat}}} ''t''.

The following code elaborates on this idea: Ltac can be used to build a generic solver tactic, taking as arguments invertible and non-invertible tactics, and applying a standard iterative deepening search using non-invertible tactics and normalizing the goal at each depth using invertible tactics. You can think of it as a parameterized intuition tactic (intuition can be parameterized but only about the way it ''solves'' atoms; there is no way to add some specific behavior to, say, make it unfold some definitions or rewrite some terms, or ...)

I (JudicaelCourant) then define some domain-specific tactics in my developments, extending the invertible and/or non-invertible tactics given in the next section an apply the generic search tactic to my tactic. For instance, in a case study I am currently conducting with Jean-François Monin, I define the following {{{progress1}}} tactic:

{{{#!coq
Ltac progress1 g := match goal with
  | [ |- step_up ?f ?z (?u::?x) ] => apply step_up_snoc2
  | [ H : continuous ?f |- _ ] => unfold continuous in H
  end
  || progress0 g.
}}}

Then I define {{{splitsolve1}}} as the following shorthand:
{{{#!coq
Ltac splitsolve1 n := splitsolve progress1 split0 noni0 n 0.
}}}

And I use {{{splitsolve1 0}}}, ..., {{{splitsolve1 2}}} to work on my goals.

Even with no customisation, {{{splitsolve0}}} (given below) is surprisingly effective. For instance, in my current case study, I found that I could replace the following steps:
{{{
intros m H y.
simpl.
rewrite H.
ring.
}}}
with a single {{{splitsolve0 0}}} (in fact, {{{intros;simpl;omega}}} would also work, but I did not figure it out at first as the goal was quite complex; {{{splitsolve0}}} did).

=== Coq code ===

{{{#!coq
Require Omega.

(* A repeat tactical for one-argument tactics. Unlike repeat, the
   tactic is applied at least once.
*)
Ltac repeat1 t g := t g; repeat (t g).

Ltac tacsum t1 t2 g := (t1 g; try t2 g) || t2 g.

(* A tactic is said invertible whenever its application does not change
   the provability of the goal.

   In the following we use the following terminology:
   * progressing tactics: invertible tactics generating at most one subgoal  
   * splitting tactics: invertible tactics potentially generating several
                        subgoal
   * solving tactics: solve the goal or fail
   * non-invertible tactics.
   * non-invertible mapping: a parameterized tactic [t], taking as argument a
       solver [s], apply some non-invertible tactic followed by [s] on the
       generated subgoals.
*)

(* [rsplit pro spl] tries to solve the goal, using the progressing tactic
   [pro] and the splitting tactic [spl]. [g] is a dummy argument. This tactic
   is splitting.
*)
Ltac rsplit pro spl g :=
  let t g := (spl g; try repeat1 pro g) in
  let rt g := repeat1 t g in
  let t2 g := repeat1 pro g in
  tacsum t2 rt g.

Ltac myfail g := fail.

(* [solver_dfs pro spl noni n g] is a depth-first search solving tactic, where
   * [pro] is progressing
   * [spl] is splitting
   * [noni] is a non-invertible mapping
   * n is the depth of search
   * g is a dummy argument
*)
Ltac solver_dfs pro spl noni n g :=
  try rsplit pro spl g;
  let t := match n with
           | O => myfail
           | S ?k => noni ltac:(solver_dfs pro spl noni k)
           end
  in t g.

(* [solver pro spl noni n g] is an iterative deepening search solving tactic,
   where:
   * [pro] is progressing
   * [spl] is splitting
   * [noni] is a non-invertible mapping
   * n is the depth of search
   * g is a dummy argument
*)
Ltac solver pro spl noni n g :=
  let t :=
    match n with
    | O => solver_dfs pro spl noni 0
    | S ?k =>
      let u g := (solver pro spl noni k g || solver_dfs pro spl noni n g) in u
    end
  in t g.

(* [splitsolve pro spl noni n g] is a splitting tactic trying to solve the
   generated subgoals with [solver]
*)
Ltac splitsolve pro spl noni n g :=
  try rsplit pro spl g; try solver pro spl noni n g.


(* [everywhere t g] generalizes the whole goal, then applies g, then intros
   generalized hyps and variable back.
*)
(* NB: we have to take care of match goal non-determinism since we want a
   deterministic behaviour here: the first case must apply only on the last
   hypothesis of the context *)
Ltac everywhere t g := match goal with
| [ H : _ |- _ ] => generalize H; clear H; (everywhere t g || fail 1); intro H
| [ |- _ ] => match goal with
            | [ H : _ |- _ ] => fail 1
            | [ |- _ ] => t g
            end
end.

(* apply [t] on some hyp [H] by generalizing [H], applying [t] (and verifying
   it is progressing), then introducing [H] back.
*)
Ltac on_one_hyp t g := match goal with
| [ H : _ |- _ ] => generalize H; clear H;
                    (progress (t g) || on_one_hyp t g || fail 1);
		    intro H
end.

(* our generic rewrite database is named rew_db *)
Ltac autorew g := autorewrite with rew_db.

(* The base progress, splitting and non-invertible tactics I use. I do not
   pretend they have nice theoretical properties (besides being progressing,
   splitting and non-invertible) but they do the job for me. (I call them
   using [splitsolve0] below.)
*)
Ltac progress0 g := match goal with
| [ |- _ ] => omega || elimtype False;omega
| [ |- _ ] => progress (autorew g)
| [ |- _ ] => on_one_hyp ltac:autorew g
| [ H : ?t = ?t |- _ ] => clear H
| [ H : ?x = ?t |- _ ] => subst x
| [ H : ?t = ?x |- _ ] => subst x
| [ H : ?a = ?b |- _ ] => discriminate H
| [ H : ?a = ?b |- _ ] => injection H;
        match goal with
        | [ H: _ |- a = b -> ?p ] => fail 1
        | [ H: _ |- _ ] => idtac
        end;
        clear H;intros
| [ H : (exists x, _) |- _ ] => elim H; clear H; intros
| [ H : _ |- _ ] => inversion H;fail
| [ |- _ ] => assumption
| [ H : ?p, H2 : ?p |- _ ] => clear H || clear H2
| [ H1 : ?a -> ?b, H2 : ?a |- _ ] => assert b; [ exact (H1 H2) | clear H1 ]
| [ H : ?a /\ ?b |- _ ] =>
  generalize (proj1 H) (proj2 H);clear H; intro; intro
| [ |- ?a -> ?b ] => intro
| [ H : ?a /\ ?b -> ?c |- _ ] => cut (a -> b -> c) ;
                                 [ clear H; intro H
                                 | intro; intro; apply H;split; assumption ]
| [ |- forall x, _ ] => intro
| [ |- ?t = ?u ] => congruence
| [ |- False ] => congruence
| [ |- ?t <> ?u ] => intro
| [ |- ?t = ?u ] => ring;fail
| [ |- _ ] => everywhere ltac:(fun g => (progress simpl)) g
| [ |- True ] => trivial
| [ H : ?a >= ?b |- _ ] => cut (a > b \/ a = b); [clear H;intro H| omega]
| [ H : ?a = ?a -> ?b |- _ ] => cut b ;
                                [ clear H; intro H | apply H; reflexivity]
end.

Ltac split0 g := match goal with
  | [ H : ?a \/ ?b |- _ ] => elim H;clear H
  | [ H : (?a +{ ?b }) |- _ ] => elim H; clear H;intro
  | [ H : ({ ?a }+{ ?b }) |- _ ] => elim H; clear H;intro
  | [ |- ?a /\ ?b ] => assert a ; [ idtac | split ; [ assumption | idtac ] ]
end.

Ltac noni0 t g := match goal with
  | [ |- _ ] => econstructor; t g
(*  | [ |- _ ] => left; t g subsummed by constructor above *)
  | [ |- _ ] => constructor 2; t g
  | [ x : _ |- exists y, _ ] => exists x;t g
  | [ |- ?f1 ?x1 = ?f2 ?x2 ] =>
    cut (f1 = f2);
     [ cut (x1 = x2); [ intros;congruence
                        | idtac ]
     | idtac ]; t g
  | [ H : (forall x, _), x0 : _ |- _ ] => generalize (H x0);clear H;t g
  | [ H : (?f ?u) <> (?f ?v) |- _ ] =>
        cut (u <> v); [ clear H; intro H; t g | congruence ]
  | [ |- _ ] => 
      (apply Zorder.Zmult_le_compat_l
       || apply Zorder.Zmult_ge_compat_l
       || apply Zorder.Zplus_le_0_compat
       || apply Zorder.Zmult_le_0_compat);
      t g
  | [ H : _ |- _ ] => apply H; t g
  | [ |- _ ] => solve [eauto]
end.

Ltac splitsolve0 n := splitsolve progress0 split0 noni0 n 0.
Ltac solver0 n := solver progress0 split0 noni0 n 0.

Hint Extern 2 (?x=?y) => congruence.

(* ensure [t] generates a given number of subgoals *)
Ltac ensure0 t g := t g;fail.
Ltac ensure1 t g := t g ; [idtac].
Ltac ensure2 t g := t g;[idtac | idtac].
Ltac ensure1atmost t g := (t g;fail)||(t g;[idtac]).

(* a progressing tactic potentially better than repeat1 as it uses
   splitting tactics, provided all of their subgoal except one are solved.
   To be improved, though.
*)
Ltac prosolve pro spl noni n g :=
  let splsol k g := spl g; solver pro spl noni k g in
  (try repeat1 pro g; ensure1atmost ltac:(splsol n g)).
}}} 
