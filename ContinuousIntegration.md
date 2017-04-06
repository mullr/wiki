== How to test your pull request ==
The medium-term plan is have github to request a build automatically for each pull-request.

Meanwhile, there are two approaches depending if you have a Jenkins Inria account.

=== I don't have a Jenkins account ===
If you do not yet have an account at our Jenkins instance, you can create one:

 * go to [[https://ci.inria.fr/|this place]]
 * click on "Sign Up"
 * provide required information
 * click on "Log In"

Then:

 * go to [[https://ci.inria.fr/dashboard|"dashboard"]]
 * click on "Join an existing project"
 * and request to join the project "coq"

You'll have to wait until some of the existing members of the project actually confirms your membership.

=== I have a Jenkins account ===
 * determine the URL that designates the GIT repository
 * determine the name of the branch (of Coq) in that repository that should be compiled

Now you can:

=== Check if a given branch breaks some of the tracked developments ===
E.g. in case of [[https://github.com/coq/coq/pull/434|this pull request]] it means we have to "build" the [[https://ci.inria.fr/coq/view/opam/job/opam-install|opam-install]] job with the following parameters:

{{attachment:opam-install.3.png}}

=== Run the benchmarks for the tracked developments ===
E.g. in case of [[https://github.com/coq/coq/pull/155|this pull request]] it means we have to "build" the [[https://ci.inria.fr/coq/view/opam/job/benchmark-part-of-the-branch|benchmark-part-of-the-branch]] job with the following parameters:

{{attachment:benchmark-part-of-the-branch.5.png}}

where the field ''coq_opam_packages'' is by default set to:

----
coq-hott coq-flocq coq-compcert coq-vst coq-geocoq coq-color coq-fiat-crypto coq-fiat-parsers coq-unimath coq-sf coq-mathcomp-ssreflect coq-iris coq-mathcomp-fingroup coq-mathcomp-finmap coq-coquelicot coq-mathcomp-algebra coq-mathcomp-solvable coq-mathcomp-field coq-mathcomp-character coq-mathcomp-odd_order

----
Assuming that you will use the above value for the ''coq_opam_packages'' field, the benchmarking will finish in:

 * 7 hours when each package is compiled once
 * 15 hours when each package is compiled twice
 * 22 hours when each package is compiled thrice
 * 28 hours when each package is compiled four-times

----
The job itself produces a looooong log. At its end you should see the results rendered as a table:

{{attachment:benchmarking-results.0.png}}

Each line shows the measurement for a single OPAM package.

Each measured/computed quantity has its own column.

The git commits, that were considered are stated explicitely below the table as '''NEW''' and '''OLD'''.

E.g., in the table shown above, we see that the compilation of '''coq-geocoq'''

 * originally took 2394.71 seconds
 * now it takes 2215.65
 * which means that it decreased by cca. 7%

The lines of the table are ordered wrt. improvements in the overall compilation times.
