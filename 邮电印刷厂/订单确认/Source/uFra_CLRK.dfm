object Fra_CLRK: TFra_CLRK
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
    Height = 342
    Align = alClient
    Caption = #26448#26009#24211#23384
    TabOrder = 0
    object stg_clkc: Ti_StgEdit
      Left = 1
      Top = 13
      Width = 798
      Height = 328
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
      FormatString = #26448#26009#32534#21495'|'#26448#26009#21517#31216'|'#24403#21069#24211#23384'|'#36827#20179#25968#37327'|'#20986#20179#25968#37327'|'#21333#20301
      FixedWordBreak = True
      PermitCellSizing = False
      PermitExport = True
      WordBreak = False
      FixedRowAlignmentCenter = True
      ZeroToEmpty = True
      KeepEdit = False
      EnterAddRow = False
      ColWidths = (
        106
        161
        72
        75
        71
        55)
      RowHeights = (
        20
        20)
    end
  end
  object RzGroupBox3: TRzGroupBox
    Left = 0
    Top = 518
    Width = 800
    Height = 82
    Align = alBottom
    Caption = #24405#20837
    TabOrder = 1
    object edt_clmc: Ti_TxtFilter
      Left = 223
      Top = 16
      Width = 154
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 48
      EditLabel.Height = 12
      EditLabel.Caption = #26448#26009#21517#31216
      EditLabel.Transparent = True
      LabelCaption = #26448#26009#21517#31216
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
    object edt_clsjjg: Ti_TxtFilter
      Left = 436
      Top = 16
      Width = 73
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 48
      EditLabel.Height = 12
      EditLabel.Caption = #23454#38469#20215#26684
      EditLabel.Transparent = True
      LabelCaption = #23454#38469#20215#26684
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
    object edt_clbh: Ti_TxtFilter
      Left = 58
      Top = 16
      Width = 89
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 48
      EditLabel.Height = 12
      EditLabel.Caption = #26448#26009#32534#21495
      EditLabel.Transparent = True
      LabelCaption = #26448#26009#32534#21495
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
    object btn_cl: TButton
      Left = 146
      Top = 15
      Width = 22
      Height = 21
      Caption = #8230
      TabOrder = 0
      OnClick = btn_clClick
    end
    object edt_cljhjg: Ti_TxtFilter
      Left = 564
      Top = 16
      Width = 65
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 48
      EditLabel.Height = 12
      EditLabel.Caption = #35745#21010#20215#26684
      EditLabel.Transparent = True
      LabelCaption = #35745#21010#20215#26684
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 4
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
    object edt_sl: Ti_TxtFilter
      Left = 668
      Top = 16
      Width = 49
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 24
      EditLabel.Height = 12
      EditLabel.Caption = #25968#37327
      EditLabel.Transparent = True
      LabelCaption = #25968#37327
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 5
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
    object btn_ok: TRzButton
      Left = 24
      Top = 48
      Width = 113
      Caption = #20837#24211
      TabOrder = 6
      OnClick = btn_okClick
    end
  end
  object RzGroupBox2: TRzGroupBox
    Left = 0
    Top = 342
    Width = 800
    Height = 176
    Align = alBottom
    Caption = #26368#21518#20837#24211#20449#24687
    TabOrder = 2
    object stg_rkxx: Ti_StgEdit
      Left = 1
      Top = 13
      Width = 798
      Height = 162
      Align = alClient
      ColCount = 9
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
      OnKeyPress = stg_rkxxKeyPress
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
      FormatString = #25209#27425#21495'|'#26448#26009#32534#21495'|'#26448#26009#21517#31216'|'#23454#38469#20215#26684'|'#35745#21010#20215#26684'|'#25968#37327'|'#21333#20301'|'#25805#20316#20154'|'#25805#20316#26085#26399
      FixedWordBreak = True
      PermitCellSizing = False
      PermitExport = True
      WordBreak = False
      FixedRowAlignmentCenter = True
      ZeroToEmpty = True
      KeepEdit = False
      EnterAddRow = False
      ColWidths = (
        99
        87
        143
        71
        69
        56
        49
        64
        137)
      RowHeights = (
        20
        20)
    end
  end
end
