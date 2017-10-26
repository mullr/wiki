Starting with Coq Version 8.2 these tricks are no longer necessary, as one can use `apply ->` and `apply <-`.

ApplyFwd
========

`ApplyFwd` is intended to allow you to apply lemmas of the form `forall a0:T0, ..., forall an:Tn, Phi <-> Psi` to reduce a goal of `Psi` to `Phi`. Because `ApplyFwd` uses `Refine` also can be used with lemmas of the form `forall a0:T0, ..., forall an:Tn, Phi -> Psi`, and will try harder than `Apply` to match `Psi` with the goal.

```coq
Ltac applyFwd l :=
first
[refine l
|refine (proj1 l _)
|refine (l _)
|refine (proj1 (l _) _)
|refine (l _ _)
|refine (proj1 (l _ _) _)
|refine (l _ _ _)
|refine (proj1 (l _ _ _) _)
|refine (l _ _ _ _)
|refine (proj1 (l _ _ _ _) _)
|refine (l _ _ _ _ _)
|refine (proj1 (l _ _ _ _ _) _)
|refine (l _ _ _ _ _ _)
|refine (proj1 (l _ _ _ _ _ _) _)
|refine (l _ _ _ _ _ _ _)
|refine (proj1 (l _ _ _ _ _ _ _) _)
|refine (l _ _ _ _ _ _ _ _)
].
```

ApplyRev
========

`ApplyRev` is intended to allow you to apply lemmas of the form `forall a0:T0, ..., forall an:Tn, Phi <-> Psi` to reduce a goal of `Phi` to `Psi`.

```coq
Ltac applyRev l :=
first
[refine (proj2 l _)
|refine (proj2 (l _) _)
|refine (proj2 (l _ _) _)
|refine (proj2 (l _ _ _) _)
|refine (proj2 (l _ _ _ _) _)
|refine (proj2 (l _ _ _ _ _) _)
|refine (proj2 (l _ _ _ _ _ _) _)
|refine (proj2 (l _ _ _ _ _ _ _) _)
].
```
