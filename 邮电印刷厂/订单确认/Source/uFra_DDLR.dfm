object Fra_DDLR: TFra_DDLR
  Left = 430
  Top = 97
  Width = 782
  Height = 606
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 44
    Top = 488
    Width = 48
    Height = 12
    Caption = #24405' '#20837' '#21592
  end
  object lab_lry: TLabel
    Left = 104
    Top = 488
    Width = 36
    Height = 12
    Caption = 'Label1'
  end
  object Label3: TLabel
    Left = 42
    Top = 136
    Width = 48
    Height = 12
    Caption = #20135#21697#32534#21495
  end
  object Label4: TLabel
    Left = 125
    Top = 136
    Width = 6
    Height = 12
    Caption = '-'
  end
  object Label5: TLabel
    Left = 192
    Top = 136
    Width = 6
    Height = 12
    Caption = '-'
  end
  object Label6: TLabel
    Left = 248
    Top = 136
    Width = 6
    Height = 12
    Caption = '-'
  end
  object Label7: TLabel
    Left = 42
    Top = 429
    Width = 60
    Height = 12
    Caption = #20132#36135#26085#26399'  '
  end
  object Label8: TLabel
    Left = 40
    Top = 44
    Width = 48
    Height = 12
    Caption = #26469#31295#26085#26399
  end
  object Label9: TLabel
    Left = 40
    Top = 74
    Width = 48
    Height = 12
    Caption = #29256'    '#21035
  end
  object Label10: TLabel
    Left = 43
    Top = 458
    Width = 48
    Height = 12
    Caption = #26159#21542#31614#26679
  end
  object Label12: TLabel
    Left = 264
    Top = 204
    Width = 12
    Height = 12
    Caption = #26522
  end
  object Label11: TLabel
    Left = 360
    Top = 136
    Width = 7
    Height = 14
    Caption = '*'
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -14
    Font.Name = #40657#20307
    Font.Style = []
    ParentFont = False
  end
  object Label13: TLabel
    Left = 264
    Top = 172
    Width = 7
    Height = 14
    Caption = '*'
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -14
    Font.Name = #40657#20307
    Font.Style = []
    ParentFont = False
  end
  object Label14: TLabel
    Left = 283
    Top = 204
    Width = 7
    Height = 14
    Caption = '*'
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -14
    Font.Name = #40657#20307
    Font.Style = []
    ParentFont = False
  end
  object Label15: TLabel
    Left = 232
    Top = 428
    Width = 7
    Height = 14
    Caption = '*'
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -14
    Font.Name = #40657#20307
    Font.Style = []
    ParentFont = False
  end
  object Label17: TLabel
    Left = 312
    Top = 136
    Width = 6
    Height = 12
    Caption = '-'
  end
  object Label2: TLabel
    Left = 286
    Top = 73
    Width = 7
    Height = 14
    Caption = '*'
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -14
    Font.Name = #40657#20307
    Font.Style = []
    ParentFont = False
  end
  object Label16: TLabel
    Left = 30
    Top = 234
    Width = 60
    Height = 12
    Caption = #26159#21542#23567#25209#37327
  end
  object edt_khmc: Ti_TxtFilter
    Left = 104
    Top = 168
    Width = 145
    Height = 20
    Alignment = taLeftJustify
    WordWrap = False
    WantReturns = False
    WantTabs = False
    ZeroToEmpty = False
    EditLabel.Width = 60
    EditLabel.Height = 12
    EditLabel.Caption = #21697'    '#21517'  '
    EditLabel.Transparent = True
    LabelCaption = #21697'    '#21517'  '
    LabelPosition = lpLeft
    LabelSpacing = 3
    TabEnter = True
    MaxLength = 100
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
  object edt_yl: Ti_TxtFilter
    Left = 104
    Top = 200
    Width = 145
    Height = 20
    Alignment = taLeftJustify
    WordWrap = False
    WantReturns = False
    WantTabs = False
    ZeroToEmpty = False
    EditLabel.Width = 60
    EditLabel.Height = 12
    EditLabel.Caption = #21360#21047#25968#37327'  '
    EditLabel.Transparent = True
    LabelCaption = #21360#21047#25968#37327'  '
    LabelPosition = lpLeft
    LabelSpacing = 3
    TabEnter = True
    TabOrder = 11
    OnExit = edt_ylExit
    OnKeyPress = edt_cpbh_1KeyPress
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
  object cbb_tsgy: Ti_TxtFilter
    Tag = 1
    Left = 104
    Top = 360
    Width = 145
    Height = 20
    Alignment = taLeftJustify
    WordWrap = False
    WantReturns = False
    WantTabs = False
    ZeroToEmpty = False
    EditLabel.Width = 60
    EditLabel.Height = 12
    EditLabel.Caption = #29305#27530#24037#33402'  '
    EditLabel.Transparent = True
    LabelCaption = #29305#27530#24037#33402'  '
    LabelPosition = lpLeft
    LabelSpacing = 3
    TabEnter = True
    TabOrder = 14
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
  object edt_sbbbh: Ti_TxtFilter
    Tag = 1
    Left = 104
    Top = 392
    Width = 121
    Height = 20
    Alignment = taLeftJustify
    WordWrap = False
    WantReturns = False
    WantTabs = False
    ZeroToEmpty = False
    EditLabel.Width = 72
    EditLabel.Height = 12
    EditLabel.Caption = #30003#25253#34920#32534#21495'  '
    EditLabel.Transparent = True
    LabelCaption = #30003#25253#34920#32534#21495'  '
    LabelPosition = lpLeft
    LabelSpacing = 3
    TabEnter = True
    TabOrder = 15
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
  object dtp_lgrq: TRzDateTimePicker
    Left = 104
    Top = 40
    Width = 121
    Height = 20
    Date = 40897.617686840280000000
    Format = 'yyyy-MM-dd'
    Time = 40897.617686840280000000
    Enabled = False
    TabOrder = 1
  end
  object dtp_jhrq: TRzDateTimePicker
    Left = 104
    Top = 424
    Width = 121
    Height = 20
    Date = 40897.617686840280000000
    Format = 'yyyy-MM-dd'
    Time = 40897.617686840280000000
    TabOrder = 16
  end
  object rb_bb_dzx: TRzRadioButton
    Left = 102
    Top = 72
    Width = 65
    Height = 17
    Caption = #23450#21046#22411
    TextShadowDepth = 1
    TabOrder = 3
  end
  object rb_bb_xsx: TRzRadioButton
    Left = 222
    Top = 72
    Width = 59
    Height = 17
    Caption = #38144#21806#22411
    TextShadowDepth = 1
    TabOrder = 5
  end
  object rb_bb_dfb: TRzRadioButton
    Left = 158
    Top = 72
    Width = 65
    Height = 17
    Caption = #22320#26041#29256
    TextShadowDepth = 1
    TabOrder = 4
  end
  object cbb_cplx: Ti_ComboBox
    Left = 104
    Top = 296
    Width = 121
    Height = 20
    EditLabel.Width = 60
    EditLabel.Height = 12
    EditLabel.Caption = #20135#21697#31867#22411#12288
    EditLabel.Transparent = True
    LabelCaption = #20135#21697#31867#22411#12288
    LabelPosition = lpLeft
    LabelSpacing = 3
    Style = csDropDownList
    ItemHeight = 12
    TabOrder = 12
    OnChange = cbb_cplxChange
  end
  object cbb_yztmc: Ti_ComboBox
    Tag = 1
    Left = 104
    Top = 328
    Width = 121
    Height = 20
    EditLabel.Width = 60
    EditLabel.Height = 12
    EditLabel.Caption = #37038' '#36164' '#22270'  '
    EditLabel.Transparent = True
    LabelCaption = #37038' '#36164' '#22270'  '
    LabelPosition = lpLeft
    LabelSpacing = 3
    Style = csDropDownList
    ItemHeight = 12
    TabOrder = 13
  end
  object edt_cpbh_1: TEdit
    Left = 136
    Top = 133
    Width = 49
    Height = 20
    MaxLength = 6
    TabOrder = 6
    OnKeyPress = edt_cpbh_1KeyPress
  end
  object edt_cpbh_2: TEdit
    Tag = 10
    Left = 208
    Top = 133
    Width = 33
    Height = 20
    MaxLength = 2
    TabOrder = 7
    OnKeyPress = edt_cpbh_1KeyPress
  end
  object edt_cpbh_3: TEdit
    Left = 264
    Top = 133
    Width = 41
    Height = 20
    MaxLength = 4
    TabOrder = 8
    OnKeyPress = edt_cpbh_1KeyPress
  end
  object btn_ok_old: TButton
    Left = 344
    Top = 520
    Width = 75
    Height = 25
    Caption = #30830#35748
    TabOrder = 18
    Visible = False
    OnClick = btn_ok_oldClick
  end
  object btn_reset: TButton
    Left = 208
    Top = 520
    Width = 75
    Height = 25
    Caption = #37325#32622
    TabOrder = 19
    OnClick = btn_resetClick
  end
  object edt_cpbh_4: TEdit
    Left = 328
    Top = 133
    Width = 33
    Height = 20
    TabOrder = 9
    Text = '000'
    OnKeyPress = edt_cpbh_1KeyPress
  end
  object Panel1: TPanel
    Left = 96
    Top = 448
    Width = 185
    Height = 25
    BevelOuter = bvNone
    TabOrder = 17
    object rb_qy_yes: TRzRadioButton
      Left = 16
      Top = 8
      Width = 41
      Height = 17
      Caption = #26159
      TabOrder = 0
    end
    object rb_qy_no: TRzRadioButton
      Left = 56
      Top = 8
      Width = 41
      Height = 17
      Caption = #21542
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
  object cb_jy: TCheckBox
    Left = 256
    Top = 42
    Width = 57
    Height = 17
    Caption = #21152#21360
    TabOrder = 2
  end
  object cbb_kh: Ti_ComboBox
    Left = 104
    Top = 102
    Width = 145
    Height = 20
    EditLabel.Width = 60
    EditLabel.Height = 12
    EditLabel.Caption = #23458'    '#25143'  '
    EditLabel.Transparent = True
    LabelCaption = #23458'    '#25143'  '
    LabelPosition = lpLeft
    LabelSpacing = 3
    Style = csDropDownList
    ItemHeight = 12
    TabOrder = 0
  end
  object btn_tsgy: TButton
    Left = 256
    Top = 358
    Width = 41
    Height = 22
    Caption = #28155#21152
    TabOrder = 20
    OnClick = btn_tsgyClick
  end
  object cbb_cplb: Ti_ComboBox
    Left = 104
    Top = 264
    Width = 121
    Height = 20
    EditLabel.Width = 60
    EditLabel.Height = 12
    EditLabel.Caption = #20135#21697#31867#21035#12288
    EditLabel.Transparent = True
    LabelCaption = #20135#21697#31867#21035#12288
    LabelPosition = lpLeft
    LabelSpacing = 3
    Style = csDropDownList
    ItemHeight = 12
    TabOrder = 21
    OnChange = cbb_cplbChange
  end
  object Panel2: TPanel
    Left = 96
    Top = 224
    Width = 185
    Height = 25
    BevelOuter = bvNone
    TabOrder = 22
    object rb_xpl_yes: TRzRadioButton
      Left = 16
      Top = 8
      Width = 41
      Height = 17
      Caption = #26159
      TabOrder = 0
    end
    object rb_xpl_no: TRzRadioButton
      Left = 56
      Top = 8
      Width = 41
      Height = 17
      Caption = #21542
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
  object btn_ok: TButton
    Left = 96
    Top = 520
    Width = 75
    Height = 25
    Caption = #30830#35748
    TabOrder = 23
    OnClick = btn_okClick
  end
  object edt_cpbh_0: TEdit
    Tag = 10
    Left = 104
    Top = 133
    Width = 19
    Height = 20
    MaxLength = 2
    TabOrder = 24
    Text = '12'
    OnKeyPress = edt_cpbh_1KeyPress
  end
  object cb_pp: TCheckBox
    Left = 320
    Top = 42
    Width = 153
    Height = 17
    Caption = #26159#21542#38656#35201#36827#34892#21305#37197
    Checked = True
    State = cbChecked
    TabOrder = 25
  end
end
