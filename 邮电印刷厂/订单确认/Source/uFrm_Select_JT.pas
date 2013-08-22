unit uFrm_Select_JT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, ExtCtrls, Grids, iGrid, StdCtrls, ButtonEdit,
  RzCmboBx, iComboBox, ADODB, ComCtrls;

type
  TFrm_Select_JT = class(TForm)
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
    vJTBH, vJTMC, vJTCLBH, vJTCLMC, vJTCLGG, vJTCLDW: string;
    vSuccess: Boolean;
  end;

var
  Frm_Select_JT: TFrm_Select_JT;

implementation

uses uDM_DataBase, PubStr;

{$R *.dfm}

const
  c_JTBH     = 0;   //材料编号
  c_JTMC     = 1;   //材料名称
  c_JTCLBH   = 2;   //自动生成的材料编号
  c_JTCLMC   = 3;   //自动生成的材料名称
  c_JTCLGG   = 4;   //自动生成的材料规格
  c_JTCLDW   = 5;   //自动生成的材料单位

procedure TFrm_Select_JT.cbb_typeChange(Sender: TObject);
begin
  edt_value.Text := '';
end;

procedure TFrm_Select_JT.edt_valueKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  sJTBH, sJTMC: string;
  n: Integer;
begin
  sJTBH := '';  sJTMC := '';
  if cbb_type.Text = '机台编号' then
  begin
    sJTBH := Ti_TxtFilter(Sender).Text;
  end else
  if cbb_type.Text = '机台名称' then
  begin
    sJTMC := Ti_TxtFilter(Sender).Text;
  end;
  //获取Item列表
  sSqlData := 'select * from BI_MachineToolInfo where F_sJTBH like ''%%%s%%'' and F_sJTMC like ''%%%s%%'' order by F_sJTBH ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sJTBH,sJTMC]);
  stg_Select.Clear;
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    stg_Select.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
    n := 1;
    with ADO_Rec do
    begin
      while not Eof do
      begin
        stg_Select.Cells[c_JTBH  ,n]   := ADO_Rec.FieldByName('F_sJTBH').AsString;
        stg_Select.Cells[c_JTMC  ,n]   := ADO_Rec.FieldByName('F_sJTMC').AsString;
        stg_Select.Cells[c_JTCLBH,n] := ADO_Rec.FieldByName('F_sJTCLBH').AsString;
        stg_Select.Cells[c_JTCLMC,n] := ADO_Rec.FieldByName('F_sJTCLMC').AsString;
        stg_Select.Cells[c_JTCLGG,n] := ADO_Rec.FieldByName('F_sJTCLGG').AsString;
        stg_Select.Cells[c_JTCLDW,n] := ADO_Rec.FieldByName('F_sJTCLDW').AsString;
        Inc(n);
        ADO_Rec.Next;
      end;
    end;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

end;

procedure TFrm_Select_JT.btn_okClick(Sender: TObject);
begin
  vSuccess := False;
  vJTBH   := stg_Select.Cells[c_JTBH  ,stg_Select.Row];
  vJTMC   := stg_Select.Cells[c_JTMC  ,stg_Select.Row];
  vJTCLBH := stg_Select.Cells[c_JTCLBH,stg_Select.Row];
  vJTCLMC := stg_Select.Cells[c_JTCLMC,stg_Select.Row];
  vJTCLGG := stg_Select.Cells[c_JTCLGG,stg_Select.Row];
  vJTCLDW := stg_Select.Cells[c_JTCLDW,stg_Select.Row];

  vSuccess := True;
  Close;
end;

procedure TFrm_Select_JT.FormShow(Sender: TObject);
var
  sSqlData, sJTBH, sJTMC: string;
  ADO_Rec: TADOQuery;
  n: Integer;
begin
  sJTBH := '';  sJTMC := '';
  if cbb_type.Text = '机台编号' then
  begin
    sJTBH := edt_value.Text;
  end else
  if cbb_type.Text = '机台名称' then
  begin
    sJTMC := edt_value.Text;
  end;
  //获取Item列表
  sSqlData := 'select * from BI_MachineToolInfo where F_sJTBH like ''%%%s%%'' and F_sJTMC like ''%%%s%%'' order by F_sJTBH ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sJTBH,sJTMC]);
  //sSqlData := 'select * from BI_MachineToolInfo order by F_sJTBH ';
  //ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
  stg_Select.Clear;
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    stg_Select.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
    n := 1;
    with ADO_Rec do
    begin
      while not Eof do
      begin
        stg_Select.Cells[c_JTBH,n]   := ADO_Rec.FieldByName('F_sJTBH').AsString;
        stg_Select.Cells[c_JTMC,n]   := ADO_Rec.FieldByName('F_sJTMC').AsString;
        stg_Select.Cells[c_JTCLBH,n] := ADO_Rec.FieldByName('F_sJTCLBH').AsString;
        stg_Select.Cells[c_JTCLMC,n] := ADO_Rec.FieldByName('F_sJTCLMC').AsString;
        stg_Select.Cells[c_JTCLGG,n] := ADO_Rec.FieldByName('F_sJTCLGG').AsString;
        stg_Select.Cells[c_JTCLDW,n] := ADO_Rec.FieldByName('F_sJTCLDW').AsString;
        Inc(n);
        ADO_Rec.Next;
      end;
    end;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

end;

procedure TFrm_Select_JT.stg_selectDblClick(Sender: TObject);
begin
  btn_ok.Click;
end;

end.

