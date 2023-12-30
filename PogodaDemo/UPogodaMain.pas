unit UPogodaMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ControlList,
  Vcl.VirtualImage, System.Generics.Collections, XML.XMLDoc, Xml.XMLIntf,
  Vcl.ExtCtrls, System.Net.HttpClientComponent, System.Net.URLClient,
  System.Net.HttpClient, pngimage, jpeg, GIFImg, Vcl.OleCtrls, SHDocVw,
  WebView2, Winapi.ActiveX, Vcl.Edge, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,
  IdHashMessageDigest,idHash, Vcl.WinXCtrls, System.Math,
  System.NetEncoding, IdGlobal, System.StrUtils, Vcl.AppEvnts;
 //TNetEncoding.URL.EncodeQuery(
type

  TWeatherItem = class
    FDateTime  : String;
    FTemp      : String;
    FImage     : TImage;
    FDesc      : String;
    FTempMin   : String;
    FTempMax   : String;
    FHumidity  : String;
    FPressure  : String;
    public
     constructor Create;
     destructor Destroy;override;
  end;

  TControlList = class (Vcl.ControlList.TControlList)
   public
    FWeatherList : TObjectList<TWeatherItem>;
  end;

  TThemeType = (ttDark, ttLight, ttSystem);

  TFPogodaDemoMain = class(TForm)
    ControlList1: TControlList;
    LabelListDesc: TLabel;
    LabelListTemp: TLabel;
    ControlListButtonDetails: TControlListButton;
    ImageWeather: TImage;
    WebBrowserMap: TWebBrowser;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTClient2: TRESTClient;
    RESTRequest2: TRESTRequest;
    RESTResponse2: TRESTResponse;
    LabelListDateTime: TLabel;
    LabelTempMin: TLabel;
    LabelTempMax: TLabel;
    Panel2: TPanel;
    Panel1: TPanel;
    ImageWeatherCurr: TImage;
    LabelTempCurr: TLabel;
    LabelPressureCurr: TLabel;
    LabelDescCurr: TLabel;
    ButtonRefresh: TButton;
    EditSearch: TEdit;
    Splitter1: TSplitter;
    RelativePanel1: TRelativePanel;
    LabelHum: TLabel;
    LabelPre: TLabel;
    MemoHTML: TMemo;
    TimerTyping: TTimer;
    EdgeBrowserMap: TEdgeBrowser;
    ActivityIndicator1: TActivityIndicator;
    ApplicationEvents1: TApplicationEvents;
    procedure ButtonRefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ControlList1BeforeDrawItem(AIndex: Integer; ACanvas: TCanvas;
      ARect: TRect; AState: TOwnerDrawState);
    procedure ControlListButton1Click(Sender: TObject);
    procedure ControlListButtonDetailsClick(Sender: TObject);
    procedure UpdateWeather;
    procedure EditSearchChange(Sender: TObject);
    procedure TimerTypingTimer(Sender: TObject);
    procedure SetTheme(AThemeType : TThemeType);
    procedure ApplicationEvents1SettingChange(Sender: TObject; Flag: Integer;
      const Section: string; var Result: LongInt);
  private
    { Private declarations }
    Flat, FLon : String;
  public
    { Public declarations }
  end;

 TImageLoadURLExtension = class helper for TImage
    procedure LoadFromURL(const AUrl: string;
       const AActIndicator: TActivityIndicator = nil;
       AControlList: TControlList = nil; AIdx : Integer = -1);
  end;



var
  FPogodaDemoMain: TFPogodaDemoMain;
  WeatherList : TObjectList<TWeatherItem>;
  doktresc : String;

implementation

{$R *.dfm}

uses
 System.Win.Registry, Vcl.Themes;

const
 DarkStyleName = 'Windows11 Modern Dark';
 LightStyleName = 'Windows11 Modern Light';

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

procedure TFPogodaDemoMain.SetTheme(AThemeType : TThemeType);
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

