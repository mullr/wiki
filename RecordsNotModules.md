The main bulk of the modules and functor system can be replaced by dependent record types and functions instead.  Because of this, there is little reason to use modules other than to provide namespace support.  In fact, there are good reasons not to use modules.  Most importantly, module parameters cannot be instantiated with variables.  See `Carlos Simpson's post`_ to coq-club.

See Coq's standard library for examples of how to do this.

Note that the TypeClasses_ feature uses dependent records internally to provide modularity.  As of Coq 8.2, it is experimental.

.. ############################################################################

.. _Carlos Simpson's post: http://pauillac.inria.fr/pipermail/coq-club/2005/001757.html

.. _TypeClasses: ../TypeClasses

