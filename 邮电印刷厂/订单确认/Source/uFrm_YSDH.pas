unit uFrm_YSDH;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, iGrid, ExtCtrls, 
  Buttons, iComboBox, ButtonEdit,
  DB, ADODB;

type
  TYS = record
    m_YS_1: Integer;
    m_YS_2: Integer;
  end;

  TFrm_YSDH = class(TForm)
    Panel2: TPanel;
    edt_bh: Ti_TxtFilter;
    edt_jt: Ti_TxtFilter;
    edt_sc: Ti_TxtFilter;
    edt_sbs: Ti_TxtFilter;
    edt_qt: Ti_TxtFilter;
    edt_sb: Ti_TxtFilter;
    edt_ys_1: Ti_TxtFilter;
    btn_ok: TButton;
    btn_close: TButton;
    Bevel1: TBevel;
    lb_Temp: TListBox;
    cbb_yzlx: TComboBox;
    Label2: TLabel;
    edt_bz: Ti_TxtFilter;
    Label24: TLabel;
    Label33: TLabel;
    Label35: TLabel;
    edt_sbk: Ti_TxtFilter;
    cbb_sblb: TComboBox;
    cbb_sbks: TComboBox;
    edt_ysyq: Ti_TxtFilter;
    edt_gjmc: Ti_TxtFilter;
    edt_ys_2: Ti_TxtFilter;
    btn_jt: TButton;
    procedure lb_TempMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure edt_bhExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edt_bhMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lb_TempMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edt_bhKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lb_TempKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lb_TempKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_sbsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edt_sbsExit(Sender: TObject);
    procedure edt_bhEnter(Sender: TObject);
    procedure Panel2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mmo_bzMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edt_sbsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbb_yzlxEnter(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure edt_ys_1Exit(Sender: TObject);
    procedure edt_scExit(Sender: TObject);
    procedure EdtExit(Sender: TObject);
    procedure btn_jtClick(Sender: TObject);
  private
    { Private declarations }
    bEnter: Boolean;
    vEdtName: string;
    vEdt: Ti_TxtFilter;
    procedure edtMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    function FindEdt: Ti_TxtFilter;
    procedure SetEdtFocus;
    function IfCheck: Boolean;
    function GetData: Boolean;
    function GetYS: TYS;    //获取轮转印数
    function f_AddJTCL: Boolean;  //添加机台所需的材料
  public
    { Public declarations }
    vActionType: Integer;
    vGroupID: Integer;
  end;

var
  Frm_YSDH: TFrm_YSDH;

implementation

uses
  uDM_DataBase, Registry, PubStr, uPub_Type, uPub_Func, uWorkOrder, uPub_Text,
  uFrm_Select_JT;

{$R *.dfm}

procedure TFrm_YSDH.lb_TempMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
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

procedure TFrm_YSDH.edt_bhExit(Sender: TObject);
begin
  bEnter := False;
  if (vEdt=nil) or (Ti_TxtFilter(Sender).Name <> vEdt.Name) then
    lb_Temp.Visible := False;
end;

procedure TFrm_YSDH.FormShow(Sender: TObject);
begin
  if vActionType = c_WorkOrder_Select then
  begin
    btn_ok.Enabled := False;
  end;
  TForm(edt_bh).OnMouseWheel := edtMouseWheel;
  TForm(edt_jt).OnMouseWheel := edtMouseWheel;
  GetData;
end;

procedure TFrm_YSDH.edtMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
//  ShowMessage(IntToStr(WheelDelta));
  if WheelDelta >= 0 then
    lb_Temp.Perform(WM_VSCROLL,SB_LINEUP,WheelDelta)
  else if WheelDelta < 0 then
    lb_Temp.Perform(WM_VSCROLL,SB_LINEDOWN,WheelDelta)
end;

procedure TFrm_YSDH.edt_bhMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  sBH, sJT: string;
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
      sSqlData := 'select * from BI_MachineToolInfo where F_sJTBH like ''%%%s%%'' and F_sJTMC like ''%%%s%%'' order by F_sJTBH ';
      sBH := '';  sJT := '';
      if vEdt.Name = 'edt_bh' then
      begin
        sBH := Trim(Ti_TxtFilter(Sender).Text);
        if sBH = '' then edt_jt.Text := '';
      end else
      if  vEdt.Name = 'edt_jt' then
      begin
        sJT := Trim(Ti_TxtFilter(Sender).Text);
        if sJT = '' then edt_bh.Text := '';
      end;
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sBH,sJT]);
      lb_Temp.Items.Clear;
      while not ADO_Rec.Eof do
      begin
        if vEdt.Name = 'edt_bh' then
        begin
          lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sJTBH').AsString+'  '+ADO_Rec.FieldByName('F_sJTMC').AsString);
        end else
        if  vEdt.Name = 'edt_jt' then
        begin
          lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sJTMC').AsString+'  '+ADO_Rec.FieldByName('F_sJTBH').AsString);
        end;
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

