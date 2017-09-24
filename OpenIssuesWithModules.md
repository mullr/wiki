This is a list of open issues with Coq module type systems

<<TableOfContents>>

= Do modules need to be type-checked in the kernel? =

The logical part of the module type system was implemented in the kernel as of Coq version 7.3.1. Assuming the kernel correct, it provides the following:
 * The kernel-guaranty that a functor application is well-typed as soon as the type of the argument is a subtype of the type of the parameter of the functor.
 * The correctness of the process of substitution of declared fields by effective definitions.
 * The ability to shorten some module expressions using algebraic expressions (e.g. {{{with}}}, {{{Include}}}, aliases).
 * The kernel-guaranty that some module is a correct refinement of a signature.

On the other side, storing modules outside of the kernel would remove (a lot of) code from the kernel. The latter would not see modules differently than as a collection of named definitions/assumptions/inductive types to type-checked.

Having modules outside of the kernel would not lower the correctness of module/functor implementations and signatures. Only subtyping would not be kernel-validated.

For instance, functors would be typechecked by temporarily adding the expansion of the module-argument in the kernel, then sending the body of the implementation to the kernel. Similarly for module types or functorial module types.

Modules and functors could still be expressed using an algebraic language (using {{{with}}} etc.) but the expansion of them would have to be done before the individual components of a module being sent to the kernel.

Otherwise said, the kernel would still check the expansion of a module as a tuple of declarations inhabiting a record (which is the semantics of a module), but would not say anything about the correctness of the algebraic language and about subtyping.

= Applicative vs generative functors =

Coq has currently generative functors: twice the same instantiation of a functor gives distinct inductive types and distinct abstract values. For inductive types, this is consistent with the view that inductive types are generative. The utility of generativity for abstract types can be discussed.

Example of generativity of inductive types:
{{{
Module Type S. End S.
Module A <: S. End A.
Module F (X : S). Inductive t := C. End F.
Module B1 := F A.
Module B2 := F A.
Fail Check eq_refl : B1.t = B2.t. (* The inductive types are different *)
}}}

For more details, search for "applicative" or "generative" in Élie Soubiran's [[https://tel.archives-ouvertes.fr/file/index/docid/679201/filename/these.pdf|PhD]], or e.g. in this [[https://www.cs.ox.ac.uk/ralf.hinze/WG2.8/24/slides/derek.pdf|talk]] from Derek Dreyer, etc.

= Module and functor transparency =

See e.g. bug [[https://coq.inria.fr/bugs/show_bug.cgi?id=3342|3342]].

The signature of an aliased module is transparent thanks to strenghtening (which is basically eta-expansion of records).

Example showing the transparency of the signature of aliased modules in functors:
{{{
Module Type S. Parameter t : Type. End S.
Module A <: S. Definition t := nat. End A.
Module F (Y : S). Module M := Y. End F.
Module C := F A.
Print C.M.t. (* Shows C.M.t = A.t *)
}}}

In current Coq, the signature of an applied functor does not have strengthening and is not transparent.

Example showing the non-transparency of the signature of an applied functor in an higher-order functor:
{{{
Module Type S. Parameter t : Type. End S.
Module A <: S. Definition t := nat. End A.
Module Type T (X : S). Parameter u : Type. End T.
Module B (X : S) <: T X. Definition u := X.t. End B.
Module F (Y : T). Module M := Y A. End F.
Module C := F B.
Print C.M.u. (* Show *** [ C.M.u : Type ], i.e. C.M.u is abstract *)
}}}

For strengthening to be applicable on applied functors, one would typically need paths to include arbitrary module expressions (for instance, OCaml adopts the compromise to allow strengthening on any functor made of application of names of functors).

As an alternative to using arbitrary module expressions in paths, another approach would be to use self-reference, i.e. to type any named algebraic expression with a type referring to the name given to the expression, as in the following informal pseudo-code:

{{{
Module N := F M : sig Definition t := N.t ... end.
}}}

Note that the absence of signature transparency of applied functors in higher-order functors implies that abstract types in the signature of these applied functors (as C.M.u above) to be de facto generative.

For more details about higher-order transparency, search for "transparency" in Élie Soubiran's [[https://tel.archives-ouvertes.fr/file/index/docid/679201/filename/these.pdf|PhD]], or e.g. in this [[https://caml.inria.fr/pub/papers/xleroy-applicative_functors-popl95.ps.gz|paper]] from Xavier Leroy, etc.

= Subtyping inductive types as definitions =

It should not be very complicated to do. Since what is visible from a module is anyways only what its signature exports, it is maybe just enough to modify the subtyping algorithm so that it accepts to see inductive types or constructors as parameters.

Example of currently failing subtyping:
{{{
Module Type S. Parameter t : Type. End S.
Module A. Inductive t := O. End A.
Module B : S := A. (* fails *)
}}}

= How far can modules and module types be identified? =

On the contrary of programming language where modules are implementations and interfaces are specifications, there is no essential differences in a module and a module type in Coq. Both have the structure of a partially defined dependent record for a notion of record containing inductive types and where manifest fields are local definitions (see Thierry Coquand, Randy Pollack and Makoto Takeyama's [[http://homepages.inf.ed.ac.uk/rpollack/export/TLCA03extended.pdf|paper]] about implementing modules as records).

The difference is that a module type is the type definition of such a record while a module is the declaration of an object coercible to an inhabitant of such a record type.

= Towards a richer algebraic language of module constructions =

Haskell and Agda have a richer algebraic language of modules and module types. In these languages, one can e.g. define new modules by selecting specific fields, or referring to existing fields with different names.
