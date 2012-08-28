This implements a certified parser on a simple grammar of arithmetic expressions.  It assumes the input has already been tokenized.

Possible improvements:
 * Define some notations so that we can act as if we were using the StateT (list token) Maybe monad.
 * Automate the proofs of completeness.

{{{#!coq
Require Import Program.
Require Import ZArith.
Require Import List.

Inductive token : Set :=
| NUM (n:Z)
| PLUS | MINUS | TIMES | OPEN_PAREN | CLOSE_PAREN.

(* The target grammar, formalized below, is informally:
expr <- summand => $1
      | expr PLUS summand => $1 + $3
      | expr MINUS summand => $1 - $3

summand <- factor => $1
         | summand TIMES factor => $1 * $3

factor <- NUM => $1
        | PLUS factor => $2
        | MINUS factor => - $2
        | OPEN_PAREN expr CLOSE_PAREN => $2
*)

Inductive expr_value : list token -> Z -> Prop :=
| expr_rule_1 : forall (l1 : list token) (val1 : Z),
  summand_value l1 val1 -> expr_value l1 val1
| expr_rule_2 : forall (l1 : list token) (val1 : Z)
  (l3 : list token) (val3 : Z),
  expr_value l1 val1 -> summand_value l3 val3 ->
  expr_value (l1 ++ PLUS :: l3) (val1 + val3)%Z
| expr_rule_3 : forall (l1 : list token) (val1 : Z)
  (l3 : list token) (val3 : Z),
  expr_value l1 val1 -> summand_value l3 val3 ->
  expr_value (l1 ++ MINUS :: l3) (val1 - val3)%Z
with
summand_value : list token -> Z -> Prop :=
| summand_rule_1 : forall (l1 : list token) (val1 : Z),
  factor_value l1 val1 -> summand_value l1 val1
| summand_rule_2 : forall (l1 : list token) (val1 : Z)
  (l3 : list token) (val3 : Z),
  summand_value l1 val1 -> factor_value l3 val3 ->
  summand_value (l1 ++ TIMES :: l3) (val1 * val3)%Z
with
factor_value : list token -> Z -> Prop :=
| factor_rule_1 : forall (n : Z),
  factor_value [NUM n]%list n
| factor_rule_2 : forall (l2 : list token) (val2 : Z),
  factor_value l2 val2 -> factor_value (PLUS :: l2) val2
| factor_rule_3 : forall (l2 : list token) (val2 : Z),
  factor_value l2 val2 -> factor_value (MINUS :: l2) (- val2)%Z
| factor_rule_4 : forall (l2 : list token) (val2 : Z),
  expr_value l2 val2 -> factor_value (OPEN_PAREN :: l2 ++ [CLOSE_PAREN]) val2.

Lemma expr_nonempty : forall (l : list token) (n : Z), expr_value l n ->
  length l > 0 with
summand_nonempty : forall (l : list token) (n : Z), summand_value l n ->
  length l > 0 with
factor_nonempty : forall (l : list token) (n : Z), factor_value l n ->
  length l > 0.
Proof.
destruct 1; (repeat rewrite app_length; simpl; omega) || eauto.
destruct 1; (repeat rewrite app_length; simpl; omega) || eauto.
destruct 1; (repeat rewrite app_length; simpl; omega) || eauto.
Qed.

(* A few trivial results to recognize a string expression involving l
   as being equal to ? ++ l. *)
Lemma app_nil_start : forall l : list token, l = nil ++ l.
Proof.
reflexivity.
Qed.

Lemma app_cons_start : forall (t : token) (l' hd l : list token),
  l' = hd ++ l -> t :: l' = (t :: hd) ++ l.
Proof.
intros.
rewrite H.
reflexivity.
Qed.

Lemma app_app_start : forall (hd1 hd2 l l' : list token),
  l' = hd2 ++ l -> hd1 ++ l' = (hd1 ++ hd2) ++ l.
Proof.
intros.
rewrite H.
apply app_assoc.
Qed.

Ltac recog_tail :=
  eauto using app_nil_start, app_cons_start, app_app_start.

Inductive parse_ret (l : list token) (cond : list token -> Z -> Prop) : Set :=
| parse_success : forall (tl : list token) (n : Z),
  (exists hd : list token, l = hd ++ tl /\ cond hd n) ->
  parse_ret l cond
| parse_failure : parse_ret l cond.

Definition expr_sub_value (n : Z) : list token -> Z -> Prop :=
fun l m => forall (n' : list token), expr_value n' n -> expr_value (n' ++ l) m.

(* Reduction rules for the fake "expr_sub_value n" symbol:
  expr_sub_value n <- empty => n
                    | PLUS summand (expr_sub_value n+$2) => $3
                    | MINUS summand (expr_sub_value n-$2) => $3 *)
Lemma expr_sub_value_rule1 : forall n : Z,
  expr_sub_value n nil n.
Proof.
intros n ? ?; rewrite <- app_nil_end; trivial.
Qed.

Lemma expr_sub_value_rule2 : forall (n : Z)
  (l2 : list token) (val2 : Z) (l3 : list token) (val3 : Z),
  summand_value l2 val2 ->
  expr_sub_value (n + val2)%Z l3 val3 ->
  expr_sub_value n (PLUS :: l2 ++ l3) val3.
Proof.
intros.
intros ? ?.
evar (hd : list token); match goal with |- expr_value ?l _ =>
            replace l with (hd ++ l3) by (symmetry; recog_tail); subst hd
                        end.
eauto using expr_value.
Qed.

Lemma expr_sub_value_rule3 : forall (n : Z)
  (l2 : list token) (val2 : Z) (l3 : list token) (val3 : Z),
  summand_value l2 val2 ->
  expr_sub_value (n - val2)%Z l3 val3 ->
  expr_sub_value n (MINUS :: l2 ++ l3) val3.
Proof.
intros.
intros ? ?.
evar (hd : list token); match goal with |- expr_value ?l _ =>
            replace l with (hd ++ l3) by (symmetry; recog_tail); subst hd
                        end.
eauto using expr_value.
Qed.

Definition summand_sub_value (n : Z) : list token -> Z -> Prop :=
fun l m => forall (n' : list token),
  summand_value n' n -> summand_value (n' ++ l) m.

(* Reduction rules for the fake "summand_sub_value n" symbol:
  summand_sub_value n <- empty => n
                       | TIMES factor (summand_sub_value n*$2) => $3 *)
Lemma summand_sub_value_rule1 : forall n : Z,
  summand_sub_value n nil n.
Proof.
intros; intros ? ?; rewrite <- app_nil_end; trivial.
Qed.

Lemma summand_sub_value_rule2 : forall (n : Z)
  (l2 : list token) (val2 : Z) (l3 : list token) (val3 : Z),
  factor_value l2 val2 ->
  summand_sub_value (n * val2)%Z l3 val3 ->
  summand_sub_value n (TIMES :: l2 ++ l3) val3.
Proof.
intros.
intros ? ?.
evar (hd : list token); match goal with |- summand_value ?l _ =>
            replace l with (hd ++ l3) by (symmetry; recog_tail); subst hd
                        end.
eauto using summand_value.
Qed.

Obligation Tactic := program_simpl; simpl; simpl in *;
  eauto using expr_value, summand_value, factor_value;
  try (repeat split; discriminate);
  try (repeat rewrite app_length in *;
       repeat match goal with
       H : _ |- _ => apply expr_nonempty in H ||
                  apply summand_nonempty in H ||
                  apply factor_nonempty in H
       end; omega);
  try (eexists; split; [ recog_tail |
                         eauto using expr_value, summand_value, factor_value,
                         expr_sub_value_rule1, expr_sub_value_rule2,
                         expr_sub_value_rule3, summand_sub_value_rule1,
                         summand_sub_value_rule2 ]).

Program Fixpoint
parse_expr (l : list token) (H : Acc lt (5 * length l + 4)) {struct H} :
  parse_ret l expr_value :=
match parse_summand l (Acc_inv H _) return parse_ret _ _ with
| parse_success l' n _ =>
  match parse_expr_sub l' (Acc_inv H _) n return parse_ret _ _ with
  | parse_success l'' n' _ => parse_success _ _ l'' n' _
  | parse_failure => parse_failure _ _
  end
| parse_failure => parse_failure _ _
end
with
parse_expr_sub (l : list token) (H : Acc lt (5 * length l + 3)) (n : Z)
  {struct H} : parse_ret l (expr_sub_value n) :=
match l with
| (PLUS :: l')%list =>
  match parse_summand l' (Acc_inv H _) return parse_ret _ _ with
  | parse_success l'' m _ =>
    match parse_expr_sub l'' (Acc_inv H _) (n + m)%Z return parse_ret _ _ with
    | parse_success l''' m' _ => parse_success _ _ l''' m' _
    | parse_failure => parse_failure _ _
    end
  | parse_failure => parse_failure _ _
  end
| (MINUS :: l')%list =>
  match parse_summand l' (Acc_inv H _) return parse_ret _ _ with
  | parse_success l'' m _ =>
    match parse_expr_sub l'' (Acc_inv H _) (n - m)%Z return parse_ret _ _ with
    | parse_success l''' m' _ => parse_success _ _ l''' m' _
    | parse_failure => parse_failure _ _
    end
  | parse_failure => parse_failure _ _
  end
| _ => parse_success _ _ l n _
end
with
parse_summand (l : list token) (H : Acc lt (5 * length l + 2)) {struct H} :
  parse_ret l summand_value :=
match parse_factor l (Acc_inv H _) return parse_ret _ _ with
| parse_success l' n _ =>
  match parse_summand_sub l' (Acc_inv H _) n return parse_ret _ _ with
  | parse_success l'' n' _ => parse_success _ _ l'' n' _
  | parse_failure => parse_failure _ _
  end
| parse_failure => parse_failure _ _
end
with
parse_summand_sub (l : list token) (H : Acc lt (5 * length l + 1)) (n : Z)
  {struct H} : parse_ret l (summand_sub_value n) :=
match l with
| (TIMES :: l')%list =>
  match parse_factor l' (Acc_inv H _) return parse_ret _ _ with
  | parse_success l'' m _ =>
    match parse_summand_sub l'' (Acc_inv H _) (n * m)%Z
      return parse_ret _ _ with
    | parse_success l''' m' _ => parse_success _ _ l''' m' _
    | parse_failure => parse_failure _ _
    end
  | parse_failure => parse_failure _ _
  end
| _ => parse_success _ _ l n _
end
with
parse_factor (l : list token) (H : Acc lt (5 * length l)) {struct H} :
  parse_ret l factor_value :=
match l with
| (PLUS :: l')%list =>
  match parse_factor l' (Acc_inv H _) return parse_ret _ _ with
  | parse_success l'' n _ => parse_success _ _ l'' n _
  | parse_failure => parse_failure _ _
  end
| (MINUS :: l')%list =>
  match parse_factor l' (Acc_inv H _) return parse_ret _ _ with
  | parse_success l'' n _ => parse_success _ _ l'' (-n)%Z _
  | parse_failure => parse_failure _ _
  end
| (OPEN_PAREN :: l')%list =>
  match parse_expr l' (Acc_inv H _) return parse_ret _ _ with
  | parse_success l'' n _ =>
    match l'' with
    | (CLOSE_PAREN :: l''')%list => parse_success _ _ l''' n _
    | _ => parse_failure _ _
    end
  | parse_failure => parse_failure _ _
  end
| (NUM n :: l')%list =>
  parse_success _ _ l' n _
| _ => parse_failure _ _
end.

Obligation Tactic := program_simpl.

Definition parse_ret_data {l cond} (ret : parse_ret l cond) :
  option (list token * Z) :=
match ret with
| parse_success l' n _ => Some (l', n)
| parse_failure => None
end.

Inductive starts_with {A:Type} : list A -> A -> Prop :=
| starts_with_intro :
  forall (tl : list A) (hd : A), starts_with (hd :: tl) hd.

Definition parse_expr_completeness_stmt {hd n} (Hexpr : expr_value hd n) :=
  forall tl, ~ starts_with tl TIMES -> forall H, exists H',
  parse_ret_data (parse_expr (hd ++ tl) H) =
  parse_ret_data (parse_expr_sub tl H' n).
Definition parse_summand_completeness_stmt {hd n}
  (Hsummand : summand_value hd n) :=
  forall tl, forall H, exists H',
  parse_ret_data (parse_summand (hd ++ tl) H) =
  parse_ret_data (parse_summand_sub tl H' n).
Definition parse_factor_completeness_stmt {hd n}
  (Hfactor : factor_value hd n) :=
  forall tl, forall H,
  parse_ret_data (parse_factor (hd ++ tl) H) = Some (tl, n).

Lemma parse_expr_completeness' {hd n} (Hexpr : expr_value hd n) :
  parse_expr_completeness_stmt Hexpr ->
  forall tl, ~ starts_with tl PLUS -> ~ starts_with tl MINUS ->
  ~ starts_with tl TIMES -> forall H,
  parse_ret_data (parse_expr (hd ++ tl) H) = Some (tl, n).
Proof.
intros.
destruct (H tl H2 H3) as [H' e]; rewrite e.
destruct H'; simpl parse_expr_sub.
destruct tl; simpl.
reflexivity.
destruct t; (match goal with
             | Hs : ~ starts_with (?t :: _) ?t |- _ =>
               contradict Hs; constructor
             end || reflexivity).
Qed.

Lemma parse_summand_completeness' {hd n} (Hsummand : summand_value hd n) :
  parse_summand_completeness_stmt Hsummand ->
  forall tl, ~ starts_with tl TIMES -> forall H,
  parse_ret_data (parse_summand (hd ++ tl) H) = Some (tl, n).
Proof.
intros.
destruct (H tl H1) as [H' e]; rewrite e.
destruct H'; simpl parse_summand_sub.
destruct tl; simpl.
reflexivity.
destruct t; (match goal with
             | Hs : ~ starts_with (?t :: _) ?t |- _ =>
               contradict Hs; constructor
             end || reflexivity).
Qed.

Lemma parse_expr_completeness : forall hd n (Hexpr : expr_value hd n),
  parse_expr_completeness_stmt Hexpr
with
parse_summand_completeness : forall hd n (Hsummand : summand_value hd n),
  parse_summand_completeness_stmt Hsummand
with
parse_factor_completeness : forall hd n (Hfactor : factor_value hd n),
  parse_factor_completeness_stmt Hfactor.
Proof.
3: intros hd n H; destruct H;
repeat match goal with
| e : expr_value _ _ |- _ =>
  progress match goal with
  | _ : parse_expr_completeness_stmt e |- _ => idtac
  | |- _ => let H := fresh in pose proof
         (parse_expr_completeness _ _ e) as H;
         pose proof (parse_expr_completeness' _ H)
  end
| s : summand_value _ _ |- _ =>
  progress match goal with
  | _ : parse_summand_completeness_stmt s |- _ => idtac
  | |- _ => let H := fresh in pose proof
         (parse_summand_completeness _ _ s) as H;
         pose proof (parse_summand_completeness' _ H)
  end
| f : factor_value _ _ |- _ =>
  progress match goal with
  | _ : parse_factor_completeness_stmt f |- _ => idtac
  | |- _ => pose proof (parse_factor_completeness _ _ f)
  end
end; clear parse_expr_completeness parse_summand_completeness
  parse_factor_completeness.
2: intros hd n H; destruct H;
repeat match goal with
| e : expr_value _ _ |- _ =>
  progress match goal with
  | _ : parse_expr_completeness_stmt e |- _ => idtac
  | |- _ => let H := fresh in pose proof
         (parse_expr_completeness _ _ e) as H;
         pose proof (parse_expr_completeness' _ H)
  end
| s : summand_value _ _ |- _ =>
  progress match goal with
  | _ : parse_summand_completeness_stmt s |- _ => idtac
  | |- _ => let H := fresh in pose proof
         (parse_summand_completeness _ _ s) as H;
         pose proof (parse_summand_completeness' _ H)
  end
| f : factor_value _ _ |- _ =>
  progress match goal with
  | _ : parse_factor_completeness_stmt f |- _ => idtac
  | |- _ => pose proof (parse_factor_completeness _ _ f)
  end
end; clear parse_expr_completeness parse_summand_completeness
  parse_factor_completeness.
1: intros hd n H; destruct H;
repeat match goal with
| e : expr_value _ _ |- _ =>
  progress match goal with
  | _ : parse_expr_completeness_stmt e |- _ => idtac
  | |- _ => let H := fresh in pose proof
         (parse_expr_completeness _ _ e) as H;
         pose proof (parse_expr_completeness' _ H)
  end
| s : summand_value _ _ |- _ =>
  progress match goal with
  | _ : parse_summand_completeness_stmt s |- _ => idtac
  | |- _ => let H := fresh in pose proof
         (parse_summand_completeness _ _ s) as H;
         pose proof (parse_summand_completeness' _ H)
  end
| f : factor_value _ _ |- _ =>
  progress match goal with
  | _ : parse_factor_completeness_stmt f |- _ => idtac
  | |- _ => pose proof (parse_factor_completeness _ _ f)
  end
end; clear parse_expr_completeness parse_summand_completeness
  parse_factor_completeness.
Guarded.

red; intros.
destruct H2; simpl parse_expr.
remember (parse_summand _ _) as ps_val.
assert (parse_ret_data ps_val = Some (tl, val1)).
  rewrite Heqps_val.
  apply (H0 _ H1).
destruct ps_val; simpl in H2; try discriminate H2.
injection H2; intros; subst.
match goal with |- appcontext [parse_expr_sub tl ?H'] => exists H' end.
destruct parse_expr_sub; reflexivity.

red.
intro tl; repeat (rewrite <- app_assoc; simpl app); intros.
assert (~ starts_with (PLUS :: l3 ++ tl) TIMES) by
  (red; inversion 1).
red in H0.
destruct (H0  _ H6 H5) as [H'' e]; rewrite e.
destruct H''; simpl parse_expr_sub.
match goal with |- appcontext [parse_summand (l3 ++ tl) ?H] =>
  let a := fresh "a" in generalize H as a; intro a end.
remember (parse_summand (l3 ++ tl) _) as ps_val.
assert (parse_ret_data ps_val = Some (tl, val3)).
  rewrite Heqps_val.
  apply H3; trivial.
destruct ps_val; simpl in H7; try discriminate H7.
injection H7; intros; subst.
match goal with |- appcontext [parse_expr_sub tl ?H] =>
  generalize H end.
intro a1; exists a1.
destruct (parse_expr_sub tl a1 (val1 + val3)); reflexivity.

red.
intro tl; repeat (rewrite <- app_assoc; simpl app); intros.
assert (~ starts_with (MINUS :: l3 ++ tl) TIMES) by
  (red; inversion 1).
red in H0.
destruct (H0  _ H6 H5) as [H'' e]; rewrite e.
destruct H''; simpl parse_expr_sub.
match goal with |- appcontext [parse_summand (l3 ++ tl) ?H] =>
  let a := fresh "a" in generalize H as a; intro a end.
remember (parse_summand (l3 ++ tl) _) as ps_val.
assert (parse_ret_data ps_val = Some (tl, val3)).
  rewrite Heqps_val.
  apply H3; trivial.
destruct ps_val; simpl in H7; try discriminate H7.
injection H7; intros; subst.
match goal with |- appcontext [parse_expr_sub tl ?H] =>
  generalize H end.
intro a1; exists a1.
destruct (parse_expr_sub tl a1 (val1 - val3)); reflexivity.

red; intros.
destruct H0; simpl parse_summand.
remember (parse_factor _ _) as pf_val.
assert (parse_ret_data pf_val = Some (tl, val1)).
  rewrite Heqpf_val.
  apply H.
destruct pf_val; simpl in H0; try discriminate H0.
injection H0; intros; subst.
match goal with |- appcontext [parse_summand_sub tl ?H'] => exists H' end.
destruct parse_summand_sub; reflexivity.

red.
intro tl; repeat (rewrite <- app_assoc; simpl app); intros.
red in H0.
destruct (H0  _ H3) as [H'' e]; rewrite e.
destruct H''; simpl parse_summand_sub.
match goal with |- appcontext [parse_factor (l3 ++ tl) ?H] =>
  let a := fresh "a" in generalize H as a; intro a end.
remember (parse_factor (l3 ++ tl) _) as pf_val.
assert (parse_ret_data pf_val = Some (tl, val3)).
  rewrite Heqpf_val.
  apply H2; trivial.
destruct pf_val; simpl in H4; try discriminate H4.
injection H4; intros; subst.
match goal with |- appcontext [parse_summand_sub tl ?H] =>
  generalize H end.
intro a1; exists a1.
destruct (parse_summand_sub tl a1 (val1 * val3)); reflexivity.

red; intros.
destruct H; reflexivity.

red; intros.
destruct H1; simpl parse_factor.
match goal with |- appcontext [parse_factor (l2 ++ tl) ?H] =>
  let a := fresh "a" in generalize H as a; intro a end.
remember (parse_factor (l2 ++ tl) a0) as pf_val.
assert (parse_ret_data pf_val = Some (tl, val2)).
  rewrite Heqpf_val.
  apply H0; trivial.
destruct pf_val; simpl in H1; try discriminate H1.
injection H1; intros; subst.
reflexivity.

red; intros.
destruct H1; simpl parse_factor.
match goal with |- appcontext [parse_factor (l2 ++ tl) ?H] =>
  let a := fresh "a" in generalize H as a; intro a end.
remember (parse_factor (l2 ++ tl) a0) as pf_val.
assert (parse_ret_data pf_val = Some (tl, val2)).
  rewrite Heqpf_val.
  apply H0; trivial.
destruct pf_val; simpl in H1; try discriminate H1.
injection H1; intros; subst.
reflexivity.

red.
intro tl; replace ((OPEN_PAREN :: l2 ++ [CLOSE_PAREN]) ++ tl) with
  (OPEN_PAREN :: l2 ++ CLOSE_PAREN :: tl) by
  (simpl; rewrite <- app_assoc; reflexivity); intros.
destruct H1; simpl parse_factor.
match goal with |- appcontext [parse_expr (l2 ++ CLOSE_PAREN :: tl) ?H] =>
  let a := fresh "a" in generalize H as a; intro a end.
remember (parse_expr (l2 ++ CLOSE_PAREN :: tl) a0) as pe_val.
assert (parse_ret_data pe_val = Some (CLOSE_PAREN :: tl, val2)).
  rewrite Heqpe_val.
  apply H0; red; inversion 1.
destruct pe_val; simpl in H1; try discriminate H1.
injection H1; intros; subst.
reflexivity.
Qed.

Corollary parse_expr_completeness'' :
  forall {hd n} (Hexpr : expr_value hd n) tl,
  ~ starts_with tl PLUS -> ~ starts_with tl MINUS ->
  ~ starts_with tl TIMES -> forall H,
  parse_ret_data (parse_expr (hd ++ tl) H) = Some (tl, n).
Proof.
intros hd n Hexpr.
apply (parse_expr_completeness' Hexpr).
apply parse_expr_completeness.
Qed.

Corollary parse_expr_completeness_no_tail :
  forall (l : list token) (n : Z), expr_value l n -> forall H,
  parse_ret_data (parse_expr l H) = Some (nil, n).
Proof.
intros l n ?; rewrite (app_nil_end l); intros.
apply parse_expr_completeness''; trivial; red; inversion 1.
Qed.

Program Definition parse_expr_wrapper (l : list token) :
  { n:Z | unique (expr_value l) n } +
  { forall n:Z, ~ expr_value l n } :=
match parse_expr l (lt_wf _) with
| parse_success nil n _ => inleft _ n
| _ => inright _ _
end.
Next Obligation.
clear Heq_anonymous.
red; split.
rewrite <- app_nil_end; trivial.
intros m ?.
rewrite <- app_nil_end in H.
pose proof (parse_expr_completeness_no_tail _ _ H (lt_wf _)).
rewrite (parse_expr_completeness_no_tail _ _ e0 (lt_wf _)) in H0.
injection H0; auto.
Defined.
Next Obligation.
change (forall (n:Z) wildcard',
  parse_success l expr_value [] n wildcard' <>
  parse_expr l (lt_wf _)) in H.
intro.
remember (parse_expr l (lt_wf _)) as pe_val.
assert (parse_ret_data pe_val = Some (nil, n)) by
  (rewrite Heqpe_val; apply parse_expr_completeness_no_tail; trivial).
destruct pe_val; simpl in H1; try discriminate H1.
injection H1; intros; subst.
contradiction (H n e); reflexivity.
Defined.
}}}
