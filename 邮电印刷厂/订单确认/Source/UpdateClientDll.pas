unit UpdateClientDll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, ShellApi;

type
//打开服务
  TOpen = function(sIP: PChar; nPort: integer): integer; stdcall;

//关闭服务
  TClose = procedure; stdcall;

//是否更新
  TIsUpdateSoft = function(sSoftName, sClientPath: PChar; nV: integer): integer; stdcall;
  TMaxVer = function(sSoftName: PChar; nV: integer): integer; stdcall;

  TUpdateSoftDll = class(TObject)
  private
    FIP: string;
    FPort: integer;

    //
    m_hDll: Cardinal;
    m_sLocalIP: string;
    m_sFile: string;
    m_Ini: TIniFile;

    //
    m_Open: TOpen;
    m_Close: TClose;
    m_IsUpdateSoft: TIsUpdateSoft;
    m_MaxVer: TMaxVer;
    function p_Check(b: boolean; const sFun: string): boolean;
    function p_Open(sIP: string; nPort: integer): integer;
    procedure p_Close;    
  public
    constructor Create;
    destructor Destroy; override;
  public
    function p_IsUpdateSoft(sSoftName, sClientPath: PChar): integer;
    function p_MaxVer(sSoftName: PChar; nV: integer): integer;
  public

  end;

  procedure p_CheckUpdate(const sSoftName, sRunType: string; bHint: boolean = true);

implementation

const
  c_Path = 'SoftUpdate\';
  C_SocketDll = 'UpdateClient.dll';

{ TUpdateSoftDll }

procedure p_CheckUpdate(const sSoftName, sRunType: string; bHint: boolean);
var
  SoftUpdate: TUpdateSoftDll;
  sExe: string;
  sParam: string;
  bUpdate: boolean;
  nR: integer;
begin
  //
  SoftUpdate := TUpdateSoftDll.Create;
  try
    nR := SoftUpdate.p_IsUpdateSoft(PChar(sSoftName), '');
    //nr := 1;
    if nR > 0 then
    begin
      bUpdate := true;
      if bHint and (nR < 2) then
        bUpdate := Application.MessageBox('发现新版本，是否更新', '提示信息',
          MB_ICONINFORMATION + MB_YESNO + MB_DEFBUTTON1) = IDYES;
      if bUpdate then
      begin
        sExe := ExtractFilePath(Application.ExeName) + c_Path + 'UpdateSoftClient.exe';
        if not FileExists(sExe) then
        begin
          Application.MessageBox(PChar('文件：' + QuotedStr(sExe) + '不存在'), '提示信息', MB_ICONINFORMATION);
          exit;
        end;

        sParam := sSoftName + '|' + sRunType;
        ShellExecute(0, 'open', PChar(sExe), PChar(sParam), PChar(ExtractFilePath(sExe)), SW_SHOW);
        Halt;
      end;
    end;
  finally
    //SoftUpdate.Free;
  end;
end;

constructor TUpdateSoftDll.Create;
var
  sNewPath, sOldPath, sFile: string;
  buf: array[0..MAX_PATH] of Char;
begin
  m_Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + c_Path + 'Update.ini');

  //sNewPath := ExtractFilePath(Application.ExeName) + 'SoftUpdate';
  //GetCurrentDirectory(SizeOf(buf), buf);
  //sOldPath := buf;
  //SetCurrentDirectory(PChar(sNewPath));
  try
    m_hDll := 0;
    sFile := ExtractFilePath(Application.ExeName) + c_Path + C_SocketDll;
    if not FileExists(sFile) then exit;
    m_hDll := LoadLibrary(PChar(sFile));
    if m_hDll = 0 then exit;
  finally
    //SetCurrentDirectory(PChar(sOldPath));
  end;

  m_Open := GetProcAddress(m_hDll, 'p_Open');
  m_Close := GetProcAddress(m_hDll, 'p_Close');
  m_IsUpdateSoft := GetProcAddress(m_hDll, 'p_IsNeedUpdate');
  m_MaxVer := GetProcAddress(m_hDll, 'p_MaxVer');
end;

destructor TUpdateSoftDll.Destroy;
begin
  if m_hDll <> 0 then begin
    p_Close;
    FreeLibrary(m_hDll);
    m_hDll := 0;
  end;

  m_Ini.Free;
  inherited;
end;

function TUpdateSoftDll.p_Check(b: boolean; const sFun: string): boolean;
begin
  Result := b;
  if not b then begin
    raise Exception.Create(C_SocketDll + '接口' + sFun + '无效');
  end;
end;

procedure TUpdateSoftDll.p_Close;
begin
  if Assigned(m_Close) then
  begin
    //m_bExit := true;
    m_Close;
  end;
end;

function TUpdateSoftDll.p_IsUpdateSoft(sSoftName, sClientPath: PChar): integer;
var
  sIP: string;
  r, nPort: integer;
  nV: integer;
  sMac: string;
begin
  Result := 0;
  if Assigned(m_IsUpdateSoft) then
  begin
    sIP := m_Ini.ReadString('UpdateServer', 'ServerIP', '127.0.0.1');
    nPort := m_Ini.ReadInteger('UpdateServer', 'ServerPort', 8325);
    nV := m_Ini.ReadInteger('UpdateSoft', 'LastVersion', 1);

    r := p_Open(sIP, nPort);
    if r = 0 then
    begin
      sMac := '';
      Result := m_IsUpdateSoft(sSoftName, sClientPath, nV);
    end;
      
    p_Close;
  end;
end;

function TUpdateSoftDll.p_MaxVer(sSoftName: PChar; nV: integer): integer;
begin
  Result := -1;
  if Assigned(m_MaxVer) then
  begin
    Result := m_MaxVer(sSoftName, nV);
  end;
end;

function TUpdateSoftDll.p_Open(
  sIP: string;
  nPort: integer
): integer;
begin
  Result := -2;
  //m_bExit := false;
  if Assigned(m_Open) then
  begin
    FIP := sIP;
    FPort := nPort;
    Result := m_Open(PChar(FIP), FPort);
  end;
end;

end.
