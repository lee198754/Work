unit uFra_DataArchiving;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DBGridEhGrouping, GridsEh, DBGridEh, RzButton, ComCtrls, RzDTP,
  StdCtrls, ExtCtrls, RzPanel,ADODB, Menus, iLabel;

type
  TProgress=class(TThread)
  private
    g_MaxID: Integer;
    Con_Progress: TADOConnection;
    procedure  p_Progress;    //进度
  protected
    procedure   Execute;override;
  end;

  TFra_DataArchiving = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    dtp_wgq: TRzDateTimePicker;
    dtp_wgz: TRzDateTimePicker;
    btn_cx: TRzButton;
    btn_Archiving: TRzButton;
    gb_dd: TRzGroupBox;
    dbg_ddxx: TDBGridEh;
    pan_data: TPanel;
    lab_up: TLabel;
    lab_down: TLabel;
    lab_ts50: TLabel;
    lab_first: TLabel;
    lab_last: TLabel;
    Label3: TLabel;
    lab_zys: TLabel;
    lab_ts100: TLabel;
    lab_ts200: TLabel;
    lab_ts500: TLabel;
    Label6: TLabel;
    lab_tsQB: TLabel;
    lab_ts15: TLabel;
    lab_ts20: TLabel;
    edt_ys: TEdit;
    btn_go: TButton;
    pm_ddxx: TPopupMenu;
    menu_ddmx: TMenuItem;
    menu_ddmxPic: TMenuItem;
    N2: TMenuItem;
    menu_ztmx: TMenuItem;
    menu_fhmx: TMenuItem;
    Button1: TButton;
    procedure btn_cxClick(Sender: TObject);
    procedure btn_ArchivingClick(Sender: TObject);
    procedure lab_ts50Click(Sender: TObject);
    procedure lab_firstClick(Sender: TObject);
    procedure btn_goClick(Sender: TObject);
    procedure dbg_ddxxCellClick(Column: TColumnEh);
    procedure menu_ddmxClick(Sender: TObject);
    procedure menu_ztmxClick(Sender: TObject);
    procedure menu_fhmxClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    vMYTS: Integer;     //当前每页条数
    vYs: integer;       //当前页数
    vSqlData: string;
    procedure GDHClick;
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

uses
  uDM_DataBase, uPub_Func, PubStr, uWorkOrder, uFrm_GDH_XZ, uDDMX_DZX,
  uDDMX_XSX, uFrm_ZTMX, uFrm_FHMX, uPub_Text, uFrm_DataArcProgress,DateUtils;

{$R *.dfm}

var
  vdWGTime1, vdWGTime2: TDateTime;

procedure TFra_DataArchiving.btn_cxClick(Sender: TObject);
var
  sWgq,sWgz, sSqlData: string;
  iCplb,iXPL,iOrderType: integer;
  iMYTS, iYS, n: Integer;
begin
  Screen.Cursor := crHourGlass;
  sWgq := FormatDateTime('yyyyMMdd',dtp_wgq.DateTime)+' 00:00:00';
  sWgz := FormatDateTime('yyyyMMdd',dtp_wgz.DateTime)+' 23:59:59';
  iYS := 1;
  vYs := iYS;
  edt_ys.Text := IntToStr(iYs);
  if vMYTS = 0 then
  begin
    vMYTS := 20;
    lab_ts20.Font.Color :=  clBlack;
    lab_ts20.Font.Size := 10;
    lab_ts20.Font.Style := [fsBold];
    lab_ts20.Cursor := crDefault;
  end;
  iMYTS := vMYTS;
  sSqlData := Format('Exec p_DataArchiving_Select ''%s'',''%s'',%d,%d',
    [sWgq,sWgz,iYS,iMYTS]);

  try
    DM_DataBase.ADO_DataArchiving.Close;
    DM_DataBase.ADO_DataArchiving.SQL.Text :=  sSqlData;
    DM_DataBase.ADO_DataArchiving.Open;
    vSqlData := Format('Exec p_DataArchiving_Select ''%s'',''%s'',%s,%s',[sWgq,sWgz,'%d','%d']);
    n := 0;
    if DM_DataBase.ADO_DataArchiving.RecordCount > 0 then
    begin
      n := DM_DataBase.ADO_DataArchiving.FieldByName('Count').AsInteger;
  //  n := DM_DataBase.ADO_DataRec.RecordCount;
    end;
    gb_dd.Caption := '未完成订单  总数:'+IntToStr(n)+'条';
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);
  except
    on E: Exception do
    begin
      p_MessageBoxDlg('错误：'+E.message);
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TFra_DataArchiving.FraShow;
begin
  if FormatDateTime('hh:mm:ss',dtp_wgq.Time) = '00:00:00' then
  begin
    dtp_wgq.DateTime := Now;
    dtp_wgz.DateTime := Now;
  end;