procedure TFrm_YSDH.lb_TempMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  str: string;
  i: Integer;
begin
  lb_Temp.Visible := False;
  if lb_Temp.ItemIndex >= 0 then
  begin
    str := lb_Temp.Items.Strings[lb_Temp.ItemIndex];
    case lb_Temp.Tag of
      c_LB_Tag_Many:
        begin
          if vEdt.Name = 'edt_bh' then
          begin
            edt_bh.Text := Copy(str,1,Pos('  ',str)-1) ;
            if edt_bh.Text = '' then
              edt_bh.Text := str
            else
              edt_jt.Text := Copy(str,Pos('  ',str)+2,Length(str)) ;
          end else
          if vEdt.Name = 'edt_jt' then
          begin
            edt_jt.Text := Copy(str,1,Pos('  ',str)-1) ;
            if edt_jt.Text = '' then
              edt_jt.Text := str
            else
              edt_bh.Text := Copy(str,Pos('  ',str)+2,Length(str)) ;
          end;
        end;
    else
      vEdt.Text := str;
    end;
  end;
  SetEdtFocus;

end;

procedure TFrm_YSDH.edt_bhKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  sBH, sJT: string;
begin
  if not Assigned(vEdt) then
  begin
    vEdt := Ti_TxtFilter(Sender);
    Exit;
  end;
  if (Key = VK_RETURN) and (vEdt.Name = 'edt_bh') then
  begin
    btn_jt.Click;
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
  sBH := '';  sJT := '';
  if vEdt.Name = 'edt_bh' then
  begin
    sBH := Trim(Ti_TxtFilter(Sender).Text);
    if sBH = '' then edt_jt.Text := '';
  end else
  if  vEdt.Name = 'edt_jt' then
  begin
    sJT := Trim(Ti_TxtFilter(Sender).Text);
    if sJT = '' then edt_bh.Text := '';
  end;
  sSqlData := 'select * from BI_MachineToolInfo where F_sJTBH like ''%%%s%%'' and F_sJTMC like ''%%%s%%'' order by F_sJTBH ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sBH,sJT]);
  lb_Temp.Items.Clear;
  if (ADO_Rec.RecordCount = 0) and (vEdt.Name = 'edt_jt') then
    edt_bh.Text := '';
  while not ADO_Rec.Eof do
  begin
    if vEdt.Name = 'edt_bh' then
    begin
      lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sJTBH').AsString+'  '+ADO_Rec.FieldByName('F_sJTMC').AsString);
    end else
    if  vEdt.Name = 'edt_jt' then
    begin
      lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sJTMC').AsString+'  '+ADO_Rec.FieldByName('F_sJTBH').AsString);
    end;
    //lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sJTBH').AsString+'  '+ADO_Rec.FieldByName('F_sJTMC').AsString);
    ADO_Rec.Next;
  end;
  ADO_Rec.Free;
  lb_Temp.Height := LB_HEIGHT - lb_Temp.ItemHeight*iif(lb_Temp.Count<LB_LISTCOUNT,LB_LISTCOUNT-lb_Temp.Count,0);
  lb_Temp.Visible := True;
end;

