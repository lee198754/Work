unit uFrascgl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel, RzButton, StdCtrls, RzCmboBx, iComboBox,
  ButtonEdit, ComCtrls, RzListVw, iGrid, RzDTP, ADODB, RzRadChk,
  ImgList, GridsEh, DBGridEh, Menus,RzEdit, DBGridEhGrouping;


type
  TFra_scgl = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    edt_gdh: Ti_TxtFilter;
    btn_cx: TRzBitBtn;
    dtp_kdq: TRzDateTimePicker;
    dtp_kdz: TRzDateTimePicker;
    dtp_jhq: TRzDateTimePicker;
    dtp_jhz: TRzDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    cbb_sczt: Ti_ComboBox;
    RzPanel2: TRzPanel;
    btn_ok: TRzBitBtn;
    btn_zbap: TRzBitBtn;
    cb_kdrq: TRzCheckBox;
    cb_jhrq: TRzCheckBox;
    ImageList1: TImageList;
    RzPanel1: TRzPanel;
    gb_ddxx: TRzGroupBox;
    lv_jtxx: TRzListView;
    gb_gd: TRzGroupBox;
    lv_gd: TRzListView;
    pm_gd: TPopupMenu;
    memu_ckgd: TMenuItem;
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
    btn_ysdh: TRzBitBtn;
    lv_gdmx: TRzListView;
    edt_bfjc: TRzBitBtn;
    procedure btn_cxClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure lv_gdColumnClick(Sender: TObject; Column: TListColumn);
    procedure btn_zbapClick(Sender: TObject);
    procedure cb_kdrqClick(Sender: TObject);
    procedure cb_jhrqClick(Sender: TObject);
    procedure lv_gdCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lv_jtxxColumnClick(Sender: TObject; Column: TListColumn);
    procedure lv_gdMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lab_ts50Click(Sender: TObject);
    procedure lab_firstClick(Sender: TObject);
    procedure lab_upClick(Sender: TObject);
    procedure lab_downClick(Sender: TObject);
    procedure lab_lastClick(Sender: TObject);
    procedure btn_goClick(Sender: TObject);
    procedure memu_ckgdClick(Sender: TObject);
    procedure lv_jtxxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lv_gdmxColumnClick(Sender: TObject; Column: TListColumn);
    procedure lv_gdmxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edt_bfjcClick(Sender: TObject);
  private
    { Private declarations }
    vMYTS: Integer;     //当前每页条数
    vYs: integer;       //当前页数
    vSqlData: string;
    procedure ReadDataGD(ADO_Data: TADOQuery);
    procedure memu_ckgdClick_old(Sender: TObject);
    function p_LoadWorkOrderData: Boolean;    //读取工单数据到数组中(不用)
    procedure ReadDataJTXX(ADO_Data: TADOQuery);
    procedure ReadDataGDMX(ADO_Data: TADOQuery);
    function GetPTWorkID(var sWorkID: string; var sPTWorkID: string): Boolean;   //获取普通邮资(不包含有起始号码的工单)
    function f_MakeAllow: Boolean;   //操作允许
    procedure lv_gdClick(Sender: TObject);
  public
    { Public declarations }
    vFraType: Integer;
    procedure FraShow;
  end;

implementation

{$R *.dfm}

uses
  uDM_DataBase, PubStr, uFrmzbap, uPub_Type, uPub_Func, DateUtils,
  uPrint, uWorkOrder,uPub_Text, DB, uFrm_SCGL_BFJC;

const
  {lv_gd}
  c_bz      = 0;
  c_gdh     = 1;
  c_hm      = 2;
  c_pm      = 3;
//  c_dylb = 3;
//  c_zzs = 4;
  c_kdrq    = 4;
  c_jhrq    = 5;
  c_jtbh    = 6;
  c_jtmc    = 7;
  c_jbrq    = 8;
  c_ywrq    = 9;
  c_zwrq    = 10;
  c_JTXXID  = 11;
  c_GroupID = 12;
  c_F_iID   = 13;

const
  {vFraType}
  c_sczb=1;   //制版
  c_scys=2;   //印刷
  c_scdh=3;   //打号
  c_schdjg=4;   //后道加工
  c_scjc=5;      //进仓
  c_scfh=6;      //发货

const
  {cbb_sczt}
  c_cx_sczb=1;   //制版
  c_cx_scys=2;   //印刷
  c_cx_scdh=3;   //打号
  c_cx_schdjg=4;   //后道加工
  c_cx_scjc=5;      //进仓
  c_cx_scfh=6;      //发货
  c_cx_yzbfnj=7;  //已印刷非内件
  c_cx_ydhhyysnj=8;  //已打号或已印刷内件

const
  c_JTXX_JTBH     = 0;
  c_JTXX_JTMC     = 1;
  c_JTXX_YS       = 2;
  c_JTXX_DYLX     = 3;
  c_JTXX_QT       = 4;
  c_JTXX_GroupID  = 5;
  c_JTXX_ID       = 6;

const
  {lv_gdmx}
  c_GDMX_KHMC    = 0;
  c_GDMX_CPBH    = 1;
  c_GDMX_BCYL    = 2;
  c_GDMX_WJCYL   = 3;
  c_GDMX_ZH      = 4;
  c_GDMX_RJHDQ   = 5;
  c_GDMX_RJHDZ   = 6;
  c_GDMX_BZ      = 7;
  c_GDMX_DetailsID = 8;

procedure TFra_scgl.btn_cxClick(Sender: TObject);
var
  sKdq,sKdz,sJhq,sJhz: string;
  iYs, iTs,iXpl: Integer;
  ADO_Rec: TADOQuery;
  sSqlData: string;
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
//暂不用小批量查询
//  iXpl := -1;
  case cbb_xpl.ItemIndex of
    0: iXpl := -1;
    1: iXpl := 0;
    2: iXpl := 1;
  end;
  iYs := 1;
  vYs := iYs;
  edt_ys.Text := IntToStr(iYs);
  if vMYTS = 0 then
  begin
    vMYTS := 50;
    lab_ts50.Font.Color :=  clBlack;
    lab_ts50.Font.Size := 10;
    lab_ts50.Font.Style := [fsBold];
    lab_ts50.Cursor := crDefault;
  end;
  iTs := vMYTS;
