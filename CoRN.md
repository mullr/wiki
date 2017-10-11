[Constructive Coq Repository at Nijmegen](http://c-corn.cs.ru.nl/)

FAQ about C-Corn
================

1.  In algebraic structures, why hava a separate structure for the axioms (as in [is\_CGroup](http://c-corn.cs.ru.nl/documentation/CoRN.algebra.CGroups.html#is_CGroup)) instead of putting the axioms with the group sturcture ([CGroup](http://c-corn.cs.ru.nl/documentation/CoRN.algebra.CGroups.html#CGroup))?

Sometimes the axiom structure is useful when an algebraic structure can be viewed as two different substructures. For example the additive structure of a [CRing](http://c-corn.cs.ru.nl/documentation/CoRN.algebra.CRings.html#CRing) [is an Abelian group](http://c-corn.cs.ru.nl/documentation/CoRN.algebra.CAbGroups.html#is_CAbGroup) and the multiplicative stucture [is a monoid](http://c-corn.cs.ru.nl/documentation/CoRN.algebra.CMonoids.html#is_CMonoid). By using a separate structure for the axioms, it is easy for the same stursture to share the same universe.

The same technique could be used to define a vector space as an Abelian group with a field action plus a distributive law.
