Math Classes
============

math-classes_ is a library of abstract interfaces for mathematical structures.

* Algebraic hierarchy (groups, rings, fields, ...)

* Relations, orders, ...

* Categories, functors, universal algebra, ...

* Numbers: NN, ZZ, QQ, ...

* Operations, ...

It's heavily based on Coq's new TypeClasses_ in order to archieve:

* elegant and mathematically sound abstract interfaces for algebraic and numeric structures up to and including rationals (with practical use of universal algebra and category theory);

* a very flexible purely predicate-based representation of algebraic structures that makes sharing, multiple inheritance, and derived inheritance, all trivial;

* clean expression terms that neither refer to proofs nor require deeply nested record projections;

* fluent rewriting;

* easy and flexible replacement and specialization of data representations and operations with more efficient versions;

* ordinary mathematical notation and overloaded names not reliant on Coq's notation scopes.

More information can be found here:

Presentation_ Paper_

You can find the latest code on github_

.. ############################################################################

.. _math-classes: https://math-classes.github.io/

.. _TypeClasses: ../TypeClasses

.. _Presentation: http://robbertkrebbers.nl/research/slides/typeclasses_paris.pdf

.. _Paper: http://arxiv.org/abs/1102.1323/

.. _github: https://github.com/math-classes/math-classes

