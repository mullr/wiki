Require Import Arith Wf_nat Omega Utf8.

(** A simple extraction example : factorial *)

Fixpoint fact n :=
 match n with
  | 0 => 1
  | S m => n * fact m
 end.

Extraction fact.
Recursive Extraction fact.
(* Extraction "fact.ml" fact. *)

Extraction Language Haskell.
Recursive Extraction fact.

Extraction Language Ocaml.


(** Extraction of "pure" proofs : no contents *)

Lemma le_or_lt : ∀n m : nat, n ≤ m \/ m < n.
Proof. intros; omega. Qed.

Print le_or_lt.

Extraction le_or_lt.

Locate "\/". Check or. (* Prop → Prop → Prop *)

(** The logic of Coq guarantees indeed that we cannot use
    things in Prop to build informative things (in Set or Type). *)

Fail Check (if le_or_lt 3 5 then true else false).



(** Mixed approach : functions with logical parts
    (or dualy proofs with "computational content") *)

Check le_lt_dec.
Locate "{ _ } + { _ }". Check sumbool. (* Prop → Prop → Set *)
Recursive Extraction le_lt_dec.
Print le_lt_dec.


(** It is possible to make explicit the isomorphism between
    extracted sumbool and bool. *)
Extract Inductive sumbool => bool [true false].
Recursive Extraction le_lt_dec.



(** In addition to logical parts, the extraction also
    discards types. *)

Definition id (X:Type)(x:X) := x.
Extraction id.

Definition mix := (nat,0).
Extraction mix.



(** The extracted code might be untypable in ML.
    For instance, consider n-ary functions. *)

Fixpoint nArrow n : Type :=
  match n with
    | 0 => nat
    | S n => nat → nArrow n
  end.

Compute nArrow 5.

Fixpoint nSum_acc n acc : nArrow n :=
  match n with
    | 0 => acc
    | S m => (fun a => nSum_acc m (acc+a))
  end.

Definition nSum n : nArrow n := nSum_acc n 0.

Compute (nSum 2) 1 3 : nat. (* computes 1+3=4 *)
Compute (nSum 5) 1 3 5 7 9 : nat. (* computes 1+3+5+7+9=25 *)

Recursive Extraction nSum.



(** There exists 3 particular situations where Prop things might
    influe on informative terms. *)

(** 1) False elimination *)

Definition ex_falso_quodlibet (F:False) : nat :=
 match F with end.

Extraction ex_falso_quodlibet.

(** 2) Equality elimination (or any other logical singleton type) *)

Definition strange_cast (H:bool=nat) : bool -> nat.
Proof. intro b. rewrite <- H. exact b. Defined.

Definition strange_cast' (H:bool=nat) : bool -> nat :=
 fun b => match H in (_ = t) return t with eq_refl => b end.

Extraction strange_cast'.

(** 3) Use of Acc for controling a fixpoint
       (leading to general recursion in Coq) *)

Print Acc_rect.
Extraction Acc_rect.

(** A invalid axiom might then lead to extracted code that :
    1) might trigger an exception
    2) crash badly (invalid use of an Obj.magic)
    3) loop forever
    Similarly it is crucial to not reduce extracted terms
    under lambdas (and we keep some extra lambdas,
    see e.g. False_rect). *)



(** Cumulativity of sorts : a Prop is also a Type. *)

Check option.

Definition logical_option : option True := Some I.
Extraction logical_option.

(** A complex example showing that __ cannot always been
    implemented as () in a strict language like OCaml. *)

Definition compo (X:Type)(f:nat->X)(g:X->nat) := g (f 0).
Extraction compo.

Definition logical_compo := compo True (fun _ => I) (fun _ => 0).
Recursive Extraction logical_compo.

(** Same in Haskell : *)
Extraction Language Haskell.
Recursive Extraction logical_compo.

Extraction Language Ocaml.



(** Complexity *)

(** In case of use of recursors like [nat_rect]
   (for instance programming by tactics), the recursive call
   is made each time in CBV, even if it doesn't help.
   Solution: we unfold in advance these recursors. *)

Definition le_lt_dec' : forall n m : nat, { n ≤ m } + { m < n }.
Proof.
induction n.
auto with arith.
induction m.
auto with arith.
destruct (IHn m); auto with arith.
Defined.

(** If we force the extraction to leave [nat_rect] folded,
    we obtain a function with exponential cost. *)
Extraction NoInline nat_rect.
Recursive Extraction le_lt_dec'.
