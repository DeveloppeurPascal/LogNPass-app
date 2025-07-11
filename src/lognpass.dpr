(* C2PP
  ***************************************************************************

  Log'n Pass

  Copyright 2015-2025 Patrick Prémartin under AGPL 3.0 license.

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
  https://lognpass.olfsoftware.fr/

  Project site :
  https://github.com/DeveloppeurPascal/LogNPass-app

  ***************************************************************************
  File last update : 2025-07-11T12:22:22.000+02:00
  Signature : 652805aa405352224044c1e2f820ff3c4d9d1bcd
  ***************************************************************************
*)

program LogNPass;

uses
  System.StartUpCopy,
  FMX.Forms,
  uConfig in '..\lib-externes\FMX-Tools-Starter-Kit\src\uConfig.pas',
  uConsts in '..\lib-externes\FMX-Tools-Starter-Kit\src\uConsts.pas',
  uDMAboutBox in '..\lib-externes\FMX-Tools-Starter-Kit\src\uDMAboutBox.pas' {AboutBox: TDataModule},
  uDMAboutBoxLogoStorrage in '..\lib-externes\FMX-Tools-Starter-Kit\src\uDMAboutBoxLogoStorrage.pas' {dmAboutBoxLogo: TDataModule},
  uTranslate in '..\lib-externes\FMX-Tools-Starter-Kit\src\uTranslate.pas',
  uTxtAboutDescription in '..\lib-externes\FMX-Tools-Starter-Kit\src\uTxtAboutDescription.pas',
  uTxtAboutLicense in '..\lib-externes\FMX-Tools-Starter-Kit\src\uTxtAboutLicense.pas',
  Olf.FMX.AboutDialog in '..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialog.pas',
  Olf.FMX.AboutDialogForm in '..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialogForm.pas' {OlfAboutDialogForm},
  Olf.FMX.SelectDirectory in '..\lib-externes\Delphi-FMXExtend-Library\src\Olf.FMX.SelectDirectory.pas',
  Olf.RTL.CryptDecrypt in '..\lib-externes\librairies\src\Olf.RTL.CryptDecrypt.pas',
  Olf.RTL.Language in '..\lib-externes\librairies\src\Olf.RTL.Language.pas',
  Olf.RTL.Params in '..\lib-externes\librairies\src\Olf.RTL.Params.pas',
  u_urlOpen in '..\lib-externes\librairies\src\u_urlOpen.pas',
  _TFrameAncestor in '..\lib-externes\FMX-Tools-Starter-Kit\src\_TFrameAncestor.pas' {__TFrameAncestor: TFrame},
  _TFormAncestor in '..\lib-externes\FMX-Tools-Starter-Kit\src\_TFormAncestor.pas' {__TFormAncestor},
  _MainFormAncestor in '..\lib-externes\FMX-Tools-Starter-Kit\src\_MainFormAncestor.pas' {__MainFormAncestor},
  uDocumentsAncestor in '..\lib-externes\FMX-Tools-Starter-Kit\src\uDocumentsAncestor.pas',
  Olf.RTL.Streams in '..\lib-externes\librairies\src\Olf.RTL.Streams.pas',
  Olf.RTL.Maths.Conversions in '..\lib-externes\librairies\src\Olf.RTL.Maths.Conversions.pas',
  uStyleManagerHelpers in '..\lib-externes\FMX-Tools-Starter-Kit\src\uStyleManagerHelpers.pas',
  Olf.RTL.SystemAppearance in '..\lib-externes\librairies\src\Olf.RTL.SystemAppearance.pas',
  fToolsStylesDialog in '..\lib-externes\FMX-Tools-Starter-Kit\src\fToolsStylesDialog.pas' {frmToolsStylesDialog},
  fToolsLanguagesDialog in '..\lib-externes\FMX-Tools-Starter-Kit\src\fToolsLanguagesDialog.pas' {frmToolsLanguagesDialog},
  Olf.CilTseg.ClientLib in '..\lib-externes\CilTseg4Delphi\src\Olf.CilTseg.ClientLib.pas',
  Olf.RTL.Checksum in '..\lib-externes\librairies\src\Olf.RTL.Checksum.pas',
  u_md5 in '..\lib-externes\librairies\src\u_md5.pas',
  fCiltsegRegisterOrShowLicense in '..\lib-externes\CilTseg4Delphi\src\FMX\fCiltsegRegisterOrShowLicense.pas' {frmCilTsegRegisterOrShowLicense},
  fMainForm in '..\lib-externes\FMX-Tools-Starter-Kit\src\fMainForm.pas' {MainForm},
  _StyleContainerAncestor in '..\lib-externes\FMX-Styles-Utils\src\_StyleContainerAncestor.pas' {__StyleContainerAncestor: TDataModule},
  uStyleManager in '..\lib-externes\FMX-Styles-Utils\src\uStyleManager.pas',
  uStyleDarkByDefault in '..\lib-externes\FMX-Styles-Utils\samples\DarkLightSampleProject\uStyleDarkByDefault.pas' {StyleDarkByDefault: TDataModule},
  uStyleLightByDefault in '..\lib-externes\FMX-Styles-Utils\samples\DarkLightSampleProject\uStyleLightByDefault.pas' {StyleLightByDefault: TDataModule},
  uGetDeviceName in '..\lib-externes\librairies\src\uGetDeviceName.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
