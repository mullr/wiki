In Coq, you can use notations to have fancy (and/or more readable) way to write your code in Coq. Here is an example of what you can have:

::

   Set Implicit Arguments.
   Record set (A: Type): Type :=
   Comprehension {In: A -> Prop}.
   Delimit Scope set_scope with set.
   Open Scope set_scope.
   Notation "{ x : s 'ﬆ' P }" :=
    ({|In:=λ (x: s), P|}) (at level 10, x at level 69): set_scope.
   Notation "{ x 'ﬆ' P }" := ({x:_ ﬆ P}) (at level 10, x at level 69): set_scope.
   Notation "x ∈ X" := (X.(In) x) (at level 40): set_scope.
   Notation "x ∉ X" := (¬(x ∈ X)) (at level 40): set_scope.
   Notation "X ⊆ Y" := (∀ x, x ∈ X → x ∈ Y) (at level 40): set_scope.
   Notation "X ≡ Y" := (X⊆Y ∧ Y⊆X) (at level 40): set_scope.
   Notation "X ∪ Y" := ({x ﬆ x ∈ X ∨ x ∈ Y}) (at level 55): set_scope.
   Notation "X ∩ Y" := ({x ﬆ x ∈ X ∧ x ∈ Y}) (at level 50): set_scope.
   Notation "⋃ X" := ({x ﬆ ∃ y, x ∈ y ∧ y ∈ X}) (at level 35): set_scope.
   Notation "⋂ X" := ({x ﬆ ∀ y, y ∈ X → x ∈ y}) (at level 30): set_scope.
   Notation "f ⁻¹ Σ" := ({x ﬆ (f x) ∈ Σ}) (at level 5): set_scope.
   Notation "∁ A" := ({x ﬆ x ∉ A}) (at level 5): set_scope.
   Definition empty_set (A: Type) := {x: A ﬆ ⊥}.
   Definition full_set (A: Type) := {x: A ﬆ ⊤}.
   Notation "₀ s" := (empty_set s) (at level 5): set_scope.
   Notation "₁ s" := (full_set s) (at level 5): set_scope.
   Definition finite_union {A: Type} (f: nat -> set A) :=
    fix finite_union n :=
    match n with
    | O => ₀A
    | S k => (f k) ∪ (finite_union k)
    end.
   Axiom Extensionnality: ∀ (S: Type) (σ1 σ2: set S), σ1 ≡ σ2 → σ1 = σ2.
   Class Topology (S: Type): Type :=
   { O: set (set S);
     Hempty: ₀S ∈ O;
     Hall: ₁S ∈ O;
     Hinter: ∀ ω1 ω2, (ω1 ∈ O) → (ω2 ∈ O) → (ω1 ∩ ω2) ∈ O;
     HUNION: ∀ ωs, (∀ ω, (ω ∈ ωs) → (ω ∈ O)) → (⋃ωs) ∈ O
   }.
   Definition Compact {A: Type} {ΩA: Topology A} a :=
    ∀ os, (a ⊆ ⋃os ∧ (∀ o, (o ∈ os) → (o ∈ O))) →
    ∃ subos, ∃ n, (∀ m, m<n → (subos m) ∈ os) ∧ a ⊆ (finite_union subos n).
   Definition Separables {A: Type} {ΩA: Topology A} x y :=
    ∃ ox, ∃ oy,
    ((y ∈ oy) ∧ (oy ∈ O)) ∧
    ((x ∈ ox) ∧ (ox ∈ O)) ∧
    (ox ⊆ ∁oy).
   Lemma compacts_are_closed:
    ∀ A {ΩA: Topology A}, (∀ x y, x ≠ y → Separables x y) →
    ∀ a, Compact a → (∁a ∈ O).

It seems cool, but how to have a way to input such a code in (almost) any editor under X? A good way is to have a "XIM" compliant editor (under X, almost any editor is XIM compliant; so it is the case for emacs, xterm, url in firefox, …), then following some tutorials on XCompose, you can have some cool stuff:

::

   echo 'GTK_IM_MODULE=xim' >> $PROFILE
   echo 'QT_IM_MODULE=xim' >> $PROFILE
   echo 'XMODIFIERS=@im=xim' >> $PROFILE

where $PROFILE is "~/.profile" or "~/.xinitrc" (or any script file run at logging time under X).

Now, if you do not have a "<Multi-key>", it can be (although not necessary) to define one:

::

   echo 'keycode 117 = Multi_key' >> ~/.Xmodmap

To know the keycode you want, you can use xev.

Now create or edit "~/.XCompose" to have your wished compositions:

::

   echo 'include "~/.XCompose.my_symbols"' >> ~/.XCompose
   touch ~/.XCompose.my_symbols

Now, you have to edit this file to have your own compositions. Take a look at the official webpage of unicode to find the unicode codes you want.

The expected format is:

[non_empty_list_of_keys_or_unicode_name] : [optional "\""utf8-encoded-character"\""] [optional unicode-name] [optional "U"unicode-code]

for instance:

::

   echo '<Multi_key> <a> <l> <l> : "∀" U2200' >> ~/.XCompose.my_symbols

Finally restart your X server, and all should work.

See `this file for an example`_.

.. ############################################################################

.. _this file for an example: ../XCompose_symbols

