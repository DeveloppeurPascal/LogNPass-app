# Log'n Pass application

[Cette page en français.](LISEZMOI.md)

Source code of the [Log'n Pass](https://lognpass.fr) application  providing unique access codes (OTP - one time password) for software and sites referenced through the Log'n Pass API.

How it works:
* List the sites or software to protect in the interface
* Reference your secret phrases
* Add the secret phrases on your user account on compatible software and sites

Once done, you just have to generate a temporary code when you need to connect.

This code repository contains a project developed in Object Pascal language under Delphi. You don't know what Delphi is and where to download it ? You'll learn more [on this web site](https://delphi-resources.developpeur-pascal.fr/).

## Where to download the application?

If you don't want to compile the program yourself you can also [download a version](https://lognpass.fr/c/_5-telecharger.html) for your operating systems :

* Apple iOS (ARM - 64 bits) : [App Store](https://apps.apple.com/us/app/logn-pass/id1046096987)
* Apple macOS (x64 - processeurs Intel) : [Mac App Store](https://apps.apple.com/us/app/logn-pass/id1046096987) [GitHub](https://github.com/DeveloppeurPascal/LogNPass-app/releases)
* Apple macOS (ARM - processeurs Apple Silicon M1/M2/...) : [GitHub](https://github.com/DeveloppeurPascal/LogNPass-app/releases)
* Android (ARM - 32 bits) : [Amazon Appstore](https://www.amazon.fr/OLF-SOFTWARE-Logn-Pass/dp/B01B3HU94U/ref=sr_1_1) [GitHub](https://github.com/DeveloppeurPascal/LogNPass-app/releases)
* Android (ARM - 64 bits) : [Google Play](https://play.google.com/store/apps/details?id=olfsoftware.lognpass.android) [GitHub](https://github.com/DeveloppeurPascal/LogNPass-app/releases)
* Microsoft Windows (x86 - 32 bits) : [GitHub](https://github.com/DeveloppeurPascal/LogNPass-app/releases)
* Microsoft Windows (x64 - 64 bits) : [GitHub](https://github.com/DeveloppeurPascal/LogNPass-app/releases)

Downloads from GitHub are autonomous. You will only be notified of a new version of the program if you follow this project and request notifications for each release.

In most cases we recommend using an application store that will allow you to automatically update the program.

## Install

To download this project you better should use "git" command but you also can download a ZIP from [its GitHub repository](https://github.com/DeveloppeurPascal/LogNPass-app).

**Warning :** if the project has submodules dependencies they wont be in the ZIP file. You'll have to download them manually.

## Dependencies

This project depends on :

* [DeveloppeurPascal/AboutDialog-Delphi-Component](https://github.com/DeveloppeurPascal/AboutDialog-Delphi-Component) in the sub folder ./lib-externes/BoiteDeDialogueAPropos
* [DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies) in the sub folder ./lib-externes/librairies

## Protect your sites and programs

If you want to implement Log'n Pass in your sites or programs, you just need to add a text field (or several) to your user accounts to enter the pass phrase used to generate the codes.

This phrase or series of letters and numbers must be generated on your side and re-entered in the application or preferably left free for your users to enter what they want.

To control access with Log'n Pass, you just have to use one of [our development kits](https://lognpass.fr/c/_3-integrer.html) or add your own. The implementation is not very complicated.

## How to ask a new feature, report a bug or a security issue ?

If you want an answer from the project owner the best way to ask for a new feature or report a bug is to go to [the GitHub repository](https://github.com/DeveloppeurPascal/LogNPass-app) and [open a new issue](https://github.com/DeveloppeurPascal/LogNPass-app/issues).

If you found a security issue please don't report it publicly before a patch is available. Explain the case by [sending a private message to the author](https://developpeur-pascal.fr/nous-contacter.php).

You also can fork the repository and contribute by submitting pull requests if you want to help. Please read the [CONTRIBUTING.md](CONTRIBUTING.md) file.

## Dual licensing model

This project is distributed under [AGPL 3.0 or later](https://choosealicense.com/licenses/agpl-3.0/) license.

If you want to use it or a part of it in your projects but don't want to share the sources or don't want to distribute your project under the same license you can buy the right to use it under the [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/) or a dedicated license ([contact the author](https://developpeur-pascal.fr/nous-contacter.php) to explain your needs).

## Support the project and its author

If you think this project is useful and want to support it, please make a donation to [its author](https://github.com/DeveloppeurPascal). It will help to maintain the code and binaries.

You can use one of those services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* [Liberapay](https://liberapay.com/PatrickPremartin)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Paypal](https://www.paypal.com/paypalme/patrickpremartin)

or if you speack french you can [subscribe to Zone Abo](https://zone-abo.fr/nos-abonnements.php) on a monthly or yearly basis and get a lot of resources as videos and articles.
