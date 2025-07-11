(* C2PP
  ***************************************************************************

  Bidioo

  Copyright 2013-2025 Patrick PREMARTIN under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://lognpass.olfsoftware.fr

  Project site :
  https://github.com/DeveloppeurPascal/Bidioo-v2-Delphi

  ***************************************************************************
  File last update : 2025-05-31T15:21:30.000+02:00
  Signature : 0ec79016159bb54d6df6806ae8e23f4235c3896e
  ***************************************************************************
*)

unit uTxtAboutDescription;

interface

function GetTxtAboutDescription(const Language: string;
  const Recursif: boolean = false): string;

implementation

// For the languages codes, please use 2 letters ISO codes
// https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes

uses
  System.SysUtils,
  uConsts;

const
  CTxtEN = '''
Log'n Pass is a 2FA client application.

*****************
* Credits

This application was developed by Patrick Prémartin.

*****************
* Publisher info

This video game is published by OLF SOFTWARE, a company registered in Paris (France) under the reference 439521725.

****************
* Personal data

This program is autonomous in its current version. It communicates nothing to the outside world. Your data are private !

We have no knowledge of what you do with it.

No information about you is transmitted to us or to any third party.

We use no cookies, no tracking, no stats on your use of the application.

***************
* User support

If you have any questions or require additional functionality, please leave us a message on the application's website or on its code repository.

To find out more, visit https://lognpass.olfsoftware.fr

''';
   CTxtFR = '''
Log'n Pass est une application cliente 2FA.

*****************
* Remerciements

Cette application a été développée par Patrick Prémartin.

*****************
* Info éditeur

Ce jeu vidéo est éditée par OLF SOFTWARE, société enregistrée à Paris (France) sous la référence 439521725.

****************
* Données personnelles

Ce programme est autonome dans sa version actuelle. Il ne communique rien au monde extérieur. Vos données sont privées !

Nous n'avons aucune connaissance de ce que vous faites avec lui.

Aucune information vous concernant n'est transmise à nous ou à des tiers.

Nous n'utilisons pas de cookies, pas de tracking, pas de statistiques sur votre utilisation de l'application.

***************
* Assistance aux utilisateurs

Si vous avez des questions ou si vous avez besoin de fonctionnalités supplémentaires, veuillez nous laisser un message sur le site web de l'application ou sur son dépôt de code.

Pour en savoir plus, visitez https://lognpass.olfsoftware.fr

''';
  // CTxtIT = '';
  // CTxtDE = '';
  // CTxtJP = '';
  // CTxtPT = '';
  // CTxtES = '';

function GetTxtAboutDescription(const Language: string;
  const Recursif: boolean): string;
var
  lng: string;
begin
  lng := Language.tolower;
  if (lng = 'en') then
    result := CTxtEN
  else if (lng = 'fr') then // France
    result := CTxtFR
  else if not Recursif then
    result := GetTxtAboutDescription(CDefaultLanguage, true)
  else
    raise Exception.Create('Unknow description for language "' +
      Language + '".');
end;

end.
