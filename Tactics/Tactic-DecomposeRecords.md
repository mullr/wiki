The following tactic decomposes all record-like structures in the context.

    Tactic Notation "decompose" "records" :=
      repeat (
        match goal with
        | H: _ |- _ => progress (decompose record H); clear H
        end).
