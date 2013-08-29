unit uLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, StdCtrls, ButtonEdit, uDM_DataBase,ADODB,
  IdBaseComponent, IdComponent, IdRawBase, IdRawClient, IdIcmpClient,
  ExtCtrls, RzRadChk, DB;

type
  TFrm_Login = class(TForm)
    edt_Name: Ti_TxtFilter;
    btn_login: TRzButton;
    edt_Pwd: TEdit;
    Label1: TLabel;
    IdIcmpClient1: TIdIcmpClient;
    cb_RemPwd: TRzCheckBox;
    procedure btn_loginClick(Sender: TObject);
    procedure edt_PwdKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Login: TFrm_Login;
  vUserName,vUserPwd: string;

implementation

{$R *.dfm}
uses
  uPub_Type, uPub_Func, IniFiles, PubStr, Registry, uPub_Text;




function CheckFile(S_Path, D_Path: string):Boolean;
var
  F,FileRec: TSearchRec;
begin
  Result := False;
  if FindFirst(S_Path+'*.*',faAnyfile,FileRec) = 0 then
  begin
    repeat
      Application.ProcessMessages;
      if (FileRec.Name ='.') or (FileRec.Name ='..') then Continue;
      if FileRec.Attr = faDirectory then
      begin
        if FileRec.Name = 'Server' then Continue;
        CheckFile(S_Path + FileRec.Name +'\',D_Path + FileRec.Name + '\');
      end else
      begin
        if FindFirst(D_Path+FileRec.Name,faAnyfile,F) <> 0 then
        begin
          if UpperCase(FileRec.Name) = UpperCase('AutoUpdate.exe') then
          begin
            if CopyFile(PChar(S_Path+FileRec.Name),PChar(D_Path+FileRec.Name),False) then
              Continue;
          end;
          Result := True;
        end else
        begin
          if CovFileDate(FileRec.FindData.ftLastWriteTime) > CovFileDate(F.FindData.ftLastWriteTime) then
          begin
            if UpperCase(FileRec.Name) = UpperCase('AutoUpdate.exe') then
              CopyFile(PChar(S_Path+FileRec.Name),PChar(D_Path+FileRec.Name),False);
            Result := True;
          end;
        end;
      end;
    until FindNext(FileRec)<>0;
  end;

end;



procedure TFrm_Login.btn_loginClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  MyReg: TRegistry;
begin
  ModalResult := mrNone;
  if Trim(edt_Name.Text) = '' then
  begin
    Application.MessageBox('请输入用户名!','提示',MB_ICONINFORMATION);
    edt_Name.SetFocus;
    Exit;
  end;
  if edt_Pwd.Text='' then
  begin
    Application.MessageBox('请输入密码!','提示',MB_ICONINFORMATION);
    edt_Pwd.SetFocus;
    Exit;
  end;
  MyReg := TRegistry.Create;
  MyReg.RootKey := HKEY_LOCAL_MACHINE;
  MyReg.OpenKey(c_Reg_Login_CookiePath,True);
  MyReg.WriteString('UserName', edt_Name.Text);
  MyReg.WriteString('UserPwd', '');
//  if cb_RemPwd.Checked then
//  begin
//    MyReg.WriteString('UserPwd', edt_Pwd.Text);
//  end else
//  begin
//    MyReg.WriteString('UserPwd', '');
//  end;
  MyReg.CloseKey;
  MyReg.Free;
  vUserName := edt_Name.Text;
  vUserPwd := edt_Pwd.Text;

  try
    ADO_Rec := TADOQuery.Create(Self);
    DM_DataBase.GetTableData(ADO_Rec,'BI_UserList','F_sName='''+Trim(edt_Name.Text)+''' ');
    if ADO_Rec.RecordCount > 0 then
    begin
      if ADO_Rec.FieldByName('F_sPwd').AsString = StrMD5(Trim(edt_Pwd.Text)) then
      begin
        LoginData.m_iUserID := ADO_Rec.FieldByName('F_iID').AsInteger;
        LoginData.m_sUserName := ADO_Rec.FieldByName('F_sName').AsString;
        LoginData.m_iUserType := ADO_Rec.FieldByName('F_iType').AsInteger;
        LoginData.m_sRealName := ADO_Rec.FieldByName('F_sRealName').AsString;
        if ADO_Rec.FieldByName('F_iLicenseCode').IsNull then
          LoginData.m_iLicenseCode := 0
        else
          LoginData.m_iLicenseCode := ADO_Rec['F_iLicenseCode'];
        if ADO_Rec.FieldByName('F_iAllowCode').IsNull then
          LoginData.m_iAllowCode := 0
        else
          LoginData.m_iAllowCode := ADO_Rec['F_iAllowCode'];

        ModalResult := mrOk;
      end else
      begin
        Application.MessageBox('密码错误!','提示',MB_ICONINFORMATION);
        edt_Pwd.Text := '';
        edt_Pwd.SetFocus;
      end;
    end else
    begin
      Application.MessageBox('用户名错误!','提示',MB_ICONINFORMATION);
      //EditBalloonTip(edt_Pwd.Handle,'密码错误!','提示');
      edt_Name.SetFocus;

    end;
  finally
    if Assigned(ADO_Rec) then
      ADO_Rec.Free;
  end;
end;



procedure TFrm_Login.edt_PwdKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btn_login.Click;
end;


procedure TFrm_Login.FormShow(Sender: TObject);
var
  UpdateIP,sPath,sAutoUpdatePath,sServicesIP: string;
  ini: TIniFile;
  F: TSearchRec;
  MyReg: TRegistry;
begin
  Caption := c_TitleName + ' -- 登陆';
  sPath := ExtractFilePath(Application.ExeName);
  ini := TIniFile.Create(sPath+'set.ini');
  sServicesIP := ini.ReadString('Set','ServicesIP','');
  if sServicesIP = '' then
    Caption := '登陆(本机)';
  //更新判断
  sAutoUpdatePath := ini.ReadString('Set','AutoUpdatePath','');
  if sAutoUpdatePath = '' then
    sAutoUpdatePath := AutoUpdatePath;
  UpdateIP := PosCopy(sAutoUpdatePath,'\',3);
{  IdIcmpClient1.Host := UpdateIP;
  IdIcmpClient1.Ping;
  if IdIcmpClient1.ReplyStatus.ReplyStatusType = rsEcho then
  begin
    if FindFirst(sAutoUpdatePath+'*.*',faAnyfile,F) <> 0 then
    begin
      Str := 'net use \\'+UpdateIP+' '+UpdatePwd+ ' /user:'+UpdateUser;
      WinExec(pchar(Str),SW_HIDE);
    end;
    if CheckFile(sAutoUpdatePath,ExtractFilePath(Application.ExeName)) then
    begin
      if Application.MessageBox(pchar('发现新版本,是否更新?'),'提示',MB_ICONINFORMATION+MB_YESNO)= IDYES then
      begin
        if winexec(PChar(sPath+'AutoUpdate.exe'),   SW_SHOWNORMAL) < 31 then
          Application.MessageBox(pchar('更新失败!请关闭系统后手动运行"AutoUpdate.exe"进行更新'),'提示',MB_ICONINFORMATION);
      end;
    end;
  end;   }
  MyReg := TRegistry.Create;
  MyReg.RootKey := HKEY_LOCAL_MACHINE;
  if MyReg.OpenKey(c_Reg_Login_CookiePath,False) then
  begin
    if MyReg.ValueExists('UserName') then
    begin
      vUserName := MyReg.ReadString('UserName');
      if MyReg.ValueExists('UserPwd') then
        vUserPwd := MyReg.ReadString('UserPwd');
    end;
  end;
  MyReg.CloseKey;
  MyReg.Free;

  edt_Name.Text := vUserName;
  edt_Pwd.Text := vUserPwd;
  if vUserPwd = '' then
  begin
    cb_RemPwd.Checked := False;
    edt_Pwd.SetFocus;
  end;
  ini.Free;
  DelTempPic;

end;


end.
