This page collected a list of pages dedicated to discuss changes for Coq version 8.8.

Users are welcomed to comment and discuss with developers on these changes at the indicated pages, or by adding a new [issue](https://github.com/coq/coq/issues) page if no link already exists.

### The logic

- Removal of (implicit) support for template polymorphism since it can be simulated using (explicit) universe polymorphism and thanks to [cumulativity](https://github.com/coq/coq/pull/613) propagated through inductive definitions (discussion at 
[PR #889](https://github.com/coq/coq/pull/889)).

### Notations

- New strategy based on open scopes for deciding which notation to use among several of them (discussion at [PR #873](https://github.com/coq/coq/pull/873)) (initially planned for 8.8 but postponed).

  Typical questions are: should abbreviations (i.e. notations bound to a name rather than to a `" ... "` grammar rule) support being attached to a scope.
  What should be their priority relatively to notations defined in a scope for printing.
  
- Factorizing "match" clauses with same right-hand side (discussion at [PR #978](https://github.com/coq/coq/pull/978)).

- Support for custom alternative grammars for terms (discussion at [PR #6247](https://github.com/coq/coq/pull/6247)).

### Tactics

- Tactics `apply`, `rewrite`, `destruct`, `induction`, etc. based on a different unification algorithm (postponed to 8.9, discussion at [PR #930](https://github.com/coq/coq/pull/930) and [PR #991](https://github.com/coq/coq/pull/991)).

- Removal of `Declare Implicit Tactic` (postponed to 8.9).

### A comprehensive list of features for version 8.8

The list of new 8.8 features that have been integrated is listed [here](https://github.com/coq/coq/pulls?q=is%3Apr+label%3A%22kind%3A+feature%22+milestone%3A8.8%2Bbeta1+is%3Aclosed).