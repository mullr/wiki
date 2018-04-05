This page collects a list of pages dedicated to discuss changes planned in Coq version 8.9.

Users are welcomed to comment and discuss with developers on these changes at the indicated pages, or by adding a new [issue](https://github.com/coq/coq/issues) page if no link already exists.

See also the [8.9 roadmap](https://github.com/coq/roadmaps/blob/master/text/roadmap-8.9.md) page for an upstream perspective at the 8.9 projects.

### The logic

- Kernel support for primitive efficient integers ([PR #6914](https://github.com/coq/coq/pull/6914)).

- The `match` reduction, as well as the `iota` reduction which includes it, are now stronger. Formerly, `Eval cbv match in match S O with S n => true | O => false end` was returning `(fun _ : nat => true) 0` needing a `beta` step further to reach a normal form. Substitution of the variables of a pattern by the arguments of a constructor could become part of the `match` reduction. As another example, `Eval lazy match in match 3 with 2 => true | _ => false end` would return `false` without requiring the `beta` flag ([CEPS #34](https://github.com/coq/ceps/pull/34)).

### Notations

- User-level support for declaring numeral notations for arbitrary types ([PR #496](https://github.com/coq/coq/pull/496)).

- Support for custom alternative grammars for terms ([PR #6247](https://github.com/coq/coq/pull/6247)).

- New strategy based on open scopes for deciding which notation to use among several of them ([PR #873](https://github.com/coq/coq/pull/873)).

- New command for explicit declaration of a scope, intended to be eventually mandatory ([PR #7135](https://github.com/coq/coq/pull/7135)).

- New semantics to `Set Printing All`: it can be combined with other printing options for better customization ([PR #6560](https://github.com/coq/coq/pull/6560)).

### Tactics

- Tactics `apply`, `rewrite`, `destruct`, `induction`, etc. based on a different unification algorithm ([PR #930](https://github.com/coq/coq/pull/930) and [PR #991](https://github.com/coq/coq/pull/991)).

- New syntax `induction t over m` intended to be more intuitive than the current `induction t in m |- *` ([PR #6836](https://github.com/coq/coq/pull/6836)).

- Miscellaneous improvements in regularity of `destruct` and `induction`:

  - use dependent elimination automatically whenever needed ([PR #6833](https://github.com/coq/coq/pull/6833))

  - section variables cleared by default like for non-section variables ([PR #6826](https://github.com/coq/coq/pull/6826))

- Removal of `Declare Implicit Tactic`.

- Uniformization of the behavior of the variants of `eauto` ([PR #721](https://github.com/coq/coq/pull/721)).

- Opportunities to add new introduction patterns (see [PR #410](https://github.com/coq/coq/pull/410), [PR #1003](https://github.com/coq/coq/pull/1003), [PR #6705](https://github.com/coq/coq/pull/6705)).

- Model for letting tactic behaviors evolve without breaking compatibility, or at least without breaking it too much (discussion at [issue 6043](https://github.com/coq/coq/issues/6043)).

### A comprehensive list of features for version 8.9

The list of new 8.9 features already integrated is listed [here](https://github.com/coq/coq/pulls?q=is%3Apr+label%3A%22kind%3A+feature%22+milestone%3A8.9+is%3Aclosed)
and the one planned for integration are listed [here](https://github.com/coq/coq/pulls?utf8=%E2%9C%93&q=label%3A%22kind%3A+feature%22+milestone%3A8.9%2Bbeta1+is%3Aopen).
