object Fra_scgl: TFra_scgl
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
  object RzGroupBox1: TRzGroupBox
    Left = 0
    Top = 0
    Width = 782
    Height = 81
    Align = alTop
    Caption = #26597#35810
    TabOrder = 0
    object Label3: TLabel
      Left = 176
      Top = 50
      Width = 12
      Height = 12
      Caption = #65374
    end
    object Label4: TLabel
      Left = 456
      Top = 50
      Width = 12
      Height = 12
      Caption = #65374
    end
    object edt_gdh: Ti_TxtFilter
      Left = 78
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
      Left = 573
      Top = 45
      Caption = #26597#35810
      TabOrder = 8
      OnClick = btn_cxClick
    end
    object dtp_kdq: TRzDateTimePicker
      Left = 80
      Top = 47
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      Enabled = False
      TabOrder = 2
    end
    object dtp_kdz: TRzDateTimePicker
      Left = 192
      Top = 47
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      Enabled = False
      TabOrder = 3
    end
    object dtp_jhq: TRzDateTimePicker
      Left = 364
      Top = 47
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      Enabled = False
      TabOrder = 4
    end
    object dtp_jhz: TRzDateTimePicker
      Left = 472
      Top = 47
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      Enabled = False
      TabOrder = 5
    end
    object cbb_sczt: Ti_ComboBox
      Left = 328
      Top = 16
      Width = 140
      Height = 20
      EditLabel.Width = 30
      EditLabel.Height = 12
      EditLabel.Caption = #29366#24577':'
      EditLabel.Transparent = True
      LabelCaption = #29366#24577':'
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 1
      Text = #21046#29256
      Items.Strings = (
        #21046#29256
        #21360#21047
        #25171#21495
        #21518#36947#21152#24037
        #36827#20179
        #21457#36135
        #24050#21457#36135
        #24050#21360#21047#38750#20869#20214
        #24050#25171#21495#25110#24050#21360#21047#20869#20214)
      ItemIndex = 0
    end
    object cb_kdrq: TRzCheckBox
      Left = 8
      Top = 50
      Width = 73
      Height = 17
      Caption = #24320#21333#26085#26399
      State = cbUnchecked
      TabOrder = 7
      OnClick = cb_kdrqClick
    end
    object cb_jhrq: TRzCheckBox
      Left = 289
      Top = 49
      Width = 73
      Height = 17
      Caption = #20132#36135#26085#26399
      State = cbUnchecked
      TabOrder = 6
      OnClick = cb_jhrqClick
    end
    object cbb_xpl: Ti_ComboBox
      Left = 553
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
      TabOrder = 9
      Text = #20840#37096
      Items.Strings = (
        #20840#37096
        #21542
        #26159)
      ItemIndex = 0
    end
  end
  object RzPanel2: TRzPanel
    Left = 0
    Top = 491
    Width = 782
    Height = 39
    Align = alBottom
    BorderOuter = fsNone
    TabOrder = 1
    DesignSize = (
      782
      39)
    object btn_ok: TRzBitBtn
      Left = 20
      Top = 7
      Anchors = [akLeft, akBottom]
      Caption = #30830#35748
      TabOrder = 1
      OnClick = btn_okClick
    end
    object btn_zbap: TRzBitBtn
      Left = 380
      Top = 6
      Anchors = [akLeft, akBottom]
      Caption = #21046#29256#23433#25490
      TabOrder = 0
      OnClick = btn_zbapClick
    end
    object btn_ysdh: TRzBitBtn
      Left = 132
      Top = 6
      Width = 101
      Anchors = [akLeft, akBottom]
      Caption = #21360#21047#25171#21495#23436#25104
      TabOrder = 2
      Visible = False
      OnClick = btn_okClick
    end
    object edt_bfjc: TRzBitBtn
      Left = 252
      Top = 6
      Anchors = [akLeft, akBottom]
      Caption = #37096#20998#36827#20179
      TabOrder = 3
      Visible = False
      OnClick = edt_bfjcClick
    end
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 81
    Width = 782
    Height = 410
    Align = alClient
    BorderOuter = fsNone
    TabOrder = 2
    object gb_ddxx: TRzGroupBox
      Left = 0
      Top = 216
      Width = 782
      Height = 194
      Align = alBottom
      Caption = #35746#21333#20449#24687
      TabOrder = 0
      Visible = False
      object lv_jtxx: TRzListView
        Left = 1
        Top = 13
        Width = 780
        Height = 180
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Caption = #36873#25321
            Width = 40
          end
          item
            Caption = #26426#21488#32534#21495
            Width = 100
          end
          item
            Caption = #26426#21488#21517#31216
            Width = 180
          end
          item
            Caption = #21360#25968
            Width = 80
          end
          item
            Caption = #25171#21360#31867#22411
            Width = 60
          end
          item
            Caption = #20854#23427
            Width = 299
          end>
        ReadOnly = True
        RowSelect = True
        SmallImages = ImageList1
        TabOrder = 0
        ViewStyle = vsReport
        Visible = False
        OnColumnClick = lv_jtxxColumnClick
        OnCustomDrawItem = lv_gdCustomDrawItem
        OnMouseDown = lv_jtxxMouseDown
      end
      object lv_gdmx: TRzListView
        Left = 1
        Top = 13
        Width = 780
        Height = 180
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Caption = #36873#25321
            Width = 40
          end
          item
            Caption = #23458#25143#21517#31216
            Width = 150
          end
          item
            Caption = #20135#21697#32534#21495
            Width = 180
          end
          item
            Caption = #24320#21333#21360#37327'('#19975#26522')'
            Width = 100
          end
          item
            Caption = #26410#36827#20179#21360#37327'('#19975#26522')'
            Width = 110
          end
          item
            Caption = #32452#21495
            Width = 40
          end
          item
            Caption = #20817#22870#21495#27573#36215
            Width = 80
          end
          item
            Caption = #20817#22870#21495#27573#27490
            Width = 80
          end
          item
            Caption = #22791#27880
            Width = 89
          end>
        ReadOnly = True
        RowSelect = True
        SmallImages = ImageList1
        TabOrder = 1
        ViewStyle = vsReport
        OnColumnClick = lv_gdmxColumnClick
        OnCustomDrawItem = lv_gdCustomDrawItem
        OnMouseDown = lv_gdmxMouseDown
      end
    end
    object gb_gd: TRzGroupBox
      Left = 0
      Top = 0
      Width = 782
      Height = 216
      Align = alClient
      Caption = #24037#21333
      TabOrder = 1
      object lv_gd: TRzListView
        Left = 1
        Top = 13
        Width = 780
        Height = 173
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Caption = #36873#25321
            Width = 40
          end
          item
            Caption = #26631#24535
            Width = 40
          end
          item
            Caption = #24037#21333#21495
            Width = 120
          end
          item
            Caption = #25143#21517
            Width = 100
          end
          item
            Caption = #21697#21517
            Width = 100
          end
          item
            Caption = #26426#21488#32534#21495
            Width = 100
          end
          item
            Caption = #26426#21488#21517#31216
            Width = 100
          end
          item
            Caption = #24320#21333#26085#26399
            Width = 130
          end
          item
            Caption = #20132#36135#26085#26399
            Width = 130
          end
          item
            Caption = #20132#29256#26085#26399
            Width = 130
          end
          item
            Caption = #21360#23436#26085#26399
            Width = 130
          end
          item
            Caption = #35013#23436#26085#26399
            Width = 130
          end>
        ReadOnly = True
        RowSelect = True
        SmallImages = ImageList1
        TabOrder = 0
        ViewStyle = vsReport
        OnColumnClick = lv_gdColumnClick
        OnCustomDrawItem = lv_gdCustomDrawItem
        OnMouseDown = lv_gdMouseDown
      end
      object pan_data: TPanel
        Left = 1
        Top = 186
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
          Left = 536
          Top = 9
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
          Left = 584
          Top = 9
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
          Left = 272
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
          Left = 488
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
          Left = 632
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
          Left = 416
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
          Top = 9
          Width = 78
          Height = 12
          Anchors = [akLeft, akBottom]
          Caption = #39029#27425#65306'100/100'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = #26032#23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lab_ts100: TLabel
          Tag = 100
          Left = 304
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
          Left = 344
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
          Left = 384
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
          Left = 232
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
          Left = 692
          Top = 5
          Width = 33
          Height = 20
          Anchors = [akRight, akBottom]
          TabOrder = 0
        end
        object btn_go: TButton
          Left = 736
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
  object ImageList1: TImageList
    Height = 20
    Width = 0
    Left = 720
    Top = 360
  end
  object pm_gd: TPopupMenu
    Left = 640
    Top = 72
    object memu_ckgd: TMenuItem
      Caption = #26597#30475#24037#21333
      OnClick = memu_ckgdClick
    end
  end
end
