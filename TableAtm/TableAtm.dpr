program TableAtm;

{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$R 'Logo.res' 'Resources\Logo.rc'}

uses
  Vcl.Forms,
  System.SysUtils,
  Main in 'Main.pas' {frmMain},
  DaModule in 'DataModules\DaModule.pas' {dmMain: TDataModule},
  Translate.Lang in 'Translate\Translate.Lang.pas',
  Translate.Resources in 'Translate\Translate.Resources.pas',
  HtmlLib in '..\Common\HtmlLib.pas',
  DebugWriter in '..\Common\DebugWriter.pas',
  HtmlConsts in '..\Common\HtmlConsts.pas',
  XmlFiles in '..\Common\XmlFiles.pas',
  Utils.LocalInformation in '..\Common\Utils.LocalInformation.pas',
  Utils in '..\Common\Utils.pas',
  Utils.VerInfo in '..\Common\Utils.VerInfo.pas',
  Common.Types in '..\Common\Common.Types.pas',
  SplashScreen in 'SplashScreen.pas' {frmSplashScreen},
  Global.Resources in 'Resources\Global.Resources.pas',
  MessageDialog in '..\Common\MessageDialog.pas';

{$R *.res}

begin
  try
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmMain, dmMain);
  try
       TfrmSplashScreen.ShowSplashScreen;
      frmMain.Initialize;
      Application.ShowMainForm := True;
    finally
      TfrmSplashScreen.HideSplashScreen;
    end;
    Application.Run;
  except
    on E: Exception do
    begin
      TfrmSplashScreen.HideSplashScreen;
      if Assigned(LogWriter) then
        LogWriter.Write(ddError, E.Message);
    end;
  end;

end.
