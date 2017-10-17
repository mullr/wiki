Il y a un bug sur gforge.inria.fr dans la préservation du charset et des caractères utf-8 dans les messages de commits. Voici un moyen d'y remédier en filtrant son courrier avec procmail :

Dans son fichier `~/.procmailrc`, mettre les lignes

    #Fix unicode in gforge commit mails (multi-part case; charset missing and utf-8 broken)
    :0 fbw
    * ^TO*-commits@lists.gforge.inria.fr
    | /home/pauillac/coq/herbelin/bin/mailman-fix-utf8

    #Fix unicode in gforge commit mails (single-part case: wrong charset in header)
    :0 fhw
    * ^TO*-commits@lists.gforge.inria.fr
    * ^Content-Type: text/plain; charset="iso-8859-1"
    | /usr/local/bin/formail -I 'Content-Type: text/plain; charset="UTF-8"'

(pour activer procmail, mettre par exemple `"| /usr/bin/procmail"` dans son `~/.forward`)

Le filtre ad hoc `gforge-fix-utf8` se compile avec la commande
`ocamllex gforge-fix-utf8.mll; ocamlopt -o gforge-fix-utf8 gforge-fix-utf8.ml` à partir du fichier joint gforge-fix-utf8.mll (perdu).
