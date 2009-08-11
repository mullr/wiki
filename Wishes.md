This page is for collecting wishes for Coq and possibly discuss their feasibility. For CoqIde see [[CoqIDEWishes|CoqIDE wishes page]].

<<TableOfContents>>

== High-level language ==

=== Syntax of terms ===

==== Support for custom numeral notations ====

A possible approach for printing terms of some type T as numerals is to provide two functions:

 * A Coq term of type {{{Z -> option T}}} which is used for parsing and which returns the closed term of type T corresponding to an integer (if interpretable, i.e., if T denotes e.g. positive numbers, the function will return None on negative numbers)

 * an Ltac function which analyzes if a term is closed expression in {{{T}}} and returns the corresponding term in {{{Z}}} if it is. It fails otherwise.

==== Support for specific constr grammar entries ====

==== Support for on-the-fly decomposition of unary inductive types ====

That would be convenient to be able to write 

{{{Definition f x (y1,y2) z := .... }}} or {{{ Definition f x ((y1,y2) as y) z := ....}}}

meaning

{{{Definition f x y z := let (y1,y2) := y in ...}}}

or 

{{{Definition f x '(C y1 y2 y3) z := ....}}}

meaning

{{{Definition f x y z := let '(C y1 y2 y3) := y in ...}}}

or, for records, something like

{{{Definition f x {|snd:=y2;fst:=y1|} z := ....}}}

meaning

{{{Definition f x y z := let '(y1,y2) := y in ...}}}

For implicit arguments, one could force to have a surrounding '{... as y}' ??

== Tactics ==

=== Simplification tactics ===

{{{simpl}}}, or rather a better {{{simpl}}} with a different name, should not simplify {{{minus O x}}} in the following definition:

{{{
Fixpoint minus (n m:nat) {struct n} : nat :=
   match n, m with
   | O, _ => n
   | S k, O => n
   | S k, S l => k - l
   end
}}}

It should wait for falling in one of the given n-ary clauses.

=== Optimization ===

Prune the proof terms produced by tauto/intuition/omega (by removal of unnecessary steps) so that they're shorter and we can use them w/o endanger an arbitrary increase of the size of the proof.

== The Calculus of Inductive Constructions ==

=== Support lexicographic termination in Fixpoint ===

Extend the guard condition so as to support lexicographic ordering. At worst, Coq could support automatic insertion of subfixpoint in recursive function on lexicographic ordering. E.g.

{{{
Fixpoint merge l1 l2 :=
   match l1, l2 with
   | [], _ => l2
   | _, [] => l1
   | a1::l1', a2::l2' =>
       if a1 <=? a2 then a1 :: merge l1' l2 else a2 :: merge l1 l2'
   end.
}}}

could be accepted and produce:

{{{
Definition merge :=
   fix merge l1 l2 :=
   let fix merge_aux l2 :=
     match l1, l2 with
     | [], _ => l2
     | _, [] => l1
     | a1::l1', a2::l2' =>
         if a1 <=? a2 then a1 :: merge l1' l2 else a2 :: merge_aux l2'
   end
   in merge_aux l2.
}}}

This is not as useful as native support for lexicographic ordering because when exposed, {{{merge_aux l2}}} will not appear as {{{merge l1 l2}}}.

=== Support refolding of fixpoints in the kernel ===

When unfolding a fixpoint and reducing it, we are left with a {{{fix}}} expression which in principle could be refolded when this expression is associated to a definition. What are the issues if we modify the rule for unfolding "named fixpoint" in the kernel.

=== Investigation into commutative cuts ===

In many cases, terms could be made convertible thanks to commutative cuts, such as {{{(let (a,b) := x in t) u) == let (a,b) := x in (t u)}}}.

In presence of predicate parameters (i.e. indices), commutative cuts may get quite involved. Consider the following example in context  {{{H : x = y}}}:

{{{
match H in _ = z return P(z) -> Q(z) with
    eq_refl => fun H:P(x) => H'
end (t : P(y))
}}}

The naive commutation

{{{
match H in _ = z return P(z) -> Q(z) with
    eq_refl => (fun H:P(x) => H') t
end
}}}

is ill-typed but one can use the following commutation:

{{{
match H in _ = z return P(z) -> Q(z) with
  eq_refl => (fun H:P(x) => H') (match sym_eq H in _ = z return P(z) with eq_refl => t)
end
}}}

In presence of truly dependent pattern-matching, commutation is apparently possible only if the surrounding context is uniformly dependent on the term matched. Consider e.g.

{{{
match b as b' return P b b' -> Q b b' with
  | true => a   (* of type P b true -> Q b true *)
  | false => b  (* of type P b false-> Q b false *)
  end  t (* of type P b b)
}}}

we need to cast {{{t}}} into a term of type {{{P b true}}}, but how can we ensure it is possible?

Finally, traversing the fixpoints is complicated. In case of tail-recursive fixpoints, the context can directly be moved to the base case of the recursive defintion but in the general case, this seems impossible.

== Coqdoc ==

=== Support links from within [...] parts of comments ===

E.g. support links on definition {{{permutation}}} from

{{{(* This is a variant of [Coq.List.List.permutation] *)}}}
