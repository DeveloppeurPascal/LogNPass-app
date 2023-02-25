program lognpass;

uses
  System.StartUpCopy,
  FMX.Forms,
  frm_principale in 'frm_principale.pas' {frmMain},
  u_ajax in 'u_ajax.pas',
  u_lognpass in '..\lib-externes\LogNPass-Delphi\src\u_lognpass.pas',
  u_md5 in '..\lib-externes\librairies\u_md5.pas',
  dm in 'dm.pas' {DataModule1: TDataModule},
  u_urlOpen in '..\lib-externes\librairies\u_urlOpen.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
