unit uFratg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, RzCmboBx, iComboBox, ButtonEdit, ComCtrls,
  RzListVw, RzButton, RzPanel, uDM_DataBase,ADODB, iGrid,
  PostService, Menus,iLabel, ImgList,DBGridEh,DB, ComObj,uBaseForm;



type
  TFra_tg = class(TFrmFrame)
    RzGroupBox1: TRzGroupBox;
    edt_cpbh: Ti_TxtFilter;
    edt_khmc: Ti_TxtFilter;
    cbb_cplb: Ti_ComboBox;
    cbb_cplx: Ti_ComboBox;
    cbb_qyfs: Ti_ComboBox;
    btn_cx: TRzButton;
    cbb_tgzt: Ti_ComboBox;
    GroupBox1: TGroupBox;
    cbb_llzt: Ti_ComboBox;
    btn_ok: TRzButton;
    btn_fk: TRzButton;
    cbb_bb: Ti_ComboBox;
    cbb_xpl: Ti_ComboBox;
    RzPanel1: TRzPanel;
    gb_dd: TRzGroupBox;
    lv_jhxd: TRzListView;
    cbb_nf: Ti_ComboBox;
    ImageList1: TImageList;
    cbb_fktgzt: Ti_ComboBox;
    pm_jhxd: TPopupMenu;
    menu_cxfj: TMenuItem;
    menu_ddmx: TMenuItem;
    menu_ddmxPic: TMenuItem;
    cbb_sfqy: Ti_ComboBox;
    N1: TMenuItem;
    menu_del: TMenuItem;
    lab_up: TLabel;
    lab_down: TLabel;
    edt_ys: TEdit;
    btn_go: TButton;
    lab_ts50: TLabel;
    lab_first: TLabel;
    lab_last: TLabel;
    pan_data: TPanel;
    Label2: TLabel;
    lab_zys: TLabel;
    lab_ts100: TLabel;
    lab_ts200: TLabel;
    lab_ts500: TLabel;
    Label6: TLabel;
    edt_gdh: Ti_TxtFilter;
    menu_NJDel: TMenuItem;
    menu_ddcy: TMenuItem;
    btn_export: TRzButton;
    SavePath: TSaveDialog;
    edt_bz: Ti_TxtFilter;
    procedure btn_cxClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_fkClick(Sender: TObject);
    procedure lv_jhxdColumnClick(Sender: TObject; Column: TListColumn);
    procedure cbb_bbChange(Sender: TObject);
    procedure lv_jhxdMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure menu_ddmxClick(Sender: TObject);
    procedure cbb_cplbChange(Sender: TObject);
    procedure lv_jhxdCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure menu_cxfjClick(Sender: TObject);
    procedure menu_delClick(Sender: TObject);
    procedure btn_goClick(Sender: TObject);
    procedure edt_ysKeyPress(Sender: TObject; var Key: Char);
    procedure lab_firstClick(Sender: TObject);
    procedure lab_lastClick(Sender: TObject);
    procedure lab_upClick(Sender: TObject);
    procedure lab_downClick(Sender: TObject);
    procedure lab_ts50Click(Sender: TObject);
    procedure menu_NJDelClick(Sender: TObject);
    procedure menu_ddcyClick(Sender: TObject);
    procedure btn_exportClick(Sender: TObject);
    procedure cbb_llztChange(Sender: TObject);
  private
    { Private declarations }
    vMYTS: Integer;     //当前每页条数
    vYs: integer;       //当前页数
    vSqlData: string;
    vOrderType: integer;
    procedure ReadDataJHXD(ADO_Data: TADOQuery;Bz: integer);
    function f_MakeAllow: Boolean;   //操作允许
  public
    { Public declarations }
    procedure FraShow;
    procedure CustomLvAdd;
    procedure SellLvAdd;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  uMain, PubStr, uDDMX_DZX, uDDMX_XSX, uPub_Type, uPub_Func,
  uFrmFJ, DateUtils, uDDCX_BZ, uPub_Text;


{$R *.dfm}

const
  c_tgwsd=1;   //图稿未收到
  c_tgysd=2;   //图稿已收到
  c_dyz=3;   //打样中
  c_tgwhg=4;   //图稿未合格
  c_tgyhg=5;   //图稿已合格
  c_ydy=6;      //已打样
  c_yqy=7;    //已签样
  c_tgshz = 8;  //图稿审核中

const
  c_sjg   = 0;           //要教省
  c_jg    = 1;           //要教机构
  c_CPBH  = 2;           //产品编号
  c_JSRQ  = 3;           //订单下达日
  c_khmc  = 4;           //产品名称                    
  c_zl    = 5;           //种类                        
  c_yztmc = 6;           //邮资图                      
  c_yl    = 7;           //印量(万枚)
  c_jybz  = 8;           //加印
  c_xpl   = 9;           //小批量
  c_sfqy  = 10;          //是否签样
  c_zt    = 11;          //状态
  c_czr   = 12;          //操作人
  c_czrq  = 13;          //操作日期
  c_fkzt  = 14;          //反馈状态
  c_fkr   = 15;          //反馈人
  c_fkrq  = 16;          //反馈日期

procedure TFra_tg.btn_cxClick(Sender: TObject);                          
const
  c_wsd = 0;                                                             
  c_ysd = 1;
  c_whg = 2;                                                             
  c_yhg = 3;
  c_ydy = 4;                                                             
  c_yqy = 5;
  c_dhg = 6;                                                             
  c_dqy = 7;
  c_dcl = 8;                                                             

  c_dzx = 0;                                                             
  c_xsx = 1;
var                                                                      
  sFktgzt, sSqlData: string;
  sCpbh, sKhbh,sGdh: string;
  iOrderType, iSfqy, iTgzt: integer;
  iCplb, iCplx, iXpl,iYs, iTs: Integer;
  sNf: string;
  ADO_Rec: TADOQuery;
begin
  Screen.Cursor := crHourGlass;
  sCpbh := Trim(edt_cpbh.Text);
  sKhbh := Trim(edt_khmc.Text);
  sGdh := Trim(edt_gdh.Text);
  iTgzt := cbb_tgzt.ItemIndex;
  sFktgzt := inttostr(cbb_fktgzt.ItemIndex-1);
  iOrderType := cbb_bb.ItemIndex;
  iCplb := FindProductCategoryCode(cbb_cplb.ItemIndex);
  iCplx := FindProductTypeID(cbb_cplx.ItemIndex,iCplb);
  sNf := cbb_nf.Text;
  iSfqy := cbb_sfqy.ItemIndex-1;
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
  case cbb_xpl.ItemIndex of
    0: iXpl := -1;
    1: iXpl := 0;
    2: iXpl := 1;
  else
    iXpl := -1;
  end;
  try
    sSqlData := 'exec p_tgcx ''%s'',%d,%d,''%s'',%d,%d,''%s'',''%s'',%d,%d,%d,%d';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sCpbh,iCplb,iCplx,sNf,iOrderType,iSfqy,sKhbh,sGdh,iTgzt,iXpl,iYs,iTs],True);
  //  DM_DataBase.ADO_DataRec := DM_DataBase.OpenQuery(sSqlData,[sCpbh,iCplb,iCplx,sNf,iOrderType,iSfqy,sKhbh,sTgzt,iXpl,iYs,iTs]);
    vSqlData := Format('exec p_tgcx ''%s'',%d,%d,''%s'',%d,%d,''%s'',''%s'',%d,%d,%s,%s',[sCpbh,iCplb,iCplx,sNf,iOrderType,iSfqy,sKhbh,sGdh,iTgzt,iXpl,'%d','%d']);
    if vOrderType <> iOrderType then
    begin
      case iOrderType of
        0:
          begin
            CustomLvAdd;
            if btn_fk.Tag = c_Tag_MakeAllow then
            begin
              btn_fk.Enabled:= True;
              btn_ok.Enabled:= True;
            end;
          end;
        1:
          begin
            SellLvAdd;
            btn_fk.Enabled:= False;
            btn_ok.Enabled:= False;
          end;
      end;
      vOrderType := iOrderType;
    end;
    ReadDataJHXD(ADO_Rec,iOrderType);
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar('错误:'+E.message),'提示',MB_ICONINFORMATION);
    end;
  end;
  ADO_Rec.Free;
  Screen.Cursor := crDefault;
end;

