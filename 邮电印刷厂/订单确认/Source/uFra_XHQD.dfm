object Fra_XHQD: TFra_XHQD
  Left = 0
  Top = 0
  Width = 790
  Height = 427
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object RzGroupBox1: TRzGroupBox
    Left = 0
    Top = 0
    Width = 790
    Height = 57
    Align = alTop
    Caption = #26597#35810#26465#20214
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 25
      Width = 48
      Height = 12
      Caption = #24320#21333#26085#26399
    end
    object Label2: TLabel
      Left = 176
      Top = 29
      Width = 6
      Height = 12
      Caption = '~'
    end
    object dtp_kdq: TRzDateTimePicker
      Left = 80
      Top = 21
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      TabOrder = 0
    end
    object dtp_kdz: TRzDateTimePicker
      Left = 192
      Top = 21
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      TabOrder = 1
    end
    object btn_cx: TRzButton
      Left = 505
      Top = 18
      Caption = #26597#35810
      TabOrder = 2
      OnClick = btn_cxClick
    end
    object btn_export: TRzButton
      Left = 601
      Top = 18
      Caption = #23548#20986
      TabOrder = 3
      OnClick = btn_exportClick
    end
    object cbb_cplb: Ti_ComboBox
      Left = 356
      Top = 21
      Width = 121
      Height = 20
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #20135#21697#31867#21035#65306
      EditLabel.Transparent = True
      LabelCaption = #20135#21697#31867#21035#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 4
    end
  end
  object RzGroupBox2: TRzGroupBox
    Left = 0
    Top = 57
    Width = 790
    Height = 370
    Align = alClient
    Caption = #26597#35810#32467#26524
    TabOrder = 1
    object dbg_XHQD: TDBGridEh
      Left = 1
      Top = 13
      Width = 788
      Height = 356
      Align = alClient
      Ctl3D = True
      DataGrouping.GroupLevels = <>
      DataSource = DM_DataBase.ds_XHQD
      Flat = False
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #26032#23435#20307
      Font.Style = []
      FooterColor = clWindow
      FooterFont.Charset = GB2312_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -12
      FooterFont.Name = #26032#23435#20307
      FooterFont.Style = []
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      RowDetailPanel.Color = clBtnFace
      TabOrder = 0
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = #26032#23435#20307
      TitleFont.Style = []
      UseMultiTitle = True
      Columns = <
        item
          EditButtons = <>
          FieldName = 'XH'
          Footers = <>
          Title.Caption = #24207#21495
          Width = 30
        end
        item
          EditButtons = <>
          FieldName = 'CPBH'
          Footers = <>
          Title.Caption = #20135#21697#32534#21495
          Width = 179
        end
        item
          EditButtons = <>
          FieldName = 'PPMC'
          Footers = <>
          Title.Caption = #37038#36164#31080#21697#21517#31216
          Width = 100
        end
        item
          EditButtons = <>
          FieldName = 'ZL'
          Footers = <>
          Title.Caption = #31080#21697#31867#21035
          Width = 60
        end
        item
          EditButtons = <>
          FieldName = 'JHDH'
          Footers = <>
          Title.Caption = #35745#21010#21333#21495
          Width = 250
        end
        item
          EditButtons = <>
          FieldName = 'JG'
          Footers = <>
          Title.Caption = #25215#25597#26426#26500
          Width = 200
        end
        item
          EditButtons = <>
          FieldName = 'KHMC'
          Footers = <>
          Title.Caption = #23458#25143#21517#31216
          Width = 200
        end
        item
          EditButtons = <>
          FieldName = 'GDH'
          Footers = <>
          Title.Caption = #24037#21333#21495
          Width = 132
        end
        item
          EditButtons = <>
          FieldName = 'DYL'
          Footers = <>
          Title.Caption = #35746#21360#37327#13#10#65288#26522#25968#65289
          Width = 60
        end
        item
          EditButtons = <>
          FieldName = 'LQBZ'
          Footers = <>
          Title.Caption = #39046#21462#30333#32440#13#10'('#22235#24320#24352#25968')'
          Width = 70
        end
        item
          EditButtons = <>
          FieldName = 'DY'
          Footers = <>
          Title.Caption = #25171#26679#13#10#65288#22235#24320#24352#25968#65289
          Width = 80
        end
        item
          EditButtons = <>
          FieldName = 'YS'
          Footers = <>
          Title.Caption = #21360#21047#13#10'('#22235#24320#24352#25968')'
          Width = 70
        end
        item
          EditButtons = <>
          FieldName = 'CP'
          Footers = <>
          Title.Caption = #25104#21697#13#10' ('#22235#24320#24352#25968')'
          Width = 70
        end
        item
          EditButtons = <>
          FieldName = 'SJZLP'
          Footers = <>
          Title.Caption = #36865#20132#36164#26009#31080#65288#26522#25968#65289
          Width = 70
        end
        item
          EditButtons = <>
          FieldName = 'FPZS'
          Footers = <>
          Title.Caption = #24223#21697'|'#22235#24320#24352#25968
          Width = 60
        end
        item
          EditButtons = <>
          FieldName = 'FPZHMS'
          Footers = <>
          Title.Caption = #24223#21697'|'#25240#21512#26522#25968
          Width = 60
        end
        item
          EditButtons = <>
          FieldName = 'BZ'
          Footers = <>
          Title.Caption = #22791#27880
          Width = 60
        end
        item
          EditButtons = <>
          FieldName = 'KHMCJG'
          Footers = <>
          Visible = False
        end
        item
          EditButtons = <>
          FieldName = 'CPKS'
          Footers = <>
          Title.Caption = #25104#21697#13#10#24320#25968
          Width = 41
        end
        item
          EditButtons = <>
          FieldName = 'WorkID'
          Footers = <>
          Visible = False
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object SavePath: TSaveDialog
    DefaultExt = 'xls'
    Filter = 'Excel'#25991#20214'(*.xls)|*.xls'
    Left = 696
    Top = 16
  end
end
