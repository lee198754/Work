unit FrmMain_New;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, uFratg, uFrascgl, uFraYZTGL,
  uFraddcx, uFraUserAdd, uFra_ywtj, uFra_sctj, uFrakd, uFragdcx,
  uFra_cplx_gl, uFraWorkerManage, uFraParamSet, ComCtrls, RzGroupBar,
  RzPanel, RzSplit, uDM_DataBase,
  iComboBox, ADODB, RzButton, uFra_FHGL, uFra_FHGL_DYCX,
  uFra_DDLR, uFra_DDJY_CX, uFra_Pwd_Modify, uFra_XQCX, uFra_FHFK,
  uFra_MatlManage, uMachineManage, uFra_XHQD, uFra_CPLB_GL, uFra_ZBGX_GL,
  XPStyleActnCtrls, ActnMan, ActnList, msxmldom,
  uFra_FYDHLR, uFra_FHTJ, uFra_CLTJ, uFra_JTTJ, uFra_WGYBB, uFra_CPYBB,
  uFra_CLRK, iImagePanel, U_FrmList, Menus, ToolWin, pngimage, RzTabs,
  StdCtrls;
                     
type
  TFrm_Main_New = class(TFrmList)
    Img_Status: TImage;
    Image11: TImage;
    Image12: TImage;
    Lbl_Operator: TLabel;
    Image13: TImage;
    Image14: TImage;
    Lbl_Date: TLabel;
    Lbl_Zt: TLabel;
    Lbl_Use: TLabel;
    Panel2: TPanel;
    PageControl1: TRzPageControl;
    TS_Navigation_Frm: TRzTabSheet;
    Img_In: TImage;
    Panel1: TPanel;
    Image1: TImage;
    Img_Res2: TImage;
    Img_Res: TImage;
    Img_Provider2: TImage;
    Img_Provider: TImage;
    Img_Customer2: TImage;
    Img_Customer: TImage;
    Img_StockOrder2: TImage;
    Img_StockOrder: TImage;
    Img_StockIn2: TImage;
    Img_Pay2: TImage;
    Img_SaleOrder2: TImage;
    Img_SaleOut2: TImage;
    Img_Gather2: TImage;
    Img_StockIn: TImage;
    Img_Pay: TImage;
    Img_SaleOrder: TImage;
    Img_SaleOut: TImage;
    Img_Gather: TImage;
    Lbl_Res: TLabel;
    Lbl_Provider: TLabel;
    Lbl_Customer: TLabel;
    Lbl_StockOrder: TLabel;
    Lbl_StockIn: TLabel;
    Lbl_Pay: TLabel;
    Lbl_SaleOrder: TLabel;
    Lbl_SaleOut: TLabel;
    Lbl_Gather: TLabel;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image2: TImage;
    Img_OnlineServiceL: TImage;
    Img_OnlineService2: TImage;
    Img_OnlineService: TImage;
    Lbl_OnlineService: TLabel;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    TB_Res: TToolButton;
    TB_Provider: TToolButton;
    TB_Customer: TToolButton;
    TB_StockOrder: TToolButton;
    TB_StockIn: TToolButton;
    TB_Pay: TToolButton;
    TB_SaleOrder: TToolButton;
    TB_SaleOut: TToolButton;
    TB_Gathering: TToolButton;
    Lbl_UserType: TLabel;
    Lbl_UserName: TLabel;
    Image10: TImage;
    Img_Toolbar: TImage;
    Lbl_LoginDate: TLabel;
    Image15: TImage;
    Lbl_LoginTime: TLabel;
    Image16: TImage;
    gb_Menu: TMainMenu;
    menu_Class: TMenuItem;
    menu_BI_Producer: TMenuItem;
    N212: TMenuItem;
    N3: TMenuItem;
    menu_SalePriceGroup: TMenuItem;
    N14: TMenuItem;
    N2: TMenuItem;
    menu_Depot: TMenuItem;
    N130: TMenuItem;
    N129: TMenuItem;
    menu_BI_ProviderImport: TMenuItem;
    menu_BI_CustomerImport: TMenuItem;
    menu_BI_ResImport: TMenuItem;
    N13: TMenuItem;
    N12: TMenuItem;
    N10: TMenuItem;
    N38: TMenuItem;
    menu_BI_Subject: TMenuItem;
    N71: TMenuItem;
    N77: TMenuItem;
    N54: TMenuItem;
    N55: TMenuItem;
    N120: TMenuItem;
    N118: TMenuItem;
    N119: TMenuItem;
    N1: TMenuItem;
    N211: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N138: TMenuItem;
    N21: TMenuItem;
    N134: TMenuItem;
    N132: TMenuItem;
    N133: TMenuItem;
    N145: TMenuItem;
    N146: TMenuItem;
    N22: TMenuItem;
    N20: TMenuItem;
    N139: TMenuItem;
    N19: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N7: TMenuItem;
    N18: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N98: TMenuItem;
    N35: TMenuItem;
    N137: TMenuItem;
    N37: TMenuItem;
    N36: TMenuItem;
    N135: TMenuItem;
    N136: TMenuItem;
    N15: TMenuItem;
    N144: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    N29: TMenuItem;
    N32: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N140: TMenuItem;
    N99: TMenuItem;
    N28: TMenuItem;
    N16: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    N40: TMenuItem;
    N49: TMenuItem;
    N50: TMenuItem;
    N121: TMenuItem;
    N17: TMenuItem;
    N48: TMenuItem;
    N44: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    N47: TMenuItem;
    N83: TMenuItem;
    N84: TMenuItem;
    N141: TMenuItem;
    N76: TMenuItem;
    N51: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    N100: TMenuItem;
    N75: TMenuItem;
    N59: TMenuItem;
    N148: TMenuItem;
    N147: TMenuItem;
    N60: TMenuItem;
    N52: TMenuItem;
    N53: TMenuItem;
    N56: TMenuItem;
    N142: TMenuItem;
    N61: TMenuItem;
    N62: TMenuItem;
    N63: TMenuItem;
    N43: TMenuItem;
    N92: TMenuItem;
    N91: TMenuItem;
    N73: TMenuItem;
    N65: TMenuItem;
    N64: TMenuItem;
    N95: TMenuItem;
    N101: TMenuItem;
    N97: TMenuItem;
    N96: TMenuItem;
    N102: TMenuItem;
    N127: TMenuItem;
    N126: TMenuItem;
    N125: TMenuItem;
    N124: TMenuItem;
    N122: TMenuItem;
    N128: TMenuItem;
    N156: TMenuItem;
    N155: TMenuItem;
    N154: TMenuItem;
    N153: TMenuItem;
    N151: TMenuItem;
    N150: TMenuItem;
    N143: TMenuItem;
    N131: TMenuItem;
    N175: TMenuItem;
    N176: TMenuItem;
    N177: TMenuItem;
    N178: TMenuItem;
    N179: TMenuItem;
    N180: TMenuItem;
    N181: TMenuItem;
    N183: TMenuItem;
    N11: TMenuItem;
    N39: TMenuItem;
    N41: TMenuItem;
    N42: TMenuItem;
    N57: TMenuItem;
    N58: TMenuItem;
    N66: TMenuItem;
    N67: TMenuItem;
    N68: TMenuItem;
    N69: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ToolBar1CustomDraw(Sender: TToolBar; const ARect: TRect;
      var DefaultDraw: Boolean);
    procedure FormShow(Sender: TObject);
    procedure menu_ddrlClick(Sender: TObject);
    procedure menu_ddjyClick(Sender: TObject);
    procedure N43Click(Sender: TObject);
    procedure N65Click(Sender: TObject);
    procedure N64Click(Sender: TObject);
    procedure N101Click(Sender: TObject);
    procedure N97Click(Sender: TObject);
    procedure N127Click(Sender: TObject);
    procedure N122Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N156Click(Sender: TObject);
    procedure N155Click(Sender: TObject);
    procedure N154Click(Sender: TObject);
    procedure N153Click(Sender: TObject);
    procedure N151Click(Sender: TObject);
    procedure N150Click(Sender: TObject);
    procedure N143Click(Sender: TObject);
    procedure N131Click(Sender: TObject);
    procedure N183Click(Sender: TObject);
    procedure N181Click(Sender: TObject);
    procedure N180Click(Sender: TObject);
    procedure N179Click(Sender: TObject);
    procedure N178Click(Sender: TObject);
    procedure N177Click(Sender: TObject);
    procedure N176Click(Sender: TObject);
  private
    m_Pnl: Ti_ImagePanel;

    procedure p_LoadImg;
    function p_NewSheet(const sCaption: string; Data: integer): TRzTabSheet;
    function p_ActivePage(const sClassName: string; sCaption: string = ''): boolean;  // sClassName

    procedure p_SetFrm(Frm: TScrollingWinControl; TabSheet: TRzTabSheet);
  public
    { Public declarations }
  end;

