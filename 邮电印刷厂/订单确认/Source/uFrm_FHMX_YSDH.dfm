object Frm_FHMX_YSDH: TFrm_FHMX_YSDH
  Left = 470
  Top = 240
  Width = 797
  Height = 481
  Caption = #20998#31665#26126#32454
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 14
  object stg_ysdh: Ti_StgEdit
    Left = 0
    Top = 0
    Width = 781
    Height = 443
    Align = alClient
    ColCount = 6
    DefaultRowHeight = 20
    FixedCols = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    Options = [goRowSizing, goColSizing]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    pt_TitleHeight = 20
    FixedFontStyle = []
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
    FormatString = #20998#31665#21495'|'#20135#21697#32534#21495'|'#36816#36755#21333#21495'|'#25805#20316#20154'|'#25805#20316#26085#26399'|EMS'#26597#35810
    FixedWordBreak = True
    PermitCellSizing = False
    PermitExport = True
    WordBreak = False
    FixedRowAlignmentCenter = True
    ZeroToEmpty = True
    KeepEdit = False
    EnterAddRow = False
    ColWidths = (
      52
      168
      210
      68
      137
      64)
    RowHeights = (
      20
      20)
  end
  object edt_Temp: TEdit
    Left = 123
    Top = 200
    Width = 121
    Height = 20
    Ctl3D = False
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 1
    Text = 'edt_Temp'
    Visible = False
  end
end
