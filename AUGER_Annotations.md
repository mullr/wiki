Some dummy library to have annotations on your proof.
```coq
    Require Import String.
    Inductive Trace: Prop :=
    | End_of_trace: Trace
    | Trace_entry: Trace -> forall T, T -> Trace.
    Inductive STrace: Prop :=
     STrace_intro: bool -> Trace -> STrace.
    Ltac start_trace :=
      (set (trace := STrace_intro false End_of_trace);
       move trace at top)
    ||idtac "trace already started"
    .
    Ltac trace s :=
     match goal with
     | xtrace: STrace |- _
      => let trace_aux := fresh "trace_" in
         set (trace_aux :=
              match xtrace with
              | STrace_intro b t =>
                STrace_intro b (Trace_entry t _ s)
              end);
         (subst xtrace; rename trace_aux into xtrace;
          simpl in xtrace; move xtrace at top)
       ||(clear trace_aux;
          idtac "hypothesis are messing with the trace")
     | _ => idtac "trace wasn't started"
     end.
    Ltac trace_goal :=
     match goal with
     | xtrace: STrace |- ?g
      => let trace_aux := fresh "trace_" in
         set (trace_aux :=
              match xtrace with
              | STrace_intro b t =>
                STrace_intro b (Trace_entry t _ g)
              end);
         (subst xtrace; rename trace_aux into xtrace;
          simpl in xtrace; move xtrace at top)
       ||(clear trace_aux;
          idtac "hypothesis are messing with the trace")
     | _ => idtac "trace wasn't started"
     end.
    Notation "'Hidden'" := (STrace_intro false _).
    Notation "'>' x .. y" :=
     (STrace_intro true (Trace_entry (.. (Trace_entry End_of_trace _ x) ..) _ y))
     (at level 0,
      format "'>' '[v' x '/' .. '/' y ']'").
    Notation "'>!'" := (STrace_intro true End_of_trace) (at level 0).
    Ltac show_trace :=
     match goal with
     | xtrace: STrace |- _
      => let trace_aux := fresh "trace_" in
         set (trace_aux :=
              match xtrace with
              | STrace_intro _ t =>
                STrace_intro true t
              end);
         (subst xtrace; rename trace_aux into xtrace;
          simpl in xtrace; move xtrace at top)
       ||(clear trace_aux;
          idtac "hypothesis are messing with the trace")
     | _ => idtac "trace wasn't started"
     end.
    Ltac hide_trace :=
     match goal with
     | xtrace: STrace |- _
      => let trace_aux := fresh "trace_" in
         set (trace_aux :=
              match xtrace with
              | STrace_intro _ t =>
                STrace_intro false t
              end);
         (subst xtrace; rename trace_aux into xtrace;
          simpl in xtrace; move xtrace at top)
       ||(clear trace_aux;
          idtac "hypothesis are messing with the trace")
     | _ => idtac "trace wasn't started"
     end.

And a (not very relevant) example using it.

    Fixpoint sum_O_n n :=
     match n with
     | S m => n + sum_O_n m
     | O => O
     end.
    Open Scope string_scope.
    Goal forall n, (sum_O_n n)*2 = n*(S n).
     start_trace.
     trace "by induction on n".
     induction n.
      trace "case n is O".
      simpl.
      split.
     show_trace.
     trace "case n is not O".
     hide_trace.
     trace_goal.
     trace "we simplify it".
     simpl in *.
     do 2 f_equal.
     trace "it is now simplified".
     trace_goal.
    SearchAbout plus.
     trace "by distributivity and induction".
     rewrite Mult.mult_plus_distr_r.
     rewrite IHn; clear IHn.
     show_trace.
     trace_goal.
     hide_trace.
    SearchAbout mult.
     trace "by commutativity".
     do 2 (rewrite Mult.mult_comm; simpl).
     symmetry.
     rewrite Mult.mult_comm; simpl.
     rewrite <- plus_n_O.
     repeat rewrite Plus.plus_assoc.
     show_trace.
     split.
    Qed.
```