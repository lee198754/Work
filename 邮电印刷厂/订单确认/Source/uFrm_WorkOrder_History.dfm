object Frm_WorkOrder_History: TFrm_WorkOrder_History
  Left = 403
  Top = 130
  Width = 409
  Height = 404
  Caption = #21382#21490#24037#21333
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
  object stg_HistoryList: Ti_StgEdit
    Left = 0
    Top = 0
    Width = 393
    Height = 366
    Align = alClient
    ColCount = 4
    DefaultRowHeight = 20
    FixedCols = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    Options = [goRangeSelect, goRowSizing, goColSizing]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    pt_TitleHeight = 20
    FixedFontStyle = []
    OnLinkClick = stg_HistoryListLinkClick
    RowSelect = True
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
    FormatString = #25805#20316#26102#38388'|'#25805#20316#20154'|'#25805#20316'|'
    FixedWordBreak = True
    PermitCellSizing = False
    PermitExport = True
    WordBreak = False
    FixedRowAlignmentCenter = True
    ZeroToEmpty = True
    KeepEdit = False
    EnterAddRow = False
    ColWidths = (
      121
      85
      50
      64)
    RowHeights = (
      20
      20)
  end
end