//  sSqlData := 'p_sccx %d,''%s'',''%s'',''%s'',''%s'',''%s'',%d,%d ';        //生产状态,工单号,开单日期起,开单日期止,交货日期起,交货日期止,页数,每页条数
//  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[cbb_sczt.ItemIndex,Trim(edt_gdh.Text),sKdq,sKdz,sJhq,sJhz,iYs,iTs]);
//  vSqlData := Format('p_sccx %d,''%s'',''%s'',''%s'',''%s'',''%s'' ',[cbb_sczt.ItemIndex,Trim(edt_gdh.Text),sKdq,sKdz,sJhq,sJhz])+',%d,%d';
//暂不用小批量查询
  sSqlData := 'p_sccx %d,''%s'',''%s'',''%s'',''%s'',''%s'',%d,%d,%d ';        //生产状态,工单号,开单日期起,开单日期止,交货日期起,交货日期止,小批量,页数,每页条数
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[cbb_sczt.ItemIndex,Trim(edt_gdh.Text),sKdq,sKdz,sJhq,sJhz,iXpl,iYs,iTs]);
  vSqlData := Format('p_sccx %d,''%s'',''%s'',''%s'',''%s'',''%s'',%d,%s,%s ',[cbb_sczt.ItemIndex,Trim(edt_gdh.Text),sKdq,sKdz,sJhq,sJhz,iXpl,'%d','%d']);
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    ReadDataGD(ADO_Rec);
  end else
  begin
    lv_gd.Clear;
    lv_gdmx.Clear;
  end;

  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

  Screen.Cursor := crDefault;
{  with DM_DataBase.ADO_DataRec do
  begin
    Close;
    case cbb_sczt.ItemIndex of
      0:
        begin
          SQL.Text := 'select *,a.F_iID WorkID from BI_WorkOrder a,DO_ProductDate_Log b  where a.F_iID=b.F_iWorkID and a.F_tiCXBZ=0 and a.F_iSczt='+IntToStr(cbb_sczt.ItemIndex);
          //SQL.Text := 'select distinct a.* from BI_WorkOrder a, BI_WorkOrderDetails b where F_iSczt='+IntToStr(cbb_sczt.ItemIndex);   //暂不做限制
         // SQL.Add(' and (exists(select 1 from BI_WorkOrderDetails b,BI_CustomOrderDetails c ,DO_OrderApart f where f.F_tiOrderType=0 and b.F_iApartID=f.F_iID and c.F_iID=f.F_iOrderID and c.F_iTgzt in (4,6) and b.F_iWorkID=a.F_iID )');
         // SQL.Add('or exists(select 1 from BI_WorkOrderDetails d, BI_SellOrderDetails e ,DO_OrderApart g where g.F_tiOrderType=1 and d.F_iApartID=g.F_iID and e.F_iID=g.F_iOrderID and e.F_iTgzt in (4,6) and d.F_iWorkID=a.F_iID))');
          if cb_kdrq.Checked then
            SQL.Add(' and a.F_dKdrq >= '''+sKdq+''' and a.F_dKdrq<='''+sKdz+'''');
          if cb_jhrq.Checked then
            SQL.Add(' and a.F_dJhrq >= '''+sJhq+''' and a.F_dJhrq<='''+sJhz+'''');
          if Trim(edt_gdh.Text) <> '' then
            SQL.Add(' and  CHARINDEX('''+edt_gdh.Text+''',F_sGdh)>0 ');
          SQL.Add(' Order By a.F_iID desc');
        end;
      c_cx_yzbfnj:
        begin
          SQL.Text := 'select *,a.F_iID WorkID  from BI_WorkOrder a,DO_ProductDate_Log b  where a.F_iID=b.F_iWorkID and a.F_tiCXBZ=0 and a.F_iSczt=2';   //内件不显示
          SQL.Add(' and exists(select 1 from  BI_WorkOrderDetails c,DO_OrderApart d where a.F_iID=c.F_iWorkID and d.F_sCPBH=c.F_sCPBH and d.F_tiNJBZ=0)');
          if cb_kdrq.Checked then
            SQL.Add(' and a.F_dKdrq >= '''+sKdq+''' and a.F_dKdrq<='''+sKdz+'''');
          if cb_jhrq.Checked then
            SQL.Add(' and a.F_dJhrq >= '''+sJhq+''' and a.F_dJhrq<='''+sJhz+'''');
          if Trim(edt_gdh.Text) <> '' then
            SQL.Add(' and  CHARINDEX('''+edt_gdh.Text+''',a.F_sGdh)>0 ');
          SQL.Add(' Order By a.F_iID desc');
        end;
      c_cx_ydhhyysnj:
        begin
          SQL.Text := 'select *,a.F_iID WorkID  from BI_WorkOrder a,DO_ProductDate_Log b  where a.F_iID=b.F_iWorkID and a.F_tiCXBZ=0 and (a.F_iSczt=3';   //已打号的全是内件的显示
          SQL.Add(' or (not exists(select 1 from BI_WorkOrderDetails c,DO_OrderApart d where a.F_iID=c.F_iWorkID and d.F_sCPBH=c.F_sCPBH and d.F_tiNJBZ=0) and a.F_iSczt=2 ) )');
          if cb_kdrq.Checked then
            SQL.Add(' and a.F_dKdrq >= '''+sKdq+''' and a.F_dKdrq<='''+sKdz+'''');
          if cb_jhrq.Checked then
            SQL.Add(' and a.F_dJhrq >= '''+sJhq+''' and a.F_dJhrq<='''+sJhz+'''');
          if Trim(edt_gdh.Text) <> '' then
            SQL.Add(' and  CHARINDEX('''+edt_gdh.Text+''',a.F_sGdh)>0 ');
          SQL.Add(' Order By a.F_iID desc');
        end;
    else
      SQL.Text := 'select *,a.F_iID WorkID  from BI_WorkOrder a,DO_ProductDate_Log b  where a.F_iID=b.F_iWorkID and a.F_tiCXBZ=0 and a.F_iSczt='+IntToStr(cbb_sczt.ItemIndex);
      if cb_kdrq.Checked then
        SQL.Add(' and a.F_dKdrq >= '''+sKdq+''' and a.F_dKdrq<='''+sKdz+'''');
      if cb_jhrq.Checked then
        SQL.Add(' and a.F_dJhrq >= '''+sJhq+''' and a.F_dJhrq<='''+sJhz+'''');
      if Trim(edt_gdh.Text) <> '' then
        SQL.Add(' and  CHARINDEX('''+edt_gdh.Text+''',a.F_sGdh)>0 ');
      SQL.Add(' Order By a.F_iID desc');
    end;
    open;
  end;
  ReadDataGD(DM_DataBase.ADO_DataRec);
  lv_gdmx.Clear;  }
end;

procedure TFra_scgl.ReadDataGD(ADO_Data: TADOQuery);
var
  sTgzt,sJDBZ: string;
  dDate: TDateTime;
  i,n: integer;
begin
  lv_gdmx.Clear;
  lv_gd.Items.BeginUpdate;
  try
    btn_cx.Caption := '查询中...';
    with lv_gd,ADO_Data do
    begin
      Clear;
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
      while not Eof do
      begin
        inc(i);
        if i mod 100 = 0 then
          btn_cx.Caption := '查询中'+StrLeft(StrRep('.',(i div 100) Mod 4)+'   ',3);
        Items.Add.Caption := '';
        case FieldByName('F_tiJDBZ').AsInteger of
          1: sJDBZ := '急单';
        else
          sJDBZ := '';
        end;
        Items.Item[Items.Count -1].SubItems.Add(sJDBZ);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sGdh').AsString);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sHm').AsString);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sPm').AsString);
//        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sDylb').AsString);
//        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_iZzs').AsString);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sJTBH').AsString);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sJTMC').AsString);
        dDate := FieldByName('F_dKdrq').AsDateTime;
        if YearOf(dDate)>2000 then
          Items.Item[Items.Count -1].SubItems.Add(FormatDateTime('yyyy-MM-dd hh:mm:ss',dDate))
        else
          Items.Item[Items.Count -1].SubItems.Add('');
        dDate := FieldByName('F_dJhrq').AsDateTime;
        if YearOf(dDate)>2000 then
          Items.Item[Items.Count -1].SubItems.Add(FormatDateTime('yyyy-MM-dd hh:mm:ss',dDate))
        else
          Items.Item[Items.Count -1].SubItems.Add('');
        dDate := FieldByName('F_dYZBRQ').AsDateTime;
        if YearOf(dDate)>2000 then
          Items.Item[Items.Count -1].SubItems.Add(FormatDateTime('yyyy-MM-dd hh:mm:ss',dDate))
        else
          Items.Item[Items.Count -1].SubItems.Add('');
        dDate := FieldByName('F_dYYSRQ').AsDateTime;
        if YearOf(dDate)>2000 then
         Items.Item[Items.Count -1].SubItems.Add(FormatDateTime('yyyy-MM-dd hh:mm:ss',dDate))
        else
          Items.Item[Items.Count -1].SubItems.Add('');
        dDate := FieldByName('F_dYZDRQ').AsDateTime;
        if YearOf(dDate)>2000 then
          Items.Item[Items.Count -1].SubItems.Add(FormatDateTime('yyyy-MM-dd hh:mm:ss',dDate))
        else
          Items.Item[Items.Count -1].SubItems.Add('');
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('JTXXID').AsString);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_iGroupID').AsString);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('WorkID').AsString);
        Next;
      end;
    end;
  finally
    btn_cx.Caption := '查询';
    lv_gd.Items.EndUpdate;
//    gb_gd.Caption := '工单  总数:'+IntToStr(i)+'条';
  end;

end;

procedure TFra_scgl.btn_okClick(Sender: TObject);
var
  i, iCheck,iSczt: Integer;
  sArrCustomID: array of string;
  sWorkID, sNjWorkID, sScrqFieldName,sCzrFieldName: string;
  sJTXXID : string;  //机台信息ID,组ID
  ADO_Rec: TADOQuery;
  sSqlData: string;
  iNjTypeID,iDHID: Integer;
  sDetailsID: string;
  iYsdh: integer;
  sPTWorkID: string;
  sInsertSQL: string;
  iDetailsID,iWJCYL: Integer;

begin
  iYsdh := 0;
  if  TRzButton(Sender).Name = 'btn_ysdh' then
  begin
    iYsdh := 1;
  end;

  //后道加工不需要检查 lv_gd,改成检查lv_gdmx
  if vFraType <> c_schdjg then
  begin
    for i := 0 to lv_gd.Items.Count -1 do
    begin
      if lv_gd.Items[i].Checked then
        Break;
    end;
    if (i = lv_gd.Items.Count) or (lv_gd.Items.Count =0) then
    begin
      Application.MessageBox('请选择至少一项','提示',MB_ICONINFORMATION);
      Exit;
    end;
  end else
  begin
    for i := 0 to lv_gdmx.Items.Count -1 do
    begin
      if lv_gdmx.Items[i].Checked then
        Break;
    end;
    if (i = lv_gdmx.Items.Count) or (lv_gdmx.Items.Count =0) then
    begin
      Application.MessageBox('请选择至少一项','提示',MB_ICONINFORMATION);
      Exit;
    end;
  end;
  
  sWorkID := '';
  //sWorkID := StrToNum(lv_gd.Selected.SubItems.Strings[c_F_iID]);
  sJTXXID := '';
  for i := 0 to lv_gd.Items.Count -1 do
  begin
    if lv_gd.Items[i].Checked then
    begin
      sWorkID := lv_gd.Items[i].SubItems.Strings[c_F_iID] +',' + sWorkID;
      sJTXXID := lv_gd.Items[i].SubItems.Strings[c_JTXXID] +',' + sJTXXID;
    end;
  end;
  if sJTXXID <> '' then
  begin
    sJTXXID := Copy(sJTXXID,1,Length(sJTXXID)-1);
  end;
  if sWorkID <> '' then
  begin
    sWorkID := Copy(sWorkID,1,Length(sWorkID)-1);
  end;

  if lv_gdmx.Columns[0].Width >0 then
  begin
    sDetailsID := '';
    sInsertSQL := '';
    for i := 0 to lv_gdmx.Items.Count -1 do
    begin
      if lv_gdmx.Items[i].Checked then
      begin
        iDetailsID := StrToNum(lv_gdmx.Items[i].SubItems.Strings[c_GDMX_DetailsID]);
        iWJCYL := StrToNum(FloatToStr(StrToFloat(lv_gdmx.Items[i].SubItems.Strings[c_GDMX_WJCYL])*10000));
        if sInsertSQL = '' then
          sInsertSQL := Format(' Select %d,%d ',[iDetailsID,iWJCYL])
        else
          sInsertSQL := sInsertSQL + Format(' union all Select %d,%d ',[iDetailsID,iWJCYL]);
        sDetailsID := lv_gdmx.Items[i].SubItems.Strings[c_GDMX_DetailsID] +',' + sDetailsID;
      end;
    end;
    if sDetailsID <> '' then
    begin
      sDetailsID := Copy(sDetailsID,1,Length(sDetailsID)-1);
    end;
  end;

  try
    DM_DataBase.Con_YDPrint.BeginTrans;
    with DM_DataBase.ADO_DataRec do
    begin
     { Close;
      if vFraType = 1 then          //制版安排
      begin
        SQL.Text := 'Select 1 from DO_MakingTrace where F_iWorkID in ('+sWorkID+')';
        Open;
        if recordcount < iCheck then
        begin
          Application.MessageBox('所选项中存在未安排工单,请重新选择!','提示',MB_ICONINFORMATION);
          Exit;
        end;
      end;   }
      case vFraType of
        c_sczb:
          begin
            iSczt := 1;
            sScrqFieldName := 'F_dYZBRQ';
            sCzrFieldName := 'F_iYZBCZRID'
          end;
        c_scys:
          begin
            iSczt := 2;
            sScrqFieldName := 'F_dYYSRQ';
            sCzrFieldName := 'F_iYYSCZRID';
            //普通邮资(不包含有起始号码的工单)
            if GetPTWorkID(sWorkID,sPTWorkID) then
            begin
              if sPTWorkID <> '' then
              begin
                sSqlData := ' Update DO_WorkOrderPrtProc set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d where F_iID in (%s) and F_iWorkID in (%s) ';
                sSqlData := sSqlData + ' Update DO_WorkOrderDetails set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d from DO_WorkOrderDetails a,DO_WorkOrderPrtProc b '
                  +' where a.F_iGroupID=b.F_iGroupID and a.F_iWorkID=b.F_iWorkID and b.F_iID in (%s) and b.F_iWorkID in (%s) ';
                sSqlData := sSqlData+' Update DO_ProductDate_Log set %s=Getdate(),%s=%d  from DO_ProductDate_Log  a '
                  +' ,DO_WorkOrderPrtProc b where a.F_iWorkID=b.F_iWorkID and a.F_iGroupID=b.F_iGroupID and a.F_iWorkID in (%s) and b.F_iID in (%s) ';
                sSqlData := sSqlData+'Update DO_WorkOrder set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d where F_iID in (%s) ';
                DM_DataBase.ExecQuery(sSqlData,[3,LoginData.m_iUserID,sJTXXID,sPTWorkID
                  ,3,LoginData.m_iUserID,sJTXXID,sPTWorkID
                  ,sScrqFieldName,sCzrFieldName,LoginData.m_iUserID,sPTWorkID,sJTXXID
                  ,3,LoginData.m_iUserID,sPTWorkID],True)
              end;
            end;
            //----------------------------
            if sWorkID <> '' then
            begin
              iNjTypeID := DM_DataBase.GetTableFirst('Select F_iID from Set_ProductType where F_sTypeCode=''0005'' and F_iProductCategoryID=1 '  );
              //iDHID := DM_DataBase.GetTableFirst('Select F_iID from Set_ProductType where F_sTypeName<>''内件'' and F_iProductCategoryID=1'  );
              sSqlData := 'Select F_iID,F_iProductTypeID from  DO_WorkOrder where F_iID in (%s)  ';
              ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sWorkID],True);
              sWorkID := '';
              sNjWorkID := '';
              while not ADO_Rec.Eof do
              begin
                if ADO_Rec.FieldByName('F_iProductTypeID').AsInteger = iNjTypeID then
                  sNjWorkID :=ADO_Rec.FieldByName('F_iID').AsString + ',' + sNjWorkID
                else
                  sWorkID :=ADO_Rec.FieldByName('F_iID').AsString + ',' + sWorkID;
                ADO_Rec.Next;
              end;
              if sNjWorkID <> '' then
              begin
                sNjWorkID := Copy(sNjWorkID,1,Length(sNjWorkID)-1);
                sSqlData := ' Update DO_WorkOrderPrtProc set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d where F_iID in (%s) and F_iWorkID in (%s) ';
                sSqlData := sSqlData + ' Update DO_WorkOrderDetails set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d from DO_WorkOrderDetails a,DO_WorkOrderPrtProc b '
                  +' where a.F_iGroupID=b.F_iGroupID and a.F_iWorkID=b.F_iWorkID and b.F_iID in (%s) and b.F_iWorkID in (%s) ';
                //sSqlData := ' Update DO_WorkOrderDetails set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d from DO_WorkOrderDetails a,DO_WorkOrderPrtProc b '
                //  +' where a.F_iGroupID=b.F_iGroupID and a.F_iWorkID=b.F_iWorkID and b.F_iID in (%s) and b.F_iWorkID in (%s) ';
                //sSqlData := sSqlData+' Update DO_ProductDate_Log set %s=Getdate(),%s=%d where F_iWorkID in (%s) and F_iGroupID in (%s) ';
                sSqlData := sSqlData+' Update DO_ProductDate_Log set %s=Getdate(),%s=%d  from DO_ProductDate_Log  a '
                  +' ,DO_WorkOrderPrtProc b where a.F_iWorkID=b.F_iWorkID and a.F_iGroupID=b.F_iGroupID and a.F_iWorkID in (%s) and b.F_iID in (%s) ';
                sSqlData := sSqlData+'Update DO_WorkOrder set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d where F_iID in (%s) ';
                DM_DataBase.ExecQuery(sSqlData,[3,LoginData.m_iUserID,sJTXXID,sNjWorkID
                  ,3,LoginData.m_iUserID,sJTXXID,sNjWorkID
                  ,sScrqFieldName,sCzrFieldName,LoginData.m_iUserID,sNjWorkID,sJTXXID
                  ,3,LoginData.m_iUserID,sNjWorkID],True)
              end;
              if sWorkID <> '' then
                sWorkID := Copy(sWorkID,1,Length(sWorkID)-1);
            end;
          end;
        c_scdh:
          begin
            iSczt := 3;
            sScrqFieldName := 'F_dYDHRQ';
            sCzrFieldName := 'F_iYDHCZRID';
          end;
        c_schdjg:
          begin
            iSczt := 4;
            sScrqFieldName := 'F_dYZDRQ';
            sCzrFieldName := 'F_iYZDCZRID';
            //按订单进仓

            //后道进仓合并
            //后道订单录入
            if (sWorkID <> '') and (sJTXXID <> '') and (sDetailsID <> '' ) then
            begin
              sSqlData := ' Update DO_WorkOrderDetails set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d where F_iID in (%s) and F_iWorkID in (%s) ';
              sSqlData := sSqlData + ' Update DO_WorkOrderPrtProc set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d from DO_WorkOrderPrtProc a '
                +' where not exists(Select 1 from DO_WorkOrderDetails where F_iSczt<%d and F_iWorkID=a.F_iWorkID and F_iGroupID=a.F_iGroupID) '
                +' and F_iID in (%s) and F_iWorkID in (%s) ';
              //sSqlData := ' Update DO_WorkOrderPrtProc set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d where F_iID in (%s) and F_iWorkID in (%s)';
              //sSqlData := ' Update DO_WorkOrderDetails set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d from DO_WorkOrderDetails a,DO_WorkOrderPrtProc b '
              //  +' where a.F_iGroupID=b.F_iGroupID and a.F_iWorkID=b.F_iWorkID and b.F_iID in (%s) and b.F_iWorkID in (%s) ';
              //sSqlData := sSqlData + ' Update DO_ProductDate_Log set %s=Getdate(),%s=%d where F_iWorkID in (%s) and F_iGroupID in (%s) ';
              sSqlData := sSqlData+' Update DO_ProductDate_Log set %s=Getdate(),%s=%d  from DO_ProductDate_Log  a '
                +' ,DO_WorkOrderPrtProc b where a.F_iWorkID=b.F_iWorkID and a.F_iGroupID=b.F_iGroupID and a.F_iWorkID in (%s) and b.F_iID in (%s) '
                +' and not exists(Select 1 from DO_WorkOrderDetails where F_iSczt<%d and F_iWorkID=a.F_iWorkID and F_iGroupID=a.F_iGroupID)';
              sSqlData := sSqlData + ' Update DO_WorkOrder set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d from DO_WorkOrder a where a.F_iID in (%s) '
                +' and not exists(Select 1 from DO_WorkOrderDetails where F_iSczt<%d and F_iWorkID=a.F_iID ) ';
              DM_DataBase.ExecQuery(sSqlData,[iSczt,LoginData.m_iUserID,sDetailsID,sWorkID
                ,iSczt,LoginData.m_iUserID,iSczt,sJTXXID,sWorkID
                ,sScrqFieldName,sCzrFieldName,LoginData.m_iUserID,sWorkID,sJTXXID,iSczt
                ,iSczt,LoginData.m_iUserID,sWorkID,iSczt],True);
            end;
            iSczt := 5;
            sScrqFieldName := 'F_dYJCRQ';
            sCzrFieldName := 'F_iYJCCZRID';
            if sDetailsID <> '' then
            begin
              sSqlData := 'create table #ApartID (F_iApartID int ,F_iDetailsID int,F_iSL int) ';
              sSqlData := sSqlData + ' insert into #ApartID (F_iDetailsID,F_iSL) ' + sInsertSQL;
              DM_DataBase.ExecQuery(sSqlData,[],True);
              sSqlData := ' p_jcgl ''%s''';
              DM_DataBase.ExecQuery(sSqlData,[sDetailsID],True);
              sSqlData := 'drop table #ApartID';
              DM_DataBase.ExecQuery(sSqlData,[],True);
            end;
          end;
        c_scjc:
          begin
            iSczt := 5;
            sScrqFieldName := 'F_dYJCRQ';
            sCzrFieldName := 'F_iYJCCZRID';
            if sDetailsID <> '' then
            begin
              sSqlData := 'create table #ApartID (F_iApartID int ,F_iDetailsID int,F_iSL int) ';
              sSqlData := sSqlData + ' insert into #ApartID (F_iDetailsID,F_iSL) ' + sInsertSQL;
              DM_DataBase.ExecQuery(sSqlData,[],True);
              sSqlData := ' p_jcgl ''%s''';
              DM_DataBase.ExecQuery(sSqlData,[sDetailsID],True);
              sSqlData := 'drop table #ApartID';
              DM_DataBase.ExecQuery(sSqlData,[],True);
            end;
          end;
        c_scfh:
          begin
            iSczt := 6;
            sScrqFieldName := 'F_dYFHRQ';
            sCzrFieldName := 'F_iYFHCZRID';
          end;
      end;
      if (sWorkID <> '') and (sJTXXID <> '') then
      begin
        case vFraType of
          c_schdjg,c_scjc:
            begin
            //进仓订单录入
              if sDetailsID <> ''  then
              begin
                sSqlData := ' Update DO_WorkOrderDetails set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d where F_iID in (%s) and F_iWorkID in (%s) ';
                sSqlData := sSqlData + ' Update DO_WorkOrderPrtProc set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d from DO_WorkOrderPrtProc a '
                  +' where not exists(Select 1 from DO_WorkOrderDetails where F_iSczt<%d and F_iWorkID=a.F_iWorkID and F_iGroupID=a.F_iGroupID) '
                  +' and F_iID in (%s) and F_iWorkID in (%s) ';
                //sSqlData := ' Update DO_WorkOrderPrtProc set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d where F_iID in (%s) and F_iWorkID in (%s)';
                //sSqlData := ' Update DO_WorkOrderDetails set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d from DO_WorkOrderDetails a,DO_WorkOrderPrtProc b '
                //  +' where a.F_iGroupID=b.F_iGroupID and a.F_iWorkID=b.F_iWorkID and b.F_iID in (%s) and b.F_iWorkID in (%s) ';
                //sSqlData := sSqlData + ' Update DO_ProductDate_Log set %s=Getdate(),%s=%d where F_iWorkID in (%s) and F_iGroupID in (%s) ';
                sSqlData := sSqlData+' Update DO_ProductDate_Log set %s=Getdate(),%s=%d  from DO_ProductDate_Log  a '
                  +' ,DO_WorkOrderPrtProc b where a.F_iWorkID=b.F_iWorkID and a.F_iGroupID=b.F_iGroupID and a.F_iWorkID in (%s) and b.F_iID in (%s) '
                  +' and not exists(Select 1 from DO_WorkOrderDetails where F_iSczt<%d and F_iWorkID=a.F_iWorkID and F_iGroupID=a.F_iGroupID)';
                sSqlData := sSqlData + ' Update DO_WorkOrder set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d from DO_WorkOrder a where a.F_iID in (%s) '
                  +' and not exists(Select 1 from DO_WorkOrderDetails where F_iSczt<%d and F_iWorkID=a.F_iID ) ';
                DM_DataBase.ExecQuery(sSqlData,[iSczt,LoginData.m_iUserID,sDetailsID,sWorkID
                  ,iSczt,LoginData.m_iUserID,iSczt,sJTXXID,sWorkID
                  ,sScrqFieldName,sCzrFieldName,LoginData.m_iUserID,sWorkID,sJTXXID,iSczt
                  ,iSczt,LoginData.m_iUserID,sWorkID,iSczt],True);
              end;
            end;
        else
          begin
            sSqlData := ' Update DO_WorkOrderPrtProc set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d where F_iID in (%s) and F_iWorkID in (%s)';
            sSqlData := sSqlData + ' Update DO_WorkOrderDetails set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d from DO_WorkOrderDetails a,DO_WorkOrderPrtProc b '
              +' where a.F_iGroupID=b.F_iGroupID and a.F_iWorkID=b.F_iWorkID and b.F_iID in (%s) and b.F_iWorkID in (%s) ';
            //sSqlData := sSqlData + ' Update DO_ProductDate_Log set %s=Getdate(),%s=%d where F_iWorkID in (%s) and F_iGroupID in (%s) ';
            sSqlData := sSqlData+' Update DO_ProductDate_Log set %s=Getdate(),%s=%d  from DO_ProductDate_Log  a '
              +' ,DO_WorkOrderPrtProc b where a.F_iWorkID=b.F_iWorkID and a.F_iGroupID=b.F_iGroupID and a.F_iWorkID in (%s) and b.F_iID in (%s) ';
            sSqlData := sSqlData + ' Update DO_WorkOrder set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d from DO_WorkOrder a where a.F_iID in (%s) '
              +' and not exists(Select 1 from DO_WorkOrderDetails where F_iSczt<%d and F_iWorkID=a.F_iID ) ';
            DM_DataBase.ExecQuery(sSqlData,[iSczt,LoginData.m_iUserID,sJTXXID,sWorkID
              ,iSczt,LoginData.m_iUserID,sJTXXID,sWorkID
              ,sScrqFieldName,sCzrFieldName,LoginData.m_iUserID,sWorkID,sJTXXID
              ,iSczt,LoginData.m_iUserID,sWorkID,iSczt],True);
            if iYsdh = 1 then
            begin
              iSczt := 3;
              sScrqFieldName := 'F_dYDHRQ';
              sCzrFieldName := 'F_iYDHCZRID';
              sSqlData := ' Update DO_WorkOrderPrtProc set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d where F_iID in (%s) and F_iWorkID in (%s) ';
              sSqlData := sSqlData + ' Update DO_WorkOrderDetails set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d from DO_WorkOrderDetails a,DO_WorkOrderPrtProc b '
                +' where a.F_iGroupID=b.F_iGroupID and a.F_iWorkID=b.F_iWorkID and b.F_iID in (%s) and b.F_iWorkID in (%s) ';
              //sSqlData := sSqlData + ' Update DO_ProductDate_Log set %s=Getdate(),%s=%d where F_iWorkID in (%s) and F_iGroupID in (%s) ';
              sSqlData := sSqlData+' Update DO_ProductDate_Log set %s=Getdate(),%s=%d  from DO_ProductDate_Log  a '
                +' ,DO_WorkOrderPrtProc b where a.F_iWorkID=b.F_iWorkID and a.F_iGroupID=b.F_iGroupID and a.F_iWorkID in (%s) and b.F_iID in (%s) ';
              sSqlData := sSqlData + ' Update DO_WorkOrder set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d from DO_WorkOrder a where a.F_iID in (%s) '
                +' and not exists(Select 1 from DO_WorkOrderDetails where F_iSczt<%d and F_iWorkID=a.F_iID ) ';
              DM_DataBase.ExecQuery(sSqlData,[iSczt,LoginData.m_iUserID,sJTXXID,sWorkID
                ,iSczt,LoginData.m_iUserID,sJTXXID,sWorkID
                ,sScrqFieldName,sCzrFieldName,LoginData.m_iUserID,sWorkID,sJTXXID
                ,iSczt,LoginData.m_iUserID,sWorkID,iSczt],True);
            end;
    {        if iSczt = 5 then
            begin
              sSqlData := 'Update DO_ProductDate_Log set '+sScrqFieldName+'=Getdate(),'+sCzrFieldName+'='+IntToStr(LoginData.m_iUserID)+' where F_iWorkID in ('+sWorkID+')';
              SQL.Text := sSqlData;
              ExecSQL;
            end; }
          end;
        end;
      end;
    end;
    if (sWorkID <> '') or (sNjWorkID <> '') or (sJTXXID <> '') then
      Application.MessageBox('成功','提示',MB_ICONINFORMATION);
    btn_cx.Click;
    DM_DataBase.Con_YDPrint.CommitTrans;
  except
    on E: Exception do
    begin
      DM_DataBase.Con_YDPrint.RollbackTrans;
      Application.MessageBox(PChar('失败:'+E.message),'提示',MB_ICONINFORMATION);
    end;
  end;
end;

procedure TFra_scgl.lv_gdColumnClick(Sender: TObject; Column: TListColumn);
var
  i: Integer;
  bQx: Boolean;
begin
  if Column.Caption = '选择' then
  begin
    bQx := False;
    for i := 0 to lv_gd.Items.Count -1 do
    begin
      if not lv_gd.Items[i].Checked then
      begin
        bQx := True;
        Break
      end;
    end;
    if bQx then
    begin
      for i := 0 to lv_gd.Items.Count -1 do
        lv_gd.Items[i].Checked := True;
    end else
    begin
      for i := 0 to lv_gd.Items.Count -1 do
        lv_gd.Items[i].Checked := False;
    end;
  end else
  begin
    TRzListView(Sender).CustomSort(@RzCustomSortProc,Column.Index)
  end;
end;

procedure TFra_scgl.btn_zbapClick(Sender: TObject);
var
  i,iCheck: Integer;
  sWorkID: string;
  ADO_Rec: TADOQuery;
  SqlData: string;
begin
  for i := 0 to lv_gd.Items.Count -1 do
  begin
    if lv_gd.Items.Item[i].Checked then
    begin
      sWorkID := sWorkID + lv_gd.Items[i].SubItems[lv_gd.Items[i].SubItems.Count-1] +',';
      iCheck := i;
    end;
  end;
  sWorkID := Copy(sWorkID,1,Length(sWorkID)-1);
  if Pos(',',sWorkID) >0 then
  begin
    Application.MessageBox('只能对一个工单进行安排!','提示',MB_ICONINFORMATION);
    Exit;
  end;
  if sWorkID = '' then
  begin
    Application.MessageBox('请选择工单!','提示',MB_ICONINFORMATION);
    Exit;
  end;
  Frm_zbap := TFrm_zbap.Create(Self);
  Frm_zbap.lab_gzdh.Caption := lv_gd.Items[iCheck].SubItems.Strings[c_gdh];
  Frm_zbap.lab_cpmc.Caption := lv_gd.Items[iCheck].SubItems.Strings[c_pm];
  uFrmzbap.vWorkID := StrToInt(sWorkID);
  Frm_zbap.ShowModal;
  Frm_zbap.Free;


end;

procedure TFra_scgl.cb_kdrqClick(Sender: TObject);
begin
  dtp_kdq.Enabled := cb_kdrq.Checked;
  dtp_kdz.Enabled := cb_kdrq.Checked;

end;

procedure TFra_scgl.cb_jhrqClick(Sender: TObject);
begin
  dtp_jhq.Enabled := cb_jhrq.Checked;
  dtp_jhz.Enabled := cb_jhrq.Checked;
end;

procedure TFra_scgl.lv_gdCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if (Item.Index mod 2) = 0 then
    Sender.Canvas.Brush.Color := $00F0FFF0
  else
    Sender.Canvas.Brush.Color := $00F2F2F2;
  LVDrawItem(TRzListView(Sender), Item, State, DefaultDraw);
end;

procedure TFra_scgl.lv_jtxxColumnClick(Sender: TObject;
  Column: TListColumn);
var
  i: Integer;
  bQx: Boolean;
begin
  if Column.Caption = '选择' then
  begin
    bQx := False;
    for i := 0 to lv_gd.Items.Count -1 do
    begin
      if not lv_gd.Items[i].Checked then
      begin
        bQx := True;
        Break
      end;
    end;
    if bQx then
    begin
      for i := 0 to lv_gd.Items.Count -1 do
        lv_gd.Items[i].Checked := True;
    end else
    begin
      for i := 0 to lv_gd.Items.Count -1 do
        lv_gd.Items[i].Checked := False;
    end;
  end else
  begin
    TRzListView(Sender).CustomSort(@RzCustomSortProc,Column.Index)
  end;
end;

procedure TFra_scgl.lv_gdMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Point: TPoint;
begin
  if Button = mbRight then
  begin
    if Assigned(TListView(Sender).Selected) and (X > 20) then
    begin
      GetCursorPos(Point);
      pm_gd.Popup(Point.X,Point.Y)
    end;
  end else
  if (Button = mbleft) and (X > 20) then
  begin
    if not Assigned(TRzListView(Sender).Selected) then Exit;
    TRzListView(Sender).Selected.Checked := not TRzListView(Sender).Selected.Checked;
  end;
  if (X <= 20) then
  begin
    if Assigned(TRzListView(Sender).GetItemAt(X,Y)) then
      TRzListView(Sender).ItemIndex := TRzListView(Sender).GetItemAt(X,Y).Index;
  end;
  lv_gdClick(Sender);
end;

procedure TFra_scgl.memu_ckgdClick_old(Sender: TObject);
var
  SelItem: TListItem;
  ADO_Rec: TADOQuery;
  i, n, iOrderType: Integer;
  sHint, sID, sCXBZ, sSczt: string;
  comp: TComponent;
  iBsts: Integer;
  khmc,cpbh,bz,dw,sl,zh,ApartID: string;
begin
  SelItem := lv_gd.Selected;
  if not Assigned(SelItem) then Exit;
  sID := SelItem.SubItems.Strings[c_F_iID];
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
          5: sSczt:='发货';
          6: sSczt:='已发货';
        end;
//        Frm_Print.lab_jbrq.Visible := True;
//        Frm_Print.lab_ywrq.Visible := True;
//        Frm_Print.lab_zwrq.Visible := True;
//        Frm_Print.lab_jbrq.Caption := SelItem.SubItems.Strings[c_jbrq];
//        Frm_Print.lab_ywrq.Caption := SelItem.SubItems.Strings[c_ywrq];
//        Frm_Print.lab_zwrq.Caption := SelItem.SubItems.Strings[c_zwrq];
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
          OrderData[Length(OrderData)-1].m_iApartID := StrToInt(ApartID);
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
        Frm_Print.ShowModal;
        Frm_Print.btn_cx.Caption := '撤消';
//        setLength(lab, 0);
//        setLength(edt, 0);
//        setLength(cbb, 0);
        Frm_Print.Free;
      end;
      btn_cx.Click;
    end;
  finally
    ADO_Rec.Free;
  end;
end;

procedure TFra_scgl.lv_gdClick(Sender: TObject);
var
  iWorkID,iGroupID: integer;
  sSqlData: string;
  ADO_Rec: TADOQuery;
  i, iSCZT: integer;
begin
  //if not gb_ddxx.Visible then Exit;
  lv_jtxx.Clear;
  if not Assigned(lv_gd.Selected) then Exit;
  case vFraType of
    c_schdjg:
      begin
        if lv_gd.Selected.Checked then
        begin
          for i := 0 to lv_gd.Items.Count -1 do
          begin
            if i <> lv_gd.Selected.Index then
              lv_gd.Items.Item[i].Checked := False;
          end;
          iWorkID := StrToNum(lv_gd.Items[lv_gd.Selected.Index].SubItems[c_F_iID]);
          iGroupID := StrToNum(lv_gd.Items[lv_gd.Selected.Index].SubItems[c_GroupID]);
          if iWorkID > 0 then
          begin
            try
              iSCZT := cbb_sczt.ItemIndex;
              //sSqlData := 'Select * from DO_WorkOrderPrtProc where F_iWorkID = %d and F_iSCZT=%d';
              sSqlData := 'Select * from DO_WorkOrderDetails where F_iWorkID = %d and F_iGroupID=%d and F_iSCZT = %d';
              ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iWorkID,iGroupID,iSCZT],False);
              if (Assigned(ADO_Rec)) and (ADO_Rec.RecordCount > 0) then
                ReadDataGDMX(ADO_Rec)
              else
                lv_gdmx.Clear;
            finally
              ADO_Rec.Free;
            end;
          end;
        end else
        begin
          lv_gdmx.Clear;
        end;
      end;
  end;

