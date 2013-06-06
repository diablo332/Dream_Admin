object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 412
  ClientWidth = 423
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object TreeView1: TTreeView
    Left = 17
    Top = 24
    Width = 121
    Height = 337
    Indent = 19
    TabOrder = 0
    OnClick = TreeView1Click
    Items.NodeData = {
      0101000000210000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      00042104350442044C04}
  end
  object GroupBox1: TGroupBox
    Left = 160
    Top = 32
    Width = 239
    Height = 145
    Caption = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103' '#1089#1077#1090#1080':'
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 35
      Width = 68
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1087#1086#1088#1090#1072':'
    end
    object Label2: TLabel
      Left = 128
      Top = 112
      Width = 91
      Height = 13
      Caption = #1057#1077#1088#1074#1077#1088' '#1086#1090#1082#1083#1102#1095#1077#1085
    end
    object Edit1: TEdit
      Left = 101
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 0
      Text = '5555'
      OnKeyPress = Edit1KeyPress
    end
    object Button1: TButton
      Left = 16
      Top = 72
      Width = 104
      Height = 25
      Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1089#1077#1088#1074#1077#1088
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 136
      Top = 72
      Width = 75
      Height = 25
      Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object Button3: TButton
    Left = 324
    Top = 368
    Width = 75
    Height = 25
    Caption = #1053#1072#1079#1072#1076
    TabOrder = 2
    OnClick = Button3Click
  end
end