var
  Frm_Main_New: TFrm_Main_New;

implementation

uses
  uLogin, uPub_Type, uPub_Func, uDDMX_DZX, uDDMX_XSX, uPub_Text, PubStr, PubDef;

{$R *.dfm}

const
  c_User = 0;
  c_Admin = 1;
  c_User_Small=5;
  c_Admin_Small=6;
  c_SuperAdmin = 10;

{ TFrm_Main_New }

procedure TFrm_Main_New.p_LoadImg;
begin
  p_LoadImgFile(Img_Res, PF_Res32);
  p_LoadImgFile(Img_Provider, PF_Provider32);
  p_LoadImgFile(Img_Customer, PF_Customer32);
  p_LoadImgFile(Img_StockOrder, PF_StockOrder32);
  p_LoadImgFile(Img_StockIn, PF_StockIn32);
  p_LoadImgFile(Img_Pay, PF_Pay32);
  p_LoadImgFile(Img_SaleOrder, PF_SaleOrder32);
  p_LoadImgFile(Img_SaleOut, PF_SaleOut32);
  p_LoadImgFile(Img_Gather, PF_Gather32);
end;

procedure TFrm_Main_New.FormCreate(Sender: TObject);
begin
  // 创建工具栏图标
  m_Pnl := Ti_ImagePanel.Create;
  m_Pnl.pt_BackImg := Img_In;

  m_Pnl.p_AddItem(Img_Res, Img_Res2, Lbl_Res);
  m_Pnl.p_AddItem(Img_Provider, Img_Provider2, Lbl_Provider);
  m_Pnl.p_AddItem(Img_Customer, Img_Customer2, Lbl_Customer);

  m_Pnl.p_AddItem(Img_StockOrder, Img_StockOrder2, Lbl_StockOrder);
  m_Pnl.p_AddItem(Img_StockIn, Img_StockIn2, Lbl_StockIn);
  m_Pnl.p_AddItem(Img_Pay, Img_Pay2, Lbl_Pay);

  m_Pnl.p_AddItem(Img_SaleOrder, Img_SaleOrder2, Lbl_SaleOrder);
  m_Pnl.p_AddItem(Img_SaleOut, Img_SaleOut2, Lbl_SaleOut);
  m_Pnl.p_AddItem(Img_Gather, Img_Gather2, Lbl_Gather);
  m_Pnl.p_AddItem(Img_OnlineService, Img_OnlineService2, Lbl_OnlineService);

  p_LoadImg;
end;

procedure TFrm_Main_New.ToolBar1CustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
  TToolBar(Sender).Canvas.StretchDraw(ARect, Img_Toolbar.Picture.Graphic);
end;

procedure TFrm_Main_New.FormShow(Sender: TObject);
var
  sType,sSqlData: string;
