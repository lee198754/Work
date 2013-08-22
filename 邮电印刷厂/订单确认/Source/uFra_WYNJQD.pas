unit uFra_WYNJQD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, RM_Dataset, RM_System, RM_Common, RM_Class,
  RM_GridReport, Grids, iGrid, StdCtrls, RzButton, ComCtrls, RzDTP,
  ExtCtrls, RzPanel;

type
  TFra_WYNJQD = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    dtp_cxq: TRzDateTimePicker;
    dtp_cxz: TRzDateTimePicker;
    btn_cx: TRzButton;
    btn_dy: TButton;
    RzGroupBox2: TRzGroupBox;
    stg_wynjqd: Ti_StgEdit;
    rmr_WYNJQD: TRMGridReport;
    rmdb_WYNJQD: TRMDBDataSet;
    ADO_WYNJQD: TADOQuery;
    btn_export: TRzButton;
    procedure btn_cxClick(Sender: TObject);
    procedure btn_dyClick(Sender: TObject);
    procedure btn_exportClick(Sender: TObject);
  private
    { Private declarations }
    procedure ReadWYNJQD(ADO_Rec: TADOQuery);
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

uses
  PubStr, uDM_DataBase, uPub_Func;

{$R *.dfm}

const
  c_CXRQ      = 0;
  c_JGMC      = 1;
  c_CPBH      = 2;
  c_CPLX      = 3;
  c_KHMC      = 4;
  c_YL        = 5;
  c_YZDJ      = 6;
  c_TSGYFDJ   = 7;

{ TFraWYNJQD }

procedure TFra_WYNJQD.FraShow;
var
  sCPLB: string;
begin
  if FormatDateTime('hh:mm:ss',dtp_cxq.Time) = '00:00:00' then
  begin
    dtp_cxq.DateTime := Now;
    dtp_cxz.DateTime := Now;
  end;
  stg_wynjqd.p_SetColSortType(0,c_SetColSortType_Str );
  stg_wynjqd.p_SetColSortType(1,c_SetColSortType_Str );
  stg_wynjqd.p_SetColSortType(2,c_SetColSortType_Str );
  stg_wynjqd.p_SetColSortType(3,c_SetColSortType_Str );
  stg_wynjqd.p_SetColSortType(4,c_SetColSortType_Str );
  stg_wynjqd.p_SetColSortType(5,c_SetColSortType_Num );
  stg_wynjqd.p_SetColSortType(6,c_SetColSortType_Num );
  stg_wynjqd.p_SetColSortType(7,c_SetColSortType_Num );
end;

procedure TFra_WYNJQD.btn_cxClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sCxq,sCxz: string;
begin
  sCxq := FormatDateTime('yyyyMMdd',dtp_cxq.DateTime)+' 00:00:00';
  sCxz := FormatDateTime('yyyyMMdd',dtp_cxz.DateTime)+' 23:59:59';
  ADO_WYNJQD.Close;
  ADO_WYNJQD.SQL.Text := Format('exec p_wynjqd  ''%s'',''%s'' ',[sCxq,sCxz]);
  ADO_WYNJQD.Open;
  ReadWYNJQD(ADO_WYNJQD);
end;

procedure TFra_WYNJQD.ReadWYNJQD(ADO_Rec: TADOQuery);
var
  i,n,j: Integer;
  dDate: TDateTime;
begin
  stg_wynjqd.Clear;
  stg_wynjqd.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
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
      begin
        btn_cx.Caption := '查询中'+StrLeft(StrRep('.',(i div 100) Mod 4)+'   ',3);
        Application.ProcessMessages;
      end;
      stg_wynjqd.cells[c_CXRQ,n] := FieldByName('CXRQ').AsString ;
      stg_wynjqd.cells[c_JGMC,n] := FieldByName('JGMC').AsString ;
      stg_wynjqd.cells[c_CPBH,n] := FieldByName('CPBH').AsString ;
      stg_wynjqd.cells[c_CPLX,n] := FieldByName('CPLX').AsString ;
      stg_wynjqd.cells[c_KHMC,n] := FieldByName('KHMC').AsString ;
      stg_wynjqd.cells[c_YL,n] := FieldByName('YL').AsString ;
      stg_wynjqd.cells[c_YZDJ,n] := FieldByName('YZDJ').AsString ;
      stg_wynjqd.cells[c_TSGYFDJ,n] := FieldByName('TSGYFDJ').AsString ;
      inc(n);
      Next;
    end;
  end;
  btn_cx.Caption := '查询';
end;

procedure TFra_WYNJQD.btn_dyClick(Sender: TObject);
begin
  rmr_WYNJQD.PrepareReport;
  rmr_WYNJQD.ShowReport;

end;

procedure TFra_WYNJQD.btn_exportClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    DM_DataBase.gr_dc.p_SaveToExcel(stg_wynjqd,['撤销日期','机构名称','产品编号','产品类型',
      '客户名称','印量(枚)','印制单价','特殊工艺费单价'],[c_CXRQ,c_JGMC,c_CPBH,c_CPLX,
      c_KHMC,c_YL,c_YZDJ,c_TSGYFDJ],[0,0,0,0,0,1,1,1],False);
     p_MessageBoxDlg('导出成功!');
  except
    p_MessageBoxDlg('导出失败!');
  end;
  Screen.Cursor := crDefault;
end;

end.


