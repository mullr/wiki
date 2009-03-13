= Trucs pour accélérer le processus de compilation de Coq sous Emacs =

Raccourcis dans `.emacs` pour compiler et trouver les erreurs « instantanément » :

{{{
;;; pour initier la 1e compil de la session par simple appui sur F5
(global-set-key [f5] 'compile)
;;; pour relancer la compil en cours par appui sur F6
(global-set-key [f6] 'recompile)
;;; pour trouver _instantanement_ la derniere erreur de compilation avec F7
(global-set-key [f7] 'next-error)
}}}

Script de nom `makecoq` à mettre dans son `path` permettant de compiler Coq depuis n'importe quel sous-répertoire sans refaire les dépendances

{{{
#!/bin/sh

# permet d'avoir les messages de make en anglais afin que emacs sache les parser
export LC_ALL=C

case "$@" in  
  *-f\ *) true;;
  *-C\ *) true;;
  *)
  if [ -e GNUmakefile -o -e Makefile -o -e makefile -o "$PWD" == "/" ]; then
    true
  else
    # NO_RECALC_DEPS=1 GOTO_STAGE_N=2 permet de court-circuiter le calcul des dépendances (pour les machines lentes)
    # le grep -v permet de supprimer les ***** du message de make et d'éviter d'avoir
    # à scroller dans la fenêtre de compilation pour trouver la prochaine erreur
    cd .. && exec make NO_RECALC_DEPS=1 GOTO_STAGE_N=2 $@ | grep -v '\*\*\*\*\*\*\*\*'
  fi;;
esac
}}}

Ensuite, une fois `emacs` ouvert sur le fichier, par exemple
`pretyping/unification.ml` :

`F5`, une première fois qui ouvre une ligne d'édition dans laquelle je mets
{{{
  makecoq bin/coqtop.byte
}}}
ou
{{{
  makecoq theories
}}}
ou, si l'on ne veut tester que les premiers fichiers de la bibliothèque
{{{
  makecoq BEST=byte theories
}}}
retour chariot, puis, si erreur à la compil, `F7` qui positionne immédiatement à l'endroit de l'erreur. Correction de l'erreur, et `F6` pour relancer exactement la même compil, puis `F7`, correction, `F6`, etc. jusqu'à réussite de la compil.

Les `NO_RECALC_DEPS=1 GOTO_STAGE=2` sont là pour contourner le calcul des dépendances. Dans la pratique, si la compil échoue pour une raison de dépendance, je relance un `make stage2` dans un terminal à côté, juste pour refaire les dépendances et je repars avec `F6`. Si aucun des `.ml4` utilisés pour parser d'autres `.ml4` est concerné, alors on peut même se contenter de `make GOTO_STAGE=2 dummy`.

Il y a certaines erreurs que `F7` ne capturent pas comme `Values do not match`. C'est parce que ocaml n'envoie pas de localisation pour cette erreur.

(merci à JCF, PL et LM)

= Compilation de la doc =

Pour compiler des cibles spécifiques de la doc, démarrer sur `Makefile.stage3`, comme dans :
{{{
  make -f Makefile.stage3 doc/refman/Reference-Manual.ps
}}}
