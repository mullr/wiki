What happens at the Coq Coding Sprint
=====================================

This page is to log all the activities done during the Coq Implementors Workshop.  Please put here links to the bugs you've fixed, to the git repository containing your plugin or your experimental branch.

Monday 12
~~~~~~~~~

* Intro talk by Matthieu

* Matthieu: Unification, universes in template-coq and CONTRIBUTING

* Nicolas, Thierry no particular projects

* Abhishek: unused variables test and universes in template-coq

* Emilio: Few minor PRs.

Tuesday 13
~~~~~~~~~~

* Emilio: Talk about UI; spend afternoon discussing about side-effects and STM init. Ported ELPI to jsCoq.

Wednesday 14
~~~~~~~~~~~~

* Kathrin Stark and Abhishek Anand : `plugin to efficiently reduce away a var`_

* Yannick Forster and Abhishek Anand : `universes in template-coq ported to trunk`_

Thursday 15
~~~~~~~~~~~

* Emilio: Code coverage report: https://x80.org/coq2017/report/

Friday 16
~~~~~~~~~

Abhishek: Tested_ the above-mentioned "reduce away var" plugin to strengthen a free theorem produced by paramcoq-iff. The above plugin removes a hypothesis in 0.8s. Using coq's [lazy] tactic takes 30s.

.. ############################################################################

.. _plugin to efficiently reduce away a var: https://github.com/aa755/example-plugin

.. _universes in template-coq ported to trunk: https://github.com/yforster/template-coq/tree/trunk_june_17

.. _Tested: https://github.com/aa755/paramcoq-iff/commit/e792fde761a7e527d6cbf794212021b859c5fc10

