unit uFrm_Select_ZBGX;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, ExtCtrls, Grids, iGrid, StdCtrls, ButtonEdit,
  RzCmboBx, iComboBox, ADODB, ComCtrls;

type
  TFrm_Select_ZBGX = class(TForm)
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
    vGXBH, vGXMC, vLBGG, vCL, vDW: string;
    vSuccess: Boolean;
  end;

var
  Frm_Select_ZBGX: TFrm_Select_ZBGX;

implementation

uses uDM_DataBase, PubStr;

{$R *.dfm}

const
  c_GXBH     = 0;   //工序编号
  c_GXMC     = 1;   //工序名称
  c_LBGG     = 2;   //类别规格
  c_CL       = 3;   //产量
  c_DW       = 4;   //单位

procedure TFrm_Select_ZBGX.cbb_typeChange(Sender: TObject);
begin
  edt_value.Text := '';
end;

procedure TFrm_Select_ZBGX.edt_valueKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  sCode, sName: string;
  n: Integer;
begin
  sCode := '';  sName := '';
  if cbb_type.Text = '工序编号' then
  begin
    sCode := Ti_TxtFilter(Sender).Text;
  end else
  if cbb_type.Text = '工序名称' then
  begin
    sName := Ti_TxtFilter(Sender).Text;
  end;
  //获取Item列表
  sSqlData := 'select * from BI_WorkProcManage where F_sCode like ''%%%s%%'' and F_sName like ''%%%s%%'' order by F_sCode ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sCode,sName]);
  stg_Select.Clear;
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    stg_Select.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
    n := 1;
    with ADO_Rec do
    begin
      while not Eof do
      begin
        stg_Select.Cells[c_GXBH,n] := ADO_Rec.FieldByName('F_sCode').AsString;
        stg_Select.Cells[c_GXMC,n] := ADO_Rec.FieldByName('F_sName').AsString;
        stg_Select.Cells[c_LBGG,n] := ADO_Rec.FieldByName('F_sCategorySpec').AsString;
        stg_Select.Cells[c_CL,n] := ADO_Rec.FieldByName('F_sOutput').AsString;
        stg_Select.Cells[c_DW,n] := ADO_Rec.FieldByName('F_sUnit').AsString;
        Inc(n);
        ADO_Rec.Next;
      end;
    end;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

end;

procedure TFrm_Select_ZBGX.btn_okClick(Sender: TObject);
begin
  vSuccess := False;
  vGXBH :=  stg_Select.Cells[c_GXBH,stg_Select.Row];
  vGXMC :=  stg_Select.Cells[c_GXMC,stg_Select.Row];
  vLBGG :=  stg_Select.Cells[c_LBGG,stg_Select.Row];
  vCL   :=  stg_Select.Cells[c_CL,stg_Select.Row];
  vDW   :=  stg_Select.Cells[c_DW,stg_Select.Row];

  vSuccess := True;
  Close;
end;

procedure TFrm_Select_ZBGX.FormShow(Sender: TObject);
var
  sSqlData, sCode, sName: string;
  ADO_Rec: TADOQuery;
  n: Integer;
begin
  sCode := '';  sName := '';
  if cbb_type.Text = '工序编号' then
  begin
    sCode := edt_value.Text;
  end else
  if cbb_type.Text = '工序名称' then
  begin
    sName := edt_value.Text;
  end;
  //获取Item列表
  sSqlData := 'select * from BI_WorkProcManage where F_sCode like ''%%%s%%'' and F_sName like ''%%%s%%'' order by F_sCode ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sCode,sName]);
//  sSqlData := 'select * from BI_WorkProcManage order by F_sCode ';
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
        stg_Select.Cells[c_GXBH,n] := ADO_Rec.FieldByName('F_sCode').AsString;
        stg_Select.Cells[c_GXMC,n] := ADO_Rec.FieldByName('F_sName').AsString;
        stg_Select.Cells[c_LBGG,n] := ADO_Rec.FieldByName('F_sCategorySpec').AsString;
        stg_Select.Cells[c_CL,n] := ADO_Rec.FieldByName('F_sOutput').AsString;
        stg_Select.Cells[c_DW,n] := ADO_Rec.FieldByName('F_sUnit').AsString;
        Inc(n);
        ADO_Rec.Next;
      end;
    end;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

end;

procedure TFrm_Select_ZBGX.stg_selectDblClick(Sender: TObject);
begin
  btn_ok.Click;
end;

end.