//  if TargetThemeName = LightStyleName then
//   Panel2.Color := clLime
//  else
//   Panel2.Color := clGreen;
  TStyleManager.TrySetStyle( TargetThemeName );
end;

procedure TFPogodaDemoMain.ApplicationEvents1SettingChange(Sender: TObject;
  Flag: Integer; const Section: string; var Result: LongInt);
begin
  if SameText( 'ImmersiveColorSet', Section ) then
    SetTheme( ttSystem );
end;



procedure VclLoadImageHttpFromURL
    (const url: string; const img: TImage;
     const AActIndicator : TActivityIndicator = nil;
     AControlList: TControlList = nil; AIdx : Integer = -1);

begin
  TThread.CreateAnonymousThread(
      procedure()
      var
          HTTP: TNetHTTPClient;
          ms: TStream;
          FirstBytes: AnsiString;
          Graphic: Vcl.Graphics.TGraphic;
          bm: Vcl.Graphics.TBitmap;
      begin
          HTTP := TNetHTTPClient.Create(nil);
          Http.UserAgent:='Mozilla/3.0 (compatible; zdzichs)';
          try
            bm := Vcl.Graphics.TBitmap.Create;
            ms := TMemoryStream.Create;
            try
              //Sleep(Random(5000));  //wyrzucić!!!
              HTTP.Get(url, ms);
              ms.Position := 0;
              SetLength(FirstBytes, 8);
              ms.Read(FirstBytes[1], 8);

              if Copy(FirstBytes, 1, 2) = 'BM' then
              begin
                Graphic := Vcl.Graphics.TBitmap.Create;
              end else
              if FirstBytes = #137'PNG'#13#10#26#10 then
              begin
                Graphic := TPNGImage.Create;
              end else
              if Copy(FirstBytes, 1, 3) =  'GIF' then
              begin
                Graphic := TGIFImage.Create;
              end else
              if Copy(FirstBytes, 1, 2) = #$FF#$D8 then
              begin
                Graphic := TJPEGImage.Create;
              end;

              if Assigned(Graphic) then
              begin
                try
//                  ms.Seek(0, soFromBeginning);
//                  Graphic.LoadFromStream(ms);
//                  bm.Assign(Graphic);
                  TThread.Synchronize(TThread.CurrentThread,
                    procedure ()
                    begin
                       ms.Seek(0, soFromBeginning);
                       Graphic.LoadFromStream(ms);
                       bm.Assign(Graphic);
                       img.Picture.Assign(bm);
                       if Assigned(AControlList) and (AIdx >= 0) then
                             AControlList.UpdateItem(AIdx);
                       if Assigned( AActIndicator ) then
                       begin
                        AActIndicator.Animate := false;
                        AActIndicator.Visible := false;
                       end;
                    end
                  );


                except
                end;
                Graphic.Free;
              end;
            finally
              ms.Free;
              bm.Free;
            end
          finally
            HTTP.Free
          end;
      end).Start;
end;





{ TImageLoadURLExtension }

procedure TImageLoadURLExtension.LoadFromURL(const AUrl: string;
  const AActIndicator: TActivityIndicator = nil;
  AControlList: TControlList = nil; AIdx : Integer = -1);
begin
  VclLoadImageHttpFromURL(AUrl, self, AActIndicator, AControlList, AIdx);
end;


procedure TFPogodaDemoMain.ButtonRefreshClick(Sender: TObject);
begin
  UpdateWeather;
end;


