(Part of [[the Coq FAQ]])

### What are the differences between type classes and canonical structures?

There is varied opinion about when to use Typeclasses versus when to use Canonical Structures. Some references are listed below:


- [Mailing list thread on Typeclasses versus Canonical Structures](http://coq-club.inria.narkive.com/TBVZVe4O/typeclasses-vs-canonical-instances)

- [Software foundations discussion: Advice from Experts](https://softwarefoundations.cis.upenn.edu/draft/qc-current/Typeclasses.html)

- [Canonical structures for the working Coq user: section on related work](https://hal.inria.fr/hal-00816703v1/document)

- [Packaging Mathematical Structures](https://hal.inria.fr/inria-00368403v1/document) and [Garillot's PhD thesis](https://pastel.archives-ouvertes.fr/pastel-00649586/file/manuscript.pdf) describe how ssreflect uses canonical structure. The thesis also has an in-depth discussion of the computational complexity "bundled" (canonical structures) and "unbundled" (typeclasses) approaches.

- [Type Classes for Mathematics in Type Theory](https://arxiv.org/abs/1102.1323) describes an algebraic hierarchy using type classes.

- [Hints in Unification](https://www.cs.unibo.it/~sacerdot/PAPERS/tphol09.pdf) argues for a generalization of both mechanisms.

The `mathcomp` (Mathematical Components) library uses Canonical Structures, as described in the [`mathcomp` book](https://math-comp.github.io/mcb/book.pdf).

The general opinion seems to be that:

- Coq typeclasses allow multiple instances, unlike Haskell Typeclasses.
- The `typeclass` resolution mechanism uses more powerful unification rules, but is also harder to predict. 
- Debugging typeclasses is harder due to their greater power. On the other hand, there is `Set Typeclasses Debug` (and `Set Typeclasses Debug Verbosity 2`); no similar mechanism exists for canonical structures.
- Typeclass resolution can be slow in large developments, and typeclasses can lead to *huge* terms because of redundancy in class indices.
- Canonical structures are simple and their unification rule is easy to reason about. However, the way they are triggered by projections can be hard to understand, whereas typeclasses can be explained as "just" an inference mechanism that fills holes.