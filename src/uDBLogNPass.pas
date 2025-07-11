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
  File last update : 2025-07-11T14:58:48.000+02:00
  Signature : 469b7130596bc26d174f876f24befc306293dd58
  ***************************************************************************
*)

unit uDBLogNPass;

interface

uses
  System.Generics.Collections,
  System.JSON,
  uDocumentsAncestor;

type
{$SCOPEDENUMS ON}
  TLNPRecType = (None, LogNPass);

  TLNPRecord = class(TObject)
  private
    Fdateheure_creation: TDateTime;
    Fdateheure_modification: TDateTime;
    Fpassphrase: string;
    Flibelle: string;
    Fsupprime: boolean;
    Fguid: string;
    FRecType: TLNPRecType;
    procedure Setdateheure_creation(const Value: TDateTime);
    procedure Setdateheure_modification(const Value: TDateTime);
    procedure Setguid(const Value: string);
    procedure Setlibelle(const Value: string);
    procedure Setpassphrase(const Value: string);
    procedure Setsupprime(const Value: boolean);
    function Getguid: string;
    procedure SetRecType(const Value: TLNPRecType);
  protected
  public
    property guid: string read Getguid write Setguid;
    property dateheure_creation: TDateTime read Fdateheure_creation
      write Setdateheure_creation;
    property dateheure_modification: TDateTime read Fdateheure_modification
      write Setdateheure_modification;
    property libelle: string read Flibelle write Setlibelle;
    property passphrase: string read Fpassphrase write Setpassphrase;
    property supprime: boolean read Fsupprime write Setsupprime;
    property RecType: TLNPRecType read FRecType write SetRecType;
    function AsJSON: TJSONObject;
    constructor Create;
    constructor CreateFromJSON(const jso: TJSONObject);
  end;

  TLNPRecordsList = class(TObjectList<TLNPRecord>)
  private
  protected
  public
    function AddIfNotExists(const ARec: TLNPRecord): integer;
    function AsJSON: TJSONArray;
    constructor CreateFromJSON(const jsa: TJSONArray);
    procedure AddLogNPassRecord(const libelle, passphrase: string);
  end;

  TLNPDB = class(TJSONDocumentAncestor)
  private
    FAccessList: TLNPRecordsList;
  protected
  public
    property AccessList: TLNPRecordsList read FAccessList;
    function GetDocumentGUID: string; override;
    function GetDocumentExtension: string; override;
    function GetPrivateXORKey: TArray<Byte>; override;
    function AsJSON: TJSONObject; override;
    procedure LoadFromJSONObject(const jso: TJSONObject); override;
    constructor Create; override;
    destructor Destroy; override;
    class function Current: TLNPDB;
    function GetFilePath: string;
    procedure Load;
    procedure Save;
  end;

implementation

uses
  System.DateUtils,
  System.IOUtils,
  System.SysUtils,
  uConfig;

var
  LLNPDB: TLNPDB;

  { TLNPDB }

function TLNPDB.AsJSON: TJSONObject;
begin
  result := inherited;
  result.AddPair('lst', AccessList.AsJSON);
end;

constructor TLNPDB.Create;
begin
  inherited;

  FAccessList := TLNPRecordsList.Create;
end;

class function TLNPDB.Current: TLNPDB;
begin
  if not assigned(LLNPDB) then
  begin
    LLNPDB := TLNPDB.Create;
    if tfile.Exists(LLNPDB.GetFilePath) then
      LLNPDB.LoadFromFile(LLNPDB.GetFilePath);
  end;

  result := LLNPDB;
end;

destructor TLNPDB.Destroy;
begin
  FAccessList.Free;

  inherited;
end;

function TLNPDB.GetFilePath: string;
begin
{$IFDEF RELEASE}
  result := TPath.Combine(TPath.GetDirectoryName(tconfig.Current.GetPath),
    'lognpass.' + GetDocumentExtension);
{$ELSE}
  result := TPath.Combine(TPath.GetDirectoryName(tconfig.Current.GetPath),
    'lognpass-debug.' + GetDocumentExtension);
{$ENDIF}
end;

function TLNPDB.GetDocumentExtension: string;
begin
{$IFDEF DEBUG}
  result := 'lnp-dbg';
{$ELSE}
  result := 'lnp';
{$ENDIF}
end;

function TLNPDB.GetDocumentGUID: string;
begin
  result := 'ACD602E3-3CD0-4A16-9176-6F4B3D569A94';
end;

function TLNPDB.GetPrivateXORKey: TArray<Byte>;
begin
{$IFDEF DEBUG}
  setlength(result, 0);
{$ELSE}
{$I '..\_PRIVATE\src\DBFileXORKey.inc'}
{$ENDIF}
end;

procedure TLNPDB.Load;
begin
  LoadFromFile(GetFilePath);
end;

procedure TLNPDB.LoadFromJSONObject(const jso: TJSONObject);
var
  jsa: TJSONArray;
