Numeral Notation is a new proposed vernac command. It allows any Coq user to define his own numeral types to be parsed and printed as strings of decimal digits, possibly prefixed by a minus sign (such as "0", "-42", "825"). There is an implementation of that, but before integrating it into the Coq sources, there are several decisions to take. But let us see what it is.

First, the type of "strings of decimal digits" has been named Z' (Z prime, there is an debate about this choice, see below). The vernacular command is the following:

 . '''Numeral Notation''' t f g : t_scope { ('''printing''' <list of references>) } { ('''warning after''' <number>) }

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

 * Z' is defined exactly like Z, with a positive' and constructors having having a quote. So why not using Z? Z' having to be defined very early in the Coq library (Datatypes.v), to be used in the definition of nat (Nat.v), we could move the definition of Z and positive into Datatypes.v and so, we do not have two definitions Z and Z'.

I think Z' should be kept, perhaps with another name, for the following reasons:

  1. For the mathematical point of view, there is no reason to define ℤ before ℕ. A mathematician using Coq would find this strange. For me, Coq is like a new Bourbaki, thinks must be clean as far a mathematics are concerned, and there is no reason to change this order of definitions just for a parsing and printing issue;

  2. Z' is now defined like Z, but it is not a definition of integers; it is a definition of string of decimal digits; it is necessary for programming issues, not for mathematical issues; its definition may change if we decide to be able to parse and print decimal numbers (e.g. 3.5), or even rings in general (e.g. polynomials), as it was suggested in the Coq working group;

  3. If we move the definition of Z into Datatypes.v, do we move also their associated comments explaining its implementation? Do we have to move all Z functions? Or kept them where they are now? In that case, Z definitions, functions, and proofs would be separated in different parts of the Coq library;

  4. Z is very important, Z' is a detail; they should not be considered as the same thing

 * It was suggested to define Numeral Notation for R differently, since the way integer numbers were coded for R was not good; I think that compatibility is important; if R users want reals integer numbers be parsed and printed differently, they can use their own "Numeral Notation" vernac command (in that case, it masks the "Numeral Notation" of the library), test if it is really better and later, we could adopt a new implementation of real integers.

 * The system have been implemented also for int31, bigN, bigZ and bigQ; actually, I think that they should eventually been excluded from this system, because for these types, there are very important issues for speed and memory usage; in this new implementation, there is a big difference (I tested for 10^1000) and it it 4 times slower than the previous version and I suspect this could be worse for bigger numbers.

 * Speed of parsing and printing for the other types (nat, Z, R) should be tested, but it depends whether Coq programmers use really big numbers of these types; if not, we could have this version which is probably slower that the previous one, but small compared to the other parts of Coq (e.g. tactics).
