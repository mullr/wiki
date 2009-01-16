#language en
||Rank || Theorem || Statement || Formalisation available from ||
||<|2>1 ||<|2> The Irrationality of the Square Root of 2 || {{{Theorem sqrt2_not_rational : forall p q : nat, q <> 0 -> p * p = 2 * (q * q) -> False.}}} || UserContributions/Nijmegen/QArithSternBrocot/sqrt2.v||
|| {{{  ~exists n, exists p, n ^2 = 2* p^2 /\ n <> 0}}} || SquareRootTwo ||
|| 2 || Fundamental Theorem of Algebra || {{{Lemma FTA : forall f : CCX, nonConst _ f -> {z : CC | f ! z [=] Zero}.}}} <<BR>> {{{Lemma FTA_a_la_Henk : forall f : CCX, {x : CC | {y : CC | AbsCC (f ! x[-]f ! y) [>]Zero}} -> {z : CC | f ! z [=] Zero}.}}} || UserContributions/Nijmegen/CoRN/fta/FTA.v||
|| 3 ||The Denumerability of the Rational Numbers ||{{{Theorem Q_is_denumerable: is_denumerable Q.}}} <<BR>> ''where''<<BR>> {{{Definition is_denumerable A := same_cardinality A nat.}}} <<BR>>{{{Definition same_cardinality (A B:Set):= {f:A->B & { g:B->A |}}} <<BR>> {{{ (forall b,(compose _ _ _ f g) b= (identity B) b) /\ forall a,(compose _ _ _ g f) a = (identity A) a}}.}}}|| UserContributions/Nijmegen/QArithSternBrocot/Q_denumerable.v||
|| 4 || Pythagorean Theorem || ??? ||  UserContributions/Sophia-Antipolis/geometry ||
|| 6 || Gödel's Incompleteness Theorem || {{{ forall T : System, Included Formula NN T -> RepresentsInSelf T -> DecidableSet Formula T -> }}} {{{ }}} {{{{ f : Formula | (Sentence f) /\ ({SysPrf T f} + {SysPrf T (notH f)} -> Inconsistent LNN T)} }}} ||UserContributions/Berkeley/Godel ||
||11 || The Infinitude of Primes || {{{~(EX l:(list Prime) | (p:Prime)(In p l))}}} || NotFinitePrimes ||
||15 || Fundamental Theorem of Integral Calculus ||  ??? || UserContributions/Nijmegen/CoRN ||
||17 || De Moivre's Theorem || ??? || UserContributions/Sophia-Antipolis/ ||
||20 || All Primes Equal the Sum of Two Squares ||   {{{forall n, 0 <= n -> (forall p, prime p -> Zis_mod p 3 4 ->  Zeven (Zdiv_exp p n)) -> sum_of_two_square n}}} ||UserContributions/Sophia-Antipolis/SumOfTwoSquare ||
||23 || Formula for Pythagorean Triples || {{{Lemma pytha_thm1 : forall a b c : Z, (is_pytha a b c) -> (pytha_set a b c).}}} {{{Lemma pytha_thm2 : forall a b c : Z, (pytha_set a b c) -> (is_pytha a b c).}}} || [[http://coq.inria.fr/contribs/Fermat4.html|UserContributions/CNAM/Fermat4]] (File Pythagorean.v) by ''[[http://cedric.cnam.fr/~delahaye/|D. Delahaye]]'' and ''[[http://www-lipn.univ-paris13.fr/~mayero/|M. Mayero]]'' ||
||25 || Schroeder--Bernstein Theorem || ??? || UserContributions/Rocq /SCHROEDER ||
||26 || Leibnitz's Series for Pi || ??? || UserContributions/Nijmegen/CoRN ||
||27 || Sum of the Angles of a Triangle ||  ??? ||UserContributions/Sophia-Antipolis/ ||
||32 || The Four Color Problem || ??? || GeorgesGonthier http://research.microsoft.com/~gonthier/ ||
||35 || Taylor's Theorem || ??? || UserContributions/Nijmegen/CoRN ||
||44 || Binomial Theorem || {{{(a + b) ^ n = \sum_(i < n.+1) (bin n i * (a ^ (n - i) * b ^ i))}}} || http://coqfinitgroup.gforge.inria.fr/||
||49 || Cayley-Hamilton Theorem || Every square matrix is a root of its characteristic polynomial : {{{forall A, (Zpoly (char_poly A)).[A] = 0}}} || Math Components Projects : http://coqfinitgroup.gforge.inria.fr/ ||
||<|2> 51 ||<|2> Wilson's Theorem || {{{forall p, prime p ->  Zis_mod (Zfact (p - 1)) (- 1) p}}} || UserContributions/Sophia-Antipolis/ ||
||{{{forall p, 1 < p -> (prime p <-> p %| (fact (p.-1)).+1)}}} || http://coqfinitgroup.gforge.inria.fr/ ||
||52 ||The Number of Subsets of a Set || ??? || ??? ||
||55 || Product of Segments of Chords || {{{forall A B C D M O:point, samedistance O A O B ->  samedistance O A O C ->  samedistance O A O D ->  collinear A B M ->  collinear C D M -> }}} {{{ (distance M A)*(distance M B)=(distance M C)*(distance M D)  \/ parallel A B C D. }}} || to appear next... ||
||<|2>60 ||<|2> Bezout's Theorem || ??? || StandardLibrary/Coq.ZArith.Znumtheory ||
|| {{{forall m n, m > 0 -> {a | a < m & m %| gcdn m n + a * n} }}} <<BR>> {{{forall m n, n > 0 -> {a | a < n & n %| gcdn m n + a * m} }}}|| http://coqfinitgroup.gforge.inria.fr/ ||
||61 || Theorem of Ceva ||  ??? ||UserContributions/Sophia-Antipolis/ ||
||65 || Isosceles Triangle Theorem ||  ??? ||UserContributions/Sophia-Antipolis/ ||
||66 || Sum of a Geometric Series ||  ??? ||UserContributions/Nijmegen/CoRN ||
||69 || Greatest Common Divisor Algorithm ||  ??? ||StandardLibrary/Coq.ZArith.Znumtheory ||
||71 || Order of a Subgroup ||??? || ||
||74 || The Principle of Mathematical Induction || {{{forall P : nat -> Prop,  P 0 -> (forall n : nat, P n -> P (S n)) ->}}} {{{ forall n : nat, P n}}}|| StandardLibrary ||
||75 || The Mean Value Theorem || ??? || UserContributions/Nijmegen/CoRN ||
||79 || The Intermediate Value Theorem || ??? || UserContributions/Nijmegen/CoRN ||
||80 || The Fundamental Theorem of Arithmetic || ??? || UserContributions/Eindhoven/POCKLINGTON ||
||87 || Desargues's Theorem ||  ??? ||UserContributions/Sophia-Antipolis/geometry ||
||89 || The Factor and Remainder Theorems ||  ??? || StandardLibrary ||
||94 || The Law of Cosines || ??? || UserContributions/Sophia-Antipolis/ ||
||98 || Bertrand’s Postulate || {{{forall n : nat, 2 <= n -> exists p : nat, prime p /\ n < p /\ p < 2 * n}}} || UserContributions/Sophia-Antipolis/Bertrand ||


----
 * The theorems regarding angles or triangles are proved in one of the two UserContributions/Sophia-Antipolis/geometry or UserContributions/Sophia-Antipolis/Angles (please specify if you know which contrib package contains them).

 * The Ranks are taken from the original list of Top100MathematicalTheorems.

 * See Also http://www.cs.ru.nl/~freek/100/
