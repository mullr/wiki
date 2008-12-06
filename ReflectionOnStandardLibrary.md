= Discussion on the standard library of Coq =

See also StandardLibrary for older discussion (should these pages be merged?)

== Organisational aspects ==

=== Overall consistency and maintenance ===

 * Lack of overall design consistency due to not-always-coordinated multi-author development through different times of the history of Coq.
 * Lack of human resources for a correct maintenance of many components of the library: 
   * many users propose to complete and extend some libraries but no availability from the development team to evaluate these additions and to check these extensions do not add design inconsistencies to the existing setting
   * many users developed libraries that could be considered of general purpose (UserContributions) but, again, the Coq developers do not have the time to referee and validate these libraries.

Possible solution: A more modular approach of libraries with a small core of standard library maintained by the Coq development team and a second distinct distributed archive of libraries with a coordinated maintenance so as, not to necessarily guarantee a strict overall consistent design, but to at least guarantee correct compilation dependencies (see the [[http://prover.cs.ru.nl/wiki.php|MathWiki]] project). The responsibility of the maintenance of the consistency of each individual component of this second archive would be distributed.

=== Compatibility issues ===

 * Compatibility issues hinder or at least complicate the improvement of some libraries, e.g.:
   * definitions or lemmas got wrong names, e.g.:
     * {{{plus}}}/{{{mult}}} instead of {{{plus}}}/{{{times}}} or {{{add}}}/{{{mult}}} or {{{add}}}/{{{mul}}},
     * very basic lemmas such as {{{n = pred (S n)}}} were stated in an unnatural way (this historically was due to the use of ''elim'' for simulating rewriting before ''rewrite'' was implemented),
   * bound variables sometimes got inconsistent names in a same library (e.g. lemmas on nat generally use n, m, p, q in this order, but sometimes, it is a,b or x, y or the differently ordered m, n),
   * hints database cannot be improved without breaking ''auto'' in general.
   * bad definition choices were sometimes made (e.g. {{{Zplus}}} of numbers of opposite signs which uselessly computes twice the difference, or the questioned design of <=, <, >= and >),
 * How to address the compatibility issues?
   * Completely forget about too inconsistently built libraries? But they will still be needed anyway. And with what to replace them?
   * Use mechanisms as in the V7 to V8 translator?
     * Notations to provide only-parsing compatibility aliases to newly consistently-named lemmas?
     * ML support for on the fly renaming of binders?
     * Eventually arrive at a V9 generation and use a translator?
     * Combine the cleaner parts with parts clearly flagged as obsolete?

=== Lack of Coq support for features ===

 * Dependency of the technical design of the libraries over the support (or absence of support!) of Coq for some features, e.g.:
   * lack of support for freely reasoning with less-or-equal or greater-or-equal as one would do in a mathematical text: either one is a notation for the other and then the user cannot choose which one he wants to read, or there are two distinct definitions but then there are often not converted one to the other by Coq,
   * lack of support for freely switching between a computational representation of decidable properties (as order in {{{ZArith}}} is defined) and a propositional representation of it (as order in {{{Arith}}} is defined),
   * automatic introduction of names and hypotheses in the context?

=== Documentation and metadata issues ===

Coqdoc is a rather nice tool for documentation but there is a need for metadatas liable to ease the formal treatment of informations like title, author, table of contents, ...

== Specific issues with the libraries of Coq ==

  see StandardLibrary

=== Arithmetic ===

==== General issues about arithmetic ====

 * Naming policy:
   * {{{Snm}}} style vs {{{_assoc}}} style?
   * Heterogenous pair {{{plus}}}/{{{mult}}} (with adopted solution being the pair {{{add}}}/{{{mul}}})?
 * Design choice for less vs greater:
   * Have explicit constants for > and >= (better for displaying things as the user did but requires better support for such 'notational' definitions)?
   * Have only < and <= what is easier to manage and mathematically "cleaner" to think about?
 * Notation policy:
   * Adopt the nice {{{.+1}}} notation?
   * Use "_ = _ ?", "_ <= _ ?" for the computational operations?
 * What design choices for orders and decidable predicates?
 * Design choice for decidable operations:
   * Decidability to {{{bool}}} or decidability to {{{sumbool}}} (but then requires better support for rewriting modulo proof-irrelevance)?
 * Modularity:
   * Proceed further with the {{{Numbers}}} modular approach?

==== Peano numbers ====

 * Organisation:
   * One large file vs small files (as it is now)?
   * What to put in {{{Init}}}? Just the operations or also the basic lemmas?
   * Make all non basic lemmas derived from {{{Numbers}}}?

==== Binary natural numbers ====

==== Binary integers ====

==== Rational numbers ====

=== Real numbers ===

=== Lists ===

=== Lists annotated with their length (vectors) ===

Coq provides a single file with a few results (with comments in French) in the [[http://logical.saclay.inria.fr/coq/distrib/current/stdlib/Coq.Bool.Bvector.html|Bool]] library. The [[http://color.inria.fr|CoLoR]] contribution provides much more.

=== Boolean ===

=== Strings ===

=== Sorting ===

Is this worth to be a distinct library?

=== Maps and sets (data structures) ===

=== Relations and sets ===

=== Algebra ===

Coq sparsely provides definitions of algebraic structures but nothing usable as a standard library. Many approaches to algebra exist (see the various Algebra contributions in the [[http://logical.saclay.inria.fr/coq/distrib/current/contribs|user contribution server of Coq]], including C-CoRN).

=== Libraries not represented in Coq ===

Floating point numbers, constructive real analysis (computing and mathematical aspects), finite sets, but candidates exist (what about the licence issues?).
