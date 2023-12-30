object FPogodaDemoMain: TFPogodaDemoMain
  Left = 0
  Top = 0
  Caption = 'Pogoda Demo'
  ClientHeight = 592
  ClientWidth = 826
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 401
    Top = 0
    Width = 5
    Height = 592
    Color = clLightgray
    ParentColor = False
    StyleElements = [seFont, seBorder]
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 401
    Height = 592
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      401
      592)
    object LabelTempCurr: TLabel
      Left = 136
      Top = 80
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
    object LabelPressureCurr: TLabel
      Left = 136
      Top = 99
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
    object LabelDescCurr: TLabel
      Left = 136
      Top = 118
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
    object Panel1: TPanel
      Left = 42
      Top = 80
      Width = 68
      Height = 57
      BevelOuter = bvNone
      Caption = 'Panel1'
      Color = clWhite
      ParentBackground = False
      ShowCaption = False
      TabOrder = 0
      StyleElements = [seFont, seBorder]
      object ImageWeatherCurr: TImage
        Left = 0
        Top = 0
        Width = 68
        Height = 57
        Align = alClient
        AutoSize = True
        Proportional = True
        Stretch = True
        ExplicitLeft = 97
        ExplicitTop = 30
        ExplicitWidth = 183
        ExplicitHeight = 91
      end
    end
    object ButtonRefresh: TButton
      Left = 361
      Top = 15
      Width = 32
      Height = 33
      Anchors = [akTop, akRight]
      Caption = #10227
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = ButtonRefreshClick
    end
    object EditSearch: TEdit
      Left = 10
      Top = 15
      Width = 345
      Height = 33
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'Bytom'
      OnChange = EditSearchChange
    end
    object ControlList1: TControlList
      Left = 0
      Top = 176
      Width = 401
      Height = 416
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemMargins.Left = 0
      ItemMargins.Top = 0
      ItemMargins.Right = 0
      ItemMargins.Bottom = 0
      ItemSelectionOptions.HotColorAlpha = 50
      ItemSelectionOptions.SelectedColorAlpha = 70
      ItemSelectionOptions.FocusedColorAlpha = 80
      ParentColor = False
      TabOrder = 3
      OnBeforeDrawItem = ControlList1BeforeDrawItem
      object LabelListDesc: TLabel
        AlignWithMargins = True
        Left = 83
        Top = 41
        Width = 270
        Height = 14
        Margins.Left = 10
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight, akBottom]
        AutoSize = False
        Caption = 
          'This is example of item with multi-line text. You can put any TG' +
          'raphicControl on it and adjust properties.'
        EllipsisPosition = epEndEllipsis
        ShowAccelChar = False
        Transparent = True
        ExplicitWidth = 254
      end
      object LabelListTemp: TLabel
        Left = 82
        Top = 23
        Width = 32
        Height = 13
        Caption = 'Temp'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object ControlListButtonDetails: TControlListButton
        AlignWithMargins = True
        Left = 365
        Top = 20
        Width = 30
        Height = 30
        Margins.Left = 2
        Margins.Top = 20
        Margins.Right = 2
        Margins.Bottom = 20
        Align = alRight
        Caption = '>'
        Style = clbkToolButton
        OnClick = ControlListButtonDetailsClick
        ExplicitLeft = 341
      end
      object ImageWeather: TImage
        Left = 8
        Top = 8
        Width = 68
        Height = 57
        Proportional = True
        Stretch = True
      end
      object LabelListDateTime: TLabel
        Left = 82
        Top = 4
        Width = 26
        Height = 13
        Caption = 'Temp'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
    end
    object MemoHTML: TMemo
      Left = 189
      Top = 78
      Width = 206
      Height = 91
      Lines.Strings = (
        '<!DOCTYPE html>'
        '<html>'
        '<head>'
        #9'<title>Mapa</title>'
        ''
        #9'<meta charset="utf-8" />'
        
          #9'<link rel="stylesheet" href="https://unpkg.com/leaflet@1.5.1/di' +
          'st/leaflet.css"'
        
          '   integrity="sha512-xwE/Az9zrjBIphAcBb3F6JVqxf46+CDLwfLMHloNu6K' +
          'EQCAWi6HcDUbeOfBIptF7tcCzusKFjFw2yuvEpDL9wQ=="'
        '   crossorigin=""/>'
        '   '
        '   <script src="https://unpkg.com/leaflet@1.5.1/dist/leaflet.js"'
        
          '   integrity="sha512-GffPMF3RvMeYyc1LWMHtK8EbPv0iNZ8/oTtHPx9/cc2' +
          'ILxQ+u905qIwdpULaqDkyBKgOaB57QTMg7ztg8Jm2Og=="'
        '   crossorigin=""></script>'
        '<style>'
        '    body {'
        '      padding: 0;'
        '      margin: 0;'
        '    }'
        '    html, body, #map {'
        '      height: 100%;'
        '      width: 100%;'
        '    }'
        '  </style></head>'
        '<body>'
        #9'<div id="map"></div>'
        ''
        #9'<script type="text/javascript">'
        #9'    var lat = <lat>;'
        #9#9'var lon = <lon>;'
        
          '        var mymap = L.map('#39'map'#39',{ zoomControl: false }).setView(' +
          '[lat,lon], <scale>);'
        
          #9#9'L.tileLayer('#39'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png' +
          #39', {'
        #9#9'maxZoom: 18,'
        
          #9#9'attribution: '#39'Map data &copy; <a href="https://www.openstreetm' +
          'ap.org/">OpenStreetMap</a> contributors, '#39' +'
        
          #9#9#9#39'<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC' +
          '-BY-SA</a> '#39
        #9'}).addTo(mymap);'
        #9'    var marker = L.marker([lat, lon]).addTo(mymap);'
        #9'</script>'
        '</body>'
        '</html>')
      TabOrder = 4
      Visible = False
      WordWrap = False
    end
  end
  object RelativePanel1: TRelativePanel
    Left = 406
    Top = 0
    Width = 420
    Height = 592
    ControlCollection = <
      item
        Control = LabelTempMax
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = True
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
        Below = LabelTempMin
      end
      item
        Control = LabelTempMin
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = True
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
        Below = WebBrowserMap
      end
      item
        Control = WebBrowserMap
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = True
        AlignRightWithPanel = True
        AlignTopWithPanel = True
        AlignVerticalCenterWithPanel = False
      end
      item
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
      end
      item
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
      end
      item
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
      end
      item
        Control = LabelHum
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = True
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
        Below = LabelTempMax
      end
      item
        Control = LabelPre
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = True
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
        Below = LabelHum
      end
      item
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
      end
      item
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
      end
      item
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
      end
      item
        Control = EdgeBrowserMap
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = True
        AlignRightWithPanel = True
        AlignTopWithPanel = True
        AlignVerticalCenterWithPanel = False
      end
      item
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
      end
      item
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
      end
      item
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
      end>
    Align = alClient
    TabOrder = 1
    DesignSize = (
      420
      592)
    object LabelTempMax: TLabel
      AlignWithMargins = True
      Left = 173
      Top = 416
      Width = 71
      Height = 13
      Margins.Bottom = 30
      Anchors = []
      Caption = 'LabelTempMax'
    end
    object LabelTempMin: TLabel
      AlignWithMargins = True
      Left = 175
      Top = 370
      Width = 67
      Height = 13
      Margins.Bottom = 30
      Anchors = []
      Caption = 'LabelTempMin'
    end
    object WebBrowserMap: TWebBrowser
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 412
      Height = 333
      Margins.Bottom = 30
      Anchors = []
      TabOrder = 0
      ControlData = {
        4C000000952A00006B2200000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E12620A000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
    object LabelHum: TLabel
      AlignWithMargins = True
      Left = 186
      Top = 462
      Width = 46
      Height = 13
      Margins.Bottom = 30
      Anchors = []
      Caption = 'LabelHum'
    end
    object LabelPre: TLabel
      AlignWithMargins = True
      Left = 186
      Top = 508
      Width = 46
      Height = 13
      Anchors = []
      Caption = 'LabelPres'
    end
    object EdgeBrowserMap: TEdgeBrowser
      Left = 1
      Top = 1
      Width = 418
      Height = 344
      Anchors = []
      TabOrder = 1
      AllowSingleSignOnUsingOSPrimaryAccount = False
      TargetCompatibleBrowserVersion = '117.0.2045.28'
      UserDataFolder = '%LOCALAPPDATA%\bds.exe.WebView2'
    end
  end
  object ActivityIndicator1: TActivityIndicator
    Left = 361
    Top = 16
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://api.openweathermap.org'
    Params = <>
    SynchronizedEvents = False
    Left = 32
    Top = 80
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        Name = 'q'
        Value = 'Gliwice'
      end
      item
        Kind = pkURLSEGMENT
        Name = 'r'
        Options = [poAutoCreated]
      end>
    Resource = 
      'data/2.5/forecast?q={q}&units=metric&APPID=KLUCZ_Z_OPENWEATHER' +
      'ccca0164f89&lang=pl&rnd={r}'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 40
    Top = 136
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 40
    Top = 208
  end
  object RESTClient2: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://api.openweathermap.org'
    Params = <>
    SynchronizedEvents = False
    Left = 24
    Top = 280
  end
  object RESTRequest2: TRESTRequest
    Client = RESTClient2
    Params = <
      item
        Kind = pkURLSEGMENT
        Name = 'q'
        Value = 'Krak'#243'w'
      end
      item
        Kind = pkURLSEGMENT
        Name = 'r'
        Options = [poAutoCreated]
      end>
    Resource = 
      'data/2.5/weather?q={q}&units=metric&APPID=KLUCZ_Z_OPENWEATHER' +
      'cca0164f89&lang=pl&rnd={r}'
    Response = RESTResponse2
    SynchronizedEvents = False
    Left = 32
    Top = 336
  end
  object RESTResponse2: TRESTResponse
    ContentType = 'application/json'
    Left = 32
    Top = 408
  end
  object TimerTyping: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerTypingTimer
    Left = 280
    Top = 16
  end
  object ApplicationEvents1: TApplicationEvents
    OnSettingChange = ApplicationEvents1SettingChange
    Left = 184
    Top = 56
  end
end
