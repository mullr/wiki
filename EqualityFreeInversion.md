The basic idea for this method of generating inversion proofs without intermediate equalities is contained in the auto-generated proofs from discriminate and injection:

{{{#!coq
Lemma nat_discr: forall n:nat, S n <> 0.
Proof.
discriminate.
Defined.
Compute nat_discr.
     = fun (n : nat) (x : S n = 0) =>
       match
         match
           x in (_ = x0) return match x0 with
                                | 0 => False
                                | S _ => True
                                end
         with
         | eq_refl => I
         end return False
       with
       end
     : forall n : nat, S n <> 0
}}}
Ignoring the wrapping which destructs False just to get another proof of False, the essential idea is in providing a return type for a match expression which itself is a match expression.  Similarly, for the injection tactic:

{{{#!coq
Lemma S_inj: forall m n:nat, S m = S n -> m = n.
Proof.
injection 1; trivial.
Defined.
Compute S_inj.
     = fun (m n : nat) (x : S m = S n) =>
       match
         x in (_ = x0) return (m = match x0 with
                                   | 0 => m
                                   | S x1 => x1
                                   end)
       with
       | eq_refl => eq_refl m
       end
     : forall m n : nat, S m = S n -> m = n
}}}

This proof is morally equivalent to:

{{{#!coq
Definition S_inj': forall m n:nat, S m = S n -> m = n :=
fun m n Heq => match Heq in (_ = Sn) return
                 (match Sn return Prop with
                  | 0 => True
                  | S n' => m = n'
                  end) with
               | eq_refl => eq_refl m
               end.
}}}

So let's see some more simple examples of how to apply this idea:

{{{#!coq
Inductive even : nat -> Prop :=
| evenO : even 0
| evenS : forall n:nat, odd n -> even (S n)
with odd : nat -> Prop :=
| oddS : forall n:nat, even n -> odd (S n).

Definition evenS_inv : forall n:nat, even (S n) -> odd n :=
fun n Heven => match Heven in (even Sn) return
  (match Sn return Prop with
   | 0 => True
   | S n => odd n
   end) with
| evenO => I
| evenS n' Hodd => Hodd
end.

Definition oddS_inv : forall n:nat, odd (S n) -> even n :=
fun n Hodd => match Hodd in (odd Sn) return
  (match Sn return Prop with
   | 0 => False
   | S n => even n
   end) with
| oddS n' Heven => Heven
end.

Definition nodd0 : ~ odd 0 :=
fun Hodd => match Hodd in (odd n) return
  (match n return Prop with
   | 0 => False
   | S _ => True
   end) with
| oddS _ _ => I
end.
}}}

And a similar idea should often work for dependent induction:

{{{#!coq
Lemma le_resp_S_inv: forall (m n:nat), S m <= S n -> m <= n.
Proof.
intros.
apply le_ind with (P:=fun Sn:nat =>
                   match Sn with
                   | 0 => False
                   | S n' => m <= n'
                   end) (3:=H).
  constructor.

  intros.
  destruct m0.
    destruct H1.

    constructor; assumption.
Qed.
}}}

If some of the current hypotheses are dependent on the arguments of embedded constructors, it will be useful to revert those hypotheses before applying this strategy.  Let's see this in a slightly more complex example, involving extending an equivalence relation on A to an equivalence relation on list A:

