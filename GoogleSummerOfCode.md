= Ideas for Google Summer of Code 2016 and Coq =

Note: This page needs updating for GSOC 2017.

== Mentors ==

People that have expressed interest in mentoring: Maxime Dènes, Emilio Gallego, Gregory Machela, Pierre-Marie Pedrot, Kenneth Roe, Matthieu Sozeau, Enrico Tassi

== Ideas ==

Template for ideas are:

=== Title of the Idea ===

* '''Description''':

* '''Requisites''':

* '''Difficulty''':

* '''Mentors''':

We aim most ideas to be co-mentored, so feel free to participate in an existing one.

=== JsCoq library and option management ===

* '''Description''': [[https://github.com/ejgallego/jscoq|JsCoq]] is a port of Coq to Javascript, allowing the development of Coq scripts using html with a zero free installation. This task would consist in improving the user interface and preliminary package definition so it is possible to build and manage a jsCoq enviroment with proper modular libraries and dependencies.

* '''Requisites''': Javascript UI development: ''Medium'', OCaml: ''Medium'', Coq: ''Medium level''

* '''Difficulty''': Medium

* '''Mentor''': Emilio J. Gallego

=== Port vm_compute to jsCoq ===

* '''Description''': [[https://github.com/ejgallego/jscoq|JsCoq]] is a port of Coq to Javascript, allowing the development of Coq scripts using html with a zero free installation. Currently vm_compute is not available in jsCoq as we don't transcompile the C parts of Coq to javascript. This could be done using emscriptem thou. This is a fun project but of high difficulty.

* '''Requisites''': Strong C and javascript knowlegde.

* '''Difficulty''': High.

* '''Mentor''': Emilio J. Gallego

=== Markdown support in Proof General ===

* '''Description''': [[https://github.com/ProofGeneral/PG/|ProofGeneral]] is the most used editing environment for Proof Scripts. Currently it can edit .v file; this task would consist in developing an extension incorporating support for markdown files with embedded Coq.

* '''Requisites''': Emacs lisp: High

* '''Difficulty''': High

* '''Possible Mentor''': Emilio J. Gallego


=== Improvement the Search Command and API ===

* '''Description''': The Search command allows the users to search for relevant lemmas, but the current implementation and API has some limitations and doesn't scale too well. Your task would be to improve the API and command improving efficiency and flexibility. This task is quite open, student ideas are welcome here, some ideas we have are: implementing approximate search, indexing, result streaming, richer filtering combinators.

* '''Requisites''': Ocaml: High, Coq: Medium

* '''Difficulty''': Medium/High

* '''Mentor''': Emilio J. Gallego  (GM: I have a partial implementation of the revised API, I wanted to do a bit of benchmarking) (EG: great ! Would you like to mentor/co-mentor this project?) (GM: sure)


=== Atom-based CoqIDE ===

* '''Description''': [[https://atom.io|Atom]] is a new editor based on web frontend technologies. Your task would be to implement a proof of concept extension to make Atom communicate with Coq. Some exploratory work has already happened in jsCoq, you would likely help in refining current protocol and serialization needs.

* '''Requisites''': JS/Hmtl: ''High'', Ocaml: ''High'', Coq: ''Medium''

* '''Difficulty''': Very High

* '''Mentor''': Emilio J. Gallego

=== Stable Binary Format ===

* '''Description''': Implement a stable binary format for Coq theory files (an alternative to .vo). As a starting point, we could just write a standalone tool that converts a .vo to one of these files and back. The benefits of a stable binary format are: 1) avoid rebuilding large libraries, 2) avoid having to install plugins that are only necessary to build files, 3) quick way to use old developments in new ones, 4) ability to manipulate Coq files in languages other than Ocaml.

* '''NOTE''': Someone on the Coq teams needs to weigh in on their perceived usefulness of this and the feasibility of the project.
     (EG: IMO this is super interesting stuff, but indeed it may be too hard. The first problem we found some time ago is that .vo files store hashes, which are of different size in 32 vs 64 versions of Coq.) (GM: A hash of what? At their core, these files are just ASTs of Gallina terms + notations + ltac tactics. But I can't think of what you would need hashes for. ET: imo this project mixes "stable" and "readable".  by turning .vo files into directories would make the second part simpler, especially the step0 (converter); eg .vo files are already divided into binary segments, one of these segment is an array of terms and could simply be a subdirectory of terms)

* '''Requisites''': Ocaml: ''High'', Coq: ''Medium''

* '''Difficulty''': Very High

* '''Mentor''': Gregory Malecha + Someone from the Coq team

=== Update Coq Parser API ===

* '''Description''': Update Coq to 1) Support an XML format for all outputs (proof goals, responses to entering definitions--good or bad, etc.), 2) To produce a command that can take any Coq command and respond with the corresponding AST XML with line/column annotations.  3)  Develop a Python library (based on CoqPIE) to provide support for many useful capabilities such as proof replay, dependency analysis, lemma extraction and term difference analysis.  The idea being that the Python library will be integrated into other IDEs.

* '''Support for developing an IDE based on Coq Syntax ASTs''':

* '''Requisites''': Ocaml: ''High'', Coq: ''Medium'' Python: ''Medium''

* '''Difficulty''': Medium

* '''Mentor''': Kenneth Roe + Enrico Tassi
* '''Comments by EG''': Note that a sensible plan here could be to use automatic serialization of the Coq internal structures using ocaml PPX. Note that in particular JSON/SEXP serialization works well and a proof of concept has been implemented for JsCoq, see the thread titled ''Printing-only notations (was Re: Printing in fully parenthesized Polish prefix notation)'' in coqev. Unfortunately the ppx support for json serialization seems to work not so well these days, and doing is manually is IMO just not going to work due to the size and complexity of the structures.

=== Improve CoqDoc support for JsCoq ===

* '''Description''': A branch of [[https://github.com/coq/coq/pull/133|CoqDoc]] has now support for outputting JsCoq documents. However coqdoc lacks support for many useful constructs to build lessons with CoqDoc like a "click here to eval"/"click here to view the type, automatic "go to this point", "solve this exercise" etc... commands. The goal of the student would be, starting from the current coqdoc branch to build and extend CoqDoc to support a nice interactive introduction to Coq.

* '''Requisites''': Ocaml: ''Medium'', Coq: ''Medium/Low'', Js/HTML: ''Medium/High''

* '''Difficulty''': Medium

* '''Mentor''': Emilio J. Gallego

=== Extraction to Javascript ===

* '''Description''': Extend Coq's extraction plugin so it can output javascript. This would allow the definition of Coq programs in JsCoq, their extraction, and execution whithin the browser.

* '''Requisites''': Ocaml: ''Medium'', Coq: ''Medium'', Js/HTML: ''Medium''

* '''Difficulty''': Medium

* '''Mentor''': Emilio J. Gallego

=== Porting LtacProf to Coq 8.5 ===

* '''Description''': Tobias Tebbi wrote a very useful [[http://www.ps.uni-saarland.de/~ttebbi/ltacprof/|profiler for Coq 8.4]].  The goal would be to port it to 8.5 and have it integrated in trunk.  Most of it has been [[https://github.com/JasonGross/coq/commits/v8.5%2Bltacprof|ported to a slightly outdated version of the v8.5 branch]], but it doesn't actually work (as you execute more tactics, the percentage of the total time which is accounted for in the table goes down.  What remains is primarily debugging this issue.

* '''Requisites''': Ocaml: ''Medium'', Coq: ''Low'', Debugging: ''High''

* '''Difficulty''': Low--Medium

* '''Mentors''': ??? (Jason Gross would be willing to provide input and direction, but doesn't have much time available)
