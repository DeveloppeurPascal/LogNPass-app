unit fOptionsForm;

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
  _TFormAncestor,
  FMX.Controls.Presentation,
  FMX.Layouts;

type
  TfrmOptions = class(T__TFormAncestor)
    VertScrollBox1: TVertScrollBox;
    Layout1: TLayout;
    btnClose: TButton;
    cbShowPassPhrase: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cbShowPassPhraseChange(Sender: TObject);
  private
  public
    procedure TranslateTexts(const Language: string); override;
  end;

implementation

{$R *.fmx}

uses
  uConfigLogNPass,
  uConfig;

{ TfrmOptions }

procedure TfrmOptions.cbShowPassPhraseChange(Sender: TObject);
begin
  TConfig.Current.ShowPassPhrase := cbShowPassPhrase.IsChecked;
end;

procedure TfrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
{$IF Defined(IOS) or Defined(ANDROID)}
  TThread.ForceQueue(nil,
    procedure
    begin
      Self.Free;
    end);
{$ENDIF}
end;

procedure TfrmOptions.FormCreate(Sender: TObject);
begin
  cbShowPassPhrase.IsChecked := TConfig.Current.ShowPassPhrase;
end;

procedure TfrmOptions.TranslateTexts(const Language: string);
begin
  inherited;
  if (Language = 'fr') then
  begin
    caption := 'Options';
    cbShowPassPhrase.Text := 'Afficher les clés secrètes et mots de passe';
    btnClose.Text := 'Fermer';
  end
  else
  begin
    caption := 'Options';
    cbShowPassPhrase.Text := 'Show password and secrets keys';
    btnClose.Text := 'Close';
  end;
end;

end.
