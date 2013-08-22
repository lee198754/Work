object fra_gdcx: Tfra_gdcx
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
  object Splitter2: TSplitter
    Left = 0
    Top = 343
    Width = 800
    Height = 5
    Cursor = crVSplit
    Align = alBottom
  end
  object RzGroupBox1: TRzGroupBox
    Left = 0
    Top = 0
    Width = 800
    Height = 121
    Align = alTop
    Caption = #26597#35810
    TabOrder = 0
    object Label3: TLabel
      Left = 187
      Top = 83
      Width = 12
      Height = 12
      Caption = #65374
    end
    object Label4: TLabel
      Left = 467
      Top = 83
      Width = 12
      Height = 12
      Caption = #65374
    end
    object edt_hm: Ti_TxtFilter
      Left = 550
      Top = 49
      Width = 137
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 24
      EditLabel.Height = 12
      EditLabel.Caption = #25143#21517
      EditLabel.Transparent = True
      LabelCaption = #25143#21517
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 0
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
    object edt_pm: Ti_TxtFilter
      Left = 45
      Top = 49
      Width = 145
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 24
      EditLabel.Height = 12
      EditLabel.Caption = #21697#21517
      EditLabel.Transparent = True
      LabelCaption = #21697#21517
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
    object edt_gdh: Ti_TxtFilter
      Left = 46
      Top = 16
      Width = 177
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 36
      EditLabel.Height = 12
      EditLabel.Caption = #24037#21333#21495
      EditLabel.Transparent = True
      LabelCaption = #24037#21333#21495
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
    object cbb_dylx: Ti_ComboBox
      Left = 716
      Top = 96
      Width = 89
      Height = 20
      EditLabel.Width = 48
      EditLabel.Height = 12
      EditLabel.Caption = #25171#21360#31867#22411
      EditLabel.Transparent = True
      LabelCaption = #25171#21360#31867#22411
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 3
      Text = #20840#37096
      Visible = False
      Items.Strings = (
        #20840#37096
        #32763#21360
        #22871#21360
        #21333#38754#21360)
      ItemIndex = 0
    end
    object btn_cx_old: TRzBitBtn
      Left = 678
      Top = 38
      Caption = #26597#35810
      TabOrder = 4
      Visible = False
      OnClick = btn_cx_oldClick
    end
    object dtp_kdq: TRzDateTimePicker
      Left = 91
      Top = 80
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      Enabled = False
      TabOrder = 5
    end
    object dtp_kdz: TRzDateTimePicker
      Left = 203
      Top = 80
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      Enabled = False
      TabOrder = 6
    end
    object dtp_jhq: TRzDateTimePicker
      Left = 375
      Top = 80
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      Enabled = False
      TabOrder = 7
    end
    object dtp_jhz: TRzDateTimePicker
      Left = 483
      Top = 80
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      Enabled = False
      TabOrder = 8
    end
    object cb_kdrq: TRzCheckBox
      Left = 11
      Top = 83
      Width = 73
      Height = 17
      Caption = #24320#21333#26085#26399
      State = cbUnchecked
      TabOrder = 9
      OnClick = cb_kdrqClick
    end
    object cb_jhrq: TRzCheckBox
      Left = 300
      Top = 82
      Width = 73
      Height = 17
      Caption = #20132#36135#26085#26399
      State = cbUnchecked
      TabOrder = 10
      OnClick = cb_jhrqClick
    end
    object cbb_cx: Ti_ComboBox
      Left = 534
      Top = 16
      Width = 89
      Height = 20
      EditLabel.Width = 48
      EditLabel.Height = 12
      EditLabel.Caption = #25764#28040#26631#24535
      EditLabel.Transparent = True
      LabelCaption = #25764#28040#26631#24535
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 11
      Text = #26410#25764#28040
      Items.Strings = (
        #20840#37096
        #26410#25764#28040
        #24050#25764#28040)
      ItemIndex = 1
    end
    object cbb_xpl: Ti_ComboBox
      Left = 286
      Top = 49
      Width = 97
      Height = 20
      EditLabel.Width = 72
      EditLabel.Height = 12
      EditLabel.Caption = #26159#21542#23567#25209#37327#65306
      EditLabel.Transparent = True
      LabelCaption = #26159#21542#23567#25209#37327#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 12
      Text = #20840#37096
      Items.Strings = (
        #20840#37096
        #21542
        #26159)
      ItemIndex = 0
    end
    object btn_cx: TRzBitBtn
      Left = 590
      Top = 78
      Caption = #26597#35810
      TabOrder = 13
      OnClick = btn_cxClick
    end
    object btn_export: TRzButton
      Left = 673
      Top = 78
      Caption = #23548#20986
      TabOrder = 14
      OnClick = btn_exportClick
    end
    object edt_cpbh: Ti_TxtFilter
      Left = 288
      Top = 16
      Width = 177
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 48
      EditLabel.Height = 12
      EditLabel.Caption = #20135#21697#32534#21495
      EditLabel.Transparent = True
      LabelCaption = #20135#21697#32534#21495
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 15
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
    object cb_History: TCheckBox
      Left = 656
      Top = 18
      Width = 97
      Height = 17
      Caption = #21382#21490#24037#21333
      TabOrder = 16
    end
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 348
    Width = 800
    Height = 202
    Align = alBottom
    BorderOuter = fsNone
    TabOrder = 1
    object RzGroupBox2: TRzGroupBox
      Left = 0
      Top = 0
      Width = 800
      Height = 202
      Align = alClient
      Caption = #24037#21333#26126#32454
      TabOrder = 0
      object stg_gdmx: Ti_StgEdit
        Left = 313
        Top = 13
        Width = 486
        Height = 188
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
        FormatString = #23458#25143#21517#31216'|'#20135#21697#32534#21495'|'#26412#27425#21360#37327'('#19975#26522')|'#32452#21495'|'#20817#22870#21495#27573#36215'|'#20817#22870#21495#27573#27490'|'#22791#27880
        FixedWordBreak = True
        PermitCellSizing = False
        PermitExport = True
        WordBreak = False
        FixedRowAlignmentCenter = True
        ZeroToEmpty = True
        KeepEdit = False
        EnterAddRow = False
        ColWidths = (
          164
          134
          91
          64
          64
          64
          194)
        RowHeights = (
          20
          20)
      end
      object edt_Temp: TEdit
        Left = 519
        Top = 56
        Width = 121
        Height = 18
        Ctl3D = False
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 1
        Text = 'edt_Temp'
        Visible = False
      end
      object RzPanel2: TRzPanel
        Left = 1
        Top = 13
        Width = 312
        Height = 188
        Align = alLeft
        BorderOuter = fsNone
        TabOrder = 2
        Visible = False
        object stg_jtxx: Ti_StgEdit
          Left = 0
          Top = 0
          Width = 312
          Height = 188
          Align = alClient
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
          TabOrder = 0
          OnSelectCell = stg_jtxxSelectCell
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
          FormatString = #26426#21488#32534#21495'|'#26426#21488#21517#31216'|'#29366#24577'||'
          FixedWordBreak = True
          PermitCellSizing = False
          PermitExport = True
          WordBreak = False
          FixedRowAlignmentCenter = True
          ZeroToEmpty = True
          KeepEdit = False
          EnterAddRow = False
          ColWidths = (
            105
            137
            64
            64
            64)
          RowHeights = (
            20
            20)
        end
      end
    end
  end
  object gb_gd: TRzGroupBox
    Left = 0
    Top = 121
    Width = 800
    Height = 222
    Align = alClient
    Caption = #24037#21333
    TabOrder = 2
    object stg_gd: Ti_StgEdit
      Left = 1
      Top = 13
      Width = 798
      Height = 179
      Align = alClient
      ColCount = 18
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
      OnSelectCell = stg_gdSelectCell
      pt_TitleHeight = 20
      FixedFontStyle = []
      OnLinkClick = stg_gdLinkClick
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
      FormatString = 
        #25805#20316'|'#26631#24535'|'#24037#21333#21495'|'#25143#21517'|'#21697#21517'|'#26426#21488#32534#21495'|'#26426#21488#21517#31216'|'#24320#21333#26085#26399'|'#20132#36135#26085#26399'|'#29366#24577'|'#20132#29256#26085#26399'|'#21360#23436#26085#26399'|'#35013#23436#26085#26399'|'#23454#38469#21457#36135#26085#26399'|'#26368#21518#25805 +
        #20316#26085#26399'|'#25764#28040#26631#24535'||'
      FixedWordBreak = True
      PermitCellSizing = False
      PermitExport = True
      WordBreak = False
      FixedRowAlignmentCenter = True
      ZeroToEmpty = True
      KeepEdit = False
      EnterAddRow = False
      ColWidths = (
        41
        47
        114
        97
        106
        77
        100
        74
        70
        67
        90
        84
        86
        90
        103
        64
        64
        64)
      RowHeights = (
        20
        20)
    end
    object pan_data: TPanel
      Left = 1
      Top = 192
      Width = 798
      Height = 29
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #26032#23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        798
        29)
      object lab_up: TLabel
        Left = 562
        Top = 8
        Width = 36
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = #19978#19968#39029
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = lab_upClick
      end
      object lab_down: TLabel
        Left = 610
        Top = 8
        Width = 36
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = #19979#19968#39029
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = lab_downClick
      end
      object lab_ts50: TLabel
        Tag = 50
        Left = 298
        Top = 9
        Width = 24
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = '50 |'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = lab_ts50Click
      end
      object lab_first: TLabel
        Left = 514
        Top = 8
        Width = 36
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = #31532#19968#39029
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = lab_firstClick
      end
      object lab_last: TLabel
        Left = 658
        Top = 8
        Width = 48
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = #26368#21518#19968#39029
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = lab_lastClick
      end
      object Label2: TLabel
        Left = 442
        Top = 9
        Width = 12
        Height = 12
        Anchors = [akRight, akBottom]
        Caption = #26465
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lab_zys: TLabel
        Left = 10
        Top = 8
        Width = 54
        Height = 12
        Anchors = [akLeft, akBottom]
        Caption = #39029#27425#65306'0/0'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lab_ts100: TLabel
        Tag = 100
        Left = 330
        Top = 9
        Width = 30
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = '100 |'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = lab_ts50Click
      end
      object lab_ts200: TLabel
        Tag = 200
        Left = 370
        Top = 9
        Width = 30
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = '200 |'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = lab_ts50Click
      end
      object lab_ts500: TLabel
        Tag = 500
        Left = 410
        Top = 9
        Width = 18
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = '500'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = lab_ts50Click
      end
      object Label6: TLabel
        Left = 258
        Top = 9
        Width = 24
        Height = 12
        Anchors = [akRight, akBottom]
        Caption = #27599#39029
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lab_tsQB: TLabel
        Tag = 100000000
        Left = 178
        Top = 9
        Width = 54
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = ' '#26174#31034#20840#37096
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = lab_ts50Click
      end
      object edt_ys: TEdit
        Left = 718
        Top = 5
        Width = 33
        Height = 20
        Anchors = [akRight, akBottom]
        TabOrder = 0
      end
      object btn_go: TButton
        Left = 762
        Top = 2
        Width = 33
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Go'
        TabOrder = 1
        OnClick = btn_goClick
      end
    end
  end
end
