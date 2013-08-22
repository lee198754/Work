unit uFrm_CL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ButtonEdit, ExtCtrls, ADODB, RzCmboBx, iComboBox;

type
  TFrm_CL = class(TForm)
    Panel2: TPanel;
    Bevel1: TBevel;
    edt_clbh: Ti_TxtFilter;
    edt_clmc: Ti_TxtFilter;
    edt_cjgg: Ti_TxtFilter;
    edt_clgg: Ti_TxtFilter;
    edt_zzs: Ti_TxtFilter;
    edt_jfqs: Ti_TxtFilter;
    edt_jfs: Ti_TxtFilter;
    btn_ok: TButton;
    btn_close: TButton;
    lb_Temp: TListBox;
    edt_ls: Ti_TxtFilter;
    gb_jtsccl: TGroupBox;
    edt_scclbh: Ti_TxtFilter;
    edt_scclmc: Ti_TxtFilter;
    edt_scclsl: Ti_TxtFilter;
    Label1: TLabel;
    cbb_sccldw: TComboBox;
    edt_scclgg: Ti_TxtFilter;
    cbb_cjks: TComboBox;
    Label2: TLabel;
    btn_cl: TButton;
    btn_sccl: TButton;
    cb_jtsccl: TCheckBox;
    edt_sccjgg: Ti_TxtFilter;
    edt_pch: Ti_TxtFilter;
    btn_pch: TButton;
    edt_scpch: Ti_TxtFilter;
    btn_scpch: TButton;
    procedure edt_clbhEnter(Sender: TObject);
    procedure edt_clbhExit(Sender: TObject);
    procedure edt_clbhMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edt_clbhKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_clggMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edt_clggKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_okClick(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure lb_TempKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lb_TempKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lb_TempMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lb_TempMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure edt_jfqsExit(Sender: TObject);
    procedure edt_clggExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Panel2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_clClick(Sender: TObject);
    procedure btn_scclClick(Sender: TObject);
    procedure cb_jtscclClick(Sender: TObject);
    procedure edt_scpchClick(Sender: TObject);
    procedure edt_pchClick(Sender: TObject);
    procedure btn_scpchClick(Sender: TObject);
    procedure btn_pchClick(Sender: TObject);
  private
    { Private declarations }
    bEnter: Boolean;
    vEdt: Ti_TxtFilter;
    vLbVisible: Boolean;
    procedure edtMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    function IfCheck: Boolean;
    procedure EdtExit(Sender: TObject);
    function GetData: Boolean;
    function GetJFQS: Integer;    //获取加放前数
  public
    { Public declarations }
    vActionType: Integer;
    vGroupID: Integer;
  end;

var
  Frm_CL: TFrm_CL;

implementation

uses
  uDM_DataBase, PubStr, Registry, uPub_Type, uPub_Func, uWorkOrder, uPub_Text, uFrm_Select_CL,
  uFrm_Select;

{$R *.dfm}

procedure TFrm_CL.edt_clbhEnter(Sender: TObject);
begin
  bEnter := True;
end;

procedure TFrm_CL.edt_clbhExit(Sender: TObject);
begin
  bEnter := False;
  if (vEdt=nil) or (Ti_TxtFilter(Sender).Name <> vEdt.Name) then
    lb_Temp.Visible := False;
end;

procedure TFrm_CL.edt_clbhMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  sCLBH, sCLMC: string;
  n: Integer;
begin
  if not Assigned(vEdt) then
  begin
    vEdt := Ti_TxtFilter(Sender);
    Exit;
  end;
  if (bEnter) and (vLbVisible)  then
  begin
    if (vEdt.Name <> Ti_TxtFilter(Sender).Name) then
    begin
      vEdt := Ti_TxtFilter(Sender);
      lb_Temp.Hide;
      Exit;
    end;
    if ((not lb_Temp.Visible) or (vEdt.Name <> Ti_TxtFilter(Sender).Name))  then
    begin
      //lb_Temp.Hint := Ti_TxtFilter(Sender).Name;
      if(vEdt.Name = 'edt_scclbh') or (vEdt.Name = 'edt_scclmc') then
      begin
        lb_Temp.Left := Ti_TxtFilter(Sender).Left + Ti_TxtFilter(Sender).Parent.Left;
        lb_Temp.Top := Ti_TxtFilter(Sender).Top+Ti_TxtFilter(Sender).Height + Ti_TxtFilter(Sender).Parent.Top;
        lb_Temp.Tag := c_LB_Tag_SC_Many;
      end else
      begin
        lb_Temp.Left := Ti_TxtFilter(Sender).Left;
        lb_Temp.Top := Ti_TxtFilter(Sender).Top+Ti_TxtFilter(Sender).Height;
        lb_Temp.Tag := c_LB_Tag_Many;
      end;
      lb_Temp.Width := Ti_TxtFilter(Sender).Width;
      vEdt := Ti_TxtFilter(Sender);
      //获取Item列表
      sSqlData := 'select * from BI_MatlManage where F_sCLBH like ''%%%s%%'' and F_sCLMC like ''%%%s%%'' order by F_sCLBH ';
      sCLBH := '';  sCLMC := '';
      if vEdt.Name = 'edt_clbh' then
      begin
        sCLBH := Trim(Ti_TxtFilter(Sender).Text);
       if sCLBH = '' then edt_clmc.Text := '';
      end else
      if  vEdt.Name = 'edt_clmc' then
      begin
        sCLMC := Trim(Ti_TxtFilter(Sender).Text);
      if sCLMC = '' then edt_clbh.Text := '';
      end else
      if  vEdt.Name = 'edt_scclbh' then
      begin
        sCLBH := Trim(Ti_TxtFilter(Sender).Text);
      if sCLBH = '' then edt_scclmc.Text := '';
      end else
      if  vEdt.Name = 'edt_scclmc' then
      begin
        sCLMC := Trim(Ti_TxtFilter(Sender).Text);
      if sCLMC = '' then edt_scclbh.Text := '';
      end;
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sCLBH,sCLMC]);
      lb_Temp.Items.Clear;
      n := 0;
      SetLength(MatlInfo,n);
      while not ADO_Rec.Eof do
      begin
        if vEdt.Name = 'edt_clbh' then
        begin
          lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sCLBH').AsString+'  '+ADO_Rec.FieldByName('F_sCLMC').AsString);
        end else
        if  vEdt.Name = 'edt_clmc' then
        begin
          lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sCLMC').AsString+'  '+ADO_Rec.FieldByName('F_sCLBH').AsString);
        end else
        if vEdt.Name = 'edt_scclbh' then
        begin
          lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sCLBH').AsString+'  '+ADO_Rec.FieldByName('F_sCLMC').AsString);
        end else
        if  vEdt.Name = 'edt_scclmc' then
        begin
          lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sCLMC').AsString+'  '+ADO_Rec.FieldByName('F_sCLBH').AsString);
        end;
        SetLength(MatlInfo,n+1);
        MatlInfo[n].m_iID := n;
        MatlInfo[n].m_sCLBH := ADO_Rec.FieldByName('F_sCLBH').AsString;
        MatlInfo[n].m_sCLMC := ADO_Rec.FieldByName('F_sCLMC').AsString;
        MatlInfo[n].m_sCLGG := ADO_Rec.FieldByName('F_sCLGG').AsString;
        MatlInfo[n].m_sCJGG := ADO_Rec.FieldByName('F_sCJGG').AsString;
        MatlInfo[n].m_sCJSL := '0';
        MatlInfo[n].m_sCJDW := ADO_Rec.FieldByName('F_sDW').AsString;
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
  vLbVisible := True;
