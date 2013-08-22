unit uFra_WGYBB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DB, ADODB, RM_Dataset, RM_System, RM_Common, RM_Class,
  RM_GridReport, Grids, iGrid, StdCtrls, RzCmboBx, iComboBox, RzButton,
  ComCtrls, RzDTP, ExtCtrls, RzPanel, GridRow;

type
  TFra_WGYBB = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    dtp_cxq: TRzDateTimePicker;
    dtp_cxz: TRzDateTimePicker;
    btn_cx: TRzButton;
    btn_dy: TButton;
    cbb_cplb: Ti_ComboBox;
    RzGroupBox2: TRzGroupBox;
    stg_wgybb: Ti_StgEdit;
    rmr_WGYBB: TRMGridReport;
    rmdb_WGYBB: TRMDBDataSet;
    ADO_WGYBB: TADOQuery;
    btn_export: TRzButton;
    cbb_bb: Ti_ComboBox;
    cbb_xpl: Ti_ComboBox;
    procedure btn_cxClick(Sender: TObject);
    procedure stg_wgybbLinkClick(Sender: TObject; ACol, ARow: Integer);
    procedure btn_dyClick(Sender: TObject);
    procedure btn_exportClick(Sender: TObject);
  private
    { Private declarations }
    procedure ReadWGYBB(ADO_Rec: TADOQuery);
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

uses
  uPub_Func, uPub_Text, uPub_Type, PubStr, uWorkOrder,uDM_DataBase;

{$R *.dfm}

const
  c_GDH      = 0;
  c_PM       = 1;
  c_XPL      = 2;
  c_KDRQ     = 3;
  c_JCRQ     = 4;
  c_YZDJ     = 5;
  c_TSGYFDJ  = 6;
  c_SL       = 7;
  c_YZJE     = 8;
  c_CLFY     = 9;
  c_GroupID  = 10;
  c_WorkID   = 11;

procedure TFra_WGYBB.btn_cxClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sCxq,sCxz: string;
  iCplb,iXPL,iOrderType: integer;
begin
  Screen.Cursor := crHourGlass;
  sCxq := FormatDateTime('yyyyMMdd',dtp_cxq.DateTime)+' 00:00:00';
  sCxz := FormatDateTime('yyyyMMdd',dtp_cxz.DateTime)+' 23:59:59';
  iCplb := FindProductCategoryID(cbb_cplb.ItemIndex);
  //ADO_Rec := DM_DataBase.OpenQuery('Exec p_sctj ''%s'',''%s''',[sCxq,sCxz]);
  case cbb_xpl.ItemIndex of
    0: iXpl := -1;
    1: iXpl := 0;
    2: iXpl := 1;
  else
    iXpl := -1;
  end;
  case cbb_bb.ItemIndex of
    0: iOrderType := -1;
    1: iOrderType := 0;
    2: iOrderType := 1;
  else
    iOrderType := -1;
  end;
  try
    ADO_WGYBB.Close;
    ADO_WGYBB.SQL.Text := Format('Exec p_wgybb ''%s'',''%s'',%d,%d,%d',[sCxq,sCxz,iCplb,iOrderType,iXpl]);
    ADO_WGYBB.Open;
    ReadWGYBB(ADO_WGYBB);
  except
    on E: Exception do
    begin
      p_MessageBoxDlg('����'+E.message);
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TFra_WGYBB.FraShow;
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
  cbb_cplb.Items.Add('--ȫ��--');
  CbbAdd(cbb_cplb,pkProductCategory);
  if sCPLB <> '' then
    cbb_cplb.ItemIndex := cbb_cplb.Items.IndexOf(sCPLB)
  else
    cbb_cplb.ItemIndex := c_Default_CPLB;

  stg_wgybb.ColWidths[c_GroupID] := 0;
  stg_wgybb.ColWidths[c_WorkID] := 0;

end;

procedure TFra_WGYBB.ReadWGYBB(ADO_Rec: TADOQuery);
var
  i,n,j: Integer;
  sGDGS,sYZJEZS,sXPL, sBHNJMS, sHNJMS: string;
  dDate: TDateTime;
