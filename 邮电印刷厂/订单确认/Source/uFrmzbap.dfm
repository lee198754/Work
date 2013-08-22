object Frm_zbap: TFrm_zbap
  Left = 240
  Top = 111
  Width = 1002
  Height = 613
  Caption = #21046#29256#23433#25490
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object RzGroupBar1: TRzGroupBar
    Left = 0
    Top = 0
    Width = 225
    Height = 575
    GradientColorStart = clBtnFace
    GradientColorStop = clBtnShadow
    GroupBorderSize = 8
    Color = clBtnShadow
    ParentColor = False
    TabOrder = 0
    object RzGroup1: TRzGroup
      Items = <>
      Opened = True
      OpenedHeight = 89
      DividerVisible = False
      Caption = #22522#26412#20449#24687
      ParentColor = False
      object lab_gzdh: Ti_Label
        Left = 72
        Top = 32
        Width = 48
        Height = 12
        Caption = 'lab_gzdh'
        EditLabel.Width = 60
        EditLabel.Height = 12
        EditLabel.Caption = #24037#20316#21333#21495#65306
        EditLabel.Transparent = True
        LabelCaption = #24037#20316#21333#21495#65306
        LabelPosition = lpLeft
        LabelSpacing = 3
      end
      object lab_cpmc: Ti_Label
        Left = 72
        Top = 56
        Width = 48
        Height = 12
        Caption = 'lab_cpmc'
        EditLabel.Width = 60
        EditLabel.Height = 12
        EditLabel.Caption = #20135#21697#21517#31216#65306
        EditLabel.Transparent = True
        LabelCaption = #20135#21697#21517#31216#65306
        LabelPosition = lpLeft
        LabelSpacing = 3
      end
    end
    object RzGroup2: TRzGroup
      Items = <>
      Opened = True
      OpenedHeight = 440
      DividerVisible = False
      Caption = #20854#20182
      ParentColor = False
      object Label1: TLabel
        Left = 10
        Top = 36
        Width = 60
        Height = 12
        Caption = #25509#31295#26085#26399#65306
      end
      object Label2: TLabel
        Left = 10
        Top = 66
        Width = 60
        Height = 12
        Caption = #23436#31295#26085#26399#65306
      end
      object Label3: TLabel
        Left = 32
        Top = 128
        Width = 36
        Height = 12
        Caption = #22791#27880#65306
      end
      object dtp_jgrq: TRzDateTimePicker
        Left = 72
        Top = 32
        Width = 121
        Height = 20
        Date = 40809.452999421290000000
        Time = 40809.452999421290000000
        TabOrder = 0
      end
      object dtp_wgrq: TRzDateTimePicker
        Left = 72
        Top = 62
        Width = 121
        Height = 20
        Date = 40809.452999421290000000
        Time = 40809.452999421290000000
        TabOrder = 1
      end
      object cbb_zgsh: Ti_ComboBox
        Left = 72
        Top = 92
        Width = 121
        Height = 20
        EditLabel.Width = 60
        EditLabel.Height = 12
        EditLabel.Caption = #20027#31649#30003#26680#65306
        EditLabel.Transparent = True
        LabelCaption = #20027#31649#30003#26680#65306
        LabelPosition = lpLeft
        LabelSpacing = 3
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 2
      end
      object mmo_bz: TRzMemo
        Left = 72
        Top = 128
        Width = 121
        Height = 121
        TabOrder = 3
      end
    end
  end
  object RzPanel1: TRzPanel
    Left = 225
    Top = 0
    Width = 761
    Height = 575
    Align = alClient
    BorderOuter = fsNone
    TabOrder = 1
    DesignSize = (
      761
      575)
    object RzButton1: TRzButton
      Left = 30
      Top = 533
      Anchors = [akLeft, akBottom]
      Caption = #20445#23384
      TabOrder = 0
      OnClick = RzButton1Click
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 761
      Height = 56
      Align = alTop
      Caption = #24405#20837
      TabOrder = 1
      DesignSize = (
        761
        56)
      object cbb_gx: Ti_ComboBox
        Left = 48
        Top = 20
        Width = 121
        Height = 20
        EditLabel.Width = 36
        EditLabel.Height = 12
        EditLabel.Caption = #24037#24207#65306
        EditLabel.Transparent = True
        LabelCaption = #24037#24207#65306
        LabelPosition = lpLeft
        LabelSpacing = 3
        Anchors = [akLeft, akBottom]
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 0
      end
      object cbb_czr: Ti_ComboBox
        Left = 528
        Top = 20
        Width = 121
        Height = 20
        EditLabel.Width = 48
        EditLabel.Height = 12
        EditLabel.Caption = #25805#20316#20154#65306
        EditLabel.Transparent = True
        LabelCaption = #25805#20316#20154#65306
        LabelPosition = lpLeft
        LabelSpacing = 3
        Anchors = [akLeft, akBottom]
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 1
      end
      object cbb_ks: Ti_ComboBox
        Left = 224
        Top = 20
        Width = 121
        Height = 20
        EditLabel.Width = 36
        EditLabel.Height = 12
        EditLabel.Caption = #24320#25968#65306
        EditLabel.Transparent = True
        LabelCaption = #24320#25968#65306
        LabelPosition = lpLeft
        LabelSpacing = 3
        Anchors = [akLeft, akBottom]
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 2
      end
      object btn_Add: TRzButton
        Left = 672
        Top = 18
        Anchors = [akLeft, akBottom]
        Caption = #28155#21152
        TabOrder = 3
        OnClick = btn_AddClick
      end
      object edt_sl: Ti_TxtFilter
        Left = 394
        Top = 20
        Width = 75
        Height = 20
        Alignment = taLeftJustify
        WordWrap = False
        WantReturns = False
        WantTabs = False
        ZeroToEmpty = False
        EditLabel.Width = 36
        EditLabel.Height = 12
        EditLabel.Caption = #25968#37327#65306
        EditLabel.Transparent = True
        LabelCaption = #25968#37327#65306
        LabelPosition = lpLeft
        LabelSpacing = 3
        TabEnter = True
        TabOrder = 4
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
      Top = 56
      Width = 761
      Height = 455
      Align = alTop
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = #23433#25490#34920
      TabOrder = 2
      object lv_ap: TRzListView
        Left = 1
        Top = 13
        Width = 759
        Height = 441
        Align = alClient
        Columns = <
          item
            Caption = #24037#24207
            Width = 80
          end
          item
            Caption = #24320#25968
          end
          item
            Caption = #25968#37327
          end
          item
            Caption = #25805#20316#20154
            Width = 558
          end>
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnMouseDown = lv_apMouseDown
      end
    end
  end
  object pm_ap: TPopupMenu
    Left = 585
    Top = 224
    object menu_Del: TMenuItem
      Caption = #21024#38500
      OnClick = menu_DelClick
    end
  end
end
