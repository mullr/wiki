Introduction
============

-   Nice introduction to the type theory

    > [Book by Simon Thompson](http://www.cs.kent.ac.uk/people/staff/sjt/TTFP/)

-   Lectures about Coq

    > <http://www.europeindia.org/cd09/lectures/lect04/index.htm>
    >
    > [Lecture notes by Femke van Raamsdonk](http://www.cs.vu.nl/~tcs/lv/notes.html)
    >
    > [Lecture notes on Lambda calculus, types and their use in proofs, by Yves Bertot](http://cel.archives-ouvertes.fr/inria-00083975) (in French)

Metatheory of the Calculus of Constructions
===========================================

-   [Metamathematical Investigations of a Calculus of Construction, Thierry Coquand](http://www.cs.chalmers.se/~coquand/meta.pdf)

Metatheory of Inductive Types
=============================

-   [Definitions and further issues regarding inductive types in Coq, Christine Paulin](http://www.lri.fr/~paulin/PUBLIS/habilitation.ps.gz) (in French)

    > In this work the definitions based on `case` (case analysis, now called `match`) and `Fixpoint` are described. Several issues eg. mutual inductive types, restrictions on elimination sort and positivity condition are studied.

-   [Guardedness condition for fixed points and cofixed points, Eduardo Giménez](ftp://ftp.ens-lyon.fr/pub/LIP/Rapports/RR/RR95/RR95-07.ps.Z)

Model Construction
==================

-   [Realizability model for the calculus of construction with universes (CC\_{omega}) with subtyping, Alexandre Miquel](http://www.pps.jussieu.fr/~miquel/publis/lics00.pdf)

    This paper contains realizability model for a system stronger than Coq but without inductive types.

-   [Set-theoretical model of the calculus of construction (CC) and discussion about the extension to CC\_{omega}, Alexandre Miquel and Benjamin Werner](http://www.pps.jussieu.fr/~miquel/publis/types02.pdf)
-   [Realizability model for the calculus of construction (CC) extended with the type of natural numbers and only one universe, Benjamin Werner](ftp://ftp.inria.fr/INRIA/LogiCal/Benjamin.Werner/these.ps.gz) (in French)
-   [Consistency of the Predicative Calculus of Cumulative Inductive Constructions (pCuIC), Sozeau and Timany](https://arxiv.org/abs/1710.03912) Set theoretical model for pCIC with universe polymorphic inductive types. also conjectures SN.

(In)dependence of Axioms
========================

-   [Groupoid model of intensional Martin-Lof type theory, Martin Hofmann and Thomas Streicher](http://www.tcs.informatik.uni-muenchen.de/~mhofmann/venedig.dvi.gz): This shows the independence of Axiom `K`, which states that there is only one proof of reflexivity statement.
-   [Excluded Middle in impredicative Set and extensionality of functions are refuted by Miquel's realizability model of CC\_{omega}, Alexandre Miquel](http://www.pps.jussieu.fr/~miquel/publis/these.pdf)
-   [Excluded Middle in Prop and Axiom of Choice in Type are inconsistent with impredicative Set, Laurent Chicli and Loïc Pottier and Carlos Simpson](http://www-sop.inria.fr/lemme/Loic.Pottier/chicli_pottier_simpson.ps)

Others
======

-   Why does Coq use inductive types and not [W-Types](WTypeInsteadOfInductiveTypes)?
-   A [summary](CoqTerminationDiscussion) of the long and informative discussion that took place on the coq-club mailing list when similar bugs were discovered in the termination checkers of both Coq and Agda.
-   Some [proof theoretic consequences](http://r6.ca/blog/20091101T231201Z.html) of impredicative Prop.

