#acl CoqAdminGroup:read,write,admin,revert,delete CoqDevelopersGroup:read,write All:read

= The main features of the next version 8.3 =

 * new proof engine with existential variables instantiable by tactics, and, hopefully structured proof scripts

 * a new specialized tactic for solving systems of polynomial equations

 * more and better tactics

 * a better module system with more transparent name management

= The future of Coq =

In the longer term, we plan to investigate

 * foundations of the [[TheoryBehindCoq|Calculus of Inductive Constructions]]

   * how to support some form of extensional reasoning?

   * to which extent supporting pattern-matching on inductive subfamilies à la [[http://appserv.cs.chalmers.se/users/ulfn/wiki/agda.php|Agda]]?

   * support for proof-irrelevance in the conversion (either by reasoning in Miquel-Barras-Bernardo's Implicit Calculus of Inductive Constructions or by following Werner's approach)

 * a re-evaluation of the overall structure, objectives and contents of the standard library ([[ReflectionOnStandardLibrary|discussion page]])

 * a cleaning phase of the tactics

 * more solid foundations for the different forms of unification used in Coq (for proving and for type inference)

 * an extension of CoqIDE ([[CoqIDEWishes|wish list]])

Under consideration are

 * aspects of the [[http://www.msr-inria.inria.fr/Projects/math-components|ssreflect]] tactic language

 * proof generation from the [[http://ergo.lri.fr|alt-ergo]] theorem prover

 * kernel-embedded decision procedures
er

 * kernel-embedded decision procedures
