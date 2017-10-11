Introduction
------------

* Nice introduction to the type theory 

    `Book by Simon Thompson`_

* Lectures about Coq

    http://www.europeindia.org/cd09/lectures/lect04/index.htm

    `Lecture notes by Femke van Raamsdonk`_

    `Lecture notes on Lambda calculus, types and their use in proofs, by Yves Bertot`_ (in French)

Metatheory of the Calculus of Constructions
-------------------------------------------

* `Metamathematical Investigations of a Calculus of Construction, Thierry Coquand`_ 

Metatheory of Inductive Types
-----------------------------

* `Definitions and further issues regarding inductive types in Coq, Christine Paulin`_ (in French)

    In this work the definitions based on ``case`` (case analysis, now called ``match``) and ``Fixpoint`` are described. Several issues eg. mutual inductive types, restrictions on elimination sort and positivity condition are studied.

* `Guardedness condition for fixed points and cofixed points, Eduardo Giménez`_

Model Construction
------------------

* `Realizability model for the calculus of construction with universes (CC_{omega}) with subtyping, Alexandre Miquel`_

  This paper contains realizability model for a system stronger than Coq but without inductive types.

* `Set-theoretical model of the calculus of construction (CC) and discussion about the extension to CC_{omega}, Alexandre Miquel and Benjamin Werner`_

* `Realizability model for the calculus of construction (CC) extended with the type of natural numbers and only one universe, Benjamin Werner`_ (in French)

(In)dependence of Axioms
------------------------

* `Groupoid model of intensional Martin-Lof type theory, Martin Hofmann and Thomas Streicher`_: This shows the independence of Axiom ``K``, which states that there is only one proof of reflexivity statement.

* `Excluded Middle in impredicative Set and extensionality of functions are refuted by Miquel's realizability model of CC_{omega}, Alexandre Miquel`_

* `Excluded Middle in Prop and Axiom of Choice in Type are inconsistent with impredicative Set, Laurent Chicli and Loïc Pottier and Carlos Simpson`_

Others
------

* Why does Coq use inductive types and not W-Types_?

* A summary_ of the long and informative discussion that took place on the coq-club mailing list when similar bugs were discovered in the termination checkers of both Coq and Agda. 

* Some `proof theoretic consequences`_ of impredicative Prop.

.. ############################################################################

.. _Book by Simon Thompson: http://www.cs.kent.ac.uk/people/staff/sjt/TTFP/

.. _Lecture notes by Femke van Raamsdonk: http://www.cs.vu.nl/~tcs/lv/notes.html

.. _Lecture notes on Lambda calculus, types and their use in proofs, by Yves Bertot: http://cel.archives-ouvertes.fr/inria-00083975

.. _Metamathematical Investigations of a Calculus of Construction, Thierry Coquand: http://www.cs.chalmers.se/~coquand/meta.pdf

.. _Definitions and further issues regarding inductive types in Coq, Christine Paulin: http://www.lri.fr/~paulin/PUBLIS/habilitation.ps.gz

.. _Guardedness condition for fixed points and cofixed points, Eduardo Giménez: ftp://ftp.ens-lyon.fr/pub/LIP/Rapports/RR/RR95/RR95-07.ps.Z

.. _Realizability model for the calculus of construction with universes (CC_{omega}) with subtyping, Alexandre Miquel: http://www.pps.jussieu.fr/~miquel/publis/lics00.pdf

.. _Set-theoretical model of the calculus of construction (CC) and discussion about the extension to CC_{omega}, Alexandre Miquel and Benjamin Werner: http://www.pps.jussieu.fr/~miquel/publis/types02.pdf

.. _Realizability model for the calculus of construction (CC) extended with the type of natural numbers and only one universe, Benjamin Werner: ftp://ftp.inria.fr/INRIA/LogiCal/Benjamin.Werner/these.ps.gz

.. _Groupoid model of intensional Martin-Lof type theory, Martin Hofmann and Thomas Streicher: http://www.tcs.informatik.uni-muenchen.de/~mhofmann/venedig.dvi.gz

.. _Excluded Middle in impredicative Set and extensionality of functions are refuted by Miquel's realizability model of CC_{omega}, Alexandre Miquel: http://www.pps.jussieu.fr/~miquel/publis/these.pdf

.. _Excluded Middle in Prop and Axiom of Choice in Type are inconsistent with impredicative Set, Laurent Chicli and Loïc Pottier and Carlos Simpson: http://www-sop.inria.fr/lemme/Loic.Pottier/chicli_pottier_simpson.ps

.. _W-Types: ../WTypeInsteadOfInductiveTypes

.. _summary: ../CoqTerminationDiscussion

.. _proof theoretic consequences: http://r6.ca/blog/20091101T231201Z.html

