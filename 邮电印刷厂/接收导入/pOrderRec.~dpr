program pOrderRec;

uses
  Forms,
  SvcMgr,
  windows,
  Messages,
  uOrderRec in 'Source\uOrderRec.pas' {Frm_OrderRec},
  PostService in 'Source\PostService.pas',
  uFrm_PicPathDlg in 'Source\uFrm_PicPathDlg.pas' {Frm_PicPathDlg},
  uRunLoopService_Frm in 'Source\uRunLoopService_Frm.pas' {RunLoopServeiceFrm};


{$R *.res}
const
  CMutexName = '订单接收导入_Mutex';
var
  OneInstanceMutex: THandle;
//  SecMem: SECURITY_ATTRIBUTES;
//  aSD: SECURITY_DESCRIPTOR;
begin

//  InitializeSecurityDescriptor(@aSD, SECURITY_DESCRIPTOR_REVISION);
//  SetSecurityDescriptorDacl(@aSD, True, nil, False);
//  SecMem.nLength := SizeOf(SECURITY_ATTRIBUTES);
//  SecMem.lpSecurityDescriptor := @aSD;
//  SecMem.bInheritHandle := False;
  OneInstanceMutex := CreateMutex(nil, False, CMutexName);
  //CreateMutex(nil,false,CSMutexName);
  if GetLastError=Error_Already_Exists then
  begin
    CloseHandle(OneInstanceMutex);
  end else
  begin
    Forms.Application.Initialize;
    Forms.Application.Title := '订单接收导入';
    Forms.Application.CreateForm(TFrm_OrderRec, Frm_OrderRec);
    Forms.Application.Run;
  end;


end.
