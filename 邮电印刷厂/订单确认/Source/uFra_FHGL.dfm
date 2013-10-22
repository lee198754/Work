object Fra_FHGL: TFra_FHGL
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
    Height = 65
    Align = alTop
    Caption = #26597#35810
    TabOrder = 0
    object Label3: TLabel
      Left = 176
      Top = 43
      Width = 12
      Height = 12
      Caption = #65374
    end
    object edt_gdh: Ti_TxtFilter
      Left = 254
      Top = 16
      Width = 155
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
    object btn_cx: TRzBitBtn
      Left = 621
      Top = 35
      Caption = #26597#35810
      TabOrder = 4
      OnClick = btn_cxClick
    end
    object dtp_jcq: TRzDateTimePicker
      Left = 80
      Top = 40
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      Enabled = False
      TabOrder = 1
    end
    object dtp_jcz: TRzDateTimePicker
      Left = 192
      Top = 40
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      Enabled = False
      TabOrder = 2
    end
    object cb_jcrq: TRzCheckBox
      Left = 8
      Top = 43
      Width = 73
      Height = 17
      Caption = #36827#20179#26085#26399
      State = cbUnchecked
      TabOrder = 3
      OnClick = cb_jcrqClick
    end
    object edt_cpbh: Ti_TxtFilter
      Left = 54
      Top = 16
      Width = 155
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
    object cbb_jcqk: Ti_ComboBox
      Left = 472
      Top = 16
      Width = 89
      Height = 20
      EditLabel.Width = 48
      EditLabel.Height = 12
      EditLabel.Caption = #36827#20179#24773#20917
      EditLabel.Transparent = True
      LabelCaption = #36827#20179#24773#20917
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 6
      Text = #20840#37096
      Items.Strings = (
        #20840#37096
        #26410#36827#20179#30830#35748
        #24050#36827#20179#30830#35748)
      ItemIndex = 0
    end
  end
  object gb_dd: TRzGroupBox
    Left = 0
    Top = 65
    Width = 800
    Height = 496
    Align = alClient
    Caption = #35746#21333
    TabOrder = 1
    object dbg_jhxd_dzx: TDBGridEh
      Left = 1
      Top = 13
      Width = 798
      Height = 453
      Align = alClient
      ColumnDefValues.Layout = tlCenter
      ColumnDefValues.Title.Alignment = taCenter
      ColumnDefValues.Title.TitleButton = True
      ColumnDefValues.ToolTips = True
      Ctl3D = True
      DataGrouping.GroupLevels = <>
      DataSource = DM_DataBase.ds_FHCX
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
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      OptionsEh = [dghFixed3D, dghFooter3D, dghClearSelection, dghFitRowHeightToText, dghAutoSortMarking, dghMultiSortMarking, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghColumnResize, dghColumnMove, dghAutoFitRowHeight, dghHotTrack, dghExtendVertLines]
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
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
      TitleHeight = 16
      VertScrollBar.SmoothStep = True
      OnTitleClick = dbg_jhxd_dzxTitleClick
      Columns = <
        item
          Checkboxes = True
          EditButtons = <>
          FieldName = 'FH'
          Footers = <>
          Title.Caption = #21457#36135
          Title.TitleButton = False
          Width = 46
        end
        item
          EditButtons = <>
          FieldName = 'JCQR'
          Footers = <>
          Title.Caption = #36827#20179#24773#20917
          Width = 60
        end
        item
          EditButtons = <>
          FieldName = 'JCSJS'
          Footers = <>
          Title.Caption = #36827#20179#25195#20214#25968
          Width = 66
        end
        item
          EditButtons = <>
          FieldName = 'SBSL'
          Footers = <>
          ReadOnly = True
          Title.Caption = #30003#25253#25968#37327
          Width = 60
        end
        item
          EditButtons = <>
          FieldName = 'FHQK'
          Footers = <>
          Title.Caption = #21457#36135#24773#20917
          Width = 60
        end
        item
          EditButtons = <>
          FieldName = 'TGZT'
          Footers = <>
          Title.Caption = #22270#31295#29366#24577
          Width = 55
        end
        item
          EditButtons = <>
          FieldName = 'XQZT'
          Footers = <>
          Title.Caption = #31665#31614#29366#24577
          Width = 55
        end
        item
          EditButtons = <>
          FieldName = 'F_sJg'
          Footers = <>
          ReadOnly = True
          Title.Caption = #26426#26500#21517#31216
          Width = 158
        end
        item
          EditButtons = <>
          FieldName = 'F_sCpbh'
          Footers = <>
          ReadOnly = True
          Title.Caption = #20135#21697#32534#21495
          Width = 133
        end
        item
          EditButtons = <>
          FieldName = 'F_sCPLX'
          Footers = <>
          ReadOnly = True
          Title.Caption = #31181#31867
          Width = 37
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'FNJZT'
          Footers = <>
          Title.Caption = #23553'('#20869#20214')'#29366#24577
          Width = 120
        end
        item
          EditButtons = <>
          FieldName = 'CYBZ'
          Footers = <>
          Title.Caption = #37325#21360
          Width = 32
        end
        item
          EditButtons = <>
          FieldName = 'KHMC'
          Footers = <>
          Title.Caption = #23458#25143#21517#31216
          Width = 139
        end
        item
          EditButtons = <>
          FieldName = 'GDH'
          Footers = <>
          ReadOnly = True
          Title.Caption = #24037#21333#21495
          Width = 122
        end
        item
          DisplayFormat = 'yyyy-MM-dd'
          EditButtons = <>
          FieldName = 'F_dJCRQ'
          Footers = <>
          ReadOnly = True
          Title.Caption = #36827#20179#26085#26399
          Width = 95
        end
        item
          EditButtons = <>
          FieldName = 'ZRKL'
          Footers = <>
          ReadOnly = True
          Title.Caption = #24635#20837#24211#37327
          Width = 66
        end
        item
          EditButtons = <>
          FieldName = 'XYKC'
          Footers = <>
          ReadOnly = True
          Title.Caption = #29616#26377#24211#23384
          Width = 57
        end
        item
          EditButtons = <>
          FieldName = 'BCFHL'
          Footers = <>
          Title.Caption = #26412#27425#21457#36135#37327
          Visible = False
        end
        item
          EditButtons = <>
          FieldName = 'MBMS'
          Footers = <>
          Title.Caption = #27599#21253#25968#37327
          Visible = False
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object pan_data: TPanel
      Left = 1
      Top = 466
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
        Left = 559
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
        Left = 607
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
        Left = 296
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
        Left = 511
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
        Left = 655
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
        Left = 439
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
        Left = 327
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
        Left = 367
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
        Left = 407
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
        Left = 255
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
        Left = 715
        Top = 5
        Width = 33
        Height = 20
        Anchors = [akRight, akBottom]
        TabOrder = 0
      end
      object btn_go: TButton
        Left = 759
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
  object RzPanel2: TRzPanel
    Left = 0
    Top = 561
    Width = 800
    Height = 39
    Align = alBottom
    BorderOuter = fsNone
    TabOrder = 2
    DesignSize = (
      800
      39)
    object btn_ok: TRzBitBtn
      Left = 36
      Top = 7
      Height = 26
      Anchors = [akLeft, akBottom]
      Caption = #20986#20179#21333#25171#21360
      TabOrder = 0
      OnClick = btn_okClick
    end
    object btn_jcqr: TRzBitBtn
      Left = 124
      Top = 7
      Height = 26
      Anchors = [akLeft, akBottom]
      Caption = #36827#20179#30830#35748
      Enabled = False
      TabOrder = 1
      OnClick = btn_JCQRClick
    end
    object btn_cxjcqr: TRzBitBtn
      Left = 212
      Top = 7
      Width = 117
      Height = 26
      Anchors = [akLeft, akBottom]
      Caption = #25764#38144#36827#20179#30830#35748
      Enabled = False
      TabOrder = 2
      OnClick = btn_cxjcqrClick
    end
  end
end
