Project Ideas
=============

Now that you know the basics of Coq you are itching to prove something. Here are some ideas.

Other than formalizing existing proofs, one useful exercise is to update some of Coq's user-contributed libraries so that they build on the recent additions in the Coq [StandardLibrary](StandardLibrary) rather than their own foundations.

See [Top100MathematicalTheoremsInCoq](Top100MathematicalTheoremsInCoq) and [Formalizing 100 Theorems](http://www.cs.ru.nl/~freek/100/)

Fermat Last Theorem for n = 3
-----------------------------

### Statement

`forall (x y z:Z), x^3 + y^3 = z^3 -> x=0 \/ y= 0 \/ z=0`

### Resources

See [Fermat's Last Theorem: Proof for n=3](http://fermatslasttheorem.blogspot.com/2005/05/fermats-last-theorem-proof-for-n3.html).

<http://nshmyrev.narod.ru/temp/fermat4.tar.gz> start of the proof.

### Estimated Difficulty

|{*}| |{*}| |{o}| |{o}| |{o}| |{o}| |{o}| |{o}| *(change the estimate if you disagree)*

### Bounties Offered

*(none)*

Fermat Last Theorem
-------------------

### Statement

`forall (x y z:Z) (n:nat), x^(n+3) + y^(n+3) = z^(n+3) -> x=0 \/ y= 0 \/ z=0`

### Resources

Fermat's last theorem has been proven in Coq for the *n*=4 case. The proof is available in UserContributions/CNAM/Fermat4/ .

See also, [Computer verification of Wiles' proof of Fermat's Last Theorem](http://www.cs.rug.nl/~wim/fermat/wilesEnglish.html)

### Estimated Difficulty

|{*}| |{*}| |{*}| |{*}| |{*}| |{*}| |{*}| |{*}| *(change the estimate if you disagree)*

### Bounties Offered

*(none)*

Lusin Separation Theorem
------------------------

### Informal Statement

Any strongly disjoint pair of analytic sets is strongly Borel sepearable.

### Comments

Peter Aczel has a proof in constructive ZF. It should be possible to translate this proof into type theory.

### Resources

-   <http://foundations.cs.ru.nl/fndswiki/A_constructive_version_of_the_Lusin_Separation_Theorem>

### Estimated Difficulty

|{*}| |{*}| |{*}| |{*}| |{o}| |{o}| |{o}| |{o}| *(change the estimate if you disagree)*

Conway's Cosmological Theorem
-----------------------------

### Informal Statement

The maximal length of an atom in the splitting of a 50-day-old string is 74. Every such atom decays, in at most 17 days, into stable or transuranic elements.

### Resources

<http://www.cs.cmu.edu/~kw/pubs/conway.pdf> <http://www.mathematik.uni-bielefeld.de/~sillke/SEQUENCES/series000>

### Estimated Difficulty

??? *(change the estimate if you disagree)*

### Bounties Offered

*(none)*

Completed Projects
==================

Tarski's Undefinability of Truth
--------------------------------

This has now been completed by Wouter Stekelenburg.

Elliptic Curve Primality Proving
--------------------------------

This has now been completed. See <http://coqprime.gforge.inria.fr/>
