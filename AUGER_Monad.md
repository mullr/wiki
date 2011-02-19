This file uses my [[AUGER_Notations|notations]].

It has been written from [[http://www.haskell.org/haskellwiki/Monads_as_Containers|this Haskell tutorial]], so the notations for the monads are also taken from Haskell.

After having done this file I took a look at what has been done in coq for the monads, and I found:

- [[http://coq.inria.fr/V8.2pl1/contribs/lc.Monad.html|this contribution]]; it has a lot of lemmas and theorems, but no example, and IMHO my definition of a monad is more handy (the monad_carrier is a parameter of the type and not a field); but I think that merging my development with his one could be a good thing. 

- [[http://mattam.org/repos/coq/misc/shiftreset/GenuineShiftReset.html|GMonad]]; a generalization of monads.

{{{#!coq
Require Import Notations.
Set Implicit Arguments.

(** * The Monad Type Class *)

Class Monad (m: Type → Type): Type :=
{ return_: ∀ A, A → m A;
  bind: ∀ A, m A → ∀ B, (A → m B) → m B;

  right_unit: ∀ A (a: m A), a = bind a (@return_ A);
  left_unit: ∀ A (a: A) B (f: A → m B),
             f a = bind (return_ a) f;
  associativity: ∀ A (ma: m A) B f C (g: B → m C),
                 bind ma (λ x· bind (f x) g) = bind (bind ma f) g
}.

Notation "a >>= f" := (bind a _ f) (at level 50, left associativity).

Section monadic_functions.
 Variable m: Type → Type.
 Variable M: Monad m.

 Definition wbind {A: Type} (ma: m A) {B: Type} (mb: m B) :=
 ma >>= λ _·mb.

 Definition liftM {A B: Type} (f: A→B) (ma: m A): m B :=
 ma >>= (λ a · return_ (f a)).

 Definition join {A: Type} (mma: m (m A)): m A :=
 mma >>= (λ ma · ma).
End monadic_functions.

Notation "a >> f" := (wbind _ a f) (at level 50, left associativity).
Notation "'do' a ← e ; c" := (e >>= (λ a · c)) (at level 60, right associativity).

(** * Some classic Monads *)
(** ** The Maybe monad (using option type) *)
Instance Maybe: Monad option :=
{| return_ := Some;
   bind := λ A m B f · match m with None => None | Some a => f a end
|}.
(* Checking the 3 laws *)
 (* unit_left *)
 abstract (intros A a; case a; split).
 (* unit_right *)
 abstract (split).
 (* associativity *)
 abstract (intros A m B f C g; case m; split).
Defined.

(** The Reader monad *)
Axiom Eta: ∀ A (B: A → Type) (f: ∀ a, B a), f = λ a·f a.

Instance Reader (E: Type): Monad (λ A · E → A) :=
{| return_ := λ A (a: A) e · a;
   bind := λ A m B f e · f (m e) e
|}.
(* Checking the 3 laws *)
 (* unit_left *)
 intros; apply Eta.
 (* unit_right *)
 intros; apply Eta.
 (* associativity *)
 reflexivity.
Defined.

(** ** The State monad *)

Axiom Ext: ∀ A (B: A→Type) (f g: ∀ a, B a), (∀ a, f a = g a) → f = g.

Instance State (S: Type): Monad (λ A · S → A * S) :=
{| return_ := λ A (a: A) s · (a, s);
   bind := λ A m B f s · let (a, s) := m s in f a s
|}.
(* Checking the 3 laws *)
 (* unit_left *)
 abstract (intros;apply Ext;intros s;destruct (a s);split).
 (* unit_right *)
 abstract (intros;apply Eta).
 (* associativity *)
 abstract (intros;apply Ext;intros s;destruct (ma s);reflexivity).
Defined.

(** ** The tree monad *)
Inductive Tree (A:  Type) :=
| Leaf: A → Tree A
| Branch: Tree A → Tree A → Tree A
.

Definition bind_tree {A B: Type} (f: A → Tree B) :=
 fix bind_tree t :=
 match t with
 | Leaf a => f a
 | Branch t1 t2 => Branch (bind_tree t1) (bind_tree t2)
 end.

Instance tree : Monad Tree :=
{ return_ := Leaf;
  bind := λ A t B f · bind_tree f t
}.
(* Checking the 3 laws *)
 (* unit_left *)
 Lemma tree_unit_left: ∀ A a, a = bind_tree (@Leaf A) a.
 Proof.
 intros A; fix 1; intros []; simpl.
  split.
 intros t1 t2.
 generalize (tree_unit_left t1) (tree_unit_left t2); clear tree_unit_left.
 intros [] [].
 split.
Qed.
 exact tree_unit_left.
 (* unit_right *)
 Lemma tree_unit_right: ∀ A a B (f : A → Tree B), f a = bind_tree f (Leaf a).
 Proof.
 simpl; split.
Qed.
 exact tree_unit_right.
 (* associativity *)
 Lemma tree_associativity: ∀ A (m : Tree A) B f C (g : B → Tree C),
 bind_tree (bind_tree g ∘ f) m = bind_tree g (bind_tree f m).
 Proof.
 intros A m B f C g; revert m.
 fix 1; intros []; simpl.
  split.
 intros t1 t2.
 generalize (tree_associativity t1) (tree_associativity t2);
 clear tree_associativity.
 intros [] [].
 split.
Qed.
 exact tree_associativity.
Defined.

(** ** A light version of the IO monad *)
Require Import Ascii.
Open Scope char_scope.

CoInductive stream: Type :=
| Stream: ascii → stream → stream
| EmptyStream.

Record std_streams: Type :=
{ stdin: stream;
  stdout: stream;
  stderr: stream
}.

Definition io (A: Type) := std_streams → (A * std_streams).

Instance IO : Monad io :=
{| return_ := λ A (a: A) s · (a, s);
   bind := λ A a B (f: A → io B) s · let (a, s) := (a s) in f a s
|}.
(* Checking the 3 laws *)
 (* unit_left *)
 Lemma io_unit_left:
 ∀ A (a: io A), a = (λ s : std_streams · let (a, s) := a s in (a, s)).
 Proof.
 intros; apply Ext.
 intros s; case (a s); split.
Qed.
 exact io_unit_left.
 (* unit_right *)
 Lemma io_unit_right:
 ∀ A a B (f : A → io B), f a = (λ s : std_streams · f a s).
 Proof.
 intros; apply Ext.
 split.
Qed.
 exact io_unit_right.
 (* associativity *)
 Lemma io_associativity: ∀ A (m : io A) B (f: A → io B) C (g : B → io C),
 (λ s · let (a, s0) := m s in let (a0, s1) := f a s0 in g a0 s1) =
 (λ s · let (a, s0) := let (a, s0) := m s in f a s0 in g a s0).
 Proof.
 intros; apply Ext.
 intros; case (m a); split.
Qed.
 exact io_associativity.
Defined.

Definition getchar: io ascii :=
 λ i·
 let (c, stdin) :=
 match i.(stdin) with
 | EmptyStream => ("#", EmptyStream) (*I do not remember the code of EOF *)
 | Stream a i => (a, i)
 end
 in (c, {|stdin := stdin; stdout := i.(stdout); stderr := i.(stderr)|}).

Definition putchar (a: ascii): io unit :=
 λ i·
 let stdout :=
 (cofix putchar i :=
 match i with
 | EmptyStream => Stream a EmptyStream
 | Stream a i => Stream a (putchar i)
 end) i.(stdout)
 in (tt, {|stdin:=i.(stdin); stdout:=stdout; stderr:=i.(stderr)|}).

Definition err_putchar (a: ascii): io unit :=
 λ i·
 let stderr :=
 (cofix putchar i :=
 match i with
 | EmptyStream => Stream a EmptyStream
 | Stream a i => Stream a (putchar i)
 end) i.(stderr)
 in (tt, {|stdin:=i.(stdin); stdout:=i.(stdout); stderr:=stderr|}).

Require Import String.
Require Import List.

Fixpoint lts l :=
match l with
| nil => EmptyString
| c::l => String c (lts l)
end.

Fixpoint ltS l :=
match l with
| nil => EmptyStream
| c::l => Stream c (ltS l)
end.

Example some_std_streams :=
{| stdin := ltS ("H"::"e"::"l"::"l"::"o"::","::" "::"W"::"o"::"r"::"l"::"d"::
                 "!"::nil);
   stdout := EmptyStream;
   stderr := EmptyStream
|}.

Example prog :=
 (do h    ← getchar;
  do e    ← getchar;
  do l1   ← getchar;
  do l2   ← getchar;
  do o1   ← getchar;
  do coma ← getchar;
  putchar "E" >>
  do space← getchar;
  do w    ← getchar;
  do o2   ← getchar;
  putchar "n" >>
  do r    ← getchar;
  do l3   ← getchar;
  do d    ← getchar;
  putchar d >>
  do bang ← getchar;
  do eof1 ← getchar;
  do eof2 ← getchar;
  do eof3 ← getchar;
  return_ (lts (h::e::l1::l2::o1::coma::space::w::o2::r::l3::d::
                bang::eof1::eof2::eof3::nil))).

Eval compute in (prog some_std_streams).
Eval compute in (let out := (snd (prog some_std_streams)).(stdout) in
                prog {|stdin := out;
                       stdout := EmptyStream;
                       stderr := EmptyStream|}).
}}}
