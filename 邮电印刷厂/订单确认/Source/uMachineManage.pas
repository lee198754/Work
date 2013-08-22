unit uMachineManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, iGrid, RzButton, StdCtrls, ButtonEdit, ExtCtrls, RzPanel,
  ADODB, iComboBox;

type
  TFra_MachineManage = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    RzGroupBox2: TRzGroupBox;
    edt_jtbh: Ti_TxtFilter;
    edt_jtmc: Ti_TxtFilter;
    btn_add: TRzButton;
    btn_mod: TRzButton;
    stg_jtxx: Ti_StgEdit;
    gb_sccl: TRzGroupBox;
    cb_sccl: TCheckBox;
    lb_Temp: TListBox;
    edt_clbh: Ti_TxtFilter;
    edt_clmc: Ti_TxtFilter;
    edt_clgg: Ti_TxtFilter;
    Label1: TLabel;
    cbb_dw: TComboBox;
    procedure stg_jtxxLinkClick(Sender: TObject; ACol, ARow: Integer);
    procedure stg_jtxxSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btn_addClick(Sender: TObject);
    procedure btn_modClick(Sender: TObject);
    procedure cb_scclClick(Sender: TObject);
    procedure edt_clhEnter(Sender: TObject);
    procedure edt_clbhExit(Sender: TObject);
    procedure edt_clggExit(Sender: TObject);
    procedure edt_clbhMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edt_clbhKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_clggKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_clggMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lb_TempKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lb_TempKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lb_TempMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lb_TempMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure gb_scclMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    stgSeletedID: Integer;
    bEnter: Boolean;
    vEdt: Ti_TxtFilter;
    vLbVisible: Boolean;
    procedure EdtExit(Sender: TObject);
    procedure LoadJTXX;
    function IsEmpty: Boolean;
    procedure ClearText;
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

uses
  uDM_DataBase,PubStr, uPub_Func, Registry, uPub_Text, uPub_Type;


{$R *.dfm}

const
  c_JTBH = 0;
  c_JTMC = 1;
  c_JTCLBH = 2;
  c_JTCLMC = 3;
  c_JTCLGG = 4;
  c_JTCLDW = 5;
  c_CZ   = 6;
  c_JTID = 7;

{ TFrm_MachineManage }

procedure TFra_MachineManage.ClearText;
var
  i: Integer;
begin
  for i := 0 to Self.ComponentCount -1 do
  begin
    if Self.Components[i] is Ti_TxtFilter then
      Ti_TxtFilter(Self.Components[i]).Text := ''
    else
    if (Self.Components[i] is Ti_ComboBox) or (Self.Components[i] is TComboBox) then
      Ti_ComboBox(Self.Components[i]).ItemIndex := 0;
  end;
  stgSeletedID := 0;
end;

procedure TFra_MachineManage.FraShow;
begin
  stg_jtxx.ColWidths[c_JTID] := 0;
  LoadJTXX;
end;

function TFra_MachineManage.IsEmpty: Boolean;
var
  i: Integer;
  comp: TComponent;
begin
  Result := False;
  for i := 0 to Self.ComponentCount -1 do
  begin
    comp := Self.Components[i];
    if (comp is Ti_TxtFilter) or (comp is Ti_ComboBox) then
    begin
      if  comp.Tag <> 10 then
      begin
        if Ti_TxtFilter(comp).Text = '' then
        begin
          Application.MessageBox(PChar('请输入 '+StrReplace(Ti_TxtFilter(comp).LabelCaption,'：',' ')+'!'),'提示',MB_ICONINFORMATION);
          Ti_TxtFilter(comp).SetFocus;
          Result := True;
          Exit;
        end;
      end;        
    end;
  end;
end;

procedure TFra_MachineManage.LoadJTXX;
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
  n: integer;
begin
  try
    sSqlData := 'Select * from BI_MachineToolInfo';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[],True);
    stg_jtxx.Clear;
    stg_jtxx.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
    if ADO_Rec.RecordCount > 0 then
    begin
      n := 1;
      with ADO_Rec do
      begin
        while not Eof do
        begin
          stg_jtxx.Cells[c_JTBH,n] := FieldByName('F_sJTBH').AsString;
          stg_jtxx.Cells[c_JTMC,n] := FieldByName('F_sJTMC').AsString;
          stg_jtxx.Cells[c_JTCLBH,n] := FieldByName('F_sJTCLBH').AsString;
          stg_jtxx.Cells[c_JTCLMC,n] := FieldByName('F_sJTCLMC').AsString;
          stg_jtxx.Cells[c_JTCLGG,n] := FieldByName('F_sJTCLGG').AsString;
          stg_jtxx.Cells[c_JTCLDW,n] := FieldByName('F_sJTCLDW').AsString;
          stg_jtxx.Cells[c_CZ,n] := '删除';                                          
          stg_jtxx.CellsLink[c_CZ,n] := '删除';                                      
          stg_jtxx.Cells[c_JTID,n] := FieldByName('F_iID').AsString;                 
          inc(n);                                                                    
          Next;
        end;
      end;
    end;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar('错误:'+E.message),'提示',MB_ICONINFORMATION);
      Exit;
    end;
  end;
  ADO_Rec.Free;
