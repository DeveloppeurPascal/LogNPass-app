unit frm_principale;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.TabControl,
  System.Actions,
  FMX.ActnList,
  FMX.Gestures,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  System.Rtti,
  System.Bindings.Outputs,
  FMX.Bind.Editors,
  Data.Bind.EngExt,
  FMX.Bind.DBEngExt,
  Data.Bind.Components,
  Data.Bind.DBScope,
  FMX.Edit,
  FMX.Layouts,
  System.ImageList,
  FMX.ImgList,
  FMX.Objects,
  FireDAC.Phys.SQLiteWrapper.Stat,
  Olf.FMX.AboutDialog, FireDAC.Phys.SQLiteWrapper.FDEStat;

type
  TfrmMain = class(TForm)
    tcPrincipal: TTabControl;
    tabListe: TTabItem;
    tabAPropos: TTabItem;
    tcListe: TTabControl;
    tabListeVisu: TTabItem;
    tabListeAjout: TTabItem;
    tabListeDetail: TTabItem;
    tbListeTitre: TToolBar;
    btnListeBack: TSpeedButton;
    btnListeAjouter: TSpeedButton;
    lblListeTitre: TLabel;
    tbAProposTitre: TToolBar;
    lblAProposTitre: TLabel;
    GestureManager1: TGestureManager;
    lblAProposTexte: TLabel;
    Lang1: TLang;
    lstListe: TListView;
    LognpassConnection: TFDConnection;
    ListeTable: TFDQuery;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    edtCrtLibelle: TEdit;
    edtCrtPassphrase: TEdit;
    btnCrtEnregistrer: TButton;
    btnCrtCancel: TButton;
    lblCrtLibelle: TLabel;
    lblCrtPassphrase: TLabel;
    qryListeUpdate: TFDQuery;
    qryListeDelete: TFDQuery;
    qryListeInsert: TFDQuery;
    lblDetailLibelle: TLabel;
    edtDetailPassphrase: TEdit;
    lblDetailPassphrase: TLabel;
    edtDetailLibelle: TEdit;
    btnListeSupprimer: TSpeedButton;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    lblDetailCodeTitre: TLabel;
    lblDetailCode: TLabel;
    Timer1: TTimer;
    tabListeDetailLayout: TLayout;
    tabListeAjoutLayout: TLayout;
    tabReglages: TTabItem;
    tbReglagesTitre: TToolBar;
    lblReglagesTitre: TLabel;
    btnAProposGoWeb: TSpeedButton;
    pbDessus: TRectangle;
    pbFondHaut: TRectangle;
    pbFondBas: TRectangle;
    tabReglagesLayout: TLayout;
    lblReglagesAfficherPassPhrase: TLabel;
    switchAfficherPassPhrase: TSwitch;
    lblReglagesAfficherPassPhraseInfos: TLabel;
    lblDetailCodeEdit: TEdit;
    OlfAboutDialog1: TOlfAboutDialog;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    procedure btnListeAjouterClick(Sender: TObject);
    procedure btnListeBackClick(Sender: TObject);
    procedure lstListeItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormCreate(Sender: TObject);
    procedure LognpassConnectionAfterConnect(Sender: TObject);
    procedure edtCrtPassphraseClick(Sender: TObject);
    procedure edtCrtLibelleClick(Sender: TObject);
    procedure btnCrtCancelClick(Sender: TObject);
    procedure btnCrtEnregistrerClick(Sender: TObject);
    procedure btnListeSupprimerClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure lblDetailCodeResize(Sender: TObject);
    procedure switchAfficherPassPhraseSwitch(Sender: TObject);
    procedure lblDetailCodeClick(Sender: TObject);
    procedure edtDetailPassphraseClick(Sender: TObject);
    procedure pbFondHautResize(Sender: TObject);
    procedure OlfAboutDialog1URLClick(const AURL: string);
    procedure btnAProposGoWebClick(Sender: TObject);
  private
  protected
    api_key, api_num, api_sec: string;
    timer_en_cours: boolean;
    phrase_MD5: string;
    temps_restant: integer;
    PassPhraseVisible: boolean;
    procedure ListeAjouterAffiche;
    procedure ListeVisuAffiche;
    procedure ListeDetailAffiche;
    function PassPhraseCreate: string;
    procedure dessine_progressbar(temps_restant: integer);
    procedure masquer_PassPhrase;
    procedure afficher_PassPhrase;
    procedure positionne_barre_de_temps;
    procedure InitMainFormCaption;
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses
  System.IOUtils,
  u_lognpass,
  u_ajax,
  u_md5,
  System.JSON,
  dm,
  u_urlOpen,
  System.UIConsts,
  Olf.FMX.AboutDialogForm;

