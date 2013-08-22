unit uFrm_WorkOrder_ZB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, iGrid, ExtCtrls, RzPanel, StdCtrls, RzButton, ButtonEdit,
  ADODB;

type
  TFrm_WorkOrder_ZB = class(TForm)
    RzPanel1: TRzPanel;
    RzGroupBox1: TRzGroupBox;
    stg_gxxx: Ti_StgEdit;
    RzPanel2: TRzPanel;
    RzGroupBox3: TRzGroupBox;
    Label24: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    edt_sbk: Ti_TxtFilter;
    cbb_sblb: TComboBox;
    cbb_sbks: TComboBox;
    btn_ok: TRzButton;
    btn_close: TRzButton;
    lb_Temp: TListBox;
    RzPanel3: TRzPanel;
    btn_Add: TRzButton;
    procedure edt_sbkExit(Sender: TObject);
    procedure lb_TempKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lb_TempKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lb_TempMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lb_TempMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure stg_gxxxLinkClick(Sender: TObject; ACol, ARow: Integer);
    procedure edt_sbkEnter(Sender: TObject);
    procedure edt_sbkKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_okClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure edt_sbkMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    bEnter: Boolean;
    vEdt: Ti_TxtFilter;
    function IfCheck: Boolean;
    procedure EdtExit(Sender: TObject);
    function GetData: Boolean;
    procedure p_LoadGXXX;
    procedure p_AddArrZB;
  public
    { Public declarations }
    vActionType: Integer;
    vGroupID: Integer;
  end;

var
  Frm_WorkOrder_ZB: TFrm_WorkOrder_ZB;

implementation

uses
  PubStr, uPub_Type, uPub_Func, uFrm_WorkOrder_ZB_GXTJ, uDM_DataBase, Registry, uPub_Text;

{$R *.dfm}

{ TFrm_WorkOrder_ZB }

procedure TFrm_WorkOrder_ZB.EdtExit(Sender: TObject);
begin
  bEnter := False;
  if (vEdt=nil) or (Ti_TxtFilter(Sender).Name <> vEdt.Name) then
    lb_Temp.Visible := False;
  edtCookie(Sender,c_Reg_ZB_CookiePath);
end;

function TFrm_WorkOrder_ZB.GetData: Boolean;
var
  i, n: Integer;
begin
  Result := False;
  n := -1;
  for i := 0 to Length(aZB) -1 do
  begin
    if aZB[i].m_iGroupID = vGroupID then
    begin
      n := i;
      Break;
    end;
  end;
  if n = -1 then
  begin
    Exit;
  end;
  cbb_sblb.Text := aZB[n].m_sSBLB;
  cbb_sbks.Text := aZB[n].m_sSBKS;
  edt_sbk.Text := IntToStr(aZB[n].m_iSBK);
  p_LoadGXXX;
  Result := True;
end;

function TFrm_WorkOrder_ZB.IfCheck: Boolean;
begin
  Result := False;

  Result := True;
end;

procedure TFrm_WorkOrder_ZB.p_LoadGXXX;
var
  i, n: integer;
begin
  stg_gxxx.Clear;
//  stg_gxxx.RowCount := iif(Length(aZBGX) > 0, Length(aZBGX) +1, 2);

  n := 1;
  for i :=  0 to Length(aZBGX) - 1 do
  begin
    if aZBGX[i].m_iGroupID = vGroupID then
    begin
      if n > 1 then
        stg_gxxx.RowCount := stg_gxxx.RowCount + 1;
      stg_gxxx.Cells[c_ZB_GXBH,n] := aZBGX[i].m_sCode;
      stg_gxxx.Cells[c_ZB_GXMC,n] := aZBGX[i].m_sName;
      stg_gxxx.Cells[c_ZB_LBGG,n] := aZBGX[i].m_sCategorySpec;
      stg_gxxx.Cells[c_ZB_CL,n] := aZBGX[i].m_sOutput;
      stg_gxxx.Cells[c_ZB_DW,n] := aZBGX[i].m_sUnit;
      stg_gxxx.Cells[c_ZB_BZ,n] := aZBGX[i].m_sBZ;
      stg_gxxx.Cells[c_ZB_CZ_XG,n] := '修改';
      stg_gxxx.CellsLink[c_ZB_CZ_XG,n] := '修改';
      stg_gxxx.Cells[c_ZB_CZ_SC,n] := '删除';
      stg_gxxx.CellsLink[c_ZB_CZ_SC,n] := '删除';
      stg_gxxx.Cells[c_ZB_GXID,n] := IntToStr(aZBGX[i].m_iID);
      inc(n);
    end;
  end;
  stg_gxxx.ColWidths[c_ZB_GXID] := 0;
