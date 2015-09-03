#title Coq in the classroom

This page collects material related to Coq teaching or using Coq and related interfaces as a support for teaching.

<<TableOfContents>>

== Teaching Coq ==

=== Short courses for working researchers ===

From 1993, the [[http://www.cs.chalmers.se/Cs/Research/Logic/Types|TYPES]] summer school had courses on Coq as part of its curriculum. In particular, Yves Bertot's course in 2006 led to a tutorial named   [[[http://cel.archives-ouvertes.fr/inria-00001173/en|Coq in a hurry]]. Notice that other proof assistants related to the TYPES European working group were taught too (in the 2007 edition, this included Isabelle, Matita and Mizar). Most attendees were PhD students but these summer schools were opened to senior people too.

Between 1999 and 2002, a few formations were organised by the [[http://logical.inria.fr|LogiCal]] team (formerly Coq team). It was generally three-day-long intensive formations hosting senior people from industry and academy. The material is now rather old as the last such session was using Coq V7.2.

In 2006, Pierre Castéran proposed a 3-hours introduction to Coq at the [[jfla.inria.fr/2006|JFLA]] conference. It was based on his formalisation of ordinals and entitled [[http://www.labri.fr/perso/casteran/Cantor/JFLA2006.pdf|Le Coq au Pauillac et aux omégas]].

In 2006, Adam Chlipala and George Necula taught [[http://adam.chlipala.net/itp/|Interactive Computer Theorem Proving]] at Berkeley university, focusing on Coq and Twelf.

The University of Pennsylvania Provers Group ran a 2008 POPL tutorial, [[http://www.cis.upenn.edu/~plclub/popl08-tutorial/|Using Proof Assistants for Programming Language Research]].  Extensively documented Coq code, illustrating type soundness for simply typed lambda calculus and system F-sub, is available from the website.

An Asian-Pacific summer school was held in 2009, 2010, [[kyhcs.ustcsz.edu.cn/fmschool-2011|2011]], 2012 and 2013 (part of material [[http://pauillac.inria.fr/~levy/courses/tsinghua/13coq/|here]]).

A school on [[http://www.di.ens.fr/~zappa/teaching/coq/ecole10/|Modelling and verifying algorithms in Coq]] was held in 2010 in Paris.

A spring school on the [[http://www-sop.inria.fr/manifestations/MapSpringSchool/program.html|Formalization of Mathematics]] was held in Nice-Sophia-Antipolis in 2012.

A short [[http://specfun.inria.fr/mahboubi/cirm14.html|course on the formalization of mathematics]] at the initial school of the [[https://ihp2014.pps.univ-paris-diderot.fr/doku.php|IHP 2014]] special trimester.

A winter school on [[https://team.inria.fr/marelle/en/coq-winter-school-14|Software verification and computer proof|]] in Nice in 2014.

A spring school on [[http://yann.regis-gianas.org/coqepit/index.html|Mechanizing proofs of programs]] was held in 2015 in Fréjus (France).

A short [[http://coq.inria.fr/coq-itp-2015|tutorial]] was given in Nanjing as part of ITP 2015.

Coq is regularly taught as part of the [[https://www.cs.uoregon.edu/research/summerschool/|Oregon Programming Languages Summer School]].

== Using Coq as a teaching tool ==

=== Coq as a teaching tool in computer science ===

A former experience of using Coq as a teaching tool and not just per is by Jean Goubault-Larrecq at ENSTA in 1999 (a course on software safety).  The [[http://www.lsv.ens-cachan.fr/~goubault/cours.html#svl|Course notes]] (in French) are available on the teacher's page. 

Another experiment has been made by David Delahaye, Mathieu Jaume and Virgile Prevosto to teach semantics of programming languages and software safety at the [[http://deptinfo.cnam.fr/master/spip.php?rubrique15|master-level]] of CNAM, a university for adults.  The paper [[#Ref1|Ref1]] (in French) describes this experience.

A similar master-level class on formal methods and specification languages has been taught by Catherine Dubois using Coq. This was at [[http://www.iie.cnam.fr|ENSIIE]], a computer science engineer school attached to the CNAM. Groups were composed of 15 to 20 students.

In 2004, Pierre Castéran and Richard Moot used Coq in the context of a [[http://esslli2004.loria.fr/giveabs.php?14|course]] on ''Proof automation for type-logical grammars''] at ESSLLI. Their Coq material is avalaible [[http://www.labri.fr/perso/casteran/esslli2004/index.html|online]].

In 2007, Yves Bertot used Coq as a support for an intensive 4-day class ''Semantics in Calculus of Constructions'' at Chalmers University. The [[http://groups.google.com/group/chalmers-cs-semantics-in-coq|course notes]] are freely available.

Amy Felty used Coq as a tool for a class on ''Principles of Formal Software Development'' [[http://www.site.uottawa.ca/~afelty/csi5110|Fall 2007]] at Ottawa University.

Benjamin Pierce used Coq as a tool for teaching ''[[http://www.cis.upenn.edu/~bcpierce/sf/|Software Foundations]]'' at the University of Pennsylvania (notes used also at [[http://web.cecs.pdx.edu/~apt/cs578/|Portland State Portland]], Maryland, Lehigh, Iowa, USCD, Purdue, ...).

Andrew W. Appel used Coq in a class on ''Automated Theorem Proving'' [[http://www.cs.princeton.edu/courses/archive/fall07/cos595|Fall 2007]] at Princeton University. This moved to a ''Programming Languages'' class using the ''[[http://www.cis.upenn.edu/~bcpierce/sf/|Software Foundations]]'' material.

Paweł Urzyczyn used Coq as a tool for teaching ''Theoretical Foundations of Theorem Proving Systems'' (Winter 2006-07) at Warsaw University.

Greg Morrisett (Harvard): I've been teaching an undergraduate PL course using Coq. We've done a big chunk of Winskell's book, and parts of Pierce's book as well. The course website is [[http://www.eecs.harvard.edu/cs152/|here]]. 

Yves Bertot (INRIA): For teaching purpose, I have a project on the thorough description of a very small imperative programming language. The development contains two variants of operational semantics (small-step --also called SOS in my development-- or big-step --also called natural semantics), denotational semantics, Hoare logic, Dijkstra's weakest precondition calculus, and abstract interpretation; I intended to add a formally verified compiler. The programming language I work on is minimal, as it only contains constructs for assignment, while-loops and sequences and each aspect is covered in a few hundred lines of Coq code.

=== Coq as a teaching tool in mathematics ===

For teaching Logic, Pierre Castéran used Coq for long. His material (in French) is publicly [[http://www.labri.fr/perso/casteran/FM/Logique/|available]].

In 2003, Frédérique Guilhot formalised geometry in a way close to the way it is teached in French high schools. A dedicated extension [[GeoView]] of [[PCoq]] was designed in the same time.  It seems that the conclusion was that much work was necessary before submitting such tools to high school pupils. The paper [[#Ref2|Ref2]] (in French) describes this experience and the corresponding [[http://coq.inria.fr/contribs/Angles.html|formalisation of geometry]] is available as a Coq user contribution which can also serve as the base axiomatic for Julien Narboux' [[GeoProof]].

From 2004, Loïc Pottier and André Hirschowitz started using Coq to for teaching mathematics for undergraduate students at the University of Nice. They set up a [[http://pcmath165.unice.fr/wcw/spikini/?wiki=AccueilWikiCoqWeb|Wiki Coq Web]] that collects course notes and exercices, all of them being formally checkable via a Coq web server. The Coq web server, CoqWeb, can also be used via the [[http://wims.unice.fr/wims/en_home.html|Wims]] collection of exercices.

In 2005, Cezary Kaliszyk developed [[http://www.cs.ru.nl/~cek/proofweb/ProofWeb|ProofWeb]], a web server that allows to use online Coq and other proof assistants. This service has been used as a tool for various classes in computer science and mathematics at the University of Nijmegen (see paper [[#Ref3|Ref3]]).

In 2006 and 2007, Aaron Stump used Coq as a tool to teach Logic and Discrete Math at the undergraduate level. One of the objective was to learn students what a proof is. The [[http://cl.cse.wustl.edu./classes/cse240-spring06|2006]] and [[http://cl.cse.wustl.edu./classes/cse240-spring07|2007]] homepages of the class are available online.

In 2007, Jakub Sakowicz and Jacek Chrząszcz developed [[http://www.mimuw.edu.pl/~chrzaszc/Papuq|Papuq]], an extension of CoqIde designed for teaching logic and set theory at Warsaw University (see paper [[#Ref5|Ref5]]).

In 2007, Sungwoo Park started to teach a [[http://www.postech.ac.kr/~gla/cs433/|logic class]] using Coq for the assignments at [[http://www.postech.ac.kr|Postech]].

In 2008, Anne Mulhern taught an informal semester long seminar [[http://www.cs.wisc.edu/~mulhern/coqtalks/2008.01/index.html|CoqTalks]] on using Coq to write formal proofs and using the Penn PL club metatheory library to prove language properties.

Coq is used in a [[http://mathinfo.unistra.fr/offre-de-formation/ue/?spec=9&sem=17&ue=524|master class on geometry]] at the university of Strasbourg.

== Other resources ==

A [[http://pauillac.inria.fr/pipermail/coq-club/2007/002885.html|thread]] on using Coq for teaching on the Coq-Club mailing list.

The TYPES [[http://www.lsv.ens-cachan.fr/rdp07/pate.html|Proof Assistants and Types in Education]] (PATE 2007) workshop.

The [[http://www.activemath.org/workshops/MathUI/07/proceedings/Narboux-Geoproof-MathUI07.html|GeoProof]] user interface for formal proofs in geometry.

== Bibliography ==

Ref1: <<Anchor(Ref1)>> D. Delahaye, M. Jaume, V. Prevosto, [[http://focal.inria.fr/site/images/stories/articles/delahayetsi05.pdf|Coq, un outil pour l'enseignement]], Technique et Science Informatiques, vol. 24(9), Langages applicatifs, pp&nbsp;1139-1160, Hermes Science, 2005.

Ref2: <<Anchor(Ref2)>> F. Guilhot, [[http://www-sop.inria.fr/lemme/Frederique.Guilhot/tsi.pdf|Formalisation en Coq et visualisation d'un cours de géométrie pour le lycée]], Technique et Science Informatiques, vol. 24(9), Langages applicatifs, pp&nbsp;1113-1138, Hermes Science, 2005.

Ref3: <<Anchor(Ref3)>> C. Kaliszyk, F. Wiedijk, [[http://www.cs.ru.nl/~cek/proofweb/pate.pdf|Teaching logic using a state-of-the-art proof assistant]], Proceedings of PATE'07, H. Geuvers and P. Courtieu editors. Elsevier, 2007.

Ref4: <<Anchor(Ref4)>> J. Narboux, [[http://www4.in.tum.de/~narboux/slides/bristol2005.pdf|Toward the use of a proof assistant to teach mathematics]], Proceedings of ICTMT7, 2005.

Ref5: <<Anchor(Ref5)>> J. Sakowicz, J. Chrząszcz, [[http://www.mimuw.edu.pl/~chrzaszc/papers/Sakowicz-Chrzaszcz_Papuq_a_Coq_assistant.pdf|Papuq, a Coq assistant]], Proceedings of PATE'07, H. Geuvers and P. Courtieu editors. Elsevier, pp 79-96, 2007.
