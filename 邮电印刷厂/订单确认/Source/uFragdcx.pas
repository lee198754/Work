unit uFragdcx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RzCmboBx, iComboBox, ButtonEdit, ComCtrls, DB, 
  ExtCtrls, RzPanel, RzButton, uDM_DataBase,ADODB, Grids, iGrid,
  RzDTP, RzRadChk, RzEdit, GridRow;

type
  Tfra_gdcx = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    edt_hm: Ti_TxtFilter;
    edt_pm: Ti_TxtFilter;
    edt_gdh: Ti_TxtFilter;
    cbb_dylx: Ti_ComboBox;
    btn_cx_old: TRzBitBtn;
    RzPanel1: TRzPanel;
    RzGroupBox2: TRzGroupBox;
    stg_gdmx: Ti_StgEdit;
    Splitter2: TSplitter;
    Label3: TLabel;
    Label4: TLabel;
    dtp_kdq: TRzDateTimePicker;
    dtp_kdz: TRzDateTimePicker;
    dtp_jhq: TRzDateTimePicker;
    dtp_jhz: TRzDateTimePicker;
    cb_kdrq: TRzCheckBox;
    cb_jhrq: TRzCheckBox;
    cbb_cx: Ti_ComboBox;
    edt_Temp: TEdit;
    gb_gd: TRzGroupBox;
    stg_gd: Ti_StgEdit;
    pan_data: TPanel;
    lab_up: TLabel;
    lab_down: TLabel;
    lab_ts50: TLabel;
    lab_first: TLabel;
    lab_last: TLabel;
    Label2: TLabel;
    lab_zys: TLabel;
    lab_ts100: TLabel;
    lab_ts200: TLabel;
    lab_ts500: TLabel;
    Label6: TLabel;
    edt_ys: TEdit;
    btn_go: TButton;
    cbb_xpl: Ti_ComboBox;
    btn_cx: TRzBitBtn;
    RzPanel2: TRzPanel;
    stg_jtxx: Ti_StgEdit;
    btn_export: TRzButton;
    edt_cpbh: Ti_TxtFilter;
    lab_tsQB: TLabel;
    cb_History: TCheckBox;
    procedure btn_cx_oldClick(Sender: TObject);
    procedure stg_gdSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure cb_kdrqClick(Sender: TObject);
    procedure cb_jhrqClick(Sender: TObject);
    procedure btn_cxClick(Sender: TObject);
    procedure stg_gdLinkClick(Sender: TObject; ACol, ARow: Integer);
    procedure stg_jtxxSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btn_goClick(Sender: TObject);
    procedure lab_firstClick(Sender: TObject);
    procedure lab_upClick(Sender: TObject);
    procedure lab_downClick(Sender: TObject);
    procedure lab_lastClick(Sender: TObject);
    procedure lab_ts50Click(Sender: TObject);
    procedure btn_exportClick(Sender: TObject);
  private
    { Private declarations }
    vSqlData: string;
    vYS: Integer;
    vMYTS: Integer;
    procedure stg_gdLinkClick_old(Sender: TObject; ACol, ARow: Integer);
    procedure ReadDataGD(ADO_Data: TADOQuery);
    procedure ReadDataJTXX(ADO_Data: TADOQuery);
    procedure ReadDataGDMX(ADO_Data: TADOQuery);
    function p_LoadWorkOrderData: Boolean;    //读取工单数据到数组中(不用)
  public
    { Public declarations }
    vActionType: Integer;  //操作类型(0:查询;1:修改;2:开单)
    procedure FraShow;
  end;

implementation

uses
  uPrint, PubStr, uPub_Type, uPub_Func, DateUtils, uWorkOrder, uPub_Text;

{$R *.dfm}

const
  {stg_gd}
  c_jrjm    = 0;    //进入界面
  c_jdbz    = 1;
  c_gdh     = 2;
  c_hm      = 3;
  c_pm      = 4;
//  c_dylb   = 5;
//  c_zzs    = 6;
  c_JTBH    = 5;
  c_JTMC    = 6;
  c_kdrq    = 7;
  c_jhrq    = 8;
  c_sczt    = 9;
  c_jbrq    = 10;
  c_ywrq    = 11;
  c_zwrq    = 12;
  c_sjfhrq  = 13;
  c_czrq    = 14;
  c_cxbz    = 15;
  c_GroupID = 16;
  c_F_iID   = 17;

const
  {stg_jtxx}
  c_JTXX_JTBH = 0;
  c_JTXX_JTMC = 1;
  c_JTXX_SCZT = 2;
  c_JTXX_GroupID = 3;
  c_JTXX_WorkID = 4;

const
  {stg_gdmx}
  c_KHMC = 0;
  c_Code = 1;
  c_SL = 2;
//  c_DW = 3;
  c_Zh = 3;
  c_RJHDQ = 4;
  c_RJHDZ = 5;
  c_FHGL_BZ = 6;

procedure Tfra_gdcx.btn_cx_oldClick(Sender: TObject);
var
  sKdq,sKdz,sJhq,sJhz,sCxbz: string;
begin
  Screen.Cursor := crHourGlass;
  if cb_kdrq.Checked then
  begin
    sKdq := FormatDateTime('yyyy.MM.dd 00:00:00',dtp_kdq.DateTime);
    sKdz := FormatDateTime('yyyy.MM.dd 23:59:59',dtp_kdz.DateTime);
  end;
  if cb_jhrq.Checked then
  begin
    sJhq := FormatDateTime('yyyy.MM.dd 00:00:00',dtp_jhq.DateTime);
    sJhz := FormatDateTime('yyyy.MM.dd 23:59:59',dtp_jhz.DateTime);
  end;

  with DM_DataBase.ADO_DataRec do
  begin
    Close;
