
Set Primitive Projections. (* Requires Coq 8.5 *)
Set Implicit Arguments.

(* Explicit cumulativity : we lift manually Prop statements
   to the Type level *)

Record lift (A:Prop) : Set := up { down : A }.

(* Older version, lacking the convertibility of (up ∘ down) with id
Inductive lift (A:Prop) : Type := up : A -> lift A.
Definition down (A:Prop)(a:lift A) := match a with up a' => a' end.
*)

Recursive Extraction lift down.

(* The Record formulation behaves nicely w.r.t. conversion *)

Lemma down_up (A:Prop)(a:A) : down (up a) = a.
Proof.
 simpl. reflexivity.
Qed.

Lemma up_down (A:Prop)(a:lift A) : up (down a) = a.
Proof.
 reflexivity. (* cf Matthieu, surjective pairing :-) *)
 (* old proof: destruct a. simpl. reflexivity. *)
Qed.

(* The switch to explicit cumulativity may require some eta-expansion *)
(* For instance, let's define nat_ind out of nat_rect *)

Definition nat_ind' :
 forall P : nat -> Prop,
   P 0 -> (forall n : nat, P n -> P (S n)) -> forall n : nat, P n :=
  fun P h0 hS n =>
    down
      (nat_rect
         (fun n => lift (P n))
         (up h0)
         (fun n h => up (hS n (down h))) n).

(* Conjecture: we could translate any CIC terms in this way, and
   embed them into a CIC' with no Prop/Type cumulativity rule. *)

(* Related works:
   - Ali Assaf : in his explicit system, there is a "lift", but
     no explicit "up" and "down", and convertibility equations
     such that (A->lift B) is the same as lift(A->B).
     Here we precisely don't want this kind of equation, but
     rather be "low level".
   - Matthieu Sozeau and Philip Haselwarter
     http://www.haselwarter.org/~philipp/piCoq.pdf
   - Also related to Lasson/Keller parametricity
*)


(* With explicit cumulativity, the extraction can handle nicely
   many troublesome situations: in terms such as Fun.f_prop',
   the dummy extracted value __ could be ().

   That doesn't solve all issues, cf for instance Fun.f_type
   (collapsing type schemes while we should probably collapse
    only types).
*)

Module Fun.

Definition f {X} (h:nat->X)(g:X->nat) := g (h 0).

Definition f_set := f S S.
Definition f_prop := f (fun _ => I) (fun _ => 1).
Definition f_type := f (fun _ => nat) (fun _ => 1).

Definition f_prop' := f (fun _ => up I) (fun _ => 1).

End Fun.

Recursive Extraction Fun.


Module Match.

Definition t (b:bool) := if b then nat else True.

Definition f (b:bool)(h:nat->t b)(g:t b ->nat) := g (h 0).

Definition f_true := f true S S.
Definition f_false := f false (fun _ => I) (fun _ => 1).

Definition t' (b:bool) := if b then nat else lift True.
Definition f' (b:bool)(h:nat->t' b)(g:t' b ->nat) := g (h 0).
Definition f'_true := f' true S S.
Definition f'_false := f' false (fun _ => up I) (fun _ => 1).

End Match.

Recursive Extraction Match.


Module Ind.

Inductive t (X:Type) : Type := T : (nat->X)->(X->nat)-> t X.

Definition f {X} (x : t X) := match x with T h g => g (h 0) end.

Definition f_set := f (T S S).
Definition f_prop := f (T (fun _ => I) (fun _ => 1)).
Definition f_type := f (T (fun _ => nat) (fun _ => 1)).

Definition f_prop' := f (T (fun _ => up I) (fun _ => 1)).

End Ind.

Recursive Extraction Ind.


(* Below, things get really interesting, since the old-style extraction
   of Poly.f_prop leads to segfault (match on a function), cf S. Glondu's
   thesis. The current fix in Coq 8.4 is to detect these situations and
   refuse to extract. In Coq 8.5 this fix is currently broken. To be
   investigated. With explicit cumulativity, no problem anymore :-) *)

Module Poly.

Definition f {X} (p : (nat -> X) * True) : X * nat :=
  (fst p 0, 0).

Definition f_set := f (S,I).
Definition f_prop := f ((fun _ => I),I).
Definition f_type := f ((fun _ => nat),I).

Definition f_prop' := f ((fun _ => up I), I).

End Poly.

Recursive Extraction Poly.



Module Fix.

Fixpoint arity (X:Type) n : Type := match n with
 | 0 => nat
 | S n => (nat->X)->arity X n
end.

Fixpoint f {X} n (g:X->nat) acc : arity X n := match n with
 | 0 => acc
 | S n => fun (h:nat->X) => f n g (g (h acc))
end.

Definition f_nat := f 2 S 0 S S.
Definition f_prop := f 2 (fun _=>3) 0 (fun _=>I) (fun _=>I).
Definition f_prop' := f 2 (fun _=>3) 0 (fun _=>up I) (fun _=>up I).

End Fix.

Recursive Extraction Fix.
(* NB: etrange, des (fun x ->...) au lieu de (fun _ ->...) dans f_prop' *)