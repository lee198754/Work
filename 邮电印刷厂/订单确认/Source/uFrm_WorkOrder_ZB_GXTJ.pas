unit uFrm_WorkOrder_ZB_GXTJ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ButtonEdit, RzButton, ADODB;

type
  TFrm_WorkOrder_ZB_GXTJ = class(TForm)
    btn_ok: TRzButton;
    btn_close: TRzButton;
    Label1: TLabel;
    edt_gxbh: Ti_TxtFilter;
    edt_gxmc: Ti_TxtFilter;
    edt_cl: Ti_TxtFilter;
    cbb_dw: TComboBox;
    btn_bz: Ti_TxtFilter;
    lb_Temp: TListBox;
    cbb_lbgg: TComboBox;
    Label2: TLabel;
    btn_zbgx: TButton;
    procedure lb_TempKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lb_TempKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lb_TempMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lb_TempMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure edt_gxbhMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edt_gxbhKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_gxbhEnter(Sender: TObject);
    procedure edt_gxbhExit(Sender: TObject);
    procedure edt_clEnter(Sender: TObject);
    procedure edt_clExit(Sender: TObject);
    procedure edt_clKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_clMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_okClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_bzExit(Sender: TObject);
    procedure btn_zbgxClick(Sender: TObject);
  private
    { Private declarations }
    bEnter: Boolean;
    vEdt: Ti_TxtFilter;
    function IsCheck: Boolean;
    procedure EdtExit(Sender: TObject);
    function GetData: Boolean;
  public
    { Public declarations }
    vGroupID: Integer;
    vARow: integer;
  end;

var
  Frm_WorkOrder_ZB_GXTJ: TFrm_WorkOrder_ZB_GXTJ;

implementation

{$R *.dfm}

uses
  uPub_Func, uDM_DataBase, uPub_Text, PubStr, uPub_Type,
  Registry, uFrm_WorkOrder_ZB, uFrm_Select_ZBGX;

procedure TFrm_WorkOrder_ZB_GXTJ.EdtExit(Sender: TObject);
begin
  bEnter := False;
  if (vEdt=nil) or (Ti_TxtFilter(Sender).Name <> vEdt.Name) then
    lb_Temp.Visible := False;
  edtCookie(Sender,c_Reg_GXTJ_CookiePath)
end;

function TFrm_WorkOrder_ZB_GXTJ.GetData: Boolean;
var
  i: integer;
begin
  Result := False;

  Result := True;

end;

function TFrm_WorkOrder_ZB_GXTJ.IsCheck: Boolean;
begin
  Result := False;

  Result := True;
end;

procedure TFrm_WorkOrder_ZB_GXTJ.lb_TempKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (TListBox(Sender).ItemIndex<1) and (Key = VK_UP) then
  begin
    TListBox(Sender).ItemIndex := -1;
    TListBox(Sender).Selected[0] := False;
    vEdt.SetFocus;
  end;
end;

procedure TFrm_WorkOrder_ZB_GXTJ.lb_TempKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  str, sSqlData, sCategorySpec, sUnit: string;
  ADO_Rec: TADOQuery;
  n: Integer;
begin
  if Key = VK_RETURN then
  begin
    lb_Temp.Visible := False;
    if lb_Temp.ItemIndex >= 0 then
    begin
      str := lb_Temp.Items.Strings[lb_Temp.ItemIndex];
      n := lb_Temp.ItemIndex;
      case lb_Temp.Tag of
        c_LB_Tag_Many:
          begin
            sSqlData := 'Select F_sCategorySpec,F_sUnit from BI_WorkProcManage where F_sCode=''%s'' ';
            ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[WorkProcInfo[n].m_sGXBH],False);
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
            edt_gxbh.Text :=  WorkProcInfo[n].m_sGXBH;
            edt_gxmc.Text :=  WorkProcInfo[n].m_sGXMC;
            cbb_lbgg.Text :=  WorkProcInfo[n].m_sLBGG;
            edt_cl.Text   :=  WorkProcInfo[n].m_sCL;
            cbb_dw.Text   :=  WorkProcInfo[n].m_sDW;
          end;
      else
        vEdt.Text := str;
      end;
    end;
    vEdt.SetFocus;
  end;
end;

procedure TFrm_WorkOrder_ZB_GXTJ.lb_TempMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  str,sSqlData: string;
  sCategorySpec, sUnit: string;
  i, n: Integer;
  ADO_Rec: TADOQuery;
