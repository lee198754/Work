object Frm_OrderRec: TFrm_OrderRec
  Left = 142
  Top = 87
  Width = 1024
  Height = 625
  Caption = #35746#21333#25509#25910
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  Icon.Data = {
    0000010001001010000001001800680300001600000028000000100000002000
    0000010018000000000040030000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000ADA6A61B252FAEA19F000000
    000000000000000000000000BFA99F755944C1ABA10000000000000000000000
    000000006E7E8C30BAEC0B1826AEA19F000000000000000000BFA99F755944EC
    E4DDB6A08F000000000000000000000000000000B5ABAA6E7E8C30BAEC1E2B3B
    AEA19F000000BFA99F755944F4EFE9B7A1900000000000000000000000000000
    00000000000000B5ABAA6E7E8C30BAEC2D3A4AA2928D755944FDF9F5B7A19000
    0000000000000000000000000000000000000000000000000000B5ABAA6E7E8C
    3EA6CA755944FFFFFDB7A1900000000000000000000000000000000000000000
    00000000000000000000000000A89A95755944FFFFFDB7A190ACA09E00000000
    0000CEB8B1C1AAA0795B48C1ABA1000000000000000000000000BFA99F755944
    FFFFFDB7A19030BAEC606368AB9B94000000B9A297826754F3EFEC967D690000
    00000000000000BFA99F755944FFFFFDB7A190B5ABAA6E7E8C779DA6977E6D8B
    715E7C604C917764AC9380C2AC9FBEA79C9A8170846957886F5DFFFFFDB7A190
    000000000000B5A59CA18E82F3EFECE6DDD6D5C7BC967C6BC2ACA1CFBAB2B7A1
    90C2AFA1C0AC9DC2AFA0967E6C000000000000000000CBB6ACBAA393FEFEFEF9
    F7F6E9E1DBB39C8E000000000000B7A190D8C6C0CEB9B0C1AD9F987E6D000000
    000000000000BFA99EA28977FBF9F7E8E0DABBA494CCB7AE0000000000000000
    00000000DDCDC7C9B6A9BDA898000000C7B1A99B806F8E7361B8A79AC0AB9EC0
    A99BCCB7AE000000000000000000000000000000B7A190B7A190C9B3A9000000
    C0A998BAA28FCAB3A2C6AF9DC9B4A90000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    0000C7C70000C3870000C10F0000E01F0000F03F0000F8300000F0100000E000
    0000030000000703000007030000C4070000C41F0000FFFF0000FFFF0000}
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMinimized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 417
    Top = 18
    Width = 60
    Height = 12
    Caption = #25509#21475#22320#22336#65306
    Transparent = True
  end
  object RzGroupBox1: TRzGroupBox
    Left = 24
    Top = 160
    Width = 305
    Height = 177
    Caption = #25509#25910#26631#24535
    TabOrder = 0
    object Label4: TLabel
      Left = 115
      Top = 118
      Width = 6
      Height = 12
      Caption = '~'
    end
    object Chk_0: TRzRadioButton
      Left = 8
      Top = 54
      Width = 68
      Height = 17
      Caption = #26410#25509#25910
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = Chk_0Click
    end
    object Chk_1: TRzRadioButton
      Left = 8
      Top = 82
      Width = 68
      Height = 17
      Caption = #24050#25509#25910
      TabOrder = 1
      OnClick = Chk_1Click
    end
    object Btn_NewList: TRzButton
      Left = 137
      Top = 20
      Caption = #35746#21333#23548#20837
      TabOrder = 2
      OnClick = Btn_NewListClick
    end
    object Box_msbz: TComboBox
      Left = 11
      Top = 23
      Width = 105
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      ItemIndex = 0
      TabOrder = 3
      Text = #23450#21046#22411
      Items.Strings = (
        #23450#21046#22411
        #38144#21806#22411)
    end
    object dtp_DateEnd: TRzDateTimePicker
      Left = 128
      Top = 112
      Width = 105
      Height = 20
      Date = 40815.519739398150000000
      Format = 'yyyy-MM-dd'
      Time = 40815.519739398150000000
      Enabled = False
      TabOrder = 4
    end
    object dtp_DateBegin: TRzDateTimePicker
      Left = 8
      Top = 112
      Width = 105
      Height = 20
      Date = 40815.519739398150000000
      Format = 'yyyy-MM-dd'
      Time = 40815.519739398150000000
      Enabled = False
      TabOrder = 5
    end
    object Button7: TButton
      Left = 224
      Top = 40
      Width = 75
      Height = 25
      Caption = #20462#25913#35746#21333
      TabOrder = 6
      Visible = False
      OnClick = Button7Click
    end
    object btn_ggcx: TButton
      Left = 137
      Top = 56
      Width = 75
      Height = 25
      Caption = #25509#25910#26356#25913#20449#24687
      TabOrder = 7
      OnClick = btn_ggcxClick
    end
  end
  object Edit1: TEdit
    Left = 416
    Top = 32
    Width = 537
    Height = 20
    TabOrder = 1
    Text = 'http://211.156.193.139/PostWebService/services/PostService?wsdl'
  end
  object Memo1: TMemo
    Left = 416
    Top = 64
    Width = 537
    Height = 329
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 24
    Top = 368
    Width = 241
    Height = 97
    Caption = #25163#21160#23548#20837
    TabOrder = 3
    object Button1: TButton
      Left = 16
      Top = 24
      Width = 75
      Height = 25
      Caption = #23548#20837#23450#21046#22411
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 16
      Top = 56
      Width = 75
      Height = 25
      Caption = #23548#20837#38144#21806#22411
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 32
    Top = 32
    Width = 241
    Height = 121
    Caption = #33258#21160#25509#25910
    TabOrder = 4
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 72
      Height = 12
      Caption = #24050#36827#34892#26102#38388#65306
    end
    object lab_Time: TLabel
      Left = 88
      Top = 24
      Width = 6
      Height = 12
    end
    object Label3: TLabel
      Left = 16
      Top = 48
      Width = 84
      Height = 12
      Caption = #24050#25509#25910#35746#21333#25968#65306
    end
    object lab_RecCount: TLabel
      Left = 104
      Top = 48
      Width = 6
      Height = 12
      Caption = '0'
    end
    object btn_Rec: TButton
      Left = 24
      Top = 80
      Width = 75
      Height = 25
      Caption = #24320#22987#25509#25910
      TabOrder = 0
      OnClick = btn_RecClick
    end
    object btn_OpenLog: TButton
      Left = 128
      Top = 80
      Width = 75
      Height = 25
      Caption = #26597#30475#26085#24535
      TabOrder = 1
      OnClick = btn_OpenLogClick
    end
  end
  object btn_qycx: TButton
    Left = 56
    Top = 480
    Width = 75
    Height = 25
    Caption = #31614#26679#26597#35810
    TabOrder = 5
    Visible = False
    OnClick = btn_qycxClick
  end
  object Button3: TButton
    Left = 384
    Top = 480
    Width = 75
    Height = 25
    Caption = #26597#30475#35745#21010#21333
    TabOrder = 6
    Visible = False
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 560
    Top = 464
    Width = 75
    Height = 25
    Caption = #31665#31614
    TabOrder = 7
    Visible = False
    OnClick = Button4Click
  end
  object Edit2: TEdit
    Left = 528
    Top = 440
    Width = 121
    Height = 20
    TabOrder = 8
    Text = '176671'
    Visible = False
  end
  object Button6: TButton
    Left = 472
    Top = 464
    Width = 75
    Height = 25
    Caption = #21457#36135
    TabOrder = 9
    Visible = False
    OnClick = Button6Click
  end
  object DBGridEh1: TDBGridEh
    Left = 664
    Top = 424
    Width = 320
    Height = 120
    DataGrouping.GroupLevels = <>
    DataSource = DataSource1
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = GB2312_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -12
    FooterFont.Name = #26032#23435#20307
    FooterFont.Style = []
    RowDetailPanel.Color = clBtnFace
    TabOrder = 10
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = #26032#23435#20307
    TitleFont.Style = []
    Visible = False
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Button5: TButton
    Left = 504
    Top = 512
    Width = 75
    Height = 25
    Caption = #23548#20837#31665#31614
    TabOrder = 11
    Visible = False
    OnClick = Button5Click
  end
  object XML_Rec: TXMLDocument
    Left = 168
    Top = 424
    DOMVendorDesc = 'MSXML'
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 120
    Top = 432
  end
  object ADO_Write: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 208
    Top = 432
  end
  object OpenDialog1: TOpenDialog
    Filter = '(*.XML)|*.xml'
    Left = 136
    Top = 400
  end
  object tmr_CustomRec: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = tmr_CustomRecTimer
    Left = 248
    Top = 416
  end
  object tmr_SellRec: TTimer
    Enabled = False
    Interval = 15000
    OnTimer = tmr_SellRecTimer
    Left = 288
    Top = 416
  end
  object PopupMenu_Sys: TPopupMenu
    Left = 376
    Top = 400
    object N1: TMenuItem
      Caption = #36864#20986
      OnClick = N1Click
    end
  end
  object tmr_Time: TTimer
    OnTimer = tmr_TimeTimer
    Left = 200
    Top = 80
  end
  object tmr_qycx: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = tmr_qycxTimer
    Left = 280
    Top = 80
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 632
    Top = 400
  end
  object ADOTable1: TADOTable
    CursorType = ctStatic
    TableName = 'BI_CustomOrderDetails'
    Left = 584
    Top = 400
  end
  object tmr_EverydayStart: TTimer
    Interval = 600
    OnTimer = tmr_EverydayStartTimer
    Left = 360
    Top = 176
  end
  object tmr_lrfk: TTimer
    Enabled = False
    Interval = 100000
    OnTimer = tmr_lrfkTimer
    Left = 320
    Top = 80
  end
  object tmr_ggcx: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = tmr_ggcxTimer
    Left = 344
    Top = 224
  end
  object tmr_Error: TTimer
    Interval = 60000
    OnTimer = tmr_ErrorTimer
    Left = 352
    Top = 272
  end
  object RzTrayIcon1: TRzTrayIcon
    PopupMenu = PopupMenu_Sys
    RestoreOn = ticLeftClickUp
    Left = 424
    Top = 392
  end
end
