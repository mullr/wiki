{{{match}}} allows the result type to depend on both the input value, and the parameters of the input type.  The {{{as}}} and {{{in}}} keywords create bound variables that can occur in the {{{return}}} type.  So the expression
{{{#!coq
match expr as T in (deptype A B) return exprR
(*...*)
}}}

creates bound variables {{{T}}}, {{{A}}}, and {{{B}}} that occur in {{{exprR}}}.
If {{{expr}}} has type {{{(deptype exprA exprB)}}} then the type of the entire {{{match}}} expression will have type {{{exprR[T/expr, A/exprA, B/exprB]}}}, that is {{{exprR}}} with {{{T}}}, {{{A}}}, and {{{B}}} substituted by {{{expr}}}, {{{exprA}}}, and {{{exprB}}}.

{{{T}}}, {{{A}}} and {{{B}}} are new variable names, and cannot be expressions.

== "Real Arguments" ==

Coq is missing some assumptions about real arguments (see page 105 of the 11-Feb-2009 edition of the Coq 8.2 manual for the subtle definition of the technical term "real argument").

In the (highly contrived) program below, it cannot discern that the last occurrence of {{{u}}} has type {{{updown (z+1)}}}:

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
meaning of A_i    
