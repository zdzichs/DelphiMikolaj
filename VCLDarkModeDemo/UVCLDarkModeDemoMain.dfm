object FVCLDarkModeDemoMain: TFVCLDarkModeDemoMain
  Left = 0
  Top = 0
  Caption = 'FVCLDarkModeDemoMain'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object ComboBox1: TComboBox
    Left = 56
    Top = 48
    Width = 145
    Height = 23
    Style = csDropDownList
    ItemIndex = 2
    TabOrder = 0
    Text = 'Systemowy'
    OnChange = ComboBox1Change
    Items.Strings = (
      'Ciemny'
      'Jasny'
      'Systemowy')
  end
  object Panel1: TPanel
    Left = 56
    Top = 152
    Width = 185
    Height = 153
    Caption = 'Panel styl systemu'
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 312
    Top = 152
    Width = 185
    Height = 153
    Caption = 'Panel w'#322'asny kolor'
    TabOrder = 2
    StyleElements = [seFont, seBorder]
  end
  object ApplicationEvents1: TApplicationEvents
    OnSettingChange = ApplicationEvents1SettingChange
    Left = 512
    Top = 40
  end
end
