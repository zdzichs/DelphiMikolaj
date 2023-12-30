unit UPogodaMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.TabControl, REST.Types, FMX.Controls.Presentation,
  FMX.StdCtrls, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, FMX.ListBox, FMX.Layouts,
  System.Actions, FMX.ActnList, FMX.Edit, FMX.DialogService.Async, FMX.Objects,
  {IdHTTP,} System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.IOUtils, FMX.Ani,
  IdHashMessageDigest,idHash,idGlobal, FMX.Platform, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, REST.Json, System.JSON, System.Math,
  FMX.DarkModeWindows, System.Messaging;

type
  TFPogodaMain = class(TForm)
    TabControlMain: TTabControl;
    TabItemResults: TTabItem;
    TabItemForecast: TTabItem;
    ListViewForecast: TListView;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    BindingsList1: TBindingsList;
    ListBoxDetails: TListBox;
    ListBoxItemTemp: TListBoxItem;
    LabelTemp: TLabel;
    ListBoxItemCisn: TListBoxItem;
    LabelCisn: TLabel;
    ListBoxItemTmin: TListBoxItem;
    LabelTmin: TLabel;
    ListBoxItemTmax: TListBoxItem;
    LabelTmax: TLabel;
    ListBoxItemWilg: TListBoxItem;
    LabelWilg: TLabel;
    ActionList1: TActionList;
    NextTabActionDetails: TNextTabAction;
    ToolBar1: TToolBar;
    LabelDetails: TLabel;
    ButtonWroc: TButton;
    PreviousTabActionDetails: TPreviousTabAction;
    ToolBar2: TToolBar;
    LabelTitle: TLabel;
    EditSearch: TEdit;
    ButtonClearEditSearch: TButton;
    ButtonSearch: TButton;
    TimerTyping: TTimer;
    AniIndicator1: TAniIndicator;
    ListBoxItemChmury: TListBoxItem;
    LabelChmury: TLabel;
    LabelChmuryOpis: TLabel;
    RoundRectChmury: TRoundRect;
    RoundRectChmuryWartosc: TRoundRect;
    LayoutChmury: TLayout;
    ListBoxItemIcon: TListBoxItem;
    ImageWeather: TImage;
    LayoutRight: TLayout;
    TimerAdjustBars: TTimer;
    LayoutCurrentWeather: TLayout;
    RESTClient2: TRESTClient;
    RESTRequest2: TRESTRequest;
    RESTResponse2: TRESTResponse;
    ImageWeatherCurr: TImage;
    Layout1: TLayout;
    Layout2: TLayout;
    LabelTempCurr: TLabel;
    LabelPressureCurr: TLabel;
    LabelDescCurr: TLabel;
    TimerUpdateWeather: TTimer;
    RoundRect1: TRoundRect;
    MemoLog: TMemo;
    StyleBookLight: TStyleBook;
    StyleBookDark: TStyleBook;
    procedure ListViewForecastItemClickEx(const Sender: TObject;
      ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
    procedure ButtonWrocClick(Sender: TObject);
    procedure ListBoxDetailsItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure EditSearchChangeTracking(Sender: TObject);
    procedure ButtonClearEditSearchClick(Sender: TObject);
    procedure TimerTypingTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SaveConfig;
    procedure LoadConfig;
    procedure FormCreate(Sender: TObject);
    procedure AdjustBars;
    procedure LayoutChmuryResize(Sender: TObject);
    procedure TimerAdjustBarsTimer(Sender: TObject);
    procedure UpdateWeather;
    procedure TimerUpdateWeatherTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AdjustTheme;
    procedure SystemAppearanceChangedListener(const Sender: TObject; const AMessage: TMessage);
    procedure ListViewForecastUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ListViewForecastScrollViewChange(Sender: TObject);

  private
    { Private declarations }
    FThemeMode : TSystemThemeKind;
  public
    function HandleAppEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;

  end;

  TImageLoadURLExtension = class helper for TBitmap
    procedure LoadFromURL(const AUrl: string);
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
  FPogodaMain: TFPogodaMain;

implementation

{$R *.fmx}

procedure TFPogodaMain.AdjustBars;
begin

 try
  RoundRectChmuryWartosc.Width := 0;
  TAnimator.AnimateFloatDelay(RoundRectChmuryWartosc,'Width',LabelChmury.Text.ToInteger/100*RoundRectChmury.Width,0.5,0.1,TAnimationType.InOut, TInterpolationType.Exponential );

 except

 end;
end;

procedure TFPogodaMain.AdjustTheme;
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
        RoundRectChmuryWartosc.Fill.Color := TAlphaColorRec.LightSteelblue;
      end
      else
      begin
        if LightStyleName <> '' then
          self.StyleBook := StyleBookLight
        else
          self.StyleBook := nil;
        RoundRectChmuryWartosc.Fill.Color := TAlphaColorRec.Steelblue;
      end
    end
  end
   else
    FThemeMode := TSystemThemeKind.Unspecified;

end;

procedure TFPogodaMain.ButtonClearEditSearchClick(Sender: TObject);
begin
 EditSearch.Text:='';
 ButtonSearch.Visible:=true;
 EditSearch.SetFocus;
end;

procedure TFPogodaMain.ButtonWrocClick(Sender: TObject);
begin
 PreviousTabActionDetails.Execute;
end;

procedure TFPogodaMain.EditSearchChangeTracking(Sender: TObject);
begin
   TimerTyping.Enabled:=false;
   TimerTyping.Interval:=1200;
   TimerTyping.Enabled:=true;
   ButtonSearch.Visible:=(EditSearch.Text='');
end;

procedure TFPogodaMain.FormActivate(Sender: TObject);
begin
 if TimerUpdateWeather.Enabled then
   UpdateWeather;
end;

procedure TFPogodaMain.FormCreate(Sender: TObject);
var aFMXApplicationEventService: IFMXApplicationEventService;
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
    begin //uruchamiamy tylko jeśli udało się załadować właściwe style
      AdjustTheme;
      TMessageManager.DefaultManager.SubscribeToMessage(TSystemAppearanceChangedMessage, SystemAppearanceChangedListener);
    end;




  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, IInterface(aFMXApplicationEventService)) then
  begin
    aFMXApplicationEventService.SetApplicationEventHandler(HandleAppEvent);
  end;

 LoadConfig;
