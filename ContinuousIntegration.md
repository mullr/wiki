In order to hook up a coq-contrib to Jenkins:
 * create a new Jenkins job in [[https://ci.inria.fr/coq/view/coq-contribs/|coq-contribs view]] by copying any of the existing jobs in the same view.
 * the name of the new item '''must''' be the same as the name of the directory that holds its source-code in the "coq-contrib" repository.
 * after copying, keep all the values as they are.
To see if all is well, build for it and check the result.
