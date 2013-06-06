object Form12: TForm12
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1086#1080#1089#1082
  ClientHeight = 111
  ClientWidth = 375
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
  object Label1: TLabel
    Left = 15
    Top = 16
    Width = 35
    Height = 13
    Caption = #1053#1072#1081#1090#1080':'
  end
  object Label2: TLabel
    Left = 15
    Top = 44
    Width = 36
    Height = 13
    Caption = #1043#1088#1072#1092#1072':'
  end
  object Edit1: TEdit
    Left = 66
    Top = 13
    Width = 197
    Height = 21
    TabOrder = 0
    OnKeyPress = Edit1KeyPress
  end
  object Button1: TButton
    Left = 269
    Top = 11
    Width = 88
    Height = 26
    Caption = #1053#1072#1081#1090#1080' '#1076#1072#1083#1077#1077
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 269
    Top = 43
    Width = 88
    Height = 25
    Caption = #1053#1072#1081#1090#1080' '#1074#1089#1105
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 269
    Top = 74
    Width = 88
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = Button3Click
  end
  object ComboBox1: TComboBox
    Left = 66
    Top = 40
    Width = 197
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 4
    Text = '('#1042#1089#1077')'
    OnClick = ComboBox1Click
    Items.Strings = (
      '('#1042#1089#1077')'
      #1055#1091#1090#1100' '#1082' '#1092#1072#1081#1083#1091
      #1060#1072#1081#1083
      #1056#1072#1079#1084#1077#1088' ('#1041#1072#1081#1090')'
      'MD5'
      'CRC32'
      #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103)
  end
end