end;

procedure TFPogodaMain.FormResize(Sender: TObject);
begin
 AdjustBars;

end;

function TFPogodaMain.HandleAppEvent(AAppEvent: TApplicationEvent;
  AContext: TObject): Boolean;
begin
 case AAppEvent of
    TApplicationEvent.FinishedLaunching:;
    TApplicationEvent.BecameActive:
    begin
     LoadConfig;
     UpdateWeather;
    end;
    TApplicationEvent.WillBecomeInactive:;
    TApplicationEvent.EnteredBackground: ;
    TApplicationEvent.WillBecomeForeground:;
    TApplicationEvent.WillTerminate: ;
    TApplicationEvent.LowMemory: ;
    TApplicationEvent.TimeChange: ;
    TApplicationEvent.OpenURL: ;
  end;

  Result := True;

end;

procedure TFPogodaMain.LayoutChmuryResize(Sender: TObject);
begin
 //AdjustBars;
end;

procedure TFPogodaMain.ListBoxDetailsItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
 ListBoxDetails.ItemIndex := -1;
 ListBoxDetails.RealignContent;
end;

//function LoadBitmapIndyFromURL(const url: string; const RAWBitmap: TBitmap): Boolean;
//var
//  HTTP: TIdHttp;
//  Stream: TStream;
//begin
//  Result := False;
//  HTTP := TIdHttp.Create(nil);
//  Http.Request.UserAgent:='Mozilla/3.0 (compatible; zdzichs)';
//  try
//    Stream := TMemoryStream.Create;
//    try
//      HTTP.Get(url, Stream);
//      Stream.Position := 0;
//      //RAWBitmap := TBitmap.Create(0, 0);
//      RAWBitmap.LoadFromStream(Stream);
//      Result := True;
//    finally
//      Stream.Free
//    end
//  finally
//    HTTP.Free
//  end;
//end;

procedure LoadBitmapHttpFromURL(const url: string; const RAWBitmap: TBitmap);
begin
  TThread.CreateAnonymousThread(
  procedure()
  var
    HTTP: TNetHTTPClient;
    Stream: TStream;

  begin
      HTTP := TNetHTTPClient.Create(nil);
      Http.UserAgent:='Mozilla/3.0 (compatible; zdzichs)';
      try
        Stream := TMemoryStream.Create;
        try
          HTTP.Get(url, Stream);
          //TThread.Sleep(3000);
          Stream.Position := 0;
          //RAWBitmap := TBitmap.Create(0, 0);
          TThread.Synchronize(TThread.CurrentThread,
           procedure ()
           begin
             RAWBitmap.LoadFromStream(Stream);
           end
          );
          //Result := True;
        finally
          Stream.Free
        end
      finally
        HTTP.Free
      end;
  end).Start;
