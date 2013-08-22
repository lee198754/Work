object Frm_WorkOrder_RJHD: TFrm_WorkOrder_RJHD
  Left = 572
  Top = 104
  Width = 355
  Height = 391
  Caption = #22810#21495#27573#24405#20837
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    339
    353)
  PixelsPerInch = 96
  TextHeight = 12
  object Bevel1: TBevel
    Left = 8
    Top = 304
    Width = 323
    Height = 10
    Anchors = [akLeft, akTop, akRight]
    Shape = bsBottomLine
  end
  object btn_ok: TButton
    Left = 152
    Top = 320
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #30830#35748
    TabOrder = 0
    OnClick = btn_okClick
  end
  object btn_close: TButton
    Left = 248
    Top = 320
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #20851#38381
    ModalResult = 2
    TabOrder = 1
  end
  object stg_RJHD: Ti_StgEdit
    Left = 0
    Top = 0
    Width = 339
    Height = 294
    Align = alTop
    ColCount = 3
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
    TabOrder = 3
    OnSelectCell = stg_RJHDSelectCell
    pt_TitleHeight = 20
    FixedFontStyle = []
    RowSelect = False
    FocusColor = clBlack
    RowSelectColor = clHighlight
    RowSelect_TextColor_Highlight = True
    AutoUpdate = True
    Merge_FixedRow = True
    Merge_FixedCol = False
    Merge_Cell = False
    FixedFontSize = 9
    FixedFontName = #23435#20307
    FixedGridLineColor = clBlack
    GridLinesFixed = PGridInset
    FormatString = #32452#21495'|'#20817#22870#21495#27573#36215'|'#20817#22870#21495#27573#27490
    FixedWordBreak = True
    PermitCellSizing = False
    PermitExport = True
    WordBreak = False
    FixedRowAlignmentCenter = True
    ZeroToEmpty = True
    KeepEdit = False
    EnterAddRow = False
    ColWidths = (
      64
      111
      102)
    RowHeights = (
      20
      20)
  end
  object edt_Temp: TEdit
    Left = 160
    Top = 207
    Width = 121
    Height = 18
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
    Text = 'edt_Temp'
    OnExit = edt_TempExit
  end
end
