unit uPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, RzDTP, iComboBox,
  RzEdit, ButtonEdit, ADODB, RM_Dataset, RM_System,
  RM_Common, RM_Class, RzButton, RzRadChk, RM_AsBarView,
  RM_BarCode;

type
  TFrm_Print = class(TForm)
    rmr_Print: TRMReport;
    pan_gd: TPanel;
    Shape1: TShape;
    Shape22: TShape;
    Shape25: TShape;
    Shape68: TShape;
    sh_zd: TShape;
    Shape51: TShape;
    Shape21: TShape;
    Shape13: TShape;
    Shape12: TShape;
    Shape10: TShape;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Shape11: TShape;
    Label15: TLabel;
    Label16: TLabel;
    Shape14: TShape;
    Shape15: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Shape20: TShape;
    Shape23: TShape;
    Label17: TLabel;
    Label18: TLabel;
    Shape26: TShape;
    Label21: TLabel;
    Shape27: TShape;
    Shape28: TShape;
    Shape29: TShape;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Shape30: TShape;
    Label25: TLabel;
    Shape31: TShape;
    Shape32: TShape;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Shape33: TShape;
    Shape34: TShape;
    Shape35: TShape;
    Shape36: TShape;
    Shape37: TShape;
    Shape38: TShape;
    Shape39: TShape;
    Shape40: TShape;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    lab_HBST: TLabel;
    Shape41: TShape;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Shape42: TShape;
    Shape43: TShape;
    Shape44: TShape;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Shape45: TShape;
    Shape46: TShape;
    Shape47: TShape;
    Shape48: TShape;
    Label39: TLabel;
    Label40: TLabel;
    Shape49: TShape;
    Shape50: TShape;
    Label51: TLabel;
    Label52: TLabel;
    Shape57: TShape;
    Label19: TLabel;
    Label20: TLabel;
    Label53: TLabel;
    Shape52: TShape;
    Shape53: TShape;
    Shape69: TShape;
    Shape70: TShape;
    Shape71: TShape;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Shape60: TShape;
    Shape61: TShape;
    Shape62: TShape;
    Shape24: TShape;
    Shape55: TShape;
    lab_jbrq: TLabel;
    lab_ywrq: TLabel;
    lab_zwrq: TLabel;
    Shape56: TShape;
    Shape58: TShape;
    Shape59: TShape;
    Label32: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Shape54: TShape;
    Shape63: TShape;
    Shape64: TShape;
    Label41: TLabel;
    Shape65: TShape;
    Shape66: TShape;
    Label42: TLabel;
    Shape67: TShape;
    edt_hm: Ti_TxtFilter;
    edt_pm: Ti_TxtFilter;
    edt_gdh: Ti_TxtFilter;
    edt_jfqs: Ti_TxtFilter;
    edt_jfs: Ti_TxtFilter;
    edt_zzs: Ti_TxtFilter;
    edt_ls: Ti_TxtFilter;
    edt_zh: Ti_TxtFilter;
    edt_zbts: Ti_TxtFilter;
    edt_zbgb: Ti_TxtFilter;
    edt_zbxd: Ti_TxtFilter;
    edt_zbdy: Ti_TxtFilter;
    edt_zbpb: Ti_TxtFilter;
    edt_zbcp: Ti_TxtFilter;
    edt_bsts: Ti_TxtFilter;
    edt_dysbs: Ti_TxtFilter;
    edt_dylz: Ti_TxtFilter;
    edt_dysc: Ti_TxtFilter;
    edt_sbk: Ti_TxtFilter;
    mmo_dysb: TRzMemo;
    dtp_kdrq: TRzDateTimePicker;
    edt_zl: Ti_TxtFilter;
    edt_cpk: Ti_TxtFilter;
    edt_cpc: Ti_TxtFilter;
    edt_cjk: Ti_TxtFilter;
    edt_cjc: Ti_TxtFilter;
    cbb_zb: TComboBox;
    cbb_dyjb: TComboBox;
    cbb_gg: TComboBox;
    cbb_cpks: TComboBox;
    cbb_sblb: TComboBox;
    cbb_sbks: TComboBox;
    cbb_dylb: TComboBox;
    mmo_zbbz: TRzMemo;
    mmo_zd: TRzMemo;
    mmo_bz: TRzMemo;
    dtp_jhrq: TRzDateTimePicker;
    mmo_dybz: TRzMemo;
    edt_Tj: Ti_TxtFilter;
    edt_Zj: Ti_TxtFilter;
    edt_zbqt: Ti_TxtFilter;
    edt_dyqt: Ti_TxtFilter;
    edt_zhq: Ti_TxtFilter;
    edt_zhz: Ti_TxtFilter;
    RMDBDataSet1: TRMDBDataSet;
    lab_sczt: TLabel;
    cbb_Temp: TComboBox;
    btn_zd: TButton;
    btn_xg: TButton;
    btn_dy: TButton;
    btn_cx: TButton;
    btn_Close: TButton;
    cb_Cookie: TRzCheckBox;
    btn_ckdd: TButton;
    Panel1: TPanel;
    Button1: TButton;
    procedure btn_zdClick(Sender: TObject);
    procedure btn_cxClick(Sender: TObject);
    procedure btn_dyClick(Sender: TObject);
    procedure btn_xgClick(Sender: TObject);
    procedure lab_HBSTClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure edt_jfqsKeyPress(Sender: TObject; var Key: Char);
    procedure edt_jfqsExit(Sender: TObject);
    procedure edt_cpkKeyPress(Sender: TObject; var Key: Char);
    procedure edt_cpc1KeyPress(Sender: TObject; var Key: Char);
    procedure btn_ckddClick(Sender: TObject);
    procedure edt_hmExit(Sender: TObject);
    procedure edt_hmKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbb_TempCloseUp(Sender: TObject);
    procedure cbb_TempClick(Sender: TObject);
    procedure edt_zhqExit(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    vEdt: TEdit;
    procedure ClearValue;    //清空数据
    function FindOrderType(OrderID: integer): Integer; //查找订单类型
    procedure EdtDblClick(Sender: TObject);
    procedure EdtExit(Sender: TObject);
    procedure EdtShowCbbEvent;
  public
    { Public declarations }
    vWorkID: Integer; //工单ID
    vBSTID: Integer;  //版式图ID
    vBSTZS: Integer;   //版式图总数
    vActionType: Integer;   //操作类型(0:查询;1:修改2:开单)
//    procedure CreateFrame(khmc,cpbh,bz,dw,sl,zh,ApartID: string; Num:integer=0); //创建工单明细列表
    procedure EnableCom(bStatus: Boolean);
    procedure RecCookieALL;             //记录Cookie
//    procedure LoadCbbZB;         //初始化纸别
//    procedure LoadCbbJB;         //初始化机别
//    procedure LoadCbbGG;         //初始化规格
  end;

var
  Frm_Print: TFrm_Print;
//  vOrderType: integer;
  lab: array of TLabel;
  edt: array of Ti_TxtFilter;
  cbb: array of Ti_ComboBox;

implementation

{$R *.dfm}

uses
  uDM_DataBase, uHBST, uBSTPrint, PubStr, Registry, uFrm_GDFK, uFrm_zdgy,
  uPub_Type, uPub_Func;
{ TForm1 }

{procedure TFrm_Print.CreateFrame(khmc,cpbh,bz,dw,sl,zh,ApartID: string; Num: integer=0);
var
  iTop, iLeft: Integer;
  i,iCount: integer;
  shp: array [0..5] of TShape;
begin
  iTop := sh_khmc.Top+sh_khmc.Height -1 + 24*Num;
  iLeft := sh_khmc.Left;
  for i := 0 to 5 do
  begin
    shp[i] := TShape.Create(self);
    shp[i].Top := iTop;
    shp[i].Height := 25;
    shp[i].Parent := Self;
    shp[i].Visible := True;
  end;
  shp[0].Left := sh_khmc.Left;
  shp[0].Width := sh_khmc.Width;
  shp[1].Left := sh_cpmc.Left;
  shp[1].Width := sh_cpmc.Width;
  shp[2].Left := sh_sl.Left;
  shp[2].Width := sh_sl.Width;
  shp[3].Left := sh_dw.Left;
  shp[3].Width := sh_dw.Width;;
  shp[4].Left := sh_zh.Left;
  shp[4].Width := sh_zh.Width;
  shp[5].Left := sh_bz.Left;
  shp[5].Width := sh_bz.Width;
  iCount := Length(lab);
  SetLength(lab,iCount+2);
  for i := iCount to Length(lab)-1 do
  begin
    lab[i] := TLabel.Create(Self);
    lab[i].Top := iTop + 6;
    lab[i].Color := clCream;
    lab[i].Parent := Self;
    lab[i].Visible := True;
  end;
  lab[iCount].Left := sh_khmc.Left + 10;
  lab[iCount].Caption := khmc;
  lab[iCount+1].Left := sh_cpmc.Left+10;
  lab[iCount+1].Caption := cpbh;
  lab[iCount+1].Hint := ApartID;
  iCount := Length(edt);
  SetLength(edt,iCount+3);
  for i := iCount to Length(edt)-1 do
  begin
    edt[i] := Ti_TxtFilter.Create(Self);
    edt[i].Top := iTop + 2;
    edt[i].Parent := Self;
    edt[i].Visible := True;
  end;
  edt[iCount].Left := sh_bz.Left +10;
  edt[iCount].Width := sh_bz.Width-16;
  edt[iCount].Text := bz;
  edt[iCount+1].Left := sh_sl.Left +10;
  edt[iCount+1].Width := sh_sl.Width-16;
  edt[iCount+1].Text := sl;
  edt[iCount+2].Left := sh_zh.Left +10;
  edt[iCount+2].Width := sh_zh.Width-16;
  edt[iCount+2].Text := zh;
  iCount := Length(cbb);
  SetLength(cbb,iCount+1);
  for i := iCount to Length(cbb)-1 do
  begin
    cbb[i] := Ti_ComboBox.Create(Self);
    cbb[i].Parent := Self;
    cbb[i].Visible := True;
  end;
  cbb[iCount].Top := iTop + 2;
  cbb[iCount].Left := sh_dw.Left +10;
  cbb[iCount].Width := sh_dw.Width-16;
  cbb[iCount].Items.Add('请选择');
  cbb[iCount].Items.Add('万枚');
  cbb[iCount].ItemIndex:= 0;
  if dw <> '' then
    cbb[iCount].ItemIndex := StrToInt(dw);
  if iTop + 25 > pnl_final.Top then
  begin
    pnl_final.Top := iTop + 25;
   // Self.Height := Self.Height +  iTop + 25 - sh_zd.Top;
  end;
end;     }

procedure TFrm_Print.btn_zdClick(Sender: TObject);
var
  i, iOrderType, iSl: Integer;
  sHint,sWorkID,sValue,sID, sGDH: string;
  pstr: PChar;
  iProductTypeID,iXpl: Integer;
  sSqlData: string;
  iBsts: Integer;
begin
  if vBSTID = 0 then
  begin
    Application.MessageBox(PChar('请先画制版图!'),'提示',MB_ICONINFORMATION);
    Exit;
  end;

  DM_DataBase.GetMaxID('BI_WorkOrder','BK_GDH',sGDH);
  sGDH := 'CP-12BK-'+StrRight(sGDH,6);
  edt_gdh.Text := sGDH;
  edt_sbk.Text := StrToNum(edt_sbk.Text);
  if StrToNum(edt_jfqs.Text)+ StrToNum(edt_jfs.Text) >  High(Integer) then
  begin
   Application.MessageBox('加放前数与加放数之和超过可用范围!','提示',MB_ICONINFORMATION);
   exit;
  end;
  edt_zzs.Text := StrToNum(edt_jfqs.Text)+ StrToNum(edt_jfs.Text);
  edt_ls.Text := StrToNum(edt_zzs.Text) / 500;
  iBsts :=StrToNum(edt_bsts.Text);
  iSl := 0;
  for i := 0 to Length(OrderData) -1 do
  begin
    OrderData[i].m_sSl := Format('%6.2f',[OrderData[i].m_iBSTS*iBsts /10000]);
    OrderData[i].m_sDw := 1;
    iSl := iSl + OrderData[i].m_iBSTS*iBsts;
  end;
  if iSl <> StrToNum(edt_zl.Text) then
  begin
    pstr := '所画的版式图中需要的总印量与此工单的总量不符,是否继续些操作?';
//    Application.MessageBox(pstr,'提示',MB_ICONINFORMATION);
    if Application.MessageBox(pstr,'提示',MB_YESNO+MB_ICONINFORMATION) = IDNO then
      Exit;
  end;
  if not DM_DataBase.GetTableData(DM_DataBase.ADO_MOD,'BI_WorkOrder','1=2') then
    Exit;
  DM_DataBase.Con_YDPrint.BeginTrans;
  try
    with DM_DataBase.ADO_MOD do
    begin
      Insert;
//      DM_DataBase.GetMaxID('BI_WorkOrder','F_iID',sWorkID,1);
      sSqlData := 'Select F_iProductTypeID from DO_OrderApart a,Set_PostageType b where CHARINDEX(b.F_sYZTMC,a.F_sYztmc)=1 and a.F_iID='+IntToStr(OrderData[0].m_iApartID);
      iProductTypeID := StrToNum(DM_DataBase.GetTableFirst(sSqlData));
      if OrderData[0].m_iType = 0 then
        sSqlData := Format('Select b.F_tiXpl from DO_OrderApart a,BI_CustomOrderDetails b,BI_CustomOrder c '
          +'where a.F_tiOrderType=0 and a.F_iOrderID=b.F_iID and b.F_iCustomID=c.F_iID and a.F_iID=%d',[OrderData[0].m_iApartID]);
      if OrderData[0].m_iType = 1 then
        sSqlData := Format('Select b.F_tiXpl from DO_OrderApart a,BI_SellOrderDetails b,BI_SellOrder c '
          +'where a.F_tiOrderType=1 and a.F_iOrderID=b.F_iID and b.F_iSellID=c.F_iID and a.F_iID=%d',[OrderData[0].m_iApartID]);
      iXpl := StrToNum(DM_DataBase.GetTableFirst(sSqlData));
  //    iWorkID := DM_DataBase.GetMaxID('select IsNull(max(F_iID),0) from BI_WorkOrder') + 1;
//      FieldByName('F_iID').AsInteger := StrToInt(sWorkID);
      for i := 0 to Self.ComponentCount -1 do
      begin
        sValue := '';
        if (Self.Components[i] is Ti_TxtFilter) or (Self.Components[i] is Ti_ComboBox) or (Self.Components[i] is TComboBox) or (Self.Components[i] is TRzDateTimePicker)
          or (Self.Components[i] is TRzMemo) then
        begin
          sHint := TControl(Self.Components[i]).Hint;
          if (Copy(sHint,1,2) = 'F_') and (Self.Components[i].Tag <> 10) then //and (TControl(Self.Components[i]).Enabled)
          begin
            if Self.Components[i] is TRzDateTimePicker then
            begin
              if TRzDateTimePicker(Self.Components[i]).Enabled then
                FieldByName(sHint).AsDateTime := TRzDateTimePicker(Self.Components[i]).DateTime;
              Continue;
            end;
            if (Self.Components[i] is Ti_ComboBox) or (Self.Components[i] is TComboBox) then
              sValue := Ti_ComboBox(Self.Components[i]).Text
            else
              sValue := TEdit(Self.Components[i]).Text;
  //          if sValue <> '' then
              FieldByName(sHint).AsString := sValue;
          end;
        end;
      end;
      FieldByName('F_iProductTypeID').AsInteger := iProductTypeID;
      FieldByName('F_tiXpl').AsInteger := iXpl;
      FieldByName('F_sKdr').AsString := LoginData.m_sUserName;
      FieldByName('F_iBSTID').AsInteger := vBSTID;
      Post;
      sWorkID := FieldByName('F_iID').AsString;
      iBsts :=StrToNum(edt_bsts.Text);
      for i := 0 to Length(OrderData) -1 do
      begin
        OrderData[i].m_sSl := Format('%6.2f',[OrderData[i].m_iBSTS*iBsts /10000]);
        OrderData[i].m_sDw := 1;
      end;
      if DM_DataBase.GetTableData(DM_DataBase.ADO_MOD,'BI_WorkOrderDetails','1=2') then
      begin
        //DM_DataBase.GetMaxID('BI_WorkOrderDetails','F_iID',sID,1,Length(OrderData));
        for i := 0 to Length(OrderData)-1 do
        begin
          Insert;
          iOrderType := OrderData[i].m_iType;
          //FieldByName('F_iID').AsInteger := StrToInt(sID)+i;
          FieldByName('F_tiOrderType').AsInteger := iOrderType;
          FieldByName('F_sKhmc').AsString := OrderData[i].m_sKhmc;
          FieldByName('F_sCpbh').AsString := OrderData[i].m_sCPBH;
          FieldByName('F_iApartID').AsInteger := OrderData[i].m_iApartID;
//          FieldByName('F_sBz').AsString := edt[3*i+0].Text;
          FieldByName('F_sDw').AsInteger := OrderData[i].m_sDw;
          FieldByName('F_sSl').AsString := OrderData[i].m_sSl;
//          FieldByName('F_sZh').AsString := edt[3*i+2].Text;
          FieldByName('F_iWorkID').AsInteger := StrToInt(sWorkID);
        end;
        if Length(OrderData) > 0 then
          Post;
        sSqlData := ' if not exists(Select 1 from DO_ProductDate_Log where F_iWorkID = %s) ' ;
        sSqlData := sSqlData + 'Insert into DO_ProductDate_Log (F_iWorkID) VALUES (%s)';
        DM_DataBase.ExecQuery(sSqlData,[sWorkID,sWorkID],True);

        Application.MessageBox('制单成功','提示',MB_ICONINFORMATION);
        vWorkID := StrToInt(sWorkID);
  //      EnableCom(False);
        btn_zd.Enabled := False;
        btn_xg.Enabled := True;
        btn_dy.Enabled := True;
        btn_cx.Enabled := True;
      end;
    end;
    DM_DataBase.Con_YDPrint.CommitTrans;
  except
    on E: Exception do
    begin
      DM_DataBase.Con_YDPrint.RollbackTrans;
      Application.MessageBox(PChar('制单失败,'+e.Message),'提示',MB_ICONINFORMATION);
      Exit;
    end;
  end;

end;



procedure TFrm_Print.ClearValue;
var
  i: Integer;
begin
  for i := 0 to Self.ComponentCount -1 do
  begin
    if Self.Components[i] is TRzDateTimePicker then
      TRzDateTimePicker(Self.Components[i]).DateTime := Now
    else
    if (Self.Components[i] is Ti_ComboBox) or (Self.Components[i] is TComboBox) then
      Ti_ComboBox(Self.Components[i]).ItemIndex := 0
    else
    if (Self.Components[i] is Ti_TxtFilter) or (Self.Components[i] is TRzMemo) then
      TEdit(Self.Components[i]).Text := '';
  end;
end;

procedure TFrm_Print.EnableCom(bStatus: Boolean);
var
  i: Integer;
begin
  for i:= 0 to Self.ComponentCount -1 do
  begin
    if Self.Components[i].Tag <> 10 then
      TWinControl(Self.Components[i]).Enabled := bStatus;
  end;
end;

procedure TFrm_Print.btn_cxClick(Sender: TObject);
var
  iWorkID: Integer;
  iSczt,iRec: integer;
  sSczt,sSqlData: string;
  ADO_Rec: TADOQuery;
begin
  iWorkID := vWorkID;
  if iWorkID = -1 then
  begin
    Application.MessageBox(PChar('数据不存在!不能'+btn_cx.Caption+'!'),'提示',MB_ICONINFORMATION);
    Exit;
  end;

  if btn_cx.Caption = '撤消' then
  begin
    //已制版后不执行 ( 撤单暂不做此限制)
    iSczt := DM_DataBase.GetMaxID('Select F_iSczt from BI_WorkOrder where F_iID='+IntToStr(iWorkID));
    if iSczt >4 then
    begin
      case iSczt of
      0: sSczt:='已开单';
      1: sSczt:='已制版';
      2: sSczt:='已印刷';
      3: sSczt:='已打号';
      4: sSczt:='已后道加工';
      5: sSczt:='已进仓';
      6: sSczt:='已发货';
      end;
      Application.MessageBox(PChar('工单'+sSczt+',不能撤消!'),'提示',MB_ICONINFORMATION);
      Exit;
    end;  

    if Application.MessageBox('是否撤消此工单?','提示',MB_YESNO + MB_ICONINFORMATION)=ID_NO then exit;
{    with DM_DataBase.ADO_DataRec do          //删除工单
    begin
      Close;
      SQL.Clear;
      SQL.Add('Update BI_WorkOrder Set F_tiCXBZ=1 where F_iID=' +inttostr(iWorkID));
  //    SQL.Add('delete BI_WorkOrder where F_iID=' +inttostr(iWorkID));
  //    SQL.Add(' delete BI_WorkOrderDetails where F_iWorkID='+ inttostr(iWorkID));
  //    SQL.Add(' delete DO_WorkOrderMKPic where F_iID='+ inttostr(vBSTID));
  //    SQL.Add(' delete DO_WorkOrderMKPicPrt where F_iBSTID='+ inttostr(vBSTID));
      ExecSQL;
    end; }
    sSqlData := 'Update BI_WorkOrder Set F_tiCXBZ=1 where F_iID=' +inttostr(iWorkID);
    if DM_DataBase.UpdateTable(sSqlData) then
    begin
      Application.MessageBox('撤消成功!','提示',MB_ICONINFORMATION);
      btn_cx.Caption := '恢复';
//      vWorkID := 0;
//      vBSTID := 0;
//      lab_HBST.Caption := '画版式图';
//      EnableCom(True);
//      btn_xg.Enabled := False;
//      btn_dy.Enabled := False;
//      btn_cx.Enabled := False;
    end;
  end else
  if btn_cx.Caption = '恢复' then
  begin
    if Application.MessageBox('是否恢复此工单?','提示',MB_YESNO + MB_ICONINFORMATION)=ID_NO then exit;
    try
      sSqlData := 'exec p_hfpd_old %d';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iWorkID]);
      if ADO_Rec.RecordCount > 0  then
      begin
        Application.MessageBox('此工单中的订单已被别的工单开过!不能恢复!','提示',MB_ICONINFORMATION);
        Exit;
      end;
      sSqlData := 'Update BI_WorkOrder Set F_tiCXBZ=0 where F_iID=' +inttostr(iWorkID);
      if DM_DataBase.UpdateTable(sSqlData) then
      begin
        Application.MessageBox('恢复成功!','提示',MB_ICONINFORMATION);
        btn_cx.Caption := '撤消';
      end;
    finally
      ADO_Rec.Free;
    end;
  end;
