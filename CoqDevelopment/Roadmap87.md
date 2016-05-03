= Summary of changes =

These changes are in the trunk and not in 8.5pl1.

? indicates points which were not discussed/undecided/whose description
is incomplete, or which required more discussion/in-depth explanations.
The other items were agreed to be integrated in the next release at the last WG.
! indicates changes introducing incompatibilities w.r.t. 8.5 (not taking into
  account plugin interfaces)

== General Implementation ==

- ! We settled on requiring ocaml >= 4.01.0 for 8.6.
  There is a known issue with 4.01.0 and camlp4 where
  Coq compilation fails, this case is now detected early
  in the configure script.
  
- Switch to using ocamlfind for finding compilers (new dependency)
  
- Module name conflicts with the ocaml compiler.
  While waiting for an upstream solution, we decided
  to rename files in our codebase whose names are conflicting 
  with the compiler-libs library of the ocaml compiler.

- Bytes/String PR by E. Arias. WIP, proposal is to split
  it in smaller chunks and do renamings.

- M. Kosik implemented the move to Context.Rel/Named for 
  manipulating named and de Bruijn contexts using an algebraic 
  datatype distinguishing declarations and definitions
  and modules with a similar interface. This will break plugins but the
  move to the new representation is really straightforward.
  An advantage of the new representation is that users are less
  likely to forget that there are potentially local definitions
  and not only declarations in these contexts.

- ? PR # 158: 
  Fixing the "beautifier" and checking the parsing-printing reversibility (H. Herbelin)
- ? PR #86: simplify sort_fields (G. Sherer)
- ? PR #117: iota split into iota0+phi+psi and ML API cleanup for
  reduction functions (H. Herbelin)

== Kernel ==

- New universe cycle detection algorithm by J.H. Jourdan.
  Much faster on typical graphs, implements a state-of-the-art
  incremental cycle detection algorithm by Bender, M. A.,
  Fineman, J. T., Gilbert, S., & Tarjan, R. E.
      
- Now accepting unit props in mutual definitions (B. Barras, 045b695)
  Any change due to this? kernel/checker

== Elaboration, Gallina ==

- Ltac implementation refactoring, "Ltac as a plugin" (P.M. Pédrot).
  Uniform handling of generic arguments.

  Incompatibilities:
  * ?! at the syntax level, when using constr:, ltac:
	grammar entries in Ltac code, parentheses become mandatory
	(e.g.: constr:((x, y)) for the pair of terms x y).
	ipattern_list:([] []). Uniformity vs "non-uglyness".
  * At the level of ML: camlp4 quotations of ltac are no longer
  supported (<:ltac < auto with *>>)
  
  Some tactics and vernac entries were moved to 
  TACTIC EXTEND/VERNAC EXTEND thanks to the refactoring.

- ML: API cleanup/changes for maps of existential variables and
  universes. pretyping/evd.ml was moved to engine/evd.ml and a new
  programming interface engine/sigma.ml is provided to statically ensure
  the state is used monotonously (using GADTs). namegen, termops,
  logic_monad, proofview_monad are also in engine.

- Evar resolvability flag and naming are more efficiently handled now,
  reducing memory usage in presence of large numbers of evars.

- ? Evar naming:
  Unnamed evars generated identifiers are not stable and shouldn't be 
  used to refer to evars (MS: can they?)
  
  There are two kinds of names printed the same way? the generated ones
  and the user-specified ones?
  
  We have another occurrence of the "declare at first use" phenomenon.
  ?[e] declares and evar and uses it.
  Check ?[n]+?n differs from Check ?n+?[n].
  Should we use ?[n] several times, what happens currently?
  Proposition by PMP to use tactics in terms [let t := ltac:(evar sometype) in u] ?
  instantiate(n:=t) is now broken.
  
- Unification:

  * ? Unification of Let-In bodies without unifying their types (in
	evarconv heuristic of first-order unifications) (9cc95f5) 
  * Other improvements? (H. Herbelin, M. Sozeau)	

- Keyed Unification:

  ?! The strategy is now to do a first pass without conversion and
  a pass with full conversion of arguments if this fails, when
  selecting subterms. Keyed Unification is still restricted to
  [unify_to_subterm], used by the standard rewrite only (M. Sozeau).

