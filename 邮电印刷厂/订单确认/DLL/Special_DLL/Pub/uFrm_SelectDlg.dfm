object Frm_SelectDlg: TFrm_SelectDlg
  Left = 519
  Top = 210
  Width = 338
  Height = 156
  Caption = #25552#31034
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    322
    118)
  PixelsPerInch = 96
  TextHeight = 14
  object lab_Text: TLabel
    Left = 16
    Top = 24
    Width = 273
    Height = 14
    Caption = #27492#35746#21333#21547#26377#20869#20214','#35831#36873#25321#25171#21360#20449#23553#36824#26159#20869#20214#65306
  end
  object btn_A: TRzButton
    Left = 59
    Top = 64
    Anchors = [akTop]
    Caption = #25171#21360#20449#23553
    TabOrder = 0
    OnClick = btn_AClick
  end
  object btn_B: TRzButton
    Left = 172
    Top = 64
    Anchors = [akTop]
    Caption = #25171#21360#20869#20214
    TabOrder = 1
    OnClick = btn_BClick
  end
end
