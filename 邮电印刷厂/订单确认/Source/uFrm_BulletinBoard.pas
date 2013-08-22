unit uFrm_BulletinBoard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, StdCtrls, RzPanel, ButtonEdit, ExtCtrls, ADODB;

type
  TFrm_BulletinBoard = class(TForm)
    Panel1: TPanel;
    edt_fbr: Ti_TxtFilter;
    edt_fjrq: Ti_TxtFilter;
    Panel3: TPanel;
    RzGroupBox1: TRzGroupBox;
    mmo_Bulletin: TMemo;
    btn_ok: TRzButton;
    btn_close: TRzButton;
    btn_del: TRzButton;
    procedure btn_okClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_delClick(Sender: TObject);
  private
    { Private declarations }
    function f_MakeAllow: Boolean;   //操作允许

  public
    { Public declarations }
    viBulletinID: Integer;
  end;

var
  Frm_BulletinBoard: TFrm_BulletinBoard;

implementation

uses
  uDM_DataBase, uPub_Type, uPub_Text, uPub_Func, DB;

{$R *.dfm}

procedure TFrm_BulletinBoard.btn_okClick(Sender: TObject);
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
begin
  sSqlData := 'Select * from BI_BulletinBoard where F_iID=%d';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[viBulletinID]);
  if Assigned(ADO_Rec) then
  begin
    if ADO_Rec.Eof then
      ADO_Rec.Insert
    else
      ADO_Rec.Edit;
    ADO_Rec.FieldByName('F_sFBRBM').AsString := LoginData.m_sUserName;
    ADO_Rec.FieldByName('F_sContent').AsString := mmo_Bulletin.Text;
    ADO_Rec.Post;
    p_MessageBoxDlg(btn_ok.Caption+'成功!');
    ADO_Rec.Free;
    ModalResult := mrOk;
  end;
end;

procedure TFrm_BulletinBoard.FormShow(Sender: TObject);
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
begin
  f_MakeAllow;
  if viBulletinID > 0 then
  begin
    sSqlData := 'Select a.F_dFBRQ,b.F_sRealName,a.F_sContent from BI_BulletinBoard a left join BI_UserList b on a.F_sFBRBM=b.F_sName  where a.F_iID=%d   ';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[viBulletinID]);
    if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
    begin
      edt_fjrq.Text := FormatDateTime('yyyy-MM-dd hh:mm:ss',ADO_Rec.FieldByName('F_dFBRQ').AsDateTime);
      edt_fbr.Text := ADO_Rec.FieldByName('F_sRealName').AsString;
      mmo_Bulletin.Text :=  ADO_Rec.FieldByName('F_sContent').AsString;
    end else
    begin
      p_MessageBoxDlg('数据获取失败!');
      ADO_Rec.Free;
      Exit;
    end;
    if Assigned(ADO_Rec) then
      ADO_Rec.Free;
    edt_fjrq.Visible := True;
    btn_del.Visible := True;
    btn_ok.Caption := '修改';
  end else
  begin
    edt_fbr.Text := LoginData.m_sRealName;
    edt_fjrq.Visible := False;
    btn_del.Visible := False;
    btn_ok.Caption := '发布';
  end;
end;

procedure TFrm_BulletinBoard.btn_delClick(Sender: TObject);
var
  sSqlData: string;
begin
  if viBulletinID > 0 then
  begin
    if p_MessageBoxDlg('是否要删除此公告?','提示',MB_ICONINFORMATION+MB_YESNO) = IDYES then
    begin
      sSqlData := 'update BI_BulletinBoard set F_tiCXBZ=1,F_sCXRBM=''%s'',F_dCXRQ=getdate() where F_iID=%d';
      DM_DataBase.ExecQuery(sSqlData,[LoginData.m_sUserName,viBulletinID]);
      p_MessageBoxDlg('删除成功!');
      ModalResult := mrOk;
    end;      
  end else
    p_MessageBoxDlg('获取数据失败!');
end;

function TFrm_BulletinBoard.f_MakeAllow: Boolean;
var
  sSqlData, sCode: string;
  ADO_Rec: TADOQuery;
  iAllowID, iAllowCode: Integer;
begin
  Result := False;
  if LoginData.m_iAllowCode >= 0 then
  begin
    sCode := Format('''%s''',[c_Allow_Bulletin_FB]);
    iAllowCode := LoginData.m_iAllowCode;
    sSqlData := 'Select F_iID,F_sCode from Set_AllowInfo where F_tiStatus = 1 and F_sCode in (%s) order by F_iID';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sCode],False);
    if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
    begin
      while not ADO_Rec.Eof do
      begin
        iAllowID := ADO_Rec.FieldByName('F_iID').AsInteger;
        sCode := ADO_Rec.FieldByName('F_sCode').AsString;
        if 1 shl iAllowID or iAllowCode = iAllowCode then
        begin
          if sCode = c_Allow_Bulletin_FB then
          begin
            btn_ok.Enabled := True;
            btn_ok.Tag := c_Tag_MakeAllow;
            btn_del.Enabled := True;
            btn_del.Tag := c_Tag_MakeAllow;
          end;
        end else
        begin
          if sCode = c_Allow_Bulletin_FB then
          begin
            btn_ok.Enabled := False;
            btn_ok.Tag := 0;
            btn_del.Enabled := False;
            btn_del.Tag := 0;
          end;
        end;
        ADO_Rec.Next;
      end;
    end;
    if Assigned(ADO_Rec) then
      ADO_Rec.Free;
    
  end;
  Result := True;
end;

end.
