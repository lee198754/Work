object Frm_TSGYGL: TFrm_TSGYGL
  Left = 571
  Top = 217
  Width = 798
  Height = 664
  Caption = #29305#27530#24037#33402#31649#29702
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 49
    Width = 782
    Height = 577
    Align = alClient
    Caption = #32467#26524
    TabOrder = 0
    object stg_TSGY: Ti_StgEdit
      Left = 2
      Top = 15
      Width = 778
      Height = 560
      Align = alClient
      ColCount = 6
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
      OnLinkClick = stg_TSGYLinkClick
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
      FormatString = #29305#27530#24037#33402#32534#21495'|'#29305#27530#24037#33402#21517#31216'|'#29305#27530#24037#33402#21333#20215'|'#25805#20316'|'#25805#20316'|'
      FixedWordBreak = True
      PermitCellSizing = False
      PermitExport = True
      WordBreak = False
      FixedRowAlignmentCenter = True
      ZeroToEmpty = True
      KeepEdit = False
      EnterAddRow = False
      ColWidths = (
        87
        96
        103
        64
        64
        64)
      RowHeights = (
        20
        20)
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 782
    Height = 49
    Align = alTop
    Caption = #25805#20316
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 24
      Top = 16
      Width = 75
      Height = 25
      Caption = #26597#35810
      TabOrder = 0
      Visible = False
    end
    object btn_Add: TBitBtn
      Left = 112
      Top = 16
      Width = 75
      Height = 25
      Caption = #28155#21152
      TabOrder = 1
      OnClick = btn_AddClick
    end
    object BitBtn4: TBitBtn
      Left = 208
      Top = 16
      Width = 75
      Height = 25
      Caption = #21047#26032
      TabOrder = 2
      OnClick = BitBtn4Click
    end
  end
end
