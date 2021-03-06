Performance
===========

There are some hints [here](http://logical.saclay.inria.fr/coq-puma/messages/7efd0d05c29e3702) (dead link)

Try `Typeclasses eauto.`

Be careful with coercions. They're incredibly useful, but can lead to a great deal of unnecessary work during the convertibility check. Take a look at `Print Graph` and try to prune it down to the minimum amount you need.

Try using the `abstract` tactic.

Memory Consumption
==================

See also [this thread](http://article.gmane.org/gmane.science.mathematics.logic.coq.club/5394) regarding memory consumption.

If you have your development in a single large file, try breaking it into multiple files.

Even if your machine has ample memory, reducing memory consumption can speed up proof checking (due to garbage collection?)

Opaque Proofs
-------------

The `Opaque`/`Transparent` distinction is important for keeping memory consumption under control. Subproofs wrapped in the `abstract` tactic and proofs which end with `Qed` are opaque; all others are transparent (unless made opaque with the `Opaque` command).