{{{#!coq
Section list_eqv.

Require Import Morphisms.
Require Import RelationClasses.

Variable A:Type.
Variable A_eqv: A -> A -> Prop.

Inductive list_eqv : list A -> list A -> Prop :=
| nil_proper: Proper list_eqv nil
| cons_proper: Proper (A_eqv ==> list_eqv ==> list_eqv) (@cons A).

Context `{!Equivalence A_eqv}.
}}}

Proving reflexivity and symmetry is simple enough:

{{{#!coq
Global Instance list_eqv_refl : Reflexive list_eqv.
Proof.
intro l; induction l; constructor; trivial.
reflexivity.
Qed.

Global Instance list_eqv_sym : Symmetric list_eqv.
Proof.
intros l1 l2 Hlisteqv; induction Hlisteqv; constructor; trivial.
symmetry; assumption.
Qed.
}}}

It's in proving transitivity that some form of inversion is needed, so that we know the two equivalences come from the same constructor with compatible arguments:

{{{#!coq
Global Instance list_eqv_trans : Transitive list_eqv.
Proof.
intros l1 l2 l3 ? ?.
revert l3 H0; induction H.
  intros.
  refine (match H0 in (list_eqv nil' l3') return
            (match nil' return Prop with
             | nil => list_eqv nil l3'
             | cons _ _ => True
             end) with
          | nil_proper => _
          | cons_proper _ _ _ _ _ _ => _
          end).
    constructor.
    trivial.

  intros.
  revert H H0 IHlist_eqv.
  refine (match H1 in (list_eqv yy0' l3') return
            (match yy0' return Prop with
             | nil => True
             | cons y' y0' => A_eqv x y' -> list_eqv x0 y0' ->
               (forall l4:list A, list_eqv y0' l4 -> list_eqv x0 l4) ->
               list_eqv (cons x x0) l3'
             end) with
          | nil_proper => _
          | cons_proper _ _ _ _ _ _ => _
          end).
    trivial.

    intros H H0 IHlist_eqv.
    constructor.
      etransitivity; eassumption.

      eapply IHlist_eqv; eassumption.
Qed.
}}}

And for good measure, let's see an example with both arguments involving a constructor:

{{{#!coq
Lemma cons_proper_inv: forall (a1 a2:A) (l1 l2:list A),
  list_eqv (cons a1 l1) (cons a2 l2) ->
  A_eqv a1 a2 /\ list_eqv l1 l2.
Proof.
intros.
refine (match H in (list_eqv a1l1' a2l2') return
     (match a1l1', a2l2' return Prop with
      | cons a1' l1', cons a2' l2' =>
        A_eqv a1' a2' /\ list_eqv l1' l2'
      | _, _ => True
      end) with
  | nil_proper => _
  | cons_proper _ _ _ _ _ _ => _
  end).
  trivial.

  split; assumption.
Qed.

End list_eqv.
}}}

Sometimes, if one of the constructors of the top-level inductive type involves arguments with fewer constructors than what you're inverting, you will end up with a match expression to prove.  Of course, that calls for destructing the argument of the match...

{{{#!coq
Lemma le_S_inv: forall (m n:nat), m <= S n -> m <= n \/ m = S n.
Proof.
intros.
refine (match H in (_ <= Sn) return
          (match Sn return Prop with
           | 0 => True
           | S n' => m <= n' \/ m = S n'
           end) with
        | le_n => _
        | le_S _ _ => _
        end).
  destruct m.
    trivial.

    right; reflexivity.

  left; assumption.
Qed.
}}}

This might seem like a mere curiosity, given that the current inversion tactic can handle all these cases.  But where it really shines is in writing very readable functions on dependent types.  For some examples with the prototypical family of dependent types:

{{{#!coq
Inductive vector (X:Type) : nat -> Type :=
| vector_nil: vector X 0
| vector_cons: X -> forall n:nat, vector X n -> vector X (S n).

Implicit Arguments vector_nil [[X]].
Implicit Arguments vector_cons [[X] [n]].

Definition vector_hd {X:Type} {n:nat} (v:vector X (S n)) : X :=
match v in (vector _ Sn) return
  (match Sn with
   | 0 => unit
   | S _ => X
   end) with
| vector_nil => tt
| vector_cons h _ _ => h
end.

Definition vector_tl {X:Type} {n:nat} (v:vector X (S n)) : vector X n :=
match v in (vector _ Sn) return
  (match Sn with
   | 0 => unit
   | S n' => vector X n'
   end) with
| vector_nil => tt
| vector_cons _ _ t => t
end.
}}}

And for a "dependent inversion" type of statement, you may need to use the "convoy pattern" a couple times:

{{{#!coq
Require Import Program.  (* for the { (_, _) : _ * _ | _ } notation *)

Definition vector_decomp {X:Type} {n:nat} (v:vector X (S n)) :
  { (h, t) : X * vector X n | vector_cons h t = v } :=
match v as v' in (vector _ Sn) return
  (match Sn as Sn' return (vector X Sn' -> Type) with
   | 0 => fun _ => unit
   | S n' => fun v'' =>
         { (h, t) : X * vector X n' | vector_cons h t = v'' }
   end v') with
| vector_nil => tt
| vector_cons h _ t => exist _ (h, t) (eq_refl _)
end.
}}}

These definitions work beautifully with Coq-level computations.  There's just one small problem: the extractions aren't quite what you might want.

{{{#!coq
Extraction vector_hd.
(** val vector_hd : nat -> 'a1 vector -> 'a1 **)

let vector_hd n = function
| Vector_nil -> Obj.magic Tt
| Vector_cons (h, n0, v0) -> h
}}}

To fix the extraction, you can provide a context Prop which reduces to False in the unreachable case, so that it can "signal an exception" instead of returning a garbage value.

{{{#!coq
Definition vector_hd' {X:Type} {n:nat} (v:vector X (S n)) : X :=
match v in (vector _ Sn) return
  (match Sn return Prop with
   | 0 => False
   | S _ => True
   end -> X) with
| vector_nil => False_rect X
| vector_cons h _ _ => fun _:True => h
end I.

Definition vector_tl' {X:Type} {n:nat} (v:vector X (S n)) : vector X n :=
match v in (vector _ Sn) return
  (match Sn return Prop with
   | 0 => False
   | S _ => True
   end ->
   match Sn return Type with
   | 0 => Empty_set
   | S n' => vector X n'
   end) with
| vector_nil => False_rect Empty_set
| vector_cons _ _ t => fun _:True => t
end I.

Definition vector_decomp' {X:Type} {n:nat} (v:vector X (S n)) :
  { (h, t) : X * vector X n | vector_cons h t = v } :=
match v as v' in (vector _ Sn) return
  (match Sn return Prop with
   | 0 => False
   | S _ => True
   end ->
   match Sn as Sn' return (vector X Sn' -> Type) with
   | 0 => fun _ => Empty_set
   | S n' => fun v'' =>
       { (h, t) : X * vector X n' | vector_cons h t = v'' }
   end v') with
| vector_nil => False_rect Empty_set
| vector_cons h _ t => fun _:True => exist _ (h, t) (eq_refl _)
end I.
}}}

With these changes, reduction still works well within Coq; and now the extraction in OCaml is cleaned up:

{{{#!coq
Extraction vector_hd'.
(** val vector_hd' : nat -> 'a1 vector -> 'a1 **)

let vector_hd' n = function
| Vector_nil -> assert false (* absurd case *)
| Vector_cons (h, n0, v0) -> h
}}}

As a closing note, there are a couple situations I can think of where an intermediate equality hypothesis could still be useful: one is when there's an application of a function (which is not a constructor) within the inverted hypothesis.  (Example: im f (g x'), where im f : Y -> Prop is the image subset of the codomain of f.)  Another is when a single atomic argument to constructors shows up multiple times in the inverted hypothesis.  (Example: list_eqv (cons a l1) (cons a l2).)
