This file takes all the notations of "Utf8.v" and "Utf8-core.v" and adds a lot of others.
See this [[XComposeAndNotations|page]] to find how to use XCompose for an easy access to
special characters.
{{{#!coq
(* Logic *)
Notation "∀  x .. y , P" := (forall x, .. (forall y, P) ..)
  (at level 200, x binder, y binder, right associativity) : type_scope.
Notation "∃  x .. y , P" := (exists x, .. (exists y, P) ..)
  (at level 200, x binder, y binder, right associativity) : type_scope.

Notation "x ∨ y" := (x \/ y) (at level 85, right associativity) : type_scope.
Notation "x ∧ y" := (x /\ y) (at level 80, right associativity) : type_scope.
Notation "x → y" := (x -> y) (at level 90, right associativity): type_scope.
Notation "x ↔ y" := (x <-> y) (at level 95, no associativity): type_scope.
Notation "¬ x" := (~x) (at level 75, right associativity) : type_scope.
Notation "x ≠ y" := (x <> y) (at level 70) : type_scope.
Notation "⊤" := (True).
Notation "⊥" := (False).

(* Functions *)
Notation "'λ'  x .. y · t" := (fun x => .. (fun y => t) ..)
  (at level 200, x binder, y binder, right associativity).
Notation "f ∘ g" := (λ x · f (g x)) (at level 20, right associativity).

(* Arithmetic *)
Notation "x ≤ y" := (le x y) (at level 70, no associativity).
Notation "x ≥ y" := (ge x y) (at level 70, no associativity).
Notation "x ≮ y" := (¬ (x < y)) (at level 70, no associativity).
Notation "x ≯ y" := (¬ (x > y)) (at level 70, no associativity).
Notation "x ≰ y" := (¬ (x ≤ y)) (at level 70, no associativity).
Notation "x ≱ y" := (¬ (x ≥ y)) (at level 70, no associativity).

(* Types *)
Delimit Scope init_scope with init.
Notation "'ℕ'" := nat: init_scope.
Notation "'𝟘'" := Empty_set: init_scope.
Notation "'𝟙'" := unit: init_scope.
Notation "'𝟚'" := bool: init_scope.
Notation "'𝕠'" := tt: init_scope.
Notation "'𝕥'" := true: init_scope.
Notation "'𝕗'" := false: init_scope.
Notation "x ₁" := (let (y, _) := x in y) (at level 5).
Notation "x ₂" := (let (_, y) := x in y) (at level 5).

Close Scope init_scope.

(* Sets *)
Delimit Scope set_scope with set.
Open Scope set_scope.
Notation "{ x : s 'ﬆ' P }" :=
 (λ (x: s)·(P: Prop)) (at level 10, x at level 69): set_scope.
Notation "{ x 'ﬆ' P }" := ({x:_ ﬆ P}) (at level 10, x at level 69): set_scope.
Notation "x ∈ X" := ((X: _ → Prop) x) (at level 40): set_scope.
Notation "x ∉ X" := (¬(x ∈ X)) (at level 40): set_scope.
Notation "X ⊆ Y" := (∀ x, x ∈ X → x ∈ Y) (at level 40): set_scope.
Notation "X ≡ Y" := (X⊆Y ∧ Y⊆X) (at level 40): set_scope.
Notation "X ∪ Y" := ({x ﬆ x ∈ X ∨ x ∈ Y}) (at level 55): set_scope.
Notation "X ∩ Y" := ({x ﬆ x ∈ X ∧ x ∈ Y}) (at level 50): set_scope.
Notation "⋃ X" := ({x ﬆ ∃ y, x ∈ y ∧ y ∈ X}) (at level 35): set_scope.
Notation "⋂ X" := ({x ﬆ ∀ y, y ∈ X → x ∈ y}) (at level 30): set_scope.
Notation "f ⁻¹ Σ" := ({x ﬆ (f x) ∈ Σ}) (at level 5): set_scope.
Notation "∁ A" := ({x ﬆ x ∉ A}) (at level 5): set_scope.
Notation "₀ s" := ({x: s ﬆ ⊥}) (at level 5): set_scope.
Notation "₁ s" := ({x: s ﬆ ⊤}) (at level 5): set_scope.
Notation "'℘' s" :=
 ({x ﬆ ∀ a, (x a: Prop) → (s a: Prop)}) (at level 5): set_scope.

Close Scope set_scope.
}}}