begin
  (*FraHide(nil);
  Caption := c_TitleName;
  WriteLoginLog(LoginData.m_iUserID,LoginData.m_sUserName,'登录');
//  Fra_tg1.cbb_xpl.ItemIndex := 0;
  {Fra_kd1.cbb_qyzt.Visible := True;    //显示签样状态
  Fra_ddcx1.cbb_xpl.Enabled := True;     //小批量
  Fra_tg1.cbb_xpl.Enabled := True;
  Fra_kd1.cbb_xpl.Enabled := True;
  Fra_ddcx1.cbb_xpl.ItemIndex := 0;       //小批量标志
  Fra_tg1.cbb_xpl.ItemIndex := 0;
  Fra_kd1.cbb_xpl.ItemIndex := 0;
  Fra_scgl1.cbb_xpl.ItemIndex := 0;
  Fra_gdcx1.cbb_xpl.ItemIndex := 0;}
  case LoginData.m_iUserType of
    c_User:
      begin
        sType := '普通用户';
        Fra_ddcx1.cbb_xpl.ItemIndex := 1;       //普通
        Fra_tg1.cbb_xpl.ItemIndex := 1;
        Fra_kd1.cbb_xpl.ItemIndex := 1;
        Fra_scgl1.cbb_xpl.ItemIndex := 1;
        fra_gdcx1.cbb_xpl.ItemIndex := 1;
//        rg_user_dzxddgl.Visible := True;
//        rg_user_xsxddgl.Visible := True;
        //rg_user_dzxddgl.Visible := False;      //订制型订单管理
        //rg_user_xsxddgl.Visible := False;      //销售型订单管理
        rg_sys_ddgl.Visible := true;           //订单管理
//        rg_SysManage.Visible := False;
//        rg_yhgl.Visible := False;
      end;
    c_Admin:
      begin
        sType := '管理员';
        Fra_ddcx1.cbb_xpl.ItemIndex := 1;       //普通
        Fra_tg1.cbb_xpl.ItemIndex := 1;
        Fra_kd1.cbb_xpl.ItemIndex := 1;
        Fra_scgl1.cbb_xpl.ItemIndex := 1;
        fra_gdcx1.cbb_xpl.ItemIndex := 1;
        //rg_user_dzxddgl.Visible := False;        //订制型订单管理
        //rg_user_xsxddgl.Visible := False;        //销售型订单管理
        rg_SysManage.Visible := True;            //订单管理
        Fra_kd1.cbb_qyzt.Visible := True;         //显示签样状态
        rg_yhgl.Visible := True;
      end;
    c_User_Small:
      begin
        sType := '普通用户(小批量)';
        Fra_ddcx1.cbb_xpl.ItemIndex := 2;       //小批量
        Fra_tg1.cbb_xpl.ItemIndex := 2;
        Fra_kd1.cbb_xpl.ItemIndex := 2;
        Fra_scgl1.cbb_xpl.ItemIndex := 2;
        fra_gdcx1.cbb_xpl.ItemIndex := 2;
        Fra_tg1.cbb_xpl.Enabled := False;
        Fra_kd1.cbb_xpl.Enabled := False;
        Fra_scgl1.cbb_xpl.Enabled := False;
{        Fra_ddcx1.cbb_xpl.Enabled := False;
        fra_gdcx1.cbb_xpl.Enabled := False;}
      end;
    c_Admin_Small:
      begin
        sType := '管理员(小批量)';
        Fra_ddcx1.cbb_xpl.ItemIndex := 2;         //小批量
        Fra_tg1.cbb_xpl.ItemIndex := 2;
        Fra_kd1.cbb_xpl.ItemIndex := 2;
        Fra_scgl1.cbb_xpl.ItemIndex := 2;
        fra_gdcx1.cbb_xpl.ItemIndex := 2;
        Fra_tg1.cbb_xpl.Enabled := False;
        Fra_kd1.cbb_xpl.Enabled := False;
        Fra_scgl1.cbb_xpl.Enabled := False;
       { fra_gdcx1.cbb_xpl.Enabled := False;
        Fra_ddcx1.cbb_xpl.Enabled := False;}
        Fra_kd1.cbb_qyzt.Visible := True;         //显示签样状态
      end;
    c_SuperAdmin:
      begin
        sType := '超级管理员';
        //rg_user_dzxddgl.Visible := False;
        //rg_user_xsxddgl.Visible := False;
        rg_SysManage.Visible := True;
        rg_yhgl.Visible := True;
        Fra_kd1.cbb_qyzt.Visible := True;         //显示签样状态
      end;
  end;
  MenuHide;*)
  //stat_zt.Panels.Items[0].Text := '用户类型：'+sType;
  Lbl_UserType.Caption := '用户类型：' + sType;
//  stat_zt.Panels.Items[0].Width := 150;
  //stat_zt.Panels.Items[1].Text := '用户名：'+ LoginData.m_sUserName;
  Lbl_UserName.Caption :=  '用户名：' + LoginData.m_sUserName;
  Lbl_LoginDate.Caption := '登录日期：' + FormatDateTime('yyyy-MM-dd',Now);
  Lbl_LoginTime.Caption := '登录时间' + FormatDateTime('hh:mm:ss',Now);

//  rg_yhgl.Opened := False;

end;

procedure TFrm_Main_New.menu_ddrlClick(Sender: TObject);
var
  Obj: TFra_DDLR;