procedure TFrm_YSDH.lb_TempKeyUp(Sender: TObject; var Key: Word;
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
      if (vEdt.Name = 'edt_bh') or (vEdt.Name = 'edt_jt') then
      begin
        if vEdt.Name = 'edt_bh' then
        begin
          edt_bh.Text := Copy(str,1,Pos('  ',str)-1) ;
          if edt_bh.Text = '' then
            edt_bh.Text := str
          else
            edt_jt.Text := Copy(str,Pos('  ',str)+2,Length(str)) ;
        end else
        if vEdt.Name = 'edt_jt' then
        begin
          edt_jt.Text := Copy(str,1,Pos('  ',str)-1) ;
          if edt_jt.Text = '' then
            edt_jt.Text := str
          else
            edt_bh.Text := Copy(str,Pos('  ',str)+2,Length(str)) ;
        end;
      end else
        vEdt.Text := str;
    end;
    SetEdtFocus;
  end;
end;

procedure TFrm_YSDH.SetEdtFocus;
begin
  vEdt.SetFocus;
//  FindEdt.SetFocus;
end;

procedure TFrm_YSDH.lb_TempKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (TListBox(Sender).ItemIndex<1) and (Key = VK_UP) then
  begin
    TListBox(Sender).ItemIndex := -1;
    TListBox(Sender).Selected[0] := False;
    SetEdtFocus;
  end;
end;

procedure TFrm_YSDH.edt_sbsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  MyReg: TRegistry;
  ItemList,str: string;
  i,n: Integer;
  edt: TEdit;
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
      MyReg.OpenKey(c_Reg_YSDH_CookiePath,True);
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

procedure TFrm_YSDH.edt_sbsExit(Sender: TObject);
var
  YS: TYS;
begin
  EdtExit(Sender);
  YS := GetYS;
  if (YS.m_YS_1 > 0) and (YS.m_YS_2 > 0) then
  begin
    edt_ys_1.Text := IntToStr(YS.m_YS_1);
    edt_ys_2.Text := IntToStr(YS.m_YS_2);
  end;
end;

procedure TFrm_YSDH.EdtExit(Sender: TObject);
var
  MyReg: TRegistry;
  i,n: integer;
  ItemList,str: string;
  edt: TEdit;
  List: TStringList;
begin
  bEnter := False;
  if (vEdt=nil) or (Ti_TxtFilter(Sender).Name <> vEdt.Name) then
    lb_Temp.Visible := False;
  edt := TEdit(Sender);
  MyReg := TRegistry.Create;
  MyReg.RootKey := HKEY_LOCAL_MACHINE;
  MyReg.OpenKey(c_Reg_YSDH_CookiePath,True);
  if MyReg.ValueExists(edt.Name) then
    ItemList := MyReg.ReadString(edt.Name);
  List := TStringList.Create;
  n := PosNum(ItemList,';');
  for i := 1 to n do
  begin
    str := PosCopy(ItemList,';',i);
    if str <> '' then
      List.Add(str)
  end;
  n := List.IndexOf(edt.Text);
  if n >= 0 then
    List.Delete(n);
  List.Insert(0,edt.Text);
  ItemList := '';
  for i := 0 to 99 do
  begin
    if i < List.Count then
      ItemList := ItemList + List.Strings[i] + ';';
  end;
  MyReg.WriteString(edt.Name, ItemList);
  MyReg.CloseKey;
  MyReg.Free
end;

function TFrm_YSDH.FindEdt: Ti_TxtFilter;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to Self.ComponentCount -1 do
  begin
    if Self.Components[i].Name = vEdtName then
    begin
      Result := Ti_TxtFilter(Self.Components[i]);
      Break;
    end;
  end;
end;

procedure TFrm_YSDH.edt_bhEnter(Sender: TObject);
begin
  bEnter := True;
end;

procedure TFrm_YSDH.Panel2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  lb_Temp.Hide;
end;

procedure TFrm_YSDH.mmo_bzMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  lb_Temp.Hide;
end;

procedure TFrm_YSDH.edt_sbsKeyUp(Sender: TObject; var Key: Word;
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
  MyReg.OpenKey(c_Reg_YSDH_CookiePath,True);
  if MyReg.ValueExists(vEdt.Name) then
    ItemList := MyReg.ReadString(vEdt.Name);
  MyReg.CloseKey;
  MyReg.Free ;
  lb_Temp.Items.Clear;
  n := PosNum(ItemList,';');
  for i := 1 to n do
  begin
    str := PosCopy(ItemList,';',i);
    if (str <> '') and ((Ti_TxtFilter(Sender).Text = '') or (Pos(UpperCase(Ti_TxtFilter(Sender).Text),UpperCase(str)) > 0)) then
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

procedure TFrm_YSDH.cbb_yzlxEnter(Sender: TObject);
begin
  lb_Temp.Hide;
end;

procedure TFrm_YSDH.btn_okClick(Sender: TObject);
var
  i, n: Integer;
begin
  if not IfCheck then Exit;
  n := -1;
  for i := 0 to Length(aYSDH) -1 do
  begin
    if aYSDH[i].m_iGroupID = vGroupID then
    begin
     // aYSDH[i].m_iGroupID := -1;
      n := i;
      Break;
    end;
  end;
  if n = -1 then
  begin
    for i := 0 to Length(aYSDH) -1 do
    begin
      if aYSDH[i].m_iGroupID = -1 then
      begin
        n := i;
        Break;
      end;
    end;
    if n = -1 then
    begin
      SetLength(aYSDH,Length(aYSDH)+1);
      n := Length(aYSDH) -1;
      aYSDH[n].m_iBSTID := -1;
    end;
  end;
  aYSDH[n].m_sGJMC := edt_gjmc.Text;
  aYSDH[n].m_sJTBH := edt_bh.Text;
  aYSDH[n].m_sJTMC := edt_jt.Text;
  aYSDH[n].m_iSBS := StrToNum(edt_sbs.Text);
  aYSDH[n].m_iYS := StrToNum(edt_ys_1.Text)+StrToNum(edt_ys_2.Text);
  aYSDH[n].m_iYS_1 := StrToNum(edt_ys_1.Text);
  aYSDH[n].m_iYS_2 := StrToNum(edt_ys_2.Text);
  aYSDH[n].m_sSB := edt_sb.Text;
  aYSDH[n].m_sSC := edt_sc.Text;
  aYSDH[n].m_sYZLX := cbb_yzlx.Text;
  aYSDH[n].m_sQT := edt_qt.Text;
  aYSDH[n].m_sYQGX := cbb_sblb.Text;
  aYSDH[n].m_sYQGXSL := edt_sbk.Text;
  aYSDH[n].m_sYQGXDW := cbb_sbks.Text;
  aYSDH[n].m_sYSYQ := edt_ysyq.Text;
  aYSDH[n].m_sBZ := edt_bz.Text;
  aYSDH[n].m_iGroupID := vGroupID;
  f_AddJTCL;
end;

function TFrm_YSDH.IfCheck: Boolean;
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  sJTBH: string;
begin
  Result := False;
  sJTBH := Trim(edt_bh.Text);
  if sJTBH <> '' then
  begin
    sSqlData := 'select * from BI_MachineToolInfo where F_sJTBH = ''s'' ';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sJTBH],False);
    if (ADO_Rec = nil) and (ADO_Rec.RecordCount = 0) then
    begin
      p_MessageBoxDlg('此编号不存在,如果想继续录入请不要输入编号!');
      edt_bh.Text := '';
      ADO_Rec.Free;
      Exit;
    end;
  end;    
  Result := True;
