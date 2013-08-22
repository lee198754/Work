unit uFra_CLTJ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, iGrid, DB, ADODB, RM_Dataset, RM_System, RM_Common,
  RM_Class, RM_GridReport, RM_e_Xls, StdCtrls, RzCmboBx, iComboBox,
  RzButton, ComCtrls, RzDTP, ExtCtrls, RzPanel;

type
  TFra_CLTJ = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    dtp_cxq: TRzDateTimePicker;
    dtp_cxz: TRzDateTimePicker;
    btn_cx: TRzButton;
    btn_dy: TButton;
    cbb_cplb: Ti_ComboBox;
    RzGroupBox2: TRzGroupBox;
    rmr_CLTJ: TRMGridReport;
    rmdb_CLTJ: TRMDBDataSet;
    ADO_CLTJ: TADOQuery;
    stg_cltj: Ti_StgEdit;
    procedure btn_cxClick(Sender: TObject);
    procedure btn_dyClick(Sender: TObject);
  private
    { Private declarations }
    procedure ReadCLTJ(ADO_Rec: TADOQuery);
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

{$R *.dfm}

uses
  uPub_Func, uPub_Text, uPub_Type, PubStr;

{ TFra_CLTJ }

const
  c_CLBH      = 0;
  c_CLMC      = 1;
  //c_CLGG      = 2;
  //c_CJGG      = 3;
  c_SJJG      = 2;
  c_JHJG      = 3;
  c_JFQS      = 4;
  c_JFS       = 5;
  c_ZZS       = 6;
  c_YSYSL     = 7;
  c_KCSL      = 8;
  c_CLDW      = 9;
  c_SJSYJE    = 10;
  c_JHSYJE    = 11;

procedure TFra_CLTJ.FraShow;
var
  sCPLB: string;
begin
  stg_cltj.ColWidths[c_KCSL] := 0;
  stg_cltj.ColWidths[c_SJSYJE] := 0;
  stg_cltj.ColWidths[c_JHSYJE] := 0;
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

procedure TFra_CLTJ.btn_cxClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sCxq,sCxz: string;
  iCplb: integer;
begin
  sCxq := FormatDateTime('yyyyMMdd',dtp_cxq.DateTime)+' 00:00:00';
  sCxz := FormatDateTime('yyyyMMdd',dtp_cxz.DateTime)+' 23:59:59';
  iCplb := FindProductCategoryID(cbb_cplb.ItemIndex);
  //ADO_Rec := DM_DataBase.OpenQuery('Exec p_sctj ''%s'',''%s''',[sCxq,sCxz]);
  ADO_CLTJ.Close;
  ADO_CLTJ.SQL.Text := Format('Exec p_cltj ''%s'',''%s'',%d',[sCxq,sCxz,iCplb]);
  ADO_CLTJ.Open;
  ReadCLTJ(ADO_CLTJ);
//  ADO_Rec.Free;
end;

procedure TFra_CLTJ.ReadCLTJ(ADO_Rec: TADOQuery);
var
  i,n,j: Integer;
  dDate: TDateTime;
begin
  stg_cltj.Clear;
  stg_cltj.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
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
      stg_cltj.cells[c_CLBH,n] := FieldByName('CLBH').AsString ;
      stg_cltj.cells[c_CLMC,n] := FieldByName('CLMC').AsString ;
      //stg_cltj.cells[c_CLGG,n] := FieldByName('CLGG').AsString ;
      //stg_cltj.cells[c_CJGG,n] := FieldByName('CJGG').AsString ;
      stg_cltj.cells[c_SJJG,n] := FieldByName('SJJG').AsString ;
      stg_cltj.cells[c_JHJG,n] := FieldByName('JHJG').AsString ;
      stg_cltj.cells[c_JFQS,n] := FieldByName('JFQS').AsString ;
      stg_cltj.cells[c_JFS,n] := FieldByName('JFS').AsString ;
      stg_cltj.cells[c_ZZS,n] := FieldByName('ZZS').AsString ;
      stg_cltj.cells[c_YSYSL,n] := FieldByName('YSYSL').AsString ;
      //stg_cltj.cells[c_KCSL,n] := FieldByName('KCSL').AsString ;
      stg_cltj.cells[c_CLDW,n] := FieldByName('CLDW').AsString ;
      stg_cltj.cells[c_SJSYJE,n] := FieldByName('SJSYJE').AsString ;
      stg_cltj.cells[c_JHSYJE,n] := FieldByName('JHSYJE').AsString ;
      inc(n);
      Next;
    end;
  end;
  btn_cx.Caption := '查询';
end;

procedure TFra_CLTJ.btn_dyClick(Sender: TObject);
begin
  rmr_CLTJ.PrepareReport;
  rmr_CLTJ.ShowReport;

end;

end.
