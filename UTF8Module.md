#language en



{{{#!coq
Notation " A ⇒ B " := (A -> B) (at level 90, right associativity) : type_scope.

Notation " ∀ x , B  " := (forall x:_, B ) (at level 200, x at level 0, no associativity) : type_scope.

Notation " ∀ x y , B  " := (forall (x:_) (y:_), B ) (at level 200, x at level 0, y at level 0, no associativity) : type_scope.

Notation " ∀ x y z , B  " := (forall (x:_) (y:_) (z:_), B ) (at level 200, x at level 0, y at level 0, z at level 0, no associativity) : type_scope.

Notation " ∀ x y z t , B  " := (forall (x:_) (y:_) (z:_) (t:_), B ) (at level 200, x at level 0, y at level 0, z at level 0, t at level 0, no associativity) : type_scope.

Notation " ∀ x y z t u , B  " := (forall (x:_) (y:_) (z:_) (t:_) (u:_), B ) (at level 200, x at level 0, y at level 0, z at level 0, t at level 0, u at level 0, no associativity) : type_scope.

Notation " ∀ x : A , B  " := (forall x:A, B ) (at level 200, x at level 0, no associativity) : type_scope.

Notation " ∀ ( x : A1 )  ( y : A2 ) , B  " := (forall (x:A1) (y:A2), B ) (at level 200, x at level 0, y at level 0, no associativity) : type_scope.

Notation " ∀ x ( y : A2 ) , B  " := (forall (x:_) (y:A2), B ) (at level 200, x at level 0, y at level 0, no associativity) : type_scope.


Notation " ¬ x " := (not  x) (at level 75, right associativity) : type_scope.
}}}
