unit uFra_Pwd_Modify;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ButtonEdit, RzButton, ExtCtrls, RzPanel,ADODB;

type
  TFra_Pwd_Modify = class(TFrame)
    pan_Modify: TRzPanel;
    edt_oldPwd: Ti_TxtFilter;
    edt_NewPwd: Ti_TxtFilter;
    edt_NewPwd_Ack: Ti_TxtFilter;
    RzButton1: TRzButton;
    Label1: TLabel;
    lab_Info: TLabel;
    procedure RzButton1Click(Sender: TObject);
  private
    { Private declarations }
    function IsEmpty:Boolean;
  public
    { Public declarations }
    procedure  FraShow;
  end;

implementation

uses
  uDM_DataBase, PubStr, uPub_Type, uPub_Func;
{$R *.dfm}

{ TFra_Pwd_Modify }

procedure TFra_Pwd_Modify.FraShow;
begin
  edt_oldPwd.Text := '';
  edt_NewPwd.Text := '';
  edt_NewPwd_Ack.Text := '';
  lab_Info.Caption := '�������޸ĵ��û��� '+LoginData.m_sUserName;
end;

function TFra_Pwd_Modify.IsEmpty: Boolean;
var
  i: Integer;
  comp: TComponent;
begin
  Result := False;
  for i := 0 to pan_Modify.ControlCount -1 do
  begin
    comp := pan_Modify.Controls[i];
    if (comp is Ti_TxtFilter)  then
    begin
      if Ti_TxtFilter(comp).Text = '' then
      begin
        Application.MessageBox(PChar('������ '+StrCut(Ti_TxtFilter(comp).LabelCaption,'��')+' !'),'��ʾ',MB_ICONINFORMATION);
        Ti_TxtFilter(comp).SetFocus;
        Result := True;
        Exit;
      end;
    end;
  end;
end;

procedure TFra_Pwd_Modify.RzButton1Click(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
begin
  if IsEmpty then Exit;
  if edt_NewPwd.Text <> edt_NewPwd_Ack.Text then
  begin
    Application.MessageBox('������������벻һ�� ','��ʾ',MB_ICONINFORMATION);
    Exit;
  end;
  sSqlData := 'Select * from BI_UserList where F_iID =%d';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[LoginData.m_iUserID]);
  try
    if ADO_Rec.RecordCount > 0 then
    begin
      if not (ADO_Rec.FieldByName('F_sPwd').AsString = StrMD5(edt_oldPwd.Text)) then
      begin
        Application.MessageBox('���������','��ʾ',MB_ICONINFORMATION);
        Exit;
      end;
      ADO_Rec.Edit;
      ADO_Rec.FieldByName('F_sPwd').AsString := StrMD5(edt_NewPwd.Text);
      ADO_Rec.Post;
      Application.MessageBox('�޸ĳɹ�!','��ʾ',MB_ICONINFORMATION);
      FraShow;
    end else
      Application.MessageBox('�û�������!','��ʾ',MB_ICONINFORMATION);
  finally
    ADO_Rec.Free;
  end;
end;

end.