end;

procedure TFra_DataArchiving.btn_ArchivingClick(Sender: TObject);
var
  sWgq,sWgz, sSqlData: string;
  time: TDateTime;
  time1,time2: string;
  i,n,iCount: integer;
  ADO_Rec: TADOQuery;
begin
  sWgq := FormatDateTime('yyyyMMdd',dtp_wgq.DateTime)+' 00:00:00';
  sWgz := FormatDateTime('yyyyMMdd',dtp_wgz.DateTime)+' 23:59:59';
  if p_MessageBoxDlg('是否确认归档 '+sWgq+' - '+sWgz+' 日期之间完工订单有关数据?','提示',MB_ICONINFORMATION + MB_YESNO) = IDYES then
  begin
    vdWGTime1 := dtp_wgq.DateTime;
    vdWGTime2 := dtp_wgz.DateTime;
    Frm_DataArcProgress := TFrm_DataArcProgress.Create(Self);
    TProgress.Create(False);
    //Frm_DataArcProgress.ShowModal;
    //Frm_DataArcProgress.Free;

//    Screen.Cursor := crHourGlass;
//    try
//      DM_DataBase.Con_YDPrint.BeginTrans;
//      sSqlData := 'Exec p_DataArchiving ''%s'',''%s'' ';
//      iCount := MonthsBetween(dtp_wgq.DateTime,dtp_wgz.DateTime);
//      time := dtp_wgq.DateTime;
//      n := 0;
//      for i := 0 to iCount do
//      begin
//        time1 := FormatDateTime('yyyyMMdd 00:00:00',time);
//        time := IncMonth(time,1);
//        time2 :=  FormatDateTime('yyyyMMdd 00:00:00',time);
//        if i = iCount then time2 :=  FormatDateTime('yyyyMMdd 23:59:59',dtp_wgz.DateTime);
//        DM_DataBase.ExecQuery(sSqlData,[time1,time2],True);
////        ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[time1,time2],True);
////        if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
////        begin
////
////        end;
////        ShowMessage(time1 + ' ' + time2);
//      end;

//      iCount :=DaysBetween(dtp_wgq.DateTime,dtp_wgz.DateTime);
//      time := dtp_wgq.DateTime;
//      n := 0;
//      i := 0;
//      while i<iCount do
//      begin
//        time1 := FormatDateTime('yyyyMMdd 00:00:00',time);
//        Inc(i,10);
//        if i < iCount then
//        begin
//          time := IncDay(time,10);
//          time2 :=  FormatDateTime('yyyyMMdd 00:00:00',time);
//        end else
//          time2 := FormatDateTime('yyyyMMdd 23:59:59',dtp_wgz.DateTime);
//        DM_DataBase.ExecQuery(sSqlData,[time1,time2],True);
//        //ShowMessage(time1 + ' ' + time2);
//      end;
//      DM_DataBase.Con_YDPrint.CommitTrans;
//      p_MessageBoxDlg(' '+sWgq+' - '+sWgz+' 日期之间完工订单有关数据归档成功!');
//    except
//      on E: Exception do
//      begin
//        //DM_DataBase.Con_YDPrint.RollbackTrans;
//        p_MessageBoxDlg('错误：'+E.message);
//      end;
//    end;
//    Screen.Cursor := crDefault;
  end;
end;

