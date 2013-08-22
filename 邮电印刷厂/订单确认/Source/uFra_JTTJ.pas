unit uFra_JTTJ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DB, ADODB, RM_Dataset, RM_System, RM_Common, RM_Class,
  RM_GridReport, RM_e_Xls, Grids, iGrid, StdCtrls, RzCmboBx, iComboBox,
  RzButton, ComCtrls, RzDTP, ExtCtrls, RzPanel;

type
  TFra_JTTJ = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    dtp_cxq: TRzDateTimePicker;
    dtp_cxz: TRzDateTimePicker;
    btn_cx: TRzButton;
    btn_dy: TButton;
    cbb_cplb: Ti_ComboBox;
    RzGroupBox2: TRzGroupBox;
    stg_jttj: Ti_StgEdit;
    rmr_JTTJ: TRMGridReport;
    rmdb_JTTJ: TRMDBDataSet;
    ADO_JTTJ: TADOQuery;
    btn_export: TRzButton;
    procedure btn_dyClick(Sender: TObject);
    procedure btn_cxClick(Sender: TObject);
    procedure btn_exportClick(Sender: TObject);
  private
    { Private declarations }
    procedure ReadJTTJ(ADO_Rec: TADOQuery);
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

uses
  uPub_Type,uPub_Text,uPub_Func, PubStr, uDM_DataBase;

{$R *.dfm}

const
  c_JTBH      = 0;
  c_JTMC      = 1;
  c_ZMSC      = 2;
  c_FMSC      = 3;
  c_ZMLZ      = 4;
  c_FMLZ      = 5;

{ TFra_JTTJ }

procedure TFra_JTTJ.FraShow;
var
  sCPLB: string;
begin
  if cbb_cplb.Text <> '' then
    sCPLB := cbb_cplb.Text;
  if sCPLB = '' then
  begin
    dtp_cxq.DateTime := Now;
    dtp_cxz.DateTime := Now;
  end;
  cbb_cplb.Clear;
  cbb_cplb.Items.Add('--全部--');
  CbbAdd(cbb_cplb,pkProductCategory);
  if sCPLB <> '' then
    cbb_cplb.ItemIndex := cbb_cplb.Items.IndexOf(sCPLB)
  else
    cbb_cplb.ItemIndex := c_Default_CPLB;
end;

procedure TFra_JTTJ.btn_dyClick(Sender: TObject);
begin
  rmr_JTTJ.PrepareReport;
  rmr_JTTJ.ShowReport;
end;

procedure TFra_JTTJ.ReadJTTJ(ADO_Rec: TADOQuery);
var
  i,n,j: Integer;
  sSczt,sCxbz: string;
  dDate: TDateTime;
begin
  stg_jttj.Clear;
  stg_jttj.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
  i := 0;
  btn_cx.Caption := '查询中...';
  with ADO_Rec do
  begin
    First;
    n := 1;
    while not Eof do
    begin
      inc(i);
      if i mod 100 = 0 then
        btn_cx.Caption := '查询中'+StrLeft(StrRep('.',(i div 100) Mod 4)+'   ',3);
      stg_jttj.cells[c_JTBH,n] := FieldByName('JTBH').AsString ;
      stg_jttj.cells[c_JTMC,n] := FieldByName('JTMC').AsString ;
      stg_jttj.cells[c_ZMSC,n] := FieldByName('ZMSC').AsString ;
      stg_jttj.cells[c_FMSC,n] := FieldByName('FMSC').AsString ;
      stg_jttj.cells[c_ZMLZ,n] := FieldByName('ZMLZ').AsString ;
      stg_jttj.cells[c_FMLZ,n] := FieldByName('FMLZ').AsString ;
      inc(n);
      Next;
    end;
  end;

  btn_cx.Caption := '查询';
end;

procedure TFra_JTTJ.btn_cxClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sCxq,sCxz: string;
  iCplb: integer;
begin
  sCxq := FormatDateTime('yyyyMMdd',dtp_cxq.DateTime)+' 00:00:00';
  sCxz := FormatDateTime('yyyyMMdd',dtp_cxz.DateTime)+' 23:59:59';
  iCplb := FindProductCategoryID(cbb_cplb.ItemIndex);
  //ADO_Rec := DM_DataBase.OpenQuery('Exec p_sctj ''%s'',''%s''',[sCxq,sCxz]);
  ADO_JTTJ.Close;
  ADO_JTTJ.SQL.Text := Format('Exec p_jttj ''%s'',''%s'',%d',[sCxq,sCxz,iCplb]);
  ADO_JTTJ.Open;
  ReadJTTJ(ADO_JTTJ);
end;

procedure TFra_JTTJ.btn_exportClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    DM_DataBase.gr_dc.p_SaveToExcel(stg_jttj,['机台编号','机台名称',
      '正面色次','反面色次','正面轮转','反面轮转'],[c_JTBH,c_JTMC,c_ZMSC,
      c_FMSC,c_ZMLZ,c_FMLZ],[0,0,0,0,0,0],False);
    p_MessageBoxDlg('导出成功!');
  except
    p_MessageBoxDlg('导出失败!');
  end;
  Screen.Cursor := crDefault;

end;

end.