end;

procedure TFrm_Print.btn_dyClick(Sender: TObject);
var
  sSqlData: string;
begin
  with DM_DataBase.ADO_Print do
  begin
    Close;
    sSqlData := 'select *,CPLX=(select F_sTypeName from Set_ProductType where F_iID=a.F_iProductTypeID) from BI_WorkOrder a where a.F_iID=%d';
    SQL.Text := Format(sSqlData,[vWorkID]) ;
    Open;
  end;
  rmr_Print.PrepareReport;
  rmr_Print.ShowReport;
end;

procedure TFrm_Print.btn_xgClick(Sender: TObject);
var
  SqlData,sSczt,sID: string;
  sValue,sHint: string;
  i,iWorkID,iSczt,iOrderType,iSl,iCPLX: Integer;
  sSqlData: string;
  iBsts: Integer;
  pstr: PChar;
  ADO_Rec: TADOQuery;
begin
  iWorkID := vWorkID;
  if iWorkID = -1 then
  begin
    Application.MessageBox(PChar('数据不存在!'),'提示',MB_ICONINFORMATION);
    Exit;
  end;
  //已制版后不执行
//  iSczt := DM_DataBase.GetMaxID('Select F_iSczt from BI_WorkOrder where F_iID='+IntToStr(iWorkID));
  sSqlData := 'Select a.F_iSczt,IsNull(b.F_iID,0) CPLX from BI_WorkOrder a left join Set_ProductType b on a.F_iProductTypeID=b.F_iID where a.F_iID=%d';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iWorkID]);
  if ADO_Rec.RecordCount > 0 then
  begin
    iCPLX := ADO_Rec.FieldByName('CPLX').AsInteger;
    iSczt := ADO_Rec.FieldByName('F_iSczt').AsInteger;
    if (iCPLX = 5) and (iSczt =4 ) then
      iSczt := 2;
  end else
  begin
    Application.MessageBox(PChar('数据出错,请重新进入此工单界面!'),'提示',MB_ICONINFORMATION);
    Exit
  end;
  ADO_Rec.Free;
  if iSczt >0 then
  begin
    case iSczt of
      0: sSczt:='已开单';
      1: sSczt:='已制版';
      2: sSczt:='已印刷';
      3: sSczt:='已打号';
      4: sSczt:='已后道加工';
      5: sSczt:='已进仓';
      6: sSczt:='已发货';
    end;
    Application.MessageBox(PChar('工单'+sSczt+',不能修改!'),'提示',MB_ICONINFORMATION);
    Exit;
  end;
  if StrToNum(edt_jfqs.Text)+ StrToNum(edt_jfs.Text) >  High(Integer) then
  begin
   Application.MessageBox('加放前数与加放数之和超过可用范围!','提示',MB_ICONINFORMATION);
   exit;
  end;

  edt_zzs.Text := StrToNum(edt_jfqs.Text)+ StrToNum(edt_jfs.Text);
  edt_ls.Text := StrToNum(edt_zzs.Text) / 500;
  edt_sbk.Text := StrToNum(edt_sbk.Text);
  iSl := 0;
  iBsts :=StrToNum(edt_bsts.Text);
  for i := 0 to Length(OrderData) -1 do
  begin
    OrderData[i].m_sSl := Format('%6.2f',[OrderData[i].m_iBSTS*iBsts /10000]);
    OrderData[i].m_sDw := 1;
    iSl := iSl + OrderData[i].m_iBSTS*iBsts;
  end;
  if iSl <> StrToNum(edt_zl.Text) then
  begin
    pstr := '所画的版式图中需要的总印量与此工单的总量不符,请检查版式图是否正确!';
