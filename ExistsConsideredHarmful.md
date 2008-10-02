== Exists and \/ Considered Harmful ==

One should never use {{{exists}}} and {{{\/}}} because the resulting types are in {{{Prop}}}.  This means that case analysis can never occur on objects of these types to produce an object in {{{Set}}}.  Inevitably there comes a time when someone will want to do this with the result of your lemma, and he/she will be angry that they cannot.

Instead use {{{sig}}} (aka {{{{x : T | P}}}}) and {{{sumbool}}} (aka {{{{A}+{B}}}}).  See under {{{Coq.Init.Specif}}}.
