#acl CoqAdminGroup:read,write,admin,revert,delete CoqDevelopersGroup:read,write All:read

= The main features of the forthcoming version 8.3 =

 * a new specialized tactic for solving systems of polynomial equations ({{{gb}}} by Loïc Pottier)

 * a better module system with more transparent name management and an inheritance operator <:

 * libraries FSet and Sorting revised, library Numbers extended, new modular library MSets of finite sets with computational content and specification separated

 * more and better tactics

= Roadmap for version 8.4 =

 * new proof engine with existential variables instantiable by tactics, and, hopefully structured proof scripts (formerly thought for 8.3 but postponed)

 * native support for axiom K and eta-conversion

= The future of Coq =

In the longer term, we plan to investigate

 * foundations of the [[TheoryBehindCoq|Calculus of Inductive Constructions]]

   * how to support some form of extensional reasoning? (see the [[http://pierre-yves.strub.nu/research/coqmt/|CoqMT]] prototype for native support of decidably true equations over natural numbers)

   * to which extent supporting pattern-matching on inductive subfamilies à la [[http://appserv.cs.chalmers.se/users/ulfn/wiki/agda.php|Agda]]? (see also the [[http://mattam.org/research/coq/equations.en.html|Equations]] plugin)

   * support for proof-irrelevance in the conversion (either by reasoning in Miquel-Barras-Bernardo's Implicit Calculus of Inductive Constructions or by following Werner's approach)

 * a re-evaluation of the overall structure, objectives and contents of the standard library ([[ReflectionOnStandardLibrary|discussion page]])

 * a cleaning phase of the tactics

 * more solid foundations for the different forms of unification used in Coq (for proving and for type inference)

 * an extension of CoqIDE ([[CoqIDEWishes|wish list]])

Under consideration are

 * aspects of the [[http://www.msr-inria.inria.fr/Projects/math-components|ssreflect]] tactic language

 * proof generation from the [[http://ergo.lri.fr|alt-ergo]] theorem prover

 * kernel-embedded decision procedures (see the [[http://pierre-yves.strub.nu/research/coqmt/|CoqMT]] prototype for natively solving quantifier-free arithmetic)
