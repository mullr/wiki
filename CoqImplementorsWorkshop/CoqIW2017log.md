= What happens at the Coq Coding Sprint =
This page is to log all the activities done during the Coq Coding Sprint.  Please put here links to the bugs you've fixed, to the git repository containing your plugin or your experimental branch.

=== Before the CS begins ===
* Enrico spams the participants with infos about wifi, git and this page

=== Monday 22 ===
 * Enrico makes a brilliant talk.

=== Tuesday 23 ===
 * (Jaap) working on IDE stuff - fork here: http://github.com/jaapb/coq
 * (Matthieu) and (Jacques-Henri) fixing bugs on universes (#4254).
 * (Frédéric) [Set Printing Coercions Quoted] (like the name?); didn't know how to do a pull request; learnt it with Cyril
 * (Maxime) Add a printer for VM bytecode to make debugging easier
 * (Assia, with the help of Pierre B.) Learnt about _CoqProject (with ProofGeneral, to handle plugins, options...). Started rebasing old code on v8.5.
 * (Cyprien) Add range selectors ("[1,3-5]:tac."). I still need to check if I can make the syntax simpler while still working with IDEs.
 * (Enrico) merge pull request of Alec (fix STM + obligations); buy candies & coffee; a lot of chatting
 * (Arnaud) document positivity checker (pushed), lots of helping around, progress on making inductive definition assume their positivity (commits here https://github.com/aspiwack/coq/commits/assumetotal )
 * (Matej) Talking to Enrico. dist-upgrading my machine (in order to generate VCS diagrams, I needed a newer version of "graphviz"). Studying Stm.show_script function and transitively whatever it relies upon.
 * (Pierre-Marie) Merge pull requests, do profiling, help people.
 * (Alec) Fixed a conflict between STM and Program; changed the way Coqoon draws processing annotations
 * (Jacques-Henri) test a sampling memory profiler on Coq with PMP; work on #4254 with Matthieu
 * (Gabriel) fix small issues in Jacques-Henri's memory profiler; very slow progress on a (fun <pattern> => ...) patch
 * (Thomas, with help from Hugo H. and Pierre B.) Move fatal_error to the Errors module ([[https://github.com/tomsib2001/coq/commit/a110da85ea25ba6b1f5a4001142abf200da3f193|a110da8]]), and then implemented a printer in cbv and cbn ([[https://github.com/tomsib2001/coq/commit/dc3f2ed953979a965a48ace94c3c344e5e9d0c7e|dc3f2ed]]).
  . We now have a function
  print : forall X, X -> X such that print behaves like the identity but has the side effect of printing its argument to stdout.
 * (Jason, with help from Arnaud) Ported [[www.ps.uni-saarland.de/~ttebbi/ltacprof/|LtacProf]] to Coq 8.5; it compiles, but there seem to be heisenbugs, and other strange behavior.  (With help from Hugo) Started reverting [[https://github.com/coq/coq/commit/18796b6aea453bdeef1ad12ce80eeb220bf01e67|18796b6]] to add `function_scope`, fixing [[https://coq.inria.fr/bugs/show_bug.cgi?id=3080|#3080]]
 * (Cyril, Laurence) Design of a vernacular command to extend a hierarchy of packed classes, on paper.
 * (Anders) Patch the paramcoq plugin so that it compiles on v8.5. Continue porting CoqEAL to use this and start rewriting the matrix refinements library (https://github.com/CoqEAL/CoqEAL/tree/paramcoq).
 * (Abhishek) Extracted the "3-digits of e" program to Ocaml; the Ocaml program produces correct answer when run. Then extracted a [[http://www.cs.cornell.edu/~aa755/ROSCoq/coqdoc/ROSCOQ.icreateConcrete.html#robotProgramInstance|robotic program]] to OCaml. This did not typecheck. A simplified version typechecked and produced correct answer. Read the full documentation of extraction. With help of Pierre Letouzey, mapped many Coq types to native OCaml implentations in the extract. He also fixed an issue causing the Haskell extract of the 3-digit program to segfault. Rebuilt Coq and CoRN with this fix in the [[https://github.com/coq/coq/commit/607b1cbfc819c321c1f5449ee10d12789f51e09a|8.4 tip]].
 * (Amin) Learned about how kernel handles universes and universe constraints. Started making a plugin to compare universe levels with a vernacular command.
 * (Reynald) I had performance issues with a formalization of mine (http://jfr.unibo.it/article/view/4317) -> profiling with perf on Linux (by PMP) indicated GC related problems. Port Coq8.4 code to Coq8.5beta2 -> *huge* performance improvement. Reported compatibilities issues between Coq8.4 and Coq8.5 regarding the semantics of Ltac and automation with Program. Got a guided debugging tour by HH and MS about above issues (first one on binders in Ltac already fixed). Reported performance/semantics issues with f_equal (problem identified by HH and PL).

=== Wednesday 24 ===
 * (Emilio with help of countless others) Make ocaml plugin loading work in the javascript port. vo loading seems to be working in a proper way, but unfortunately javascript don't allow to unmarshall to 64 bits integers, which even trivial vo files contain. Trying with a 32 bit version of Coq, this looks like a tricky issue.
 * (Gabriel) report a Merlin issues affecting Coq plugin authors: [[https://github.com/the-lambda-church/merlin/issues/410|merlin#410]], [[https://github.com/the-lambda-church/merlin/issues/411|merlin#411]]. Elisp parser for Anomaly stack traces: [[https://github.com/coq/coq/pull/78|#78]].
 * (Frédéric) got review by Enrico; dealt with it, except for the request to be able to collapse stacked quoted coercions:
  * quoted coercions now can be parsed
  * start thinking about using declare_string_option for the wanted variety of presentations of coercions
 * (Matej) I tried to understand in understanding relevant parts of "Stm", "VCS" and "Dag" modules. Some progress in that.
 * (Arnaud) Some helping. Completed inductive definition assumed positive (some bug fixes left in vio & checker).
 * (Abhishek) [[http://www.cs.cornell.edu/~aa755/ROSCoq/|ROSCoq]] failed to compile with the [[https://github.com/coq/coq/commit/607b1cbfc819c321c1f5449ee10d12789f51e09a|8.4 tip]]. Minimized the problem with Jason and filed a [[https://coq.inria.fr/bugs/show_bug.cgi?id=4260|bug report]]. Patched ROSCoq with Jason's workaround and got it to compile. Then extracted the [[http://www.cs.cornell.edu/~aa755/ROSCoq/coqdoc/ROSCOQ.icreateConcrete.html#robotProgramInstance|robotic program]] to Haskell. Like the Ocaml extract, this Haskell extract also failed to compile. Manually fixed the extract to make it compile. It produced correct results when run. Hence, decided that the main way to run ROSCoq programs will be to extract them to Haskell and then to link them somehow with the [[https://github.com/acowley/roshask|roshask]] bindings for the [[http://www.ros.org/|Robot Operating System]].
 * (Assia, with Pierre B.) still rebasing... plus some more discussions about _CoqProject. Started editing its documentation on the reference manual.
 * (Amin) The plugin now works for global constraints. I'm trying to add support for constraints local to a universe polymorphic definition.
 * (Théo) Talked with Arnaud, Pierre-Marie and Matthieu about choices on how to generalize the subterm function in  rewrite.ml. Current goal is to add a second term as input before generalizing to heterogenous relations. When there is no know second term, we need to give a "hole" instead. How to represent this hole? Went to Evar to Meta to special kind_of_term with holes back to Meta and yet, not sure it's the right solution.
 * (Reynald) Compiled CoqSDK for Windows 64 bits with debug flag and was explained construction of Windows installers in coq/dev by ET. Failed to compile Merlin for Cygwin (various problems with subprograms and in particular ocamlfind). Reported problem with coq_makefile-generated makefile's on cygwin (failing "make clean"). As an exercise, extended sample plugin by ET to use standard libraries (Coqlib.glob_nat data structures, etc; had issues with printing via Pp.msg_warning). Set up environment to further extend above plugin with calls to lemmas from own user libraries.
 * (Jaap) continued with introducing tabs in the CoqIDE proof view; also solved an irritating lablgtk bug in NetBSD (I know this has nothing to do with Coq, but it really was an annoying bug)
 * (Lionel) alpha version of the selective unfolding of notations
 * (Gregory) working on coqdep
 * (Pierre-Marie) Helped people, profiled, optimized.
 * (Jason) Added back [Bind Scope ... with Sortclass], [Bind Scope ... with Funclass], added [function_scope] declared in Coq.Init.Notations, moved [type_scope] into user-space, rather than special-casing it in OCaml (the string ["type_scope"] no longer appears anywhere in the Coq source code).  Submitted a [[https://github.com/coq/coq/pull/77|pull request]].
 * (Alec) Attempted (with Enrico) to track down the cause of a mysteriously non-responsive PIDE worker; ''almost'' managed to understand PIDE query overlays
 * (Anders) Continued rewriting CoqEAL to use paramcoq (ported polynomial pseudo-division and started porting Bareiss algorithm). Ran into some problems with the refinements for matrices.
 * (Cyprien) Submitted a PR for range selectors. Also started to look at the migration of some tactics to the new tactics engine.
 * (Guilhem) Adapted the Forcing plugin (https://github.com/mattam82/Forcing) to v8.5. Trying to remove the need of UIP in conversion in the proofs, and rather using it only as an Axiom.

=== Thursday 25 ===
 * (Frédéric):
   * got option strings to work; want to augment my data structure with a Coq nat, learnt how to do it in principle, but this leads to dependency headaches; then discuss with Assia and Pierre: the approach of adding a new constant is bad, as representing presentation-only Coq terms inside the true logical content will lead to troubles (rewrite will apply to the metadata as well, etc); the right approach would be to have a genuine presentation-tree type in OCaml, and have metadata passed to IDEs through a separate channel; my hack could still live as a plugin, through a hook into constrextern; else it could be possible to use copies of `bool`, `nat`, etc, less prone to interference with the user
   * discussed with Arthur his draft for:
     * design of environments containing the state of interaction parameters (flags, notations, coercions, databases, hints, etc)
     * design of a set of tacticals (fast intros, easy post-application of tactics, etc) and tactics for disjunction, conjunction abstracted over their (n-ary) representation
 * (Jason) Fixed [[https://coq.inria.fr/bugs/show_bug.cgi?id=4262|bug #4262, Output of [Print Scopes] is missing class keys]]
 * (Matej) I learned why my previous attempts to use "Drop." command failed.
 * (Arnaud) PR on assuming positivity ( https://github.com/coq/coq/pull/79 )
 * (Jaap) Updated my MSc thesis project (10 years old now) to work with Coq 8.5 and as a plugin. Github repo here: https://github.com/jaapb/pra
 * (Jaap) Tabs in CoqIDE now at workable prototype stage.
 * (Théo) Learned about Canonical Structures with the help of Yves and Assia.
