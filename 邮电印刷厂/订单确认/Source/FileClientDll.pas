{
����ֻ����һ������
�ȴ����ȴ����룬��ʱ����ģ̬�򿪶Ի�����ʾ���ڵȴ����û���ȡ���ȴ�
��ģ������TBackCall�Ļص����ȴ����ڲ��ص��ٴ����ⲿ�ص����ڲ���ʽΪͬ�����ⲿ��ʽΪ�첽

����������������мӵ��б���ΪResult��Call�����ͣ�
Result��ֻ��һ�����ڵ���ǰ���Result���ݣ�
        Call�����ܴ��������һ���б��ţ�
��һ����ʱ��ȡ���ݣ�ȡ�����գ����ⲿ�ĵ���ֱ�ӴӴ�����ڲ������ã�
        ���ٷ��������ӿڣ��ⲿ���ܵ��ã���
}

unit FileClientDll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SyncObjs, SConnect, FrmWaitFor, WinSock, ExtCtrls, IniFiles;

type
//
  TNet_MsgBackCall = procedure(); stdcall;
  TNet_SetSaveMsg = procedure(b: boolean; BC: TNet_MsgBackCall); stdcall;
  TNet_GetMsgCount = function: integer; stdcall;
  TNet_GetMsgData = function(nIndex: integer; out pData: pointer; out nLen: integer): boolean; stdcall;
  TNet_DeleteMsgData = procedure(nIndex: integer); stdcall;

  TBackCall = procedure(pData: PChar; nLen: integer; out bSaveMsg: boolean); stdcall;
  TDisConnectBackCall = procedure(); stdcall;
  TReConnectBackCall = procedure(); stdcall;
  TReConnect = function(): integer; stdcall;
  TFileBackCall = procedure(  // �ļ�����ص�
    bUpload: boolean;

    sFileName: PChar;
    sFileSize: PChar;
    sTransPercent: PChar;
    sTransSpeed: PChar;
    sLeaveTime: PChar;
    bStop: boolean      //�ļ�ֹͣ
  ); stdcall;

  // �򿪷���
  // sKey ��С40�ֽڣ���֤�룬��ʱ��ʹ��
  // sIP IP��ַ��һ̨���ӿ��ж��������Ҫָ��ʹ�õ�IP
  // nPort �˿ں�
  // ����ֵ��0 �ɹ�; -1 ��֤����Ч - 2������Ч
  TOpen = function(
    sKey: PChar;
    sIP: PChar; //nIPLen: integer;
    nPort: integer;
    BC: TBackCall;
    DisConnectBC: TDisConnectBackCall;
    ReConnectBC: TReConnectBackCall;
    FileBackCall: TFileBackCall
  ): integer; stdcall;

  //�رշ���
  TClose = procedure; stdcall;

  // �˳���
  TExit = procedure; stdcall;

  // ȡ��Ϣϵͳ
  TGetSysInfo = function(pBuffer: PChar; nLen: integer): integer; stdcall;

  // ��������
  // ����ֵ��0 �ɹ�
  TSend = function(pData: PChar; nLen: integer): integer; stdcall;
  TSend_Cmd = function(pData: PChar; nLen, nCmd: integer): integer; stdcall;

  // �Ƿ�����
  TIsActive = function: boolean; stdcall;

  // ����ֵ����汾
  TGetEdition = function: PChar; stdcall;

  // �ļ��Զ�����
  TAutoFileDown = procedure; stdcall;

  // �ļ��ϴ�
  TUploadFile = function(sServerFile: PChar; sClientFile: PChar): integer; stdcall;
  TDownloadFile = function(sServerFile: PChar; sClientFile: PChar): integer; stdcall;
  TDeleteFileFinishStateInfo = procedure(sFileName: PChar); stdcall;

  // ��ͣ�ļ�
  TPauseFile = procedure(sClientFile: PChar; bPause, bUpload: boolean); stdcall;

  // ֹͣ�ļ�
  TStopFile = procedure(sClientFile: PChar; bUpload: boolean); stdcall;

  // �Ƿ����
  TIsUpdateSoft = function(sSoftName, sClientPath: PChar; nV: integer): integer; stdcall;

  TOnReconnect = procedure;
  TShowLog = procedure(); stdcall;

  TGetFileTransStateInfo = function(sFileName: PChar;
    out bFinish: boolean;
    out nFileSize, nTrans: Cardinal; out nError: integer): boolean; stdcall;

  TNet_p_xml_GetParam = function: PChar; stdcall;
  TNet_p_xml_SetParam = procedure(sParam: PChar); stdcall;

