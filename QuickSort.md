#language en

We want to formalise the following Haskell implementation of  '''quicksort''' algorithm in Coq:

{{{#!haskell 
quicksort :: (Ord a) => [a] -> [a]           
quicksort []           = []
quicksort (pivot:rest) = quicksort [y | y <- rest, y < pivot] ++ 
                                        [pivot] ++ 
                                        quicksort [y | y <- rest, pivot <= y]
}}}

We will use the method known as the ''recursion on an ad hoc predicate''. This is a method for defining general recursive functions based on InductiveDomainPredicate paradigm.  We define the algorithm on integers, the generalisation to a generic ordered type being trivial.

First we need to formalise the main component of quicksort which is the list comprehension function. It is possible to formalise the general case of MonadicListComprehension but here we only define the instance that we need:

{{{#!coq
Definition is_decidable (A:Set) (P:A->Prop) := forall a, {P a} + {~(P a)}.

Fixpoint list_comprehension (A : Set) (l : list A) {struct l} : forall P : A -> Prop, is_decidable A P -> list A :=
  match l with
  | nil => fun (P : A -> Prop) (_ : is_decidable A P) => nil 
  | x :: xs =>
      fun (P : A -> Prop) (H_dec : is_decidable A P) =>
      match H_dec x with 
      | left _ => x :: list_comprehension A xs P H_dec
      |	right _ => list_comprehension A xs P H_dec
      end
  end.
}}}

It is easy to define the familiar notation for list comprehension (see TipsAndTricks):

{{{#!coq
Notation "[ e | b <- l , Hp ]" := (map (fun b:Z=> e) ((list_comprehension Z) l (fun b:Z=>_ ) Hp))  (at level 1).
}}}

Now we define the domain of the quicksort function as an inductive prediacte that lives in `Prop`:

{{{#!coq
Inductive is_sortable : list Z -> Prop :=
  | is_sortable_nil : forall l, l = nil -> is_sortable l
  | is_sortable_concat : forall (l:list Z) (pivot:Z) (rest:list Z), l = pivot::rest -> 
                                                       is_sortable [ y | y <- rest , (Zlt_is_decidable pivot)] ->
						       is_sortable [ y | y <- rest , (Zle_is_decidable pivot)] ->
                                                       is_sortable (pivot::rest).
}}}

As it can be seen the predicate has two constructors, each corresponding to a branch of the Haskell definition.

Next we need to prove the inverse of the second constructor without using inversion.  This constructor has two inverses, we prove both. Here is a possible proof:

{{{#!coq
Lemma is_sortable_concat_inv_1 : forall l pivot rest, is_sortable l -> l = pivot::rest -> is_sortable [ y | y <- rest , (Zlt_is_decidable pivot) ].
Proof.
 simple destruct 1; [ intros l0 H0 H1 | intros l0 pivot0 rest0 H0 H1 H2 H3];
 [
  apply False_ind;
  rewrite H0 in H1;
  discriminate
 |
  replace pivot with pivot0;
  [ replace rest with rest0; trivial;
    change (tail (pivot0 :: rest0)=tail (pivot :: rest))
  | apply Some_inv;
    change (head (pivot0 :: rest0)=head (pivot :: rest))
  ];
  rewrite <- H3; trivial
 ].
Defined.
}}}

The proof of second inversion lemma is identical to the first one:

{{{#!coq
Lemma is_sortable_concat_inv_2 : forall l pivot rest, is_sortable l -> l = pivot::rest -> is_sortable [ y | y <- rest , (Zle_is_decidable pivot) ].
}}}

Finally we can give the definition of `quicksort_aux` function.

{{{#!coq
Fixpoint quicksort_aux (l : list Z) (H_sortable : is_sortable l) {struct H_sortable} : list Z :=
         match l as l0 return (l = l0 -> list Z) with
         | nil => fun _ : l = nil => nil
         | pivot :: rest =>
             fun H : l = pivot :: rest =>
             quicksort_aux [y | y <- rest, Zlt_is_decidable pivot] (is_sortable_concat_inv_1 l pivot rest H_sortable H) ++
             (pivot :: nil) ++
             quicksort_aux [y | y <- rest, Zle_is_decidable pivot] (is_sortable_concat_inv_2 l pivot rest H_sortable H)
         end (refl_equal l).
}}}

The `quicksort_aux` function when extracted to Haskell is identical (modulo extraction of the constants) to the Haskell code that we started with. 

However, inside Coq it is a function with 2 arguments despite the fact that we know that `quicksort` is a total function (and hence should have one argument). So we need to prove that `quicksort_aux` is total. I.e we should prove that 
{{{#!coq
Theorem everylist_is_sortable : forall (l:list Z), is_sortable l.
}}}