end;

procedure TFra_MachineManage.stg_jtxxLinkClick(Sender: TObject; ACol,
  ARow: Integer);
var
  sSqlData: string;
  iID: integer;
begin
  iID := StrToNum(stg_jtxx.Cells[c_JTID,ARow]);
  if iID = 0 then Exit;
  if ACol = c_CZ then
  begin
    if Application.MessageBox(PChar('是否删除机台 "'+stg_jtxx.Cells[c_JTMC,ARow]+'" ?'),'提示',MB_YESNO +MB_ICONINFORMATION)= IDNO then Exit;
    sSqlData := 'Delete BI_MachineToolInfo where F_iID=%d';
    try
      DM_DataBase.ExecQuery(sSqlData,[iID],True);
      stg_jtxx.p_Delrow(ARow);
      p_MessageBoxDlg('删除成功!');
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar('删除失败:'+E.message),'提示',MB_ICONINFORMATION);
      end;
    end;                
  end;
end;

procedure TFra_MachineManage.stg_jtxxSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  i: integer;
begin
  edt_jtbh.Text := stg_jtxx.cells[c_JTBH ,ARow];
  edt_jtmc.Text := stg_jtxx.cells[c_JTMC ,ARow];
  if stg_jtxx.cells[c_JTCLMC ,ARow] <> '' then
  begin
    cb_sccl.Checked := True;
  end else
    cb_sccl.Checked := False;
  edt_clbh.Text := stg_jtxx.cells[c_JTCLBH ,ARow];
  edt_clmc.Text := stg_jtxx.cells[c_JTCLMC ,ARow];
  edt_clgg.Text := stg_jtxx.cells[c_JTCLGG ,ARow];
  cbb_dw.Text := stg_jtxx.cells[c_JTCLDW ,ARow];
  gb_sccl.Enabled := cb_sccl.Checked;
  for i := 0 to gb_sccl.ControlCount -1 do
  begin
    if (gb_sccl.Controls[i] is Ti_TxtFilter) or (gb_sccl.Controls[i] is TComboBox) then
    begin
      Ti_TxtFilter(gb_sccl.Controls[i]).Enabled := cb_sccl.Checked;
      Ti_TxtFilter(gb_sccl.Controls[i]).Color := iif(cb_sccl.Checked,clWindow,clBtnFace);
    end;
  end;
  stgSeletedID := StrToNum(stg_jtxx.cells[c_JTID ,ARow]);

end;                                                                                     
                                                                                         
procedure TFra_MachineManage.btn_addClick(Sender: TObject);                              
var                                                                                      
  ADO_Rec: TADOQuery;
  sSqlData, str: string;
begin
  if IsEmpty then Exit;
  try
    sSqlData := 'Select * from BI_MachineToolInfo where F_sJTBH=''%s'' or F_sJTMC=''%s'' ';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[edt_jtbh.Text,edt_jtmc.Text],True);
    if ADO_rec.RecordCount > 0 then
    begin
      str := '';
      if edt_jtbh.Text =  ADO_rec.FieldByName('F_sJTBH').AsString then
        str := str+',机台编号';
      if edt_jtmc.Text =  ADO_rec.FieldByName('F_sJTMC').AsString then
        str := str+',机台名称';
      str := Copy(str,2,Length(str));
      Application.MessageBox(PChar(str+'已存在,请重新输入!'),'提示',MB_ICONINFORMATION);
      ADO_Rec.Free;
      Exit;
    end;
    with ADO_Rec do
    begin
      Insert;
      FieldByName('F_sJTBH').AsString := edt_jtbh.Text;
      FieldByName('F_sJTMC').AsString := edt_jtmc.Text;
      if cb_sccl.Checked then
      begin
        FieldByName('F_sJTCLBH').AsString := edt_clbh.Text;
        FieldByName('F_sJTCLMC').AsString := edt_clmc.Text;
        FieldByName('F_sJTCLGG').AsString := edt_clgg.Text;
        FieldByName('F_sJTCLDW').AsString := cbb_dw.Text;
      end;
      Post;
    end;
    p_MessageBoxDlg('添加成功!');
    ClearText;
    LoadJTXX;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(e.Message),'提示',MB_ICONINFORMATION);
      Exit;
    end;
  end;