end;

procedure TFra_scgl.lab_ts50Click(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  iTs: Integer;
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
  ADO_Rec := DM_DataBase.OpenQuery(vSqlData,[1,iTs]);
  vMYTS := iTs;
  LabFontClear(lab_ts50);
  LabFontClear(lab_ts100);
  LabFontClear(lab_ts200);
  LabFontClear(lab_ts500);
  TLabel(Sender).Font.Color :=  clBlack;
  TLabel(Sender).Font.Size := 10;
  TLabel(Sender).Font.Style := [fsBold];
  TLabel(Sender).Cursor := crDefault;
  ReadDataGD(ADO_Rec);
  ADO_Rec.Free;
  vYs := 1;
  edt_ys.Text := '1';
  lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);

end;

procedure TFra_scgl.lab_firstClick(Sender: TObject);
begin
  if vYs = 1 then Exit;
  edt_ys.Text := '1';
  btn_go.Click;
end;

procedure TFra_scgl.lab_upClick(Sender: TObject);
begin
  if vYs > 1 then
  begin
    edt_ys.Text := IntToStr(vYs -1);
    btn_go.Click;
  end;
end;

procedure TFra_scgl.lab_downClick(Sender: TObject);
begin
  if vYs < lab_zys.Tag then
  begin
    edt_ys.Text := IntToStr(vYs +1);
    btn_go.Click;
  end;
