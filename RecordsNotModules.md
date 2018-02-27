The main bulk of the modules and functor system can be replaced by dependent record types and functions instead. Because of this, there is little reason to use modules other than to provide namespace support. In fact, there are good reasons not to use modules. Most importantly, module parameters cannot be instantiated with variables. See [Carlos Simpson's post](https://sympa.inria.fr/sympa/arc/coq-club/2005-03/msg00031.html) to coq-club.

See Coq's standard library for examples of how to do this.

Note that the [TypeClasses](TypeClasses) feature uses dependent records internally to provide modularity.
