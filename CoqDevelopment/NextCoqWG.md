## page was copied from CoqDevelopment/CoqWG20150915
## page was renamed from CoqDevelopment/NextCoqWG
## page was copied from CoqDevelopment/CRGTCoq20131126

.. contents::

This page is used to organize the next Coq Working Group (in French GT Coq). The framadate link to decide which day it will happen is:

  https://framadate.org/gtpksTqOKNOmLpws 

Organization
============

The next Coq Working Group will take place on October 3rd and 4th at Inria Paris (2, rue Simone Iff). The room for the two days is Jacques-Louis Lions 1.

Streaming and recorded video will be available from M. Sozeau's YouTube_ channel: https://www.youtube.com/channel/UCgI_DseUNWbA9_tO88fyhoQ.

Schedule
========

October 3rd
-----------

* 9:00 Coffee

* 10:00 8.7 debrief, recent evolution of the release management (T. Zimmermann and M. Dénès)

* 10:30 8.8 roadmap (M. Dénès)

* 11:00 Discussion on the future of tactics and SSReflect (T. Zimmermann)

* 12:00 Lunch

* 13:30 Strategic Priorities in Coq Development (E. Gallego)

* 14:00 PR discussion (part I)

* 19:00 Social event (TBA)

October 4th
-----------

* 9:00 Coffee

* 10:00 Coq Communities (E. Gallego)

* 11:00 Unifall status (M. Sozeau) `attachment:Unifying Unifiers 2.pdf`_Unifying Unifiers 2.pdf`attachment:None`_

* 11:30 Plan for the standard library (T. Zimmermann)

* 12:00 Lunch

* 13:30 Fun with template-coq (M. Sozeau) `attachment:Fun with Template-Coq.pdf`_Fun with Template-Coq.pdf`attachment:None`_

* 14:00 Moving to GitHub_ issues (T. Zimmermann) Here is the link to my experiment: https://github.com/Zimmi48/bugzilla-test/

* 14:30 PR discussion (part II)

PR authors should get prepared to lead a quick discussion on each of them. Here is the list of the PRs we will try to discuss:

* `Iff as a proper connective`_ (herbelin)

* `Experiment in bindings sumbool and sumor to sum`_ (herbelin)

* `Adding a flag to support different naming modes for evar hypotheses.`_ (herbelin)

* `Scoped options`_ (ppedrot)

* `Fix #4959: Ltac match fails to match Type with Type`_ (maximedenes)

* `Reducing temporary allocations in CClosure`_ (ppedrot)

* `An intropattern-style variant for split`_ (herbelin)

* `[pp] Optimized `Pp.t` gluing.`_ (ejgallego)

* `Make some keywords into normal idents`_ (SkySkimmer_)

* `[plugins] Remove Derive plugin.`_ (ejgallego)

* `Refine test for unresolved evars to be less sensitive to unification …`_ (mattam82)

* `mli-only files outside API`_ (letouzey)

* `Deprecate Proof term.`_ (Zimmi48)

* `an attempt to document known API problems`_ (matejkosik)

* `New strategy based on open scopes for deciding which notation to use among several of them`_ (herbelin)

* `Turning warning for deprecated notations on.`_ (herbelin)

* `Removing support for 8.5 compatibility.`_ (herbelin)

* `Fix rewrite in * side conditions`_ (herbelin)

* `New beta-iota compatibility refinements`_ (herbelin)

* `Handling evars in the VM`_ (ppedrot)

* `Uniformize references to Bugzilla`_ (Zimmi48)

* `Create checklist for pull requests.`_ (Zimmi48)

* `In printing, experimenting factorizing "match" clauses with same right-hand side.`_ (herbelin)

* `Miscellaneous extensions of notations (including granting BZ5585)`_ (herbelin)

* `intros '(x,y)`_ (herbelin)

* `Add HashConsing option`_ (psteckler)

* `changed statements of Rpower_lt and Rle_power and added lemmas`_ (ybertot)

* `Restore safety mechanisms on kernel names.`_ (silene)

* `Restoring test on ident validity while browsing directory structure.`_ (herbelin)

* `Iris CI: use opam to install dependencies`_ (RalfJung_)

* `[general] Move declare to pretyping.`_ (ejgallego)

.. ############################################################################

.. _Iff as a proper connective: https://github.com/coq/coq/pull/140

.. _Experiment in bindings sumbool and sumor to sum: https://github.com/coq/coq/pull/306

.. _Adding a flag to support different naming modes for evar hypotheses.: https://github.com/coq/coq/pull/307

.. _Scoped options: https://github.com/coq/coq/pull/313

.. _`Fix #4959: Ltac match fails to match Type with Type`: https://github.com/coq/coq/pull/323

.. _Reducing temporary allocations in CClosure: https://github.com/coq/coq/pull/400

.. _An intropattern-style variant for split: https://github.com/coq/coq/pull/410

.. _[pp] Optimized `Pp.t` gluing.: https://github.com/coq/coq/pull/505

.. _Make some keywords into normal idents: https://github.com/coq/coq/pull/616

.. _[plugins] Remove Derive plugin.: https://github.com/coq/coq/pull/682

.. _Refine test for unresolved evars to be less sensitive to unification …: https://github.com/coq/coq/pull/786

.. _mli-only files outside API: https://github.com/coq/coq/pull/797

.. _Deprecate Proof term.: https://github.com/coq/coq/pull/827

.. _an attempt to document known API problems: https://github.com/coq/coq/pull/866

.. _New strategy based on open scopes for deciding which notation to use among several of them: https://github.com/coq/coq/pull/873

.. _Turning warning for deprecated notations on.: https://github.com/coq/coq/pull/884

.. _Removing support for 8.5 compatibility.: https://github.com/coq/coq/pull/887

.. _Fix rewrite in * side conditions: https://github.com/coq/coq/pull/915

.. _New beta-iota compatibility refinements: https://github.com/coq/coq/pull/922

.. _Handling evars in the VM: https://github.com/coq/coq/pull/935

.. _Uniformize references to Bugzilla: https://github.com/coq/coq/pull/960

.. _Create checklist for pull requests.: https://github.com/coq/coq/pull/975

.. _In printing, experimenting factorizing "match" clauses with same right-hand side.: https://github.com/coq/coq/pull/978

.. _Miscellaneous extensions of notations (including granting BZ5585): https://github.com/coq/coq/pull/982

.. _intros '(x,y): https://github.com/coq/coq/pull/1003

.. _Add HashConsing option: https://github.com/coq/coq/pull/1013

.. _changed statements of Rpower_lt and Rle_power and added lemmas: https://github.com/coq/coq/pull/1026

.. _Restore safety mechanisms on kernel names.: https://github.com/coq/coq/pull/1034

.. _Restoring test on ident validity while browsing directory structure.: https://github.com/coq/coq/pull/1054

.. _`Iris CI: use opam to install dependencies`: https://github.com/coq/coq/pull/1067

.. _[general] Move declare to pretyping.: https://github.com/coq/coq/pull/1091