//    Application.MessageBox(pstr,'提示',MB_ICONINFORMATION);
    if Application.MessageBox(pstr,'提示',MB_YESNO+MB_ICONINFORMATION) = IDNO then
      Exit;
  end;

  if not DM_DataBase.GetTableData(DM_DataBase.ADO_MOD,'BI_WorkOrder','F_iID='+IntToStr(vWorkID)) then
    Exit;
  try
    with DM_DataBase.ADO_MOD do
    begin
      if RecordCount = 0 then
      begin
        Application.MessageBox(PChar('数据不存在!'),'提示',MB_ICONINFORMATION);
        Exit;
      end;
      DM_DataBase.Con_YDPrint.BeginTrans;
      Edit;
      for i := 0 to Self.ComponentCount -1 do
      begin
        sValue := '';
        if (Self.Components[i] is Ti_TxtFilter) or (Self.Components[i] is Ti_ComboBox) or (Self.Components[i] is TComboBox) or (Self.Components[i] is TRzDateTimePicker)
          or (Self.Components[i] is TRzMemo) then
        begin
          sHint := TControl(Self.Components[i]).Hint;
          if (Copy(sHint,1,2) = 'F_') and (Self.Components[i].Tag <> 10) then           //and (TControl(Self.Components[i]).Enabled)
          begin
            if Self.Components[i] is TRzDateTimePicker then
            begin
              FieldByName(sHint).AsDateTime := TRzDateTimePicker(Self.Components[i]).DateTime;
              Continue;
            end;
            if (Self.Components[i] is Ti_ComboBox) or (Self.Components[i] is TComboBox) then
              sValue := Ti_ComboBox(Self.Components[i]).Text
            else
              sValue := TEdit(Self.Components[i]).Text;
  //          if sValue <> '' then
              FieldByName(sHint).AsString := sValue;
          end;
        end;
      end;
      FieldByName('F_sXgr').AsString := LoginData.m_sUserName;
      Post;
      iBsts :=StrToNum(edt_bsts.Text);
      for i := 0 to Length(OrderData) -1 do
      begin
        OrderData[i].m_sSl := Format('%6.2f',[OrderData[i].m_iBSTS*iBsts /10000]);
        OrderData[i].m_sDw := 1;
      end;
      if DM_DataBase.GetTableData(DM_DataBase.ADO_MOD,'BI_WorkOrderDetails','F_iWorkID='+IntToStr(vWorkID)) then
      begin
        First;
        while not Eof do Delete;
        First;
        //DM_DataBase.GetMaxID('BI_WorkOrderDetails','F_iID',sID,1,Length(OrderData));
        for i := 0 to Length(OrderData)-1 do
        begin
          Insert;
          iOrderType := OrderData[i].m_iType;
          //FieldByName('F_iID').AsInteger := StrToInt(sID)+i;
          FieldByName('F_tiOrderType').AsInteger := iOrderType;
          FieldByName('F_sKhmc').AsString := OrderData[i].m_sKhmc;
          FieldByName('F_sCpbh').AsString := OrderData[i].m_sCPBH;
          FieldByName('F_iApartID').AsInteger := OrderData[i].m_iApartID;
  //          FieldByName('F_sBz').AsString := edt[3*i+0].Text;
          FieldByName('F_sDw').AsInteger := OrderData[i].m_sDw;
          FieldByName('F_sSl').AsString := OrderData[i].m_sSl;
  //          FieldByName('F_sZh').AsString := edt[3*i+2].Text;
          FieldByName('F_iWorkID').AsInteger := iWorkID;
        end;
        if Length(OrderData) > 0 then
          Post;
        sSqlData := ' if not exists(Select 1 from DO_ProductDate_Log where F_iWorkID = %d) ' ;
        sSqlData := sSqlData + 'Insert into DO_ProductDate_Log (F_iWorkID) VALUES (%d)';   
        DM_DataBase.ExecQuery(sSqlData,[vWorkID,vWorkID],True);
        Application.MessageBox('修改成功','提示',MB_ICONINFORMATION);
      end;
    end;
    DM_DataBase.Con_YDPrint.CommitTrans;
  except
    on E: Exception do
    begin
      DM_DataBase.Con_YDPrint.RollbackTrans;
      Application.MessageBox(PChar('修改失败,'+e.Message),'提示',MB_ICONINFORMATION);
      Exit;
    end;
  end;

