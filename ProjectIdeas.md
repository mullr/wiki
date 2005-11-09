Now that you know the basics of Coq you are itching to prove somthing.  Here are some ideas.

[[TableOfContents(1)]]

See also [http://www.cs.ru.nl/~freek/100/ Formalizing 100 Theorems]

= Fermat Last Theorem for n = 3 =

== Statement ==
{{{forall (x y z:Z), x^3 + y^3 = z^3 -> x=0 \/ y= 0 \/ z=0}}}

== Resources ==

See [http://fermatslasttheorem.blogspot.com/2005/05/fermats-last-theorem-proof-for-n3.html Fermat's Last Theorem: Proof for n=3].

== Estimated Difficulty ==

{*} {*} {o} {o} {o} ''(change the estimate if you disagree)''

== Bounties Offered ==
''(none)''

= Fermat Last Theorem =

== Statement ==
{{{forall (x y z:Z) (n:nat), x^(n+3) + y^(n+3) = z^(n+3) -> x=0 \/ y= 0 \/ z=0}}}

== Resources ==

Fermat's lat theorem has been proven in Coq for the ''n''=4 case.

== Estimated Difficulty ==

{*} {*} {*} {*} {*} ''(change the estimate if you disagree)''

== Bounties Offered ==
''(none)''
