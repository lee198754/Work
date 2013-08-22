unit uFra_MatlManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, RzButton, StdCtrls, ButtonEdit, Grids, iGrid, ExtCtrls, RzPanel,
  ADODB, iComboBox;

type
  TFra_MatlManage = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    RzGroupBox2: TRzGroupBox;
    edt_clbh: Ti_TxtFilter;
    edt_clmc: Ti_TxtFilter;
    stg_clxx: Ti_StgEdit;
    edt_clgg: Ti_TxtFilter;
    btn_add: TRzButton;
    btn_mod: TRzButton;
    edt_cjgg: Ti_TxtFilter;
    edt_sjjg: Ti_TxtFilter;
    edt_jhjg: Ti_TxtFilter;
    edt_dw: Ti_TxtFilter;
    procedure stg_clxxLinkClick(Sender: TObject; ACol, ARow: Integer);
    procedure stg_clxxSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_ModClick(Sender: TObject);
    procedure edt_sjjgExit(Sender: TObject);
  private
    { Private declarations }
    stgSeletedID: integer;
    procedure LoadCLXX;
    function IsEmpty: Boolean;
    procedure ClearText;
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

uses
  PubStr, uDM_DataBase, uPub_Func;

{$R *.dfm}

const
  c_CLBH     = 0;   //材料编号
  c_CLMC     = 1;   //材料名称
  c_CLGG     = 2;   //材料规格
  c_CJGG     = 3;   //裁剪规格
  c_SJJG     = 4;   //实际价格
  c_JHJG     = 5;   //计划价格
  c_DW       = 6;   //单位
  c_CZ       = 7;   //操作
  c_MatlID   = 8;   //材料ID

procedure TFra_MatlManage.FraShow;
begin
  stg_clxx.ColWidths[c_MatlID] := 0;
  LoadCLXX;
end;

procedure TFra_MatlManage.LoadCLXX;
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
  n: integer;
begin
  try
    sSqlData := 'Select * from BI_MatlManage';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[],True);
    stg_clxx.Clear;
    stg_clxx.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
    if ADO_Rec.RecordCount > 0 then
    begin
      n := 1;
      with ADO_Rec do
      begin
        while not Eof do
        begin
          stg_clxx.Cells[c_CLBH,n] := FieldByName('F_sCLBH').AsString;
          stg_clxx.Cells[c_CLMC,n] := FieldByName('F_sCLMC').AsString;
          stg_clxx.Cells[c_CLGG,n] := FieldByName('F_sCLGG').AsString;
          stg_clxx.Cells[c_CJGG,n] := FieldByName('F_sCJGG').AsString;
          stg_clxx.Cells[c_SJJG,n] := FieldByName('F_nSJJG').AsString;
          stg_clxx.Cells[c_JHJG,n] := FieldByName('F_nJHJG').AsString;
          stg_clxx.Cells[c_DW,n]   := FieldByName('F_sDW').AsString;
          stg_clxx.Cells[c_CZ,n]   := '删除';
          stg_clxx.CellsLink[c_CZ,n] := '删除';
          stg_clxx.Cells[c_MatlID,n] := FieldByName('F_iID').AsString;
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

procedure TFra_MatlManage.stg_clxxLinkClick(Sender: TObject; ACol,
  ARow: Integer);
var
  sSqlData: string;
  iID: integer;
begin
  iID := StrToNum(stg_clxx.Cells[c_MatlID,ARow]);
  if iID = 0 then Exit;
  if ACol = c_CZ then
  begin
    if Application.MessageBox(PChar('是否删除材料 "'+stg_clxx.Cells[c_CLMC,ARow]+'" ?'),'提示',MB_YESNO +MB_ICONINFORMATION)= IDNO then Exit;
    sSqlData := 'Delete BI_MatlManage where F_iID=%d';
    try
      DM_DataBase.ExecQuery(sSqlData,[iID],True);
      stg_clxx.p_Delrow(ARow);
      p_MessageBoxDlg('删除成功!');
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar('删除失败:'+E.message),'提示',MB_ICONINFORMATION);
      end;
    end;                
  end;
end;

