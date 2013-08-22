unit uAutoUpdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,XPMan, RzPrgres, ComCtrls, IdBaseComponent,
  IdComponent, IdRawBase, IdRawClient, IdIcmpClient;

type
  TFrm_AutoUpdate = class(TForm)
    pb_UpdateProgress: TProgressBar;
    Label1: TLabel;
    IdIcmpClient1: TIdIcmpClient;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function CovFileDate(Fd:_FileTime):TDateTime;
    function UpdateFile(S_Path,D_Path: string):Boolean;
    function GetFileCount(sPath: string): integer;
    function CheckFile(S_Path, D_Path: string):Boolean;
  public
    { Public declarations }
  end;
const
  UpdateUser='ydysca';
  UpdatePwd='ydys';
  AutoUpdatePath= '\\172.29.116.7\公共区\贺卡2011客户端软件\';

var
  Frm_AutoUpdate: TFrm_AutoUpdate;
  vAutoUpdatePath: string='';
  vSour_Path: string;

implementation

uses
  IniFiles,PubStr;

{$R *.dfm}

function TFrm_AutoUpdate.CheckFile(S_Path, D_Path: string):Boolean;
var
  F,FileRec: TSearchRec;
begin
  Result := False;
  if FindFirst(S_Path+'*.*',faAnyfile,FileRec) = 0 then
  begin
    Result := True;
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
          Result := True;
          Break;
        end else
        begin
          if CovFileDate(FileRec.FindData.ftLastWriteTime) > CovFileDate(F.FindData.ftLastWriteTime) then
          begin
            Result := True;
            Break;
          end;
        end;
      end;
    until FindNext(FileRec)<>0;
  end;

end;

function TFrm_AutoUpdate.UpdateFile(S_Path, D_Path: string):Boolean;
var
  dUpdateTime: TDateTime;
  F,FileRec: TSearchRec;
  iFileCount: Integer;
begin
  Result := False;
  iFileCount := GetFileCount(S_Path);
  pb_UpdateProgress.Max := iFileCount;
  pb_UpdateProgress.Position := 0;
  if FindFirst(S_Path+'*.*',faAnyfile,FileRec) = 0 then
  begin
    repeat
      Application.ProcessMessages;
      if (FileRec.Name ='.') or (FileRec.Name ='..') then Continue;
      if FileRec.Attr = faDirectory then
      begin
        if FileRec.Name = 'Server' then Continue;
        CreateDirectory(PChar(FileRec.Name),nil);
        UpdateFile(S_Path + FileRec.Name +'\',D_Path + FileRec.Name + '\');
      end else
      begin
        if FindFirst(D_Path+FileRec.Name,faAnyfile,F) <> 0 then
        begin
          if UpperCase(FileRec.Name) = UpperCase(Application.ExeName) then Continue;
          if not CopyFile(PChar(S_Path+FileRec.Name),PChar(D_Path+FileRec.Name),False) then Exit;
          pb_UpdateProgress.Position := pb_UpdateProgress.Position +1;
        end else
        begin
          if UpperCase(FileRec.Name) = UpperCase(Application.ExeName) then Continue;
          if CovFileDate(FileRec.FindData.ftLastWriteTime) > CovFileDate(F.FindData.ftLastWriteTime) then
          begin
            if not CopyFile(PChar(S_Path+FileRec.Name),PChar(D_Path+FileRec.Name),False) then Exit;
            pb_UpdateProgress.Position := pb_UpdateProgress.Position +1;
          end;

        end;
      end;
    until FindNext(FileRec)<>0;
  end else
    Exit;
  pb_UpdateProgress.Position := pb_UpdateProgress.Max;
  Result := True;
end;

function TFrm_AutoUpdate.CovFileDate(Fd:_FileTime):TDateTime;
{ 转换文件的时间格式 }
var
  Tct:_SystemTime;
  Temp:_FileTime;
begin
  FileTimeToLocalFileTime(Fd,Temp);
  FileTimeToSystemTime(Temp,Tct);
  CovFileDate:=SystemTimeToDateTime(Tct);
end;

procedure TFrm_AutoUpdate.FormCreate(Sender: TObject);
var
  ini: TIniFile;
  str: string;
  vAutoUpdatePath: string;
begin
  vSour_Path := ExtractFilePath(Application.ExeName);
  ini := TIniFile.Create(vSour_Path+'set.ini');
  vAutoUpdatePath := ini.ReadString('Set','AutoUpdatePath','');
  if vAutoUpdatePath = '' then
    vAutoUpdatePath := AutoUpdatePath;
end;

procedure TFrm_AutoUpdate.FormShow(Sender: TObject);
var
  Str: string;
  h: THandle;
  iTime: integer;
  UpdateIP: string;
  F: TSearchRec;
begin
  Self.Icon := Application.Icon;
  UpdateIP := PosCopy(AutoUpdatePath,'\',3);
  IdIcmpClient1.Host := UpdateIP;
  IdIcmpClient1.Ping;
  if IdIcmpClient1.ReplyStatus.ReplyStatusType = rsEcho then
  begin
    h := FindWindow('Tfrm_login','登陆');
    iTime := GetTickCount;
    while h > 0 do
    begin
      Application.ProcessMessages;
      SendMessage(h,WM_CLOSE,0,0);
      if GetTickCount - iTime > 1000 then Break;
      h := FindWindow('Tfrm_login','登陆');
    end;
    if FindFirst(AutoUpdatePath+'*.*',faAnyfile,F) <> 0 then
    begin
  //    UpdateIP := PosCopy(AutoUpdatePath,'\',3);
      Str := 'net use \\'+UpdateIP+' '+UpdatePwd+ ' /user:'+UpdateUser;
      WinExec(pchar(Str),SW_HIDE);
    end;
  //  if CheckFile(AutoUpdatePath,vSour_Path) then
    begin
      if UpdateFile(AutoUpdatePath,vSour_Path) then
      begin
        Str := '更新成功!是否启动系统?';
        if Application.MessageBox(pchar(Str),'提示',MB_ICONINFORMATION+MB_YESNO)= IDYES then
        begin
          if winexec(PChar(vSour_Path+'邮电贺卡系统.exe'),   SW_SHOWNORMAL) <= 31 then
            Application.MessageBox(pchar('启动失败!请手动启动"邮电贺卡系统"'),'提示',MB_ICONINFORMATION);
        end;
      end else
      begin
        Str:= '更新失败:"'+AutoUpdatePath+'"拒绝访问!';
        Application.MessageBox(pchar(Str),'提示',MB_ICONINFORMATION);
      end;
    end;
  end;
  Close;

end;

function TFrm_AutoUpdate.GetFileCount(sPath: string): integer;
var
  FileRec: TSearchRec;
begin
  Result := 0;
  if FindFirst(sPath+'*.*',faAnyfile,FileRec) = 0 then
  begin
    repeat
      if (FileRec.Name ='.') or (FileRec.Name ='..') then Continue;
      if FileRec.Attr = faDirectory then
        GetFileCount(FileRec.Name+'\');
      Result := Result +1;
    until FindNext(FileRec)<>0;
  end;

end;

end.