end;


procedure TFPogodaMain.ListViewForecastItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var
 icn : String;
begin
 LabelDetails.Text := EditSearch.Text+' '+ListViewForecast.Items[ItemIndex].Text;
 LabelChmury.Text := RESTResponse1.JSONValue.GetValue<Double>('list['+ItemIndex.ToString+'].clouds.all').ToString;
 LabelTemp.Text := RESTResponse1.JSONValue.GetValue<Double>('list['+ItemIndex.ToString+'].main.temp').ToString;
 LabelTmin.Text := RESTResponse1.JSONValue.GetValue<Double>('list['+ItemIndex.ToString+'].main.temp_min').ToString;
 LabelTmax.Text := RESTResponse1.JSONValue.GetValue<Double>('list['+ItemIndex.ToString+'].main.temp_max').ToString;
 LabelWilg.Text := RESTResponse1.JSONValue.GetValue<Integer>('list['+ItemIndex.ToString+'].main.humidity').ToString;
 LabelCisn.Text := RESTResponse1.JSONValue.GetValue<Integer>('list['+ItemIndex.ToString+'].main.pressure').ToString;
 icn := RESTResponse1.JSONValue.GetValue<String>('list['+ItemIndex.ToString+'].weather[0].icon');
 ImageWeather.Bitmap.Clear(TAlphaColorRec.White);
 LoadBitmapHttpFromURL('http://openweathermap.org/img/wn/'+icn+'@2x.png',ImageWeather.Bitmap);
 ListViewForecast.Selected:=nil;
 NextTabActionDetails.Execute;
 RoundRectChmuryWartosc.Width := 0;
 TimerAdjustBars.Enabled:= true;
end;

procedure TFPogodaMain.ListViewForecastScrollViewChange(Sender: TObject);
begin
 for var AItem in TListView(Sender).Items do
 begin
   var R : TRectF := TListView(Sender).GetItemRect(AItem.Index);
   //AItem.Objects.TextObject.Text := R.Top.ToString;
   if (R.Top >= 0) and (R.Top <= TListView(Sender).Height) and
      (AItem.TagString <> '') then
   begin
    AItem.Objects.ImageObject.Bitmap.LoadFromURL(AItem.TagString);
    AItem.TagString := '';
   end;
 end;

end;

procedure TFPogodaMain.ListViewForecastUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
var
  R : TRectF;
begin

//  R := TListView(Sender).GetItemRect(AItem.Index);
//  if (R.Top >= 0) and (R.Bottom <= TListView(Sender).Height) then
////  if AItem.TagString <> '' then
//  begin
//    AItem.Objects.ImageObject.Bitmap.LoadFromURL(AItem.TagString);
//    AItem.TagString := '';
//  end;
end;

procedure TFPogodaMain.LoadConfig;
begin
 try
  EditSearch.Text := TFile.ReadAllText(System.IOUtils.TPath.GetDocumentsPath+System.IOUtils.TPath.DirectorySeparatorChar+'mojapogoda.dat', TEncoding.UTF8);
 except

 end;

end;

procedure TFPogodaMain.SaveConfig;
begin
 try
  TFile.WriteAllText(System.IOUtils.TPath.GetDocumentsPath+System.IOUtils.TPath.DirectorySeparatorChar+'mojapogoda.dat', EditSearch.Text, TEncoding.UTF8);
 except

 end;
end;

procedure TFPogodaMain.SystemAppearanceChangedListener(const Sender: TObject;
  const AMessage: TMessage);
begin
 AdjustTheme;
end;

procedure TFPogodaMain.TimerAdjustBarsTimer(Sender: TObject);
begin
  TimerAdjustBars.Enabled := false;
  AdjustBars;
end;

procedure TFPogodaMain.TimerTypingTimer(Sender: TObject);
begin
 UpdateWeather;
end;

procedure TFPogodaMain.TimerUpdateWeatherTimer(Sender: TObject);
begin
  UpdateWeather;
