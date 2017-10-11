The ``Scheme`` command is used to generate mutual induction principles.

This_ excellent Coq-club post by Xavier Leroy explains best practices for mutual induction in Coq.

`A response`_ by Matthieu Sozeau to that post explains the use of ``Combined Scheme``, which is available in newer versions of Coq and addresses Leroy's critiques.

See also the Coq Reference Manual's `discussion and examples`_.

Section 14.3.3 of Coq'Art contains information on how to do mutual induction on inductive types which are NOT defined mutually (ie using "with").  This is important for polymorphic datatypes: for example, an inductive type with a constructor taking an argument which is the instantiation of the polymorphic list type at the inductive type being defined.  You can find this information on `google books`_

HugoHerbelin_ has posted some additional information about how "nested fix" works here http://article.gmane.org/gmane.science.mathematics.logic.coq.club/5280 see also http://article.gmane.org/gmane.science.mathematics.logic.coq.club/4125/match=more+nested+fixpoint+difficulties and http://article.gmane.org/gmane.science.mathematics.logic.coq.club/4144/match=generaling+parameteric+fixpoint+parameters and http://article.gmane.org/gmane.science.mathematics.logic.coq.club/4111/match=meta+theory+induction+over+terms+abstract+variables

.. ############################################################################

.. _This: http://mid.gmane.org/46B9E268.10503%40inria.fr

.. _A response: http://mid.gmane.org/38125.217.238.34.47.1186676839.squirrel%40www.lri.fr

.. _discussion and examples: https://coq.inria.fr/distrib/current/refman/Reference-Manual015.html

.. _google books: http://books.google.com/books?id=m5w5PRj5Nj4C&lpg=PA400&ots=VGsA_PW_0e&dq=coq%20%22list%20of%20trees%22&pg=PA404#v=onepage&q=coq%20%22list%20of%20trees%22&f=false

.. _HugoHerbelin: ../HugoHerbelin

