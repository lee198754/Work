object Fra_WarehEntryBarCode: TFra_WarehEntryBarCode
  Left = 0
  Top = 0
  Width = 800
  Height = 600
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object RzGroupBox2: TRzGroupBox
    Left = 0
    Top = 0
    Width = 800
    Height = 561
    Align = alClient
    TabOrder = 0
    object RzPanel1: TRzPanel
      Left = 1
      Top = 15
      Width = 798
      Height = 34
      Align = alTop
      BorderOuter = fsNone
      TabOrder = 0
      DesignSize = (
        798
        34)
      object RzBitBtn1: TRzBitBtn
        Left = 12
        Top = 0
        Width = 101
        Anchors = [akLeft, akBottom]
        Caption = #36827#20179#23548#20837
        TabOrder = 0
        OnClick = RzBitBtn1Click
      end
    end
    object rb_fydh: TRzGroupBox
      Left = 1
      Top = 49
      Width = 798
      Height = 511
      Align = alClient
      Caption = #36827#20179#26465#24418#30721
      TabOrder = 1
      object stg_jctxm: Ti_StgEdit
        Left = 1
        Top = 15
        Width = 796
        Height = 495
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
        OnLinkClick = stg_jctxmLinkClick
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
        FormatString = #31665#31614#26465#24418#30721'|'#20135#21697#32534#21495'|'#37038#36164#22270'|'#25805#20316'|'#21097#20313#24211#23384'|'#24050#21457#36135#24635#37327'|'#26410#21457#36135#24635#37327'|||'
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
          161
          90
          66
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
      end
    end
  end
  object RzPanel2: TRzPanel
    Left = 0
    Top = 561
    Width = 800
    Height = 39
    Align = alBottom
    BorderOuter = fsNone
    TabOrder = 1
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
