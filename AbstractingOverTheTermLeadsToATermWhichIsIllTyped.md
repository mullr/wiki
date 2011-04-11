We're not really sure.

There's some advice here: http://logical.saclay.inria.fr/coq-puma/messages/883f1468f299699c

Try using {{{destruct}}}.

Note that this error message is sensitive to what's in the context.  Try using {{{clear}}} to remove any hypotheses you don't need.

Also try {{{dependent induction}}} from {{{Coq.Program.Equality}}} (although this requires additional axioms outside of CiC).