end;

procedure TFra_scgl.lab_lastClick(Sender: TObject);
begin
  if vYs = lab_zys.Tag then Exit;
  edt_ys.Text := IntToStr(lab_zys.Tag);
  btn_go.Click;

end;

procedure TFra_scgl.btn_goClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  iYs: Integer;
begin
  Screen.Cursor := crHourGlass;
  iYs := StrToNum(edt_ys.Text);
  ADO_Rec := DM_DataBase.OpenQuery(vSqlData,[iYs,vMYTS]);
  ReadDataGD(ADO_Rec);
  lab_zys.Caption := '页次：'+IntToStr(iYs)+'/'+ IntToStr(lab_zys.Tag);
  vYs := iYs;
  Screen.Cursor := crDefault;
end;

procedure TFra_scgl.FraShow;
begin
  lv_gd.Columns[c_hm+1].Width := 0;
  case vFraType of
    c_schdjg:
      begin
        //lv_gd.Columns[0].Width := 0;
        lv_gdmx.Columns[0].Width := 40;
        edt_bfjc.Show;
        edt_bfjc.Left := btn_ysdh.Left;
        gb_ddxx.Show;
      end;
  else
    begin
      //lv_gd.Columns[0].Width := 40;
      lv_gdmx.Columns[0].Width := 0;
      gb_ddxx.Hide;
      edt_bfjc.Hide;
    end;
  end;
  f_MakeAllow;
