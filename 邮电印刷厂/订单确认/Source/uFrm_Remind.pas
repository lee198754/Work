unit uFrm_Remind;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, iGrid, StdCtrls, ExtCtrls, RzPanel,ADODB,uPub_Type;

type
  TFrm_Remind = class(TForm)
    lab_Text: TLabel;
    gb_Remind: TRzGroupBox;
    stg_Remind: Ti_StgEdit;
    edt_Temp: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure stg_RemindLinkClick(Sender: TObject; ACol, ARow: Integer);
  private
    { Private declarations }
    procedure GDHClick(sGDH: string);
    procedure CPBHClick(sCPBH: string);
  public
    { Public declarations }
    aField:TArrSelectField;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  Frm_Remind: TFrm_Remind;

implementation

{$R *.dfm}

uses
  uMain, uFraddcx, uPub_Text, uPub_Func, uFrm_GDH_XZ,
  uDM_DataBase, uWorkOrder,PubStr;

{ TFrm_Remind }

procedure TFrm_Remind.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent :=   0 ;//就是桌面
end;

procedure TFrm_Remind.Button1Click(Sender: TObject);
begin
  with Frm_Main do
  begin
    if not Assigned(Fra_ddcx1) then
    begin
      Fra_ddcx1 := TFra_ddcx.Create(Frm_Main);
      Fra_ddcx1.Hide;
      Fra_ddcx1.Parent := Frm_Main;
    end;
{    case LoginData.m_iUserType of
      c_User:
        Fra_ddcx1.cbb_xpl.ItemIndex := 1;       //普通;
      c_Admin:
        Fra_ddcx1.cbb_xpl.ItemIndex := 1;       //普通;
      c_User_Small:
        Fra_ddcx1.cbb_xpl.ItemIndex := 2;       //小批量
      c_Admin_Small:
        Fra_ddcx1.cbb_xpl.ItemIndex := 2;         //小批量
      c_SuperAdmin:;
    end;
    Fra_ddcx1.cbb_txlx.ItemIndex := 1;
    Fra_ddcx1.cbb_bb.ItemIndex := 0;
    Fra_ddcx1.cbb_bb.Enabled := True;

    Fra_ddcx1.cbb_cplb.Clear;
    Fra_ddcx1.cbb_cplb.Items.Add('--全部--');
    CbbAdd(Fra_ddcx1.cbb_cplb,pkProductCategory);
    Fra_ddcx1.cbb_cplb.ItemIndex := 0;

    Fra_ddcx1.cbb_cplx.Clear;
    Fra_ddcx1.cbb_cplx.Items.Add('--全部--');
    CbbAdd(Fra_ddcx1.cbb_cplx,pkProductType,FindProductCategoryID(Fra_ddcx1.cbb_cplb.ItemIndex));
    Fra_ddcx1.cbb_cplx.ItemIndex := 0;  }
    Fra_ddcx1.Init;
    Fra_ddcx1.Align := alClient;
    Fra_ddcx1.FraShow;
    Fra_ddcx1.edt_cpbh.Text := '';
    Fra_ddcx1.Visible := True;
    Application.ProcessMessages;
    Fra_ddcx1.btn_cx.Click;
    setForegroundWindow(Frm_Main.Handle);
  end;
end;

procedure TFrm_Remind.GDHClick(sGDH: string);
var
  ADO_Rec: TADOQuery;
  i, n, iOrderType, iApartID, iWorkID, iGroupID: Integer;
  sSqlData: string;
begin
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
  sSqlData := 'select a.F_iID from DO_WorkOrder a where a.F_sGDH=''%s'' ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sGDH,iApartID],False);
  if ADO_Rec.RecordCount > 0 then
  begin
    iWorkID := ADO_Rec.FieldByName('F_iID').AsInteger;
    Frm_WorkOrder := TFrm_WorkOrder.Create(Self);
    Frm_WorkOrder.vWorkID := iWorkID;
    Frm_WorkOrder.vGroupID := 1;
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

procedure TFrm_Remind.stg_RemindLinkClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  if aField[ACol-1].m_sName='工单号' then
  begin
    GDHClick(stg_Remind.Cells[ACol,ARow]);
  end else
  if aField[ACol-1].m_sName='产品编号' then
  begin
    CPBHClick(stg_Remind.Cells[ACol,ARow]);
  end;
end;

procedure TFrm_Remind.CPBHClick(sCPBH: string);
var
  iIndex: Integer;
begin
  if sCPBH = '' then Exit;
  with Frm_Main do
  begin
    if not Assigned(Fra_ddcx1) then
    begin
      Fra_ddcx1 := TFra_ddcx.Create(Frm_Main);
      Fra_ddcx1.Hide;
      Fra_ddcx1.Parent := Frm_Main;
    end;
{    case LoginData.m_iUserType of
      c_User:
        Fra_ddcx1.cbb_xpl.ItemIndex := 1;       //普通;
      c_Admin:
        Fra_ddcx1.cbb_xpl.ItemIndex := 1;       //普通;
      c_User_Small:
        Fra_ddcx1.cbb_xpl.ItemIndex := 2;       //小批量
      c_Admin_Small:
        Fra_ddcx1.cbb_xpl.ItemIndex := 2;         //小批量
      c_SuperAdmin:;
    end;
    Fra_ddcx1.cbb_txlx.ItemIndex := 0;
    Fra_ddcx1.cbb_bb.ItemIndex := 0;
    Fra_ddcx1.cbb_bb.Enabled := True;

    Fra_ddcx1.cbb_cplb.Clear;
    Fra_ddcx1.cbb_cplb.Items.Add('--全部--');
    CbbAdd(Fra_ddcx1.cbb_cplb,pkProductCategory);
    Fra_ddcx1.cbb_cplb.ItemIndex := 0;

    Fra_ddcx1.cbb_cplx.Clear;
    Fra_ddcx1.cbb_cplx.Items.Add('--全部--');
    CbbAdd(Fra_ddcx1.cbb_cplx,pkProductType,FindProductCategoryID(Fra_ddcx1.cbb_cplb.ItemIndex));
    Fra_ddcx1.cbb_cplx.ItemIndex := 0;   }

    Fra_ddcx1.Init;
    Fra_ddcx1.Align := alClient;
    Fra_ddcx1.FraShow;
    Fra_ddcx1.edt_cpbh.Text := StrLeft(sCPBH,17);
    iIndex := Fra_ddcx1.cbb_txlx.ItemIndex;
    Fra_ddcx1.cbb_txlx.ItemIndex := 1;
    Fra_ddcx1.Visible := True;
    Application.ProcessMessages;
    Fra_ddcx1.btn_cx.Click;
    Fra_ddcx1.cbb_txlx.ItemIndex := iIndex;
    setForegroundWindow(Frm_Main.Handle);
  end;
end;

end.
