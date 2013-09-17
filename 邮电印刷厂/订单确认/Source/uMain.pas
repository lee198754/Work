unit uMain;

interface
                                        
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, uFratg, uFrascgl, uFraYZTGL,
  uFraddcx, uFraUserAdd, uFra_ywtj, uFra_sctj, uFrakd, uFragdcx,
  uFra_cplx_gl, uFraWorkerManage, uFraParamSet, ComCtrls, RzGroupBar,
  RzPanel, RzSplit, uDM_DataBase,
  iComboBox, ADODB, RzButton, uFra_FHGL, uFra_FHGL_DYCX, StdCtrls,
  ImgList, RzListVw, RzTabs, uFra_CLTJ, uFra_CLRK, uFra_CPYBB, uFra_WGYBB,
  uFra_JTTJ, uFra_FHTJ, uFra_DDLR, uFra_FYDHLR, uFra_FHFK, uFra_ZBGX_GL,
  uFra_CPLB_GL, uFra_XHQD, uMachineManage, uFra_MatlManage,
  uFra_Pwd_Modify, uFra_DDJY_CX,  uFra_XQCX, uFra_YSMDDY,
  XPStyleActnCtrls, ActnMan, ActnList, msxmldom,uFra_WYNJQD,uFrm_TSGYGL,
  uFrm_BulletinBoard,uFra_WarehEntryBarCode,uFra_DataArchiving, Menus,uBaseForm,
  iGrid;


