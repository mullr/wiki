== Performance ==

There are some hints [[http://logical.saclay.inria.fr/coq-puma/messages/7efd0d05c29e3702|here]] (dead link)

Try {{{Typeclasses eauto.}}}

Be careful with coercions.  They're incredibly useful, but can lead to a great deal of unnecessary work during the convertibility check.  Take a look at {{{Print Graph}}} and try to prune it down to the minimum amount you need.

Try using the {{{abstract}}} tactic.

== Memory Consumption ==

See also [[http://article.gmane.org/gmane.science.mathematics.logic.coq.club/5394|this thread]] regarding memory consumption.

If you have your development in a single large file, try breaking it into multiple files.
