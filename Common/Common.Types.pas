unit Common.Types;

interface

{$REGION 'Region uses'}
uses
  Winapi.Messages, System.SysUtils, System.Variants, {$IFDEF USE_CODE_SITE}CodeSiteLogging, {$ENDIF} Vcl.Graphics;
{$ENDREGION}

type
  TLogDetailType = (ddEnterMethod, ddExitMethod, ddError, ddText, ddWarning);
  TLogDetailTypes = set of TLogDetailType;
  TLogDetailTypeHelper = record helper for TLogDetailType
  private
    const LogDetailTypesString: array[TLogDetailType] of string = ('Enter Method', 'Exit Method', 'Error', 'Text', 'Warning');
  public
    function ToString: string;
  end;

implementation

{ TLogDetailTypeHelper }

function TLogDetailTypeHelper.ToString: string;
begin
  Result := LogDetailTypesString[Self];
end;

end.
