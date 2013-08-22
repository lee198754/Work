unit uFraParamSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Menus, StdCtrls, ButtonEdit, ComCtrls, RzTreeVw, RzButton,uDM_DataBase,
  ADODB, ExtCtrls, RzPanel, RzRadChk;

type
  TFra_ParamSet = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    btn_ParamAdd: TRzButton;
    tv_ParamList: TRzTreeView;
    edt_Param: Ti_TxtFilter;
    btn_ClassAdd: TRzButton;
    edt_Class: Ti_TxtFilter;
    pm_ParamList: TPopupMenu;
    menu_Del: TMenuItem;
    RzGroupBox2: TRzGroupBox;
    Label1: TLabel;
    edt_sczq: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edt_tqts: TEdit;
    Label4: TLabel;
    btn_sczq: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edt_xqlsczq: TEdit;
    edt_xqltqts: TEdit;
    btn_xqlsczq: TButton;
    RzGroupBox3: TRzGroupBox;
    cb_rjhdpp: TRzCheckBox;
    btn_rjhdpp: TButton;
    RzGroupBox4: TRzGroupBox;
    rb_fkslpp: TRzCheckBox;
    btn_fkslpp: TButton;
    procedure btn_ParamAddClick(Sender: TObject);
    procedure menu_DelClick(Sender: TObject);
    procedure tv_ParamListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_ClassAddClick(Sender: TObject);
    procedure btn_sczqClick(Sender: TObject);
    procedure btn_xqlsczqClick(Sender: TObject);
    procedure btn_rjhdppClick(Sender: TObject);
    procedure btn_fkslppClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshTv;
    procedure RefreshOption;
    procedure FraShow;
  end;

implementation

uses
  uPub_Type,PubStr, uPub_Func, uPub_Text;

{$R *.dfm}

type
  TData = record      //树节点的数据
    m_iID: integer; //参数ID
    m_iType: Integer;  //类型ID
    m_sClassName: string;  //类型名
  end;
  TPData = ^TData;

{ TFra_ParamSet }

procedure TFra_ParamSet.RefreshTv;
var
  sName,sParam1: string;
  Node: TTreeNode;
  Nodes: TTreeNodes;
  pData: TPData;
  i, iID, iType: Integer;
  sSqlData: string;
  ADO_Rec: TADOQuery;
begin
  if LoginData.m_iUserType = 10 then
  begin
    edt_Class.Visible := True;
    btn_ClassAdd.Visible := True;
  end else
  begin
    edt_Class.Visible := False;
    btn_ClassAdd.Visible := False;
  end;

  sSqlData := 'select * from Set_ParamList where F_iType > 0 order by F_iType';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount>0) then
  begin
    with ADO_Rec do
    begin
      tv_ParamList.Items.Clear;
      Nodes := tv_ParamList.Items;
      First;
      while not Eof do
      begin
        sParam1 := FieldByName('F_sParam1').AsString;
        sName := FieldByName('F_sName').AsString;
        if sParam1 = '' then
        begin
          Node := Nodes.Add(nil,sName);
          New(pData);
          pData.m_iID := FieldByName('F_iID').AsInteger;
          pData.m_iType := FieldByName('F_iType').AsInteger;
          pData.m_sClassName := FieldByName('F_sName').AsString;
          Node.Data := pData;
        end;
        Next;
      end;
      First;
      while not Eof do
      begin
        sParam1 := FieldByName('F_sParam1').AsString;
        if sParam1 <> '' then
        begin
          iID := FieldByName('F_iID').AsInteger;
          iType := FieldByName('F_iType').AsInteger;
          for i := 0 to Nodes.Count -1 do
          begin
            Node := Nodes.Item[i];
            pData := Node.Data;
            if pData.m_iType = iType then
            begin
              Node := Nodes.AddChild(Node,sParam1);
              New(pData);
              pData.m_iID := iID;
              pData.m_iType := iType;
              pData.m_sClassName := Node.Text;
              Node.Data := pData;
              Break;
            end;
          end;
        end;
        Next;
      end;
    end;
    ADO_Rec.Free;
  end;
end;

procedure TFra_ParamSet.btn_ParamAddClick(Sender: TObject);
var
  Nodes: TTreeNodes;
  Node: TTreeNode;
  sClassName,Param1: string;
  i, iType, iID: Integer;
  pParentData,pData: TPData;
  SqlData: string;
  ADO_Rec: TADOQuery;