end;

procedure TFra_scgl.memu_ckgdClick(Sender: TObject);
var
  iWorkID, iGroupID: Integer;
  SelItem: TListItem;
begin
  Frm_WorkOrder := TFrm_WorkOrder.Create(Self);
  SelItem := lv_gd.Selected;
  iWorkID := StrToNum(SelItem.SubItems.Strings[c_F_iID]);
  iGroupID := StrToNum(SelItem.SubItems.Strings[c_GroupID]);
  Frm_WorkOrder.vWorkID := iWorkID;
  Frm_WorkOrder.vGroupID := iGroupID;
  Frm_WorkOrder.vbCXBZ := False;
  if Frm_WorkOrder.p_LoadWorkOrderData then
  begin
    Frm_WorkOrder.btn_zd.Enabled := False;
    Frm_WorkOrder.btn_xg.Enabled := True;
    Frm_WorkOrder.btn_dy.Enabled := True;
    Frm_WorkOrder.btn_cx.Enabled := True;
    Frm_WorkOrder.vActionType := c_WorkOrder_Select ;

    Frm_WorkOrder.ShowModal;
    Frm_WorkOrder.btn_cx.Caption := '撤消';
  end;
  Frm_WorkOrder.Free;
end;

function TFra_scgl.p_LoadWorkOrderData: Boolean;
var
  ADO_Rec: TADOQuery;
  i, j, n, iOrderType, iID: Integer;
  sHint, sSczt, str: string;
  comp: TComponent;
  iBsts,iWorkID,iApartID, iGroupID: Integer;
  sKHMC,sCPBH,SBZ,sDW,sSL,sZH,sRJHDQ,sRJHDZ,sCXBZ: string;
  iSYYL, iMax: integer;
  sSqlData: string;
  SelItem: TListItem;
  sTypeName: string;