end;

procedure TFPogodaMain.UpdateWeather;
var
 idmd5 : TIdHashMessageDigest5;
 kod   : String;
begin
  TimerTyping.Enabled := false;
  TimerUpdateWeather.Enabled:=false;
  PreviousTabActionDetails.Execute;

  ListViewForecast.Items.Clear;
  LabelTempCurr.Text:= '';
  LabelPressureCurr.Text:= '';
  LabelDescCurr.Text:= '';
  ImageWeatherCurr.Bitmap.Clear(TAlphaColorRec.Null);

  AniIndicator1.Enabled:=true;
  AniIndicator1.Visible:=true;

  kod := '';
  idmd5 := TIdHashMessageDigest5.Create;
  try
    kod := idmd5.HashStringAsHex(DateTimeToStr(Now), IndyTextEncoding_UTF8);
  finally
    idmd5.Free;
  end;


  RESTRequest1.Params[0].Value := EditSearch.Text;
  RESTRequest1.Params[1].Value := kod;
  RESTRequest2.Params[0].Value := EditSearch.Text;
  RESTRequest2.Params[1].Value := kod;
  SaveConfig;
  LabelTitle.Text := 'Moja pogoda ('+DateTimeToStr(Now)+')';
  RESTRequest2.ExecuteAsync(
    procedure()
    begin
      LabelTempCurr.Text:=RESTResponse2.JSONValue.GetValue<Double>('main.temp').ToString +' ºC';
      LabelPressureCurr.Text:=RESTResponse2.JSONValue.GetValue<Double>('main.pressure').ToString +' hPa';
      LabelDescCurr.Text:=RESTResponse2.JSONValue.GetValue<String>('weather[0].description');

      ImageWeatherCurr.Bitmap.Clear(TAlphaColorRec.Null);
      LoadBitmapHttpFromURL('http://openweathermap.org/img/wn/'+RESTResponse2.JSONValue.GetValue<String>('weather[0].icon')+'@2x.png',ImageWeatherCurr.Bitmap);
    end
  );
  RESTRequest1.ExecuteAsync(
    procedure()
    var
     NewItem : TListViewItem;
    begin
      FPogodaMain.AniIndicator1.Enabled := false;
      FPogodaMain.AniIndicator1.Visible := false;
      TimerUpdateWeather.Enabled := true;
      if RESTResponse1.StatusCode = 200 then
      begin
       for var i:= 0 to RESTResponse1.JSONValue.GetValue<Integer>('cnt')-1 do
       begin

           NewItem := ListViewForecast.Items.Add;
           var strdt := RESTResponse1.JSONValue.GetValue<String>('list['+i.ToString+'].dt_txt');
           NewItem.Text:=strdt.Remove(Length(strdt)-3);    //Substring(0,Length(strdt)-3);
           NewItem.Detail:=FormatFloat('#0.0',RoundTo(RESTResponse1.JSONValue.GetValue<Double>('list['+i.ToString+'].main.temp'),-1))+
              ' ºC - '+ RESTResponse1.JSONValue.GetValue<String>('list['+i.ToString+'].weather[0].description');
           NewItem.TagString := 'http://openweathermap.org/img/wn/'+RESTResponse1.JSONValue.GetValue<String>('list['+i.ToString+'].weather[0].icon')+'@2x.png';
           //NewItem.Bitmap.LoadFromURL('http://openweathermap.org/img/wn/'+RESTResponse1.JSONValue.GetValue<String>('list['+i.ToString+'].weather[0].icon')+'@2x.png');

       end;
        ListViewForecastScrollViewChange(ListViewForecast);
        LabelTitle.Text := 'Moja pogoda ('+DateTimeToStr(Now)+')';
      end;

    end
    ,True, True
    ,
    procedure(Exception : TObject)
    begin
      FPogodaMain.AniIndicator1.Enabled := false;
      FPogodaMain.AniIndicator1.Visible := false;
      TimerUpdateWeather.Enabled := true;
      LabelTitle.Text := 'Moja pogoda';
      TDialogServiceAsync.ShowMessage('Sprawdź połączenie sieciowe!')

    end
  );
end;

{ TImageLoadURLExtension }

procedure TImageLoadURLExtension.LoadFromURL(const AUrl: string);
begin
  LoadBitmapHttpFromURL(AUrl, self);
end;

end.