procedure TFra_DataArchiving.lab_ts50Click(Sender: TObject);
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
  DM_DataBase.ADO_DataArchiving.Close;
  sSqlData := Format(vSqlData,[1,vMYTS]);
  DM_DataBase.ADO_DataArchiving.SQL.Text :=  sSqlData;
  DM_DataBase.ADO_DataArchiving.Open;
  LabFontClear(lab_ts15);
  LabFontClear(lab_ts20);
  //LabFontClear(lab_ts50);
  //LabFontClear(lab_ts100);
  LabFontClear(lab_ts200);
  LabFontClear(lab_ts500);
  LabFontClear(lab_tsQB);
  TLabel(Sender).Font.Color :=  clBlack;
  TLabel(Sender).Font.Size := 10;
  TLabel(Sender).Font.Style := [fsBold];
  TLabel(Sender).Cursor := crDefault;
  vYs := 1;
  edt_ys.Text := '1';
  if DM_DataBase.ADO_DataArchiving.RecordCount > 0 then
  begin
    n := DM_DataBase.ADO_DataArchiving.FieldByName('Count').AsInteger;
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);
  end;
end;

procedure TFra_DataArchiving.lab_firstClick(Sender: TObject);
begin
  if TLabel(Sender).Name = 'lab_first' then
  begin
    if vYs = 1 then Exit;
    edt_ys.Text := '1';
    btn_go.Click;
  end else
  if TLabel(Sender).Name = 'lab_up' then
  begin
    if vYs > 1 then
    begin
      edt_ys.Text := IntToStr(vYs -1);
      btn_go.Click;
    end;

  end else
  if TLabel(Sender).Name = 'lab_down' then
  begin
    if vYs < lab_zys.Tag then
    begin
      edt_ys.Text := IntToStr(vYs +1);
      btn_go.Click;
    end;

  end else
  if TLabel(Sender).Name = 'lab_last' then
  begin
    if vYs = lab_zys.Tag then Exit;
    edt_ys.Text := IntToStr(lab_zys.Tag);
    btn_go.Click;
  end;

end;

procedure TFra_DataArchiving.btn_goClick(Sender: TObject);
var
  iYs,n: Integer;
  sSqlData: string;
begin
  Screen.Cursor := crHourGlass;
  iYs := StrToNum(edt_ys.Text);
  try
    DM_DataBase.ADO_DataArchiving.Close;
    sSqlData := Format(vSqlData,[iYs,vMYTS]);
    DM_DataBase.ADO_DataArchiving.SQL.Text :=  sSqlData;
    DM_DataBase.ADO_DataArchiving.Open;
    if DM_DataBase.ADO_DataArchiving.RecordCount > 0 then
    begin
      n := DM_DataBase.ADO_DataArchiving.FieldByName('Count').AsInteger;
      lab_zys.Tag := n div vMYTS;
      if n mod vMYTS > 0 then
        lab_zys.Tag := lab_zys.Tag +1;
      vYs := iYs;
      lab_zys.Caption := '页次：'+IntToStr(iYs)+'/'+ IntToStr(lab_zys.Tag);
    end;
  except
    on E: Exception do
    begin
      p_MessageBoxDlg('错误：'+E.message);
    end;

  end;          
  Screen.Cursor := crDefault;
end;

procedure TFra_DataArchiving.dbg_ddxxCellClick(Column: TColumnEh);
begin
  if Column.FieldName = 'GDH' then
  begin
    GDHClick;
  end;

end;

procedure TFra_DataArchiving.GDHClick;
var
  ADO_Rec: TADOQuery;
  i, n, iOrderType, iApartID, iWorkID, iGroupID: Integer;
  sGDH, sSqlData: string;