end;

procedure TFrm_CL.edt_clbhKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  sCLBH, sCLMC, sCLGG: string;
  n: Integer;
begin
  if not Assigned(vEdt) then
  begin
    vEdt := Ti_TxtFilter(Sender);
    Exit;
  end;
  if (Key = VK_RETURN) and (vEdt.Name = 'edt_scclbh') or (vEdt.Name = 'edt_clbh')  then
  begin
    if vEdt.Name = 'edt_scclbh' then
      btn_sccl.Click
    else
    if vEdt.Name = 'edt_clbh' then
      btn_cl.Click;
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
  if (vEdt.Name = 'edt_scclbh') or (vEdt.Name = 'edt_scclmc') then
  begin
    lb_Temp.Left := Ti_TxtFilter(Sender).Left + Ti_TxtFilter(Sender).Parent.Left;
    lb_Temp.Top := Ti_TxtFilter(Sender).Top+Ti_TxtFilter(Sender).Height + Ti_TxtFilter(Sender).Parent.Top;
    lb_Temp.Tag := c_LB_Tag_SC_Many;
  end else
  begin
    lb_Temp.Left := Ti_TxtFilter(Sender).Left;
    lb_Temp.Top := Ti_TxtFilter(Sender).Top+Ti_TxtFilter(Sender).Height;
    lb_Temp.Tag := c_LB_Tag_Many;
  end;
    lb_Temp.Width := Ti_TxtFilter(Sender).Width;
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
  sCLBH := '';  sCLMC := '';
  if vEdt.Name = 'edt_clbh' then
  begin
    sCLBH := Trim(Ti_TxtFilter(Sender).Text);
  end;
  if vEdt.Name = 'edt_clmc' then
  begin
    sCLMC := Trim(Ti_TxtFilter(Sender).Text);
  end else
  if vEdt.Name = 'edt_scclbh' then
  begin
    sCLBH := Trim(Ti_TxtFilter(Sender).Text);
  end;
  if vEdt.Name = 'edt_scclmc' then
  begin
    sCLMC := Trim(Ti_TxtFilter(Sender).Text);
  end;
 { if vEdt.Name = 'edt_clgg' then
  begin
    sCLGG := Trim(Ti_TxtFilter(Sender).Text);
  end; }
  if (Trim(Ti_TxtFilter(Sender).Text)='') and ((vEdt.Name = 'edt_clbh') or (vEdt.Name = 'edt_clmc') ) then
  begin
    edt_clbh.Text := '';
    edt_clmc.Text := '';
    edt_clgg.Text := '';
    edt_cjgg.Text := '';
  end;
  if (Trim(Ti_TxtFilter(Sender).Text)='') and ((vEdt.Name = 'edt_scclbh') or (vEdt.Name = 'edt_scclmc') ) then
  begin
    edt_scclbh.Text := '';
    edt_scclmc.Text := '';
    edt_scclgg.Text := '';
    edt_scclsl.Text := '';
  end;
  sSqlData := 'select * from BI_MatlManage where F_sCLBH like ''%%%s%%'' and F_sCLMC like ''%%%s%%'' order by F_sCLBH ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sCLBH,sCLMC]);
  lb_Temp.Items.Clear;
  if (ADO_Rec.RecordCount = 0) and (vEdt.Name = 'edt_clmc') then
    edt_clbh.Text := '';
  if (ADO_Rec.RecordCount = 0) and (vEdt.Name = 'edt_scclmc') then
    edt_scclbh.Text := '';
  n := 0;
  SetLength(MatlInfo,n);
  while not ADO_Rec.Eof do
  begin
    if vEdt.Name = 'edt_clbh' then
    begin
      lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sCLBH').AsString+'  '+ADO_Rec.FieldByName('F_sCLMC').AsString);
    end else
    if  vEdt.Name = 'edt_clmc' then
    begin
      lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sCLMC').AsString+'  '+ADO_Rec.FieldByName('F_sCLBH').AsString);
    end else
    if vEdt.Name = 'edt_scclbh' then
    begin
      lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sCLBH').AsString+'  '+ADO_Rec.FieldByName('F_sCLMC').AsString);
    end else
    if  vEdt.Name = 'edt_scclmc' then
    begin
      lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sCLMC').AsString+'  '+ADO_Rec.FieldByName('F_sCLBH').AsString);
    end;
   // lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sCLBH').AsString+'  '+ADO_Rec.FieldByName('F_sCLMC').AsString);
    SetLength(MatlInfo,n+1);
    MatlInfo[n].m_iID := n;
    MatlInfo[n].m_sCLBH := ADO_Rec.FieldByName('F_sCLBH').AsString;
    MatlInfo[n].m_sCLMC := ADO_Rec.FieldByName('F_sCLMC').AsString;
    MatlInfo[n].m_sCLGG := ADO_Rec.FieldByName('F_sCLGG').AsString;
    MatlInfo[n].m_sCJGG := ADO_Rec.FieldByName('F_sCJGG').AsString;
    MatlInfo[n].m_sCJSL := '0';
    MatlInfo[n].m_sCJDW := ADO_Rec.FieldByName('F_sDW').AsString;
    inc(n);
    ADO_Rec.Next;
  end;
  ADO_Rec.Free;
  lb_Temp.Height := LB_HEIGHT - lb_Temp.ItemHeight*iif(lb_Temp.Count<LB_LISTCOUNT,LB_LISTCOUNT-lb_Temp.Count,0);
  lb_Temp.Visible := True;
