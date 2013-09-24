unit uFrm_Select;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, ExtCtrls, Grids, iGrid, StdCtrls, ButtonEdit,
  RzCmboBx, iComboBox, ADODB, ComCtrls, uPub_Type;

type
  TFunIsCheck = function :Boolean;

  TFrm_Select = class(TForm)
    edt_value: Ti_TxtFilter;
    Bevel1: TBevel;
    btn_ok: TRzButton;
    btn_close: TRzButton;
    cbb_type: Ti_ComboBox;
    stg_select: Ti_StgEdit;
    StatusBar1: TStatusBar;
    procedure cbb_typeChange(Sender: TObject);
    procedure edt_valueKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_okClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure stg_selectDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function IsCheck: Boolean;
  public
    { Public declarations }
    vSqlData: string;
    vSuccess: Boolean;
    vaSelectField: TArrSelectField;
    vYQSL: Integer;
    fIsCheck: TFunIsCheck;
  end;

var
  Frm_Select: TFrm_Select;

implementation

uses uDM_DataBase, PubStr;

{$R *.dfm}

const
  c_CLBH     = 0;   //材料编号
  c_CLMC     = 1;   //材料名称
  c_CLGG     = 2;   //材料规格
  c_CJGG     = 3;   //裁剪规格
  c_SJJG     = 4;   //实际价格
  c_JHJG     = 5;   //计划价格
  c_DW       = 6;   //单位

procedure TFrm_Select.cbb_typeChange(Sender: TObject);
begin
  edt_value.Text := '';
end;

procedure TFrm_Select.edt_valueKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  sParam1, sParam2: string;
  n, i: Integer;
begin
  sParam1 := '';  sParam2 := '';
//  if Pos('编号',cbb_type.Text) > 0 then
//  begin
//    sBH := Ti_TxtFilter(Sender).Text;
//  end else
//  if Pos('名称',cbb_type.Text) > 0 then
//  begin
//    sMC := Ti_TxtFilter(Sender).Text;
//  end;
  case cbb_type.ItemIndex of
    0: sParam1 := Ti_TxtFilter(Sender).Text;
    1: sParam2 := Ti_TxtFilter(Sender).Text;
  end;
 //获取Item列表
  sSqlData := vSqlData;
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sParam1,sParam2]);
  stg_Select.Clear;
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    stg_Select.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
    n := 1;
    with ADO_Rec do
    begin
      while not Eof do
      begin                                 
        for i := 0 to Length(vaSelectField) -1 do
          stg_Select.Cells[i,n] := ADO_Rec.FieldByName(vaSelectField[i].m_sField).AsString;
        Inc(n);
        ADO_Rec.Next;
      end;
    end;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

end;

procedure TFrm_Select.btn_okClick(Sender: TObject);
var
  i: Integer;
begin
  vSuccess := False;
  for i := 0 to Length(vaSelectField) -1 do
    vaSelectField[i].m_sValue := stg_Select.Cells[i,stg_Select.Row];
  if not fIsCheck then Exit;
  vSuccess := True;
  Close;
end;

procedure TFrm_Select.FormShow(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData, sFields: string;
  sParam1, sParam2: string;
  n, i, iWidth: Integer;
begin
  sParam1 := '';  sParam2 := ''; sFields := '';  iWidth := 0;
//  if Pos('编号',cbb_type.Text) > 0 then
//  begin
//    sBH := edt_value.Text;
//  end else
//  if Pos('名称',cbb_type.Text) > 0 then
//  begin
//    sMC := edt_value.Text;
//  end;
  case cbb_type.ItemIndex of
    0: sParam1 := edt_value.Text;
    1: sParam2 := edt_value.Text;
  end;
  stg_select.ColCount := Length(vaSelectField);
  for i := 0 to Length(vaSelectField) -1 do
  begin
    sFields := sFields + '|' + vaSelectField[i].m_sName;
    stg_select.ColWidths[i] := vaSelectField[i].m_iWidth;
    iWidth := iWidth + vaSelectField[i].m_iWidth;
  end;
  if (iWidth+100) > Self.Width then
    Self.Width := iWidth+100;
  if sFields <> '' then
    sFields := Copy(sFields,2,Length(sFields));
  stg_select.FormatString := sFields;
   //获取Item列表
  //sSqlData := 'select * from BI_MatlManage where F_sCLBH like ''%%%s%%'' and F_sCLMC like ''%%%s%%'' order by F_sCLBH ';
  sSqlData := vSqlData;
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sParam1,sParam2]);
  stg_Select.Clear;
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    stg_Select.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
    n := 1;
    with ADO_Rec do
    begin
      while not Eof do
      begin                                 
        for i := 0 to Length(vaSelectField) -1 do
          stg_Select.Cells[i,n] := ADO_Rec.FieldByName(vaSelectField[i].m_sField).AsString;
        Inc(n);
        ADO_Rec.Next;
      end;
    end;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

end;

procedure TFrm_Select.stg_selectDblClick(Sender: TObject);
begin
  btn_ok.Click;
end;

procedure TFrm_Select.FormCreate(Sender: TObject);
begin
  @fIsCheck := @TFrm_Select.IsCheck;
  //ShowMessage(BoolToStr(IsCheck));
end;



function TFrm_Select.IsCheck: Boolean;
begin
  Result := True;
end;

end.
