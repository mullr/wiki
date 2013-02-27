#acl CoqAdminGroup:read,write,admin,revert,delete CoqDevelopersGroup:read,write All:read

<<TableOfContents>>

= Minutes from the Coq development working groups and ADT meetings =

Minutes might be written in either English or French

 * [[CoqDevelopment/CRGTCoq20130214|14 février 2013]] (about native compilation, reals, enhancing conversion, the new coqdoc)
 * [[CoqDevelopment/CRGTCoq20120119|19 janvier 2012]] (about the repository of user contributions, parsing patterns as terms, 8.4)
 * [[CoqDevelopment/CRGTCoq20110706|6 juillet 2012]] (about structured proof scripts, options applying to arguments)
 * [[CoqDevelopment/CRGTCoq20110414|14 avril 2011]] (about native ints, native arrays, native compilation, numbers library, containers library, ergo decision procedure, other libraries, 8.4)
 * [[CoqDevelopment/CRGTCoq20101217|17 décembre 2010]] (about the Numbers library)
 * [[http://coq.inria.fr/files/summary-27oct2010.txt|27 octobre 2010]] (ADT interfaces)
 * [[CoqDevelopment/CRGTCoq20100920|20 septembre 2009]]
 * [[CoqDevelopment/CRGTCoq20100426|26 avril 2009]]
 * [[CoqDevelopment/CRADT20100202|2 février 2009]]
 * [[CoqDevelopment/CRGTCoq20100113|13 janvier 2009]]
 * [[CoqDevelopment/CRGTCoq20091103|3 novembre 2009]]
 * [[CoqDevelopment/CRADT20090630|30 juin 2009]] (ADT tactiques)
 * [[CoqDevelopment/CRGTCoq20090704|3 juillet 2009]] (ADT equality and termination)
 * [[CoqDevelopment/CRADT20090324|24 mars 2009]] (ADT meeting on automatisation)
 * [[CoqDevelopment/CRADTCommunication20090323|23 mars 2009]] (discussion sur format de communication avec outils externes)
 * [[CoqDevelopment/CRGTCoq20090323|23 mars 2009]] 
 * [[CoqDevelopment/CRGTCoq20090116|16 janvier 2009]] 
 * [[CoqDevelopment/CRGTCoq20081118|18 novembre 2008]]
 * [[CoqDevelopment/CRADT20081029|29 octobre 2008]] (ADT Kick-off meeting)
 * [[CoqDevelopment/CRGTCoq20081010|10 octobre 2008]]

= Past roadmap for version 8.4 =

 * new proof engine with existential variables instantiable by tactics, and, hopefully structured proof scripts (Arnaud Spiwack)

 * native support for eta-conversion (Hugo Herbelin) and maybe axiom K

 * new comprehensive abstract library of numbers, specifying standard arithmetical operations (including power, square root, log, ...) and standard bitwise operations (shift, logical and, or, xor, ...) (Pierre Letouzey, carrying on preliminary works from Evgeny Makarov, also using material from Laurent Théry and Benjamin Grégoire)

 * new model of communication, process based instead of thread based, between Coq and CoqIDE, allowing multi-sessions and interruptability of Coq

= Roadmap for version 8.5 =

 * improved support for pattern-matching on inductive subfamilies à la [[http://appserv.cs.chalmers.se/users/ulfn/wiki/agda.php|Agda]] (see also the [[http://mattam.org/research/coq/equations.en.html|Equations]] plugin)

 * native support for machine word arithmetic and arrays (see Benjamin Grégoire and Maxime Dénès' [[https://gforge.inria.fr/scm/viewvc.php/branches/native/?root=coq native]] branch)

 * applications of the new proof engine: multi-goals tactics? deep backtracking? (Arnaud Spiwack)

 * binding the libraries of Peano numbers and rational numbers to the Numbers architecture

 * asynchronous interaction (parallel compilation of proof scripts, modular compilation of files)

 * miscellaneous tactic improvements (rewriting strategies, improved induction tactics, ...)

 * improvements of the guard condition

 * optimized representation of records with native projections

 * a new infrastructure for user contributions

 * a reworking of coqdoc (François Ripault)

= The future of Coq =

In the longer term, we plan to investigate

 * foundations of the [[TheoryBehindCoq|Calculus of Inductive Constructions]]

   * how to support some form of extensional reasoning? (see the [[http://pierre-yves.strub.nu/research/coqmt/|CoqMT]] prototype for native support of decidably true equations over natural numbers)

   * support for proof-irrelevance in the conversion (either by reasoning in Miquel-Barras-Bernardo's Implicit Calculus of Inductive Constructions or by following Werner's approach)

   * support for K at the Set level

   * induction-recursion

   * compatibility of the logic with the univalent homotopy model

 * a library of mathematical structures (see also [[ReflectionOnStandardLibrary|discussion page]])

 * a typed tactic language (Yann Régis-Gianas, Lourdes del Carmen González Huesca, Guillaume Claret)

 * a cleaning phase of the tactics

 * more solid foundations for the different forms of unification used in Coq (for proving and for type inference)

 * graphical user interfaces: JEdit-based interfaces (see [[http://paral-itp,lri.fr|Paral-ITP project]]), design of a Coq-GUI communication protocol, miscellaneous extensions of CoqIDE ([[CoqIDEWishes|wish list]])
 
Under consideration are

 * aspects of the [[http://www.msr-inria.inria.fr/Projects/math-components|ssreflect]] tactic language

 * proof generation from the [[http://ergo.lri.fr|alt-ergo]] theorem prover

 * kernel-embedded decision procedures (see the [[http://pierre-yves.strub.nu/research/coqmt/|CoqMT]] prototype for natively solving quantifier-free arithmetic)

 * full universe polymorphism

= Miscellaneous =

 * [[CoqDevelopment/RaccourcisPourDevelopperSousEmacs|Raccourcis pour accélérer la compilation]] (en particulier sous Emacs).
