object Fra_UserAdd: TFra_UserAdd
  Left = 0
  Top = 0
  Width = 782
  Height = 530
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object pan_UserAdd: TRzPanel
    Left = 0
    Top = 452
    Width = 782
    Height = 78
    Align = alBottom
    BorderOuter = fsNone
    TabOrder = 0
    object edt_UserName: Ti_TxtFilter
      Left = 61
      Top = 8
      Width = 121
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 48
      EditLabel.Height = 12
      EditLabel.Caption = #29992#25143#21517#65306
      EditLabel.Transparent = True
      LabelCaption = #29992#25143#21517#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      MaxLength = 50
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
    object edt_Pwd: Ti_TxtFilter
      Left = 429
      Top = 8
      Width = 121
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 36
      EditLabel.Height = 12
      EditLabel.Caption = #23494#30721#65306
      EditLabel.Transparent = True
      LabelCaption = #23494#30721#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      MaxLength = 50
      PasswordChar = '*'
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
    object cbb_Type: Ti_ComboBox
      Left = 605
      Top = 8
      Width = 121
      Height = 20
      EditLabel.Width = 36
      EditLabel.Height = 12
      EditLabel.Caption = #26435#38480#65306
      EditLabel.Transparent = True
      LabelCaption = #26435#38480#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 3
      Text = '--'#35831#36873#25321'--'
      Items.Strings = (
        '--'#35831#36873#25321'--'
        #26222#36890#29992#25143
        #31649#29702#21592
        #36229#32423#31649#29702#21592
        #26222#36890#29992#25143'('#23567#25209#37327')'
        #31649#29702#21592'('#23567#25209#37327')')
      ItemIndex = 0
    end
    object edt_JobNum: Ti_TxtFilter
      Tag = 10
      Left = 597
      Top = 40
      Width = 121
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 36
      EditLabel.Height = 12
      EditLabel.Caption = #24037#21495#65306
      EditLabel.Transparent = True
      LabelCaption = #24037#21495#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      MaxLength = 50
      TabOrder = 2
      Visible = False
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
      Top = 45
      Caption = #28155#21152
      TabOrder = 4
      OnClick = btn_addClick
    end
    object btn_mod: TRzButton
      Left = 423
      Top = 45
      Caption = #20462#25913
      TabOrder = 5
      OnClick = btn_modClick
    end
    object btn_del: TRzButton
      Left = 775
      Top = 45
      Caption = #21024#38500
      TabOrder = 6
      Visible = False
      OnClick = btn_delClick
    end
    object edt_RealName: Ti_TxtFilter
      Left = 253
      Top = 8
      Width = 121
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #30495#23454#22995#21517#65306
      EditLabel.Transparent = True
      LabelCaption = #30495#23454#22995#21517#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      MaxLength = 50
      TabOrder = 7
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
  object RzGroupBox1: TRzGroupBox
    Left = 0
    Top = 41
    Width = 782
    Height = 411
    Align = alClient
    Caption = #29992#25143#21015#34920
    TabOrder = 1
    object stg_UserList: Ti_StgEdit
      Left = 1
      Top = 13
      Width = 780
      Height = 397
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
      OnSelectCell = stg_UserListSelectCell
      pt_TitleHeight = 20
      FixedFontStyle = []
      OnLinkClick = stg_UserListLinkClick
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
      FormatString = #29992#25143#21517'|'#30495#23454#22995#21517'|'#26435#38480'|'#25805#20316'|'#25805#20316'|'#25805#20316'|'
      FixedWordBreak = True
      PermitCellSizing = False
      PermitExport = True
      WordBreak = False
      FixedRowAlignmentCenter = True
      ZeroToEmpty = True
      KeepEdit = False
      EnterAddRow = False
      ColWidths = (
        115
        127
        130
        64
        61
        64
        64)
      RowHeights = (
        20
        20)
    end
  end
  object gb_cx: TRzGroupBox
    Left = 0
    Top = 0
    Width = 782
    Height = 41
    Align = alTop
    Caption = #26597#35810#26465#20214
    TabOrder = 2
    object btn_cx: TRzButton
      Left = 299
      Top = 10
      Caption = #26597#35810
      TabOrder = 0
      OnClick = btn_cxClick
    end
    object cb_Type: Ti_ComboBox
      Left = 48
      Top = 12
      Width = 113
      Height = 20
      EditLabel.Width = 6
      EditLabel.Height = 12
      EditLabel.Transparent = True
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 1
      Text = #29992#25143#21517
      OnChange = cb_TypeChange
      Items.Strings = (
        #29992#25143#21517
        #30495#23454#22995#21517
        #26435#38480)
      ItemIndex = 0
    end
    object edt_Content: Ti_TxtFilter
      Left = 168
      Top = 12
      Width = 121
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 6
      EditLabel.Height = 12
      EditLabel.Transparent = True
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
    object btn_cz: TRzButton
      Left = 394
      Top = 10
      Caption = #37325#32622
      TabOrder = 3
      OnClick = btn_czClick
    end
    object cbb_UserType: Ti_ComboBox
      Left = 501
      Top = 8
      Width = 121
      Height = 20
      EditLabel.Width = 6
      EditLabel.Height = 12
      EditLabel.Transparent = True
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 4
      Visible = False
    end
  end
end
