Motivation
==========

Why this project ?
------------------

The integration of the most popular features of SSReflect to Coq is not a mere extension of the existing set of tactics. This language is rather a more stuctured and robust way of writing proof scripts. Moreover, many SSReflect tactics widely overlap with the traditional Coq tactics. An extension of the current tactic language providing primitives to write proof scripts in the style of SSReflect (possibly with a syntax closer to V8 syntax) is not satisfactory in the long term since it would let the user with too many choices without guidance about which is better.

The goal of this page is to gather ideas about the evolution of the tactic language, and then proposing a new syntax that would address most of the criterions considered as prioritary. We try to avoid as long as possible to discuss concrete syntax matters, in order to avoid the endless arguments of personal taste. This would also hinder the most important goal: designing the *abstract* syntax of the language.

It is quite clear that this page is influenced by the ideas that have led to SSReflect, but it also tries to go further on some points, considering alternative design choices, and sometimes a different point of view.

Currently, it might reflects the partial opinion of the initial author. The idea is that other contributions are welcome and should help cover more aspects and integrate discussions on aspects on which there is no consensus.

This page is **not** the place to discuss new features. This would make the task of implementing the proposal too hard. We should try to stick to easy generalizations of existing features. Nonetheless, the design phase should always try to stay compatible with desirable extensions.

Method
------

The proposed roadmap is the following:

* Write down a list of important design choices and features.

* Discriminate between features of general use, and those corresponding to a specific proof domain.

* Compare the features, highlighting analogies, orthogonalities. The same concept can be implemented in slightly differently from a tactic to the other. In this case, it is important to isolate what what forms the common (or general) feature and what are the variants of the general feature. If such variants are considered necessary, this should be compared to variants of other features.

* This gives birth to a list of independent features, to which we can then assign concrete syntax, beginning with those considered of wider usage.

General Rules
=============

Basic criterions
----------------

**TODO: tranlate...**

* Robustesse et facilité de maintenance des scripts:

  * éviter l'emploi de noms engendrés automatiquement

  * structuration pour que le script casse à un endroit proche de celui où le comportement a divergé,

  * traçage des hypothèses pour retrouver rapidement quelles portions du script affectent quelles hypothèses.

* Facilité d'utilisation en mode "premier jet": lors de la construction initiale de la preuve, l'écriture du script ne doit pas être freinée par une discipline trop contraignante.

* Effort d'accessibilité pour les débutants sans pour autant pénaliser les utilisateurs expérimentés: même si la concision est souhaitable, il est plus important que la syntaxe dirige l'attention du lecteur sur les points d'articulation de la preuve, si possible avec des notations qui évoquent naturellement ce qu'il s'y passe.

* Extensibilité: possibilité de définir des syntaxes utilisateur.

La suite de cette section aborde certains choix de conception et des discussions dégageant les critères qu'ils satisfont.

Script Language, Structured Language
------------------------------------

**TODO: tranlate...** 

Il faut bien prendre en compte non seulement le resultat fini, mais bien tout le processus d'élaboration d'un script de preuves. Passage d'un style "script" (premier jet de la preuve) où l'on ne veut pas perdre de temps (par exemple à nommer des hypothèses alors que le script sera peut être modifié très rapidement), vers un style plus robuste, dans lequel toutes les hypothèses sont nommées, les effets de bords explicités, etc.

