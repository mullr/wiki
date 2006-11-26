= Prop vs Set =

There are several philosophies to follow to help you decide whether to make your type in Prop or in Set

== How Many Objects Per Type Philosophy ==

If your type could have two or more distiguishable objects, put it in {{{Set}}} otherwise put it in {{{Prop}}}.  In Coq (without addtional axioms) extensionally equivalent functions are indistinguishable. According to this philosophy {{{(lt a b)}}} should be in {{{Prop}}} because there can be only one proof that ''a'' < ''b'' for natural numbers.  For (constructive) real number {{{a < b}}} should be in {{{Set}}} because in this case there are multiple proofs that ''a'' < ''b''.  Indeed the (constructive) logarithm function, ln(''x''), requires a proof that 0 < ''x'' to be in Set because the logarithm function requires a (constructive) proof that its arguement is positive to operate (anyone have a reference?).

The basis of this philosophy is that an object from a type with at most one object contributes no information, and therefore may safely be removed during program extraction.

A consequence of of this philosophy is that or should never be used because {{{A \/ B}}} could have to object even if {{{A}}} and {{{B}}} both only have at most one object. See ExistsConsideredHarmful.

=== Exists : from Prop to Set ===
Even if the existence of an object in Prop doesn't give a witness, we can write an algorithm to find it for some types.
The main difficulty is to prove to Coq that the algorithm is correct and will terminate because we know that such a witness exists.

See ExistsFromPropToSet.
