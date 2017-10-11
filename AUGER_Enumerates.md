Some coqdoc'umented source. Obj.t free extraction.

``coqdoc --utf8 -g Enumerates.v``

::

   (* Enumerates.v *)
   Require Import Utf8.
   Set Implicit Arguments.
   (** * A library for representations of sets having a finite number of possible values. *)
   (**   Some common representation is to have the following:
        
         [Inductive element : nat -> Set :=
         | GotIt : forall n, element (S n)
         | SkipIt : forall n, element n -> element (S n)
         .]
        
         [element n] is a type of exactly [n] values.
        
         This kind of set is not very efficient since the last element
         is accessed in O([n]).
        
         A better thing would be to use binary representation,
         so that we could address a given element by dichotomy.
         This would however require some arithmetic more complex than
         just using successor.
        
         Here is an intermediate version. In this version, in degenerate
         cases, access to some element can still be in O([n]), but if
         thing are balanced we got it in O(log([n])). The idea is to
         use binary trees. If the tree is just one thread, then it
         is kind of isomorphic to the [element n] above. The case using
         binary representation corresponds to the case where the trees
         is perfectly balanced.
        
         One good point of this representation is that you can easily
         build the sum of two finite sets, without doing any arithmetic.
        
         Such sets can be naturally ordered, and we have a successor and
         a predecessor. These notions are dual, so each set should also
         have a dual, where the successor of an element is the predecessor of
         its dual.
   *)
   (** ** The support for finite sets. *)
   (** The type of the support of our finite set. *)
   Inductive Finite : Set :=
     | Single : Finite
     | Multiple : Finite → Finite → Finite
   .
   (** Finite has a symmetric counter part. *)
   Fixpoint dualFinite f :=
     match f with
     | Single => Single
     | Multiple low high => Multiple (dualFinite high) (dualFinite low)
     end
   .
   (** cardinality of a finite set. *)
   Fixpoint cardinal f :=
     match f with
     | Single => O
     | Multiple low high => (cardinal low) + (cardinal high)
     end
   .
   Lemma cardinal_preservation : ∀ f, cardinal f = cardinal (dualFinite f).
   Proof.
     intros f; induction f; simpl; auto.
     destruct IHf1; destruct IHf2.
     induction (cardinal f1); simpl; auto.
     rewrite IHn; clear; induction (cardinal f2); simpl; auto.
   Qed.
   Lemma dualFinite_is_involutive : ∀ f, dualFinite (dualFinite f) = f.
   Proof.
     intros f; induction f; simpl; f_equal; auto.
   Qed.
   (** ** The elements of such finite sets. *)
   Inductive Element : Finite → Set :=
     | Only : Element Single
     | Low : ∀ l h, Element l → Element (Multiple l h)
     | High : ∀ l h, Element h → Element (Multiple l h)
   .
   (** To each element of a finite set, we can associate one of its dual *)
   Fixpoint dualElement f (e : Element f) : Element (dualFinite f) :=
     match e in Element f0 return Element (dualFinite f0) with
     | Only => Only
     | Low l h L => High (dualFinite h) (dualElement L)
     | High l h H => Low (dualFinite l) (dualElement H)
     end
   .
   (** There is a problem in talking of involution as there is a typing
       problem: [dualElement (dualElement x)] is not an element of
       [Element f], but one of [Element (dualFinite (dualFinite f))],
       although these two types are provably equal. So we use a trick
       like the one used in [JMeq], but specialized for us. *)
   Inductive jmeq (T : Finite) (t : Element T) : ∀ U, Element U → Prop :=
     JmeqEq : jmeq t t.
   Lemma dualElement_is_involutive
   : ∀ f (x : Element f), jmeq x (dualElement (dualElement x)).
   Proof.
     intros f x; induction x; simpl in *; fold dualFinite in *.
         split.
       destruct IHx.
       rewrite dualFinite_is_involutive.
       split.
     destruct IHx.
     rewrite dualFinite_is_involutive.
     split.
   Qed.
   (** ** Access of [first] and [last] elements. *)
   Fixpoint first (f : Finite) : Element f :=
     match f with
     | Single => Only
     | Multiple l h => Low h (first l)
     end
   .
   Fixpoint last (f : Finite) : Element f :=
     match f with
     | Single => Only
     | Multiple l h => High l (last h)
     end
   .
   Lemma first_is_last_dual : ∀ f, first (dualFinite f) = dualElement (last f).
   Proof.
     intros f; induction f; simpl; f_equal; auto.
   Qed.
   Lemma last_is_first_dual : ∀ f, last (dualFinite f) = dualElement (first f).
   Proof.
     intros f; induction f; simpl; f_equal; auto.
   Qed.
   (** ** Access to [next] and [prev]ious elements. *)
   Fixpoint next (f : Finite) (e : Element f) : option (Element f) :=
     match e with
     | Only => None
     | Low l h e => Some match next e with
                         | None => High l (first h)
                         | Some e => Low h e
                         end
     | High l h e => match next e with
                     | None => None
                     | Some e => Some (High l e)
                     end
     end
   .
   Fixpoint prev (f : Finite) (e : Element f) : option (Element f) :=
     match e with
     | Only => None
     | Low l h e => match prev e with
                    | None => None
                    | Some e => Some (Low h e)
                    end
     | High l h e => Some match prev e with
                          | None => Low h (last l)
                          | Some e => High l e
                          end
     end
   .
   (* There should be some simplification using duality *)
   Lemma prev_first : ∀ f, prev (first f) = None.
   Proof.
     intros f; induction f; simpl; auto.
     rewrite IHf1; simpl; auto.
   Qed.
   Lemma next_last : ∀ f, next (last f) = None.
   Proof.
     intros f; induction f; simpl; auto.
     rewrite IHf2; simpl; auto.
   Qed.
   Lemma prev_next : ∀ f x, match prev x with | None => x = first f
                                              | Some y => Some x = next y
                            end.
   Proof.
     intros f x; induction x; simpl; auto;
     destruct (prev x); simpl; try rewrite next_last; destruct IHx; auto.
   Qed.
   Lemma next_prev : ∀ f x, match next x with | None => x = last f
                                              | Some y => Some x = prev y
                            end.
   Proof.
     intros f x; induction x; simpl; auto;
     destruct (next x); simpl; try rewrite prev_first; destruct IHx; auto.
   Qed.
   Lemma dual_prev : ∀ f x, next (@dualElement f x) =
                            match prev x with | None => None
                                              | Some y => Some (dualElement y)
                            end.
   Proof.
     intros f x; induction x; simpl; auto;
     destruct (prev x); rewrite IHx; simpl; try split.
     repeat f_equal.
     apply first_is_last_dual.
   Qed.
   Lemma dual_next : ∀ f x, prev (@dualElement f x) =
                            match next x with | None => None
                                              | Some y => Some (dualElement y)
                            end.
   Proof.
     intros f x; induction x; simpl; auto;
     destruct (next x); rewrite IHx; simpl; try split.
     repeat f_equal.
     apply last_is_first_dual.
   Qed.