Il semble utile de considérer plusieurs modes: un mode libre où toutes les tactiques sont disponibles, et des modes bridés qui imposent une discipline (nommage, etc.). Il convient que ce passage se fasse en douceur autant que possible. Le passage de l'un à l'autre pourrait être facilité par un mécanisme de complétion: lorsque l'utilisateur entre une commande laissant au système une liberté (nommage automatique des hypothèses, généralisation automatique), celui-ci devrait retourner la version explicitée, de façon à ce que l'on puisse facilement passer à un script robuste (tâche éventuellement réalisée par l'interface).

Le mode déclaratif semble correspondre à un autre but: communiquer des preuves en langage presque naturel, même s'il n'est pas forcement le plus facile à maintenir. Il pourrait être intéressant de voir si cela s'applique aussi au langage déclaratif*.* 

Extendability
-------------

**TODO: tranlate...** 

Il faut essayer d'anticiper les évolutions, d'où l'intérêt de bien classifier et généraliser les fonctionalités orthogonales de façon à ce qu'une nouvelle tactique bénéficie automatiquement d'un support plus important (exemple de rewrite plus bas).

Verbose Syntax vs Compact Syntax
--------------------------------

**TODO: tranlate...** 

L'important n'est pas tant le nombre de caractères que la répartition*:* les étapes administratives doivent être aussi légères (et composables) que possible, de façon à attirer l'attention sur les étapes de raisonnement.

En revanche, l'argument visant à systématiquement chercher une syntaxe compacte pour ne pas "fatiguer les doigts de l'utilisateur" semble discutable. D'une part un utilisateur confirmé prend rapidement l'habitude de taper des mots longs (on ne réforme pas les langues naturelles de façon à réduire la longueur des mots: le mot anticonstitutionnellement est long mais on le comprend), d'autre part une syntaxe "cryptique" rend plus raide la courbe d'apprentissage du langage pour les utilisateurs novices ou le coût de se replonger dans une preuve pour les utilisateurs occasionnels.

Le principe "une commande doit pouvoir tenir sur une ligne de 78 caractères" est à discuter. Il ne faut pas sombrer dans la mauvaise foi pour le satisfaire (on peut toujours y arriver si l'on découpe suffisamment la commande à l'aide d'abbréviations, ce qui peut au final diminuer la lisibilité). Il devrait être secondaire par rapport à la volonté que la syntaxe "parle" aussi aux utilisateurs novices, sans évidemment croire que l'on arrivera à ce que n'importe quel utilisateur puisse comprendre tous les détails d'une invocation de tactique.

More detailed items
===================

Introduction and Generalization Tacticals
-----------------------------------------

**TODO: tranlate...**

C'est une contribution importante de SSReflect que de présenter les mécanisme de nommage et de généralisation comme des tacticielles ayant un comportement uniforme.

Hypotheses anonymes...

Layout of a Basic Command Line
------------------------------

**TODO: tranlate...**

En anticipant sur la section réservée à la syntaxe, on peut se poser la question de manière abstraite. Une idée reprise de SSReflect est que typiquement, une ligne de commande suit le schéma "*f(x) = y*" où *f* est une procédure prenant ses arguments *x* par généralisation et produisant un résultat *y* (tacticielle de nommage). Sans rentrer dans les détails, on peut déjà se poser la question de l'ordre dans lequel doivent apparaître *f*, *x* et *y*, puis quels symboles intercaler pour suggérer cette application.

Rewriting
---------

**TODO: tranlate...**

La tactique rewrite se dirige de plus en plus vers un "shell" dans lequel on éxécute une séquence de commandes (réécriture proprement dite, simplification, dépliage de constantes). Dans chaque étape, on peut distinguer 2 composantes:

* la stratégie: description de l'occurrence à réécrire (recherche de sous-terme par filtrage, utilisation de clauses ``in`` et des indicateurs de répétition;

* la procédure à appliquer: simplification, dépliage, réécriture Leibniz ou setoïde.

Ces 2 composantes doivent évidemmant communiquer: la stratégie passe à la procédure le sous-terme et le contexte d'occurrence, et la procédure peut retourner à la stratégie soit un morceau de preuve, soit un signal de backtrack ou d'échec.

Le gain majeur est de faciliter l'implantation de nouvelles procédures de réécriture: penser à comment la réécriture modulo setoïde a remplacé la réécriture de Leibniz par "effet de bord" pour pouvoir profiter de toutes ses fonctionalités auxiliaires, et penser à ce qui se passera quand on voudra une réécriture fonctionnant modulo AC.

En développant cette idée, on arrive à la notion de "conversion" de HOL. Une conversion est une fonction qui étant donné un terme *t*, retourne une preuve de *t=t'*  pour un certain *t'* . Une conversion se traduit en tactique en passant le but courant à la conversion, et en réécrivant (au sommet) la preuve produite. Ces conversion peuvent evidemment se composer: séquence, répétition, application à un sous-terme (de manière déterministe ou par recherche), etc. La plupart des procédures de décision sont en fait des conversions (les procédures logiques fonctionnent par réécriture booléenne).

Patterns, Term with Holes
-------------------------

**TODO: tranlate...**

Les termes à trous (plus exactement les variables existentielles restant non contraintes à la fin de l'inférence de type) ont 2 manières d'être interprétés:

* soit pour construire des termes partiellement instanciés, qui sont généralisés par rapport aux sous-termes libres; cela facilite la manipulation de lemmes sans les instantier complètement;

* soit pour dénoter un sous-terme du but ou d'une hypothèse.

La première utilisation apporte du confort à la manipulation de lemmes.

La deuxième utilisation permet de n'écrire que la partie nécessaire pour reconnaître un sous-terme, en passant sous silence certains détails. C'est un facteur de robustesse du script.

Syntax
======

Too early to discuss this point...