end;

procedure TFrm_CL.edt_clggMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
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
  if (bEnter) and (vLbVisible)  then
  begin
    if (vEdt.Name <> Ti_TxtFilter(Sender).Name) then
    begin
      vEdt := Ti_TxtFilter(Sender);
      lb_Temp.Hide;
      Exit;
    end;
    if ((not lb_Temp.Visible) or (vEdt.Name <> Ti_TxtFilter(Sender).Name))  then
    begin
      if(vEdt.Name = 'edt_scclgg') or (vEdt.Name = 'edt_scclsl') then
      begin
        lb_Temp.Left := Ti_TxtFilter(Sender).Left + Ti_TxtFilter(Sender).Parent.Left;
        lb_Temp.Top := Ti_TxtFilter(Sender).Top+Ti_TxtFilter(Sender).Height + Ti_TxtFilter(Sender).Parent.Top;
      end else
      begin
        lb_Temp.Left := Ti_TxtFilter(Sender).Left;
        lb_Temp.Top := Ti_TxtFilter(Sender).Top+Ti_TxtFilter(Sender).Height;
      end;
      lb_Temp.Width := Ti_TxtFilter(Sender).Width;
      lb_Temp.Tag := c_LB_Tag_Normal;
      vEdt := Ti_TxtFilter(Sender);
      MyReg := TRegistry.Create;
      MyReg.RootKey := HKEY_LOCAL_MACHINE;
      MyReg.OpenKey(c_Reg_CL_CookiePath,True);
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
  vLbVisible := True;
