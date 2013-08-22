object Frm_SCGL_BFJC: TFrm_SCGL_BFJC
  Left = 448
  Top = 156
  Width = 606
  Height = 388
  Caption = #37096#20998#36827#20179
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    590
    350)
  PixelsPerInch = 96
  TextHeight = 12
  object Bevel1: TBevel
    Left = 8
    Top = 297
    Width = 573
    Height = 10
    Anchors = [akLeft, akTop, akRight]
    Shape = bsBottomLine
  end
  object btn_ok: TButton
    Left = 404
    Top = 314
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #30830#35748
    TabOrder = 0
    OnClick = btn_okClick
  end
  object btn_close: TButton
    Left = 500
    Top = 314
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #20851#38381
    ModalResult = 2
    TabOrder = 1
  end
  object stg_BFJC: Ti_StgEdit
    Left = 0
    Top = 0
    Width = 590
    Height = 294
    Align = alTop
    ColCount = 5
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
    TabOrder = 2
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
    FormatString = #20135#21697#32534#21495'|'#24320#21333#21360#37327'('#26522')|'#26410#36827#20179#21360#37327'('#26522')|'#26412#27425#36827#20179#21360#37327'('#26522')|'
    FixedWordBreak = True
    PermitCellSizing = False
    PermitExport = True
    WordBreak = False
    FixedRowAlignmentCenter = True
    ZeroToEmpty = True
    KeepEdit = False
    EnterAddRow = False
    ColWidths = (
      136
      92
      95
      103
      64)
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
    TabOrder = 3
    Text = 'edt_Temp'
  end
end
