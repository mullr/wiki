Other tutorials
===============

Introduction to Coq
-------------------

-   [Beginners video tutorials](http://www.youtube.com/view_play_list?p=DD40A96C2ED54E99), by Andrej Bauer
-   [Coq in a Hurry](http://cel.archives-ouvertes.fr/inria-00001173), tutorial by Yves Bertot
-   Material from the Coq summer school [Modelling and verifying algorithms in Coq: an introduction](http://moscova.inria.fr/~zappa/teaching/coq/ecole10/).
-   Material from courses in French:
    -   [by David Pichardie](http://www.irisa.fr/celtique/pichardie/teaching/M2/MDV/)
    -   [by Pierre Letouzey](https://www.irif.fr/users/letouzey/edu/preuves)
    -   [by Assia Mahboubi](http://specfun.inria.fr/mahboubi/ens.html)
-   Material from course [Semantic of Proofs and Certified Mathematics](http://specfun.inria.fr/mahboubi/cirm14.html)
-   Material from the [Using Proof Assistants for Programming Language Research](http://www.cis.upenn.edu/~plclub/popl08-tutorial/code/index.html) tutorial.

    > See also the page [Technique for formalization of variable binding](BindingRepresentation).

-   [ITP'15 tutorial on Coq](http://coq.inria.fr/coq-itp-2015)

Specific techniques
-------------------

Warning: the rest of this page may contain deprecated information.

### Tips

-   Induction
    -   How do I do [mutual induction](Mutual%20Induction)?
    -   How do I do [induction over a type containing pairs](Induction%20over%20a%20type%20containing%20pairs)?
    -   How can I do [induction with self defined cases](InductionWithSelfDefinedCases) ?
-   [Tips on code extraction](Extraction)
-   [Tips on improving performance](Performance)
-   [Tips on notation (Haskell-style list comprehension)](ListComprehensionNotation)

### Ltac tactics

-   [Marking cases and subcases in proofs](Case%20(tactic))
-   [Folding definitions in multiple places](Folding%20tactics)
-   [A conditional tactical](if/then/else%20(tactical))
-   [An aggressive version of subst](subst++%20(tactic))
-   [Decomposing all record-like structures](decompose%20records%20(tactic))
-   [Solving a goal by inversion on an unspecified hypothesis](solve%20by%20inversion%20(tactic))
-   [Solve goals about list inclusion](InTac)
-   [Apply &lt;-&gt; forwards and backwards](AppFwdRev)
-   [Manipulate equalities in the goal](LhsRhsTactic)
-   Automatically [cleaning your hypothesis like in linear programming](LinearTactics) (contains also an example of a way to have list of hypothesis in a custom tactic)

### OCaml tactics

-   A [simple example](evar_match) of a tactic written in OCaml
-   [Unfold a fixpoint once](UnfoldFixpointOnce) (in OCaml)

