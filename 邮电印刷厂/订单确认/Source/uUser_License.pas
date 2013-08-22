unit uUser_License;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, StdCtrls, CheckLst, ADODB, ComCtrls, RzListVw, ImgList;

type
  TFrm_User_License = class(TForm)
    ckl_LicenseList: TCheckListBox;
    btn_ok: TRzButton;
    Label1: TLabel;
    lv_LicenseList: TRzListView;
    ImageList1: TImageList;
    procedure btn_okClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ckl_LicenseListMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure lv_LicenseListCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lv_LicenseListMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    MenuList : array of Integer;
  public
    { Public declarations }
    vUserID: integer;
  end;

var
  Frm_User_License: TFrm_User_License;

implementation

uses
  uDM_DataBase, uPub_Type, uPub_Func, DB, PubStr, Math;

{$R *.dfm}

procedure TFrm_User_License.btn_okClick(Sender: TObject);
var
  i: integer;
  iLicenseCode: LONGLONG;
  sLicenseCode: string;
  sSqlData: string;
begin
  iLicenseCode := 0;
  for i := 0 to ckl_LicenseList.Count -1 do
  begin
    if ckl_LicenseList.Checked[i] then
    begin
      //iLicenseCode := iLicenseCode or 1 shl MenuList[i];
      iLicenseCode := iLicenseCode or Trunc(power(2,MenuList[i]));
    end;
  end;

  sSqlData := 'Update BI_UserList set F_iLicenseCode=%d where F_iID=%d';
  DM_DataBase.ExecQuery(sSqlData,[iLicenseCode,vUserID],False);
  Application.MessageBox('修改成功!','提示',MB_ICONINFORMATION);
  Close;
end;

procedure TFrm_User_License.FormShow(Sender: TObject);
var
  i: integer;
  iLicenseCode: LONGLONG;
  ADO_Rec: TADOQuery;
  sSqlData: string;
begin
  try
    sSqlData := 'select F_iID,F_sMenuName from  Sys_MenuInfo where F_tiStatus = 1 Order By F_iSort';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[],True);
    ckl_LicenseList.Clear;
    SetLength(MenuList,ADO_Rec.RecordCount);
    i:=0;
    with ADO_Rec do
    begin
      while not Eof do
      begin
        ckl_LicenseList.Items.Add(FieldByName('F_sMenuName').AsString);
        MenuList[i] := FieldByName('F_iID').AsInteger;
        Inc(i);
  //      lv_LicenseList.Items.Add.Caption := '';
  //      lv_LicenseList.Items.Item[lv_LicenseList.Items.Count-1].SubItems.Add(FieldByName('F_sMenuName').AsString);
        Next;
      end;
    end;
    sSqlData := 'select F_iLicenseCode from  BI_UserList where F_iID=%d';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[vUserID],True);
    if ADO_Rec.FieldByName('F_iLicenseCode').IsNull then
      iLicenseCode := 0
    else
      iLicenseCode := ADO_Rec['F_iLicenseCode'];
    //iLicenseCode := StrToInt64('%'+ADO_Rec.FieldByName('F_iLicenseCode').AsString);
    for i := 0 to ckl_LicenseList.Count -1 do
    begin
      //ckl_LicenseList.Checked[i] :=  1 shl MenuList[i] or  iLicenseCode  = iLicenseCode;
      ckl_LicenseList.Checked[i] :=  Trunc(power(2,MenuList[i])) or  iLicenseCode  = iLicenseCode;
    end;
  except
    on E: Exception do
    begin
      p_MessageBoxDlg(E.Message);
      Close;
    end;
  end;
  ADO_Rec.Free;
end;

procedure TFrm_User_License.ckl_LicenseListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
{  if (Button = mbleft) and (X > 10) then
  begin
    if not Assigned(TCheckListBox(Sender)) then Exit;
    TCheckListBox(Sender).Checked[TCheckListBox(Sender).ItemIndex] := not TCheckListBox(Sender).Checked[TCheckListBox(Sender).ItemIndex];
  end;    }

end;

procedure TFrm_User_License.lv_LicenseListCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  if (Item.Index mod 2) = 0 then
    Sender.Canvas.Brush.Color := $00F0FFF0
  else
    Sender.Canvas.Brush.Color := $00F2F2F2;
  LVDrawItem(TRzListView(Sender), Item, State, DefaultDraw);

end;

procedure TFrm_User_License.lv_LicenseListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbleft) and (X > 20) then
  begin
    if not Assigned(TRzListView(Sender).Selected) then Exit;
    TRzListView(Sender).Selected.Checked := not TRzListView(Sender).Selected.Checked;
  end;
end;

end.
