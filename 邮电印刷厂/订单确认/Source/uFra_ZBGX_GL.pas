unit uFra_ZBGX_GL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, RzButton, StdCtrls, ButtonEdit, Grids, iGrid, ExtCtrls, RzPanel,
  iComboBox,ADODB;

type
  TFra_ZBGX_GL = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    stg_gxxx: Ti_StgEdit;
    RzGroupBox2: TRzGroupBox;
    edt_gxbh: Ti_TxtFilter;
    edt_gxmc: Ti_TxtFilter;
    btn_add: TRzButton;
    btn_mod: TRzButton;
    edt_cl: Ti_TxtFilter;
    edt_lbgg: Ti_TxtFilter;
    cbb_dw: TComboBox;
    Label1: TLabel;
    procedure stg_gxxxSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btn_addClick(Sender: TObject);
    procedure btn_modClick(Sender: TObject);
    procedure edt_clExit(Sender: TObject);
    procedure stg_gxxxLinkClick(Sender: TObject; ACol, ARow: Integer);
  private
    { Private declarations }
    stgSeletedID: Integer;
    function p_LoadWorkProcManage: Boolean;
    function IsEmpty: Boolean;
    procedure ClearText;

  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

uses
  uDM_DataBase, PubStr, uPub_Func;

{$R *.dfm}

const
  c_GXBH   = 0;
  c_GXMC   = 1;
  c_LBGG   = 2;
  c_CL     = 3;
  c_DW     = 4;
  c_CZ     = 5;
  c_GXID   = 6;

procedure TFra_ZBGX_GL.FraShow;
begin
  stg_gxxx.ColWidths[c_GXID] := 0;
  p_LoadWorkProcManage;
end;

function TFra_ZBGX_GL.p_LoadWorkProcManage;
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
  n: Integer;
begin
  Result := False;
  sSqlData := 'Select * from BI_WorkProcManage order by F_sName,F_iID desc';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[],False);
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    stg_gxxx.Clear;
    stg_gxxx.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
    n := 1;
    with ADO_Rec do
    begin
      while not Eof do
      begin
        stg_gxxx.Cells[c_GXBH,n] := FieldByName('F_sCode').AsString;
        stg_gxxx.Cells[c_GXMC,n] := FieldByName('F_sName').AsString;
        stg_gxxx.Cells[c_LBGG,n] := FieldByName('F_sCategorySpec').AsString;
        stg_gxxx.Cells[c_CL,n] := FieldByName('F_sOutput').AsString;
        stg_gxxx.Cells[c_DW,n] := FieldByName('F_sUnit').AsString;
        stg_gxxx.Cells[c_CZ,n] := '删除';
        stg_gxxx.CellsLink[c_CZ,n] := '删除';
        stg_gxxx.Cells[c_GXID,n] := FieldByName('F_iID').AsString;
        inc(n);
        Next;
      end;
    end;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

  Result := True;;
end;

procedure TFra_ZBGX_GL.stg_gxxxSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  edt_gxbh.Text :=  stg_gxxx.Cells[c_GXBH,ARow];
  edt_gxmc.Text :=  stg_gxxx.Cells[c_GXMC,ARow];
  edt_lbgg.Text :=  stg_gxxx.Cells[c_LBGG,ARow];
  edt_cl.Text :=  stg_gxxx.Cells[c_CL,ARow];
  cbb_dw.ItemIndex := cbb_dw.Items.IndexOf(stg_gxxx.Cells[c_DW,ARow]);
  stgSeletedID := StrToNum(stg_gxxx.cells[c_GXID ,ARow]);

end;

