Do False, eq, and Acc have a special status?

Although these inductives are in Prop, their values can be eliminated while constructing objects of type Set.

This applies to all inductives of type Prop that are:

-   empty: without constructors (e.g. False)
-   singleton: having one single constructor, whose arguments (if any) are all of type Prop

See also the [Empty and singleton elimination](http://coq.inria.fr/doc/Reference-Manual006.html#@default316) from the manual.