procedure TFra_tg.btn_okClick(Sender: TObject);
const
  c_wsd = 0;
  c_ysd = 1;
  c_whg = 2;
  c_yhg = 3;
  c_dy = 4;
  c_yqy = 5;
  c_dcl = 8;
  c_llzt_qxz = 0;     //请选择
  c_llzt_wsd = 1;     //图稿未收到
  c_llzt_ysd = 2;     //图稿已收到
  c_llzt_whg = 3;     //图稿未合格
  c_llzt_yhg = 4;     //图稿已合格
  c_llzt_dy  = 5;     //已打样
  c_llzt_dcl = 6;     //图稿待处理
  c_dzx = 0;
  c_xsx = 1;
var
  i,iTgzt: Integer;
  sID: string;
  iOrderType: integer;
  sSqlData, sZT, sCPBH: string;
  sCzrqFieldName,sCzrFieldName: string;
  bCheck: Boolean;
begin
  bCheck := False;
  for i := 0 to lv_jhxd.Items.Count -1 do
  begin
    if lv_jhxd.Items[i].Checked then
    begin
      bCheck := True;
      iOrderType := StrToNum(lv_jhxd.Items[i].SubItems.Strings[lv_jhxd.Items[i].SubItems.Count-2]);
      if cbb_llzt.ItemIndex = c_llzt_dy  then
      begin
        sZT := lv_jhxd.Items[i].SubItems.Strings[c_zt];
        if sZT <> '图稿已合格' then
        begin
          sCPBH := lv_jhxd.Items[i].SubItems.Strings[c_cpbh];
          p_MessageBoxDlg(sCPBH+' 只有是"图稿已合格"状态才可以进行打样!');
          Exit;
        end;
      end else
      begin
        Break;
      end;
    end;
  end;
  if not bCheck then
  begin
    Application.MessageBox('请选择至少一项','提示',MB_ICONINFORMATION);
    Exit;
  end;
  if cbb_llzt.ItemIndex = 0 then
  begin
    Application.MessageBox('请选择图稿状态','提示',MB_ICONINFORMATION);
    Exit;
  end;
  if p_MessageBoxDlg('是否只改变内部状态而不进行反馈?','提示',MB_ICONINFORMATION+MB_YESNO)=IDNO then
  begin
    Exit;
  end;
  for i := 0 to lv_jhxd.Items.Count -1 do
  begin
    if lv_jhxd.Items[i].Checked then
    begin
      sID := lv_jhxd.Items[i].SubItems.Strings[lv_jhxd.Items[i].SubItems.Count-1]+',' + sID;
      sSqlData := sSqlData +' if not exists(Select 1 from DO_OrderPicDate_Log where F_iOrderID = '+lv_jhxd.Items[i].SubItems.Strings[lv_jhxd.Items[i].SubItems.Count-1]+' ' ;
      sSqlData := sSqlData +' and F_tiOrderType = '+lv_jhxd.Items[i].SubItems.Strings[lv_jhxd.Items[i].SubItems.Count-2]+') ' ;
      sSqlData := sSqlData + 'Insert into DO_OrderPicDate_Log (F_iOrderID,F_tiOrderType) VALUES ('+ lv_jhxd.Items[i].SubItems.Strings[lv_jhxd.Items[i].SubItems.Count-1];
      sSqlData := sSqlData +' ,'+lv_jhxd.Items[i].SubItems.Strings[lv_jhxd.Items[i].SubItems.Count-2]+') ' ;
    end;
  end;
  if sID = '' then exit;
  sID := Copy(sID,1,Length(sID)-1);
  DM_DataBase.ExecQuery(sSqlData,[],True);
//  DM_DataBase.WriteSynLog(sSqlData);  //记录日志
//  sCzr := DM_DataBase.GetTableFirst('Select F_sName from BI_UserList where F_iID='+sID);
  case cbb_llzt.ItemIndex of
    c_llzt_wsd:
      begin
        iTgzt := c_wsd;
        sCzrqFieldName := 'F_dWSD';
        sCzrFieldName := 'F_iWSDCZRID'
      end;                                                      
    c_llzt_ysd:
      begin
        iTgzt := c_ysd;
        sCzrqFieldName := 'F_dYSD';
        sCzrFieldName := 'F_iYSDCZRID'
      end;
    c_llzt_whg:
      begin
        iTgzt := c_whg;
        sCzrqFieldName := 'F_dWHG';
        sCzrFieldName := 'F_iWHGCZRID'
      end;
    c_llzt_yhg:
      begin
        iTgzt := c_yhg;
        sCzrqFieldName := 'F_dYHG';
        sCzrFieldName := 'F_iYHGCZRID'
      end;
    c_llzt_dy:
      begin
        iTgzt := c_dy;
        sCzrqFieldName := 'F_dYDY';
        sCzrFieldName := 'F_iYDYCZRID'
      end;
    c_llzt_dcl:
      begin
        iTgzt := c_dcl;
        sCzrqFieldName := 'F_dDCL';
        sCzrFieldName := 'F_iDCLCZRID';
        if iOrderType = c_dzx then
          sSqlData := 'Update BI_CustomOrderDetails set F_sNBBZ = ''%s'' where F_iID in (%s) '
        else
          sSqlData := 'Update BI_SellOrderDetails set F_sNBBZ = ''%s'' where F_iID in (%s) ';
        DM_DataBase.ExecQuery(sSqlData,[edt_bz.Text,sID]);
      end;
  else
      iTgzt:= -1;
  end;
  try
    DM_DataBase.Con_YDPrint.BeginTrans;
    with DM_DataBase.ADO_DataRec do
    begin
      if iOrderType = c_dzx then
      begin
//        SQL.Text := 'Update BI_CustomOrderDetails set F_iTgzt='+IntToStr(iTgzt)+',F_dCzrq=getdate(),F_iCzrID='+IntToStr(LoginData.m_iUserID)+' where F_iID in ('+sID+') ';
//        SQL.Add(' Update DO_OrderPicDate_Log set '+sCzrqFieldName+'=getdate(),'+sCzrFieldName+'='+IntToStr(LoginData.m_iUserID)+' where F_tiOrderType = 0 and F_iOrderID in ('+sID+') ');
//        ExecSQL;
//        sSqldata := 'Update BI_CustomOrderDetails set F_dLGRQ=getdate(), F_sLGCZRBM=''%s'' where IsNull(F_sLGCZRBM,'''') = '''' and F_iID in (%s) ';
//        DM_DataBase.ExecQuery(sSqldata,[LoginData.m_sUserName,sID],True);

        //记录图稿操作时间(图稿操作的时间)
        SQL.Text := Format('Update BI_CustomOrderDetails set F_iTgzt=%d,F_dCzrq=getdate(),F_iCzrID=%d where F_iID in (%s) '
          ,[iTgzt,LoginData.m_iUserID,sID]);
        SQL.Text := SQL.Text+Format(' Update DO_OrderPicDate_Log set %s=getdate(),%s=%d where F_tiOrderType = 0 and F_iOrderID in (%s) '
          ,[sCzrqFieldName,sCzrFieldName,LoginData.m_iUserID,sID]);
        //记录来稿时间(第一次操作的时间)
        SQL.Text := SQL.Text+Format(' Update BI_CustomOrderDetails set F_dLGRQ=getdate(), F_sLGCZRBM=''%s'' where IsNull(F_sLGCZRBM,'''') = '''' and F_iID in (%s) '
          ,[LoginData.m_sUserName,sID]);
        ExecSQL;
      end else
      if iOrderType = c_xsx then
      begin
