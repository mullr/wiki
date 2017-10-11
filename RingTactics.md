::

   Require Export Ring.

ringsimpl
---------

The idea is to put all ring expressions occuring in the goal into normal form.  This tactic could use lots of improvement.

::

   Ltac ringsimpl :=
   match goal with
   | |- (_ ?a ?b) => ring a b
   | |- (?a ?b ?c) => try ringsimpl a; try ringsimpl b; try ringsimpl c
   end.

ringreplace
-----------

Instead of this tactic, you can now do ``replace a with b by ring`` in Coq.  Unfortuately this doesn't work for ``setoid_replace``.See also `TacticExts#LHS`_ for using replace with ``LHS`` and ``RHS``.

.. ############################################################################

.. _TacticExts#LHS: ../TacticExts#LHS