end;

procedure TFra_MachineManage.btn_modClick(Sender: TObject);
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
begin
  if IsEmpty then Exit;
  if stgSeletedID =0 then
  begin
    Application.MessageBox('请选择要修改的数据!','提示',MB_ICONINFORMATION);
    Exit;
  end;
  try
    sSqlData := 'Select * from BI_MachineToolInfo where F_iID=%d ';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[stgSeletedID],True);
    if ADO_Rec.RecordCount = 0 then
    begin
      p_MessageBoxDlg('数据不存在,不能修改!');
      ADO_Rec.Free;
      Exit;
    end;
    with ADO_Rec do
    begin
      Edit;
      FieldByName('F_sJTBH').AsString := edt_jtbh.Text;
      FieldByName('F_sJTMC').AsString := edt_jtmc.Text;
      if cb_sccl.Checked then
      begin
        FieldByName('F_sJTCLBH').AsString := edt_clbh.Text;
        FieldByName('F_sJTCLMC').AsString := edt_clmc.Text;
        FieldByName('F_sJTCLGG').AsString := edt_clgg.Text;
        FieldByName('F_sJTCLDW').AsString := cbb_dw.Text;
      end;
      Post;
    end;
    p_MessageBoxDlg('修改成功!');
    ClearText;
    LoadJTXX;
  except
    on E: Exception do      
    begin
      Application.MessageBox(PChar('修改失败：'+E.Message),'提示',MB_ICONINFORMATION);
      Exit;
    end;
  end;
  ADO_Rec.Free;
end;

procedure TFra_MachineManage.cb_scclClick(Sender: TObject);
var
  i: integer;
begin
  lb_Temp.Hide;
  gb_sccl.Enabled := cb_sccl.Checked;
  for i := 0 to gb_sccl.ControlCount -1 do
  begin
    if (gb_sccl.Controls[i] is Ti_TxtFilter) or (gb_sccl.Controls[i] is TComboBox) then
    begin
      Ti_TxtFilter(gb_sccl.Controls[i]).Enabled := cb_sccl.Checked;
      Ti_TxtFilter(gb_sccl.Controls[i]).Color := iif(cb_sccl.Checked,clWindow,clBtnFace);
    end;
  end;



end;

procedure TFra_MachineManage.edt_clhEnter(Sender: TObject);
begin
  bEnter := True;
end;

procedure TFra_MachineManage.edt_clbhExit(Sender: TObject);
begin
  bEnter := False;
  if (vEdt=nil) or (Ti_TxtFilter(Sender).Name <> vEdt.Name) then
    lb_Temp.Visible := False;

end;

procedure TFra_MachineManage.EdtExit(Sender: TObject);
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
  MyReg.OpenKey(c_Reg_MachineManage_CookiePath,True);
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

procedure TFra_MachineManage.edt_clggExit(Sender: TObject);
begin
  EdtExit(Sender);
end;

procedure TFra_MachineManage.edt_clbhMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
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
      lb_Temp.Left := Ti_TxtFilter(Sender).Left + Ti_TxtFilter(Sender).Parent.Left;
      lb_Temp.Top := Ti_TxtFilter(Sender).Top+Ti_TxtFilter(Sender).Height + Ti_TxtFilter(Sender).Parent.Top;
      lb_Temp.Width := Ti_TxtFilter(Sender).Width;
      //lb_Temp.Hint := Ti_TxtFilter(Sender).Name;
      lb_Temp.Tag := c_LB_Tag_Many;
      vEdt := Ti_TxtFilter(Sender);
      //获取Item列表
      sSqlData := 'select * from BI_MatlManage where F_sCLBH like ''%%%s%%'' and F_sCLMC like ''%%%s%%'' ';
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
        end;
        SetLength(MatlInfo,n+1);
        MatlInfo[n].m_iID := n;
        MatlInfo[n].m_sCLBH := ADO_Rec.FieldByName('F_sCLBH').AsString;
        MatlInfo[n].m_sCLMC := ADO_Rec.FieldByName('F_sCLMC').AsString;
        MatlInfo[n].m_sCLGG := ADO_Rec.FieldByName('F_sCLGG').AsString;
        MatlInfo[n].m_sCJGG := ADO_Rec.FieldByName('F_sCJGG').AsString;
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

