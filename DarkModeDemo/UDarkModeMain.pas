unit UDarkModeMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls,
  System.Messaging, FMX.Platform, System.IOUtils,FMX.Objects,
  FMX.DarkModeWindows, FMX.DialogService;

type
  TFormDarkModeMain = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    TrackBar1: TTrackBar;
    StyleBookDark: TStyleBook;
    StyleBookLight: TStyleBook;
    Rectangle1: TRectangle;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SystemAppearanceChangedListener(const Sender: TObject; const AMessage: System.Messaging.TMessage);
    procedure AdjustTheme;
  private
    { Private declarations }
    FThemeMode : TSystemThemeKind;
  public
    { Public declarations }
  end;



const
 DarkStyleName =
{$IFDEF ANDROID}
 'AndroidLDark.fsf';
{$ENDIF}
{$IFDEF MSWINDOWS}
 'Nero_Win.style';
 //'Win10ModernDark.Style';
{$ENDIF}
{$IFDEF IOS}
  '';
{$ENDIF}

LightStyleName =
{$IFDEF ANDROID}
 '';
{$ENDIF}
{$IFDEF MSWINDOWS}
 'Concrete_Win.style';
{$ENDIF}
{$IFDEF IOS}
  '';
{$ENDIF}



var
  FormDarkModeMain: TFormDarkModeMain;

implementation

{$R *.fmx}

procedure TFormDarkModeMain.AdjustTheme;
var
 svc : IFMXSystemAppearanceService;
begin
  if TPlatFormServices.Current.SupportsPlatformService(IFMXSystemAppearanceService,svc) then
  begin
    if FThemeMode <> svc.ThemeKind then
    begin
     FThemeMode := svc.ThemeKind;
      if FThemeMode = TSystemThemeKind.Dark then
      begin
        if DarkStyleName <> '' then
          self.StyleBook := StyleBookDark
        else
          self.StyleBook := nil;
        Memo1.Lines.Add('Tryb Dark');
        Rectangle1.Fill.Color := TAlphaColorRec.Violet;
      end
      else
      begin
        if LightStyleName <> '' then
          self.StyleBook := StyleBookLight
        else
          self.StyleBook := nil;
        Rectangle1.Fill.Color := TAlphaColorRec.Yellow;
        Memo1.Lines.Add('Tryb Light');
      end
    end
  end
   else
    FThemeMode := TSystemThemeKind.Unspecified;

end;

procedure TFormDarkModeMain.Button1Click(Sender: TObject);
begin
 AdjustTheme
end;

procedure TFormDarkModeMain.FormCreate(Sender: TObject);
begin

    FThemeMode := TSystemThemeKind.Unspecified;

    {$IFDEF MSWINDOWS}
    try
     if DarkStyleName <> '' then
       StyleBookDark.FileName := System.IOUtils.TPath.Combine(ExtractFilePath(paramstr(0)),DarkStyleName);
    except
    end;
    try
     if LightStyleName <> '' then
       StyleBookLight.FileName := System.IOUtils.TPath.Combine(ExtractFilePath(paramstr(0)),LightStyleName);
    except
    end;
    {$ENDIF}
    {$IFDEF ANDROID}
     try
     if DarkStyleName <> '' then
       StyleBookDark.FileName := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, DarkStyleName);
     except
     end;
     try
     if LightStyleName <> '' then
       StyleBookLight.FileName := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, LightStyleName);
     except
     end;
    {$ENDIF}
    {$IFNDEF IOS}
    if (((DarkStyleName <> '') and FileExists(StyleBookDark.FileName))
       or (DarkStyleName = ''))
       and
       (((LightStyleName <> '') and FileExists(StyleBookLight.FileName))
       or (LightStyleName = ''))
    then
    {$ENDIF}
    begin //uruchamiamy tylko jeœli uda³o siê za³adowaæ w³aœciwe style
      AdjustTheme;
      TMessageManager.DefaultManager.SubscribeToMessage(TSystemAppearanceChangedMessage, SystemAppearanceChangedListener);
    end;




end;

procedure TFormDarkModeMain.SystemAppearanceChangedListener(const Sender: TObject;
  const AMessage: System.Messaging.TMessage);
begin
  AdjustTheme;
end;






end.
