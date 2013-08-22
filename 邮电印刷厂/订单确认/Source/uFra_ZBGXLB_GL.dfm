object Fra_ZBGXLB_GL: TFra_ZBGXLB_GL
  Left = 0
  Top = 0
  Width = 800
  Height = 600
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object RzGroupBox1: TRzGroupBox
    Left = 0
    Top = 0
    Width = 800
    Height = 509
    Align = alClient
    Caption = #21046#29256#24037#24207#31867#21035#20449#24687
    TabOrder = 0
    object stg_gxlbxx: Ti_StgEdit
      Left = 1
      Top = 13
      Width = 798
      Height = 495
      Align = alClient
      ColCount = 7
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
      FormatString = #24037#24207#32534#21495'|'#24037#24207#21517#31216'|'#31867#21035#35268#26684'|'#20135#37327'|'#21333#20301'|'#25805#20316'|'
      FixedWordBreak = True
      PermitCellSizing = False
      PermitExport = True
      WordBreak = False
      FixedRowAlignmentCenter = True
      ZeroToEmpty = True
      KeepEdit = False
      EnterAddRow = False
      ColWidths = (
        117
        140
        108
        64
        64
        64
        64)
      RowHeights = (
        20
        20)
    end
  end
  object RzGroupBox2: TRzGroupBox
    Left = 0
    Top = 509
    Width = 800
    Height = 91
    Align = alBottom
    Caption = #24405#20837
    TabOrder = 1
    object Label1: TLabel
      Left = 659
      Top = 28
      Width = 36
      Height = 12
      Caption = #21333#20301#65306
    end
    object edt_gxbh: Ti_TxtFilter
      Left = 80
      Top = 24
      Width = 81
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #24037#24207#32534#21495#65306
      EditLabel.Transparent = True
      LabelCaption = #24037#24207#32534#21495#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 0
      AllowNegative = True
      BorderLine = False
      BorderLineColor = clBlack
      BorderLineGap = 0
      ErrDialog = False
      ErrLostFocus = False
      FullEnter = True
      LabelEnableFollow = True
      LabelLeft = -1
      LabelTransParent = True
      LayOut = BIVCenter
      Style = PNomal
      ReadOnly_X = False
      AllowEmpty_X = True
    end
    object edt_gxmc: Ti_TxtFilter
      Left = 232
      Top = 24
      Width = 129
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #24037#24207#21517#31216#65306
      EditLabel.Transparent = True
      LabelCaption = #24037#24207#21517#31216#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 1
      AllowNegative = True
      BorderLine = False
      BorderLineColor = clBlack
      BorderLineGap = 0
      ErrDialog = False
      ErrLostFocus = False
      FullEnter = True
      LabelEnableFollow = True
      LabelLeft = -1
      LabelTransParent = True
      LayOut = BIVCenter
      Style = PNomal
      ReadOnly_X = False
      AllowEmpty_X = True
    end
    object btn_add: TRzButton
      Left = 223
      Top = 57
      Caption = #28155#21152
      TabOrder = 4
    end
    object btn_mod: TRzButton
      Left = 423
      Top = 57
      Caption = #20462#25913
      TabOrder = 5
    end
    object edt_cl: Ti_TxtFilter
      Left = 581
      Top = 24
      Width = 73
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 36
      EditLabel.Height = 12
      EditLabel.Caption = #20135#37327#65306
      EditLabel.Transparent = True
      LabelCaption = #20135#37327#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 3
      AllowNegative = True
      BorderLine = False
      BorderLineColor = clBlack
      BorderLineGap = 0
      ErrDialog = False
      ErrLostFocus = False
      FullEnter = True
      LabelEnableFollow = True
      LabelLeft = -1
      LabelTransParent = True
      LayOut = BIVCenter
      Style = PNomal
      ReadOnly_X = False
      AllowEmpty_X = True
    end
    object edt_lbgg: Ti_TxtFilter
      Left = 432
      Top = 24
      Width = 101
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #31867#21035#35268#26684#65306
      EditLabel.Transparent = True
      LabelCaption = #31867#21035#35268#26684#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 2
      AllowNegative = True
      BorderLine = False
      BorderLineColor = clBlack
      BorderLineGap = 0
      ErrDialog = False
      ErrLostFocus = False
      FullEnter = True
      LabelEnableFollow = True
      LabelLeft = -1
      LabelTransParent = True
      LayOut = BIVCenter
      Style = PNomal
      ReadOnly_X = False
      AllowEmpty_X = True
    end
    object cbb_dw: TComboBox
      Left = 696
      Top = 24
      Width = 63
      Height = 20
      ItemHeight = 12
      TabOrder = 6
      Items.Strings = (
        #29256
        #30721
        #29255)
    end
  end
end
