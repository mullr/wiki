
Set Implicit Arguments.

(* Extraction: prune some "useless" parts (proofs + types)
   and replace them by arbitrary values *)

(* Btw, why do we need replacement values ?
   - Old extraction to Fw was doing total removal
   - Now, handling the sort Type leads to polymorphism (think of id)
   - We also need to preserve evaluation order (cf. False_rec)
   - Hopefully, post-extraction optimization get rid of most
     "dummy" values *)

(* Issue: arbitrary values aren't so arbitrary at the moment... *)

Module Fun.

Definition f {X} (h:nat->X)(g:X->nat) := g (h 0).

Definition f_set := f S S.
Definition f_prop := f (fun _ => I) (fun _ => 1).
Definition f_type := f (fun _ => nat) (fun _ => 1).

End Fun.

(* In Ocaml, the extracted arbitrary value __ should hence be able
   to receive arguments, at least in the current extraction
   framework. Hence the choice "let rec __ x = __" *)
Recursive Extraction Fun.
Extraction Language Haskell.
(* With lazy evaluation, no issue at all, __ is "error" *)
Recursive Extraction Fun.
Extraction Language Ocaml.


(* Same issue, encoded inside an inductive type *)

Module Ind.

Inductive t (X:Type) : Type := T : (nat->X)->(X->nat)-> t X.

Definition f {X} (x : t X) := match x with T h g => g (h 0) end.

Definition f_set := f (T S S).
Definition f_prop := f (T (fun _ => I) (fun _ => 1)).
Definition f_type := f (T (fun _ => nat) (fun _ => 1)).

End Ind.

Recursive Extraction Ind.


(* Strong elimination (pattern matching for producing types)
   mixed with cumulativity *)

Module Match.

Definition t (b:bool) := if b then nat else True.

Definition f (b:bool)(h:nat->t b)(g:t b ->nat) := g (h 0).

Definition f_true := f true S S.
Definition f_false := f false (fun _ => I) (fun _ => 1).

End Match.

Recursive Extraction Match.

(* Since Coq 8.2 (more or less), an specific instance of
   a singleton inductive type could live in Prop while
   the initial type is defined in Type. This is a major issue
   for extraction. Current answer: detect this and refuse to
   extract, otherwise extracted code might segfault :-(.
*)

Module Poly.

Definition f {X} (p : (nat -> X) * True) : X * nat :=
  (fst p 0, 0).

Definition f_set := f (S,I).
Definition f_prop := f ((fun _ => I),I).
Definition f_type := f ((fun _ => nat),I).

End Poly.

Fail Recursive Extraction Poly.

(* !! le polyprop warning est H.S. en 8.5 !! *)


(* More strong elimination (and fixpoint this time) *)

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

End Fix.

Recursive Extraction Fix.
