Second Coq Implementors Workshop, May 30 - June 3, 2016, Sophia-Antipolis
=========================================================================

This page collects useful infos for the participants to the second Coq Implementors Workshop.

The Coq Implementors Workshop is an event that brings together the core developers of Coq and people willing to understand, improve or extend the system.

Location
--------

The Implementors Workshop takes place at the Inria Center in Sophia-Antipolis (`how to reach the Inria center`_, `accommodation infos`_).

Program
-------

`attachment:schedule.pdf`_Program PDF`attachment:None`_

Talks by devs:

* Introduction (Enrico, Maxime, Matej) `attachment:intro.pdf`_Intro PDF`attachment:None`_

* STM (Enrico) `attachment:stm4hackers.pdf`_Slides PDF`attachment:None`_

* Extraction (Pierre L) `attachment:extraction.pdf`_Slides PDF`attachment:None`_ `attachment:extraction_demo.v`_extraction_demo.v`attachment:None`_ `attachment:extraction_cornercases.v`_extraction_cornercases.v`attachment:None`_ `attachment:explicit_cumul.v`_explicit_cumul.v`attachment:None`_

* Notations (Hugo) `attachment:notations.pdf`_Slides PDF`attachment:None`_

* Universes (Matthieu) `attachment:universes.pdf`_Slides PDF`attachment:None`_ (see dev/doc/univpoly.txt too)

* Ltac (Pierre-Marie) `attachment:ltac-internals.pdf`_Slides PDF`attachment:None`_

Do log what you did/learnt/implemented!
---------------------------------------

Write it here_.

Registration
------------

For organization purposes we require the participants to register (free of charge) by subscribing to the `coordination mailing list`_.

The mailing list is also the preferred channel to contact the organizers. Subscription is required in order to post.

Beach event
-----------

TBD

Quick list of dinner options
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(pick what you prefer and build your dinner group around you)

* Le Brulot (grill) or le Burlot Pasta (mediterran cuisine) https://goo.gl/maps/vidtd,

* Le Safranier (local cuisine) https://goo.gl/maps/YAg0O,

* L'Altro (italian) https://goo.gl/maps/AtQWL,

* Hong Yun (chinese) https://goo.gl/maps/sYwbH

* Sushi shop (sushi) https://goo.gl/maps/fnF3E

List of participants
--------------------

1. Yves Bertot

#. Maxime Dénès

#. Enrico Tassi

#. Pierre-Marie Pédrot

#. Matej Košík

#. Matthieu Sozeau

#. Cyprien Mangin

#. Guillaume Melquiond

#. Pierre Letouzey

#. Hugo Herbelin

#. Emilio J. Gallego Arias

#. Nicolas Magaud

#. Pierre-Évariste Dagand

#. Lionel Rieg

#. Cyril Cohen

#. Théo Zimmermann

(+) Late subscription (tradition says you pay a round at the pub...)

Bug squashing
-------------

A list of `relatively simple bugs`_, to kill the time |;-)|

Also, `bug triaging`_ is very welcome (check if a bug is still valid, add extra info, close solved bugs...).

"Little" projects
-----------------

Finish the safe string patch
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A good little project is to submit some cleanups for -safe-string as hinted in https://github.com/coq/coq/pull/134

Fix Ocaml Warnings
~~~~~~~~~~~~~~~~~~

Compiling Coq with Ocaml Warning enabled provides interesting cases to look at for cleanups. More details in Bug: https://coq.inria.fr/bugs/show_bug.cgi?id=4671

A special interesting project is to get the kernel to compile warning clean with *all warnings enabled*.

Using Merlin is highly recommended for this task.

Remove redundant typing
~~~~~~~~~~~~~~~~~~~~~~~

In 8.4 setoid_rewrite, there was code to type-check terms known to be well-typed. It would be useful to scan the codebase to look for other redundant type-checks.

Brainstorming ("harder" projects, to be considered carefully)
-------------------------------------------------------------

...

Individual Projects
-------------------

Insert here your individual plan for the week:

Emilio J. Gallego Arias
~~~~~~~~~~~~~~~~~~~~~~~

