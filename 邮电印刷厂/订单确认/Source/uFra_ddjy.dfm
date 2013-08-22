object Fra_ddjy: TFra_ddjy
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
    Top = 121
    Width = 800
    Height = 450
    Align = alClient
    Caption = 'RzGroupBox1'
    TabOrder = 0
    object stg_fhd: Ti_StgEdit
      Left = 1
      Top = 13
      Width = 798
      Height = 436
      Align = alClient
      ColCount = 10
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
      RowSelectColor = clWindowFrame
      RowSelect_TextColor_Highlight = True
      AutoUpdate = True
      Merge_FixedRow = True
      Merge_FixedCol = False
      Merge_Cell = False
      FixedFontSize = 9
      FixedFontName = #23435#20307
      FixedGridLineColor = clBlack
      GridLinesFixed = PGridInset
      FormatString = #23458#25143'|'#29256#21035'|'#20135#21697#32534#21495'|'#21360#37327'|'#31181#31867'|'#37038#36164#22270'|'#31614#26679'|'#25805#20316'|'
      FixedWordBreak = True
      PermitCellSizing = False
      PermitExport = True
      WordBreak = False
      FixedRowAlignmentCenter = True
      ZeroToEmpty = True
      KeepEdit = False
      EnterAddRow = False
      ColWidths = (
        71
        56
        122
        52
        54
        59
        57
        64
        57
        56)
      RowHeights = (
        20
        20)
    end
    object edt_Temp: TEdit
      Left = 536
      Top = 224
      Width = 121
      Height = 18
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 1
      Text = 'edt_Temp'
    end
  end
  object RzGroupBox2: TRzGroupBox
    Left = 0
    Top = 0
    Width = 800
    Height = 121
    Align = alTop
    Caption = '`'
    TabOrder = 1
    object Label3: TLabel
      Left = 198
      Top = 90
      Width = 12
      Height = 12
      Caption = #65374
    end
    object cbb_bb: Ti_ComboBox
      Left = 296
      Top = 22
      Width = 137
      Height = 20
      EditLabel.Width = 42
      EditLabel.Height = 12
      EditLabel.Caption = #29256' '#21035#65306
      EditLabel.Transparent = True
      LabelCaption = #29256' '#21035#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 1
      Text = #23450#21046#22411
      Items.Strings = (
        #23450#21046#22411
        #38144#21806#22411)
      ItemIndex = 0
    end
    object edt_cpbh: Ti_TxtFilter
      Left = 80
      Top = 22
      Width = 137
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #20135#21697#32534#21495#65306
      EditLabel.Transparent = True
      LabelCaption = #20135#21697#32534#21495#65306
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
    object cbb_cplb: Ti_ComboBox
      Left = 80
      Top = 54
      Width = 145
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
      TabOrder = 2
    end
    object cbb_cplx: Ti_ComboBox
      Left = 296
      Top = 54
      Width = 137
      Height = 20
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #20135#21697#31867#22411#65306
      EditLabel.Transparent = True
      LabelCaption = #20135#21697#31867#22411#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 3
      Text = '--'#20840#37096'--'
      Items.Strings = (
        '--'#20840#37096'--')
      ItemIndex = 0
    end
    object cbb_nf: Ti_ComboBox
      Left = 536
      Top = 54
      Width = 73
      Height = 20
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #24180#20221#26631#35782#65306
      EditLabel.Transparent = True
      LabelCaption = #24180#20221#26631#35782#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 8
      Text = '12'
      Visible = False
      Items.Strings = (
        '12')
      ItemIndex = 0
    end
    object dtp_jsq: TRzDateTimePicker
      Left = 102
      Top = 86
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      Enabled = False
      TabOrder = 6
    end
    object dtp_jsz: TRzDateTimePicker
      Left = 214
      Top = 86
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      Enabled = False
      TabOrder = 7
    end
    object cb_jsrq: TRzCheckBox
      Left = 17
      Top = 88
      Width = 80
      Height = 17
      Caption = #25509#25910#26085#26399#65306
      State = cbUnchecked
      TabOrder = 5
    end
    object btn_cx: TRzButton
      Left = 472
      Top = 84
      Caption = #26597#35810
      TabOrder = 4
    end
  end
  object pan_data: TPanel
    Left = 0
    Top = 571
    Width = 800
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #26032#23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      800
      29)
    object lab_up: TLabel
      Left = 564
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
    end
    object lab_down: TLabel
      Left = 612
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
    end
    object lab_ts50: TLabel
      Tag = 50
      Left = 300
      Top = 8
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
    end
    object lab_first: TLabel
      Left = 516
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
    end
    object lab_last: TLabel
      Left = 660
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
    end
    object Label2: TLabel
      Left = 444
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
      Left = 332
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
    end
    object lab_ts200: TLabel
      Tag = 200
      Left = 372
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
    end
    object lab_ts500: TLabel
      Tag = 500
      Left = 412
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
    end
    object Label6: TLabel
      Left = 260
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
    object edt_ys: TEdit
      Left = 720
      Top = 5
      Width = 33
      Height = 20
      Anchors = [akRight, akBottom]
      TabOrder = 0
    end
    object btn_go: TButton
      Left = 764
      Top = 2
      Width = 33
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Go'
      TabOrder = 1
    end
  end
end
