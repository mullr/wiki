# Log of the CIW 2018

### Emilio:

- [with Michael] OPAM and OCaml developments tools for Windows
- [with Jim] goal diff printing https://github.com/coq/coq/pull/6801 .
- [with Enrico] language server protocol support for Coq.
- [with Leo] CI for quickchick https://github.com/coq/coq/pull/7656
- [with Talia] plugin porting to 8.8, discussion about the universe constraint API, also some discussion on reduction.
- [with Maxime, Enrico] discussion about Dune / package formats.
- [with Maxime] discussion on API documentation https://github.com/coq/coq/issues/7155
- Small merlin / emacs demo [pointer to file]

### Jim:

- With Emilio, made some progress on printing diffs between proof steps (https://github.com/coq/coq/pull/6801)
- Talked to Erik about getting Proof General to use the info produced by the proof diff code
- Discussion with Maxime about possible next projects for me
- Talk to Théo about improving the documentation.  I plan to make this my next project.
- Heard from Emilio about plans to use the Language Support Protocol to interface Coq to VSCode and other IDEs.  This would make CoqIde obsolete and save us from the considerable work required to provide a GUI ourselves.
- Short conversations about how to make Coq more powerful.  The Language Server Protocol may let us add helpful status displays in the various IDEs.

### Michael:

* Efficient and easy to maintain forward reasoning with eauto or typeclasses eauto:
  - intensive discussion with Théo and Armael on the right approach
  - my old approach was to bundle all forwarding into one step during backward reasoning to avoid permutation of the order of forwarding steps if a backward step is backtracked
  - Theó suggested to instead disable creating of a backtracking point for forward reasoning and include the forward reasoning steps as individual steps in the hint database. The main reasoning is that forwarding never influences the solvability of the goal, so it doesn't make much sense to backtrack such steps. This might also apply to some non forwarding steps, so the solution suggested by Théo is a quite general improvement.
  - Armael and Théo implemented this method for typeclasses eauto - PR has been created (https://github.com/coq/coq/pull/7661).
  - Michael is still working on some more advanced test cases.
  - Still open (maybe for CIW2019) is a Hint Forward which uses a premise based discrimination in the database
* Effective setup for development of Coq for Windows
  - Emilio helped me to get Merlin compiled under Cygwin (essentially one has to use a very recent OCaml version)
  - what still doesn't work is integration of Merlin into Visual Studio Code - Emilio is looking into this
  - Michael will provide an automated setup script - Jim will test it
* Problem that simpl and cbn tactics easily cross abstraction level borders:
  - Z is in Coq implemented bases on positives. This has the effect that simpl and cbn frequently "simplify" Z based expressions to positives based expressions. This is frequently not what one want's because it increases the domain automation needs to handle substantially and the results are usually not really simpler. It is a general problem that simpl and cbn cross abstraction borders.
  - I had intensive discussions on this with Yves, Emilio and Hugo
  - My suggestion was to use "Arguments Z.add : simpl never." & Co and have a special simplification tactic, which does not obey "simpl never" but only simplifies literal terms (that are terms consiting only of constructors and names of inductive types). Yves implemented a prototype of such a simplification function in ltac.
  - Emilio suggested to categorize symbols into abstraction domains (possibly by reusing the existing module structure) and be able to specify a preferred abstraction layer, e.g. by specifying a set of modules / files. If simplification would "simplify" a function from the preferred abstraction layer to a function of an unwanted abstraction layer, the simplification is not done. This is not trivial, because one would have to check if further simplification results in a term of the desired abstraction, e.g. a Z literal term. So backtracking would be required. But this would definitely a very powerful and flexible method to define what the user means by "simple".
* Term classification for gating automation:
  - Maxime added tactics for term classification, especially a tactic to check if a term is a literal term (PR https://github.com/coq/coq/pull/7670)
  - Some already existing but not documented tactics (is_ctor) need documentation
* Many useful hints / details:
  - deeper explanation of inversion vs. destruct vs. dependent destruct ... by Hugo
  - learning about Zify and romega
  - personal contact to developers of interesting Coq contributions
  - many more

In summary it was a very good, effective and enjoyable workshop!

### Erik:

- [with Enrico] in the course of a discussion about `under`, we talked about ssr rewrite's behavior w.r.t. evars; see [PR #7638](https://github.com/coq/coq/pull/7638)
- [with Enrico, Cyril] new specification of the `under` tactic
- [with Enrico] on-going work to implement this new specification of `under` (which fortuitously made us notice [PG issue 362](https://github.com/ProofGeneral/PG/issues/362))
- [with Enrico, Cyril, Théo] discussion on the needed changes in Coq to provide a tactic doing `Focus 1`
- [with Jim] presentation of his [PR #6801](https://github.com/coq/coq/pull/6801), discussion around ProofGeneral and demo of [company-coq](https://github.com/cpitclaudel/company-coq)
- [with Enrico, Gaëtan] discussion about the current infrastructure of Coq (w.r.t. CI and Docker)
- [with Maxime] discussions about native_compute that lead to Maxime's [PR #7646](https://github.com/coq/coq/pull/7646) that fixes [#4714](https://github.com/coq/coq/issues/4714)
- [with Maxime] experiments with [Set NativeCompute Profiling](https://coq.inria.fr/refman/proof-engine/tactics.html#coq:tacv.native-compute) that didn't work at first due to [#7631](https://github.com/coq/coq/issues/7631) (now fixed in [PR #7643](https://github.com/coq/coq/pull/7643)) and [#7673](https://github.com/coq/coq/issues/7673)
- and many fruitful discussions about interesting formalizations, important features for PG, etc.