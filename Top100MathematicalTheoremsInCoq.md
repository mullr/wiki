
#### 1: The Irrationality of the Square Root of 2
`Theorem sqrt2_not_rational : forall p q : nat, q <> 0 -> p * p = 2 * (q * q) -> False.`

See: UserContributions/Nijmegen/QArithSternBrocot/sqrt2.v

`~exists n, exists p, n ^2 = 2* p^2 /\ n <> 0`

See: [SquareRootTwo](SquareRootTwo)

#### 2: Fundamental Theorem of Algebra
`Lemma FTA : forall f : CCX, nonConst _ f -> {z : CC | f ! z [=] Zero}.`

`Lemma FTA_a_la_Henk : forall f : CCX, {x : CC | {y : CC | AbsCC (f ! x[-]f ! y) [>]Zero}} -> {z : CC | f ! z [=] Zero}.`

See: UserContributions/Nijmegen/CoRN/fta/FTA.v

#### 3: The Denumerability of the Rational Numbers
`Theorem Q_is_denumerable: is_denumerable Q.`

*where*

```
Definition is_denumerable A := same_cardinality A nat.
Definition same_cardinality (A B:Set):= {f:A->B & { g:B->A |
  (forall b,(compose _ _ _ f g) b= (identity B) b) /\
   forall a,(compose _ _ _ g f) a = (identity A) a}}.
```

See: UserContributions/Nijmegen/QArithSternBrocot/Q\_denumerable.v

#### 4: Pythagorean Theorem
`Theorem Pythagore : forall A B C : PO, orthogonal (vec A B) (vec A C) <-> Rsqr (distance B C) = Rsqr (distance A B) + Rsqr (distance A C) :>R.`

See: UserContributions/Sophia-Antipolis/geometry

#### 5: Gödel's Incompleteness Theorem
`forall T : System, Included Formula NN T -> RepresentsInSelf T -> DecidableSet Formula T -> { f : Formula | (Sentence f) /\ ({SysPrf T f} + {SysPrf T (notH f)} -> Inconsistent LNN T)}`

See: UserContributions/Berkeley/Godel

#### 11: The Infinitude of Primes 
`~(EX l:(list Prime) | (p:Prime)(In p l))`

See: [NotFinitePrimes](NotFinitePrimes)

#### 13: Polyhedron Formula
`Theorem Euler_Poincare_criterion: forall m:fmap, inv_qhmap m -> (plf m <-> ec m / 2 = nc m).`

See: UserContributions/Strasbourg/EulerFormula

#### 15: Fundamental Theorem of Integral Calculus
`Lemma FTC1 : forall (J : interval) (F : PartFunct IR) (contF : Continuous J F) (x0 : IR) (Hx0 : J x0) (pJ : proper J), Derivative J pJ (([-S-]contF) x0 Hx0) F`

`Lemma FTC2 : forall (J : interval) (F : PartFunct IR) (contF : Continuous J F) (x0 : IR) (Hx0 : J x0) (pJ : proper J) (G0 : PartFunct IR), Derivative J pJ G0 F -> {c : IR | Feq J (([-S-]contF) x0 Hx0{-}G0) [-C-]c}`

`Lemma Barrow : forall (J : interval) (F : PartFunct IR), Continuous J F -> forall (pJ : proper J) (G0 : PartFunct IR) (derG0 : Derivative J pJ G0 F) (a b : IR) (H : Continuous_I (Min_leEq_Max a b) F) (Ha : J a) (Hb : J b), let Ha' := Derivative_imp_inc J pJ G0 F derG0 a Ha in let Hb' := Derivative_imp_inc J pJ G0 F derG0 b Hb in Integral H[=]G0 b Hb'[-]G0 a Ha'`

See: UserContributions/Nijmegen/CoRN

#### 17: De Moivre's Theorem
See: UserContributions/Sophia-Antipolis

#### 18: Liouville's Theorem and the Construction of Transcendental Numbers
See: UserContributions/Nijmegen/CoRN

#### 20: All Primes Equal the Sum of Two Squares
`forall n, 0 <= n -> (forall p, prime p -> Zis_mod p 3 4 ->  Zeven (Zdiv_exp p n)) -> sum_of_two_square n`

See: UserContributions/Sophia-Antipolis/SumOfTwoSquare

#### 23: Formula for Pythagorean Triples
`Lemma pytha_thm1 : forall a b c : Z, (is_pytha a b c) -> (pytha_set a b c).`

`Lemma pytha_thm2 : forall a b c : Z, (pytha_set a b c) -> (is_pytha a b c).`