begin
  Result := False;
  SelItem := lv_gd.Selected;
  if not Assigned(SelItem) then Exit;
  iID := StrToNum(SelItem.SubItems.Strings[c_F_iID]);
  if iID = 0 then Exit;
  try
    sSqlData := 'Select a.*,b.F_sTypeName from DO_WorkOrder a left join Set_ProductType b on a.F_iProductTypeID=b.F_iID where a.F_iID=%d';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iID,iGroupID],True);
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
        Frm_WorkOrder.Caption := '工单查询 -- '+SelItem.SubItems.Strings[c_gdh]+'('+ sTypeName + ')';
        case FieldByName('F_iSczt').AsInteger of
          0: sSczt:='制版';
          1: sSczt:='印刷';
          2: sSczt:='打号';
          3: sSczt:='后道加工';
          4: sSczt:='进仓';
          5,6: sSczt:='已进仓';
        end;
        Frm_WorkOrder.gb_zt.Show;
        Frm_WorkOrder.lab_sczt.Caption := '该工单目前生产进度： '+sSczt;
        if Trim(SelItem.SubItems.Strings[c_jbrq]) <> '' then
        begin
          Frm_WorkOrder.lab_jbrq.Visible := True;
          Frm_WorkOrder.lab_jbrq.Caption := '交版日期：'+SelItem.SubItems.Strings[c_jbrq];
          Frm_WorkOrder.lab_jbrq.Left := Frm_WorkOrder.lab_sczt.Left+ Frm_WorkOrder.lab_sczt.Width + 30;   
        end;
        if Trim(SelItem.SubItems.Strings[c_ywrq]) <> '' then
        begin
          Frm_WorkOrder.lab_ywrq.Visible := True;
          Frm_WorkOrder.lab_ywrq.Caption := '印完日期：'+SelItem.SubItems.Strings[c_ywrq];
          Frm_WorkOrder.lab_ywrq.Left := Frm_WorkOrder.lab_jbrq.Left+ Frm_WorkOrder.lab_jbrq.Width + 30;
        end;
        if Trim(SelItem.SubItems.Strings[c_zwrq]) <> '' then
        begin
          Frm_WorkOrder.lab_zwrq.Visible := True;
          Frm_WorkOrder.lab_zwrq.Caption := '装订日期：'+SelItem.SubItems.Strings[c_zwrq];
          Frm_WorkOrder.lab_zwrq.Left := Frm_WorkOrder.lab_ywrq.Left+ Frm_WorkOrder.lab_ywrq.Width + 30;
        end;
        //DM_DataBase.GetTableData(ADO_Rec,'DO_WorkOrderDetails','F_iWorkID='+sID);
        ADO_Rec.Free;
        //读取订单信息到数组
        sSqlData := 'select *,SYYL=dbo.f_GetSYYL(F_iApartID) from DO_WorkOrderDetails where F_iWorkID=%d ';
        ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iID],True);
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
           // aYSDH[Length(aYSDH)-1].m_sBZ := FieldByName('F_sBZ').AsString;
            aYSDH[Length(aYSDH)-1].m_iBSTID := FieldByName('F_iBSTID').AsInteger;
            aYSDH[Length(aYSDH)-1].m_iBSTYS := FieldByName('F_iBSTYS').AsInteger;
            aYSDH[Length(aYSDH)-1].m_iBSTZS := FieldByName('F_iBSTZS').AsInteger;