procedure TfrmMain.btnCrtEnregistrerClick(Sender: TObject);
begin
  edtCrtLibelle.Text := trim(edtCrtLibelle.Text);
  edtCrtPassphrase.Text := trim(edtCrtPassphrase.Text);
  if (edtCrtLibelle.Text <> '') then
  begin
    if (edtCrtPassphrase.Text <> '') then
    begin
      qryListeInsert.ParamByName('libelle').AsString := edtCrtLibelle.Text;
      qryListeInsert.ParamByName('passphrase').AsString :=
        edtCrtPassphrase.Text;
      qryListeInsert.ExecSQL;
      // ListeTable.Refresh; // ne fonctionnait pas dans le cas où on ajoutait un élément au dessus des autres : la ListView ne se mettait pas correctement à jour.
      ListeTable.Active := false;
      ListeTable.Active := true;
      ListeVisuAffiche;
    end
    else
    begin
{$IF Defined(ANDROID)}
      frmMain.Visible := false;
      MessageDlg('La phrase mystère est obligatoire.', TMsgDlgType.mtError,
        [TMsgDlgBtn.mbOK], 0, TMsgDlgBtn.mbOK,
        procedure(const AResult: TModalResult)
        begin
          frmMain.Visible := true;
        end);
{$ELSE}
      MessageDlg('La phrase mystère est obligatoire.', TMsgDlgType.mtError,
        [TMsgDlgBtn.mbOK], 0);
{$ENDIF}
{$IF Defined(MSWINDOWS) or Defined(MACOS)}
      edtCrtPassphrase.SetFocus;
{$ENDIF}
    end;
  end
  else
  begin
{$IF Defined(ANDROID)}
    frmMain.Visible := false;
    MessageDlg('Le nom est obligatoire.', TMsgDlgType.mtError,
      [TMsgDlgBtn.mbOK], 0, TMsgDlgBtn.mbOK,
      procedure(const AResult: TModalResult)
      begin
        frmMain.Visible := true;
      end);
{$ELSE}
    MessageDlg('Le nom est obligatoire.', TMsgDlgType.mtError,
      [TMsgDlgBtn.mbOK], 0);
{$ENDIF}
{$IF Defined(MSWINDOWS) or Defined(MACOS)}
    edtCrtLibelle.SetFocus;
{$ENDIF}
  end;
end;

procedure TfrmMain.btnListeAjouterClick(Sender: TObject);
begin
  ListeAjouterAffiche;
end;

procedure TfrmMain.btnListeBackClick(Sender: TObject);
begin
  ListeVisuAffiche;
end;

procedure TfrmMain.btnListeSupprimerClick(Sender: TObject);
begin
{$IF Defined(ANDROID)}
  frmMain.Visible := false;
  MessageDlg('Voulez-vous supprimer ce code ?', TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0, TMsgDlgBtn.mbNo,
    procedure(const AResult: TModalResult)
    begin
      if (mrYes = AResult) then
      begin
        qryListeDelete.ParamByName('guid').AsString :=
          ListeTable.FieldByName('guid').AsString;
        qryListeDelete.ParamByName('dateheure_creation').AsDateTime :=
          ListeTable.FieldByName('dateheure_creation').AsDateTime;
        qryListeDelete.ExecSQL;
        ListeTable.Refresh;
        ListeVisuAffiche;
      end;
      frmMain.Visible := true;
    end);
{$ELSE}
  if (mrYes = MessageDlg('Voulez-vous supprimer ce code ?',
    TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
    TMsgDlgBtn.mbNo)) then
  begin
    qryListeDelete.ParamByName('guid').AsString :=
      ListeTable.FieldByName('guid').AsString;
    qryListeDelete.ParamByName('dateheure_creation').AsDateTime :=
      ListeTable.FieldByName('dateheure_creation').AsDateTime;
    qryListeDelete.ExecSQL;
    ListeTable.Refresh;
    ListeVisuAffiche;
  end;
{$ENDIF}
end;

procedure TfrmMain.dessine_progressbar(temps_restant: integer);
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

procedure TfrmMain.afficher_PassPhrase;
begin
  PassPhraseVisible := true;
  lblDetailPassphrase.Visible := PassPhraseVisible;
  edtDetailPassphrase.Visible := PassPhraseVisible;
end;

procedure TfrmMain.btnAProposGoWebClick(Sender: TObject);
begin
  url_Open_In_Browser(OlfAboutDialog1.URL);
end;

procedure TfrmMain.btnCrtCancelClick(Sender: TObject);
begin
  ListeVisuAffiche;
end;

