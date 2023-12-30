unit FMX.DarkModeWindows;

interface

implementation

{$IFDEF MSWINDOWS}
uses
System.Messaging, System.Classes, System.UITypes, System.SysUtils,
FMX.Platform,Winapi.Windows,Winapi.Messages, System.Win.Registry, FMX.Objects;

type
TPlatformWindowsDarkMode = class(TInterfacedObject, IFMXSystemAppearanceService)
   CheckWnd: HWND;
   function GetSystemThemeKind: TSystemThemeKind;
   function GetSystemColor(const AType: TSystemColorType): TAlphaColor;
   procedure CheckWndProc(var WinMessage: Winapi.Messages.TMessage);
end;

var
 FPlatformWindowsDarkMode : TPlatformWindowsDarkMode;

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

function TPlatformWindowsDarkMode.GetSystemColor(
  const AType: TSystemColorType): TAlphaColor;
begin
  //
end;

function TPlatformWindowsDarkMode.GetSystemThemeKind: TSystemThemeKind;
begin
  if WindowsDarkMode then
    Result := TSystemThemeKind.Dark
  else
    Result := TSystemThemeKind.Light;
end;

procedure TPlatformWindowsDarkMode.CheckWndProc(var WinMessage: Winapi.Messages.TMessage);
begin
  if WinMessage.MSG = WM_SETTINGCHANGE then
  begin
    //Memo1.Lines.Add(String(TWMSettingChange(WinMessage).Section));
    if SameText('ImmersiveColorSet', String(TWMSettingChange(WinMessage).Section)) then
    begin
      var Msg := TSystemAppearanceChangedMessage.Create(TSystemAppearance.Create, True);
      TMessageManager.DefaultManager.SendMessage(nil, Msg, True);

    end;
  end
  else
    WinMessage.Result := DefWindowProc(CheckWnd, WinMessage.Msg, WinMessage.WParam, WinMessage.LParam);
end;



initialization
 FPlatformWindowsDarkMode := TPlatformWindowsDarkMode.Create;
 AllocateHWnd(FPlatformWindowsDarkMode.CheckWndProc);
 TPlatformServices.Current.AddPlatformService(IFMXSystemAppearanceService, FPlatformWindowsDarkMode);


finalization
 DeallocateHWnd(FPlatformWindowsDarkMode.CheckWnd);

{$ENDIF}
end.
