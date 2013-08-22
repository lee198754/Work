object Fra_FHTJ: TFra_FHTJ
  Left = 0
  Top = 0
  Width = 800
  Height = 600
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
    Width = 800
    Height = 81
    Align = alTop
    Caption = #26597#35810#26465#20214
    TabOrder = 0
    object Label7: TLabel
      Left = 48
      Top = 20
      Width = 48
      Height = 12
      Caption = #26597#35810#26085#26399
    end
    object Label1: TLabel
      Left = 200
      Top = 24
      Width = 6
      Height = 12
      Caption = '~'
    end
    object dtp_cxq: TRzDateTimePicker
      Left = 104
      Top = 16
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      TabOrder = 0
    end
    object dtp_cxz: TRzDateTimePicker
      Left = 216
      Top = 16
      Width = 89
      Height = 20
      Date = 40801.680891192130000000
      Time = 40801.680891192130000000
      TabOrder = 1
    end
    object btn_cx: TRzButton
      Left = 573
      Top = 45
      Caption = #26597#35810
      TabOrder = 2
      OnClick = btn_cxClick
    end
    object btn_dy: TButton
      Left = 656
      Top = 45
      Width = 97
      Height = 25
      Caption = #21457#36135#32479#35745#25171#21360
      TabOrder = 3
      OnClick = btn_dyClick
    end
    object cbb_cplb: Ti_ComboBox
      Left = 380
      Top = 16
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
    object cbb_sf: Ti_ComboBox
      Left = 105
      Top = 48
      Width = 90
      Height = 20
      EditLabel.Width = 36
      EditLabel.Height = 12
      EditLabel.Caption = #30465#20221#65306
      EditLabel.Transparent = True
      LabelCaption = #30465#20221#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 5
      OnChange = cbb_sfChange
    end
    object cbb_cs: Ti_ComboBox
      Left = 260
      Top = 48
      Width = 90
      Height = 20
      EditLabel.Width = 36
      EditLabel.Height = 12
      EditLabel.Caption = #22478#24066#65306
      EditLabel.Transparent = True
      LabelCaption = #22478#24066#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 6
      OnChange = cbb_csChange
    end
    object cbb_qx: Ti_ComboBox
      Left = 412
      Top = 48
      Width = 90
      Height = 20
      EditLabel.Width = 36
      EditLabel.Height = 12
      EditLabel.Caption = #21306#21439#65306
      EditLabel.Transparent = True
      LabelCaption = #21306#21439#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 7
      OnChange = cbb_qxChange
    end
    object cbb_xpl: Ti_ComboBox
      Left = 590
      Top = 17
      Width = 97
      Height = 20
      EditLabel.Width = 72
      EditLabel.Height = 12
      EditLabel.Caption = #26159#21542#23567#25209#37327#65306
      EditLabel.Transparent = True
      LabelCaption = #26159#21542#23567#25209#37327#65306
      LabelPosition = lpLeft
      LabelSpacing = 3
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 8
      Text = #20840#37096
      Items.Strings = (
        #20840#37096
        #21542
        #26159)
      ItemIndex = 0
    end
  end
  object RzGroupBox2: TRzGroupBox
    Left = 0
    Top = 81
    Width = 800
    Height = 96
    Align = alTop
    Caption = #21457#36135#32479#35745
    TabOrder = 1
    object Shape2: TShape
      Left = 24
      Top = 48
      Width = 657
      Height = 25
      Brush.Color = clBtnFace
    end
    object Shape3: TShape
      Left = 24
      Top = 24
      Width = 657
      Height = 25
      Brush.Color = clBtnFace
    end
    object lab_fhzms: TLabel
      Left = 32
      Top = 32
      Width = 138
      Height = 12
      Caption = #20849#21457#36135#65306'0 '#26522'(0'#31665')'#65292#20854#20013
    end
    object lab_fhms: TLabel
      Left = 56
      Top = 56
      Width = 384
      Height = 12
      Caption = #26222#21345' 0 '#26522'(0'#31665')'#65292#20449#21345' 0 '#26522'(0'#31665')'#65292#36154#21345#23553' 0 '#26522'(0'#31665')'#65292#36154#21345' 0 '#26522'(0'#31665')'
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 177
    Width = 800
    Height = 423
    Align = alClient
    Caption = #36816#36755#21333#21495#32479#35745
    TabOrder = 2
    object Shape4: TShape
      Left = 24
      Top = 24
      Width = 657
      Height = 25
      Brush.Color = clBtnFace
    end
    object lab_yrlysdh: TLabel
      Left = 32
      Top = 32
      Width = 72
      Height = 12
      Caption = #20849#24405#20837#65306'0 '#31665
    end
  end
  object rmr_FHTJ: TRMGridReport
    ThreadPrepareReport = True
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbPageSetup, pbExit, pbSaveToXLS, pbExport, pbNavigator]
    DefaultCollate = False
    SaveReportOptions.RegistryPath = 'Software\ReportMachine\ReportSettings\'
    PreviewOptions.RulerUnit = rmutScreenPixels
    PreviewOptions.RulerVisible = False
    PreviewOptions.DrawBorder = False
    PreviewOptions.BorderPen.Color = clGray
    PreviewOptions.BorderPen.Style = psDash
    Dataset = rmdb_FHTJ
    StoreInDFM = True
    CompressLevel = rmzcFastest
    CompressThread = False
    LaterBuildEvents = True
    OnlyOwnerDataSet = False
    Left = 688
    Top = 80
    ReportData = {
      6B0600001E005265706F72744D616368696E65205265706F72742046696C6520
      332E301A42000000AE0000000000000000000000000001000000000000000000
      00000F0044656661756C74205072696E7465721257000000756E697420526570
      6F72743B0D0A0D0A696E746572666163650D0A0D0A696D706C656D656E746174
      696F6E0D0A0D0A70726F636564757265204D61696E3B0D0A626567696E0D0A0D
      0A656E643B0D0A0D0A656E642E0D0A0000006B060000FF110054524D47726964
      5265706F727450616765040005005061676531010900000033080000990B0000
      983A0000983A0000983A0000983A00000000FFFF0000000000F9000000000000
      0000000000FFFFFFFFFFFFFFFF00000000000100000000000000000000000300
      0200090000000300000025420000254200002542000025420000254200002542
      000025420000FD7A0000CE180000F01C00009602000001000100080001000100
      010400CBCECCE5F3FFFFFF0000080000FF8600000B0006004D656D6F31390000
      0000000000002E4F0200BD16000011020000110200000000011800000080FFFF
      FF1F000001000000000009010000000100000000000901000000010000000000
      0901000000010000000000090100000000000122040000000000000000000000
      123E000000E585B1E58F91E8B4A7EFBC9A5B726D64625F4648544A2E22594648
      4D53225D20E69E9A285B726D64625F4648544A2E225946485853225D20E7AEB1
      290D0A000000000000022E000001000000000000000000000000000000000003
      005B3B5DFFFFFFFF05000400CBCECCE5F3FFFFFF0000080000FF860000010200
      0000000000000000000000000000FFFFFF1F00000D004D532053616E73205365
      726966F5FFFFFF0200000000000100000000FFFFFFFFFFFFFFFFA00400000100
      0200080002000100010400CBCECCE5F3FFFFFF0000080000FF8600000B000600
      4D656D6F323900000000000000002E4F0200DF1A000011020000110200000100
      019800000080FFFFFF1F00000100000000000901000000010000000000090100
      0000010000000000090100000001000000000009010000000000012204000000
      0000000000000000120001000020202020E699AEE58DA1205B726D64625F4648
      544A2E22594648504B4D53225D20E69E9A285B726D64625F4648544A2E225946
      48504B5853225D20E7AEB129EFBC8CE4BFA1E58DA1205B726D64625F4648544A
      2E22594648584B4D53225D20E69E9A285B726D64625F4648544A2E2259464858
      4B5853225D20E7AEB129EFBC8CE8B4BAE58DA1E5B081205B726D64625F464854
      4A2E22594648484B464D53225D20E69E9A285B726D64625F4648544A2E225946
      48484B465853225D20E7AEB129EFBC8CE8B4BAE58DA1205B726D64625F464854
      4A2E22594648484B4D53225D20E69E9A285B726D64625F4648544A2E22594648
      484B5853225D20E7AEB1290D0A000000000000022E0000010000000000000000
      00000000000000000003005B3B5DFFFFFFFF05000400CBCECCE5F3FFFFFF0000
      080000FF8600000102000000000000000000000000000000FFFFFF1F00000D00
      4D532053616E73205365726966F5FFFFFF0200000000000100000000FFFFFFFF
      FFFFFFFF0B004D617374657244617461310B004D617374657244617461310004
      00CBCECCE5F3FFFFFF0000080000FF86000000000000000000000000000400CB
      CECCE5F3FFFFFF0000080000FF86000000000000000000000000000400CBCECC
      E5F3FFFFFF0000080000FF8600000000000400CBCECCE5F3FFFFFF0000080000
      FF860000000000000000000000000001013C110054524D42616E644D61737465
      724461746136060000000B000B004D6173746572446174613100000000000000
      00000000000000000011020000110200000002009800000000FFFFFF1F000000
      0000000000090100000000000000000009010000000000000000000901000000
      0000000000000901000000000001220400000000000000000000001000000000
      000000000000022E000001000000000000000000000000000000000003005B3B
      5DFFFFFFFF05000900726D64625F4648544A0000000D004D532053616E732053
      65726966F5FFFFFF0000080000FF01000000000000000000020300000000AC14
      000001000000B5CE000000000000000000000000000000000000FE4200210052
      65706F72744D616368696E652044696374696F6E6172792046696C652033301A
      0000000000000000FD000000000000}
  end
  object rmdb_FHTJ: TRMDBDataSet
    Visible = True
    DataSet = ADO_FHTJ
    Left = 656
    Top = 80
  end
  object ADO_FHTJ: TADOQuery
    Connection = DM_DataBase.Con_YDPrint
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    Parameters = <>
    SQL.Strings = (
      'Exec p_fhtj '#39'2012.01.01'#39','#39'2012.05.01'#39)
    Left = 656
    Top = 112
  end
end