//        SQL.Text := 'Update BI_SellOrderDetails set F_iTgzt='+IntToStr(iTgzt)+',F_dCzrq=getdate(),F_iCzrID='+IntToStr(LoginData.m_iUserID)+' where F_iID in ('+sID+') ';
//        SQL.Add(' Update DO_OrderPicDate_Log set '+sCzrqFieldName+'=getdate(),'+sCzrFieldName+'='+IntToStr(LoginData.m_iUserID)+' where F_tiOrderType = 1 and F_iOrderID in ('+sID+') ');
//        ExecSQL;
//        sSqldata := 'Update BI_SellOrderDetails set F_dLGRQ=getdate(), F_sLGCZRBM=''%s'' where IsNull(F_sLGCZRBM,'''') = '''' and F_iID in (%s) ';
//        DM_DataBase.ExecQuery(sSqldata,[LoginData.m_sUserName,sID],True);

        //记录图稿操作时间(图稿操作的时间)
        SQL.Text := Format('Update BI_SellOrderDetails set F_iTgzt=%d,F_dCzrq=getdate(),F_iCzrID=%d where F_iID in (%s) '
          ,[iTgzt,LoginData.m_iUserID,sID]);
        SQL.Text := SQL.Text+Format(' Update DO_OrderPicDate_Log set %s=getdate(),%s=%d where F_tiOrderType = 1 and F_iOrderID in (%s) '
          ,[sCzrqFieldName,sCzrFieldName,LoginData.m_iUserID,sID]);
        //记录来稿时间(第一次操作的时间)
        SQL.Text := SQL.Text+Format(' Update BI_SellOrderDetails set F_dLGRQ=getdate(), F_sLGCZRBM=''%s'' where IsNull(F_sLGCZRBM,'''') = '''' and F_iID in (%s) '
          ,[LoginData.m_sUserName,sID]);
        ExecSQL;
      end;
    end;
//    DM_DataBase.WriteSynLog(DM_DataBase.ADO_DataRec.SQL.Text);     //记录日志(不使用)
    Application.MessageBox('成功','提示',MB_ICONINFORMATION);
    btn_cx.Click;
    DM_DataBase.Con_YDPrint.CommitTrans;
  except
    on E: Exception do
    begin
      DM_DataBase.Con_YDPrint.RollbackTrans;
      Application.MessageBox(PChar('失败:'+E.message),'提示',MB_ICONINFORMATION)
    end;
  end;
end;



procedure TFra_tg.btn_fkClick(Sender: TObject);
const
  c_wsd = 0;
  c_ysd = 1;
  c_whg = 2;
  c_yhg = 3;
  c_dy=4;
  c_yqy = 5;
  c_dcl = 8;
  c_llzt_qxz = 0;      //请选择
  c_llzt_wsd = 1;      //图稿未收到
  c_llzt_ysd = 2;      //图稿已收到
  c_llzt_whg = 3;      //图稿未合格
  c_llzt_yhg = 4;      //图稿已合格
  c_llzt_dy  = 5;      //已打样
  c_llzt_dcl = 6;      //图稿待处理
  c_dzx = 0;
  c_xsx = 1;
var
  obj: PostServicePortType;
  i,iRec,iFktgzt: Integer;
  sDetailsID, sSpbm,sOrderID, sCPBH, sFKZT: string;
  zStr,Str, SqlData, sSqldata: string;
  iOrderType,iDfbbz: integer;
  sCzrqFieldName,sCzrFieldName: string;
  bCheck: Boolean;
  ADO_Rec: TADOQuery;
begin
  if cbb_llzt.ItemIndex = c_llzt_dcl then       //图稿待处理只进行内部状态更改,不进行反馈
  begin
    btn_ok.Click;
    Exit;
  end;

  bCheck := False;
  for i := 0 to lv_jhxd.Items.Count -1 do
  begin
    if lv_jhxd.Items[i].Checked then
    begin
      bCheck := True;
      iOrderType := StrToNum(lv_jhxd.Items[i].SubItems.Strings[lv_jhxd.Items[i].SubItems.Count-2]);
      if cbb_llzt.ItemIndex = c_llzt_dy  then
      begin
        sFKZT := lv_jhxd.Items[i].SubItems.Strings[c_fkzt];
        if sFKZT <> '图稿已合格' then
        begin
          sCPBH := lv_jhxd.Items[i].SubItems.Strings[c_cpbh];
          p_MessageBoxDlg(sCPBH+' 只有是"图稿已合格"状态才可以进行打样!');
          Exit;
        end;
      end else
        Break;
    end;
  end;
  if not bCheck then
  begin
    Application.MessageBox('请选择至少一项','提示',MB_ICONINFORMATION);
    Exit;
  end;
  if cbb_llzt.ItemIndex = 0 then
  begin
    Application.MessageBox('请选择图稿状态','提示',MB_ICONINFORMATION);
    Exit;
  end;
  try
    obj := GetPostServicePortType(true,uMain.vUrl, nil);
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar('连接出错,'+e.Message),'提示',MB_ICONINFORMATION);
      Exit;
    end;      
  end;          
  if obj = nil then exit;
  Str := '';
  for i := 0 to lv_jhxd.Items.Count -1 do
  begin
    if lv_jhxd.Items[i].Checked then
    begin
      sOrderID := Trim(lv_jhxd.Items[i].SubItems.Strings[lv_jhxd.Items[i].SubItems.Count-1]);
      sDetailsID := Trim(lv_jhxd.Items[i].SubItems.Strings[lv_jhxd.Items[i].SubItems.Count-3]);
      sSpbm := Trim(lv_jhxd.Items[i].SubItems.Strings[c_CPBH]);
      if sDetailsID = '' then
      begin
        Str := '产品编号：'+sSpbm+' 国网上无此订单,不能反馈!';
        Application.MessageBox(PChar(Str),'提示',MB_ICONINFORMATION);
        Continue;
      end;

      case iOrderType of
        c_dzx:
          begin
            SqlData := 'Select IsNull(F_tiDfbbz,0) from BI_CustomOrder a where exists(Select 1 from BI_CustomOrderDetails where a.F_iID = F_iCustomID and '
              +' F_iDetailsID='+sDetailsID+')';
            iDfbbz := DM_DataBase.GetTableFirst(SqlData);
          end;
        c_xsx:
          begin
            SqlData := 'Select IsNull(F_tiDfbbz,0) from BI_SellOrder a where exists(Select 1 from BI_SellOrderDetails where a.F_iID = F_iSellID and '
              +' F_iDetailsID='+sDetailsID+')';
            iDfbbz := DM_DataBase.GetTableFirst(SqlData);
          end;
      else
        iDfbbz := -1;
      end;
      try
        if (cbb_llzt.ItemIndex = c_llzt_dy) then     //打样
          iRec := obj.setDYQR('wsfj1', '000000',iif(iDfbbz=0,iOrderType,3),sDetailsID,0,StrLeft(sSpbm,17))
        else
          iRec := obj.setProductInfo('wsfj1', '000000',iif(iDfbbz=0,iOrderType,3),sDetailsID,sSpbm,cbb_llzt.ItemIndex-1);
      except
        on E: Exception do
        begin
          f_WriteOperationLog('[图稿状态]反馈申报ID:' +sDetailsID+' 访问出错,'+e.Message,999);
          Application.MessageBox(PChar('访问出错,'+e.Message),'提示',MB_ICONINFORMATION);
          Exit;
        end;
      end;
      if iRec = 0 then
      begin
        Str := '产品编号：'+sSpbm+' 反馈成功';
//        sSqlData := sSqlData +' if not exists(Select 1 from DO_OrderPicDate_Log where F_iOrderID = '+sOrderID+' ' ;
//        sSqlData := sSqlData +' and F_tiOrderType = '+IntToStr(iOrderType)+') ' ;

//        sSqlData := sSqlData + 'Insert into DO_OrderPicDate_Log (F_iOrderID,F_tiOrderType) VALUES ('+ sOrderID ;
//        sSqlData := sSqlData +' ,'+IntToStr(iOrderType)+') ' ;
        sSqldata := ' if not exists(Select 1 from DO_OrderPicDate_Log where F_iOrderID = %s and F_tiOrderType = %d ) '
          + ' Insert into DO_OrderPicDate_Log (F_iOrderID,F_tiOrderType) VALUES (%s,%d) ';
        DM_DataBase.ExecQuery(sSqlData,[sOrderID,iOrderType,sOrderID,iOrderType],True);
//        DM_DataBase.WriteSynLog(sSqlData);  //记录日志

        case cbb_llzt.ItemIndex of
          c_llzt_wsd:
            begin
              iFktgzt := c_wsd;
              sCzrqFieldName := 'F_dWSD';
              sCzrFieldName := 'F_iWSDCZRID';
            end;
          c_llzt_ysd:
            begin
              iFktgzt := c_ysd;
              sCzrqFieldName := 'F_dYSD';
              sCzrFieldName := 'F_iYSDCZRID';
            end;
          c_llzt_whg:
            begin
              iFktgzt := c_whg;
              sCzrqFieldName := 'F_dWHG';
              sCzrFieldName := 'F_iWHGCZRID';
            end;
          c_llzt_yhg:
            begin
              iFktgzt := c_yhg;
              sCzrqFieldName := 'F_dYHG';
              sCzrFieldName := 'F_iYHGCZRID';
            end;
          c_llzt_dy:
            begin
              iFktgzt := c_dy;
              sCzrqFieldName := 'F_dYDY';
              sCzrFieldName := 'F_iYDYCZRID';
            end;
          c_llzt_dcl:
            begin
