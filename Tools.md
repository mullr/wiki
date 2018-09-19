Some of the tools listed here are part of bigger projects that support other proof assistants/theorem provers. Another list of Coq-related tools can be found at <https://coq.inria.fr/related-tools>.

Interface for Editing Proofs
============================

-   [CoqIDE](CoqIde)

    > The graphical user interface distributed with Coq.

-   [ProofGeneral](https://proofgeneral.github.io/)

    > ProofGeneral is a generic interface for proof assistants, based on the customizable text editor Emacs.

-   [Coqoon](http://coqoon.github.io)

    > Eclipse plugin for Coq development (based on Wenzel's asynchronous PIDE framework).

-   [Coq PIDE](http://coqpide.bitbucket.org)

    > Jedit (proof of concept) plugin for Coq development by Carst Tankink (also based on asynchronous PIDE framework).

-   [Papuq](http://www.mimuw.edu.pl/~chrzaszc/Papuq/)

    > Papuq is patched version of [CoqIde](CoqIde) with teaching oriented features.

-   [tmEgg](http://www.cs.ru.nl/~lionelm/tmEgg/)

    > Coq plugin for TeXmacs

-   [ProofWeb](http://prover.cs.ru.nl)

    > An online web interface for Coq (and other proof assistants), with a focus on teaching.

-   [ProverEditor](http://provereditor.gforge.inria.fr)

    > An experimental Eclipse plugin with support for Coq.

-   [vscoq](https://github.com/siegebell/vscoq)

    > A Visual Studio based interface developed in 2016.

Discontinued interfaces
-----------------------

-   [GeoProof](http://home.gna.org/geoproof/)

    > GeoProof was a dynamic geometry software, which can communicate with CoqIDE to build the formula corresponding to a geometry figure interactively.

-   [PCoq](http://www-sop.inria.fr/lemme/pcoq/) (for versions of Coq in old syntax, version 7.4 of 2003 and before)

    > A graphical user interface for Coq. The environment provides ways to edit structurally formulas and commands, new notations can easily be added. It allows proof by pointing.

-   [TmCoq](http://tmcoq.audebaud.org/)

    > TmCoq integrates Coq within TeXmacs.

Interface for Browsing Proofs
=============================

-   [Helm](http://helm.cs.unibo.it/) is a browsable and searchable (using the `Whelp` tool) repository of formal mathematics (includes the Coq User Contributions).

Presenting Proofs
=================

-   `coqdoc` exports vernacular file to TeX or HTML. It is part of the Coq distribution and documented in the [Reference Manual](http://coq.inria.fr/doc).
-   enscript mode for Coq <http://www.cs.ru.nl/~milad/programs/enscript>

Tactics packages
================

-   [Micromega](http://coq.inria.fr/contribs/Micromega.html): solves linear (Fourier-Motzkin) and non linear (Sum-of-Square's algorithm) systems of polynomial inequations; also provides a (partial) replacement for the Coq's `omega` tactic.
-   [Ssreflect](http://www.msr-inria.inria.fr/Projects/math-components) facilitates proof by small scale reflection, "a style of proof that ... provide\[s\] effective automation for many small, clerical proof steps. This is often accomplished by restating ("reflecting") problems in a more concrete form ... For example, in the Ssreflect library arithmetic comparison is not an abstract predicate, but a function computing a boolean. ([source](http://pauillac.inria.fr/pipermail/coq-club/2008/003486.html))"
-   [AAC\_tactics](http://sardes.inrialpes.fr/%7Ebraibant/aac%5Ftactics/) provides tactics that facilitates the rewriting of universal equations,modulo associative and possibly commutative operators, and modulo neutral elements (units).

Packaging extracted code
========================

-   [Z\_interface](ZInterfacePackage) An approach for deriving directly standalone programs from extracted code.

Utilities
=========

-   `coqwc` is a stand-alone command line tool to print line statistics about Coq files (how many lines are spec, proof, comments). `coqwc` comes with the standard Coq distribution.