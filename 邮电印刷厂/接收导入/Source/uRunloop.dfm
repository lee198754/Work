object FRunloop: TFRunloop
  Left = 389
  Top = 233
  Width = 335
  Height = 86
  Caption = #24490#29615#25191#34892
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMinimized
  OnShow = FormShow
  DesignSize = (
    319
    48)
  PixelsPerInch = 96
  TextHeight = 12
  object lab_Time: TLabel
    Left = 152
    Top = 8
    Width = 48
    Height = 12
    Caption = 'lab_Time'
  end
  object lab_Path: TLabel
    Left = 24
    Top = 26
    Width = 48
    Height = 12
    Caption = 'lab_Path'
  end
  object lab_Interval: TLabel
    Left = 24
    Top = 8
    Width = 72
    Height = 12
    Caption = 'lab_Interval'
  end
  object btn_zx: TButton
    Left = 240
    Top = 16
    Width = 75
    Height = 25
    Anchors = [akTop, akBottom]
    Caption = #31435#21363#25191#34892
    TabOrder = 0
    OnClick = Timer1Timer
  end
  object Timer1: TTimer
    Interval = 18000000
    OnTimer = Timer1Timer
    Left = 144
    Top = 24
  end
  object RzTrayIcon1: TRzTrayIcon
    RestoreOn = ticLeftClick
    Left = 104
    Top = 24
  end
  object Timer2: TTimer
    OnTimer = Timer2Timer
    Left = 184
    Top = 24
  end
end
