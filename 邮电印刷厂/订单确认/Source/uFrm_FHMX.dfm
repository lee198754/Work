object Frm_FHMX: TFrm_FHMX
  Left = 313
  Top = 81
  Width = 786
  Height = 428
  Caption = #21457#36135#26126#32454
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
  object stg_fhmx: Ti_StgEdit
    Left = 0
    Top = 0
    Width = 770
    Height = 336
    Align = alClient
    ColCount = 7
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
    OnLinkClick = stg_fhmxLinkClick
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
    FormatString = #20135#21697#32534#21495'|'#21457#36135#21333#21495'|'#25171#21333#26085#26399'|'#21457#36135#26041#24335'|'#21457#36816#21333#21495'|'#21457#36135#25968#37327'|'#21457#36135#20154
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
      120
      120
      88
      141
      65
      64)
    RowHeights = (
      20
      20)
  end
  object RzGroupBox1: TRzGroupBox
    Left = 0
    Top = 336
    Width = 770
    Height = 54
    Align = alBottom
    Caption = #32479#35745
    TabOrder = 1
    object lab_yfhzl: Ti_Label
      Left = 114
      Top = 24
      Width = 6
      Height = 12
      Caption = '0'
      EditLabel.Width = 72
      EditLabel.Height = 12
      EditLabel.Caption = #24050#21457#36135#24635#37327#65306
      EditLabel.Transparent = True
      LabelCaption = #24050#21457#36135#24635#37327#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
    end
    object lab_sykc: Ti_Label
      Left = 343
      Top = 24
      Width = 6
      Height = 12
      Caption = '0'
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #21097#20313#24211#23384#65306
      EditLabel.Transparent = True
      LabelCaption = #21097#20313#24211#23384#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
    end
    object lab_wfhzl: Ti_Label
      Left = 596
      Top = 24
      Width = 6
      Height = 12
      Caption = '0'
      EditLabel.Width = 72
      EditLabel.Height = 12
      EditLabel.Caption = #26410#21457#36135#24635#37327#65306
      EditLabel.Transparent = True
      LabelCaption = #26410#21457#36135#24635#37327#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
    end
  end
end
