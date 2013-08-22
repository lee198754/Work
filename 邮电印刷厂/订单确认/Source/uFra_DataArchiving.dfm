object Fra_DataArchiving: TFra_DataArchiving
  Left = 0
  Top = 0
  Width = 800
  Height = 600
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object RzGroupBox1: TRzGroupBox
    Left = 0
    Top = 0
    Width = 800
    Height = 57
    Align = alTop
    Caption = #24402#26723#26465#20214
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 25
      Width = 84
      Height = 14
      Caption = #35746#21333#19979#36798#26085#26399
    end
    object Label2: TLabel
      Left = 224
      Top = 29
      Width = 7
      Height = 14
      Caption = '~'
    end
    object dtp_wgq: TRzDateTimePicker
      Left = 112
      Top = 21
      Width = 105
      Height = 20
      Date = 40801.000000000000000000
      Time = 40801.000000000000000000
      TabOrder = 0
    end
    object dtp_wgz: TRzDateTimePicker
      Left = 240
      Top = 21
      Width = 105
      Height = 20
      Date = 40801.000000000000000000
      Time = 40801.000000000000000000
      TabOrder = 1
    end
    object btn_cx: TRzButton
      Left = 601
      Top = 18
      Caption = #26597#35810
      TabOrder = 2
      OnClick = btn_cxClick
    end
    object btn_Archiving: TRzButton
      Left = 689
      Top = 18
      Caption = #24402#26723
      TabOrder = 3
      OnClick = btn_ArchivingClick
    end
    object Button1: TButton
      Left = 488
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 4
      OnClick = Button1Click
    end
  end
  object gb_dd: TRzGroupBox
    Left = 0
    Top = 57
    Width = 800
    Height = 543
    Align = alClient
    Caption = #26410#23436#25104#35746#21333
    TabOrder = 1
    object dbg_ddxx: TDBGridEh
      Left = 1
      Top = 15
      Width = 798
      Height = 498
      Align = alClient
      ColumnDefValues.Layout = tlCenter
      ColumnDefValues.Title.Alignment = taCenter
      ColumnDefValues.Title.TitleButton = True
      ColumnDefValues.ToolTips = True
      Ctl3D = True
      DataGrouping.GroupLevels = <>
      DataSource = DM_DataBase.ds_DataArchiving
      Flat = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #26032#23435#20307
      Font.Style = []
      FooterColor = clWindow
      FooterFont.Charset = GB2312_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -12
      FooterFont.Name = #26032#23435#20307
      FooterFont.Style = []
      FrozenCols = 3
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      OptionsEh = [dghFixed3D, dghFooter3D, dghClearSelection, dghFitRowHeightToText, dghAutoSortMarking, dghMultiSortMarking, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghColumnResize, dghColumnMove, dghAutoFitRowHeight, dghHotTrack, dghExtendVertLines]
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      PopupMenu = pm_ddxx
      ReadOnly = True
      RowDetailPanel.Color = clBtnFace
      RowHeight = 2
      RowLines = 2
      RowSizingAllowed = True
      ShowHint = True
      SortLocal = True
      STFilter.Local = True
      STFilter.Location = stflInTitleFilterEh
      TabOrder = 0
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = #26032#23435#20307
      TitleFont.Style = []
      TitleHeight = 12
      VertScrollBar.SmoothStep = True
      OnCellClick = dbg_ddxxCellClick
      Columns = <
        item
          DropDownBox.Options = [dlgColLinesEh, dlgRowLinesEh]
          EditButtons = <>
          FieldName = 'F_sJg'
          Footers = <>
          Title.Caption = #25215#25597#26426#26500#21517#31216
          Width = 143
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'CPBH'
          Footers = <>
          Title.Caption = #20135#21697#32534#21495
          Width = 138
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'CPLX'
          Footers = <>
          Title.Caption = #31181#31867
          Width = 51
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'F_sYztmc'
          Footers = <>
          Title.Caption = #37038#36164#22270
          Width = 67
        end
        item
          AutoFitColWidth = False
          DisplayFormat = 'yyyy-MM-dd  hh:mm:ss'
          EditButtons = <>
          FieldName = 'JSQR'
          Footers = <>
          Title.Caption = #35746#21333#19979#36798#26085#26399
          Width = 82
        end
        item
          EditButtons = <>
          FieldName = 'LGRQ'
          Footers = <>
          Title.Caption = #26469#31295#26085#26399
          Width = 75
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'SCZT'
          Footers = <>
          Title.Caption = #29983#20135#36827#24230
          Width = 98
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'YL'
          Footers = <>
          Title.Caption = #21360#37327
          Width = 53
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'JYBZ'
          Footers = <>
          Title.Caption = #21152#21360
          Width = 45
        end
        item
          EditButtons = <>
          FieldName = 'CYBZ'
          Footers = <>
          Title.Caption = #37325#21360
          Width = 45
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'XPL'
          Footers = <>
          Title.Caption = #23567#25209#37327
          Width = 60
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'GDH'
          Footers = <>
          Title.Caption = #24037#21333#21495
          Width = 98
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'JHRQ'
          Footers = <>
          Title.Caption = #20132#36135#26085#26399
          Width = 119
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'TS'
          Footers = <>
          Title.Caption = #31163#20132#36135#22825#25968
          Width = 91
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'QY'
          Footers = <>
          Title.Caption = #26159#21542#31614#26679
          Width = 72
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'F_sShr'
          Footers = <>
          Title.Caption = #25910#36135#20154#22995#21517
          Width = 86
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'F_sKhmc'
          Footers = <>
          Title.Caption = #23458#25143#21517#31216
          Width = 191
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'F_iGjs'
          Footers = <>
          Title.Caption = #31295#20214#25968
          Width = 63
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'F_sCpcc'
          Footers = <>
          Title.Caption = #25104#21697#23610#23544
          Width = 69
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'TGZT'
          Footers = <>
          Title.Caption = #22270#31295#29366#24577
          Width = 71
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'F_dCzrq'
          Footers = <>
          Title.Caption = #25805#20316#26085#26399
          Width = 119
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'FKZT'
          Footers = <>
          Title.Caption = #21453#39304#29366#24577
          Width = 70
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'F_dFkrq'
          Footers = <>
          Title.Caption = #21453#39304#26085#26399
          Width = 131
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'OrderID'
          Footers = <>
          Visible = False
        end
        item
          AutoFitColWidth = False
          EditButtons = <>
          FieldName = 'OrderType'
          Footers = <>
          Visible = False
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object pan_data: TPanel
      Left = 1
      Top = 513
      Width = 798
      Height = 29
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #26032#23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        798
        29)
      object lab_up: TLabel
        Left = 562
        Top = 8
        Width = 36
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = #19978#19968#39029
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = lab_firstClick
      end
      object lab_down: TLabel
        Left = 610
        Top = 8
        Width = 36
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = #19979#19968#39029
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = lab_firstClick
      end
      object lab_ts50: TLabel
        Tag = 50
        Left = 114
        Top = 9
        Width = 24
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = '50 |'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        Visible = False
        OnClick = lab_ts50Click
      end
      object lab_first: TLabel
        Left = 514
        Top = 8
        Width = 36
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = #31532#19968#39029
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = lab_firstClick
      end
      object lab_last: TLabel
        Left = 658
        Top = 8
        Width = 48
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = #26368#21518#19968#39029
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = lab_firstClick
      end
      object Label3: TLabel
        Left = 434
        Top = 9
        Width = 12
        Height = 12
        Anchors = [akRight, akBottom]
        Caption = #26465
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lab_zys: TLabel
        Left = 10
        Top = 8
        Width = 54
        Height = 12
        Anchors = [akLeft, akBottom]
        Caption = #39029#27425#65306'0/0'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lab_ts100: TLabel
        Tag = 100
        Left = 146
        Top = 9
        Width = 30
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = '100 |'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        Visible = False
        OnClick = lab_ts50Click
      end
      object lab_ts200: TLabel
        Tag = 200
        Left = 370
        Top = 9
        Width = 30
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = '200 |'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = lab_ts50Click
      end
      object lab_ts500: TLabel
        Tag = 500
        Left = 410
        Top = 9
        Width = 18
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = '500'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = lab_ts50Click
      end
      object Label6: TLabel
        Left = 258
        Top = 9
        Width = 24
        Height = 12
        Anchors = [akRight, akBottom]
        Caption = #27599#39029
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lab_tsQB: TLabel
        Tag = 100000000
        Left = 178
        Top = 9
        Width = 54
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = ' '#26174#31034#20840#37096
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = lab_ts50Click
      end
      object lab_ts15: TLabel
        Tag = 15
        Left = 298
        Top = 9
        Width = 24
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = '15 |'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = lab_ts50Click
      end
      object lab_ts20: TLabel
        Tag = 20
        Left = 330
        Top = 9
        Width = 24
        Height = 12
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = '20 |'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = lab_ts50Click
      end
      object edt_ys: TEdit
        Left = 718
        Top = 5
        Width = 33
        Height = 20
        Anchors = [akRight, akBottom]
        TabOrder = 0
      end
      object btn_go: TButton
        Left = 762
        Top = 2
        Width = 33
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Go'
        TabOrder = 1
        OnClick = btn_goClick
      end
    end
  end
  object pm_ddxx: TPopupMenu
    Left = 544
    Top = 64
    object menu_ddmx: TMenuItem
      Caption = #35746#21333#26126#32454
      OnClick = menu_ddmxClick
    end
    object menu_ddmxPic: TMenuItem
      Caption = #35746#21333#26126#32454'('#21547#22270#31295')'
      Visible = False
      OnClick = menu_ddmxClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object menu_ztmx: TMenuItem
      Caption = #29366#24577#26126#32454
      OnClick = menu_ztmxClick
    end
    object menu_fhmx: TMenuItem
      Caption = #21457#36135#26126#32454
      OnClick = menu_fhmxClick
    end
  end
end
