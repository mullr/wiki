{{{match}}} allows the result type to depend on both the input value, and the parameters of the input type.  The {{{as}}} and {{{in}}} keywords create bound variables that can occur in the {{{return}}} type.  So the expression
{{{#!coq
match expr as T in (deptype A B) return exprR
(*...*)
}}}

creates bound variables {{{T}}}, {{{A}}}, and {{{B}}} that occur in {{{exprR}}}.
If {{{expr}}} has type {{{(deptype exprA exprB)}}} then the type of the entire {{{match}}} expression will have type {{{exprR[T/expr, A/exprA, B/exprB]}}}, that is {{{exprR}}} with {{{T}}}, {{{A}}}, and {{{B}}} substituted by {{{expr}}}, {{{exprA}}}, and {{{exprB}}}.

{{{T}}}, {{{A}}} and {{{B}}} are new variable names, and cannot be expressions.