procedure TfrmMain.edtCrtLibelleClick(Sender: TObject);
begin
  edtCrtLibelle.SelectAll;
end;

procedure TfrmMain.edtCrtPassphraseClick(Sender: TObject);
begin
  edtCrtPassphrase.SelectAll;
end;

procedure TfrmMain.edtDetailPassphraseClick(Sender: TObject);
begin
  edtDetailPassphrase.SelectAll;
  edtDetailPassphrase.CopyToClipboard;
  ShowMessage('Phrase mystère copiée vers le presse papier.');
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  encrypter_db: boolean;
begin
  InitMainFormCaption;
{$IF Defined(ANDROID)}
  btnListeSupprimer.Text := '';
{$ENDIF}
{$IF Defined(IOS) OR Defined(ANDROID)}
  tcPrincipal.TabPosition := TTabPosition.Bottom;
  btnAProposGoWeb.Text := '';
  btnCrtEnregistrer.Text := '';
  btnCrtCancel.Text := '';
{$ELSEIF Defined(MSWINDOWS) OR Defined(MACOS)}
  tcPrincipal.TabPosition := TTabPosition.Top;
{$ENDIF}
  tcPrincipal.ActiveTab := tabListe;
  tcListe.ActiveTab := tabListeVisu;
  btnListeBack.Visible := false;
  btnListeAjouter.Visible := true;
  btnListeSupprimer.Visible := false;
{$IF (Defined(MSWINDOWS) OR Defined(MACOS)) AND NOT Defined(IOS)}
  lblListeTitre.Visible := false;
  lblAProposTitre.Visible := false;
  lblReglagesTitre.Visible := false;
{$ENDIF}
  phrase_MD5 := '';
  api_key := '';
  api_num := '';
  api_sec := '0';
  temps_restant := 0;
  masquer_PassPhrase;
  switchAfficherPassPhrase.IsChecked := false;
  timer_en_cours := false;
  Timer1.Enabled := true;
{$IFDEF RELEASE}
  encrypter_db := not FileExists(TPath.Combine(TPath.GetDocumentsPath,
    'lognpass-ne.db'));
{$ELSE}
  encrypter_db := not FileExists(TPath.Combine(TPath.GetDocumentsPath,
    'lognpass-ne-debug.db'));
{$ENDIF}
  if encrypter_db then
    try // TODO : déplacer le fichier de la base de données
      // TODO : distinguer DEBUG et RELEASE pour le path du fichier
{$IFDEF RELEASE}
      LognpassConnection.Params.Values['Database'] :=
        TPath.Combine(TPath.GetDocumentsPath, 'lognpass.db');
{$ELSE}
      LognpassConnection.Params.Values['Database'] :=
        TPath.Combine(TPath.GetDocumentsPath, 'lognpass-debug.db');
{$ENDIF}
      // TODO : distinguer DEBUG et RELEASE pour le User/Password
{$INCLUDE '..\_PRIVATE\db_user_pass.inc.pas.'}
      LognpassConnection.Connected := true;
    except
      encrypter_db := false;
    end;
  if (not encrypter_db) then
  begin
{$IFDEF RELEASE}
    LognpassConnection.Params.Values['Database'] :=
      TPath.Combine(TPath.GetDocumentsPath, 'lognpass-ne.db');
{$ELSE}
    LognpassConnection.Params.Values['Database'] :=
      TPath.Combine(TPath.GetDocumentsPath, 'lognpass-ne-debug.db');
{$ENDIF}
    LognpassConnection.Params.Values['User_Name'] := '';
    LognpassConnection.Params.Values['Password'] := '';
    LognpassConnection.Params.Values['Encrypt'] := 'no';
    LognpassConnection.Connected := true;
  end;
  lblAProposTexte.Text := 'Log''n Pass' + sLineBreak +
    '(c) Patrick Prémartin / Olf Software 2016-2024' + sLineBreak + sLineBreak +
    'Pictos : kolopach (Fotolia.com)' + sLineBreak + 'Logo : Patrick Prémartin'
    + sLineBreak + sLineBreak + 'Développé sous Delphi 12.1 Athens' + sLineBreak
    + sLineBreak + 'Contacts et infos sur https://lognpass.fr';
end;

procedure TfrmMain.InitMainFormCaption;
begin
{$IFDEF DEBUG}
  caption := '[DEBUG] ';
{$ELSE}
  caption := '';
{$ENDIF}
  caption := caption + OlfAboutDialog1.Titre + ' v' +
    OlfAboutDialog1.VersionNumero;
end;