////////////////////////////////////////////////////////////////////////////////

  TFileClientDllBase = class(TObject)
  private
    //m_UseMsgTimer: boolean;
    m_sResult: string;
    // ��CallSig��Ϣ
    m_MsgCall: TStringList;
    m_Timer_GetMsg: TTimer;  // ��ʱȡ����

    m_Ini: TIniFile;
    // Զ�̵��õ����ȴ���ʱ�Ķ�ʱ��⣬�����ʱ��Ч���ر�ʱ��Ч
    m_Timer_Wait: TTimer;
    // ��ʱ����Ƿ��յ�����
    // ����رմ��壬���յ����ý��ʱ��ɾ�������������
      procedure Timer_NetTimer(Sender: TObject);
      // ��ʱ������
      procedure OnTimer_GetMsg(Sender: TObject);
      // �����ݲ���
      // ��OnTimer_GetMsg��p_WaitFor�е���
      procedure p_DoGetMsg;

    function p_GetRData: pointer;
    function p_GetRLen: integer;
    // ��������Ƿ��յ�(�ʵ�ؿ�����޸�)
    function p_YDHK_WaitCheck: boolean;
    // ��������Ƿ��յ����յ���رն�ʱ��
    function p_WaitCheck: boolean;
    // Զ�̵��õȴ���
    // ����ֵ��STATUS_TIMEOUT/��ʱ��0/û��ʱ��������
    function p_YDHK_WaitFor(ms: integer): integer;  // ; out RData: variant
    // Զ�̵��õȴ���
    // ����ֵ��STATUS_TIMEOUT/��ʱ��0/û��ʱ��������
    function p_WaitFor(ms: integer): integer;  // ; out RData: variant

    // ���ݽӿ�
    function p_GetMsgCount_In: integer;
    function p_GetMsgData_In(nIndex: integer; out sData: string): boolean;
    procedure p_DeleteMsgData_In(nIndex: integer);
  protected
    function p_DoOpen: integer; virtual; abstract;
  private
    FBC: TBackCall;
    FDisConnectBC: TDisConnectBackCall;
    FReConnectBC: TReConnectBackCall;
    FFileBackCall: TFileBackCall;

    //
    m_Frm_Wait: TFrm_WaitFor;
    m_tr: IDataBlock;
    m_OnReconnect: TOnReconnect;

    //
    m_Send: TSend;
    m_Send_Cmd: TSend_Cmd;

    m_IsActive: TIsActive;
    m_GetEdition: TGetEdition;
    m_AutoFileDown: TAutoFileDown;
    m_UploadFile: TUploadFile;
    m_DownloadFile: TDownloadFile;
    m_DeleteFileFinishStateInfo: TDeleteFileFinishStateInfo;
    m_PauseFile: TPauseFile;
    m_StopFile: TStopFile;
    m_ShowLog: TShowLog;
    m_IsUpdateSoft: TIsUpdateSoft;
    m_GetSysInfo: TGetSysInfo;
    m_GetFileTransStateInfo: TGetFileTransStateInfo;

    //
    m_SetSaveMsg: TNet_SetSaveMsg;
    m_GetMsgCount: TNet_GetMsgCount;
    m_GetMsgData: TNet_GetMsgData;
    m_DeleteMsgData: TNet_DeleteMsgData;

    m_xml_GetParam: TNet_p_xml_GetParam;
    m_xml_SetParam: TNet_p_xml_SetParam;
  public
    constructor Create(bUseMsgTimer: boolean);            overload;
    constructor Create(bUseMsgTimer: boolean;bWaitForm: Boolean);  overload;        //(�ʵ�ؿ��޸�)
    destructor Destroy; override;
  public
    // New Send
    function p_Send_Cmd(nCmd: integer; const s: string): integer;
    function p_SendVariantTo(sock: integer; const sName: string; const Data: variant; Sig: Integer): integer;
    function p_SendStrTo(sock: integer; pData: PChar; nLen: integer): integer;

    // �첽������������
    // const Data; ���ֲ�����ʽ��Data������ʵ�壬������ָ��
    function p_SendDataPL(const Data; nLen: integer): integer;
    function p_SendVariant(Data: Variant): integer;

        // ���͵���ԭʼ���ݣ����Ǳ���
    function p_SendData(const s: string): integer; overload;
    // δ�����򲻷���
    function p_SendData_OnActive(const s: string): integer; overload;
        // ���͵��Ǳ���
    function p_SendData(const sName: string; const Data: variant): boolean; overload;
    
    // δ�����򲻷���
    function p_SendData_OnActive(const sName: string; const Data: variant): boolean; overload;
    function p_SendData_Sys(const sSys, sName: string; const Data: variant): boolean;
    // end

    // ͬ��������������(�ʵ�ؿ�����޸�)
    function p_YDHK_CallWait(pData: pointer; nLen: integer; out RData: variant; bHint: boolean): boolean;
    // ͬ��������������
    function p_CallWait(pData: pointer; nLen: integer; out RData: variant; bHint: boolean): boolean;
    function p_CallSendBC(pData: pointer; nLen: integer; out pRData: pointer; out nRLen: integer): boolean;
    //��������(�ʵ�ؿ�����޸�)
    function p_YDHK_SendWait(const sName: string; Data: variant; out RData: variant; bHint: boolean): boolean;
    //
    function p_SendWait(const sName: string; Data: variant; out RData: variant; bHint: boolean): boolean;
    function p_SendWait_Sys(const sSys, sName: string; Data: variant; out RData: variant; bHint: boolean): boolean;
    // ���ڽ�����ҵ��
    function Execute(
      const FLoginID, FunID, ConClassName, BusClassName, BusServerName: string;
      Data: variant; out bOk: boolean; bHint: boolean = true): variant;
    // end

    // RData�����ն˷���ԭʼ���ݣ��ѽ��
    function p_TouchAskPlayer(const sMachine: string; Data: variant; out RData: variant): boolean;
    function p_IsActive: boolean;
    function p_GetEdition: string;

    // �ļ�����
    procedure p_AutoFileDown;
    function p_UploadFile(const sServerFile: string; const sClientFile: string): integer;
    function p_DownloadFile(const sServerFile: string; const sClientFile: string): integer;
    procedure p_DeleteFileFinishStateInfo(const sFileName: string);
    // ȫ��
    procedure p_PauseFile(sClientFile: string; bPause, bUpload: boolean);
    // ȫ��
    procedure p_StopFile(sClientFile: string; bUpload: boolean);
    procedure p_ShowLog;

    function p_IsUpdateSoft(sSoftName: PChar): integer;
    function p_GetSysInfo(pBuffer: PChar; nLen: integer): integer;

    function p_GetFileTransStateInfo(sFileName: string;
      out bFinish: boolean;
      out nFileSize, nTrans: Cardinal; out nError: integer): boolean;

    // ���ݽӿ�
    function p_GetMsgCount: integer;
    function p_GetMsgData(nIndex: integer; out sData: string): boolean;
    procedure p_DeleteMsgData(nIndex: integer);

    //
    procedure p_SetSaveMsg(b: boolean; BC: TNet_MsgBackCall);
    function p_xml_GetParam: string;
    procedure p_xml_SetParam(const sParam: string); overload;
    procedure p_xml_SetParam(IsSendHeart: string; HeartTimer: string; ReConnectOfHeart: string); overload;
  public
    property OnReconnect: TOnReconnect write m_OnReconnect;
    property pt_RData: pointer read p_GetRData;
    property pt_RLen: integer read p_GetRLen;
  end;

  TFileClientDll = class(TFileClientDllBase)
  private
    FKey: string;
    FIP: string;
    FPort: integer;
    m_hDll: Cardinal;

    m_Open: TOpen;
    m_Close: TClose;
    m_Exit: TExit;
  private
    function p_Check(b: boolean; const sFun: string): boolean;
  protected
    function p_DoOpen: integer; override;
  public
    function p_LinkToServer(
      sKey: string;
      sIP: string;
      nPort: integer;
      //nBlockSize: integer;
      BC: TBackCall;
      DisConnectBC: TDisConnectBackCall;
      ReConnectBC: TReConnectBackCall;
      FileBackCall: TFileBackCall;
      bBC: boolean
    ): integer;
    procedure p_Close;
    procedure p_Exit;
  public
    constructor Create(const sDllFileName: string = ''; bUseMsgTimer: boolean = true);             overload;
    constructor Create(const sDllFileName: string ; bUseMsgTimer: boolean;bWaitForm: Boolean);    overload; //(�ʵ�ؿ��޸�)
    destructor Destroy; override;
  end;

  TFileClientDll_Bus = class(TFileClientDll)
  public
    constructor Create(const sDllFileName: string = '');
    destructor Destroy; override;
  end;

