object Frm_User_Limit: TFrm_User_Limit
  Left = 601
  Top = 175
  Width = 274
  Height = 405
  Caption = #38480#21046
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    258
    367)
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 60
    Height = 12
    Caption = #38480#21046#21015#34920#65306
  end
  object ckl_LimitList: TCheckListBox
    Left = 8
    Top = 32
    Width = 241
    Height = 275
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = #26032#23435#20307
    Font.Style = []
    ItemHeight = 14
    Items.Strings = (
      'asf'
      'sf'
      'saf'
      'sf'
      'sa'
      'saf')
    ParentFont = False
    TabOrder = 0
  end
  object btn_ok: TRzButton
    Left = 88
    Top = 330
    Anchors = [akLeft, akBottom]
    Caption = #30830#35748
    TabOrder = 1
    OnClick = btn_okClick
  end
  object ImageList1: TImageList
    Height = 20
    Width = 0
    Left = 440
    Top = 208
  end
end
