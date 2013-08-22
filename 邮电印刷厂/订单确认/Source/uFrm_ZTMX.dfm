object Frm_ZTMX: TFrm_ZTMX
  Left = 393
  Top = 159
  Width = 716
  Height = 390
  Caption = 'Frm_ZTMX'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object stg_ztmx: Ti_StgEdit
    Left = 0
    Top = 0
    Width = 700
    Height = 298
    Align = alClient
    ColCount = 4
    DefaultRowHeight = 20
    FixedCols = 0
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #26032#23435#20307
    Font.Style = []
    Options = [goRangeSelect, goRowSizing, goColSizing]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    pt_TitleHeight = 20
    FixedFontStyle = []
    RowSelect = False
    FocusColor = clBlack
    RowSelectColor = clGrayText
    RowSelect_TextColor_Highlight = True
    AutoUpdate = True
    Merge_FixedRow = True
    Merge_FixedCol = False
    Merge_Cell = False
    FixedFontSize = 9
    FixedFontName = #23435#20307
    FixedGridLineColor = clBlack
    GridLinesFixed = PGridInset
    FormatString = #20135#21697#32534#21495'|'#29366#24577'|'#25805#20316#20154'|'#25805#20316#26102#38388
    FixedWordBreak = True
    PermitCellSizing = False
    PermitExport = True
    WordBreak = False
    FixedRowAlignmentCenter = True
    ZeroToEmpty = True
    KeepEdit = False
    EnterAddRow = False
    ColWidths = (
      162
      92
      91
      178)
    RowHeights = (
      20
      20)
  end
  object RzGroupBox1: TRzGroupBox
    Left = 0
    Top = 298
    Width = 700
    Height = 54
    Align = alBottom
    Caption = #32479#35745
    TabOrder = 1
    object lab_wkdyl: Ti_Label
      Left = 365
      Top = 24
      Width = 6
      Height = 12
      Caption = '0'
      EditLabel.Width = 96
      EditLabel.Height = 12
      EditLabel.Caption = #26410#24320#21333#21360#37327'('#26522')'#65306
      EditLabel.Transparent = True
      LabelCaption = #26410#24320#21333#21360#37327'('#26522')'#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
    end
    object lab_ykdyl: Ti_Label
      Left = 135
      Top = 24
      Width = 6
      Height = 12
      Caption = '0'
      EditLabel.Width = 96
      EditLabel.Height = 12
      EditLabel.Caption = #24050#24320#21333#21360#37327'('#26522')'#65306
      EditLabel.Transparent = True
      LabelCaption = #24050#24320#21333#21360#37327'('#26522')'#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
    end
    object lab_zyl: Ti_Label
      Left = 604
      Top = 24
      Width = 6
      Height = 12
      Caption = '0'
      EditLabel.Width = 72
      EditLabel.Height = 12
      EditLabel.Caption = #24635#21360#37327'('#26522')'#65306
      EditLabel.Transparent = True
      LabelCaption = #24635#21360#37327'('#26522')'#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
    end
  end
end
