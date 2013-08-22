object Frm_User_License: TFrm_User_License
  Left = 434
  Top = 178
  Width = 274
  Height = 405
  Caption = #25480#26435
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    258
    367)
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 72
    Height = 12
    Caption = #21487#25805#20316#30028#38754#65306
  end
  object ckl_LicenseList: TCheckListBox
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
    OnMouseDown = ckl_LicenseListMouseDown
  end
  object btn_ok: TRzButton
    Left = 88
    Top = 330
    Anchors = [akLeft, akBottom]
    Caption = #30830#35748
    TabOrder = 1
    OnClick = btn_okClick
  end
  object lv_LicenseList: TRzListView
    Left = 264
    Top = 32
    Width = 201
    Height = 249
    Checkboxes = True
    Columns = <
      item
        Width = 20
      end
      item
        Width = 160
      end>
    ReadOnly = True
    RowSelect = True
    SmallImages = ImageList1
    TabOrder = 2
    ViewStyle = vsReport
    Visible = False
    OnCustomDrawItem = lv_LicenseListCustomDrawItem
    OnMouseDown = lv_LicenseListMouseDown
  end
  object ImageList1: TImageList
    Height = 20
    Width = 0
    Left = 440
    Top = 208
  end
end
