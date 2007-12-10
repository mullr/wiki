#acl All:


[[attachment:toast.v]]

[[attachment:tuust.cpp]]


To test the experimental features.

{{{#!bibtex
@Book{aho.74,
  author= {Alfred V. Aho and John E. Hopcroft and Jeffrey D. Ullman},
  title = {The Design and Analysis of Computer Algorithms},
  publisher= {Addison-Wesley},
  year  = {1974},
}
}}}

{{{#!pascal
int main() {
    printf("Hello wikiwiki world!\n");
}
}}}

{{{#!latex
\usepackage{amssymb}
%%end-prologue%%
$2\in\mathbb{N}$
}}}

{{{#!syntax ocaml
open Reduction
open Type_errors

(* raise Not_found if not an inductive type *)
let lookup_mind_specif env (kn,tyi) =
  let mib = Environ.lookup_mind kn env in
  if tyi >= Array.length mib.mind_packets then
    error "Inductive.lookup_mind_specif: invalid inductive index";
  (mib, mib.mind_packets.(tyi))
}}}


{{{#!syntax coq
Global Variable X.
Global X.

Axiom s:kjhdwkjhw.
Axioms qwe:llqwjehljhq.

Global Variable X232143->Y.
a-b

Proof.
[idtac; first [T1|T2|T3].

Goal g:skljs.
Proof.

Defined.
Qed.

Parameter a := "kjhasdkjhdas".

SearchAbout X.
SearchPattern Y. 
SearchRewrite j54976;l.
Show ;kdawflkj.

}}}

{{{#!syntax c
int main() {
    printf("Hello wikiwiki world!\n");
}
}}}

{{{#!syntax printall
}}}


{{{#!syntax haskell
data Song = Do | Re | Mi 
}}}

 


{{{#!syntax haskell
type Vector = [Double]

normSquared :: Vector -> Double
normSquared = sum . map (^2)

norm :: Vector -> Double
norm = sqrt . normSquared

scale :: Double -> Vector -> Vector
scale a = map (a*)

normalize :: Vector -> Vector
normalize v = scale (recip (norm v)) v
}}}

{{{#!syntax haskell numbers=none
type Vector = [Double]

normSquared :: Vector -> Double
normSquared = sum . map (^2)

norm :: Vector -> Double
norm = sqrt . normSquared

scale :: Double -> Vector -> Vector
scale a = map (a*)

normalize :: Vector -> Vector
normalize v = scale (recip (norm v)) v
}}}

It is possible to do {{{scale}}} and {{{normSquared}}} at the same time. Internally the data must still be processed twice but this can be hidden.

Consider a vector represented as a list of doubles.  Suppose we want to normalize a vector.  The standard method is to compute the length in one pass, and scale the vector in another pass:

{{{#!syntax haskell
type Vector = [Double]

normSquared :: Vector -> Double
normSquared = sum . map (^2)

norm :: Vector -> Double
norm = sqrt . normSquared

scale :: Double -> Vector -> Vector
scale a = map (a*)

normalize :: Vector -> Vector
normalize v = scale (recip (norm v)) v
}}}

It is possible to do {{{scale}}} and {{{normSquared}}} at the same time. Internally the data must still be processed twice but this can be hidden.

{{{#!syntax haskell
-- fst of the result is the scaled value of the vector
-- snd of the result is the squared norm of the vector before scaling
scaleAndNormSquared :: Double -> Vector -> (Vector, Double)
scaleAndNormSquared a [] = ([], 0)
scaleAndNormSquared a (x:xs) = (a*x:recScale, x*x+recNormSquared)
  where (recScale, recNormSquared) = scaleAndNormSquared a xs
}}}


Now using the laziness of Haskell, and recursive binding, we can use {{{scaleAndNormSquared}}} to create a virtually one-pass normalization. We need to scale by the reciprocal of the square-root of {{{normSquared}}}.  So we say exactly that.

{{{#!syntax haskell
circNormalize :: Vector -> Vector
circNormalize v = scaledVector
  where (scaledVector, normSquared) = scaleAndNormSquared (recip (sqrt normSquared)) v
}}}
