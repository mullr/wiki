Now that you know the basics of Coq you are itching to prove something.  Here are some ideas.

[[TableOfContents(1)]]

See Top100MathematicalTheoremsInCoq and [http://www.cs.ru.nl/~freek/100/ Formalizing 100 Theorems]

= Fermat Last Theorem for n = 3 =

== Statement ==
{{{forall (x y z:Z), x^3 + y^3 = z^3 -> x=0 \/ y= 0 \/ z=0}}}

== Resources ==

See [http://fermatslasttheorem.blogspot.com/2005/05/fermats-last-theorem-proof-for-n3.html Fermat's Last Theorem: Proof for n=3].

[http://nshmyrev.narod.ru/temp/fermat4.tar.gz] start of the proof.

== Estimated Difficulty ==

{*} {*} {o} {o} {o} {o} {o} {o} ''(change the estimate if you disagree)''

== Bounties Offered ==
''(none)''

= Fermat Last Theorem =

== Statement ==
{{{forall (x y z:Z) (n:nat), x^(n+3) + y^(n+3) = z^(n+3) -> x=0 \/ y= 0 \/ z=0}}}

== Resources ==

Fermat's last theorem has been proven in Coq for the ''n''=4 case. The proof is available in UserContributions/CNAM/Fermat4/ .

See also, [http://www.cs.rug.nl/~wim/fermat/wilesEnglish.html Computer verification of Wiles' proof of Fermat's Last Theorem]

== Estimated Difficulty ==

{*} {*} {*} {*} {*} {*} {*} {*} ''(change the estimate if you disagree)''

== Bounties Offered ==
''(none)''

= Tarski's Undefinability of Truth =

== Informal Statement ==

The set of numbers which encode true sentences of number theory, is not definable as a predicate in number theory.

== Resources ==

This theorem should be a direct consequence of [http://coq.inria.fr/contribs/GodelRosser.html the Gödel-Rosser Incompleteness Theorem] as defined in the Coq contribution.

The idea is that if the truth predicate were definable, then the set of true statements in number theory would be form a consistent axiom system that is able to represent it's own axioms.  This contradicts the Gödel-Rosser Incompleteness Theorem.

However, Tarski's Undefinability of Truth may be easy enough to prove directly given the framework of the [http://coq.inria.fr/contribs/GodelRosser.html the Gödel-Rosser Incompleteness Development].
== Estimated Difficulty ==

{*} {*} {*} {o} {o} {o} {o} {o} ''(change the estimate if you disagree)''

== Bounties Offered ==
''(none)''

= Elliptic Curve Primality Proving =

This has now been completed.  See http://coqprime.gforge.inria.fr/

= Lusin Separation Theorem =

== Informal Statement ==

Any strongly disjoint pair of analytic sets is strongly Borel sepearable.

== Comments ==

Peter Aczel has a proof in constructive ZF.  It should be possible to translate this proof into type theory.

== Resources ==

 * http://foundations.cs.ru.nl/fndswiki/A_constructive_version_of_the_Lusin_Separation_Theorem

== Estimated Difficulty ==

{*} {*} {*} {*} {o} {o} {o} {o} ''(change the estimate if you disagree)''

= Conway's Cosmological Theorem =

== Informal Statement ==
The maximal length of an atom in the splitting of a 50-day-old 
string is 74. Every such atom decays, in at most 17 days, into stable 
or transuranic elements.

== Resources ==

[http://www.mathematik.uni-bielefeld.de/~sillke/SEQUENCES/series000]

== Estimated Difficulty ==

??? ''(change the estimate if you disagree)''

== Bounties Offered ==
''(none)''