end;

procedure TFrm_Print.lab_HBSTClick(Sender: TObject);
var
  AOD_Rec: TADOQuery;
  iBSTID: integer;
  sSqlData: string;
  sCplx,sYztmc: string;
begin
  if Length(OrderData) > 0 then
  begin
    sSqlData := 'Select b.F_sCplx,a.F_sYZTMC from DO_OrderApart a,Set_PostageType b where a.F_sYZTMC like b.F_sYZTMC+''%%'' and a.F_iID=%d ';
    AOD_Rec := DM_DataBase.OpenQuery(sSqlData,[OrderData[0].m_iApartID]);
    if AOD_Rec.RecordCount >0 then
    begin
      sCplx := AOD_Rec.FieldByName('F_sCplx').AsString;
      sYztmc := AOD_Rec.FieldByName('F_sYZTMC').AsString;
    end;
    AOD_Rec.Free;
  end;
  if (lab_HBST.Caption = '画版式图') and (vBSTID=0) then
  begin
{    Frm_HBST := TFrm_HBST.Create(Self);
    Frm_HBST.ShowModal;
    Frm_HBST.Free;  }
    vActionType := 1;
    Frm_BSTPrint := TFrm_BSTPrint.Create(Self);
    Frm_BSTPrint.vCplx := sCplx;
    Frm_BSTPrint.vYztmc := sYztmc;
    Frm_BSTPrint.ShowModal;
    Frm_BSTPrint.Free;

  end else
  if (lab_HBST.Caption = '打印版式图') or (vBSTID>0) then
  begin
    Frm_BSTPrint := TFrm_BSTPrint.Create(Self);
    Frm_BSTPrint.vCplx := sCplx;
    Frm_BSTPrint.vYztmc := sYztmc;
    if vBSTID > 0 then
      iBSTID := vBSTID
    else
      iBSTID := DM_DataBase.GetMaxID('Select F_iBSTID from BI_WorkOrder where F_iID='+IntToStr(vWorkID));
    try
      AOD_Rec := TADOQuery.Create(Self);
      DM_DataBase.GetTableData(AOD_Rec,'DO_WorkOrderMKPic','F_iID='+IntToStr(iBSTID));
      if AOD_Rec.RecordCount >0 then
      begin
        Frm_BSTPrint.vRow := AOD_Rec.FieldByName('F_iRow').AsInteger;
        Frm_BSTPrint.vCol := AOD_Rec.FieldByName('F_iCol').AsInteger;
        Frm_BSTPrint.mmo_bz.Text := AOD_Rec.FieldByName('F_sBZ').AsString;
        vBSTID := iBSTID;             
      end;
      while Frm_BSTPrint.ShowModal = mrNo do
      begin
        Frm_BSTPrint.Free;
        Frm_BSTPrint := TFrm_BSTPrint.Create(Self);
        Frm_BSTPrint.vCplx := sCplx;
        Frm_BSTPrint.vYztmc := sYztmc;
        Frm_HBST := TFrm_HBST.Create(Self);
        //Frm_HBST.ShowModal;
        if Frm_HBST.ShowModal <> mrok then
        begin
          Frm_HBST.Free;
          Break;
        end;
        Frm_HBST.Free;
      end;
      Frm_BSTPrint.Free;
    finally
      AOD_Rec.Free;
    end;
  end;
