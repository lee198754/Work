object Frm_PicPathDlg: TFrm_PicPathDlg
  Left = 636
  Top = 367
  BorderStyle = bsDialog
  Caption = #36755#20837
  ClientHeight = 130
  ClientWidth = 421
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 401
    Height = 73
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 169
    Height = 13
    Caption = #35831#36755#20837#22270#31295#19979#36733#36335#24452':'
  end
  object OKBtn: TButton
    Left = 143
    Top = 92
    Width = 75
    Height = 25
    Caption = #30830#23450
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 223
    Top = 92
    Width = 75
    Height = 25
    Cancel = True
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 1
  end
  object edt_Path: TEdit
    Left = 16
    Top = 48
    Width = 345
    Height = 21
    TabOrder = 2
    Text = 'edt_path'
  end
  object btn_Path: TButton
    Left = 364
    Top = 44
    Width = 35
    Height = 25
    Caption = #27983#35272
    TabOrder = 3
    OnClick = btn_PathClick
  end
  object dlgSave_Pic: TSaveDialog
    FilterIndex = 0
    Left = 248
    Top = 16
  end
end
