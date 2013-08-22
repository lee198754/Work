object Frm_GDFK: TFrm_GDFK
  Left = 496
  Top = 75
  Width = 800
  Height = 600
  Caption = #24037#21333#21453#39304
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
  object gb_dd: TRzGroupBox
    Left = 0
    Top = 0
    Width = 784
    Height = 498
    Align = alClient
    Caption = #35746#21333
    TabOrder = 0
    object lv_dd: TRzListView
      Left = 1
      Top = 13
      Width = 782
      Height = 484
      Align = alClient
      Checkboxes = True
      Columns = <
        item
          Caption = #36873#25321
          Width = 40
        end
        item
          Alignment = taCenter
          Caption = #25215#25597#26426#26500
          Width = 130
        end
        item
          Alignment = taCenter
          Caption = #23458#25143#21517#31216
          Width = 60
        end
        item
          Alignment = taCenter
          Caption = #20135#21697#32534#21495
          Width = 180
        end
        item
          Caption = #31181#31867
        end
        item
          Alignment = taCenter
          Caption = #37038#36164#22270
          Width = 70
        end
        item
          Alignment = taCenter
          Caption = #24635#21360#37327
          Width = 80
        end
        item
          Caption = #26159#21542#31614#26679
          Width = 60
        end
        item
          Caption = #21152#21360
          Width = 40
        end
        item
          Caption = #22270#31295#29366#24577
          Width = 51
        end>
      ReadOnly = True
      RowSelect = True
      SmallImages = ImageList1
      TabOrder = 0
      ViewStyle = vsReport
      OnColumnClick = lv_ddColumnClick
      OnCustomDrawItem = lv_ddCustomDrawItem
      OnMouseDown = lv_ddMouseDown
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 498
    Width = 784
    Height = 64
    Align = alBottom
    Caption = #24405#20837
    TabOrder = 1
    object cbb_llzt: Ti_ComboBox
      Left = 80
      Top = 27
      Width = 120
      Height = 20
      EditLabel.Width = 30
      EditLabel.Height = 12
      EditLabel.Caption = #29366#24577':'
      EditLabel.Transparent = True
      LabelCaption = #29366#24577':'
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 1
      Text = '--'#35831#36873#25321'--'
      Items.Strings = (
        '--'#35831#36873#25321'--'
        #22270#31295#26410#25910#21040
        #22270#31295#24050#25910#21040
        #22270#31295#26410#21512#26684
        #22270#31295#24050#21512#26684
        #24050#25171#26679)
      ItemIndex = 0
    end
    object btn_fk: TRzButton
      Left = 216
      Top = 24
      Caption = #21453#39304
      TabOrder = 0
      OnClick = btn_fkClick
    end
  end
  object ImageList1: TImageList
    Height = 20
    Width = 0
    Left = 712
    Top = 144
  end
  object pm_jhxd: TPopupMenu
    Left = 664
    Top = 144
    object menu_ddmx: TMenuItem
      Caption = #35746#21333#26126#32454
    end
    object menu_ddmxPic: TMenuItem
      Caption = #35746#21333#26126#32454'('#21547#22270#31295')'
      Visible = False
    end
  end
end
