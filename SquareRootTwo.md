The plain language proof is as follows,
''if there is an n such that for some p, n^2^ = 2p^2^, then let's take the least positive such n and
the corresponding positive p,  in this case we have (i) (2p-n)^2^=2(n-p)^2^ and (ii) (2p-n) < n, thus a contradiction.''

The key to the proof is algebraic computation to obtain (i) and solving systems of inequations to obtain (ii).
These can be done very quickly using the "micromega" tactic proposed in "http://www.irisa.fr/lande/fbesson/fbesson.html".

We give two solutions, first a solution that uses micromega, and second a solution that uses only tactics that are
provided in standard Coq V8.1.

{{{#!coq
Require Import ZArith Zwf Micromegatac QArith.
Open Scope Z_scope.

Lemma Zabs_square : forall x,  (Zabs  x) ^ 2 = x ^ 2.
Proof.
 intros ; case (Zabs_dec x) ; intros; micromega.
Qed.
Hint Resolve Zabs_pos Zabs_square.

Lemma integer_statement :  ~exists n, exists p, n ^ 2 = 2*p ^ 2 /\ n <> 0.
Proof.
intros [n [p [Heq Hnz]]]; pose (n' := Zabs n); pose (p':=Zabs p).
assert (facts : 0 <= Zabs n /\ 0 <= Zabs p /\ Zabs n2=n2
         /\ Zabs p2 = p2) by auto.
assert (H : (0 < n' /\ 0 <= p' /\ n' ^ 2 = 2* p' ^ 2))
by (destruct facts as [Hf1 [Hf2 [Hf3 Hf4]]]; unfold n', p'; micromega).
generalize p' H; elim n' using (well_founded_ind (Zwf_well_founded 0)); clear.
intros n IHn p [Hn [Hp Heq]].
assert (Hzwf : Zwf 0 (2*p-n) n) by (unfold Zwf; zrelax; micromega).
assert (Hdecr : 0 < 2*p-n /\ 0 <= n-p /\ (2*p-n)^2=2*(n-p)^2)
by (zrelax; micromega).
apply (IHn (2*p-n) Hzwf (n-p) Hdecr).
Qed.

Open Scope Q_scope.

Theorem sqrt2_not_rational : ~exists x:Q, x ^ 2==2#1.
Proof.
 unfold Qeq; intros [x]; simpl (Qden (2#1)); rewrite Zmult_1_r.
 intros HQeq.
 assert (Heq : (Qnum x ^ 2 = 2 * ' Qden x ^ 2)%Z) by exact HQeq.
 assert (Hnx : (Qnum x <> 0)%Z)
 by (intros Hx; simpl in HQeq; rewrite Hx in HQeq; discriminate HQeq).
 apply integer_statement; exists (Qnum x); exists (' Qden x); auto.
Qed.
}}}

For the second solution, the proof of integer statement is based on more
manual work:

{{{#!coq
Require Import ZArith ZArithRing Omega Zwf.
Open Scope Z_scope.

Lemma Zabs_square : forall x, Zabs x ^ 2 = x ^ 2.
intros; case (Zabs_dec x); intros Heq; ring [Heq].
Qed.

Lemma Zabs_st_pos : forall x, x <> 0 -> 0 < Zabs x.
intros; assert (H':= Zabs_pos x); case (Zabs_dec x); intros; omega.
Qed.
Hint Resolve Zabs_pos Zabs_square Zabs_st_pos.

Theorem integer_statement :  ~exists n, exists p, n ^2 = 2* p^2 /\ n <> 0.
intros [n [p [He Hz]]]; pose (q := Zabs n); pose (r :=Zabs p).
assert (H : (0 < q /\ 0 <= r) /\ q ^2 = 2* r ^2).
  assert (F : 0 <= Zabs n /\ 0 <= Zabs p /\ Zabs p ^ 2 = p ^ 2 /\
            Zabs n ^ 2 = n ^ 2) by auto.
  destruct F as [H1 [H2 [H3 H4]]];  unfold q, r; split; auto; ring [H3 H4 He].
generalize r H; elim q using (well_founded_ind (Zwf_well_founded 0)); clear.
assert (fact_sq : forall x, x^2=x*x) by (intros; ring).
intros n IHn p [[Hn Hp] Heq].
assert (Hmain_eq: (2*p-n)^2 = 2*(n-p)^2) by ring [Heq].
assert (Hs: 0 < n^2) by (rewrite fact_sq; apply Zmult_lt_0_compat; auto).
assert (Hpn : p < n).
  apply Znot_ge_lt; intros Habs.
  assert (2*p^2 <= p^2).
    rewrite <- Heq; repeat rewrite fact_sq; 
    apply Zmult_le_compat; auto with zarith.
  omega.
assert (Hn2p: n < 2*p).
  elim (Zle_or_lt (2*p) n); auto; intros Habs'.
  assert (2*n^2 <= n^2).
    replace (2*n^2) with ((2*p)^2) by ring [Heq].
    repeat rewrite fact_sq; apply Zmult_le_compat; auto with zarith.
  omega.
assert (Hzwf : Zwf 0 (2*p-n) n) by (unfold Zwf; omega).
apply (IHn (2*p-n) Hzwf (n-p)); omega.
Qed.
}}}
