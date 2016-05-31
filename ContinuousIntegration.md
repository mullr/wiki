= How to compile all coq-contribs with a chosen Coq branch =

On our [[https://ci.inria.fr/coq|Jenkins server]],
in the [[https://ci.inria.fr/coq/view/coq-contribs|"coq-contribs" view]],
there is a [[https://ci.inria.fr/coq/view/coq-contribs/job/coq-contribs|"coq-contribs" job]].

When you start it, you can specify which coq-repository to clone, which branch to check out etc.
All coq-contribs will then be rebuilt with the Coq version you have chosen.

== How to test your pull request ==

At the moment, there is not a more convenient method than, really, for a given pull-request:
 * determine the URL that designates the GIT repository
 * determine the name of the branch (of Coq) in that repository that should be compiled

E.g. in case of [[https://github.com/coq/coq/pull/178|this pull request]] it means we have to "build" the [[https://ci.inria.fr/coq/view/coq-contribs/job/coq-contribs|"coq-contribs" job]] with the following parameters:

{{attachment:jenkins.png}}

== How to add your own contrib to Jenkins ==

1. The first step is to submit a pull request to https://github.com/coq-contribs/coq-contribs Your project should be hosted in a public git server.
1. More information should be appear in the `coq-contribs` readme.
