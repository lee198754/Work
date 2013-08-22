object Frm_Select: TFrm_Select
  Left = 266
  Top = 86
  Width = 748
  Height = 406
  Caption = #36873#25321#26448#26009
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    732
    368)
  PixelsPerInch = 96
  TextHeight = 12
  object Bevel1: TBevel
    Left = 8
    Top = 295
    Width = 713
    Height = 18
    Anchors = [akLeft, akRight, akBottom]
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
    Top = 319
    Anchors = [akRight, akBottom]
    Caption = #30830#23450
    TabOrder = 3
    OnClick = btn_okClick
  end
  object btn_close: TRzButton
    Left = 643
    Top = 319
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
    OnChange = cbb_typeChange
  end
  object stg_select: Ti_StgEdit
    Left = 8
    Top = 40
    Width = 713
    Height = 261
    Anchors = [akLeft, akTop, akRight, akBottom]
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
    FixedWordBreak = True
    PermitCellSizing = False
    PermitExport = True
    WordBreak = False
    FixedRowAlignmentCenter = True
    ZeroToEmpty = True
    KeepEdit = False
    EnterAddRow = False
    ColWidths = (
      70
      64)
    RowHeights = (
      20
      20)
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 349
    Width = 732
    Height = 19
    Panels = <
      item
        Text = #21452#20987#36873#20013#39033#25110#36873#20013#24182#28857#20987#30830#23450#25353#38062#36827#34892#30830#35748
        Width = 50
      end>
  end
end
