unit uYCXDDQDFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, iGrid, StdCtrls, ComCtrls, DB, ADODB, GridRow,
  RM_Dataset, RM_System, RM_Common, RM_Class, RM_GridReport, Menus,
  ActnList,uBaseForm;

type
  TFrm_YCXDDQD = class(TFrmFrame)
    gb_check: TGroupBox;
    Label1: TLabel;
    dtb_Begin: TDateTimePicker;
    Label2: TLabel;
    dtb_End: TDateTimePicker;
    btn_CHAXUN: TButton;
    btn_DAYIN: TButton;
    btn_DAOCHU: TButton;
    gb_cxxx: TGroupBox;
    Stg_CHAXUN: Ti_StgEdit;
    GridRow_X1: TGridRow_X;
    rmg_Report: TRMGridReport;
    rmd_DateSet: TRMDBDataSet;
    pmi_HFDD: TMenuItem;
    pm_HFDD: TPopupMenu;
    ActionList1: TActionList;
    pmi_ddmx: TMenuItem;
    pmi_ddmxPic: TMenuItem;
    N4: TMenuItem;
    procedure btn_CHAXUNClick(Sender: TObject);
    procedure btn_DAOCHUClick(Sender: TObject);
    procedure btn_DAYINClick(Sender: TObject);
    procedure pmi_HFDDClick(Sender: TObject);
    procedure Stg_CHAXUNClick(Sender: TObject);
    procedure pmi_ddmxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FraShow;
    constructor Create(AOwner: TComponent); overload;
    //constructor Create(AOwner: TComponent;AParentWindow:THandle=0);
  end;

var
  Frm_YCXDDQD: TFrm_YCXDDQD;
implementation

uses
  uOrderRecoveryFrm,uDM_DataBase,DateUtils,PubStr,uDDMX_DZX,uDDMX_XSX;

{$R *.dfm}

const
  c_ddcxyy: integer=0;
  c_cxbz:integer=1;
  c_cxrmz:integer=2;
  c_cxrq:integer=3;
  c_ddbh:integer=4;
  c_ddxdsj:integer=5;
  c_yztmc:integer=6;
  c_ddid:integer=7;
  c_ddlx:integer=8;
  c_oprator:integer=9;

procedure TFrm_YCXDDQD.btn_CHAXUNClick(Sender: TObject);
var
  i:Integer;
  qrq,zrq, sSqlData:string;
  ADO_Rec: TADOQuery;
begin
  qrq:=format('%s %s',[datetostr(dtb_begin.Date),'00:00:00']);
  zrq:=format('%s %s',[Datetostr(dtb_end.date),'23:59:59']);
  sSqlData := format('exec  p_ycxddqd ''%s'',''%s''',[qrq,zrq]);
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    i:=1;
    Stg_CHAXUN.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
    while  not ADO_Rec.Eof do
    begin
      Stg_CHAXUN.Cells[c_ddcxyy,i]:=ADO_Rec.fieldbyname('CXYY').AsString;
      Stg_CHAXUN.Cells[c_cxbz,i]:=ADO_Rec.fieldbyname('CXBZ').asstring;
      Stg_CHAXUN.cells[c_cxrmz,i]:=ADO_Rec.fieldbyname('CXR').AsString;
      Stg_CHAXUN.Cells[c_cxrq,i]:=ADO_Rec.FIELDBYNAME('CXRQ').AsString;
      Stg_CHAXUN.Cells[c_ddbh,i]:=ADO_Rec.fieldbyname('CPBH').asstring;
      Stg_CHAXUN.Cells[c_ddxdsj,i]:=ADO_Rec.fieldbyname('JSRQ').AsString;
      Stg_CHAXUN.Cells[c_yztmc,i]:=ADO_Rec.fieldbyname('Yztmc').AsString;
      Stg_CHAXUN.cells[c_ddid,i]:=ADO_Rec.fieldbyname('OrderID').AsString;
      Stg_CHAXUN.Cells[c_ddlx,i]:=ADO_Rec.fieldbyname('OrderType').AsString;
      Stg_CHAXUN.Cells[c_oprator,i]:=ADO_Rec.fieldbyname('CZRBM').AsString;
      i:=i+1;
      ADO_Rec.Next;
    end;
    gb_cxxx.Caption:=format('%s   总条数 %d行',[gb_cxxx.caption,ADO_Rec.RecordCount]);
    ADO_Rec.Free;
  end;
end;

procedure TFrm_YCXDDQD.btn_DAOCHUClick(Sender: TObject);
begin
   GridRow_X1.p_SaveToExcel(Stg_CHAXUN,['订单撤销原因','撤销备注','撤销人真实姓名','撤销日期','订单编号','订单下达时间','ss邮资图名称','订单ID','订单类型'],[0,1,2,3,4,5,6,7,8],[0,0,0,0,0,0,0,1,1],true);
end;

procedure TFrm_YCXDDQD.btn_DAYINClick(Sender: TObject);
begin
      rmg_Report.PrepareReport;//编译
      rmg_Report.ShowReport;//显示打印
end;

