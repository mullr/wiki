Here's an example showing how to define and work with functions taking a variable number of arguments.

    (* Defines the type of a function X^n -> Y. *)
    Fixpoint n_args (X Y:Type) (n:nat) : Type :=
    match n with
    | 0 => Y
    | S m => X -> (n_args X Y m)
    end.
    (* Composition of a function X^n -> Y with a function Y -> Z. *)
    Fixpoint n_args_range_fun {n:nat} {X Y Z:Type} :
      (Y->Z) -> (n_args X Y n) -> (n_args X Z n) :=
    fun f =>
    match n as n' return (n_args X Y n' -> n_args X Z n') with
    | 0 => fun g => f g
    | S n0 => fun g x => n_args_range_fun f (g x)
    end.
    (* Eval compute in (@n_args_range_fun 3). *)
    (* Composition of a function Y^n -> Z with a function X -> Y. *)
    Fixpoint n_args_dom_fun {n:nat} {X Y Z:Type} :
      (n_args Y Z n) -> (X->Y) -> (n_args X Z n) :=
    match n as n' return (n_args Y Z n' -> (X -> Y) -> n_args X Z n') with
    | 0 => fun z _ => z
    | S n0 => fun f g x => n_args_dom_fun (f (g x)) g
    end.
    (* Eval compute in (@n_args_dom_fun 3). *)
    (* Composition of a function X^n -> Y with the diagonal map X -> X^n. *)
    Fixpoint duplicate_arg {n:nat} {X Y:Type} :
      (n_args X Y n) -> X -> Y :=
    match n as n' return (n_args X Y n' -> X -> Y) with
    | 0 => fun y _ => y
    | S n0 => fun f x => duplicate_arg (f x) x
    end.
    (* Eval compute in (@duplicate_args 3). *)
    (* Composition of a function X^n -> Y with a function X -> Y -> Z to get
       a function X^(n+1) -> Z. *)
    Definition curry_first_arg {n:nat} {X Y Z:Type} :
      (X->Y->Z) -> (n_args X Y n) -> (n_args X Z (S n)) :=
    fun f g x => n_args_range_fun (f x) g.
    (* Eval compute in (@curry_first_arg 3). *)
    (* Composition of a function X^n -> Y with a function Y -> X -> Z to get
       a function X^(n+1) -> Z. *)
    Fixpoint curry_last_arg {n:nat} {X Y Z:Type} {struct n} :
      (Y->X->Z) -> (n_args X Y n) -> (n_args X Z (S n)) :=
    fun f =>
    match n as n' return (n_args X Y n' -> n_args X Z (S n')) with
    | 0 => fun g x => f g x
    | S n0 => fun g x => curry_last_arg f (g x)
    end.
    (* Eval compute in (@curry_last_arg 3). *)
    (* Translate from a function Y -> X^n -> Z to X^n -> Y -> Z.
       In the other direction you can use n_args_range_fun to compose
       X^n -> Y -> Z with evaluation at y for a given y:Y. *)
    Fixpoint bring_dep_inside {n:nat} {X Y Z:Type} :
      (Y -> (n_args X Z n)) -> (n_args X (Y->Z) n) :=
    match n as n' return ((Y -> n_args X Z n') -> n_args X (Y->Z) n') with
    | 0 => fun f => f
    | S n0 => fun f x0 => bring_dep_inside (fun y:Y => f y x0)
    end.
    (* Eval compute in (@bring_dep_inside 3). *)
    (* Composition of a function Y^n -> Z with n functions X -> Y. *)
    Fixpoint n_args_dom_funs {n:nat} {X Y Z:Type} {struct n} :
      (n_args Y Z n) -> (n_args (X->Y) (n_args X Z n) n) :=
    match n as n' return (n_args Y Z n' -> n_args (X->Y) (n_args X Z n') n') with
    | 0 => fun z => z
    | S n0 => fun f g0 => bring_dep_inside
      (fun x0:X => n_args_dom_funs (f (g0 x0)))
    end.
    (* Eval compute in (@n_args_dom_funs 3). *)
    Lemma n_args_add: forall (X Y:Type) (n m:nat),
      n_args X (n_args X Y m) n = n_args X Y (n+m).
    Proof.
    induction n.
    trivial.
    intros.
    simpl.
    rewrite IHn.
    reflexivity.
    Defined.
    (* Defines the type of an operator on X of a given arity. *)
    Definition operator (X:Type) (arity:nat) : Type := n_args X X arity.
    Require Export Relation_Definitions.
    Require Export RelationClasses.
    Generalizable Variables eqv.
    (* Extensional equality of two functions X^n -> Y. *)
    Fixpoint n_args_equiv {X Y:Type} {n:nat} `{Equivalence Y eqv} :
      relation (n_args X Y n) :=
    match n as m return (relation (n_args X Y m)) with
    | 0 => eqv
    | S m => fun op1 op2 => forall x:X, n_args_equiv (op1 x) (op2 x)
    end.
    (* Eval compute in (fun X Y => (@n_args_equiv X Y 3)). *)
    Instance n_args_equiv_equiv: forall (X Y:Type) (n:nat) `{Equivalence Y eqv},
      Equivalence (@n_args_equiv X Y n _ _).
    Proof.
    intros.
    induction n.
    simpl.
    trivial.
    simpl.
    constructor.
    red; intros op x.
    reflexivity.
    red; intros op1 op2 ? x.
    symmetry; trivial.
    red; intros op1 op2 op3 ? ? x.
    etransitivity; eauto.
    Qed.
    Require Export Morphisms.
    (* Signature which asserts the properness of an operator of arity n over R. *)
    Fixpoint operator_signature {X:Type} (R:relation X) (n:nat) :
      relation (operator X n) :=
    match n with
    | 0 => R%signature
    | S m => (R ==> operator_signature R m)%signature
    end.
    (* Example of this: define an arbitrary variety of algebras. *)
    Class AlgebraSignature (Operation:Type) : Type :=
    | Arity : Operation -> nat.
    Section algebra_signature.
    Context `{AlgebraSignature}.
    (* Unfortunately, we can't make an inductive constructor of type
       forall op:Operation, operator (abstract_term vars) (Arity op), so we
       go through an intermediate vector type and then define that constructor
       later... *)
    Inductive abstract_term (vars:Type) : Type :=
      | var_term: vars -> abstract_term vars
      | op_term_vect: forall op:Operation,
          abstract_term_vector vars (Arity op) -> abstract_term vars
    with abstract_term_vector (vars:Type) : nat -> Type :=
      | term_vector_nil: abstract_term_vector vars 0
      | term_vector_cons: forall {n:nat}, abstract_term vars ->
          abstract_term_vector vars n ->
          abstract_term_vector vars (S n).
    Fixpoint make_vect_aux {vars:Type} (n:nat) {X} (f:abstract_term_vector vars n -> X)
      : n_args (abstract_term vars) X n :=
    match n as n' return ((abstract_term_vector vars n' -> X) ->
                          n_args (abstract_term vars) X n') with
    | 0 => fun f => f (term_vector_nil vars)
    | S m => fun f (t:abstract_term vars) => @make_vect_aux vars m _
        (fun (v:abstract_term_vector vars m) =>
           f (term_vector_cons vars t v))
    end f.
    Definition make_vect {vars:Type} (n:nat) :
      n_args (abstract_term vars) (abstract_term_vector vars n) n :=
    make_vect_aux n (fun t:abstract_term_vector vars n => t).
    (* Eval compute in (fun vars => @make_vect_aux vars 3). *)
    (* Eval compute in (fun vars => @make_vect vars 3). *)
    Definition op_term {vars:Type} (op:Operation) :
      operator (abstract_term vars) (Arity op) :=
    make_vect_aux (Arity op) (op_term_vect vars op).
    Fixpoint evaluate {X:Type} {vars:Type}
      (vals: vars -> X) (ops: forall op:Operation, operator X (Arity op))
      (t: abstract_term vars) {struct t} : X :=
    match t with
    | var_term v => vals v
    | op_term_vect op v => vector_evaluate vals ops v (ops op)
    end
    with vector_evaluate {X:Type} {vars:Type}
      (vals: vars -> X) (ops: forall op:Operation, operator X (Arity op))
      {n:nat} (v:abstract_term_vector vars n) (top_op: operator X n)
      {struct v} : X :=
    match v in (abstract_term_vector _ m) return (operator X m -> X) with
    | term_vector_nil => fun op => op
    | term_vector_cons m hd tl => fun op => vector_evaluate vals ops tl
                                              (op (evaluate vals ops hd))
    end top_op.
    End algebra_signature.
    Class AlgebraSpec : Type := {
      Operation: Type;
      signature:> AlgebraSignature Operation;
      Identity: Type;
      IdentityVariable: Identity -> Type;
      IdentityTerms: forall ident:Identity,
        abstract_term (IdentityVariable ident) *
        abstract_term (IdentityVariable ident)
    }.
    Require Export SetoidClass.
    Class Algebra (A:Type) `{Setoid A} `{AlgebraSpec} : Type := {
      ops: forall op:Operation, operator A (Arity op);
      op_proper:> forall op:Operation, Proper
        (operator_signature equiv (Arity op)) (ops op);
      identity_holds: forall (ident:Identity)
        (vars: IdentityVariable ident -> A),
        evaluate vars ops (fst (IdentityTerms ident)) ==
        evaluate vars ops (snd (IdentityTerms ident))
    }.
    Generalizable Variables A B.
    Class AlgebraHom `{AlgebraSpec} `{Setoid A} {_:Algebra A}
      `{Setoid B} {_:Algebra B} (f:A->B) : Prop :=
    | respects_ops: forall op:Operation,
      n_args_equiv (n_args_range_fun f (ops op))
                   (n_args_dom_fun (ops op) f).
    Inductive no_vars : Set := .
    Inductive one_var : Set := var1_x.
    Inductive two_vars : Set := var2_x | var2_y.
    Inductive three_vars : Set := var3_x | var3_y | var3_z.
    Implicit Arguments var_term [[Operation] [H] [vars]].
    (* Example constructing groups as an instance of a variety of algebras.
       Defining the identities is still a bit cumbersome... *)
    Section groups_example.
    Inductive GroupOp : Set := GroupMult | GroupInv | GroupId.
    Instance GroupSignature : AlgebraSignature GroupOp :=
      fun (op:GroupOp) => match op with
    | GroupMult => 2
    | GroupInv => 1
    | GroupId => 0
      end.
    Inductive GroupIdentity : Set :=
    GroupIdLeft | GroupIdRight | GroupInvLeft | GroupInvRight | GroupAssoc.
    Instance GroupSpec : AlgebraSpec := {
      Operation := GroupOp;
      Identity := GroupIdentity;
      IdentityVariable := fun ident => match ident with
    | GroupIdLeft => one_var
    | GroupIdRight => one_var
    | GroupInvLeft => one_var
    | GroupInvRight => one_var
    | GroupAssoc => three_vars
      end
    }.
    (* IdentityTerms *)
    destruct ident.
    (* GroupIdLeft *)
    exact ( (op_term GroupMult (op_term GroupId) (var_term var1_x),
             var_term var1_x) ).
    (* GroupIdRight *)
    exact ( (op_term GroupMult (var_term var1_x) (op_term GroupId),
             var_term var1_x) ).
    (* GroupInvLeft *)
    exact ( (op_term GroupMult (op_term GroupInv (var_term var1_x))
                               (var_term var1_x),
             op_term GroupId) ).
    (* GroupInvRight *)
    exact ( (op_term GroupMult (var_term var1_x)
                               (op_term GroupInv (var_term var1_x)),
             var_term var1_x) ).
    (* GroupAssoc *)
    exact ( (op_term GroupMult (var_term var3_x)
                     (op_term GroupMult (var_term var3_y) (var_term var3_z)),
             op_term GroupMult
                     (op_term GroupMult (var_term var3_x) (var_term var3_y))
                     (var_term var3_z)) ).
    Defined.
    Generalizable Variables G.
    Class Group (G:Type) `{Setoid G} : Type :=
      | group_structure:> Algebra G.
    Context `{Group G}.
    Definition group_mult : G -> G -> G := ops GroupMult.
    Definition group_inv: G -> G := ops GroupInv.
    Definition group_id: G := ops GroupId.
    Lemma group_mult_proper: Proper (equiv ==> equiv ==> equiv) group_mult.
    Proof.
    exact (op_proper GroupMult).
    Qed.
    Lemma group_mult_assoc: forall x y z:G, group_mult x (group_mult y z) ==
                                            group_mult (group_mult x y) z.
    Proof.
    intros.
    exact (identity_holds GroupAssoc
      (fun v:three_vars => match v with
       | var3_x => x | var3_y => y | var3_z => z end)).
    Qed.
    End groups_example.
