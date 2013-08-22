unit uFraUserAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, RzButton, StdCtrls, RzCmboBx, iComboBox, ButtonEdit, uDM_DataBase,
  ADODB, ComCtrls, ExtCtrls, RzPanel, Menus, RzListVw,
  Grids, iGrid;

const
//  c_gh=0;   //工号
  c_yhm=0;  //用户名
  c_zsxm=1;  //真实姓名
  c_qx=2;   //权限
  c_sq=3;   //授权
  c_yx=4;    // 允许
  c_sc=5;   //删除
  c_F_iID=6; //用户ID
  c_code_Admin = 24395774;
  c_Code_User = 24395774;
type
  TFra_UserAdd = class(TFrame)
    pan_UserAdd: TRzPanel;
    edt_UserName: Ti_TxtFilter;
    edt_Pwd: Ti_TxtFilter;
    cbb_Type: Ti_ComboBox;
    edt_JobNum: Ti_TxtFilter;
    btn_add: TRzButton;
    RzGroupBox1: TRzGroupBox;
    stg_UserList: Ti_StgEdit;
    btn_mod: TRzButton;
    btn_del: TRzButton;
    edt_RealName: Ti_TxtFilter;
    gb_cx: TRzGroupBox;
    btn_cx: TRzButton;
    cb_Type: Ti_ComboBox;
    edt_Content: Ti_TxtFilter;
    btn_cz: TRzButton;
    cbb_UserType: Ti_ComboBox;
    procedure btn_addClick(Sender: TObject);
    procedure lv_UserListCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lv_UserListColumnClick(Sender: TObject; Column: TListColumn);
    procedure stg_UserListLinkClick(Sender: TObject; ACol, ARow: Integer);
    procedure stg_UserListSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btn_modClick(Sender: TObject);
    procedure btn_delClick(Sender: TObject);
    procedure btn_cxClick(Sender: TObject);
    procedure btn_czClick(Sender: TObject);
    procedure cb_TypeChange(Sender: TObject);
  private
    { Private declarations }
    stgSeletedID : Integer;
    function IsEmpty: Boolean;     //判断是否数据都有输入
    procedure ReadDataUserList(ADO_Data: TADOQuery);
    procedure InitUserList;       //初始化列表
    procedure SetOperatingAuthorization;   //设置操作权限
    //function StrMD5(CheckStr:string):String;
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

{$R *.dfm}
uses
  PubStr, uPub_Type, uPub_Func, uUser_License, uUser_Allow, uPub_Text;


function TFra_UserAdd.IsEmpty: Boolean;
var
  i: Integer;
  comp: TComponent;
begin
  Result := False;
  for i := 0 to pan_UserAdd.ComponentCount -1 do
  begin
    comp := pan_UserAdd.Components[i];
    if  comp.Tag <> 10 then
    begin
      if (comp is Ti_TxtFilter) then
      begin
        if Ti_TxtFilter(comp).Text = '' then
        begin
          Application.MessageBox(PChar('请输入 '+StrReplace(Ti_TxtFilter(comp).LabelCaption,'：',' ')+'!'),'提示',MB_ICONINFORMATION);
          Ti_TxtFilter(comp).SetFocus;
          Result := True;
          Exit;
        end;
      end;
      if (comp is Ti_ComboBox) then
      begin
        if Ti_ComboBox(comp).ItemIndex <= 0 then
        begin
          Application.MessageBox(PChar('请选择 '+StrReplace(Ti_ComboBox(comp).LabelCaption,'：',' ')+'!'),'提示',MB_ICONINFORMATION);
          Ti_TxtFilter(comp).SetFocus;
          Result := True;
          Exit;
        end;
      end;
    end;
  end;
end;



procedure TFra_UserAdd.btn_addClick(Sender: TObject);
const
  c_User = 1;
  c_Admin = 2;
  c_SuperAdmin = 3;
  c_User_Small = 4;
  c_Admin_Small = 5;
var
  ADO_rec: TADOQuery;
  iType,iXH: integer;
  iLicenseCode: LONGLONG;
  str: string;
