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
  public
    class procedure MigrateToNewDB;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

uses
  System.IOUtils;

procedure TdmOldSQLiteDB.DataModuleCreate(Sender: TObject);
var
  encrypter_db: boolean;
begin
{$IFDEF RELEASE}
  encrypter_db := not FileExists(TPath.Combine(TPath.GetDocumentsPath,
    'lognpass-ne.db'));
{$ELSE}
  encrypter_db := not FileExists(TPath.Combine(TPath.GetDocumentsPath,
    'lognpass-ne-debug.db'));
{$ENDIF}
  if encrypter_db then
    try
{$IFDEF RELEASE}
      DBFilePath := TPath.Combine(TPath.GetDocumentsPath, 'lognpass.db');
{$ELSE}
      DBFilePath := TPath.Combine(TPath.GetDocumentsPath, 'lognpass-debug.db');
{$ENDIF}
{$INCLUDE '..\_PRIVATE\src\db_user_pass.inc'}
    except
      encrypter_db := false;
    end;
  if (not encrypter_db) then
  begin
{$IFDEF RELEASE}
    DBFilePath := TPath.Combine(TPath.GetDocumentsPath, 'lognpass-ne.db');
{$ELSE}
    DBFilePath := TPath.Combine(TPath.GetDocumentsPath, 'lognpass-ne-debug.db');
{$ENDIF}
    LognpassConnection.Params.Values['User_Name'] := '';
    LognpassConnection.Params.Values['Password'] := '';
    LognpassConnection.Params.Values['Encrypt'] := 'no';
  end;

  if tfile.Exists(DBFilePath) then
  begin
    LognpassConnection.Params.Values['Database'] := DBFilePath;
    LognpassConnection.Connected := true;
  end;
end;

procedure TdmOldSQLiteDB.LognpassConnectionAfterConnect(Sender: TObject);
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

class procedure TdmOldSQLiteDB.MigrateToNewDB;
var
  dm: TdmOldSQLiteDB;
begin
  dm := TdmOldSQLiteDB.Create(nil);
  try
    if dm.ListeTable.Active then
      try
        dm.ListeTable.First;
        while not dm.ListeTable.Eof do
        begin
          // TODO : stocker dans nouveau format
          dm.ListeTable.Next;
        end;
        dm.ListeTable.Close;
        dm.LognpassConnection.Close;
        // tfile.Move(dm.DBFilePath, dm.DBFilePath + '.1_2');
        // TODO : à réactiver dans une future version du programme
        // tfile.Delete(dm.DBFilePath);
      except
        // TODO : ajouter erreur de migration
      end;
  finally
    dm.free;
  end;
end;

initialization

TdmOldSQLiteDB.MigrateToNewDB;

end.
