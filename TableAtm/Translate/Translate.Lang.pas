unit Translate.Lang;

interface

{$REGION 'Region uses'}

uses
  System.SysUtils, System.Variants, System.Classes, Translate.Resources, System.Generics.Collections,
  System.Generics.Defaults;
{$ENDREGION}

type
  TLanguage = (lgHe, lgEn);
  TLanguageHelper = record helper for TLanguage
  private const
    LanguageString: array [TLanguage] of string = ('Hebrew', 'English');
  public
    function ToString: string;
  end;

  TLang = class(TObject)
  private
    FLanguage: TLanguage;
    FEnList: TDictionary<string, string>;
    FHeList: TDictionary<string, string>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Initialize;
    function Translate(const AKey: string): string;
    property Language: TLanguage read FLanguage write FLanguage;
  end;

implementation

{ TLang }

constructor TLang.Create;
begin
  FLanguage := lgHe;
  FEnList := TDictionary<string, string>.Create;
  FHeList := TDictionary<string, string>.Create;
end;

destructor TLang.Destroy;
begin
  FreeAndNil(FEnList);
  FreeAndNil(FHeList);
  inherited;
end;

procedure TLang.Initialize;
begin
  FEnList.Add('atmversion', en_ATMVersion);
  FEnList.Add('sqlversion', en_SQLVersion);
  FEnList.Add('compatibility', en_Compatibility);
  FEnList.Add('dbsharedwithnetzer', en_DBSharedWithNetzer);
  FEnList.Add('convertatmdocs', en_ConvertATMDocs);
  FEnList.Add('cancel', en_Cancel);
  FEnList.Add('go', en_Go);
  FEnList.Add('error', en_Error);
  FEnList.Add('errors', en_Errors);
  FEnList.Add('filenotfound', en_FileNotFound);
  FEnList.Add('directorynotfound', en_DirectoryNotFound);
  FEnList.Add('programstopsworking', en_ProgramStopsWorking);

  FHeList.Add('atmversion', he_ATMVersion);
  FHeList.Add('sqlversion', he_SQLVersion);
  FHeList.Add('compatibility', he_Compatibility);
  FHeList.Add('dbsharedwithnetzer', he_DBSharedWithNetzer);
  FHeList.Add('convertatmdocs', he_ConvertATMDocs);
  FHeList.Add('cancel', he_Cancel);
  FHeList.Add('go', he_Go);
  FHeList.Add('error', he_Error);
  FHeList.Add('errors', he_Errors);
  FHeList.Add('filenotfound', he_FileNotFound);
  FHeList.Add('directorynotfound', he_DirectoryNotFound);
  FHeList.Add('programstopsworking', he_ProgramStopsWorking);
end;

function TLang.Translate(const AKey: string): string;
var
  val: string;
begin
  case FLanguage of
    lgHe:
      FHeList.TryGetValue(AKey.ToLower, val);
    lgEn:
      FEnList.TryGetValue(AKey.ToLower, val);
  end;
  Result := val;
end;

{ TLanguageHelper }

function TLanguageHelper.ToString: string;
begin
  REsult := LanguageString[Self];
end;

end.
