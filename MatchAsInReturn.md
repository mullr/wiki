{{{match}}} allows the result type to depend on both the input value, and the parameters of the input type.  The {{{as}}} and {{{in}}} keywords create bound variables that can occur in the {{{return}}} type.  So the expression

{{{#!coq
match expr as T in (deptype A B) return exprR
(*...*)
}}}
creates bound variables {{{T}}}, {{{A}}}, and {{{B}}} that occur in {{{exprR}}}. If {{{expr}}} has type {{{(deptype exprA exprB)}}} then the type of the entire {{{match}}} expression will have type {{{exprR[T/expr, A/exprA, B/exprB]}}}, that is {{{exprR}}} with {{{T}}}, {{{A}}}, and {{{B}}} substituted by {{{expr}}}, {{{exprA}}}, and {{{exprB}}}.

{{{T}}}, {{{A}}} and {{{B}}} are new variable names, and cannot be expressions.

== "Real Arguments" ==
Coq is missing some assumptions about real arguments (see page 105 of the 11-Feb-2009 edition of the Coq 8.2 manual for the subtle definition of the technical term "real argument").  In the (highly contrived) program below, it cannot discern that {{{u}}} has type {{{updown (n+1)}}}:

{{{#!coq
Inductive updown : nat -> Set :=
  | up   : forall n, updown (n+1) -> updown n
  | down : forall n, updown  n    -> updown (n+1).

Fixpoint demo (n:nat)(t:updown n)(t':updown (n+1)) : nat :=
  match t with
    | up   _ u => demo n t u
    | down _ d => 3
  end.
}}}
=== Possible Fix ===
In the typing rule at the bottom of page 114 of the 11-Feb-2009 edition of the Coq 8.2 manual, the text E[\Gamma] appears three times in the hypothesis of rule "match".  The rightmost occurrence should be replaced with:

{{{
  E[\Gamma, x:(Coq.Logic.Eqdep.eq_dep Type (fun x=>x) C c A_i c)]
}}}
For x a fresh variable name.  See the bottom of page 109 for the meaning of A_i.  This suggestion has the disadvantage (which was first lamented [[http://article.gmane.org/gmane.science.mathematics.logic.coq.club/4667|here]]) of introducing a new constant into the typing rules, thereby making {{{eq_dep}}} a primitive of CiC.

HugoHerbelin, 28 March 2010: This is not as simple as that. First because {{{eq_dep}}} (or {{{eq}}}, or {{{JMeq}}}) are all ''defined'' notions that are unknown from the kernel type-checker. In particular, to be able to type {{{match}}} as proposed above, one would need to have {{{eq_dep}}} primitively defined in the Calculus of Inductive Constructions. In any case, it is easy (though ugly) to simulate the rule proposed above by generalizing the type of the {{{match}}} with hypotheses {{{Coq.Logic.Eqdep.eq_dep Type (fun x=>x) C c A_i c}}} (this is described in most textbooks about Coq, see also the reference paper ''Eliminating dependent pattern-matching'' by Goguen, Mc Bride and Mc Kinna).

Note that some proof assistants such as Agda have a more powerful typing rule for {{{match}}} which supports a limited amount of equations of the form above. However, this is not the case of Coq.

AdamMegacz, 28 March 2010: Interesting!  Would you care to include the expanded rule that "inlines" the hypotheses of {{{Coq.Logic.Eqdep.eq_dep Type (fun x=>x) C c A_i c}}} in place of {{{Coq.Logic.Eqdep.eq_dep}}} itself?

HugoHerbelin, 29 March 2010: Again, this is no so simple. There is first a choice to do between {{{eq}}}, {{{JMeq}}} and {{{eq_dep}}}, with different issues depending of this choice. With {{{eq}}}, we need convoluted statements when the dependencies are iterated. with {{{JMeq}}}, one does not need to iterate dependencies but {{{JMeq}}} is not canonical like {{{eq}}} and it would be strange to have {{{JMeq}}} natively known from the kernel without {{{eq}}} being known. With {{{eq_dep}}} we would need n-ary forms of it to support iterated dependencies. At the end, it is not clear whether it would really be an advantage compared to a non-native treatment of the equalities derivable by pattern-matching.

If not natively put inside the kernel type-checker, there is then a second alternative which is to modify the pattern-matching compilation algorithm so that it automatically adds the matching equations (outside the kernel, but still ideally made invisible to the user). This second approach is already adopted by the {{{Program}}} and {{{Equations}}} commands. The question then is whether it would be relevant to add it too to the general {{{match}}} mechanism.

AdamMegacz, 29 March 2010: Unfortunately this is not so simple.  The {{{Program}}} command will not alter the inductive definitions in the required manner.  It certainly helps organize the proofs, but it won't get the necessary propositions threaded into the right places.

PierreBoutillier, 23 April 2010: Terminaison checking will fail on your example

AdamMegacz, 3 May 2010: That's not the problem -- adding a decreasing parameter doesn't fix the problem (but certainly makes the example more difficult to read)

{{{#!coq
Inductive updown : nat -> Set :=                                                                                          
  | up   : forall n, updown (n+1) -> updown n                                                                             
  | down : forall n, updown  n    -> updown (n+1).

Fixpoint demo (n:nat)(t:updown n)(t':updown (n+1))
              (decreasing_parameter:nat) {struct decreasing_parameter} : nat :=
  match decreasing_parameter with
    | 0 => 0
    | (S dec) => 0
      match t with
        | up   _ u => demo n t u dec
        | down _ d => 3
      end
  end.
}}}

PierreBoutillier, 23 April 2010 but why are you unhappy with:

{{{#!coq
Fixpoint demo (n:nat)(t:updown n)(t':updown (n+1)) : nat :=
  match t with
    | up   n0 u as t0 => demo n0 t0 u
    | down _ d => 3
  end.
}}}

AdamMegacz, 3 May 2010: Because that is a different program from the one I wrote.  You are passing "u" as the second argument to the recursive call, whereas I am passing "t".  The problem is more glaring if you add an extra argument to the up/down constructors:

{{{#!coq
Inductive updown : nat -> Set :=                                                                                          
  | up   : forall n, updown (n+1) -> nat -> updown n                                                                      
  | down : forall n, updown  n    -> nat -> updown (n+1).                                                                 
                                                                                                                          
Definition getX (n:nat)(t:updown n) :=                                                                                    
  match t with                                                                                                            
  | up   _ _ x => x                                                                                                       
  | down _ _ x => x                                                                                                       
  end.

Fixpoint demo (n:nat)(t:updown n)(t':updown (n+1)) : nat :=
  match t with
    | up   _ u _ => demo n t u
    | down _ d _ => 3
  end.
}}}

There is no guarantee that (getX t) and (getX u) are equal, so your change will drastically alter the observable behavior of the function.

PierreBoutillier, 23 April 2010:  More generaly, any kind of equation adds garbage in the computationnal behavior.  Generalising may be a better solution. 

My playground :
{{{#!coq 
Variable s : Type.
Inductive t : Type := |C1 : s -> t |C2 : whatever -> t.
Variable a : s, b : t, f : s -> t.
Inductive T : t -> Type := stuff.
}}}
 * If you match over a term of type ''T b'', tactics will automaticaly build the generalisation of terms depending of ''b'' and will rewrite the goal with the new ''b''. I need a better example than the silly :
{{{#!coq
Lemma f_equal (A B : Type) (f : A -> B) (x y : A) (H  : x = y) : f x = f y.
Proof.
destruct H.
reflexivity.
Qed.
}}}

 * If you match over a term of type ''T (C1 a)'', first, terms whose type depends of ''a'' are not generalized (by the way, terms of types depending of ''C a'' are, so you may have an "ill typed term" message !) and second, constructor that build something of type ''T (C2 _)'' aren't automaticaly erased. But by a bit weird match in the return clause and the use of ''ID/id'' or''True/I'' for impossible case, we've got a solution.

Here is the already existing : 
{{{#!coq
Definition Vtail (A : Type) (n : nat) (v : vector A (S n)) : vector A n :=
match v in (vector _ n0) return match n0 with
    | 0 => ID | S n1 => vector A n1 end with
 | Vnil => id
 | Vcons _ _ v0 => v0
end.
}}}
or an example (adapted from Heq of Chung-Kil Hur) : 
{{{#!coq
Inductive TyVar : nat -> Type := 
| ZTYVAR : forall u, TyVar (S u)
| STYVAR : forall u, TyVar u -> TyVar (S u).

Definition RenT u w := TyVar u -> TyVar w.

Definition RTyL u w (r:RenT u w) : RenT (S u) (S w) := 
fun var : TyVar (S u) => match var in TyVar n return match n with 
    |0 => ID |S x => RenT x w -> TyVar (S w) end with
  | ZTYVAR _ => fun _ => (ZTYVAR _)
  | STYVAR _ var' => fun r' => STYVAR (r' var')
  end r.
}}}
Never the less, this technique isn't really friend with terminaison checking. In 
{{{#!coq
Fixpoint Vbinary n  (a : vector n) {struct a} : vector n -> vector n :=
match a in vector n0 return vector n0 -> vector n0 with
  |Vnil => fun b' => match b' in vector n0' return 
      match n0' with |0 => vector 0 |S _ => ID end with
      |Vnil => Vnil |Vcons _ _ _ => id end
  |Vcons h l t => fun b' => match b' in vector n0' return
    match n0' with |0 => ID |S n' => vector n' -> vector (S n') end with
    |Vnil => id 
    |Vcons h' l' t' => fun tbis => Vcons (g h h') l' 
      (Vbinary l' tbis t')
  end t
end.
}}}
''tbis'' isn't a strict subterm of ''a''. I've to ask for a rule such as in ''(fun x' => f x') x'' (''x, x' '' variables), gives to ''x' '' the subterm property of ''x''.

 * If you match over a term of type ''T (f a)'', I don't see a better solution that equations and rewritings such as Program/dependent destruction. (Agda anyway seems to do it the same way by using '''with''' tricks.)
