Paper programming languages proofs often follow the Barendregt variable convention. This says that alpha equivalent terms (e.g. ``\x.x z`` and ``\y.y z`` are implicitly identified.  While the convention is convenient on paper, it does not translate automatically to a formal setting.  The following papers (and tutorial) discuss approaches to formalizing languages with binding.

* Brian Aydemir, Arthur Charguéraud, Benjamin C. Pierce, Randy Pollack, and Stephanie Weirich. `Engineering Formal Metatheory`_. This paper argues for locally nameless terms and cofinitely quantified judgments.  The approach appears practical for general research purposes.

* `Using Proof Assistants for Programming Language Research`_. A tutorial based on the locally nameless/cofinite approach.

* Brian Aydemir, Stephanie Weirich, and Steve Zdancewic. `Abstracting Syntax (Draft)`_. This paper suggests several other shemes including a higher order abstract syntax encoding in Coq.  The techniques mostly refine those described above.

* Brian Aydemir, Aaron Bohannon, and Stephanie Weirich. `Nominal Reasoning Techniques in Coq (Extended Abstract)`_.  This paper illustrates defining expressions in terms of an (uninstantiated) nominal-logic style signature.

.. ############################################################################

.. _Engineering Formal Metatheory: http://www.cis.upenn.edu/~baydemir/papers/Engineering%20Formal%20Metatheory.pdf

.. _Using Proof Assistants for Programming Language Research: http://www.cis.upenn.edu/~plclub/popl08-tutorial/code/index.html

.. _Abstracting Syntax (Draft): http://www.cis.upenn.edu/~baydemir/papers/Abstracting%20Syntax.pdf

.. _Nominal Reasoning Techniques in Coq (Extended Abstract): http://www.cis.upenn.edu/~baydemir/papers/Nominal%20Reasoning%20Techniques%20in%20Coq%20(Extended%20Abstract).pdf

