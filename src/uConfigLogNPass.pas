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
