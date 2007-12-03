#language en

= Notation for List Comprehension =

We want to define a notation for Haskell-like list comprehension using {{{Notation}}}, ie we want to denote 

{{{#!haskell numbers=none
[ b | b <- l , P(b) ]
}}}

in Coq.

Assuming we have a variable {{{list_comprehension}}} that has the following type:

{{{#!coq
Variable list_comprehension: forall A : Set, list A -> forall P : A -> Prop, is_decidable A P -> list A.
Implicit Arguments list_comprehension [A].
}}}

where

{{{#!coq
Definition is_decidable (A:Set) (P:A->Prop) := forall a, {P a} + {~(P a)}.
}}}

we can declare the following notation.

{{{#!coq
Notation "[ e | b <- l , Hp ]" := (map (fun b:_=> e) (list_comprehension l (fun b:_=>_ ) Hp))  (at level 1).
}}}

Now, for example, if 
{{{#!coq
Hypothesis  Zlt_decide:forall a, is_decidable Z (fun x=>x<a).
}}}

we can use the above notation to define the Haskell list {{{ [ y | y<-l , y<pivot]}}} where {{{l:list Z}}} and {{{pivot:Z}}}:

{{{#!coq
Definition elt_lt_x l pivot:= [ y | y <- l , (Zlt_decide pivot) ].
}}}
