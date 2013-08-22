object Frm_WorkOrder_ZB: TFrm_WorkOrder_ZB
  Left = 363
  Top = 64
  Width = 800
  Height = 600
  Caption = #21046#29256
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel1: TRzPanel
    Left = 0
    Top = 41
    Width = 784
    Height = 479
    Align = alClient
    BorderOuter = fsNone
    TabOrder = 0
    object RzGroupBox1: TRzGroupBox
      Left = 0
      Top = 0
      Width = 784
      Height = 479
      Align = alClient
      Caption = #24037#24207#20449#24687
      TabOrder = 0
      object stg_gxxx: Ti_StgEdit
        Left = 1
        Top = 43
        Width = 782
        Height = 435
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
        pt_TitleHeight = 20
        FixedFontStyle = []
        OnLinkClick = stg_gxxxLinkClick
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
        FormatString = #24037#24207#32534#21495'|'#24037#24207#21517#31216'|'#31867#21035#35268#26684'|'#20135#37327'|'#21333#20301'|'#22791#27880'|'#25805#20316'|'#25805#20316'|'
        FixedWordBreak = True
        PermitCellSizing = False
        PermitExport = True
        WordBreak = False
        FixedRowAlignmentCenter = True
        ZeroToEmpty = True
        KeepEdit = False
        EnterAddRow = False
        ColWidths = (
          94
          102
          94
          70
          45
          217
          64
          64
          64)
        RowHeights = (
          20
          20)
      end
      object RzPanel3: TRzPanel
        Left = 1
        Top = 13
        Width = 782
        Height = 30
        Align = alTop
        BorderOuter = fsNone
        TabOrder = 1
        object btn_Add: TRzButton
          Left = 9
          Top = 2
          Caption = #28155#21152
          TabOrder = 0
          OnClick = btn_AddClick
        end
      end
    end
  end
  object RzPanel2: TRzPanel
    Left = 0
    Top = 520
    Width = 784
    Height = 42
    Align = alBottom
    BorderOuter = fsNone
    TabOrder = 1
    object btn_ok: TRzButton
      Left = 229
      Top = 7
      ModalResult = 1
      Caption = #30830#35748
      TabOrder = 0
      OnClick = btn_okClick
    end
    object btn_close: TRzButton
      Left = 409
      Top = 8
      ModalResult = 2
      Caption = #20851#38381
      TabOrder = 1
    end
  end
  object RzGroupBox3: TRzGroupBox
    Left = 0
    Top = 0
    Width = 784
    Height = 41
    Align = alTop
    Caption = #26194#29256
    TabOrder = 2
    Visible = False
    object Label24: TLabel
      Left = 33
      Top = 18
      Width = 24
      Height = 12
      Caption = #26194#29256
      Color = clBtnFace
      ParentColor = False
    end
    object Label33: TLabel
      Left = 126
      Top = 17
      Width = 12
      Height = 12
      Caption = #29256
      Color = clBtnFace
      ParentColor = False
    end
    object Label34: TLabel
      Left = 206
      Top = 17
      Width = 12
      Height = 12
      Caption = #24320
      Color = clBtnFace
      ParentColor = False
    end
    object Label35: TLabel
      Left = 270
      Top = 17
      Width = 12
      Height = 12
      Caption = #22359
      Color = clBtnFace
      ParentColor = False
    end
    object edt_sbk: Ti_TxtFilter
      Tag = 3
      Left = 225
      Top = 15
      Width = 36
      Height = 20
      Hint = 'F_sSbk'
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
      MaxLength = 4
      TabOrder = 0
      OnEnter = edt_sbkEnter
      OnExit = edt_sbkExit
      OnKeyUp = edt_sbkKeyUp
      OnMouseDown = edt_sbkMouseDown
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
    object cbb_sblb: TComboBox
      Tag = 3
      Left = 60
      Top = 14
      Width = 57
      Height = 20
      Hint = 'F_sSblb'
      ItemHeight = 12
      ItemIndex = 1
      TabOrder = 1
      Text = 'CTP'
      Items.Strings = (
        'CTF'
        'CTP')
    end
    object cbb_sbks: TComboBox
      Tag = 3
      Left = 147
      Top = 14
      Width = 50
      Height = 20
      Hint = 'F_sSbks'
      ItemHeight = 12
      ItemIndex = 2
      TabOrder = 2
      Text = '4'
      Items.Strings = (
        #23545
        '3'
        '4'
        '6'
        '8')
    end
  end
  object lb_Temp: TListBox
    Left = 56
    Top = 528
    Width = 121
    Height = 98
    Ctl3D = False
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #26032#23435#20307
    Font.Style = []
    ItemHeight = 16
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7')
    ParentCtl3D = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Visible = False
    OnKeyDown = lb_TempKeyDown
    OnKeyUp = lb_TempKeyUp
    OnMouseDown = lb_TempMouseDown
    OnMouseMove = lb_TempMouseMove
  end
end
