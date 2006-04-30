{{{#!coq 
Ltac exist_hyp t := match goal with
  | H1:t |- _ => idtac
 end.

Ltac clean_duplicated_hyps :=
  repeat match goal with
      | H:?X1 |- _ => clear H; exist_hyp X1
end.
}}}
