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
  uDocumentsAncestor;

type
  TMainForm = class(T__MainFormAncestor)
  private
  protected
    function GetNewDoc(const FileName: string = ''): TDocumentAncestor;
      override;
    procedure DoToolsOptionsAction(Sender: TObject); override;
  public
    procedure TranslateTexts(const Language: string); override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses
  fOptionsForm;
{ TMainForm }

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

function TMainForm.GetNewDoc(const FileName: string): TDocumentAncestor;
begin
{$MESSAGE WARN 'Create an instance of your document and remove this comment.'}
  // TODO : Create an instance of your document and remove this comment
  // result := TYourDocumentType.Create;
  result := nil;
end;

procedure TMainForm.TranslateTexts(const Language: string);
begin
  inherited;
  // TODO : à compléter
end;

end.
