(Part of [[the Coq FAQ]])

### What are the differences between type classes and canonical structures?

There is varied opinion about when to use Typeclasses versus when to use Canonical Structures. Some references are listed below:


- [Mailing list thread on Typeclasses versus Canonical Structures](http://coq-club.inria.narkive.com/TBVZVe4O/typeclasses-vs-canonical-instances)

- [Software foundations discussion: Advice from Experts](https://softwarefoundations.cis.upenn.edu/draft/qc-current/Typeclasses.html)

- [Canonical structures for the working Coq user: section on related work](https://hal.inria.fr/hal-00816703v1/document)

- [2008 -- Garillot, Gonthier, Mahboubi, Rideau -- Packaging Mathematical Structures](https://hal.inria.fr/inria-00368403v1/document)

- [2011 -- Spitters, van der Weegen -- Type Classes for Mathematics in Type Theory](https://arxiv.org/abs/1102.1323)

The `mathcomp` (Mathematical Components) library uses Canonical Structures, as described in the [`mathcomp` book](https://math-comp.github.io/mcb/book.pdf).

The general opinion seems to be that:

- Coq typeclasses allow multiple instances, unlike Haskell Typeclasses.
- The `typeclass` resolution mechanism uses more powerful unification rules, but is also harder to control. 
- Debugging typeclasses is harder due to their greater power.
- Typeclass resolution can be slow in large developments.
- Canonical structures are simple and their unification rule is easy to reason about.