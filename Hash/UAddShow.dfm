object FormAdd: TFormAdd
  Left = 230
  Top = 129
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077
  ClientHeight = 379
  ClientWidth = 379
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_FIO: TLabel
    Left = 8
    Top = 24
    Width = 37
    Height = 19
    Caption = #1060#1048#1054
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl_StudNumb: TLabel
    Left = 8
    Top = 56
    Width = 59
    Height = 19
    Caption = #1053#1086#1084#1077#1088' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl_Name: TLabel
    Left = 8
    Top = 88
    Width = 63
    Height = 19
    Caption = #1054#1094#1077#1085#1082#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit_FIO: TEdit
    Left = 104
    Top = 24
    Width = 257
    Height = 21
    TabOrder = 0
    OnChange = Edit_Change
  end
  object Edit_StudNumber: TEdit
    Left = 104
    Top = 56
    Width = 257
    Height = 21
    TabOrder = 1
    OnChange = Edit_Change
  end
  object btn_Ok: TButton
    Left = 32
    Top = 336
    Width = 75
    Height = 25
    Caption = #1054#1050
    Default = True
    Enabled = False
    TabOrder = 2
    OnClick = btn_OkClick
  end
  object btn_Cancel: TButton
    Left = 264
    Top = 336
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object Edit_Mark: TEdit
    Left = 104
    Top = 88
    Width = 257
    Height = 21
    TabOrder = 4
    OnChange = Edit_Change
  end
end
