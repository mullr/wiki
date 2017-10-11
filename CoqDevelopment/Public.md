.. contents::

The Coq development working groups
==================================

Organization
------------

* As of November 2013, it has been decided to have working groups every two months (Summer excepted) in Paris, at the Sophie Germain building. They are announced 1 month and a half in advance.

    `The next Coq Working Group`_

* It has also been decided to have a bug session ruling on pull requests and recent bugs every two months (Summer excepted).

Latest Coq WG's, ADT meetings and Users/Developers meetings (in inverse chronological order)
--------------------------------------------------------------------------------------------

* `December 14th-15th 2016`_

* `September 28th-29th 2016`_

* `May 31th - June 2th 2016`_

* `April 15th 2016`_

* `February 16th 2016`_

* `November 25th 2016`_

* `September 15th 2016`_

* `May 12th 2016`_

* `March 24th 2016`_

* `January 6th 2015`_ (about a parametricity plugin, naming of hypotheses, 8.5, ...)

* `October 23th 2014`_ (about international collaborations, opam packaging, 8.5, ...)

* `September 9th 2014`_ (about universes, projections, packaging, existential variables, simpl and cbn)

* `June 6th 2014`_ (about JEdit+Coq, performance issues, tactic interfaces, ...)

* `April 4th 2014`_ (about Guardedness, primitive integers, native compilation, ...)

