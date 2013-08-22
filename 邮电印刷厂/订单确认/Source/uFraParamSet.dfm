object Fra_ParamSet: TFra_ParamSet
  Left = 0
  Top = 0
  Width = 931
  Height = 541
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object RzGroupBox1: TRzGroupBox
    Left = 0
    Top = 16
    Width = 313
    Height = 401
    Caption = #19979#25289#26694#39044#35774
    TabOrder = 0
    object btn_ParamAdd: TRzButton
      Left = 208
      Top = 350
      Caption = #28155#21152
      TabOrder = 0
      OnClick = btn_ParamAddClick
    end
    object tv_ParamList: TRzTreeView
      Left = 16
      Top = 64
      Width = 265
      Height = 265
      SelectionPen.Color = clBtnShadow
      HideSelection = False
      Indent = 19
      ReadOnly = True
      TabOrder = 1
      OnMouseDown = tv_ParamListMouseDown
    end
    object edt_Param: Ti_TxtFilter
      Left = 48
      Top = 352
      Width = 153
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 36
      EditLabel.Height = 12
      EditLabel.Caption = #21442#25968#65306
      EditLabel.Transparent = True
      LabelCaption = #21442#25968#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 2
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
    object btn_ClassAdd: TRzButton
      Left = 208
      Top = 30
      Caption = #28155#21152
      TabOrder = 3
      Visible = False
      OnClick = btn_ClassAddClick
    end
    object edt_Class: Ti_TxtFilter
      Left = 48
      Top = 32
      Width = 153
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 36
      EditLabel.Height = 12
      EditLabel.Caption = #31867#22411#65306
      EditLabel.Transparent = True
      LabelCaption = #31867#22411#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      TabOrder = 4
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
  object RzGroupBox2: TRzGroupBox
    Left = 336
    Top = 8
    Width = 457
    Height = 89
    Caption = #29983#20135#21608#26399#35774#32622
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 27
      Width = 96
      Height = 12
      Caption = #22823#25209#37327#29983#20135#21608#26399#65306
    end
    object Label2: TLabel
      Left = 160
      Top = 27
      Width = 12
      Height = 12
      Caption = #22825
    end
    object Label3: TLabel
      Left = 202
      Top = 27
      Width = 24
      Height = 12
      Caption = #25552#21069
    end
    object Label4: TLabel
      Left = 282
      Top = 27
      Width = 36
      Height = 12
      Caption = #22825#25552#37266
    end
    object Label5: TLabel
      Left = 17
      Top = 58
      Width = 96
      Height = 12
      Caption = #23567#25209#37327#29983#20135#21608#26399#65306
    end
    object Label6: TLabel
      Left = 161
      Top = 58
      Width = 12
      Height = 12
      Caption = #22825
    end
    object Label7: TLabel
      Left = 203
      Top = 58
      Width = 24
      Height = 12
      Caption = #25552#21069
    end
    object Label8: TLabel
      Left = 283
      Top = 58
      Width = 36
      Height = 12
      Caption = #22825#25552#37266
    end
    object edt_sczq: TEdit
      Left = 112
      Top = 24
      Width = 41
      Height = 20
      TabOrder = 0
    end
    object edt_tqts: TEdit
      Left = 234
      Top = 24
      Width = 41
      Height = 20
      TabOrder = 1
    end
    object btn_sczq: TButton
      Left = 352
      Top = 21
      Width = 57
      Height = 25
      Caption = #20445#23384
      TabOrder = 2
      OnClick = btn_sczqClick
    end
    object edt_xqlsczq: TEdit
      Left = 113
      Top = 55
      Width = 41
      Height = 20
      TabOrder = 3
    end
    object edt_xqltqts: TEdit
      Left = 235
      Top = 55
      Width = 41
      Height = 20
      TabOrder = 4
    end
    object btn_xqlsczq: TButton
      Left = 353
      Top = 52
      Width = 57
      Height = 25
      Caption = #20445#23384
      TabOrder = 5
      OnClick = btn_xqlsczqClick
    end
  end
  object RzGroupBox3: TRzGroupBox
    Left = 336
    Top = 112
    Width = 457
    Height = 49
    Caption = #31665#31614#35774#32622
    TabOrder = 2
    object cb_rjhdpp: TRzCheckBox
      Left = 16
      Top = 20
      Width = 281
      Height = 17
      Caption = #26816#26597#31665#31614#20817#22870#21495#30721#25968#37327#19982#35746#21333#21360#37327#26159#21542#21305#37197
      State = cbUnchecked
      TabOrder = 0
    end
    object btn_rjhdpp: TButton
      Left = 336
      Top = 16
      Width = 57
      Height = 25
      Caption = #35774#32622
      TabOrder = 1
      OnClick = btn_rjhdppClick
    end
  end
  object RzGroupBox4: TRzGroupBox
    Left = 336
    Top = 176
    Width = 457
    Height = 49
    Caption = #21457#36135#21453#39304#35774#32622
    TabOrder = 3
    object rb_fkslpp: TRzCheckBox
      Left = 16
      Top = 20
      Width = 281
      Height = 17
      Caption = #26816#26597#21457#36135#21453#39304#20817#22870#21495#30721#25968#37327#19982#35746#21333#21360#37327#26159#21542#21305#37197
      State = cbUnchecked
      TabOrder = 0
    end
    object btn_fkslpp: TButton
      Left = 336
      Top = 15
      Width = 57
      Height = 25
      Caption = #35774#32622
      TabOrder = 1
      OnClick = btn_fkslppClick
    end
  end
  object pm_ParamList: TPopupMenu
    Left = 120
    Top = 392
    object menu_Del: TMenuItem
      Caption = #21024#38500
      OnClick = menu_DelClick
    end
  end
end
