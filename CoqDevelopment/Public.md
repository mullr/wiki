#acl CoqAdminGroup:read,write,admin,revert,delete CoqDevelopersGroup:read,write All:read

= Roadmap for version 8.4 =

 * new proof engine with existential variables instantiable by tactics, and, hopefully structured proof scripts (Arnaud Spiwack)

 * native support for eta-conversion (Hugo Herbelin) and maybe axiom K

 * new comprehensive abstract library of numbers, specifying standard arithmetical operations (including power, square root, log, ...) and standard bitwise operations (shift, logical and, or, xor, ...) (Pierre Letouzey, carrying on preliminary works from Evgeny Makarov, also using material from Laurent Théry and Benjamin Grégoire)

 * new model of communication, process based instead of thread based, between Coq and CoqIDE, allowing multi-sessions and interruptability of Coq

= The future of Coq =

In the longer term, we plan to investigate

 * foundations of the [[TheoryBehindCoq|Calculus of Inductive Constructions]]

   * how to support some form of extensional reasoning? (see the [[http://pierre-yves.strub.nu/research/coqmt/|CoqMT]] prototype for native support of decidably true equations over natural numbers)

   * to which extent supporting pattern-matching on inductive subfamilies à la [[http://appserv.cs.chalmers.se/users/ulfn/wiki/agda.php|Agda]]? (see also the [[http://mattam.org/research/coq/equations.en.html|Equations]] plugin)

   * how to natively support machine word arithmetic and arrays (see Benjamin Grégoire's [[https://gforge.inria.fr/scm/viewvc.php/branches/native/?root=coq native]] branch)

   * support for proof-irrelevance in the conversion (either by reasoning in Miquel-Barras-Bernardo's Implicit Calculus of Inductive Constructions or by following Werner's approach)

 * a re-evaluation of the overall structure, objectives and contents of the standard library ([[ReflectionOnStandardLibrary|discussion page]])

 * a cleaning phase of the tactics

 * more solid foundations for the different forms of unification used in Coq (for proving and for type inference)

 * other extensions of CoqIDE ([[CoqIDEWishes|wish list]])

Under consideration are

 * aspects of the [[http://www.msr-inria.inria.fr/Projects/math-components|ssreflect]] tactic language

 * proof generation from the [[http://ergo.lri.fr|alt-ergo]] theorem prover

 * kernel-embedded decision procedures (see the [[http://pierre-yves.strub.nu/research/coqmt/|CoqMT]] prototype for natively solving quantifier-free arithmetic)
