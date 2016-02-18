= Ideas for Google Summer of Code and Coq =

Template for ideas are:

=== Title of the Idea ===

* '''Description''': 

* '''Requisites''':

* '''Difficulty''':

* '''Mentor''': 

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

* '''Mentor''': Emilio J. Gallego  (GM: I have a partial implementation of the revised API, I wanted to do a bit of benchmarking)


=== Atom-based CoqIDE ===

* '''Description''': [[https://atom.io|Atom]] is a new editor based on web frontend technologies. Your task would be to implement a proof of concept extension to make Atom communicate with Coq. Some exploratory work has already happened in jsCoq, you would likely help in refining current protocol and serialization needs.

* '''Requisites''': JS/Hmtl: ''High'', Ocaml: ''High'', Coq: ''Medium''

* '''Difficulty''': Very High

* '''Mentor''': Emilio J. Gallego 

=== Stable Binary Format ===

* '''Description''': Implement a stable binary format for Coq theory files (an alternative to .vo). As a starting point, we could just write a standalone tool that converts a .vo to one of these files and back. The benefits of a stable binary format are: 1) avoid rebuilding large libraries, 2) avoid having to install plugins that are only necessary to build files, 3) quick way to use old developments in new ones, 4) ability to manipulate Coq files in languages other than Ocaml.

* '''NOTE''': Someone on the Coq teams needs to weigh in on their perceived usefulness of this and the feasibility of the project.

* '''Requisites''': Ocaml: ''High'', Coq: ''Medium''

* '''Difficulty''': Very High

* '''Mentor''': Gregory Malecha + Someone from the Coq team

=== Update Coq Parser API ===

* '''Description''': Update Coq to 1) Support an XML format for all outputs (proof goals, responses to entering definitions--good or bad, etc.), 2) To produce a command that can take any Coq command and respond with the corresponding AST XML with line/column annotations.  3)  Develop a Python library (based on CoqPIE) to provide support for many useful capabilities such as proof replay, dependency analysis, lemma extraction and term difference analysis.  The idea being that the Python library will be integrated into other IDEs.

* '''Support for developing an IDE based on Coq Syntax ASTs''': 

* '''Requisites''': Ocaml: ''High'', Coq: ''Medium'' Python: ''Medium'':

* '''Difficulty''': Medium
 
* '''Mentor''': Kenneth Roe + Someone from the Coq team
