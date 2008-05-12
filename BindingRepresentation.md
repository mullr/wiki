Paper programming languages proofs often follow the Barendregt variable convention. This says that alpha equivalent terms (e.g. `\x.x z` and `\y.y z`
are implicitly identified.  While the convention is convenient on paper, it does not translate automatically to a formal setting.  The following papers
(and tutorial) discuss approaches to formalizing languages with binding.

 * Brian Aydemir, Arthur Charguéraud, Benjamin C. Pierce, Randy Pollack, and Stephanie Weirich. [[http://www.cis.upenn.edu/~baydemir/papers/Engineering%20Formal%20Metatheory.pdf|Engineering Formal Metatheory]]. This paper argues for locally nameless terms and cofinitely quantified judgments.  The approach appears practical for general research purposes.

 * [[http://www.cis.upenn.edu/~plclub/popl08-tutorial/code/index.html|Using Proof Assistants for Programming Language Research]]. A tutorial based on the locally nameless/cofinite approach.

 * Brian Aydemir, Stephanie Weirich, and Steve Zdancewic. [[http://www.cis.upenn.edu/~baydemir/papers/Abstracting%20Syntax.pdf|Abstracting Syntax (Draft)]]. This paper suggests several other shemes including a higher order abstract syntax encoding in Coq.  The techniques mostly refine those described above.

 * Brian Aydemir, Aaron Bohannon, and Stephanie Weirich. [[http://www.cis.upenn.edu/~baydemir/papers/Nominal%20Reasoning%20Techniques%20in%20Coq%20(Extended%20Abstract).pdf|Nominal Reasoning Techniques in Coq (Extended Abstract)]].  This paper illustrates defining expressions in terms of an (uninstantiated) nominal-logic style signature.