procedure TFra_MatlManage.stg_clxxSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  edt_clbh.Text := stg_clxx.cells[c_CLBH ,ARow];
  edt_clmc.Text := stg_clxx.cells[c_CLMC ,ARow];
  edt_clgg.Text := stg_clxx.cells[c_CLGG ,ARow];
  edt_cjgg.Text := stg_clxx.cells[c_CJGG ,ARow];
  edt_sjjg.Text := stg_clxx.cells[c_SJJG ,ARow];
  edt_jhjg.Text := stg_clxx.cells[c_JHJG ,ARow];
  edt_dw.Text   := stg_clxx.cells[c_DW ,ARow];
  stgSeletedID := StrToNum(stg_clxx.cells[c_MatlID ,ARow]);

end;

procedure TFra_MatlManage.btn_AddClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData, str: string;
begin
  if IsEmpty then Exit;
  try
    sSqlData := 'Select * from BI_MatlManage where F_sCLBH=''%s'' or F_sCLMC=''%s'' ';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[edt_clbh.Text,edt_clmc.Text],True);
    if ADO_rec.RecordCount > 0 then
    begin
      str := '';
      if edt_clbh.Text =  ADO_rec.FieldByName('F_sCLBH').AsString then
        str := str+',材料编号';
      if edt_clmc.Text =  ADO_rec.FieldByName('F_sCLMC').AsString then
        str := str+',材料名称';
      str := Copy(str,2,Length(str));
      Application.MessageBox(PChar(str+'存在'),'提示',MB_ICONINFORMATION);
      ADO_Rec.Free;
      Exit;
    end;
    with ADO_Rec do
    begin
      Insert;
      FieldByName('F_sCLBH').AsString := edt_clbh.Text;
      FieldByName('F_sCLMC').AsString := edt_clmc.Text;
      FieldByName('F_sCLGG').AsString := edt_clgg.Text;
      FieldByName('F_sCJGG').AsString := edt_cjgg.Text;
      FieldByName('F_nSJJG').AsFloat  := StrToFloatDef(edt_sjjg.Text,0.000);
      FieldByName('F_nJHJG').AsFloat  := StrToFloatDef(edt_jhjg.Text,0.000);
      FieldByName('F_sDW').AsString   := edt_dw.Text;
      Post;
    end;
    p_MessageBoxDlg('添加成功!');
    ClearText;
    LoadCLXX;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(e.Message),'提示',MB_ICONINFORMATION);
      Exit;
    end;
  end;
end;

function TFra_MatlManage.IsEmpty: Boolean;
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
          Application.MessageBox(PChar('请输入 '+Ti_TxtFilter(comp).LabelCaption+'!'),'提示',MB_ICONINFORMATION);
          Ti_TxtFilter(comp).SetFocus;
          Result := True;
          Exit;
        end;
      end;        
    end;
  end;
end;

procedure TFra_MatlManage.ClearText;
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

procedure TFra_MatlManage.btn_ModClick(Sender: TObject);
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
begin
  if stgSeletedID =0 then
  begin
    Application.MessageBox('请选择要修改的数据!','提示',MB_ICONINFORMATION);
    Exit;
  end;
  try
    sSqlData := 'Select * from BI_MatlManage where F_iID=%d ';
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
      FieldByName('F_sCLBH').AsString := edt_clbh.Text;
      FieldByName('F_sCLMC').AsString := edt_clmc.Text;
      FieldByName('F_sCLGG').AsString := edt_clgg.Text;
      FieldByName('F_sCJGG').AsString := edt_cjgg.Text;
      FieldByName('F_nSJJG').AsFloat  := StrToFloatDef(edt_sjjg.Text,0.000);
      FieldByName('F_nJHJG').AsFloat  := StrToFloatDef(edt_jhjg.Text,0.000);
      FieldByName('F_sDW').AsString   := edt_dw.Text;
      Post;
    end;
    p_MessageBoxDlg('修改成功!');
    ClearText;
    LoadCLXX;
  except
    on E: Exception do      
    begin
      Application.MessageBox(PChar('修改失败：'+E.Message),'提示',MB_ICONINFORMATION);
      Exit;
    end;
  end;
  ADO_Rec.Free;
end;

procedure TFra_MatlManage.edt_sjjgExit(Sender: TObject);
begin
  if (Trim(Ti_TxtFilter(Sender).Text) <> '') and (StrToFloatDef(Ti_TxtFilter(Sender).Text,-1.000) = -1.000) then
  begin
    p_MessageBoxDlg('输入有误,请输入数字!');
    Ti_TxtFilter(Sender).SetFocus;
    Exit;
  end;
  Ti_TxtFilter(Sender).Text := FloatToStr(StrToFloatDef(Ti_TxtFilter(Sender).Text,0.000));
end;

end.
