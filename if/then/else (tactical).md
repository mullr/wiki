::

      Tactic Notation
        "if" tactic(t)
        "then" tactic(t1)
        "else" tactic(t2) :=
        first [ t; first [ t1 | fail 2 ] | t2 ].

``if t then t1 else t2`` is equivalent to ``t; t1`` if ``t`` does not fail and is equivalent to ``t2`` otherwise. 

