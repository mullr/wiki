#acl CoqAdminGroup:read,write,admin,revert,delete CoqDevelopersGroup:read,write

Ceci est la page d'accueil de l'espace réservé aux développeurs de Coq. Pour toute information sur l'édition de ces pages, merci de vous référer à la page 
[[CoqDevelopment/Usage|Usage]].

== Compte-rendus des GT Coq ==

 * [[CoqDevelopment/CRGTCoq20081118|18 novembre 2008]]
 * [[CoqDevelopment/CRGTCoq20081029|29 octobre 2008]] (lancement de l'ADT Coq)
 * [[CoqDevelopment/CRGTCoq20081010|10 octobre 2008]]

== Discussions en cours ==

La discussion chaude du moment est celle sur la [[CoqDevelopment/SyntaxeDesLieurs|la syntaxe des lieurs]], rendue nécessaire suite à l'ajout des classes de types par Matthieu Sozeau.

== Discussions pour prochain GT ==

''Réorganisation des variables de configuration de Coq'' ? Les choses qui me semblent à comprendre sont :

 * Quels sont les rôles respectifs de COQSRC, COQTOP, COQBIN, COQLIB, et où doit se trouver chacune (dans Makefile ou dans Coq_config ou dans les deux) ?
 * En particulier, quand on est en mode compilation, ne suffit-il pas
  * de connaître COQSRC (dans le Makefile pour compiler et dans Coq_config pour l'option -boot) ?
  * de connaître COQLIB (qui vaut COQSRC en mode local ou en -boot et qui vaut le répertoire d'installation sinon) ?
 * Comment s'arranger pour que camldir et camlp4lib dans Coq_config ne servent qu'à la compilation (puisque une fois installés rien n'assure que caml et camlp4 seront au même endroit) ?
  * En particulier, comment faire pour que coqmktop puisse être utilisé hors mode compilation de l'archive (et donc sans forcément dépendre des valeurs de camldir et camlp4dir dans coq_config) ? Faut-il des options -camlbin, -camlp4bin, ou des variables globales CAMLBIN, CAMLP4BIN (ou CAMLLIB, CAMLP4LIB) ?
  * Et que coq_makefile sache gérer l'appel à un coqtop se trouvant dans une archive compilée localement ou se trouvant dans une archive installée ? Pour positionner ses propres variables, il doit savoir si on est en local, si on utilise camlp4 ou camlp5, et idéalement,quelle version de ocaml on a besoin. Peut-on utiliser l'option -config de coqtop pour cela ?
 * Dans quels cas souhaite-t-on que COQTOP (ou COQSRC), CAMLP4LIB et COQLIB puissent être repositionnés dynamiquement (via l'environnement shell) ? En tout cas pas en mode compilation je suppose ? Ou bien est-ce pour les packages linux ? [HH]