We prove this by induction on the length of `l`. For this we need the following lemma

{{{#!coq
Lemma induction_ltof1_Prop
     : forall (A : Set) (f : A -> nat) (P : A -> Prop),
       (forall x : A, (forall y : A, Wf_nat.ltof A f y x -> P y) -> P x) ->
       forall a : A, P a.
}}}

which is missing in the StandardLibrary (the similar case where `P: A -> Set` exists as `Coq.Arith.Wf_nat.induction_ltof1`).

Furthermore we need the following fact about list comprehension, that says that any sublist obtained by list comprehension on tail of a list is necessarily shorter than the original list.

{{{#!coq
Lemma tail_comprehension_shortens:forall A pivot rest P H, length (list_comprehension A rest P H) < length (pivot::rest).
Proof.
intros A pivot rest P H.
 induction rest.  
 simpl; constructor.
 unfold list_comprehension_Z; simpl.
 case (H a);
 intros H_a_pivot;
 simpl;
 [  apply lt_n_S;
   replace (S (length rest)) with  (length (pivot :: rest))
 | constructor
 ]; trivial.
Defined.
}}}

We need two instances of this lemma, namely
{{{#!coq
Lemma length_elt_lt:forall pivot rest, length [ y | y <- rest , (Zlt_is_decidable pivot)] < length (pivot::rest).

Lemma length_elt_le:forall pivot rest, length [ y | y <- rest , (Zle_is_decidable pivot)] < length (pivot::rest).
}}}

Having proved the above we can prove the totality:

{{{#!coq
Theorem everylist_is_sortable : forall l, is_sortable l.
Proof.
 intros l;
 apply (induction_ltof1_Prop _ (@length Z));
 clear l; intros [|x xs] H_ind;
 [ constructor 1; trivial
 | apply (is_sortable_concat _ _ _ (refl_equal (x::xs)));
   apply H_ind; red
 ];
 [ apply length_elt_lt
 | apply length_elt_le
 ].
Defined.
}}}

Whence we can define the total function `quicksort` simply as
{{{#!coq
Definition quicksort l := quicksort_aux l (everylist_is_sortable l).
}}}

At this point, we already can evaluate wth our `quicksort` inside Coq

{{{#!coq
Time Eval compute in (quicksort (quicksort (99 :: 11 :: 4 :: -9 :: -23 :: -88 :: nil))).
}}}

{{{
     = -88 :: -23 :: -9 :: 4 :: 11 :: 99 :: nil
     : list Z
Finished transaction in 1. secs (0.37u,0.s)
}}}

To prove any further properties we need some basic facts. The most essential ones are the FixpointEquations of `quicksort` and `quicksort_aux`. For the latter we first need to prove the ProofIrrelevance. I.e. we should prove that

{{{#!coq
Lemma quicksort_aux_proof_irrelevance : forall l (H_sort1 H_sort2: is_sortable l), quicksort_aux l H_sort1 = quicksort_aux l H_sort2.
}}}


There are various ways to prove this. One way is to apply double induction on the strong elimination predicate which is generated by the following invocation of [[[Scheme]]] VernacularCommand.

{{{#!coq
Scheme is_sortable_ind_dep := Induction for is_sortable Sort Prop.
}}}

This will generate an strong (dependent) elimination principle which enables us to prove `quicksort_aux_proof_irrelevance`.

Applying `quicksort_aux_proof_irrelevance` one can easily prove the FixpointEquations of `quicksort_aux`
{{{#!coq
Lemma quicksort_aux_nil :forall l H_sort, l=nil -> quicksort_aux l H_sort = nil.

Lemma quicksort_aux_cons :forall l pivot rest H_sort, l=pivot::rest -> forall H_sort_lt H_sort_le, quicksort_aux l H_sort =
          quicksort_aux [y | y <- rest, Zlt_is_decidable pivot] H_sort_lt ++ (pivot :: nil) ++
          quicksort_aux [y | y <- rest, Zle_is_decidable pivot] H_sort_le.
}}}

which in turn gives us the FixpointEquations of `quicksort`:

{{{#!coq
Lemma quicksort_nil :forall l, l=nil -> quicksort l = nil.

Lemma quicksort_cons :forall l pivot rest, l=pivot::rest -> 
       quicksort l = quicksort [y | y <- rest, Zlt_is_decidable pivot] ++ (pivot :: nil) ++
	                     quicksort [y | y <- rest, Zle_is_decidable pivot].
}}}

--  -- MiladNiqui