//            aYSDH[Length(aYSDH)-1].m_sJTCLBH := FieldByName('F_sJTCLBH').AsString;
//            aYSDH[Length(aYSDH)-1].m_sJTCLMC := FieldByName('F_sJTCLMC').AsString;
//            aYSDH[Length(aYSDH)-1].m_sJTCLGG := FieldByName('F_sJTCLGG').AsString;
//            aYSDH[Length(aYSDH)-1].m_sJTCLDW := FieldByName('F_sJTCLDW').AsString;
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
      end;

      Result := True;
    end;
  except
    on E:Exception do
    begin
      p_MessageBoxDlg('错误：'+e.Message);
    end;
  end;
end;

procedure TFra_scgl.ReadDataJTXX(ADO_Data: TADOQuery);
var
  n: Integer;
  sDw: string;
begin
  lv_jtxx.Clear;
  with lv_jtxx,ADO_Data do
  begin
    First;
    while not Eof do
    begin
      Items.Add.Caption := '';
      Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sJTBH').AsString);
      Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sJTMC').AsString);
      Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_iYS').AsString);
      Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sYZLX').AsString);
      Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sQT').AsString);
      Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_iGroupID').AsString);
      Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_iID').AsString);
      Next;
    end;
  end;
end;

procedure TFra_scgl.lv_jtxxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbleft) and (X > 16) then
  begin
    if not Assigned(TRzListView(Sender).Selected) then Exit;
    TRzListView(Sender).Selected.Checked := not TRzListView(Sender).Selected.Checked;
  end;
end;

procedure TFra_scgl.ReadDataGDMX(ADO_Data: TADOQuery);
var
  sTgzt: string;
begin
//  lv_gdmx.Items.BeginUpdate;
  with lv_gdmx,ADO_Data do
  begin
    Clear;
    First;
    while not Eof do
    begin
      Items.Add.Caption := '';
      Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sKhmc').AsString);
      Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sCpbh').AsString);
      Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sSl').AsString);
      Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_nWJCSL').AsString);
      Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sZh').AsString);
      Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sRJHDQ').AsString);
      Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sRJHDZ').AsString);
      Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sBz').AsString);
      Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_iID').AsString);
      Next;
    end;
  end;
//  lv_gdmx.Items.EndUpdate;
end;

procedure TFra_scgl.lv_gdmxColumnClick(Sender: TObject;
  Column: TListColumn);
var
  i: Integer;
  bQx: Boolean;
  lv: TRzListView;
begin
  lv := TRzListView(Sender);
  if Column.Caption = '选择' then
  begin
    bQx := False;
    for i := 0 to lv.Items.Count -1 do
    begin
      if not lv.Items[i].Checked then
      begin
        bQx := True;
        Break
      end;
    end;
    if bQx then
    begin
      for i := 0 to lv.Items.Count -1 do
        lv.Items[i].Checked := True;
    end else
    begin
      for i := 0 to lv.Items.Count -1 do
        lv.Items[i].Checked := False;
    end;
  end else
  begin
    TRzListView(Sender).CustomSort(@RzCustomSortProc,Column.Index)
  end;
