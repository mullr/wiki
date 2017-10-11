Other tutorials
===============

Introduction to Coq
-------------------

* `Beginners video tutorials`_, by Andrej Bauer

* `Coq in a Hurry`_, tutorial by Yves Bertot

* Material from the Coq summer school `Modelling and verifying algorithms in Coq: an introduction`_.

* Material from courses in French:

  * `by David Pichardie`_

  * `by Pierre Letouzey`_

  * `by Assia Mahboubi`_

  * `by Alexandre Miquel`_

* Material from course `Semantic of Proofs and Certified Mathematics`_

* Material from the `Using Proof Assistants for Programming Language Research`_ tutorial.

    See also the page `Technique for formalization of variable binding`_.

* `ITP'15 tutorial on Coq`_

Specific techniques
-------------------

Warning: the rest of this page may contain deprecated information.

Tips
~~~~

* Induction

  * How do I do `mutual induction`_?

  * How do I do `induction over a type containing pairs`_?

  * How can I do `induction with self defined cases`_ ?

* `Tips on code extraction`_

* `Tips on improving performance`_

* `Tips on notation (Haskell-style list comprehension)`_

Ltac tactics
~~~~~~~~~~~~

* `Marking cases and subcases in proofs`_

* `Folding definitions in multiple places`_

* `A conditional tactical`_

* `An aggressive version of subst`_

* `Decomposing all record-like structures`_

* `Solving a goal by inversion on an unspecified hypothesis`_

* `Solve goals about list inclusion`_

* `Apply <-> forwards and backwards`_

* `Manipulate equalities in the goal`_

* Automatically `cleaning your hypothesis like in linear programming`_ (contains also an example of a way to have list of hypothesis in a custom tactic)

OCaml tactics
~~~~~~~~~~~~~

* A `simple example`_ of a tactic written in OCaml

* `Unfold a fixpoint once`_ (in OCaml)

.. ############################################################################

.. _Beginners video tutorials: http://www.youtube.com/view_play_list?p=DD40A96C2ED54E99

.. _Coq in a Hurry: http://cel.archives-ouvertes.fr/inria-00001173

.. _`Modelling and verifying algorithms in Coq: an introduction`: http://moscova.inria.fr/~zappa/teaching/coq/ecole10/

.. _by David Pichardie: http://www.irisa.fr/celtique/pichardie/teaching/M2/MDV/

.. _by Pierre Letouzey: http://www.pps.jussieu.fr/~letouzey/teaching.fr.html

.. _by Assia Mahboubi: http://specfun.inria.fr/mahboubi/ens.html

.. _by Alexandre Miquel: http://www.pps.jussieu.fr/~miquel/enseignement/mpri/index.html

.. _Semantic of Proofs and Certified Mathematics: http://specfun.inria.fr/mahboubi/cirm14.html

.. _Using Proof Assistants for Programming Language Research: http://www.cis.upenn.edu/~plclub/popl08-tutorial/code/index.html

.. _Technique for formalization of variable binding: ../BindingRepresentation

.. _ITP'15 tutorial on Coq: http://coq.inria.fr/coq-itp-2015

.. _mutual induction: ../Mutual Induction

.. _induction over a type containing pairs: ../Induction over a type containing pairs

.. _induction with self defined cases: ../InductionWithSelfDefinedCases

.. _Tips on code extraction: ../Extraction

.. _Tips on improving performance: ../Performance

.. _Tips on notation (Haskell-style list comprehension): ../ListComprehensionNotation

.. _Marking cases and subcases in proofs: ../Case (tactic)

.. _Folding definitions in multiple places: ../Folding tactics

.. _A conditional tactical: ../if/then/else (tactical)

.. _An aggressive version of subst: ../subst++ (tactic)

.. _Decomposing all record-like structures: ../decompose records (tactic)

.. _Solving a goal by inversion on an unspecified hypothesis: ../solve by inversion (tactic)

.. _Solve goals about list inclusion: ../InTac

.. _Apply <-> forwards and backwards: ../AppFwdRev

.. _Manipulate equalities in the goal: ../LhsRhsTactic

.. _cleaning your hypothesis like in linear programming: ../LinearTactics

.. _simple example: ../evar_match

.. _Unfold a fixpoint once: ../UnfoldFixpointOnce

