object Frm_OrderList: TFrm_OrderList
  Left = 310
  Top = 142
  Width = 1180
  Height = 528
  Caption = #35746#21333#20449#24687
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
  object RzSizePanel1: TRzSizePanel
    Left = 0
    Top = 0
    Width = 247
    Height = 490
    Color = clBtnShadow
    HotSpotVisible = True
    SizeBarStyle = ssGroupBar
    SizeBarWidth = 7
    TabOrder = 0
    object RzGroupBar1: TRzGroupBar
      Left = 0
      Top = 0
      Width = 239
      Height = 490
      GradientColorStart = clBtnFace
      GradientColorStop = clBtnShadow
      GroupBorderSize = 4
      VisualStyle = vsWinXP
      Align = alClient
      Color = clBtnShadow
      ParentColor = False
      TabOrder = 0
      object RzGroup1: TRzGroup
        Items = <>
        Opened = True
        OpenedHeight = 391
        DividerVisible = False
        Caption = #35746#21333
        ParentColor = False
        object lv_dd: TRzListView
          Left = 1
          Top = 20
          Width = 229
          Height = 370
          Align = alClient
          Checkboxes = True
          Columns = <
            item
              Caption = #36873#25321
              Width = 40
            end
            item
              Caption = #20135#21697#32534#21495
              Width = 130
            end
            item
              Caption = #20998#32452
              Width = 38
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
    end
    object btn_ddth: TButton
      Left = 8
      Top = 408
      Width = 75
      Height = 25
      Caption = #35746#21333#26367#25442
      TabOrder = 1
      OnClick = btn_ddthClick
    end
  end
  object Panel2: TPanel
    Left = 247
    Top = 0
    Width = 917
    Height = 490
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object stg_list: Ti_StgEdit
      Left = 1
      Top = 1
      Width = 915
      Height = 442
      Align = alClient
      ColCount = 12
      DefaultRowHeight = 20
      FixedCols = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      Options = [goRangeSelect, goRowSizing, goColSizing]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnSelectCell = stg_listSelectCell
      pt_TitleHeight = 20
      FixedFontStyle = []
      OnLinkClick = stg_listLinkClick
      RowSelect = False
      FocusColor = clBlack
      RowSelectColor = clHighlight
      RowSelect_TextColor_Highlight = True
      AutoUpdate = True
      Merge_FixedRow = True
      Merge_FixedCol = False
      Merge_Cell = False
      FixedFontSize = 9
      FixedFontName = #23435#20307
      FixedGridLineColor = clBlack
      GridLinesFixed = PGridInset
      FormatString = #36873#25321'|'#23458#25143#21517#31216'|'#20135#21697#32534#21495'|'#37038#36164#22270'|'#21097#20313#21360#37327'('#26522')|'#26412#27425#21360#37327'('#26522')|'#32452#21495'|'#20817#22870#21495#27573#36215'|'#20817#22870#21495#27573#27490'|'#22791#27880'|'#22810#21495#27573#24405#20837'|'
      FixedWordBreak = True
      PermitCellSizing = False
      PermitExport = True
      WordBreak = False
      FixedRowAlignmentCenter = True
      ZeroToEmpty = True
      KeepEdit = False
      EnterAddRow = False
      ColWidths = (
        36
        113
        137
        57
        82
        80
        43
        78
        82
        124
        79
        64)
      RowHeights = (
        20
        20)
    end
    object Panel1: TPanel
      Left = 1
      Top = 443
      Width = 915
      Height = 46
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object btn_ok: TButton
        Left = 56
        Top = 8
        Width = 75
        Height = 25
        Caption = #30830#35748
        TabOrder = 0
        OnClick = btn_okClick
      end
      object btn_close: TButton
        Left = 200
        Top = 8
        Width = 75
        Height = 25
        Caption = #20851#38381
        ModalResult = 2
        TabOrder = 1
      end
      object btn_hdrl: TButton
        Left = 320
        Top = 8
        Width = 75
        Height = 25
        Caption = #21495#27573#21521#19979#24405#20837
        TabOrder = 2
        OnClick = btn_hdrlClick
      end
    end
    object edt_Temp: TEdit
      Left = 352
      Top = 264
      Width = 121
      Height = 18
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 2
      Text = 'edt_Temp'
      OnExit = edt_TempExit
    end
    object cb_Temp: TCheckBox
      Left = 336
      Top = 216
      Width = 97
      Height = 17
      Caption = 'cb_Temp'
      TabOrder = 3
    end
  end
  object ImageList1: TImageList
    Height = 20
    Width = 0
    Left = 160
    Top = 320
  end
end
