object Fra_FHGL_DYCX: TFra_FHGL_DYCX
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
  object Splitter2: TSplitter
    Left = 0
    Top = 323
    Width = 782
    Height = 5
    Cursor = crVSplit
    Align = alBottom
  end
  object RzGroupBox1: TRzGroupBox
    Left = 0
    Top = 0
    Width = 782
    Height = 81
    Align = alTop
    Caption = #26597#35810
    TabOrder = 0
    object Label3: TLabel
      Left = 443
      Top = 51
      Width = 12
      Height = 12
      Caption = #65374
    end
    object edt_spdw: Ti_TxtFilter
      Left = 310
      Top = 16
      Width = 137
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 48
      EditLabel.Height = 12
      EditLabel.Caption = #25910#31080#21333#20301
      EditLabel.Transparent = True
      LabelCaption = #25910#31080#21333#20301
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
    object edt_fhdh: Ti_TxtFilter
      Left = 70
      Top = 48
      Width = 177
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 48
      EditLabel.Height = 12
      EditLabel.Caption = #21457#36135#21333#21495
      EditLabel.Transparent = True
      LabelCaption = #21457#36135#21333#21495
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
    object btn_cx: TRzBitBtn
      Left = 598
      Top = 46
      Caption = #26597#35810
      TabOrder = 2
      OnClick = btn_cxClick
    end
    object dtp_fpq: TRzDateTimePicker
      Left = 347
      Top = 48
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      Enabled = False
      TabOrder = 3
    end
    object dtp_fpz: TRzDateTimePicker
      Left = 459
      Top = 48
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      Enabled = False
      TabOrder = 4
    end
    object cb_fprq: TRzCheckBox
      Left = 267
      Top = 51
      Width = 73
      Height = 17
      Caption = #21457#31080#26085#26399
      State = cbUnchecked
      TabOrder = 5
      OnClick = cb_fprqClick
    end
    object edt_cpbh: Ti_TxtFilter
      Left = 70
      Top = 16
      Width = 179
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
      TabOrder = 6
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
      Left = 600
      Top = 18
      Width = 97
      Height = 17
      Caption = #21382#21490#20986#20179#21333
      TabOrder = 7
    end
  end
  object gb_fhd: TRzGroupBox
    Left = 0
    Top = 81
    Width = 782
    Height = 242
    Align = alClient
    Caption = #21457#36135#21333
    TabOrder = 1
    object stg_fhd: Ti_StgEdit
      Left = 1
      Top = 13
      Width = 780
      Height = 199
      Align = alClient
      ColCount = 8
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
      OnMouseDown = stg_fhdMouseDown
      OnSelectCell = stg_fhdSelectCell
      pt_TitleHeight = 20
      FixedFontStyle = []
      OnLinkClick = stg_fhdLinkClick
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
      FormatString = #25805#20316'|'#27425#25968'|'#21457#36135#21333#21495'|'#25910#31080#21333#20301'|'#32852#31995#20154'|'#21457#31080#21333#20301'|'#21457#31080#26085#26399'|'
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
        39
        148
        117
        147
        119
        64
        64)
      RowHeights = (
        20
        20)
    end
    object pan_data: TPanel
      Left = 1
      Top = 212
      Width = 780
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
        780
        29)
      object lab_up: TLabel
        Left = 544
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
        Left = 592
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
        Left = 280
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
        OnClick = lab_ts50Click
      end
      object lab_first: TLabel
        Left = 496
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
        Left = 640
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
        Left = 424
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
        Left = 312
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
        Left = 352
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
        Left = 392
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
        Left = 240
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
        Left = 162
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
        Left = 700
        Top = 5
        Width = 33
        Height = 20
        Anchors = [akRight, akBottom]
        TabOrder = 0
      end
      object btn_go: TButton
        Left = 744
        Top = 2
        Width = 33
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Go'
        TabOrder = 1
        OnClick = btn_goClick
      end
    end
    object edt_Temp: TEdit
      Left = 496
      Top = 208
      Width = 121
      Height = 18
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 2
      Text = 'edt_Temp'
    end
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 328
    Width = 782
    Height = 202
    Align = alBottom
    BorderOuter = fsNone
    TabOrder = 2
    object RzGroupBox2: TRzGroupBox
      Left = 0
      Top = 0
      Width = 782
      Height = 202
      Align = alClient
      Caption = #21457#36135#26126#32454
      TabOrder = 0
      object stg_fhmx: Ti_StgEdit
        Left = 1
        Top = 13
        Width = 780
        Height = 188
        Align = alClient
        ColCount = 8
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
        FormatString = #31080#21697#21517#31216'|'#20135#21697#32534#21495'|'#38754#20540'|'#22270#21035'|'#31665#25968'|'#27599#31665#26522#25968'('#26522')|'#26522#25968'('#26522')|'#22791#27880
        FixedWordBreak = True
        PermitCellSizing = False
        PermitExport = True
        WordBreak = False
        FixedRowAlignmentCenter = True
        ZeroToEmpty = True
        KeepEdit = False
        EnterAddRow = False
        ColWidths = (
          254
          114
          54
          61
          44
          82
          85
          64)
        RowHeights = (
          20
          20)
      end
      object edt_Temp2: TEdit
        Left = 519
        Top = 56
        Width = 121
        Height = 18
        Ctl3D = False
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 1
        Text = 'edt_Temp2'
        Visible = False
      end
    end
  end
end
