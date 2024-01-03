program SkiaDemo;

uses
  Vcl.Forms,
  USkiaDemoMain in 'USkiaDemoMain.pas' {FSkiaDemoMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFSkiaDemoMain, FSkiaDemoMain);
  Application.Run;
end.
