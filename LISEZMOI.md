# Log'n Pass (logiciel desktop et application mobile)

[This page in English.](README.md)

Codes sources de l'application [Log'n Pass](https://lognpass.fr) fournissant les codes d'accès uniques (OTP - one time password) pour les logiciels et sites référencés à travers l'API Log'n Pass.

Fonctionnement :
* Listez les sites ou logiciels à protéger dans l'interface
* Référencez vos phrases secrètes
* Ajoutez les phrases secrètes sur votre compte utilisateur sur les logiciels et sites compatibles

Une fois fait il ne vous reste plus qu'à générer un code temporaire lorsque vous avez besoin de vous connecter.

Ce dépôt de code contient un projet développé en langage Pascal Objet sous Delphi. Vous ne savez pas ce qu'est Dephi ni où le télécharger ? Vous en saurez plus [sur ce site web](https://delphi-resources.developpeur-pascal.fr/).

## Protéger vos sites et programmes

Si vous désirez implémenter Log'n Pass dans vos sites ou programmes il vous suffit d'ajouter un champ texte (ou plusieurs) à vos comptes utilisateurs pour y saisir la pass phrase utilisée pour générer les codes.

Cette phrase ou série de lettres et chiffres doit être générée de votre côté et resaisie dans l'application ou de préférence laissée libre en saisie pour que vos utilisateurs y mettent ce qu'ils veulent.

Pour contrôler l'accès avec Log'n Pass il vous suffit ensuite d'utiliser l'un de [nos kits de développement](https://lognpass.fr/c/_3-integrer.html) ou ajouter le vôtre. L'implémentation n'est pas très compliquée.

## Présentations et conférences

### Twitch

Suivez mes streams de développement de logiciels, jeux vidéo, applications mobiles et sites web sur [ma chaîne Twitch](https://www.twitch.tv/patrickpremartin) ou en rediffusion sur [Serial Streameur](https://serialstreameur.fr) la plupart du temps en français.

## Utiliser ce logiciel

Ce logiciel est disponible dans une version de production directement installable ou exécutable. Il est distribué en shareware.

Vous pouvez le télécharger et le rediffuser gratuitement à condition de ne pas en modifier le contenu (installeur, programme, fichiers annexes, ...).

Télécharger le programme ou son installeur :

* [Amazon Appstore](https://www.amazon.fr/OLF-SOFTWARE-Logn-Pass/dp/B01B3HU94U/ref=sr_1_1) (Android)
* [App Store](https://apps.apple.com/us/app/logn-pass/id1046096987) (iOS et macOS)
* [Google Play](https://play.google.com/store/apps/details?id=olfsoftware.lognpass.android) (Android)
* [Microsoft Store](https://www.microsoft.com/store/apps/9N6VK8JKSRNX) (Windows)
* [téléchargement direct](https://olfsoftware.lemonsqueezy.com/buy/138427ed-3bc4-4e2e-ba59-5c933363665d) (macOS et Windows)

Si vous utilisez régulièrement ce logiciel et en êtes satisfait vous êtes invité à en acheter une licence d'utilisateur final. L'achat d'une licence vous donnera accès aux mises à jour du logiciel en plus d'activer d'évenuelles fonctionnalités optionnelles.

[Acheter une licence](https://store.olfsoftware.fr/logiciels-grand-public-c-1/logn-pass-p-8)

Vous pouvez aussi [consulter le site du logiciel](https://lognpass.olfsoftware.fr) pour en savoir plus sur son fonctionnement, accéder à des vidéos et articles, connaître les différentes versions disponibles et leurs fonctionnalités, contacter le support utilisateurs...

## Installation des codes sources

Pour télécharger ce dépôt de code il est recommandé de passer par "git" mais vous pouvez aussi télécharger un ZIP directement depuis [son dépôt GitHub](https://github.com/DeveloppeurPascal/LogNPass-app).

Ce projet utilise des dépendances sous forme de sous modules. Ils seront absents du fichier ZIP. Vous devrez les télécharger à la main.

* [DeveloppeurPascal/AboutDialog-Delphi-Component](https://github.com/DeveloppeurPascal/AboutDialog-Delphi-Component) dans le sous dossier ./lib-externes/AboutDialog-Delphi-Component
* [DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies) dans le sous dossier ./lib-externes/librairies
* [DeveloppeurPascal/LogNPass-Delphi](https://github.com/DeveloppeurPascal/LogNPass-Delphi) dans le sous dossier ./lib-externes/LogNPass-Delphi

## Compatibilité

En tant que [MVP Embarcadero](https://www.embarcadero.com/resources/partners/mvp-directory) je bénéficie dès qu'elles sortent des dernières versions de [Delphi](https://www.embarcadero.com/products/delphi) et [C++ Builder](https://www.embarcadero.com/products/cbuilder) dans [RAD Studio](https://www.embarcadero.com/products/rad-studio). C'est donc dans ces versions que je travaille.

Normalement mes librairies et composants doivent aussi fonctionner au moins sur la version en cours de [Delphi Community Edition](https://www.embarcadero.com/products/delphi/starter).

Aucune garantie de compatibilité avec des versions antérieures n'est fournie même si je m'efforce de faire du code propre et ne pas trop utiliser les nouvelles façons d'écrire dedans (type inference, inline var et multilines strings).

Si vous détectez des anomalies sur des versions antérieures n'hésitez pas à [les rapporter](https://github.com/DeveloppeurPascal/LogNPass-app/issues) pour que je teste et tente de corriger ou fournir un contournement.

## Licence d'utilisation de ce dépôt de code et de son contenu

Ces codes sources sont distribués sous licence [AGPL 3.0 ou ultérieure](https://choosealicense.com/licenses/agpl-3.0/).

Vous êtes globalement libre d'utiliser le contenu de ce dépôt de code n'importe où à condition :
* d'en faire mention dans vos projets
* de diffuser les modifications apportées aux fichiers fournis dans ce projet sous licence AGPL (en y laissant les mentions de copyright d'origine (auteur, lien vers ce dépôt, licence) obligatoirement complétées par les vôtres)
* de diffuser les codes sources de vos créations sous licence AGPL

Si cette licence ne convient pas à vos besoins vous pouvez acheter un droit d'utilisation de ce projet sous la licence [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/) ou une licence commerciale dédiée ([contactez l'auteur](https://developpeur-pascal.fr/nous-contacter.php) pour discuter de vos besoins).

Ces codes sources sont fournis en l'état sans garantie d'aucune sorte.

Certains éléments inclus dans ce dépôt peuvent dépendre de droits d'utilisation de tiers (images, sons, ...). Ils ne sont pas réutilisables dans vos projets sauf mention contraire.

## Comment demander une nouvelle fonctionnalité, signaler un bogue ou une faille de sécurité ?

Si vous voulez une réponse du propriétaire de ce dépôt la meilleure façon de procéder pour demander une nouvelle fonctionnalité ou signaler une anomalie est d'aller sur [le dépôt de code sur GitHub](https://github.com/DeveloppeurPascal/LogNPass-app) et [d'ouvrir un ticket](https://github.com/DeveloppeurPascal/LogNPass-app/issues).

Si vous avez trouvé une faille de sécurité n'en parlez pas en public avant qu'un correctif n'ait été déployé ou soit disponible. [Contactez l'auteur du dépôt en privé](https://developpeur-pascal.fr/nous-contacter.php) pour expliquer votre trouvaille.

Vous pouvez aussi cloner ce dépôt de code et participer à ses évolutions en soumettant vos modifications si vous le désirez. Lisez les explications dans le fichier [CONTRIBUTING.md](CONTRIBUTING.md).

## Supportez ce projet et son auteur

Si vous trouvez ce dépôt de code utile et voulez le montrer, merci de faire une donation [à son auteur](https://github.com/DeveloppeurPascal). Ca aidera à maintenir le projet (codes sources et binaires).

Vous pouvez utiliser l'un de ces services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* [Liberapay](https://liberapay.com/PatrickPremartin)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Paypal](https://www.paypal.com/paypalme/patrickpremartin)

ou si vous parlez français vous pouvez [vous abonner à Zone Abo](https://zone-abo.fr/nos-abonnements.php) sur une base mensuelle ou annuelle et avoir en plus accès à de nombreuses ressources en ligne (vidéos et articles).