end;

function TFrm_YSDH.GetData: Boolean;
var
  i, n: Integer;
  sTJ,sZJ: string;
begin
  Result := False;
  n := -1;
  for i := 0 to Length(aYSDH) -1 do
  begin
    if aYSDH[i].m_iGroupID = vGroupID then
    begin
      n := i;
      Break;
    end;
  end;
  if n = -1 then
  begin
    if Frm_WorkOrder.ADO_WorkOrder.RecNo = 1 then
    begin
      sTJ := Trim(Frm_WorkOrder.edt_Tj.Text);
      sZJ := Trim(Frm_WorkOrder.edt_Zj.Text);
      if (sTJ <> '' ) and (sZJ <> '') then
      begin
        edt_ysyq.Text :=  Format('版面要求(头距：%s cm 左距：%s cm)',[sTJ,sZJ]);
      end;
    end;      
    Exit;
  end;
  if not ((aYSDH[n].m_sJTBH = '') and (aYSDH[n].m_sJTBH = '') and (aYSDH[n].m_sSB = '')
    and (aYSDH[n].m_sSC = '') and (aYSDH[n].m_iSBS = 0) and (aYSDH[n].m_iYS = 0)
    and (aYSDH[n].m_iYS_1 = 0) and (aYSDH[n].m_iYS_2 = 0) and (aYSDH[n].m_sYZLX = '')) then
  begin
    edt_gjmc.Text := aYSDH[n].m_sGJMC;
    edt_bh.Text := aYSDH[n].m_sJTBH;
    edt_jt.Text := aYSDH[n].m_sJTMC;
    edt_sbs.Text := IntToStr(aYSDH[n].m_iSBS);
    //edt_ys.Text := IntToStr(aYSDH[n].m_iYS);
    edt_ys_1.Text := IntToStr(aYSDH[n].m_iYS_1);
    edt_ys_2.Text := IntToStr(aYSDH[n].m_iYS_2);
    edt_sb.Text := aYSDH[n].m_sSB;
    edt_sc.Text := aYSDH[n].m_sSC;
    cbb_yzlx.Text := aYSDH[n].m_sYZLX;
    edt_qt.Text := aYSDH[n].m_sQT;
    cbb_sblb.Text := aYSDH[n].m_sYQGX;
    edt_sbk.Text := aYSDH[n].m_sYQGXSL;
    cbb_sbks.Text := aYSDH[n].m_sYQGXDW;
    edt_ysyq.Text := aYSDH[n].m_sYSYQ;
    edt_bz.Text := aYSDH[n].m_sBZ;
    Result := True;
  end;
