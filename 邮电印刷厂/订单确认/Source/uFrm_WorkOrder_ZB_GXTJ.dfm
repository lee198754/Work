object Frm_WorkOrder_ZB_GXTJ: TFrm_WorkOrder_ZB_GXTJ
  Left = 454
  Top = 219
  Width = 510
  Height = 210
  Caption = #24037#24207#28155#21152
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnMouseDown = FormMouseDown
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 371
    Top = 52
    Width = 36
    Height = 12
    Caption = #21333#20301#65306
  end
  object Label2: TLabel
    Left = 17
    Top = 52
    Width = 60
    Height = 12
    Caption = #31867#21035#35268#26684#65306
  end
  object btn_ok: TRzButton
    Left = 111
    Top = 137
    ModalResult = 1
    Caption = #30830#23450
    TabOrder = 0
    OnClick = btn_okClick
  end
  object btn_close: TRzButton
    Left = 263
    Top = 137
    ModalResult = 2
    Caption = #20851#38381
    TabOrder = 1
  end
  object edt_gxbh: Ti_TxtFilter
    Left = 80
    Top = 16
    Width = 117
    Height = 20
    Alignment = taLeftJustify
    WordWrap = False
    WantReturns = False
    WantTabs = False
    ZeroToEmpty = False
    EditLabel.Width = 60
    EditLabel.Height = 12
    EditLabel.Caption = #24037#24207#32534#21495#65306
    EditLabel.Transparent = True
    LabelCaption = #24037#24207#32534#21495#65306
    LabelPosition = lpLeft
    LabelSpacing = 3
    TabEnter = True
    TabOrder = 2
    OnEnter = edt_gxbhEnter
    OnExit = edt_gxbhExit
    OnKeyUp = edt_gxbhKeyUp
    OnMouseDown = edt_gxbhMouseDown
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
  object edt_gxmc: Ti_TxtFilter
    Left = 292
    Top = 16
    Width = 129
    Height = 20
    Alignment = taLeftJustify
    WordWrap = False
    WantReturns = False
    WantTabs = False
    ZeroToEmpty = False
    EditLabel.Width = 60
    EditLabel.Height = 12
    EditLabel.Caption = #24037#24207#21517#31216#65306
    EditLabel.Transparent = True
    LabelCaption = #24037#24207#21517#31216#65306
    LabelPosition = lpLeft
    LabelSpacing = 3
    TabEnter = True
    TabOrder = 3
    OnEnter = edt_gxbhEnter
    OnExit = edt_gxbhExit
    OnKeyUp = edt_gxbhKeyUp
    OnMouseDown = edt_gxbhMouseDown
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
  object edt_cl: Ti_TxtFilter
    Left = 293
    Top = 48
    Width = 73
    Height = 20
    Alignment = taLeftJustify
    WordWrap = False
    WantReturns = False
    WantTabs = False
    ZeroToEmpty = False
    EditLabel.Width = 36
    EditLabel.Height = 12
    EditLabel.Caption = #20135#37327#65306
    EditLabel.Transparent = True
    LabelCaption = #20135#37327#65306
    LabelPosition = lpLeft
    LabelSpacing = 3
    TabEnter = True
    TabOrder = 4
    OnEnter = edt_clEnter
    OnExit = edt_clExit
    OnKeyUp = edt_clKeyUp
    OnMouseDown = edt_clMouseDown
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
  object cbb_dw: TComboBox
    Left = 408
    Top = 48
    Width = 63
    Height = 20
    ItemHeight = 12
    TabOrder = 5
    Items.Strings = (
      #29256
      #30721
      #29255)
  end
  object btn_bz: Ti_TxtFilter
    Left = 80
    Top = 80
    Width = 393
    Height = 20
    Alignment = taLeftJustify
    WordWrap = False
    WantReturns = False
    WantTabs = False
    ZeroToEmpty = False
    EditLabel.Width = 36
    EditLabel.Height = 12
    EditLabel.Caption = #22791#27880#65306
    EditLabel.Transparent = True
    LabelCaption = #22791#27880#65306
    LabelPosition = lpLeft
    LabelSpacing = 3
    TabEnter = True
    TabOrder = 6
    OnEnter = edt_clEnter
    OnExit = btn_bzExit
    OnKeyUp = edt_clKeyUp
    OnMouseDown = edt_clMouseDown
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
  object cbb_lbgg: TComboBox
    Left = 80
    Top = 48
    Width = 121
    Height = 20
    ItemHeight = 12
    TabOrder = 8
    Items.Strings = (
      #29256
      #30721
      #29255)
  end
  object lb_Temp: TListBox
    Left = -16
    Top = 118
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
    TabOrder = 7
    Visible = False
    OnKeyDown = lb_TempKeyDown
    OnKeyUp = lb_TempKeyUp
    OnMouseDown = lb_TempMouseDown
    OnMouseMove = lb_TempMouseMove
  end
  object btn_zbgx: TButton
    Left = 197
    Top = 15
    Width = 22
    Height = 21
    Caption = #8230
    TabOrder = 9
    OnClick = btn_zbgxClick
  end
end
