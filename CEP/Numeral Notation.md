Numeral Notation is a new proposed vernac command. It allows any Coq user to define his own numeral types to be parsed and printed as strings of decimal digits, possibly prefixed by a minus sign (such as "0", "-42", "825"). There is an implementation of that, but before integrating it into the Coq sources, there are several decisions to take. But let us see what it is.

First, the type of "strings of decimal digits" has been named Z' (Z prime, there is an debate about this choice, see below). The vernacular command is the following:

     '''Numeral Notation''' t f g : t_scope { ('''printing''' <list of references>) } { ('''warning after''' <number>) }

 * t is the type,
 * f is a function of type "Z' -> option t"; when a string of digits is found in the scope of t, the function Z' is called; if its return is "Some v", the value is v; if it is "None", this is an error, for example "(-1)%nat",
 * g is either a function (of type "t -> option Z'"), or a Ltac (depending on the option '''printing''': see below),
 * t_scope is the scope of t,
 * the optional '''printing''' allows to specify a list of reference names to be printed; if t is an inductive type, it could be its constructors, or some of its constructors; if this option is absent, the default is all its constructors; in that case, g must be a function of type "t -> option Z'"; if t is not an inductive type, this list must be the names of the terms or functions (typically axioms) to be printed; for example, for the type R, it has been defined as "R0 R1 Rplus Rmult Ropp"; in that case, g must be an Ltac returning a value of type Z' or failing by "fail". If the result of g is "None" or "fail", the value is not printed as strings of digits.
 * the optional '''warning after''' is to print a warning if the string of digits represents a too big number; typically used for the type "nat" which is very expensive in memory resulting on stack overflow or memory fault if a too big value is given. For nat, it has been defined as 5000; Test "Check 5000%nat." (no warning) and "Check 5001%nat" (warning) on the toplevel.

This implementation has as objectives:

 * to try to be the most possible compatible with the current version (which used plugins written in OCaml), and
 * to give Coq users a useful feature.

== Debate ==

... (to be completed) ...
