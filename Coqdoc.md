This page is for collecting wishes and features requests for coqdoc. 

<<TableOfContents>>

== Use cases for coqdoc ==
This sections lists the different uses for coqdoc

 * Project documentation
 * Manpage generation
 * Literate programming
 * Use for writing scientific papers
 * Interactive documentation : 
  Since there is an implementation of coq in javascript, we can think of interactive content integrated in web pages, using coq.
  This feature would offer an interactive documentation and even interactive tutorials.

== Coqdoc's design ==

The objective for the new coqdoc is to use elements from coq's compiler, and to use the metadata obtained during the compilation phase for the documentation.

In order to do this, coqdoc would generate .vdoc files, which is an intermediate representation for the documentation files. They would hold all the necessary metadata coming from the coq compiler.

== Coqdoc features ==

The following features are taken from [[Wishes]]

=== Support links from within [...] parts of comments ===

E.g. support links on definition {{{permutation}}} from

{{{(* This is a variant of [Coq.List.List.permutation] *)}}}

=== Index ===
Build up global alphabetical index of all values kind by kind (Module, Lemma, Axiom, ...)

Follow directories hierarchy : In large formalisation and in the standard library for example. Also build (module for example) index file by file and directory by directory.

=== Native output format ===
 * LaTeX : See the link with coq-tex
 * HTML 
 * dot : graph with Lemma's name as verticle and an edge if one is used by the other. Maybe at least avoid induction principle. 
Have a look to [[http://www-sop.inria.fr/members/Anne.Pacalet/dpdgraph/|dpdgraph-0.2]]
