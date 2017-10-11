Prop vs Set
===========

There are several philosophies to follow to help you decide whether to make your type in Prop or in Set

How Many Objects Per Type Philosophy
------------------------------------

If your type could have two or more distiguishable objects, put it in `Set` otherwise put it in `Prop`. In Coq (without addtional axioms) extensionally equivalent functions are indistinguishable. According to this philosophy `(lt a b)` should be in `Prop` because there can be only one proof that *a* &lt; *b* for natural numbers. For (constructive) real number `a < b` should be in `Set` because in this case there are multiple proofs that *a* &lt; *b*. Indeed the (constructive) logarithm function, ln(*x*), requires a proof that 0 &lt; *x* to be in Set because the logarithm function requires a (constructive) proof that its argument is positive to operate. See the online documentation and publications for C-CoRN, which uses a special type `CProp` for computationally meaningful propositions.

The basis of this philosophy is that an object from a type with at most one object contributes no information, and therefore may safely be removed during program extraction.

A consequence of this philosophy is that `or` should never be used because `A \/ B` could have two objects even if `A` and `B` both only have at most one object. Instead, use `{A} + {B}` . Similar considerations apply to `exists`; use `{x:T | P}` instead. See [ExistsConsideredHarmful](../ExistsConsideredHarmful).

### Exists : from Prop to Set

Even if the existence of an object in Prop doesn't give a witness, we can write an algorithm to find it for some types. The main difficulty is to prove to Coq that the algorithm is correct and will terminate because we know that such a witness exists.

See [ExistsFromPropToSet](../ExistsFromPropToSet).
