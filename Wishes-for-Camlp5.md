I'm collecting here a few wishes about Camlp5 which would help for the purpose of Coq. Please edit/extend...

#### Required type invariants not enforced by the API

To write a Camlp5 action Coq-side, one needs to know the type of this action in the implementation of Camlp5 (for instance, a `Gramext.Stoken` action is supposed to return a `string` (which is the type of `parser_of_token` in this [code](https://github.com/camlp5/camlp5/blob/ff7703f2f0db80d539ac34403150cc11f909c548/lib/grammar.ml#L849-L855).

There is a [proposal](https://github.com/camlp5/camlp5/pull/15) to use GADT to enforce these invariants

#### In `Grammar`, `delete_rule` is not symmetric to `extend`

If one creates a level, then creates a rule in this level, then deletes this rule, this deletes not only the rule but also the level. This forces Coq to maintain a copy of the stack of levels to manually re-define
the level after a deletion. It would be useful to have atomic deletions commands symmetrical to the extension commands.

#### How to make factorization of `LIST1` `SEP` and `LIST0` `SEP` simpler

For instance, if I have two rules sharing a `LIST1 foo SEP "bar"` prefix, they are factorized but if I have two rules sharing a `LIST1 foo SEP [ "bar" ]` (which itself is a short-hand for `sharing a `LIST1 foo SEP [ _ = "bar" -> () ]`), there are not factorized.

I believe that this can be made simpler, e.g. by `SEP` taking a list of symbols rather than a single symbol. This is consistent with the fact that the result of parsing the separator is dropped in `LIST1` `SEP` and `LIST0` `SEP`,  (`v` [here](https://github.com/camlp5/camlp5/blob/ff7703f2f0db80d539ac34403150cc11f909c548/lib/grammar.ml#L740)), so that it should be correct to have the parsing of the separator returns `()`. Then, the syntactic equality on what `SEP` parses could be equality of components of the list. 

On this topic, see Camlp5 issue [16](https://github.com/camlp5/camlp5/issues/16) and #6167.

#### How to ask Camlp5 to strictly respect levels?

There are some tolerance to bypass the levels in case of failure of finding a rule which applies. Sometimes this is convenient as it parses more things when otherwise there would have been a failure, but in other cases, this is disconcerting.
```coq
Notation "[ x + 1 ]" := (Some x) (x at level 40).
Check [ 0 + 0 + 1 ].
(* Syntax error: '+' '1' ']' expected, even though "+" is at level 50 *)
```
Even more disconcerting:
```coq
Notation "[ x + 1 ]" := (Some x) (x at level 40).
Check [ 0 + 0 + 1 ].
(* Syntax error: '+' '1' ']' expected *)
Check [ fun A => A + 1 ].
(* Syntax error: '+' '1' ']' expected, even though "fun" is at level 200 *)
Notation "[ : x + 1 ]" := (Some x) (x at level 40).
Check [ fun A => A + 1 ].
(* Error changed: Syntax error: ':' or [constr:operconstr level 40] expected after '[' *)
Check [ 0 + 0 + 1 ].
(* Error unchanged: Syntax error: '+' '1' ']' expected after [constr:operconstr level 40] *)
```
As a consequence, we cannot e.g. enforce the non associativity of an operator.

See also item 2 of this [comment](https://github.com/coq/coq/pull/982#issuecomment-346080849) and how to parse both `{ forall A, A } + { True }`, `{ x : A | P }` and `{ ' x : A | P }`.
