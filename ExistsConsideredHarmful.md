== Exists and \/ Considered Harmful ==

One should never use {{{exists}}} and {{{\/}}} because the resulting types are in {{{Prop}}}.  This means that case analysis can never occur on objects of these types to produce an object in {{{Set}}}.  Inevitably there comes a time when someone will want to do this with the result of your lemma, and he/she will be angry that they cannot.

Instead use {{{sig}}} (aka{{{ {x : T | P} }}}) and {{{sumbool}}} /{{{ {A}+{B} }}}(in {{{Set}}}) or {{{sum}}} /{{{A + B}}} (in {{{Type}}}).  See under {{{Coq.Init.Specif}}} and {{{Coq.Init.Datatypes}}}.
