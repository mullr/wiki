= Status quo =
Systems currently running some sort of benchmarking, regression testing for Coq.

|| label        || URL                                                     || access || tests what          || comment ||
|| lix-bench    || [[http://www.lix.polytechnique.fr/coq/bench/|bench]]    || lix    || contribs (from git) ||         ||
|| lix-newbench || [[http://www.lix.polytechnique.fr/coq/pylons|newbench]] || lix    || -                   || down very often ||
|| inria-ci     || [[https://ci.inria.fr/coq/|jenkins]]                    || inria  || coq (from git)      ||         ||
|| opam-bench   || [[http://coq-bench.github.io/|opam-bench]]              || jobs on gihub, infrastructure ??? || opam packages || ||

= Problems =
The problems we have w.r.t. regression testing, that apply to one or many of the above.
"we" means people working on Coq, not necessarily in PPS, Inria, France, Europe...

 1. 4 systems, overlap, which is the reference?  Maybe 5, wasn't pyrolyse intended to be the bench system?
 1. access: we need to be able to access the compilation logs (possible with Jenkins)
 1. access: we need to be able to fix the bench system, at least for trivial errors (like it picks the wrong branch, coq_makefile refresh)
 1. reproducibility: understand why it fails (access to logs, maybe more), replicate on more hardware
 1. too slow (wait 24h for a run)
 1. ability to start a bench on demand and to start custom benches
 1. are the tests representative?
 1. only 1 big test (all contribs), all or nothing
 1. test a personal experiment without impacting the other developers
 1. single point of failure (only 1 gatekeeper)

= Desiderata =
Things that are desirable, not necessarily a problem:

 1. extend the bench with extra tools/scripts (graphs, etc...)
 1. extend the bench to produced precompiled artifacts (installers...)
   1. windows (ci.inria has it)
   1. osx (ci.inria does not have it)