begin
  lb_Temp.Visible := False;
  if lb_Temp.ItemIndex >= 0 then
  begin
    str := lb_Temp.Items.Strings[lb_Temp.ItemIndex];
    n := lb_Temp.ItemIndex;
    case lb_Temp.Tag of
      c_LB_Tag_Many:
        begin
          sSqlData := 'Select F_sCategorySpec,F_sUnit from BI_WorkProcManage where F_sCode=''%s'' ';
          ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[WorkProcInfo[n].m_sGXBH],False);
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
          edt_gxbh.Text :=  WorkProcInfo[n].m_sGXBH;
          edt_gxmc.Text :=  WorkProcInfo[n].m_sGXMC;
          cbb_lbgg.Text :=  WorkProcInfo[n].m_sLBGG;
          edt_cl.Text   :=  WorkProcInfo[n].m_sCL;
          cbb_dw.Text   :=  WorkProcInfo[n].m_sDW;
        end;
    else
      vEdt.Text := str;
    end;
  end;
  vEdt.SetFocus;

end;

procedure TFrm_WorkOrder_ZB_GXTJ.lb_TempMouseMove(Sender: TObject;
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

procedure TFrm_WorkOrder_ZB_GXTJ.edt_gxbhMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  sGXBH, sGXMC: string;
  n: integer;
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
      //lb_Temp.Hint := Ti_TxtFilter(Sender).Name;
      lb_Temp.Tag := c_LB_Tag_Many;
      vEdt := Ti_TxtFilter(Sender);
      //获取Item列表
      sGXBH := '';  sGXMC := '';
      if vEdt.Name = 'edt_gxbh' then
      begin
        sGXBH := Trim(Ti_TxtFilter(Sender).Text);
        if sGXBH = '' then edt_gxmc.Text := '';
      end else
      if  vEdt.Name = 'edt_gxmc' then
      begin
        sGXMC := Trim(Ti_TxtFilter(Sender).Text);
        if sGXMC = '' then edt_gxbh.Text := '';
      end;
      sSqlData := 'select * from BI_WorkProcManage where F_sCode like ''%%%s%%'' and F_sName like ''%%%s%%'' order by F_sCode ';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sGXBH,sGXMC]);
      lb_Temp.Items.Clear;
      n := 0;
      SetLength(WorkProcInfo,n);
      while not ADO_Rec.Eof do
      begin
        if vEdt.Name = 'edt_gxbh' then
        begin
          if lb_Temp.Items.IndexOf(ADO_Rec.FieldByName('F_sCode').AsString+'  '+ADO_Rec.FieldByName('F_sName').AsString) = -1 then
          begin
            lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sCode').AsString+'  '+ADO_Rec.FieldByName('F_sName').AsString);
          end else
          begin
            ADO_Rec.Next;
            Continue;
          end;
        end else
        if  vEdt.Name = 'edt_gxmc' then
        begin
          if lb_Temp.Items.IndexOf(ADO_Rec.FieldByName('F_sName').AsString+'  '+ADO_Rec.FieldByName('F_sCode').AsString) = -1 then
          begin
            lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sName').AsString+'  '+ADO_Rec.FieldByName('F_sCode').AsString);
          end else
          begin
            ADO_Rec.Next;
            Continue;
          end;
        end;
        SetLength(WorkProcInfo,n+1);
        WorkProcInfo[n].m_iID := n;
        WorkProcInfo[n].m_sGXBH := ADO_Rec.FieldByName('F_sCode').AsString;
        WorkProcInfo[n].m_sGXMC := ADO_Rec.FieldByName('F_sName').AsString;
        WorkProcInfo[n].m_sLBGG := ADO_Rec.FieldByName('F_sCategorySpec').AsString;
        WorkProcInfo[n].m_sCL := ADO_Rec.FieldByName('F_sOutput').AsString;
        WorkProcInfo[n].m_sDW := ADO_Rec.FieldByName('F_sUnit').AsString;
        inc(n);
        ADO_Rec.Next;
      end;
      ADO_Rec.Free;
      lb_Temp.Height := LB_HEIGHT - lb_Temp.ItemHeight*iif(lb_Temp.Count<LB_LISTCOUNT,LB_LISTCOUNT-lb_Temp.Count,0);
      lb_Temp.Visible := True;
    end else
    if lb_Temp.Visible then
    begin
      lb_Temp.Visible := False;
    end;
  end;
end;

procedure TFrm_WorkOrder_ZB_GXTJ.edt_gxbhKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  sGXBH, sGXMC: string;
  n: Integer;
