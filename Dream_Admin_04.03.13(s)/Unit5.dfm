object Form5: TForm5
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1086#1080#1089#1082
  ClientHeight = 130
  ClientWidth = 382
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel1: TsLabel
    Left = 15
    Top = 17
    Width = 35
    Height = 13
    Caption = #1053#1072#1081#1090#1080':'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5059883
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object sLabel2: TsLabel
    Left = 15
    Top = 43
    Width = 36
    Height = 13
    Caption = #1043#1088#1072#1092#1072':'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5059883
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object sButton1: TsButton
    Left = 276
    Top = 12
    Width = 88
    Height = 25
    Caption = #1053#1072#1081#1090#1080' '#1076#1072#1083#1077#1077
    TabOrder = 0
    OnClick = sButton1Click
    SkinData.SkinSection = 'BUTTON'
  end
  object sButton2: TsButton
    Left = 276
    Top = 43
    Width = 88
    Height = 25
    Caption = #1053#1072#1081#1090#1080' '#1074#1089#1077
    TabOrder = 1
    OnClick = sButton2Click
    SkinData.SkinSection = 'BUTTON'
  end
  object sButton3: TsButton
    Left = 276
    Top = 74
    Width = 88
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = sButton3Click
    SkinData.SkinSection = 'BUTTON'
  end
  object sEdit1: TsEdit
    Left = 66
    Top = 13
    Width = 197
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnKeyPress = sEdit1KeyPress
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
  end
  object sComboBox1: TsComboBox
    Left = 66
    Top = 40
    Width = 197
    Height = 21
    Alignment = taLeftJustify
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'COMBOBOX'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 15
    ItemIndex = 0
    ParentFont = False
    TabOrder = 4
    Text = '('#1042#1089#1077')'
    OnClick = sComboBox1Click
    Items.Strings = (
      '('#1042#1089#1077')'
      #1055#1091#1090#1100' '#1082' '#1092#1072#1081#1083#1091
      #1060#1072#1081#1083
      #1056#1072#1079#1084#1077#1088' ('#1041#1072#1081#1090')'
      'MD5'
      'CRC32'
      #1056#1072#1079#1088#1077#1096#1077#1085#1086' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100)
  end
end
