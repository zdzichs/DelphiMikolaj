program PogodaDemo;

uses
  Vcl.Forms,
  UPogodaMain in 'UPogodaMain.pas' {FPogodaDemoMain},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPogodaDemoMain, FPogodaDemoMain);
  Application.Run;
end.
