= How to compile all coq-contribs with a chosen Coq branch =

On our [[https://ci.inria.fr/coq|Jenkins server]],
in the [[https://ci.inria.fr/coq/view/make|"make" view]],
there is a [[https://ci.inria.fr/coq/view/make/job/make-coq-contribs|"make-coq-contribs" job]].

There, if you click on the [[https://ci.inria.fr/coq/view/make/job/make-coq-contribs/build?delay=0sec|"Build with Parameters" link]],
Jenkins will then clone the designated branch of from the designated Coq repository,
and then build all coq-contribs (cloned from the designated repository and the designated branch).

The progress and the results are displayed in the usual way.
