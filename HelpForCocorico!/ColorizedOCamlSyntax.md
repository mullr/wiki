#language en
= Ocaml code with highlighted syntax =

We use the Ocaml parser written by Jakub Piotr Nowak.

You can type

{{{
{ { { #!ocaml
<ocaml code>
} } }
}}}



For example

{{{#!ocaml
let constr_of c = Constrintern.interp_constr Evd.empty (Global.env()) c
}}}

By default you don't get any line numbers. Adding numbers=on adds line numbers to the code, which then can be toggled on and off in most browsers.

{{{#!ocaml numbers=on
let constr_of c = Constrintern.interp_constr Evd.empty (Global.env()) c
}}}
