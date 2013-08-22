object Frm_ZBTPrint: TFrm_ZBTPrint
  Left = 320
  Top = 61
  Width = 800
  Height = 600
  Caption = #21046#29256#22270
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
  object lab_bz: TLabel
    Left = 124
    Top = 368
    Width = 36
    Height = 12
    Caption = #22791#27880#65306
  end
  object mmo_bz: TRzMemo
    Left = 174
    Top = 368
    Width = 379
    Height = 113
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object btn_ok: TRzButton
    Left = 296
    Top = 504
    Caption = #20445#23384
    TabOrder = 1
    OnClick = btn_okClick
  end
end