end;

procedure TFrm_CL.edt_clggKeyUp(Sender: TObject; var Key: Word;
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
  if(vEdt.Name = 'edt_scclgg') or (vEdt.Name = 'edt_scclsl') then
  begin
    lb_Temp.Left := Ti_TxtFilter(Sender).Left + Ti_TxtFilter(Sender).Parent.Left;
    lb_Temp.Top := Ti_TxtFilter(Sender).Top+Ti_TxtFilter(Sender).Height + Ti_TxtFilter(Sender).Parent.Top;
  end else
  begin
    lb_Temp.Left := Ti_TxtFilter(Sender).Left;
    lb_Temp.Top := Ti_TxtFilter(Sender).Top+Ti_TxtFilter(Sender).Height;
  end;
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
  MyReg.OpenKey(c_Reg_CL_CookiePath,True);
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

procedure TFrm_CL.btn_okClick(Sender: TObject);
var
  i, n: Integer;
begin
  if not IfCheck then Exit;
  //保存录入材料修改
  n := -1;
  for i := 0 to Length(aCL) -1 do
  begin
    if (aCL[i].m_iGroupID = vGroupID) and (aCL[i].m_iFlag = c_CL_Flag_Normal) then
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
  aCL[n].m_sCLBH    := edt_clbh.Text;
  aCL[n].m_sCLMC    := edt_clmc.Text;
  aCL[n].m_sCLGG    := edt_clgg.Text;
  aCL[n].m_sCJGG    := edt_cjgg.Text;
  aCL[n].m_sCJKS    := cbb_cjks.Text;
  aCL[n].m_iJFQS    := StrToNum(edt_jfqs.Text);
  aCL[n].m_iJFS     := StrToNum(edt_jfs.Text);
  aCL[n].m_iFlag    := c_CL_Flag_Normal;
  aCL[n].m_sDW      := '令';
  //aCL[n].m_sPCH     := edt_pch.Text;
  aCL[n].m_iGroupID := vGroupID;

  //保存机台所需材料修改
  n := -1;
  for i := 0 to Length(aCL) -1 do
  begin
    if (aCL[i].m_iGroupID = vGroupID) and (aCL[i].m_iFlag = c_CL_Flag_Auto) then
    begin
      n := i;
      Break;
    end;
  end;
  if cb_jtsccl.Checked then
  begin
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
    aCL[n].m_sCLBH     := edt_scclbh.Text;
    aCL[n].m_sCLMC     := edt_scclmc.Text;
    aCL[n].m_sCLGG     := edt_scclgg.Text;
    aCL[n].m_sCJGG     := edt_sccjgg.Text;
    aCL[n].m_iJFQS     := 0;
    aCL[n].m_iJFS      := 0;
    aCL[n].m_sSL       := edt_scclsl.Text;
    aCL[n].m_sDW       := cbb_sccldw.Text;
    //aCL[n].m_sPCH      := edt_scpch.Text;
    aCL[n].m_iFlag     := c_CL_Flag_Auto;
    aCL[n].m_iGroupID  := vGroupID;
  end else
  if n > -1 then
  begin
    aCL[n].m_iGroupID := -1;
  end;
  ModalResult := mrOk;                
end;

procedure TFrm_CL.Panel2Click(Sender: TObject);
begin
  lb_Temp.Hide;
end;

procedure TFrm_CL.lb_TempKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (TListBox(Sender).ItemIndex<1) and (Key = VK_UP) then
  begin
    TListBox(Sender).ItemIndex := -1;
    TListBox(Sender).Selected[0] := False;
    vEdt.SetFocus;
  end;
end;

procedure TFrm_CL.lb_TempKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  str: string;
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
            {edt_clbh.Text := Copy(str,1,Pos('  ',str)-1) ;
            if edt_clbh.Text = '' then
              edt_clbh.Text := str
            else
              edt_clmc.Text := Copy(str,Pos('  ',str)+2,Length(str)) ;  }
            edt_clbh.Text :=  MatlInfo[n].m_sCLBH;
            edt_clmc.Text :=  MatlInfo[n].m_sCLMC;
            edt_clgg.Text :=  MatlInfo[n].m_sCLGG;
            edt_cjgg.Text :=  MatlInfo[n].m_sCJGG;
          end;
        c_LB_Tag_SC_Many:
          begin
            edt_scclbh.Text :=  MatlInfo[n].m_sCLBH;
            edt_scclmc.Text :=  MatlInfo[n].m_sCLMC;
            edt_scclgg.Text :=  MatlInfo[n].m_sCLGG;
            edt_scclsl.Text :=  MatlInfo[n].m_sCJSL;
            if cbb_sccldw.Items.IndexOf(MatlInfo[n].m_sCJDW) = -1 then
              cbb_sccldw.Items.Add(MatlInfo[n].m_sCJDW);
            cbb_sccldw.ItemIndex :=  cbb_sccldw.Items.IndexOf(MatlInfo[n].m_sCJDW);
          end;
      else
        vEdt.Text := str;
      end;
      {if (vEdt.Name = 'edt_clbh') or (vEdt.Name = 'edt_clmc') then
      begin
        edt_clbh.Text := Copy(str,1,Pos('  ',str)-1) ;
        if edt_clbh.Text = '' then
          edt_clbh.Text := str
        else
          edt_clmc.Text := Copy(str,Pos('  ',str)+2,Length(str)) ;
      end else
        vEdt.Text := str;  }
    end;
    vEdt.SetFocus;
  end;
end;

procedure TFrm_CL.lb_TempMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  str: string;
  i, n: Integer;
begin
  lb_Temp.Visible := False;
  if lb_Temp.ItemIndex >= 0 then
  begin
    str := lb_Temp.Items.Strings[lb_Temp.ItemIndex];
    n := lb_Temp.ItemIndex;
    case lb_Temp.Tag of
      c_LB_Tag_Many:
        begin
          {edt_clbh.Text := Copy(str,1,Pos('  ',str)-1) ;
          if edt_clbh.Text = '' then
            edt_clbh.Text := str
          else
            edt_clmc.Text := Copy(str,Pos('  ',str)+2,Length(str)) ;  }
          edt_clbh.Text :=  MatlInfo[n].m_sCLBH;
          edt_clmc.Text :=  MatlInfo[n].m_sCLMC;
          edt_clgg.Text :=  MatlInfo[n].m_sCLGG;
          edt_cjgg.Text :=  MatlInfo[n].m_sCJGG;
        end;
      c_LB_Tag_SC_Many:
        begin
          edt_scclbh.Text :=  MatlInfo[n].m_sCLBH;
          edt_scclmc.Text :=  MatlInfo[n].m_sCLMC;
          edt_scclgg.Text :=  MatlInfo[n].m_sCLGG;
          edt_scclsl.Text :=  MatlInfo[n].m_sCJSL;
          if cbb_sccldw.Items.IndexOf(MatlInfo[n].m_sCJDW) = -1 then
            cbb_sccldw.Items.Add(MatlInfo[n].m_sCJDW);
          cbb_sccldw.ItemIndex :=  cbb_sccldw.Items.IndexOf(MatlInfo[n].m_sCJDW);
        end;
    else
      vEdt.Text := str;
    end;
  end;
  vEdt.SetFocus;

end;

procedure TFrm_CL.lb_TempMouseMove(Sender: TObject; Shift: TShiftState; X,
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

function TFrm_CL.IfCheck: Boolean;
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  sCLBH: string;
begin
  Result := False;
  sCLBH := Trim(edt_clbh.Text);
  if sCLBH <> '' then
  begin
    sSqlData := 'select * from BI_MatlManage where F_sCLBH = ''s'' ';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sCLBH],False);
    if (ADO_Rec = nil) and (ADO_Rec.RecordCount = 0) then
    begin
      p_MessageBoxDlg('此编号不存在,如果想继续录入请不要输入编号!');
      edt_clbh.Text := '';
      ADO_Rec.Free;
      Exit;
    end;
  end;
{  if edt_scpch.Text = '' then
  begin
    p_MessageBoxDlg('请填写生成材料所使用的批次!');
    edt_scpch.SetFocus;
    Exit;
  end;
  if edt_pch.Text = '' then
  begin
    p_MessageBoxDlg('请填写材料所使用的批次!');
    edt_pch.SetFocus;
    Exit;
  end;  }
  Result := True;
