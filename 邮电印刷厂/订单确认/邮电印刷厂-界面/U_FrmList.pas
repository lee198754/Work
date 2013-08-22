unit U_FrmList;

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
  uFra_CLRK;

type
  TFrmList = class(TForm)
  protected
    Fra_ParamSet1: TFra_ParamSet;
    Fra_WorkerManage1: TFra_WorkerManage;
    Fra_cplx_gl1: TFra_cplx_gl;
    Fra_UserAdd1: TFra_UserAdd;
    Fra_yztgl1: TFra_yztgl;
    Fra_kd1: TFra_kd;
    Fra_DDJY_CX1: TFra_DDJY_CX;
    Fra_Pwd_Modify1: TFra_Pwd_Modify;
    Fra_FHGL1: TFra_FHGL;
    Fra_MatlManage1: TFra_MatlManage;
    Fra_MachineManage1: TFra_MachineManage;
    Fra_XHQD1: TFra_XHQD;
    Fra_CPLB_GL1: TFra_CPLB_GL;
    //Fra_tgnb1: TFra_tg;
    Fra_tg1: TFra_tg;
    Fra_ZBGX_GL1: TFra_ZBGX_GL;
    Fra_ywtj1: TFra_ywtj;
    Fra_FHFK1: TFra_FHFK;
    Fra_scgl1: TFra_scgl;
    Fra_FYDHLR1: TFra_FYDHLR;
    Fra_sctj1: TFra_sctj;
    rg_tjbb: TRzGroup;
    Fra_DDLR1: TFra_DDLR;
    Fra_ddcx1: TFra_ddcx;
    fra_gdcx1: Tfra_gdcx;
    Fra_FHGL_DYCX1: TFra_FHGL_DYCX;
    Fra_FHTJ1: TFra_FHTJ;
    Fra_JTTJ1: TFra_JTTJ;
    Fra_WGYBB1: TFra_WGYBB;
    Fra_CPYBB1: TFra_CPYBB;
    rg_kcgl: TRzGroup;
    Fra_CLRK1: TFra_CLRK;
    Fra_CLTJ1: TFra_CLTJ;
    Fra_XQCX1: TFra_XQCX;
  protected
    procedure FraHide(Sender: TObject);
    procedure MenuHide;
    procedure InitFra(Fra: TFrame);
    function FindMenu(sName: string): TRzGroupItem;
    procedure WriteLoginLog(iUserID: Integer;sUserName,sType: string);
    procedure ClearBold;

    //
    procedure p_OnShow();
  public
    g_bIsRunAgain: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses
  uLogin, uPub_Type, uPub_Func, uDDMX_DZX, uDDMX_XSX, uPub_Text, PubStr;

const
  c_User = 0;
  c_Admin = 1;
  c_User_Small=5;
  c_Admin_Small=6;
  c_SuperAdmin = 10;

{ TFrmList }

procedure TFrmList.ClearBold;
var
  i,j: Integer;
begin
  {for i := 0 to gb_Menu.ControlCount -1 do
  begin
    if gb_Menu.Controls[i] is TRzGroup then
    begin
      for j := 0 to TRzGroup(gb_Menu.Controls[i]).Items.Count -1 do
      begin
        if TRzGroup(gb_Menu.Controls[i]).Items.Items[j].Visible then
          TRzGroup(gb_Menu.Controls[i]).Items.Items[j].FontStyle := [];
      end;
    end;
  end;}
end;

constructor TFrmList.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TFrmList.Destroy;
begin

  inherited;
end;

function TFrmList.FindMenu(sName: string): TRzGroupItem;
var
  i,j: integer;
begin
  Result := nil;
  {for i := 0 to gb_Menu.ControlCount -1 do
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
  end;}
end;

procedure TFrmList.FraHide(Sender: TObject);
var
  i: integer;
