Status quo
==========

Systems currently running some sort of benchmarking, regression testing for Coq.

[Table not converted]

Problems
========

The problems we have w.r.t. regression testing, that apply to one or many of the above. "we" means people working on Coq, not necessarily in PPS, Inria, France, Europe...

1. 4 systems, overlap, which is the reference?  Maybe 5, wasn't pyrolyse intended to be the bench system?

#. access: we need to be able to access the compilation logs (possible with Jenkins)

#. access: we need to be able to fix the bench system, at least for trivial errors (like it picks the wrong branch, coq_makefile refresh)

#. reproducibility: understand why it fails (access to logs, maybe more), replicate on more hardware

#. too slow (wait 24h for a run)

#. ability to start a bench on demand and to start custom benches

#. are the tests representative?

#. only 1 big test (all contribs), all or nothing

#. test a personal experiment without impacting the other developers

#. single point of failure (only 1 gatekeeper)

Desiderata
==========

Things that are desirable, not necessarily a problem:

1. extend the bench with extra tools/scripts (graphs, etc...)

#. extend the bench to produced precompiled artifacts (installers...)

   1. windows (ci.inria has it)

   #. osx (ci.inria does not have it)

   .. ############################################################################

   .. _bench: http://www.lix.polytechnique.fr/coq/bench/

   .. _newbench: http://www.lix.polytechnique.fr/coq/pylons

   .. _jenkins: https://ci.inria.fr/coq/

   .. _opam-bench: http://coq-bench.github.io/