var
  g_bFileClientDll_WaitForResultSig: boolean = false;

const
  C_SocketDll = 'NetClient.dll';
  C_SocketDll_D = 'NetClient_D.dll';
  C_SocketDll_2 = 'NetClient_2.dll';

  C_SocketDll_UpdateSoft = 'UpdateClient.dll';

implementation

uses InitSock, NetDataDef, AppDllDef, _NetFun, RunLog;

var
  g_BC: TBackCall;  // �����ⲿ��p_BackCall�����ڲ���p_BackCall�е���
  m_WaitEvent: Cardinal;
  g_RData: variant;
  g_bWait: boolean = false;
  g_tr: IDataBlock;
  //g_Frm_Wait: TFrm_WaitFor;

  m_bActive: boolean = false;

const
  c_XXX_Execute = 'XXX_Execute';  // ֻ�ڡ�ģ��|ҵ��|����|��������ϼ�ͬ����ʽ��ʹ��
  c_LibFolderName = 'file';  //��Ƶ���Ͽ�
  c_WairtTime = 5000;

const
  c_Path = 'SoftUpdate\';

var
  g_RFileData: string;

{ TFileClientDllBase }

{procedure p_OnMsg(pData: PChar; nLen: integer);
var
  nType: Cardinal;
begin
  if nLen < 1 then exit;
  nType := p_NetDta_GetValue(pData, nLen);

  case nType of
    InitSock.CallSig, InitSock.ResultSig:  //
    begin
      try
        p_StreamToVariant(g_RData, g_tr, pData, nLen);
        SetLength(g_sCallSendResult, nLen);
        Move(pData^, g_sCallSendResult[1], nLen);
      except
      end;
    end;
  end;

  //RunLog.p_RunLog('�յ�������', true);
  SetEvent(m_WaitEvent);
  if g_Frm_Wait <> nil then
    g_Frm_Wait.p_Finish;
end;}

constructor TFileClientDllBase.Create(bUseMsgTimer: boolean);
begin
  m_WaitEvent := CreateEvent(nil, true, false, nil);
  m_tr := TDataBlock.Create;

  m_Frm_Wait := TFrm_WaitFor.Create(nil);
  //g_Frm_Wait := m_Frm_Wait;
  m_bActive := false;

  m_Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + c_Path + 'Update.ini');

  m_sResult := '';
  m_MsgCall := TStringList.Create();

  //
  if bUseMsgTimer then
  begin
    m_Timer_Wait := TTimer.Create(nil);
    m_Timer_Wait.Enabled := false;
    m_Timer_Wait.Interval := 100;
    m_Timer_Wait.OnTimer := Timer_NetTimer;

    //
    m_Timer_GetMsg := TTimer.Create(nil);
    m_Timer_GetMsg.Enabled := True;
    m_Timer_GetMsg.Interval := 100;
    m_Timer_GetMsg.OnTimer := OnTimer_GetMsg;
  end;
end;

destructor TFileClientDllBase.Destroy;
begin
  m_tr := nil;
  CloseHandle(m_WaitEvent);

  m_MsgCall.Free;

  m_Frm_Wait.Free;
  //g_Frm_Wait := nil;
  m_Ini.Free;

  if m_Timer_Wait <> nil then m_Timer_Wait.Free;
  if m_Timer_GetMsg <> nil then m_Timer_GetMsg.Free;
  inherited;
end;

procedure TFileClientDllBase.p_AutoFileDown;
begin
  if Assigned(m_AutoFileDown) then
  begin
    m_AutoFileDown;
  end;
end;

function TFileClientDllBase.p_GetEdition: string;
begin
  if Assigned(m_GetEdition) then
    Result := m_GetEdition
  else
    Result := '';  
end;

function TFileClientDllBase.p_IsActive: boolean;
begin
  if Assigned(m_IsActive) then
    Result := m_IsActive
  else
    Result := false;  
end;

function TFileClientDllBase.p_SendData(const sName: string; const Data: variant): boolean;
var
  s: string;
begin
  Result := false;

  if Assigned(m_Send) then
  begin
    {if SameText(sName, c_XXX_Execute) then
    begin
      Application.MessageBox(PChar('��Ч�ĵ��ã�' + sName), '��ʾ��Ϣ', MB_ICONINFORMATION);
      exit;
    end;}

    if not p_VariantToStream(s, VarArrayOf([sName, Data]), m_tr) then exit;
    Result := p_SendDataPL(s[1], Length(s)) = 0;
  end;
end;

function TFileClientDllBase.p_SendWait(const sName: string; Data: variant;
  out RData: variant; bHint: boolean): boolean;
var
  s: string;
begin
  Result := false;

  if Assigned(m_Send) then
  begin
    if SameText(sName, c_XXX_Execute) then
    begin
      Application.MessageBox(PChar('��Ч�ĵ��ã�' + sName), '��ʾ��Ϣ', MB_ICONINFORMATION);
      exit;
    end;

    if not p_VariantToStream(s, VarArrayOf([sName, Data]), m_tr) then exit;
    Result := p_CallWait(PChar(s), Length(s), RData, bHint);
  end;