//    SQL.Text := 'select *,a.F_iID WorkID from BI_WorkOrder a,DO_ProductDate_Log b where a.F_iID=b.F_iWorkID ';
    SQL.Text := 'select a.F_sGdh,a.F_sHm,a.F_sPm,a.F_sDylb,a.F_iZzs,a.F_dkdrq,a.F_dJhrq,'
      +'b.F_dYZBRQ,b.F_dYYSRQ,b.F_dYZDRQ,b.F_dYFHRQ,a.F_iSczt,a.F_dCzrq,a.F_tiCXBZ,a.F_iID WorkID '
      +'from BI_WorkOrder a left join DO_ProductDate_Log b on a.F_iID=b.F_iWorkID  where 1=1';
    case cbb_cx.ItemIndex of
      0:sCxbz := '';
      1:sCxbz := '0';
      2:sCxbz := '1';
    end;
    if sCxbz <> '' then
      SQL.Add(' and F_tiCXBZ = '+sCxbz+' ');
    if Trim(edt_hm.Text) <> '' then
      SQL.Add(' and  CHARINDEX('''+edt_hm.Text+''',a.F_sHm)>0 ');
    if Trim(edt_pm.Text) <> '' then
      SQL.Add(' and  CHARINDEX('''+edt_pm.Text+''',a.F_sPm)>0 ');
    if Trim(edt_gdh.Text) <> '' then
      SQL.Add(' and  CHARINDEX('''+edt_gdh.Text+''',a.F_sGdh)>0 ');
    if cbb_dylx.ItemIndex >0 then
      SQL.Add(' and  CHARINDEX('''+cbb_dylx.Text+''',a.F_sDylb)>0 ');
    if cb_kdrq.Checked then
      SQL.Add(' and F_dKdrq >= '''+sKdq+''' and F_dKdrq<='''+sKdz+'''');
    if cb_jhrq.Checked then
      SQL.Add(' and F_dJhrq >= '''+sJhq+''' and F_dJhrq<='''+sJhz+'''');
    if  cbb_xpl.ItemIndex = 1 then
    begin
      SQL.Add(' and a.F_tiXpl=0 ');
//      SQL.Add(' and ( exists(Select top 1 1 from BI_WorkOrderDetails c where c.F_iWorkID=a.F_iID and c.F_tiOrderType = 1)  ');
//      SQL.Add(' or (exists(Select top 1 1 from BI_WorkOrderDetails c where c.F_iWorkID=a.F_iID and c.F_tiOrderType = 0) and exists(Select top 1 1 ');
//      SQL.Add('   from BI_WorkOrderDetails c,DO_OrderApart d,BI_CustomOrderDetails e ');
//      SQL.Add('   where c.F_iWorkID=a.F_iID and c.F_iApartID=d.F_iID and d.F_iOrderID=e.F_iID and IsNull(e.F_tiXpl,0)=0) ) ) ');
    end;
    if  cbb_xpl.ItemIndex = 2 then
    begin
    //  SQL.Add(' and ( (exists(Select 1 from BI_WorkOrderDetails c where c.F_iWorkID=a.F_iID and c.F_tiOrderType = 1) and  1=2 ) ');
      SQL.Add(' and a.F_tiXpl=1 ');
//      SQL.Add(' and (exists(Select top 1 1 from BI_WorkOrderDetails c where c.F_iWorkID=a.F_iID and c.F_tiOrderType = 0) and exists(Select top 1 1 ');
//      SQL.Add('   from BI_WorkOrderDetails c,DO_OrderApart d,BI_CustomOrderDetails e ');
//      SQL.Add('   where c.F_iWorkID=a.F_iID and c.F_iApartID=d.F_iID and d.F_iOrderID=e.F_iID and IsNull(e.F_tiXpl,0)=1) )  ');
    end;

    SQL.Add(' Order By F_dKdrq desc,F_sGdh desc');
    open;
  end;
  ReadDataGD(DM_DataBase.ADO_DataRec);
  stg_gdmx.Clear;
  Screen.Cursor := crDefault;
end;

procedure Tfra_gdcx.ReadDataGD(ADO_Data: TADOQuery);
var
  i,n,j: Integer;
  sSczt,sCxbz,sJDBZ: string;
  dDate: TDateTime;
begin
  stg_gd.Clear;
  stg_gd.RowCount := iif(ADO_Data.RecordCount > 0, ADO_Data.RecordCount +1, 2);
  i := 0;
  btn_cx.Caption := '查询中...';
  with ADO_Data do
  begin
    First;
    n := 0;
    if ADO_Data.RecordCount > 0 then
    begin
      n := FieldByName('Count').AsInteger;
    end;
    gb_gd.Caption := '工单  总数:'+IntToStr(n)+'条';
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);
    n := 1;
    while not Eof do
    begin
      inc(i);
      if i mod 100 = 0 then
        btn_cx.Caption := '查询中'+StrLeft(StrRep('.',(i div 100) Mod 4)+'   ',3);
      case FieldByName('F_tiJDBZ').AsInteger of
        1: sJDBZ := '急单';
      else
        sJDBZ := '';
      end;
      stg_gd.cells[c_jdbz,n] := sJDBZ ;
      stg_gd.cells[c_gdh,n] := FieldByName('F_sGdh').AsString ;
      stg_gd.cells[c_hm,n] := FieldByName('F_sHm').AsString;
      stg_gd.cells[c_pm,n] := FieldByName('F_sPm').AsString;
      stg_gd.cells[c_JTBH,n] := FieldByName('F_sJTBH').AsString;
      stg_gd.cells[c_JTMC,n] := FieldByName('F_sJTMC').AsString;
      //stg_gd.cells[c_dylb,n] := FieldByName('F_sDylb').AsString;
      //stg_gd.ColWidths[c_dylb] := 0;
      //stg_gd.cells[c_zzs,n] := FieldByName('F_iZzs').AsString ;
      //stg_gd.ColWidths[c_zzs] := 0;
      dDate := FieldByName('F_dkdrq').AsDateTime;
      if YearOf(dDate)>2000 then
        stg_gd.cells[c_kdrq,n] := FormatDateTime('yyyy-MM-dd hh:MM:ss',dDate)
      else
        stg_gd.cells[c_kdrq,n] := '';
      dDate := FieldByName('F_dJhrq').AsDateTime;
      if YearOf(dDate)>2000 then
        stg_gd.cells[c_jhrq,n] := FormatDateTime('yyyy-MM-dd',dDate)
      else
        stg_gd.cells[c_jhrq,n] := '';
      dDate := FieldByName('F_dYZBRQ').AsDateTime;
      if YearOf(dDate)>2000 then
        stg_gd.cells[c_jbrq,n] := FormatDateTime('yyyy-MM-dd hh:MM:ss',dDate)
      else
        stg_gd.cells[c_jbrq,n] := '';
      dDate := FieldByName('F_dYYSRQ').AsDateTime;
      if YearOf(dDate)>2000 then
        stg_gd.cells[c_ywrq,n] := FormatDateTime('yyyy-MM-dd hh:MM:ss',dDate)
      else
        stg_gd.cells[c_ywrq,n] := '';
      dDate := FieldByName('F_dYZDRQ').AsDateTime;
      if YearOf(dDate)>2000 then
        stg_gd.cells[c_zwrq,n] := FormatDateTime('yyyy-MM-dd hh:MM:ss',dDate)
      else
        stg_gd.cells[c_zwrq,n] := '';
      dDate := FieldByName('F_dYFHRQ').AsDateTime;
      if YearOf(dDate)>2000 then
        stg_gd.cells[c_sjfhrq,n] := FormatDateTime('yyyy-MM-dd hh:MM:ss',dDate)
      else
        stg_gd.cells[c_sjfhrq,n] := '';
      case FieldByName('F_iSczt').AsInteger of
        0: sSczt:='制版';
        1: sSczt:='印刷';
        2: sSczt:='打号';
        3: sSczt:='后道加工';
        4: sSczt:='进仓';
        5,6: sSczt:='已进仓';
//        5: sSczt:='发货';
//        6: sSczt:='已发货';
      end;
      stg_gd.Cells[c_sczt,n] := sSczt;
      //stg_gd.ColWidths[c_sczt] := 0;
      dDate := FieldByName('F_dCzrq').AsDateTime;
      if YearOf(dDate)>2000 then
        stg_gd.Cells[c_czrq,n] := FormatDateTime('yyyy-MM-dd hh:MM:ss',dDate)
      else
        stg_gd.cells[c_czrq,n] := '';
      case FieldByName('F_tiCXBZ').AsInteger of
        0: sCxbz := '未撤消';
      else
        sCxbz := '已撤消';
      end;
      stg_gd.Cells[c_cxbz,n] := sCxbz;
      stg_gd.Cells[c_jrjm,n] := '进入';
      stg_gd.CellsLink[c_jrjm,n] := '进入';
      stg_gd.Cells[c_GroupID,n] := FieldByName('F_iGroupID').AsString;
      stg_gd.Cells[c_F_iID,n] := FieldByName('WorkID').AsString;
      inc(n);
      Next;
    end;
  end;

  btn_cx.Caption := '查询';
end;

procedure Tfra_gdcx.ReadDataGDMX(ADO_Data: TADOQuery);
var
  n: Integer;
  sDw: string;
begin
  stg_gdmx.Clear;
  stg_gdmx.RowCount := iif(ADO_Data.RecordCount > 0, ADO_Data.RecordCount +1, 2);
  n := 1;
  with ADO_Data do
  begin
    First;
    while not Eof do
    begin
      stg_gdmx.cells[c_KHMC,n] := FieldByName('F_sKhmc').AsString ;
      stg_gdmx.ColWidths[c_Code] := 150;
      stg_gdmx.cells[c_Code,n] := FieldByName('F_sCpbh').AsString;
      stg_gdmx.ColWidths[c_Code] := 200;
     { if FieldByName('F_sDw').AsString <> '' then
        case FieldByName('F_sDw').AsInteger of
          1: sDW := '万枚';
        else
          sDW := '枚';
        end;
      stg_gdmx.cells[c_Dw,n] := sDW; }
      stg_gdmx.cells[c_Sl,n] := FieldByName('F_sSl').AsString ;
      stg_gdmx.cells[c_Zh,n] := FieldByName('F_sZh').AsString ;
      stg_gdmx.cells[c_RJHDQ,n] := FieldByName('F_sRJHDQ').AsString ;
      stg_gdmx.cells[c_RJHDZ,n] := FieldByName('F_sRJHDZ').AsString ;
      stg_gdmx.cells[c_FHGL_BZ,n] := FieldByName('F_sBz').AsString;
      inc(n);
      Next;
    end;
  end;
end;

procedure Tfra_gdcx.stg_gdLinkClick_old(Sender: TObject; ACol, ARow: Integer);
var
  ADO_Rec: TADOQuery;
  i, n, iOrderType: Integer;
  sHint, sID, sCXBZ, sSczt: string;
  comp: TComponent;
  iBsts: Integer;
  khmc,cpbh,bz,dw,sl,zh,ApartID: string;
begin
  if ACol = c_jrjm then
  begin
    sID := stg_gd.Cells[c_F_iID,ARow];
    sCXBZ := stg_gd.Cells[c_cxbz,ARow];
    if sID = '' then Exit;
    try
      ADO_Rec := TADOQuery.Create(Self);
      DM_DataBase.GetTableData(ADO_Rec,'BI_WorkOrder','F_iID='+sID);
      if ADO_Rec.RecordCount > 0 then
      begin
        with Frm_Print,ADO_Rec do
        begin
          Frm_Print := TFrm_Print.Create(Self);
          for i := 0 to Frm_Print.ComponentCount -1 do
          begin
            comp := Frm_Print.Components[i];
            if (comp is Ti_TxtFilter) or (comp is Ti_ComboBox) or (comp is TComboBox) or (comp is TRzDateTimePicker) or (comp is TRzMemo) then
            begin
              sHint := TCustomControl(comp).Hint;
              if (Copy(sHint,1,2) = 'F_') then
              begin
                if comp is TRzDateTimePicker then
                  TRzDateTimePicker(comp).DateTime := FieldByName(sHint).AsDateTime
                else
                if (comp is Ti_ComboBox) or (comp is TComboBox) then
                  Ti_ComboBox(comp).Text := FieldByName(sHint).AsString
                else
                  TEdit(comp).Text := FieldByName(sHint).AsString;
              end;
            end;
          end;
          Frm_Print.vBSTID := FieldByName('F_iBSTID').AsInteger;
          case FieldByName('F_iSczt').AsInteger of
            0: sSczt:='制版';
            1: sSczt:='印刷';
            2: sSczt:='打号';
            3: sSczt:='后道加工';
            4: sSczt:='进仓';
            5,6: sSczt:='已进仓';
          end;
          Frm_Print.lab_jbrq.Visible := True;
          Frm_Print.lab_ywrq.Visible := True;
          Frm_Print.lab_zwrq.Visible := True;
          Frm_Print.lab_jbrq.Caption := stg_gd.cells[c_jbrq,ARow];
          Frm_Print.lab_ywrq.Caption := stg_gd.cells[c_ywrq,ARow];
          Frm_Print.lab_zwrq.Caption := stg_gd.cells[c_zwrq,ARow];
          Frm_Print.lab_sczt.Caption := '该工单目前生产进度： '+sSczt;
          DM_DataBase.GetTableData(ADO_Rec,'BI_WorkOrderDetails','F_iWorkID='+sID);
          n := 0;
          SetLength(OrderData,0);
          iBsts := StrToNum(edt_bsts.Text);
          First;
          while not Eof do
          begin
            khmc := FieldByName('F_sKhmc').AsString;
            cpbh := FieldByName('F_sCpbh').AsString;
            bz := FieldByName('F_sBz').AsString;
            dw := FieldByName('F_sDw').AsString;
            sl := FieldByName('F_sSl').AsString;
            zh := FieldByName('F_sZh').AsString;
            ApartID := FieldByName('F_iApartID').AsString;
            iOrderType := ADO_Rec.FieldByName('F_tiOrderType').AsInteger;
            SetLength(OrderData,Length(OrderData)+1);
            OrderData[Length(OrderData)-1].m_iXH := n;
            OrderData[Length(OrderData)-1].m_sCPBH := cpbh;
            OrderData[Length(OrderData)-1].m_sKhmc := khmc;
            OrderData[Length(OrderData)-1].m_iSyyl := StrToNum(sl);
            OrderData[Length(OrderData)-1].m_iApartID := StrToNum(ApartID);
            OrderData[Length(OrderData)-1].m_iType := iOrderType;
            OrderData[Length(OrderData)-1].m_sSl := sl;
            OrderData[Length(OrderData)-1].m_sDw := StrToNum(dw);
            if iBsts =0 then
              OrderData[Length(OrderData)-1].m_iBSTS := 0
            else
              OrderData[Length(OrderData)-1].m_iBSTS := StrToNum(sl)*10000 div iBsts;
            //CreateFrame(khmc, cpbh,bz,dw,sl,zh,ApartID,n);
            ADO_Rec.Next;
            inc(n);
          end;
          Frm_Print.vWorkID := StrToInt(sID);
          Frm_Print.lab_HBST.Caption := '打印版式图';
//          Frm_Print.EnableCom(False);
          btn_zd.Enabled := False;
          Frm_Print.btn_xg.Enabled := True;
          Frm_Print.btn_dy.Enabled := True;
          Frm_Print.btn_cx.Enabled := True;
          if sCXBZ = '已撤消' then
            Frm_Print.btn_cx.Caption := '恢复';
          cb_Cookie.Checked := False;
          Frm_Print.vActionType :=  Self.vActionType ;
          Frm_Print.ShowModal;
          Frm_Print.btn_cx.Caption := '撤消';
          setLength(lab, 0);
          setLength(edt, 0);
          setLength(cbb, 0);
          Frm_Print.Free;
        end;
        btn_cx.Click;
      end;
    finally
      ADO_Rec.Free;
    end;
  end;
end;

procedure Tfra_gdcx.stg_gdSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  iID, iGroupID: integer;
  ADO_Rec: TADOQuery;
  sSqlData: string;
begin
  stg_gdmx.Clear;
  iGroupID := StrToNum(stg_gd.Cells[c_GroupID,ARow]);
  iID := StrToNum(stg_gd.Cells[c_F_iID,ARow]);
  if iID > 0 then
  begin
    try
      //sSqlData := 'Select * from DO_WorkOrderPrtProc where F_iWorkID=%d ';
      sSqlData := 'Select * from DO_WorkOrderDetails where F_iWorkID=%d and F_iGroupID=%d';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iID,iGroupID],False);
      if (Assigned(ADO_Rec)) and (ADO_Rec.RecordCount > 0) then
        ReadDataGDMX(ADO_Rec);
    finally
      ADO_Rec.Free;
    end;
  end;

end;

procedure Tfra_gdcx.cb_kdrqClick(Sender: TObject);
begin
  dtp_kdq.Enabled := cb_kdrq.Checked;
  dtp_kdz.Enabled := cb_kdrq.Checked;

end;

procedure Tfra_gdcx.cb_jhrqClick(Sender: TObject);
begin
  dtp_jhq.Enabled := cb_jhrq.Checked;
  dtp_jhz.Enabled := cb_jhrq.Checked;

end;

procedure Tfra_gdcx.FraShow;
var
  i: integer;
begin
  if stg_gd.ColWidths[c_F_iID] <> 0 then
  begin
    dtp_kdq.DateTime := Now;
    dtp_kdz.DateTime := Now;
    dtp_jhq.DateTime := Now;
    dtp_jhz.DateTime := Now;
  end;
  stg_gd.p_SetColSortType(1,c_SetColSortType_Str );
  stg_gd.p_SetColSortType(2,c_SetColSortType_Str );
  stg_gd.p_SetColSortType(3,c_SetColSortType_Str );
  stg_gd.p_SetColSortType(4,c_SetColSortType_Str );
  stg_gd.p_SetColSortType(5,c_SetColSortType_Str );
  stg_gd.p_SetColSortType(6,c_SetColSortType_Str );
  stg_gd.p_SetColSortType(7,c_SetColSortType_Str );
  stg_gd.p_SetColSortType(8,c_SetColSortType_Str );
  stg_gd.p_SetColSortType(9,c_SetColSortType_Str );
  stg_gd.p_SetColSortType(10,c_SetColSortType_Str );
  stg_gd.p_SetColSortType(11,c_SetColSortType_Str );
  stg_gd.p_SetColSortType(12,c_SetColSortType_Str );
  stg_gd.p_SetColSortType(13,c_SetColSortType_Str );
  stg_gd.p_SetColSortType(14,c_SetColSortType_Str );
  
  stg_gd.ColWidths[c_hm] := 0;
  stg_gd.ColWidths[c_sjfhrq] := 0;
  stg_gd.ColWidths[c_czrq] := 0;
  stg_gd.ColWidths[c_GroupID] := 0;
  stg_gd.ColWidths[c_F_iID] := 0;

  for i := 0 to stg_gdmx.ColCount -1 do
    stg_gdmx.ColBuddy[i] := 'edt_Temp';

end;

procedure Tfra_gdcx.btn_cxClick(Sender: TObject);
var
  sKdq,sKdz,sJhq,sJhz,sCxbz: string;
  sGDH,sHM,sPM,sCPBH: string;
  iXPL,iCXBZ,iYS,iMYTS,iTS: Integer;
  sSqlData: string;
  ADO_Rec: TADOQuery;
begin
  Screen.Cursor := crHourGlass;
  sKdq := '';
  sKdz := '';
  if cb_kdrq.Checked then
  begin
    sKdq := FormatDateTime('yyyy.MM.dd 00:00:00',dtp_kdq.DateTime);
    sKdz := FormatDateTime('yyyy.MM.dd 23:59:59',dtp_kdz.DateTime);
  end;
  sJhq := '';
  sJhz := '';
  if cb_jhrq.Checked then
  begin
    sJhq := FormatDateTime('yyyy.MM.dd 00:00:00',dtp_jhq.DateTime);
    sJhz := FormatDateTime('yyyy.MM.dd 23:59:59',dtp_jhz.DateTime);
  end;
  sGDH := Trim(edt_gdh.Text);
  sCPBH := Trim(edt_cpbh.Text);
  sHM := Trim(edt_hm.Text);
  sPM := Trim(edt_pm.Text);
  case cbb_xpl.ItemIndex of
    0:iXPL := -1;
    1:iXPL := 0;
    2:iXPL := 1;
  end;
  case cbb_cx.ItemIndex of
    0:iCxbz := -1;
    1:iCxbz := 0;
    2:iCxbz := 1;
  end;
  iYS := 1;
  vYS := iYS;
  edt_ys.Text := IntToStr(iYs);
  if vMYTS = 0 then
  begin
    vMYTS := 50;
    lab_ts50.Font.Color :=  clBlack;
    lab_ts50.Font.Size := 10;
    lab_ts50.Font.Style := [fsBold];
    lab_ts50.Cursor := crDefault;
  end;
  iTS := vMYTS;

  try
    sSqlData := 'exec p_gdcx ''%s'',''%s'',''%s'',%d,''%s'',''%s'',''%s'',''%s'',%d,%d,%d,''%s'' ';
    if not cb_History.checked then
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sGDH,sHM,sPM,iXPL,sKdq,sKdz,sJhq,sJhz,iCxbz,iYS,iTs,sCPBH],True,False)
    else
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sGDH,sHM,sPM,iXPL,sKdq,sKdz,sJhq,sJhz,iCxbz,iYS,iTs,sCPBH],True,True);
    vSqlData := Format('exec p_gdcx ''%s'',''%s'',''%s'',%d,''%s'',''%s'',''%s'',''%s'',%d,%s,%s,''%s'' ',[sGDH,sHM,sPM,iXPL,sKdq,sKdz,sJhq,sJhz,iCxbz,'%d','%d',sCPBH]);
    if Assigned(ADO_Rec) then
    begin
      ReadDataGD(ADO_Rec);
      ADO_Rec.Free;
    end;
    stg_gdmx.Clear;
  except
    on E: Exception do
    begin
      p_MessageBoxDlg('错误：'+E.Message);
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure Tfra_gdcx.stg_gdLinkClick(Sender: TObject; ACol, ARow: Integer);
var
  ADO_Rec: TADOQuery;
  i, n, iOrderType: Integer;
  sHint, sID, sCXBZ, sSczt: string;
  comp: TComponent;
  iWorkID, iGroupID, iBsts, iSYYL, iApartID: Integer;
  sKHMC,sCPBH,SBZ,sDW,sSL,sZH,sRJHDQ,sRJHDZ: string;
  sSqlData: string;
begin
  if ACol = c_jrjm then
  begin
    Screen.Cursor := crHourGlass;
    Frm_WorkOrder := TFrm_WorkOrder.Create(self);
    iWorkID := StrToNum(stg_gd.Cells[c_F_iID,stg_gd.Row]);
    iGroupID := StrToNum(stg_gd.Cells[c_GroupID,stg_gd.Row]);
    sCXBZ := stg_gd.Cells[c_cxbz,stg_gd.Row];
    Frm_WorkOrder.vWorkID := iWorkID;
    Frm_WorkOrder.vGroupID := iGroupID;
    Frm_WorkOrder.vbCXBZ := iif(Trim(sCXBZ) = '已撤消',True,False);
    if Frm_WorkOrder.p_LoadWorkOrderData then
    begin
      Frm_WorkOrder.btn_zd.Enabled := False;
      Frm_WorkOrder.btn_xg.Enabled := True;
      Frm_WorkOrder.btn_dy.Enabled := True;
      Frm_WorkOrder.btn_cx.Enabled := True;
      Frm_WorkOrder.vActionType :=  Self.vActionType ;
      Screen.Cursor := crDefault;

      Frm_WorkOrder.ShowModal;
      //setLength(lab, 0);
      //setLength(edt, 0);
      //setLength(cbb, 0);
      if vActionType = c_WorkOrder_Modify then
        btn_cx.Click;
    end;
    Frm_WorkOrder.Free;

    Exit;

    sID := stg_gd.Cells[c_F_iID,ARow];
    sCXBZ := stg_gd.Cells[c_cxbz,ARow];
    if sID = '' then Exit;
    try
      sSqlData := 'Select * from DO_WorkOrder where F_iID=%s ';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sID]);
      if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
      begin
        with Frm_WorkOrder,ADO_Rec do
        begin
          Frm_Print := TFrm_Print.Create(Self);
          for i := 0 to Frm_Print.ComponentCount -1 do
          begin
            comp := Frm_Print.Components[i];
            if (comp is Ti_TxtFilter) or (comp is Ti_ComboBox) or (comp is TComboBox) or (comp is TRzDateTimePicker) or (comp is TRzMemo) then
            begin
              sHint := TCustomControl(comp).Hint;
              if (Copy(sHint,1,2) = 'F_') then
              begin
                if comp is TRzDateTimePicker then
                  TRzDateTimePicker(comp).DateTime := FieldByName(sHint).AsDateTime
                else
                if (comp is Ti_ComboBox) or (comp is TComboBox) then
                  Ti_ComboBox(comp).Text := FieldByName(sHint).AsString
                else
                  TEdit(comp).Text := FieldByName(sHint).AsString;
              end;
            end;
          end;
          //Frm_Print.vBSTID := FieldByName('F_iBSTID').AsInteger;
          case FieldByName('F_iSczt').AsInteger of
            0: sSczt:='制版';
            1: sSczt:='印刷';
            2: sSczt:='打号';
            3: sSczt:='后道加工';
            4: sSczt:='进仓';
            5,6: sSczt:='已进仓';
          end;
          if Trim(stg_gd.cells[c_jbrq,ARow]) <> '' then
          begin
            Frm_WorkOrder.lab_jbrq.Visible := True;
            Frm_WorkOrder.lab_jbrq.Caption := '交版日期：'+stg_gd.cells[c_jbrq,ARow];
            Frm_WorkOrder.lab_jbrq.Left := Frm_WorkOrder.lab_sczt.Left+ Frm_WorkOrder.lab_sczt.Width + 10;
          end;
          if Trim(stg_gd.cells[c_jbrq,ARow]) <> '' then
          begin
            Frm_WorkOrder.lab_ywrq.Visible := True;
            Frm_WorkOrder.lab_ywrq.Caption := '印完日期：'+stg_gd.cells[c_ywrq,ARow];
            Frm_WorkOrder.lab_jbrq.Left := Frm_WorkOrder.lab_jbrq.Left+ Frm_WorkOrder.lab_jbrq.Width + 10;
          end;
          if Trim(stg_gd.cells[c_jbrq,ARow]) <> '' then
          begin
            Frm_WorkOrder.lab_zwrq.Visible := True;
            Frm_WorkOrder.lab_zwrq.Caption := '装订日期：'+stg_gd.cells[c_zwrq,ARow];
            Frm_WorkOrder.lab_jbrq.Left := Frm_WorkOrder.lab_ywrq.Left+ Frm_WorkOrder.lab_ywrq.Width + 10;
          end;
          Frm_WorkOrder.gb_zt.Show;
          Frm_WorkOrder.lab_sczt.Caption := '该工单目前生产进度： '+sSczt;
          //DM_DataBase.GetTableData(ADO_Rec,'DO_WorkOrderDetails','F_iWorkID='+sID);
          ADO_Rec.Free;
          sSqlData := 'select *,SYYL=dbo.f_GetSYYL(F_iApartID) from DO_WorkOrderDetails where F_iWorkID=%s order by F_iGroupID,F_iID';
          ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sID],True);
          n := 0;
          SetLength(OrderData,0);
          //iBsts := StrToNum(edt_bsts.Text);
          First;
          while not Eof do
          begin
            sKHMC := FieldByName('F_sKhmc').AsString;
            sCPBH := FieldByName('F_sCpbh').AsString;
            SBZ := FieldByName('F_sBz').AsString;
            sDW := FieldByName('F_sDw').AsString;
            sSL := FieldByName('F_sSl').AsString;
            sZH := FieldByName('F_sZh').AsString;
            sRJHDQ := FieldByName('F_sRJHDQ').AsString;
            sRJHDZ := FieldByName('F_sRJHDZ').AsString;
            iSYYL := FieldByName('SYYL').AsInteger;
            iApartID := FieldByName('F_iApartID').AsInteger;
            iOrderType := FieldByName('F_tiOrderType').AsInteger;
            SetLength(OrderData,Length(OrderData)+1);
            OrderData[Length(OrderData)-1].m_iXH := n;
            OrderData[Length(OrderData)-1].m_sCPBH := sCPBH;
            OrderData[Length(OrderData)-1].m_sKhmc := sKHMC;
            OrderData[Length(OrderData)-1].m_sSl := StrToNum(sSL);
            OrderData[Length(OrderData)-1].m_iBCYL := StrToNum(sSL)*10000;
            OrderData[Length(OrderData)-1].m_iSyyl := StrToNum(sSL)*10000+iSYYL;
            OrderData[Length(OrderData)-1].m_iApartID := iApartID;
            OrderData[Length(OrderData)-1].m_iType := iOrderType;
            OrderData[Length(OrderData)-1].m_sDw := StrToNum(sDW);
            if iBsts =0 then
              OrderData[Length(OrderData)-1].m_iBSTS := 0
            else
              OrderData[Length(OrderData)-1].m_iBSTS := StrToNum(sSL)*10000 div iBsts;
            //CreateFrame(khmc, cpbh,bz,dw,sl,zh,ApartID,n);
            ADO_Rec.Next;
            inc(n);
          end;
          //Frm_Print.vWorkID := StrToInt(sID);
          //Frm_Print.lab_HBST.Caption := '打印版式图';
//          Frm_Print.EnableCom(False);
          btn_zd.Enabled := False;
          Frm_Print.btn_xg.Enabled := True;
          Frm_Print.btn_dy.Enabled := True;
          Frm_Print.btn_cx.Enabled := True;
          if sCXBZ = '已撤消' then
            Frm_Print.btn_cx.Caption := '恢复';
          //cb_Cookie.Checked := False;
          Frm_Print.vActionType :=  Self.vActionType ;
          Frm_Print.ShowModal;
          Frm_Print.btn_cx.Caption := '撤消';
          setLength(lab, 0);
          setLength(edt, 0);
          setLength(cbb, 0);
          Frm_Print.Free;
        end;
        btn_cx.Click;
      end;
    finally
      if Assigned(ADO_Rec) then
        ADO_Rec.Free;
    end;
  end;
end;

function Tfra_gdcx.p_LoadWorkOrderData: Boolean;
var
  ADO_Rec: TADOQuery;
  i, j, n, iOrderType, iID: Integer;
  sHint, sSczt, str: string;
  comp: TComponent;
  iBsts,iWorkID,iApartID, iGroupID: Integer;
  sKHMC,sCPBH,SBZ,sDW,sSL,sZH,sRJHDQ,sRJHDZ,sCXBZ: string;
  iSYYL, iMax: integer;
  sSqlData: string;
  sTypeName: string;
begin
  Result := False;
  iID := StrToNum(stg_gd.Cells[c_F_iID,stg_gd.Row]);
  iGroupID := StrToNum(stg_gd.Cells[c_GroupID,stg_gd.Row]);
  sCXBZ := stg_gd.Cells[c_cxbz,stg_gd.Row];
  if Trim(sCXBZ) = '已撤消' then
    Frm_WorkOrder.btn_cx.Caption := '恢复';
  if iID = 0 then Exit;
  try
    sSqlData := 'Select a.*,b.F_iSCZT SCZT,c.F_sTypeName from DO_WorkOrderPrtProc b,'
      + ' DO_WorkOrder a left join Set_ProductType c on a.F_iProductTypeID=c.F_iID '
      + ' where a.F_iID=%d and a.F_iID=b.F_iWorkID and b.F_iGroupID=%d ';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iID,iGroupID],True);
    if ADO_Rec = nil then Exit;
    if ADO_Rec.RecordCount > 0 then
    begin
      with ADO_Rec do
      begin
        for i := 0 to Frm_WorkOrder.ComponentCount -1 do
        begin
          comp := Frm_WorkOrder.Components[i];
          if (comp is Ti_TxtFilter) or (comp is Ti_ComboBox) or (comp is TComboBox) or (comp is TRzDateTimePicker) or (comp is TMemo) then
          begin
            sHint := TCustomControl(comp).Hint;
            if (Copy(sHint,1,2) = 'F_') then
            begin
              if comp is TRzDateTimePicker then
                TRzDateTimePicker(comp).DateTime := FieldByName(sHint).AsDateTime
              else
              if (comp is Ti_ComboBox) or (comp is TComboBox) then
                Ti_ComboBox(comp).Text := FieldByName(sHint).AsString
              else
                TEdit(comp).Text := FieldByName(sHint).AsString;
            end;
          end;
        end;
        //Frm_Print.vBSTID := FieldByName('F_iBSTID').AsInteger;
        sTypeName := FieldByName('F_sTypeName').AsString ;
        Frm_WorkOrder.Caption := '工单查询 -- '+stg_gd.cells[c_gdh,stg_gd.Row]+'('+ sTypeName + ')';
        case FieldByName('SCZT').AsInteger of
          0: sSczt:='制版';
          1: sSczt:='印刷';
          2: sSczt:='打号';
          3: sSczt:='后道加工';
          4: sSczt:='进仓';
          5,6: sSczt:='已进仓';
        end;
        Frm_WorkOrder.gb_zt.Show;
        Frm_WorkOrder.lab_sczt.Caption := '该工单目前生产进度： '+sSczt;
        if Trim(stg_gd.cells[c_jbrq,stg_gd.Row]) <> '' then
        begin
          Frm_WorkOrder.lab_jbrq.Visible := True;
          Frm_WorkOrder.lab_jbrq.Caption := '交版日期：'+stg_gd.cells[c_jbrq,stg_gd.Row];
          Frm_WorkOrder.lab_jbrq.Left := Frm_WorkOrder.lab_sczt.Left+ Frm_WorkOrder.lab_sczt.Width + 30;
        end;
        if Trim(stg_gd.cells[c_ywrq,stg_gd.Row]) <> '' then
        begin
          Frm_WorkOrder.lab_ywrq.Visible := True;
          Frm_WorkOrder.lab_ywrq.Caption := '印完日期：'+stg_gd.cells[c_ywrq,stg_gd.Row];
          Frm_WorkOrder.lab_ywrq.Left := Frm_WorkOrder.lab_jbrq.Left+ Frm_WorkOrder.lab_jbrq.Width + 30;
        end;
        if Trim(stg_gd.cells[c_zwrq,stg_gd.Row]) <> '' then
        begin
          Frm_WorkOrder.lab_zwrq.Visible := True;
          Frm_WorkOrder.lab_zwrq.Caption := '装订日期：'+stg_gd.cells[c_zwrq,stg_gd.Row];
          Frm_WorkOrder.lab_zwrq.Left := Frm_WorkOrder.lab_ywrq.Left+ Frm_WorkOrder.lab_ywrq.Width + 30;
        end;
        //DM_DataBase.GetTableData(ADO_Rec,'DO_WorkOrderDetails','F_iWorkID='+sID);
        ADO_Rec.Free;
      end;

      //读取订单信息到数组
      sSqlData := 'select *,SYYL=dbo.f_GetSYYL(F_iApartID) from DO_WorkOrderDetails where F_iWorkID=%d ';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iID],True);
      n := 0;
      SetLength(OrderData,0);
      //iBsts := StrToNum(edt_bsts.Text);
      with ADO_Rec do
      begin
        while not Eof do
        begin
          sKHMC := FieldByName('F_sKhmc').AsString;
          sCPBH := FieldByName('F_sCpbh').AsString;
          SBZ := FieldByName('F_sBz').AsString;
          sDW := FieldByName('F_sDw').AsString;
          sSL := FieldByName('F_sSl').AsString;
          sZH := FieldByName('F_sZh').AsString;
          sRJHDQ := FieldByName('F_sRJHDQ').AsString;
          sRJHDZ := FieldByName('F_sRJHDZ').AsString;
          iSYYL := FieldByName('SYYL').AsInteger;
          iApartID := FieldByName('F_iApartID').AsInteger;
          iGroupID := FieldByName('F_iGroupID').AsInteger;
          iOrderType := FieldByName('F_tiOrderType').AsInteger;
          SetLength(OrderData,Length(OrderData)+1);
          OrderData[Length(OrderData)-1].m_iXH := n;
          OrderData[Length(OrderData)-1].m_sCPBH := sCPBH;
          OrderData[Length(OrderData)-1].m_sKhmc := sKHMC;
          OrderData[Length(OrderData)-1].m_sSl := StrToNum(sSL);
          OrderData[Length(OrderData)-1].m_iBCYL := StrToNum(sSL)*10000;
          OrderData[Length(OrderData)-1].m_iSyyl := StrToNum(sSL)*10000+iSYYL;
          OrderData[Length(OrderData)-1].m_iApartID := iApartID;
          OrderData[Length(OrderData)-1].m_iType := iOrderType;
          OrderData[Length(OrderData)-1].m_sZH := sZH;
          OrderData[Length(OrderData)-1].m_sRJHDQ := sRJHDQ;
          OrderData[Length(OrderData)-1].m_sRJHDZ := sRJHDZ;
          OrderData[Length(OrderData)-1].m_sDw := StrToNum(sDW);
          OrderData[Length(OrderData)-1].m_sBZ := SBZ;
          OrderData[Length(OrderData)-1].m_iGroupID := iGroupID;
         { if iBsts =0 then
            OrderData[Length(OrderData)-1].m_iBSTS := 0
          else
            OrderData[Length(OrderData)-1].m_iBSTS := StrToNum(sl)*10000 div iBsts;  }
          //CreateFrame(khmc, cpbh,bz,dw,sl,zh,ApartID,n);
          ADO_Rec.Next;
          inc(n);
        end;
        Frm_WorkOrder.vWorkID := iID;
        //Frm_WorkOrder.lab_HBST.Caption := '打印版式图';
  //          Frm_Print.EnableCom(False);
        ADO_Rec.Free;
      end;
      //读取材料信息到数组
      sSqlData := 'select * from DO_WorkOrderMatl where F_iWorkID = %d';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iID],True);
      SetLength(aCL,0);
      with ADO_Rec do
      begin
        while not ADO_Rec.Eof do
        begin
          SetLength(aCL,Length(aCL)+1);
          aCL[Length(aCL)-1].m_iID := FieldByName('F_iID').AsInteger;
          aCL[Length(aCL)-1].m_sCLBH := FieldByName('F_sCLBH').AsString;
          aCL[Length(aCL)-1].m_sCLMC := FieldByName('F_sCLMC').AsString;
          aCL[Length(aCL)-1].m_sCLGG := FieldByName('F_sCLGG').AsString;
          aCL[Length(aCL)-1].m_sCJGG := FieldByName('F_sCJGG').AsString;
          aCL[Length(aCL)-1].m_iJFQS := FieldByName('F_iJFQS').AsInteger;
          aCL[Length(aCL)-1].m_iJFS := FieldByName('F_iJFS').AsInteger;
          aCL[Length(aCL)-1].m_iGroupID := FieldByName('F_iGroupID').AsInteger;
          Next;
        end;
      end;
      ADO_Rec.Free;
      //读取机台信息到数组
      sSqlData := 'select * from DO_WorkOrderPrtProc where F_iWorkID = %d';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iID],True);
      SetLength(aYSDH,0);
      with ADO_Rec do
      begin
        while not ADO_Rec.Eof do
        begin
          SetLength(aYSDH,Length(aYSDH)+1);
          aYSDH[Length(aYSDH)-1].m_iID := FieldByName('F_iID').AsInteger;
          aYSDH[Length(aYSDH)-1].m_sJTMC := FieldByName('F_sJTMC').AsString;
          aYSDH[Length(aYSDH)-1].m_sJTBH := FieldByName('F_sJTBH').AsString;
          aYSDH[Length(aYSDH)-1].m_sSC := FieldByName('F_sSC').AsString;
          aYSDH[Length(aYSDH)-1].m_iSBS := FieldByName('F_iSBS').AsInteger;
          aYSDH[Length(aYSDH)-1].m_sSB := FieldByName('F_sSB').AsString;
          aYSDH[Length(aYSDH)-1].m_iYS := FieldByName('F_iYS').AsInteger;
          aYSDH[Length(aYSDH)-1].m_iYS_1 := FieldByName('F_iYS_1').AsInteger;
          aYSDH[Length(aYSDH)-1].m_iYS_2 := FieldByName('F_iYS_2').AsInteger;
          aYSDH[Length(aYSDH)-1].m_sYZLX := FieldByName('F_sYZLX').AsString;
          aYSDH[Length(aYSDH)-1].m_sQT := FieldByName('F_sQT').AsString;
          aYSDH[Length(aYSDH)-1].m_sYQGX := FieldByName('F_sYQGX').AsString;
          aYSDH[Length(aYSDH)-1].m_sYQGXSL := FieldByName('F_sYQGXSL').AsString;
          aYSDH[Length(aYSDH)-1].m_sYQGXDW := FieldByName('F_sYQGXDW').AsString;
          aYSDH[Length(aYSDH)-1].m_sYSYQ := FieldByName('F_sYSYQ').AsString;
          //aYSDH[Length(aYSDH)-1].m_sBZ := FieldByName('F_sBZ').AsString;
          aYSDH[Length(aYSDH)-1].m_iBSTID := FieldByName('F_iBSTID').AsInteger;
          aYSDH[Length(aYSDH)-1].m_iBSTYS := FieldByName('F_iBSTYS').AsInteger;
          aYSDH[Length(aYSDH)-1].m_iBSTZS := FieldByName('F_iBSTZS').AsInteger;
//          aYSDH[Length(aYSDH)-1].m_sJTCLBH := FieldByName('F_sJTCLBH').AsString;
//          aYSDH[Length(aYSDH)-1].m_sJTCLMC := FieldByName('F_sJTCLMC').AsString;
//          aYSDH[Length(aYSDH)-1].m_sJTCLGG := FieldByName('F_sJTCLGG').AsString;
//          aYSDH[Length(aYSDH)-1].m_sJTCLDW := FieldByName('F_sJTCLDW').AsString;
          aYSDH[Length(aYSDH)-1].m_iGroupID := FieldByName('F_iGroupID').AsInteger;
          Next;
        end;
      end;
      ADO_Rec.Free;
      //读取制版信息到数组
      sSqlData := 'select * from DO_WorkOrderMkProc where F_iWorkID = %d';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iID],True);
      SetLength(aZB,0);
      with ADO_Rec do
      begin
        while not ADO_Rec.Eof do
        begin
          SetLength(aZB,Length(aZB)+1);
          aZB[Length(aZB)-1].m_iID := FieldByName('F_iID').AsInteger;
          aZB[Length(aZB)-1].m_sTS := FieldByName('F_sTS').AsString;
          aZB[Length(aZB)-1].m_sGB := FieldByName('F_sGB').AsString;
          aZB[Length(aZB)-1].m_sJD := FieldByName('F_sJD').AsString;
          aZB[Length(aZB)-1].m_sDY := FieldByName('F_sDY').AsString;
          aZB[Length(aZB)-1].m_sPB := FieldByName('F_sPB').AsString;
          aZB[Length(aZB)-1].m_sSBLB := FieldByName('F_sSBLB').AsString;
          aZB[Length(aZB)-1].m_sSBKS := FieldByName('F_sSBKS').AsString;
          aZB[Length(aZB)-1].m_iSBK := FieldByName('F_iSBK').AsInteger;
          aZB[Length(aZB)-1].m_sQT := FieldByName('F_sQT').AsString;
          aZB[Length(aZB)-1].m_iGroupID := FieldByName('F_iGroupID').AsInteger;
          Next;
        end;
      end;
      ADO_Rec.Free;

      //读取制版工序信息到数组
      sSqlData := 'select * from DO_WorkOrderMkProcDet where F_iWorkID = %d';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iID],True);
      SetLength(aZBGX,0);
      with ADO_Rec do
      begin
        while not ADO_Rec.Eof do
        begin
          SetLength(aZBGX,Length(aZBGX)+1);
          aZBGX[Length(aZBGX)-1].m_iID := FieldByName('F_iID').AsInteger;
          aZBGX[Length(aZBGX)-1].m_sCode := FieldByName('F_sCode').AsString;
          aZBGX[Length(aZBGX)-1].m_sName := FieldByName('F_sName').AsString;
          aZBGX[Length(aZBGX)-1].m_sCategorySpec := FieldByName('F_sCategorySpec').AsString;
          aZBGX[Length(aZBGX)-1].m_sOutput := FieldByName('F_sOutput').AsString;
          aZBGX[Length(aZBGX)-1].m_sUnit := FieldByName('F_sUnit').AsString;
          aZBGX[Length(aZBGX)-1].m_sBZ := FieldByName('F_sRemarks').AsString;
          aZBGX[Length(aZBGX)-1].m_iMkProcID := FieldByName('F_iMkProcID').AsInteger;
          aZBGX[Length(aZBGX)-1].m_iGroupID := FieldByName('F_iGroupID').AsInteger;
          Next;
        end;
      end;
      ADO_Rec.Free;

    end;

    sSqlData := 'select cast('''' as varchar(500)) orders,cast('''' as varchar(500)) JTMC,cast(0 as int) BSTYS,cast(0 as int) BSTZS '
      +',cast('''' as varchar(500)) CL,cast('''' as varchar(500)) ZB into #s '
      +'select * from #s';
    with Frm_WorkOrder.ADO_WorkOrder do
    begin
      Close;
      SQL.Text := sSqlData;
      Open;
      //取最大行数
      iMax := 0;
      for i := 0 to Length(OrderData) -1 do
      begin
        if iMax < OrderData[i].m_iGroupID then
          iMax := OrderData[i].m_iGroupID;
      end;
      for i := 0 to Length(aYSDH) -1 do
      begin
        if iMax < aYSDH[i].m_iGroupID then
          iMax := aYSDH[i].m_iGroupID;
      end;
      for i := 0 to Length(aCL) -1 do
      begin
        if iMax < aCL[i].m_iGroupID then
          iMax := aCL[i].m_iGroupID;
      end;
      for i := 0 to Length(aZB) -1 do
      begin
        if iMax < aZB[i].m_iGroupID then
          iMax := aZB[i].m_iGroupID;
      end;
      //添加数据
      First;
      sCPBH := '';
      for i := 0 to iMax -1 do
      begin
        for j := 0 to Length(OrderData) -1 do
        begin
          if OrderData[j].m_iGroupID = Frm_WorkOrder.ADO_WorkOrder.RecNo then
          begin
            sCPBH := sCPBH + OrderData[j].m_sCPBH + '; ';
          end;
        end;
        if not Eof then
          Edit
        else
          Insert;
        FieldByName('orders').AsString := sCPBH;
        Post;
        Next;
      end;
      First;
      while not Eof do
      begin
        for i := 0 to Length(aYSDH) -1 do
        begin
          if aYSDH[i].m_iGroupID = Frm_WorkOrder.ADO_WorkOrder.RecNo then
          begin
            Edit;
            FieldByName('JTMC').AsString := aYSDH[i].m_sJTMC;
            FieldByName('BSTYS').AsInteger := aYSDH[i].m_iBSTYS;
            FieldByName('BSTZS').AsInteger := aYSDH[i].m_iBSTZS;
            Post;
          end;
        end;
        Next;
      end;
      First;
      while not Eof do
      begin
        for i := 0 to Length(aCL) -1 do
        begin
          if aCL[i].m_iGroupID = Frm_WorkOrder.ADO_WorkOrder.RecNo then
          begin
            Edit;
            FieldByName('CL').AsString := aCL[i].m_sCLMC;
            Post;
          end;
        end;
        Next;
      end;
      First;
      while not Eof do
      begin
        {for i := 0 to Length(aZB) -1 do
        begin
          if aZB[i].m_iGroupID = Frm_WorkOrder.ADO_WorkOrder.RecNo then
          begin
            str := aZB[i].m_sSBLB + '版 ' + aZB[i].m_sSBKS + '开 ' + IntToStr(aZB[i].m_iSBK) + '块';
            Edit;
            FieldByName('ZB').AsString := str;
            Post;
          end;
        end;   }
        str := '';
        for i := 0 to Length(aZBGX) -1 do
        begin
          if aZBGX[i].m_iGroupID = Frm_WorkOrder.ADO_WorkOrder.RecNo then
            str := str + ';' + aZBGX[i].m_sName ;
        end;
        str := Copy(str,2,Length(str));
        Edit;
        FieldByName('ZB').AsString := str;
        Post;
        Next;
      end;

      Result := True;
    end;
  except
    on E:Exception do
    begin
      Screen.Cursor := crDefault;
      p_MessageBoxDlg('错误：'+e.Message);
    end;
  end;
end;

procedure Tfra_gdcx.ReadDataJTXX(ADO_Data: TADOQuery);
var
  n: Integer;
  sSczt: string;
begin
  stg_jtxx.Clear;
  stg_jtxx.RowCount := iif(ADO_Data.RecordCount > 0, ADO_Data.RecordCount +1, 2);
  n := 1;
  with ADO_Data do
  begin
    First;
    while not Eof do
    begin
      stg_jtxx.cells[c_JTXX_JTBH,n] := FieldByName('F_sJTBH').AsString ;
//      stg_gdmx.ColWidths[c_Code] := 150;
      stg_jtxx.cells[c_JTXX_JTMC,n] := FieldByName('F_sJTMC').AsString;
//      stg_gdmx.ColWidths[c_Code] := 200;
      case FieldByName('F_iSczt').AsInteger of
        0: sSczt:='制版';
        1: sSczt:='印刷';
        2: sSczt:='打号';
        3: sSczt:='后道加工';
        4: sSczt:='进仓';
        5,6: sSczt:='已进仓';
//        5: sSczt:='发货';
//        6: sSczt:='已发货';
      end;
      stg_jtxx.cells[c_JTXX_SCZT,n] := sSczt;
      stg_jtxx.cells[c_JTXX_GroupID,n] := FieldByName('F_iGroupID').AsString;
      stg_jtxx.ColWidths[c_JTXX_GroupID] := 0;
      stg_jtxx.cells[c_JTXX_WorkID,n] := FieldByName('F_iWorkID').AsString;
      stg_jtxx.ColWidths[c_JTXX_GroupID] := 0;
      inc(n);
      Next;
    end;
  end;
end;

procedure Tfra_gdcx.stg_jtxxSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  iID, iGroupID: Integer;
  ADO_Rec: TADOQuery;
  sSqlData: string;
begin
  stg_gdmx.Clear;
  iID := StrToNum(stg_jtxx.Cells[c_JTXX_WorkID,ARow]);
  iGroupID := StrToNum(stg_jtxx.Cells[c_JTXX_GroupID,ARow]);
  if iID > 0 then
  begin
    try
      sSqlData := 'Select * from DO_WorkOrderDetails where F_iWorkID=%d and F_iGroupID=%d';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iID,iGroupID],False);
      if (Assigned(ADO_Rec)) and (ADO_Rec.RecordCount > 0 ) then
        ReadDataGDMX(ADO_Rec);
    finally
      ADO_Rec.Free;
    end;
  end;
end;

procedure Tfra_gdcx.btn_goClick(Sender: TObject);
var
  iYs,n: Integer;
  sSqlData: string;
  ADO_Rec: TADOQuery;
begin
  Screen.Cursor := crHourGlass;
  iYs := StrToNum(edt_ys.Text);
  ADO_Rec := DM_DataBase.OpenQuery(vSqlData,[iYs,vMYTS]);
  if ADO_Rec.RecordCount > 0 then
  begin
    ReadDataGD(ADO_Rec);
    vYs := iYs;
    lab_zys.Caption := '页次：'+IntToStr(iYs)+'/'+ IntToStr(lab_zys.Tag);
  end;
  Screen.Cursor := crDefault;
end;

procedure Tfra_gdcx.lab_firstClick(Sender: TObject);
begin
  if vYs = 1 then Exit;
  edt_ys.Text := '1';
  btn_go.Click;
end;

procedure Tfra_gdcx.lab_upClick(Sender: TObject);
begin
  if vYs > 1 then
  begin
    edt_ys.Text := IntToStr(vYs -1);
    btn_go.Click;
  end;
end;

procedure Tfra_gdcx.lab_downClick(Sender: TObject);
begin
  if vYs < lab_zys.Tag then
  begin
    edt_ys.Text := IntToStr(vYs +1);
    btn_go.Click;
  end;
end;

procedure Tfra_gdcx.lab_lastClick(Sender: TObject);
begin
  if vYs = lab_zys.Tag then Exit;
  edt_ys.Text := IntToStr(lab_zys.Tag);
  btn_go.Click;
end;

procedure Tfra_gdcx.lab_ts50Click(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  iTs,n: Integer;
procedure LabFontClear(lab: TLabel);
begin
  lab.Font.Size := 9;
  lab.Font.Style := [];
  lab.Font.Color := clBlue;
  lab.Cursor := crHandPoint;
end;
begin
  if TLabel(Sender).Tag = vMYTS then Exit;
  iTs := TLabel(Sender).Tag;
  vMYTS := iTs;
//  DM_DataBase.ADO_DataRec.Close;
//  sSqlData := Format(vSqlData,[1,vMYTS]);
  ADO_Rec := DM_DataBase.OpenQuery(vSqlData,[1,vMYTS]);
//  DM_DataBase.ADO_DataRec.SQL.Text :=  sSqlData;
//  DM_DataBase.ADO_DataRec.Open;
//  DM_DataBase.mte_DataRec.Close;
//  DM_DataBase.mte_DataRec.Open;
  LabFontClear(lab_ts50);
  LabFontClear(lab_ts100);
  LabFontClear(lab_ts200);
  LabFontClear(lab_ts500);
  LabFontClear(lab_tsQB);
  TLabel(Sender).Font.Color :=  clBlack;
  TLabel(Sender).Font.Size := 10;
  TLabel(Sender).Font.Style := [fsBold];
  TLabel(Sender).Cursor := crDefault;
  vYs := 1;
  ReadDataGD(ADO_Rec);
  edt_ys.Text := '1';
//  if DM_DataBase.ADO_DataRec.RecordCount > 0 then
//  begin
//    n := DM_DataBase.mte_DataRec.FieldByName('Count').AsInteger;
//    lab_zys.Tag := n div vMYTS;
//    if n mod vMYTS > 0 then
//      lab_zys.Tag := lab_zys.Tag +1;
//    lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);
//  end;
end;

procedure Tfra_gdcx.btn_exportClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    DM_DataBase.gr_dc.p_SaveToExcel(stg_gd,['工单号','户名','品名',
      '机台编号','机台名称','开单日期','交货日期','状态',
      '交版日期','印完日期','装完日期','实际发货日期',
      '最后操作日期','撤消标志'],[c_gdh,c_hm,c_pm,c_JTBH,c_JTMC,
      c_kdrq,c_jhrq,c_sczt,c_jbrq,c_ywrq,c_zwrq,c_sjfhrq,c_czrq,c_cxbz],[0,0,0,0,0,0,0,
      0,0,0,0,0,0,0],False);
    p_MessageBoxDlg('导出成功!');
  except
    p_MessageBoxDlg('导出失败!');
  end;          
  Screen.Cursor := crDefault;

end;

end.


