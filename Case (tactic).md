A case tactic is used to mark your position in a proof.  For example

{{{#!coq
  Require Export String.
  Open Scope string_scope.
  
  Ltac move_to_top x :=
    match reverse goal with
    | H : _ |- _ => try move x after H
  end.
  
  Tactic Notation "assert_eq" ident(x) constr(v) :=
    let H := fresh in
    assert (x = v) as H by reflexivity;
    clear H.
  
  Tactic Notation "Case_aux" ident(x) constr(name) :=
    first [
      set (x := name); move_to_top x
    | assert_eq x name
    | fail 1 "because we are working on a different case." ].
  
  Ltac Case name := Case_aux case name.
  Ltac SCase name := Case_aux subcase name.
  Ltac SSCase name := Case_aux subsubcase name.
}}}

Now, you may define versions of induction tactics on a type that will automatically insert case markers as follows.

{{{#!coq
  Tactic Notation "induction" "nat" ident(n) :=
    induction n; [ Case "O" | Case "S" ].
  Tactic Notation "sub" "induction" "nat" ident(n) :=
    induction n; [ SCase "O" | SCase "S" ].
  Tactic Notation "sub" "sub" "induction" "nat" ident(n) :=
    induction n; [ SSCase "O" | SSCase "S" ].
}}}

If you use such customized versions of the induction tactics, then the "Case" tactic will verify that you are working on the case that you think you are.  You may also use the "Case" tactic with the standard version of "induction", in which case no verification is done.
