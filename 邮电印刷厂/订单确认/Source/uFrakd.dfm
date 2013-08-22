object Fra_kd: TFra_kd
  Left = 0
  Top = 0
  Width = 794
  Height = 504
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
    Width = 794
    Height = 97
    Align = alTop
    Caption = #26597#35810
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 649
      Top = 50
      Width = 84
      Height = 14
      Caption = #37038#36164#22270#21517#31216#65306
      Visible = False
    end
    object Label4: TLabel
      Left = 415
      Top = 75
      Width = 14
      Height = 14
      Caption = #65374
    end
    object btn_cx: TRzButton
      Left = 564
      Top = 68
      Caption = #26597#35810
      TabOrder = 0
      OnClick = btn_cxClick
    end
    object cbb_ddlx: Ti_ComboBox
      Left = 324
      Top = 22
      Width = 145
      Height = 22
      EditLabel.Width = 70
      EditLabel.Height = 14
      EditLabel.Caption = #35746#21333#31867#22411#65306
      EditLabel.Transparent = True
      LabelCaption = #35746#21333#31867#22411#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 1
      Items.Strings = (
        '--'#20840#37096'--'
        #23450#21046#22411
        #38144#21806#22411)
    end
    object cbb_yztmc: TComboBox
      Left = 720
      Top = 46
      Width = 105
      Height = 22
      ItemHeight = 14
      ItemIndex = 0
      TabOrder = 2
      Text = '--'#20840#37096'--'
      Visible = False
      Items.Strings = (
        '--'#20840#37096'--'
        'L1'
        'L2'
        'L3'
        'L4'
        #26080#37038#36164#22270)
    end
    object edt_cpbh: Ti_TxtFilter
      Left = 92
      Top = 22
      Width = 153
      Height = 22
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 70
      EditLabel.Height = 14
      EditLabel.Caption = #20135#21697#32534#21495#65306
      EditLabel.Transparent = True
      LabelCaption = #20135#21697#32534#21495#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 3
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
      Left = 92
      Top = 46
      Width = 145
      Height = 22
      EditLabel.Width = 70
      EditLabel.Height = 14
      EditLabel.Caption = #20135#21697#31867#21035#65306
      EditLabel.Transparent = True
      LabelCaption = #20135#21697#31867#21035#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 4
      OnChange = cbb_cplbChange
      Items.Strings = (
        '--'#20840#37096'--'
        #37038#36164#36154#21345)
    end
    object cbb_cplx: Ti_ComboBox
      Left = 324
      Top = 46
      Width = 145
      Height = 22
      EditLabel.Width = 70
      EditLabel.Height = 14
      EditLabel.Caption = #20135#21697#31867#22411#65306
      EditLabel.Transparent = True
      LabelCaption = #20135#21697#31867#22411#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 5
      Items.Strings = (
        '--'#20840#37096'--')
    end
    object cbb_nf: Ti_ComboBox
      Left = 713
      Top = 69
      Width = 73
      Height = 22
      EditLabel.Width = 70
      EditLabel.Height = 14
      EditLabel.Caption = #24180#20221#26631#35782#65306
      EditLabel.Transparent = True
      LabelCaption = #24180#20221#26631#35782#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 6
      Text = '12'
      Visible = False
      OnChange = cbb_cplbChange
      Items.Strings = (
        '12')
      ItemIndex = 0
    end
    object cbb_xpl: Ti_ComboBox
      Left = 93
      Top = 71
      Width = 97
      Height = 22
      EditLabel.Width = 84
      EditLabel.Height = 14
      EditLabel.Caption = #26159#21542#23567#25209#37327#65306
      EditLabel.Transparent = True
      LabelCaption = #26159#21542#23567#25209#37327#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 7
      Text = #20840#37096
      Items.Strings = (
        #20840#37096
        #21542
        #26159)
      ItemIndex = 0
    end
    object cbb_qyzt: Ti_ComboBox
      Left = 549
      Top = 23
      Width = 152
      Height = 22
      EditLabel.Width = 70
      EditLabel.Height = 14
      EditLabel.Caption = #31614#26679#29366#24577#65306
      EditLabel.Transparent = True
      LabelCaption = #31614#26679#29366#24577#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 8
      Text = #24050#31614#26679'('#21253#21547#19981#31614#26679')'
      Visible = False
      Items.Strings = (
        #20840#37096
        #26410#31614#26679
        #24050#31614#26679'('#21253#21547#19981#31614#26679')')
      ItemIndex = 2
    end
    object cb_syyl: TRzCheckBox
      Left = 235
      Top = 74
      Width = 90
      Height = 17
      Caption = #21097#20313#21360#37327#65306
      State = cbUnchecked
      TabOrder = 9
      OnClick = cb_syylClick
    end
    object edt_syylq: TEdit
      Left = 324
      Top = 71
      Width = 81
      Height = 22
      Color = clBtnFace
      Enabled = False
      TabOrder = 10
    end
    object edt_syylz: TEdit
      Left = 436
      Top = 71
      Width = 81
      Height = 22
      Color = clBtnFace
      Enabled = False
      TabOrder = 11
    end
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 97
    Width = 794
    Height = 369
    Align = alClient
    BorderOuter = fsNone
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 794
      Height = 369
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel1'
      TabOrder = 0
      object gb_dd: TRzGroupBox
        Left = 0
        Top = 0
        Width = 794
        Height = 369
        Align = alClient
        Caption = #35746#21333
        TabOrder = 0
        object lv_jhxd: TRzListView
          Left = 1
          Top = 15
          Width = 792
          Height = 324
          Align = alClient
          Checkboxes = True
          Columns = <
            item
              Caption = #36873#25321
            end
            item
              Caption = #26426#26500#21517#31216
              Width = 150
            end
            item
              Caption = #20135#21697#32534#21495
              Width = 160
            end
            item
              Caption = #20135#21697#31867#22411
              Width = 70
            end
            item
              Caption = #37038#36164#22270
              Width = 70
            end
            item
              Caption = #26469#31295#26085#26399
              Width = 100
            end
            item
              Caption = #23458#25143#21517#31216
              Width = 170
            end
            item
              Caption = #24635#21360#37327
              Width = 60
            end
            item
              Caption = #29305#27530#24037#33402
              Width = 90
            end
            item
              Caption = #38468#21152#24037#33402
              Width = 90
            end
            item
              Caption = #21152#21360
              Width = 45
            end
            item
              Caption = #37325#21360
              Width = 45
            end
            item
              Caption = #21097#20313#21360#37327
              Width = 70
            end
            item
              Caption = #26159#21542#31614#26679
              Width = 70
            end
            item
              Caption = #23567#25209#37327
              Width = 60
            end
            item
              Caption = #22270#31295#29366#24577
              Width = 140
            end>
          RowSelect = True
          SmallImages = ImageList1
          TabOrder = 0
          ViewStyle = vsReport
          OnCheckStateChange = lv_jhxdCheckStateChange
          OnColumnClick = lv_jhxdColumnClick
          OnCustomDrawItem = lv_jhxdCustomDrawItem
          OnMouseDown = lv_jhxdMouseDown
        end
        object pan_data: TPanel
          Left = 1
          Top = 339
          Width = 792
          Height = 29
          Align = alBottom
          BevelOuter = bvNone
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -14
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          DesignSize = (
            792
            29)
          object lab_up: TLabel
            Left = 546
            Top = 9
            Width = 42
            Height = 14
            Cursor = crHandPoint
            Anchors = [akRight, akBottom]
            Caption = #19978#19968#39029
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            OnClick = lab_upClick
          end
          object lab_down: TLabel
            Left = 594
            Top = 9
            Width = 42
            Height = 14
            Cursor = crHandPoint
            Anchors = [akRight, akBottom]
            Caption = #19979#19968#39029
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            OnClick = lab_downClick
          end
          object lab_ts50: TLabel
            Tag = 50
            Left = 282
            Top = 9
            Width = 28
            Height = 14
            Cursor = crHandPoint
            Anchors = [akRight, akBottom]
            Caption = '50 |'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            OnClick = lab_ts50Click
          end
          object lab_first: TLabel
            Left = 498
            Top = 9
            Width = 42
            Height = 14
            Cursor = crHandPoint
            Anchors = [akRight, akBottom]
            Caption = #31532#19968#39029
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            OnClick = lab_firstClick
          end
          object lab_last: TLabel
            Left = 642
            Top = 9
            Width = 56
            Height = 14
            Cursor = crHandPoint
            Anchors = [akRight, akBottom]
            Caption = #26368#21518#19968#39029
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            OnClick = lab_lastClick
          end
          object Label2: TLabel
            Left = 426
            Top = 9
            Width = 14
            Height = 14
            Anchors = [akRight, akBottom]
            Caption = #26465
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_zys: TLabel
            Left = 16
            Top = 9
            Width = 63
            Height = 14
            Anchors = [akLeft, akBottom]
            Caption = #39029#27425#65306'0/0'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lab_ts100: TLabel
            Tag = 100
            Left = 314
            Top = 9
            Width = 35
            Height = 14
            Cursor = crHandPoint
            Anchors = [akRight, akBottom]
            Caption = '100 |'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            OnClick = lab_ts50Click
          end
          object lab_ts200: TLabel
            Tag = 200
            Left = 354
            Top = 9
            Width = 35
            Height = 14
            Cursor = crHandPoint
            Anchors = [akRight, akBottom]
            Caption = '200 |'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            OnClick = lab_ts50Click
          end
          object lab_ts500: TLabel
            Tag = 500
            Left = 394
            Top = 9
            Width = 21
            Height = 14
            Cursor = crHandPoint
            Anchors = [akRight, akBottom]
            Caption = '500'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            OnClick = lab_ts50Click
          end
          object Label6: TLabel
            Left = 242
            Top = 9
            Width = 28
            Height = 14
            Anchors = [akRight, akBottom]
            Caption = #27599#39029
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edt_ys: TEdit
            Left = 702
            Top = 5
            Width = 33
            Height = 22
            Anchors = [akRight, akBottom]
            TabOrder = 0
          end
          object btn_go: TButton
            Left = 746
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
  end
  object RzPanel2: TRzPanel
    Left = 0
    Top = 466
    Width = 794
    Height = 38
    Align = alBottom
    BorderOuter = fsNone
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      794
      38)
    object btn_kgd_old: TRzBitBtn
      Left = 198
      Top = 8
      Height = 23
      Align = alCustom
      Caption = #24320#24037#21333
      TabOrder = 0
      Visible = False
      OnClick = btn_kgd_oldClick
    end
    object cb_Cookie: TRzCheckBox
      Left = 632
      Top = 13
      Width = 97
      Height = 17
      Anchors = [akRight, akBottom]
      Caption = #20351#29992'Cookie'
      Checked = True
      State = cbChecked
      TabOrder = 1
      Visible = False
    end
    object btn_kgd: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = #24320#24037#21333
      TabOrder = 2
      OnClick = btn_kgdClick
    end
  end
  object ImageList1: TImageList
    Height = 20
    Width = 0
    Left = 712
    Top = 144
  end
  object pm_jhxd: TPopupMenu
    Left = 680
    Top = 144
    object menu_ddmx: TMenuItem
      Caption = #35746#21333#26126#32454
      OnClick = menu_ddmxClick
    end
    object menu_ddmxPic: TMenuItem
      Caption = #35746#21333#26126#32454'('#21547#22270#31295')'
      Visible = False
      OnClick = menu_ddmxClick
    end
  end
end
