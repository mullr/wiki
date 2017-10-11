One should never include proof terms in computationally meaningful Coq objects. This is because Coq has little or no support for reasoning under [ProofIrrelevance](../ProofIrrelevance). This means that inevitably, someone will need to prove that two Coq objects are equal and be angry that they cannot, because their proof terms are not shared.

If you face such problems, consider changes such as using `bool` rather than `sumbool`, `option` rather than `sumor` and avoiding the use of `sig`. Define signatures for your algebraic structures separately and use predicates (e.g. `IsGroup`, `IsRing`) in order to express their properties. Do not bundle setoid equalities with proofs that they are equivalence relations, or setoid morphisms with proofs that they are respectful.

For a general reference, see W Lovas, F Pfenning: *Refinement Types as Proof Irrelevance*.
