Status quo
==========

Systems currently running some sort of benchmarking, regression testing for Coq.

\[Table not converted\]

Problems
========

The problems we have w.r.t. regression testing, that apply to one or many of the above. "we" means people working on Coq, not necessarily in PPS, Inria, France, Europe...

1.  4 systems, overlap, which is the reference? Maybe 5, wasn't pyrolyse intended to be the bench system?
2.  access: we need to be able to access the compilation logs (possible with Jenkins)
3.  access: we need to be able to fix the bench system, at least for trivial errors (like it picks the wrong branch, coq\_makefile refresh)
4.  reproducibility: understand why it fails (access to logs, maybe more), replicate on more hardware
5.  too slow (wait 24h for a run)
6.  ability to start a bench on demand and to start custom benches
7.  are the tests representative?
8.  only 1 big test (all contribs), all or nothing
9.  test a personal experiment without impacting the other developers
10. single point of failure (only 1 gatekeeper)

Desiderata
==========

Things that are desirable, not necessarily a problem:

1.  extend the bench with extra tools/scripts (graphs, etc...)
2.  extend the bench to produced precompiled artifacts (installers...)
    1.  windows (ci.inria has it)
    2.  osx (ci.inria does not have it)