end;

procedure TFrm_YSDH.edt_ys_1Exit(Sender: TObject);
begin
  if (Pos('.',Ti_TxtFilter(Sender).Text)>0) or ((Ti_TxtFilter(Sender).Text <> '') and (not IsNum(Ti_TxtFilter(Sender).Text))) then
  begin
    p_MessageBoxDlg('字符无效,请输入数字(不含小数)!');
    Ti_TxtFilter(Sender).SetFocus;
    Exit;
  end;
  EdtExit(Sender);
end;

function TFrm_YSDH.GetYS: TYS;
var
  i, iSBS, iSC, iZL, iCPKS, iBSTZS, iYS_1, iYS_2, iBSTYS: integer;
  sSC, sCPKS: string;
begin
  Result.m_YS_1 := 0;
  Result.m_YS_2 := 0;
  iYS_1 := StrToNum(edt_ys_1.Text);
  iYS_2 := StrToNum(edt_ys_2.Text);
  if iYS_1 > 0 then Exit;
  iSBS := StrToNum(edt_sbs.Text);
  sSC := Trim(edt_sc.Text);
  if (iSBS = 0) and (sSC = '') then Exit;
  iSC := 0;
  if StrToNum(PosCopy(sSC,'/',1)) > 0 then
    Inc(iSC);
  if StrToNum(PosCopy(sSC,'/',2)) > 0 then
    Inc(iSC);
  sCPKS := Trim(Frm_WorkOrder.cbb_cpks.Text);
  if sCPKS = '对' then
    iCPKS := 2
  else
    iCPKS := StrToNum(sCPKS);
  iBSTYS := Frm_WorkOrder.ADO_WorkOrder.FieldByName('BSTYS').AsInteger;
  if (iBSTYS > 0) and (iSC > 0) then
  begin
    //Result := iBSTYS * iSC;                 //印数=每版成品数*(iif(4/4,2,1))
    Result.m_YS_1 := iBSTYS;                 //印数=每版成品数*(iif(4/4,2,1))
    if iSC > 1 then
      Result.m_YS_2 := iBSTYS;                 //印数=每版成品数*(iif(4/4,2,1))
    exit;
  end;

  iBSTZS := Frm_WorkOrder.ADO_WorkOrder.FieldByName('BSTZS').AsInteger;
  //iZL := StrToNum(Frm_WorkOrder.edt_zl.Text);
  iZL := 0;
  for i := 0 to Length(OrderData) -1 do
  begin
    if OrderData[i].m_iGroupID = Frm_WorkOrder.ADO_WorkOrder.RecNo then
      iZL := iZL + OrderData[i].m_iBCYL;
  end;
  if (iZL > 0) and (iSBS > 0) and (iSC > 0)  then
  begin
    if iBSTZS > 0 then
    begin
      //Result := iZL div iBSTZS * iSC                 //印数=总量/版式图个数*(iif(4/4,2,1))
      Result.m_YS_1 := iZL div iBSTZS;                      //印数=总量/版式图个数
      if iSC > 1 then
        Result.m_YS_2 := iZL div iBSTZS;                          //印数=总量/版式图个数
    end else
    if (iCPKS > 0) and (iCPKS div iSBS > 0) then
    begin
      //Result := iZL div (iCPKS div iSBS) * iSC;           //印数=总量/(产品开数/上机开本)*(iif(4/4,2,1))
      Result.m_YS_1 := iZL div (iCPKS div iSBS);
      if iSC > 1 then
        Result.m_YS_2 := iZL div (iCPKS div iSBS);
    end;
  end;
