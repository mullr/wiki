#language en

{{{eapply}}} introduces an existentail variable which is denoted by a numbered question mark. You can let Coq itself fill the suitable candidate for the question mark later on in your proof. Alternatively you can explicitely ask coq to instantiate the question mark with a term. For the latter you should use the {{{instantiate}}} tactic:

{{{#!coq
instantiate (1:=H)
}}}

This will instatitate the leftmost existentail variable with the term {{{H}}}. You can instatitate more existential variables at once:

{{{#!coq
instantiate (1:=H1) (2:=H2)
}}}

This will instatitate the leftmost and the second from left existential variables by {{{H1}}} and {{{H2}}} respectively.

If you have existential variables in your gaol (or context) you can see their environment by 

{{{#!coq
Show Existentials.
}}}

For instance if you have one existential variabl in your goal,  this will give an output like the following.

{{{
Existential 1 =
?87 : [
       n : nat
       H: 0 < n]
}}}

The terms that you pass to {{{instantiate}}} for {{{?n}}} should appear in the environment of  {{{?n}}}.