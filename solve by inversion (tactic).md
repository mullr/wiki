{{{#!coq
  Tactic Notation "solve_by_inversion_aux" tactic(t) :=
    match goal with
    | H : _ |- _ => solve [ inversion H; subst++; t ]
    end
    || fail "because the goal is not solvable by inversion.".
  
  Tactic Notation "solve" "by" "inversion" "1" :=
    solve_by_inversion_aux idtac.
  Tactic Notation "solve" "by" "inversion" "2" :=
    solve_by_inversion_aux (solve by inversion 1).
  Tactic Notation "solve" "by" "inversion" "3" :=
    solve_by_inversion_aux (solve by inversion 2).
  Tactic Notation "solve" "by" "inversion" :=
    solve by inversion 1.
}}}
`solve by inversion n` will attempt to solve the goal by `n` successive uses of `inversion` (where `n` may range between `1` and `3`, given the above definitions).  This tactic uses [[subst++ (tactic)|subst++]] to maximize its effectiveness but could work almost as well replacing `subst++` with `subst`.
