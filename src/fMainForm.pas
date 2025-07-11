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
  File last update : 2025-07-11T13:23:52.000+02:00
  Signature : bf3e4380a32719fad0f3251850f935ce7244aa74
  ***************************************************************************
*)

unit fMainForm;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  _MainFormAncestor,
  System.Actions,
  FMX.ActnList,
  FMX.Menus,
  uDocumentsAncestor,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.Objects,
  FMX.Edit,
  FMX.Controls.Presentation,
  FMX.Layouts,
  FMX.ListView,
  FMX.TabControl,
  uDBLogNPass;

type
  TMainForm = class(T__MainFormAncestor)
    tcListe: TTabControl;
    tabListeVisu: TTabItem;
    lstListe: TListView;
    tabListeAjout: TTabItem;
    tabListeAjoutLayout: TLayout;
    lblCrtPassphrase: TLabel;
    lblCrtLibelle: TLabel;
    edtCrtPassphrase: TEdit;
    edtCrtLibelle: TEdit;
    btnCrtEnregistrer: TButton;
    btnCrtCancel: TButton;
    tabListeDetail: TTabItem;
    tabListeDetailLayout: TLayout;
    pbFondHaut: TRectangle;
    pbFondBas: TRectangle;
    lblDetailLibelle: TLabel;
    edtDetailLibelle: TEdit;
    lblDetailPassphrase: TLabel;
    edtDetailPassphrase: TEdit;
    lblDetailCodeTitre: TLabel;
    pbDessus: TRectangle;
    lblDetailCode: TLabel;
    lblDetailCodeEdit: TEdit;
    tbListeTitre: TToolBar;
    lblListeTitre: TLabel;
    btnListeBack: TSpeedButton;
    btnListeAjouter: TSpeedButton;
    btnListeSupprimer: TSpeedButton;
    Timer1: TTimer;
    procedure btnCrtCancelClick(Sender: TObject);
    procedure btnCrtEnregistrerClick(Sender: TObject);
    procedure edtCrtLibelleClick(Sender: TObject);
    procedure edtCrtPassphraseClick(Sender: TObject);
    procedure edtDetailPassphraseClick(Sender: TObject);
    procedure lblDetailCodeClick(Sender: TObject);
    procedure pbFondHautResize(Sender: TObject);
    procedure lstListeItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnListeAjouterClick(Sender: TObject);
    procedure btnListeBackClick(Sender: TObject);
    procedure btnListeSupprimerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
  protected
    api_key, api_num, api_sec: string;
    timer_en_cours: boolean;
    phrase_MD5: string;
    temps_restant: integer;
    function GetNewDoc(const FileName: string = ''): TDocumentAncestor;
      override;
    procedure DoToolsOptionsAction(Sender: TObject); override;
    procedure LoadLogNPassDB;
    procedure ListeVisuAffiche;
    procedure ListeDetailAffiche;
    procedure ListeAjouterAffiche;
    procedure positionne_barre_de_temps;
    function CurrentLnPRecord: TLNPRecord;
    function PassPhraseCreate: string;
    procedure dessine_progressbar(temps_restant: integer);
    procedure TestIfDBMigrationNeeded;
  public
    procedure TranslateTexts(const Language: string); override;
    procedure AfterConstruction; override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses
  System.Net.HttpClient,
  System.Net.URLClient,
  System.Hash,
  System.JSON,
  FMX.DialogService,
  fOptionsForm,
  System.UIConsts,
  u_lognpass,
  uConfig,
  uConfigLogNPass,
  uDMOldSQLiteDB;

{ TMainForm }

procedure TMainForm.AfterConstruction;
begin
  inherited;
  LoadLogNPassDB;
  ListeVisuAffiche;

  TThread.ForceQueue(nil,
    procedure
    begin
      TestIfDBMigrationNeeded;
    end);
end;

procedure TMainForm.btnCrtCancelClick(Sender: TObject);
begin
  ListeVisuAffiche;
end;