end;

procedure TFrm_Print.FormDestroy(Sender: TObject);
begin
  if vWorkID = 0 then
  begin
    DM_DataBase.UpdateTable('Delete DO_WorkOrderMKPic where F_iID='+IntToStr(vBSTID));
    DM_DataBase.UpdateTable('Delete DO_WorkOrderMKPicPrt where F_iBSTID='+IntToStr(vBSTID));
  end;                                    
//  if cb_Cookie.Checked then
//    RecCookieALL;
end;

function TFrm_Print.FindOrderType(OrderID: integer): Integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to Length(OrderData) -1 do
  begin
    if OrderData[i].m_iApartID = OrderID then
    begin
      Result := OrderData[i].m_iType;
      Break;
    end;
  end;
end;

procedure TFrm_Print.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrm_Print.FormShow(Sender: TObject);
var
  str: string;
  hRect: TRect;
begin
  if vActionType = 0 then
  begin
    btn_xg.Enabled := False;
    btn_cx.Enabled := False;
  end;
  VertScrollBar.Position := 0;
 { SystemParametersInfo(SPI_GETWORKAREA,0,@hRect, 0);    //获取桌面分辨率(不含任务栏)
  if hRect.Right < Self.Width then
  begin
    Self.Width := 800;
  end;
  if hRect.Bottom < Self.Height then
  begin
    Self.Height := 600;
  end;   }
  str := cbb_cpks.Text;
  CbbParamAdd(cbb_cpks,'成品开数');
  cbb_cpks.Text := str;
  str := cbb_sblb.Text;
  CbbParamAdd(cbb_sblb,'晒版版别');
  cbb_sblb.Text := str;
  str := cbb_zb.Text;
  CbbParamAdd(cbb_zb,'纸张名称');
  cbb_zb.Text := str;
  str := cbb_gg.Text;
  CbbParamAdd(cbb_gg,'纸张规格');
  cbb_gg.Text := str;
  str := cbb_dyjb.Text;
  CbbParamAdd(cbb_dyjb,'机台名称');
