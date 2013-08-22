unit uFrm_ZB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ButtonEdit, ExtCtrls;

type
  TFrm_ZB = class(TForm)
    Panel2: TPanel;
    Bevel1: TBevel;
    edt_ts: Ti_TxtFilter;
    edt_gb: Ti_TxtFilter;
    edt_dy: Ti_TxtFilter;
    edt_jd: Ti_TxtFilter;
    edt_pb: Ti_TxtFilter;
    edt_cp: Ti_TxtFilter;
    btn_ok: TButton;
    btn_close: TButton;
    lb_Temp: TListBox;
    Label24: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    edt_sbk: Ti_TxtFilter;
    cbb_sblb: TComboBox;
    cbb_sbks: TComboBox;
    edt_qt: Ti_TxtFilter;
    procedure edt_jdEnter(Sender: TObject);
    procedure edt_jdExit(Sender: TObject);
    procedure edt_jdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_jdMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbb_sblbEnter(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lb_TempKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lb_TempKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lb_TempMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lb_TempMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel2Click(Sender: TObject);
  private
    { Private declarations }
    bEnter: Boolean;
    vEdt: Ti_TxtFilter;
    function IfCheck: Boolean;
    procedure EdtExit(Sender: TObject);
    function GetData: Boolean;
  public
    { Public declarations }
    vGroupID: Integer;
  end;

var
  Frm_ZB: TFrm_ZB;

implementation

uses
  uPub_Type, uPub_Func, PubStr, Registry, uWorkOrder, uPub_Text;

{$R *.dfm}

{ TForm1 }

procedure TFrm_ZB.EdtExit(Sender: TObject);
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
  MyReg.OpenKey(c_Reg_ZB_CookiePath,True);
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
  MyReg.Free;
end;

function TFrm_ZB.GetData: Boolean;
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
  edt_jd.Text := aZB[n].m_sJD;
  edt_gb.Text := aZB[n].m_sGB;
  edt_ts.Text := aZB[n].m_sTS;
  edt_dy.Text := aZB[n].m_sDY;
  edt_pb.Text := aZB[n].m_sPB;
  edt_cp.Text := aZB[n].m_sCP;
  cbb_sblb.Text := aZB[n].m_sSBLB;
  cbb_sbks.Text := aZB[n].m_sSBKS;
  edt_sbk.Text := IntToStr(aZB[n].m_iSBK);
  edt_qt.Text := aZB[n].m_sQT;

  Result := True;
end;

function TFrm_ZB.IfCheck: Boolean;
begin
  Result := False;

  Result := True;
end;

procedure TFrm_ZB.edt_jdEnter(Sender: TObject);
begin
  bEnter := True;
end;

procedure TFrm_ZB.edt_jdExit(Sender: TObject);
begin
  EdtExit(Sender);
end;

procedure TFrm_ZB.edt_jdKeyUp(Sender: TObject; var Key: Word;
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

procedure TFrm_ZB.edt_jdMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
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

procedure TFrm_ZB.cbb_sblbEnter(Sender: TObject);
begin
  lb_Temp.Hide;
end;

procedure TFrm_ZB.btn_okClick(Sender: TObject);
var
  i, n: Integer;
begin
  if not IfCheck then Exit;
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
  aZB[n].m_sTS := edt_ts.Text;
  aZB[n].m_sGB := edt_gb.Text;
  aZB[n].m_sJD := edt_jd.Text;
  aZB[n].m_sDY := edt_dy.Text;
  aZB[n].m_sPB := edt_pb.Text;
  aZB[n].m_sCP := edt_cp.Text;
  aZB[n].m_sSBLB := cbb_sblb.Text;
  aZB[n].m_sSBKS := Trim(cbb_sbks.Text);
  aZB[n].m_iSBK := StrToNum(edt_sbk.Text);
  aZB[n].m_sQT := edt_qt.Text;
//  aZB[n].m_sBZ := mmo_bz.Text;
  aZB[n].m_iGroupID := vGroupID;

end;     
         
procedure TFrm_ZB.FormShow(Sender: TObject);
var
  str: string;
begin
  if Frm_WorkOrder.vActionType = c_WorkOrder_Select then
  begin
    btn_ok.Enabled := False;
  end;

  str := cbb_sblb.Text;
  CbbParamAdd(cbb_sblb,'晒版版别');
  CbbParamAdd(cbb_sbks,'成品开数');
  cbb_sblb.Text := str;
  GetData;
end;

procedure TFrm_ZB.lb_TempKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (TListBox(Sender).ItemIndex<1) and (Key = VK_UP) then
  begin
    TListBox(Sender).ItemIndex := -1;
    TListBox(Sender).Selected[0] := False;
    vEdt.SetFocus;
  end;
end;

procedure TFrm_ZB.lb_TempKeyUp(Sender: TObject; var Key: Word;
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

procedure TFrm_ZB.lb_TempMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
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

procedure TFrm_ZB.lb_TempMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
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

procedure TFrm_ZB.Panel2Click(Sender: TObject);
begin
  lb_Temp.Hide;
end;

end.
         


