unit UVCLDarkModeDemoMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.AppEvnts, Vcl.StdCtrls, Vcl.ExtCtrls;

type
 TThemeType = (ttDark, ttLight, ttSystem);

  TFVCLDarkModeDemoMain = class(TForm)
    ApplicationEvents1: TApplicationEvents;
    ComboBox1: TComboBox;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure ApplicationEvents1SettingChange(Sender: TObject; Flag: Integer;
      const Section: string; var Result: Integer);
    //procedure WMSettingChange(var Message: TWMSettingChange); message WM_SETTINGCHANGE;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure SaveConfig;
    procedure LoadConfig;
    procedure SetTheme(AThemeType : TThemeType);
  private
    FThemeType : TThemeType;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FVCLDarkModeDemoMain: TFVCLDarkModeDemoMain;

implementation

{$R *.dfm}

uses
 System.Win.Registry, Vcl.Themes;

const
 DarkStyleName = 'Windows10 Dark';
 LightStyleName = 'Windows10';


function WindowsDarkMode: Boolean;
// https://github.com/checkdigits/delphidarkmode/blob/master/WindowsDarkMode.pas
const
  TheKey   = 'Software\Microsoft\Windows\CurrentVersion\Themes\Personalize\';
  TheValue = 'AppsUseLightTheme';
var
  Reg: TRegistry;
begin

  Result := False;

  Reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.KeyExists(TheKey) then
      if Reg.OpenKey(TheKey, False) then
      try
        if Reg.ValueExists(TheValue) then
          Result := Reg.ReadInteger(TheValue) = 0;
      finally
        Reg.CloseKey;
      end;
  finally
    Reg.Free;
  end;
end;


procedure TFVCLDarkModeDemoMain.SetTheme(AThemeType : TThemeType);
var
 TargetThemeName : String;
begin
  if AThemeType = ttLight then
    TargetThemeName := LightStyleName
  else
  begin
    TargetThemeName := DarkStyleName;

    if (AThemeType = ttSystem) and (not WindowsDarkMode) then
        TargetThemeName := LightStyleName;

  end;

  if TargetThemeName = LightStyleName then
   Panel2.Color := clLime
  else
   Panel2.Color := clGreen;



  TStyleManager.TrySetStyle( TargetThemeName );




end;

procedure TFVCLDarkModeDemoMain.ApplicationEvents1SettingChange(Sender: TObject;
  Flag: Integer; const Section: string; var Result: Integer);
begin
 if SameText( 'ImmersiveColorSet', Section ) then
    SetTheme( FThemeType );
end;



procedure TFVCLDarkModeDemoMain.ComboBox1Change(Sender: TObject);
begin
 FThemeType := TThemeType( ComboBox1.ItemIndex );
 SetTheme( FThemeType );
 SaveConfig;
end;

procedure TFVCLDarkModeDemoMain.FormCreate(Sender: TObject);
begin
 LoadConfig;
 ComboBox1.ItemIndex := Ord(FThemeType);
 SetTheme( FThemeType );
end;

procedure TFVCLDarkModeDemoMain.LoadConfig;
var
  Rejestr: TRegistry;
  rg: string;
begin
  Rejestr := TRegistry.Create;
  try
    try
      Rejestr.RootKey := HKEY_CURRENT_USER;
      Rejestr.OpenKey('\Software\Caprisoft\DarkModeDemo', true);
      rg := Rejestr.ReadString('Tryb');
      // TThemeType = (ttDark, ttLight, ttSystem);
      if rg='' then rg:='Light';
      if rg = 'Light' then
       FThemeType := ttLight
      else
       if rg = 'Dark' then
         FThemeType := ttDark
        else
           FThemeType := ttSystem;

      Rejestr.CloseKey;
    except
    end;
  finally
    Rejestr.Free;
  end;
end;

procedure TFVCLDarkModeDemoMain.SaveConfig;
var
  Rejestr: TRegistry;
  rg: string;

begin
  Rejestr := TRegistry.Create;
  try
    try
      Rejestr.RootKey := HKEY_CURRENT_USER;
      Rejestr.OpenKey('\Software\Caprisoft\DarkModeDemo', true);
      rg := 'Light';
      if FThemeType = ttDark then
         rg := 'Dark'
      else
      if FThemeType = ttSystem then
         rg := 'System';
      Rejestr.WriteString('Tryb', rg);

      Rejestr.CloseKey;
    except
    end;
  finally
    Rejestr.Free;
  end;

end;


//https://blogs.embarcadero.com/modernize-your-app-are-you-handling-windows-themes-correctly/
//procedure TFVCLDarkModeDemoMain.WMSettingChange(var Message: TWMSettingChange);
//begin
// if SameText( 'ImmersiveColorSet', String(Message.Section) ) then
//    SetTheme( FThemeType );
//end;

end.