begin
  if not Assigned(vEdt) then
  begin
    vEdt := Ti_TxtFilter(Sender);
    Exit;
  end;
  if (Key = VK_RETURN) and (vEdt.Name = 'edt_gxbh') then
  begin
    btn_zbgx.Click;
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
  lb_Temp.Tag := c_LB_Tag_Many;
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
  //获取Item列表
  sGXBH := '';  sGXMC := '';
  if vEdt.Name = 'edt_gxbh' then
  begin
    sGXBH := Trim(Ti_TxtFilter(Sender).Text);
    if sGXBH = '' then edt_gxmc.Text := '';
  end else
  if  vEdt.Name = 'edt_gxmc' then
  begin
    sGXMC := Trim(Ti_TxtFilter(Sender).Text);
    if sGXMC = '' then edt_gxbh.Text := '';
  end;
  sSqlData := 'select * from BI_WorkProcManage where F_sCode like ''%%%s%%'' and F_sName like ''%%%s%%'' order by F_sCode ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sGXBH,sGXMC]);
  lb_Temp.Items.Clear;
  if (ADO_Rec.RecordCount = 0) and (vEdt.Name = 'edt_gxmc') then
    edt_gxbh.Text := '';
  n := 0;
  SetLength(WorkProcInfo,n);
  while not ADO_Rec.Eof do
  begin
    if vEdt.Name = 'edt_gxbh' then
    begin
      if lb_Temp.Items.IndexOf(ADO_Rec.FieldByName('F_sCode').AsString+'  '+ADO_Rec.FieldByName('F_sName').AsString) = -1 then
      begin
        lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sCode').AsString+'  '+ADO_Rec.FieldByName('F_sName').AsString);
      end else
      begin
        ADO_Rec.Next;
        Continue;
      end;
    end else
    if  vEdt.Name = 'edt_gxmc' then
    begin
      if lb_Temp.Items.IndexOf(ADO_Rec.FieldByName('F_sName').AsString+'  '+ADO_Rec.FieldByName('F_sCode').AsString) = -1 then
      begin
        lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sName').AsString+'  '+ADO_Rec.FieldByName('F_sCode').AsString);
      end else
      begin
        ADO_Rec.Next;
        Continue;
      end;
    end;
    //lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sCode').AsString+'  '+ADO_Rec.FieldByName('F_sName').AsString);
    SetLength(WorkProcInfo,n+1);
    WorkProcInfo[n].m_iID := n;
    WorkProcInfo[n].m_sGXBH := ADO_Rec.FieldByName('F_sCode').AsString;
    WorkProcInfo[n].m_sGXMC := ADO_Rec.FieldByName('F_sName').AsString;
    WorkProcInfo[n].m_sLBGG := ADO_Rec.FieldByName('F_sCategorySpec').AsString;
    WorkProcInfo[n].m_sCL := ADO_Rec.FieldByName('F_sOutput').AsString;
    WorkProcInfo[n].m_sDW := ADO_Rec.FieldByName('F_sUnit').AsString;
    inc(n);
    ADO_Rec.Next;
  end;
  ADO_Rec.Free;
  lb_Temp.Height := LB_HEIGHT - lb_Temp.ItemHeight*iif(lb_Temp.Count<LB_LISTCOUNT,LB_LISTCOUNT-lb_Temp.Count,0);
  lb_Temp.Visible := True;
end;

procedure TFrm_WorkOrder_ZB_GXTJ.edt_gxbhEnter(Sender: TObject);
begin
  bEnter := True;
end;

procedure TFrm_WorkOrder_ZB_GXTJ.edt_gxbhExit(Sender: TObject);
begin
  bEnter := False;
  if (vEdt=nil) or (Ti_TxtFilter(Sender).Name <> vEdt.Name) then
    lb_Temp.Visible := False;
end;

procedure TFrm_WorkOrder_ZB_GXTJ.edt_clEnter(Sender: TObject);
begin
  bEnter := True;
end;

procedure TFrm_WorkOrder_ZB_GXTJ.edt_clExit(Sender: TObject);
begin
  if (Ti_TxtFilter(Sender).Text <> '') and (not IsNum(Ti_TxtFilter(Sender).Text)) then
  begin
    p_MessageBoxDlg('字符无效,请输入数字!');
    Ti_TxtFilter(Sender).SetFocus;
    Exit;
  end;
  if Ti_TxtFilter(Sender).Name = 'edt_cl' then
  begin
    try
      Ti_TxtFilter(Sender).Text := FormatFloat('0.00',StrToNum(Ti_TxtFilter(Sender).Text));
    except
      p_MessageBoxDlg('字符无效,请输入数字!');
      Ti_TxtFilter(Sender).SetFocus;
      Exit;
    end;
  end;
