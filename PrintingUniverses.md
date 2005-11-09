Printing Universes
==================

Coq 8.2
-------

From Coq version 8.2, you can use the corresponding entry of the Display menu of CoqIDE.

Coq 8.1
-------

From Coq version 8.1, ``Type`` universes in terms can be displayed by toggling the ``Set Printing Universes`` command and universes constraints can be displayed using the ``Print Universes`` command (more in the `Reference Manual`_).

Subsequently, the ``Print [term]`` command will annotate it's output with universes levels.  For instance

::

   Coq < Set Printing Universes.
   Coq < Print prod.
   Inductive prod
                 (A : Type (* Coq.Init.Datatypes.22 *))
                 (B : Type (* Coq.Init.Datatypes.22 *))
               : Type (* Coq.Init.Datatypes.22 *) :=  pair : A -> B -> A * B

Coq 8.0
-------

In Coq versions 8.0 and 8.0pl1 to 8.0pl4, the following tricks can be used instead.

In Coq versions 8.0, 8.0pl1 and 8.0pl2, you should modify the source of Coq:

In the file ``$COQTOP/translate/ppconstrnew.ml`` replace

::

   let pr_universe u = str "<univ>"

with

::

   let pr_universe = Univ.pr_uni

Then in the file ``$COQTOP/interp/constrextern.ml`` replace

::

   let print_universes = ref false

with

::

   let print_universes = ref true

Now you should recompile Coq. After recompiling the universes will be printed. You can use 

::

   Dump Universes.

 to see a graph of universes. In fact, the ``Dump Universes`` command above also works without changing the source code, but in this case it is less helpful. See also, ``$COQTOP/dev/universes.txt`` file in your local installation for a documentation of this feature.

In Coq versions 8.0pl3 and 8.0pl4 ``pr_universe = Univ.pr_uni`` by default so you don't need to change that, however, if you want the universes to *always* be printed then you should still change ``print_universe`` as above and recompile. For temporarily printing universes see ``$COQTOP/dev/universes.txt``.

.. ############################################################################

.. _Reference Manual: http://coq.inria.fr/V8.1/refman/Reference-Manual004.html#toc21
