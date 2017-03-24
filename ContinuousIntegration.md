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

E.g. in case of [[https://github.com/coq/coq/pull/434|this pull request]] it means we have to "build" the [[https://ci.inria.fr/coq/view/opam/job/opam-install|"opam-install" job]] with the following parameters:

{{attachment:opam-install.1.png}}

=== Run the benchmarks for the tracked developments ===

E.g. in case of [[https://github.com/coq/coq/pull/434|this pull request]] it means we have to "build" the [[https://ci.inria.fr/coq/view/opam/job/opam-install|"benchmark-the-whole-branch" job]] with the following parameters:

{{attachment:benchmark-the-whole-branch.1.png}}

where the field ''coq_opam_packages'' can be set to:
----
coq-mathcomp-algebra coq-mathcomp-character coq-mathcomp-field coq-mathcomp-fingroup coq-mathcomp-solvable coq-mathcomp-ssreflect coq-unimath coq-math-classes coq-corn coq-iris coq-hott coq-geocoq coq-flocq coq-coquelicot coq-compcert coq-fiat-parsers coq-fiat-crypto coq-color coq-sf
----
Assuming that you will use the above value for the ''coq_opam_packages'' field, the benchmarking will finish in:
 * 7 hours when each package is compiled once
 * 15 hours when each package is compiled twice
 * 22 hours when each package is compiled thrice
----
The job itself produces a looooong log. At its end you should see the results rendered as a table:

{{attachment:benchmarking-results.png}}

Each line shows the measurement for a single OPAM package.

Each measured/computed quantity has its own column.

E.g., in the table shown above, we see that the compilation of '''coq-geocoq'''
 * originally took 2394.71 seconds
 * now it takes 2215.65
 * which means that it decreased by cca. 7%

The lines of the table are ordered wrt. improvements in the overall compilation times.
