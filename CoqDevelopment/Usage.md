#acl CoqAdminGroup:read,write,delete,revert,admin CoqDevelopersGroup:read,write

= Mode d'emploi de l'espace CoqDevelopment sur Cocorico! =


== Gestion des droits ==

Les droits sont gérés par le moyen des [[HelpOnAccessControlLists|ACL]]. Pour l'instant, 3 groupes spécifiques existent:
 * CoqAdminGroup: pour les administrateurs de l'espace; ils ont tous les droits sur les pages.
 * CoqDevelopersGroup: pour les développeurs Coq; l'appartenance au groupe donne l'accès en lecture et écriture aux documents dans CoqDevelopment (compte-rendus des GT, discussions internes, ...).
 * CoqAdvancedUsersGroup: pour les utilisateurs de Coq que l'on souhaite inviter dans les discussions internes.

Les droits sont spécifiés dans chaque page par l'ajout d'une ligne spécifique en tête de la page. La ligne par défaut est:
{{{
#acl CoqAdminGroup:read,write,revert,delete,admin CoqDevelopersGroup:read,write
}}}

''Il est impératif que quiconque créant une page dans l'espace CoqDevelopment pense à ajouter cette ligne en tête de la page.''

== Espace de noms ==

Pour éviter d'éventuels conflits avec des documents existant dans l'espace public de [[FrontPage|Cocorico!]], tous les noms des documents limités aux développeurs de Coq sont préfixés par CoqDevelopment/ . Il existe 2 points d'entrée à cet espace:
 * [[CoqDevelopment/Public|CoqDevelopment/Public]]: destiné à accueillir les liens vers les informations que l'on souhaite partager avec l'ensemble des utilisateurs de Coq;
 * [[CoqDevelopment/Private|CoqDevelopment/Private]]: qui regroupe les liens intéressant les développeurs de Coq (compte-rendus des GT, discussions en cours, ...)
