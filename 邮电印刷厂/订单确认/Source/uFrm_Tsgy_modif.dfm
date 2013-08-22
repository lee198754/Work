object Frm_Tsgy_modif: TFrm_Tsgy_modif
  Left = 457
  Top = 149
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsToolWindow
  Caption = #29305#27530#24037#33402#20462#25913
  ClientHeight = 401
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 8
    Top = 288
    Width = 60
    Height = 12
    Caption = #29305#27530#24037#33402#65306
  end
  object btn_ok: TButton
    Left = 40
    Top = 368
    Width = 65
    Height = 25
    Caption = #30830#23450
    ModalResult = 1
    TabOrder = 0
    OnClick = btn_okClick
  end
  object btn_cancel: TButton
    Left = 160
    Top = 368
    Width = 75
    Height = 25
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 1
  end
  object mmo_tsgy: TRzMemo
    Left = 8
    Top = 304
    Width = 249
    Height = 49
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object RzGroupBox1: TRzGroupBox
    Left = 8
    Top = 8
    Width = 249
    Height = 273
    Caption = #24037#33402#35201#27714
    TabOrder = 3
    object cb_gyyq: TCheckListBox
      Left = 1
      Top = 13
      Width = 247
      Height = 259
      OnClickCheck = cb_gyyqClickCheck
      Align = alClient
      ItemHeight = 12
      TabOrder = 0
    end
  end
end
