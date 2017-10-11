There are a number of automatic theorems provers, proof assistants and math formalization systems. Some of them:

-   [ACL2](http://www.cs.utexas.edu/users/moore/acl2/acl2-doc.html)
-   [GHilbert](http://ghilbert.org)
-   [Hilbert II](http://www.qedeq.org/index.html)
-   [HOL Light](http://www.cl.cam.ac.uk/users/jrh/hol-light/)
-   [Isabelle](http://isabelle.in.tum.de/index.html)
-   [Metamath](http://au.metamath.org/index.html)
-   [Mizar](http://www.mizar.org)
-   [Nqthm](ftp://ftp.cs.utexas.edu/pub/boyer/nqthm/index.html)
-   [NuPRL](http://www.cs.cornell.edu/Info/Projects/NuPrl/)
-   [PlanetMath](http://planetmath.org)
-   [ProofPower](http://www.lemma-one.com/ProofPower/index/)

For a more complete list see [Freek Wiedijk's list of Computer Math Systems](http://www.cs.ru.nl/~freek/digimath/index.html).

It would be nice to give brief list of their advantages and disadvantages compared to Coq.

-   Kam, Robert C., "Case Studies in Proof Checking" available from <http://www.cs.sjsu.edu/faculty/beeson/Masters/KamThesis.pdf> includes a critique of Coq and a comparison with the Mizar system.
-   -   Among other things, it is claimed that Coq's abstract foundations introduce incompatibilities between foundational libraries and make it hard to reuse existing theories. The non-trivialness of type-casting compounds this problem. See [LibraryIncompatibility](../LibraryIncompatibility)

HOL theorem provers
===================

HOL Light
---------

HOL Light is a proof assistant in the HOL family. It is being used in the [FlyspeckProject](../FlyspeckProject) to machine-check Hales's proof of the Kepler conjecture.

Freek Wiedijk has described an encoding of the HOL Light logic into Coq: see \[<http://www.cs.ru.nl/~freek/notes/holl2coq.pdf>\]. Unfortunately, the overall approach is very inefficient.

Hol4 and [ProofPower](../ProofPower) are said to have the same foundation as HOL light; if so, the same encoding should apply. Isabelle/HOL is also a system in the HOL family, and the foundational differences with HOL light should be minor.

Mizar
=====

The Mizar system (ignoring the default axioms which are based on Tarski/Grothendieck set theory, a strenghtening of ZFC) is based on unsorteed FOL. Encoding this logical system into Coq is straightforward.

Related Tools for Software Verification
=======================================

-   Caduceus <http://why.lri.fr/caduceus/index.en.html>
-   Krakatoa <http://krakatoa.lri.fr/>
-   Why <http://why.lri.fr/index.en.html>

Why you should choose Coq
=========================

It's free. Coq is licensed under LGPL, so it's much easier to modify it and develop it. For example, although Mizar has very large theorems collection, there is no prover source available.

It's strict. Comparing Coq to wiki-based systems like [PlanetMath](http://planetmath.org) shows it's that Coq is much nicer organized. Although it's easy to contribute to wiki system, it's hard to manage them. It's hard to trust just wiki.
