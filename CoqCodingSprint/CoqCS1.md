First Coq Coding Sprint, June 22-25 2015 Sophia-Antipolis
=========================================================

This page collects useful infos for the participants to the first Coq Coding Sprint

What is a Coding Sprint?
------------------------

A coding sprint is an event that brings together the core developers of Coq and people willing to understand, improve or extend the system.

Location
--------

The coding sprint will take place at the Inria Center in Sophia-Antipolis ([how to reach the Inria center](https://team.inria.fr/marelle/venue/), [accommodation infos](https://team.inria.fr/marelle/accomodation-information/)).

Program
-------

[Tentative schedule](files/cs1/schedule-coqcs1.pdf), [Slides](files/cs1/intro-talk.pdf) for the introduction

Do log what you did/learnt/implemented!
---------------------------------------

[Write it here](CoqCS1-log).

Registration
------------

For organization purposes we require the participants to register (free of charge) by following these two steps:

1.  subscribe to the [coordination mailing list](https://sympa.inria.fr/sympa/info/coq-coding-sprint)
2.  post a [message with subject REGISTER](coq-coding-sprint@inria.fr). In case you already have an project in mind, please include a short description of it in the registration email.

The mailing list is also the preferred channel to contact the organizers. Subscription is required in order to post.

Beach on Wednesday 24
---------------------

Meeting point 17:00 in front of Inria or 18:00 at the beach.

[Itinerary](files/cs1/itinerary-beach-coqcs1.pdf)

Meeting point 20:00 if you want to join the group for dinner.

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
2.  Pierre Boutillier
3.  Maxime Dénès
4.  Hugo Herbelin
5.  Matthieu Sozeau
6.  Enrico Tassi
7.  Bruno Barras
8.  Benjamin Gregoire
9.  Pierre Letouzey
10. Jaap Boender
11. Arthur Charguéraud
12. Nicolas Magaud
13. Gabriel Scherer
14. Jason Gross
15. Assia Mahboubi
16. Arnaud Spiwack
17. Pierre-Marie Pédrot
18. Laurence Rideau
19. Jacques-Henri Jourdan
20. Reynald Affeldt
21. Guilhem Jaber
22. Jasmin Blanchette
23. Cyril Cohen
24. Nico Lehmann
25. Emilio J. Gallego Arias
26. Thomas Sibut-Pinote
27. Amin Timany
28. Thibault Gauthier
29. Théo Zimmermann (+)
30. Lionel Rieg (+)
31. Cyprien Mangin (+)
32. Abhishek Anand (+)
33. Matej Kosik (+)
34. Anders Mörtberg (+)
35. Alexander Faithfull (+)
36. Jesper Bengtson (+)
37. Guillaume Cano (+)
38. Frederic Chyzak
39. Qingguo Xu

(+) Late subscription (tradition says you pay a round at the pub...)

Bug squashing
-------------

A list of [relatively simple bugs](CoqCS1-bsp), to kill the time :smile:

Also, [bug triaging](https://coq.inria.fr/bugs/) is very welcome (check if a bug is still valid, add extra info, close solved bugs...).

"Little" projects
-----------------

-   coqide:
    1.  Make the goal window display all goals, not only the focused one. Consider using a notebook widget to let the user look at any goal by changing page. Think about creative uses for the notebook page labels. Requires GTK skills.
    2.  Add a "quick compile" button, as in coqc -quick. The STM can also "dump" the current state as a .vio file, but there is no protocol message for requiring such service.
    3.  Make coqide silently kill coqtop and save the current buffer position when too many tabs are opened and restart coqtop when the user re-opens an old tab. (see [4074](http://coq.inria.fr/bug/4074))
    4.  Remove use of threads in the coqide back end: use CPS+Unix.select to code a cooperative threads library (in the LWT style), see tentative patch [by PMP](https://github.com/ppedrot/coq/commits/thread-free).
-   tooling:
    1.  coqobjinfo (like ocamlobjinfo) reusing some code from votour/coqchk to get infos about a .vo or .vio file: modules/lemmas included, axioms, ... This is turn could be used to build other tools to: extract the set of assumptions associated with a final theorems, locate the places of uses of a given definition, (in the future) optimize the recompilation process by knowing which parts need to be recompiled following a change in one given definition.
    2.  make it possible to hide all support files (e.g. .glob files) to make directory listing and file selection/auto-completion operation simpler. (comment: very much in the spirit of what .coq-native/ does for native\_compute files). One could also say that a .vo file is a directory, that the segments in which the .vo file are organized are files with standard names in these directories and that all extra metadata are again files in such directory. E.g. foo.vo/{lib,opaque,glob}. This is also compatible with Makefiles, since it is possible to target a single components.
-   tactics
    1.  CUPS like syntax for selecting a set of goals for tactic application. I.e. generalize "all:" to "1,2-5:", see also [1805](http://coq.inria.fr/bug/1805).
-   ci.inria.fr
    1.  Prepare a job (to be copied, a sort of template) that one can easily use to compile a personal Coq branch (take from github) and a list of other git repos (like some entries from the coq-contribs).
-   Win
    1.  test the [Win64 installer](https://ci.inria.fr/coq/job/coq-win64-8.5/label=coq-win7-64/lastSuccessfulBuild/artifact/dev/nsis/) on a Win64 machine
-   OSX
    1.  try to make the procedure of building the .app reproducible (an SDK, or a scipt)
    2.  see if an opam root (compressed, to be unpacked in `/opt/coq$V/opam/` on the fly) can be integrated in the .app bundle and have the bundled CoqIDE use that coqtop
-   opam
    1.  test [coq:shell](https://github.com/coq/opam-coq-shell) especially under OSX

Brainstorming ("harder" projects, to be considered carefully)
-------------------------------------------------------------

-   improving Search:
    1.  finding theorems that fit a pattern thanks to type classes, canonical structures, or modulo iota-reduction, or delta steps of a set of registered constants (see also [\#3904](http://coq.inria.fr/bug/3904))
    2.  Invent a "search" that works for tactics: search the patterns used in the tactic, or use patterns given by the user. ([related work](http://staff.computing.dundee.ac.uk/katya/ML4PG/))
    3.  Sort search result according to a priority heuristic to display more relevant results first.
-   tools:
    1.  coq\_makefile: use a real template engine to generate the Makefile, instead of playing with OCaml strings; alternatively make coq\_makefile just generate a Makefile.conf snippet with the user setting and copy in the current directory a standard Makefile that uses conditionals at run time (not at generation time as it is done now). In both cases the Makefile should be easier to read from the sources of coq\_makefile, now it is really hard to do so.
-   type inference, unification:
    1.  Print canonical structures inference failures in error messages. E.g. "typing error... + during type inference this CS inference failed"
    2.  Add proper categories to unification variables (goals, typeclass constraints, implicits that should be solved...)
    3.  Reimplement and merge typeclasses eauto, auto and eauto using the new tactic engine.
    4.  Let the user tell TI when the expected type should be propagated down via an Argument directive. E.g. with `Arguments cons {A} | x xs` type inference should unify A (probably an implicit) with the A in the expected type before processing x and xs. If the expected type is `list Q` and `x` is a `nat`, then `N->Q` coercion could be inserted. If we wait, we may infer that the list is `list nat` and there is not coercion to `list Q`.
-   bench system:
    1.  plug decent graphs into ci.inria.fr/coq
    2.  fix `coqc -quick -time` [Bug 3934](http://coq.inria.fr/bug/3934)
-   developers manual:
    1.  Enrich the document started by Wojciech Jedynak <https://github.com/wjzz/Coq-Developers-Manual/releases/download/0.1/devman.pdf>, [github](https://github.com/wjzz/Coq-Developers-Manual).
    2.  Write down the policies (a real document): how to submit code to Coq, how to submit a contrib, how opam packages should be written...

-   kernel
    1.  Make it possible for the kernel to accept an a priori unsound definition (not guarded, not universe consistent, not strictly positive) when the definition is prefixed by some command. This must be taken account by `Print Assumptions` with assumptions like `foo is total`.
    2.  Harden the kernel interface: move from arrays to an abstract type at least.
-   tactics:
    1.  decouple the prelude from the tactics
    2.  Coding the tactics of the `logic.ml` file in the new proof engine. These were the primitive tactics of the old proof engine and are currently implemented using a compatibility layer which, in particular, makes the `Info` command unaware of their semantics.
    3.  Implement a "debug" trace for tactics. The `Info` command gives a trace of the tactics which were effectively applied. In order to debug scripts, it may be useful to also have a trace of all the tactics which were attempted.
    4.  Port [LtacProf](http://www.ps.uni-saarland.de/~ttebbi/ltacprof/) to Coq 8.5, possibly hooking into the `Info` infrastructure.
-   declarative proof mode
    1.  More robust implementation of the declarative proof mode. The declarative mode, because it's older, doesn't really take advantage of the disciplined focus API of the new proof engine and re-implements its features in a fragile way. To move forward, the code must be cleaned up and use the modern API.
-   Notation:
    1.  control notation/implicits/coercions display on a sub term
-   stdlib:
    1.  uniform names/notations see [Bug 4110](http://coq.inria.fr/bug/4110)
    2.  document the axiom used in each file/file-group
-   Evar instantiation failure explanation: given an evar defined in some context, and given a term with which the evar fails to unify, report to the user the list of variables that occur in the term but that do not belong to the context in which the evar was defined.
-   Computation of the dependency graph

    > The goal is to build an OCaml data structure representing the global dependency graph (given a set of compiled files):
    >
    > -   each node is labelled with the fully qualified path of a definition; the node carries a flag indicating whether the proof is transparent (i.e. Defined vs Qed).
    > -   the node associated with "foo" has two sets of outgoing edges: one for describing the definitions that are required for typechecking the type of "foo", and one for describing the definitions that are required for typechecking the body of "foo" (body of the definition, or the proof term).

-   A lightweight abstraction mechanism

    > Currently, the only way to have a real abstraction layer is to use module signatures, which are very heavy in practice, as they require copy-pasting statements. It would be nice if the same result could be achieve through a simple top-level command, "Abstract foo bar." which would ensure that all the definitions mentioned have their definition made really opaque, as if the definitions/proofs where enclosed in a module signature.

-   Environments: a powerful replacement for sections

    > The idea is to introduce environments, which solve the problem of closing/reopening a section with similar variables and implicit types, and which generalizes the notion of notation scope and hint database. An "environment" consists of a set of declaration, among: context variables declaration, implicit types declaration, eauto hint declaration, local notation declaration, coercion declaration, instance declaration. (Note that dependencies are possible, i.e. an implicit type or a hint or a notation can be associated with a context variable.) An "environment" can be named, and can be opened in a section. It can be built as the union of existing environments (or by removing declarations from existing environments). Environments are functional (i.e. they are not extended in place), even though a convenient syntax can be provided for extending an environment and immediately rebinding it with the same name, so as to locally give the illusion that it is augmented in place. Having functional environments solves the modularity issue that is currently associated with scopes / hint / instances being global.

-   Speeding up recompilation in a project

    > The idea is to make it possible to recompile the definitions located in all the dependencies of a given file as fast as possible, by skipping all proofs in the dependencies, and avoiding the space blow-up currently affecting vio files.

    -   "The command "coqlighten foo.v" generates "foo.light.v", which is the same as foo.v except that all lemmas whose proof ends on a Qed are replaced with a corresponding axiom. (coqlighten can probably be implemented using sed with the right regular expression). This file is typically compiled using "coqc" as "foo.light.vo".
    -   "coqc -light bar.v" treats "Require Import foo" exactly as if it were "Require Import foo.light", and it produces as output the file "bar.vo.light" (instead of "bar.vo").
    -   "coqdep foo.v" (where "foo.v" depends on "bar.v") produces dependencies using an extra level of indirection that is useful for the end-user (read further), as follows:

        -   foo.vo: foo.vo.requires
        -   foo.vo.requires: bar.vo
        -   foo.vo.light: foo.vo.light.requires
        -   foo.vo.light.requires: bar.light.vo

        Note that we have "foo.light.vo: foo.light.v" following the standard compilation rule based on "coqc", and we also have "foo.light.v: foo.v" following the build rule based on "coqlighten".

    -   In CoqIDE, add a shortcut that, when the current file is "foo.v", runs the command "make foo.vo.light.requires", and then (optionnaly) reloads the current file up to current location in this file. This allows making a change in another file "bar.v", and getting back to an up-to-date state in "foo.v" with minimal recompilation effort.
    -   If parsing takes significant time, it is possible to dump the content of the parsed tree in binary format, in e.g. "foo.light.ast". This assumes, though, that the user will be responsible for doing a clean of those files if he changes the scopes or the set of notation being used.

-   (bonus) HTML5 interface for Coq developments The idea is to make sure that all the tools are ready to allow for the development of an alternative to CoqIDE, which would allow for:

    -   customizable display for domain-specific uses of Coq (e.g. CFML).
    -   display of latex-style mathematical formula using mathjax.
    -   working with Coq online without any local installation, in case a remote server is used for compiling scripts.
    -   integration in the display of links for looking up definitions.

    What's needed:

    -   a basic http server that runs coqtop, and (preferably) that is able to do a little bit of caching to avoid the transmition of fule files on every change.
    -   a way for the server to obtain from coqtop structured AST (instead of plain strings), so as to be able to render structured display.
    -   a Coq plugin to be able to register latex notation with term constructs (such a plugin would also be useful to generate readable versions of formal definitions, e.g. for documentation purposes)."
-   (bonus) Development benchmark for Coq developers

    > The idea is to gather a few real, modern Coq developments, and use them for the during-the-day testing of changes to the code base of Coq.

    -   Select a number of developments provided by volunteers Coq power users, who are available to help in case the developers of Coq cannot easily figure out why a proof has been broken by their changes.
    -   For each, ask the authors to maintain a little script to describe which lemmas should be turned into axioms (to save compilation time), keeping only a representative subset of the lemmas in the developments. Typically, it would suffice to provide a list of lemmas to keep, e.g. in JSON format:

      ```json
      [ { file : "foo.v",
          keep : [ "lemma_x", "lemma_y" \], keep_sections : [ "Part1" ] },
          { file : "bar.v", keep_all : "true" } ] // keep_all could be implicit.
      ```
      The goal is to test a maximal number of aspects in less than 1 minute of compilation time per development. (If needed, it is also possible to exclude some files entirely.)

    -   The code can be pulled (on carefully-chosen commit points) form the git repository of the authors, then the filter on proofs is applied. Optionnaly, these generated files can be commited in a git used by coq developers, but this might not be necessary if the process is fast enough.
    -   It might be useful to also keep track of little patches that may need to be applied to the development, in order to cope with non-backward compatible changes. Such patches could be commited in the git of the Coq developers.


