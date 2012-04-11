#language en

== Introduction ==

 * Nice introduction to the type theory 

  [[http://www.cs.kent.ac.uk/people/staff/sjt/TTFP/|Book by Simon Thompson]]

 * Lectures about Coq

  http://www.europeindia.org/cd09/lectures/lect04/index.htm

  [[http://www.cs.vu.nl/~tcs/lv/notes.html|Lecture notes by Femke van Raamsdonk]]

  [[http://cel.archives-ouvertes.fr/inria-00083975|Lecture notes on Lambda calculus, types and their use in proofs, by Yves Bertot]] (in French)

== Metatheory of the Calculus of Constructions ==

 * [[http://www.cs.chalmers.se/~coquand/meta.pdf|Metamathematical Investigations of a Calculus of Construction, Thierry Coquand]] 

== Metatheory of Inductive Types ==

 * [[http://www.lri.fr/~paulin/habilitation.ps.gz|Definitions and further issues regarding inductive types in Coq, Christine Paulin]] (in French)

  In this work the definitions based on {{{case}}} (case analysis, now called {{{match}}}) and {{{Fixpoint}}} are described. Several issues eg. mutual inductive types, restrictions on elimination sort and positivity condition are studied.

 * [[ftp://ftp.ens-lyon.fr/pub/LIP/Rapports/RR/RR95/RR95-07.ps.Z|Guardedness condition for fixed points and cofixed points, Eduardo Giménez]]

== Model Construction ==

 * [[http://www.pps.jussieu.fr/~miquel/publis/lics00.pdf|Realizability model for the calculus of construction with universes (CC_{omega}) with subtyping, Alexandre Miquel]]

 This paper contains realizability model for a system stronger than Coq but without inductive types.

 * [[http://www.pps.jussieu.fr/~miquel/publis/types02.pdf|Set-theoretical model of the calculus of construction (CC) and discussion about the extension to CC_{omega}, Alexandre Miquel and Benjamin Werner]]

 * [[ftp://ftp.inria.fr/INRIA/LogiCal/Benjamin.Werner/these.ps.gz|Realizability model for the calculus of construction (CC) extended with the type of natural numbers and only one universe, Benjamin Werner]] (in French)

== (In)dependence of Axioms ==

 * [[http://www.tcs.informatik.uni-muenchen.de/~mhofmann/venedig.dvi.gz|Groupoid model of intensional Martin-Lof type theory, Martin Hofmann and Thomas Streicher]]: This shows the independence of Axiom {{{K}}}, which states that there is only one proof of reflexivity statement.

 * [[http://www.pps.jussieu.fr/~miquel/publis/these.pdf|Excluded Middle in impredicative Set and extensionality of functions are refuted by Miquel's realizability model of CC_{omega}, Alexandre Miquel]]
 
 * [[http://www-sop.inria.fr/lemme/Loic.Pottier/chicli_pottier_simpson.ps|Excluded Middle in Prop and Axiom of Choice in Type are inconsistent with impredicative Set, Laurent Chicli and Loïc Pottier and Carlos Simpson]]

== Others ==

 * Why does Coq use inductive types and not [[WTypeInsteadOfInductiveTypes|W-Types]]?
