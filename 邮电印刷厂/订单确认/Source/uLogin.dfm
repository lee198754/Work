object Frm_Login: TFrm_Login
  Left = 380
  Top = 191
  Width = 305
  Height = 168
  Caption = #30331#38470
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 50
    Top = 61
    Width = 36
    Height = 12
    Caption = #23494#30721#65306
  end
  object edt_Name: Ti_TxtFilter
    Left = 88
    Top = 24
    Width = 137
    Height = 20
    Alignment = taLeftJustify
    WordWrap = False
    WantReturns = False
    WantTabs = False
    ZeroToEmpty = False
    EditLabel.Width = 48
    EditLabel.Height = 12
    EditLabel.Caption = #29992#25143#21517#65306
    EditLabel.Transparent = True
    LabelCaption = #29992#25143#21517#65306
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
  object btn_login: TRzButton
    Left = 104
    Top = 92
    Caption = #30331#38470
    TabOrder = 2
    OnClick = btn_loginClick
  end
  object edt_Pwd: TEdit
    Left = 88
    Top = 56
    Width = 137
    Height = 20
    PasswordChar = '*'
    TabOrder = 1
    OnKeyPress = edt_PwdKeyPress
  end
  object cb_RemPwd: TRzCheckBox
    Left = 8
    Top = 84
    Width = 73
    Height = 17
    Caption = #35760#20303#23494#30721
    Checked = True
    State = cbChecked
    TabOrder = 3
    Visible = False
  end
  object IdIcmpClient1: TIdIcmpClient
    ReceiveTimeout = 500
    Left = 224
    Top = 80
  end
end
