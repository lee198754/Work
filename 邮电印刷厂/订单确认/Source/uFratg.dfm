object Fra_tg: TFra_tg
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
    Height = 153
    Align = alTop
    Caption = #26597#35810
    TabOrder = 0
    object edt_cpbh: Ti_TxtFilter
      Left = 70
      Top = 24
      Width = 140
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 54
      EditLabel.Height = 12
      EditLabel.Caption = #20135#21697#32534#21495':'
      EditLabel.Transparent = True
      LabelCaption = #20135#21697#32534#21495':'
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
    object edt_khmc: Ti_TxtFilter
      Left = 302
      Top = 56
      Width = 315
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 54
      EditLabel.Height = 12
      EditLabel.Caption = #23458#25143#21517#31216':'
      EditLabel.Transparent = True
      LabelCaption = #23458#25143#21517#31216':'
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
    object cbb_cplb: Ti_ComboBox
      Left = 302
      Top = 24
      Width = 140
      Height = 20
      EditLabel.Width = 54
      EditLabel.Height = 12
      EditLabel.Caption = #20135#21697#31867#21035':'
      EditLabel.Transparent = True
      LabelCaption = #20135#21697#31867#21035':'
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 1
      Text = '--'#20840#37096'--'
      OnChange = cbb_cplbChange
      Items.Strings = (
        '--'#20840#37096'--'
        #26126#20449#29255
        #37038#36164#23553
        #37038#25919#36154#21345
        #37038#36164#20449#21345
        #26085#24120#33410#26085#36154#21345)
      ItemIndex = 0
    end
    object cbb_cplx: Ti_ComboBox
      Left = 512
      Top = 24
      Width = 140
      Height = 20
      EditLabel.Width = 54
      EditLabel.Height = 12
      EditLabel.Caption = #20135#21697#31867#22411':'
      EditLabel.Transparent = True
      LabelCaption = #20135#21697#31867#22411':'
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 2
      Text = '--'#20840#37096'--'
      Items.Strings = (
        '--'#20840#37096'--')
      ItemIndex = 0
    end
    object cbb_qyfs: Ti_ComboBox
      Left = 696
      Top = 88
      Width = 140
      Height = 20
      EditLabel.Width = 54
      EditLabel.Height = 12
      EditLabel.Caption = #31614#26679#26041#24335':'
      EditLabel.Transparent = True
      LabelCaption = #31614#26679#26041#24335':'
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 8
      Text = '--'#20840#37096'--'
      Visible = False
      Items.Strings = (
        '--'#20840#37096'--'
        #19981#31614#26679
        #23454#29289#31614#26679
        #30005#23376#31614#26679
        #36828#31243#31614#26679)
      ItemIndex = 0
    end
    object btn_cx: TRzButton
      Left = 488
      Top = 118
      Caption = #26597#35810
      TabOrder = 7
      OnClick = btn_cxClick
    end
    object cbb_tgzt: Ti_ComboBox
      Left = 70
      Top = 56
      Width = 140
      Height = 20
      EditLabel.Width = 54
      EditLabel.Height = 12
      EditLabel.Caption = #22270#31295#29366#24577':'
      EditLabel.Transparent = True
      LabelCaption = #22270#31295#29366#24577':'
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 6
      Text = #22270#31295#26410#25910#21040
      Items.Strings = (
        #22270#31295#26410#25910#21040
        #22270#31295#24050#25910#21040
        #22270#31295#26410#21512#26684
        #22270#31295#24050#21512#26684
        #24050#25171#26679
        #24050#31614#26679
        #21457#36135#24453#21512#26684
        #21457#36135#24453#31614#26679
        #22270#31295#24453#22788#29702)
      ItemIndex = 0
    end
    object cbb_bb: Ti_ComboBox
      Left = 70
      Top = 120
      Width = 140
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
      TabOrder = 9
      Text = #23450#21046#22411
      OnChange = cbb_bbChange
      Items.Strings = (
        #23450#21046#22411
        #38144#21806#22411)
      ItemIndex = 0
    end
    object cbb_xpl: Ti_ComboBox
      Left = 302
      Top = 120
      Width = 97
      Height = 20
      EditLabel.Width = 66
      EditLabel.Height = 12
      EditLabel.Caption = #26159#21542#23567#25209#37327':'
      EditLabel.Transparent = True
      LabelCaption = #26159#21542#23567#25209#37327':'
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 3
      Text = #20840#37096
      Items.Strings = (
        #20840#37096
        #21542
        #26159)
      ItemIndex = 0
    end
    object cbb_nf: Ti_ComboBox
      Left = 745
      Top = 54
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
      TabOrder = 4
      Text = '12'
      Visible = False
      OnChange = cbb_cplbChange
      Items.Strings = (
        '12')
      ItemIndex = 0
    end
    object cbb_fktgzt: Ti_ComboBox
      Left = 502
      Top = 88
      Width = 140
      Height = 20
      EditLabel.Width = 54
      EditLabel.Height = 12
      EditLabel.Caption = #21453#39304#29366#24577':'
      EditLabel.Transparent = True
      LabelCaption = #21453#39304#29366#24577':'
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 10
      Text = '--'#20840#37096'--'
      Visible = False
      Items.Strings = (
        '--'#20840#37096'--'
        #22270#31295#26410#25910#21040
        #22270#31295#24050#25910#21040
        #22270#31295#26410#21512#26684
        #22270#31295#24050#21512#26684
        #24050#31614#26679
        #24050#25171#26679)
      ItemIndex = 0
    end
    object cbb_sfqy: Ti_ComboBox
      Left = 70
      Top = 88
      Width = 140
      Height = 20
      EditLabel.Width = 54
      EditLabel.Height = 12
      EditLabel.Caption = #26159#21542#31614#26679':'
      EditLabel.Transparent = True
      LabelCaption = #26159#21542#31614#26679':'
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 11
      Text = '--'#20840#37096'--'
      Items.Strings = (
        '--'#20840#37096'--'
        #19981#31614#26679
        #31614#26679)
      ItemIndex = 0
    end
    object edt_gdh: Ti_TxtFilter
      Left = 302
      Top = 88
      Width = 140
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 42
      EditLabel.Height = 12
      EditLabel.Caption = #24037#21333#21495':'
      EditLabel.Transparent = True
      LabelCaption = #24037#21333#21495':'
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
    object btn_export: TRzButton
      Left = 587
      Top = 118
      Caption = #23548#20986
      TabOrder = 13
      OnClick = btn_exportClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 466
    Width = 782
    Height = 64
    Align = alBottom
    Caption = #24405#20837
    TabOrder = 2
    object cbb_llzt: Ti_ComboBox
      Left = 80
      Top = 26
      Width = 120
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
      TabOrder = 2
      Text = '--'#35831#36873#25321'--'
      OnChange = cbb_llztChange
      Items.Strings = (
        '--'#35831#36873#25321'--'
        #22270#31295#26410#25910#21040
        #22270#31295#24050#25910#21040
        #25171#26679#20013
        #22270#31295#26410#21512#26684
        #22270#31295#24050#21512#26684
        #24050#25171#26679
        #24050#31614#26679
        #22270#31295#23457#26680#20013)
      ItemIndex = 0
    end
    object btn_ok: TRzButton
      Left = 240
      Top = 24
      Caption = #20869#37096#30830#35748
      TabOrder = 1
      OnClick = btn_okClick
    end
    object btn_fk: TRzButton
      Left = 240
      Top = 24
      Caption = #30830#35748
      TabOrder = 0
      OnClick = btn_fkClick
    end
    object edt_bz: Ti_TxtFilter
      Left = 376
      Top = 26
      Width = 305
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 30
      EditLabel.Height = 12
      EditLabel.Caption = #22791#27880':'
      EditLabel.Transparent = True
      LabelCaption = #22791#27880':'
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 3
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
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 153
    Width = 782
    Height = 313
    Align = alClient
    BorderOuter = fsNone
    TabOrder = 1
    object gb_dd: TRzGroupBox
      Left = 0
      Top = 0
      Width = 782
      Height = 313
      Align = alClient
      Caption = #35746#21333
      TabOrder = 0
      object lv_jhxd: TRzListView
        Left = 1
        Top = 13
        Width = 780
        Height = 270
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Caption = #36873#25321
            Width = 40
          end
          item
            Alignment = taCenter
            Caption = #25215#25597#30465
            Width = 100
          end
          item
            Alignment = taCenter
            Caption = #25215#25597#26426#26500
            Width = 100
          end
          item
            Alignment = taCenter
            Caption = #20135#21697#32534#21495
            Width = 180
          end
          item
            Caption = #35746#21333#19979#36798#26085#26399
            Width = 90
          end
          item
            Alignment = taCenter
            Caption = #23458#25143#21517#31216
            Width = 60
          end
          item
            Alignment = taCenter
            Caption = #37038#36164#22270#21517#31216
            Width = 80
          end
          item
            Alignment = taCenter
            Caption = #21360#37327#65288#19975#26522#65289
            Width = 90
          end
          item
            Caption = #26159#21542#31614#26679
            Width = 60
          end
          item
            Caption = #21152#21360
          end
          item
            AutoSize = True
            Caption = #29366#24577
            WidthType = (
              -74)
          end>
        ReadOnly = True
        RowSelect = True
        SmallImages = ImageList1
        TabOrder = 0
        ViewStyle = vsReport
        OnColumnClick = lv_jhxdColumnClick
        OnCustomDrawItem = lv_jhxdCustomDrawItem
        OnMouseDown = lv_jhxdMouseDown
      end
      object pan_data: TPanel
        Left = 1
        Top = 283
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
          Left = 584
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
          OnKeyPress = edt_ysKeyPress
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
    Left = 744
    Top = 136
  end
  object pm_jhxd: TPopupMenu
    Left = 664
    Top = 144
    object menu_cxfj: TMenuItem
      Caption = #37325#26032#25286#20998#35746#21333
      Enabled = False
      OnClick = menu_cxfjClick
    end
    object menu_ddmx: TMenuItem
      Caption = #35746#21333#26126#32454
      OnClick = menu_ddmxClick
    end
    object menu_ddmxPic: TMenuItem
      Caption = #35746#21333#26126#32454'('#21547#22270#31295')'
      OnClick = menu_ddmxClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object menu_ddcy: TMenuItem
      Caption = #35746#21333#37325#21360
      Enabled = False
      OnClick = menu_ddcyClick
    end
    object menu_NJDel: TMenuItem
      Caption = #21024#38500#20869#20214'('#19981#21360#21047')'
      Enabled = False
      OnClick = menu_NJDelClick
    end
    object menu_del: TMenuItem
      Caption = #21024#38500
      Enabled = False
      OnClick = menu_delClick
    end
  end
  object SavePath: TSaveDialog
    DefaultExt = 'xls'
    Filter = 'Excel'#25991#20214'(*.xls)|*.xls'
    Left = 728
    Top = 112
  end
end
