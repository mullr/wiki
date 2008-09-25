#language en

= W-Type =

A W-type or well-ordered set constructor is introduced in [[Martin-LöfTypeTheory]] to construct well-ordered sets. It can be used to construct many (all predicative?) inductive types of Coq.

== General form ==

If A is a type and B is a type dependent on A (of course this may all be in a context dependent on who knows what else), then there is a type W_A B, or W_{x:A} B[x], of well-founded trees with nodes labelled by A and branching given by B. That is:
 * each node is labelled by an element of A;
 * given a node labelled by x: A, the branches from that node (away from the root) are indexed by B[x];
 * we can do induction on nodes: given any property of nodes, if it holds for a node whenever it holds for every node one step further from the root, then it holds for all nodes.
Note that the root of the tree is a node like any other, and the leaves are those nodes labelled by an x: A such that B[x] is empty.

For example, to define the NaturalNumbers, A has two elements (call them z and s), B[z] is empty, and B[s] has one element. The tree corresponding to the natural number n consists of n nodes labelled by s (the first of these the root), one after another, ending in one more node (a leaf) labelled by z. (If the number is zero, then the root is the leaf.) Branching is trivial, since every B[x] has at most one element; the tree must stop sometime, by well-foundedness.

Note that a calculus founded on inductive types will still need to stick in some basic type constructions by hand: an empty type, binary sums, and dependent sums. (Also dependent products, but even the CalculusOfInductiveConstructions has to do that.) Often, followers of Martin-Löf will put in some other basic types by hand (usually N and the non-empty finite types), but these are not strictly necessary.

== W-types vs. Inductive types ==

There some problems with using the W-type constructor instead of the inductive types of Coq:

 1. The elimination rule for inductive types can't be proved using intensional equality. For example, if you define the set of natural numbers as a W-type then you will need [[extensional_equality]] to obtain nat_elim. This is because one cannot prove that there is only a unique function from the empty set to the set of natural numbers without using extensional equality.

 1. It is difficult to encode complicated inductive types (e.g. mutual inductive families) as W-types. You can use the GeneralTreeConstructor to get over some of this difficulty, but still defining inductive types directly using their constructors (as it is done in Coq) is much easier in practice for programming.

 1. You want to be able to define impredicative inductive types (at least in Prop).

On the other hand, basing a proof assistant on W-types has its own advantages:

 1. The system is simpler. You only have one constructor for all inductive types instead of adding inductive types one by one. (But you still need to put in empty types, binary sums, and dependent sums.)

 2. You have one type constructor for all inductive types. This means that you can describe classes of particular data types and define functions on these. This is usually called generic programming in the functional programming community. In type theory with W-types, it is there for free.
