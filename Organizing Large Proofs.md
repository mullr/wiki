This Coq-club thread_ contains an interesting discussion about how to stay oriented while doing large inductive proofs.  

Benjamin Pierce suggests using a `Case tactic`_ to mark your progress.

Since Coq version 8.2, the best way of organizing a large proof is probably using C-zar_, Coq's DeclarativeProof_ language [http://www.lix.polytechnique.fr/coq/distrib/current/refman/Reference-Manual014.html].  You can use ``escape`` and ``return`` commands to include a procedural block in a declarative script, or ``proof`` and ``end proof`` to nest a declarative proof block inside a procedural proof script.

.. ############################################################################

.. _thread: http://pauillac.inria.fr/pipermail/coq-club/2007/003006.html

.. _Case tactic: ../Case (tactic)

.. _C-zar: ../C-zar

.. _DeclarativeProof: ../DeclarativeProof

