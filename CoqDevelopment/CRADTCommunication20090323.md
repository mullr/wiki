Meeting on "Coq communication", Monday, the 23th of March
=========================================================

Participants: V. Gross, T. Hutchinson, A. Spiwack, P. Letouzey, J. Forest, H. Herbelin.

Proposition for a type of constructions that unifies all of constr, constr\_expr and rawconstr. Maybe should this type be used in place of constr\_expr and rawconstr. Does it looks like as an approach to be investigated further?

1.  Reminding the chain of command interpretation in Coq

<!-- -->

    string
     |
     | Vernac.parse_phrase
     |
     V
    vernac_expr(raw_tactic_expr,constr_expr)
     |
     | Vernacentries.interp
     |
     |------------------------
     |     |                 |
     V     |                 |
    unit   |                 |
           V                 V
     glob_tactic_expr    rawconstr
                             |
                             |
                             |
                             V
                          constr

Note: `constr_expr` should have been called `raw_constr` and `rawconstr` should have been better named `glob_constr`.

-   Location informations are everywhere except in `constr`
-   Semantics of commands and keywords are known in `vernac_expr`

1.  Requirements

We have the following needs:

-   For the graphical interfaces:
    -   retrieving informations on input text from Coq (input buffer)
    -   getting informations from Coq output text Coq (goal/query windows)
-   For bidirectional communication with external tools
    -   sending requests to external tools ("external")
    -   getting terms, tactics, commands from external tools
-   We need to be able to communicate at different levels:
    -   we need to be able to receive raw data from external tools (as `string` or as `raw_constr`, for easiness of the communication)
    -   we need to be able to receive (supposedly) type-checked data from external tools (for efficiency of the communication)
    -   we need for graphical interfaces to match the Coq expressions/commands with their input/output (and hence to have locations)

1.  A temptative unified type for communication

It seems we need to have a communication data structure able to convey informations at different levels. Here is an attempt for such a universal type (in ML-style):

```ocaml
type uconstr =
| App of (* impargs not in effect *) luconstr * luconstr list
| UserApp of (* implicit arguments in effect *)
    bool hidable * (* true means is a coercion *)
    luconstr * (explicitation located hidable option * luconstr) list
| Lambda of name located * luconstr hidable * luconstr
| Prod of name located * luconstr hidable * luconstr
| LetIn of name located * luconstr * (* always hidden: *) luconstr * luconstr
| Var of name | Rel of int (* Two ways to denote variables *)
| Ref of reference
| Sort of sorts
| Cast of uconstr * uconstr * cast_kind
| Evar of (existential_key located * luconstr list) option
| Notation of
   notation_component located list * (* what it means: *) uconstr option
| Prim of prim_token * (* what it means: *) uconstr option
| Generalization of binding_kind * abstraction_kind option * luconstr
| Delimiters of string * uconstr
| If of uconstr * (name * luconstr hidable option) * luconstr * luconstr
| LetTuple of name list * (name * luconstr hidable option) * luconstr * luconstr
| Cases of       \
| Fixpoint of    | a merge to do of rawconstr.ml and topconstr.ml
| CoFixpoint of  /

and luconstr =
  (* a located uconstr, possible annotated with its type *)
  uconstr located * uconstr option

and reference =
 (* possibly an absolute qualid, possibly with its "uconstr" form available *)
  qualid * global_reference option

and notation_component =
| Terminal of string
| Term of uconstr
| Ident of identifier

type 'a hidable = 'a * bool
  (* used to remember informations from constr that the printer does not need
     to display if "true" *)
```

Notes:

-   `Evar None` for `Hole`
-   `Meta`'s are not supposed to occur in an interaction with outside
-   `PatVar`'s are used in Ltac patterns; they may have to be added

`type uvernac = ...` morally like `vernac_expr` with `uconstr` in place of `constr_expr and string * luconstr` generic\_argument list (as in `TacExtend`) in place of `raw_tactic_expr` (`generic_argument` is currently not large enough to support encoding of all primitive tactics as Extend tactics but that's something we may eventually consider).

The purpose is to obtain that all of `raw_constr` (i.e. `constr_expr`), `glob_constr` (i.e. r`awconstr`), and `constr` can indeed be embedded in `luconstr` in such a way that any `luconstr` coming from a `constr` can be skimmed to recover the original `constr`, and any `luconstr` can be skimmed too into a ready-to-be-displayed `constr_expr`.

Typically, Detyping (that goes from `constr` down to `rawconstr`) should be rewritable as the injection from `constr` to `luconstr` followed by a internal translation from `luconstr` to `luconstr`. Constrextern (that goes from `rawconstr` to `constr_expr`) should be rewritable as a internal translation from `luconstr` to `luconstr` followed by the skimming from `luconstr` to `constr_expr`.

The communication could then be done at the level of `luconstr`. E.g. CoqIde would receive `luconstr` that it would print itself, keeping the hidden informations for on-demand display. External would receive `luconstr` with a flag indicating whether the interning and pretyping phase have to be done or not.

\[We also have to understand whether `raw_tactic_expr` and `glob_tactic_expr` can indeed be simulated in an interesting and useful way by pairs `string * luconstr generic_argument list` (this amounts to understand whether every tactic can be defined via a `TACTIC EXTEND` construction).\]
