object Frm_LableGroup: TFrm_LableGroup
  Left = 438
  Top = 114
  Width = 474
  Height = 400
  Caption = 'Frm_LableGroup'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object RzGroupBox1: TRzGroupBox
    Left = 0
    Top = 0
    Width = 458
    Height = 297
    Align = alTop
    Caption = #22810#21495#27573#24405#20837
    TabOrder = 0
    object stg_LableGroup: Ti_StgEdit
      Left = 1
      Top = 14
      Width = 456
      Height = 282
      Align = alClient
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
      TabOrder = 0
      OnSelectCell = stg_LableGroupSelectCell
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
  end
  object btn_ok: TButton
    Left = 80
    Top = 320
    Width = 75
    Height = 25
    Caption = #30830#35748
    TabOrder = 1
    OnClick = btn_okClick
  end
  object btn_close: TButton
    Left = 264
    Top = 320
    Width = 75
    Height = 25
    Caption = #20851#38381
    ModalResult = 2
    TabOrder = 2
  end
  object edt_Temp: TEdit
    Left = 136
    Top = 248
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'edt_Temp'
  end
end
