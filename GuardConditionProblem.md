= Here should be explained some of the mysteries behind Coq guard condition for fixpoints =

== All arguments of constructors are NOT admissible sub terms ==
Polymorphic arguments of a constructors must not be a recursive argument. See the example

Inductive I : Type := C: (∀ (P : Type), P→P) → I.

Definition Paradox : False :=
(fix ni (i :I):False := match i with | C (f :∀P:Prop,P→P) => ni (f _i) end)
(C (fun (P :Type) (x :P)  => x)).

to understand why !

Coq registers "admissible for recursive calls" arguments of a constructor at definition time. Consequently, as the first argument of cons in 

Inductive list (A : Type) : Type :=
    nil : list A | cons : A -> list A -> list A.

is not a 'list A' it will never be OK to use it (or one of its subterm) as a recursive argument !

There is sometime a work-around. In "match x with | cons a _ => ... | _ => ... end", if 'x' is the recursive argument, we have just seen why sadly 'a' will never be recognize as a subterm but if 'x' is a subterm already then 'a' will be one.
