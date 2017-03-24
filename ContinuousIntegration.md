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

{{attachment:opam-install.png}}

=== Run the benchmarks for the tracked developments ===

E.g. in case of [[https://github.com/coq/coq/pull/434|this pull request]] it means we have to "build" the [[https://ci.inria.fr/coq/view/opam/job/opam-install|"benchmark-the-whole-branch" job]] with the following parameters:

{{attachment:benchmark-the-whole-branch.png}}

where ''coq_opam_packages'' can be e.g.: ''coq-mathcomp-algebra coq-mathcomp-character coq-mathcomp-field coq-mathcomp-fingroup coq-mathcomp-solvable coq-mathcomp-ssreflect coq-unimath coq-math-classes coq-corn coq-iris coq-hott coq-geocoq coq-flocq coq-coquelicot coq-compcert coq-fiat-parsers coq-fiat-crypto coq-color coq-sf''
