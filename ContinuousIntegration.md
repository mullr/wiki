= How to compile all coq-contribs with a chosen Coq branch =

On our [[https://ci.inria.fr/coq|Jenkins server]],
in the [[https://ci.inria.fr/coq/view/coq-contribs|"coq-contribs" view]],
there is a [[https://ci.inria.fr/coq/view/coq-contribs/job/coq-contribs|"coq-contribs" job]].

When you start it, you can specify which coq-repository to clone, which branch to check out etc.
All coq-contribs will then be rebuilt with the Coq version you have chosen.

== How to test your pull request ==

The medium-term plan is have github to request a build automatically for each pull-request.

Meanwhile, there are two approaches depending if you have a Jenkins Inria account.

=== I don't have a Jenkins account ===

If you do not yet have an account at our Jenkins instance, you can create one:

  * to to [[https://ci.inria.fr/|this place]]
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

E.g. in case of [[https://github.com/coq/coq/pull/178|this pull request]] it means we have to "build" the [[https://ci.inria.fr/coq/view/coq-contribs/job/coq-contribs|"coq-contribs" job]] with the following parameters:

{{attachment:jenkins.png}}

Instructions [[https://github.com/coq-contribs/coq-contribs/blob/master/FAQ.md#how-can-i-add-my-work-to-coq-contribs|how to add your work to coq-contribs]].