//              iFktgzt := c_dcl;
//              sCzrqFieldName := 'F_dDCLRQ';
//              sCzrFieldName := 'F_iDCLCZRID'
            end;
        else
          iFktgzt := -1;
        end;
        try
          DM_DataBase.Con_YDPrint.BeginTrans;
          with DM_DataBase.ADO_DataRec do
          begin
            if iOrderType = c_dzx then
            begin
              //记录图稿操作时间(图稿操作的时间)
//              SQL.Text := 'Update BI_CustomOrderDetails set F_iFktgzt='+IntToStr(iFktgzt)+',F_dFkrq=getdate(),F_iFkrID='+IntToStr(LoginData.m_iUserID)+',F_iTgzt='+IntToStr(iFktgzt)+',F_iCzrID='+IntToStr(LoginData.m_iUserID)+',F_dCzrq=getdate() where F_iDetailsID in ('+sDetailsID+') ';  //改变内部状态为反馈状态
//              SQL.Add(' Update DO_OrderPicDate_Log set '+sCzrqFieldName+'=getdate(),'+sCzrFieldName+'='+IntToStr(LoginData.m_iUserID)+' where F_tiOrderType = 0 and F_iOrderID in ('+sOrderID+') ');
//              ExecSQL;
              //记录来稿时间(第一次操作的时间)
//              sSqldata := ' Update BI_CustomOrderDetails set F_dLGRQ=getdate(), F_sLGCZRBM=''%s'' where IsNull(F_sLGCZRBM,'''') = '''' and F_iDetailsID in (%s) ';
//              DM_DataBase.ExecQuery(sSqldata,[LoginData.m_sUserName,sDetailsID],True);

              //记录图稿操作时间(图稿操作的时间)
              SQL.Text := Format('Update BI_CustomOrderDetails set F_iFktgzt=%d,F_dFkrq=getdate(),F_iFkrID=%d,F_iTgzt=%d,F_iCzrID=%d,F_dCzrq=getdate() where F_iDetailsID in (%s) '
                ,[iFktgzt,LoginData.m_iUserID,iFktgzt,LoginData.m_iUserID,sDetailsID]);  //改变内部状态为反馈状态
              SQL.Text := SQL.Text+Format(' Update DO_OrderPicDate_Log set %s=getdate(),%s=%d where F_tiOrderType = 0 and F_iOrderID in (%s) '
                ,[sCzrqFieldName,sCzrFieldName,LoginData.m_iUserID,sOrderID]);
              //记录来稿时间(第一次操作的时间)
              SQL.Text := SQL.Text+Format(' Update BI_CustomOrderDetails set F_dLGRQ=getdate(), F_sLGCZRBM=''%s'' where IsNull(F_sLGCZRBM,'''') = '''' and F_iDetailsID in (%s) '
                ,[LoginData.m_sUserName,sDetailsID]);
              ExecSQL;
            end
            else
            if iOrderType = c_xsx then
            begin
              //记录图稿操作时间(图稿操作的时间)
//              SQL.Text := 'Update BI_SellOrderDetails set F_iFktgzt='+IntToStr(iFktgzt)+',F_dFkrq=getdate(),F_iFkrID='+IntToStr(LoginData.m_iUserID)+',F_iTgzt='+IntToStr(iFktgzt)+',F_iCzrID='+IntToStr(LoginData.m_iUserID)+',F_dCzrq=getdate() where F_iDetailsID in ('+sDetailsID+') ';
//              SQL.Add(' Update DO_OrderPicDate_Log set '+sCzrqFieldName+'=getdate(),'+sCzrFieldName+'='+IntToStr(LoginData.m_iUserID)+' where F_tiOrderType = 1 and F_iOrderID in ('+sOrderID+') ');
//              ExecSQL;
              //记录来稿时间(第一次操作的时间)
//              sSqldata := 'Update BI_SellOrderDetails set F_dLGRQ=getdate(),F_sLGCZRBM=''%s'' where IsNull(F_sLGCZRBM,'''') = '''' and F_iDetailsID in (%s) ';
//              DM_DataBase.ExecQuery(sSqldata,[LoginData.m_sUserName,sDetailsID],True);

              //记录图稿操作时间(图稿操作的时间)
              SQL.Text := Format('Update BI_SellOrderDetails set F_iFktgzt=%d,F_dFkrq=getdate(),F_iFkrID=%d,F_iTgzt=%d,F_iCzrID=%d,F_dCzrq=getdate() where F_iDetailsID in (%s) '
                ,[iFktgzt,LoginData.m_iUserID,iFktgzt,LoginData.m_iUserID,sDetailsID]);  //改变内部状态为反馈状态
              SQL.Text := SQL.Text+Format(' Update DO_OrderPicDate_Log set %s=getdate(),%s=%d where F_tiOrderType = 1 and F_iOrderID in (%s) '
                ,[sCzrqFieldName,sCzrFieldName,LoginData.m_iUserID,sOrderID]);
              //记录来稿时间(第一次操作的时间)
              SQL.Text := SQL.Text+Format(' Update BI_SellOrderDetails set F_dLGRQ=getdate(), F_sLGCZRBM=''%s'' where IsNull(F_sLGCZRBM,'''') = '''' and F_iDetailsID in (%s) '
                ,[LoginData.m_sUserName,sDetailsID]);
              ExecSQL;
            end;
          end;
//          DM_DataBase.WriteSynLog(DM_DataBase.ADO_DataRec.SQL.Text);   //记录日志
          zStr := zStr +sSpbm+#13#10;
          DM_DataBase.Con_YDPrint.CommitTrans;
        except
          on E: Exception do
          begin
            DM_DataBase.Con_YDPrint.RollbackTrans;
            Application.MessageBox(PChar('更新失败,'+e.Message),'提示',MB_ICONINFORMATION);
            Exit;
          end;
        end;
      end else
      begin
        Str := '产品编号：'+sSpbm+' 反馈失败,失败原因:'+IntToStr(iRec);
        Application.MessageBox(PChar(Str),'提示',MB_ICONINFORMATION);
      end;
    end;
  end;
  if zStr <> '' then
  begin
    Str := '产品编号：'+#13#10+zStr+' 反馈成功';
    btn_cx.Click;
    Application.MessageBox(PChar(Str),'提示',MB_ICONINFORMATION);
  end;
end;

procedure TFra_tg.lv_jhxdColumnClick(Sender: TObject; Column: TListColumn);
var
  i: Integer;
  bQx: Boolean;
begin
  if Column.Caption = '选择' then
  begin
    bQx := False;
    for i := 0 to TRzListView(Sender).Items.Count -1 do
    begin
      if not TRzListView(Sender).Items[i].Checked then
      begin
        bQx := True;
        Break
      end;
    end;
    for i := 0 to TRzListView(Sender).Items.Count -1 do
      TRzListView(Sender).Items[i].Checked := bQx;
  end else
  begin
    TRzListView(Sender).CustomSort(@RzCustomSortProc,Column.Index)
  end;
end;

procedure TFra_tg.CustomLvAdd;
begin
  edt_khmc.EditLabel.Caption := '客户名称:';
  with lv_jhxd do
  begin
    Items.BeginUpdate;
    Clear;
    Columns.Clear;
    Columns.Add.Caption := '选择';
    Columns.Items[Columns.Count-1].Width := 40;
    Columns.Add.Caption := '承揽省';
    Columns.Items[Columns.Count-1].Width := 100;
    Columns.Add.Caption := '承揽机构';
    Columns.Items[Columns.Count-1].Width := 100;
    Columns.Add.Caption := '产品编号';
    Columns.Items[Columns.Count-1].Width := 140;
    Columns.Add.Caption := '订单下达日期';
    Columns.Items[Columns.Count-1].Width := 90;
    Columns.Add.Caption := '客户名称';
    Columns.Items[Columns.Count-1].Width := 130;
    Columns.Add.Caption := '种类';
    Columns.Items[Columns.Count-1].Width := 40;
    Columns.Add.Caption := '邮资图';
    Columns.Items[Columns.Count-1].Width := 60;
    Columns.Add.Caption := '印量(万枚)';
    Columns.Items[Columns.Count-1].Width := 80;
    Columns.Add.Caption := '加印';
    Columns.Items[Columns.Count-1].Width := 40;
    Columns.Add.Caption := '小批量';
    Columns.Items[Columns.Count-1].Width := 60;
    Columns.Add.Caption := '是否签样';
    Columns.Items[Columns.Count-1].Width := 60;
    Columns.Add.Caption := '状态';
    Columns.Items[Columns.Count-1].Width := 80;
    Columns.Add.Caption := '操作人';
    Columns.Items[Columns.Count-1].Width := 80;
    Columns.Add.Caption := '操作日期';
    Columns.Items[Columns.Count-1].Width := 150;
    Columns.Add.Caption := '反馈状态';
    Columns.Items[Columns.Count-1].Width := 80;
    Columns.Add.Caption := '反馈人';
    Columns.Items[Columns.Count-1].Width := 80;
    Columns.Add.Caption := '反馈日期';
    Columns.Items[Columns.Count-1].Width := 150;
    Items.EndUpdate;
  end;
