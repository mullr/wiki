This implements a certified parser on a simple grammar of arithmetic expressions. It assumes the input has already been tokenized.

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
      expr_value (l1 ++ PLUS :: l3) (val1 + val3)
    | expr_rule_3 : forall (l1 : list token) (val1 : Z)
      (l3 : list token) (val3 : Z),
      expr_value l1 val1 -> summand_value l3 val3 ->
      expr_value (l1 ++ MINUS :: l3) (val1 - val3)
    with
    summand_value : list token -> Z -> Prop :=
    | summand_rule_1 : forall (l1 : list token) (val1 : Z),
      factor_value l1 val1 -> summand_value l1 val1
    | summand_rule_2 : forall (l1 : list token) (val1 : Z)
      (l3 : list token) (val3 : Z),
      summand_value l1 val1 -> factor_value l3 val3 ->
      summand_value (l1 ++ TIMES :: l3) (val1 * val3)
    with
    factor_value : list token -> Z -> Prop :=
    | factor_rule_1 : forall (n : Z),
      factor_value [NUM n] n
    | factor_rule_2 : forall (l2 : list token) (val2 : Z),
      factor_value l2 val2 -> factor_value (PLUS :: l2) val2
    | factor_rule_3 : forall (l2 : list token) (val2 : Z),
      factor_value l2 val2 -> factor_value (MINUS :: l2) (- val2)
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
    Local Ltac recog_tail :=
      eauto using app_nil_start, app_cons_start, app_app_start.
    Inductive parse_ret (l : list token) (cond : list token -> Z -> Prop) : Set :=
    | parse_success : forall (tl : list token) (n : Z),
      (exists hd : list token, l = hd ++ tl /\ cond hd n) ->
      parse_ret l cond
    | parse_failure : parse_ret l cond.
    Definition expr_sub_value (n : Z) : list token -> Z -> Prop :=
    fun l m => forall (n_str : list token), expr_value n_str n ->
      expr_value (n_str ++ l) m.
    (* Reduction rules for the fake "expr_sub n" symbol:
      expr_sub n <- empty => n
                  | PLUS summand (expr_sub (n+$2)) => $3
                  | MINUS summand (expr_sub (n-$2)) => $3 *)
    Lemma expr_sub_rule1 : forall n : Z,
      expr_sub_value n nil n.
    Proof.
    intros n ? ?; rewrite <- app_nil_end; trivial.
    Qed.
    Lemma expr_sub_rule2 : forall (n : Z)
      (l2 : list token) (val2 : Z) (l3 : list token) (val3 : Z),
      summand_value l2 val2 ->
      expr_sub_value (n + val2) l3 val3 ->
      expr_sub_value n (PLUS :: l2 ++ l3) val3.
    Proof.
    intros.
    intros ? ?.
    evar (hd : list token); match goal with |- expr_value ?l _ =>
                replace l with (hd ++ l3) by (symmetry; recog_tail); subst hd
                            end.
    eauto using expr_value.
    Qed.
    Lemma expr_sub_rule3 : forall (n : Z)
      (l2 : list token) (val2 : Z) (l3 : list token) (val3 : Z),
      summand_value l2 val2 ->
      expr_sub_value (n - val2) l3 val3 ->
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
    fun l m => forall (n_str : list token),
      summand_value n_str n -> summand_value (n_str ++ l) m.
    (* Reduction rules for the fake "summand_sub n" symbol:
      summand_sub n <- empty => n
                     | TIMES factor (summand_sub (n*$2)) => $3 *)
    Lemma summand_sub_rule1 : forall n : Z,
      summand_sub_value n nil n.
    Proof.
    intros; intros ? ?; rewrite <- app_nil_end; trivial.
    Qed.
    Lemma summand_sub_rule2 : forall (n : Z)
      (l2 : list token) (val2 : Z) (l3 : list token) (val3 : Z),
      factor_value l2 val2 ->
      summand_sub_value (n * val2) l3 val3 ->
      summand_sub_value n (TIMES :: l2 ++ l3) val3.
    Proof.
    intros.
    intros ? ?.
    evar (hd : list token); match goal with |- summand_value ?l _ =>
                replace l with (hd ++ l3) by (symmetry; recog_tail); subst hd
                            end.
    eauto using summand_value.
    Qed.
    (* Notations to allow us to act as if our parser functions were
       instances of StateT (list token) Maybe Z -- which they are if one
       ignores the proof content. *)
    (* First, a couple utility functions which are literally instances of
       StateT (list token) Maybe (option token), and
       StateT (list token) Maybe token, respectively. *)
    (* Peek at the next token, without removing it from the parser stream;
       if at end of stream, return None, but don't signal an error *)
    Definition peek_token (l : list token) : option (list token * option token) :=
    match l with
    | nil => Some (l, None)
    | t :: _ => Some (l, Some t)
    end.
    (* Get the next token and remove it from the parser stream;
       if at end of stream, signal an error *)
    Definition get_token (l : list token) : option (list token * token) :=
    match l with
    | nil => None
    | t :: l' => Some (l', t)
    end.
    (* Our actual intermediate terms that we build as part of the notation
       will be of this form: *)
    Definition parse_monad_type (P : list token -> list token -> Prop)
      (cond : list token -> Z -> Prop) : Set :=
      forall l l0, P l l0 -> parse_ret l0 cond.
    (* Here, l0 represents the "initial state", needed to specify the
       return type, and l represents the "current state".
       P will represent enough "context" from the monad invocations
       so far to continue.  For example, in the first return_ statement
       in parse_expr_sub below, P might look like:
       fun l l0 =>
       exists hd, expr_sub_value (n + m) hd result /\
       exists hd0, summand_value hd0 m /\
       exists l', get_token l' = Some (hd0 ++ hd ++ l, Anonymous) /\
       exists l'', peek_token l'' = Some (l', t) /\
       l'' = l0.
       For the outer structure, we will build an instance of
       parse_monad_type eq cond, and then pass arguments
       l l eq_refl *)
    Program Definition parse_monad_bind {X P cond}
      (x : list token -> option (list token * X))
      (g : forall x0:X, parse_monad_type
                       (fun l l0 => exists l', x l' = Some (l, x0) /\
                                    P l' l0)
                       cond) :
      parse_monad_type P cond :=
    fun l l0 H =>
    match x l as o return (x l = o -> _) with
    | Some (l', x0) => fun _ => g x0 l' l0 _
    | None => fun _ => parse_failure _ _
    end eq_refl.
    Next Obligation.
    eexists; split; [ reflexivity | eassumption ].
    Defined.
    Program Definition parse_monad_bind_rec {P sz sz' cond cond'}
      (subparse : forall (l : list token), sz' l < sz ->
                    parse_ret l cond')
      (g : forall n:Z, parse_monad_type
                       (fun l l0 => exists hd, cond' hd n /\ P (hd ++ l) l0)
                       cond) :
      (forall l l0:list token, P l l0 -> sz' l < sz) ->
      parse_monad_type P cond :=
    fun Hlt l l0 H =>
    match subparse l _ return _ with
    | parse_success tl n _ => g n tl l0 _
    | parse_failure => parse_failure _ _
    end.
    Next Obligation.
    eexists; split; eassumption.
    Defined.
    Notation "'do' x0 <- x ; y" :=
      (parse_monad_bind x (fun x0 => y))
    (at level 70, right associativity, x0 ident).
    Notation "'do_rec' n <- x ; y" :=
      (parse_monad_bind_rec x (fun n => y) _)
    (at level 70, right associativity, x0 ident).
    Notation "'return_' n" := (fun l l0 _ => parse_success _ _ l n _)
    (at level 71).
    Notation "'error'" := (fun l l0 _ => parse_failure _ _)
    (at level 71).
    (* Notation "'subparser' p Hacc" :=
      (fun l Hlt => p l (Acc_inv Hacc Hlt)) (at level 90). *)
    Definition subparser {P sz} (p : forall l, Acc lt (sz l) -> P l)
      {n} (Hacc : Acc lt n) :=
      fun (l:list token) (Hlt : sz l < n) => p l (Acc_inv Hacc Hlt).
    Definition parse_expr_sz (l : list token) := 5 * length l + 4.
    Definition parse_expr_sub_sz (l : list token) := 5 * length l + 3.
    Definition parse_summand_sz (l : list token) := 5 * length l + 2.
    Definition parse_summand_sub_sz (l : list token) := 5 * length l + 1.
    Definition parse_factor_sz (l : list token) := 5 * length l.
    Program Definition run_with_initial_state (l : list token) {cond}
      (m : parse_monad_type (fun l0 l1 => l0 = l /\ l1 = l) cond) :
      parse_ret l cond :=
    m l l _.
    Obligation Tactic := program_simpl; simpl; simpl in *;
      eauto using expr_value, summand_value, factor_value;
      try (repeat split; discriminate);
      repeat match goal with
      | H : ?f ?l = _ |- _ =>
        match f with
        | peek_token => idtac
        | get_token => idtac
        | _ => fail
        end;
        (is_var l; destruct l; (discriminate H || (injection H; intros; subst));
         clear H) ||
        (simpl f in H; injection H; intros; subst; clear H)
      end;
      try (unfold parse_expr_sz, parse_expr_sub_sz, parse_summand_sz,
                  parse_summand_sub_sz, parse_factor_sz;
           simpl length; repeat rewrite app_length;
           repeat match goal with
           H : _ |- _ => apply expr_nonempty in H ||
                      apply summand_nonempty in H ||
                      apply factor_nonempty in H
           end; omega);
      try (eexists; split; [ recog_tail |
                             eauto using expr_value, summand_value, factor_value,
                             expr_sub_rule1, expr_sub_rule2, expr_sub_rule3,
                             summand_sub_rule1, summand_sub_rule2 ]).
    Program Definition parse_expr_builder (l : list token)
      (parse_summand : forall l', parse_summand_sz l' < parse_expr_sz l ->
         parse_ret l' summand_value)
      (parse_expr_sub : forall n l', parse_expr_sub_sz l' < parse_expr_sz l ->
         parse_ret l' (expr_sub_value n)) :
      parse_ret l expr_value :=
    run_with_initial_state l (
    do_rec n <- parse_summand;
    do_rec m <- parse_expr_sub n;
    return_ m
    ).
    Program Definition parse_expr_sub_builder (n : Z) (l : list token)
      (parse_summand : forall l', parse_summand_sz l' < parse_expr_sub_sz l ->
         parse_ret l' summand_value)
      (parse_expr_sub : forall n l', parse_expr_sub_sz l' < parse_expr_sub_sz l ->
         parse_ret l' (expr_sub_value n)) :
      parse_ret l (expr_sub_value n) :=
    run_with_initial_state l (
    do t <- peek_token;
    match t with
    | Some PLUS => do _ <- get_token;
                   do_rec m <- parse_summand;
                   do_rec result <- parse_expr_sub (n + m)%Z;
                   return_ result
    | Some MINUS => do _ <- get_token;
                    do_rec m <- parse_summand;
                    do_rec result <- parse_expr_sub (n - m)%Z;
                    return_ result
    | _ => return_ n
    end
    ).
    Program Definition parse_summand_builder (l : list token)
      (parse_summand_sub : forall n l',
         parse_summand_sub_sz l' < parse_summand_sz l ->
         parse_ret l' (summand_sub_value n))
      (parse_factor : forall l',
         parse_factor_sz l' < parse_summand_sz l ->
         parse_ret l' factor_value) :
      parse_ret l summand_value :=
    run_with_initial_state l (
    do_rec n <- parse_factor;
    do_rec m <- parse_summand_sub n;
    return_ m
    ).
    Program Definition parse_summand_sub_builder (n : Z) (l : list token)
      (parse_summand_sub : forall n l',
         parse_summand_sub_sz l' < parse_summand_sub_sz l ->
         parse_ret l' (summand_sub_value n))
      (parse_factor : forall l',
         parse_factor_sz l' < parse_summand_sub_sz l ->
         parse_ret l' factor_value) :
      parse_ret l (summand_sub_value n) :=
    run_with_initial_state l (
    do t <- peek_token;
    match t with
    | Some TIMES => do _ <- get_token;
                    do_rec m <- parse_factor;
                    do_rec result <- parse_summand_sub (n * m)%Z;
                    return_ result
    | _ => return_ n
    end
    ).
    Program Definition parse_factor_builder (l : list token)
      (parse_expr : forall l',
         parse_expr_sz l' < parse_factor_sz l ->
         parse_ret l' expr_value)
      (parse_factor : forall l',
         parse_factor_sz l' < parse_factor_sz l ->
         parse_ret l' factor_value) :
      parse_ret l factor_value :=
    run_with_initial_state l (
    do t <- get_token;
    match t with
    | NUM n => return_ n
    | PLUS => do_rec n <- parse_factor;
              return_ n
    | MINUS => do_rec n <- parse_factor;
               return_ (-n)
    | OPEN_PAREN => do_rec n <- parse_expr;
                    do t <- get_token;
                    match t with
                    | CLOSE_PAREN => return_ n
                    | _ => error
                    end
    | _ => error
    end
    ).
    Fixpoint
    parse_expr (l : list token) (H : Acc lt (parse_expr_sz l)) {struct H} :
      parse_ret l expr_value :=
    parse_expr_builder l
      (fun l' Hlt => parse_summand l' (Acc_inv H Hlt))
      (fun n l' Hlt => parse_expr_sub n l' (Acc_inv H Hlt))
    with
    parse_expr_sub (n : Z) (l : list token) (H : Acc lt (parse_expr_sub_sz l))
      {struct H} : parse_ret l (expr_sub_value n) :=
    parse_expr_sub_builder n l
      (fun l' Hlt => parse_summand l' (Acc_inv H Hlt))
      (fun n l' Hlt => parse_expr_sub n l' (Acc_inv H Hlt))
    with
    parse_summand (l : list token) (H : Acc lt (parse_summand_sz l)) {struct H} :
      parse_ret l summand_value :=
    parse_summand_builder l
      (fun n l' Hlt => parse_summand_sub n l' (Acc_inv H Hlt))
      (fun l' Hlt => parse_factor l' (Acc_inv H Hlt))
    with
    parse_summand_sub (n : Z) (l : list token) (H : Acc lt (parse_summand_sub_sz l))
      {struct H} : parse_ret l (summand_sub_value n) :=
    parse_summand_sub_builder n l
      (fun n l' Hlt => parse_summand_sub n l' (Acc_inv H Hlt))
      (fun l' Hlt => parse_factor l' (Acc_inv H Hlt))
    with
    parse_factor (l : list token) (H : Acc lt (parse_factor_sz l)) {struct H} :
      parse_ret l factor_value :=
    parse_factor_builder l
      (fun l' Hlt => parse_expr l' (Acc_inv H Hlt))
      (fun l' Hlt => parse_factor l' (Acc_inv H Hlt)).
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
    Definition parse_expr_completeness_stmt hd n :=
      forall tl, ~ starts_with tl TIMES -> forall H, exists H',
      parse_ret_data (parse_expr (hd ++ tl) H) =
      parse_ret_data (parse_expr_sub n tl H').
    Definition parse_summand_completeness_stmt hd n :=
      forall tl, forall H, exists H',
      parse_ret_data (parse_summand (hd ++ tl) H) =
      parse_ret_data (parse_summand_sub n tl H').
    Definition parse_factor_completeness_stmt hd n :=
      forall tl, forall H,
      parse_ret_data (parse_factor (hd ++ tl) H) = Some (tl, n).
    Lemma parse_expr_completeness' {hd n} :
      parse_expr_completeness_stmt hd n ->
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
    Lemma parse_summand_completeness' {hd n} :
      parse_summand_completeness_stmt hd n ->
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
    Lemma parse_expr_completeness : forall hd n, expr_value hd n ->
      parse_expr_completeness_stmt hd n
    with
    parse_summand_completeness : forall hd n, summand_value hd n ->
      parse_summand_completeness_stmt hd n
    with
    parse_factor_completeness : forall hd n, factor_value hd n ->
      parse_factor_completeness_stmt hd n.
    Proof.
    Local Ltac inst_sub_cases parse_expr_completeness
      parse_summand_completeness parse_factor_completeness :=
    destruct 1; repeat match goal with
    | e : expr_value ?hd ?n |- _ =>
      progress match goal with
      | _ : parse_expr_completeness_stmt hd n |- _ => idtac
      | |- _ => let H := fresh in pose proof
             (parse_expr_completeness _ _ e) as H;
             pose proof (parse_expr_completeness' H)
      end
    | s : summand_value ?hd ?n |- _ =>
      progress match goal with
      | _ : parse_summand_completeness_stmt hd n |- _ => idtac
      | |- _ => let H := fresh in pose proof
             (parse_summand_completeness _ _ s) as H;
             pose proof (parse_summand_completeness' H)
      end
    | f : factor_value ?hd ?n |- _ =>
      progress match goal with
      | _ : parse_factor_completeness_stmt hd n |- _ => idtac
      | |- _ => pose proof (parse_factor_completeness _ _ f)
      end
    end; clear parse_expr_completeness parse_summand_completeness
      parse_factor_completeness.
    3: inst_sub_cases parse_expr_completeness parse_summand_completeness
      parse_factor_completeness.
    2: inst_sub_cases parse_expr_completeness parse_summand_completeness
      parse_factor_completeness.
    inst_sub_cases parse_expr_completeness parse_summand_completeness
      parse_factor_completeness.
    Guarded.
    Local Ltac subcase_intros :=
    intro tl; repeat (simpl app; rewrite <- app_assoc; simpl app); intros.
    Local Ltac expand_parser :=
    match goal with
    | H : Acc _ _ |- _ => destruct H; simpl
    end;
    unfold parse_expr_builder, parse_expr_sub_builder,
      parse_summand_builder, parse_summand_sub_builder, parse_factor_builder,
      run_with_initial_state, parse_monad_bind_rec, parse_monad_bind; simpl.
    Local Ltac red_expr_completeness :=
    match goal with
    | H : parse_expr_completeness_stmt ?l ?val |-
      appcontext [parse_expr (?l ++ ?tl) ?Hacc] =>
      let H0 := fresh in
      assert (~ starts_with tl TIMES) as H0 by (red; inversion 1);
      destruct (H _ H0 Hacc) as [? e]; rewrite e
    end.
    Local Ltac red_parse_expr :=
    match goal with
    | |- appcontext [parse_expr (?l ++ ?tl) ?H] =>
       let a := fresh "a" in generalize H as a; intro a;
       remember (parse_expr (l ++ tl) a) as pe_val;
       try (match goal with
                   | H0 : forall tl, ~ starts_with tl PLUS ->
                        ~ starts_with tl MINUS -> ~ starts_with tl TIMES ->
                     forall H, parse_ret_data (parse_expr (l ++ tl) H) =
                       Some (tl, ?val),
                     Heq : pe_val = _ |- _ =>
                     let Hplus := fresh in
                     assert (~ starts_with tl PLUS) as Hplus by
                       (red; inversion 1);
                     let Hminus := fresh in
                     assert (~ starts_with tl MINUS) as Hminus by
                       (red; inversion 1);
                     let Htimes := fresh in
                     assert (~ starts_with tl TIMES) as Htimes by
                       (red; inversion 1);
                     let Heqdata := fresh in
                     assert (parse_ret_data pe_val = Some (tl, val)) as Heqdata by
                       (rewrite Heq; apply (H0 _ Hplus Hminus Htimes));
                     destruct pe_val; discriminate Heqdata ||
                                      (injection Heqdata; intros; subst)
                     end)
    end.
    Local Ltac red_summand_completeness :=
    match goal with
    | H : parse_summand_completeness_stmt ?l ?val |-
      appcontext [parse_summand (?l ++ ?tl) ?Hacc] =>
      destruct (H _ Hacc) as [? e]; rewrite e
    end.
    Local Ltac red_parse_summand :=
    match goal with
    | |- appcontext [parse_summand (?l ++ ?tl) ?H] =>
       let a := fresh "a" in generalize H as a; intro a;
       remember (parse_summand (l ++ tl) a) as ps_val;
       try (match goal with
                   | H0 : forall tl, ~ starts_with tl TIMES ->
                     forall H, parse_ret_data (parse_summand (l ++ tl) H) =
                       Some (tl, ?val),
                     H1 : ~ starts_with tl TIMES,
                     Heq : ps_val = _  |- _ =>
                     let Heqdata := fresh in
                     assert (parse_ret_data ps_val = Some (tl, val)) as Heqdata by
                       (rewrite Heq; apply (H0 _ H1));
                   destruct ps_val; discriminate Heqdata ||
                                    (injection Heqdata; intros; subst)
                   end)
    end.
    Local Ltac red_parse_factor :=
    match goal with
    | |- appcontext [parse_factor (?l ++ ?tl) ?H] =>
       let a := fresh "a" in generalize H as a; intro a;
       remember (parse_factor (l ++ tl) a) as pf_val;
       try (match goal with
            | H0 : parse_factor_completeness_stmt l ?val,
              Heq : pf_val = _ |- _ =>
              let Heqdata := fresh in
                assert (parse_ret_data pf_val = Some (tl, val)) as Heqdata by
                   (rewrite Heq; apply H0);
                destruct pf_val; discriminate Heqdata ||
                                 (injection Heqdata; intros; subst)
            end)
    end.
    Local Ltac end_state p :=
    match goal with
    | |- appcontext [p ?tl ?H] =>
       let a := fresh "a" in generalize H as a; intro a; exists a;
       destruct (p tl a); reflexivity
    end.
    abstract (subcase_intros; expand_parser; red_parse_summand;
              end_state (parse_expr_sub val1)).
    abstract (subcase_intros; red_expr_completeness; expand_parser;
      red_parse_summand; end_state (parse_expr_sub (val1 + val3))).
    abstract (subcase_intros; red_expr_completeness; expand_parser;
      red_parse_summand; end_state (parse_expr_sub (val1 - val3))).
    abstract (subcase_intros; expand_parser; red_parse_factor;
      end_state (parse_summand_sub val1)).
    abstract (subcase_intros; red_summand_completeness; expand_parser;
      red_parse_factor; end_state (parse_summand_sub (val1 * val3))).
    abstract (subcase_intros; expand_parser; reflexivity).
    abstract (subcase_intros; expand_parser; red_parse_factor; reflexivity).
    abstract (subcase_intros; expand_parser; red_parse_factor; reflexivity).
    abstract (subcase_intros; expand_parser; red_parse_expr;
      simpl; reflexivity).
    Qed.
    Corollary parse_expr_completeness'' :
      forall {hd n}, expr_value hd n -> forall tl,
      ~ starts_with tl PLUS -> ~ starts_with tl MINUS ->
      ~ starts_with tl TIMES -> forall H,
      parse_ret_data (parse_expr (hd ++ tl) H) = Some (tl, n).
    Proof.
    intros hd n Hexpr.
    apply parse_expr_completeness'.
    apply parse_expr_completeness; trivial.
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
    rewrite (parse_expr_completeness_no_tail _ _ e0) in H0.
    injection H0; auto.
    Defined.
    Next Obligation.
    change (forall n wildcard',
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
    (* For extraction, use:
    Require Import ExtrOcamlBasic.
    Extraction Inline parse_expr_builder parse_expr_sub_builder
      parse_summand_builder parse_summand_sub_builder parse_factor_builder
      parse_monad_bind parse_monad_bind_rec run_with_initial_state.
    Recursive Extraction parse_expr_wrapper.
    *)