begin
  if tv_ParamList.SelectionCount = 0 then     {如果无选择}
  begin
    Application.MessageBox('请选择类型!','提示',MB_ICONINFORMATION);
    Exit;
  end;
  if Assigned(tv_ParamList.Selected.Parent) then Exit;
  if Trim(edt_Param.Text) = '' then Exit;
  pParentData := tv_ParamList.Selected.Data;
  iType := pParentData.m_iType;
  sClassName := pParentData.m_sClassName;
  Param1 :=  edt_Param.Text;
  SqlData := 'Select * from Set_ParamList where 1=2';
  ADO_Rec := DM_DataBase.OpenQuery(SqlData,[]);
  with ADO_Rec do
  begin
    Insert;
    FieldByName('F_iType').AsInteger := iType;
    FieldByName('F_sName').AsString := sClassName;
    FieldByName('F_sParam1').AsString := Param1;
    Post;
    iID := FieldByName('F_iID').AsInteger;
  end;

  Nodes := tv_ParamList.Items;
  Node := Nodes.AddChild(tv_ParamList.Selected,edt_Param.Text);  //创建子节点
  New(pData);
  pData.m_iID := iID;
  pData.m_iType := iType;
  pData.m_sClassName := sClassName;
  Node.Data := pData;
  edt_Param.Text := '';
  edt_Param.SetFocus;
end;

procedure TFra_ParamSet.menu_DelClick(Sender: TObject);
var
  ParentNode, Node: TTreeNode;
  i: Integer;
  Param1: string;
  SqlData: string;
  pData: TPData;
begin
  if tv_ParamList.SelectionCount = 0 then Exit; {如果无选择}
  Node := tv_ParamList.Selected;
  ParentNode := Node.Parent;
//  if not Assigned(ParentNode) then Exit;
  if Application.MessageBox(PChar('是否删除 '+tv_ParamList.Selected.Text+' ?'),'提示',MB_YESNO) = IDNO then
    Exit;
  if  not tv_ParamList.Selected.HasChildren then
  begin
    pData := Node.Data;
    SqlData := 'Delete Set_ParamList where F_iID='+IntToStr(pData.m_iID);
    with DM_DataBase.ADO_DataRec do
    begin
      Close;
      SQL.Text := Sqldata;
      ExecSQL;
    end;
    tv_ParamList.Selected.Delete;
  end;

end;

procedure TFra_ParamSet.tv_ParamListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Point: TPoint;
begin
  if Button = mbRight then
  begin
    if TTreeView(Sender).GetNodeAt(X,Y) <> nil then
    begin
      TTreeView(Sender).SetFocus;
      TTreeView(Sender).Select(TTreeView(Sender).GetNodeAt(X,Y));
      if TTreeView(Sender).SelectionCount = 0 then Exit; {如果无选择}
      if not Assigned(TTreeView(Sender).Selected.Parent) and TTreeView(Sender).Selected.HasChildren then Exit;

      GetCursorPos(Point);
      pm_ParamList.Popup(Point.X, Point.Y);
    end;
  end;
end;

procedure TFra_ParamSet.btn_ClassAddClick(Sender: TObject);
var
  Nodes: TTreeNodes;
  Node: TTreeNode;
  MaxTypeID, iID: integer;
  SqlData,sClassName: string;
  pData: TPData;
  ADO_Rec: TADOQuery;
begin
  if Trim(edt_Class.Text) = '' then Exit;
  MaxTypeID := DM_DataBase.GetMaxID('select Max(F_iType) from Set_ParamList') +1;
  sClassName := edt_Class.Text;
  SqlData := 'Select * from Set_ParamList where 1=2';
  ADO_Rec := DM_DataBase.OpenQuery(SqlData,[]);
  with ADO_Rec do
  begin
    Insert;
    FieldByName('F_iType').AsInteger := MaxTypeID;
    FieldByName('F_sName').AsString := sClassName;
    Post;
    iID := FieldByName('F_iID').AsInteger;
  end;

  Nodes := tv_ParamList.Items;
  Node := Nodes.add(nil,sClassName);
  New(pData);
  pData.m_iID := iID;
  pData.m_iType := MaxTypeID;
  pData.m_sClassName := sClassName;
  Node.Data := pData;
  edt_Class.Text := '';
end;

procedure TFra_ParamSet.FraShow;
begin
  RefreshTv;
  RefreshOption;
end;

procedure TFra_ParamSet.btn_sczqClick(Sender: TObject);
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
begin
  if (edt_sczq.Text = '') or (edt_tqts.Text = '') then
  begin
    p_MessageBoxDlg('请完整输入数据!');
    Exit;
  end;
  sSqlData := 'select * from Set_ParamList where F_sName = ''生产周期设置'' ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
  if not Assigned(ADO_Rec) then Exit;
  if ADO_Rec.RecordCount = 0 then
  begin
    ADO_Rec.Insert;
    ADO_Rec.FieldByName('F_iType').AsInteger := 0;
    ADO_Rec.FieldByName('F_sName').AsString := '生产周期设置';
  end else
    ADO_Rec.Edit;
  ADO_Rec.FieldByName('F_sParam1').AsInteger := StrToNum(edt_sczq.Text);
  ADO_Rec.FieldByName('F_sParam2').AsInteger := StrToNum(edt_tqts.Text);
  ADO_Rec.Post;
  p_MessageBoxDlg('保存成功!')