end;

procedure TFrm_WorkOrder_ZB.edt_sbkExit(Sender: TObject);
begin
  EdtExit(Sender);
end;

procedure TFrm_WorkOrder_ZB.lb_TempKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (TListBox(Sender).ItemIndex<1) and (Key = VK_UP) then
  begin
    TListBox(Sender).ItemIndex := -1;
    TListBox(Sender).Selected[0] := False;
    vEdt.SetFocus;
  end;
end;

procedure TFrm_WorkOrder_ZB.lb_TempKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  str: string;
begin
  if Key = VK_RETURN then
  begin
    lb_Temp.Visible := False;
    if lb_Temp.ItemIndex >= 0 then
    begin
      str := lb_Temp.Items.Strings[lb_Temp.ItemIndex];
      vEdt.Text := str;
    end;
    vEdt.SetFocus;
  end;
end;

procedure TFrm_WorkOrder_ZB.lb_TempMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  str: string;
  i: Integer;
begin
  lb_Temp.Visible := False;
  if lb_Temp.ItemIndex >= 0 then
  begin
    str := lb_Temp.Items.Strings[lb_Temp.ItemIndex];
    vEdt.Text := str;
  end;
  vEdt.SetFocus;
end;

procedure TFrm_WorkOrder_ZB.lb_TempMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  str: string;
  p: TPoint;
  frame, caption: integer;
begin
  TListBox(Sender).ItemIndex := TListBox(Sender).ItemAtPos(Point(X,   Y),   True);
  str := '';
  if TListBox(Sender).ItemIndex >= 0 then
  begin
    str := TListBox(Sender).Items.Strings[TListBox(Sender).ItemIndex];
    TListBox(Sender).Hint := str;
    if Length(str)*TListBox(Sender).Font.Size > TListBox(Sender).Width then
    begin
      TListBox(Sender).ShowHint := True;
      GetCursorPos(p);
      application.ActivateHint(point(p.x,p.y));
    end else
      TListBox(Sender).ShowHint := False;
  end;
end;

procedure TFrm_WorkOrder_ZB.stg_gxxxLinkClick(Sender: TObject; ACol,
  ARow: Integer);
var
  sSqlData: string;
  sGXBH, sGXMC, sLBGG, sCL, sDW, sBZ: string;
  sCategorySpec, sUnit: string;
  i: Integer;
  ADO_Rec: TADOQuery;