* `31 january 2014`_ (about latest proof engine API, .vi's and parallel compilation and the poll, videos to be added)

* `21 january 2014`_ (at POPL in San Diego, 8.5 summary, poll results, whish lists and demos)

* `26 novembre 2013`_ (about asynchronous interaction, wishes for coq, full type polymorphism and fast projections, enhancing efficiency, opam for coq)

* `9 juillet 2013`_ (about what's going on at this time and what is liable to be part of 8.5)

* `14 février 2013`_ (about native compilation, reals, enhancing conversion, the new coqdoc)

* `19 janvier 2012`_ (about the repository of user contributions, parsing patterns as terms, 8.4) (in French)

* `6 juillet 2011`_ (about structured proof scripts, options applying to arguments) (in French)

* `14 avril 2011`_ (about native ints, native arrays, native compilation, numbers library, containers library, ergo decision procedure, other libraries, 8.4)

* `17 décembre 2010`_ (about the Numbers library) (in French)

* `27 octobre 2010`_ (ADT interfaces)

* `20 septembre 2010`_

* `26 avril 2010`_ (in French)

* `2 février 2010`_

* `13 janvier 2010`_ (in French)

* `3 novembre 2009`_

* `30 juin 2009`_ (ADT tactiques) (in French)

* `3 juillet 2009`_ (ADT equality and termination)

* `24 mars 2009`_ (ADT meeting on automatisation) (in French)

* `23 mars 2009`_ (discussion sur format de communication avec outils externes)

* `23 mars 2009 <../CRGTCoq20090323>`__ 

* `16 janvier 2009`_ 

* `18 novembre 2008`_ (in French)

* `29 octobre 2008`_ (ADT Kick-off meeting) (in French)

* `10 octobre 2008`_ (in French)

Past roadmap for version 8.4
============================

* new proof engine with existential variables instantiable by tactics, and, hopefully structured proof scripts (Arnaud Spiwack)

* native support for eta-conversion (Hugo Herbelin) and maybe axiom K

* new comprehensive abstract library of numbers, specifying standard arithmetical operations (including power, square root, log, ...) and standard bitwise operations (shift, logical and, or, xor, ...) (Pierre Letouzey, carrying on preliminary works from Evgeny Makarov, also using material from Laurent Théry and Benjamin Grégoire)

* new model of communication, process based instead of thread based, between Coq and CoqIDE, allowing multi-sessions and interruptability of Coq

Roadmap for version 8.5
=======================

* improved support for pattern-matching on inductive subfamilies à la Agda_ (see also the Equations_ plugin)

* native support for machine word arithmetic and arrays (see Benjamin Grégoire and Maxime Dénès' native_ branch)

* applications of the new proof engine: multi-goals tactics? deep backtracking? (Arnaud Spiwack)

* binding the libraries of Peano numbers and rational numbers to the Numbers architecture

* asynchronous interaction (parallel compilation of proof scripts, modular compilation of files)

* miscellaneous tactic improvements (rewriting strategies, improved induction tactics, ...)

* improvements of the guard condition

* full universe polymorphism

* optimized representation of records with native projections

* a new infrastructure for user contributions

* a reworking of coqdoc (François Ripault)

The future of Coq
=================

In the longer term, we plan to investigate

* foundations of the `Calculus of Inductive Constructions`_

  * how to support some form of extensional reasoning? (see the CoqMT_ prototype for native support of decidably true equations over natural numbers)

  * support for proof-irrelevance in the conversion (either by reasoning in Miquel-Barras-Bernardo's Implicit Calculus of Inductive Constructions or by following Werner's approach)

  * support for K at the Set level

  * induction-recursion

  * compatibility of the logic with the univalent homotopy model

* a library of mathematical structures (see also `discussion page`_)

* a typed tactic language (Yann Régis-Gianas, Lourdes del Carmen González Huesca, Guillaume Claret)

* a cleaning phase of the tactics

* more solid foundations for the different forms of unification used in Coq (for proving and for type inference)

* graphical user interfaces: JEdit-based interfaces (see `Paral-ITP project`_), design of a Coq-GUI communication protocol, miscellaneous extensions of CoqIDE (`wish list`_)

Under consideration are

* aspects of the ssreflect_ tactic language

* proof generation from the alt-ergo_ theorem prover

* kernel-embedded decision procedures (see the CoqMT_ prototype for natively solving quantifier-free arithmetic)

* full universe polymorphism

Miscellaneous
=============

* `Raccourcis pour accélérer la compilation`_ (en particulier sous Emacs).

.. ############################################################################

.. _The next Coq Working Group: ../NextCoqWG

.. _December 14th-15th 2016: ../CoqWG20161214

.. _September 28th-29th 2016: ../CoqWG20160928

.. _May 31th - June 2th 2016: ../CoqWG20160531

.. _April 15th 2016: ../CoqWG20160415

.. _February 16th 2016: ../CoqWG20160216

.. _November 25th 2016: ../CoqWG20151125

.. _September 15th 2016: ../CoqWG20150915

.. _May 12th 2016: ../CoqWG20150512

.. _March 24th 2016: ../CoqWG20150324

.. _January 6th 2015: ../CoqWG20150106

.. _October 23th 2014: ../CoqWG20141023

.. _September 9th 2014: ../CoqWG20140905

.. _June 6th 2014: ../CoqWG20140606

.. _April 4th 2014: ../CoqWG20140404

.. _31 january 2014: ../CoqWG20140131

.. _21 january 2014: http://www.irisa.fr/celtique/pichardie/cuw2014/

.. _26 novembre 2013: ../CRGTCoq20131126

.. _9 juillet 2013: ../CRGTCoq20130709

.. _14 février 2013: ../CRGTCoq20130214

.. _19 janvier 2012: ../CRGTCoq20120119

.. _6 juillet 2011: ../CRGTCoq20110706

.. _14 avril 2011: ../CRGTCoq20110414

.. _17 décembre 2010: ../CRGTCoq20101217

.. _27 octobre 2010: http://coq.inria.fr/files/summary-27oct2010.txt

.. _20 septembre 2010: ../CRGTCoq20100920

.. _26 avril 2010: ../CRGTCoq20100426

.. _2 février 2010: ../CRADT20100202

.. _13 janvier 2010: ../CRGTCoq20100113

.. _3 novembre 2009: ../CRGTCoq20091103

.. _30 juin 2009: ../CRADT20090630

.. _3 juillet 2009: ../CRGTCoq20090704

.. _24 mars 2009: ../CRADT20090324

.. _23 mars 2009: ../CRADTCommunication20090323

.. _16 janvier 2009: ../CRGTCoq20090116

.. _18 novembre 2008: ../CRGTCoq20081118

.. _29 octobre 2008: ../CRADT20081029

.. _10 octobre 2008: ../CRGTCoq20081010

.. _Agda: http://appserv.cs.chalmers.se/users/ulfn/wiki/agda.php

.. _Equations: http://mattam.org/research/coq/equations.en.html

.. _native: https://gforge.inria.fr/scm/viewvc.php/branches/native/?root=coq

.. _Calculus of Inductive Constructions: TheoryBehindCoq

.. _CoqMT: http://pierre-yves.strub.nu/research/coqmt/

.. _discussion page: ReflectionOnStandardLibrary

.. _Paral-ITP project: https://www.lri.fr/~wolff/projects/ANR-Paral-ITP/

.. _wish list: CoqIDEWishes

.. _ssreflect: http://www.msr-inria.inria.fr/Projects/math-components

.. _alt-ergo: http://ergo.lri.fr

.. _Raccourcis pour accélérer la compilation: ../RaccourcisPourDevelopperSousEmacs

