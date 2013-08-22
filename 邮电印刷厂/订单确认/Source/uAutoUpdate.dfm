object Frm_AutoUpdate: TFrm_AutoUpdate
  Left = 646
  Top = 331
  Width = 247
  Height = 105
  Caption = #33258#21160#26356#26032
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 48
    Height = 12
    Caption = #26356#26032#36827#24230
  end
  object pb_UpdateProgress: TProgressBar
    Left = 16
    Top = 32
    Width = 193
    Height = 17
    Position = 20
    TabOrder = 0
  end
  object IdIcmpClient1: TIdIcmpClient
    ReceiveTimeout = 1000
    Left = 192
    Top = 16
  end
end
