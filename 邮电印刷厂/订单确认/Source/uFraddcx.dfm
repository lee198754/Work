object Fra_ddcx: TFra_ddcx
  Left = 327
  Top = 211
  Width = 800
  Height = 554
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  object gb_cx: TRzGroupBox
    Left = 0
    Top = 0
    Width = 784
    Height = 169
    Align = alTop
    Caption = #26597#35810
    TabOrder = 0
    object Label3: TLabel
      Left = 218
      Top = 146
      Width = 12
      Height = 12
      Caption = #65374
    end
    object Label1: TLabel
      Left = 655
      Top = 114
      Width = 12
      Height = 12
      Caption = #65374
    end
    object cbb_bb: Ti_ComboBox
      Left = 296
      Top = 14
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
      Text = '--'#20840#37096'--'
      OnChange = cbb_bbChange
      Items.Strings = (
        '--'#20840#37096'--'
        #23450#21046#22411
        #38144#21806#22411)
      ItemIndex = 0
    end
    object edt_cpbh: Ti_TxtFilter
      Left = 80
      Top = 14
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
      Top = 46
      Width = 137
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
      TabOrder = 3
      OnChange = cbb_cplbChange
    end
    object cbb_cplx: Ti_ComboBox
      Left = 296
      Top = 46
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
      TabOrder = 4
      Text = '--'#20840#37096'--'
      Items.Strings = (
        '--'#20840#37096'--')
      ItemIndex = 0
    end
    object cbb_nf: Ti_ComboBox
      Left = 685
      Top = 14
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
      TabOrder = 9
      Text = '12'
      Visible = False
      OnChange = cbb_cplbChange
      Items.Strings = (
        '12')
      ItemIndex = 0
    end
    object dtp_jsq: TRzDateTimePicker
      Left = 122
      Top = 142
      Width = 89
      Height = 20
      Date = 40801.000000000000000000
      Time = 40801.000000000000000000
      Enabled = False
      TabOrder = 7
    end
    object dtp_jsz: TRzDateTimePicker
      Left = 234
      Top = 142
      Width = 89
      Height = 20
      Date = 40801.000000000000000000
      Time = 40801.000000000000000000
      Enabled = False
      TabOrder = 8
    end
    object cb_jsrq: TRzCheckBox
      Left = 17
      Top = 144
      Width = 103
      Height = 17
      Caption = #35746#21333#19979#36798#26085#26399#65306
      State = cbUnchecked
      TabOrder = 6
      OnClick = cb_jsrqClick
    end
    object cbb_xpl: Ti_ComboBox
      Left = 519
      Top = 16
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
      TabOrder = 2
      Text = '--'#20840#37096'--'
      Items.Strings = (
        '--'#20840#37096'--'
        #21542
        #26159)
      ItemIndex = 0
    end
    object btn_cx: TRzButton
      Left = 498
      Top = 138
      Caption = #26597#35810
      TabOrder = 5
      OnClick = btn_cxClick
    end
    object edt_gdh: Ti_TxtFilter
      Left = 80
      Top = 78
      Width = 137
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 48
      EditLabel.Height = 12
      EditLabel.Caption = #24037#21333#21495#65306
      EditLabel.Transparent = True
      LabelCaption = #24037#21333#21495#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 10
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
    object cbb_scjd: Ti_ComboBox
      Left = 519
      Top = 46
      Width = 97
      Height = 20
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #29983#20135#36827#24230#65306
      EditLabel.Transparent = True
      LabelCaption = #29983#20135#36827#24230#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 11
      Text = '--'#20840#37096'--'
      Items.Strings = (
        '--'#20840#37096'--'
        #26410#24320#21333
        #21046#29256
        #21360#21047
        #25171#21495
        #21518#36947#21152#24037
        #36827#20179#24453#30830#35748
        #24050#36827#20179
        #24050#25171#21360#20986#20179#21333
        #24050#21457#36135)
      ItemIndex = 0
    end
    object edt_jgmc: Ti_TxtFilter
      Left = 296
      Top = 78
      Width = 137
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #26426#26500#21517#31216#65306
      EditLabel.Transparent = True
      LabelCaption = #26426#26500#21517#31216#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 12
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
    object edt_kfmc: Ti_TxtFilter
      Left = 517
      Top = 78
      Width = 180
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #23458#25143#21517#31216#65306
      EditLabel.Transparent = True
      LabelCaption = #23458#25143#21517#31216#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 13
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
    object btn_export: TRzButton
      Left = 587
      Top = 138
      Caption = #23548#20986
      TabOrder = 14
      OnClick = btn_exportClick
    end
    object cb_ljhrqfw: TRzCheckBox
      Left = 505
      Top = 112
      Width = 115
      Height = 17
      Caption = #31163#20132#36135#26085#26399#33539#22260#65306
      State = cbUnchecked
      TabOrder = 15
      OnClick = cb_ljhrqfwClick
    end
    object edt_ljhrqq: TEdit
      Left = 624
      Top = 110
      Width = 25
      Height = 20
      Color = clBtnFace
      Enabled = False
      TabOrder = 16
    end
    object edt_ljhrqz: TEdit
      Left = 675
      Top = 110
      Width = 25
      Height = 20
      Color = clBtnFace
      Enabled = False
      TabOrder = 17
    end
    object cbb_tgzt: Ti_ComboBox
      Left = 689
      Top = 46
      Width = 88
      Height = 20
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #22270#31295#29366#24577#65306
      EditLabel.Transparent = True
      LabelCaption = #22270#31295#29366#24577#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 18
      Text = '--'#20840#37096'--'
      Items.Strings = (
        '--'#20840#37096'--'
        #26410#25910#21040
        #24050#25910#21040
        #26410#21512#26684
        #24050#21512#26684
        #24050#25171#26679
        #24050#31614#26679
        #21457#36135#24453#21512#26684
        #21457#36135#24453#31614#26679)
      ItemIndex = 0
    end
    object cbb_txlx: Ti_ComboBox
      Left = 296
      Top = 110
      Width = 177
      Height = 20
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #25552#37266#31867#22411#65306
      EditLabel.Transparent = True
      LabelCaption = #25552#37266#31867#22411#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 19
      Text = #26080
      Items.Strings = (
        #26080
        #29983#20135#21608#26399#32467#26463#26410#21457#36135#21453#39304)
      ItemIndex = 0
    end
    object edt_ysdh: Ti_TxtFilter
      Left = 80
      Top = 110
      Width = 137
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #36816#36755#21333#21495#65306
      EditLabel.Transparent = True
      LabelCaption = #36816#36755#21333#21495#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 20
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
      Left = 680
      Top = 144
      Width = 97
      Height = 17
      Caption = #21382#21490#35746#21333
      TabOrder = 21
    end
    object cb_cybz: Ti_ComboBox
      Left = 400
      Top = 142
      Width = 81
      Height = 20
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #37325#21360#26631#24535#65306
      EditLabel.Transparent = True
      LabelCaption = #37325#21360#26631#24535#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 22
      Text = '--'#20840#37096'--'
      Items.Strings = (
        '--'#20840#37096'--'
        #26080
        #37325#21360)
      ItemIndex = 0
    end
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 169
    Width = 784
    Height = 347
    Align = alClient
    BorderOuter = fsNone
    TabOrder = 1
    object gb_dd: TRzGroupBox
      Left = 0
      Top = 0
      Width = 784
      Height = 347
      Align = alClient
      Caption = #35746#21333
      TabOrder = 0
      object dbg_jhxd: TDBGridEh
        Left = 1
        Top = 13
        Width = 782
        Height = 304
        Align = alClient
        ColumnDefValues.Layout = tlCenter
        ColumnDefValues.Title.Alignment = taCenter
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.ToolTips = True
        Ctl3D = True
        DataGrouping.GroupLevels = <>
        DataSource = DM_DataBase.ds_show
        Flat = True
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -12
        FooterFont.Name = #26032#23435#20307
        FooterFont.Style = []
        FrozenCols = 3
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghFooter3D, dghClearSelection, dghFitRowHeightToText, dghAutoSortMarking, dghMultiSortMarking, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghColumnResize, dghColumnMove, dghAutoFitRowHeight, dghHotTrack, dghExtendVertLines]
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        PopupMenu = pm_jhxd
        ReadOnly = True
        RowDetailPanel.Color = clBtnFace
        RowHeight = 2
        RowLines = 2
        RowSizingAllowed = True
        ShowHint = True
        SortLocal = True
        STFilter.Local = True
        STFilter.Location = stflInTitleFilterEh
        TabOrder = 0
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #26032#23435#20307
        TitleFont.Style = []
        TitleHeight = 12
        VertScrollBar.SmoothStep = True
        OnCellClick = dbg_jhxdCellClick
        OnTitleClick = dbg_jhxdTitleClick
        Columns = <
          item
            DropDownBox.Options = [dlgColLinesEh, dlgRowLinesEh]
            EditButtons = <>
            FieldName = 'F_sJg'
            Footers = <>
            Title.Caption = #25215#25597#26426#26500#21517#31216
            Width = 143
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'CPBH'
            Footers = <>
            Title.Caption = #20135#21697#32534#21495
            Width = 138
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'CPLX'
            Footers = <>
            Title.Caption = #31181#31867
            Width = 51
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'F_sYztmc'
            Footers = <>
            Title.Caption = #37038#36164#22270
            Width = 67
          end
          item
            AutoFitColWidth = False
            DisplayFormat = 'yyyy-MM-dd  hh:mm:ss'
            EditButtons = <>
            FieldName = 'JSQR'
            Footers = <>
            Title.Caption = #35746#21333#19979#36798#26085#26399
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'LGRQ'
            Footers = <>
            Title.Caption = #26469#31295#26085#26399
            Width = 75
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'YL'
            Footers = <>
            Title.Caption = #21360#37327
            Width = 53
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'JYBZ'
            Footers = <>
            Title.Caption = #21152#21360
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'CYBZ'
            Footers = <>
            Title.Caption = #37325#21360
            Width = 45
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'XPL'
            Footers = <>
            Title.Caption = #23567#25209#37327
            Width = 60
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'GDH'
            Footers = <>
            Title.Caption = #24037#21333#21495
            Width = 98
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'SCZT'
            Footers = <>
            Title.Caption = #29983#20135#36827#24230
            Width = 98
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'JHRQ'
            Footers = <>
            Title.Caption = #20132#36135#26085#26399
            Width = 119
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'TS'
            Footers = <>
            Title.Caption = #31163#20132#36135#22825#25968
            Width = 91
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'QY'
            Footers = <>
            Title.Caption = #26159#21542#31614#26679
            Width = 72
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'F_sShr'
            Footers = <>
            Title.Caption = #25910#36135#20154#22995#21517
            Width = 86
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'F_sKhmc'
            Footers = <>
            Title.Caption = #23458#25143#21517#31216
            Width = 191
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'F_iGjs'
            Footers = <>
            Title.Caption = #31295#20214#25968
            Width = 63
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'F_sCpcc'
            Footers = <>
            Title.Caption = #25104#21697#23610#23544
            Width = 69
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'TGZT'
            Footers = <>
            Title.Caption = #22270#31295#29366#24577
            Width = 71
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'F_dCzrq'
            Footers = <>
            Title.Caption = #25805#20316#26085#26399
            Width = 119
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'FKZT'
            Footers = <>
            Title.Caption = #21453#39304#29366#24577
            Width = 70
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'F_dFkrq'
            Footers = <>
            Title.Caption = #21453#39304#26085#26399
            Width = 131
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'OrderID'
            Footers = <>
            Visible = False
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'OrderType'
            Footers = <>
            Visible = False
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object pan_data: TPanel
        Left = 1
        Top = 317
        Width = 782
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
          782
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
          Left = 114
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
          Visible = False
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
          Left = 434
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
          Left = 146
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
          Visible = False
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
        object lab_ts15: TLabel
          Tag = 15
          Left = 298
          Top = 9
          Width = 24
          Height = 12
          Cursor = crHandPoint
          Anchors = [akRight, akBottom]
          Caption = '15 |'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = #26032#23435#20307
          Font.Style = []
          ParentFont = False
          OnClick = lab_ts50Click
        end
        object lab_ts20: TLabel
          Tag = 20
          Left = 330
          Top = 9
          Width = 24
          Height = 12
          Cursor = crHandPoint
          Anchors = [akRight, akBottom]
          Caption = '20 |'
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
  object pm_jhxd: TPopupMenu
    OnPopup = pm_jhxdPopup
    Left = 664
    Top = 160
    object menu_cxfj: TMenuItem
      Caption = #37325#26032#25286#20998#35746#21333
      Visible = False
      OnClick = menu_cxfjClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object menu_ddmx: TMenuItem
      Caption = #35746#21333#26126#32454
      OnClick = menu_ddmxClick
    end
    object menu_ddmxPic: TMenuItem
      Caption = #35746#21333#26126#32454'('#21547#22270#31295')'
      Visible = False
      OnClick = menu_ddmxClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object menu_ztmx: TMenuItem
      Caption = #29366#24577#26126#32454
      OnClick = menu_ztmxClick
    end
    object menu_fhmx: TMenuItem
      Caption = #21457#36135#26126#32454
      OnClick = menu_fhmxClick
    end
  end
  object ImageList1: TImageList
    Height = 20
    Width = 0
    Left = 600
    Top = 264
  end
  object tmr_cx: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmr_cxTimer
    Left = 728
    Top = 96
  end
  object SavePath: TSaveDialog
    DefaultExt = 'xls'
    Filter = 'Excel'#25991#20214'(*.xls)|*.xls'
    Left = 728
    Top = 112
  end
end