end;

function TFileClientDllBase.p_UploadFile(const sServerFile: string; const sClientFile: string): integer;
begin
  Result := -1;
  if Assigned(m_UploadFile) then
  begin
    Result := m_UploadFile(PChar(sServerFile), PChar(sClientFile));
  end;
end;

function TFileClientDllBase.p_SendData(const s: string): integer;
begin
  Result := -2;
  if Assigned(m_Send) then
  begin
    Result := p_SendDataPL(s[1], Length(s));
  end;
end;

// RData[0] = 1(����Դ�ڷ����)��Ŀ�����ߣ�Data[1]��Ч��
// RData[0] = 0(����Դ��Ŀ��)��Ŀ�����ߣ�RData[1]ΪĿ��ķ���ֵ
function TFileClientDllBase.p_TouchAskPlayer(const sMachine: string;
  Data: variant; out RData: variant): boolean;
var
  RD: variant;
begin
  Result := p_SendWait('p_TouchAskPlayer', VarArrayOf([sMachine, Data]), RD, true);
  if Result then
    RData := RD[1];
end;

function TFileClientDllBase.p_DownloadFile(const sServerFile,
  sClientFile: string): integer;
var
  sLocal: string;
begin
  Result := -1;
  if Assigned(m_DownloadFile) then
  begin
    if Pos(':', sClientFile) > 0 then
      sLocal := sClientFile
    else
      sLocal := ExtractFilePath(Application.ExeName) + c_LibFolderName + '\' + sClientFile;

    Result := m_DownloadFile(PChar(sServerFile), PChar(sLocal));
  end;
end;

procedure TFileClientDllBase.p_PauseFile(sClientFile: string; bPause,
  bUpload: boolean);
begin
  if Assigned(m_PauseFile) then
  begin
    m_PauseFile(PChar(sClientFile), bPause, bUpload);
  end;
end;

procedure TFileClientDllBase.p_StopFile(sClientFile: string; bUpload: boolean);
begin
  if Assigned(m_PauseFile) then
  begin
    m_StopFile(PChar(sClientFile), bUpload);
  end;
end;

function TFileClientDllBase.p_CallWait(pData: pointer; nLen: integer;
  out RData: variant; bHint: boolean): boolean;
var
  n: integer;
  r: integer;
begin
    Result := false;

    //
    g_bWait := true;
    ResetEvent(m_WaitEvent);  // ��
    r := m_Send(pData, nLen);
    if r <> 0 then
    begin
      if not bHint then exit;
      //if Application.MessageBox('����ʧ�ܣ��Ƿ�����������', '��ʾ��Ϣ', MB_ICONINFORMATION + MB_YESNO) = IDNO then exit;
      if p_DoOpen <> 0 then
      begin
        Application.MessageBox('���ӷ�����ʧ��', '��ʾ��Ϣ', MB_ICONINFORMATION);
        exit;
      end;

      if Assigned(m_OnReconnect) then
        m_OnReconnect;
      r := m_Send(pData, nLen);
      if r <> 0 then exit;  // �ط�
    end;

    //n := WaitForSingleObject(m_WaitEvent, c_WairtTime);  //INFINITE
    n := self.p_WaitFor(c_WairtTime);
    if n = WAIT_TIMEOUT then
    begin
      Result := self.m_Frm_Wait.p_WairtFor;
    end
    else
      Result := true;

    if Result then
    begin
      RData := g_RData;
      if self.m_Frm_Wait <> nil then
        self.m_Frm_Wait.p_Finish;
    end;

    g_bWait := false;
end;

function TFileClientDllBase.Execute(const FLoginID, FunID, ConClassName,
  BusClassName, BusServerName: string; Data: variant;
  out bOk: boolean; bHint: boolean): variant;
var
  s: string;
begin
  Result := null;

  //if m_bExit then exit;
  if Assigned(m_Send) then
  begin
    if not p_VariantToStream(s,
      VarArrayOf([c_XXX_Execute, FLoginID, FunID, ConClassName, BusClassName, BusServerName, Data]), m_tr) then exit;
    bOk := p_CallWait(PChar(s), Length(s), Result, bHint);
  end;
end;

procedure TFileClientDllBase.Timer_NetTimer(Sender: TObject);
begin
  if p_WaitCheck then
  begin
    if m_Frm_Wait <> nil then
      m_Frm_Wait.p_Finish;
  end;
end;

function TFileClientDllBase.p_GetRData: pointer;
begin
  Result := PChar(g_RFileData);
end;

function TFileClientDllBase.p_GetRLen: integer;
begin
  Result := Length(g_RFileData);
end;

function TFileClientDllBase.p_SendDataPL(const Data;
  nLen: integer): integer;
begin
  Result := -2;
  if Assigned(m_Send) then
  begin
    Result := m_Send(@Data, nLen);

    if Result <> 0 then
    begin
      if p_DoOpen <> 0 then
      begin
        //Application.MessageBox('���ӷ�����ʧ��', '��ʾ��Ϣ', MB_ICONINFORMATION);
        exit;
      end;

      if Assigned(m_OnReconnect) then
        m_OnReconnect;
      Result := m_Send(@Data, nLen);
    end;
  end;
end;

function TFileClientDllBase.p_SendVariant(Data: Variant): integer;
var
  s: string;
begin
  Result := -2;

  if Assigned(m_Send) then
  begin
    if not p_VariantToStream(s, Data, m_tr) then exit;
    p_SendDataPL(s[1], Length(s));
  end;
end;

function TFileClientDllBase.p_CallSendBC(pData: pointer; nLen: integer;
  out pRData: pointer; out nRLen: integer): boolean;
var
  n, r: integer;
