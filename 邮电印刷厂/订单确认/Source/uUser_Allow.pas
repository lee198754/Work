unit uUser_Allow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, RzButton, StdCtrls, CheckLst, ADODB;

type
  TFrm_User_Allow = class(TForm)
    Label1: TLabel;
    ckl_AllowList: TCheckListBox;
    btn_ok: TRzButton;
    ImageList1: TImageList;
    procedure FormShow(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    { Private declarations }
    AllowList : array of Integer;
  public
    { Public declarations }
    vUserID: integer;
  end;

var
  Frm_User_Allow: TFrm_User_Allow;

implementation

uses
  uDM_DataBase, uPub_Type, uPub_Func;

{$R *.dfm}

procedure TFrm_User_Allow.FormShow(Sender: TObject);
var
  i, iAllowCode: integer;
  ADO_Rec: TADOQuery;
  sSqlData: string;
begin
  try
    sSqlData := 'select F_iID,F_sAllowName from  Set_AllowInfo where F_tiStatus = 1 Order By F_iSort';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[],True);
    ckl_AllowList.Clear;
    SetLength(AllowList,ADO_Rec.RecordCount);
    i:=0;
    with ADO_Rec do
    begin
      while not Eof do
      begin
        ckl_AllowList.Items.Add(FieldByName('F_sAllowName').AsString);
        AllowList[i] := FieldByName('F_iID').AsInteger;
        Inc(i);
        Next;
      end;
    end;
    ADO_Rec.Free;
    sSqlData := 'select F_iAllowCode from  BI_UserList where F_iID=%d';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[vUserID],True);
    iAllowCode := ADO_Rec.FieldByName('F_iAllowCode').AsInteger;
    for i := 0 to ckl_AllowList.Count -1 do
    begin
      ckl_AllowList.Checked[i] :=  1 shl AllowList[i] or  iAllowCode  = iAllowCode;
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

procedure TFrm_User_Allow.btn_okClick(Sender: TObject);
var
  i: integer;
  iAllowCode: LONGLONG;
  sSqlData: string;
begin
  iAllowCode := 0;
  for i := 0 to ckl_AllowList.Count -1 do
  begin
    if ckl_AllowList.Checked[i] then
      iAllowCode := iAllowCode or 1 shl AllowList[i];
  end;
  sSqlData := 'Update BI_UserList set F_iAllowCode=%d where F_iID=%d';
  DM_DataBase.ExecQuery(sSqlData,[iAllowCode,vUserID],False);
  Application.MessageBox('修改成功!','提示',MB_ICONINFORMATION);
  if LoginData.m_iUserID = vUserID then
    LoginData.m_iAllowCode := iAllowCode;
  Close;
end;

end.
 