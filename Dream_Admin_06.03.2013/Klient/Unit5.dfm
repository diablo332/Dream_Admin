object Frame5: TFrame5
  Left = 0
  Top = 0
  Width = 394
  Height = 143
  Color = clCaptionText
  ParentColor = False
  TabOrder = 0
  TabStop = True
  object Label4: TLabel
    Left = 8
    Top = 98
    Width = 26
    Height = 13
    Caption = 'Host:'
  end
  object Label3: TLabel
    Left = 8
    Top = 66
    Width = 24
    Height = 13
    Caption = 'Port:'
  end
  object Label2: TLabel
    Left = 8
    Top = 34
    Width = 49
    Height = 13
    Caption = 'IP Server:'
  end
  object Button7: TButton
    Left = 198
    Top = 93
    Width = 145
    Height = 25
    Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103' '#1087#1086' host'
    TabOrder = 0
  end
  object Button6: TButton
    Left = 198
    Top = 61
    Width = 145
    Height = 25
    Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100#1089#1103
    TabOrder = 1
  end
  object Button5: TButton
    Left = 198
    Top = 29
    Width = 145
    Height = 25
    Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103' '#1087#1086' ip'
    TabOrder = 2
  end
  object Edit3: TEdit
    Left = 64
    Top = 95
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 64
    Top = 63
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '5555'
  end
  object Edit1: TEdit
    Left = 64
    Top = 31
    Width = 121
    Height = 21
    TabOrder = 5
    Text = '127.0.0.1'
    OnChange = Edit1Change
  end
end
