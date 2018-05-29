Workspace for the Profiling Coq work group at CIW2018

Objective: write down a tutorial on how to profile Coq to pin point the root cause of an inefficiency.

Plan: split the works in blocks, each with an expert and a tester. The expert documents/explains the tool then the tester validates the documentation and helps putting it in a decent form.


Blocks, sorted by "abstraction" level, descending.

Level: formalization style
- Recurrent problems: term comparison, unification, TC resolution
- Tools: ?, CI/pendulum(per-line-diff)
- Work around: locking, ...?
- Experts: enrico, matthieu
- Tester: anton

Level: Ltac
- Symptoms: slow ltac tactic
- Tools: ltacprof(proof-engine/ltac.rst), time?, Time, CI/pendulum(per-line-diff)
- Experts: enrico
- Tester:

Level: ML
- Problems: slow ML tactic
- Tools: lib/cProfile.ml
- Experts: enrico
- Task: unify ssrcommon.ml/mk_profile and lib/cProfile.ml
- Tester:

Level: VM
- Tools:
- Experts: maxime
- Tester: erik

Level: native compute
- Tools: perf
- Experts: maxime
- Tester:

Level: binary (eventual recompilation)
- Recurrent problems: slowness due to allocations/GC-cycles in tight loops
- Tools: perf + various OCaml branches
- Experts: pierre-marie (dev/doc/profiling.txt)
- Tester: