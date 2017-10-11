Second Coq Implementors Workshop, May 30 - June 3, 2016, Sophia-Antipolis
=========================================================================

This page collects useful infos for the participants to the second Coq Implementors Workshop.

The Coq Implementors Workshop is an event that brings together the core developers of Coq and people willing to understand, improve or extend the system.

Location
--------

The Implementors Workshop takes place at the Inria Center in Sophia-Antipolis ([how to reach the Inria center](https://team.inria.fr/marelle/venue/), [accommodation infos](https://team.inria.fr/marelle/accomodation-information/)).

Program
-------

attachment:schedule.pdf\_Program PDF\`<attachment:None%60_>

Talks by devs:

-   Introduction (Enrico, Maxime, Matej) attachment:intro.pdf\_Intro PDF\`<attachment:None%60_>
-   STM (Enrico) attachment:stm4hackers.pdf\_Slides PDF\`<attachment:None%60_>
-   Extraction (Pierre L) attachment:extraction.pdf\_Slides PDF\`<attachment:None%60_> attachment:extraction\_demo.v\_extraction\_demo.v\`<attachment:None%60_> attachment:extraction\_cornercases.v\_extraction\_cornercases.v\`<attachment:None%60_> attachment:explicit\_cumul.v\_explicit\_cumul.v\`<attachment:None%60_>
-   Notations (Hugo) attachment:notations.pdf\_Slides PDF\`<attachment:None%60_>
-   Universes (Matthieu) attachment:universes.pdf\_Slides PDF\`<attachment:None%60_> (see dev/doc/univpoly.txt too)
-   Ltac (Pierre-Marie) attachment:ltac-internals.pdf\_Slides PDF\`<attachment:None%60_>

Do log what you did/learnt/implemented!
---------------------------------------

Write it [here](https://coq.inria.fr/cocorico/CoqImplementorsWorkshop/CoqIW2016/log).

Registration
------------

For organization purposes we require the participants to register (free of charge) by subscribing to the [coordination mailing list](https://sympa.inria.fr/sympa/info/coq-coding-sprint).

The mailing list is also the preferred channel to contact the organizers. Subscription is required in order to post.

Beach event
-----------

TBD

### Quick list of dinner options

(pick what you prefer and build your dinner group around you)

-   Le Brulot (grill) or le Burlot Pasta (mediterran cuisine) <https://goo.gl/maps/vidtd>,
-   Le Safranier (local cuisine) <https://goo.gl/maps/YAg0O>,
-   L'Altro (italian) <https://goo.gl/maps/AtQWL>,
-   Hong Yun (chinese) <https://goo.gl/maps/sYwbH>
-   Sushi shop (sushi) <https://goo.gl/maps/fnF3E>

List of participants
--------------------

1.  Yves Bertot
2.  Maxime Dénès
3.  Enrico Tassi
4.  Pierre-Marie Pédrot
5.  Matej Košík
6.  Matthieu Sozeau
7.  Cyprien Mangin
8.  Guillaume Melquiond
9.  Pierre Letouzey
10. Hugo Herbelin
11. Emilio J. Gallego Arias
12. Nicolas Magaud
13. Pierre-Évariste Dagand
14. Lionel Rieg
15. Cyril Cohen
16. Théo Zimmermann

(+) Late subscription (tradition says you pay a round at the pub...)

Bug squashing
-------------

A list of [relatively simple bugs](https://coq.inria.fr/cocorico/CoqImplementorsWorkshop/CoqIW2016/bsp), to kill the time |;-)|

Also, [bug triaging](https://coq.inria.fr/bugs/) is very welcome (check if a bug is still valid, add extra info, close solved bugs...).

"Little" projects
-----------------

### Finish the safe string patch

A good little project is to submit some cleanups for -safe-string as hinted in <https://github.com/coq/coq/pull/134>

### Fix Ocaml Warnings

Compiling Coq with Ocaml Warning enabled provides interesting cases to look at for cleanups. More details in Bug: <https://coq.inria.fr/bugs/show_bug.cgi?id=4671>

A special interesting project is to get the kernel to compile warning clean with *all warnings enabled*.

Using Merlin is highly recommended for this task.

### Remove redundant typing

In 8.4 setoid\_rewrite, there was code to type-check terms known to be well-typed. It would be useful to scan the codebase to look for other redundant type-checks.

Brainstorming ("harder" projects, to be considered carefully)
-------------------------------------------------------------

...

Individual Projects
-------------------

Insert here your individual plan for the week:

### Emilio J. Gallego Arias

-   Look at weird behavior when using new universe unification (PR\#178) and universe polimorphism (happens both in trunk and v8.5)
-   PR\#143 merge: Follow the plan outlined at: <https://sympa.inria.fr/sympa/arc/coqdev/2016-04/msg00013.html>
    -   Feedback from the devs? Enrico is looking at it. PMP did a preliminary eval.
    -   PR\#133?
-   New protocol/serialization:
    -   There's already an almost complete serializer at: <https://github.com/ejgallego/coq-serapi>
    -   Plan is to reify STM and search API to build a toplevel.
-   jsCoq/uDoc:
    -   complete new linking support
    -   Move to a thread.
    -   new UI
    -   vm\_compute
-   Plugin packing: It would be great to have proper namespacing.

### Discussion on the roadmap

The changes we should discuss during the implementors workshop are:

-   ? PR [\#143](https://github.com/coq/coq/pull/143) now [\#179](https://github.com/coq/coq/pull/179): Feedback/pp cleanup (E. J. Gallego)

    > \[EJGA\] I should be able to get this in shape for 8.6. \[EJGA\] Done

-   ? PR [\#158](https://github.com/coq/coq/pull/158): Fixing the "beautifier" and checking the parsing-printing reversibility (H. Herbelin)
-   ? PR [\#86](https://github.com/coq/coq/pull/86): simplify sort\_fields (G. Scherer)
-   ? PR [\#117](%5B%5Bhttps://github.com/coq/coq/pull/117): iota split into iota0+phi+psi and ML API cleanup for

    > reduction functions (H. Herbelin)

-   ? New warning system
-   ? Flag deprecated commands: Add Setoid/Morphism/...?
-   ? Error resilient mode for STM (Enrico) [\#173](https://github.com/coq/coq/pull/173)
-   ? Compartimentalize IDE-API specific serialization in IDE (PR\#180, EJGA). Parts of this could be merged on 8.6 but some more discussion is needed.
-   ? PR [\#79](https://github.com/coq/coq/pull/78) Assume Positive/Guarded/... Syntax issue on attributes, naming.
-   ? New flag "Shrink Abstract" that minimizes proofs generated by the abstract

    > tactical w.r.t. variables appearing in the body of the proof. Also improved Shrink Obligations.

-   ? PR [\#114](https://github.com/coq/coq/pull/114): Set Debug Foo vs Set Foo Debug (H. Herbelin)
-   ? PR [\#67](https://github.com/coq/coq/pull/67): Add a Show Proof query to CoqIDE
-   ? PR [\#166](https://github.com/coq/coq/pull/166): Add -o option to coqc to choose the .vo file directory (Enrico)
-   ? Option to add eta-unification during resolution.
    -   ? Option to do resolution following the dependency order of subgoals in resolution (previously, and by default, the most dependent ones are tried first, respecting the semantics of the previous proof engine).
    -   ? Option to switch to an iterative deepening search strategy.
    -   ?! New implementation of typeclasses eauto based on new proof engine, could replace eauto as well: full backtracking, Hint Cut supported, iterative deepening, limited search, ... (M. Sozeau) [branch](https://github.com/mattam82/coq/commits/bteauto). To be turned into a PR, compatibility checks to do first.
-   ? congruence now uses build\_selector from Equality (H. Herbelin)
-   ? PR [\#140](https://github.com/coq/coq/pull/140): Iff as a proper connective (H. Herbelin)
-   ? PR [\#150](https://github.com/coq/coq/pull/150): LtacProf\_ (Coq v8.5) (J. Gross, P. Steckler)
-   ? Fix semantics of pattern-matching in Ltac (non-linear patterns, difference between hyps and goal and hyps)

    > (M. Sozeau)

-   Update the website (contribs and others?)
-   opam ?

