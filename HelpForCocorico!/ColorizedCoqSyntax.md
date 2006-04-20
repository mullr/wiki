Coq code with highlighted syntax
================================

In `Cocorico!`_ to present a piece of Coq code with syntax highlighting, you should enclose your code between ``{{{#!coq`` and ``}}}``.

For example

::

   Fixpoint log_inf (p:positive) : Z :=
     match p with
     | xH => 0   | xO q => Zsucc (log_inf q)   | xI q => Zsucc (log_inf q)   end.
   Theorem log_inf_correct :
    forall x:positive,
      0 <= log_inf x /\ two_p (log_inf x) <= Zpos x < two_p (Zsucc (log_inf x)).
   Lemma log_sup_correct1 : forall p:positive, 0 <= log_sup p.
   simple induction p; intros; simpl in |- *; auto with zarith.
   Qed.

By default you don't get any line numbers. Adding **numbers=on** adds line numbers to the code, which then can be toggled on and off in most browsers. 

::

   Fixpoint log_inf (p:positive) : Z :=
     match p with
     | xH => 0   | xO q => Zsucc (log_inf q)   | xI q => Zsucc (log_inf q)   end.
