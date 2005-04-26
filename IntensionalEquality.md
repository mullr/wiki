= Intensional Equality =

== Why Have Intensional Equality ==

Suppose you create a countable data type of recursive functions, {{{RecursiveFunction}}}, along with some execution function {{{exec : forall (rf:RecursiveFunction) (input:N) (steps:N) : option N}}}, then you could add an axiom 
{{{#!coq
reflect : forall (f:N -> N), 
 {rf:RecursiveFunction 
 | forall (n m:N) {(exec rf n m)=Some (f n)}+{(exec rf n m)=None}
}}}

During ProgramExtraction this function could be mapped to a function statifying this signature.  This might be a useful thing to do.

I ''think'' that if coq had extensional equality of functions, such an axiom could not be mapped to any function during program extraction.