begin
    Result := false;

    //
    g_bWait := true;
    ResetEvent(m_WaitEvent);  // ��
    r := m_Send(pData, nLen);
    if r <> 0 then
    begin
      if p_DoOpen <> 0 then
      begin
        Application.MessageBox('���ӷ�����ʧ��', '��ʾ��Ϣ', MB_ICONINFORMATION);
        exit;
      end;

      if Assigned(m_OnReconnect) then
        m_OnReconnect;
      r := m_Send(pData, nLen);
      if r <> 0 then exit;  // �ط�
    end;

    //n := WaitForSingleObject(m_WaitEvent, c_WairtTime);  //INFINITE
    n := p_WaitFor(c_WairtTime);
    if n = WAIT_TIMEOUT then
    begin
      Result := self.m_Frm_Wait.p_WairtFor;
    end
    else
      Result := true;

    if Result then
    begin
      pRData := PChar(g_sCallSendResult);
      nRLen := Length(g_sCallSendResult);
    end;

    g_bWait := false;
end;

procedure TFileClientDllBase.p_ShowLog;
begin
  if Assigned(m_ShowLog) then
  begin
    m_ShowLog();
  end;
end;

function TFileClientDllBase.p_IsUpdateSoft(sSoftName: PChar): integer;
var
  nV: integer;
begin
  Result := 0;
  if Assigned(m_IsUpdateSoft) then
  begin
    nV := m_Ini.ReadInteger('UpdateSoft', 'LastVersion', 1);
    Result := m_IsUpdateSoft(sSoftName, '', nV);
  end;
end;

function TFileClientDllBase.p_GetSysInfo(pBuffer: PChar;
  nLen: integer): integer;
begin
  Result := 0;
  if Assigned(m_GetSysInfo) then
  begin
    Result := m_GetSysInfo(pBuffer, nLen);
  end;
end;

function TFileClientDllBase.p_SendWait_Sys(const sSys, sName: string;
  Data: variant; out RData: variant; bHint: boolean): boolean;
begin
  Result := p_SendWait(sSys + ',' + sName, Data, RData, bHint);
end;

function TFileClientDllBase.p_SendData_Sys(const sSys, sName: string;
  const Data: variant): boolean;
begin
  Result := p_SendData(sSys + ',' + sName, Data);
end;

function TFileClientDllBase.p_SendData_OnActive(const s: string): integer;
begin
  Result := -2;
  if not self.p_IsActive then exit;

  if Assigned(m_Send) then
  begin
    Result := p_SendDataPL(s[1], Length(s));
  end;
end;

function TFileClientDllBase.p_SendData_OnActive(const sName: string;
  const Data: variant): boolean;
var
  s: string;
begin
  Result := false;
  if not self.p_IsActive then exit;
  
  if Assigned(m_Send) then
  begin
    if not p_VariantToStream(s, VarArrayOf([sName, Data]), m_tr) then exit;
    Result := p_SendDataPL(s[1], Length(s)) = 0;
  end;
end;

function TFileClientDllBase.p_GetFileTransStateInfo(sFileName: string;
  out bFinish: boolean;
  out nFileSize, nTrans: Cardinal; out nError: integer): boolean;
begin
  if Assigned(m_GetFileTransStateInfo) then
  begin
    Result := m_GetFileTransStateInfo(PChar(sFileName), bFinish, nFileSize, nTrans, nError);
  end
  else
    Result := false;
end;

procedure TFileClientDllBase.p_DeleteMsgData_In(nIndex: integer);
begin
  if Assigned(m_DeleteMsgData) then
    m_DeleteMsgData(nIndex);
end;

function TFileClientDllBase.p_GetMsgCount_In: integer;
begin
  if Assigned(m_GetMsgCount) then
    Result := m_GetMsgCount()
  else
    Result := 0;  
end;

function TFileClientDllBase.p_GetMsgData_In(nIndex: integer; out sData: string): boolean;
var
  s: string;
  pData: pointer;
  nLen: integer;
begin
  Result := false;

  if Assigned(m_GetMsgData) then
  begin
    if m_GetMsgData(nIndex, pData, nLen) then
    begin
      SetLength(s, nLen);
      Move(pData^, s[1], nLen);
      sData := s;
      Result := true;
    end;
  end;
end;

procedure TFileClientDllBase.p_SetSaveMsg(b: boolean; BC: TNet_MsgBackCall);
begin
  if Assigned(m_SetSaveMsg) then
    m_SetSaveMsg(b, BC);
end;

function TFileClientDllBase.p_WaitFor(ms: integer): integer;
var
  n: integer;
const
  c_ms = 100;
begin
  m_sResult := '';
  
  Result := 0;
  n := 0;
  while n <= ms do
  begin
    Sleep(c_ms);
    p_DoGetMsg;  // Ҳ����һ�Σ���Ȼ����
    if p_WaitCheck then exit;

    Inc(n, c_ms);
  end;

  Result := STATUS_TIMEOUT;
  self.m_Timer_Wait.Enabled := true;
end;

function TFileClientDllBase.p_WaitCheck: boolean;
{var
  j: integer;
  nType: Cardinal;
  s, sData: string;
  pData: PChar;
  nLen: integer;
begin
  Result := false;
  while p_GetMsgCount_In > 0 do
  begin
    for j := 0 to p_GetMsgCount_In - 1 do
    begin
      if not self.p_GetMsgData_In(j, s) then continue;
      pData := PChar(s);
      nLen := Length(s);
      self.p_DeleteMsgData_In(j);  // ��������ˣ�Ҫɾ��

      if nLen >= sizeof(Cardinal) then
      begin
        nType := p_NetDta_GetValue(pData, nLen);
        case nType of
          InitSock.CallSig, InitSock.ResultSig:  //
          begin
            try
              p_StreamToVariant(g_RData, g_tr, pData, nLen);
              SetLength(g_sCallSendResult, nLen);  // use in p_CallSendBC
              Move(pData^, g_sCallSendResult[1], nLen);
              Result := true;
              exit;
            except
            end;
          end;
        end;
      end;  // end if
    end;
  end;
end;}
begin
  Result := false;
  if self.m_sResult <> '' then
  begin
    m_Timer_Wait.Enabled := false;

    try
      p_StreamToVariant(g_RData, g_tr, PChar(m_sResult), Length(m_sResult));
      g_sCallSendResult := self.m_sResult;
      m_sResult := ''; // �����˾����
      Result := true;
    except
    end;
  end;