end;

procedure TFrm_CL.edt_jfqsExit(Sender: TObject);
begin
  if (Pos('.',Ti_TxtFilter(Sender).Text)>0) or ((Ti_TxtFilter(Sender).Text <> '') and (not IsNum(Ti_TxtFilter(Sender).Text))) then
  begin
    p_MessageBoxDlg('字符无效,请输入数字(不含小数)!');
    Ti_TxtFilter(Sender).SetFocus;
    Exit;
  end;
  if StrToNum(edt_jfqs.Text)+ StrToNum(edt_jfs.Text) >  High(Integer) then
  begin
   Application.MessageBox('加放前数与加放数之和超过可用范围!','提示',MB_ICONINFORMATION);
   Ti_TxtFilter(Sender).SetFocus;
   vLbVisible := False;
   Exit;
  end;
  edt_zzs.Text := StrToNum(edt_jfqs.Text)+ StrToNum(edt_jfs.Text);
  edt_ls.Text := FormatFloat('0.000',StrToNum(edt_zzs.Text)/500);
  EdtExit(Sender);
end;

procedure TFrm_CL.EdtExit(Sender: TObject);
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
  MyReg.OpenKey(c_Reg_CL_CookiePath,True);
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

procedure TFrm_CL.edt_clggExit(Sender: TObject);
begin
  EdtExit(Sender);