procedure TFra_MachineManage.edt_clbhKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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
  if (vEdt.Name <> Ti_TxtFilter(Sender).Name) then
  begin
    vEdt := Ti_TxtFilter(Sender);
    lb_Temp.Hide;
    Exit;
  end;
  lb_Temp.Left := Ti_TxtFilter(Sender).Left+ Ti_TxtFilter(Sender).Parent.Left;
  lb_Temp.Top := Ti_TxtFilter(Sender).Top+Ti_TxtFilter(Sender).Height+ Ti_TxtFilter(Sender).Parent.Top;
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
  sCLBH := '';  sCLMC := '';
  if vEdt.Name = 'edt_clbh' then
  begin
    sCLBH := Trim(Ti_TxtFilter(Sender).Text);
  end;
  if vEdt.Name = 'edt_clmc' then
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
  end;
  sSqlData := 'select * from BI_MatlManage where F_sCLBH like ''%%%s%%'' and F_sCLMC like ''%%%s%%'' ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sCLBH,sCLMC]);
  lb_Temp.Items.Clear;
  if (ADO_Rec.RecordCount = 0) and (vEdt.Name = 'edt_clmc') then
    edt_clbh.Text := '';
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
    end;
   // lb_Temp.Items.Add(ADO_Rec.FieldByName('F_sCLBH').AsString+'  '+ADO_Rec.FieldByName('F_sCLMC').AsString);
    SetLength(MatlInfo,n+1);
    MatlInfo[n].m_iID := n;
    MatlInfo[n].m_sCLBH := ADO_Rec.FieldByName('F_sCLBH').AsString;
    MatlInfo[n].m_sCLMC := ADO_Rec.FieldByName('F_sCLMC').AsString;
    MatlInfo[n].m_sCLGG := ADO_Rec.FieldByName('F_sCLGG').AsString;
    MatlInfo[n].m_sCJGG := ADO_Rec.FieldByName('F_sCJGG').AsString;
    inc(n);
    ADO_Rec.Next;
  end;
  ADO_Rec.Free;
  lb_Temp.Height := LB_HEIGHT - lb_Temp.ItemHeight*iif(lb_Temp.Count<LB_LISTCOUNT,LB_LISTCOUNT-lb_Temp.Count,0);
  lb_Temp.Visible := True;
end;

procedure TFra_MachineManage.edt_clggKeyUp(Sender: TObject; var Key: Word;
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
  lb_Temp.Left := Ti_TxtFilter(Sender).Left+ Ti_TxtFilter(Sender).Parent.Left;
  lb_Temp.Top := Ti_TxtFilter(Sender).Top+Ti_TxtFilter(Sender).Height+ Ti_TxtFilter(Sender).Parent.Top;
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
  MyReg.OpenKey(c_Reg_MachineManage_CookiePath,True);
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

procedure TFra_MachineManage.edt_clggMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
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
      lb_Temp.Left := Ti_TxtFilter(Sender).Left + Ti_TxtFilter(Sender).Parent.Left;
      lb_Temp.Top := Ti_TxtFilter(Sender).Top+Ti_TxtFilter(Sender).Height + Ti_TxtFilter(Sender).Parent.Top;
      lb_Temp.Width := Ti_TxtFilter(Sender).Width;
      lb_Temp.Tag := c_LB_Tag_Normal;
      vEdt := Ti_TxtFilter(Sender);
      MyReg := TRegistry.Create;
      MyReg.RootKey := HKEY_LOCAL_MACHINE;
      MyReg.OpenKey(c_Reg_MachineManage_CookiePath,True);

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

procedure TFra_MachineManage.lb_TempKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (TListBox(Sender).ItemIndex<1) and (Key = VK_UP) then
  begin
    TListBox(Sender).ItemIndex := -1;
    TListBox(Sender).Selected[0] := False;
    vEdt.SetFocus;
  end;
end;

procedure TFra_MachineManage.lb_TempKeyUp(Sender: TObject; var Key: Word;
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
          end;
      else
        vEdt.Text := str;
      end;
    end;
    vEdt.SetFocus;
  end;
end;

procedure TFra_MachineManage.lb_TempMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  str: string;
  n: Integer;
begin
  lb_Temp.Visible := False;
  if lb_Temp.ItemIndex >= 0 then
  begin
    str := lb_Temp.Items.Strings[lb_Temp.ItemIndex];
    n := lb_Temp.ItemIndex;
    case lb_Temp.Tag of
      c_LB_Tag_Many:
        begin
          edt_clbh.Text :=  MatlInfo[n].m_sCLBH;
          edt_clmc.Text :=  MatlInfo[n].m_sCLMC;
          edt_clgg.Text :=  MatlInfo[n].m_sCLGG;
        end;
    else
      vEdt.Text := str;
    end;
  end;
  vEdt.SetFocus;
end;

procedure TFra_MachineManage.lb_TempMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  str: string;
  p: TPoint;
//  frame, caption: integer;
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

procedure TFra_MachineManage.gb_scclMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lb_Temp.Hide;
end;

end.
