This page describes how to compile a tactic written in OCaml. Here is an example a tactic that checks if its argument is an evar:

{{{#!ocaml
(*i camlp4deps: "parsing/grammar.cma" i*)
(*i camlp4use: "pa_extend.cmo" i*)

open Pp
open Term
open Refiner

TACTIC EXTEND evar_match
| [ "evar_match" constr(x) ] ->
    [ match kind_of_term x with
        | Evar _ -> tclIDTAC
        | _ -> tclFAIL 0 (str "not an evar")
    ]
END;;
}}}

To compile it, save it to e.g. {{{evar_match.ml}}}, and use the following commands

{{{#!sh
coq_makefile evar_match.ml > Makefile
make
}}}

{i} '''Note:''' with version 8.4 and later, the file extension must be .ml4 if it needs to be preprocessed (which is the case when {{{TACTIC EXTEND}}} is used).

You need the development libraries of Coq and its dependencies (most notably OCaml and Camlp5), which should be installed if you compiled from source, but might be distributed separately if you are using a precompiled package (on Debian and its derivatives, they are in the {{{libcoq-ocaml-dev}}} package).

This will generate {{{evar_match.cmo}}} and {{{evar_match.cmxs}}} (if possible on your platform). You can then use it with the {{{Declare ML Module}}} command:

{{{#!coq
Declare ML Module "evar_match".

Goal forall (x y z : nat), x = y -> y = z -> x = z.
  intros;
  eapply trans_eq;
  match goal with
    | |- ?a = ?b => evar_match a; idtac a
    | |- ?a = ?b => evar_match b; idtac b
  end.
}}}
Try to replace {{{match}}} by {{{lazymatch}}} to see another behaviour.

The only reliable documentation for writing tactics in OCaml is Coq's source code :-) Tactics defined with {{{TACTIC EXTEND}}} (usually found in *.ml4 files) are a good start.

/!\ '''Warning:''' Tactics written in OCaml are highly dependent on the version of Coq, and there is no guarantee on the stability of Coq's API between major versions (e.g. 8.3 and 8.4). The API should be stable between patch level (bugfix) versions, though, and efforts are made to document intrusive changes in {{{dev/doc/changes.txt}}} and/or in commit messages ({{{git annotate}}} and {{{git log -p}}} on a [[https://sympa-roc.inria.fr/wws/arc/coqdev/2010-09/msg00042.html|git clone]] of Coq sources might be useful).

The tactic described in this page has been tested with Coq 8.2, 8.3 and trunk r13631 (2010-11-08). It has been part of Coq (named {{{is_evar}}}) since version 8.3pl1, but this page can be used as a skeleton to build new tactics in OCaml.
