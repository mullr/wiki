= Debugging output for tactics =

'''Q''': `idtac` can be used to give output when writing ltac tactics for debugging reasons. However, I cannot work out how to convert Coq terms to strings. For example, I would like to see what the failed match is below:

{{{#!coq 
Ltac test x :=
  match x with
  |  _+_ => idtac "Hello world!"
  | _ => idtac x (* Doesn't work! *)
 end.
}}}

'''A''': From Coq 8.1, `idtac x` works and prints the value `x`.

In Coq 8.0, `idtac x` doesn't work because `idtac` accepts only strings as arguments. 
To observe the value of `x` in the branch, a solution is to use `pose (name := x)` in place of `idtac x`.

= Can commutativity of or be proven? =

'''Q''': Can commutativity of `or` be proven?
{{{#!coq 
Lemma or_comm : forall (A B:Prop), (A \/ B) = (B \/ A).
}}}
[[Date(2006-06-18T22:32:50Z)]]

'''A''': No, but Coq can prove
{{{#!coq 
Lemma or_comm : forall (A B:Prop), (A \/ B) <-> (B \/ A).
}}}

'''Q''': Is it consistent to add as an axiom
{{{#!coq
Hypothesis extprop : forall (C D:Prop), (C <-> D) -> (C = D).
}}}
? (I don't suppose it's ''useful''.)

'''A''': It is consistent with respect to the set-theoretic interpretation of the Calculus of Inductive Constructions (the `Set`-predicative version of it, as in Coq 8.x).

The axiom is generally not needed. For instance `setoid rewrite` is able to "rewrite" equivalence without relying on this axiom.

= Syntax Question: What does ... mean? =

'''Q''': What do the triple elipses mean  after a tactic? E.g. how is {{{induction 1... }}} different than just {{{induction 1.}}}

'''A''': If you start your proof with 
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

'''Q''': Is there a paper which describes a small-(or big) step operational semantics for core coq? 

'''A''': Coq is an equational theory generated from four reduction rules named β, δ, ι and ζ (see Section ''Conversion rules'' in Chapter [http://coq.inria.fr/doc/Reference-Manual006.html Calculus of Inductive Constructions] of the Coq 
[http://coq.inria.fr/doc/index.html Reference Manual]). There is no fixed operational semantics and reduction is not restricted to evaluation of closed terms.

Different strategies of reduction are made available to the user such as lazy and strict evaluation (strict here does not mean call-by-value in Plotkin's sense: it means reducing first the arguments into a weak head normal form before contracting β-redexes).
See Section ''Conversion tactics'' in Chapter [http://coq.inria.fr/doc/Reference-Manual010.html Tactics] for the list of available strategies of reduction.

= Implicit arguments =

'''Q''': I have a problem with implicit arguments. Really, this is only a matter of inconvenience, but since implicit arguments are for convenience, why not ask?

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

'''A''': The feature you are looking for is implemented in the development version of Coq (to be released as Coq version 8.2 in early 2008). It is called maximal insertion of implicit arguments and it works as follows:

{{{#!coq
Set Implicit Arguments.
Set Maximal Implicit Insertion.

Definition comp (A B C: Set) (f: A -> B) (g: B -> C): A -> C := fun x => g (f x).
Definition id (A: Set): A -> A := fun x => x.
About id. 
(* tells you that A is "maximally inserted", i.e. inserted even if no arguments follow *)

Theorem unit (A B: Set) (f: A -> B): forall (x: A), comp id f x = f x. (* works *)
}}}

'''Q''': Here's another example, which doesn't show all of the issues above, but does demonstrate quickly that I really don't understand what's going on:

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

'''A''': Coq unfortunately does not implement inference of such kind of implicit :-(. Then, if '''B''' is printed in '''pair_indep''', it is to ensure the reversibility of parsing. This is a ''defensive'' strategy of printing. From Coq version 8.2, such defensive strategy of printing can be deactivated using the command `Unset Printing Implicit Defensive`.