procedure TFPogodaDemoMain.ControlList1BeforeDrawItem(AIndex: Integer;
  ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
begin
 LabelListTemp.Caption := ControlList1.FWeatherList[AIndex].FTemp;
 LabelListDateTime.Caption := ControlList1.FWeatherList[AIndex].FDateTime;
 LabelListDesc.Caption := ControlList1.FWeatherList[AIndex].FDesc;
 ImageWeather.Picture.Assign(ControlList1.FWeatherList[AIndex].FImage.Picture);
end;

procedure TFPogodaDemoMain.ControlListButton1Click(Sender: TObject);
begin
 //showmessage(ControlList1.FNewsList[ControlList1.ItemIndex].Komunikat);
end;

procedure WBLoadHTML(WebBrowser: TWebBrowser; HTMLCode: string) ;
var
   sl: TStringList;
   ms: TMemoryStream;
begin
   WebBrowser.Navigate('about:blank') ;
   while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

   if Assigned(WebBrowser.Document) then
   begin
     sl := TStringList.Create;
     try
       ms := TMemoryStream.Create;
       try
         sl.Text := HTMLCode;
         sl.SaveToStream(ms, TEncoding.UTF8) ;
         ms.Seek(0, 0) ;
         (WebBrowser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(ms)) ;
       finally
         ms.Free;
       end;
     finally
       sl.Free;
     end;
   end;
end;


procedure TFPogodaDemoMain.ControlListButtonDetailsClick(Sender: TObject);
begin
  LabelTempMin.Caption := 'Temp. Min. = ' + ControlList1.FWeatherList[ControlList1.ItemIndex].FTempMin;
  LabelTempMax.Caption := 'Temp. Max. = ' + ControlList1.FWeatherList[ControlList1.ItemIndex].FTempMax;
  LabelHum.Caption := 'Wilgotność = ' + ControlList1.FWeatherList[ControlList1.ItemIndex].FHumidity;
  LabelPre.Caption := 'Ciśnienie = ' + ControlList1.FWeatherList[ControlList1.ItemIndex].FPressure;

 var LMapsHTML := ReplaceStr(MemoHTML.Text,'<lat>',Flat);
 LMapsHTML := ReplaceStr(LMapsHTML,'<lon>',Flon);
 LMapsHTML := ReplaceStr(LMapsHTML,'<scale>',IntToStr(15));
 WBLoadHTML(WebBrowserMap, LMapsHTML) ;
 EdgeBrowserMap.NavigateToString(LMapsHTML);
end;

procedure TFPogodaDemoMain.EditSearchChange(Sender: TObject);
begin
   TimerTyping.Enabled:=false;
   TimerTyping.Interval:=1200;
   TimerTyping.Enabled:=true;

end;

procedure TFPogodaDemoMain.FormCreate(Sender: TObject);
begin
 SetTheme( ttSystem );
 WeatherList := TObjectList<TWeatherItem>.Create(true);
 ControlList1.FWeatherList := WeatherList;
 UpdateWeather;
 EdgeBrowserMap.Navigate('about:blank');
end;

procedure TFPogodaDemoMain.FormDestroy(Sender: TObject);
begin
 WeatherList.Free;
end;


procedure TFPogodaDemoMain.TimerTypingTimer(Sender: TObject);
begin
 UpdateWeather;
end;

{ TNewsItem }

constructor TWeatherItem.Create;
begin
 Inherited;
 FImage := TImage.Create(nil);
end;

destructor TWeatherItem.Destroy;
begin
 FImage.Free;
 Inherited;
end;


function dajkod: String;
var
 idmd5 : TIdHashMessageDigest5;
 kod   : String;
begin
  kod := '';
  idmd5 := TIdHashMessageDigest5.Create;
  try
    kod := idmd5.HashStringAsHex(DateTimeToStr(Now), IndyTextEncoding_UTF8);
  finally
    idmd5.Free;
  end;
  result := kod;
end;

procedure TFPogodaDemoMain.UpdateWeather;
begin
  TimerTyping.Enabled := false;

  WeatherList.Clear;
  ControlList1.ItemCount := 0;
  ControlList1.Refresh;
  LabelTempCurr.Caption:= '';
  LabelPressureCurr.Caption:= '';
  LabelDescCurr.Caption:= '';

  ActivityIndicator1.Animate:=true;
  ActivityIndicator1.Visible:=true;
  ButtonRefresh.Visible := false;

  RESTRequest1.Params[0].Value := EditSearch.Text;
  RESTRequest1.Params[1].Value := dajkod;
  RESTRequest2.Params[0].Value := EditSearch.Text;
  RESTRequest2.Params[1].Value := dajkod;
  //SaveConfig;
  Caption := 'Pogoda Demo ('+DateTimeToStr(Now)+')';
  RESTRequest2.ExecuteAsync(
    procedure()
    begin
      LabelTempCurr.Caption := RESTResponse2.JSONValue.GetValue<Double>('main.temp').ToString +' ºC';
      LabelPressureCurr.Caption := RESTResponse2.JSONValue.GetValue<Double>('main.pressure').ToString +' hPa';
      LabelDescCurr.Caption := RESTResponse2.JSONValue.GetValue<String>('weather[0].description');
      Flat := RESTResponse2.JSONValue.GetValue<String>('coord.lat');
      Flon := RESTResponse2.JSONValue.GetValue<String>('coord.lon');
      //ImageWeatherCurr.LoadFromURL('https://random.imagecdn.app/100/100');
      ImageWeatherCurr.LoadFromURL('http://openweathermap.org/img/wn/'+RESTResponse2.JSONValue.GetValue<String>('weather[0].icon')+'@2x.png?k='+dajkod());
    end
  );
  RESTRequest1.ExecuteAsync(
    procedure()
    var
     NewWeatherItem : TWeatherItem;
    begin
      ActivityIndicator1.Animate:=false;
      ActivityIndicator1.Visible:=false;
      ButtonRefresh.Visible := true;

      if RESTResponse1.StatusCode = 200 then
      begin
       for var i:= 0 to RESTResponse1.JSONValue.GetValue<Integer>('cnt')-1 do
       begin

           NewWeatherItem := TWeatherItem.Create;
           NewWeatherItem.FDateTime := RESTResponse1.JSONValue.GetValue<String>('list['+i.ToString+'].dt_txt');
           NewWeatherItem.FTemp := FormatFloat('#0.0',RoundTo(RESTResponse1.JSONValue.GetValue<Double>('list['+i.ToString+'].main.temp'),-1))+' ºC';
           NewWeatherItem.FTempMin := FormatFloat('#0.0',RoundTo(RESTResponse1.JSONValue.GetValue<Double>('list['+i.ToString+'].main.temp_min'),-1))+' ºC';
           NewWeatherItem.FTempMax := FormatFloat('#0.0',RoundTo(RESTResponse1.JSONValue.GetValue<Double>('list['+i.ToString+'].main.temp_max'),-1))+' ºC';
           NewWeatherItem.FHumidity := FormatFloat('#0.0',RoundTo(RESTResponse1.JSONValue.GetValue<Double>('list['+i.ToString+'].main.humidity'),-1))+' %';
           NewWeatherItem.FPressure := FormatFloat('#0.0',RoundTo(RESTResponse1.JSONValue.GetValue<Double>('list['+i.ToString+'].main.pressure'),-1))+' hPa';

           NewWeatherItem.FDesc := RESTResponse1.JSONValue.GetValue<String>('list['+i.ToString+'].weather[0].description');
           NewWeatherItem.FImage.LoadFromURL('http://openweathermap.org/img/wn/'+RESTResponse1.JSONValue.GetValue<String>('list['+i.ToString+'].weather[0].icon')+'@2x.png?k='+dajkod(), nil, ControlList1, i);
           //NewWeatherItem.FImage.LoadFromURL('https://random.imagecdn.app/100/100');
           WeatherList.Add(NewWeatherItem);
       end;
       ControlList1.ItemCount := WeatherList.Count;

      end;

    end
    ,True, True
    ,
    procedure(Exception : TObject)
    begin
      ActivityIndicator1.Animate:=false;
      ActivityIndicator1.Visible:=false;
      ButtonRefresh.Visible := true;
      Caption := 'Pogoda Demo';
      ShowMessage('Sprawdź połączenie sieciowe!')

    end
  );
end;





end.