procedure TFrm_YCXDDQD.pmi_HFDDClick(Sender: TObject);
var
  liRow: Integer;
begin
    liRow:=Stg_CHAXUN.Row;
    Frm_OrderRecovery :=  TFrm_OrderRecovery.Create(Self);
    Frm_OrderRecovery.edt_cxr.Text:= Stg_CHAXUN.Cells[c_cxrmz,liRow];
    Frm_OrderRecovery.edt_cxyy.Text:= Stg_CHAXUN.Cells[c_ddcxyy,liRow];
    Frm_OrderRecovery.edt_cxbz.Text:= Stg_CHAXUN.Cells[c_cxbz,liRow];
    Frm_OrderRecovery.edt_cxrq.Text:= Stg_CHAXUN.Cells[c_cxrq,liRow];
    Frm_OrderRecovery.edt_cpbh.Text:= Stg_CHAXUN.Cells[c_ddbh,liRow];
    Frm_OrderRecovery.edt_czrbm.Text:= Stg_CHAXUN.Cells[c_oprator,liRow];
    Frm_OrderRecovery.edt_ddid.Text:= Stg_CHAXUN.Cells[c_ddid,liRow];
    Frm_OrderRecovery.FOrderType:=StrToInt(Stg_CHAXUN.Cells[c_ddlx,liRow]);
    Frm_OrderRecovery.ShowModal;
    Frm_OrderRecovery.Free;
end;

procedure TFrm_YCXDDQD.Stg_CHAXUNClick(Sender: TObject);
var
  liRow: Integer;
begin
  liRow:=Stg_CHAXUN.Row;
  if Stg_CHAXUN.Cells[c_cxrmz,liRow]<>'' then
  begin
    Stg_CHAXUN.PopupMenu:=pm_HFDD;
    pmi_HFDD.Enabled:=true;
  end
  else
    pmi_HFDD.Enabled:=false;
end;

procedure TFrm_YCXDDQD.FraShow;
begin

end;

constructor TFrm_YCXDDQD.Create(AOwner: TComponent);
begin
  inherited;
  dtb_Begin.DateTime := Now;
  dtb_End.DateTime := Now;
  Stg_CHAXUN.p_SetColSortType(c_ddcxyy,c_setcolsorttype_str);
  Stg_CHAXUN.p_SetColSortType(c_cxbz,c_setcolsorttype_str);
  Stg_CHAXUN.p_SetColSortType(c_cxrmz,c_setcolsorttype_str);
  Stg_CHAXUN.p_SetColSortType(c_cxrq,c_SetColSortType_str);
  Stg_CHAXUN.p_setcolsortType(c_ddbh,c_setcolsortType_str);
  Stg_CHAXUN.p_setcolsortType(c_ddxdsj,c_setcolsortType_str);
  Stg_CHAXUN.p_setcolsortType(c_yztmc,c_setcolsortType_str);

  Stg_CHAXUN.ColWidths[c_ddid]:=0;
  Stg_CHAXUN.colwidths[c_ddlx]:=0;
  Stg_CHAXUN.ColWidths[c_oprator]:=0;

end;

//constructor TFrm_YCXDDQD.Create(AOwner: TComponent;
//  AParentWindow: THandle);
//begin
//  inherited ;
//  dtb_Begin.DateTime := Now;
//  dtb_End.DateTime := Now;
//  Stg_CHAXUN.p_SetColSortType(c_ddcxyy,c_setcolsorttype_str);
//  Stg_CHAXUN.p_SetColSortType(c_cxbz,c_setcolsorttype_str);
//  Stg_CHAXUN.p_SetColSortType(c_cxrmz,c_setcolsorttype_str);
//  Stg_CHAXUN.p_SetColSortType(c_cxrq,c_SetColSortType_str);
//  Stg_CHAXUN.p_setcolsortType(c_ddbh,c_setcolsortType_str);
//  Stg_CHAXUN.p_setcolsortType(c_ddxdsj,c_setcolsortType_str);
//  Stg_CHAXUN.p_setcolsortType(c_yztmc,c_setcolsortType_str);
//
//  Stg_CHAXUN.ColWidths[c_ddid]:=0;
//  Stg_CHAXUN.colwidths[c_ddlx]:=0;
//  Stg_CHAXUN.ColWidths[c_oprator]:=0;
//end;

procedure TFrm_YCXDDQD.pmi_ddmxClick(Sender: TObject);
var
  iType,iOrderID: integer;
begin
  iOrderID := StrToNum(Stg_CHAXUN.Cells[c_ddid,Stg_CHAXUN.Row]);
  iType := StrToNum(Stg_CHAXUN.Cells[c_ddlx,Stg_CHAXUN.Row]);

  case iType of
    0:
      begin
        if TMenuItem(Sender).Name = 'pmi_ddmxPic' then
        begin
          FrmDDMX_DZX(iOrderID,True).Show;
        end else
          FrmDDMX_DZX(iOrderID,False).Show;
      end;
    1:
      begin
        FrmDDMX_XSX(iOrderID).Show;
      end;
  end;
end;



end.