end;

procedure TFra_scgl.lv_gdmxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (X <= 20) then
  begin
    if Assigned(TRzListView(Sender).GetItemAt(X,Y)) then
      TRzListView(Sender).ItemIndex := TRzListView(Sender).GetItemAt(X,Y).Index;
  end;
  if (Button = mbleft) and (X > 20) then
  begin
    if not Assigned(TRzListView(Sender).Selected) then Exit;
    TRzListView(Sender).Selected.Checked := not TRzListView(Sender).Selected.Checked;
  end;
end;

function TFra_scgl.GetPTWorkID(var sWorkID, sPTWorkID: string): Boolean;
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
  sTemp_WorkID,sTemp_PTWorkID: string;
begin
  Result := False;
  sTemp_WorkID := sWorkID;
  sTemp_PTWorkID := sPTWorkID;
  sSqlData :=  'Select a.F_iID,b.F_iClassCode,a.F_sQSHM from DO_WorkOrder a,Set_ProductCategory b where a.F_iProductCategoryID = b.F_iID  and a.F_iID in (%s)';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sTemp_WorkID],True);
  sTemp_WorkID := '';
  sTemp_PTWorkID := '';
  while not ADO_Rec.Eof do
  begin
    if (ADO_Rec.FieldByName('F_iClassCode').AsInteger = 0)  and (ADO_Rec.FieldByName('F_sQSHM').AsString = '') then
      sTemp_PTWorkID := sTemp_PTWorkID +',' + ADO_Rec.FieldByName('F_iID').AsString
    else
      sTemp_WorkID := sTemp_WorkID + ',' + ADO_Rec.FieldByName('F_iID').AsString;
    ADO_Rec.Next;
  end;
  if sTemp_WorkID <> '' then
    sTemp_WorkID := Copy(sTemp_WorkID,2,Length(sTemp_WorkID));
  if sTemp_PTWorkID <> '' then
    sTemp_PTWorkID := Copy(sTemp_PTWorkID,2,Length(sTemp_PTWorkID));
  ADO_Rec.Free;
  sWorkID := sTemp_WorkID;
  sPTWorkID := sTemp_PTWorkID;
  Result := True;
end;

function TFra_scgl.f_MakeAllow: Boolean;
var
  sSqlData, sCode: string;
  ADO_Rec: TADOQuery;
  iAllowID, iAllowCode: Integer;
begin
  Result := False;
  if LoginData.m_iAllowCode >= 0 then
  begin
    case vFraType of
      c_sczb: sCode := ''''+ c_Allow_ZB_OK + '''';
      c_scys: begin
        sCode := ''''+c_Allow_YS_OK+'''';
        sCode := sCode + ',''' + c_Allow_YS_YSDH+'''';
      end;
      c_scdh: sCode := '''' + c_Allow_DH_OK + '''';
      c_schdjg: sCode := '''' + c_Allow_HDJG_OK + '''';
    else
      sCode := '';
    end;
    if sCode = '' then Exit;
    iAllowCode := LoginData.m_iAllowCode;
    sSqlData := 'Select F_iID,F_sCode from Set_AllowInfo where F_tiStatus = 1 and F_sCode in (%s) order by F_iID';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sCode],False);
    if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
    begin
      while not ADO_Rec.Eof do
      begin
        iAllowID := ADO_Rec.FieldByName('F_iID').AsInteger;
        sCode := ADO_Rec.FieldByName('F_sCode').AsString;
        if 1 shl iAllowID or iAllowCode = iAllowCode then
        begin
          if sCode = c_Allow_YS_YSDH then
          begin
            btn_ysdh.Enabled := True;
            btn_ysdh.Tag := c_Tag_MakeAllow;
          end else
          begin
            btn_ok.Enabled := True;
            btn_ok.Tag := c_Tag_MakeAllow;
          end;
        end else
        begin
          if sCode = c_Allow_YS_YSDH then
          begin
            btn_ysdh.Enabled := False;
            btn_ysdh.Tag := 0;
          end else
          begin
            btn_ok.Enabled := False;
            btn_ok.Tag := 0;
          end;
        end;
        ADO_Rec.Next;
      end;
    end;
    if Assigned(ADO_Rec) then
      ADO_Rec.Free;
  end;
  Result := True;
end;

procedure TFra_scgl.edt_bfjcClick(Sender: TObject);
var
  i, n, iApartID: Integer;
  iWorkID,iJTXXID,iGroupID,iSCZT: Integer;
  ADO_Rec: TADOQuery;
  sSqlData: string;
begin
  for i := 0 to lv_gdmx.Items.Count -1 do
  begin
    if lv_gdmx.Items[i].Checked then
      Break;
  end;
  if (i = lv_gdmx.Items.Count) or (lv_gdmx.Items.Count =0) then
  begin
    Application.MessageBox('请选择至少一项进行部分发货!','提示',MB_ICONINFORMATION);
    Exit;
  end;
  Frm_SCGL_BFJC := TFrm_SCGL_BFJC.Create(Self);
  with Frm_SCGL_BFJC do
  begin
    stg_BFJC.Clear;
    n := 1;
    for i := 0 to lv_gdmx.Items.Count -1 do
    begin
      if lv_gdmx.Items[i].Checked then
      begin
        if n > 1 then
          stg_BFJC.RowCount := stg_BFJC.RowCount + 1;
        stg_BFJC.Cells[c_BFJC_CPBH,n] := lv_gdmx.Items[i].SubItems.Strings[c_GDMX_CPBH];
        stg_BFJC.Cells[c_BFJC_KDYL,n] := FloatToStr(StrToFloatDef(lv_gdmx.Items[i].SubItems.Strings[c_GDMX_BCYL],0.000)*10000);
        stg_BFJC.Cells[c_BFJC_WJCYL,n] := FloatToStr(StrToFloatDef(lv_gdmx.Items[i].SubItems.Strings[c_GDMX_WJCYL],0.000)*10000);
        stg_BFJC.Cells[c_BFJC_BCJCYL,n] := FloatToStr(StrToFloatDef(lv_gdmx.Items[i].SubItems.Strings[c_GDMX_WJCYL],0.000)*10000);
        stg_BFJC.Cells[c_BFJC_DetailsID,n] := lv_gdmx.Items[i].SubItems.Strings[c_GDMX_DetailsID];
        Inc(n);
      end;
    end;
  end;
  for i := 0 to lv_gd.Items.Count -1 do
  begin
    if lv_gd.Items[i].Checked then
    begin
      iWorkID := StrToNum(lv_gd.Items[i].SubItems[c_F_iID]);
      iGroupID := StrToNum(lv_gd.Items[i].SubItems[c_GroupID]);
      iJTXXID := StrToNum(lv_gd.Items[i].SubItems[c_JTXXID]);
    end;
  end;
  Frm_SCGL_BFJC.vWorkID := iWorkID;
  Frm_SCGL_BFJC.vJTXXID := iJTXXID;
  Frm_SCGL_BFJC.ShowModal;
  if Frm_SCGL_BFJC.vSuccess then
  begin
    if iWorkID > 0 then
    begin
      try
        iSCZT := cbb_sczt.ItemIndex;
        //sSqlData := 'Select * from DO_WorkOrderPrtProc where F_iWorkID = %d and F_iSCZT=%d';
        sSqlData := 'Select * from DO_WorkOrderDetails where F_iWorkID = %d and F_iGroupID=%d and F_iSCZT = %d';
        ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iWorkID,iGroupID,iSCZT],False);
        if (Assigned(ADO_Rec)) and (ADO_Rec.RecordCount > 0) then
          ReadDataGDMX(ADO_Rec)
        else
          lv_gdmx.Clear;
      finally
        ADO_Rec.Free;
      end;
    end;
  end;

  Frm_SCGL_BFJC.Free;
end;

end.