type
  TLoadBulletinThread=class(TThread)
  private
    g_MaxID: Integer;
    Con_Bulletin: TADOConnection;
    viLoadBulletinTime: Integer;
    procedure  p_LoadBulletinBoard;    //加载公告栏
  protected
    procedure   Execute;override;
  end;

  TFrm_Main = class(TForm)
    RzSizePanel1: TRzSizePanel;
    gb_Menu: TRzGroupBar;
    rg_sys_ddgl: TRzGroup;
    rg_gdgl: TRzGroup;
    rg_yhgl: TRzGroup;
    stat_zt: TStatusBar;
    rg_scgl: TRzGroup;
    rg_SysManage: TRzGroup;
    Fra_WorkerManage1: TFra_WorkerManage;
    Fra_cplx_gl1: TFra_cplx_gl;
    Fra_DDJY_CX1: TFra_DDJY_CX;
    Fra_Pwd_Modify1: TFra_Pwd_Modify;
    Fra_MatlManage1: TFra_MatlManage;
    Fra_MachineManage1: TFra_MachineManage;
    Fra_XHQD1: TFra_XHQD;
    Fra_CPLB_GL1: TFra_CPLB_GL;
    Fra_ZBGX_GL1: TFra_ZBGX_GL;
    Fra_ywtj1: TFra_ywtj;
    Fra_scgl1: TFra_scgl;
    Fra_FYDHLR1: TFra_FYDHLR;
    Fra_sctj1: TFra_sctj;
    rg_tjbb: TRzGroup;
    fra_gdcx1: Tfra_gdcx;
    Fra_FHGL_DYCX1: TFra_FHGL_DYCX;
    Fra_JTTJ1: TFra_JTTJ;
    rg_kcgl: TRzGroup;
    Fra_CLRK1: TFra_CLRK;
    Fra_CLTJ1: TFra_CLTJ;
    tmr_show: TTimer;
    tc_bulletin: TRzTabControl;
    lv_bulletin: TRzListView;
    ImageList1: TImageList;
    btn_Bulletin: TRzButton;
    btn_hide: TRzButton;
    Splitter1: TSplitter;
    gb_bulletin: TGroupBox;
    lab_bulletin: TLabel;
    RzButton1: TRzButton;
    Fra_kd1: TFra_kd;
    Fra_FHTJ1: TFra_FHTJ;
    actlst_ddgl: TActionList;
    act_ddlr: TAction;
    act_ddjy: TAction;
    act_ddcx: TAction;
    act_tgshnb: TAction;
    act_tgsh: TAction;
    actlst_gdgl: TActionList;
    act_kgd: TAction;
    act_gdcx: TAction;
    act_gdxg: TAction;
    actlist_scgl: TActionList;
    act_scgl_zb: TAction;
    act_scgl_ys: TAction;
    act_scgl_dh: TAction;
    act_scgl_hdjg: TAction;
    act_scgl_jc: TAction;
    act_scgl_xq: TAction;
    act_scgl_jcgrsm: TAction;
    act_scgl_fydhlrsm: TAction;
    act_scgl_ccddy: TAction;
    act_scgl_ccdcx: TAction;
    act_scgl_fhfk: TAction;
    act_scgl_ysmddy: TAction;
    actlist_tjbb: TActionList;
    act_tjbb_ywtj: TAction;
    act_tjbb_sctj: TAction;
    act_tjbb_fhtj: TAction;
    act_tjbb_cltj: TAction;
    act_tjbb_jttj: TAction;
    act_tjbb_xhtj: TAction;
    act_tjbb_zcpybb: TAction;
    act_tjbb_wgybb: TAction;
    act_tjbb_wynjqd: TAction;
    actlist_SysManage: TActionList;
    act_SysManage_cssz: TAction;
    act_SysManage_rygl: TAction;
    act_SysManage_yztgl: TAction;
    act_SysManage_cplbgl: TAction;
    act_SysManage_cplxgl: TAction;
    act_SysManage_clgl: TAction;
    act_SysManage_jtgl: TAction;
    act_SysManage_zbgxgl: TAction;
    act_SysManage_tsgygl: TAction;
    act_SysManage_sjgd: TAction;
    actlist_yhgl: TActionList;
    act_yhgl_yhsz: TAction;
    act_yhgl_xgmm: TAction;
    act_yhgl_zx: TAction;
    procedure FormShow(Sender: TObject);
    procedure RzGroup2Items1Click(Sender: TObject);
    procedure RzGroup2Items0Click(Sender: TObject);
    procedure RzGroup3Items0Click(Sender: TObject);
    procedure rg_scglItems0Click(Sender: TObject);
    procedure rg_SysManageItems0Click(Sender: TObject);
    procedure rg_SysManageItems1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rg_SysManageItems2Click(Sender: TObject);
    procedure rg_sys_ddglItems4Click(Sender: TObject);
    procedure rg_sys_ddglItems1Click(Sender: TObject);
    procedure rg_sys_ddglItems2Click(Sender: TObject);
    procedure rg_SysManageItems3Click(Sender: TObject);
    procedure rg_yhglItems1Click(Sender: TObject);
    procedure rg_sys_ddglItems3Click(Sender: TObject);
    procedure rg_sys_ddglItems0Click(Sender: TObject);
    procedure rg_yhglItems2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rg_scglItems9Click(Sender: TObject);
    procedure rg_scglItems11Click(Sender: TObject);
    procedure rg_SysManageItems4Click(Sender: TObject);
    procedure rg_SysManageItems5Click(Sender: TObject);
    procedure rg_SysManageItems6Click(Sender: TObject);
    procedure rg_SysManageItems7Click(Sender: TObject);
    procedure rg_scglItems12Click(Sender: TObject);
    procedure rg_tjbbItems0Click(Sender: TObject);
    procedure rg_tjbbItems1Click(Sender: TObject);
    procedure rg_tjbbItems2Click(Sender: TObject);
    procedure rg_tjbbItems3Click(Sender: TObject);
    procedure rg_tjbbItems4Click(Sender: TObject);
    procedure rg_tjbbItems5Click(Sender: TObject);
    procedure rg_tjbbItems6Click(Sender: TObject);
    procedure rg_tjbbItems7Click(Sender: TObject);
    procedure rg_kcglItems0Click(Sender: TObject);
    procedure rg_tjbbItems8Click(Sender: TObject);
    procedure btn_BulletinClick(Sender: TObject);
    procedure lv_bulletinDblClick(Sender: TObject);
    procedure lv_bulletinCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure btn_hideClick(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
    procedure rg_scglItems10Click(Sender: TObject);
    procedure tmr_showTimer(Sender: TObject);
    procedure rg_scglItems8Click(Sender: TObject);
    procedure rg_SysManageItems8Click(Sender: TObject);
    procedure rg_SysManageItems9Click(Sender: TObject);
    procedure rg_tjbbItems9Click(Sender: TObject);
  private
    { Private declarations }
    Fra_WYNJQD1: TFra_WYNJQD;
    Fra_XQCX1: TFra_XQCX;
    Fra_FHGL1: TFra_FHGL;
    Fra_ParamSet1: TFra_ParamSet;
    Fra_WGYBB1: TFra_WGYBB;
    Fra_CPYBB1: TFra_CPYBB;
    Fra_YSMDDY1: TFra_YSMDDY;
    Fra_FHFK1: TFra_FHFK;
    Fra_WarehEntryBarCode1: TFra_WarehEntryBarCode;
    Fra_tg1: TFra_tg;
    Fra_DDLR1: TFra_DDLR;
    Fra_DataArchiving1: TFra_DataArchiving;
    Fra_UserAdd1: TFra_UserAdd;
    Fra_yztgl1: TFra_yztgl;
    procedure FraHide(Sender: TObject);
    procedure MenuHide;
    procedure InitFra(Sender: TObject);
    procedure WriteLoginLog(sType: string);
    procedure ClearBold;
    function f_MakeAllow: Boolean;   //操作允许
    procedure AppException(Sender: TObject; E: Exception);
  public
    { Public declarations }
    Fra_DDCX1: TFra_ddcx;
    g_bIsRunAgain: Boolean;
  end;

var
  Frm_Main: TFrm_Main;
  vUrl: string;
  //vbThreadStopping: Boolean;  //(true: 线程暂停;False 线程继续)

implementation

uses
  uLogin, uPub_Type, uPub_Func, uDDMX_DZX, uDDMX_XSX, uPub_Text, PubStr, Math,
  DB,uYCXDDQDFrm;

{$R *.dfm}

  //function GetFra_XQCX:Fra_XQCX; External; 'D:\Borland\Delphi7\Bin\bin\Project2.dll' ;

var
  vbExecute: Boolean;
  LoadBulletinThread: TLoadBulletinThread;

procedure TFrm_Main.WriteLoginLog(sType: string);
var
  sSqlData,sUserName: string;
  ADO_Rec: TADOQuery;
  iUserID,iLoginID: Integer;
begin
  iUserID := LoginData.m_iUserID;
  sUserName := LoginData.m_sUserName;
  sSqlData := 'select * from  Log_LoginLog where 1=2';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
  if not Assigned(ADO_Rec) then Exit;
  ADO_Rec.Insert;
  ADO_Rec.FieldByName('F_iUserID').AsInteger := iUserID;
  ADO_Rec.FieldByName('F_sUserName').AsString := sUserName;
  ADO_Rec.FieldByName('F_sType').AsString := sType;
  ADO_Rec.FieldByName('F_sVersion').AsString := c_TitleName;
  ADO_Rec.Post;
  iLoginID := ADO_Rec.FieldByName('F_iID').AsInteger;
  ADO_Rec.Free;
  //sSqlData := 'Insert into Log_LoginLog (F_iUserID, F_sUserName,F_sType,F_sVersion) values (%d,''%s'',''%s'',''%s'')';
  //DM_DataBase.ExecQuery(sSqlData,[iUserID,sUserName,sType,c_TitleName],False);
  if sType = '登录' then
  begin
    LoginData.m_iLoginID := iLoginID;
    sSqlData := 'Update BI_UserList set F_tiOnLineFlag=%d  where F_iID=%d';
    DM_DataBase.ExecQuery(sSqlData,[1,iUserID],False);
  end else
  if sType = '退出' then
  begin
    sSqlData := 'Update BI_UserList set F_tiOnLineFlag=%d where F_iID=%d';
    DM_DataBase.ExecQuery(sSqlData,[0,iUserID],False);
  end;
end;


procedure TFrm_Main.FormShow(Sender: TObject);
var
  sType: string;
  //aField:TArrSelectField;
begin
  Application.OnException := AppException;
  f_MakeAllow;
  vbExecute := True;
  LoadBulletinThread := TLoadBulletinThread.Create(True);
  with LoadBulletinThread do
  begin
    viLoadBulletinTime := c_LoadBulletinTime;
    Con_Bulletin := TADOConnection.Create(Frm_Main);
    Con_Bulletin.Connected := False;
    Con_Bulletin.Close;
    Con_Bulletin.ConnectionString := DM_DataBase.vServicesConnect;
    Con_Bulletin.LoginPrompt := False;
    Con_Bulletin.Open;
    Resume;
  end;
  FraHide(nil);
  Caption := c_TitleName;
  WriteLoginLog('登录');
//  Fra_tg1.cbb_xpl.ItemIndex := 0;
  Fra_kd1.cbb_qyzt.Visible := True;    //显示签样状态
  //Fra_ddcx1.cbb_xpl.Enabled := True;     //小批量
  //Fra_tg1.cbb_xpl.Enabled := True;
  Fra_kd1.cbb_xpl.Enabled := True;
  //Fra_ddcx1.cbb_xpl.ItemIndex := 0;       //小批量标志
  //Fra_tg1.cbb_xpl.ItemIndex := 0;
  Fra_kd1.cbb_xpl.ItemIndex := 0;
  Fra_scgl1.cbb_xpl.ItemIndex := 0;
  Fra_gdcx1.cbb_xpl.ItemIndex := 0;
  case LoginData.m_iUserType of
    c_User:
      begin
        sType := '普通用户';
        //Fra_ddcx1.cbb_xpl.ItemIndex := 1;       //普通
        //Fra_tg1.cbb_xpl.ItemIndex := 1;
        Fra_kd1.cbb_xpl.ItemIndex := 1;
        Fra_scgl1.cbb_xpl.ItemIndex := 1;
        fra_gdcx1.cbb_xpl.ItemIndex := 1;
//        rg_user_dzxddgl.Visible := True;
//        rg_user_xsxddgl.Visible := True;

        rg_sys_ddgl.Visible := true;           //订单管理
//        rg_SysManage.Visible := False;
//        rg_yhgl.Visible := False;
      end;
    c_Admin:
      begin
        sType := '管理员';
        //Fra_ddcx1.cbb_xpl.ItemIndex := 1;       //普通
        //Fra_tg1.cbb_xpl.ItemIndex := 1;
        Fra_kd1.cbb_xpl.ItemIndex := 1;
        Fra_scgl1.cbb_xpl.ItemIndex := 1;
        fra_gdcx1.cbb_xpl.ItemIndex := 1;
        rg_SysManage.Visible := True;            //订单管理
        Fra_kd1.cbb_qyzt.Visible := True;         //显示签样状态
        rg_yhgl.Visible := True;
      end;
    c_User_Small:
      begin
        sType := '普通用户(小批量)';
        //Fra_ddcx1.cbb_xpl.ItemIndex := 2;       //小批量
        //Fra_tg1.cbb_xpl.ItemIndex := 2;
        Fra_kd1.cbb_xpl.ItemIndex := 2;
        Fra_scgl1.cbb_xpl.ItemIndex := 2;
        fra_gdcx1.cbb_xpl.ItemIndex := 2;
        //Fra_tg1.cbb_xpl.Enabled := False;
        Fra_kd1.cbb_xpl.Enabled := False;
        Fra_scgl1.cbb_xpl.Enabled := False;
{        Fra_ddcx1.cbb_xpl.Enabled := False;
        fra_gdcx1.cbb_xpl.Enabled := False;}
      end;
    c_Admin_Small:
      begin
        sType := '管理员(小批量)';
        //Fra_ddcx1.cbb_xpl.ItemIndex := 2;         //小批量
        //Fra_tg1.cbb_xpl.ItemIndex := 2;
        Fra_kd1.cbb_xpl.ItemIndex := 2;
        Fra_scgl1.cbb_xpl.ItemIndex := 2;
        fra_gdcx1.cbb_xpl.ItemIndex := 2;
        //Fra_tg1.cbb_xpl.Enabled := False;
        Fra_kd1.cbb_xpl.Enabled := False;
        Fra_scgl1.cbb_xpl.Enabled := False;
       { fra_gdcx1.cbb_xpl.Enabled := False;
        Fra_ddcx1.cbb_xpl.Enabled := False;}
        Fra_kd1.cbb_qyzt.Visible := True;         //显示签样状态
      end;
    c_SuperAdmin:
      begin
        sType := '超级管理员';
        rg_SysManage.Visible := True;
        rg_yhgl.Visible := True;
        Fra_kd1.cbb_qyzt.Visible := True;         //显示签样状态
      end;
  end;
  MenuHide;
  //stat_zt.Panels.Items[0].Text := '用户类型：'+sType;
  stat_zt.Panels.Items[c_ZT_YHLX].Text := sType;
//  stat_zt.Panels.Items[0].Width := 150;
  //stat_zt.Panels.Items[1].Text := '用户名：'+ LoginData.m_sUserName;
  stat_zt.Panels.Items[c_ZT_YHM].Text :=  LoginData.m_sRealName;
  stat_zt.Panels.Items[c_ZT_DLRQ].Text := FormatDateTime('yyyy-MM-dd',Now);
  stat_zt.Panels.Items[c_ZT_DLSJ].Text := FormatDateTime('hh:mm:ss',Now);

//  rg_yhgl.Opened := False;

end;

procedure TFrm_Main.FraHide(Sender: TObject);
var
  i: integer;
begin
//  Fra_tg1.DoubleBuffered := True;
//  Fra_tg1.RzGroupBox1.DoubleBuffered := True;
//  Fra_tg1.RzPanel1.DoubleBuffered := True;
//  Fra_tg1.RzGroupBox3.DoubleBuffered := True;
  Frm_Main.DoubleBuffered := True;
  Fra_kd1.DoubleBuffered := True;
  fra_gdcx1.DoubleBuffered := True;
  //Fra_ddcx1.DoubleBuffered := True;
  //Fra_UserAdd1.DoubleBuffered := True;
  Fra_scgl1.DoubleBuffered := True;
  Fra_WorkerManage1.DoubleBuffered := True;

  for i := 0 to Self.ComponentCount -1 do
  begin
    if Self.Components[i].ClassParent.ClassName = TFrame.ClassName then
      TFrame(Self.Components[i]).Visible := False
    else
    if Self.Components[i].ClassParent.ClassName = TForm.ClassName then
      TForm(Self.Components[i]).Visible := False
    else
    if Self.Components[i].ClassParent.ClassName = TFrmFrame.ClassName then
      TFrmFrame(Self.Components[i]).Visible := False;
  end;

  if Sender <> nil then
  begin
    ClearBold;
    TRzGroupItem(Sender).FontStyle := [fsBold];
    InitFra(Sender);
  end;
end;

procedure TFrm_Main.RzGroup2Items1Click(Sender: TObject);
var
  str: string;
begin
  Caption := c_TitleName +'--开工单';
  FraHide(Sender);
  Fra_kd1.Align := alclient;
//  Fra_kd1.CustomLvAdd;
  str := Fra_kd1.cbb_cplb.Text;
  Fra_kd1.cbb_cplb.Clear;
  Fra_kd1.cbb_cplb.Items.Add('--全部--');
  CbbAdd(Fra_kd1.cbb_cplb,pkProductCategory);
  Fra_kd1.cbb_cplb.ItemIndex := Fra_kd1.cbb_cplb.IndexOf(str);
  if Fra_kd1.cbb_cplb.ItemIndex = -1 then
    Fra_kd1.cbb_cplb.ItemIndex := c_Default_CPLB;       //默认选择邮政贺卡

  str := Fra_kd1.cbb_cplx.Text;
  Fra_kd1.cbb_cplx.Clear;
  Fra_kd1.cbb_cplx.Items.Add('--全部--');
  CbbAdd(Fra_kd1.cbb_cplx,pkProductType,FindProductCategoryID(Fra_kd1.cbb_cplb.ItemIndex));
  Fra_kd1.cbb_cplx.ItemIndex := Fra_kd1.cbb_cplx.IndexOf(str);
  if Fra_kd1.cbb_cplx.ItemIndex = -1 then
    Fra_kd1.cbb_cplx.ItemIndex := 0;

  if Fra_kd1.cbb_ddlx.ItemIndex = -1 then
    Fra_kd1.cbb_ddlx.ItemIndex := 0;

  Fra_kd1.FraShow;
  Fra_kd1.Visible := True;
  Application.ProcessMessages;
  Fra_kd1.btn_cx.Click;
end;

procedure TFrm_Main.RzGroup2Items0Click(Sender: TObject);
const
  c_gdcx = 1;
  c_gdxg = 2;
begin
  case TRzGroupItem(Sender).Tag  of
    c_gdcx:
      begin
        Caption := c_TitleName +'--工单查询';
        fra_gdcx1.vActionType := c_WorkOrder_Select;
        fra_gdcx1.cb_History.Visible := True;
        if LoginData.m_iUserType in [c_User_Small,c_Admin_Small] then   //小批量用户
          fra_gdcx1.cbb_xpl.Enabled := True;
      end;
     c_gdxg:
       begin
         Caption := c_TitleName +'--工单修改';
        fra_gdcx1.vActionType := c_WorkOrder_Modify;
        fra_gdcx1.cb_History.Visible := False;
        fra_gdcx1.cb_History.Checked := False;
        if LoginData.m_iUserType in [c_User_Small,c_Admin_Small] then   //小批量用户
        begin
          fra_gdcx1.cbb_xpl.Enabled := False;
          fra_gdcx1.cbb_xpl.ItemIndex := fra_gdcx1.cbb_xpl.IndexOf('是');
        end;
       end;
  else
    Caption := c_TitleName +'--工单查询';
    fra_gdcx1.vActionType := c_WorkOrder_Select;
  end;
  FraHide(Sender);
  fra_gdcx1.Align := alclient;
//  fra_gdcx1.Height := Self.Height;
//  fra_gdcx1.cbb_cx.ItemIndex := 1;  //未撤销
  fra_gdcx1.Visible := True;
  fra_gdcx1.FraShow;
  Application.ProcessMessages;
  fra_gdcx1.btn_cx.Click;
end;

procedure TFrm_Main.RzGroup3Items0Click(Sender: TObject);
begin
  FraHide(Sender);
  Caption := c_TitleName +'--用户设置';
end;

procedure TFrm_Main.rg_scglItems0Click(Sender: TObject);
const
  c_sczb=1;   //制版
  c_scys=2;   //印刷
  c_scdh=3;   //打号
  c_schdjg=4;   //后道加工
  c_scjc=5;      //进仓
  c_scfh=6;      //发货
  c_scfhdy=7;    //发货打印

  c_cx_ykd=0;   //已开单
  c_cx_sczb=1;   //制版
  c_cx_scys=2;   //印刷
  c_cx_scdh=3;   //打号
  c_cx_schdjg=4;   //后道加工
  c_cx_scjc=5;      //进仓
  c_cx_scfh=6;      //发货
  c_cx_yzbfnj=7;  //已印刷非内件
  c_cx_ydhhyysnj=8;  //已打号或已印刷内件
begin
  FraHide(Sender);
  Fra_scgl1.btn_ysdh.Visible := False;
  Fra_scgl1.vFraType := TRzGroupItem(Sender).Tag;
  case TRzGroupItem(Sender).Tag of
    c_sczb:
      begin
        Caption := c_TitleName +'--制版';
       // Fra_scgl1.btn_zbap.Visible := True;
        Fra_scgl1.cbb_sczt.ItemIndex := c_cx_sczb-1;
      end;
    c_scys:                                                                                                                                          
      begin
        Caption := c_TitleName +'--印刷';
        Fra_scgl1.cbb_sczt.ItemIndex := c_cx_scys-1;
        Fra_scgl1.btn_ysdh.Visible := True;
      end;
    c_scdh:
      begin
        Caption := c_TitleName +'--打号';
        Fra_scgl1.cbb_sczt.ItemIndex := c_cx_scdh-1;
      end;
    c_schdjg:
      begin
        Caption := c_TitleName +'--后道加工';
        Fra_scgl1.cbb_sczt.ItemIndex := c_cx_schdjg-1;
      end;
    c_scjc:
      begin
        Caption := c_TitleName +'--进仓';
        Fra_scgl1.cbb_sczt.ItemIndex := c_cx_scjc-1;
      end;
    c_scfh:
      begin
        Caption := c_TitleName +'--出仓单打印';
        //Fra_scgl1.cbb_sczt.ItemIndex := c_cx_scfh-1;
//        Fra_FHGL1.Align := alClient;
//        Fra_FHGL1.dtp_jcq.DateTime := Now;
//        Fra_FHGL1.dtp_jcz.DateTime := Now;
//        Fra_FHGL1.FrmShow;
//        Fra_FHGL1.Visible := True;
//        Application.ProcessMessages;
//        Fra_FHGL1.btn_cx.Click;
        Exit;
      end;
    c_scfhdy:
      begin
        Caption := c_TitleName +'--出仓单查询';
        //Fra_scgl1.cbb_sczt.ItemIndex := c_cx_scfh-1;
        Fra_FHGL_DYCX1.Align := alClient;
        Fra_FHGL_DYCX1.dtp_fpq.DateTime := Now;
        Fra_FHGL_DYCX1.dtp_fpz.DateTime := Now;
        Fra_FHGL_DYCX1.Visible := True;
        Fra_FHGL_DYCX1.FraShow;
        Application.ProcessMessages;
        Fra_FHGL_DYCX1.btn_cx.Click;
        Exit;
      end;
  end;
  Fra_scgl1.btn_zbap.Visible := False;
  Fra_scgl1.dtp_kdq.DateTime := Now;
  Fra_scgl1.dtp_kdz.DateTime := Now;
  Fra_scgl1.dtp_jhq.DateTime := Now;
  Fra_scgl1.dtp_jhz.DateTime := Now;
  Fra_scgl1.cbb_sczt.Enabled := False;
  Fra_scgl1.Align := alClient;
  Fra_scgl1.FraShow;
  Fra_scgl1.Visible := True;
  Application.ProcessMessages;
  Fra_scgl1.btn_cx.Click;
end;

procedure TFrm_Main.rg_SysManageItems0Click(Sender: TObject);
begin
//  FraHide(Sender);
//  Fra_ParamSet1.Align := alclient;
//  Fra_ParamSet1.RefreshTv;
//  Fra_ParamSet1.Visible := True;

  if not Assigned(Fra_ParamSet1) then
  begin
    Fra_ParamSet1 := TFra_ParamSet.Create(Self);
    Fra_ParamSet1.Parent := Self;
  end;
  FraHide(Sender);
  Fra_ParamSet1.Align := alClient;
  Fra_ParamSet1.FraShow;
  Fra_ParamSet1.Visible := True;

end;

procedure TFrm_Main.rg_SysManageItems1Click(Sender: TObject);
begin
  FraHide(Sender);
  Fra_WorkerManage1.Align := alclient;
  Fra_WorkerManage1.RefreshLv;
  Fra_WorkerManage1.Visible := True;
end;

procedure TFrm_Main.FormCreate(Sender: TObject);
begin
  vUrl := DM_DataBase.vUrl;
  Screen.Cursors[crHandPoint] := LoadCursor(0, IDC_HAND);
  g_bIsRunAgain := False;
end;

procedure TFrm_Main.rg_SysManageItems2Click(Sender: TObject);
begin
  Caption := c_TitleName +'--邮资图管理';
  FraHide(Sender);
//  Fra_yztgl1.Align := alclient;
//  Fra_yztgl1.ReadDataYZTXX;
//  Fra_yztgl1.cbb_cplb.Clear;
//  CbbAdd(Fra_yztgl1.cbb_cplb,pkProductCategory);
//  Fra_yztgl1.cbb_cplx.Clear;
//  Fra_yztgl1.cbb_cplb.ItemIndex := iif(c_Default_CPLB=0,0,c_Default_CPLB-1);       //默认选择邮政贺卡
//  CbbAdd(Fra_yztgl1.cbb_cplx,pkProductType,ProductCategory[1].m_iID);
//  Fra_yztgl1.Visible := True;
end;

procedure TFrm_Main.rg_sys_ddglItems4Click(Sender: TObject);
var
  str: string;
begin
  Caption := c_TitleName +'--订单查询';
  FraHide(Sender);
  Exit;
  Fra_ddcx1.Align := alclient;

  str := Fra_ddcx1.cbb_bb.Text;
  Fra_ddcx1.cbb_bb.ItemIndex := Fra_ddcx1.cbb_bb.Items.IndexOf(str);
  if Fra_ddcx1.cbb_bb.ItemIndex = -1 then
    Fra_ddcx1.cbb_bb.ItemIndex := 0;
  Fra_ddcx1.cbb_bb.Enabled := True;

  str := Fra_ddcx1.cbb_cplb.Text;
  Fra_ddcx1.cbb_cplb.Clear;
  Fra_ddcx1.cbb_cplb.Items.Add('--全部--');
  CbbAdd(Fra_ddcx1.cbb_cplb,pkProductCategory);
  Fra_ddcx1.cbb_cplb.ItemIndex := Fra_ddcx1.cbb_cplb.Items.IndexOf(str);
  if Fra_ddcx1.cbb_cplb.ItemIndex = -1 then
  Fra_ddcx1.cbb_cplb.ItemIndex := c_Default_CPLB;       //默认选择邮政贺卡

  str := Fra_ddcx1.cbb_cplx.Text;
  Fra_ddcx1.cbb_cplx.Clear;
  Fra_ddcx1.cbb_cplx.Items.Add('--全部--');
  CbbAdd(Fra_ddcx1.cbb_cplx,pkProductType,FindProductCategoryID(Fra_ddcx1.cbb_cplb.ItemIndex));
  Fra_ddcx1.cbb_cplx.ItemIndex := Fra_ddcx1.cbb_cplx.Items.IndexOf(str);
  if Fra_ddcx1.cbb_cplx.ItemIndex = -1 then
    Fra_ddcx1.cbb_cplx.ItemIndex := 0;

  Fra_ddcx1.FraShow;
  Fra_ddcx1.Visible := True;
  Application.ProcessMessages;
  Fra_ddcx1.btn_cx.Click;
end;

procedure TFrm_Main.rg_sys_ddglItems1Click(Sender: TObject);
var
  str: string;
begin
  Caption := c_TitleName +'--图稿审核(内部)';
  FraHide(Sender);
  Exit;
  Fra_tg1.Align := alclient;
//  Fra_tg1.Height := Self.Height;
  Fra_tg1.btn_fk.Visible := False;
  Fra_tg1.btn_ok.Visible := True;

  if Fra_tg1.cbb_tgzt.ItemIndex = -1 then
    Fra_tg1.cbb_tgzt.ItemIndex := 0;

  Fra_tg1.cbb_tgzt.Enabled := True;
  with Fra_tg1.cbb_llzt.Items do
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
  //Fra_tg1.btn_tgysd.Visible := False;    //隐藏已收到
  //Fra_tg1.cbb_bb.Enabled := True;        //显示版别

  str := Fra_tg1.cbb_cplb.Text;
  Fra_tg1.cbb_cplb.Clear;
  Fra_tg1.cbb_cplb.Items.Add('--全部--');
  CbbAdd(Fra_tg1.cbb_cplb,pkProductCategory);
  Fra_tg1.cbb_cplb.ItemIndex := Fra_tg1.cbb_cplb.Items.IndexOf(str);
  if Fra_tg1.cbb_cplb.ItemIndex = -1 then
    Fra_tg1.cbb_cplb.ItemIndex := c_Default_CPLB;       //默认选择邮政贺卡

  str := Fra_tg1.cbb_cplx.Text;
  Fra_tg1.cbb_cplx.Clear;
  Fra_tg1.cbb_cplx.Items.Add('--全部--');
  CbbAdd(Fra_tg1.cbb_cplx,pkProductType,FindProductCategoryID(Fra_tg1.cbb_cplb.ItemIndex));
  Fra_tg1.cbb_cplx.ItemIndex := Fra_tg1.cbb_cplx.Items.IndexOf(str);
  if Fra_tg1.cbb_cplx.ItemIndex = -1 then
    Fra_tg1.cbb_cplx.ItemIndex := 0;

  if Fra_tg1.cbb_llzt.ItemIndex = -1 then
    Fra_tg1.cbb_llzt.ItemIndex := 0;
  if Fra_tg1.cbb_bb.ItemIndex = -1 then
    Fra_tg1.cbb_bb.ItemIndex := 0;
    
  Fra_tg1.CustomLvAdd;
  Fra_tg1.FraShow;
  Fra_tg1.Visible := True;
  Application.ProcessMessages;
  Fra_tg1.btn_cx.Click;
end;

procedure TFrm_Main.rg_sys_ddglItems2Click(Sender: TObject);
var
  str: string;
begin
  Caption := c_TitleName +'--图稿审核';
  FraHide(Sender);
  Exit;
  Fra_tg1.Align := alclient;
//  Fra_tg1.Height := Self.Height;
  Fra_tg1.btn_fk.Visible := True;
  Fra_tg1.btn_ok.Visible := False;

  if Fra_tg1.cbb_tgzt.ItemIndex = -1 then
    Fra_tg1.cbb_tgzt.ItemIndex := 0;
  Fra_tg1.cbb_tgzt.Enabled := True;
  //  Fra_tg1.cbb_tgzt.EditLabel.Caption := '内部状态';
  with Fra_tg1.cbb_llzt.Items do
  begin
    Clear;
    Add('--请选择--');
    Add('图稿未收到');
    Add('图稿已收到');
    Add('图稿未合格');
    Add('图稿已合格');
    Add('已打样');
    Add('图稿待处理');
//    Add('已签样');
  end;

  //Fra_tg1.btn_tgysd.Visible := False;    //隐藏已收到
  //Fra_tg1.cbb_bb.Enabled := True;        //显示版别
  //获取产品类别
  str := Fra_tg1.cbb_cplb.Text;
  Fra_tg1.cbb_cplb.Clear;
  Fra_tg1.cbb_cplb.Items.Add('--全部--');
  CbbAdd(Fra_tg1.cbb_cplb,pkProductCategory);
  Fra_tg1.cbb_cplb.ItemIndex := Fra_tg1.cbb_cplb.Items.IndexOf(str);
  if Fra_tg1.cbb_cplb.ItemIndex = -1 then
    Fra_tg1.cbb_cplb.ItemIndex := c_Default_CPLB;       //默认选择邮政贺卡
  str := Fra_tg1.cbb_cplx.Text;
  Fra_tg1.cbb_cplx.Clear;
  Fra_tg1.cbb_cplx.Items.Add('--全部--');
  CbbAdd(Fra_tg1.cbb_cplx,pkProductType,FindProductCategoryID(Fra_tg1.cbb_cplb.ItemIndex));
  Fra_tg1.cbb_cplx.ItemIndex := Fra_tg1.cbb_cplx.Items.IndexOf(str);
  if Fra_tg1.cbb_cplx.ItemIndex = -1 then
    Fra_tg1.cbb_cplx.ItemIndex := 0;

  if Fra_tg1.cbb_llzt.ItemIndex = -1 then
   Fra_tg1.cbb_llzt.ItemIndex := 0;
  if Fra_tg1.cbb_bb.ItemIndex = -1 then
    Fra_tg1.cbb_bb.ItemIndex := 0;
    
  Fra_tg1.CustomLvAdd;
  Fra_tg1.FraShow;
  Fra_tg1.Visible := True;
  Application.ProcessMessages;
  Fra_tg1.btn_cx.Click;
end;

procedure TFrm_Main.rg_SysManageItems3Click(Sender: TObject);
begin
  FraHide(Sender);
  Fra_cplx_gl1.Align := alclient;
  Fra_cplx_gl1.ReadDataCPLXXX;
  Fra_cplx_gl1.cbb_cplb.Clear;
  CbbAdd(Fra_cplx_gl1.cbb_cplb,pkProductCategory);
  Fra_cplx_gl1.cbb_cplb.ItemIndex := iif(c_Default_CPLB=0,0,c_Default_CPLB-1);;       //默认选择邮政贺卡
  Fra_cplx_gl1.Visible := True;

end;

procedure TFrm_Main.MenuHide;
type
  TMenu = record
    Id: integer;
    Name: string;
    Status: integer;
    Comp: TRzGroupItem;
  end;
  PTMenu = ^TMenu;
var
  iLicenseCode: LONGLONG;
  i, j: integer;
  ADO_Rec: TADOQuery;
  sSqlData: string;
  MenuList: array of TMenu;
function FindMenu(sName: string): TRzGroupItem;
var
  i,j: integer;
begin
  Result := nil;
  for i := 0 to gb_Menu.ControlCount -1 do
  begin
    if gb_Menu.Controls[i]is TRzGroup then
    begin
      for j := 0 to TRzGroup(gb_Menu.Controls[i]).Items.Count -1 do
      begin
        if Trim(TRzGroup(gb_Menu.Controls[i]).Items.Items[j].Caption) = Trim(sName) then
        begin
          Result := TRzGroup(gb_Menu.Controls[i]).Items.Items[j];
          Exit;
        end;
      end;
    end;
  end;
end;
begin
  iLicenseCode := LoginData.m_iLicenseCode;
  rg_sys_ddgl.Visible := False;
  rg_gdgl.Visible := False;
  rg_scgl.Visible := False;
  rg_SysManage.Visible := False;
  rg_yhgl.Visible := False;
  rg_kcgl.Visible := False;
  sSqlData := 'Select * from Sys_MenuInfo where F_tiStatus = 1 order by F_iID';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
  SetLength(MenuList,ADO_Rec.RecordCount);
  for i := 0 to ADO_Rec.RecordCount -1 do
  begin
    MenuList[i].Id := ADO_Rec.FieldByName('F_iID').AsInteger;
    MenuList[i].Name := ADO_Rec.FieldByName('F_sMenuName').AsString;
    MenuList[i].Status  := ADO_Rec.FieldByName('F_tiStatus').AsInteger;
    MenuList[i].Comp := FindMenu(MenuList[i].Name);
    ADO_Rec.Next;
  end;
  for i := 0 to length(MenuList) -1 do
  begin
    //if 1 shl MenuList[i].Id or iLicenseCode = iLicenseCode then
    if Trunc(power(2,MenuList[i].Id)) or iLicenseCode = iLicenseCode then
    begin
      if Assigned(MenuList[i].Comp) then
        MenuList[i].Comp.Visible := True;
    end else
    begin
      if Assigned(MenuList[i].Comp) then
        MenuList[i].Comp.Visible := False;
    end;
  end;

  for i := 0 to gb_Menu.ControlCount -1 do
  begin
    if gb_Menu.Controls[i] is TRzGroup then
    begin
      for j := 0 to TRzGroup(gb_Menu.Controls[i]).Items.Count -1 do
      begin
        if TRzGroup(gb_Menu.Controls[i]).Items.Items[j].Visible then
        begin
          TRzGroup(gb_Menu.Controls[i]).Visible := True;
          Break;
        end;
      end;
    end;
  end;
end;

procedure TFrm_Main.rg_yhglItems1Click(Sender: TObject);
begin
  {
   //注销退出程序再运行
  g_bIsRunAgain:=true;
  close;
  Exit;
  }


  ClearBold;
  Self.Visible:= False;
  WriteLoginLog('退出');
  frm_login := Tfrm_login.Create(Application);
  if Frm_login.ShowModal = mrok then
  begin
    Self.Visible:= True;
//    FormShow(Self);
  end else
    Self.Close;
  Frm_login.Free;

end;

procedure TFrm_Main.InitFra(Sender: TObject);
  function GetCaption(Sender: TObject):string;
  begin
    Result := '';
    if Sender is TRzGroupItem then
      Result := (Sender as TRzGroupItem).Caption
    else
    if Sender is TAction then
      Result := (Sender as TAction).Caption;
  end;
var
  str: string;
  sCaption: string;
begin
  if not Assigned(Sender) then Exit;
  sCaption := GetCaption(Sender);
  f_WriteOperationLog('进入'+sCaption);
  GetPostageTypeList;                 //获取邮资图,产品类别,//获取产品类别
  //GetProductCategoryList;             //获取产品类别
  //GetProductTypeList;                 //获取产品类型
  if sCaption = '箱签' then
  begin
    if not Assigned(Fra_XQCX1) then
    begin
      Fra_XQCX1 := TFra_XQCX.Create(Self);
    end;
    Fra_XQCX1.Visible := True;
    //Fra_XQCX1.Align := alClient;
    Fra_XQCX1.FraShow;
    Application.ProcessMessages;
    Fra_XQCX1.btn_cx.Click;
  end else
  if sCaption = '特殊工艺管理' then
  begin
    if not Assigned(Frm_TSGYGL) then
    begin
      Frm_TSGYGL := TFrm_TSGYGL.Create(Self);
      Frm_TSGYGL.Hide;
    end;
    Frm_TSGYGL.Visible := True;
    //Fra_XQCX1.Align := alClient;
    Application.ProcessMessages;
  end else
  if sCaption = '出仓单打印' then
  begin
    if not Assigned(Fra_FHGL1) then
    begin
      Fra_FHGL1 := TFra_FHGL.Create(Self);
      Fra_FHGL1.Hide;
      Fra_FHGL1.Parent := Self;
      Fra_FHGL1.dtp_jcq.DateTime := Now;
      Fra_FHGL1.dtp_jcz.DateTime := Now;
    end;
    Fra_FHGL1.Align := alClient;
    Fra_FHGL1.FrmShow;
    Fra_FHGL1.Visible := True;
    Application.ProcessMessages;
    Fra_FHGL1.btn_cx.Click;
  end else
  if sCaption = '订单查询' then
  begin
    if not Assigned(Fra_ddcx1) then
    begin
      Fra_ddcx1 := TFra_ddcx.Create(Self);
    end;

    //Fra_ddcx1.Align := alClient;
    Fra_ddcx1.FraShow;
    Fra_ddcx1.Visible := True;
    Application.ProcessMessages;
    Fra_ddcx1.btn_cx.Click;
  end else
  if sCaption = '在产品月报表' then
  begin
    if not Assigned(Fra_CPYBB1) then
    begin
      Fra_CPYBB1 := TFra_CPYBB.Create(Self);
      Fra_CPYBB1.Hide;
      Fra_CPYBB1.Parent := Self;
    end;
    Fra_CPYBB1.Align := alClient;
    Fra_CPYBB1.FraShow;
    Fra_CPYBB1.Visible := True;
    Application.ProcessMessages;
    Fra_CPYBB1.btn_cx.Click;
  end else
  if sCaption = '完工月报表' then
  begin
    if not Assigned(Fra_WGYBB1) then
    begin
      Fra_WGYBB1 := TFra_WGYBB.Create(Self);
      Fra_WGYBB1.Hide;
      Fra_WGYBB1.Parent := Self;
    end;
    Fra_WGYBB1.Align := alClient;
    Fra_WGYBB1.FraShow;
    Fra_WGYBB1.Visible := True;
    Application.ProcessMessages;
    Fra_WGYBB1.btn_cx.Click;
  end else
  if sCaption = '运输面单打印' then
  begin
    if not Assigned(Fra_YSMDDY1) then
    begin
      Fra_YSMDDY1 := TFra_YSMDDY.Create(Self);
      Fra_YSMDDY1.Hide;
      Fra_YSMDDY1.Parent := Self;
    end;
    Fra_YSMDDY1.Align := alClient;
    Fra_YSMDDY1.FraShow;
    Fra_YSMDDY1.Visible := True;
    Application.ProcessMessages;
    // Fra_YSMDDY1.btn_cx.Click;
  end else
  if sCaption = '发货反馈' then
  begin
    if not Assigned(Fra_FHFK1) then
    begin
      Fra_FHFK1 := TFra_FHFK.Create(Self);
      Fra_FHFK1.Hide;
      Fra_FHFK1.Parent := Self;
    end;
    Fra_FHFK1.Align := alClient;
    Fra_FHFK1.FraShow;
    Fra_FHFK1.Visible := True;
    Application.ProcessMessages;
    Fra_FHFK1.btn_cx.Click;
  end else
  if sCaption = '进仓导入(扫描)' then
  begin
    if not Assigned(Fra_WarehEntryBarCode1) then
    begin
      Fra_WarehEntryBarCode1 := TFra_WarehEntryBarCode.Create(Self);
      Fra_WarehEntryBarCode1.Hide;
      Fra_WarehEntryBarCode1.Parent := Self;
    end;
    Fra_WarehEntryBarCode1.Align := alClient;
    Fra_WarehEntryBarCode1.FraShow;
    Fra_WarehEntryBarCode1.Visible := True;
    Application.ProcessMessages;
  end else
  if sCaption = '图稿审核(内部)' then
  begin
    if not Assigned(Fra_tg1) then
    begin
      Fra_tg1 := TFra_tg.Create(Self);
    end;
    //Fra_tg1.Align := alClient;

    Fra_tg1.FraShow;
    Fra_tg1.Visible := True;
    Application.ProcessMessages;
    Fra_tg1.btn_cx.Click;
  end else
  if sCaption = '图稿审核' then
  begin
    if not Assigned(Fra_tg1) then
    begin
      Fra_tg1 := TFra_tg.Create(Self);
      Fra_tg1.Hide;
      Fra_tg1.Parent := Self;
      Fra_tg1.cbb_xpl.Enabled := True;
      Fra_tg1.cbb_xpl.ItemIndex := 0;
      case LoginData.m_iUserType of
        c_User:
          Fra_tg1.cbb_xpl.ItemIndex := 1;
        c_Admin:
          Fra_tg1.cbb_xpl.ItemIndex := 1;
        c_User_Small:
          begin
            Fra_tg1.cbb_xpl.ItemIndex := 2;
            Fra_tg1.cbb_xpl.Enabled := False;
          end;
        c_Admin_Small:
          begin
            Fra_tg1.cbb_xpl.ItemIndex := 2;
            Fra_tg1.cbb_xpl.Enabled := False;
          end;
        c_SuperAdmin:;
      end;
    end;
    Fra_tg1.Align := alClient;

    Fra_tg1.btn_fk.Visible := True;
    Fra_tg1.btn_ok.Visible := False;

    if Fra_tg1.cbb_tgzt.ItemIndex = -1 then
      Fra_tg1.cbb_tgzt.ItemIndex := 0;
    Fra_tg1.cbb_tgzt.Enabled := True;
    //  Fra_tg1.cbb_tgzt.EditLabel.Caption := '内部状态';
    with Fra_tg1.cbb_llzt.Items do
    begin
      Clear;
      Add('--请选择--');
      Add('图稿未收到');
      Add('图稿已收到');
      Add('图稿未合格');
      Add('图稿已合格');
      Add('已打样');
      Add('图稿待处理');
  //    Add('已签样');
    end;

    //获取产品类别
    str := Fra_tg1.cbb_cplb.Text;
    Fra_tg1.cbb_cplb.Clear;
    Fra_tg1.cbb_cplb.Items.Add('--全部--');
    CbbAdd(Fra_tg1.cbb_cplb,pkProductCategory);
    Fra_tg1.cbb_cplb.ItemIndex := Fra_tg1.cbb_cplb.Items.IndexOf(str);
    if Fra_tg1.cbb_cplb.ItemIndex = -1 then
      Fra_tg1.cbb_cplb.ItemIndex := c_Default_CPLB;       //默认选择邮政贺卡
    str := Fra_tg1.cbb_cplx.Text;
    Fra_tg1.cbb_cplx.Clear;
    Fra_tg1.cbb_cplx.Items.Add('--全部--');
    CbbAdd(Fra_tg1.cbb_cplx,pkProductType,FindProductCategoryID(Fra_tg1.cbb_cplb.ItemIndex));
    Fra_tg1.cbb_cplx.ItemIndex := Fra_tg1.cbb_cplx.Items.IndexOf(str);
    if Fra_tg1.cbb_cplx.ItemIndex = -1 then
      Fra_tg1.cbb_cplx.ItemIndex := 0;

    if Fra_tg1.cbb_llzt.ItemIndex = -1 then
     Fra_tg1.cbb_llzt.ItemIndex := 0;
    if Fra_tg1.cbb_bb.ItemIndex = -1 then
      Fra_tg1.cbb_bb.ItemIndex := 0;
    
    Fra_tg1.CustomLvAdd;

    Fra_tg1.FraShow;
    Fra_tg1.Visible := True;
    Application.ProcessMessages;
    Fra_tg1.btn_cx.Click;
  end else
  if sCaption = '订单录入' then
  begin
    if not Assigned(Fra_DDLR1) then
    begin
      Fra_DDLR1 := TFra_DDLR.Create(Self);
      //Fra_DDLR1.Hide;
      //Fra_DDLR1.Parent := Self;
    end;
    //Fra_DDLR1.Align := alClient;
    Fra_DDLR1.lab_lry.Caption := LoginData.m_sUserName;
    Fra_DDLR1.FraShow;
    Fra_DDLR1.Visible := True;
    Application.ProcessMessages;
  end else
  if sCaption = '数据归档' then
  begin
    if not Assigned(Fra_DataArchiving1) then
    begin
      Fra_DataArchiving1 := TFra_DataArchiving.Create(Self);
      Fra_DataArchiving1.Hide;
      Fra_DataArchiving1.Parent := Self;
    end;
    Fra_DataArchiving1.Align := alClient;
    Fra_DataArchiving1.FraShow;
    Fra_DataArchiving1.Visible := True;
    Application.ProcessMessages;
  end else
  if sCaption = '用户设置' then
  begin
    if not Assigned(Fra_UserAdd1) then
    begin
      Fra_UserAdd1 := TFra_UserAdd.Create(Self);
      Fra_UserAdd1.Hide;
      Fra_UserAdd1.Parent := Self;
      Fra_UserAdd1.stg_UserList.p_SetColSortType(0,c_SetColSortType_Str );
      Fra_UserAdd1.stg_UserList.p_SetColSortType(1,c_SetColSortType_Str );
      Fra_UserAdd1.stg_UserList.p_SetColSortType(2,c_SetColSortType_Str );
    end;
    Fra_UserAdd1.Align := alClient;
    Fra_UserAdd1.FraShow;
    Fra_UserAdd1.Visible := True;
    Application.ProcessMessages;
  end else
  if sCaption = '邮资图管理' then
  begin
    if not Assigned(Fra_yztgl1) then
    begin
      Fra_yztgl1 := TFra_yztgl.Create(Self);
      Fra_yztgl1.cbb_cplb.ItemIndex := iif(c_Default_CPLB=0,0,c_Default_CPLB-1);       //默认选择邮政贺卡
    end;
    Fra_yztgl1.FraShow;
    Fra_yztgl1.Visible := True;
  end else
  if sCaption = '已撤销订单清单' then
  begin
    if not Assigned(Frm_YCXDDQD) then
    begin
      Frm_YCXDDQD := TFrm_YCXDDQD.Create(Self);
    end;
    Frm_YCXDDQD.FraShow;
    Frm_YCXDDQD.Visible := True;
  end;


end;


procedure TFrm_Main.rg_sys_ddglItems3Click(Sender: TObject);
begin
  Caption := c_TitleName +'--订单录入';
  FraHide(Sender);
end;

procedure TFrm_Main.rg_sys_ddglItems0Click(Sender: TObject);
var
  str: string;
begin
  Caption := c_TitleName +'--订单加印';
  FraHide(Sender);
  Fra_DDJY_CX1.FraShow;
  str := Fra_DDJY_CX1.cbb_cplb.Text;
  Fra_DDJY_CX1.cbb_cplb.Clear;
  Fra_DDJY_CX1.cbb_cplb.Items.Add('--全部--');
  CbbAdd(Fra_DDJY_CX1.cbb_cplb,pkProductCategory);
  Fra_DDJY_CX1.cbb_cplb.ItemIndex := Fra_DDJY_CX1.cbb_cplb.Items.IndexOf(str);
  if Fra_DDJY_CX1.cbb_cplb.ItemIndex = -1 then
    Fra_DDJY_CX1.cbb_cplb.ItemIndex := c_Default_CPLB;       //默认选择邮政贺卡

  str := Fra_DDJY_CX1.cbb_cplx.Text;
  Fra_DDJY_CX1.cbb_cplx.Clear;
  Fra_DDJY_CX1.cbb_cplx.Items.Add('--全部--');
  CbbAdd(Fra_DDJY_CX1.cbb_cplx,pkProductType,FindProductCategoryID(Fra_DDJY_CX1.cbb_cplb.ItemIndex));
  Fra_DDJY_CX1.cbb_cplx.ItemIndex := Fra_DDJY_CX1.cbb_cplx.Items.IndexOf(str);
  if Fra_DDJY_CX1.cbb_cplx.ItemIndex = -1 then
    Fra_DDJY_CX1.cbb_cplx.ItemIndex := 0;
  Fra_DDJY_CX1.dtp_jsq.DateTime := Now;
  Fra_DDJY_CX1.dtp_jsz.DateTime := Now;
  Fra_DDJY_CX1.Align := alclient;
  Fra_DDJY_CX1.Visible := True;
  Application.ProcessMessages;
  Fra_DDJY_CX1.btn_cx.Click;

end;

procedure TFrm_Main.rg_yhglItems2Click(Sender: TObject);
begin
  Caption := c_TitleName +'--修改密码';
  FraHide(Sender);
  Fra_Pwd_Modify1.Align := alClient;
  Fra_Pwd_Modify1.FraShow;
  Fra_Pwd_Modify1.Visible := True;
end;

procedure TFrm_Main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  if Assigned(Frm_DDMX_DZX) then Frm_DDMX_DZX.Free;
//  if Assigned(Frm_DDMX_XSX) then Frm_DDMX_XSX.Free;

{  for i := 0 to Length(aFrm_WorkOrder)-1 do
  begin
    if Assigned(aFrm_WorkOrder[i]) then
      aFrm_WorkOrder[i].Free;
  end;  }

  if LoadBulletinThread <> nil then
  begin
    vbExecute := False;
    LoadBulletinThread.Free;
    LoadBulletinThread := nil;
  end;

  WriteLoginLog('退出');
end;

procedure TFrm_Main.ClearBold;
var
  i,j: Integer;
begin
  for i := 0 to gb_Menu.ControlCount -1 do
  begin
    if gb_Menu.Controls[i] is TRzGroup then
    begin
      for j := 0 to TRzGroup(gb_Menu.Controls[i]).Items.Count -1 do
      begin
        if TRzGroup(gb_Menu.Controls[i]).Items.Items[j].Visible then
          TRzGroup(gb_Menu.Controls[i]).Items.Items[j].FontStyle := [];
      end;
    end;
  end;
end;

procedure TFrm_Main.rg_scglItems9Click(Sender: TObject);
begin
  Caption := c_TitleName +'--箱签';
  FraHide(Sender);
end;

procedure TFrm_Main.rg_scglItems11Click(Sender: TObject);
begin
  Caption := c_TitleName +'--发货反馈';
  FraHide(Sender);
end;

procedure TFrm_Main.rg_SysManageItems4Click(Sender: TObject);
begin
  Caption := c_TitleName +'--材料管理';
  FraHide(Sender);
  Fra_MatlManage1.Align := alClient;
  Fra_MatlManage1.FraShow;
  Fra_MatlManage1.Visible := True;
  Application.ProcessMessages;
end;

procedure TFrm_Main.rg_SysManageItems5Click(Sender: TObject);
begin
  Caption := c_TitleName +'--机台管理';
  FraHide(Sender);
  Fra_MachineManage1.Align := alClient;
  Fra_MachineManage1.FraShow;
  Fra_MachineManage1.Visible := True;
  Application.ProcessMessages;
end;

procedure TFrm_Main.rg_SysManageItems6Click(Sender: TObject);
begin
  Caption := c_TitleName +'--产品类别管理';
  FraHide(Sender);
  Fra_CPLB_GL1.Align := alClient;
  Fra_CPLB_GL1.FraShow;
  Fra_CPLB_GL1.Visible := True;
  Application.ProcessMessages;

end;

procedure TFrm_Main.rg_SysManageItems7Click(Sender: TObject);
begin
  Caption := c_TitleName +'--制版工序管理';
  FraHide(Sender);
  Fra_ZBGX_GL1.Align := alClient;
  Fra_ZBGX_GL1.FraShow;
  Fra_ZBGX_GL1.Visible := True;
  Application.ProcessMessages;
end;

procedure TFrm_Main.rg_scglItems12Click(Sender: TObject);
begin
  Caption := c_TitleName +'--发运单号录入(扫描)';
  FraHide(Sender);
  Fra_FYDHLR1.Align := alClient;
  Fra_FYDHLR1.FraShow;
  Fra_FYDHLR1.Visible := True;
  Application.ProcessMessages;
end;

procedure TFrm_Main.rg_tjbbItems0Click(Sender: TObject);
begin
  Caption := c_TitleName +'--业务统计';
  FraHide(Sender);

  Fra_ywtj1.Align := alclient;
  Fra_ywtj1.FraShow;
  Fra_ywtj1.Visible := True;
  Application.ProcessMessages;
  Fra_ywtj1.btn_cx.Click;

end;

procedure TFrm_Main.rg_tjbbItems1Click(Sender: TObject);
begin
  Caption := c_TitleName +'--生产统计';
  FraHide(Sender);
  Fra_sctj1.Align := alclient;
  Fra_sctj1.FraShow;
  Fra_sctj1.Visible := True;
  Application.ProcessMessages;
  Fra_sctj1.btn_cx.Click;

end;

procedure TFrm_Main.rg_tjbbItems2Click(Sender: TObject);
begin
  Caption := c_TitleName +'--销毁清单';
  FraHide(Sender);
  Fra_XHQD1.Align := alClient;
  Fra_XHQD1.FraShow;
  Fra_XHQD1.Visible := True;
  Application.ProcessMessages;
  Fra_XHQD1.btn_cx.Click;

end;

procedure TFrm_Main.rg_tjbbItems3Click(Sender: TObject);
begin
  Caption := c_TitleName +'--发货统计';
  FraHide(Sender);
  Fra_FHTJ1.Align := alClient;
  Fra_FHTJ1.FraShow;
  Fra_FHTJ1.Visible := True;
  Application.ProcessMessages;
  Fra_FHTJ1.btn_cx.Click;

end;

procedure TFrm_Main.rg_tjbbItems4Click(Sender: TObject);
begin
  Caption := c_TitleName +'--材料统计';
  FraHide(Sender);
  Fra_CLTJ1.Align := alClient;
  Fra_CLTJ1.FraShow;
  Fra_CLTJ1.Visible := True;
  Application.ProcessMessages;
  Fra_CLTJ1.btn_cx.Click;

end;

procedure TFrm_Main.rg_tjbbItems5Click(Sender: TObject);
begin
  Caption := c_TitleName +'--机台统计';
  FraHide(Sender);
  Fra_JTTJ1.Align := alClient;
  Fra_JTTJ1.FraShow;
  Fra_JTTJ1.Visible := True;
  Application.ProcessMessages;
  Fra_JTTJ1.btn_cx.Click;

end;

procedure TFrm_Main.rg_tjbbItems6Click(Sender: TObject);
begin
  Caption := c_TitleName +'--完工月报表';
  FraHide(Sender);
  Exit;
  Fra_WGYBB1.Align := alClient;
  Fra_WGYBB1.FraShow;
  Fra_WGYBB1.Visible := True;
  Application.ProcessMessages;
  Fra_WGYBB1.btn_cx.Click;

end;

procedure TFrm_Main.rg_tjbbItems7Click(Sender: TObject);
begin
  Caption := c_TitleName +'--产品月报表';
  FraHide(Sender);
  Exit;
  Fra_CPYBB1.Align := alClient;
  Fra_CPYBB1.FraShow;
  Fra_CPYBB1.Visible := True;
  Application.ProcessMessages;
  Fra_CPYBB1.btn_cx.Click;
end;

procedure TFrm_Main.rg_kcglItems0Click(Sender: TObject);
begin
  Caption := c_TitleName +'--材料入库';
  FraHide(Sender);
  Fra_CLRK1.Align := alClient;
  Fra_CLRK1.FraShow;
  Fra_CLRK1.Visible := True;
  Application.ProcessMessages;
  //Fra_CLRK1.btn_cx.Click;

end;

procedure TFrm_Main.rg_tjbbItems8Click(Sender: TObject);
begin
  Caption := c_TitleName +'--未印内件清单';
  if not Assigned(Fra_WYNJQD1) then
  begin
    Fra_WYNJQD1 := TFra_WYNJQD.Create(Self);
    Fra_WYNJQD1.Parent := Self;
  end;
  FraHide(Sender);
  Fra_WYNJQD1.Align := alClient;
  Fra_WYNJQD1.FraShow;
  Fra_WYNJQD1.Visible := True;
  Application.ProcessMessages;

end;

procedure TFrm_Main.btn_BulletinClick(Sender: TObject);
begin
  Frm_BulletinBoard := TFrm_BulletinBoard.Create(Self);
  Frm_BulletinBoard.viBulletinID := 0;
  if Frm_BulletinBoard.ShowModal = mrOk then
  begin
    LoadBulletinThread.p_LoadBulletinBoard;
  end;
  Frm_BulletinBoard.Free;
end;

{ TLoadBulletinThread }

procedure TLoadBulletinThread.Execute;
var
  i: Integer;
begin
  inherited;
  g_MaxID := 0;
  i := viLoadBulletinTime;
  while vbExecute do
  begin
//    if vbThreadStopping then
//    begin
//      Sleep(1000);
//      Continue;
//    end;
    if i < viLoadBulletinTime then
    begin
      inc(i,1000);
      Sleep(1000);
    end else
    begin
      i := 0;
      p_LoadBulletinBoard;
    end;


  end;
end;

procedure TLoadBulletinThread.p_LoadBulletinBoard;
const
  c_RealName = 0;
  c_FBRQ = 1;
  c_Content = 2;
  c_ID = 3;
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
  i: Integer;
begin
  sSqlData := ' Select a.F_dFBRQ,b.F_sRealName,a.F_sContent,a.F_iID from BI_BulletinBoard a left join BI_UserList b on a.F_sFBRBM=b.F_sName '
    + ' where DATEDIFF(dd,a.F_dFBRQ,getdate()) <=30 and a.F_tiCXBZ=0 order by a.F_dFBRQ desc ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[],False,Con_Bulletin);
  if Assigned(ADO_Rec) then
  begin
    with Frm_Main.lv_bulletin do
    begin
      while Items.Count <> ADO_Rec.RecordCount do
      begin
        if Items.Count > ADO_Rec.RecordCount then
          Items.Delete(Items.Count-1)
        else if Items.Count < ADO_Rec.RecordCount then
        begin
          Items.Add.Caption := '';
          for i := 0 to Frm_Main.lv_bulletin.Columns.Count -1 do
            Items.Item[Items.Count -1].SubItems.Add('');
        end;
      end;
      if Items.Count = ADO_Rec.RecordCount then
      begin
        i := 0;
        ADO_Rec.First;
        while not ADO_Rec.Eof do
        begin
          if i = 0 then
          begin
            Frm_Main.lab_bulletin.Caption := format('%s(%s): %s',[ADO_Rec.FieldByName('F_sRealName').AsString
              ,FormatDateTime('yyyy-MM-dd hh:mm:ss',ADO_Rec.FieldByName('F_dFBRQ').AsDateTime),ADO_Rec.FieldByName('F_sContent').AsString]);
            g_MaxID := ADO_Rec.FieldByName('F_iID').AsInteger;
          end;
          if (ADO_Rec.FieldByName('F_iID').AsString <> Items.Item[i].SubItems.Strings[c_ID])
            or (ADO_Rec.FieldByName('F_sContent').AsString <> Items.Item[i].SubItems.Strings[c_Content])
            or (FormatDateTime('yyyy-MM-dd hh:mm:ss',ADO_Rec.FieldByName('F_dFBRQ').AsDateTime) <> Items.Item[i].SubItems.Strings[c_FBRQ])
            or (ADO_Rec.FieldByName('F_sRealName').AsString <> Items.Item[i].SubItems.Strings[c_RealName])  then
          begin
            //Break;
            Items.Item[i].Caption := IntToStr(i+1);
            Items.Item[i].SubItems.Strings[c_RealName] := ADO_Rec.FieldByName('F_sRealName').AsString;
            Items.Item[i].SubItems.Strings[c_FBRQ] := FormatDateTime('yyyy-MM-dd hh:mm:ss',ADO_Rec.FieldByName('F_dFBRQ').AsDateTime);
            Items.Item[i].SubItems.Strings[c_Content] := ADO_Rec.FieldByName('F_sContent').AsString;
            Items.Item[i].SubItems.Strings[c_ID] := ADO_Rec.FieldByName('F_iID').AsString;
          end;
          Inc(i);
          ADO_Rec.Next;
        end;
      end;
    end;
    ADO_Rec.Free;
  end;
end;

procedure TFrm_Main.lv_bulletinDblClick(Sender: TObject);
begin
  if Assigned(Frm_Main.lv_bulletin.Selected) then
  begin
    Frm_BulletinBoard := TFrm_BulletinBoard.Create(Self);
    Frm_BulletinBoard.viBulletinID := StrToNum(Frm_Main.lv_bulletin.Selected.SubItems.Strings[Frm_Main.lv_bulletin.Selected.SubItems.Count-1]);;
    if Frm_BulletinBoard.ShowModal = mrOk then
    begin
      LoadBulletinThread.p_LoadBulletinBoard;
    end;
    Frm_BulletinBoard.Free;
  end;

end;

procedure TFrm_Main.lv_bulletinCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if (Item.Index mod 2) = 0 then
    Sender.Canvas.Brush.Color := $00F0FFF0
  else
    Sender.Canvas.Brush.Color := $00F2F2F2;
  LVDrawItem(TRzListView(Sender), Item, State, DefaultDraw);

end;

function TFrm_Main.f_MakeAllow: Boolean;
var
  sSqlData, sCode: string;
  ADO_Rec: TADOQuery;
  iAllowID, iAllowCode: Integer;
begin
  Result := False;
  if LoginData.m_iAllowCode >= 0 then
  begin
    sCode := Format('''%s''',[c_Allow_Bulletin_FB]);
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
          if sCode = c_Allow_Bulletin_FB then
          begin
            btn_Bulletin.Enabled := True;
            btn_Bulletin.Tag := c_Tag_MakeAllow;
          end;
        end else
        begin
          if sCode = c_Allow_Bulletin_FB then
          begin
            btn_Bulletin.Enabled := False;
            btn_Bulletin.Tag := 0;
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

procedure TFrm_Main.btn_hideClick(Sender: TObject);
begin
  LoadBulletinThread.p_LoadBulletinBoard;
  gb_bulletin.Visible := True;
  tc_bulletin.Visible := False;
  Splitter1.Visible := False;
end;

procedure TFrm_Main.RzButton1Click(Sender: TObject);
begin
  LoadBulletinThread.p_LoadBulletinBoard;
  gb_bulletin.Visible := False;
  tc_bulletin.Visible := True;
  Splitter1.Visible := True;

end;

procedure TFrm_Main.rg_scglItems10Click(Sender: TObject);
begin
  Caption := c_TitleName +'--运输面单打印';
  FraHide(Sender);
end;

procedure TFrm_Main.tmr_showTimer(Sender: TObject);
var
  sSqlData: string;
  aField: TArrSelectField;
begin
  tmr_show.Enabled := False;
  sSqlData := 'exec p_wfhfktx ';
//  sSqlData := 'Select F_sCPBH from BI_CustomOrderDetails a where F_tiCXBZ=0 and F_iFktgzt=3  '
//    + ' and not exists(select 1 from DO_FeedbackInvoricInfo where a.F_iDetailsID=F_iSBID and F_tiFKBZ in (1,10)) '
//    + ' and ((F_tiXpl=0 and exists(select 1 from Set_ParamList where F_sName = ''生产周期设置'' and datediff(day,a.F_dFkrq,getdate()) >=(convert(int,F_sParam1)-convert(int,F_sParam2)) )) '
//    + '   or (F_tiXpl=1 and exists(select 1 from Set_ParamList where F_sName = ''小批量生产周期设置'' and datediff(day,a.F_dFkrq,getdate()) >=(convert(int,F_sParam1)-convert(int,F_sParam2)) )) ) '
//    + ' union all Select F_sCPBH from BI_SellOrderDetails a where F_tiCXBZ=0 and exists(select 1 from BI_SellOrder b where F_iID=a.F_iSellID  '
//    + ' and exists(select 1 from Set_ParamList where F_sName = ''生产周期设置'' and datediff(day,b.F_dJsrq,getdate()) >=(convert(int,F_sParam1)-convert(int,F_sParam2)) ) ) '
//    + ' and not exists(select 1 from DO_FeedbackInvoricInfo where a.F_iDetailsID=F_iSBID and F_tiFKBZ in (1,10)) ';
  SetLength(aField,4);
  aField[0].m_sName := '产品编号';
  aField[0].m_sField := 'F_sCPBH';
  aField[0].m_iWidth := 180;
  aField[0].m_FMode := fmLink;
  aField[1].m_sName := '工单号';
  aField[1].m_sField := 'GDH';
  aField[1].m_iWidth := 180;
  aField[1].m_FMode := fmLink;
  aField[2].m_sName := '开单日期';
  aField[2].m_sField := 'KDRQ';
  aField[2].m_iWidth := 180;
  aField[2].m_FMode := fmNone;
  aField[3].m_sName := '生产进度';
  aField[3].m_sField := 'SCZT';
  aField[3].m_iWidth := 150;
  aField[3].m_FMode := fmNone;
  p_ShowRemind('已到生产周期结束还未发货反馈的订单:','发货反馈提醒',aField,sSqlData);

end;

procedure TFrm_Main.AppException(Sender: TObject; E: Exception);
begin
  if Pos('Code',E.Message) =0 then
    p_MessageBoxDlg('system: ' + E.Message);
  f_WriteOperationLog('system: ' + E.Message,999);
end;

procedure TFrm_Main.rg_scglItems8Click(Sender: TObject);
begin
  Caption := c_TitleName +'--进仓导入(扫描)';
  FraHide(Sender);

end;

procedure TFrm_Main.rg_SysManageItems8Click(Sender: TObject);
begin
  Caption := c_TitleName +'--数据归档';
  FraHide(Sender);
end;

procedure TFrm_Main.rg_SysManageItems9Click(Sender: TObject);
begin
  Caption := c_TitleName +'--特殊工艺管理';
  FraHide(Sender);

end;

procedure TFrm_Main.rg_tjbbItems9Click(Sender: TObject);
begin
  Caption := c_TitleName +'--已撤销订单清单';
  FraHide(Sender);
end;

end.