end;

procedure TFra_tg.SellLvAdd;
begin
  edt_khmc.EditLabel.Caption := '产品名称:';
  with lv_jhxd do
  begin
    Items.BeginUpdate;
    Clear;
    Columns.Clear;
    Columns.Add.Caption := '选择';
    Columns.Items[Columns.Count-1].Width := 40;
    Columns.Add.Caption := '要教省';
    Columns.Items[Columns.Count-1].Width := 100;
    Columns.Add.Caption := '要教机构';
    Columns.Items[Columns.Count-1].Width := 100;
    Columns.Add.Caption := '产品编号';
    Columns.Items[Columns.Count-1].Width := 140;
    Columns.Add.Caption := '订单下达日期';
    Columns.Items[Columns.Count-1].Width := 90;
    Columns.Add.Caption := '产品名称';
    Columns.Items[Columns.Count-1].Width := 130;
    Columns.Add.Caption := '种类';
    Columns.Items[Columns.Count-1].Width := 40;
    Columns.Add.Caption := '邮资图';
    Columns.Items[Columns.Count-1].Width := 60;
    Columns.Add.Caption := '印量(万枚)';
    Columns.Items[Columns.Count-1].Width := 80;
    Columns.Add.Caption := '加印';
    Columns.Items[Columns.Count-1].Width := 40;
    Columns.Add.Caption := '小批量';
    Columns.Items[Columns.Count-1].Width := 60;
    Columns.Add.Caption := '是否签样';
    Columns.Items[Columns.Count-1].Width := 60;
    Columns.Add.Caption := '状态';
    Columns.Items[Columns.Count-1].Width := 80;
    Columns.Add.Caption := '操作人';
    Columns.Items[Columns.Count-1].Width := 80;
    Columns.Add.Caption := '操作日期';
    Columns.Items[Columns.Count-1].Width := 150;
    Columns.Add.Caption := '反馈状态';
    Columns.Items[Columns.Count-1].Width := 80;
    Columns.Add.Caption := '反馈人';
    Columns.Items[Columns.Count-1].Width := 80;
    Columns.Add.Caption := '反馈日期';
    Columns.Items[Columns.Count-1].Width := 150;
    Items.EndUpdate;
  end;
end;

procedure TFra_tg.cbb_bbChange(Sender: TObject);
begin
  case cbb_bb.ItemIndex of
    0:
      begin
        cbb_xpl.Enabled := True;
      end;
    1:
      begin
        cbb_xpl.Enabled := False;
      end;
  end;

end;

procedure TFra_tg.ReadDataJHXD(ADO_Data: TADOQuery; Bz: integer);
const
  c_wsd = 0;
  c_ysd = 1;
  c_whg = 2;
  c_yhg = 3;
  c_dy  = 4;
  c_yqy = 5;
  c_shz = 6;
  c_dcl = 8;
var
  sTgzt, sQY, sJybz, sCzr,sFkzt,sFkr,sXpl: string;
  i,n,iCzrID,iFkrID: Integer;
  sDate: string;
begin
  lv_jhxd.Items.BeginUpdate;
  btn_cx.Caption := '查询中...';
  with lv_jhxd,ADO_Data do
  begin
    Clear;
    i := 0;
    if ADO_Data.RecordCount > 0 then
    begin
      n := FieldByName('Count').AsInteger;
      gb_dd.Caption := '订单  总数: '+IntToStr(n)+' 条';
      lab_zys.Tag := n div vMYTS;
      if n mod vMYTS > 0 then
        lab_zys.Tag := lab_zys.Tag +1;
      lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);
    end else
      gb_dd.Caption := '订单  总数: 0 条';
//    lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag)+'  500条/页';
//    MoveBy(vMYTS*(vYS-1));
    while not Eof do
    begin
//      if i = vMYTS then Break;
      inc(i);
      if i mod 100 = 0 then
        btn_cx.Caption := '查询中'+StrLeft(StrRep('.',(i div 100) Mod 4)+'   ',3);
      if Bz = 0 then
      begin
        Items.Add.Caption := '';
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sSjg').AsString);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sJg').AsString);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sCpbh').AsString);
        if YearOf(FieldByName('JSRQ').AsDateTime)>2000 then
          sDate := FormatDateTime('yyyy-MM-dd hh:mm:ss',FieldByName('JSRQ').AsDateTime)
        else
          sDate := '';
        Items.Item[Items.Count -1].SubItems.Add(sDate);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sKhmc').AsString);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('CPLX').AsString);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sYztmc').AsString);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_nYl').AsString);
        case FieldByName('F_tiJybz').AsInteger of
          0: sJybz:= '无';
          1: sJybz:= '加印';
        end;
        Items.Item[Items.Count -1].SubItems.Add(sJybz);
        case FieldByName('F_tiXpl').AsInteger of
          0: sXpl := '否';
          1: sXpl := '小批量';
        end;
        Items.Item[Items.Count -1].SubItems.Add(sXpl);
        case FieldByName('F_tiQy').AsInteger of
          0: sQy:= '不签样';
          1: sQy:= '签样';
          2: sQy:= '电子签样';
        end;
//        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_tiQyfs').AsString);
        Items.Item[Items.Count -1].SubItems.Add(sQy);
        case FieldByName('F_iTgzt').AsInteger of
          c_wsd: sTgzt := '图稿未收到';
          c_ysd: sTgzt := '图稿已收到';
          c_whg: sTgzt := '图稿未合格';
          c_yhg: sTgzt := '图稿已合格';
          c_dy : sTgzt := '已打样';
          c_yqy: sTgzt := '已签样';
          c_dcl: sTgzt := '图稿待处理';
        else
          sTgzt := FieldByName('F_iTgzt').AsString
        end;
        Items.Item[Items.Count -1].SubItems.Add(sTgzt);
//        iCzrID := FieldByName('F_iCzrID').AsInteger;
//        sCzr := DM_DataBase.GetTableFirst('Select F_sName from BI_UserList where F_iID='+IntToStr(iCzrID));
//        Items.Item[Items.Count -1].SubItems.Add(sCzr);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('Czr').AsString);
        if YearOf(FieldByName('F_dCzrq').AsDateTime)>2000 then
          sDate := FormatDateTime('yyyy-MM-dd',FieldByName('F_dCzrq').AsDateTime)
        else
          sDate := '';
        Items.Item[Items.Count -1].SubItems.Add(sDate);
        case FieldByName('F_iFktgzt').AsInteger of
          c_wsd: sFkzt := '图稿未收到';
          c_ysd: sFkzt := '图稿已收到';
          c_whg: sFkzt := '图稿未合格';
          c_yhg: sFkzt := '图稿已合格';
          c_dy : sFkzt := '已打样';
          c_yqy: sFkzt := '已签样';
          c_dcl: sFkzt := '图稿待处理';
        else
          sFkzt := FieldByName('F_iFktgzt').AsString
        end;
        Items.Item[Items.Count -1].SubItems.Add(sFkzt);