begin
  case ACol of
    c_ZB_CZ_XG:
      begin
        sGXBH := stg_gxxx.Cells[c_ZB_GXBH,ARow];
        sGXMC := stg_gxxx.Cells[c_ZB_GXMC,ARow];
        sLBGG := stg_gxxx.Cells[c_ZB_LBGG,ARow];
        sCL := stg_gxxx.Cells[c_ZB_CL,ARow];
        sDW := stg_gxxx.Cells[c_ZB_DW,ARow];
        sBZ := stg_gxxx.Cells[c_ZB_BZ,ARow];
        Frm_WorkOrder_ZB_GXTJ := TFrm_WorkOrder_ZB_GXTJ.Create(Self);
        //获取类别规格和单位列表
        with Frm_WorkOrder_ZB_GXTJ do begin
          vARow := ARow;
          sSqlData := 'Select F_sCategorySpec,F_sUnit from BI_WorkProcManage where F_sCode=''%s'' ';
          ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sGXBH],False);
          if Assigned(ADO_Rec) then begin
            cbb_lbgg.Clear;
            cbb_dw.Clear;
            while not ADO_Rec.Eof do
            begin
              sCategorySpec := ADO_Rec.FieldByName('F_sCategorySpec').AsString;
              sUnit := ADO_Rec.FieldByName('F_sUnit').AsString;
              if cbb_lbgg.Items.IndexOf(sCategorySpec) = -1 then
                cbb_lbgg.Items.Add(sCategorySpec);
              if cbb_dw.Items.IndexOf(sUnit) = -1 then
                cbb_dw.Items.Add(sUnit);
              ADO_Rec.Next;
            end;
            ADO_Rec.Free;
          end;

          edt_gxbh.Text := sGXBH;
          edt_gxmc.Text := sGXMC;
          if cbb_lbgg.Items.IndexOf(sLBGG) = -1 then
            cbb_lbgg.Items.Add(sLBGG);
          cbb_lbgg.ItemIndex := cbb_lbgg.Items.IndexOf(sLBGG);
          edt_cl.Text := stg_gxxx.Cells[c_ZB_CL,ARow];
          if cbb_dw.Items.IndexOf(sDW) = 0 then
            cbb_dw.Items.Add(sDW);
          cbb_dw.ItemIndex := cbb_dw.Items.IndexOf(sDW);
          btn_bz.Text:= stg_gxxx.Cells[c_ZB_BZ,ARow];
          ShowModal;
          Free;
        end;
        {for i := 0 to Length(aZBGX) -1 do begin
          if aZBGX[i].m_iID = StrToNum(sGXID) then
          begin
            stg_gxxx.Cells[c_ZB_GXBH,ARow] := aZBGX[i].m_sCode;
            stg_gxxx.Cells[c_ZB_GXMC,ARow] := aZBGX[i].m_sName;
            stg_gxxx.Cells[c_ZB_LBGG,ARow] := aZBGX[i].m_sCategorySpec;
            stg_gxxx.Cells[c_ZB_CL,ARow] := aZBGX[i].m_sOutput;
            stg_gxxx.Cells[c_ZB_DW,ARow] := aZBGX[i].m_sUnit;
            stg_gxxx.Cells[c_ZB_BZ,ARow] := aZBGX[i].m_sBZ;
            stg_gxxx.Cells[c_ZB_GXID,ARow] := IntToStr(aZBGX[i].m_iID);
            Break;
          end;
        end;  }
      end;
    c_ZB_CZ_SC:
      begin
        if Application.MessageBox(PChar('是否删除工序 "'+stg_gxxx.Cells[c_ZB_GXMC,ARow]+'" ?'),'提示',MB_YESNO +MB_ICONINFORMATION)= IDNO then Exit;
        try
          //删除表中工序数据(改为最后确认再删除)
          {for i := 0 to Length(aZBGX) - 1 do begin
            if aZBGX[i].m_iID = StrToNum(sGXID) then begin
              if aZBGX[i].m_iMkProcID > 0 then begin
                sSqlData := 'Delete DO_WorkOrderMkProcDet where F_iID=%s';
                DM_DataBase.ExecQuery(sSqlData,[sGXID],True);
                aZBGX[i].m_iID := -1;
                aZBGX[i].m_iMkProcID := -1;
                aZBGX[i].m_iGroupID := -1;
                Break;
              end;
            end;
          end;   }
          stg_gxxx.p_Delrow(ARow);
          p_MessageBoxDlg('删除成功!');
        except
          on E: Exception do
          begin
            Application.MessageBox(PChar('删除失败:'+E.message),'提示',MB_ICONINFORMATION);
          end;
        end;
      end;
  end;
end;

procedure TFrm_WorkOrder_ZB.edt_sbkEnter(Sender: TObject);
begin
  bEnter := True;
end;

procedure TFrm_WorkOrder_ZB.edt_sbkKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  MyReg: TRegistry;
  ItemList,str: string;
  i,n: Integer;