end;

procedure TFrm_CL.FormShow(Sender: TObject);
begin
  if vActionType = c_WorkOrder_Select then
  begin
    btn_ok.Enabled := False;
  end;
  TForm(edt_clbh).OnMouseWheel := edtMouseWheel;
  TForm(edt_clmc).OnMouseWheel := edtMouseWheel;
  vLbVisible := True;
  GetData;
end;

procedure TFrm_CL.edtMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if WheelDelta >= 0 then
    lb_Temp.Perform(WM_VSCROLL,SB_LINEUP,WheelDelta)
  else if WheelDelta < 0 then
    lb_Temp.Perform(WM_VSCROLL,SB_LINEDOWN,WheelDelta);
end;

function TFrm_CL.GetData: Boolean;
var
  i, n, iJFQS: Integer;
begin
  Result := False;
  //添加录入材料
  n := -1;
  for i := 0 to Length(aCL) -1 do
  begin
    if (aCL[i].m_iGroupID = vGroupID) and (aCL[i].m_iFlag = c_CL_Flag_Normal) then
    begin
      n := i;
      Break;
    end;
  end;
  if n = -1 then
  begin
    iJFQS := GetJFQS;
    if iJFQS >0 then
      edt_jfqs.Text := IntToStr(iJFQS);
    for i := 0 to Length(aCL) -1 do
    begin
      if (aYSDH[i].m_iGroupID = vGroupID) and (aYSDH[i].m_iSBS > 0) then
      begin
        cbb_cjks.Text := IntToStr(aYSDH[i].m_iSBS);
        Break;
      end;
    end;
  end else
  begin
    edt_clbh.Text := aCL[n].m_sCLBH;
    edt_clmc.Text := aCL[n].m_sCLMC;
    edt_clgg.Text := aCL[n].m_sCLGG;
    edt_cjgg.Text := aCL[n].m_sCJGG;
    cbb_cjks.ItemIndex := cbb_cjks.Items.IndexOf(aCL[n].m_sCJKS);
    edt_jfqs.Text := IntToStr(aCL[n].m_iJFQS);
    edt_jfs.Text := IntToStr(aCL[n].m_iJFS);
    edt_zzs.Text := StrToNum(edt_jfqs.Text)+ StrToNum(edt_jfs.Text);
    edt_ls.Text := FormatFloat('0.000',StrToNum(edt_zzs.Text)/500);
    iJFQS := GetJFQS;
    if iJFQS >0 then
      edt_jfqs.Text := IntToStr(iJFQS);
    edt_pch.Text := aCL[n].m_sPCH;
  end;

  //添加机台所需材料
  n := -1;
  for i := 0 to Length(aCL) -1 do
  begin
    if (aCL[i].m_iGroupID = vGroupID) and (aCL[i].m_iFlag = c_CL_Flag_Auto) then
    begin
      n := i;
      Break;
    end;
  end;
  if n = -1 then
  begin
    //p_MessageBoxDlg('请先添加机台才会自动生成机台所需材料!');
    cb_jtsccl.Checked := False;
    lb_Temp.Hide;
    gb_jtsccl.Enabled := cb_jtsccl.Checked;
    for i := 0 to gb_jtsccl.ControlCount -1 do
    begin
      if (gb_jtsccl.Controls[i] is Ti_TxtFilter) or (gb_jtsccl.Controls[i] is TComboBox) then
      begin
        Ti_TxtFilter(gb_jtsccl.Controls[i]).Enabled := cb_jtsccl.Checked;
        Ti_TxtFilter(gb_jtsccl.Controls[i]).Color := iif(cb_jtsccl.Checked,clWindow,clBtnFace);
      end;
    end;
  end else
  begin
    edt_scclbh.Text := aCL[n].m_sCLBH;
    edt_scclmc.Text := aCL[n].m_sCLMC;
    edt_scclsl.Text := aCL[n].m_sSL;
    edt_scclgg.Text := aCL[n].m_sCLGG;
    edt_sccjgg.Text := aCL[n].m_sCJGG;
    if cbb_sccldw.Items.IndexOf(aCL[n].m_sDW) = -1 then
      cbb_sccldw.Items.Add(aCL[n].m_sDW);
    cbb_sccldw.ItemIndex := cbb_sccldw.Items.IndexOf(aCL[n].m_sDW);
    edt_scpch.Text := aCL[n].m_sPCH;
  end;

  Result := True;
