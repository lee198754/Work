unit uUser_Limit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, RzButton, StdCtrls, CheckLst,ADODB;

type
  TFrm_User_Limit = class(TForm)
    Label1: TLabel;
    ckl_LimitList: TCheckListBox;
    btn_ok: TRzButton;
    ImageList1: TImageList;
    procedure btn_okClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    LimitList : array of Integer;
  public
    { Public declarations }
    vUserID: integer;
  end;

var
  Frm_User_Limit: TFrm_User_Limit;

implementation

uses
  uDM_DataBase, uPub_Func;

{$R *.dfm}

procedure TFrm_User_Limit.btn_okClick(Sender: TObject);
var
  i: integer;
  iLimitCode: LONGLONG;
  sSqlData: string;
begin
  iLimitCode := 0;
  for i := 0 to ckl_LimitList.Count -1 do
  begin
    if ckl_LimitList.Checked[i] then
      iLimitCode := iLimitCode or 1 shl LimitList[i];
  end;
  sSqlData := 'Update BI_UserList set F_iLimitCode=%d where F_iID=%d';
  DM_DataBase.ExecQuery(sSqlData,[iLimitCode,vUserID],False);
  Application.MessageBox('修改成功!','提示',MB_ICONINFORMATION);
  Close;
end;

procedure TFrm_User_Limit.FormShow(Sender: TObject);
var
  i, iLimitCode: integer;
  ADO_Rec: TADOQuery;
  sSqlData: string;
begin
  try
    sSqlData := 'select F_iID,F_sLimitName from  Set_LimitInfo where F_tiStatus = 1 Order By F_iSort';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[],True);
    ckl_LimitList.Clear;
    SetLength(LimitList,ADO_Rec.RecordCount);
    i:=0;
    with ADO_Rec do
    begin
      while not Eof do
      begin
        ckl_LimitList.Items.Add(FieldByName('F_sLimitName').AsString);
        LimitList[i] := FieldByName('F_iID').AsInteger;
        Inc(i);
        Next;
      end;
    end;
    ADO_Rec.Free;
    sSqlData := 'select F_iLimitCode from  BI_UserList where F_iID=%d';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[vUserID],True);
    iLimitCode := ADO_Rec.FieldByName('F_iLimitCode').AsInteger;
    for i := 0 to ckl_LimitList.Count -1 do
    begin
      ckl_LimitList.Checked[i] :=  1 shl LimitList[i] or  iLimitCode  = iLimitCode;
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

end.
