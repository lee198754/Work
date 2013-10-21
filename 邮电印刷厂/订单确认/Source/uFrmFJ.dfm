object Frm_FJ: TFrm_FJ
  Left = 628
  Top = 163
  Width = 577
  Height = 432
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #37325#26032#20998#35299
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    561
    394)
  PixelsPerInch = 96
  TextHeight = 12
  object Bevel1: TBevel
    Left = 8
    Top = 320
    Width = 542
    Height = 26
    Anchors = [akLeft, akTop, akRight]
    Shape = bsBottomLine
  end
  object Label1: TLabel
    Left = 13
    Top = 304
    Width = 36
    Height = 12
    Caption = #21360#37327#65306
  end
  object lab_zyl: TLabel
    Left = 8
    Top = 36
    Width = 48
    Height = 12
    Caption = #24635#21360#37327#65306
  end
  object Label2: TLabel
    Left = 8
    Top = 12
    Width = 48
    Height = 12
    Caption = #24453#20998#35299#65306
  end
  object lab_cpbh: TLabel
    Left = 56
    Top = 12
    Width = 48
    Height = 12
    Caption = 'lab_cpbh'
  end
  object Label3: TLabel
    Left = 141
    Top = 304
    Width = 36
    Height = 12
    Caption = #37325#21360#65306
  end
  object Label4: TLabel
    Left = 237
    Top = 304
    Width = 36
    Height = 12
    Caption = #20869#20214#65306
  end
  object btn_Ok: TRzButton
    Left = 336
    Top = 355
    Default = True
    Caption = #30830#23450
    TabOrder = 0
    OnClick = btn_OkClick
  end
  object RzButton1: TRzButton
    Left = 440
    Top = 355
    Default = True
    ModalResult = 1
    Caption = #21462#28040
    TabOrder = 1
    OnClick = RzButton1Click
  end
  object btn_Add: TRzButton
    Left = 344
    Top = 298
    Width = 73
    Caption = #28155#21152
    TabOrder = 2
    OnClick = btn_AddClick
  end
  object edt_yl: TEdit
    Tag = 1
    Left = 64
    Top = 301
    Width = 65
    Height = 20
    TabOrder = 3
    Text = 'edt_yl'
  end
  object edt_czyl: TEdit
    Left = 88
    Top = 368
    Width = 73
    Height = 20
    TabOrder = 4
    Text = 'edt_czyl'
    OnExit = edt_czylExit
  end
  object edt_czcpbh: TEdit
    Left = 8
    Top = 368
    Width = 73
    Height = 20
    TabOrder = 5
    Text = 'edt_czcpbh'
  end
  object stg_yl: Ti_StgEdit
    Left = 5
    Top = 56
    Width = 545
    Height = 224
    Anchors = [akLeft, akTop, akRight]
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
    TabOrder = 6
    pt_TitleHeight = 20
    FixedFontStyle = []
    OnLinkClick = stg_ylLinkClick
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
    FormatString = #20135#21697#32534#21495'|'#37038#36164#22270#21517#31216'|'#21360#37327'('#19975#26522')|'#37325#21360'|'#25805#20316'|'
    FixedWordBreak = True
    PermitCellSizing = False
    PermitExport = True
    WordBreak = False
    FixedRowAlignmentCenter = True
    ZeroToEmpty = True
    KeepEdit = False
    EnterAddRow = False
    ColWidths = (
      240
      86
      64
      64
      64
      64)
    RowHeights = (
      20
      20)
  end
  object cb_NJBS: TRzCheckBox
    Left = 448
    Top = 32
    Width = 97
    Height = 17
    Caption = #26377#20869#20214
    State = cbUnchecked
    TabOrder = 7
    Visible = False
  end
  object cb_czcybz: TComboBox
    Left = 176
    Top = 368
    Width = 57
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    ItemIndex = 0
    TabOrder = 8
    Text = #26080
    Visible = False
    Items.Strings = (
      #26080
      #37325#21360)
  end
  object cbb_cybz: TComboBox
    Left = 176
    Top = 300
    Width = 57
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    ItemIndex = 0
    TabOrder = 9
    Text = #26080
    Items.Strings = (
      #26080
      #37325#21360)
  end
  object cbb_NJBZ: TComboBox
    Left = 272
    Top = 300
    Width = 57
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    ItemIndex = 0
    TabOrder = 10
    Text = #21542
    Items.Strings = (
      #21542
      #26159)
  end
  object cbb_YZTMC: TComboBox
    Left = 160
    Top = 350
    Width = 57
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    ItemIndex = 0
    TabOrder = 11
    Text = #26080
    Visible = False
    Items.Strings = (
      #26080
      #37325#21360)
  end
end