begin
  if not DM_DataBase.ADO_DataArchiving.Active then Exit;
  sGDH := Trim(DM_DataBase.ADO_DataArchiving.FieldByName('GDH').AsString);
  iApartID := DM_DataBase.ADO_DataArchiving.FieldByName('ApartID').AsInteger;
  if sGDH = '' then Exit;
  Screen.Cursor := crHourGlass;
  if Pos(',',sGDH) > 0 then
  begin
    Frm_GDH_XZ := TFrm_GDH_XZ.Create(Self);
    Frm_GDH_XZ.rg_gdh.Items.Clear;
    for i := 0 to PosNum(sGDH,',') do
    begin
      Frm_GDH_XZ.rg_gdh.Items.Add(PosCopy(sGDH,',',i+1));
    end;
    Frm_GDH_XZ.rg_gdh.ItemIndex := 0;
    if Frm_GDH_XZ.ShowModal <> mrok then
    begin
      Frm_GDH_XZ.Free;
      Screen.Cursor := crDefault;
      Exit;
    end else
    begin
      sGDH := Frm_GDH_XZ.rg_gdh.Items.Strings[Frm_GDH_XZ.rg_gdh.ItemIndex];
      Frm_GDH_XZ.Free;
    end;
  end;
  sSqlData := 'select b.F_iWorkID,b.F_iGroupID from DO_WorkOrder a,DO_WorkOrderDetails b where a.F_sGDH=''%s'' and b.F_iApartID=%d and a.F_iID=b.F_iWorkID  ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sGDH,iApartID],False);
  if ADO_Rec.RecordCount > 0 then
  begin
    iWorkID := ADO_Rec.FieldByName('F_iWorkID').AsInteger;
    iGroupID := ADO_Rec.FieldByName('F_iGroupID').AsInteger;
    Frm_WorkOrder := TFrm_WorkOrder.Create(Self);
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
      Frm_WorkOrder.btn_cx.Caption := '撤消';
    end;
    Frm_WorkOrder.Free;

  end;
  Screen.Cursor := crDefault;
end;

procedure TFra_DataArchiving.menu_ddmxClick(Sender: TObject);
var
  SelItem: TListItem;
  iType,iOrderID: integer;
begin
  if not DM_DataBase.ADO_DataRec.Active then Exit;
  if DM_DataBase.mte_DataRec.FieldByName('OrderID').IsNull then
  begin
    Application.MessageBox('请选择订单!','提示',MB_ICONINFORMATION);
  end;
  iOrderID := DM_DataBase.mte_DataRec.FieldByName('OrderID').AsInteger;

  iType := DM_DataBase.mte_DataRec.FieldByName('OrderType').AsInteger;
  
  case iType of
    0:
      begin
        if TMenuItem(Sender).Name = 'menu_ddmxPic' then
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

procedure TFra_DataArchiving.menu_ztmxClick(Sender: TObject);
var
  i,iApartID: integer;
begin
  if not DM_DataBase.ADO_DataRec.Active then Exit;
  iApartID := DM_DataBase.mte_DataRec.FieldByName('ApartID').AsInteger;
  if iApartID <= 0 then
  begin
    Application.MessageBox('请选择订单!','提示',MB_ICONINFORMATION);
    Exit;
  end;
  Frm_ZTMX := TFrm_ZTMX.Create(Self);
  Frm_ZTMX.p_ShowWindow([iApartID]);
end;

procedure TFra_DataArchiving.menu_fhmxClick(Sender: TObject);
var
  i,iApartID,iOrderID,iOrderType: integer;
begin
  if not DM_DataBase.ADO_DataRec.Active then Exit;
  iApartID := DM_DataBase.mte_DataRec.FieldByName('ApartID').AsInteger;
  iOrderID := DM_DataBase.mte_DataRec.FieldByName('OrderID').AsInteger;
  iOrderType := DM_DataBase.mte_DataRec.FieldByName('OrderType').AsInteger;
  if iApartID <= 0 then
  begin
    Application.MessageBox('请选择订单!','提示',MB_ICONINFORMATION);
    Exit;
  end;
  Frm_FHMX := TFrm_FHMX.Create(Self);
  Frm_FHMX.p_ShowWindow([iApartID,iOrderID,iOrderType]);

end;

procedure TFra_DataArchiving.Button1Click(Sender: TObject);
var
  i, iCount: integer;
  time: TDateTime;
  time1,time2: string;
