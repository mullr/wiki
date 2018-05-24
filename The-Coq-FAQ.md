This FAQ is the sum of the questions that came to mind as we developed proofs in Coq. Since we are singularly short-minded, we wrote the answers we found on bits of papers to have them at hand whenever the situation occurs again. This is pretty much the result of that: a collection of tips one can refer to when proofs become intricate. Yes, this means we won't take the blame for the shortcomings of this FAQ. But if you want to contribute and send in your own question and answers, feel free to add your own contributions to this wiki.

1. [Presentation](Presentation)
2. [Documentation](Documentation)
3. [Installation](Installation)
4. [The Logic of Coq](The-Logic-of-Coq)
    * [General](The-Logic-of-Coq#general)
    * [Axioms](The-Logic-of-Coq#axioms)
    * [Impredicativity](The-Logic-of-Coq#impredicativity)
5. [Talkin' with the Rooster](Talkin'-with-the-Rooster)
    * [My goal is ..., how can I prove it?](Talkin'-with-the-Rooster#my-goal-is--how-can-i-prove-it)
    * [Tactics Usage](Talkin'-with-the-Rooster#tactics-usage)
    * [Proof Management](Talkin'-with-the-Rooster#proof-management)
6. [Inductive and Co-Inductive Types](Inductive-and-Co-Inductive-Types)
    * [General](Inductive-and-Co-Inductive-Types#general)
    * [Recursion](Inductive-and-Co-Inductive-Types#recursion)
    * [Co-Inductive Types](Inductive-and-Co-Inductive-Types#co-inductive-types)
7. [Syntax and Notations](Syntax-and-Notations)
8. [Ltac](Ltac)
9. [Tactics Written in OCaml](Tactics-Written-in-OCaml)
10. [Case Studies](Case-Studies)
11. [Publishing Tools](Publishing-Tools)
12. [CoqIde](CoqIde)
13. [Extraction](Extraction)
14. [Glossary](Glossary)
15. [Troubleshooting](Troubleshooting)
16. [More questions](#more-questions)

# More questions

## How to find unused lemmas in a large development?

Use the [dpdusage](https://github.com/Karmaki/coq-dpdgraph#dpdusage-find-unused-definitions-via-dpd-file) tool which comes with the [coq-dpdgraph](https://github.com/Karmaki/coq-dpdgraph) plugin.

## Questions to move to the section they belong to

1.  Should I put my type in [[Prop_or_Set]]?
2.  How does the [[MatchAsInReturn] syntax work?
3.  Why can't I prove (forall x, f x = g x) -&gt; f = g? (see [[extensional_equality]])
4.  Isn't [[IntensionalEquality]] useless?
5.  How do I get [[DependentInversion]] to work in my case?
6.  Why not [[WTypeInsteadOfInductiveTypes]]?
9.  Do objects living in `Prop` ever need to be evaluated? See [[PropsGuardingIotaReduction]].
10. When using `eapply`, how can I instantiate the question marks i.e. the [[ExistentialVariablesInEapply]]?
11. [[CoqNewbieQuestions]]