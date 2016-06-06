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

You could wait for the automatic integration to happen, but you can also write a mail to the coq-dev mailing list requesting a developer to start your build. All you'll need to provide is the url of public git repository and branch.

=== I have a Jenkins account ===

 * determine the URL that designates the GIT repository
 * determine the name of the branch (of Coq) in that repository that should be compiled

E.g. in case of [[https://github.com/coq/coq/pull/178|this pull request]] it means we have to "build" the [[https://ci.inria.fr/coq/view/coq-contribs/job/coq-contribs|"coq-contribs" job]] with the following parameters:

{{attachment:jenkins.png}}

Instructions [[https://github.com/coq-contribs/coq-contribs/blob/master/FAQ.md#how-can-i-my-work-to-coq-contribs|how to add your work to coq-contribs]].
