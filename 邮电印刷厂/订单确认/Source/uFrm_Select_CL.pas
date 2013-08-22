unit uFrm_Select_CL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, ExtCtrls, Grids, iGrid, StdCtrls, ButtonEdit,
  RzCmboBx, iComboBox, ADODB, ComCtrls;

type
  TFrm_Select_CL = class(TForm)
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
  private
    { Private declarations }
  public
    { Public declarations }
    vCLBH, vCLMC, vCLGG, vCJGG, vDW, vCLSJJG, vCLJHJG: string;
    vSuccess: Boolean;
  end;

var
  Frm_Select_CL: TFrm_Select_CL;

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

procedure TFrm_Select_CL.cbb_typeChange(Sender: TObject);
begin
  edt_value.Text := '';
end;

procedure TFrm_Select_CL.edt_valueKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  sCLBH, sCLMC: string;
  n: Integer;
begin
  sCLBH := '';  sCLMC := '';
  if cbb_type.Text = '材料编号' then
  begin
    sCLBH := Ti_TxtFilter(Sender).Text;
  end else
  if cbb_type.Text = '材料名称' then
  begin
    sCLMC := Ti_TxtFilter(Sender).Text;
  end;
  //获取Item列表
  sSqlData := 'select * from BI_MatlManage where F_sCLBH like ''%%%s%%'' and F_sCLMC like ''%%%s%%'' order by F_sCLBH ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sCLBH,sCLMC]);
  stg_Select.Clear;
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    stg_Select.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
    n := 1;
    with ADO_Rec do
    begin
      while not Eof do
      begin
        stg_Select.Cells[c_CLBH,n] := ADO_Rec.FieldByName('F_sCLBH').AsString;
        stg_Select.Cells[c_CLMC,n] := ADO_Rec.FieldByName('F_sCLMC').AsString;
        stg_Select.Cells[c_CLGG,n] := ADO_Rec.FieldByName('F_sCLGG').AsString;
        stg_Select.Cells[c_CJGG,n] := ADO_Rec.FieldByName('F_sCJGG').AsString;
        stg_Select.Cells[c_SJJG,n] := ADO_Rec.FieldByName('F_nSJJG').AsString;
        stg_Select.Cells[c_JHJG,n] := ADO_Rec.FieldByName('F_nJHJG').AsString;
        stg_Select.Cells[c_DW,n] := ADO_Rec.FieldByName('F_sDW').AsString;
        Inc(n);
        ADO_Rec.Next;
      end;
    end;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

end;

procedure TFrm_Select_CL.btn_okClick(Sender: TObject);
begin
  vSuccess := False;
  vCLBH := stg_Select.Cells[c_CLBH,stg_Select.Row];
  vCLMC := stg_Select.Cells[c_CLMC,stg_Select.Row];
  vCLGG := stg_Select.Cells[c_CLGG,stg_Select.Row];
  vCJGG := stg_Select.Cells[c_CJGG,stg_Select.Row];
  vCLSJJG := stg_Select.Cells[c_SJJG,stg_Select.Row];
  vCLJHJG := stg_Select.Cells[c_JHJG,stg_Select.Row];
  vDW   := stg_Select.Cells[c_DW,stg_Select.Row];

  vSuccess := True;
  Close;
end;

procedure TFrm_Select_CL.FormShow(Sender: TObject);
var
  sSqlData, sCLBH,sCLMC : string;
  ADO_Rec: TADOQuery;
  n: Integer;
begin
  sCLBH := '';  sCLMC := '';
  if cbb_type.Text = '材料编号' then
  begin
    sCLBH := edt_value.Text;
  end else
  if cbb_type.Text = '材料名称' then
  begin
    sCLMC := edt_value.Text;
  end;
  //获取Item列表
  sSqlData := 'select * from BI_MatlManage where F_sCLBH like ''%%%s%%'' and F_sCLMC like ''%%%s%%'' order by F_sCLBH ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sCLBH,sCLMC]);
//  sSqlData := 'select * from BI_MatlManage order by F_sCLBH ';
//  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
  stg_Select.Clear;
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    stg_Select.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
    n := 1;
    with ADO_Rec do
    begin
      while not Eof do
      begin
        stg_Select.Cells[c_CLBH,n] := ADO_Rec.FieldByName('F_sCLBH').AsString;
        stg_Select.Cells[c_CLMC,n] := ADO_Rec.FieldByName('F_sCLMC').AsString;
        stg_Select.Cells[c_CLGG,n] := ADO_Rec.FieldByName('F_sCLGG').AsString;
        stg_Select.Cells[c_CJGG,n] := ADO_Rec.FieldByName('F_sCJGG').AsString;
        stg_Select.Cells[c_SJJG,n] := ADO_Rec.FieldByName('F_nSJJG').AsString;
        stg_Select.Cells[c_JHJG,n] := ADO_Rec.FieldByName('F_nJHJG').AsString;
        stg_Select.Cells[c_DW,n] := ADO_Rec.FieldByName('F_sDW').AsString;
        Inc(n);
        ADO_Rec.Next;
      end;
    end;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

end;

procedure TFrm_Select_CL.stg_selectDblClick(Sender: TObject);
begin
  btn_ok.Click;
end;

end.
