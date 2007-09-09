= Debugging output for tactics =

idtac can be used to give output when writing ltac tactics for debugging reasons. However, I cannot work out how to convert Coq terms to strings. For example, I would like to see what the failed match is below:

{{{#!coq 
Ltac test x :=
  match x with
  |  x+y => idtac "Hello world!"
  | _ => idtac x (* Doesn't work! *)
 end.
}}}

"idtac x" doesn't work because x isn't a string. How do I convert x to a string?

'''Suggested solution:''' Use `pose (name := x)` in place of `idtac x`.

= Can commutivity of or be proven? =

{{{#!coq 
Lemma or_comm : forall (A B:Prop), (A \/ B) = (B \/ A).
}}}
[[Date(2006-06-18T22:32:50Z)]]

No, but coq can prove
{{{#!coq 
Lemma or_comm : forall (A B:Prop), (A \/ B) <-> (B \/ A).
}}}

Is it consistent to add as an axiom
{{{#!coq
Hypothesis extprop : forall (C D:Prop), (C <-> D) -> (C = D).
}}}
? (I don't suppose it's ''useful''.)

= Syntax Question: What does ... mean? =
What do the triple elipses mean  after a tactic? E.g. how is {{{induction 1... }}} different than just {{{induction 1.}}}

 If you start your proof with 
{{{#!coq
Proof with foo.
}}}
 where {{{foo}}} is a tactic, then 
{{{#!coq
induction 1...
}}}
 is equivalent to
{{{#!coq
induction 1; foo.
}}}
 This is explained in the Reference Manual in [http://coq.inria.fr/V8.1/refman/Reference-Manual010.html#@command186]. 

= Operational Semantics of Coq =

Is there a paper which describes a small-(or big) step operational semantics for core coq? 

= Implicit arguments =

I have a problem with implicit arguments. Really, this is only a matter of inconvenience, but since implicit arguments are for convenience, why not ask?

I believe that the following input shows the issues simply:

{{{#!coq
Set Implicit Arguments.

Definition comp (A B C: Set) (f: A -> B) (g: B -> C): A -> C := fun x => g (f x).
Print comp.

Section comp.
Variables (A B C: Set) (f: A -> B) (g: B -> C) (x: A).
Check (comp f g x).
End comp.

Theorem associativity (A B C D: Set) (f: A -> B) (g: B -> C) (h: C -> D): forall (x: A), comp f (comp g h) x = comp (comp f g) h x.
Proof. trivial. Qed.

Definition id (A: Set): A -> A := fun x => x.
Print id.

Section id.
Variables (A: Set) (x: A).
Check (id x).
End id.

Theorem unit (A B: Set) (f: A -> B): forall (x: A), comp (id (A := A)) f x = f x.
Proof. trivial. Qed.

Unset Implicit Arguments.
Definition id' (A: Set): A -> A := fun x => x.
Print id'.

Section id'.
Variables (A: Set) (x: A).
Check (id' A x).
End id'.

Theorem unit' (A B: Set) (f: A -> B): forall (x: A), comp (id' A) f x = f x.
Proof. trivial. Qed.
}}}

As you can see, '''comp''' is very convenient to use. Thanks to my setting at the start, I can define '''comp''' in a perfectly straightforward way. Now, '''comp''' depends on three arguments of type '''Set''', but we ordinarily don't refer to these when discussing function composition in mathematics (the symbol is ‘∘’, not ‘∘_A,B,C’), so it's nice that I don't actually have to refer to them! The example in '''Section comp''' shows how convenient this is to use; I write simply '''comp f g''' instead of '''comp A B C f g'''. The theorem '''associativity''' gives a more complicated example; all very nice.

In contrast, '''id''' does not work perfectly well. The operator '''id''' depends on one argument of type '''Set''', and we often ''do'' refer to this in mathematics (writing ‘id_A’ rather than just ‘id’), although sometimes we do still suppress it. As set up here, Coq suppresses it. This works just great in the example in '''Section id''', just like '''comp''' worked. However, in '''unit''', I need to put in the very annoying '''(A := A)''' or it will complain. (The reason is that simply '''id A''' expects '''A''' to be an element of a set rather than a set itself, since the set is suppressed; while '''id''' alone is not a function at all, of course.)

To be sure, I can change the settings and then define '''id''''. This handles both the example in '''Section id'''', as well as the theorem '''unit'''', but I do (inconveniently) have to mention '''A''' explicitly in ''both'' of them. Note that Coq should have no trouble inferring the suppressed argument in any of my uses of '''id''', so the only reason why I must either use '''id'''' or the  '''(A := A)''' construction is to tell Coq (in the latter) that I don't want to refer to the entire operator '''id''' by itself.

In my intended applications, I will ''never'' want to refer to the entire operator '''id''', but I will often write things involving '''id''' like the theorem '''unit''' (as well as things like the example in '''Section id'''). So my choice is either to use '''id''' as above, requiring me to write '''(A := ...)''' from time to time (and it must always be '''A''' on the left, so I have to remember how the definition of '''id''' was phrased); or forgo implicit arguments in this case and use '''id''''. Right now, I'm leaning towards the latter, because I don't want to remember all the local variables that appear in definitions; but I worry that I may eventually want to use even '''comp''' in a way analogous to how '''id''' is used in '''unit''', making implicit arguments ultimately useless.

So in the end, here's what I'd like to do, and maybe there's some way to do it that I just don't realise: I want to use settings that allow me (preferably automatically, but manually after each definition if necessary) to define '''comp''' and '''id''' with implicit arguments as above, but ''also'' tell Coq that (when they appear in a later type construction) both '''comp''' and '''id''' should always appear with inferred arguments, ''even if'' there are no explicit arguments following. Is this possible?

—TobyBartels


Here's another example, which doesn't show all of the issues above, but does demonstrate quickly that I really don't understand what's going on:

{{{#!coq
Set Implicit Arguments.
Set Contextual Implicit.

Inductive sum_dep (A: Set) (B: A -> Set): Set := |pair_dep (a: A) (b: B a).
Print pair_dep.

Definition sum_indep (A B: Set): Set := sum_dep (fun a: A => B).
Definition pair_indep (A B: Set) (a: A) (b: B): sum_indep A B := pair_dep (B := fun _ => B) a b.
Print pair_indep.
Definition pair_indep' (A B: Set) (a: A) (b: B): sum_indep A B := pair_dep a b.
}}}

(Note that the final line causes an error.)

I've used an extra setting, just to get Coq to automatically make '''B''' implicit, but I could have made it implicit by hand as well. Now, I can understand Coq's reluctance to make the inference called for in '''pair_indep''''; although there's really only one possible answer, it's a strange one, and a good compiler ''should'' at least issue a warning in such a circumstance. But what I really don't understand is why that it expects ''me'' to make precisely that inference in its printout for '''pair_indep'''! I must define it with '''(B := ...)''', but Coq doesn't have to print it that way???

—TobyBartels
