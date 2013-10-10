object Frm_XQBQInfo: TFrm_XQBQInfo
  Left = 567
  Top = 193
  Width = 601
  Height = 618
  Caption = #21253#31614#25171#21360#27983#35272
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox2: TGroupBox
    Left = 0
    Top = 105
    Width = 585
    Height = 431
    Align = alClient
    Caption = #21253#31614#20449#24687
    TabOrder = 0
    object stg_BQXX: Ti_StgEdit
      Left = 2
      Top = 14
      Width = 581
      Height = 415
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
      FormatString = #21517#31216'|'#26465#24418#30721'|'#20817#22870#21495#30721
      FixedWordBreak = True
      PermitCellSizing = False
      PermitExport = True
      WordBreak = False
      FixedRowAlignmentCenter = True
      ZeroToEmpty = True
      KeepEdit = False
      EnterAddRow = False
      ColWidths = (
        132
        248
        184)
      RowHeights = (
        20
        20)
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 536
    Width = 585
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      585
      44)
    object btn_DYBQ: TButton
      Left = 487
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #25171#21360#21253#31614
      TabOrder = 0
      OnClick = btn_DYBQClick
    end
    object Button1: TButton
      Left = 400
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 1
      Visible = False
      OnClick = Button1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 585
    Height = 105
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 184
      Top = 16
      Width = 48
      Height = 12
      Caption = #20135#21697#32534#21495
    end
    object Label2: TLabel
      Left = 26
      Top = 16
      Width = 24
      Height = 12
      Caption = #29256#21035
    end
    object Label3: TLabel
      Left = 16
      Top = 48
      Width = 36
      Height = 12
      Caption = #24635#31665#25968
    end
    object Label4: TLabel
      Left = 16
      Top = 80
      Width = 36
      Height = 12
      Caption = #24635#21253#25968
    end
    object Label5: TLabel
      Left = 184
      Top = 80
      Width = 48
      Height = 12
      Caption = #25104#21253#25968#37327
    end
    object Label6: TLabel
      Left = 184
      Top = 48
      Width = 48
      Height = 12
      Caption = #25104#31665#25968#37327
    end
    object edt_CPBH: TEdit
      Left = 240
      Top = 13
      Width = 153
      Height = 20
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object edt_BB: TEdit
      Left = 64
      Top = 13
      Width = 105
      Height = 20
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
    object edt_ZXS: TEdit
      Left = 64
      Top = 45
      Width = 105
      Height = 20
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object edt_ZBS: TEdit
      Left = 64
      Top = 77
      Width = 105
      Height = 20
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 3
    end
    object edt_CBSL: TEdit
      Left = 240
      Top = 77
      Width = 105
      Height = 20
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 4
    end
    object edt_CXSL: TEdit
      Left = 240
      Top = 45
      Width = 105
      Height = 20
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 5
    end
  end
end