begin
  if not Assigned(vEdt) then
  begin
    vEdt := Ti_TxtFilter(Sender);
    Exit;
  end;
  if (vEdt.Name <> Ti_TxtFilter(Sender).Name) then
  begin
    vEdt := Ti_TxtFilter(Sender);
    lb_Temp.Hide;
    Exit;
  end;
  lb_Temp.Left := Ti_TxtFilter(Sender).Left;
  lb_Temp.Top := Ti_TxtFilter(Sender).Top+Ti_TxtFilter(Sender).Height;
  lb_Temp.Width := Ti_TxtFilter(Sender).Width;
  lb_Temp.Tag := c_LB_Tag_Normal;
  vEdt := Ti_TxtFilter(Sender);
  if Key = VK_DOWN then
  begin
    if lb_Temp.Visible then
    begin
      lb_Temp.SetFocus;
      lb_Temp.ItemIndex := 0;
      Exit;
    end;
  end;
  MyReg := TRegistry.Create;
  MyReg.RootKey := HKEY_LOCAL_MACHINE;
  MyReg.OpenKey(c_Reg_CookiePath + 'Frm_CL\',True);
  if MyReg.ValueExists(vEdt.Name) then
    ItemList := MyReg.ReadString(vEdt.Name);
  MyReg.CloseKey;
  MyReg.Free ;
  lb_Temp.Items.Clear;
  n := PosNum(ItemList,';');
  for i := 1 to n do
  begin
    str := PosCopy(ItemList,';',i);
    if (str <> '') and ((Ti_TxtFilter(Sender).Text = '') or (Pos(Ti_TxtFilter(Sender).Text,str) > 0)) then
    begin
      lb_Temp.Items.Add(str);
      if lb_Temp.Items.Count >= LB_LISTCONTCOUNT then
        Break;
    end;
  end;
  lb_Temp.Height := LB_HEIGHT - lb_Temp.ItemHeight*iif(lb_Temp.Count<LB_LISTCOUNT,LB_LISTCOUNT-lb_Temp.Count,0);
  if not lb_Temp.Visible then
    lb_Temp.Visible := True;
end;

procedure TFrm_WorkOrder_ZB.btn_okClick(Sender: TObject);
var
  i, j: integer;
  bCheck: Boolean;
begin
  if not IfCheck then Exit;
  p_AddArrZB;
  for i := 0 to Length(aZBGX) -1 do
  begin
    if aZBGX[i].m_iGroupID = vGroupID then
      aZBGX[i].m_iGroupID := -1;
  end;

  for i := 1 to stg_gxxx.RowCount -1 do
  begin
    bCheck := False;
    for j := 0 to  Length(aZBGX) -1 do
    begin
      if aZBGX[j].m_iGroupID = -1 then
      begin
        aZBGX[j].m_iGroupID := vGroupID;
        aZBGX[j].m_sCode := stg_gxxx.Cells[c_ZB_GXBH,i];
        aZBGX[j].m_sName := stg_gxxx.Cells[c_ZB_GXMC,i];
        aZBGX[j].m_sCategorySpec := stg_gxxx.Cells[c_ZB_LBGG,i];
        aZBGX[j].m_sOutput := stg_gxxx.Cells[c_ZB_CL,i];
        aZBGX[j].m_sUnit := stg_gxxx.Cells[c_ZB_DW,i];
        aZBGX[j].m_sBZ := stg_gxxx.Cells[c_ZB_BZ,i];
        bCheck := True;
        Break;
      end;
    end;
    if not bCheck then
    begin
      SetLength(aZBGX,Length(aZBGX)+1);
      aZBGX[Length(aZBGX)-1].m_iGroupID := vGroupID;
      aZBGX[Length(aZBGX)-1].m_sCode := stg_gxxx.Cells[c_ZB_GXBH,i];
      aZBGX[Length(aZBGX)-1].m_sName := stg_gxxx.Cells[c_ZB_GXMC,i];
      aZBGX[Length(aZBGX)-1].m_sCategorySpec := stg_gxxx.Cells[c_ZB_LBGG,i];
      aZBGX[Length(aZBGX)-1].m_sOutput := stg_gxxx.Cells[c_ZB_CL,i];
      aZBGX[Length(aZBGX)-1].m_sUnit := stg_gxxx.Cells[c_ZB_DW,i];
      aZBGX[Length(aZBGX)-1].m_sBZ := stg_gxxx.Cells[c_ZB_BZ,i];
    end;
  end;
end;

procedure TFrm_WorkOrder_ZB.FormShow(Sender: TObject);
var
  str: string;
begin
  if vActionType = c_WorkOrder_Select then
  begin
    btn_ok.Enabled := False;
    btn_Add.Enabled := False;
  end;

  str := cbb_sblb.Text;
  //CbbParamAdd(cbb_sblb,'晒版版别');
  CbbParamAdd(cbb_sbks,'成品开数');
  cbb_sblb.Text := str;
  GetData;
end;

procedure TFrm_WorkOrder_ZB.btn_AddClick(Sender: TObject);
begin
  Frm_WorkOrder_ZB_GXTJ := TFrm_WorkOrder_ZB_GXTJ.Create(Self);
  Frm_WorkOrder_ZB_GXTJ.vGroupID := vGroupID;
  Frm_WorkOrder_ZB_GXTJ.ShowModal;
  Frm_WorkOrder_ZB_GXTJ.Free;
end;

procedure TFrm_WorkOrder_ZB.p_AddArrZB;
var
  i, n: Integer;
begin
  n := -1;
  for i := 0 to Length(aZB) -1 do
  begin
    if aZB[i].m_iGroupID = vGroupID then
    begin
      //aZB[i].m_iGroupID := -1;
      n :=  i;
      Break;
    end;
  end;
  if n = -1 then
  begin
    for i := 0 to Length(aZB) -1 do
    begin
      if aZB[i].m_iGroupID = -1 then
      begin
        n := i;
        Break;
      end;
    end;
    if n = -1 then
    begin
      SetLength(aZB,Length(aZB)+1);
      n := Length(aZB) -1;
    end;
  end;
  aZB[n].m_sSBLB := cbb_sblb.Text;
  aZB[n].m_sSBKS := Trim(cbb_sbks.Text);
  aZB[n].m_iSBK := StrToNum(edt_sbk.Text);
  aZB[n].m_iGroupID := vGroupID;
end;

procedure TFrm_WorkOrder_ZB.edt_sbkMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  MyReg: TRegistry;
  ItemList,str: string;
  i,n: Integer;
begin
  if (bEnter)  then
  begin
    if not Assigned(vEdt) then
    begin
      vEdt := Ti_TxtFilter(Sender);
      Exit;
    end;
    if (vEdt.Name <> Ti_TxtFilter(Sender).Name) then
    begin
      vEdt := Ti_TxtFilter(Sender);
      lb_Temp.Hide;
      Exit;
    end;
    if ((not lb_Temp.Visible) or (vEdt.Name <> Ti_TxtFilter(Sender).Name))  then
    begin
      lb_Temp.Left := Ti_TxtFilter(Sender).Left;
      lb_Temp.Top := Ti_TxtFilter(Sender).Top+Ti_TxtFilter(Sender).Height;
      lb_Temp.Width := Ti_TxtFilter(Sender).Width;
      lb_Temp.Tag := c_LB_Tag_Normal;
      vEdt := Ti_TxtFilter(Sender);
      MyReg := TRegistry.Create;
      MyReg.RootKey := HKEY_LOCAL_MACHINE;
      MyReg.OpenKey(c_Reg_ZB_CookiePath,True);
      if MyReg.ValueExists(vEdt.Name) then
        ItemList := MyReg.ReadString(vEdt.Name);
      MyReg.CloseKey;
      MyReg.Free ;
      lb_Temp.Items.Clear;
      n := PosNum(ItemList,';');
      for i := 1 to n do
      begin
        str := PosCopy(ItemList,';',i);
        if (str <> '') and ((Ti_TxtFilter(Sender).Text = '') or (Pos(Ti_TxtFilter(Sender).Text,str) > 0))  then
        begin
          lb_Temp.Items.Add(str);
          if lb_Temp.Items.Count >= LB_LISTCONTCOUNT then
            Break;
        end;
      end;
      lb_Temp.Height := LB_HEIGHT - lb_Temp.ItemHeight*iif(lb_Temp.Count<LB_LISTCOUNT,LB_LISTCOUNT-lb_Temp.Count,0);
      if not lb_Temp.Visible then
        lb_Temp.Visible := True;
    end else
    if lb_Temp.Visible then
    begin
      lb_Temp.Visible := False;
    end;
  end;
end;

end.

