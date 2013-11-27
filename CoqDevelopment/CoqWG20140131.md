## page was copied from CoqDevelopment/CRGTCoq20130709
<<TableOfContents>>

Participants: Pierre Boutillier, Pierre Courtieu, Hugo Herbelin, Pierre Letouzey, Ludovic Patey,
Yann Régis-Gianas, Arnaud Spiwack, Enrico Tassi.


= Points discussed for integration to Coq 8.5 =

 * New tacticals
 * Enrico's branch with asynchronous evaluation of commands
 * Universes polymorphism
 * Optimised representation of projections
 * Caching heavy computation done at tactic time
 * New Coqdoc
 * Many deep changes in Coqide
 * Other minor points

== New-tacticals (Arnaud) ==

 * Arnaud says that current changes from Pierre-Marie's on cleaning the tactic interpretation module (tacinterp.ml) improves his tactic engine (slow down reduced from +15% to +10% by modifying interp_match)
 * Benchmarking contribs:
   * !JordanCurve is extremely slow, probably because of tauto
   * 40 contribs not compiling; reasons include:
      * ml4 to update
      * makefile problems (e.g. -j3 sometimes failing)
      * change of the semantics of refine:
        * now leaves dependent goals as explicit goals
        * use of the pattern-matching compilation algorithm makes the insertion of extra lets
 * Arnaud reminds the new features: "all:", tactical "+", "once", a native "refine", a ";" which backtracks on evars
 * Hugo says he often needs more bullet levels in proofs; the following proposals were discussed but no consensus was found:
   * stick with the current situation and force user to use brackets or lemmas when the 3rd level is reached
   * add --, ---, ----, ..., ++, +++, ... **, ***, ... (but how to hack the lexer for that, in particular in coqide?)
   * add 9 extra levels --, -+, -*, +-, ++, +*, *-, *+, **
   * make the spacing between beginning of line and "-", "+", "*" relevant and expect an inner level to be more indented than the previous one

== Asynchronous lazy evaluation of commands (Enrico) ==
 * Environment of commands (lib_stk) is now a dag instead of a list
 * "Undo" is discontinued; backtracking is done using "Backto"
 * "admit" is implemented with a fixed global constant of type False
 * There is a flag to force evaluation old-style
 * New infrastructure to manage side-effects such as "Abstract"

== Full polymorphism of universes (Matthieu) ==
 * Kernel checks universes, does not infer them any longer
 * Constants carry a list of universes
 * Pretyping and tactic engine changed to carry universe constraints
 * Constants can be declared polymorphic or not
 * No global slow down, but slow down can arrive locally when setting some constants polymorphic
 * Open problem: adapting the vm

== Ad hoc representation of projections in the code (Matthieu) ==
 * In code, projections do not any longer takes parameters of the inductive type as arguments
 * Open problem: adapting the vm

== Hack for not doing intensive computations both at proof time and qed time (Enrico) ==
 * Introduction of a new CACHEcast acting as a certified computation done in some environment and reusable without verification in any extension of this environment
 * Code revised and approved by Bruno

== Coqdoc (Yann) ==
 * No time to discuss but should be ready for 8.5

All points discussed are agreed for integration to Coq 8.5

= Miscellaneous discussions =

== Reduction of vo size with modules (Letouzey) ==
Obtained by represention "M:=N" in an algebraic way in declaremods.ml

== Introduction of a proper intropattern notation for injecting an equality on the fly (Hugo) ==
Syntax "[=pat1 ... patn]" has been approved

== Compilation of user contributions and test-suite ==
Pierre Boutillier reminds that several contribs and tests fail to compile in 8.3, 8.4 and trunk
 * Hugo acknowledges his responsibility of contribs failures for trunk (most failures related to his ongoing work on the new injection pattern; RelationAlgebra related to the management of aliases in pattern-matching)
 * Failure in 8.4 is related to "Arguments" being finally too strict and to a change in ssreflect.ml4 on June 28
 * Failure of test in 8.3 is apparently related to a change in nametab