end;

function TFileClientDllBase.p_xml_GetParam: string;
begin
  if Assigned(m_xml_GetParam) then
    Result := m_xml_GetParam()
  else
    Result := '';  
end;

procedure TFileClientDllBase.p_xml_SetParam(const sParam: string);
begin
  if Assigned(m_xml_SetParam) then
    m_xml_SetParam(PChar(sParam));
end;

procedure TFileClientDllBase.OnTimer_GetMsg(Sender: TObject);
begin
  p_DoGetMsg;
end;

procedure TFileClientDllBase.p_DeleteMsgData(nIndex: integer);
begin
  if (nIndex >= 0) and (nIndex < m_MsgCall.Count) then
    m_MsgCall.Delete(nIndex);
end;

function TFileClientDllBase.p_GetMsgCount: integer;
begin
  Result := m_MsgCall.Count;
end;

function TFileClientDllBase.p_GetMsgData(nIndex: integer;
  out sData: string): boolean;
begin
  Result := (nIndex >= 0) and (nIndex < m_MsgCall.Count);
  if Result then sData := m_MsgCall[nIndex];
end;

procedure TFileClientDllBase.p_DoGetMsg;
var
  b: boolean;
  nType: Cardinal;
  s, sData: string;
  pData: PChar;
  nLen: integer;
begin
  if not self.p_IsActive then exit;

  while p_GetMsgCount_In > 0 do
  begin
      b := self.p_GetMsgData_In(0, s);
      p_DeleteMsgData_In(0);  // ��������ˣ�Ҫɾ��
      if not b then continue;
      
      pData := PChar(s);
      nLen := Length(s);

      if nLen >= sizeof(Cardinal) then
      begin
        nType := p_NetDta_GetValue(pData, nLen);
        case nType of
          InitSock.ResultSig:  // InitSock.CallSig,
          begin
            self.m_sResult := s;
          end;
          else
          begin
            self.m_MsgCall.Add(s);
          end;
        end;  // end case
      end;  // end if
  end;
end;

procedure TFileClientDllBase.p_xml_SetParam(IsSendHeart: string;
  HeartTimer: string; ReConnectOfHeart: string);
begin
  p_xml_SetParam('<Set>'
    + '<IsSendHeart>' + IsSendHeart + '</IsSendHeart>'
    + '<HeartTimer>' + HeartTimer + '</HeartTimer>'
    + '<ReConnectOfHeart>' + ReConnectOfHeart + '</ReConnectOfHeart>'
    + '</Set>');
end;

{ TFileClientDll }

constructor TFileClientDll.Create(const sDllFileName: string; bUseMsgTimer: boolean);
var
  sFile: string;
begin
  inherited Create(bUseMsgTimer);

  m_hDll := 0;
  if sDllFileName = '' then
  begin
    sFile := ExtractFilePath(Application.ExeName) + C_SocketDll_2;
    if not FileExists(sFile) then
      sFile := ExtractFilePath(Application.ExeName) + C_SocketDll_D;
    if not FileExists(sFile) then
      sFile := ExtractFilePath(Application.ExeName) + C_SocketDll;
    if not FileExists(sFile) then
      sFile := ExtractFilePath(Application.ExeName) + C_SocketDll_UpdateSoft;
  end
  else
    sFile := ExtractFilePath(Application.ExeName) + sDllFileName;

  if not FileExists(sFile) then exit;
  m_hDll := LoadLibrary(PChar(sFile));
  if m_hDll = 0 then exit;

  m_Open := GetProcAddress(m_hDll, 'p_Open');
  m_Close := GetProcAddress(m_hDll, 'p_Close');
  m_Exit := GetProcAddress(m_hDll, 'p_Exit');
  m_Send := GetProcAddress(m_hDll, 'p_Send');
  m_Send_Cmd := GetProcAddress(m_hDll, 'p_Send_Cmd');

  m_IsActive := GetProcAddress(m_hDll, 'p_IsActive');
  m_GetEdition := GetProcAddress(m_hDll, 'p_GetEdition');
  m_AutoFileDown := GetProcAddress(m_hDll, 'p_AutoFileDown');

  m_UploadFile := GetProcAddress(m_hDll, 'p_UploadFile');
  m_DownloadFile := GetProcAddress(m_hDll, 'p_DownloadFile');
  m_DeleteFileFinishStateInfo := GetProcAddress(m_hDll, 'p_DeleteFileFinishStateInfo');

  m_PauseFile := GetProcAddress(m_hDll, 'p_PauseFile');
  m_StopFile := GetProcAddress(m_hDll, 'p_StopFile');
  m_ShowLog := GetProcAddress(m_hDll, 'p_ShowLog');
  m_IsUpdateSoft := GetProcAddress(m_hDll, 'p_IsNeedUpdate');
  m_GetSysInfo := GetProcAddress(m_hDll, 'p_GetSysInfo');
  m_GetFileTransStateInfo := GetProcAddress(m_hDll, 'p_GetFileTransStateInfo');

  //
  m_SetSaveMsg := GetProcAddress(m_hDll, 'p_SetSaveMsg');
  m_GetMsgCount := GetProcAddress(m_hDll, 'p_GetMsgCount');
  m_GetMsgData := GetProcAddress(m_hDll, 'p_GetMsgData');
  m_DeleteMsgData := GetProcAddress(m_hDll, 'p_DeleteMsgData');

  m_xml_GetParam := GetProcAddress(m_hDll, 'p_xml_GetParam');
  m_xml_SetParam := GetProcAddress(m_hDll, 'p_xml_SetParam');

  p_Check(Assigned(m_Open), 'p_Open');
  p_Check(Assigned(m_Close), 'p_Close');
  p_Check(Assigned(m_Send), 'p_Send');
  p_Check(Assigned(m_IsActive), 'p_IsActive');
  //p_Check(Assigned(m_UploadFile), 'p_UploadFile');
end;