begin
//  iCount := MonthsBetween(dtp_wgq.DateTime,dtp_wgz.DateTime);
//  ShowMessage(IntToStr(iCount));
//  time := dtp_wgq.DateTime;
//  for i := 0 to iCount do
//  begin
//    time1 := FormatDateTime('yyyyMMdd 00:00:00',time);
//    time := IncMonth(time,1);
//    time2 :=  FormatDateTime('yyyyMMdd 00:00:00',time);
//    if i = iCount then time2 :=  FormatDateTime('yyyyMMdd 23:59:59',dtp_wgz.DateTime);
//    ShowMessage(time1 + ' ' + time2);
//  end;
    vdWGTime1 := dtp_wgq.DateTime;
    vdWGTime2 := dtp_wgz.DateTime;
    Frm_DataArcProgress := TFrm_DataArcProgress.Create(Self);
    TProgress.Create(False);
    Frm_DataArcProgress.ShowModal;
    Frm_DataArcProgress.Free;

  //exit;
  DM_DataBase.Con_YDPrint.BeginTrans;
  for i := 0 to 5 do
    DM_DataBase.ExecQuery('WAITFOR DELAY ''00:00:10'' ',[]);
  DM_DataBase.Con_YDPrint.CommitTrans;
  iCount := DaysBetween(dtp_wgq.DateTime,dtp_wgz.DateTime);
  ShowMessage(IntToStr(iCount));
  time := dtp_wgq.DateTime;
  i := 0;
  while i<iCount do
  begin
    time1 := FormatDateTime('yyyyMMdd 00:00:00',time);
    inc(i,15);
    if i < iCount then
    begin
      time := IncDay(time,15);
      time2 :=  FormatDateTime('yyyyMMdd 00:00:00',time);
    end else
      time2 :=  FormatDateTime('yyyyMMdd 23:59:59',dtp_wgz.DateTime);
    ShowMessage(time1 + ' ' + time2);
  end;
//  Frm_DataArcProgress := TFrm_DataArcProgress.Create(Self);
//  Frm_DataArcProgress.ShowModal;
//  Frm_DataArcProgress.Free;
end;

{ TProgress }

procedure TProgress.Execute;
begin
  inherited;
  con_Progress := TADOConnection.Create(Application);
  con_Progress.Connected := False;
  con_Progress.Close;
  con_Progress.ConnectionString := DM_DataBase.vServicesConnect;
  con_Progress.LoginPrompt := False;
  con_Progress.Open;
  p_Progress;
end;

procedure TProgress.p_Progress;
var
  sSqlData, time1, time2, sWgq, sWgz: string;
  i, iCount: integer;
  time: TDateTime;
begin
    try
      sSqlData := 'Exec p_DataArchiving ''%s'',''%s'' ';
      sWgq := FormatDateTime('yyyyMMdd',vdWGTime1)+' 00:00:00';
      sWgz := FormatDateTime('yyyyMMdd',vdWGTime2)+' 23:59:59';
      iCount := MonthsBetween(vdWGTime1,vdWGTime2);
      time := vdWGTime1;
      Frm_DataArcProgress.ProgressBar1.Max := iCount+1;
      Frm_DataArcProgress.ProgressBar1.Position := 0;
      Frm_DataArcProgress.lab.Caption := '0%';
      Con_Progress.BeginTrans;
      for i := 0 to iCount do
      begin
        time1 := FormatDateTime('yyyyMMdd 00:00:00',time);
        time := IncMonth(time,1);
        time2 :=  FormatDateTime('yyyyMMdd 00:00:00',time);
        if i = iCount then time2 :=  FormatDateTime('yyyyMMdd 23:59:59',vdWGTime2);
        DM_DataBase.ExecQuery(sSqlData,[time1,time2],True,Con_Progress);
        if Assigned(Frm_DataArcProgress) then
        begin
          Frm_DataArcProgress.ProgressBar1.Position := i + 1;
          Frm_DataArcProgress.lab.Caption := IntToStr((i+1)*100 div (iCount+1))+'%';
          Sleep(1);
        end else
        begin
          Con_Progress.RollbackTrans;
          Exit;
        end;
      end;
      if Assigned(Frm_DataArcProgress) then
      begin
        Frm_DataArcProgress.lab.Caption := '100%';
        Frm_DataArcProgress.Close;
      end;
      Con_Progress.CommitTrans;
      p_MessageBoxDlg(' '+sWgq+' - '+sWgz+' 日期之间完工订单有关数据归档成功!');
    except
      on E: Exception do
      begin
        Con_Progress.RollbackTrans;
        p_MessageBoxDlg('错误：'+E.message);
      end;
    end;

end;

end.



