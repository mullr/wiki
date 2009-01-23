#pragma section-numbers off
#language en

Some of the tools listed here are part of bigger projects that support other proof assistants/theorem provers.  Another list of Coq-related tools can be found at [[http://coq.inria.fr/tools1-eng.html]].

== Interface for Editing Proofs ==

 * [[http://coq.inria.fr/coqide/|CoqIDE]]
   The graphical user interface distributed with Coq.
 * [[http://www-sop.inria.fr/lemme/pcoq/|PCoq]]
   A graphical user interface for Coq. The environment provides ways to edit structurally formulas and commands, new notations can easily be added. It allows proof by pointing.
 * [[http://proofgeneral.inf.ed.ac.uk/|ProofGeneral]]
  !ProofGeneral is a generic interface for proof assistants, based on the customizable text editor Emacs.
 * [[http://tmcoq.audebaud.org/|TmCoq]] 
  !TmCoq integrates Coq within !TeXmacs.
 * [[http://home.gna.org/geoproof/|GeoProof]]
  !GeoProof is a dynamic geometry software, with can communicate with CoqIDE to build the formula corresponding to a geometry figure interactively.
 * [[http://www.mimuw.edu.pl/~chrzaszc/Papuq/|Papuq]]
  Papuq is patched version of CoqIde with teaching oriented features.
 * [[http://www.cs.ru.nl/~lionelm/tmEgg/|tmEgg]]
  Coq plugin for !TeXmacs

== Interface for Browsing Proofs ==

 * [[http://helm.cs.unibo.it/|Helm]] is a browsable and searchable (using the `Whelp` tool) repository of formal mathematics (includes the Coq User Contributions).

== Presenting Proofs ==

 * `coqdoc` exports vernacular file to TeX or HTML. It is part of the Coq distribution and documented in the [[http://coq.inria.fr/doc|Reference Manual]].
 * enscript mode for Coq [[http://www.cs.ru.nl/~milad/programs/enscript]]
 
== Tactics packages ==

 * [[http://coq.inria.fr/contribs/Micromega.html|Micromega]]: solves linear (Fourier-Motzkin) and non linear (Sum-of-Square's algorithm) systems of polynomial inequations; also provides a (partial) replacement for the Coq's `omega` tactic.

 * [[http://www.msr-inria.inria.fr/Projects/math-components|Ssreflect]] facilitates proof by small scale reflection, "a style of proof that ... provide[s] effective automation for many small, clerical proof steps. This is often accomplished by restating ("reflecting") problems in a more concrete form ... For example, in the Ssreflect library arithmetic comparison is not an abstract predicate, but a function computing a boolean. ([[http://pauillac.inria.fr/pipermail/coq-club/2008/003486.html|source]])" 

== Packaging extracted code ==
 * [[ZInterfacePackage|Z_interface]] An approach for deriving directly standalone programs from extracted code.