destructor TFileClientDll.Destroy;
begin
  if m_hDll <> 0 then
  begin
    p_Close;
    p_Exit;
    FreeLibrary(m_hDll);
    m_hDll := 0;
  end;

  inherited;
end;

function TFileClientDll.p_Check(b: boolean; const sFun: string): boolean;
begin
  Result := b;
  if not b then
  begin
    raise Exception.Create(C_SocketDll + '�ӿ�' + sFun + '��Ч');
  end;
end;

procedure TFileClientDll.p_Close;
begin
  //if not m_bActive then exit;
  m_bActive := false;
  if Assigned(m_Close) then
  begin
    //m_bExit := true;
    m_Close;
  end;
end;

procedure TFileClientDll.p_Exit;
begin
  if Assigned(m_Exit) then
  begin
    m_Exit;
  end;
end;

function TFileClientDll.p_LinkToServer(
  sKey: string;
  sIP: string;
  nPort: integer;
  BC: TBackCall;
  DisConnectBC: TDisConnectBackCall;
  ReConnectBC: TReConnectBackCall;
  FileBackCall: TFileBackCall;
  bBC: boolean
): integer;
begin
  {if m_bActive then
  begin
    Result := 0;
    exit;
  end;}

  Result := -1;
  
  if p_IsActive then
  begin
    Result := 0;
    exit;
  end;

  g_BC := BC;
  Result := -2;
  //m_bExit := false;
  if sIP = c_LocalIP then
    sIP := G_LocalIP;

  if not bBC then
    self.p_SetSaveMsg(true, nil);

  if Assigned(m_Open) then
  begin
    FKey := sKey;
    FIP := sIP;
    FPort := nPort;
    //if bBC then FBC := p_BackCall;
    FDisConnectBC := DisConnectBC;
    FReConnectBC:= ReConnectBC;
    FFileBackCall := FileBackCall;

    Result := p_DoOpen;
    m_bActive := Result = 0;
  end;
end;

function TFileClientDll.p_DoOpen: integer;
begin
  Result := -1;
  if self.m_IsActive then
    self.p_Close;
  if Assigned(m_Open) then
  begin
    Result := m_Open(
      PChar(FKey),
      PChar(FIP),
      FPort,
      FBC,
      FDisConnectBC,
      FReConnectBC,
      FFileBackCall
    );

    // ��̬���ڲ����ã�����Ͳ��õ�����
    {if Result = 0 then
      if Assigned(FReConnectBC) then
        FReConnectBC;}
  end;
end;

procedure TFileClientDllBase.p_DeleteFileFinishStateInfo(const sFileName: string);
begin
  if Assigned(m_DeleteFileFinishStateInfo) then
  begin
    m_DeleteFileFinishStateInfo(PChar(sFileName));
  end;
end;

constructor TFileClientDll.Create(const sDllFileName: string; bUseMsgTimer,
  bWaitForm: Boolean);
var
  sFile: string;
begin
  inherited Create(bUseMsgTimer,bWaitForm);

  m_hDll := 0;
  if sDllFileName = '' then
  begin
    sFile := ExtractFilePath(Application.ExeName) + C_SocketDll_2;
    if not FileExists(sFile) then
      sFile := ExtractFilePath(Application.ExeName) + C_SocketDll_D;
    if not FileExists(sFile) then
      sFile := ExtractFilePath(Application.ExeName) + C_SocketDll;
    if not FileExists(sFile) then
      sFile := ExtractFilePath(Application.ExeName) + C_SocketDll_UpdateSoft;
  end
  else
    sFile := ExtractFilePath(Application.ExeName) + sDllFileName;

  if not FileExists(sFile) then exit;
  m_hDll := LoadLibrary(PChar(sFile));
  if m_hDll = 0 then exit;

  m_Open := GetProcAddress(m_hDll, 'p_Open');
  m_Close := GetProcAddress(m_hDll, 'p_Close');
  m_Exit := GetProcAddress(m_hDll, 'p_Exit');
  m_Send := GetProcAddress(m_hDll, 'p_Send');
  m_Send_Cmd := GetProcAddress(m_hDll, 'p_Send_Cmd');

  m_IsActive := GetProcAddress(m_hDll, 'p_IsActive');
  m_GetEdition := GetProcAddress(m_hDll, 'p_GetEdition');
  m_AutoFileDown := GetProcAddress(m_hDll, 'p_AutoFileDown');

  m_UploadFile := GetProcAddress(m_hDll, 'p_UploadFile');
  m_DownloadFile := GetProcAddress(m_hDll, 'p_DownloadFile');
  m_DeleteFileFinishStateInfo := GetProcAddress(m_hDll, 'p_DeleteFileFinishStateInfo');

  m_PauseFile := GetProcAddress(m_hDll, 'p_PauseFile');
  m_StopFile := GetProcAddress(m_hDll, 'p_StopFile');
  m_ShowLog := GetProcAddress(m_hDll, 'p_ShowLog');
  m_IsUpdateSoft := GetProcAddress(m_hDll, 'p_IsNeedUpdate');
  m_GetSysInfo := GetProcAddress(m_hDll, 'p_GetSysInfo');
  m_GetFileTransStateInfo := GetProcAddress(m_hDll, 'p_GetFileTransStateInfo');

  //
  m_SetSaveMsg := GetProcAddress(m_hDll, 'p_SetSaveMsg');
  m_GetMsgCount := GetProcAddress(m_hDll, 'p_GetMsgCount');
  m_GetMsgData := GetProcAddress(m_hDll, 'p_GetMsgData');
  m_DeleteMsgData := GetProcAddress(m_hDll, 'p_DeleteMsgData');

  m_xml_GetParam := GetProcAddress(m_hDll, 'p_xml_GetParam');
  m_xml_SetParam := GetProcAddress(m_hDll, 'p_xml_SetParam');

  p_Check(Assigned(m_Open), 'p_Open');
  p_Check(Assigned(m_Close), 'p_Close');
  p_Check(Assigned(m_Send), 'p_Send');
  p_Check(Assigned(m_IsActive), 'p_IsActive');
  //p_Check(Assigned(m_UploadFile), 'p_UploadFile');
