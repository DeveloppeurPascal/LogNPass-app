﻿/// <summary>
/// ***************************************************************************
///
/// Log'n Pass
///
/// Copyright 2016-2024 Patrick Prémartin under AGPL 3.0 license.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
/// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
/// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.
///
/// ***************************************************************************
///
/// Author(s) :
/// Patrick PREMARTIN
///
/// Site :
/// https://lognpass.fr/
///
/// Project site :
/// https://github.com/DeveloppeurPascal/LogNPass-app
///
/// ***************************************************************************
/// File last update : 2024-05-06T20:59:52.000+02:00
/// Signature : 3a14e319cf3b5d6849f3da873c7f373b1bb71825
/// ***************************************************************************
/// </summary>

program lognpass_MicrosoftStore;

uses
  System.StartUpCopy,
  FMX.Forms,
  frm_principale in 'frm_principale.pas' {frmMain},
  u_ajax in 'u_ajax.pas',
  u_lognpass in '..\lib-externes\LogNPass-Delphi\src\u_lognpass.pas',
  dm in 'dm.pas' {DataModule1: TDataModule},
  u_md5 in '..\lib-externes\librairies\src\u_md5.pas',
  u_urlOpen in '..\lib-externes\librairies\src\u_urlOpen.pas',
  Olf.FMX.AboutDialog in '..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialog.pas',
  Olf.FMX.AboutDialogForm in '..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialogForm.pas' {OlfAboutDialogForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