end;

function TFrm_CL.GetJFQS: Integer;
var
  i, iJFQS, iSBS, iBSTYS, iYS, iSC: Integer;
  sSC: string;
begin
  Result := 0;
  iJFQS := StrToNum(edt_jfqs.Text);
  if iJFQS > 0 then Exit;
  for i := 0 to Length(aYSDH) -1 do
  begin
    if aYSDH[i].m_iGroupID = Frm_WorkOrder.ADO_WorkOrder.RecNo then
    begin
      iSBS := aYSDH[i].m_iSBS;
      iYS := aYSDH[i].m_iYS_1;
      if aYSDH[i].m_iYS_2 > 0 then
        iYS := iYS + aYSDH[i].m_iYS_2;
      sSC := aYSDH[i].m_sSC;
    end;
  end;
  //iBSTYS := Frm_WorkOrder.ADO_WorkOrder.FieldByName('BSTYS').AsInteger;
  if (iSBS > 0) and (iYS > 0) then
  begin
    Result := iYS div iSBS;
    if iYS mod iSBS > 0 then
      Result := Result + 1;
    iSC := 0;
    if StrToNum(PosCopy(sSC,'/',1)) > 0 then
      Inc(iSC);
    if StrToNum(PosCopy(sSC,'/',2)) > 0 then
      Inc(iSC);
    if iSC = 0 then iSC := 1;
    if Result mod iSC > 0 then
      Result := Result div iSC + 1
    else
      Result := Result div iSC;
  end;
end;

procedure TFrm_CL.Panel2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  lb_Temp.Hide;
end;

procedure TFrm_CL.btn_clClick(Sender: TObject);
var
  aRecField : TArrSelectField;
  i: Integer;
begin
  aRecField := f_ShowSelectCL(edt_clbh.Text);
  for i := 0 to Length(aRecField) -1 do
  begin
    if aRecField[i].m_sName = '材料编号' then
      edt_clbh.Text := aRecField[i].m_sValue;
    if aRecField[i].m_sName = '材料名称' then
      edt_clmc.Text := aRecField[i].m_sValue;
    if aRecField[i].m_sName = '材料规格' then
      edt_clgg.Text := aRecField[i].m_sValue;
    if aRecField[i].m_sName = '裁剪规格' then
      edt_cjgg.Text := aRecField[i].m_sValue;
//    if aRecField[i].m_sName = '材料单位' then
//      cbb_cldw.Text := aRecField[i].m_sValue;
  end;

{
  Frm_Select_CL := TFrm_Select_CL.Create(Self);
  Frm_Select_CL.cbb_type.Text := '材料编号';
  Frm_Select_CL.edt_value.Text := edt_clbh.Text;
  Frm_Select_CL.ShowModal;
  if Frm_Select_CL.vSuccess then
  begin
    edt_clbh.Text := Frm_Select_CL.vCLBH;
    edt_clmc.Text := Frm_Select_CL.vCLMC;
    edt_clgg.Text := Frm_Select_CL.vCLGG;
    edt_cjgg.Text := Frm_Select_CL.vCJGG;
  end;
  Frm_Select_CL.Free;
 } 
