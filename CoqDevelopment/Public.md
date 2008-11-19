#acl CoqAdminGroup:read,write,admin,revert,delete CoqDevelopersGroup:read,write All:read

= The main features of the forthcoming version 8.2 =

- type classes

- extended arithmetic libraries (arithmetical computations bound to machine words when possible,
libraries for 31-bits integers, 31-bits-word-based unbounded integers, axiomatic arithmetic)

- more general comfort for daily use of Coq (module system, tactics, syntax extensions, type inference, commands)

- a stand-alone cross-verifier of Coq proofs

= The future of Coq =

Here are a few directions that the Coq development team aim to follow for the next releases of Coq (post-8.2):

- a new proof engine with tactics applying to multi-goals, structured proofs and refinement of existential variables by tactics

- extension of the underlying [[TheoryBehindCoq|Calculus of Inductive Constructions]] with pattern-matching on inductive subfamilies leading to pattern-matching à la [[http://appserv.cs.chalmers.se/users/ulfn/wiki/agda.php|Agda]]

- still more general comfort, tactics and tools

In the longer term, we plan

- a re-evaluation of the overall structure, objectives and contents of the standard library ([[ReflectionOnStandardLibrary|discussion page]])

- a cleaning phase of the tactics

- more solid foundations for the different forms of unification used in Coq (for proving and for type inference)

Under consideration from partners are

- the [[http://www.msr-inria.inria.fr/Projects/math-components|ssreflect]] tactic language

- proof generation from the [[http://ergo.lri.fr|alt-ergo]] theorem prover

- kernel-embedded decision procedures