//        iFkrID := FieldByName('F_iFkrID').AsInteger;
//        sFkr := DM_DataBase.GetTableFirst('Select F_sName from BI_UserList where F_iID='+IntToStr(iFkrID));
//        Items.Item[Items.Count -1].SubItems.Add(sFkr);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('Fkr').AsString);
        if YearOf(FieldByName('F_dFkrq').AsDateTime)>2000 then
          sDate := FormatDateTime('yyyy-MM-dd',FieldByName('F_dFkrq').AsDateTime)
        else
          sDate := '';
        Items.Item[Items.Count -1].SubItems.Add(sDate);

        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_tiNjbs').AsString);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_iDetailsID').AsString);
        Items.Item[Items.Count -1].SubItems.Add(IntToStr(BZ));
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_iID').AsString);
      end else
      if Bz=1 then
      begin
        Items.Add.Caption := '';
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sSjg').AsString);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sJg').AsString);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sCpbh').AsString);
        if YearOf(FieldByName('JSRQ').AsDateTime)>2000 then
          sDate := FormatDateTime('yyyy-MM-dd hh:mm:ss',FieldByName('JSRQ').AsDateTime)
        else
          sDate := '';
        Items.Item[Items.Count -1].SubItems.Add(sDate);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sCpmc').AsString);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('CPLX').AsString);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_sYztmc').AsString);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_nYl').AsString);
        case FieldByName('F_tiJybz').AsInteger of
          0: sJybz:= '无';
          1: sJybz:= '加印';
        end;
        Items.Item[Items.Count -1].SubItems.Add(sJybz);
        case FieldByName('F_tiXpl').AsInteger of
          0: sXpl := '否';
          1: sXpl := '小批量';
        end;
        Items.Item[Items.Count -1].SubItems.Add(sXpl);
        case FieldByName('F_tiQy').AsInteger of
//        case 0 of
          0: sQy:= '不签样';
          1: sQy:= '签样';
        end;
//        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_tiQyfs').AsString);
        Items.Item[Items.Count -1].SubItems.Add(sQy);
        case FieldByName('F_iTgzt').AsInteger of
          c_wsd: sTgzt := '图稿未收到';
          c_ysd: sTgzt := '图稿已收到';
          c_whg: sTgzt := '图稿未合格';
          c_yhg: sTgzt := '图稿已合格';
          c_dy : sTgzt := '已打样';
          c_yqy: sTgzt := '已签样';
          c_shz: sTgzt := '图稿审核中';
        else
          sTgzt := FieldByName('F_iTgzt').AsString
        end;
        Items.Item[Items.Count -1].SubItems.Add(sTgzt);
//        iCzrID := FieldByName('F_iCzrID').AsInteger;
//        sCzr := DM_DataBase.GetTableFirst('Select F_sName from BI_UserList where F_iID='+IntToStr(iCzrID));
//        Items.Item[Items.Count -1].SubItems.Add(sCzr);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('Czr').AsString);
        if YearOf(FieldByName('F_dCzrq').AsDateTime)>2000 then
          sDate := FormatDateTime('yyyy-MM-dd',FieldByName('F_dCzrq').AsDateTime)
        else
          sDate := '';
        Items.Item[Items.Count -1].SubItems.Add(sDate);

        case FieldByName('F_iFktgzt').AsInteger of
          c_wsd: sFkzt := '图稿未收到';
          c_ysd: sFkzt := '图稿已收到';
          c_whg: sFkzt := '图稿未合格';
          c_yhg: sFkzt := '图稿已合格';
          c_dy : sFkzt := '已打样';
          c_yqy: sFkzt := '已签样';
        else
          sFkzt := FieldByName('F_iFktgzt').AsString
        end;
        Items.Item[Items.Count -1].SubItems.Add(sFkzt);
//        iFkrID := FieldByName('F_iCzrID').AsInteger;
//        sFkr := DM_DataBase.GetTableFirst('Select F_sName from BI_UserList where F_iID='+IntToStr(iFkrID));
//        Items.Item[Items.Count -1].SubItems.Add(sFkr);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('Fkr').AsString);
        if YearOf(FieldByName('F_dFkrq').AsDateTime)>2000 then
          sDate := FormatDateTime('yyyy-MM-dd',FieldByName('F_dFkrq').AsDateTime)
        else
          sDate := '';
        Items.Item[Items.Count -1].SubItems.Add(sDate);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_tiNjbs').AsString);
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_iDetailsID').AsString);
        Items.Item[Items.Count -1].SubItems.Add(IntToStr(BZ));
        Items.Item[Items.Count -1].SubItems.Add(FieldByName('F_iID').AsString);
      end;
      Next;
    end;
  end;
  btn_cx.Caption := '查询';
  lv_jhxd.Items.EndUpdate;
//  gb_dd.Caption := '订单  总数:'+IntToStr(in)+'条';

end;

procedure TFra_tg.lv_jhxdMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Point: TPoint;
  sCpbh: string;
  iType,iNJBZ: integer;
begin
  if (X <= 20) then
  begin
    if Assigned(TRzListView(Sender).GetItemAt(X,Y)) then
      TRzListView(Sender).ItemIndex := TRzListView(Sender).GetItemAt(X,Y).Index;
  end;
  if Button = mbRight then
  begin
    if Assigned(TListView(Sender).Selected) and (X > 20) then
    begin
      //if menu_ddmxPic.Tag = c_Tag_MakeAllow then
      begin
        iType := StrToNum(TListView(Sender).Selected.SubItems.Strings[TListView(Sender).Selected.SubItems.Count-2]);
        if iType = 1 then
          menu_ddmxPic.Visible := False
        else
          menu_ddmxPic.Visible := True;
        menu_cxfj.Visible := False;
        sCpbh:= TListView(Sender).Selected.SubItems.Strings[c_CPBH];
  //      if StrRight(sCpbh,4)='-999' then          //暂不限制重新分解订单的显示
          menu_cxfj.Visible := True;
        iNJBZ := StrToNum(TListView(Sender).Selected.SubItems.Strings[TListView(Sender).Selected.SubItems.Count-4]);
        if iNJBZ = 0 then
          menu_NJDel.Visible := False
        else
          menu_NJDel.Visible := True;
      end;
      GetCursorPos(Point);
      pm_jhxd.Popup(Point.X,Point.Y)
    end;
  end else
  if (Button = mbleft) and (X > 20) then
  begin
    if not Assigned(TRzListView(Sender).Selected) then Exit;
    TRzListView(Sender).Selected.Checked := not TRzListView(Sender).Selected.Checked;
  end;

end;

procedure TFra_tg.menu_ddmxClick(Sender: TObject);
var
  SelItem: TListItem;
  iType,iOrderID: integer;
begin
  SelItem := lv_jhxd.Selected;
  if not Assigned(SelItem) then Exit;
  iOrderID := StrToNum(SelItem.SubItems.Strings[SelItem.SubItems.Count-1]);
  iType := StrToNum(SelItem.SubItems.Strings[SelItem.SubItems.Count-2]);

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

procedure TFra_tg.cbb_cplbChange(Sender: TObject);
var
  iProductCategoryID: Integer;
begin
  iProductCategoryID := FindProductCategoryID(cbb_cplb.ItemIndex);
  cbb_cplx.Clear;
  cbb_cplx.Items.Add('--全部--');
  CbbAdd(cbb_cplx,pkProductType,iProductCategoryID);
  cbb_cplx.ItemIndex := 0;
end;

procedure TFra_tg.lv_jhxdCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if (Item.Index mod 2) = 0 then
    Sender.Canvas.Brush.Color := $00F0FFF0
  else
    Sender.Canvas.Brush.Color := $00F2F2F2;
  LVDrawItem(TRzListView(Sender), Item, State, DefaultDraw);
end;

procedure TFra_tg.menu_cxfjClick(Sender: TObject);
var
  SelItem: TListItem;
  iOrderID,iType: integer;
begin
  if TMenuItem(Sender).Name = 'menu_cxfj' then
    SelItem := lv_jhxd.Selected;
  if not Assigned(SelItem) then Exit;
  iOrderID := StrToIntDef(SelItem.SubItems.Strings[SelItem.SubItems.Count-1],0);
  iType := StrToIntDef(SelItem.SubItems.Strings[SelItem.SubItems.Count-2],0);
  Frm_FJ := TFrm_FJ.Create(Self);
  Frm_FJ.ReadDataYL(iOrderID,iType);
  Frm_FJ.ShowModal;
  if Frm_FJ.vSucceed then
    btn_cx.Click;
  Frm_FJ.Free;

end;

procedure TFra_tg.menu_delClick(Sender: TObject);
var
  SelItem: TListItem;
  iOrderID,iType: integer;
  sCpbh: string;
