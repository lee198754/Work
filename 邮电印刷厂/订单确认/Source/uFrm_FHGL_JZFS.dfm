object Frm_FHGL_JZFS: TFrm_FHGL_JZFS
  Left = 440
  Top = 239
  Width = 612
  Height = 340
  Caption = #25552#31034
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object lab_Text: TLabel
    Left = 16
    Top = 216
    Width = 112
    Height = 14
    Caption = #35831#36873#25321#36827#32440#26041#24335#65306
  end
  object btn_A: TRzButton
    Left = 127
    Top = 248
    Caption = #21069#38754#36827#32440
    TabOrder = 0
    OnClick = btn_AClick
  end
  object btn_B: TRzButton
    Left = 320
    Top = 248
    Caption = #21518#38754#36827#32440
    TabOrder = 1
    OnClick = btn_BClick
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 596
    Height = 201
    Align = alTop
    Caption = #20869#20214#20449#24687
    TabOrder = 2
    object stg_njxx: Ti_StgEdit
      Left = 2
      Top = 16
      Width = 592
      Height = 183
      Align = alClient
      ColCount = 5
      DefaultRowHeight = 20
      FixedCols = 0
      RowCount = 3
      FixedRows = 2
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
      FormatString = #20135#21697#32534#21495'|'#20869#20214#21697#21517'|'#20869#20214#25968#37327'|'#20869#20214#25968#37327'|'#20869#20214#25968#37327
      FixedWordBreak = True
      PermitCellSizing = False
      PermitExport = True
      WordBreak = False
      FixedRowAlignmentCenter = True
      ZeroToEmpty = True
      KeepEdit = False
      EnterAddRow = False
      ColWidths = (
        153
        195
        62
        87
        48)
      RowHeights = (
        20
        20
        20)
    end
    object edt_Temp: TEdit
      Left = 451
      Top = 160
      Width = 121
      Height = 20
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      Text = 'edt_Temp'
      Visible = False
    end
  end
end