end;

procedure TFrm_WorkOrder_ZB_GXTJ.edt_clKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

procedure TFrm_WorkOrder_ZB_GXTJ.edt_clMouseDown(Sender: TObject;
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
      MyReg.OpenKey(c_Reg_GXTJ_CookiePath,True);
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

procedure TFrm_WorkOrder_ZB_GXTJ.btn_okClick(Sender: TObject);
var
  i, n: Integer;
begin
  if not IsCheck then Exit;
  with Frm_WorkOrder_ZB do begin
    if vARow = 0 then
    begin
      if  Trim(stg_gxxx.Cells[c_ZB_CZ_XG,stg_gxxx.RowCount-1]) <> '' then
        stg_gxxx.RowCount := stg_gxxx.RowCount+1;
      vARow := stg_gxxx.RowCount-1;
    end;
    stg_gxxx.Cells[c_ZB_GXBH,vARow] := edt_gxbh.Text;
    stg_gxxx.Cells[c_ZB_GXMC,vARow] := edt_gxmc.Text;
    stg_gxxx.Cells[c_ZB_LBGG,vARow] := cbb_lbgg.Text;
    stg_gxxx.Cells[c_ZB_CL,vARow]   := edt_cl.Text;
    stg_gxxx.Cells[c_ZB_DW,vARow]   := cbb_dw.Text;
    stg_gxxx.Cells[c_ZB_BZ,vARow]   := btn_bz.Text;
    stg_gxxx.Cells[c_ZB_CZ_XG,vARow] := '修改';
    stg_gxxx.CellsLink[c_ZB_CZ_XG,vARow] := '修改';
    stg_gxxx.Cells[c_ZB_CZ_SC,vARow] := '删除';
    stg_gxxx.CellsLink[c_ZB_CZ_SC,vARow] := '删除';
  end;

{  Exit;

  n := -1;
  for i := 0 to Length(aZBGX) -1 do
  begin
    if aZBGX[i].m_iID = vGXID then
    begin
      //aCL[i].m_iGroupID := -1;
      n := i;
      Break;
    end;
  end;
  if n = -1 then
  begin
    for i := 0 to Length(aZBGX) -1 do
    begin
      if aZBGX[i].m_iGroupID = -1 then
      begin
        n := i;
        Break;
      end;
    end;
    if n = -1 then
    begin
      SetLength(aZBGX,Length(aZBGX)+1);
      n := Length(aZBGX) -1;
    end;
  end;
  aZBGX[n].m_iID := n;
  aZBGX[n].m_sCode := edt_gxbh.Text;
  aZBGX[n].m_sName := edt_gxmc.Text;
  aZBGX[n].m_sCategorySpec := cbb_lbgg.Text;
  aZBGX[n].m_sOutput := edt_cl.Text;
  aZBGX[n].m_sUnit := cbb_dw.Text;
  aZBGX[n].m_sBZ := btn_bz.Text;
  aZBGX[n].m_iGroupID := vGroupID;    }
end;

procedure TFrm_WorkOrder_ZB_GXTJ.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lb_Temp.Hide;
end;

procedure TFrm_WorkOrder_ZB_GXTJ.btn_bzExit(Sender: TObject);
begin
  EdtExit(Sender);
end;

procedure TFrm_WorkOrder_ZB_GXTJ.btn_zbgxClick(Sender: TObject);
begin
  Frm_Select_ZBGX := TFrm_Select_ZBGX.Create(Self);
  Frm_Select_ZBGX.cbb_type.Text := '工序编号';
  Frm_Select_ZBGX.edt_value.Text := edt_gxbh.Text;
  Frm_Select_ZBGX.ShowModal;
  if Frm_Select_ZBGX.vSuccess then
  begin
    edt_gxbh.Text := Frm_Select_ZBGX.vGXBH;
    edt_gxmc.Text := Frm_Select_ZBGX.vGXMC;
    cbb_lbgg.Text := Frm_Select_ZBGX.vLBGG;
    edt_cl.Text   := Frm_Select_ZBGX.vCL;
    cbb_dw.Text   := Frm_Select_ZBGX.vDW;
  end;
  Frm_Select_ZBGX.Free;
end;

end.