//  cbb_dyjb.ItemIndex := cbb_dyjb.Items.IndexOf();
  if vWorkID >0 then
    btn_ckdd.Visible := True;
  cbb_dyjb.Text := str;
  EdtShowCbbEvent;
end;

procedure TFrm_Print.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  VertScrollBar.Position := VertScrollBar.Position +40;
end;

procedure TFrm_Print.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  VertScrollBar.Position := VertScrollBar.Position -40;

end;

procedure TFrm_Print.edt_jfqsKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Ord(Key) < Ord('0')) or (Ord(Key)>Ord('9'))) and (Ord(Key)<> VK_BACK)  then
    Key := #0;
end;

procedure TFrm_Print.edt_jfqsExit(Sender: TObject);
begin
  try
    if StrToNum(TEdit(Sender).Text) > High(Integer) then
    begin
      Application.MessageBox('输入数值超过可用范围!','提示',MB_ICONINFORMATION);
      TEdit(Sender).Text:= '';
      TEdit(Sender).SetFocus;
      Exit;
    end;
  except
    Application.MessageBox('输入数值超过可用范围!','提示',MB_ICONINFORMATION);
    TEdit(Sender).Text:= '';
    TEdit(Sender).SetFocus;
    Exit;
  end;
  if TEdit(Sender).Tag = 3 then
    EdtExit(Sender);