end;

procedure TFrm_YSDH.edt_scExit(Sender: TObject);
var
  YS: TYS;
begin
  EdtExit(Sender);
  if (edt_sc.Text<>'') and (PosNum(edt_sc.Text,'/') =0) then
  begin
    p_MessageBoxDlg('色次输入格式不对,请按 "x/x" 格式输入!');
    edt_sc.Text := '0/0';
    Exit;
  end;
  if edt_sc.Text='' then
  begin
    edt_sc.Text := '0/0';
  end;
  YS := GetYS;
  if (YS.m_YS_1 >= 0) and (YS.m_YS_2 >= 0) then
  begin
    edt_ys_1.Text := IntToStr(YS.m_YS_1);
    edt_ys_2.Text := IntToStr(YS.m_YS_2);
  end;
end;

function TFrm_YSDH.f_AddJTCL: Boolean;
var
  i, j, n, iSL: Integer;
  sSqlData, sJTBH, sJTCLBH, sJTCLMC, sJTCLGG, sJTCJGG, sJTCLDW, sSL, str: string;
  ADO_Rec: TADOQuery;
begin
  Result := False;
  sJTBH := '';
  for i := 0 to Length(aYSDH) -1 do
  begin
    if aYSDH[i].m_iGroupID = vGroupID then
    begin
      sJTBH := aYSDH[i].m_sJTBH;
      iSL := 0;
      str := aYSDH[i].m_sSC;
      for j := 1 to PosNum(str,'/')+1 do
        iSL := iSL + StrToNum(PosCopy(str,'/',j));
      Break;
    end;
  end;
  if sJTBH = '' then Exit;
  sSqlData := 'Select * from BI_MachineToolInfo where F_sJTBH = ''%s'' ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sJTBH],False);
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    sJTCLBH := Trim(ADO_Rec.FieldByName('F_sJTCLBH').AsString);
    sJTCLMC := Trim(ADO_Rec.FieldByName('F_sJTCLMC').AsString);
    sJTCLGG := Trim(ADO_Rec.FieldByName('F_sJTCLGG').AsString);
    //sJTCJGG := Trim(ADO_Rec.FieldByName('F_sJTCJGG').AsString);
    sJTCLDW := Trim(ADO_Rec.FieldByName('F_sJTCLDW').AsString);
    if sJTCLMC = '' then Exit;
    n := -1;
    for i := 0 to Length(aCL) -1 do
    begin
      if (aCL[i].m_iGroupID = vGroupID) and (aCL[i].m_iFlag = c_CL_Flag_Auto) then
      begin
        //aCL[i].m_iGroupID := -1;
        n := i;
        Break;
      end;
    end;
    if n = -1 then
    begin
      for i := 0 to Length(aCL) -1 do
      begin
        if aCL[i].m_iGroupID = -1 then
        begin
          n := i;
          Break;
        end;
      end;
      if n = -1 then
      begin
        SetLength(aCL,Length(aCL)+1);
        n := Length(aCL) -1;
      end;
    end;
    if cbb_yzlx.ItemIndex = 2 then
    begin
      iSL := iSL div 2;
      if iSL mod 2 > 0 then
       iSL := iSL + 1;
    end;
    aCL[n].m_sCLBH    := sJTCLBH;
    aCL[n].m_sCLMC    := sJTCLMC;
    aCL[n].m_sCLGG    := sJTCLGG;
    aCL[n].m_sCJGG    := '';
    aCL[n].m_iJFQS    := 0;
    aCL[n].m_iJFS     := 0;
    aCL[n].m_sSL      := IntToStr(iSL);
    aCL[n].m_sDW      := sJTCLDW;
    aCL[n].m_iFlag    := c_CL_Flag_Auto;
    aCL[n].m_iGroupID := vGroupID;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

end;

procedure TFrm_YSDH.btn_jtClick(Sender: TObject);
begin
  Frm_Select_JT := TFrm_Select_JT.Create(Self);
  Frm_Select_JT.cbb_type.Text := '机台编号';
  Frm_Select_JT.edt_value.Text := edt_bh.Text;
  Frm_Select_JT.ShowModal;
  if Frm_Select_JT.vSuccess then
  begin
    edt_bh.Text := Frm_Select_JT.vJTBH;
    edt_jt.Text := Frm_Select_JT.vJTMC;
  end;
  Frm_Select_JT.Free;

end;

end.


