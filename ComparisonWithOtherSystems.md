## page was renamed from ComparisionWithOtherSystems
There are a number of automatic theorems provers, proof assistants and math formalization systems. Some of them:

 * [[http://www.cs.utexas.edu/users/moore/acl2/acl2-doc.html|ACL2]]
 * [[http://ghilbert.org|GHilbert]]
 * [[http://www.qedeq.org/index.html|Hilbert II]]
 * [[http://www.cl.cam.ac.uk/users/jrh/hol-light/|HOL Light]]
 * [[http://isabelle.in.tum.de/index.html|Isabelle]]
 * [[http://au.metamath.org/index.html|Metamath]]
 * [[http://www.mizar.org|Mizar]]
 * [[ftp://ftp.cs.utexas.edu/pub/boyer/nqthm/index.html|Nqthm]]
 * [[http://www.cs.cornell.edu/Info/Projects/NuPrl/|NuPRL]]
 * [[http://planetmath.org|PlanetMath]]
 * [[http://www.lemma-one.com/ProofPower/index/|ProofPower]]

For a more complete list see [[http://www.cs.ru.nl/~freek/digimath/index.html|Freek Wiedijk's list of Computer Math Systems]]. 

It would be nice to give brief list of their advantages and disadvantages compared to Coq. 

* Kam, Robert C., "Case Studies in Proof Checking" available from [[http://www.cs.sjsu.edu/faculty/beeson/Masters/KamThesis.pdf]] includes a critique of Coq and a comparison with the Mizar system.
** Among other things, it is claimed that Coq's abstract foundations introduce incompatibilities between foundational libraries and make it hard to reuse existing theories.  The non-trivialness of type-casting compounds this problem.  See LibraryIncompatibility

=== Why you should choose Coq ===

It's free. Coq is licensed under LGPL,  so it's much easier to modify it and develop it. For example, although Mizar has very large theorems collection, there is no prover source available.

It's strict. Comparing Coq to wiki-based systems like [[http://planetmath.org|PlanetMath]] shows it's that Coq is much nicer organized. Although it's easy to contribute to wiki system, it's hard to manage them. It's hard to trust just wiki.