end;

procedure TFrm_Print.edt_cpkKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Ord(Key) < Ord('0')) or (Ord(Key)>Ord('9'))) and (Ord(Key)<> VK_BACK)  then
    Key := #0;
end;

procedure TFrm_Print.edt_cpc1KeyPress(Sender: TObject; var Key: Char);
begin
  if ((Ord(Key) < Ord('0')) or (Ord(Key)>Ord('9'))) and (Ord(Key)<> VK_BACK) and (Ord(Key)<>Ord('.')) then
    Key := #0;
end;

procedure TFrm_Print.RecCookieALL;
var
  i: integer;
  sValue: string;
  MyReg: TRegistry;
begin
  MyReg := TRegistry.Create;
  MyReg.RootKey := HKEY_LOCAL_MACHINE;
  MyReg.OpenKey('SOFTWARE\YDPrint\Cookie\WorkOrder\',True);
  for i := 0 to Self.ComponentCount -1 do
  begin
    sValue := '';
    if (Self.Components[i] is Ti_TxtFilter) or (Self.Components[i] is Ti_ComboBox) or (Self.Components[i] is TComboBox) or (Self.Components[i] is TRzDateTimePicker)
      or (Self.Components[i] is TRzMemo) then
    begin
      if Self.Components[i].Tag = 3 then
      begin
        if Self.Components[i] is TRzDateTimePicker then
        begin
          if TRzDateTimePicker(Self.Components[i]).Enabled then
            sValue := FormatDateTime('yyyy/MM/dd',TRzDateTimePicker(Self.Components[i]).Date);
        end;
        if (Self.Components[i] is Ti_ComboBox) or (Self.Components[i] is TComboBox) then
          sValue := Ti_ComboBox(Self.Components[i]).Text
        else
          sValue := TEdit(Self.Components[i]).Text;
        MyReg.WriteString(Self.Components[i].Name, sValue);
      end;
    end;
  end;
  MyReg.CloseKey;
  MyReg.Free
end;

procedure TFrm_Print.btn_ckddClick(Sender: TObject);
begin
  Frm_GDFK := TFrm_GDFK.Create(Self);
  Frm_GDFK.ShowModal;
  Frm_GDFK.Free;
end;

procedure TFrm_Print.EdtDblClick(Sender: TObject);
var
  MyReg: TRegistry;
  ItemList,str: string;
  i,n: Integer;
  edt: TEdit;
begin
  vEdt := TEdit(Sender);
  edt := TEdit(Sender);
  cbb_Temp.Height := edt.Height;
  cbb_Temp.Top := edt.Top+edt.Height-cbb_Temp.Height;
  cbb_Temp.Left := edt.Left;
  cbb_Temp.Width := edt.Width;
  MyReg := TRegistry.Create;
  MyReg.RootKey := HKEY_LOCAL_MACHINE;
  MyReg.OpenKey('SOFTWARE\YDPrint\Cookie\Frm_Print\',True);

  if MyReg.ValueExists(edt.Name) then
    ItemList := MyReg.ReadString(edt.Name);
  MyReg.CloseKey;
  MyReg.Free ;
  cbb_Temp.Items.Clear;
  n := PosNum(ItemList,';');
  for i := 1 to n do
  begin
    str := PosCopy(ItemList,';',i);
    if str <> '' then
      cbb_Temp.Items.Add(str);
  end;
  if not cbb_Temp.Visible then
    cbb_Temp.Visible := True;
  cbb_Temp.SetFocus;
  cbb_Temp.DroppedDown:=True;
end;

procedure TFrm_Print.EdtShowCbbEvent;
var
  i: integer;
begin
  for i := 0 to Self.ComponentCount -1 do
  begin
    if (Self.Components[i] is Ti_TxtFilter) or (Self.Components[i] is TRzMemo) then
    begin
      if Self.Components[i].Tag = 3 then
      begin
        TEdit(Self.Components[i]).OnDblClick := EdtDblClick;
      end;
    end;
  end;
end;

procedure TFrm_Print.edt_hmExit(Sender: TObject);
begin
  if TEdit(Sender).Tag = 3 then
    EdtExit(Sender);
end;

procedure TFrm_Print.EdtExit(Sender: TObject);
var
  MyReg: TRegistry;
  i,n: integer;
  ItemList,str: string;
  edt: TEdit;
begin
  vEdt := TEdit(Sender);
  if cbb_Temp.DroppedDown then Exit;
    edt := TEdit(Sender);
    MyReg := TRegistry.Create;
    MyReg.RootKey := HKEY_LOCAL_MACHINE;
    MyReg.OpenKey('SOFTWARE\YDPrint\Cookie\Frm_Print\',True);
    if MyReg.ValueExists(edt.Name) then
      ItemList := MyReg.ReadString(edt.Name);
    cbb_Temp.Items.Clear;
    n := PosNum(ItemList,';');
    for i := 1 to n do
    begin
      str := PosCopy(ItemList,';',i);
      if str <> '' then
        cbb_Temp.Items.Add(str);
    end;
    n := cbb_Temp.Items.IndexOf(edt.Text);
    if n >= 0 then
      cbb_Temp.Items.Delete(n);
    cbb_Temp.Items.Insert(0,edt.Text);
    ItemList := '';
    for i := 0 to 4 do
       ItemList := ItemList + cbb_Temp.Items.Strings[i] + ';';
    MyReg.WriteString(edt.Name, ItemList);
    MyReg.CloseKey;
    MyReg.Free
end;

procedure TFrm_Print.edt_hmKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Exit;
  if (Key = VK_DOWN) and (TEdit(Sender).Tag = 3) then
  begin
    EdtDblClick(Sender);
  end;
end;

procedure TFrm_Print.cbb_TempCloseUp(Sender: TObject);
var
  MyReg: TRegistry;
  i,n: integer;
  ItemList: string;
  edt: TEdit;
begin
    Exit;
    edt := vEdt;
    edt.Text := cbb_Temp.Text;

    n := cbb_Temp.Items.IndexOf(edt.Text);
    if n >= 0 then
      cbb_Temp.Items.Delete(n);
    cbb_Temp.Items.Insert(0,edt.Text);
    for i := 0 to 4 do
       ItemList := ItemList + cbb_Temp.Items.Strings[i] + ';';

    MyReg := TRegistry.Create;
    MyReg.RootKey := HKEY_LOCAL_MACHINE;
    MyReg.OpenKey('SOFTWARE\YDPrint\Cookie\Frm_Print\',True);
    MyReg.WriteString(edt.Name, ItemList);
    MyReg.CloseKey;
    MyReg.Free;
    edt.SetFocus;
end;

procedure TFrm_Print.cbb_TempClick(Sender: TObject);
var
  MyReg: TRegistry;
  i,n: integer;
  ItemList: string;
  edt: TEdit;
begin
    edt := vEdt;
    edt.Text := cbb_Temp.Text;

    n := cbb_Temp.Items.IndexOf(edt.Text);
    if n >= 0 then
      cbb_Temp.Items.Delete(n);
    cbb_Temp.Items.Insert(0,edt.Text);
    for i := 0 to 4 do
       ItemList := ItemList + cbb_Temp.Items.Strings[i] + ';';

    MyReg := TRegistry.Create;
    MyReg.RootKey := HKEY_LOCAL_MACHINE;
    MyReg.OpenKey('SOFTWARE\YDPrint\Cookie\Frm_Print\',True);
    MyReg.WriteString(edt.Name, ItemList);
    MyReg.CloseKey;
    MyReg.Free;
    edt.SetFocus;
end;

procedure TFrm_Print.edt_zhqExit(Sender: TObject);
begin
  edt_hmExit(Sender);
  if (Trim(edt_zhz.Text) = '') and (IsNum(edt_zhq.Text)) then
    edt_zhz.Text := StrToNum(edt_zhq.Text)+ StrToNum(edt_zl.Text)-1;
end;

procedure TFrm_Print.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  if NewWidth < 1100 then
    pan_gd.Left := 1
  else
    pan_gd.Left := (NewWidth-1000) div 2;

end;

procedure TFrm_Print.Button1Click(Sender: TObject);
var
  sZd,sDzgy: string;
  aZdgy: array of string;
  i,n,iPos: integer;
begin
  Frm_zdgy := TFrm_zdgy.Create(Self);
  sZd := mmo_zd.Text;
  CbParamAdd(Frm_zdgy.cb_gyyq,'装订工艺');
  for i := 0 to Frm_zdgy.cb_gyyq.Items.Count -1 do
  begin
    if Pos(Frm_zdgy.cb_gyyq.Items.Strings[i],sZd) > 0 then
      Frm_zdgy.cb_gyyq.Checked[i] := True;
  end;
  if Frm_zdgy.ShowModal = mrOk then
  begin
    n := 0;
    SetLength(aZdgy,n);
    for i := 0 to Frm_zdgy.cb_gyyq.Items.Count -1 do
    begin
      if Frm_zdgy.cb_gyyq.Checked[i] then
      begin
        Inc(n);
        SetLength(aZdgy,n);
        aZdgy[n-1] := Frm_zdgy.cb_gyyq.Items.Strings[i];
      end;
    end;
    iPos := Pos('----------',sZd);
    if iPos = 0 then
    begin
      mmo_zd.Text := mmo_zd.Text + #13#10#13#10;
      iPos := Length(mmo_zd.Text)+1;
    end;
    mmo_zd.Text := Copy(mmo_zd.Text,1,iPos-1);
    sDzgy := '';
    for i := 0 to Length(aZdgy) -1 do
    begin
      sDzgy := sDzgy + '--------------------' + #13#10 + aZdgy[i] + #13#10 ;
    end;
    if Length(aZdgy) > 0 then
      mmo_zd.Text := mmo_zd.Text + sDzgy + '--------------------' + #13#10;
  end;
  Frm_zdgy.Free;
end;

end.