See: [UserContributions/CNAM/Fermat4](http://coq.inria.fr/contribs/Fermat4.html) (File Pythagorean.v) by [D. Delahaye](http://cedric.cnam.fr/~delahaye/) and [M. Mayero](http://www-lipn.univ-paris13.fr/~mayero/) |

#### 25: Schroeder-Bernstein Theorem
`forall A B:Ensemble U, A <=_card B -> B <=_card A -> A =_card B.`

See: UserContributions/Rocq/SCHROEDER

#### 26: Leibnitz's Series for Pi 
See: UserContributions/Nijmegen/CoRN

#### 27: Sum of the Angles of a Triangle
See: UserContributions/Sophia-Antipolis/

#### 29: Feuerbach's Theorem
`forall A B C A1 B1 C1 O A2 B2 C2 O2:point, forall r r2:R, X A = 0 -> Y A = 0 -> X B = 1 -> Y B = 0-> middle A B C1 -> middle B C A1 -> middle C A B1 -> distance2 O A1 = distance2 O B1 -> distance2 O A1 = distance2 O C1 -> collinear A B C2 -> orthogonal A B O2 C2 -> collinear B C A2 -> orthogonal B C O2 A2 -> collinear A C B2 -> orthogonal A C O2 B2 -> distance2 O2 A2 = distance2 O2 B2 -> distance2 O2 A2 = distance2 O2 C2 -> r^2 = distance2 O A1 -> r2^2 = distance2 O2 A2 -> distance2 O O2 = (r + r2)^2 \/ distance2 O O2 = (r - r2)^2 \/ collinear A B C.`

See: <http://www-sop.inria.fr/marelle/CertiGeo/feuerbach.html>

#### 32: The Four Color Problem
See: Georges Gonthier <http://research.microsoft.com/~gonthier/>

#### 35: Taylor's Theorem
`Lemma Taylor : forall (I : interval) (pI : proper I) (F : PartFunct IR) (n : nat) (f : forall i : nat, i < S n -> PartFunct IR) (derF : forall (i : nat) (Hi : i < S n), Derivative_n i I pI F (f i Hi)) (F' : PartFunct IR), Derivative_n (S n) I pI F F' -> forall (a b : IR) (Ha : I a), I b -> forall e : IR, Zero[<]e -> forall Hb' : Dom F b, {c : IR | Compact (Min_leEq_Max a b) c | forall Hc : Dom (F'{*}[-C-](One[/]nring (fac n)[//]nring_fac_ap_zero IR n){*} ([-C-]b{-}FId){^}n) c, AbsIR (F b Hb'[-] Taylor_Seq I pI F n f derF a Ha b (Taylor_aux I pI F n f derF a b Ha)[-] (F'{*}[-C-](One[/]nring (fac n)[//]nring_fac_ap_zero IR n){*} ([-C-]b{-}FId){^}n) c Hc[*](b[-]a))[<=]e}`

See: UserContributions/Nijmegen/CoRN

#### 44: Binomial Theorem
`(a + b) ^ n = \sum_(i < n.+1) (bin n i * (a ^ (n - i) * b ^ i))`

See: <http://coqfinitgroup.gforge.inria.fr/binomial.html#exp_pascal>

#### 49: Cayley-Hamilton Theorem
Every square matrix is a root of its characteristic polynomial : `forall A, (Zpoly (char_poly A)).[A] = 0`

See: Math Components Project : <http://coqfinitgroup.gforge.inria.fr/charpoly.html#Cayley_Hamilton>

#### 51: Wilson's Theorem
`forall p, prime p ->  Zis_mod (Zfact (p - 1)) (- 1) p`

See: UserContributions/Sophia-Antipolis/
                  
`forall p, 1 < p -> (prime p <-> p % (fact (p.-1)).+1)`

See: <http://coqfinitgroup.gforge.inria.fr/binomial.html#wilson>

#### 52: The Number of Subsets of a Set

See: ??

#### 55: Product of Segments of Chords
`forall A B C D M O:point, samedistance O A O B ->  samedistance O A O C ->  samedistance O A O D -> collinear A B M ->  collinear C D M ->` `(distance M A)*(distance M B)=(distance M C)*(distance M D)  \/ parallel A B C D.`

See: to appear next...

#### 60: Bezout's Theorem 
See: StandardLibrary/Coq.ZArith.Znumtheory 
                  
`forall m n, m > 0 -> {a | a < m & m %| gcdn m n + a * n}`

`forall m n, n > 0 -> {a | a < n & n %| gcdn m n + a * m}`

See: <http://coqfinitgroup.gforge.inria.fr/div.html#bezoutl>

#### 57: Heron formula
`Theorem herron_qin : forall A B C, S A B C * S A B C = 1 / (2*2*2*2) * (Py A B A * Py A C A - Py B A C * Py B A C).`

See:  UserContributions/Rocq/AreaMethod/

#### 61: Theorem of Ceva
`Theorem Ceva : forall A B C D E F G P : Point, inter_ll D B C A P -> inter_ll E A C B P -> inter_ll F A B C P -> F <> B -> D <> C -> E <> A -> parallel A F F B -> parallel B D D C -> parallel C E E A -> (A** F / F ** B * (B ** D / D** C) * (C ** E / E** A) = 1.`

See: UserContributions/Rocq/AreaMethod 

#### 65: Isosceles Triangle Theorem
See: UserContributions/Sophia-Antipolis UserContributions/Rocq/AreaMethod

#### 66: Sum of a Geometric Series
`Lemma power_series_conv : forall c : IR, AbsIR c[<]One -> convergent (power_series c)`
 
`Lemma power_series_sum : forall c : IR, AbsIR c[<]One -> forall (H : Dom (f_rcpcl' IR) (One[-]c)) (Hc0 : convergent (power_series c)), series_sum (power_series c) Hc0[=](One[/]One[-]c[//]H)`

See: UserContributions/Nijmegen/CoRN 

#### 69: Greatest Common Divisor Algorithm

See: StandardLibrary/Coq.ZArith.Znumtheory

#### 71: Order of a Subgroup
`forall (gT : finGroupType) (G H : {group gT}),  H :<=: G -> (#|H| * #|G : H|)%N = #|G|`

See: <http://coqfinitgroup.gforge.inria.fr/groups.html#LaGrange>

#### 72: Sylow Theorem
`Lemma Sylow_exists: forall (p : nat) (gT : finGroupType) (G : {group gT}), {P : {group gT} | p.-Sylow(G) P}`
 
`Lemma Sylow_subj: forall (p : nat) (gT : finGroupType) (G P Q : {group gT}),` `p.-Sylow(G) P -> Q :<=: G -> p.-group Q -> exists2 x : gT, x \in G & Q :<=: P :^ x`

`Lemma card_Syl_dvd : forall (p : nat) (gT : finGroupType) (G : {group gT}), #|'Syl_p(G)| %| #|G|`

`Lemma card_Syl_mod : forall (p : nat) (gT : finGroupType) (G : {group gT}), prime p -> #|'Syl_p(G)| %% p = 1`

See: <http://coqfinitgroup.gforge.inria.fr/sylow.html>

#### 74: The Principle of Mathematical Induction
`forall P : nat -> Prop,  P 0 -> (forall n : nat, P n -> P (S n)) ->` `forall n : nat, P n`

See: [StandardLibrary](StandardLibrary)

#### 75: The Mean Value Theorem
`Lemma Law_of_the_Mean : forall (I : interval) (pI : proper I) (F F' : PartFunct IR), Derivative I pI F F' -> forall a b : IR, I a -> I b -> forall e : IR, Zero[<]e -> {x : IR | Compact (Min_leEq_Max a b) x | forall (Ha : Dom F a) (Hb : Dom F b) (Hx : Dom F' x), AbsIR (F b Hb[-]F a Ha[-]F' x Hx[*](b[-]a))[<=]e} Lemma Law_of_the_Mean_ineq : forall (I : interval) (pI : proper I) (F F' : PartFunct IR), Derivative I pI F F' -> forall a b : IR, I a -> I b -> forall c : IR, (forall x : IR, Compact (Min_leEq_Max a b) x -> forall Hx : Dom F' x, AbsIR (F' x Hx)[<=]c) -> forall (Ha : Dom F a) (Hb : Dom F b), F b Hb[-]F a Ha[<=]c[*]AbsIR (b[-]a)`

See: UserContributions/Nijmegen/CoRN

#### 79: The Intermediate Value Theorem
`Lemma Civt_op : forall f : CSetoid_un_op IR, contin f -> (forall a b : IR, a[<]b -> {c : IR | a[<=]c /\ c[<=]b | f c[#]Zero}) -> forall a b : IR, a[<]b -> f a[<=]Zero -> Zero[<=]f b -> {z : IR | a[<=]z /\ z[<=]b /\ f z[=]Zero}`

See: UserContributions/Nijmegen/CoRN

#### 80: The Fundamental Theorem of Arithmetic

See: UserContributions/Eindhoven/POCKLINGTON

#### 87: Desargues's Theorem
`Theorem Desargues : forall A B C X A' B' C' : Point, A' <>C' -> A' <> B' -> on_line A' X A -> on_inter_line_parallel B' A' X B A B -> on_inter_line_parallel C' A' X C A C -> parallel B C B' C'.`

See: UserContributions/Rocq/AreaMethod UserContributions/Sophia-Antipolis/geometry

#### 89: The Factor and Remainder Theorems

See: [StandardLibrary](StandardLibrary)

#### 94: The Law of Cosines

See: UserContributions/Sophia-Antipolis/

#### 95: Ptolemy's theorem

See: extension of UserContributions/Sophia-Antipolis/geometry/

#### 97: Cramer's rule
`forall (R : comRingType) (n : nat) (A : matrix R n n), A *m \adj A = \Z (\det A)`

See: Math Components Project : <http://coqfinitgroup.gforge.inria.fr/matrix.html#mulmx_adjr>

#### 98: Bertrand’s Postulate
`forall n : nat, 2 <= n -> exists p : nat, prime p /\ n < p /\ p < 2 * n`

See: UserContributions/Sophia-Antipolis/Bertrand


## Notes

-   The theorems regarding angles or triangles are proved in one of the two UserContributions/Sophia-Antipolis/geometry or UserContributions/Sophia-Antipolis/Angles (please specify if you know which contrib package contains them).
-   The Ranks are taken from the original list of [Top100MathematicalTheorems](Top100MathematicalTheorems).
-   See Also <http://www.cs.ru.nl/~freek/100/>

