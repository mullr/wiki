= How to compile all coq-contribs with a chosen Coq branch =

On our [[https://ci.inria.fr/coq|Jenkins server]],
in the [[https://ci.inria.fr/coq/view/tracked-coq-contribs|"tracked-coq-contribs" view]],
there is a [[https://ci.inria.fr/coq/view/coq-contribs/job/make-all|"make-all" job]].

There, if you click on the [[https://ci.inria.fr/coq/view/tracked-coq-contribs/job/make-all/build?delay=0sec|"Build with Parameters" link]],
Jenkins will then clone the designated branch of from the designated Coq repository,
and then build all coq-contribs (cloned from the designated repository and the designated branch).

The progress and the results are displayed in the usual way.