begin
  stg_wgybb.Clear;
  stg_wgybb.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
  i := 0;
  btn_cx.Caption := '��ѯ��';
  with ADO_Rec do
  begin
    First;
    sGDGS   := FieldByName('GDGS').AsString;
    sYZJEZS := FieldByName('YZJEZS').AsString;
    sBHNJMS := FieldByName('BHNJMS').AsString;
    sHNJMS := FieldByName('HNJMS').AsString;
    n := 1;
    while not Eof do
    begin
      //inc(i);
      //if i mod 100 = 0 then
      //  btn_cx.Caption := '��ѯ��'+StrLeft(StrRep('.',(i div 100) Mod 4)+'   ',3);
      stg_wgybb.cells[c_GDH,n]     := FieldByName('GDH').AsString ;
      stg_wgybb.CellsLink[c_GDH,n] := FieldByName('GDH').AsString;

      stg_wgybb.cells[c_PM,n]      := FieldByName('PM').AsString ;
      case FieldByName('F_tiXPL').AsInteger of
        0:sXPL := '��';
        1:sXPL := 'С����';
      end;
      stg_wgybb.cells[c_XPL,n]     := sXPL;
      stg_wgybb.cells[c_KDRQ,n]    := FormatDateTime('yyyy-MM-dd hh:mm:ss',FieldByName('KDRQ').AsDateTime) ;
      stg_wgybb.cells[c_JCRQ,n]    := FormatDateTime('yyyy-MM-dd hh:mm:ss',FieldByName('JCRQ').AsDateTime) ;
      stg_wgybb.cells[c_YZDJ,n]    := FieldByName('YZDJ').AsString ;
      stg_wgybb.cells[c_TSGYFDJ,n] := FieldByName('TSGYFDJ').AsString ;
      stg_wgybb.cells[c_SL,n]      := FieldByName('SL').AsString ;
      stg_wgybb.cells[c_YZJE,n]    := FieldByName('YZJE').AsString ;
      stg_wgybb.cells[c_CLFY,n]    := FieldByName('CLFY').AsString ;
      stg_wgybb.cells[c_GroupID,n]    := FieldByName('GroupID').AsString ;
      stg_wgybb.cells[c_WorkID,n]    := FieldByName('WorkID').AsString ;
      inc(n);
      Next;                                                                            
    end;                                                                               
  end;                                                                                 
  stg_wgybb.RowCount := stg_wgybb.RowCount + 3;
  stg_wgybb.cells[c_GDH,n]     := '�ϼ�:' ;
  inc(n);
  stg_wgybb.cells[c_PM,n]     := '��������:' ;
  stg_wgybb.cells[c_KDRQ,n]   := iif(sGDGS<>'',sGDGS,'0');
  stg_wgybb.cells[c_JCRQ,n]   := 'ӡ�ƽ������:' ;
  stg_wgybb.cells[c_YZDJ,n]   := iif(sYZJEZS<>'',sYZJEZS,'0');
  inc(n);
  stg_wgybb.cells[c_PM,n]     := '�����ڼ�ö��:' ;
  stg_wgybb.cells[c_KDRQ,n]   := iif(sBHNJMS<>'',sBHNJMS,'0');
  stg_wgybb.cells[c_JCRQ,n]   := '���ڼ�ö��:' ;
  stg_wgybb.cells[c_YZDJ,n]   := iif(sHNJMS<>'',sHNJMS,'0');

  btn_cx.Caption := '��ѯ';
end;                                                                                   
                                                                                       
procedure TFra_WGYBB.stg_wgybbLinkClick(Sender: TObject; ACol,
  ARow: Integer);
var
  ADO_Rec: TADOQuery;
  i, n, iOrderType: Integer;
  sHint, sID, sCXBZ, sSczt: string;
  comp: TComponent;
  iWorkID, iGroupID, iBsts, iSYYL, iApartID: Integer;
  sKHMC,sCPBH,SBZ,sDW,sSL,sZH,sRJHDQ,sRJHDZ: string;
  sSqlData: string;
begin
  if ACol = c_GDH then
  begin
    Screen.Cursor := crHourGlass;
    Frm_WorkOrder := TFrm_WorkOrder.Create(self);
    iGroupID := StrToNum(stg_wgybb.Cells[c_GroupID,ARow]);
    iWorkID := StrToNum(stg_wgybb.Cells[c_WorkID,ARow]);
    Frm_WorkOrder.vWorkID := iWorkID;
    Frm_WorkOrder.vGroupID := iGroupID;
    Frm_WorkOrder.vbCXBZ := False;
    if Frm_WorkOrder.p_LoadWorkOrderData then
    begin
      Frm_WorkOrder.btn_zd.Enabled := False;
      Frm_WorkOrder.btn_xg.Enabled := True;
      Frm_WorkOrder.btn_dy.Enabled := True;
      Frm_WorkOrder.btn_cx.Enabled := True;
      Frm_WorkOrder.vActionType :=  c_WorkOrder_Select ;
      Screen.Cursor := crDefault;
      Frm_WorkOrder.ShowModal;
    end;
    Frm_WorkOrder.Free;
  end;
end;

procedure TFra_WGYBB.btn_dyClick(Sender: TObject);
begin
  rmr_WGYBB.PrepareReport;
  rmr_WGYBB.ShowReport;
end;

procedure TFra_WGYBB.btn_exportClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    DM_DataBase.gr_dc.p_SaveToExcel(stg_wgybb,['������','Ʒ��','С����','��������',
      '��������','ӡ�Ƶ���','���⹤�շѵ���','����(ö)',
      'ӡ�ƽ��','���Ϸ���'],[c_GDH,c_PM,c_XPL,c_KDRQ,c_JCRQ,c_YZDJ,
      c_TSGYFDJ,c_SL,c_YZJE,c_CLFY],[0,0,0,0,0,0,0,0,
      0,0],False);
    p_MessageBoxDlg('�����ɹ�!');
  except
    p_MessageBoxDlg('����ʧ��!');
  end;
  Screen.Cursor := crDefault;
end;

end.
