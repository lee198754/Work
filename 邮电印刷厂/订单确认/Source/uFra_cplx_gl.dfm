object Fra_cplx_gl: TFra_cplx_gl
  Left = 0
  Top = 0
  Width = 800
  Height = 550
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 800
    Height = 358
    Align = alClient
    Caption = #20135#21697#31867#22411#20449#24687
    TabOrder = 0
    object stg_cplxxx: Ti_StgEdit
      Left = 2
      Top = 14
      Width = 796
      Height = 342
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
      OnSelectCell = stg_cplxxxSelectCell
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
      FormatString = #20135#21697#31867#21035'|'#24207#21495'|'#20135#21697#31867#22411'|'#32534#30721'|'#26159#21542#21547#26377#20869#20214'|'#24037#21333#21495#21069#32512'|'#24180#20221#26356#21464#26085#26399'||'
      FixedWordBreak = True
      PermitCellSizing = False
      PermitExport = True
      WordBreak = False
      FixedRowAlignmentCenter = True
      ZeroToEmpty = True
      KeepEdit = False
      EnterAddRow = False
      ColWidths = (
        166
        60
        85
        90
        95
        84
        121
        64
        64)
      RowHeights = (
        20
        20)
    end
  end
  object RzGroupBox2: TRzGroupBox
    Left = 0
    Top = 358
    Width = 800
    Height = 192
    Align = alBottom
    Caption = #24405#20837
    TabOrder = 1
    object Label3: TLabel
      Left = 10
      Top = 128
      Width = 84
      Height = 12
      Caption = #24180#20221#26356#21464#26085#26399#65306
    end
    object Label1: TLabel
      Left = 228
      Top = 94
      Width = 162
      Height = 12
      Caption = '(*'#35831#29992#23567#20889#30340'"year"'#20195#34920#24180#20221')'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #26032#23435#20307
      Font.Style = []
      ParentFont = False
    end
    object cbb_CPLX: Ti_TxtFilter
      Left = 96
      Top = 56
      Width = 125
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #20135#21697#31867#22411#65306
      EditLabel.Transparent = True
      LabelCaption = #20135#21697#31867#22411#65306
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
    object cbb_XH: Ti_TxtFilter
      Left = 288
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
      EditLabel.Caption = #24207#21495#65306
      EditLabel.Transparent = True
      LabelCaption = #24207#21495#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 1
      OnKeyPress = cbb_XHKeyPress
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
    object cbb_FJNJ: Ti_ComboBox
      Left = 463
      Top = 56
      Width = 73
      Height = 20
      EditLabel.Width = 84
      EditLabel.Height = 12
      EditLabel.Caption = #26159#21542#21547#26377#20869#20214#65306
      EditLabel.Transparent = True
      LabelCaption = #26159#21542#21547#26377#20869#20214#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 4
      Text = #21542
      Items.Strings = (
        #21542
        #26159)
      ItemIndex = 0
    end
    object edt_BM: Ti_TxtFilter
      Left = 287
      Top = 56
      Width = 73
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 36
      EditLabel.Height = 12
      EditLabel.Caption = #32534#30721#65306
      EditLabel.Transparent = True
      LabelCaption = #32534#30721#65306
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
    object cbb_cplb: Ti_ComboBox
      Left = 96
      Top = 24
      Width = 129
      Height = 20
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #20135#21697#31867#21035#65306
      EditLabel.Transparent = True
      LabelCaption = #20135#21697#31867#21035#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 0
    end
    object btn_Add: TRzButton
      Left = 48
      Top = 152
      Caption = #28155#21152
      TabOrder = 5
      OnClick = btn_AddClick
    end
    object btn_Modify: TRzButton
      Left = 232
      Top = 152
      Caption = #20462#25913
      TabOrder = 6
      OnClick = btn_ModifyClick
    end
    object btn_Del: TRzButton
      Left = 400
      Top = 152
      Caption = #21024#38500
      TabOrder = 7
      OnClick = btn_DelClick
    end
    object cbb_year: Ti_ComboBox
      Left = 96
      Top = 125
      Width = 61
      Height = 20
      EditLabel.Width = 6
      EditLabel.Height = 12
      EditLabel.Transparent = True
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 8
      Text = #31532#20108#24180
      Items.Strings = (
        #31532#20108#24180
        #27599#24180)
      ItemIndex = 0
    end
    object cbb_month: Ti_ComboBox
      Left = 161
      Top = 125
      Width = 51
      Height = 20
      EditLabel.Width = 6
      EditLabel.Height = 12
      EditLabel.Transparent = True
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 9
      Text = '01'#26376
      Items.Strings = (
        '01'#26376
        '02'#26376
        '03'#26376
        '04'#26376
        '05'#26376
        '06'#26376
        '07'#26376
        '08'#26376
        '09'#26376
        '10'#26376
        '11'#26376
        '12'#26376)
      ItemIndex = 0
    end
    object cbb_day: Ti_ComboBox
      Left = 218
      Top = 125
      Width = 51
      Height = 20
      EditLabel.Width = 6
      EditLabel.Height = 12
      EditLabel.Transparent = True
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 10
      Text = '01'#26085
      Items.Strings = (
        '01'#26085
        '02'#26085
        '03'#26085
        '04'#26085
        '05'#26085
        '06'#26085
        '07'#26085
        '08'#26085
        '09'#26085
        '10'#26085
        '11'#26085
        '12'#26085
        '13'#26085
        '14'#26085
        '15'#26085
        '16'#26085
        '17'#26085
        '18'#26085
        '19'#26085
        '20'#26085
        '21'#26085
        '22'#26085
        '23'#26085
        '24'#26085
        '25'#26085
        '26'#26085
        '27'#26085
        '28'#26085
        '29'#26085
        '30'#26085
        '31'#26085)
      ItemIndex = 0
    end
    object edt_PrefixStyle: Ti_TxtFilter
      Left = 96
      Top = 90
      Width = 125
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 72
      EditLabel.Height = 12
      EditLabel.Caption = #24037#21333#21495#21069#32512#65306
      EditLabel.Transparent = True
      LabelCaption = #24037#21333#21495#21069#32512#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 11
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
  end
end
