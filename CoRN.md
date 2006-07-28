#language en

[http://c-corn.cs.kun.nl/ Constructive Coq Repository at Nijmegen]

== FAQ about C-Corn ==

1. In algebraic structures, why hava a separate structure for the axioms (as in [http://c-corn.cs.kun.nl/documentation/CoRN.algebra.CGroups.html#is_CGroup is_CGroup]) instead of putting the axioms with the group sturcture ([http://c-corn.cs.kun.nl/documentation/CoRN.algebra.CGroups.html#CGroup CGroup])?

Sometimes the axiom structure is useful when an algebraic structure can be viewed as two different substructures.  For example the additive structure of a [http://c-corn.cs.kun.nl/documentation/CoRN.algebra.CRings.html#CRing CRing] [http://c-corn.cs.kun.nl/documentation/CoRN.algebra.CAbGroups.html#is_CAbGroup is an Abelian group] and the multiplicative stucture [http://c-corn.cs.kun.nl/documentation/CoRN.algebra.CMonoids.html#is_CMonoid is a monoid].  By using a separate structure for the axioms, it is easy for the same stursture to share the same universe.

The same technique could be used to define a vector space as an Abelian group with a field action plus a distributive law.