end;

{ TFileClientDll_Bus }

constructor TFileClientDll_Bus.Create(const sDllFileName: string);
begin
  inherited Create(sDllFileName, false);
end;

destructor TFileClientDll_Bus.Destroy;
begin

  inherited;
end;

function TFileClientDllBase.p_SendVariantTo(sock: integer; const sName: string;
  const Data: variant; Sig: Integer): integer;
var
  sH, s: string;
  nProtocol: integer;
begin
  Result := -1;

  if Assigned(m_Send) then
  begin
    if not p_VariantToStream(s, VarArrayOf([sName, Data]), m_tr, Sig) then exit;

    SetLength(sH, 2 * sizeof(integer));
    Move(sock, sH[1], sizeof(integer));
    nProtocol := 0;
    Move(nProtocol, sH[1 + sizeof(integer)], sizeof(integer));
    s := sH + s;

    Result := p_SendDataPL(s[1], Length(s));
  end;
end;

function TFileClientDllBase.p_Send_Cmd(nCmd: integer;
  const s: string): integer;
begin
  Result := -2;
  if Assigned(m_Send_Cmd) then
  begin
    Result := m_Send_Cmd(PChar(s), Length(s), nCmd);
  end;
end;

function TFileClientDllBase.p_SendStrTo(sock: integer;
  pData: PChar; nLen: integer): integer;
var
  s: string;
  nProtocol: integer;
begin
  Result := -1;

  if Assigned(m_Send) then
  begin
    SetLength(s, 2 * sizeof(integer) + nLen);
    Move(sock, s[1], sizeof(integer));
    nProtocol := 0;
    Move(nProtocol, s[1 + sizeof(integer)], sizeof(integer));
    Move(pData^, s[1 + 2 * sizeof(integer)], nLen);

    Result := p_SendDataPL(s[1], Length(s));
  end;
end;

function TFileClientDllBase.p_YDHK_CallWait(pData: pointer; nLen: integer;
  out RData: variant; bHint: boolean): boolean;
const
  c_WaitTime = 1000;
var
  n: integer;
  r: integer;
begin
    Result := false;

    //
    g_bWait := true;
    //ResetEvent(m_WaitEvent);  // ��
    r := m_Send(pData, nLen);
    if r <> 0 then
    begin
      if not bHint then exit;
      //if Application.MessageBox('����ʧ�ܣ��Ƿ�����������', '��ʾ��Ϣ', MB_ICONINFORMATION + MB_YESNO) = IDNO then exit;
      if p_DoOpen <> 0 then
      begin
        Application.MessageBox('���ӷ�����ʧ��', '��ʾ��Ϣ', MB_ICONINFORMATION);
        exit;
      end;

      if Assigned(m_OnReconnect) then
        m_OnReconnect;
      r := m_Send(pData, nLen);
      if r <> 0 then exit;  // �ط�
    end;

    //n := WaitForSingleObject(m_WaitEvent, c_WairtTime);  //INFINITE
    n := self.p_YDHK_WaitFor(c_WaitTime);
    if n = WAIT_TIMEOUT then
    begin
      Result := False;
    end
    else
      Result := true;

    if Result then
    begin
      RData := g_RData;
    end;

    g_bWait := false;
end;

function TFileClientDllBase.p_YDHK_SendWait(const sName: string;
  Data: variant; out RData: variant; bHint: boolean): boolean;
var
  s: string;
begin
  Result := false;

  if Assigned(m_Send) then
  begin
    if SameText(sName, c_XXX_Execute) then
    begin
      Application.MessageBox(PChar('��Ч�ĵ��ã�' + sName), '��ʾ��Ϣ', MB_ICONINFORMATION);
      exit;
    end;

    if not p_VariantToStream(s, VarArrayOf([sName, Data]), m_tr) then exit;
    Result := p_YDHK_CallWait(PChar(s), Length(s), RData, bHint);
  end;
end;

function TFileClientDllBase.p_YDHK_WaitCheck: boolean;
begin
  Result := false;
  if self.m_sResult <> '' then
  begin
    try
      p_StreamToVariant(g_RData, g_tr, PChar(m_sResult), Length(m_sResult));
      g_sCallSendResult := self.m_sResult;
      m_sResult := ''; // �����˾����
      Result := true;
    except
    end;
  end;
end;

function TFileClientDllBase.p_YDHK_WaitFor(ms: integer): integer;
var
  n: integer;
const
  c_ms = 100;
begin
  m_sResult := '';
  
  Result := 0;
  n := 0;
  while n <= ms do
  begin
    Sleep(c_ms);
    p_DoGetMsg;  // Ҳ����һ�Σ���Ȼ����
    if p_YDHK_WaitCheck then exit;

    Inc(n, c_ms);
  end;

  Result := STATUS_TIMEOUT;
end;

constructor TFileClientDllBase.Create(bUseMsgTimer, bWaitForm: Boolean);
begin
  m_WaitEvent := CreateEvent(nil, true, false, nil);
  m_tr := TDataBlock.Create;

  if bWaitForm then
    m_Frm_Wait := TFrm_WaitFor.Create(nil);
  //g_Frm_Wait := m_Frm_Wait;
  m_bActive := false;

  m_Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + c_Path + 'Update.ini');

  m_sResult := '';
  m_MsgCall := TStringList.Create();

  //
  if bUseMsgTimer then
  begin
    m_Timer_Wait := TTimer.Create(nil);
    m_Timer_Wait.Enabled := false;
    m_Timer_Wait.Interval := 100;
    m_Timer_Wait.OnTimer := Timer_NetTimer;

    //
    m_Timer_GetMsg := TTimer.Create(nil);
    m_Timer_GetMsg.Enabled := True;
    m_Timer_GetMsg.Interval := 100;
    m_Timer_GetMsg.OnTimer := OnTimer_GetMsg;
  end;
end;

initialization
  g_tr := TDataBlock.Create;

finalization
  g_tr := nil;

end.

////////////////////////////////////////////////////////////////////////////////

