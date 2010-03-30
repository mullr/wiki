{{{match}}} allows the result type to depend on both the input value, and the parameters of the input type.  The {{{as}}} and {{{in}}} keywords create bound variables that can occur in the {{{return}}} type.  So the expression
{{{#!coq
match expr as T in (deptype A B) return exprR
(*...*)
}}}

creates bound variables {{{T}}}, {{{A}}}, and {{{B}}} that occur in {{{exprR}}}.
If {{{expr}}} has type {{{(deptype exprA exprB)}}} then the type of the entire {{{match}}} expression will have type {{{exprR[T/expr, A/exprA, B/exprB]}}}, that is {{{exprR}}} with {{{T}}}, {{{A}}}, and {{{B}}} substituted by {{{expr}}}, {{{exprA}}}, and {{{exprB}}}.

{{{T}}}, {{{A}}} and {{{B}}} are new variable names, and cannot be expressions.

== "Real Arguments" ==

Coq is missing some assumptions about real arguments (see page 105 of the 11-Feb-2009 edition of the Coq 8.2 manual for the subtle definition of the technical term "real argument").  In the (highly contrived) program below, it cannot discern that {{{u}}} has type {{{updown (n+1)}}}:

{{{#!coq
Inductive updown : nat -> Set :=                                                                        
  | up   : forall n, updown (n+1) -> updown n                                                           
  | down : forall n, updown  n    -> updown (n+1).

Fixpoint demo (n:nat)(t:updown n)(t':updown (n+1)) : nat :=
  match t with
    | up   _ u => demo n t u
    | down _ d => 3
  end.
}}}

=== Possible Fix ===

In the typing rule at the bottom of page 114 of the 11-Feb-2009
edition of the Coq 8.2 manual, the text E[\Gamma] appears three
times in the hypothesis of rule "match".  The rightmost occurrence
should be replaced with:                                                
                                                     
{{{                              
  E[\Gamma, x:(Coq.Logic.Eqdep.eq_dep Type (fun x=>x) C c A_i c)]                                          
}}}   
                                                                                
For x a fresh variable name.  See the bottom of page 109 for the
meaning of A_i.  This suggestion has the disadvantage (which was first lamented [[http://article.gmane.org/gmane.science.mathematics.logic.coq.club/4667|here]]) of introducing a new constant into the typing rules, thereby making {{{eq_dep}}} a primitive of CiC.

HugoHerbelin, 28 March 2010: This is not as simple as that. First because {{{eq_dep}}} (or {{{eq}}}, or {{{JMeq}}}) are all ''defined'' notions that are unknown from the kernel type-checker. In particular, to be able to type {{{match}}} as proposed above, one would need to have {{{eq_dep}}} primitively defined in the Calculus of Inductive Constructions. In any case, it is easy (though ugly) to simulate the rule proposed above by generalizing the type of the {{{match}}} with hypotheses {{{Coq.Logic.Eqdep.eq_dep Type (fun x=>x) C c A_i c}}} (this is described in most textbooks about Coq, see also the reference paper ''Eliminating dependent pattern-matching'' by Goguen, Mc Bride and Mc Kinna).

Note that some proof assistants such as Agda have a more powerful typing rule for {{{match}}} which supports a limited amount of equations of the form above. However, this is not the case of Coq.

AdamMegacz, 28 March 2010: Interesting!  Would you care to include the expanded rule that "inlines" the hypotheses of {{{Coq.Logic.Eqdep.eq_dep Type (fun x=>x) C c A_i c}}} in place of {{{Coq.Logic.Eqdep.eq_dep}}} itself?

HugoHerbelin, 29 March 2010: Again, this is no so simple. There is first a choice to do between {{{eq}}}, {{{JMeq}}} and {{{eq_dep}}}, with different issues depending of this choice.
With {{{eq}}}, we need convoluted statements when the dependencies are iterated. with {{{JMeq}}}, one does not need to iterate dependencies but {{{JMeq}}} is not canonical like {{{eq}}} and it would be strange to have {{{JMeq}}} natively known from the kernel without {{{eq}}} being known. With {{{eq_dep}}} we would need n-ary forms of it to support iterated dependencies. At the end, it is not clear whether it would really be an advantage compared to a non-native treatment of the equalities derivable by pattern-matching.

If not natively put inside the kernel type-checker, there is then a second alternative which is to modify the pattern-matching compilation algorithm so that it automatically adds the matching equations (outside the kernel, but still ideally made invisible to the user). This second approach is already adopted by the {{{Program}}} and {{{Equations}}} commands. The question then is whether it would be relevant to add it too to the general {{{match}}} mechanism.

AdamMegacz, 29 March 2010: Unfortunately this is not so simple.  The {{{Program}}} command will not alter the inductive definitions in the required manner.  It certainly helps organize the proofs, but it won't get the necessary propositions threaded into the right places.
