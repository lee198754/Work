object Frm_ListView: TFrm_ListView
  Left = 438
  Top = 203
  Width = 401
  Height = 459
  Caption = 'Frm_ListView'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    385
    421)
  PixelsPerInch = 96
  TextHeight = 13
  object lb_Title: TLabel
    Left = 20
    Top = 16
    Width = 56
    Height = 13
    Caption = 'lb_Title'
  end
  object btn_ok: TRzButton
    Left = 72
    Top = 384
    Anchors = [akBottom]
    Caption = #30830#35748
    TabOrder = 0
    OnClick = btn_okClick
  end
  object btn_close: TRzButton
    Left = 232
    Top = 384
    Anchors = [akBottom]
    Caption = #20851#38381
    TabOrder = 1
  end
  object lv_xx: TRzListView
    Left = 16
    Top = 32
    Width = 353
    Height = 345
    Columns = <>
    TabOrder = 2
    ViewStyle = vsReport
    OnCustomDrawItem = lv_xxCustomDrawItem
  end
  object ImageList1: TImageList
    Height = 20
    Width = 0
    Left = 299
    Top = 1
  end
end
