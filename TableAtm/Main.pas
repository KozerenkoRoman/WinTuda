unit Main;

interface

{$REGION 'Region uses'}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Translate.Lang, Vcl.ExtCtrls, DebugWriter,
  Common.Types, System.IniFiles, System.IOUtils, Global.Resources, Utils, MessageDialog, System.Threading;
{$ENDREGION}

type
  TfrmMain = class(TForm)
    btnCancel: TButton;
    btnGo: TButton;
    cbAliasList: TComboBox;
    cbConvertATMDocs: TCheckBox;
    cbDBShares: TCheckBox;
    cbLang: TComboBox;
    lblAtmCfg: TLabel;
    lblATMVersion: TLabel;
    lblATMVersionCaption: TLabel;
    lblCompatibility: TLabel;
    lblCompatibilityCaption: TLabel;
    lblSQLVersion: TLabel;
    lblSQLVersionCaption: TLabel;
    procedure cbLangChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lblAtmCfgClick(Sender: TObject);
  private
    FLang: TLang;
    FAtmCfg: TIniFile;
    FScriptDir: string;
    procedure Translite(aLang: TLanguage);
    function CheckData: Boolean;
  public
    procedure Initialize;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
var
  IniPath: string;
  lang: string;
begin
  inherited;
  LogWriter.Write(ddText, 'Getting Started');
  FLang := TLang.Create;
  lang := GetCmdLineValue(GetCommandLine, 'lang', '-', '='); //-lang=en
  if lang.Trim.ToLower.Equals('en') then
    FLang.Language := lgEn;

  IniPath := TDirectory.GetCurrentDirectory + '\' + rsAtmCfg;
  FAtmCfg := TIniFile.Create(IniPath);
  FScriptDir := TDirectory.GetCurrentDirectory + '\' + rsTableATMScripts;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FLang);
  LogWriter.Write(ddText, 'End Of Work');
end;

procedure TfrmMain.Initialize;
begin
  FLang.Initialize;
  cbLang.Clear;
  for var i := Low(TLanguage) to High(TLanguage) do
    cbLang.Items.Add(i.ToString);
  cbLang.ItemIndex := 0;
  Translite(FLang.Language);

  lblAtmCfg.Caption := FAtmCfg.FileName;
  TTask.Create(
    procedure()
    begin
      TThread.NameThreadForDebugging('TfrmMain.CheckData');
      Sleep(1000);
      TThread.Synchronize(nil,
        procedure
        begin
          if not CheckData then
            Application.Terminate;
        end);
    end).Start;
end;

procedure TfrmMain.lblAtmCfgClick(Sender: TObject);
begin
  ShellOpen(lblAtmCfg.Caption);
end;

procedure TfrmMain.Translite(aLang: TLanguage);
begin
  FLang.Language := aLang;
  btnCancel.Caption               := FLang.Translate('Cancel');
  btnGo.Caption                   := FLang.Translate('Go');
  cbConvertATMDocs.Caption        := FLang.Translate('ConvertATMDocs');
  cbDBShares.Caption              := FLang.Translate('DBSharedWithNetzer');
  lblATMVersionCaption.Caption    := FLang.Translate('ATMVersion');
  lblCompatibilityCaption.Caption := FLang.Translate('Compatibility');
  lblSQLVersionCaption.Caption    := FLang.Translate('SQLVersion');
end;

procedure TfrmMain.cbLangChange(Sender: TObject);
begin
  if (cbLang.ItemIndex > -1) then
    Translite(TLanguage(cbLang.ItemIndex));
end;

function TfrmMain.CheckData: Boolean;
var
  Problems: string;
begin
  Problems := '';
  if not TDirectory.Exists(FScriptDir) then
    Problems := Problems + Format(FLang.Translate('DirectoryNotFound'), [FScriptDir]) + sLineBreak;
  if not TFile.Exists(FAtmCfg.FileName) then
    Problems := Problems + Format(FLang.Translate('FileNotFound'), [FAtmCfg.FileName]) + sLineBreak;
  Result := Problems.IsEmpty;
  if not Result then
  begin
    TMessageDialog.ShowWarning(Problems + FLang.Translate('ProgramStopsWorking'));
    LogWriter.Write(ddError, Self, 'CheckData', Problems);
  end;
end;

end.
