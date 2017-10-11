Some of the tools listed here are part of bigger projects that support other proof assistants/theorem provers.  Another list of Coq-related tools can be found at https://coq.inria.fr/related-tools.

Interface for Editing Proofs
----------------------------

* CoqIDE_

    The graphical user interface distributed with Coq.

* ProofGeneral_

    ProofGeneral is a generic interface for proof assistants, based on the customizable text editor Emacs.

* Coqoon_

    Eclipse plugin for Coq development (based on Wenzel's asynchronous PIDE framework).

* `Coq PIDE`_

    Jedit (proof of concept) plugin for Coq development by Carst Tankink (also based on asynchronous PIDE framework).

* GeoProof_

    GeoProof is a dynamic geometry software, with can communicate with CoqIDE to build the formula corresponding to a geometry figure interactively.

* Papuq_

    Papuq is patched version of CoqIde_ with teaching oriented features.

* tmEgg_

    Coq plugin for TeXmacs

* ProofWeb_

    An online web interface for Coq (and other proof assistants), with a focus on teaching.

* ProverEditor_

    An experimental Eclipse plugin with support for Coq.

Discontinued interfaces
:::::::::::::::::::::::

* PCoq_ (for versions of Coq in old syntax, version 7.4 of 2003 and before)

    A graphical user interface for Coq. The environment provides ways to edit structurally formulas and commands, new notations can easily be added. It allows proof by pointing.

* TmCoq_

    TmCoq integrates Coq within TeXmacs.

Interface for Browsing Proofs
-----------------------------

* Helm_ is a browsable and searchable (using the ``Whelp`` tool) repository of formal mathematics (includes the Coq User Contributions).

Presenting Proofs
-----------------

* ``coqdoc`` exports vernacular file to TeX or HTML. It is part of the Coq distribution and documented in the `Reference Manual`_.

* enscript mode for Coq http://www.cs.ru.nl/~milad/programs/enscript

Tactics packages
----------------

* Micromega_: solves linear (Fourier-Motzkin) and non linear (Sum-of-Square's algorithm) systems of polynomial inequations; also provides a (partial) replacement for the Coq's ``omega`` tactic.

* Ssreflect_ facilitates proof by small scale reflection, "a style of proof that ... provide[s] effective automation for many small, clerical proof steps. This is often accomplished by restating ("reflecting") problems in a more concrete form ... For example, in the Ssreflect library arithmetic comparison is not an abstract predicate, but a function computing a boolean. (source_)"

* AAC_tactics_ provides tactics that facilitates the rewriting of universal equations,modulo associative and   possibly commutative operators, and modulo neutral elements (units).

Packaging extracted code
------------------------

* Z_interface_ An approach for deriving directly standalone programs from extracted code.

.. ############################################################################

.. _CoqIDE: http://coq.inria.fr/coqide/

.. _ProofGeneral: http://proofgeneral.inf.ed.ac.uk/

.. _Coqoon: http://coqoon.github.io

.. _Coq PIDE: http://coqpide.bitbucket.org

.. _GeoProof: http://home.gna.org/geoproof/

.. _Papuq: http://www.mimuw.edu.pl/~chrzaszc/Papuq/

.. _CoqIde: ../CoqIde

.. _tmEgg: http://www.cs.ru.nl/~lionelm/tmEgg/

.. _ProofWeb: http://prover.cs.ru.nl

.. _ProverEditor: http://provereditor.gforge.inria.fr

.. _PCoq: http://www-sop.inria.fr/lemme/pcoq/

.. _TmCoq: http://tmcoq.audebaud.org/

.. _Helm: http://helm.cs.unibo.it/

.. _Reference Manual: http://coq.inria.fr/doc

.. _Micromega: http://coq.inria.fr/contribs/Micromega.html

.. _Ssreflect: http://www.msr-inria.inria.fr/Projects/math-components

.. _source: http://pauillac.inria.fr/pipermail/coq-club/2008/003486.html

.. _AAC_tactics: http://sardes.inrialpes.fr/%7Ebraibant/aac%5Ftactics/

.. _Z_interface: ../ZInterfacePackage

