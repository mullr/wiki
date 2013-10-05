=Here should be explained some of the mysteries behind Coq guard condition for fixpoints=

==All arguments of constructors are admissible subterm==
Polymorphic arguments of a constructors must not be recursive arguments. See the example

Inductive I : Type := C: (∀ (P : Type), P→P) → I.
Definition Paradox : False :=
(fix ni (i :I):False := match i with | C (f :∀P:Prop,P→P) => ni (f _i) end)
(C (fun (P :Type) (x :P)  => x)).

to understand why !

Nevertheless Coq registers the "admissible for recursive calls" arguments of a constructor at 
