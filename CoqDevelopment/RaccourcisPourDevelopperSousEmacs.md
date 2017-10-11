Some hints to accelerate the compilation process of Coq with Emacs
==================================================================

Shortcuts to put in ``.emacs`` to compile and locate errors "instantaneously":

::

   ;;; pressing F5 initiates the compilation session
   (global-set-key [f5] 'compile)
   ;;; pressing F6 restarts the current compilation
   (global-set-key [f6] 'recompile)
   ;;; pressing F7 locates the compilation errors
   (global-set-key [f7] 'next-error)

Script named ``makecoq`` to put in the ``path`` to compile Coq from any subdirectory and without recomputing the dependencies (you need first to remove the space before '#!')

::

    #!/bin/sh

   # ensure make messages are in English so that Emacs parse them correctly
   export LC_ALL=C

   case "$@" in 
     *-f\ *) true;;
     *-C\ *) true;;
     *)
     while [ ! \( -e GNUmakefile -o -e Makefile -o -e makefile -o "$PWD" = "/" \) ]; do
       cd ..
     done
     if [ ! \(  -e GNUmakefile -o -e Makefile -o -e makefile  \) ]; then
       echo No makefile found
       exit 1
     fi
   esac
      
   exec make NO_RECALC_DEPS=1 GOTO_STAGE_N=2 $@ | grep -v '\*\*\*\*\*\*\*\*'

Then, as soon ``emacs`` is open on some file, for example ``pretyping/unification.ml`` :

Press ``F5`` and, in the minibuffer, give either the following command:

::

     makecoq bin/coqtop.byte

or

::

     makecoq theories

or, to test only the first files of the library

::

     makecoq BEST=byte theories

Then, if the compilation fails, press ``F7`` which moves the cursor at the exact error location. When the error is fixed, press ``F6`` to restart the compilation, then ``F7``, fix, ``F6``, etc. until the compilation eventually succeeds.

The ``NO_RECALC_DEPS=1 GOTO_STAGE=2`` are here to shortcut the computation of dependencies. In practice, if the compilation fails for a dependency problem, I start a ``make stage2`` in a side terminal, just to redo the dependencies before continuing with ``F6``. If no ``.ml4`` is used to parse other ``.ml4``, the computation of dependencies can be done using ``make GOTO_STAGE=2 dummy``.

There are some errors that ``F7`` cannot locate. This is e.g. the case of ``Values do not match`` and this is due to ocaml which does not send a location for this error.

(thanks to JCF, PL and LM)

Compilation of the documentation
================================

To compile specific target of the documentation, start on ``Makefile.stage3``, as in:

::

     make -f Makefile.stage3 doc/refman/Reference-Manual.ps