- Typeclasses:

  - Option to add eta-unification during resolution.
  - Option to do resolution following the dependency order of subgoals
  in resolution (previously, and by default, the most dependent ones
  are tried first, respecting the semantics of the previous proof
  engine).
  - Option to switch to an iterative deepening search strategy.

== Vernacular ==

- ?! Forbiding "Require" inside modules and module types (Import is fine)

- Print Assumptions now prints axioms through inductive definitions (M. Lasson)

- ? PR #79 Assume Positive/Guarded/... Syntax issue on attributes, naming.
  https://github.com/coq/coq/pull/79

- ? PR #85 Printing in cbv/cbn

- Search has an option to print only the list of names found (C.
  Pit-Claudel). Maybe a generalized API is in order (PR by G. Malecha)?

- New flag "Shrink Abstract" that minimalizes proofs generated by the abstract
  tactical w.r.t. variables appearing in the body of the proof. Also
  improved Shrink Obligations.
 
- Universe binders @{} are now accepted by Program and Instance commands.
  Locations of universe binders can be taken into account in error messages.

- Support for (@foo) args in patterns, when @foo has no arguments (H. Herbelin).

- @, abbreviations and notations are now interpreted in patterns like in terms (H. Herbelin).
    
- D. de Rauglaudre: Coq-level numeral printers.

  Lots of questions and suggestions at the WG: 
  Many propositions emerge: watching efficiency, using Z directly
  instead of Z', supporting decimal or fractional numbers, ...

- PR #64: Add a Print Ltacs vernacular (C. Pit-Claudel)
- ? PR #113: Add the "not a keyword" modifier to notations (J.P. Delaix)
- ? PR #114: Set Debug Foo vs Set Foo Debug (H. Herbelin)
- ? PR #162: Search Interface Revisions (G. Malecha)

== Tactics == 

- ?! double induction, which is deprecated (but not warned as such),
  was improved by H. Herbelin, introducing an incompatibility (it succeeds
  more often). Compatibility flag?
- ?! invariants on (a, b, ...), intropattern for generalized cartesian products
  Stop autocompleting with ? (H. Herbelin)
  The error message could be improved?
- ?! inversion/injection as ([intropattern]): changed? Compatibility is not
  guaranteed here (H. Herbelin).
- ! "Set Regular Subst Tactic", subst has a more
  canonical strategy and can succeed more often.
- ?! congruence now uses build_selector from Equality (H. Herbelin)
- ? Clearing on the fly, contradiction (H. Herbelin)
- ? refine and conv_pbs
- ? PR #74: Range selector (C. Mangin)
- ?! PR #100: fresh accepts more things (P. Courtieu)
- ? PR #136: An adaptation of ssreflect's => to Coq introduction pattern model (H. Herbelin)
- ? PR #140: Iff as a proper connective (H. Herbelin)
- ? PR #157: pat%constr (H. Herbelin)
- ? PR #146: Ssreflect pattern matching facilities (E. Tassi)
- ? PR #150: LtacProf (Coq v8.5)
- ? PR #164: A few tactics for 8.6 (H. Herbelin)

== Standard Library ==

- ! Changes in QArith/Qcanon,Qcabs by P. Letouzey with minor incompatibilities
  (which?)
- Introduction of MMaps
- ?! cons and Some have their type argument set maximally implicit.
- function_scope is now declared in Notations and bound to Funclass.
  Scopes can be bound to classes again. (J. Gross)
- Definition of eta in VectorSpec.v
- ListSet lemmas in Stdlib (S. Hinderer)
- PR #135: Export Nat in NPeano.v (J. Gross) 

== CoqIDE ==

- Modernization of the preferences (P.M. Pédrot).
- ? PR #67: Add a Show Proof query to CoqIDE
  https://github.com/coq/coq/pull/67
  
== PRs: ==

- ? PR #72 Quote coercions
  https://github.com/coq/coq/pull/72

== Patches that were not backported: ==


6cf80dd * coq_makefile installs native files
f539df5 * Revert "TCs: Properly handle Hint Extern with conclusions of the form _ -> _" Not supposed to be part of 8.5beta.

* Distinguishing between bound modules (Top#X) and submodules (Top.X)
  (as in module debug printers).