procedure TfrmMain.lblDetailCodeClick(Sender: TObject);
begin
  lblDetailCodeEdit.Text := lblDetailCode.Text;
  lblDetailCodeEdit.SelectAll;
  lblDetailCodeEdit.CopyToClipboard;
  ShowMessage('Code copié vers le presse papier.');
end;

procedure TfrmMain.lblDetailCodeResize(Sender: TObject);
begin
  positionne_barre_de_temps;
end;

procedure TfrmMain.ListeAjouterAffiche;
begin
  tcListe.SetActiveTabWithTransition(tabListeAjout, TTabTransition.Slide,
    TTabTransitionDirection.Normal);
  btnListeAjouter.Visible := false;
  btnListeBack.Visible := true;
  lblListeTitre.Text := 'Ajouter';
  edtCrtLibelle.Text := '';
  edtCrtPassphrase.Text := PassPhraseCreate;
{$IF Defined(MSWINDOWS) or Defined(MACOS)}
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

procedure TfrmMain.ListeDetailAffiche;
begin
  tcListe.SetActiveTabWithTransition(tabListeDetail, TTabTransition.Slide,
    TTabTransitionDirection.Normal);
  btnListeAjouter.Visible := false;
  btnListeBack.Visible := true;
  btnListeSupprimer.Visible := true;
  lblListeTitre.Text := 'Code en cours';
  if (edtDetailPassphrase.Text <> '') then
  begin
    if (api_key.Length > 0) then
      lblDetailCode.Text := lognpass_get_password(md5(edtDetailPassphrase.Text),
        api_key, api_num)
    else
      lblDetailCode.Text := '----------';
  end;
  positionne_barre_de_temps;
end;

procedure TfrmMain.ListeVisuAffiche;
begin
  tcListe.SetActiveTabWithTransition(tabListeVisu, TTabTransition.Slide,
    TTabTransitionDirection.Reversed);
  btnListeAjouter.Visible := true;
  btnListeBack.Visible := false;
  btnListeSupprimer.Visible := false;
  lblListeTitre.Text := 'Log''n Pass';
end;

procedure TfrmMain.LognpassConnectionAfterConnect(Sender: TObject);
var
  guid: TGUID;
begin
  if CreateGUID(guid) <> 0 then
  begin
    raise Exception.Create('Problème de connexion.');
  end
  else
  begin
    LognpassConnection.ExecSQL('CREATE TABLE IF NOT EXISTS liste (' +
      'guid VARCHAR(50) DEFAULT "' + GUIDToString(guid) + '",' +
      'dateheure_creation DATETIME DEFAULT CURRENT_TIMESTAMP,' +
      'dateheure_modification DATETIME DEFAULT CURRENT_TIMESTAMP,' +
      'libelle TEXT NOT NULL,' + 'passphrase TEXT NOT NULL,' +
      'supprime CHAR(1) NOT NULL DEFAULT "N",' +
      'PRIMARY KEY(guid, dateheure_creation))');
  end;
  ListeTable.Active := true;
end;

procedure TfrmMain.lstListeItemClick(const Sender: TObject;
const AItem: TListViewItem);
begin
  ListeDetailAffiche;
end;

procedure TfrmMain.masquer_PassPhrase;
begin
  PassPhraseVisible := false;
  edtDetailPassphrase.Visible := PassPhraseVisible;
  lblDetailPassphrase.Visible := PassPhraseVisible;
end;

procedure TfrmMain.OlfAboutDialog1URLClick(const AURL: string);
begin
  url_Open_In_Browser(AURL);
end;

function TfrmMain.PassPhraseCreate: string;
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

procedure TfrmMain.pbFondHautResize(Sender: TObject);
begin
  positionne_barre_de_temps;
end;

procedure TfrmMain.positionne_barre_de_temps;
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

procedure TfrmMain.switchAfficherPassPhraseSwitch(Sender: TObject);
begin
  if switchAfficherPassPhrase.IsChecked then
    afficher_PassPhrase
  else
    masquer_PassPhrase;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  if (not timer_en_cours) then
  begin
    timer_en_cours := true;
    dec(temps_restant);
    dessine_progressbar(temps_restant);
    if (temps_restant < 1) then
      AjaxCall('http://api.lognpass.com/get/', // TODO : passer en https
        procedure(aResponseContent: TStringStream)
        var
          JSON: TJSONObject;
        begin
          JSON := TJSONObject.Create;
          try
            JSON.Parse(aResponseContent.Bytes, 0);
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
                  lognpass_get_password(md5(edtDetailPassphrase.Text),
                  api_key, api_num)
              else
                lblDetailCode.Text := '----------';
            end;
          finally
            JSON.Free;
            timer_en_cours := false;
          end;
        end)
    else
      timer_en_cours := false;
  end;
end;

end.
