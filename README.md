# Log'n Pass (desktop software and mobile application)

[Cette page en français.](LISEZMOI.md)

Source code of the [Log'n Pass](https://lognpass.fr) application  providing unique access codes (OTP - one time password) for software and sites referenced through the Log'n Pass API.

How it works:
* List the sites or software to protect in the interface
* Reference your secret phrases
* Add the secret phrases on your user account on compatible software and sites

Once done, you just have to generate a temporary code when you need to connect.

This code repository contains a project developed in Object Pascal language under Delphi. You don't know what Delphi is and where to download it ? You'll learn more [on this web site](https://delphi-resources.developpeur-pascal.fr/).

## Protect your sites and programs

If you want to implement Log'n Pass in your sites or programs, you just need to add a text field (or several) to your user accounts to enter the pass phrase used to generate the codes.

This phrase or series of letters and numbers must be generated on your side and re-entered in the application or preferably left free for your users to enter what they want.

To control access with Log'n Pass, you just have to use one of [our development kits](https://lognpass.fr/c/_3-integrer.html) or add your own. The implementation is not very complicated.

## Talks and conferences

### Twitch

Follow my development streams of software, video games, mobile applications and websites on [my Twitch channel](https://www.twitch.tv/patrickpremartin) or as replays on [Serial Streameur](https://serialstreameur.fr) mostly in French.

## Using this software

This software is available in a directly installable or executable production version. It is distributed as shareware.

You can download and redistribute it free of charge, provided you do not modify its content (installer, program, additional files, etc.).

Download program or installer:

* [Amazon Appstore](https://www.amazon.fr/OLF-SOFTWARE-Logn-Pass/dp/B01B3HU94U/ref=sr_1_1) (Android)
* [App Store](https://apps.apple.com/us/app/logn-pass/id1046096987) (iOS and macOS)
* [direct download](https://olfsoftware.lemonsqueezy.com/buy/138427ed-3bc4-4e2e-ba59-5c933363665d) (macOS and Windows)
* [Google Play](https://play.google.com/store/apps/details?id=olfsoftware.lognpass.android) (Android)
* [Microsoft Store](https://www.microsoft.com/store/apps/9N6VK8JKSRNX) (Windows)

If you use this software regularly and are satisfied with it, you are invited to purchase an end-user license. Purchasing a license will give you access to software updates, as well as enabling optional features.

[Buy a license](https://store.olfsoftware.fr/en/general-public-software-c-1/logn-pass-p-8)

You can also [visit the software website](https://lognpass.olfsoftware.fr) to find out more about how it works, access videos and articles, find out about the different versions available and their features, contact user support...

## Source code installation

To download this code repository, we recommend using "git", but you can also download a ZIP file directly from [its GitHub repository](https://github.com/DeveloppeurPascal/LogNPass-app).

This project uses dependencies in the form of sub-modules. They will be absent from the ZIP file. You'll have to download them by hand.

* [DeveloppeurPascal/AboutDialog-Delphi-Component](https://github.com/DeveloppeurPascal/AboutDialog-Delphi-Component) in the sub folder ./lib-externes/AboutDialog-Delphi-Component
* [DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies) in the sub folder ./lib-externes/librairies
* [DeveloppeurPascal/LogNPass-Delphi](https://github.com/DeveloppeurPascal/LogNPass-Delphi) in the sub folder ./lib-externes/LogNPass-Delphi

## Compatibility

As an [Embarcadero MVP](https://www.embarcadero.com/resources/partners/mvp-directory), I benefit from the latest versions of [Delphi](https://www.embarcadero.com/products/delphi) and [C++ Builder](https://www.embarcadero.com/products/cbuilder) in [RAD Studio](https://www.embarcadero.com/products/rad-studio) as soon as they are released. I therefore work with these versions.

Normally, my libraries and components should also run on at least the current version of [Delphi Community Edition](https://www.embarcadero.com/products/delphi/starter).

There's no guarantee of compatibility with earlier versions, even though I try to keep my code clean and avoid using too many of the new ways of writing in it (type inference, inline var and multiline strings).

If you detect any anomalies on earlier versions, please don't hesitate to [report them](https://github.com/DeveloppeurPascal/LogNPass-app/issues) so that I can test and try to correct or provide a workaround.

## License to use this code repository and its contents

This source code is distributed under the [AGPL 3.0 or later license](https://choosealicense.com/licenses/agpl-3.0/).

You are generally free to use the contents of this code repository anywhere, provided that:
* you mention it in your projects
* distribute the modifications made to the files supplied in this project under the AGPL license (leaving the original copyright notices (author, link to this repository, license) which must be supplemented by your own)
* to distribute the source code of your creations under the AGPL license.

If this license doesn't suit your needs, you can purchase the right to use this project under the [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/) or a dedicated commercial license ([contact the author](https://developpeur-pascal.fr/nous-contacter.php) to explain your needs).

These source codes are provided as is, without warranty of any kind.

Certain elements included in this repository may be subject to third-party usage rights (images, sounds, etc.). They are not reusable in your projects unless otherwise stated.

## How to ask a new feature, report a bug or a security issue ?

If you want an answer from the project owner the best way to ask for a new feature or report a bug is to go to [the GitHub repository](https://github.com/DeveloppeurPascal/LogNPass-app) and [open a new issue](https://github.com/DeveloppeurPascal/LogNPass-app/issues).

If you found a security issue please don't report it publicly before a patch is available. Explain the case by [sending a private message to the author](https://developpeur-pascal.fr/nous-contacter.php).

You also can fork the repository and contribute by submitting pull requests if you want to help. Please read the [CONTRIBUTING.md](CONTRIBUTING.md) file.

## Support the project and its author

If you think this project is useful and want to support it, please make a donation to [its author](https://github.com/DeveloppeurPascal). It will help to maintain the code and binaries.

You can use one of those services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* [Liberapay](https://liberapay.com/PatrickPremartin)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Paypal](https://www.paypal.com/paypalme/patrickpremartin)

or if you speack french you can [subscribe to Zone Abo](https://zone-abo.fr/nos-abonnements.php) on a monthly or yearly basis and get a lot of resources as videos and articles.