end;

procedure TFrm_CL.btn_scclClick(Sender: TObject);
var
  i: integer;
  aRecField: TArrSelectField;
begin
  aRecField := f_ShowSelectCL(edt_scclbh.Text);
  for i := 0 to Length(aRecField) -1 do
  begin
    if aRecField[i].m_sName = '材料编号' then
      edt_scclbh.Text := aRecField[i].m_sValue;
    if aRecField[i].m_sName = '材料名称' then
      edt_scclmc.Text := aRecField[i].m_sValue;
    if aRecField[i].m_sName = '材料规格' then
      edt_scclgg.Text := aRecField[i].m_sValue;
    if aRecField[i].m_sName = '裁剪规格' then
      edt_sccjgg.Text := aRecField[i].m_sValue;
    if aRecField[i].m_sName = '材料单位' then
      cbb_sccldw.Text := aRecField[i].m_sValue;
  end;

{  Frm_Select_CL := TFrm_Select_CL.Create(Self);
  Frm_Select_CL.cbb_type.Text := '材料编号';
  Frm_Select_CL.edt_value.Text := edt_scclbh.Text;
  Frm_Select_CL.ShowModal;
  if Frm_Select_CL.vSuccess then
  begin
    edt_scclbh.Text := Frm_Select_CL.vCLBH;
    edt_scclmc.Text := Frm_Select_CL.vCLMC;
    edt_scclgg.Text := Frm_Select_CL.vCLGG;
    edt_sccjgg.Text := Frm_Select_CL.vCJGG;
    cbb_sccldw.Text := Frm_Select_CL.vDW;
  end;
  Frm_Select_CL.Free;    }

end;

procedure TFrm_CL.cb_jtscclClick(Sender: TObject);
var
  i: integer;
begin
  lb_Temp.Hide;
  gb_jtsccl.Enabled := cb_jtsccl.Checked;
  for i := 0 to gb_jtsccl.ControlCount -1 do
  begin
    if (gb_jtsccl.Controls[i] is Ti_TxtFilter) or (gb_jtsccl.Controls[i] is TComboBox) then
    begin
      Ti_TxtFilter(gb_jtsccl.Controls[i]).Enabled := cb_jtsccl.Checked;
      Ti_TxtFilter(gb_jtsccl.Controls[i]).Color := iif(cb_jtsccl.Checked,clWindow,clBtnFace);
    end;
  end;
end;

procedure TFrm_CL.edt_scpchClick(Sender: TObject);
begin
  if Trim(Ti_TxtFilter(Sender).Text) = '' then
    btn_scpch.Click;
end;

procedure TFrm_CL.edt_pchClick(Sender: TObject);
begin
  if Trim(Ti_TxtFilter(Sender).Text) = '' then
    btn_pch.Click;

end;

procedure TFrm_CL.btn_scpchClick(Sender: TObject);
var
  i: integer;
  aRecField: TArrSelectField;
begin
  if Trim(edt_scclbh.Text) = '' then
  begin
    p_MessageBoxDlg('请先选择材料!');
    edt_scclbh.SetFocus;
    Exit;
  end;

  if Trim(edt_scclsl.Text) = '' then
  begin
    p_MessageBoxDlg('请先输入数量!');
    edt_scclsl.SetFocus;
    Exit;
  end;
  aRecField := f_ShowSelectCLPCH(edt_scclbh.Text,strtonum(edt_scclsl.text));
  for i := 0 to Length(aRecField) -1 do
  begin
    if aRecField[i].m_sName = '批次号' then
      edt_scpch.Text := aRecField[i].m_sValue;
  end;
end;

procedure TFrm_CL.btn_pchClick(Sender: TObject);
var
  i: integer;
  aRecField: TArrSelectField;
begin
  if Trim(edt_clbh.Text) = '' then
  begin
    p_MessageBoxDlg('请先选择材料!');
    edt_clbh.SetFocus;
    Exit;
  end;
  if Trim(edt_jfqs.Text) = '' then
  begin
    p_MessageBoxDlg('请先输入加放前数!');
    edt_jfqs.SetFocus;
    Exit;
  end;
  aRecField := f_ShowSelectCLPCH(edt_clbh.Text,StrToNum(edt_zzs.Text));
  for i := 0 to Length(aRecField) -1 do
  begin
    if aRecField[i].m_sName = '批次号' then
      edt_pch.Text := aRecField[i].m_sValue;
  end;
end;

end.

