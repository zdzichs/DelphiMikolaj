program DarkModeDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  UDarkModeMain in 'UDarkModeMain.pas' {FormDarkModeMain},
  FMX.DarkModeWindows in 'FMX.DarkModeWindows.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.CreateForm(TFormDarkModeMain, FormDarkModeMain);
  Application.Run;
end.
