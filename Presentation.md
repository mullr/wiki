(Part of [[the Coq FAQ]])

### What is Coq?

The Coq tool is a formal proof management system: a proof done with Coq is mechanically checked by the machine. In particular, Coq allows:

* the definition of mathematical objects and programming objects,
* to state mathematical theorems and software specifications,
* to interactively develop formal proofs of these theorems,
* to check these proofs by a small certification “kernel”.

Coq is based on a logical framework called “Calculus of Inductive Constructions” extended by a modular development system for theories.

### Did you really need to name it like that?

Some French computer scientists have a tradition of naming their software as animal species: Caml, Elan, Foc or Phox are examples of this tacit convention. In French, “coq” means rooster, and it sounds like the initials of the Calculus of Constructions CoC on which it is based.

### Is Coq a theorem prover?

Coq comes with decision and semi-decision procedures (propositional calculus, Presburger's arithmetic, ring and field simplification, resolution, ...) but the main style for proving theorems is interactively by using LCF-style tactics.

### What are the other theorem provers?

Many other theorem provers are available for use nowadays. Isabelle, HOL, HOL Light, Lego, Nuprl, PVS are examples of provers that are fairly similar to Coq by the way they interact with the user. Other relatives of Coq are ACL2, Agda/Alfa, Twelf, Kiv, Mizar, NqThm, Omega...

###  What do I have to trust when I see a proof checked by Coq?

You have to trust:

- **The theory behind Coq**: The theory of Coq version 8.0 is generally admitted to be consistent wrt Zermelo-Fraenkel set theory + inaccessible cardinals. Proofs of consistency of subsystems of the theory of Coq can be found in the literature.
- **The Coq kernel implementation**: You have to trust that the implementation of the Coq kernel mirrors the theory behind Coq. The kernel is intentionally small to limit the risk of conceptual or accidental implementation bugs.
- **The Objective Caml compiler**: The Coq kernel is written using the Objective Caml language but it uses only the most standard features (no object, no label ...), so that it is highly improbable that an Objective Caml bug breaks the consistency of Coq without breaking all other kinds of features of Coq or of other software compiled with Objective Caml.
- **Your hardware**: In theory, if your hardware does not work properly, it can accidentally be the case that False becomes provable. But it is more likely the case that the whole Coq system will be unusable. You can check your proof using different computers if you feel the need to.
- **Your axioms**: Your axioms must be consistent with the theory behind Coq.

### Where can I find information about the theory behind Coq?

* The Calculus of Inductive Constructions
  * [Chapter 4](https://coq.inria.fr/refman/cic.html) and [Chapter 5](https://coq.inria.fr/refman/modules.html) of the Coq Reference Manual.
* Type theory
  * _Jean-Yves Girard, Yves Lafont, and Paul Taylor. Proofs and Types. Cambrige Tracts in Theoretical Computer Science, Cambridge University Press, 1989._
  * _Gilles Dowek. Théorie des types. Lecture notes, 2002._
* Inductive types
  * _Christine Paulin-Mohring. Définitions Inductives en Théorie des Types d'Ordre Supérieur. Habilitation à diriger les recherches, Université Claude Bernard Lyon I, December 1996._
* Co-Inductive types
  * _Eduardo Giménez. Un Calcul de Constructions Infinies et son application a la vérification de systèmes communicants. thèse d'université, Ecole Normale Supérieure de Lyon, December 1996._
* Miscellaneous
  * The [Bibliography](https://coq.inria.fr/refman/biblio.html) of the Coq Reference Manual.

### How can I use Coq to prove programs?

You can either extract a program from a proof by using the extraction mechanism or use dedicated tools, such as [Why](http://why3.lri.fr/), [Krakatoa](http://krakatoa.lri.fr/), [Frama-c](http://frama-c.com/), to prove annotated programs written in other languages.

### How old is Coq?

The first implementation is from 1985 (it was named CoC which is the acronym of the name of the logic it implemented: the Calculus of Constructions). The first official release of Coq (version 4.10) was distributed in 1989.

### What are the Coq-related tools?

There are graphical user interfaces:
* **Coqide**: A GTK based GUI for Coq.
* **Pcoq**: A GUI for Coq with proof by pointing and pretty printing.
* **coqwc**: A tool similar to `wc` to count lines in Coq files.
* **Proof General**: A emacs mode for Coq and many other proof assistants.
* **ProofWeb**: An online web interface for Coq (and other proof assistants), with a focus on teaching.
* **ProverEditor**: An experimental Eclipse plugin with support for Coq.

There are documentation and browsing tools:

* **coq-tex**: A tool to insert Coq examples within `.tex` files.
* **coqdoc**: A documentation tool for Coq.
* **coqgraph**: A tool to generate a dependency graph from Coq sources.

There are front-ends for specific languages:

* **Why**: A back-end generator of verification conditions.
* **Krakatoa**: A Java code certification tool that uses both Coq and Why to verify the soundness of implementations with regards to the specifications.
* **Caduceus**: A C code certification tool that uses both Coq and Why.
* **Zenon**: A first-order theorem prover.
* **Focal**: The Focal project aims at building an environment to develop certified computer algebra libraries.
* **Concoqtion**: A dependently-typed extension of Objective Caml (and of MetaOCaml) with specifications expressed and proved in Coq.
* **Ynot** is an extension of Coq providing a ”Hoare Type Theory” for specifying higher-order, imperative and concurrent programs.
* **Ott** is a tool to translate the descriptions of the syntax and semantics of programming languages to the syntax of Coq, or of other provers.

### What are the high-level tactics of Coq?

* Decision of quantifier-free Presburger's Arithmetic
* Simplification of expressions on rings and fields
* Decision of closed systems of equations
* Semi-decision of first-order logic
* Prolog-style proof search, possibly involving equalities

### What are the main libraries available for Coq?

* Basic Peano's arithmetic, binary integer numbers, rational numbers
* Real analysis
* Libraries for lists, boolean, maps, floating-point numbers
* Libraries for relations, sets and constructive algebra
* Geometry

### What are the mathematical applications for Coq?

Coq is used for formalizing mathematical theories, for teaching, and for proving properties of algorithms or programs libraries.

The largest mathematical formalization has been done at the University of Nijmegen (see the [Constructive Coq Repository at Nijmegen](http://corn.cs.ru.nl/)).

A symbolic step has also been obtained by formalizing in full a proof of the Four Color Theorem.

### What are the industrial applications for Coq?

Coq is used e.g. to prove properties of the JavaCard system (especially by Schlumberger and Trusted Logic). It has also been used to formalize the semantics of the Lucid-Synchrone data-flow synchronous calculus used by Esterel-Technologies.