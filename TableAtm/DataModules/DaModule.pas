unit DaModule;

interface

{$REGION 'Region uses'}
uses
  System.SysUtils, System.Classes;
{$ENDREGION}

type
  TdmMain = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmMain: TdmMain;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
