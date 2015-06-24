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
   We now have a function 
   print : forall X, X -> X such that print behaves like the identity but has the side effect of printing its argument to stdout.
 * (Jason, with help from Arnaud) Ported [[www.ps.uni-saarland.de/~ttebbi/ltacprof/|LtacProf]] to Coq 8.5; it compiles, but there seem to be heisenbugs, and other strange behavior.  (With help from Hugo) Started reverting [[https://github.com/coq/coq/commit/18796b6aea453bdeef1ad12ce80eeb220bf01e67|18796b6]] to add `function_scope`, fixing [[https://coq.inria.fr/bugs/show_bug.cgi?id=3080|#3080]]
 * (Cyril, Laurence) Design of a vernacular command to extend a hierarchy of packed classes, on paper.
 * (Anders) Patch the paramcoq plugin so that it compiles on v8.5. Continue porting CoqEAL to use this and start rewriting the matrix refinements library (https://github.com/CoqEAL/CoqEAL/tree/paramcoq). 

=== Wednesday 24 ===
 * (Emilio with help of countless others) Make ocaml plugin loading work in the javascript port. vo loading seems to be working in a proper way, but unfortunately javascript don't allow to unmarshall to 64 bits integers, which even trivial vo files contain. Trying with a 32 bit version of Coq, this looks like a tricky issue.
 * (Gabriel) report a Merlin issue affecting Coq plugin authors: [[https://github.com/the-lambda-church/merlin/issues/410|#410]].
 * (Frédéric) got review by Enrico; dealt with it, except for the request to be able to collapse stacked quoted coercions:
   * quoted coercions now can be parsed
   * start thinking about using declare_string_option for the wanted variety of presentations of coercions

=== Thursday 25 ===
* nothing yet
