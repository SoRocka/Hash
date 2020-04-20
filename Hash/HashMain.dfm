object MainForm: TMainForm
  Left = 728
  Top = 122
  Width = 588
  Height = 391
  Caption = 'Hash-'#1058#1072#1073#1083#1080#1094#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object HashTableView: TStringGrid
    Left = 0
    Top = 0
    Width = 572
    Height = 332
    Align = alClient
    ColCount = 4
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goRowMoving, goColMoving]
    TabOrder = 0
  end
  object MainMenu: TMainMenu
    Left = 488
    Top = 96
    object mniN1: TMenuItem
      Caption = #1060#1072#1081#1083
      object NNew: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100
        OnClick = NNewClick
      end
      object NOpen: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        OnClick = NOpenClick
      end
      object NSave: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        OnClick = NSaveClick
      end
      object NSaveAs: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
        OnClick = NSaveAsClick
      end
      object NClose: TMenuItem
        Caption = #1047#1072#1082#1088#1099#1090#1100
        OnClick = NCloseClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object NExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
      end
    end
    object mniN2: TMenuItem
      Caption = #1055#1088#1072#1074#1082#1072
      object NAdd: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        OnClick = NAddClick
      end
      object NDelete: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100
        OnClick = NDeleteClick
      end
      object NClear: TMenuItem
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100
        OnClick = NClearClick
      end
    end
    object N1: TMenuItem
      Caption = #1055#1086#1080#1089#1082
      object NFind: TMenuItem
        Caption = #1053#1072#1081#1090#1080
        OnClick = NFindClick
      end
    end
  end
  object dlgOpen: TOpenDialog
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' *.txt|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*'
    Left = 448
    Top = 96
  end
  object dlgSave: TSaveDialog
    Filter = #1058#1077#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' *.txt|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*'
    Left = 408
    Top = 96
  end
end
