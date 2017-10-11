Coq 8.7 has a few incompatibilities with 8.6. We list the main sources of changes

Changes in Coq file
-------------------

* Change in the representation of constants in library *Reals*

  * Typical consequences: ``4`` is not any more ``2*2``, ``3`` is not any more ``2+1``, ``-1`` is now different from ``-(1)``

  * expressions of the form ``(-x)%R`` hide a non-simplifiable coercion ``IZR``; they do not simplify anymore; instead ``unfold IZR; rewrite <- INR_IPR``

  * ``auto with real`` now solve all inequations between constants (e.g. ``5<=7``)

* Fix of ``rewrite ... in *``

Changes in plugin
-----------------

There are may changes documented in ``dev/doc/changes.txt``. The one empirically requiring the most updating are the following:

* New level of abstraction ``EConstr``, documented in ``dev/doc/econstr.md``. Typical changes to do in plugins:

  * replacing ``open Term`` with ``open EConstr``

  * add a ``sigma`` to various functions now expecting it, e.g ``dependent`` (for old-style goals, get a ``sigma`` with ``Tacmach.project``)

  * replacing ``kind_of_term`` with ``kind sigma``

  * replacing ``Constr.equal`` with ``EConstr.eq_constr sigma``

  * change ``pr_lconstr`` into ``pr_leconstr``

  * change ``fold_constr`` with ``for_constr sigma``

* Few changes in the representation of ``constr_expr`` and related

  * ``CLetIn`` has now an explicit argument for the optional type

  * ``LocalRawAssum`` and ``LocalRawDef`` are now ``CLocalAssum`` and ``CLocalDef``

