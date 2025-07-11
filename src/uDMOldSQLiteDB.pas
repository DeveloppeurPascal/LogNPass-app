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
  File last update : 2025-07-11T15:12:02.000+02:00
  Signature : debef1ec34b7cd170821a680999c55066b0be83f
  ***************************************************************************
*)

unit uDMOldSQLiteDB;

interface

(*
  CREATE TABLE IF NOT EXISTS liste
  guid VARCHAR(50) DEFAULT "",
  dateheure_creation DATETIME DEFAULT CURRENT_TIMESTAMP,
  dateheure_modification DATETIME DEFAULT CURRENT_TIMESTAMP,
  libelle TEXT NOT NULL,
  passphrase TEXT NOT NULL,
  supprime CHAR(1) NOT NULL DEFAULT "N",
  PRIMARY KEY(guid, dateheure_creation))
*)

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.FDEStat,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.UI.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.FMXUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet;

type
  TdmOldSQLiteDB = class(TDataModule)
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    ListeTable: TFDQuery;
    LognpassConnection: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure LognpassConnectionAfterConnect(Sender: TObject);
  private
    DBFilePath: string;
  protected
    class function GetV1DatabaseFilePath(const Encrypted
      : boolean = true): string;
  public
    class procedure MigrateToNewDB;
    class function V1DatabaseExists: boolean;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

uses
  System.StrUtils,
  System.JSON,
  System.IOUtils,
  uDBLogNPass;

procedure TdmOldSQLiteDB.DataModuleCreate(Sender: TObject);
begin
  DBFilePath := GetV1DatabaseFilePath(true);
  if tfile.Exists(DBFilePath) then
  begin
    LognpassConnection.Params.Values['Database'] := DBFilePath;
{$INCLUDE '..\_PRIVATE\src\db_user_pass.inc'}
    LognpassConnection.Connected := true;
  end
  else
  begin
    DBFilePath := GetV1DatabaseFilePath(false);
    if tfile.Exists(DBFilePath) then
    begin
      LognpassConnection.Params.Values['Database'] := DBFilePath;
      LognpassConnection.Params.Values['User_Name'] := '';
      LognpassConnection.Params.Values['Password'] := '';
      LognpassConnection.Params.Values['Encrypt'] := 'no';
      LognpassConnection.Connected := true;
    end;
  end;
end;

class function TdmOldSQLiteDB.GetV1DatabaseFilePath(const Encrypted
  : boolean): string;
begin
{$IFDEF RELEASE}
  result := TPath.Combine(TPath.GetDocumentsPath, 'lognpass' + ifthen(Encrypted,
    '', '-ne') + '.db');
{$ELSE}
  result := TPath.Combine(TPath.GetDocumentsPath, 'lognpass' + ifthen(Encrypted,
    '', '-ne') + '-debug.db');
{$ENDIF}
end;

procedure TdmOldSQLiteDB.LognpassConnectionAfterConnect(Sender: TObject);
begin
  ListeTable.Active := true;
end;

class procedure TdmOldSQLiteDB.MigrateToNewDB;
var
  dm: TdmOldSQLiteDB;
  lst: TLNPRecordsList;
  rec: TLNPRecord;
begin
  dm := TdmOldSQLiteDB.Create(nil);
  try
    if dm.ListeTable.Active then
      try
        lst := TLNPDB.Current.AccessList;
        dm.ListeTable.First;
        while not dm.ListeTable.Eof do
        begin
          rec := TLNPRecord.Create;
          rec.guid := dm.ListeTable.FieldByName('guid').AsString;
          rec.dateheure_creation := dm.ListeTable.FieldByName
            ('dateheure_creation').AsDateTime;
          rec.libelle := dm.ListeTable.FieldByName('libelle').AsString;
          rec.passphrase := dm.ListeTable.FieldByName('passphrase').AsString;
          rec.supprime := dm.ListeTable.FieldByName('supprime').AsBoolean;
          rec.RecType := TLNPRecType.LogNPass;
          rec.dateheure_modification := dm.ListeTable.FieldByName
            ('dateheure_modification').AsDateTime;
          lst.AddIfNotExists(rec);
          dm.ListeTable.Next;
        end;
        dm.ListeTable.Close;
        dm.LognpassConnection.Close;
        TLNPDB.Current.Save;
      except
        raise Exception.Create('Import error !'); // TODO : à traduire
      end;
  finally
    dm.free;
  end;
end;

class function TdmOldSQLiteDB.V1DatabaseExists: boolean;
begin
  result := tfile.Exists(GetV1DatabaseFilePath(true)) or
    tfile.Exists(GetV1DatabaseFilePath(false));
end;

end.
