object Fra_FYDHLR: TFra_FYDHLR
  Left = 0
  Top = 0
  Width = 800
  Height = 550
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #26032#23435#20307
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object RzGroupBox1: TRzGroupBox
    Left = 0
    Top = 0
    Width = 800
    Height = 49
    Align = alTop
    Caption = #26597#35810
    TabOrder = 0
    Visible = False
    object edt_cpbh: Ti_TxtFilter
      Left = 72
      Top = 16
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 56
      EditLabel.Height = 14
      EditLabel.Caption = #20135#21697#32534#21495
      EditLabel.Transparent = True
      LabelCaption = #20135#21697#32534#21495
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
      Left = 256
      Top = 16
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 56
      EditLabel.Height = 14
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
    object btn_cx: TRzButton
      Left = 710
      Top = 13
      Caption = #26597#35810
      TabOrder = 2
    end
  end
  object RzGroupBox2: TRzGroupBox
    Left = 0
    Top = 49
    Width = 800
    Height = 462
    Align = alClient
    TabOrder = 1
    object RzPanel1: TRzPanel
      Left = 1
      Top = 15
      Width = 798
      Height = 39
      Align = alTop
      BorderOuter = fsNone
      TabOrder = 0
      DesignSize = (
        798
        39)
      object RzBitBtn1: TRzBitBtn
        Left = 12
        Top = 6
        Anchors = [akLeft, akBottom]
        Caption = #26222#36890#23548#20837
        TabOrder = 0
        OnClick = RzBitBtn1Click
      end
      object RzBitBtn2: TRzBitBtn
        Tag = 1
        Left = 108
        Top = 6
        Anchors = [akLeft, akBottom]
        Caption = #33258#25552#23548#20837
        TabOrder = 1
        OnClick = RzBitBtn1Click
      end
      object RzBitBtn3: TRzBitBtn
        Tag = 2
        Left = 204
        Top = 6
        Anchors = [akLeft, akBottom]
        Caption = #37038#34955#23548#20837
        TabOrder = 2
        OnClick = RzBitBtn1Click
      end
    end
    object rb_fydh: TRzGroupBox
      Left = 1
      Top = 54
      Width = 798
      Height = 407
      Align = alClient
      Caption = #36816#36755#21333#21495
      TabOrder = 1
      object stg_fydh: Ti_StgEdit
        Left = 1
        Top = 15
        Width = 796
        Height = 391
        Align = alClient
        ColCount = 10
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
        OnLinkClick = stg_fydhLinkClick
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
        FormatString = #31665#31614#26465#24418#30721'|'#36816#36755#21333#21495'|'#20135#21697#32534#21495'|'#37038#36164#22270'|'#25805#20316'|'#21097#20313#24211#23384'|'#24050#21457#36135#24635#37327'|'#26410#21457#36135#24635#37327'||'
        FixedWordBreak = True
        PermitCellSizing = False
        PermitExport = True
        WordBreak = False
        FixedRowAlignmentCenter = True
        ZeroToEmpty = True
        pt_NoMoveNextCol = 1
        KeepEdit = False
        EnterAddRow = False
        ColWidths = (
          171
          144
          138
          76
          53
          64
          64
          64
          64
          64)
        RowHeights = (
          20
          20)
      end
      object edt_Temp: TEdit
        Left = 271
        Top = 184
        Width = 121
        Height = 20
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        Text = 'edt_Temp'
        Visible = False
        OnExit = edt_TempExit
        OnKeyPress = edt_TempKeyPress
      end
    end
  end
  object RzPanel2: TRzPanel
    Left = 0
    Top = 511
    Width = 800
    Height = 39
    Align = alBottom
    BorderOuter = fsNone
    TabOrder = 2
    DesignSize = (
      800
      39)
    object btn_Save: TRzBitBtn
      Left = 20
      Top = 6
      Anchors = [akLeft, akBottom]
      Caption = #20445#23384
      TabOrder = 0
      OnClick = btn_SaveClick
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 384
    Top = 80
  end
end
