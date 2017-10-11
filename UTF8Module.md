This file is created from scratch. Feel free to enlarge/shorten/modify it. It is tried that the `level`s given here are consistent with the output of `Print Grammar constr` command. Yet some levels are chosen arbitrarily, for the apparent lack of a better alternative at the time of the creation. -- [MiladNiqui](../MiladNiqui) \[\[DateTime(2005-05-31T16:53:09Z)\]\]\_

    (* Notation " A ⇒ B " := (A => B) (at level 90, right associativity) : type_scope. *)
    Notation " A → B " := (A -> B) (at level 90, right associativity) : type_scope.
    (* Notation " A ← B " := (A <- B) (at level 90, right associativity) : type_scope. *)
    Notation " ∀ x , B  " := (forall x:_, B ) (at level 200, x at level 0, no associativity) : type_scope.
    Notation " ∀ x y , B  " := (forall (x:_) (y:_), B ) (at level 200, x at level 0, y at level 0, no associativity) : type_scope.
    Notation " ∀ x y z , B  " := (forall (x:_) (y:_) (z:_), B ) (at level 200, x at level 0, y at level 0, z at level 0, no associativity) : type_scope.
    Notation " ∀ x y z t , B  " := (forall (x:_) (y:_) (z:_) (t:_), B ) (at level 200, x at level 0, y at level 0, z at level 0, t at level 0, no associativity) : type_scope.
    Notation " ∀ x y z t u , B  " := (forall (x:_) (y:_) (z:_) (t:_) (u:_), B ) (at level 200, x at level 0, y at level 0, z at level 0, t at level 0, u at level 0, no associativity) : type_scope.
    Notation " ∀ x : A , B  " := (forall x:A, B ) (at level 200, x at level 0, no associativity) : type_scope.
    Notation " ∀ ( x : A1 )  ( y : A2 ) , B  " := (forall (x:A1) (y:A2), B ) (at level 200, x at level 0, y at level 0, no associativity) : type_scope.
    Notation " ∀ x ( y : A2 ) , B  " := (forall (x:_) (y:A2), B ) (at level 200, x at level 0, y at level 0, no associativity) : type_scope.
    Notation " ¬ x " := (not  x) (at level 75, right associativity) : type_scope.
    Notation " A × B " := (A * B) (at level 40, left associativity) : type_scope.
    Notation " A ≠ B " := (A <> B) (at level 70, no associativity) : type_scope.
    Notation " A ≠ B :> T " := (A <> B :> T) (at level 70, no associativity) : type_scope.
    Notation " A ≤ B " := (A <= B) (at level 70, no associativity) : type_scope.
    Notation " A ≥ B " := (A >= B) (at level 70, no associativity) : type_scope.
    Notation " A ∧ B " := (A /\ B) (at level 80, right associativity) : type_scope.
    Notation " A ⇔ B " := (A <-> B) (at level 95, right associativity) : type_scope.
    Notation " ⊥ " := (False) : type_scope.
    Notation " ⊤ " := (True) : type_scope.
    Notation " A ∨ B " := (A \/ B) (at level 85, right associativity) : type_scope.
    Notation " ∃ x , B  " := (ex (fun x:_=>B) ) (at level 0, x at level 99, no associativity) : type_scope.
    Notation " ∃ x : A , B  " := (ex (fun x:A=>B) ) (at level 0, x at level 99, no associativity) : type_scope.
    Notation " ∃! x , B  " := (ex (unique (fun x => B))) (at level 200, x ident, right associativity) : type_scope.
    Notation " ∃! x : A , B  " := (ex (unique (fun x:A => B))) (at level 200, x ident, right associativity) : type_scope.
    Notation " 'ℕ' " := nat : type_scope.
    (* Notation  "'λ' x : T , y" := (fun x:T => y) (at level 1, x,T,y at level 10). *)
    Notation  "x : T ⟼ y" := (fun x:T => y) (at level 1, x,T,y at level 10).
    (* Notation  "'λ' x := T , y" := ([x:=T] y) (at level 1, x,T,y at level 10). *)
    (* Notation " 'ℤ' " := Int : type_scope.
    Notation " 'ℤ'⁺ " := positive : type_scope.
    Notation " 'ℚ' " := Q : type_scope.
    Notation " 'ℝ' " := R : type_scope.
    Notation " 'ℝ' ⁺ " := posreal : type_scope.
    Notation " 'ℝ' ⁻ " := negreal : type_scope. *)

attachment:utf8.v\_utf8.v\`<attachment:None%60_>

Usage
=====

This file (and all the files based on the notation defined in this file) should be saved with the charset encoding UTF-8, otherwise you won't be able to compile it with `coqc`. In order to ensure this in [CoqIde](../CoqIde) you should go to

**Edit** -&gt; **Preferences** -&gt; **Files**

and set **File charset encoding** to UTF-8. (This is also explained in [Section 14.8.3 of the Reference Manual](http://coq.inria.fr/V8.1/refman/Reference-Manual016.html#toc100).)
