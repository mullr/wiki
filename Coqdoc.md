This page is for collecting wishes and features requests for coqdoc. 

<<TableOfContents>>

== Use cases for Coqdoc ==
This section enumerates the different uses for coqdoc.

 * Project documentation
    As for the current version of coqdoc, the user must be able to generate a document that is isomorphic to its development.
    The purpose of such documentation is to help the development.

 * Manpage generation
    The purpose of such documentation is to help the users of this development. 
    
 * Literate programming
    A document, in the style of literate programming, is both a human-readable document and a proof development. 

 * Use for writing scientific papers
    A scientific paper is special instance of literate programming, where some part of the proof development are hidden in the final document.

 * Interactive documentation
    Since there is a prototype implementation of coq in javascript, we can think of interactive content integrated in web pages, using coq.
    This feature would help developing  interactive documentation and tutorials.

== Design of Coqdoc ==

The objective for the new coqdoc is to have a close interaction with the coq system so that semantic information can be transmitted from the proof assistant to the document.

In order to do this, coqdoc will be based on a documentation language 'vdoc' that will act as a glue between structured documents and pieces of code written in Coq. This language will serve both as an input language to describe document and as an intermediate language. Indeed, source code written in standard .v with annotations in the style of the current coqdoc will be processed by a front-end to obtain a .vdoc file. Similarly, HTML or tex files that embed chunks of documented coq will be translated to .vdoc files. Eventually, a back-end will produces HTML or LaTeX files from the .vdoc files.

== Coqdoc features ==

We encourage members of the development teams to participate in the following list of wishes. The following features are taken from [[Wishes]].

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
