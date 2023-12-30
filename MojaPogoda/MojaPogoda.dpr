program MojaPogoda;

uses
  System.StartUpCopy,
  //FMX.MobilePreview,
  FMX.Forms,
  UPogodaMain in 'UPogodaMain.pas' {FPogodaMain};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.CreateForm(TFPogodaMain, FPogodaMain);
  Application.Run;
end.
