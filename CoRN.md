`Constructive Coq Repository at Nijmegen`_

FAQ about C-Corn
----------------

1. In algebraic structures, why hava a separate structure for the axioms (as in is_CGroup_) instead of putting the axioms with the group sturcture (CGroup_)?

Sometimes the axiom structure is useful when an algebraic structure can be viewed as two different substructures.  For example the additive structure of a CRing_ `is an Abelian group`_ and the multiplicative stucture `is a monoid`_.  By using a separate structure for the axioms, it is easy for the same stursture to share the same universe.

The same technique could be used to define a vector space as an Abelian group with a field action plus a distributive law.

.. ############################################################################

.. _Constructive Coq Repository at Nijmegen: http://c-corn.cs.ru.nl/

.. _is_CGroup: http://c-corn.cs.ru.nl/documentation/CoRN.algebra.CGroups.html#is_CGroup

.. _CGroup: http://c-corn.cs.ru.nl/documentation/CoRN.algebra.CGroups.html#CGroup

.. _CRing: http://c-corn.cs.ru.nl/documentation/CoRN.algebra.CRings.html#CRing

.. _is an Abelian group: http://c-corn.cs.ru.nl/documentation/CoRN.algebra.CAbGroups.html#is_CAbGroup

.. _is a monoid: http://c-corn.cs.ru.nl/documentation/CoRN.algebra.CMonoids.html#is_CMonoid

