The Coq development working groups
==================================

Organization
------------

-   As of November 2013, it has been decided to have working groups every two months (Summer excepted) in Paris, at the Sophie Germain building. They are announced 1 month and a half in advance.

    > [The next Coq Working Group](../NextCoqWG)

-   It has also been decided to have a bug session ruling on pull requests and recent bugs every two months (Summer excepted).

Latest Coq WG's, ADT meetings and Users/Developers meetings (in inverse chronological order)
--------------------------------------------------------------------------------------------

-   [December 14th-15th 2016](../CoqWG20161214)
-   [September 28th-29th 2016](../CoqWG20160928)
-   [May 31th - June 2th 2016](../CoqWG20160531)
-   [April 15th 2016](../CoqWG20160415)
-   [February 16th 2016](../CoqWG20160216)
-   [November 25th 2016](../CoqWG20151125)
-   [September 15th 2016](../CoqWG20150915)
-   [May 12th 2016](../CoqWG20150512)
-   [March 24th 2016](../CoqWG20150324)
-   [January 6th 2015](../CoqWG20150106) (about a parametricity plugin, naming of hypotheses, 8.5, ...)
-   [October 23th 2014](../CoqWG20141023) (about international collaborations, opam packaging, 8.5, ...)
-   [September 9th 2014](../CoqWG20140905) (about universes, projections, packaging, existential variables, simpl and cbn)
-   [June 6th 2014](../CoqWG20140606) (about JEdit+Coq, performance issues, tactic interfaces, ...)
-   [April 4th 2014](../CoqWG20140404) (about Guardedness, primitive integers, native compilation, ...)
-   [31 january 2014](../CoqWG20140131) (about latest proof engine API, .vi's and parallel compilation and the poll, videos to be added)
-   [21 january 2014](http://www.irisa.fr/celtique/pichardie/cuw2014/) (at POPL in San Diego, 8.5 summary, poll results, whish lists and demos)
-   [26 novembre 2013](../CRGTCoq20131126) (about asynchronous interaction, wishes for coq, full type polymorphism and fast projections, enhancing efficiency, opam for coq)
-   [9 juillet 2013](../CRGTCoq20130709) (about what's going on at this time and what is liable to be part of 8.5)
-   [14 février 2013](../CRGTCoq20130214) (about native compilation, reals, enhancing conversion, the new coqdoc)
-   [19 janvier 2012](../CRGTCoq20120119) (about the repository of user contributions, parsing patterns as terms, 8.4) (in French)
-   [6 juillet 2011](../CRGTCoq20110706) (about structured proof scripts, options applying to arguments) (in French)
-   [14 avril 2011](../CRGTCoq20110414) (about native ints, native arrays, native compilation, numbers library, containers library, ergo decision procedure, other libraries, 8.4)
-   [17 décembre 2010](../CRGTCoq20101217) (about the Numbers library) (in French)
-   [27 octobre 2010](http://coq.inria.fr/files/summary-27oct2010.txt) (ADT interfaces)
-   [20 septembre 2010](../CRGTCoq20100920)
-   [26 avril 2010](../CRGTCoq20100426) (in French)
-   [2 février 2010](../CRADT20100202)
-   [13 janvier 2010](../CRGTCoq20100113) (in French)
-   [3 novembre 2009](../CRGTCoq20091103)
-   [30 juin 2009](../CRADT20090630) (ADT tactiques) (in French)
-   [3 juillet 2009](../CRGTCoq20090704) (ADT equality and termination)
-   [24 mars 2009](../CRADT20090324) (ADT meeting on automatisation) (in French)
-   [23 mars 2009](../CRADTCommunication20090323) (discussion sur format de communication avec outils externes)
-   [23 mars 2009](../CRGTCoq20090323)
-   [16 janvier 2009](../CRGTCoq20090116)
-   [18 novembre 2008](../CRGTCoq20081118) (in French)
-   [29 octobre 2008](../CRADT20081029) (ADT Kick-off meeting) (in French)
-   [10 octobre 2008](../CRGTCoq20081010) (in French)

Past roadmap for version 8.4
============================

-   new proof engine with existential variables instantiable by tactics, and, hopefully structured proof scripts (Arnaud Spiwack)
-   native support for eta-conversion (Hugo Herbelin) and maybe axiom K
-   new comprehensive abstract library of numbers, specifying standard arithmetical operations (including power, square root, log, ...) and standard bitwise operations (shift, logical and, or, xor, ...) (Pierre Letouzey, carrying on preliminary works from Evgeny Makarov, also using material from Laurent Théry and Benjamin Grégoire)
-   new model of communication, process based instead of thread based, between Coq and CoqIDE, allowing multi-sessions and interruptability of Coq

Roadmap for version 8.5
=======================

-   improved support for pattern-matching on inductive subfamilies à la [Agda](http://appserv.cs.chalmers.se/users/ulfn/wiki/agda.php) (see also the [Equations](http://mattam.org/research/coq/equations.en.html) plugin)
-   native support for machine word arithmetic and arrays (see Benjamin Grégoire and Maxime Dénès' [native](https://gforge.inria.fr/scm/viewvc.php/branches/native/?root=coq) branch)
-   applications of the new proof engine: multi-goals tactics? deep backtracking? (Arnaud Spiwack)
-   binding the libraries of Peano numbers and rational numbers to the Numbers architecture
-   asynchronous interaction (parallel compilation of proof scripts, modular compilation of files)
-   miscellaneous tactic improvements (rewriting strategies, improved induction tactics, ...)
-   improvements of the guard condition
-   full universe polymorphism
-   optimized representation of records with native projections
-   a new infrastructure for user contributions
-   a reworking of coqdoc (François Ripault)

The future of Coq
=================

In the longer term, we plan to investigate

-   foundations of the [Calculus of Inductive Constructions](TheoryBehindCoq)
    -   how to support some form of extensional reasoning? (see the [CoqMT](http://pierre-yves.strub.nu/research/coqmt/) prototype for native support of decidably true equations over natural numbers)
    -   support for proof-irrelevance in the conversion (either by reasoning in Miquel-Barras-Bernardo's Implicit Calculus of Inductive Constructions or by following Werner's approach)
    -   support for K at the Set level
    -   induction-recursion
    -   compatibility of the logic with the univalent homotopy model
-   a library of mathematical structures (see also [discussion page](ReflectionOnStandardLibrary))
-   a typed tactic language (Yann Régis-Gianas, Lourdes del Carmen González Huesca, Guillaume Claret)
-   a cleaning phase of the tactics
-   more solid foundations for the different forms of unification used in Coq (for proving and for type inference)
-   graphical user interfaces: JEdit-based interfaces (see [Paral-ITP project](https://www.lri.fr/~wolff/projects/ANR-Paral-ITP/)), design of a Coq-GUI communication protocol, miscellaneous extensions of CoqIDE ([wish list](CoqIDEWishes))

Under consideration are

-   aspects of the [ssreflect](http://www.msr-inria.inria.fr/Projects/math-components) tactic language
-   proof generation from the [alt-ergo](http://ergo.lri.fr) theorem prover
-   kernel-embedded decision procedures (see the [CoqMT](http://pierre-yves.strub.nu/research/coqmt/) prototype for natively solving quantifier-free arithmetic)
-   full universe polymorphism

Miscellaneous
=============

-   [Raccourcis pour accélérer la compilation](../RaccourcisPourDevelopperSousEmacs) (en particulier sous Emacs).

