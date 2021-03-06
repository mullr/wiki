What happens at the Coq Coding Sprint
=====================================

This page is to log all the activities done during the Coq Coding Sprint. Please put here links to the bugs you've fixed, to the git repository containing your plugin or your experimental branch.

Before the CS begins
--------------------

-   Enrico spams the participants with infos about wifi, git and this page

Monday 22
---------

-   Enrico makes a brilliant talk.

Tuesday 23
----------

-   (Jaap) working on IDE stuff - fork here: <http://github.com/jaapb/coq>
-   (Matthieu) and (Jacques-Henri) fixing bugs on universes (\#4254).
-   (Frédéric) \[Set Printing Coercions Quoted\] (like the name?); didn't know how to do a pull request; learnt it with Cyril
-   (Maxime) Add a printer for VM bytecode to make debugging easier
-   (Assia, with the help of Pierre B.) Learnt about \_CoqProject (with ProofGeneral, to handle plugins, options...). Started rebasing old code on v8.5.
-   (Cyprien) Add range selectors ("\[1,3-5\]:tac."). I still need to check if I can make the syntax simpler while still working with IDEs.
-   (Enrico) merge pull request of Alec (fix STM + obligations); buy candies & coffee; a lot of chatting
-   (Arnaud) document positivity checker (pushed), lots of helping around, progress on making inductive definition assume their positivity (commits here <https://github.com/aspiwack/coq/commits/assumetotal> )
-   (Matej) Talking to Enrico. dist-upgrading my machine (in order to generate VCS diagrams, I needed a newer version of "graphviz"). Studying Stm.show\_script function and transitively whatever it relies upon.
-   (Pierre-Marie) Merge pull requests, do profiling, help people.
-   (Alec) Fixed a conflict between STM and Program; changed the way Coqoon draws processing annotations
-   (Jacques-Henri) test a sampling memory profiler on Coq with PMP; work on \#4254 with Matthieu
-   (Gabriel) fix small issues in Jacques-Henri's memory profiler; very slow progress on a (fun &lt;pattern&gt; =&gt; ...) patch
-   (Thomas, with help from Hugo H. and Pierre B.) Move fatal\_error to the Errors module ([a110da8](https://github.com/tomsib2001/coq/commit/a110da85ea25ba6b1f5a4001142abf200da3f193)), and then implemented a printer in cbv and cbn ([dc3f2ed](https://github.com/tomsib2001/coq/commit/dc3f2ed953979a965a48ace94c3c344e5e9d0c7e)).

    > We now have a function print : forall X, X -&gt; X such that print behaves like the identity but has the side effect of printing its argument to stdout.

-   (Jason, with help from Arnaud) Ported [LtacProf](www.ps.uni-saarland.de/~ttebbi/ltacprof/) to Coq 8.5; it compiles, but there seem to be heisenbugs, and other strange behavior. (With help from Hugo) Started reverting [18796b6](https://github.com/coq/coq/commit/18796b6aea453bdeef1ad12ce80eeb220bf01e67) to add `function_scope`, fixing [\#3080](../issues/3080)
-   (Cyril, Laurence) Design of a vernacular command to extend a hierarchy of packed classes, on paper.
-   (Anders) Patch the paramcoq plugin so that it compiles on v8.5. Continue porting CoqEAL to use this and start rewriting the matrix refinements library (<https://github.com/CoqEAL/CoqEAL/tree/paramcoq>).
-   (Abhishek) Extracted the "3-digits of e" program to Ocaml; the Ocaml program produces correct answer when run. Then extracted a [robotic program](http://www.cs.cornell.edu/~aa755/ROSCoq/coqdoc/ROSCOQ.icreateConcrete.html#robotProgramInstance) to OCaml. A simplified version of the extract typechecked and produced correct answer. Read the full documentation of extraction. With help of Pierre Letouzey, mapped many Coq types to native OCaml implentations in the extract. He also fixed an issue causing the Haskell extract of the 3-digit program to segfault. Rebuilt Coq and CoRN with this fix in the [8.4 tip](https://github.com/coq/coq/commit/607b1cbfc819c321c1f5449ee10d12789f51e09a).
-   (Amin) Learned about how kernel handles universes and universe constraints. Started making a plugin to compare universe levels with a vernacular command.
-   (Reynald) I had performance issues with a formalization of mine (<http://jfr.unibo.it/article/view/4317>) -&gt; profiling with perf on Linux (by PMP) indicated GC related problems. Port Coq8.4 code to Coq8.5beta2 -&gt; *huge* performance improvement. Reported compatibilities issues between Coq8.4 and Coq8.5 regarding the semantics of Ltac and automation with Program. Got a guided debugging tour by HH and MS about above issues (first one on binders in Ltac already fixed). Reported performance/semantics issues with f\_equal (problem identified by HH and PL).

Wednesday 24
------------

-   (Emilio with help of countless others) Make ocaml plugin loading work in the javascript port. vo loading seems to be working in a proper way, but unfortunately javascript don't allow to unmarshall to 64 bits integers, which even trivial vo files contain. Trying with a 32 bit version of Coq, this looks like a tricky issue.
-   (Gabriel) report a Merlin issues affecting Coq plugin authors: [merlin\#410](https://github.com/the-lambda-church/merlin/issues/410), [merlin\#411](https://github.com/the-lambda-church/merlin/issues/411). Elisp parser for Anomaly stack traces: [\#78](https://github.com/coq/coq/pull/78).
-   (Frédéric) got review by Enrico; dealt with it, except for the request to be able to collapse stacked quoted coercions:
    -   quoted coercions now can be parsed
    -   start thinking about using declare\_string\_option for the wanted variety of presentations of coercions
-   (Matej) I tried to understand in understanding relevant parts of "Stm", "VCS" and "Dag" modules. Some progress in that.
-   (Arnaud) Some helping. Completed inductive definition assumed positive (some bug fixes left in vio & checker).
-   (Abhishek) [ROSCoq](http://www.cs.cornell.edu/~aa755/ROSCoq/) failed to compile with the [8.4 tip](https://github.com/coq/coq/commit/607b1cbfc819c321c1f5449ee10d12789f51e09a). Minimized the problem with Jason and filed a [bug report](../issues/4260). Patched ROSCoq with Jason's workaround and got it to compile. Then extracted the [robotic program](http://www.cs.cornell.edu/~aa755/ROSCoq/coqdoc/ROSCOQ.icreateConcrete.html#robotProgramInstance) to Haskell. The Haskell extract failed to compile. Manually [fixed](https://github.com/aa755/ROSCoq/commit/972ed9d26ac642499e60098cf0510ee9b6e0d3ea#diff-f9928ac6597fcd7e0cfbf7e9da0cdba9R2376) the extract to make it compile. It produced [correct results](https://github.com/aa755/ROSCoq/commit/972ed9d26ac642499e60098cf0510ee9b6e0d3ea) when run. Hence, decided that the main way to run ROSCoq programs will be to extract them to Haskell and then to link them somehow with the [roshask](https://github.com/acowley/roshask) bindings for the [Robot Operating System](http://www.ros.org/).
-   (Assia, with Pierre B.) still rebasing... plus some more discussions about \_CoqProject. Started editing its documentation on the reference manual.
-   (Amin) The plugin now works for global constraints. I'm trying to add support for constraints local to a universe polymorphic definition.
-   (Théo) Talked with Arnaud, Pierre-Marie and Matthieu about choices on how to generalize the subterm function in rewrite.ml. Current goal is to add a second term as input before generalizing to heterogenous relations. When there is no know second term, we need to give a "hole" instead. How to represent this hole? Went to Evar to Meta to special kind\_of\_term with holes back to Meta and yet, not sure it's the right solution.
-   (Reynald) Compiled CoqSDK for Windows 64 bits with debug flag and was explained construction of Windows installers in coq/dev by ET. Failed to compile Merlin for Cygwin (various problems with subprograms and in particular ocamlfind). Reported problem with coq\_makefile-generated makefile's on cygwin (failing "make clean"). As an exercise, extended sample plugin by ET to use standard libraries (Coqlib.glob\_nat data structures, etc; had issues with printing via Pp.msg\_warning). Set up environment to further extend above plugin with calls to lemmas from own user libraries.
-   (Jaap) continued with introducing tabs in the CoqIDE proof view; also solved an irritating lablgtk bug in NetBSD (I know this has nothing to do with Coq, but it really was an annoying bug)
-   (Lionel) alpha version of the selective unfolding of notations
-   (Maxime) made all Cocorico pages indexable by Google :- started working on Coq's jenkins server
-   (Gregory) working on coqdep
-   (Pierre-Marie) Helped people, profiled, optimized.
-   (Jason) Added back \[Bind Scope ... with Sortclass\], \[Bind Scope ... with Funclass\], added \[function\_scope\] declared in Coq.Init.Notations, moved \[type\_scope\] into user-space, rather than special-casing it in OCaml (the string \["type\_scope"\] no longer appears anywhere in the Coq source code). Submitted a [pull request](https://github.com/coq/coq/pull/77).
-   (Alec) Attempted (with Enrico) to track down the cause of a mysteriously non-responsive PIDE worker; *almost* managed to understand PIDE query overlays
-   (Anders) Continued rewriting CoqEAL to use paramcoq (ported polynomial pseudo-division and started porting Bareiss algorithm). Ran into some problems with the refinements for matrices.
-   (Cyprien) Submitted a PR for range selectors. Also started to look at the migration of some tactics to the new tactics engine.
-   (Guilhem) Adapted the Forcing plugin (<https://github.com/mattam82/Forcing>) to v8.5. Trying to remove the need of UIP in conversion in the proofs, and rather using it only as an Axiom.

Thursday 25
-----------

-   (Frédéric):
    -   got option strings to work; want to augment my data structure with a Coq nat, learnt how to do it in principle, but this leads to dependency headaches
    -   \[then discuss with Assia and Pierre: the approach of adding a new constant is bad, as representing presentation-only Coq terms inside the true logical content will lead to troubles (rewrite will apply to the metadata as well, etc); the right approach would be to have a genuine presentation-tree type in OCaml, and have metadata passed to IDEs through a separate channel; my hack could still live as a plugin, through a hook into constrextern; else it could be possible to use copies of `bool`, `nat`, etc, less prone to interference with the user\] ← I take it back: those augmented terms are only seen by the user, after externalization; the term kept in constants, goals, etc, for further logical manipulations are not augmented
    -   discussed with Arthur his draft for:
        -   design of environments containing the state of interaction parameters (flags, notations, coercions, databases, hints, etc)
        -   design of a set of tacticals (fast intros, easy post-application of tactics, etc) and tactics for disjunction, conjunction abstracted over their (n-ary) representation
-   (Jason)
    -   Fixed [bug \#4262, Output of \[Print Scopes\] is missing class keys](../issues/4262)
    -   Figured out, with Arnaud, how to write a \[Trace\] vernacular (like \[Info\], but closer to \[debug\] (\[Debug\] is reserved), and includes backtracking info)
    -   [Implemented most of the \[Trace\] vernacular](https://github.com/JasonGross/coq/tree/debug-command), currently stuck on finding a way of [comparing lazy data types for strict equality that isn't \[Pervasives.(=)\] (which doesn't like functions)](https://github.com/JasonGross/coq/blob/1a64808ad4b2a840c2cb115ae2e90cb632ac4f7e/engine/proofview_monad.ml#L105)
-   (Matej) I learned why my previous attempts to use "Drop." command failed.
-   (Arnaud) PR on assuming positivity ( <https://github.com/coq/coq/pull/79> )
-   (Jaap) Updated my MSc thesis project (10 years old now) to work with Coq 8.5 and as a plugin. Github repo here: <https://github.com/jaapb/pra>
-   (Jaap) Tabs in CoqIDE now at workable prototype stage.
-   (Théo) Learned about Canonical Structures with the help of Yves and Assia.
-   (Cyprien) PR on migrating \[reduce\] to the new tactics engine.
-   (Maxime) Made github pull requests automatically built by Jenkins
-   (Abhishek) Studied [roshask](https://github.com/acowley/roshask). Used it to generate Haskell definitions of some ROS message types (e.g. [Twist](http://docs.ros.org/api/geometry_msgs/html/msg/Twist.html)). Realized that it should be easy to tweak roshask to generate corresponding Coq definitions as well, e.g. change *data* to *Inductive*. The generated Coq file should also include Extraction directives to extract Coq Message types to the corresponding Haskell versions. The Haskell definitions (of message types) also includes extra functions, e.g. for (de) serialization. These would not be included in the Coq version.
-   (Amin) Finished the plugin (<https://github.com/amintimany/UniverseComparator>). It now also works for constraints local to a universe polymorphic definition.
-   (Reynald) Extended yesterday's sample plugin to use user libraries. Test various variations of myplug.ml4 (global\_with\_alias vs. global\_of\_extended\_global; ise\_pretype\_gen vs. understand vs. understand\_tcc; Global.env vs. Goal.env vs. Goal.hyps; msg\_info vs. msg\_warning vs. ppnl; etc.) and ask for explanations to Coq developers. Start working on reimplementing a slow Ltac function as a plugin.
-   (Assia) Still trying to have the generic-equality branch compile. Edition of the \_CoqProject / coq\_makefile section of the reference manual.
-   (Emilio) More tweaks to module loading in the Js port, was finally able to load Mathcomp.

Friday 26
---------

-   Amazing talks, really!

