This page is for now just a copy of the 8.6 road map. Items not fitting the 8.6 time schedule should end up here.

------------------------------------------------------------------------

The purpose of this page is to summarize the different new features and modifications that are going to be part of Coq 8.6 and gather comments and contributions from developers and users.

Feel free to start discussing any of these items on this page, on coqdev or the relevant PRs, and link them here if possible, add comments to any points (creating new pages if necessary) or add your own items.

Summary of changes in trunk
===========================

These changes are in the trunk and not in 8.5, or PRs/branches based on trunk.

? indicates points which were not discussed/undecided/whose description is incomplete, or which required more discussion/in-depth explanations (at the time of the last WG).

The other items were agreed to be integrated in the next release at the last WG.

! indicates changes introducing incompatibilities w.r.t. 8.5 (not taking into account plugin interfaces)

General Implementation
----------------------

-   ! We settled on requiring ocaml &gt;= 4.01.0 for 8.6.

    > There is a known issue with 4.01.0 and camlp4 where Coq compilation fails, this case is now detected early in the configure script.
    >
    > > \[EJGA\] Note that this will likely break Debian packages, as they ship a patched Ocaml 4.01.0 thus configure will fail.

-   Switch to using ocamlfind for finding compilers (new dependency)
-   Module name conflicts with the ocaml compiler. While waiting for an upstream solution, we decided to rename files in our codebase whose names are conflicting with the compiler-libs library of the ocaml compiler.
-   Bytes/String PR by E. Arias. WIP, proposal is to split it in smaller

    > chunks and do renamings.
    >
    > > \[EGJA\] A few minor parts should be able to go into 8.6 IMHO. Personally, I would just postpone the rest until 4.02 is the default compiler to avoid shipping more compatibility burden.