begin
  SelItem := lv_jhxd.Selected;
  if not Assigned(SelItem) then Exit;
  iOrderID := StrToIntDef(SelItem.SubItems.Strings[SelItem.SubItems.Count-1],0);
  iType := StrToIntDef(SelItem.SubItems.Strings[SelItem.SubItems.Count-2],0);
  sCpbh := SelItem.SubItems.Strings[c_CPBH];
  Frm_DDCX_BZ := TFrm_DDCX_BZ.Create(Self);
  Frm_DDCX_BZ.lab_cpbh.Caption := sCpbh;
  Frm_DDCX_BZ.vOrderID := iOrderID;
  Frm_DDCX_BZ.vOrderType := iType;
  if Frm_DDCX_BZ.ShowModal = mrok then
    btn_cx.Click;
  Frm_DDCX_BZ.Free;
end;

procedure TFra_tg.btn_goClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  iYs: Integer;
begin
  Screen.Cursor := crHourGlass;
  iYs := StrToNum(edt_ys.Text);
  ADO_Rec := DM_DataBase.OpenQuery(vSqlData,[iYs,vMYTS]);
  ReadDataJHXD(ADO_Rec,vOrderType);
  lab_zys.Caption := '页次：'+IntToStr(iYs)+'/'+ IntToStr(lab_zys.Tag);
  vYs := iYs;
  Screen.Cursor := crDefault;
end;

procedure TFra_tg.edt_ysKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key) = VK_RETURN then
    btn_go.Click;
  if ((Ord(Key) < Ord('0')) or (Ord(Key)>Ord('9'))) and (Ord(Key)<> VK_BACK)  then
    Key := #0;

end;

procedure TFra_tg.lab_firstClick(Sender: TObject);
begin
  if vYs = 1 then Exit;
  edt_ys.Text := '1';
  btn_go.Click;
end;

procedure TFra_tg.lab_lastClick(Sender: TObject);
begin
  if vYs = lab_zys.Tag then Exit;
  edt_ys.Text := IntToStr(lab_zys.Tag);
  btn_go.Click;

end;

procedure TFra_tg.lab_upClick(Sender: TObject);
begin
  if vYs > 1 then
  begin
    edt_ys.Text := IntToStr(vYs -1);
    btn_go.Click;
  end;
end;

procedure TFra_tg.lab_downClick(Sender: TObject);
begin
  if vYs < lab_zys.Tag then
  begin
    edt_ys.Text := IntToStr(vYs +1);
    btn_go.Click;
  end;
end;

procedure TFra_tg.lab_ts50Click(Sender: TObject);
var
  ADO_Rec: TADOQuery;
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
  ReadDataJHXD(ADO_Rec,vOrderType);
  ADO_Rec.Free;
  vYs := 1;
  lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);

end;

procedure TFra_tg.FraShow;
var
  str: string;
begin
    btn_fk.Visible := False;
    btn_ok.Visible := True;

    if cbb_tgzt.ItemIndex = -1 then
      cbb_tgzt.ItemIndex := 0;

    cbb_tgzt.Enabled := True;
    with cbb_llzt.Items do
    begin
      Clear;
      Add('--请选择--');
      Add('图稿未收到');
      Add('图稿已收到');
  //    Add('打样中');
      Add('图稿未合格');
      Add('图稿已合格');
      Add('已打样');
      Add('图稿待处理');
  //    Add('已签样');
    end;
    //获取产品类别
    str := cbb_cplb.Text;
    cbb_cplb.Clear;
    cbb_cplb.Items.Add('--全部--');
    CbbAdd(cbb_cplb,pkProductCategory);
    cbb_cplb.ItemIndex := cbb_cplb.Items.IndexOf(str);
    if cbb_cplb.ItemIndex = -1 then
      cbb_cplb.ItemIndex := c_Default_CPLB;       //默认选择邮政贺卡

    str := cbb_cplx.Text;
    cbb_cplx.Clear;
    cbb_cplx.Items.Add('--全部--');
    CbbAdd(cbb_cplx,pkProductType,FindProductCategoryID(cbb_cplb.ItemIndex));
    cbb_cplx.ItemIndex := cbb_cplx.Items.IndexOf(str);
    if cbb_cplx.ItemIndex = -1 then
      cbb_cplx.ItemIndex := 0;

    if cbb_llzt.ItemIndex = -1 then
      cbb_llzt.ItemIndex := 0;
    if cbb_bb.ItemIndex = -1 then
      cbb_bb.ItemIndex := 0;

    CustomLvAdd;

  f_MakeAllow;
  edt_bz.Visible := False;
end;

function TFra_tg.f_MakeAllow: Boolean;
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
  iAllowID, iAllowCode: Integer;
begin
  Result := False;
  case LoginData.m_iUserType of
    c_User_Small,c_Admin_Small:
      begin
        cbb_xpl.Enabled := False;
      end;
  end;

  if LoginData.m_iAllowCode >= 0 then
  begin
    iAllowCode := LoginData.m_iAllowCode;
    sSqlData := 'Select F_iID,F_sCode from Set_AllowInfo where F_tiStatus = 1 and F_sCode in(''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'') order by F_iID';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[c_Allow_FWDDTG,c_Allow_TG_CXCFDD,c_Allow_TG_DDSC,c_Allow_TG_DDSCNJBYS,c_Allow_XSDHGDQY,c_Allow_TG_ZTSH,c_Allow_TG_DDCY],False);
    if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
    begin
      while not ADO_Rec.Eof do
      begin
        iAllowID := ADO_Rec.FieldByName('F_iID').AsInteger;
        if ADO_Rec.FieldByName('F_sCode').AsString = c_Allow_FWDDTG then
        begin
          if 1 shl iAllowID or iAllowCode = iAllowCode then
          begin
            menu_ddmxPic.Enabled := True;
            menu_ddmxPic.Tag := c_Tag_MakeAllow;
          end else
          begin
            menu_ddmxPic.Enabled := False;
            menu_ddmxPic.Tag := 0;
          end;
        end else
        if ADO_Rec.FieldByName('F_sCode').AsString = c_Allow_TG_CXCFDD then
        begin
          if 1 shl iAllowID or iAllowCode = iAllowCode then
          begin
            menu_cxfj.Enabled := True;
            menu_cxfj.Tag := c_Tag_MakeAllow;
          end else
          begin
            menu_cxfj.Enabled := False;
            menu_cxfj.Tag := 0;
          end;
        end else
        if ADO_Rec.FieldByName('F_sCode').AsString = c_Allow_TG_DDCY then
        begin
          if 1 shl iAllowID or iAllowCode = iAllowCode then
          begin
            menu_ddcy.Enabled := True;
            menu_ddcy.Tag := c_Tag_MakeAllow;
          end else
          begin
            menu_ddcy.Enabled := False;
            menu_ddcy.Tag := 0;
          end;
        end else
        if ADO_Rec.FieldByName('F_sCode').AsString = c_Allow_TG_DDSC then
        begin
          if 1 shl iAllowID or iAllowCode = iAllowCode then
          begin
            menu_del.Enabled := True;
            menu_del.Tag := c_Tag_MakeAllow;
          end else
          begin
            menu_del.Enabled := False;
            menu_del.Tag := 0;
          end;
        end else
        if ADO_Rec.FieldByName('F_sCode').AsString = c_Allow_TG_DDSCNJBYS then
        begin
          if 1 shl iAllowID or iAllowCode = iAllowCode then
          begin
            menu_NJDel.Enabled := True;
            menu_NJDel.Tag := c_Tag_MakeAllow;
          end else
          begin
            menu_NJDel.Enabled := False;
            menu_NJDel.Tag := 0;
          end;
        end else
        if ADO_Rec.FieldByName('F_sCode').AsString = c_Allow_XSDHGDQY then
        begin
          if 1 shl iAllowID or iAllowCode = iAllowCode then
          begin
            if cbb_tgzt.Items.IndexOf('发货待合格') < 0 then
              cbb_tgzt.Items.Add('发货待合格');
            if cbb_tgzt.Items.IndexOf('发货待签样') < 0 then
              cbb_tgzt.Items.Add('发货待签样');
          end else
          begin
            if cbb_tgzt.Items.IndexOf('发货待合格') >= 0 then
              cbb_tgzt.Items.Delete(cbb_tgzt.Items.IndexOf('发货待合格'));
            if cbb_tgzt.Items.IndexOf('发货待签样') >= 0 then
              cbb_tgzt.Items.Delete(cbb_tgzt.Items.IndexOf('发货待签样'));
          end;
        end else
        if ADO_Rec.FieldByName('F_sCode').AsString = c_Allow_TG_ZTSH then
        begin
          if 1 shl iAllowID or iAllowCode = iAllowCode then
          begin
            cbb_llzt.Enabled := True;
            btn_fk.Enabled := True;
            btn_ok.Enabled := True;
            cbb_llzt.Tag := c_Tag_MakeAllow;
            btn_fk.Tag := c_Tag_MakeAllow;
            btn_ok.Tag := c_Tag_MakeAllow;
          end else
          begin
            cbb_llzt.Enabled := False;
            btn_fk.Enabled := False;
            btn_ok.Enabled := False;
            cbb_llzt.Tag := 0;
            btn_fk.Tag := 0;
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