end;

procedure TFra_ParamSet.RefreshOption;
var
  sName,sParam1,sParam2: string;
  iType: Integer;
  sSqlData: string;
  ADO_Rec: TADOQuery;
begin
  sSqlData := 'select * from Set_ParamList where F_iType = 0 and F_sName in (''%s'',''%s'',''%s'',''%s'') order by F_iType';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,['生产周期设置','小批量生产周期设置',c_XQRJHDPP,c_FHFKRJHDPP]);
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount>0) then
  begin
    while not ADO_Rec.Eof do
    begin
      sParam1 := ADO_Rec.FieldByName('F_sParam1').AsString;
      sParam2 := ADO_Rec.FieldByName('F_sParam2').AsString;
      sName := ADO_Rec.FieldByName('F_sName').AsString;
      if sName = '生产周期设置' then
      begin
        edt_sczq.Text := StrToNum(sParam1);
        edt_tqts.Text := StrToNum(sParam2);
      end else
      if sName = '小批量生产周期设置' then
      begin
        edt_xqlsczq.Text := StrToNum(sParam1);
        edt_xqltqts.Text := StrToNum(sParam2);
      end else
      if sName = c_XQRJHDPP then
      begin
        case StrToNum(sParam1) of
          0: cb_rjhdpp.Checked := False;
          1: cb_rjhdpp.Checked := True;
        else
          cb_rjhdpp.Checked := True;
        end;
      end else
      if sName = c_FHFKRJHDPP then
      begin
        case StrToNum(sParam1) of
          0: rb_fkslpp.Checked := False;
          1: rb_fkslpp.Checked := True;
        else
          rb_fkslpp.Checked := True;
        end;
      end;
      ADO_Rec.Next;
    end;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

end;

procedure TFra_ParamSet.btn_xqlsczqClick(Sender: TObject);
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
begin
  if (edt_xqlsczq.Text = '') or (edt_xqltqts.Text = '') then
  begin
    p_MessageBoxDlg('请完整输入数据!');
    Exit;
  end;
  sSqlData := 'select * from Set_ParamList where F_sName = ''小批量生产周期设置'' ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
  if not Assigned(ADO_Rec) then Exit;
  if ADO_Rec.RecordCount = 0 then
  begin
    ADO_Rec.Insert;
    ADO_Rec.FieldByName('F_iType').AsInteger := 0;
    ADO_Rec.FieldByName('F_sName').AsString := '小批量生产周期设置';
  end else
    ADO_Rec.Edit;
  ADO_Rec.FieldByName('F_sParam1').AsInteger := StrToNum(edt_xqlsczq.Text);
  ADO_Rec.FieldByName('F_sParam2').AsInteger := StrToNum(edt_xqltqts.Text);
  ADO_Rec.Post;
  p_MessageBoxDlg('保存成功!')
end;

procedure TFra_ParamSet.btn_rjhdppClick(Sender: TObject);
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
begin
  sSqlData := 'select * from Set_ParamList where F_sName = ''%s'' ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[c_XQRJHDPP]);
  if not Assigned(ADO_Rec) then Exit;
  if ADO_Rec.RecordCount = 0 then
  begin
    ADO_Rec.Insert;
    ADO_Rec.FieldByName('F_iType').AsInteger := 0;
    ADO_Rec.FieldByName('F_sName').AsString  := c_XQRJHDPP;
  end else
    ADO_Rec.Edit;
  ADO_Rec.FieldByName('F_sParam1').AsInteger := iif(cb_rjhdpp.Checked,1,0);
  ADO_Rec.Post;
  p_MessageBoxDlg('保存成功!')
end;

procedure TFra_ParamSet.btn_fkslppClick(Sender: TObject);
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
begin
  sSqlData := 'select * from Set_ParamList where F_sName = ''%s'' ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[c_FHFKRJHDPP]);
  if not Assigned(ADO_Rec) then Exit;
  if ADO_Rec.RecordCount = 0 then
  begin
    ADO_Rec.Insert;
    ADO_Rec.FieldByName('F_iType').AsInteger := 0;
    ADO_Rec.FieldByName('F_sName').AsString  := c_FHFKRJHDPP;
  end else
    ADO_Rec.Edit;
  ADO_Rec.FieldByName('F_sParam1').AsInteger := iif(rb_fkslpp.Checked,1,0);
  ADO_Rec.Post;
  p_MessageBoxDlg('保存成功!')
end;

end.

