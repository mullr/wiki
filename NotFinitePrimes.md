Proof that there are not a finite number of primes.  Compatable with Coq 7.3

{{{
Require Mult.
Require Le. 
Require PolyList.

Definition one : nat := (S O).
Definition two : nat := (S one).

Theorem P1 : (a:nat)(~(S a) = O).
Proof.
Compute.
Intros.
Apply (O_S a).
Symmetry.
Assumption.
Qed.

Theorem P2 : (a:nat)(b:nat)(lt a b) -> (~(b = O)).
Proof.
Intros.
Compute in H.
Induction H.
Exact (P1 a).
Intros.
Exact (P1 m).
Qed.

Theorem P3 : (a:nat)(b:nat)(gt a b) -> ~(a = O).
Proof.
Intros a b.
Exact (P2 b a).
Qed.

Theorem P4: (a:nat)(b:nat)(plus a b)=(plus b a).
Proof.
Double Induction 1 2.
Reflexivity.
Intros.
Unfold 1 plus.
Refine (plus_n_O ?).
Intros.
Unfold 2 plus.
Symmetry.
Refine (plus_n_O ?).
Intros.
Unfold plus.
Fold plus.
Rewrite (H0 (S n)).
Rewrite <- (H n0 H0).
Unfold plus.
Fold plus.
Rewrite (H0 n).
Reflexivity.
Qed.

Theorem P5: (a:nat)(b:nat)(le b (plus a b)).
Proof.
Intros.
Induction a.
Unfold plus.
Exact (le_n b).
Unfold plus.
Apply le_S.
Assumption.
Qed.

Theorem P6 : (a:nat)(b:nat)(ge (mult a b) b)\/((mult a b) = O).
Proof.
Intros.
Induction a.
Right.
Reflexivity.
Left.
Unfold mult.
Unfold ge.
Fold plus.
Fold mult.
Rewrite (P4 b (mult a b)).
Apply P5.
Qed.

Theorem P7 : (a:nat)(b:nat)(lt a b) -> (le b a) -> False.
Proof.
Intros a b p1.
Induction p1.
Apply Le.le_Sn_n.
Intros.
Apply Hrecp1.
Apply Le.le_trans_S.
Assumption.
Qed.

Definition divides : nat -> nat -> Prop :=
[a:nat][b:nat](EX c:nat | (mult c a) = b).

Theorem P8 : (a:nat)(b:nat)(~(b = O) -> (gt a b) -> ~(divides a b)).
Proof.
Unfold not.
Intros.
Unfold gt in H.
Unfold divides in H1.
Induction H1.
Induction b.
Apply H.
Reflexivity.
Case (P6 x a).
Unfold ge.
Unfold gt in H0.
Rewrite H1.
Unfold lt in H.
Apply P7.
Assumption.
Intros.
Rewrite H1 in H2.
Discriminate H2.
Qed.

Definition isPrime : nat -> Prop :=
[a:nat](gt a one)/\((d:nat)(divides d a) -> ((d = one) \/ (d = a))).

Definition Prime : Set := (sig nat [p:nat](isPrime p)).

Definition listProd : (list nat) -> nat :=
[l:(list nat)](fold_right mult one l).

Theorem P9 : (l:(list nat))(n:nat)(In n l) -> (divides n (listProd l)).
Proof.
Intro.
Induction l.
Intros.
ElimType False.
Apply (in_nil H).
Intros.
Unfold In in H.
Induction H.
Rewrite <- H.
Unfold divides.
Exists (listProd l).
Unfold listProd.
Unfold fold_right.
Lemma P9_1 : (a:nat)(b:nat)(mult a b)=(mult b a).
Proof.
Intro.
Induction a.
Intros.
Simpl.
Apply (mult_n_O).
Intros.
Simpl.
Rewrite Hreca.
Rewrite <- (mult_n_Sm).
Apply P4.
Qed.
Apply P9_1.
Simpl.
Unfold divides.
Lemma P9_2 : (a:nat)(b:nat)(n:nat)(divides n a) -> (divides n (mult b a)).
Proof.
Intros.
Case H.
Intros.
Exists (mult b x).
Rewrite <- H0.
Symmetry.
Apply mult_assoc_l.
Qed.
Apply P9_2.
Apply Hrecl.
Assumption.
Qed.

Definition pi1 : (A:Set)(P:A->Prop)(sig A P)->A :=
[A:Set][P:A->Prop][x:(sig A P)]let (y,_)=x in y.

Definition nonZero : Set := (sig nat [n:nat](IsSucc n)).

Theorem P10 : (p:Prime)(IsSucc (pi1 ? ? p)).
Proof.
Unfold Prime.
Intros.
Induction p.
Simpl.
Unfold isPrime in p.
Induction p.
Unfold gt in H.
Induction H.
Compute.
Trivial.
Compute.
Trivial.
Qed.

Theorem P11 : (a:nonZero)(b:nonZero)(IsSucc (mult (pi1 ? ? a) (pi1 ? ? b))).
Proof.
Intros.
Induction a.
Induction b.
Simpl.
Compute in p.
Compute in p0.
Unfold IsSucc.
Induction x.
ElimType False.
Assumption.
Clear Hrecx.
Induction x0.
ElimType False.
Assumption.
Clear Hrecx0.
Compute.
Trivial.
Qed.

Theorem P12 : (l:(list nonZero))(IsSucc (listProd (map (pi1 ? ?) l))).
Proof.
Intros.
Induction l.
Compute.
Trivial.
Induction a.
Simpl.
Apply (P11 (exist nat ? x p)
   (exist ? ? (listProd (map (pi1 nat [n:nat](IsSucc n)) l)) Hrecl)).
Qed.

Definition succ : nat -> nonZero  :=
[a:nat](exist ? [n:nat](IsSucc n) (S a) I).

Theorem P13 : (l:(list nonZero))(x:nonZero)(In x l) ->
(ge (listProd (map (pi1 ? ?) l)) (pi1 ? ? x)).
Proof.
Intro.
Induction l.
Intros.
Simpl.
Simpl in H.
Elim H.
Intros.
Induction x.
Induction a.
Simpl.
Simpl in H.
Case H.
Intros.
Injection H0.
Intros.
Rewrite H1.
Case (P6 (listProd (map (pi1 nat [n:nat](IsSucc n)) l)) x).
Rewrite (mult_sym (listProd (map (pi1 nat [n:nat](IsSucc n)) l)) x).
Trivial.
Intros.
ElimType False.
Cut (IsSucc (mult (listProd (map (pi1 nat [n:nat](IsSucc n)) l)) x)).
Intros.
Rewrite H2 in H3.
Simpl in H3.
Assumption.
Apply  (P11 (exist ? ? (listProd (map (pi1 nat [n:nat](IsSucc n)) l)) (P12 l)) (exist ? ? x p)).
Intros.
Case (P6 x0 (listProd (map (pi1 nat [n:nat](IsSucc n)) l))).
Intros.
Unfold ge.
Apply le_trans with (listProd (map (pi1 nat [n:nat](IsSucc n)) l)).
Unfold ge in Hrecl.
Apply (Hrecl (exist ? ? x p)).
Assumption.
Unfold ge in H1.
Assumption.
Intros.
ElimType False.
Cut (IsSucc (mult x0 (listProd (map (pi1 nat [n:nat](IsSucc n)) l)))).
Rewrite H1.
Trivial.
Apply (P11 (exist ? ? x0 p0) (exist ? ? (listProd (map (pi1 nat [n:nat](IsSucc n)) l)) (P12 l))).
Qed.

Theorem P14 : (l:(list nonZero))
~(In (succ (listProd (map (pi1 ? ?) l)))  l).
Proof.
Unfold not.
Intros.
Cut (ge (listProd (map (pi1 nat [n:nat](IsSucc n)) l))
            (S (listProd (map (pi1 ? ?) l)))).
Unfold ge.
Apply (le_Sn_n).
Apply (P13 l (succ (listProd (map (pi1 nat [n:nat](IsSucc n)) l)))).
Assumption.
Qed.

Theorem P15 : (a:nat)(b:nat)(c:nat)
  (divides a b) -> (divides b c) -> (divides a c).
Proof.
Intros.
Induction H.
Induction H0.
Exists (mult x0 x).
Rewrite <- H in H0.
Rewrite mult_assoc_r.
Assumption.
Qed.

Theorem CourseOfValues : (P:(nat->Prop))
  ((n:nat)(f:((m:nat)(lt m n)->(P m)))(P n))->(a:nat)(P a).
Proof.
Intros.
Assert ((m:nat)(lt m a)->(P m)).
Induction a.
Intros.
Compute in H0.
Elim (le_Sn_O m).
Assumption.
LetTac p := (H a Hreca).
Intros.
Compute in H0.
LetTac z := (le_lt_or_eq ? ? H0).
Case z.
Intros.
Apply Hreca.
Apply lt_S_n.
Assumption.
Intros.
Injection H1.
Intros.
Rewrite H2.
Exact p.
Apply H.
Assumption.
Qed.

Theorem P16: (a:nat)(b:nat)(a=b)\/~(a=b).
Proof.
Double Induction 1 2.
Left.
Trivial.
Intros.
Right.
Apply O_S.
Intros.
Right.
Unfold not.
Intros.
Apply (O_S n).
Symmetry.
Trivial.
Intros.
Case (H0 n).
Intros.
Left.
Apply eq_S.
Assumption.
Intros.
Right.
Unfold not.
Intros.
Apply H1.
Apply eq_add_S.
Assumption.
Qed.

Theorem P17 : (n:nat)(P:nat->Prop)(Q:nat->Prop)((a:nat)(P a)\/(Q a))->
((m:nat)(lt m n)->(P m))\/(EX m:nat | (lt m n) /\ (Q m)).
Proof.
Intros.
Induction n.
Left.
Intros.
ElimType False.
Apply (lt_n_O m).
Assumption.
Case (H n).
Intros.
Case Hrecn.
Intros.
Left.
Intros.
Unfold lt in H2.
Case (le_lt_or_eq ? ? H2).
Intros.
Apply H1.
Apply lt_S_n.
Assumption.
Intros.
Rewrite (eq_add_S ? ? H3).
Assumption.
Intros.
Right.
Induction H1.
Exists x.
Induction H1.
Constructor.
Apply lt_S.
Assumption.
Assumption.
Intros.
Right.
Exists n.
Constructor.
Auto.
Assumption.
Qed.

Theorem P18 : (n:nat)(gt n one)->((d:nat)(le d n)->(divides d n)->(d=one)\/(d=n))
->(isPrime n).
Intros.
Constructor.
Assumption.
Intros.
Case (le_or_lt d n).
Intros.
Apply H0.
Assumption.
Assumption.
Intros.
LetTac p := (P8 d n).
ElimType False.
Apply p.
Compute in H.
Unfold not.
Intros.
Rewrite H3 in H.
Apply (le_Sn_O (S O)).
Assumption.
Assumption.
Assumption.
Qed.

Theorem P19 : (A:Prop)(B:Prop)(A\/B)->(B\/A).
Intros.
Case H.
Auto.
Auto.
Qed.

Theorem P20 : (a:nat)(b:nat)~(divides a  b)\/(divides a b).
Proof.
Intros.
Induction b.
Right.
Unfold divides.
Exists O.
Trivial.
Clear Hrecb.
Cut ((c:nat)(lt c (S (S b)))->~(mult c a)=(S b))\/(EX c:nat |(lt c (S (S b)))/\(mult c a)=(S b)).
Intros.
Case H.
Intros.
Left.
Unfold not in H0.
Unfold not.
Intros.
Induction H1.
Apply (H0 x).
Case (mult_O_le x a).
Intros.
Rewrite H2 in H1.
Rewrite <- (mult_n_O x) in H1.
Elim (O_S ? H1).
Rewrite mult_sym in H1.
Rewrite <- H1.
Refine (le_lt_n_Sm ? ?).
Assumption.
Intros.
Right.
Induction H0.
Unfold divides.
Exists x.
Induction H0.
Assumption.
Apply (P17 (S (S b)) [n:nat]~(mult n a)=(S b) [n:nat](mult n a)=(S b)).
Intros.
Apply P19.
Apply P16.
Qed.

Theorem P21 : (n:nat)(gt n one)->(isPrime n)\/(EX d:nat | (lt one d)/\(lt d n)/\(divides d n)).
Proof.
Intros.
Unfold isPrime.
Assert ((d:nat)(lt d (S n))->(divides d n)->d=one\/d=n)\/(EX d:nat | (lt d (S n))/\(lt d n)/\(gt d one)/\(divides d n)).
Apply (P17 (S n) [d:nat]((divides d n)->d=one\/d=n) [d:nat](lt d n)/\(gt d one)/\(divides d n)).
Intros.
Case (P20 a n).
Intros.
Left.
Intros.
Elim (H0 H1).
Intros.
Case (P16 a one).
Intro.
Left.
Intro.
Left.
Assumption.
Case (P16 a n).
Intros.
Left.
Intros.
Right.
Assumption.
Intros.
Right.
Constructor.
Case (le_or_lt a n).
Intros.
Case (le_lt_or_eq ? ? H3).
Auto.
Intros.
Elim (H1 H4).
Intros.
ElimType False.
Apply (P8 a n).
Unfold not.
Intros.
Rewrite H4 in H.
Compute in H.
Apply (le_Sn_O (S O)).
Assumption.
Assumption.
Assumption.
Constructor.
Induction a.
Induction H0.
Rewrite <- (mult_n_O x) in H0.
Elim (H1 H0).
Induction a.
Elim H2.
Auto.
Compute.
Apply le_n_S.
Apply le_n_S.
Apply le_O_n.
Assumption.
Case H0.
Intro.
Left.
Constructor.
Assumption.
Intro.
Case (le_or_lt (S n) d).
Intros.
ElimType False.
Apply (P8 d n).
Unfold not.
Intros.
Rewrite H4 in H.
Compute in H.
Apply (le_Sn_O ? H).
Assumption.
Assumption.
Apply H1.
Intros.
Right.
Induction H1.
Exists x.
Induction H1.
Induction H2.
Induction H3.
Constructor.
Assumption.
Constructor.
Assumption.
Assumption.
Qed.

Theorem P22 : (n:nat)(divides O n) -> (n=O).
Proof.
Intros.
Induction H.
Rewrite (mult_n_O x).
Symmetry.
Assumption.
Qed.

Theorem P23 : (isPrime two).
Proof.
Unfold isPrime.
Constructor.
Compute.
Constructor.
Intros.
Induction d.
Assert (two=O).
Apply P22.
Assumption.
Discriminate H0.
Clear Hrecd.
Induction d.
Left.
Trivial.
Clear Hrecd.
Induction d.
Right.
Trivial.
Clear Hrecd.
ElimType False.
Apply (P8 (S (S (S d))) two).
Discriminate.
Compute.
Repeat Apply (le_n_S).
Apply (le_O_n).
Assumption.
Qed.

Theorem P24 : (n:nat)(divides n O).
Proof.
Intros.
Unfold divides.
Exists O.
Compute.
Auto.
Qed.

Theorem P25 : (n:nat)(n=one)\/(EX p:Prime | (divides (pi1 ? ? p) n)).
Proof.
Apply (CourseOfValues [n:nat](n=one)\/(EX p:Prime | (divides (pi1 ? ? p) n))).
Intros.
Induction n.
Right.
LetTac z := (exist ? ? two P23).
Exists z.
Apply P24.
Clear Hrecn.
Induction n.
Left.
Trivial.
Clear Hrecn.
Right.
LetTac m := (S (S n)).
Assert (isPrime m)\/(EX d:nat | (lt one d)/\(lt d m)/\(divides d m)).
Apply P21.
Compute.
Repeat Apply le_n_S.
Apply le_O_n.
Case H.
Intro.
Exists (exist ? ? m H0).
Unfold divides.
Exists one.
Simpl.
Rewrite <- (plus_n_O n).
Trivial.
Intro.
Induction H0.
Induction H0.
Induction H1.
Case (f x H1).
Intro.
Rewrite H3 in H0.
Elim (lt_n_n ? H0).
Intro.
Induction H3.
Exists x0.
Apply P15 with x.
Assumption.
Assumption.
Qed.

Theorem P26 : (B:Set)(P:B->Prop)(a:(sig B P))(l:(list (sig B P)))
  (In a l)->(In (pi1 ? ? a) (map (pi1 ? ?) l)).
Proof.
Intros.
Induction a.
Simpl.
Induction l.
Assumption.
Simpl.
Simpl in H.
Case H.
Intro.
Left.
Rewrite H0.
Trivial.
Intro.
Right.
Apply Hrecl.
Assumption.
Qed.

Theorem P27 : (a:nat)(b:nat)(m:nat)(lt a b)->
  (le (plus m (mult m a)) (mult m b)).
Proof.
Intros.
Induction m.
Trivial.
Unfold 2 mult.
Fold mult.
Unfold 1 plus.
Fold plus.
Induction b.
Elim (lt_n_O a H).
Clear Hrecb.
Unfold 2 plus.
Fold plus.
Apply le_n_S.
Unfold 1 mult.
Fold mult.
Rewrite (plus_assoc_l m a (mult m a)).
Rewrite (plus_sym m a).
Rewrite (plus_assoc_r a m (mult m a)).
Apply (le_plus_plus).
Apply (le_S_n).
Assumption.
Assumption.
Qed.

Theorem P28 : (a:nat)(b:nat)(divides a b)->(divides a (S b))->(a=one).
Proof.
Intros.
Induction H.
Induction H0.
Rewrite (mult_sym x a) in H.
Rewrite (mult_sym x0 a) in H0.
Case (le_or_lt x0 x).
Intro.
Assert (le (mult a x0) (mult a x)).
Apply mult_le.
Assumption.
Rewrite H in H2.
Rewrite H0 in H2.
Elim (le_Sn_n b H2).
Intro.
Assert (le (plus a (mult a x)) (mult a x0)).
Refine (P27 ? ? a H1).
Rewrite H in H2.
Rewrite H0 in H2.
Induction a.
Compute in H H0.
Rewrite <- H in H0.
Discriminate H0.
Induction a.
Trivial.
Clear Hreca Hreca0.
Unfold plus in H2.
Fold plus in H2.
Assert (le (S (plus a b)) b).
Apply le_S_n.
Assumption.
Assert (le b (plus a b)).
Apply le_plus_r.
Assert (le (S (plus a b)) (plus a b)).
Apply le_trans with b.
Assumption.
Trivial.
Assumption.
Elim (le_Sn_n ? H5).
Qed.

Theorem P29 : (l:(list Prime))(IsSucc (listProd (map (pi1 ? ?) l))).
Proof.
Intro.
Induction l.
Compute.
Trivial.
Unfold map.
Unfold listProd.
Unfold map in Hrecl.
Unfold listProd in Hrecl.
Induction a.
Unfold isPrime in p.
Assert (gt x one).
Induction p.
Assumption.
Simpl.
LetTac n := (fold_right mult one
              (Fix map
                 {map [l:(list {p:nat | (isPrime p)})] : (list nat) :=
                    Cases l of
                      nil => (nil nat)
                    | (cons a t) => 
                       (cons (pi1 nat [p:nat](isPrime p) a) (map t))
                    end} l)) in Goal Hrecl. 
Case (mult_O_le x n).
Intro.
Rewrite H0 in Hrecl.
Elim Hrecl.
Intro.
Compute in H.
Assert (le (S (S O)) (mult n x)).
Apply (le_trans ? ? ? H H0).
Rewrite (mult_sym x n).
Generalize Dependent (mult n x).
Intros.
Induction n0.
Elim (le_Sn_O (S O)).
Assumption.
Compute.
Trivial.
Qed.

Theorem ManyPrimes : ~(EX l:(list Prime) | (p:Prime)(In p l)).
Proof.
Unfold not.
Intro.
Induction H.
LetTac H2 := (P29 x).
LetTac x0 := (map (pi1 ? ?) x).
(*Apply (P14 x0).*)
LetTac n := (succ (listProd x0)).
LetTac n' := (pi1 ? ? n).
LetTac p := (P25 n').
Case p.
Intros.
Unfold one in H0.
Unfold n' in H0.
Simpl in H0.
LetTac H1 :=  (eq_add_S ? ? H0).
Rewrite H1 in H2.
Elim H2.
Intro.
Induction H0.
Induction x1.
Simpl in H0.
LetTac H1 := (H (exist ? ? x1 p0)).
Clear H2.
LetTac H2 := (P26 ? ? ? ? H1).
LetTac H3 := (P9 ? ? H2).
LetTac H4 := (P28 ? ? H3 H0).
Simpl in H4.
Assert (pi1 nat [p:nat](isPrime p) (exist nat isPrime x1 p0))=one.
Exact H4.
Clear H4 H3 H2 H1.
Simpl in H5.
Induction p0.
Rewrite H5 in H1.
Unfold gt in H1.
Apply (lt_n_n ? H1).
Qed.
}}}

-- RussellOConnor
