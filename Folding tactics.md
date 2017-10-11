These tactic definitions can be used to fold multiple instances of negations:

    Tactic Notation "fold" "any" "not" :=
      repeat (
        match goal with
        | |- context [?P -> False] =>
          fold (~ P)
        end).

    Tactic Notation "fold" "any" "not" "in" ident(H) "|-" :=
      repeat (
        match goal with
        | J: context [?P -> False] |- _ =>
          fold (~ P) in H
        end).

    Tactic Notation "fold" "any" "not" "in" ident(H) :=
      fold any not in H |-.

    Tactic Notation "fold" "any" "not" "in" "*" "|-" :=
      repeat (
        match goal with
        | H: context [?P -> False] |- _ =>
          fold (~ P) in H
        end).

    Tactic Notation "fold" "any" "not" "in" "*" :=
      fold any not in * |-; fold any not.

    Tactic Notation "fold" "any" "not" "in" "*" "|-" "*" :=
      fold any not in *.

Similarly, these tactics can be uses to fold logical equivalences:

    Tactic Notation "fold" "any" "iff" :=
      repeat (
        match goal with
        | |- context [(?P -> ?Q) /\ (?Q -> ?P)] =>
          fold (P <-> Q)
        end).

    Tactic Notation "fold" "any" "iff" "in" ident(H) "|-" :=
      repeat (
        match goal with
        | J: context [(?P -> ?Q) /\ (?Q -> ?P)] |- _ =>
          fold (P <-> Q) in H
        end).

    Tactic Notation "fold" "any" "iff" "in" ident(H) :=
      fold any iff in H |-.

    Tactic Notation "fold" "any" "iff" "in" "*" "|-" :=
      repeat (
        match goal with
        | H: context [(?P -> ?Q) /\ (?Q -> ?P)] |- _ =>
          fold (P <-> Q) in H
        end).

    Tactic Notation "fold" "any" "iff" "in" "*" :=
      fold any iff in * |-; fold any iff.

    Tactic Notation "fold" "any" "iff" "in" "*" "|-" "*" :=
      fold any iff in *.