procedure TFra_tg.menu_NJDelClick(Sender: TObject);
var
  SelItem: TListItem;
  iOrderID,iType: integer;
  sSqlData, sCpbh, str: string;
  ADOQ_Rec: TADOQuery;
begin
  SelItem := lv_jhxd.Selected;
  if not Assigned(SelItem) then Exit;
  iOrderID := StrToIntDef(SelItem.SubItems.Strings[SelItem.SubItems.Count-1],0);
  iType := StrToIntDef(SelItem.SubItems.Strings[SelItem.SubItems.Count-2],0);
  sCpbh := SelItem.SubItems.Strings[c_CPBH];
  str := '产品编号：'+sCpbh+ '(内件)'+#13#10 +'撤销原因：不印刷' +#13#10+'是否撤销内件?';
  if p_MessageBoxDlg(str,'提示',MB_YESNO+MB_ICONINFORMATION) = IDNO then
    Exit;
  try
    DM_DataBase.Con_YDPrint.BeginTrans;
    case iType of
      0:sSqlData := Format(' Update BI_CustomOrderDetails Set F_tiNJBS=0 where F_iID=%d ',[iOrderID]);
      1:sSqlData := Format(' Update BI_SellOrderDetails Set F_tiNJBS=0 where F_iID=%d ',[iOrderID]);
    else
      sSqlData := '';
    end;

    sSqlData := sSqlData +' Update DO_OrderApart set F_tiCXBZ=1,F_sCXYY=''%s'',F_sCXRBM=''%s'',F_dCXRQ=getdate() where F_tiCXBZ=0 and F_tiNJBZ=1 and F_tiOrderType=%d and F_iOrderID=%d';
    DM_DataBase.ExecQuery(sSqlData,['不印刷',LoginData.m_sUserName,iType,iOrderID],True);

    str := '产品编号：'+sCpbh+ ' 内件撤销成功';
    p_MessageBoxDlg(str);
    DM_DataBase.Con_YDPrint.CommitTrans;
  except
    on E: Exception do
    begin
      DM_DataBase.Con_YDPrint.RollbackTrans;
      p_MessageBoxDlg('产品编号：'+sCpbh+ ' 内件撤销失败：'+e.Message);
    end;
  end;
end;

procedure TFra_tg.menu_ddcyClick(Sender: TObject);
var
  SelItem: TListItem;
  iOrderID,iType: integer;
  sSqlData, sCpbh, str: string;
  ADOQ_Rec: TADOQuery;
  sYL: string;
begin
  SelItem := lv_jhxd.Selected;
  if not Assigned(SelItem) then Exit;
  iOrderID := StrToIntDef(SelItem.SubItems.Strings[SelItem.SubItems.Count-1],0);
  iType := StrToIntDef(SelItem.SubItems.Strings[SelItem.SubItems.Count-2],0);
  sCpbh := SelItem.SubItems.Strings[c_CPBH];
  str := '产品编号：'+sCpbh+#13#10 +'是否订单重印?';
  if p_MessageBoxDlg(str,'提示',MB_YESNO+MB_ICONINFORMATION) = IDNO then
    Exit;
  sYL := StrToNum(SelItem.SubItems.Strings[c_yl])*10000;
  str := '请输入重印数量(枚):';
  if (StrRight(sCpbh,3) = '999') or (InputQueryEH('录入',str,sYL)) then
  begin
    try
      sYL :=  StrToNum(sYL) / 10000;
      if StrRight(sCpbh,3) = '999' then sYL := 'F_nYL';
      sSqlData := 'Insert into DO_OrderApart(F_iOrderID,F_tiOrderType,F_sCPBH,F_nYL,F_sYztmc,F_sTSGY,F_iXGR_TSGY,F_iCZR,F_dCXRQ,F_tiNJBZ,F_tiCXBZ,F_tiCYBZ) '
        + 'select F_iOrderID,F_tiOrderType,F_sCPBH,%s,F_sYztmc,F_sTSGY,F_iXGR_TSGY,F_iCZR,F_dCXRQ,F_tiNJBZ,0,1 '
        + 'from DO_OrderApart where F_tiOrderType=%d and F_iOrderID=%d and F_tiCXBZ=0';
      DM_DataBase.ExecQuery(sSqlData,[sYL,iType,iOrderID],True);
      str := '产品编号：'+sCpbh+ ' 重印订单生成成功!';
      p_MessageBoxDlg(str);
    except
      on E: Exception do
      begin
        p_MessageBoxDlg('产品编号：'+sCpbh+ ' 重新生成订单失败：'+e.Message);
      end;
    end;
  end;
end;

procedure TFra_tg.btn_exportClick(Sender: TObject);
var
  dbg: TDBGridEh;
  ds: TDataSource;
begin
  if SavePath.Execute then
  begin
    if (SavePath.FileName <> '') then
      if UpperCase(Copy(SavePath.FileName,Length(SavePath.FileName)-4,Length(SavePath.FileName))) = UpperCase('.xls') then
        SavePath.FileName := Copy(SavePath.FileName,1,Length(SavePath.FileName)-4);
    Screen.Cursor := crHourGlass;
    try
      ExportExcelFile(SavePath.FileName,True,TListView(lv_jhxd));
    except

    end;
    Screen.Cursor := crDefault;
    p_MessageBoxDlg('导出成功!')
  end;

end;

{procedure TFra_tg.btn_exportClick(Sender: TObject);
var
  ExcelApplication1, ExcelWorkbook1: oleVariant;
  i, j: Integer;
begin
  ExportExcelFile('c:\11.xls',True,TListView(lv_jhxd));
  Exit;
    try
      ExcelApplication1 := CreateOleObject('Excel.Application');
      ExcelWorkbook1 := CreateOleObject('Excel.sheet');
    except
      Application.MessageBox('无法打开Xls文件，请确认已经安装EXCEL.', '',
        mb_OK + mb_IconStop);
      exit;
    end;
    ExcelWorkbook1 := ExcelApplication1.WorkBooks.Add;
    ExcelApplication1.Visible := true;
    for j := 1 to lv_jhxd.Columns.Count -1 do
    begin
      ExcelWorkbook1.WorkSheets[1].Cells[1, j].Value := lv_jhxd.Columns.Items[j].Caption;
    end;

    try
      for i := 0 to lv_jhxd.Items.Count - 1 do
      begin
        for j := 0 to lv_jhxd.Columns.Count -2 do
        begin
          ExcelWorkbook1.WorkSheets[1].Cells[2 + i, j+1].Value := lv_jhxd.Items[i].SubItems.Strings[j];
        end;
      end;
    except
    end;
    ExcelApplication1 := Unassigned; //释放VARIANT变量
end;    }

procedure TFra_tg.cbb_llztChange(Sender: TObject);
begin
  if cbb_llzt.ItemIndex = 6 then
    edt_bz.Visible := True
  else
    edt_bz.Visible := False;
end;

constructor TFra_tg.Create(AOwner: TComponent);
begin
  inherited;
  cbb_xpl.Enabled := True;
  cbb_xpl.ItemIndex := 0;
  case LoginData.m_iUserType of
    c_User:
      cbb_xpl.ItemIndex := 1;
    c_Admin:
      cbb_xpl.ItemIndex := 1;
    c_User_Small:
      begin
        cbb_xpl.ItemIndex := 2;
        cbb_xpl.Enabled := False;
      end;
    c_Admin_Small:
      begin
        cbb_xpl.ItemIndex := 2;
        cbb_xpl.Enabled := False;
      end;
    c_SuperAdmin:;
  end;
end;

end.






