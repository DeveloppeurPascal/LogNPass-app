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
  uDocumentsAncestor;

type
  TLNPDB = class(TJSONDocumentAncestor)
  private
  protected
  public
    function GetDocumentGUID: string; override;
    function GetDocumentExtension: string; override;
    function GetPrivateXORKey: TArray<Byte>; override;
  end;

implementation

{ TLNPDB }

function TLNPDB.GetDocumentExtension: string;
begin
{$IFDEF DEBUG}
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

end.