begin
  {Fra_tg1.DoubleBuffered := True;
//  Fra_tg1.RzGroupBox1.DoubleBuffered := True;
//  Fra_tg1.RzPanel1.DoubleBuffered := True;
//  Fra_tg1.RzGroupBox3.DoubleBuffered := True;
  Fra_kd1.DoubleBuffered := True;
  fra_gdcx1.DoubleBuffered := True;
  Fra_ddcx1.DoubleBuffered := True;
  Fra_UserAdd1.DoubleBuffered := True;
  Fra_scgl1.DoubleBuffered := True;
  Fra_ParamSet1.DoubleBuffered := True;
  Fra_WorkerManage1.DoubleBuffered := True;
  Fra_yztgl1.DoubleBuffered := True;

  for i := 0 to Self.ComponentCount -1 do
  begin           
    if Self.Components[i].ClassParent.ClassName = TFrame.ClassName then
      TFrame(Self.Components[i]).Visible := False;
  end;}

  if Sender <> nil then
  begin
    ClearBold;
    //TRzGroupItem(Sender).FontStyle := [fsBold];
  end;
  InitFra(TFrame(Sender));
end;

procedure TFrmList.InitFra(Fra: TFrame);
begin
  if not Assigned(Fra) then Exit;
  GetProductCategoryList;             //获取产品类别
  GetProductTypeList;                 //获取产品类型
end;

procedure TFrmList.MenuHide;
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
  i, j, MaxID: integer;
  ADO_Rec: TADOQuery;
  sSqlData: string;
  MenuList: array of TMenu;
function FindMenuList(iID: Integer): PTMenu;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Length(MenuList) -1 do
  begin
    if MenuList[i].Id = iID then
    begin
      Result := @MenuList[i];
      Break;
    end;
  end;
end;
begin
  iLicenseCode := LoginData.m_iLicenseCode;
  MaxID := 0;
  {rg_sys_ddgl.Visible := False;
  rg_gdgl.Visible := False;
  rg_scgl.Visible := False;
  rg_SysManage.Visible := False;
  rg_yhgl.Visible := False;
  sSqlData := 'Select * from Sys_MenuInfo where F_tiStatus = 1 order by F_iID';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
  SetLength(MenuList,ADO_Rec.RecordCount);
  for i := 0 to ADO_Rec.RecordCount -1 do
  begin
    MenuList[i].Id := ADO_Rec.FieldByName('F_iID').AsInteger;
    MenuList[i].Name := ADO_Rec.FieldByName('F_sMenuName').AsString;
    MenuList[i].Status  := ADO_Rec.FieldByName('F_tiStatus').AsInteger;
    MenuList[i].Comp := FindMenu(MenuList[i].Name);
    if MenuList[i].Id > MaxID then
      MaxID := MenuList[i].Id;
    ADO_Rec.Next;
  end;}
  for i := 0 to length(MenuList) -1 do
  begin
    if 1 shl MenuList[i].Id or iLicenseCode = iLicenseCode then
    begin
      if Assigned(MenuList[i].Comp) then
        MenuList[i].Comp.Visible := True;
    end else
    begin
      if Assigned(MenuList[i].Comp) then
        MenuList[i].Comp.Visible := False;
    end;
  end;

{  for i := 1 to MaxID do
  begin
    pMenu := FindMenuList(i);
    if (pMenu <> nil) and (Assigned(pMenu.Comp))  then
    begin
      if iLicenseCode mod 2 =0 then
      begin
        pMenu.Comp.Visible := False;
      end else
      begin
        pMenu.Comp.Visible := True;
      end;
    end;
    iLicenseCode := iLicenseCode div 2;
  end;  }

  //
  {for i := 0 to gb_Menu.ControlCount -1 do
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
  end;}
end;

procedure TFrmList.p_OnShow();
begin

end;

procedure TFrmList.WriteLoginLog(iUserID: Integer; sUserName,
  sType: string);
var
  sSqlData: string;
begin
  sSqlData := 'Insert into Log_LoginLog (F_iUserID, F_sUserName,F_sType,F_sVersion) values (%d,''%s'',''%s'',''%s'')';
  DM_DataBase.ExecQuery(sSqlData,[iUserID,sUserName,sType,c_TitleName],False);
  if sType = '登录' then
  begin
    sSqlData := 'Update BI_UserList set F_tiOnLineFlag=%d  where F_iID=%d';
    DM_DataBase.ExecQuery(sSqlData,[1,iUserID],False);
  end else
  if sType = '退出' then
  begin
    sSqlData := 'Update BI_UserList set F_tiOnLineFlag=%d where F_iID=%d';
    DM_DataBase.ExecQuery(sSqlData,[0,iUserID],False);
  end;
end;

end.
