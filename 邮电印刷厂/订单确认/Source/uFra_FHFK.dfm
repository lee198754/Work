object Fra_FHFK: TFra_FHFK
  Left = 0
  Top = 0
  Width = 859
  Height = 461
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object gb_dd: TRzGroupBox
    Left = 0
    Top = 79
    Width = 859
    Height = 343
    Align = alClient
    Caption = #35746#21333
    TabOrder = 1
    object dbg_fhfk: TDBGridEh
      Left = 1
      Top = 13
      Width = 857
      Height = 300
      Align = alClient
      ColumnDefValues.Layout = tlCenter
      ColumnDefValues.Title.Alignment = taCenter
      ColumnDefValues.Title.TitleButton = True
      ColumnDefValues.ToolTips = True
      Ctl3D = True
      DataGrouping.GroupLevels = <>
      DataSource = DM_DataBase.ds_FHFK
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
      PopupMenu = pm_jhxd
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
      OnTitleClick = dbg_fhfkTitleClick
      Columns = <
        item
          EditButtons = <>
          FieldName = 'XZ'
          Footers = <>
          Title.Caption = #36873#25321
          Title.TitleButton = False
          Width = 45
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'TGZT'
          Footers = <>
          Title.Caption = #22270#31295#29366#24577
          Visible = False
          Width = 55
        end
        item
          EditButtons = <>
          FieldName = 'F_sCPBH'
          Footers = <>
          ReadOnly = True
          Title.Caption = #20135#21697#32534#21495
          Width = 147
        end
        item
          EditButtons = <>
          FieldName = 'CPLX'
          Footers = <>
          ReadOnly = True
          Title.Caption = #20135#21697#31867#22411
          Width = 60
        end
        item
          EditButtons = <>
          FieldName = 'F_sKhmc'
          Footers = <>
          ReadOnly = True
          Title.Caption = #23458#25143#21517#31216
          Width = 117
        end
        item
          EditButtons = <>
          FieldName = 'F_sJg'
          Footers = <>
          ReadOnly = True
          Title.Caption = #25910#36135#26426#26500
          Width = 107
        end
        item
          EditButtons = <>
          FieldName = 'FKRQ'
          Footers = <>
          Title.Caption = #21453#39304#26085#26399
          Width = 84
        end
        item
          DisplayFormat = 'yyyy-MM-dd  hh:mm:ss'
          EditButtons = <>
          FieldName = 'DDSJ'
          Footers = <>
          Title.Caption = #25171#21333#26102#38388
          Width = 84
        end
        item
          AlwaysShowEditButton = True
          EditButtons = <>
          FieldName = 'F_sFHFS'
          Footers = <>
          PickList.Strings = (
            'EMS'
            #20013#38081#24555#36816
            #26426#35201
            #33322#31354
            #27773#36816
            #33258#25552
            #20854#23427
            #20013#37038#29289#27969)
          Title.Caption = #21457#36135#26041#24335
          Width = 73
        end
        item
          EditButtons = <>
          FieldName = 'F_sYSDH'
          Footers = <>
          Title.Caption = #36816#36755#21333#21495
          Width = 107
        end
        item
          EditButtons = <>
          FieldName = 'F_iZXS'
          Footers = <>
          ReadOnly = True
          Title.Caption = #24635#31665#25968
          Width = 58
        end
        item
          EditButtons = <>
          FieldName = 'F_nYL'
          Footers = <>
          ReadOnly = True
          Title.Caption = #21360#37327'('#19975#26522')'
          Width = 79
        end
        item
          EditButtons = <>
          FieldName = 'XPL'
          Footers = <>
          ReadOnly = True
          Title.Caption = #23567#25209#37327
          Width = 61
        end
        item
          EditButtons = <>
          FieldName = 'JHDH'
          Footers = <>
          ReadOnly = True
          Title.Caption = #21360#21046#35745#21010#21333#21495
          Width = 125
        end
        item
          EditButtons = <>
          FieldName = 'JSBZ'
          Footers = <>
          ReadOnly = True
          Title.Caption = #25509#25910#26631#24535
          Width = 75
        end
        item
          EditButtons = <>
          FieldName = 'SBBZ'
          Footers = <>
          ReadOnly = True
          Title.Caption = #30465#29256#26631#24535
          Width = 76
        end
        item
          EditButtons = <>
          FieldName = 'F_sSjg'
          Footers = <>
          ReadOnly = True
          Title.Caption = #30465#26426#26500
          Width = 88
        end
        item
          EditButtons = <>
          FieldName = 'CPLB'
          Footers = <>
          ReadOnly = True
          Title.Caption = #20135#21697#31867#21035
          Width = 72
        end
        item
          EditButtons = <>
          FieldName = 'F_sBZ'
          Footers = <>
          Title.Caption = #22791#27880
          Width = 94
        end
        item
          EditButtons = <>
          FieldName = 'OrderID'
          Footers = <>
          ReadOnly = True
          Visible = False
        end
        item
          EditButtons = <>
          FieldName = 'OrderType'
          Footers = <>
          ReadOnly = True
          Visible = False
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object pan_data: TPanel
      Left = 1
      Top = 313
      Width = 857
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
        857
        29)
      object lab_up: TLabel
        Left = 618
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
        Left = 666
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
        Left = 354
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
        Left = 570
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
        Left = 714
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
        Left = 498
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
        Left = 386
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
        Left = 426
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
        Left = 466
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
        Left = 314
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
        Left = 774
        Top = 5
        Width = 33
        Height = 20
        Anchors = [akRight, akBottom]
        TabOrder = 1
      end
      object btn_go: TButton
        Left = 818
        Top = 2
        Width = 33
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Go'
        TabOrder = 0
        OnClick = btn_goClick
      end
    end
  end
  object RzPanel2: TRzPanel
    Left = 0
    Top = 422
    Width = 859
    Height = 39
    Align = alBottom
    BorderOuter = fsNone
    TabOrder = 2
    DesignSize = (
      859
      39)
    object lab_flrq: TLabel
      Left = 15
      Top = 13
      Width = 72
      Height = 12
      Caption = #29983#20135#23436#25104#26085#26399
    end
    object btn_ok: TRzBitBtn
      Left = 204
      Top = 6
      Anchors = [akLeft, akBottom]
      Caption = #21457#36135#21453#39304
      TabOrder = 1
      OnClick = btn_okClick
    end
    object dtp_fhrq: TRzDateTimePicker
      Left = 101
      Top = 9
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      TabOrder = 4
    end
    object btn_Save: TRzBitBtn
      Left = 292
      Top = 6
      Anchors = [akLeft, akBottom]
      Caption = #20445#23384
      TabOrder = 2
      OnClick = btn_SaveClick
    end
    object btn_qcdd: TButton
      Tag = 1
      Left = 384
      Top = 6
      Width = 97
      Height = 25
      Hint = #25152#36873#35746#21333#24050#20174#22269#32593#19978#36827#34892#21453#39304
      Caption = #22269#32593#24050#21453#39304
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btn_okClick
      OnMouseMove = btn_qcddMouseMove
    end
    object btn_cxfh: TButton
      Left = 494
      Top = 5
      Width = 75
      Height = 25
      Caption = #25764#38144#21457#36135
      Enabled = False
      TabOrder = 0
      OnClick = btn_cxfhClick
    end
  end
  object RzGroupBox1: TRzGroupBox
    Left = 0
    Top = 0
    Width = 859
    Height = 79
    Align = alTop
    Caption = #26597#35810
    TabOrder = 0
    object Label3: TLabel
      Left = 824
      Top = 27
      Width = 12
      Height = 12
      Caption = #65374
      Visible = False
    end
    object Label4: TLabel
      Left = 400
      Top = 51
      Width = 12
      Height = 12
      Caption = #65374
    end
    object edt_gdh: Ti_TxtFilter
      Left = 302
      Top = 16
      Width = 163
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
      Left = 541
      Top = 46
      Caption = #26597#35810
      TabOrder = 6
      OnClick = btn_cxClick
    end
    object dtp_jcq: TRzDateTimePicker
      Left = 728
      Top = 24
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      Enabled = False
      TabOrder = 3
      Visible = False
    end
    object dtp_jcz: TRzDateTimePicker
      Left = 840
      Top = 24
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      Enabled = False
      TabOrder = 4
      Visible = False
    end
    object cb_jcrq: TRzCheckBox
      Left = 656
      Top = 27
      Width = 73
      Height = 17
      Caption = #36827#20179#26085#26399
      State = cbUnchecked
      TabOrder = 5
      Visible = False
    end
    object edt_cpbh: Ti_TxtFilter
      Left = 80
      Top = 16
      Width = 147
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
    object edt_rjhdq: Ti_TxtFilter
      Left = 313
      Top = 80
      Width = 163
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #20817#22870#21495#27573#36215
      EditLabel.Transparent = True
      LabelCaption = #20817#22870#21495#27573#36215
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 13
      OnExit = edt_rjhdqExit
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
    object edt_zh: Ti_TxtFilter
      Left = 78
      Top = 80
      Width = 147
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 24
      EditLabel.Height = 12
      EditLabel.Caption = #32452#21495
      EditLabel.Transparent = True
      LabelCaption = #32452#21495
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 12
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
    object edt_rjhdz: Ti_TxtFilter
      Left = 548
      Top = 80
      Width = 163
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #20817#22870#21495#27573#36215
      EditLabel.Transparent = True
      LabelCaption = #20817#22870#21495#27573#36215
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 14
      OnExit = edt_rjhdqExit
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
    object cbb_fhbz: Ti_ComboBox
      Left = 80
      Top = 48
      Width = 145
      Height = 20
      EditLabel.Width = 72
      EditLabel.Height = 12
      EditLabel.Caption = #21457#36135#21453#39304#26631#24535
      EditLabel.Transparent = True
      LabelCaption = #21457#36135#21453#39304#26631#24535
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 8
      Text = #26410#21457#36135#21453#39304
      OnChange = cbb_fhbzChange
      Items.Strings = (
        #26410#21457#36135#21453#39304
        #24050#21457#36135#21453#39304
        #22269#32593#24050#21453#39304)
      ItemIndex = 0
    end
    object cbb_jsbz: Ti_ComboBox
      Left = 544
      Top = 16
      Width = 145
      Height = 20
      EditLabel.Width = 48
      EditLabel.Height = 12
      EditLabel.Caption = #25509#25910#26631#24535
      EditLabel.Transparent = True
      LabelCaption = #25509#25910#26631#24535
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 2
      Text = #26410#25509#25910
      Visible = False
      Items.Strings = (
        #26410#25509#25910)
      ItemIndex = 0
    end
    object dtp_fkrqq: TRzDateTimePicker
      Left = 304
      Top = 48
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      Enabled = False
      TabOrder = 9
    end
    object dtp_fkrqz: TRzDateTimePicker
      Left = 418
      Top = 48
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      Enabled = False
      TabOrder = 10
    end
    object cb_fjrq: TRzCheckBox
      Left = 234
      Top = 51
      Width = 69
      Height = 17
      Caption = #21453#39304#26085#26399
      Enabled = False
      State = cbUnchecked
      TabOrder = 11
      OnClick = cb_fjrqClick
    end
    object btn_export: TRzButton
      Left = 643
      Top = 45
      Caption = #23548#20986
      TabOrder = 7
      OnClick = btn_exportClick
    end
  end
  object SavePath: TSaveDialog
    DefaultExt = 'xls'
    Filter = 'Excel'#25991#20214'(*.xls)|*.xls'
    Left = 720
    Top = 56
  end
  object pm_jhxd: TPopupMenu
    OnPopup = pm_jhxdPopup
    Left = 736
    Top = 96
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
end
