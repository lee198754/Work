object Frm_Select_JT: TFrm_Select_JT
  Left = 266
  Top = 86
  Width = 748
  Height = 398
  Caption = #36873#25321#26426#21488
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    732
    360)
  PixelsPerInch = 96
  TextHeight = 12
  object Bevel1: TBevel
    Left = 8
    Top = 287
    Width = 713
    Height = 18
    Anchors = [akRight, akBottom]
    Shape = bsBottomLine
  end
  object edt_value: Ti_TxtFilter
    Left = 97
    Top = 12
    Width = 121
    Height = 20
    Alignment = taLeftJustify
    WordWrap = False
    WantReturns = False
    WantTabs = False
    ZeroToEmpty = False
    EditLabel.Width = 6
    EditLabel.Height = 12
    EditLabel.Transparent = True
    LabelPosition = lpLeft
    LabelSpacing = 3
    TabEnter = True
    TabOrder = 0
    OnKeyUp = edt_valueKeyUp
    AllowNegative = True
    BorderLine = False
    BorderLineColor = clBlack
    BorderLineGap = 0
    ErrDialog = False
    ErrLostFocus = False
    FullEnter = True
    LabelEnableFollow = True
    LabelLeft = -1
    LabelTransParent = True
    LayOut = BIVCenter
    Style = PNomal
    ReadOnly_X = False
    AllowEmpty_X = True
  end
  object btn_ok: TRzButton
    Left = 547
    Top = 311
    Anchors = [akRight, akBottom]
    Caption = #30830#23450
    TabOrder = 3
    OnClick = btn_okClick
  end
  object btn_close: TRzButton
    Left = 643
    Top = 311
    ModalResult = 2
    Anchors = [akRight, akBottom]
    Caption = #20851#38381
    TabOrder = 4
  end
  object cbb_type: Ti_ComboBox
    Left = 9
    Top = 12
    Width = 81
    Height = 20
    EditLabel.Width = 6
    EditLabel.Height = 12
    EditLabel.Transparent = True
    LabelPosition = lpLeft
    LabelSpacing = 3
    Style = csDropDownList
    ItemHeight = 12
    TabOrder = 2
    Text = #26426#21488#32534#21495
    OnChange = cbb_typeChange
    Items.Strings = (
      #26426#21488#32534#21495
      #26426#21488#21517#31216)
    ItemIndex = 0
  end
  object stg_select: Ti_StgEdit
    Left = 8
    Top = 40
    Width = 713
    Height = 253
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 6
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
    TabOrder = 1
    OnDblClick = stg_selectDblClick
    pt_TitleHeight = 20
    FixedFontStyle = []
    RowSelect = True
    FocusColor = clBlack
    RowSelectColor = clGrayText
    RowSelect_TextColor_Highlight = True
    AutoUpdate = True
    Merge_FixedRow = True
    Merge_FixedCol = False
    Merge_Cell = False
    FixedFontSize = 9
    FixedFontName = #23435#20307
    FixedGridLineColor = clBlack
    GridLinesFixed = PGridInset
    FormatString = #26426#21488#32534#21495'|'#26426#21488#21517#31216'|'#29983#25104#26448#26009#21517#32534#21495'|'#29983#25104#26448#26009#21517#31216'|'#29983#25104#26448#26009#21517#35268#26684'|'#29983#25104#26448#26009#21333#20301
    FixedWordBreak = True
    PermitCellSizing = False
    PermitExport = True
    WordBreak = False
    FixedRowAlignmentCenter = True
    ZeroToEmpty = True
    KeepEdit = False
    EnterAddRow = False
    ColWidths = (
      149
      174
      95
      108
      91
      81)
    RowHeights = (
      20
      20)
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 341
    Width = 732
    Height = 19
    Panels = <
      item
        Text = #21452#20987#36873#20013#39033#25110#36873#20013#24182#28857#20987#30830#23450#25353#38062#36827#34892#30830#35748
        Width = 50
      end>
  end
end
