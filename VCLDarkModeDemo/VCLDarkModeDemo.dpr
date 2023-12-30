program VCLDarkModeDemo;

uses
  Vcl.Forms,
  UVCLDarkModeDemoMain in 'UVCLDarkModeDemoMain.pas' {FVCLDarkModeDemoMain},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TFVCLDarkModeDemoMain, FVCLDarkModeDemoMain);
  Application.Run;
end.