begin
  if IsEmpty then Exit;
  if edt_Pwd.Text = '******'  then
  begin
    edt_Pwd.Text := '';
    Application.MessageBox('请输入密码！','提示',MB_ICONINFORMATION);
    Exit
  end;
  try
    ADO_rec := TADOQuery.Create(Self);
    DM_DataBase.GetTableData(ADO_rec,'BI_UserList','F_sName='''+edt_UserName.Text+''' order by F_iID');
    if ADO_rec.RecordCount > 0 then
    begin
      if edt_UserName.Text =  ADO_rec.FieldByName('F_sName').AsString then
        str := ',用户名';
//      if edt_JobNum.Text =  ADO_rec.FieldByName('F_sJobNum').AsString then
//        str := ',工号';
//      if edt_RealName.Text =  ADO_rec.FieldByName('F_sRealName').AsString then
//       str := ',真实姓名';
      str := Copy(str,2,Length(str));
      Application.MessageBox(PChar(str+'存在'),'提示',MB_ICONINFORMATION);
      Exit;
    end;
    iXH := cbb_Type.ItemIndex;
    if LoginData.m_iUserType = 6 then
    begin
     case cbb_Type.ItemIndex of
       1 : iXH := c_User_Small;
       2 : iXH := c_Admin_Small;
     end;
    end;
    case iXH of
      c_User:
      begin
        iType:=0;
        iLicenseCode := c_Code_User;
      end;
      c_Admin:
      begin
        iType:=1;
        iLicenseCode := c_code_Admin;
      end;
      c_SuperAdmin:
      begin
        iType:=10;
        iLicenseCode := c_code_Admin;
      end;
      c_User_Small:
      begin
        iType:=5;
        iLicenseCode := c_Code_User;
      end;
      c_Admin_Small:
      begin
        iType:=6;
        iLicenseCode := c_code_Admin;
      end;
    else
      iType := -1;
      iLicenseCode := c_Code_User;
    end;
    DM_DataBase.GetTableData(ADO_rec,'BI_UserList','1=2');
    with ADO_rec do
    begin
      Insert;
      FieldByName('F_sName').AsString := edt_UserName.Text;
      FieldByName('F_sPwd').AsString := StrMD5(edt_Pwd.Text);
//      FieldByName('F_sJobNum').AsString := edt_JobNum.Text;
      FieldByName('F_sRealName').AsString := edt_RealName.Text;
      FieldByName('F_iType').AsInteger := iType;
      FieldByName('F_iLicenseCode').AsInteger := iLicenseCode;
      Post;
    end;
    Application.MessageBox('添加成功!','提示',MB_ICONINFORMATION);
    InitUserList;
  finally
    ADO_rec.Free;
  end;
end;

procedure TFra_UserAdd.lv_UserListCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if (Item.Index mod 2) = 0 then
    Sender.Canvas.Brush.Color := $00F0FFF0
  else
    Sender.Canvas.Brush.Color := $00F2F2F2;
  LVDrawItem(TRzListView(Sender), Item, State, DefaultDraw);
end;

procedure TFra_UserAdd.lv_UserListColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  TRzListView(Sender).CustomSort(@RzCustomSortProc,Column.Index)
end;

procedure TFra_UserAdd.stg_UserListLinkClick(Sender: TObject; ACol,
  ARow: Integer);
var
  sID, sSqlData: string;
begin
  sID := stg_UserList.Cells[c_F_iID,ARow];
  if sID = '' then Exit;
  case ACol of
    c_sq:
      begin
        Frm_User_License := TFrm_User_License.Create(Self);
        Frm_User_License.vUserID := StrToNum(sID);
        Frm_User_License.ShowModal;
        Frm_User_License.Free;
      end;
    c_yx:
      begin
        Frm_User_Allow := TFrm_User_Allow.Create(Self);
        Frm_User_Allow.vUserID := StrToNum(sID);
        Frm_User_Allow.ShowModal;
        Frm_User_Allow.Free;
      end;
    c_sc:
      begin
        if Application.MessageBox(PChar('是否删除用户 "'+stg_UserList.Cells[c_yhm,ARow]+'" ?'),'提示',MB_YESNO +MB_ICONINFORMATION)= IDNO then Exit;
        sSqlData := 'Delete BI_UserList where F_iID=%s';
        try
          DM_DataBase.ExecQuery(sSqlData,[sID],True);
          stg_UserList.p_Delrow(ARow);
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

procedure TFra_UserAdd.FraShow;
var
  i: Integer;
begin
  stg_UserList.p_SetColSortType(0,c_SetColSortType_Str );
  stg_UserList.p_SetColSortType(1,c_SetColSortType_Str );
  stg_UserList.p_SetColSortType(2,c_SetColSortType_Str );

  cbb_Type.Clear;
  cbb_Type.Add('--请选择--');
  if LoginData.m_iUserType = c_Admin_Small then
  begin
    cbb_Type.Add('普通用户(小批量)');
    cbb_Type.Add('管理员(小批量)');
  end else
  if LoginData.m_iUserType in [c_Admin,c_Admin_Small,c_SuperAdmin] then
  begin
    cbb_Type.Add('普通用户');
    cbb_Type.Add('管理员');
    cbb_Type.Add('超级管理员');
    cbb_Type.Add('普通用户(小批量)');
    cbb_Type.Add('管理员(小批量)');
  end;
  cbb_Type.ItemIndex := 0;

  cbb_UserType.Clear;
  cbb_UserType.Left := edt_Content.Left;
  cbb_UserType.Top := edt_Content.Top;
  for i := 1 to cbb_Type.Items.Count -1 do
  begin
    cbb_UserType.Add(cbb_Type.Items[i]);
  end;
  cbb_UserType.ItemIndex := 0;

  InitUserList;

end;

procedure TFra_UserAdd.stg_UserListSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  cbb_Type.ItemIndex := cbb_Type.IndexOf(stg_UserList.cells[c_qx ,ARow]);
//  edt_JobNum.Text := stg_UserList.cells[c_gh ,ARow];
  edt_RealName.Text := stg_UserList.cells[c_zsxm ,ARow];
  edt_UserName.Text := stg_UserList.cells[c_yhm ,ARow];
  edt_Pwd.Text := '******';
  stgSeletedID := StrToNum(stg_UserList.cells[c_F_iID ,ARow]);

end;

procedure TFra_UserAdd.btn_modClick(Sender: TObject);
const
  c_User = 1;
  c_Admin = 2;
  c_SuperAdmin = 3;
  c_User_Small = 4;
  c_Admin_Small = 5;
var
  ADO_Rec: TADOQuery;
  iType,iXH: integer;
  str,sPwd,sSqlData: string;
begin
  if stgSeletedID = 0 then
  begin
    Application.MessageBox('请选择要修改的用户!','提示',MB_ICONINFORMATION);
    Exit;
  end;

  if IsEmpty then Exit;
  try
    sSqlData := 'Select F_sName,F_sJobNum,F_sRealName from BI_UserList where F_sName=''%s'' and F_iID <>%d ';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[edt_UserName.Text,stgSeletedID]);
    if ADO_Rec.RecordCount > 0 then
    begin
      if edt_UserName.Text =  ADO_Rec.FieldByName('F_sName').AsString then
        str := ',用户名';
//      if edt_JobNum.Text =  ADO_rec.FieldByName('F_sJobNum').AsString then
//        str := ',工号';
//      if edt_RealName.Text =  ADO_rec.FieldByName('F_sRealName').AsString then
//        str := ',真实姓名';
      ADO_Rec.Free;
      str := Copy(str,1,Length(str));
      Application.MessageBox(PChar(str+'存在'),'提示',MB_ICONINFORMATION);
      Exit;
    end;
    if Assigned(ADO_Rec) then ADO_Rec.Free;
    sSqlData := 'Select * from BI_UserList where F_iID =%d ';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[stgSeletedID]);
    if ADO_Rec.RecordCount = 0 then
    begin
      ADO_Rec.Free;
      Application.MessageBox('数据不存在!','提示',MB_ICONINFORMATION);
      InitUserList;
      Exit;
    end;
    if Trim(edt_Pwd.Text) <> '******'  then
    begin
      sPwd := '';
      if Application.MessageBox('是否要修改密码?','提示',MB_YESNO+MB_ICONINFORMATION) = IDYES then
      begin
        if InputQueryEH('提示','确认新密码：',sPwd,1) then
        begin
          //if not (ADO_rec.FieldByName('F_sPwd').AsString = StrMD5(sPwd)) then
          if sPwd <> edt_Pwd.Text then
          begin
            Application.MessageBox('两次输入的密码不一致 ','提示',MB_ICONINFORMATION);
            Exit;
          end;
        end;
      end else
        edt_Pwd.Text := '******';
    end;

    iXH := cbb_Type.ItemIndex;
    if LoginData.m_iUserType = 6 then
    begin
     case cbb_Type.ItemIndex of
       1 : iXH := c_User_Small;
       2 : iXH := c_Admin_Small;
     end;
    end;

    case iXH of
      c_User:
      begin
        iType:=0;
      end;
      c_Admin:
      begin
        iType:=1;
      end;
      c_SuperAdmin:
      begin
        iType:=10;
      end;
      c_User_Small:
      begin
        iType:=5;
      end;
      c_Admin_Small:
      begin
        iType:=6;
      end;
    else
      iType := -1;
    end;
    with ADO_Rec do
    begin
      if FieldByName('F_sName').AsString <> edt_UserName.Text then
      begin
        p_MessageBoxDlg('不能修改用户名!');
        edt_UserName.Text := FieldByName('F_sName').AsString;
        edt_UserName.SetFocus;
        //edt_UserName.Text := FieldByName('F_sName').AsString;
        Exit;
      end;
      Edit;
      //FieldByName('F_sName').AsString := edt_UserName.Text;
      if Trim(edt_Pwd.Text) <> '******'  then
      begin
        FieldByName('F_sPwd').AsString := StrMD5(edt_Pwd.Text)
      end;
//      FieldByName('F_sJobNum').AsString := edt_JobNum.Text;
      FieldByName('F_sRealName').AsString := edt_RealName.Text;
      FieldByName('F_iType').AsInteger := iType;
      //FieldByName('F_iLicenseCode').AsInteger := iLicenseCode;
      Post;
    end;
    if Assigned(ADO_Rec) then ADO_Rec.Free;
    Application.MessageBox('修改成功!','提示',MB_ICONINFORMATION);
    InitUserList;
  finally

  end;
end;

procedure TFra_UserAdd.btn_delClick(Sender: TObject);
var
  str,sSqlData,sUserNaem,sRealName,sType: string;
begin
//  sJobNum := stg_UserList.cells[c_gh ,stg_UserList.Row];
  sRealName := stg_UserList.cells[c_zsxm ,stg_UserList.Row];
  sUserNaem := stg_UserList.cells[c_yhm ,stg_UserList.Row];
  sType := stg_UserList.cells[c_qx ,stg_UserList.Row];
//  str := '是否要删除:'+#13#10+'工号：'+sJobNum+#13#10+'用户名：'+sUserNaem +#13#10+'权限：'+sType;
  str := '是否要删除:'+#13#10+'用户名：'+sUserNaem +#13#10+'真实姓名：'+sRealName +#13#10+'权限：'+sType;
  if Application.MessageBox(PChar(str),'提示',MB_YESNO+MB_ICONINFORMATION) = IDNO then
    Exit;
  sSqlData := 'Delete from BI_UserList where F_iID =%d ';
  try
    if DM_DataBase.ExecQuery(sSqlData,[stgSeletedID],False) then
    begin
      Application.MessageBox('删除成功!','提示',MB_ICONINFORMATION);
      InitUserList;
    end else
      Application.MessageBox('删除失败!','提示',MB_ICONINFORMATION);
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar('删除失败:'+E.message),'提示',MB_ICONINFORMATION);
    end;

  end;

end;

procedure TFra_UserAdd.btn_cxClick(Sender: TObject);
var
  sSqlData,sType,sContent: string;
  ADO_Rec: TADOQuery;
begin
  if cb_Type.Text = '权限' then
  begin
    sType := cb_Type.Text;
    sContent := cbb_UserType.Text;
  end else
  begin
    sType := cb_Type.Text;
    sContent := edt_Content.Text;
  end;
  sSqlData := 'exec p_yhcx ''%s'',''%s'',%d ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sType,sContent,LoginData.m_iUserType]);
  if Assigned(ADO_Rec) then
  begin
    ReadDataUserList(ADO_Rec);
    ADO_Rec.Free;
  end;

end;

procedure TFra_UserAdd.ReadDataUserList(ADO_Data: TADOQuery);
var
  n: Integer;
  sType: string;
begin
  stg_UserList.Clear;
  stg_UserList.RowCount := iif(ADO_Data.RecordCount > 0, ADO_Data.RecordCount +1, 2);
  n := 1;
  with ADO_Data do
  begin
    First;
    while not Eof do
    begin
      stg_UserList.cells[c_yhm ,n] := FieldByName('F_sName').AsString;
      stg_UserList.cells[c_zsxm ,n] := FieldByName('F_sRealName').AsString;
      case FieldByName('F_iType').AsInteger of
        c_User: sType:= '普通用户';
        c_Admin: sType:= '管理员';
        c_User_Small: sType:= '普通用户(小批量)';
        c_Admin_Small: sType:= '管理员(小批量)';
        c_SuperAdmin: sType:= '超级管理员';
      else
        sType:= FieldByName('F_iType').AsString;
      end;
      stg_UserList.cells[c_qx ,n] := sType;
      stg_UserList.Cells[c_sq,n] := '授权';
      stg_UserList.CellsLink[c_sq,n] := '授权';
      stg_UserList.Cells[c_yx,n] := '允许';
      stg_UserList.CellsLink[c_yx,n] := '允许';
      stg_UserList.Cells[c_sc,n] := '删除';
      stg_UserList.CellsLink[c_sc,n] := '删除';
      stg_UserList.cells[c_F_iID ,n] := FieldByName('F_iID').AsString;
      inc(n);
      Next;
    end;
    stg_UserList.ColWidths[c_F_iID] := 0;
  end;
end;

procedure TFra_UserAdd.InitUserList;
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
begin
  case LoginData.m_iUserType of        //对应权限所查询语句
    c_User:
    begin
      sSqlData := 'select * from BI_UserList where F_iType = 0 order by F_sName';
    end;
    c_Admin:
    begin
      sSqlData := 'select * from BI_UserList order by F_sName';
    end;
    c_User_Small:
    begin
      sSqlData := 'select * from BI_UserList where F_iType = 5 order by F_sName';
    end;
    c_Admin_Small:
    begin
      sSqlData := 'select * from BI_UserList where F_iType in (5,6) order by F_sName';
    end;
    c_SuperAdmin:
    begin
      sSqlData := 'select * from BI_UserList order by F_sName';
    end;
  else
    sSqlData := 'select * from BI_UserList order by F_sName';
  end;
  SetOperatingAuthorization;
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
  if Assigned(ADO_Rec) then
  begin
    ReadDataUserList(ADO_Rec);
    ADO_Rec.Free;
  end;
end;

procedure TFra_UserAdd.btn_czClick(Sender: TObject);
begin
  InitUserList;
end;

procedure TFra_UserAdd.SetOperatingAuthorization;
begin
  case LoginData.m_iUserType of        //对应权限所查询语句
    c_User:
    begin
      pan_UserAdd.Visible := False;
      stg_UserList.ColWidths[c_sq] := 0;
      stg_UserList.ColWidths[c_yx] := 0;
      stg_UserList.ColWidths[c_sc] := 0;
    end;
    c_Admin:
    begin
      pan_UserAdd.Visible := True;
      stg_UserList.ColWidths[c_sq] := 40;
      stg_UserList.ColWidths[c_yx] := 40;
      stg_UserList.ColWidths[c_sc] := 40;
    end;
    c_User_Small:
    begin
      pan_UserAdd.Visible := False;
      stg_UserList.ColWidths[c_sq] := 0;
      stg_UserList.ColWidths[c_yx] := 0;
      stg_UserList.ColWidths[c_sc] := 0;
    end;
    c_Admin_Small:
    begin
      pan_UserAdd.Visible := True;
      stg_UserList.ColWidths[c_sq] := 40;
      stg_UserList.ColWidths[c_yx] := 40;
      stg_UserList.ColWidths[c_sc] := 40;
    end;
    c_SuperAdmin:
    begin
      pan_UserAdd.Visible := True;
      stg_UserList.ColWidths[c_sq] := 40;
      stg_UserList.ColWidths[c_yx] := 40;
      stg_UserList.ColWidths[c_sc] := 40;
    end;
  else
    pan_UserAdd.Visible := True;
    stg_UserList.ColWidths[c_sq] := 40;
    stg_UserList.ColWidths[c_yx] := 40;
    stg_UserList.ColWidths[c_sc] := 40;
  end;
end;

procedure TFra_UserAdd.cb_TypeChange(Sender: TObject);
begin
  if Ti_ComboBox(Sender).Text = '权限' then
  begin
    edt_Content.Hide;
    cbb_UserType.Show;
  end else
  begin
    edt_Content.Show;
    cbb_UserType.Hide;
  end;

end;

end.

