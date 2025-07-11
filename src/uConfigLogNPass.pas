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
  File last update : 2025-07-11T13:32:44.000+02:00
  Signature : ee3abd1776554a1f94cf0b38f122f50435a2822f
  ***************************************************************************
*)

unit uConfigLogNPass;

interface

uses
  uConfig;

type
  TConfigHelpers = class helper for TConfig
  private
    procedure SetShowPassPhrase(const Value: boolean);
    function GetShowPassPhrase: boolean;
  protected
  public
    /// <summary>
    /// Used to show secrets and passwords on screen.
    /// </summary>
    /// <remarks>
    /// This property is not stored in the program settings. It's value is only available when the program is started.
    /// Default value is "False"
    /// </remarks>
    property ShowPassPhrase: boolean read GetShowPassPhrase
      write SetShowPassPhrase;
  end;

implementation

var
  LShowPassPhrase: boolean;

  { TConfigHelpers }

function TConfigHelpers.GetShowPassPhrase: boolean;
begin
  result := LShowPassPhrase;
end;

procedure TConfigHelpers.SetShowPassPhrase(const Value: boolean);
begin
  LShowPassPhrase := Value;
end;

initialization

LShowPassPhrase := false;

end.