* Look at weird behavior when using new universe unification (PR#178) and universe polimorphism (happens both in trunk and v8.5)

* PR#143 merge: Follow the plan outlined at: https://sympa.inria.fr/sympa/arc/coqdev/2016-04/msg00013.html

  * Feedback from the devs? Enrico is looking at it. PMP did a preliminary eval.

  * PR#133?

* New protocol/serialization:

  * There's already an almost complete serializer at: https://github.com/ejgallego/coq-serapi

  * Plan is to reify STM and search API to build a toplevel.

* jsCoq/uDoc:

  * complete new linking support

  * Move to a thread.

  * new UI

  * vm_compute

* Plugin packing: It would be great to have proper namespacing.

Discussion on the roadmap
~~~~~~~~~~~~~~~~~~~~~~~~~

The changes we should discuss during the implementors workshop are:

* ? PR `#143`_ now `#179`_: Feedback/pp cleanup (E. J. Gallego)

    [EJGA] I should be able to get this in shape for 8.6. [EJGA] Done

* ? PR `#158`_: Fixing the "beautifier" and checking the parsing-printing reversibility (H. Herbelin)

* ? PR `#86`_: simplify sort_fields (G. Scherer)

* ? PR `#117`_: iota split into iota0+phi+psi and ML API cleanup for

    reduction functions (H. Herbelin)

* ? New warning system

* ? Flag deprecated commands: Add Setoid/Morphism/...?

* ? Error resilient mode for STM (Enrico) `#173`_

* ? Compartimentalize IDE-API specific serialization in IDE (PR#180, EJGA). Parts of this could be merged on 8.6 but some more discussion is needed.

* ? PR `#79`_ Assume Positive/Guarded/... Syntax issue on attributes, naming.

* ? New flag "Shrink Abstract" that minimizes proofs generated by the abstract

    tactical w.r.t. variables appearing in the body of the proof. Also improved Shrink Obligations.

* ? PR `#114`_: Set Debug Foo vs Set Foo Debug (H. Herbelin)

* ? PR `#67`_: Add a Show Proof query to CoqIDE

* ? PR `#166`_: Add -o option to coqc to choose the .vo file directory (Enrico)

* ? Option to add eta-unification during resolution.

  * ? Option to do resolution following the dependency order of subgoals in resolution (previously, and by default, the most dependent ones are tried first, respecting the semantics of the previous proof engine).

  * ? Option to switch to an iterative deepening search strategy.

  * ?! New implementation of typeclasses eauto based on new proof engine, could replace eauto as well: full backtracking, Hint Cut supported, iterative deepening, limited search, ... (M. Sozeau)  branch_.  To be turned into a PR, compatibility checks to do first.

* ? congruence now uses build_selector from Equality (H. Herbelin)

* ? PR `#140`_: Iff as a proper connective (H. Herbelin)

* ? PR `#150`_: LtacProf_ (Coq v8.5) (J. Gross, P. Steckler)

* ? Fix semantics of pattern-matching in Ltac (non-linear patterns, difference between hyps and goal and hyps)

    (M. Sozeau)

* Update the website (contribs and others?)

* opam ?

.. ############################################################################

.. _how to reach the Inria center: https://team.inria.fr/marelle/venue/

.. _accommodation infos: https://team.inria.fr/marelle/accomodation-information/

.. _here: https://coq.inria.fr/cocorico/CoqImplementorsWorkshop/CoqIW2016/log

.. _coordination mailing list: https://sympa.inria.fr/sympa/info/coq-coding-sprint

.. _relatively simple bugs: https://coq.inria.fr/cocorico/CoqImplementorsWorkshop/CoqIW2016/bsp

.. _bug triaging: https://coq.inria.fr/bugs/

.. _#143: https://github.com/coq/coq/pull/143

.. _#179: https://github.com/coq/coq/pull/179

.. _#158: https://github.com/coq/coq/pull/158

.. _#86: https://github.com/coq/coq/pull/86

.. _#117: [[https://github.com/coq/coq/pull/117

.. _#173: https://github.com/coq/coq/pull/173

.. _#79: https://github.com/coq/coq/pull/78

.. _#114: https://github.com/coq/coq/pull/114

.. _#67: https://github.com/coq/coq/pull/67

.. _#166: https://github.com/coq/coq/pull/166

.. _branch: https://github.com/mattam82/coq/commits/bteauto

.. _#140: https://github.com/coq/coq/pull/140

.. _#150: https://github.com/coq/coq/pull/150

