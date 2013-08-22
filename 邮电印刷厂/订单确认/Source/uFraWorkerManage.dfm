object Fra_WorkerManage: TFra_WorkerManage
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
    Height = 429
    Align = alClient
    Caption = #20154#21592#21015#34920
    TabOrder = 0
    object lv_WorkerList: TRzListView
      Left = 1
      Top = 13
      Width = 780
      Height = 415
      Align = alClient
      Columns = <
        item
          Caption = #22995#21517
          Width = 80
        end
        item
          Caption = #24615#21035
        end
        item
          Caption = #25152#23646#37096#38376
          Width = 629
        end>
      RowSelect = True
      SmallImages = ImageList1
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = lv_WorkerListClick
      OnColumnClick = lv_WorkerListColumnClick
      OnCustomDrawItem = lv_WorkerListCustomDrawItem
    end
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 429
    Width = 782
    Height = 101
    Align = alBottom
    BorderOuter = fsNone
    TabOrder = 1
    object lab_Sex: TLabel
      Left = 641
      Top = 48
      Width = 36
      Height = 12
      Caption = #24615#21035#65306
      Visible = False
    end
    object edt_Name: Ti_TxtFilter
      Left = 72
      Top = 17
      Width = 121
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 36
      EditLabel.Height = 12
      EditLabel.Caption = #22995#21517#65306
      EditLabel.Transparent = True
      LabelCaption = #22995#21517#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      MaxLength = 50
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
    object btn_add: TRzButton
      Left = 158
      Top = 64
      Caption = #28155#21152
      TabOrder = 1
      OnClick = btn_addClick
    end
    object edt_Age: Ti_TxtFilter
      Left = 672
      Top = 13
      Width = 121
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 36
      EditLabel.Height = 12
      EditLabel.Caption = #24180#40836#65306
      EditLabel.Transparent = True
      LabelCaption = #24180#40836#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      TabEnter = True
      MaxLength = 5
      TabOrder = 2
      Visible = False
      OnKeyPress = edt_AgeKeyPress
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
    object rb_Sex1: TRzRadioButton
      Left = 685
      Top = 44
      Width = 41
      Height = 17
      Caption = #30007
      Checked = True
      TabOrder = 3
      TabStop = True
      Visible = False
    end
    object rb_Sex2: TRzRadioButton
      Left = 733
      Top = 44
      Width = 41
      Height = 17
      Caption = #22899
      TabOrder = 4
      Visible = False
    end
    object edt_Department: Ti_TxtFilter
      Left = 401
      Top = 13
      Width = 121
      Height = 20
      Alignment = taLeftJustify
      WordWrap = False
      WantReturns = False
      WantTabs = False
      ZeroToEmpty = False
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #25152#23646#37096#38376#65306
      EditLabel.Transparent = True
      LabelCaption = #25152#23646#37096#38376#65306
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
    object btn_mod: TRzButton
      Left = 318
      Top = 64
      Caption = #20462#25913
      TabOrder = 6
      OnClick = btn_modClick
    end
    object btn_Del: TRzButton
      Left = 470
      Top = 64
      Caption = #21024#38500
      TabOrder = 7
      OnClick = btn_DelClick
    end
    object cbb_Sex: Ti_ComboBox
      Left = 240
      Top = 16
      Width = 73
      Height = 20
      EditLabel.Width = 36
      EditLabel.Height = 12
      EditLabel.Caption = #24615#21035#65306
      EditLabel.Transparent = True
      LabelCaption = #24615#21035#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 8
      Text = #30007
      Items.Strings = (
        #30007
        #22899)
      ItemIndex = 0
    end
  end
  object pm_lv_Worker: TPopupMenu
    Left = 713
    Top = 424
    object menu_Del: TMenuItem
      Caption = #21024#38500
      OnClick = menu_DelClick
    end
  end
  object ImageList1: TImageList
    Height = 20
    Width = 0
    Left = 592
    Top = 264
  end
end