-   1.  Kosik implemented the move to Context.Rel/Named for manipulating named and de Bruijn contexts using an algebraic datatype distinguishing declarations and definitions and modules with a similar interface. This will break plugins but the move to the new representation is really straightforward. An advantage of the new representation is that users are less likely to forget that there are potentially local definitions and not only declarations in these contexts.
-   ? PR [\#145](https://github.com/coq/coq/pull/145) Coqlib cleanup (E. J. Gallego)

    > \[EJGA\] No way this can go in 8.6 as is, however some small bits could be split.

-   ? PR [\#143](https://github.com/coq/coq/pull/143) now [\#179](https://github.com/coq/coq/pull/179): Feedback/pp cleanup (E. J. Gallego)

    > \[EJGA\] I should be able to get this in shape for 8.6.

-   ? PR [\#158](https://github.com/coq/coq/pull/158): Fixing the "beautifier" and checking the parsing-printing reversibility (H. Herbelin)
-   ? PR [\#86](https://github.com/coq/coq/pull/86): simplify sort\_fields (G. Sherer)
-   ? PR [\#117](%5B%5Bhttps://github.com/coq/coq/pull/117): iota split into iota0+phi+psi and ML API cleanup for

    > reduction functions (H. Herbelin)

-   ? Flag deprecated commands: Add Setoid/Morphism/...?
-   Windows SDK built from sources using Michael's script (Enrico).
-   ? Error resilient mode for STM (Enrico) [\#173](https://github.com/coq/coq/pull/173)

Kernel
------

-   New universe cycle detection algorithm by J.H. Jourdan. Much faster on typical graphs, implements a state-of-the-art incremental cycle detection algorithm by Bender, M. A., Fineman, J. T., Gilbert, S., & Tarjan, R. E.
-   Now accepting unit props in mutual definitions (B. Barras, 045b695) Any change due to this? kernel/checker
-   ? Inductive-inductive, inductive-recursive, recursive-recursive definitions Experimental [branch](https://github.com/mattam82/coq/tree/IR), probably not for 8.6, theoretical issues: guardedness and positivity checking (M. Sozeau)

Elaboration, Gallina
--------------------

-   Ltac implementation refactoring, "Ltac as a plugin" (P.M. Pédrot). Uniform handling of generic arguments.

    > Incompatibilities:
    >
    > -   ?! at the syntax level, when using constr:, ltac:
    >
    >     > grammar entries in Ltac code, parentheses become mandatory (e.g.: constr:((x, y)) for the pair of terms x y). ipattern\_list:(\[\] \[\]). Uniformity vs "non-uglyness".
    >
    > -   At the level of ML: camlp4 quotations of ltac are no longer
    >
    > supported (&lt;:ltac &lt; auto with \*&gt;&gt;)

    Some tactics and vernac entries were moved to TACTIC EXTEND/VERNAC EXTEND thanks to the refactoring.

-   ML: API cleanup/changes for maps of existential variables and

    > universes. pretyping/evd.ml was moved to engine/evd.ml and a new programming interface engine/sigma.ml is provided to statically ensure the state is used monotonously (using GADTs). namegen, termops, logic\_monad, proofview\_monad are also in engine.

-   Evar resolvability flag and naming are more efficiently handled now,

    > reducing memory usage in presence of large numbers of evars. MS: in 8.5pl1

-   ? Evar naming:

    > Unnamed evars generated identifiers are not stable and shouldn't be used to refer to evars (MS: can they?)
    >
    > There are two kinds of names printed the same way? the generated ones and the user-specified ones? We have another occurrence of the "declare at first use" phenomenon. ?\[e\] declares and evar and uses it. Check ?\[n\]+?n differs from Check ?n+?\[n\]. Should we use ?\[n\] several times, what happens currently? Proposition by PMP to use tactics in terms \[let t := ltac:(evar sometype) in u\] ? instantiate(n:=t) is now broken.

-   Unification:
    -   ?! Unification of Let-In bodies without unifying their types (in

        > evarconv heuristic of first-order unifications) (9cc95f5)

    -   Other improvements? (H. Herbelin, M. Sozeau)

-   Keyed Unification:

    > ?! The strategy is now to do a first pass without conversion and a pass with full conversion of arguments if this fails, when selecting subterms. Keyed Unification is still restricted to \[unify\_to\_subterm\], used by the standard rewrite only (M. Sozeau).

-   Typeclasses:
    -   ? Option to add eta-unification during resolution.
    -   ? Option to do resolution following the dependency order of subgoals in resolution (previously, and by default, the most dependent ones are tried first, respecting the semantics of the previous proof engine).
    -   ? Option to switch to an iterative deepening search strategy.
    -   ?! New implementation of typeclasses eauto based on new proof engine, could replace eauto as well: full backtracking, Hint Cut supported, iterative deepening, limited search, ... (M. Sozeau) [branch](https://github.com/mattam82/coq/commits/bteauto). To be turned into a PR, compatibility checks to do first.
-   ? PR [\#72](https://github.com/coq/coq/pull/72) Quote coercions
-   PR [\#142](https://github.com/coq/coq/pull/142) Patterns in abstractions (D. de Rauglaudre)

Vernacular
----------

-   ?! Forbiding "Require" inside modules and module types (Import is fine)
-   Print Assumptions now prints axioms through inductive definitions (M. Lasson)
-   Deprecate non-qualified Requires ? Emitting a warning may be fine.
-   ? PR [\#79](https://github.com/coq/coq/pull/78) Assume Positive/Guarded/... Syntax issue on attributes, naming.
-   ? PR [\#85](https://github.com/coq/coq/pull/85) Printing in cbv/cbn
-   Search has an option to print only the list of names found (C.

    > Pit-Claudel). Maybe a generalized API is in order (PR by G. Malecha)?

-   ? New flag "Shrink Abstract" that minimizes proofs generated by the abstract

    > tactical w.r.t. variables appearing in the body of the proof. Also improved Shrink Obligations.

-   Universe binders @{} are now accepted by Program and Instance commands.

    > Locations of universe binders can be taken into account in error messages.

-   Support for (@foo) args in patterns, when @foo has no arguments (H. Herbelin).
-   @, abbreviations and notations are now interpreted in patterns like in terms (H. Herbelin).
-   PR [\#156](https://github.com/coq/coq/pull/156) Coq-level numeral printers, now a CEP: [CEP/Numeral Notation](Numeral Notation) (D. de Rauglaudre)
-   PR [\#64](https://github.com/coq/coq/pull/64): Add a Print Ltacs vernacular (C. Pit-Claudel)
-   ? PR [\#113](https://github.com/coq/coq/pull/113): Add the "not a keyword" modifier to notations (J.P. Delaix?)
-   ? PR [\#114](https://github.com/coq/coq/pull/114): Set Debug Foo vs Set Foo Debug (H. Herbelin)
-   ? PR [\#162](https://github.com/coq/coq/pull/162): Search Interface Revisions (G. Malecha)

Tactics
-------

-   ?! double induction, which is deprecated (but not warned as such),

    > was improved by H. Herbelin, introducing an incompatibility (it succeeds more often). Compatibility flag?

-   ! invariants on (a, b, ...), intropattern for generalized cartesian products

    > Stop autocompleting with ? (H. Herbelin) The error message could be improved?

-   ?! inversion/injection as (\[intropattern\]): changed? Compatibility is not

    > guaranteed here (H. Herbelin).

-   ! "Set Regular Subst Tactic", subst has a more

    > canonical strategy and can succeed more often.

-   ? congruence now uses build\_selector from Equality (H. Herbelin)
-   ? Clearing on the fly, contradiction (H. Herbelin)
-   ? refine and conv\_pbs (E. Tassi, M. Dénès)
-   ? PR [\#74](https://github.com/coq/coq/pull/74): Range selector (C. Mangin)
-   ?! PR [\#100](https://github.com/coq/coq/pull/100): fresh accepts more things (P. Courtieu) fresh will succeed more often=incompatibilies. Are these incompatibilites difficult to fix?
-   ? PR [\#136](https://github.com/coq/coq/pull/136): An adaptation of ssreflect's =&gt; to Coq introduction pattern model (H. Herbelin)
-   ? PR [\#140](https://github.com/coq/coq/pull/140): Iff as a proper connective (H. Herbelin)
-   ? PR [\#157](https://github.com/coq/coq/pull/157): pat%constr (H. Herbelin)
-   ? PR [\#146](https://github.com/coq/coq/pull/146): Ssreflect pattern matching facilities (E. Tassi)
-   ? PR [\#150](https://github.com/coq/coq/pull/150): LtacProf (Coq v8.5) (J. Gross, P. Steckler)
-   ? PR [\#164](https://github.com/coq/coq/pull/164): A few tactics for 8.6 (H. Herbelin)
-   ?! Properly handle Hint Extern with conclusions of the form

    > \_ -&gt; \_" in typeclass resolution (M. Sozeau) This breaks compatibility, these Hint Externs were not found before as the pattern was matched on the conclusion of the goal, removing arrows.

-   ?! Improvements to generalized rewriting: faster rewriting with leibniz equality, new strategies, heterogeneous relations... Still WIP (M. Sozeau)

    > [branch](https://github.com/mattam82/coq/commits/genreweqwip)

-   ?! Tactics and library for transfer/application of lemmas modulo rewritings (T. Zimmermann)

    > <https://github.com/mattam82/coq/pull/1>, linked to above point.

-   ? Fix semantics of pattern-matching in Ltac (non-linear patterns, difference between hyps and goal and hyps)

    > (M. Sozeau)

Standard Library
----------------

-   ! Changes in QArith/Qcanon,Qcabs by P. Letouzey with minor incompatibilities

    > (which?)

-   Introduction of MMaps
-   ?! cons and Some have their type argument set maximally implicit.
-   function\_scope is now declared in Notations and bound to Funclass.

    > Scopes can be bound to classes again. (J. Gross)

-   Definition of eta in VectorSpec.v
-   ListSet lemmas in Stdlib (S. Hinderer)
-   PR [\#135](https://github.com/coq/coq/pull/135): Export Nat in NPeano.v (J. Gross)

CoqIDE
------

-   Modernization of the preferences (P.M. Pédrot).
-   ? PR [\#67](https://github.com/coq/coq/pull/67): Add a Show Proof query to CoqIDE

Tools
-----

-   ? PR [\#166](https://github.com/coq/coq/pull/166): Add -o option to coqc to choose the .vo file directory (Enrico)

------------------------------------------------------------------------

FIXME
-----

-   In implicit\_quantifiers.ml, remove dead code and ad-hoc handling of { \_ : \_ | \_ }
-   Remove register\_loaded\_library with same dirpath
-   Suspicious warning from invalid identifiers coming from the filesystem