procedure TFra_ZBGX_GL.btn_addClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData, str: string;
begin
  if IsEmpty then Exit;
  try
    sSqlData := 'Select * from BI_WorkProcManage where F_sCode=''%s'' or F_sName=''%s'' ';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[edt_gxbh.Text,edt_gxmc.Text],True);
    if ADO_rec.RecordCount > 0 then
    begin
      str := '';
      if edt_gxbh.Text =  ADO_rec.FieldByName('F_sCode').AsString then
        str := str+',工序编号';
      if edt_gxmc.Text =  ADO_rec.FieldByName('F_sName').AsString then
        str := str+',工序名称';
      str := Copy(str,2,Length(str));
      Application.MessageBox(PChar(str+'已存在,请重新输入!'),'提示',MB_ICONINFORMATION);
      ADO_Rec.Free;
      Exit;
    end;
    with ADO_Rec do
    begin
      Insert;
      FieldByName('F_sCode').AsString := edt_gxbh.Text;
      FieldByName('F_sName').AsString := edt_gxmc.Text;
      FieldByName('F_sCategorySpec').AsString := edt_lbgg.Text;
      FieldByName('F_sOutput').AsFloat := StrToFloat(edt_cl.Text);
      FieldByName('F_sUnit').AsString := cbb_dw.Text;
      Post;
    end;
    p_MessageBoxDlg('添加成功!');
    ClearText;
    p_LoadWorkProcManage;
    edt_gxbh.SetFocus;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(e.Message),'提示',MB_ICONINFORMATION);
      Exit;
    end;
  end;
end;

procedure TFra_ZBGX_GL.ClearText;
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

function TFra_ZBGX_GL.IsEmpty: Boolean;
var
  i: Integer;
  comp: TComponent;
begin
  Result := False;
  for i := 0 to Self.ComponentCount -1 do
  begin
    comp := Self.Components[i];
    if  comp.Tag <> 10 then
    begin
      if comp is Ti_TxtFilter  then
      begin
        if Ti_TxtFilter(comp).Text = '' then
        begin
          Application.MessageBox(PChar('请输入 '+StrReplace(Ti_TxtFilter(comp).LabelCaption,'：',' ')+'!'),'提示',MB_ICONINFORMATION);
          Ti_TxtFilter(comp).SetFocus;
          Result := True;
          Exit;
        end;
      end else
      if comp is Ti_ComboBox then
      begin
        if Ti_ComboBox(comp).Text = '' then
        begin
          Application.MessageBox(PChar('请输入 '+StrReplace(Ti_ComboBox(comp).LabelCaption,'：',' ')+'!'),'提示',MB_ICONINFORMATION);
          Ti_TxtFilter(comp).SetFocus;
          Result := True;
          Exit;
        end;
      end;
    end;
  end;
  if cbb_dw.Text = '' then
  begin
    Application.MessageBox(PChar('请输入 单位 !'),'提示',MB_ICONINFORMATION);
    cbb_dw.SetFocus;
    Result := True;
    Exit;
  end;
end;

procedure TFra_ZBGX_GL.btn_modClick(Sender: TObject);
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
    sSqlData := 'Select * from BI_WorkProcManage where F_iID=%d ';
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
      FieldByName('F_sCode').AsString := edt_gxbh.Text;
      FieldByName('F_sName').AsString := edt_gxmc.Text;
      FieldByName('F_sCategorySpec').AsString := edt_lbgg.Text;
      FieldByName('F_sOutput').AsFloat := StrToFloat(edt_cl.Text);
      FieldByName('F_sUnit').AsString := cbb_dw.Text;
      Post;
    end;
    p_MessageBoxDlg('修改成功!');
    ClearText;
    p_LoadWorkProcManage;
  except
    on E: Exception do      
    begin
      Application.MessageBox(PChar('修改失败：'+E.Message),'提示',MB_ICONINFORMATION);
      Exit;
    end;
  end;
  ADO_Rec.Free;
end;

procedure TFra_ZBGX_GL.edt_clExit(Sender: TObject);
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

procedure TFra_ZBGX_GL.stg_gxxxLinkClick(Sender: TObject; ACol,
  ARow: Integer);
var
  sSqlData: string;
  PStr: PChar;
  iID: integer;
begin
  iID := StrToNum(stg_gxxx.Cells[c_GXID,ARow]);
  if iID = 0 then Exit;
  if ACol = c_CZ then
  begin
    PStr := PChar('是否要删除:'+#13#10+'工序编号：'+ stg_gxxx.Cells[c_GXBH,ARow] +#13#10+
      '工序名称：'+ stg_gxxx.Cells[c_GXMC,ARow] +#13#10+'类别规格：'+ stg_gxxx.Cells[c_LBGG,ARow]);
    if Application.MessageBox(PStr,'提示',MB_YESNO +MB_ICONINFORMATION)= IDNO then Exit;
    sSqlData := 'Delete BI_WorkProcManage where F_iID=%d';
    try
      DM_DataBase.ExecQuery(sSqlData,[iID],True);
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

end.