begin
  inherited;

  if assigned(FAccessList) then
    FreeAndNil(FAccessList);

  jsa := jso.GetValue<TJSONArray>('lst', nil);
  FAccessList := TLNPRecordsList.CreateFromJSON(jsa);
end;

procedure TLNPDB.Save;
begin
  SaveToFile(GetFilePath);
end;

{ TLNPRecordsList }

function TLNPRecordsList.AddIfNotExists(const ARec: TLNPRecord): integer;
var
  LRec: TLNPRecord;
begin
  for LRec in self do
    if (LRec.libelle = ARec.libelle) and (LRec.Fpassphrase = ARec.passphrase)
      and (not LRec.supprime) then
      exit(-1);
  result := add(ARec);
end;

procedure TLNPRecordsList.AddLogNPassRecord(const libelle, passphrase: string);
var
  Rec: TLNPRecord;
begin
  // TODO : à traduire
  if libelle.IsEmpty then
    raise Exception.Create('Label needed !');
  if passphrase.IsEmpty then
    raise Exception.Create('Passphrase needed !');

  Rec := TLNPRecord.Create;
  Rec.libelle := libelle;
  Rec.passphrase := passphrase;
  Rec.RecType := TLNPRecType.LogNPass;
  AddIfNotExists(Rec);
end;

function TLNPRecordsList.AsJSON: TJSONArray;
var
  Rec: TLNPRecord;
begin
  result := TJSONArray.Create;
  for Rec in self do
    result.add(Rec.AsJSON);
end;

constructor TLNPRecordsList.CreateFromJSON(const jsa: TJSONArray);
var
  jsv: TJSONValue;
begin
  Create;
  if not assigned(jsa) then
    exit;

  for jsv in jsa do
    if jsv is TJSONObject then
      self.add(TLNPRecord.CreateFromJSON(jsv as TJSONObject));
end;

{ TLNPRecord }

function TLNPRecord.AsJSON: TJSONObject;
begin
  result := TJSONObject.Create;
  result.AddPair('dhc', dateheure_creation.ToISO8601);
  result.AddPair('dhm', dateheure_modification.ToISO8601);
  result.AddPair('pp', passphrase);
  result.AddPair('lib', libelle);
  result.AddPair('del', supprime);
  result.AddPair('guid', guid);
  result.AddPair('type', ord(RecType));
end;

constructor TLNPRecord.Create;
begin
  inherited;
  Fdateheure_creation := now;
  Fdateheure_modification := Fdateheure_creation;
  Fpassphrase := '';
  Flibelle := '';
  Fsupprime := false;
  Fguid := '';
  FRecType := TLNPRecType.None;
end;

constructor TLNPRecord.CreateFromJSON(const jso: TJSONObject);
begin
  Create;
  if not assigned(jso) then
    exit;

  dateheure_creation := jso.GetValue<TDateTime>('dhc', now);
  passphrase := jso.GetValue<string>('pp', '');
  libelle := jso.GetValue<string>('lib', '');
  supprime := jso.GetValue<boolean>('del', false);
  guid := jso.GetValue<string>('guid', '');
  dateheure_modification := jso.GetValue<TDateTime>('dhm', dateheure_creation);
end;

function TLNPRecord.Getguid: string;
begin
  if Fguid.IsEmpty then
  begin
    Fguid := tguid.NewGuid.ToString;
    Fdateheure_modification := now;
  end;
  result := Fguid;
end;

procedure TLNPRecord.Setdateheure_creation(const Value: TDateTime);
begin
  if (Fdateheure_creation <> Value) then
  begin
    Fdateheure_creation := Value;
    Fdateheure_modification := now;
  end;
end;

procedure TLNPRecord.Setdateheure_modification(const Value: TDateTime);
begin
  Fdateheure_modification := Value;
end;

procedure TLNPRecord.Setguid(const Value: string);
begin
  if (Fguid <> Value) then
  begin
    Fguid := Value;
    Fdateheure_modification := now;
  end;
end;

procedure TLNPRecord.Setlibelle(const Value: string);
begin
  if (Flibelle <> Value) then
  begin
    Flibelle := Value;
    Fdateheure_modification := now;
  end;
end;

procedure TLNPRecord.Setpassphrase(const Value: string);
begin
  if (Fpassphrase <> Value) then
  begin
    Fpassphrase := Value;
    Fdateheure_modification := now;
  end;
end;

procedure TLNPRecord.SetRecType(const Value: TLNPRecType);
begin
  if (FRecType <> Value) then
  begin
    FRecType := Value;
    Fdateheure_modification := now;
  end;
end;

procedure TLNPRecord.Setsupprime(const Value: boolean);
begin
  if (Fsupprime <> Value) then
  begin
    Fsupprime := Value;
    Fdateheure_modification := now;
  end;
end;

initialization

LLNPDB := nil;

finalization

LLNPDB.Free;

end.