procedure TMainForm.btnCrtEnregistrerClick(Sender: TObject);
begin
  edtCrtLibelle.Text := trim(edtCrtLibelle.Text);
  edtCrtPassphrase.Text := trim(edtCrtPassphrase.Text);
  if (edtCrtLibelle.Text <> '') then
  begin
    if (edtCrtPassphrase.Text <> '') then
    begin
      TLNPDB.Current.AccessList.AddLogNPassRecord(edtCrtLibelle.Text,
        edtCrtPassphrase.Text);
      TLNPDB.Current.Save;
      ListeVisuAffiche;
    end
    else
    begin
      Visible := false;
      // TODO : traduire texte
      tdialogservice.MessageDialog('La phrase mystère est obligatoire.',
        TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0,
        procedure(const AResult: TModalResult)
        begin
          Visible := true;
{$IF Defined(MSWINDOWS) or Defined(MACOS) or Defined(LINUX)}
          edtCrtPassphrase.SetFocus;
{$ENDIF}
        end);
    end;
  end
  else
  begin
    Visible := false;
    // TODO : traduire texte
    tdialogservice.MessageDialog('Le nom est obligatoire.', TMsgDlgType.mtError,
      [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0,
      procedure(const AResult: TModalResult)
      begin
        Visible := true;
{$IF Defined(MSWINDOWS) or Defined(MACOS) or Defined(LINUX)}
        edtCrtLibelle.SetFocus;
{$ENDIF}
      end);
  end;
end;

procedure TMainForm.btnListeAjouterClick(Sender: TObject);
begin
  ListeAjouterAffiche;
end;

procedure TMainForm.btnListeBackClick(Sender: TObject);
begin
  ListeVisuAffiche;
end;

procedure TMainForm.btnListeSupprimerClick(Sender: TObject);
var
  Rec: TLNPRecord;
begin
  Rec := CurrentLnPRecord;
  if not assigned(Rec) then
    exit;

  Visible := false;
  tdialogservice.MessageDialog('Voulez-vous supprimer ce code ?',
    TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
    TMsgDlgBtn.mbNo, 0,
    procedure(const AResult: TModalResult)
    begin
      if (mrYes = AResult) then
      begin
        Rec.supprime := true;
        TLNPDB.Current.Save;
        ListeVisuAffiche;
      end;
      Visible := true;
    end);
end;

function TMainForm.CurrentLnPRecord: TLNPRecord;
begin
  if assigned(lstListe.Selected) and assigned(lstListe.Selected.TagObject) and
    (lstListe.Selected.TagObject is TLNPRecord) then
    result := lstListe.Selected.TagObject as TLNPRecord
  else
    result := nil;
end;

procedure TMainForm.dessine_progressbar(temps_restant: integer);
begin
  if (temps_restant > 59) then
    temps_restant := 59;
  if (temps_restant < 0) then
    temps_restant := 0;
  if (temps_restant < 5) then
    pbDessus.Fill.Color := claDarkRed
  else if (temps_restant < 10) then
    pbDessus.Fill.Color := claDarkOrange
  else if (temps_restant < 20) then
    pbDessus.Fill.Color := claOrange
  else if (temps_restant < 25) then
    pbDessus.Fill.Color := claDarkGreen
  else
    pbDessus.Fill.Color := claGreen;
  pbDessus.Width := round(pbFondHaut.Width * temps_restant / 60);
end;

procedure TMainForm.DoToolsOptionsAction(Sender: TObject);
var
  frm: TfrmOptions;
begin
  frm := TfrmOptions.Create(self);
  try
{$IF Defined(IOS) or Defined(ANDROID)}
    frm.Show;
{$ELSE}
    frm.ShowModal;
{$ENDIF}
  finally
{$IF Defined(IOS) or Defined(ANDROID)}
{$ELSE}
    frm.Free;
{$ENDIF}
  end;
end;

procedure TMainForm.edtCrtLibelleClick(Sender: TObject);
begin
  edtCrtLibelle.SelectAll;
end;

procedure TMainForm.edtCrtPassphraseClick(Sender: TObject);
begin
  edtCrtPassphrase.SelectAll;
end;

procedure TMainForm.edtDetailPassphraseClick(Sender: TObject);
begin
  edtDetailPassphrase.SelectAll;
  edtDetailPassphrase.CopyToClipboard;
  ShowMessage('Phrase mystère copiée vers le presse papier.');
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Timer1.Enabled := true;

{$IF Defined(ANDROID)}
  btnListeSupprimer.Text := '';
{$ENDIF}
{$IF Defined(IOS) OR Defined(ANDROID)}
  btnCrtEnregistrer.Text := '';
  btnCrtCancel.Text := '';
{$ENDIF}
  tcListe.ActiveTab := tabListeVisu;
  btnListeBack.Visible := false;
  btnListeAjouter.Visible := true;
  btnListeSupprimer.Visible := false;
{$IF (Defined(MSWINDOWS) OR Defined(MACOS) OR Defined(LINUX)) AND NOT Defined(IOS)}
  lblListeTitre.Visible := false;
{$ENDIF}
end;

function TMainForm.GetNewDoc(const FileName: string): TDocumentAncestor;
begin
  result := TLNPDB.Current;
end;

procedure TMainForm.lblDetailCodeClick(Sender: TObject);
begin
  lblDetailCodeEdit.Text := lblDetailCode.Text;
  lblDetailCodeEdit.SelectAll;
  lblDetailCodeEdit.CopyToClipboard;
  ShowMessage('Code copié vers le presse papier.');
end;

procedure TMainForm.ListeAjouterAffiche;
begin
  tcListe.SetActiveTabWithTransition(tabListeAjout, TTabTransition.Slide,
    TTabTransitionDirection.Normal);
  btnListeAjouter.Visible := false;
  btnListeBack.Visible := true;
  lblListeTitre.Text := 'Ajouter';
  edtCrtLibelle.Text := '';
  edtCrtPassphrase.Text := PassPhraseCreate;
{$IF Defined(MSWINDOWS) or Defined(MACOS) or Defined(LINUX)}
  edtCrtLibelle.SetFocus;
{$ENDIF}
  btnCrtEnregistrer.Position.Y := edtCrtPassphrase.Position.Y +
    edtCrtPassphrase.Size.Height + 10;
  btnCrtCancel.Position.Y := btnCrtEnregistrer.Position.Y;
  btnCrtCancel.Position.X := tabListeAjoutLayout.Width - 10 -
    btnCrtCancel.Width;
  btnCrtEnregistrer.Position.X := btnCrtCancel.Position.X - 10 -
    btnCrtEnregistrer.Width;
end;

procedure TMainForm.ListeDetailAffiche;
var
  Rec: TLNPRecord;
begin
  Rec := CurrentLnPRecord;
  if not assigned(Rec) then
    exit;

  lblDetailPassphrase.Visible := tconfig.Current.ShowPassPhrase;
  edtDetailPassphrase.Visible := lblDetailPassphrase.Visible;

  tcListe.SetActiveTabWithTransition(tabListeDetail, TTabTransition.Slide,
    TTabTransitionDirection.Normal);
  btnListeAjouter.Visible := false;
  btnListeBack.Visible := true;
  btnListeSupprimer.Visible := true;
  lblListeTitre.Text := 'Code en cours';

  edtDetailLibelle.Text := Rec.libelle;
  edtDetailPassphrase.Text := Rec.passphrase;

  if (edtDetailPassphrase.Text <> '') then
  begin
    if (api_key.Length > 0) then
      lblDetailCode.Text := lognpass_get_password
        (THashMD5.GetHashString(edtDetailPassphrase.Text), api_key, api_num)
    else
      lblDetailCode.Text := '----------';
  end;
  positionne_barre_de_temps;
end;

procedure TMainForm.ListeVisuAffiche;
var
  Rec: TLNPRecord;
  item: TListViewItem;
begin
  tcListe.SetActiveTabWithTransition(tabListeVisu, TTabTransition.Slide,
    TTabTransitionDirection.Reversed);
  btnListeAjouter.Visible := true;
  btnListeBack.Visible := false;
  btnListeSupprimer.Visible := false;
  lblListeTitre.Text := 'Log''n Pass';

  lstListe.BeginUpdate;
  try
    lstListe.items.Clear;
    for Rec in TLNPDB.Current.AccessList do
      if not Rec.supprime then
      begin
        item := lstListe.items.Add;
        item.Purpose := TListItemPurpose.None;
        item.Text := Rec.libelle;
        item.TagObject := Rec;
      end;
  finally
    lstListe.EndUpdate;
  end;
end;

procedure TMainForm.LoadLogNPassDB;
begin
  TLNPDB.Current.Load;
end;

procedure TMainForm.lstListeItemClick(const Sender: TObject;
const AItem: TListViewItem);
begin
  ListeDetailAffiche;
end;

function TMainForm.PassPhraseCreate: string;
var
  i, j: integer;
begin
  result := '';
  for i := 1 to 5 do
  begin
    if i > 1 then
      result := result + '-';
    for j := 1 to 4 do
    begin
      result := result + IntToStr(trunc(random(10)));
    end;
  end;
end;

procedure TMainForm.pbFondHautResize(Sender: TObject);
begin
  positionne_barre_de_temps;
end;

procedure TMainForm.positionne_barre_de_temps;
begin
  pbDessus.Position.X := pbFondHaut.Position.X;
  pbDessus.Position.Y := pbFondHaut.Position.Y + pbFondHaut.Height +
    pbFondBas.Height - pbDessus.Height;
  lblDetailCode.Scale.X := (pbFondHaut.Size.Width - 20) /
    lblDetailCode.Size.Width;
  if (lblDetailCode.Scale.X > 5) then
    lblDetailCode.Scale.X := 5;
  lblDetailCode.Position.X := pbFondHaut.Position.X +
    (pbFondHaut.Width - lblDetailCode.Width * lblDetailCode.Scale.X) / 2;
  lblDetailCode.Position.Y := pbFondHaut.Position.Y +
    (pbFondHaut.Height + pbFondBas.Height - lblDetailCode.Height *
    lblDetailCode.Scale.Y) / 2;
  dessine_progressbar(temps_restant);
end;

procedure TMainForm.TestIfDBMigrationNeeded;
begin
  if TdmOldSQLiteDB.V1DatabaseExists then
  begin
    Visible := false;
    // TODO : traduire texte
    tdialogservice.MessageDialog
      ('A Log''n Pass 1.x database has been detected. Do you want to import its content ?',
      TMsgDlgType.mtConfirmation, mbYesNo, TMsgDlgBtn.mbYes, 0,
      procedure(const AModalResult: TModalResult)
      begin
        if AModalResult = mrYes then
          try
            TdmOldSQLiteDB.MigrateToNewDB;
            // TODO : traduire texte
            tdialogservice.ShowMessage('Import done.',
              procedure(const AModalResult: TModalResult)
              begin
                Visible := true;
                ListeVisuAffiche;
                // TODO : proposer l'effacement des données précédentes (identifier le bon fichier importé selon NE ou pas NE)
                // tfile.Delete(dm.DBFilePath);
                // tfile.Delete(dm.DBFilePath+'-journal');
              end);
          except
            Visible := true;
            raise;
          end
        else
          Visible := true;
      end);
  end;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  if (not timer_en_cours) then
  begin
    timer_en_cours := true;
    dec(temps_restant);
    dessine_progressbar(temps_restant);
    if (temps_restant < 1) then
      turlstream.Create('http://api.lognpass.com/get/',
        procedure(AStream: TStream)
        var
          SS: TStringStream;
          JSON: TJSONObject;
        begin
          SS := TStringStream.Create;
          try
            AStream.Position := 0;
            SS.CopyFrom(AStream);
            JSON := TJSONObject.ParseJSONValue(SS.DataString) as TJSONObject;
            try
              try
                api_key := JSON.GetValue('key').ToString.Replace('"', '');
              except
                api_key := '';
              end;
              try
                api_num := JSON.GetValue('num').ToString;
              except
                api_num := '';
              end;
              try
                api_sec := JSON.GetValue('sec').ToString;
              except
                api_sec := '1';
              end;
              temps_restant := api_sec.ToInteger;
              if (edtDetailPassphrase.Text <> '') then
              begin
                if (api_key.Length > 0) then
                  lblDetailCode.Text :=
                    lognpass_get_password(THashMD5.GetHashString
                    (edtDetailPassphrase.Text), api_key, api_num)
                else
                  lblDetailCode.Text := '----------';
              end;
            finally
              JSON.Free;
              timer_en_cours := false;
            end;
          finally
            SS.Free;
          end;
        end)
    else
      timer_en_cours := false;
  end;
end;

procedure TMainForm.TranslateTexts(const Language: string);
begin
  inherited;
  // TODO : à compléter
end;

initialization

tdialogservice.PreferredMode := tdialogservice.TPreferredMode.Async;
randomize;

end.
