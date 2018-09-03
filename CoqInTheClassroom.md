This page collects material related to Coq teaching or using Coq and related interfaces as a support for teaching.

Teaching Coq
============

Short courses for working researchers
-------------------------------------

From 1993, the [TYPES](http://www.cs.chalmers.se/Cs/Research/Logic/Types) summer school had courses on Coq as part of its curriculum. In particular, Yves Bertot's course in 2006 led to a tutorial named [Coq in a hurry](%5Bhttp://cel.archives-ouvertes.fr/inria-00001173/en). Notice that other proof assistants related to the TYPES European working group were taught too (in the 2007 edition, this included Isabelle, Matita and Mizar). Most attendees were PhD students but these summer schools were opened to senior people too.

Between 1999 and 2002, a few formations were organised by the [LogiCal](http://logical.inria.fr) team (formerly Coq team). It was generally three-day-long intensive formations hosting senior people from industry and academy. The material is now rather old as the last such session was using Coq V7.2.

In 2006, Pierre Castéran proposed a 3-hours introduction to Coq at the [JFLA](jfla.inria.fr/2006) conference. It was based on his formalisation of ordinals and entitled [Le Coq au Pauillac et aux omégas](http://www.labri.fr/perso/casteran/Cantor/JFLA2006.pdf).

In 2006, Adam Chlipala and George Necula taught [Interactive Computer Theorem Proving](http://adam.chlipala.net/itp/) at Berkeley university, focusing on Coq and Twelf.

The University of Pennsylvania Provers Group ran a 2008 POPL tutorial, [Using Proof Assistants for Programming Language Research](http://www.cis.upenn.edu/~plclub/popl08-tutorial/). Extensively documented Coq code, illustrating type soundness for simply typed lambda calculus and system F-sub, is available from the website.

An Asian-Pacific summer school was held in 2009, 2010, [2011](kyhcs.ustcsz.edu.cn/fmschool-2011), 2012 and 2013 (part of material [here](http://pauillac.inria.fr/~levy/courses/tsinghua/13coq/)).

A school on [Modelling and verifying algorithms in Coq](http://www.di.ens.fr/~zappa/teaching/coq/ecole10/) was held in 2010 in Paris.

A spring school on the [Formalization of Mathematics](http://www-sop.inria.fr/manifestations/MapSpringSchool/program.html) was held in Nice-Sophia-Antipolis in 2012.

A short [course on the formalization of mathematics](http://specfun.inria.fr/mahboubi/cirm14.html) at the initial school of the [IHP 2014](https://ihp2014.pps.univ-paris-diderot.fr/doku.php) special trimester.

A winter school on [Software verification and computer proof](https://team.inria.fr/marelle/en/coq-winter-school-14) in Nice in 2014.

A spring school on [Mechanizing proofs of programs](http://yann.regis-gianas.org/coqepit/index.html) was held in 2015 in Fréjus (France).

A short [tutorial](http://coq.inria.fr/coq-itp-2015) was given in Nanjing as part of ITP 2015.

Coq is regularly taught as part of the [Oregon Programming Languages Summer School](https://www.cs.uoregon.edu/research/summerschool/).

A number of Coq-based short courses on verified software systems were included in the [DeepSpec Summer School](https://deepspec.org/event/dsss17/index.html) in July, 2017.

Using Coq as a teaching tool
============================

Coq as a teaching tool in computer science
------------------------------------------

A former experience of using Coq as a teaching tool and not just per is by Jean Goubault-Larrecq at ENSTA in 1999 (a course on software safety). The [Course notes](http://groups.google.com/group/chalmers-cs-semantics-in-coq) (in French) are available on the teacher's page.

Another experiment has been made by David Delahaye, Mathieu Jaume and Virgile Prevosto to teach semantics of programming languages and software safety at the [master-level](http://deptinfo.cnam.fr/master/spip.php?rubrique15) of CNAM, a university for adults. The paper [Ref1](#Ref1) (in French) describes this experience.

A similar master-level class on formal methods and specification languages has been taught by Catherine Dubois using Coq. This was at [ENSIIE](http://www.iie.cnam.fr), a computer science engineer school attached to the CNAM. Groups were composed of 15 to 20 students.

In 2004, Pierre Castéran and Richard Moot used Coq in the context of a [course](http://esslli2004.loria.fr/giveabs.php?14) on *Proof automation for type-logical grammars*\] at ESSLLI. Their Coq material is avalaible [online](http://www.labri.fr/perso/casteran/esslli2004/index.html).

In 2007, Yves Bertot used Coq as a support for an intensive 4-day class *Semantics in Calculus of Constructions* at Chalmers University. The [course notes](http://groups.google.com/group/chalmers-cs-semantics-in-coq) are freely available.

Amy Felty used Coq as a tool for a class on *Principles of Formal Software Development* [Fall 2007](http://www.site.uottawa.ca/~afelty/csi5110) at Ottawa University.

Benjamin Pierce, Stephanie Weirich, and Steve Zdancewic use Coq as a tool for teaching [Software Foundations](http://www.cis.upenn.edu/~bcpierce/sf/) at the University of Pennsylvania (notes used also at [Portland State Portland](http://web.cecs.pdx.edu/~apt/cs578/), Maryland, Lehigh, Iowa, USCD, Purdue, [Aarhus](http://www.cs.au.dk/~spitters/fun18.html), ...).

Andrew W. Appel used Coq in a class on *Automated Theorem Proving* [Fall 2007](http://www.cs.princeton.edu/courses/archive/fall07/cos595) at Princeton University. This moved to a *Programming Languages* class using the [Software Foundations](http://www.cis.upenn.edu/~bcpierce/sf/) material.

Paweł Urzyczyn used Coq as a tool for teaching *Theoretical Foundations of Theorem Proving Systems* (Winter 2006-07) at Warsaw University.

Greg Morrisett (Harvard): I've been teaching an undergraduate PL course using Coq. We've done a big chunk of Winskell's book, and parts of Pierce's book as well. The course website is [here](http://www.eecs.harvard.edu/cs152/).

Yves Bertot (INRIA): For teaching purpose, I have a project on the thorough description of a very small imperative programming language. The development contains two variants of operational semantics (small-step --also called SOS in my development-- or big-step --also called natural semantics), denotational semantics, Hoare logic, Dijkstra's weakest precondition calculus, and abstract interpretation; I intended to add a formally verified compiler. The programming language I work on is minimal, as it only contains constructs for assignment, while-loops and sequences and each aspect is covered in a few hundred lines of Coq code.

Coq as a teaching tool in mathematics
-------------------------------------

For teaching Logic, Pierre Castéran used Coq for long. His material (in French) is publicly [available](http://www.labri.fr/perso/casteran/FM/Logique/).

In 2003, Frédérique Guilhot formalised geometry in a way close to the way it is teached in French high schools. A dedicated extension [GeoView](GeoView) of [PCoq](PCoq) was designed in the same time. It seems that the conclusion was that much work was necessary before submitting such tools to high school pupils. The paper [Ref2](#Ref2) (in French) describes this experience and the corresponding [formalisation of geometry](http://coq.inria.fr/contribs/Angles.html) is available as a Coq user contribution which can also serve as the base axiomatic for Julien Narboux' [GeoProof](GeoProof).

From 2004, Loïc Pottier and André Hirschowitz started using Coq to for teaching mathematics for undergraduate students at the University of Nice. They set up a [Wiki Coq Web](http://pcmath165.unice.fr/wcw/spikini/?wiki=AccueilWikiCoqWeb) that collects course notes and exercices, all of them being formally checkable via a Coq web server. The Coq web server, [CoqWeb](CoqWeb), can also be used via the [Wims](http://wims.unice.fr/wims/en_home.html) collection of exercices.

In 2005, Cezary Kaliszyk developed [ProofWeb](http://www.cs.ru.nl/~cek/proofweb/ProofWeb), a web server that allows to use online Coq and other proof assistants. This service has been used as a tool for various classes in computer science and mathematics at the University of Nijmegen (see paper [Ref3](#Ref3)).

In 2006 and 2007, Aaron Stump used Coq as a tool to teach Logic and Discrete Math at the undergraduate level. One of the objective was to learn students what a proof is. The [2006](http://cl.cse.wustl.edu./classes/cse240-spring06) and [2007](http://cl.cse.wustl.edu./classes/cse240-spring07) homepages of the class are available online.

In 2007, Jakub Sakowicz and Jacek Chrząszcz developed [Papuq](http://www.mimuw.edu.pl/~chrzaszc/Papuq), an extension of [CoqIde](CoqIde) designed for teaching logic and set theory at Warsaw University (see paper [Ref5](#Ref5)).

In 2007, Sungwoo Park started to teach a [logic class](http://www.postech.ac.kr/~gla/cs433/) using Coq for the assignments at [Postech](http://www.postech.ac.kr).

In 2008, Anne Mulhern taught an informal semester long seminar [CoqTalks](http://www.cs.wisc.edu/~mulhern/coqtalks/2008.01/index.html) on using Coq to write formal proofs and using the Penn PL club metatheory library to prove language properties.

Coq is used in a [master class on geometry](http://mathinfo.unistra.fr/offre-de-formation/ue/?spec=9&sem=17&ue=524) at the university of Strasbourg.

Other resources
===============

A [thread](http://pauillac.inria.fr/pipermail/coq-club/2007/002885.html) on using Coq for teaching on the Coq-Club mailing list.

The TYPES [Proof Assistants and Types in Education](http://www.lsv.ens-cachan.fr/rdp07/pate.html) (PATE 2007) workshop.

The [GeoProof](http://www.activemath.org/workshops/MathUI/07/proceedings/Narboux-Geoproof-MathUI07.html) user interface for formal proofs in geometry.

Bibliography
============

<a name="Ref1">Ref1</a>: D. Delahaye, M. Jaume, V. Prevosto, [Coq, un outil pour l'enseignement](http://focal.inria.fr/site/images/stories/articles/delahayetsi05.pdf), Technique et Science Informatiques, vol. 24(9), Langages applicatifs, pp 1139-1160, Hermes Science, 2005.

<a name="Ref2">Ref2</a>: F. Guilhot, [Formalisation en Coq et visualisation d'un cours de géométrie pour le lycée](http://www-sop.inria.fr/lemme/Frederique.Guilhot/tsi.pdf), Technique et Science Informatiques, vol. 24(9), Langages applicatifs, pp 1113-1138, Hermes Science, 2005.

<a name="Ref3">Ref3</a>: Kaliszyk, F. Wiedijk, [Teaching logic using a state-of-the-art proof assistant](http://www.cs.ru.nl/~cek/proofweb/pate.pdf), Proceedings of PATE'07, H. Geuvers and P. Courtieu editors. Elsevier, 2007.

<a name="Ref4">Ref4</a>: Narboux, [Toward the use of a proof assistant to teach mathematics](http://www4.in.tum.de/~narboux/slides/bristol2005.pdf), Proceedings of ICTMT7, 2005.

<a name="Ref5">Ref5</a>: Sakowicz, J. Chrząszcz, [Papuq, a Coq assistant](http://www.mimuw.edu.pl/~chrzaszc/papers/Sakowicz-Chrzaszcz_Papuq_a_Coq_assistant.pdf), Proceedings of PATE'07, H. Geuvers and P. Courtieu editors. Elsevier, pp 79-96, 2007.
