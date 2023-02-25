# Log'n Pass application

[This page in english.](README.md)

Codes sources de l'application [Log'n Pass](https://lognpass.fr) fournissant les codes d'accès uniques (OTP - one time password) pour les logiciels et sites référencés à travers l'API Log'n Pass.

Fonctionnement :
* Listez les sites ou logiciels à protéger dans l'interface
* Référencez vos phrases secrètes
* Ajoutez les phrases secrètes sur votre compte utilisateur sur les logiciels et sites compatibles

Une fois fait il ne vous reste plus qu'à générer un code temporaire lorsque vous avez besoin de vous connecter.

Ce dépôt de code contient un projet développé en langage Pascal Objet sous Delphi. Vous ne savez pas ce qu'est Dephi ni où le télécharger ? Vous en saurez plus [sur ce site web](https://delphi-resources.developpeur-pascal.fr/).

## Où télécharger l'application ?

Si vous ne voulez pas compiler vous même le programme vous pouvez aussi [télécharger une version](https://lognpass.fr/c/_5-telecharger.html) pour votre systèmes d'exploitation :

* Apple iOS (ARM - 64 bits) : [App Store](https://apps.apple.com/us/app/logn-pass/id1046096987)
* Apple macOS (x64 - processeurs Intel) : [Mac App Store](https://apps.apple.com/us/app/logn-pass/id1046096987) [GitHub](https://github.com/DeveloppeurPascal/LogNPass-app/releases)
* Apple macOS (ARM - processeurs Apple Silicon M1/M2/...) : [GitHub](https://github.com/DeveloppeurPascal/LogNPass-app/releases)
* Android (ARM - 32 bits) : [Amazon Appstore](https://www.amazon.fr/OLF-SOFTWARE-Logn-Pass/dp/B01B3HU94U/ref=sr_1_1) [GitHub](https://github.com/DeveloppeurPascal/LogNPass-app/releases)
* Android (ARM - 64 bits) : [Google Play](https://play.google.com/store/apps/details?id=olfsoftware.lognpass.android) [GitHub](https://github.com/DeveloppeurPascal/LogNPass-app/releases)
* Microsoft Windows (x86 - 32 bits) : [GitHub](https://github.com/DeveloppeurPascal/LogNPass-app/releases)
* Microsoft Windows (x64 - 64 bits) : [GitHub](https://github.com/DeveloppeurPascal/LogNPass-app/releases)

Les téléchargements depuis GitHub sont autonomes. Vous ne serez prévenus d'une nouvelle version du programme que si vous suivez ce projet et en demandez les notifications à chaque release.

Dans la plupart des cas nous recommandons de passer par un magasin d'application qui vous permettra de faire automatiquement les mises à jours du programme.

## Installation

Pour télécharger ce projet il est recommandé de passer par "git" mais vous pouvez aussi télécharger un ZIP directement depuis [son dépôt GitHub](https://github.com/DeveloppeurPascal/LogNPass-app).

**Attention :** si le projet utilise des dépendances sous forme de sous modules ils seront absents du fichier ZIP. Vous devrez les télécharger à la main.

## Dépendances

Ce dépôt de code dépend des dépôts suivants :

* [DeveloppeurPascal/AboutDialog-Delphi-Component](https://github.com/DeveloppeurPascal/AboutDialog-Delphi-Component) dans le sous dossier ./lib-externes/BoiteDeDialogueAPropos
* [DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies) dans le sous dossier ./lib-externes/librairies
* [DeveloppeurPascal/LogNPass-Delphi](https://github.com/DeveloppeurPascal/LogNPass-Delphi) dans le sous dossier ./lib-externes/LogNPass-Delphi

## Protéger vos sites et programmes

Si vous désirez implémenter Log'n Pass dans vos sites ou programmes il vous suffit d'ajouter un champ texte (ou plusieurs) à vos comptes utilisateurs pour y saisir la pass phrase utilisée pour générer les codes.

Cette phrase ou série de lettres et chiffres doit être générée de votre côté et resaisie dans l'application ou de préférence laissée libre en saisie pour que vos utilisateurs y mettent ce qu'ils veulent.

Pour contrôler l'accès avec Log'n Pass il vous suffit ensuite d'utiliser l'un de [nos kits de développement](https://lognpass.fr/c/_3-integrer.html) ou ajouter le vôtre. L'implémentation n'est pas très compliquée.

## Comment demander une nouvelle fonctionnalité, signaler un bogue ou une faille de sécurité ?

Si vous voulez une réponse du propriétaire de ce dépôt la meilleure façon de procéder pour demander une nouvelle fonctionnalité ou signaler une anomalie est d'aller sur [le dépôt de code sur GitHub](https://github.com/DeveloppeurPascal/LogNPass-app) et [d'ouvrir un ticket](https://github.com/DeveloppeurPascal/LogNPass-app/issues).

Si vous avez trouvé une faille de sécurité n'en parlez pas en public avant qu'un correctif n'ait été déployé ou soit disponible. [Contactez l'auteur du dépôt en privé](https://developpeur-pascal.fr/nous-contacter.php) pour expliquer votre trouvaille.

Vous pouvez aussi cloner ce dépôt de code et participer à ses évolutions en soumettant vos modifications si vous le désirez. Lisez les explications dans le fichier [CONTRIBUTING.md](CONTRIBUTING.md).

## Modèle de licence double

Ce projet est distribué sous licence [AGPL 3.0 ou ultérieure] (https://choosealicense.com/licenses/agpl-3.0/).

Si vous voulez l'utiliser en totalité ou en partie dans vos projets mais ne voulez pas en partager les sources ou ne voulez pas distribuer votre projet sous la même licence, vous pouvez acheter le droit de l'utiliser sous la licence [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/) ou une licence dédiée ([contactez l'auteur](https://developpeur-pascal.fr/nous-contacter.php) pour discuter de vos besoins).

## Supportez ce projet et son auteur

Si vous trouvez ce dépôt de code utile et voulez le montrer, merci de faire une donation [à son auteur](https://github.com/DeveloppeurPascal). Ca aidera à maintenir le projet (codes sources et binaires).

Vous pouvez utiliser l'un de ces services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* [Liberapay](https://liberapay.com/PatrickPremartin)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Paypal](https://www.paypal.com/paypalme/patrickpremartin)

ou si vous parlez français vous pouvez [vous abonner à Zone Abo](https://zone-abo.fr/nos-abonnements.php) sur une base mensuelle ou annuelle et avoir en plus accès à de nombreuses ressources en ligne (vidéos et articles).