procedure p_New;
begin
  if Fra_DDLR1 = nil then Fra_DDLR1 := TFra_DDLR.Create(Self);
  Obj := Fra_DDLR1;
  p_SetFrm(Obj, p_NewSheet('订单录入', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_DDLR.ClassName) then
    p_New;

  Obj := Fra_DDLR1;
  //Caption := c_TitleName +'--订单录入';
  FraHide(Sender);
  Obj.Align := alclient;
  Obj.FraShow;
  Obj.lab_lry.Caption := LoginData.m_sUserName;
  Application.ProcessMessages;
  Obj.Visible := True;
end;

procedure TFrm_Main_New.menu_ddjyClick(Sender: TObject);
var
  str: string;
  Obj: TFra_DDJY_CX;
procedure p_New;
begin
  if Fra_DDJY_CX1 = nil then Fra_DDJY_CX1 := TFra_DDJY_CX.Create(Self);
  Obj := Fra_DDJY_CX1;
  p_SetFrm(Obj, p_NewSheet('订单加印', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_DDJY_CX.ClassName) then
    p_New;

  Obj := Fra_DDJY_CX1;
  //Caption := c_TitleName +'--订单加印';
  FraHide(Sender);
  Obj.FraShow;
  str := Obj.cbb_cplb.Text;
  Obj.cbb_cplb.Clear;
  Obj.cbb_cplb.Items.Add('--全部--');
  CbbAdd(Obj.cbb_cplb,pkProductCategory);
  Obj.cbb_cplb.ItemIndex := Obj.cbb_cplb.Items.IndexOf(str);
  if Obj.cbb_cplb.ItemIndex = -1 then
    Obj.cbb_cplb.ItemIndex := c_Default_CPLB;       //默认选择邮政贺卡

   str := Obj.cbb_cplx.Text;
 Obj.cbb_cplx.Clear;
  Obj.cbb_cplx.Items.Add('--全部--');
  CbbAdd(Obj.cbb_cplx,pkProductType,FindProductCategoryID(Obj.cbb_cplb.ItemIndex));
  Obj.cbb_cplx.ItemIndex := Obj.cbb_cplx.Items.IndexOf(str);
  if Obj.cbb_cplx.ItemIndex = -1 then
    Obj.cbb_cplx.ItemIndex := 0;
  Obj.dtp_jsq.DateTime := Now;
  Obj.dtp_jsz.DateTime := Now;
  Obj.Align := alclient;
  Obj.Visible := True;
  Application.ProcessMessages;
  Obj.btn_cx.Click;
end;

function TFrm_Main_New.p_ActivePage(const sClassName: string; sCaption: string): boolean;
var
  n: integer;
begin
  Result := false;
  for n := PageControl1.PageCount - 1 downto 0 do
  begin
    if PageControl1.Pages[n] = nil then continue;
    if PageControl1.Pages[n].Tag = 0 then continue;
    if TObject(PageControl1.Pages[n].Tag).ClassName = sClassName then
    //if PageControl1.Pages[n].Caption = sCaption then
    begin
      if sCaption <> '' then PageControl1.Pages[n].Caption := sCaption;
      PageControl1.ActivePageIndex := n;
      Result := true;
      break;
    end;
  end;
end;

function TFrm_Main_New.p_NewSheet(const sCaption: string;
  Data: integer): TRzTabSheet;
begin
  Result := TRzTabSheet.Create(PageControl1);
  Result.Hint := '';
  Result.ShowHint := false;
  Result.Caption := sCaption;
  Result.PageControl := PageControl1;
  Result.Tag := Data;
  PageControl1.ActivePage := Result;
end;

procedure TFrm_Main_New.p_SetFrm(Frm: TScrollingWinControl; TabSheet: TRzTabSheet);
begin
  Frm.Align := alClient;
  Frm.Parent := TabSheet;
  //Frm.BorderStyle := bsNone;
end;

procedure TFrm_Main_New.N43Click(Sender: TObject);
var
  str: string;
  Obj: TFra_ddcx;
procedure p_New;
begin
  if Fra_ddcx1 = nil then Fra_ddcx1 := TFra_ddcx.Create(Self);
  Obj := Fra_ddcx1;
  p_SetFrm(Obj, p_NewSheet('订单查询', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_ddcx.ClassName) then
    p_New;

  Obj := Fra_ddcx1;
  //Caption := c_TitleName +'--订单查询';
  FraHide(Sender);
  Obj.Align := alclient;

  str := Obj.cbb_bb.Text;
  Obj.cbb_bb.ItemIndex := Obj.cbb_bb.Items.IndexOf(str);
  if Obj.cbb_bb.ItemIndex = -1 then
    Obj.cbb_bb.ItemIndex := 0;

  Obj.cbb_bb.Enabled := True;

  str := Obj.cbb_cplb.Text;
  Obj.cbb_cplb.Clear;
  Obj.cbb_cplb.Items.Add('--全部--');
  CbbAdd(Obj.cbb_cplb,pkProductCategory);
  Obj.cbb_cplb.ItemIndex := Obj.cbb_cplb.Items.IndexOf(str);
  if Obj.cbb_cplb.ItemIndex = -1 then
  Obj.cbb_cplb.ItemIndex := c_Default_CPLB;       //默认选择邮政贺卡

  str := Obj.cbb_cplx.Text;
  Obj.cbb_cplx.Clear;
  Obj.cbb_cplx.Items.Add('--全部--');
  CbbAdd(Obj.cbb_cplx,pkProductType,FindProductCategoryID(Obj.cbb_cplb.ItemIndex));
  Obj.cbb_cplx.ItemIndex := Obj.cbb_cplx.Items.IndexOf(str);
  if Obj.cbb_cplx.ItemIndex = -1 then
    Obj.cbb_cplx.ItemIndex := 0;
    
  Obj.dtp_jsq.DateTime := Now;
  Obj.dtp_jsz.DateTime := Now;
  Obj.FraShow;
  Obj.Visible := True;
  Application.ProcessMessages;
  Obj.btn_cx.Click;
end;

procedure TFrm_Main_New.N65Click(Sender: TObject);
var
  str: string;
  Obj: TFra_tg;
procedure p_New;
begin
  if Fra_tg1 = nil then Fra_tg1 := TFra_tg.Create(Self);
  Obj := Fra_tg1;
  p_SetFrm(Obj, p_NewSheet('图稿状态(内部)', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_tg.ClassName, '图稿状态(内部)') then
    p_New;

  Obj := Fra_tg1;
  //Caption := c_TitleName +'--图稿状态(内部)';
  FraHide(Sender);
  Obj.Align := alclient;
//  Obj.Height := Self.Height;
  Obj.btn_fk.Visible := False;
  Obj.btn_ok.Visible := True;

  if Obj.cbb_tgzt.ItemIndex = -1 then
    Obj.cbb_tgzt.ItemIndex := 0;

  Obj.cbb_tgzt.Enabled := True;
  with Obj.cbb_llzt.Items do
  begin
    Clear;
    Add('--请选择--');
    Add('图稿未收到');
    Add('图稿已收到');
//    Add('打样中');
    Add('图稿未合格');
    Add('图稿已合格');
    Add('已打样');
//    Add('已签样');
  end;
  //获取产品类别
  //Obj.btn_tgysd.Visible := False;    //隐藏已收到
  Obj.cbb_bb.Enabled := True;        //显示版别

  str := Obj.cbb_cplb.Text;
  Obj.cbb_cplb.Clear;
  Obj.cbb_cplb.Items.Add('--全部--');
  CbbAdd(Obj.cbb_cplb,pkProductCategory);
  Obj.cbb_cplb.ItemIndex := Obj.cbb_cplb.Items.IndexOf(str);
  if Obj.cbb_cplb.ItemIndex = -1 then
    Obj.cbb_cplb.ItemIndex := c_Default_CPLB;       //默认选择邮政贺卡

  str := Obj.cbb_cplx.Text;
  Obj.cbb_cplx.Clear;
  Obj.cbb_cplx.Items.Add('--全部--');
  CbbAdd(Obj.cbb_cplx,pkProductType,FindProductCategoryID(Obj.cbb_cplb.ItemIndex));
  Obj.cbb_cplx.ItemIndex := Obj.cbb_cplx.Items.IndexOf(str);
  if Obj.cbb_cplx.ItemIndex = -1 then
    Obj.cbb_cplx.ItemIndex := 0;

  if Obj.cbb_llzt.ItemIndex = -1 then
    Obj.cbb_llzt.ItemIndex := 0;
  if Obj.cbb_bb.ItemIndex = -1 then
    Obj.cbb_bb.ItemIndex := 0;
    
  Obj.CustomLvAdd;
  Obj.FraShow;
  Obj.Visible := True;
  Application.ProcessMessages;
  Obj.btn_cx.Click;
end;

procedure TFrm_Main_New.N64Click(Sender: TObject);
var
  str: string;
  Obj: TFra_tg;
procedure p_New;
begin
  if Fra_tg1 = nil then Fra_tg1 := TFra_tg.Create(Self);
  Obj := Fra_tg1;

  p_SetFrm(Obj, p_NewSheet('图稿状态', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_tg.ClassName, '图稿状态') then
    p_New;

  Obj := Fra_tg1;
  //Caption := c_TitleName +'--图稿状态';
  FraHide(Sender);
  Obj.Align := alclient;
//  Obj.Height := Self.Height;
  Obj.btn_fk.Visible := True;
  Obj.btn_ok.Visible := False;

  if Obj.cbb_tgzt.ItemIndex = -1 then
    Obj.cbb_tgzt.ItemIndex := 0;
  Obj.cbb_tgzt.Enabled := True;
  Obj.cbb_bb.Enabled := True;
  //  Obj.cbb_tgzt.EditLabel.Caption := '内部状态';
  with Obj.cbb_llzt.Items do
  begin
    Clear;
    Add('--请选择--');
    Add('图稿未收到');
    Add('图稿已收到');
    Add('图稿未合格');
    Add('图稿已合格');
    Add('已打样');
//    Add('已签样');
  end;

  //Obj.btn_tgysd.Visible := False;    //隐藏已收到
  Obj.cbb_bb.Enabled := True;        //显示版别
  //获取产品类别
  str := Obj.cbb_cplb.Text;
  Obj.cbb_cplb.Clear;
  Obj.cbb_cplb.Items.Add('--全部--');
  CbbAdd(Obj.cbb_cplb,pkProductCategory);
  Obj.cbb_cplb.ItemIndex := Obj.cbb_cplb.Items.IndexOf(str);
  if Obj.cbb_cplb.ItemIndex = -1 then
    Obj.cbb_cplb.ItemIndex := c_Default_CPLB;       //默认选择邮政贺卡
  str := Obj.cbb_cplx.Text;
  Obj.cbb_cplx.Clear;
  Obj.cbb_cplx.Items.Add('--全部--');
  CbbAdd(Obj.cbb_cplx,pkProductType,FindProductCategoryID(Obj.cbb_cplb.ItemIndex));
  Obj.cbb_cplx.ItemIndex := Obj.cbb_cplx.Items.IndexOf(str);
  if Obj.cbb_cplx.ItemIndex = -1 then
    Obj.cbb_cplx.ItemIndex := 0;

  if Obj.cbb_llzt.ItemIndex = -1 then
   Obj.cbb_llzt.ItemIndex := 0;
  if Obj.cbb_bb.ItemIndex = -1 then
    Obj.cbb_bb.ItemIndex := 0;
    
  Obj.CustomLvAdd;
  Obj.FraShow;
  Obj.Visible := True;
  Application.ProcessMessages;
  Obj.btn_cx.Click;
end;

procedure TFrm_Main_New.N101Click(Sender: TObject);
var
  str: string;
  Obj: TFra_kd;
procedure p_New;
begin
  if Fra_kd1 = nil then Fra_kd1 := TFra_kd.Create(Self);
  Obj := Fra_kd1;

  p_SetFrm(Obj, p_NewSheet('开工单', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_kd.ClassName) then
    p_New;

  Obj := Fra_kd1;
  //Caption := c_TitleName +'--开工单';
  FraHide(Sender);
  Obj.Align := alclient;
//  Obj.CustomLvAdd;
  str := Obj.cbb_cplb.Text;
  Obj.cbb_cplb.Clear;
  Obj.cbb_cplb.Items.Add('--全部--');
  CbbAdd(Obj.cbb_cplb,pkProductCategory);
  Obj.cbb_cplb.ItemIndex := Obj.cbb_cplb.IndexOf(str);
  if Obj.cbb_cplb.ItemIndex = -1 then
    Obj.cbb_cplb.ItemIndex := c_Default_CPLB;       //默认选择邮政贺卡

  str := Obj.cbb_cplx.Text;
  Obj.cbb_cplx.Clear;
  Obj.cbb_cplx.Items.Add('--全部--');
  CbbAdd(Obj.cbb_cplx,pkProductType,FindProductCategoryID(Obj.cbb_cplb.ItemIndex));
  Obj.cbb_cplx.ItemIndex := Obj.cbb_cplx.IndexOf(str);
  if Obj.cbb_cplx.ItemIndex = -1 then
    Obj.cbb_cplx.ItemIndex := 0;

  if Obj.cbb_ddlx.ItemIndex = -1 then
    Obj.cbb_ddlx.ItemIndex := 0;
    
  Obj.FraShow;
  Obj.Visible := True;
  Application.ProcessMessages;
  Obj.btn_cx.Click;
end;

procedure TFrm_Main_New.N97Click(Sender: TObject);
var
  str: string;
  Obj: Tfra_gdcx;
const
  c_gdcx = 1;
  c_gdxg = 2;
procedure p_New;
begin
  if fra_gdcx1 = nil then fra_gdcx1 := Tfra_gdcx.Create(Self);
  Obj := fra_gdcx1;

  p_SetFrm(Obj, p_NewSheet(iif(TMenuItem(Sender).Tag = c_gdxg, '工单修改', '工单查询'), integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(Tfra_gdcx.ClassName, iif(TMenuItem(Sender).Tag = c_gdxg, '工单修改', '工单查询')) then
    p_New;

  Obj := fra_gdcx1;
  case TMenuItem(Sender).Tag  of
    c_gdcx:
      begin
        //Caption := c_TitleName +'--工单查询';
        fra_gdcx1.vActionType := c_WorkOrder_Select;
        if LoginData.m_iUserType in [c_User_Small,c_Admin_Small] then   //小批量用户
          fra_gdcx1.cbb_xpl.Enabled := True;
      end;
     c_gdxg:
       begin
         //Caption := c_TitleName +'--工单修改';
        fra_gdcx1.vActionType := c_WorkOrder_Modify;
        if LoginData.m_iUserType in [c_User_Small,c_Admin_Small] then   //小批量用户
          fra_gdcx1.cbb_xpl.Enabled := False;
       end;
  else
    //Caption := c_TitleName +'--工单查询';
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

procedure TFrm_Main_New.N127Click(Sender: TObject);
var
  sCaption: string;
  Obj: TFra_scgl;
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
procedure p_New;
begin
  if Fra_scgl1 = nil then Fra_scgl1 := TFra_scgl.Create(Self);
  Obj := Fra_scgl1;

  p_SetFrm(Obj, p_NewSheet(sCaption, integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  sCaption := '';
  case TMenuItem(Sender).Tag of
    c_sczb:
      begin
        sCaption := '制版';
      end;
    c_scys:                                                                                                                                          
      begin
        sCaption := '印刷';
      end;
    c_scdh:
      begin
        sCaption := '打号';
      end;
    c_schdjg:
      begin
        sCaption := '后道加工';
      end;
    c_scjc:
      begin
        sCaption := '进仓';
      end;
    c_scfh:
      begin
        sCaption := '发货';
      end;
    c_scfhdy:
      begin
        sCaption := '发货打印';
      end;
  end;

  //
  if not self.p_ActivePage(TFra_scgl.ClassName, sCaption) then
    p_New;

  Obj := Fra_scgl1;

  FraHide(Sender);
  Fra_scgl1.btn_ysdh.Visible := False;
  Fra_scgl1.vFraType := TRzGroupItem(Sender).Tag;
  case TMenuItem(Sender).Tag of
    c_sczb:
      begin
        //Caption := c_TitleName +'--制版';
       // Fra_scgl1.btn_zbap.Visible := True;
        Fra_scgl1.cbb_sczt.ItemIndex := c_cx_sczb-1;
      end;
    c_scys:                                                                                                                                          
      begin
        //Caption := c_TitleName +'--印刷';
        Fra_scgl1.cbb_sczt.ItemIndex := c_cx_scys-1;
        Fra_scgl1.btn_ysdh.Visible := True;
      end;
    c_scdh:
      begin
        //Caption := c_TitleName +'--打号';
        Fra_scgl1.cbb_sczt.ItemIndex := c_cx_scdh-1;
      end;
    c_schdjg:
      begin
        //Caption := c_TitleName +'--后道加工';
        Fra_scgl1.cbb_sczt.ItemIndex := c_cx_schdjg-1;
      end;
    c_scjc:
      begin
        Caption := c_TitleName +'--进仓';
        Fra_scgl1.cbb_sczt.ItemIndex := c_cx_scjc-1;
      end;
    c_scfh:
      begin
        //Caption := c_TitleName +'--发货';
        //Fra_scgl1.cbb_sczt.ItemIndex := c_cx_scfh-1;
        Fra_FHGL1.Align := alClient;
        Fra_FHGL1.dtp_jcq.DateTime := Now;
        Fra_FHGL1.dtp_jcz.DateTime := Now;
        Fra_FHGL1.FrmShow;
        Fra_FHGL1.Visible := True;
        Application.ProcessMessages;
        Fra_FHGL1.btn_cx.Click;
        Exit;
      end;
    c_scfhdy:
      begin
        //Caption := c_TitleName +'--发货打印';
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

procedure TFrm_Main_New.N122Click(Sender: TObject);
var
  Obj: TFra_XQCX;
procedure p_New;
begin
  if Fra_XQCX1 = nil then Fra_XQCX1 := TFra_XQCX.Create(Self);
  Obj := Fra_XQCX1;

  p_SetFrm(Obj, p_NewSheet('箱签', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  //Caption := c_TitleName +'--箱签';
  //
  if not self.p_ActivePage(TFra_XQCX.ClassName) then
    p_New;

  Obj := Fra_XQCX1;

  FraHide(Sender);
  Obj.Align := alClient;
  Obj.FraShow;
  Obj.Visible := True;
  Application.ProcessMessages;
  Obj.btn_cx.Click;
end;

procedure TFrm_Main_New.N11Click(Sender: TObject);
var
  Obj: TFra_FHFK;
procedure p_New;
begin
  if Fra_FHFK1 = nil then Fra_FHFK1 := TFra_FHFK.Create(Self);
  Obj := Fra_FHFK1;

  p_SetFrm(Obj, p_NewSheet('发货反馈', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_FHFK.ClassName) then
    p_New;

  Obj := Fra_FHFK1;

  //Caption := c_TitleName +'--发货反馈';
  FraHide(Sender);
  Fra_FHFK1.Align := alClient;
  Fra_FHFK1.FraShow;
  Fra_FHFK1.Visible := True;
  Application.ProcessMessages;
  Fra_FHFK1.btn_cx.Click;
end;

procedure TFrm_Main_New.N156Click(Sender: TObject);
var
  Obj: TFra_ywtj;
procedure p_New;
begin
  if Fra_ywtj1 = nil then Fra_ywtj1 := TFra_ywtj.Create(Self);
  Obj := Fra_ywtj1;

  p_SetFrm(Obj, p_NewSheet('业务统计', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_ywtj.ClassName) then
    p_New;

  Obj := Fra_ywtj1;

  //Caption := c_TitleName +'--业务统计';
  FraHide(Sender);
  Fra_ywtj1.Align := alclient;
  Fra_ywtj1.FraShow;
  Fra_ywtj1.Visible := True;
  Application.ProcessMessages;
  Fra_ywtj1.btn_cx.Click;
end;

procedure TFrm_Main_New.N155Click(Sender: TObject);
var
  Obj: TFra_sctj;
procedure p_New;
begin
  if Fra_sctj1 = nil then Fra_sctj1 := TFra_sctj.Create(Self);
  Obj := Fra_sctj1;

  p_SetFrm(Obj, p_NewSheet('生产统计', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_sctj.ClassName) then
    p_New;

  Obj := Fra_sctj1;

  //Caption := c_TitleName +'--生产统计';
  FraHide(Sender);
  Fra_sctj1.Align := alclient;
  Fra_sctj1.FraShow;
  Fra_sctj1.Visible := True;
  Application.ProcessMessages;
  Fra_sctj1.btn_cx.Click;
end;

procedure TFrm_Main_New.N154Click(Sender: TObject);
var
  Obj: TFra_FHTJ;
procedure p_New;
begin
  if Fra_FHTJ1 = nil then Fra_FHTJ1 := TFra_FHTJ.Create(Self);
  Obj := Fra_FHTJ1;

  p_SetFrm(Obj, p_NewSheet('发货统计', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_FHTJ.ClassName) then
    p_New;

  Obj := Fra_FHTJ1;

  //Caption := c_TitleName +'--发货统计';
  FraHide(Sender);
  Fra_FHTJ1.Align := alClient;
  Fra_FHTJ1.FraShow;
  Fra_FHTJ1.Visible := True;
  Application.ProcessMessages;
  Fra_FHTJ1.btn_cx.Click;

end;

procedure TFrm_Main_New.N153Click(Sender: TObject);
var
  Obj: TFra_CLTJ;
procedure p_New;
begin
  if Fra_CLTJ1 = nil then Fra_CLTJ1 := TFra_CLTJ.Create(Self);
  Obj := Fra_CLTJ1;

  p_SetFrm(Obj, p_NewSheet('材料统计', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_CLTJ.ClassName) then
    p_New;

  Obj := Fra_CLTJ1;

  //Caption := c_TitleName +'--材料统计';
  FraHide(Sender);
  Fra_CLTJ1.Align := alClient;
  Fra_CLTJ1.FraShow;
  Fra_CLTJ1.Visible := True;
  Application.ProcessMessages;
  Fra_CLTJ1.btn_cx.Click;

end;

procedure TFrm_Main_New.N151Click(Sender: TObject);
var
  Obj: TFra_JTTJ;
procedure p_New;
begin
  if Fra_JTTJ1 = nil then Fra_JTTJ1 := TFra_JTTJ.Create(Self);
  Obj := Fra_JTTJ1;

  p_SetFrm(Obj, p_NewSheet('机台统计', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_JTTJ.ClassName) then
    p_New;

  Obj := Fra_JTTJ1;

  //Caption := c_TitleName +'--机台统计';
  FraHide(Sender);
  Fra_JTTJ1.Align := alClient;
  Fra_JTTJ1.FraShow;
  Fra_JTTJ1.Visible := True;
  Application.ProcessMessages;
  Fra_JTTJ1.btn_cx.Click;
end;

procedure TFrm_Main_New.N150Click(Sender: TObject);
var
  Obj: TFra_XHQD;
procedure p_New;
begin
  if Fra_XHQD1 = nil then Fra_XHQD1 := TFra_XHQD.Create(Self);
  Obj := Fra_XHQD1;

  p_SetFrm(Obj, p_NewSheet('销毁清单', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_XHQD.ClassName) then
    p_New;

  Obj := Fra_XHQD1;

  //Caption := c_TitleName +'--销毁清单';
  FraHide(Sender);
  Fra_XHQD1.Align := alClient;
  Fra_XHQD1.FraShow;
  Fra_XHQD1.Visible := True;
  Application.ProcessMessages;
  Fra_XHQD1.btn_cx.Click;
end;

procedure TFrm_Main_New.N143Click(Sender: TObject);
var
  Obj: TFra_WGYBB;
procedure p_New;
begin
  if Fra_WGYBB1 = nil then Fra_WGYBB1 := TFra_WGYBB.Create(Self);
  Obj := Fra_WGYBB1;

  p_SetFrm(Obj, p_NewSheet('完工月报表', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_WGYBB.ClassName) then
    p_New;

  Obj := Fra_WGYBB1;

  //Caption := c_TitleName +'--完工月报表';
  FraHide(Sender);
  Fra_WGYBB1.Align := alClient;
  Fra_WGYBB1.FraShow;
  Fra_WGYBB1.Visible := True;
  Application.ProcessMessages;
  Fra_WGYBB1.btn_cx.Click;
end;

procedure TFrm_Main_New.N131Click(Sender: TObject);
var
  Obj: TFra_CPYBB;
procedure p_New;
begin
  if Fra_CPYBB1 = nil then Fra_CPYBB1 := TFra_CPYBB.Create(Self);
  Obj := Fra_CPYBB1;

  p_SetFrm(Obj, p_NewSheet('产品月报表', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_CPYBB.ClassName) then
    p_New;

  Obj := Fra_CPYBB1;

  //Caption := c_TitleName +'--产品月报表';
  FraHide(Sender);
  Fra_CPYBB1.Align := alClient;
  Fra_CPYBB1.FraShow;
  Fra_CPYBB1.Visible := True;
  Application.ProcessMessages;
  Fra_CPYBB1.btn_cx.Click;
end;

procedure TFrm_Main_New.N183Click(Sender: TObject);
var
  Obj: TFra_ParamSet;
procedure p_New;
begin
  if Fra_ParamSet1 = nil then Fra_ParamSet1 := TFra_ParamSet.Create(Self);
  Obj := Fra_ParamSet1;

  p_SetFrm(Obj, p_NewSheet('参数设置', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_ParamSet.ClassName) then
    p_New;

  Obj := Fra_ParamSet1;

  FraHide(Sender);
  Fra_ParamSet1.Align := alclient;
  Fra_ParamSet1.RefreshTv;
  Fra_ParamSet1.Visible := True;
end;

procedure TFrm_Main_New.N181Click(Sender: TObject);
var
  Obj: TFra_yztgl;
procedure p_New;
begin
  if Fra_yztgl1 = nil then Fra_yztgl1 := TFra_yztgl.Create(Self);
  Obj := Fra_yztgl1;

  p_SetFrm(Obj, p_NewSheet('邮资图管理', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_yztgl.ClassName) then
    p_New;

  Obj := Fra_yztgl1;

  FraHide(Sender);
  Fra_yztgl1.Align := alclient;
  Fra_yztgl1.FraShow;
//  Fra_yztgl1.ReadDataYZTXX;
//  Fra_yztgl1.cbb_cplb.Clear;
//  CbbAdd(Fra_yztgl1.cbb_cplb,pkProductCategory);
//  Fra_yztgl1.cbb_cplx.Clear;
//  Fra_yztgl1.cbb_cplb.ItemIndex := iif(c_Default_CPLB=0,0,c_Default_CPLB-1);       //默认选择邮政贺卡
//  CbbAdd(Fra_yztgl1.cbb_cplx,pkProductType,ProductCategory[1].m_iID);
  Fra_yztgl1.Visible := True;
end;

procedure TFrm_Main_New.N180Click(Sender: TObject);
var
  Obj: TFra_CPLB_GL;
procedure p_New;
begin
  if Fra_CPLB_GL1 = nil then Fra_CPLB_GL1 := TFra_CPLB_GL.Create(Self);
  Obj := Fra_CPLB_GL1;

  p_SetFrm(Obj, p_NewSheet('产品类别管理', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_CPLB_GL.ClassName) then
    p_New;

  Obj := Fra_CPLB_GL1;

  //Caption := c_TitleName +'--产品类别管理';
  FraHide(Sender);
  Fra_CPLB_GL1.Align := alClient;
  Fra_CPLB_GL1.FraShow;
  Fra_CPLB_GL1.Visible := True;
  Application.ProcessMessages;
end;

procedure TFrm_Main_New.N179Click(Sender: TObject);
var
  Obj: TFra_cplx_gl;
procedure p_New;
begin
  if Fra_cplx_gl1 = nil then Fra_cplx_gl1 := TFra_cplx_gl.Create(Self);
  Obj := Fra_cplx_gl1;

  p_SetFrm(Obj, p_NewSheet('产品类型管理', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_cplx_gl.ClassName) then
    p_New;

  Obj := Fra_cplx_gl1;

  FraHide(Sender);
  Fra_cplx_gl1.Align := alclient;
  Fra_cplx_gl1.ReadDataCPLXXX;
  Fra_cplx_gl1.cbb_cplb.Clear;
  CbbAdd(Fra_cplx_gl1.cbb_cplb,pkProductCategory);
  Fra_cplx_gl1.cbb_cplb.ItemIndex := iif(c_Default_CPLB=0,0,c_Default_CPLB-1);;       //默认选择邮政贺卡
  Fra_cplx_gl1.Visible := True;
end;

procedure TFrm_Main_New.N178Click(Sender: TObject);
var
  Obj: TFra_MatlManage;
procedure p_New;
begin
  if Fra_MatlManage1 = nil then Fra_MatlManage1 := TFra_MatlManage.Create(Self);
  Obj := Fra_MatlManage1;

  p_SetFrm(Obj, p_NewSheet('材料管理', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_MatlManage.ClassName) then
    p_New;

  Obj := Fra_MatlManage1;

  //Caption := c_TitleName +'--材料管理';
  FraHide(Sender);
  Fra_MatlManage1.Align := alClient;
  Fra_MatlManage1.FraShow;
  Fra_MatlManage1.Visible := True;
  Application.ProcessMessages;
end;

procedure TFrm_Main_New.N177Click(Sender: TObject);
var
  Obj: TFra_MachineManage;
procedure p_New;
begin
  if Fra_MachineManage1 = nil then Fra_MachineManage1 := TFra_MachineManage.Create(Self);
  Obj := Fra_MachineManage1;

  p_SetFrm(Obj, p_NewSheet('机台管理', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_MachineManage.ClassName) then
    p_New;

  Obj := Fra_MachineManage1;

  //Caption := c_TitleName +'--机台管理';
  FraHide(Sender);
  Fra_MachineManage1.Align := alClient;
  Fra_MachineManage1.FraShow;
  Fra_MachineManage1.Visible := True;
  Application.ProcessMessages;
end;

procedure TFrm_Main_New.N176Click(Sender: TObject);
var
  Obj: TFra_ZBGX_GL;
procedure p_New;
begin
  if Fra_ZBGX_GL1 = nil then Fra_ZBGX_GL1 := TFra_ZBGX_GL.Create(Self);
  Obj := Fra_ZBGX_GL1;

  p_SetFrm(Obj, p_NewSheet('制版工序管理', integer(Obj)));
  G_SetUI(TForm(Obj));
  Obj.Show;
end;
begin
  if not self.p_ActivePage(TFra_ZBGX_GL.ClassName) then
    p_New;

  Obj := Fra_ZBGX_GL1;

  //Caption := c_TitleName +'--制版工序管理';
  FraHide(Sender);
  Fra_ZBGX_GL1.Align := alClient;
  Fra_ZBGX_GL1.FraShow;
  Fra_ZBGX_GL1.Visible := True;
  Application.ProcessMessages;
end;

end.
