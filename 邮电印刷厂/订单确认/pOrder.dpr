program pOrder;

{$R 'Source\img.res' 'Source\img.rc'}

uses
  Forms,
  Windows,
  System,
  Controls,
  PostService in 'Source\PostService.pas',
  uBSTPrint in 'Source\uBSTPrint.pas' {Frm_BSTPrint},
  uDDCX_BZ in 'Source\uDDCX_BZ.pas' {Frm_DDCX_BZ},
  uDDMX_XSX in 'Source\uDDMX_XSX.pas' {Frm_DDMX_XSX},
  uFra_cplx_gl in 'Source\uFra_cplx_gl.pas' {Fra_cplx_gl: TFrame},
  uFra_DDJY_CX in 'Source\uFra_DDJY_CX.pas' {Fra_DDJY_CX: TFrame},
  uFra_DDLR in 'Source\uFra_DDLR.pas' {Fra_DDLR: TFrame},
  uFra_FHGL in 'Source\uFra_FHGL.pas' {Fra_FHGL: TFrame},
  uFra_FHGL_DYCX in 'Source\uFra_FHGL_DYCX.pas' {Fra_FHGL_DYCX: TFrame},
  uFra_Pwd_Modify in 'Source\uFra_Pwd_Modify.pas' {Fra_Pwd_Modify: TFrame},
  uFra_sctj in 'Source\uFra_sctj.pas' {Fra_sctj: TFrame},
  uFra_ywtj in 'Source\uFra_ywtj.pas' {Fra_ywtj: TFrame},
  uFraddcx in 'Source\uFraddcx.pas' {Fra_ddcx: TFrame},
  uFragdcx in 'Source\uFragdcx.pas' {fra_gdcx: TFrame},
  uFrakd in 'Source\uFrakd.pas' {Fra_kd: TFrame},
  uFraParamSet in 'Source\uFraParamSet.pas' {Fra_ParamSet: TFrame},
  uFrascgl in 'Source\uFrascgl.pas' {Fra_scgl: TFrame},
  uFratg in 'Source\uFratg.pas' {Fra_tg: TFrame},
  uFraUserAdd in 'Source\uFraUserAdd.pas' {Fra_UserAdd: TFrame},
  uFraWorkerManage in 'Source\uFraWorkerManage.pas' {Fra_WorkerManage: TFrame},
  uFraYZTGL in 'Source\uFraYZTGL.pas' {Fra_yztgl: TFrame},
  uFrm_DDJY in 'Source\uFrm_DDJY.pas' {Frm_DDJY},
  uFrm_FHGL_DY in 'Source\uFrm_FHGL_DY.pas' {Frm_FHGL_DY},
  uFrm_GDFK in 'Source\uFrm_GDFK.pas' {Frm_GDFK},
  uFrm_Tsgy_modif in 'Source\uFrm_Tsgy_modif.pas' {Frm_Tsgy_modif},
  uFrmFJ in 'Source\uFrmFJ.pas' {Frm_FJ},
  uFrmzbap in 'Source\uFrmzbap.pas' {Frm_zbap},
  uHBST in 'Source\uHBST.pas' {Frm_HBST},
  uLogin in 'Source\uLogin.pas' {Frm_Login},
  uMain in 'Source\uMain.pas' {Frm_Main},
  uPrint in 'Source\uPrint.pas' {Frm_Print},
  uPub_Type in 'Source\uPub_Type.pas',
  uUser_License in 'Source\uUser_License.pas' {Frm_User_License},
  uWrOdrPrint in 'Source\uWrOdrPrint.pas' {Frm_WrOdrPrint},
  FrmUpdateModuleCheck in 'Source\FrmUpdateModuleCheck.pas' {Frm_UpdateModuleCheck},
  UpdateClientDll in 'Source\UpdateClientDll.pas',
  uFrm_DDXG in 'Source\uFrm_DDXG.pas' {Frm_ddxg},
  uFrm_GDH_XZ in 'Source\uFrm_GDH_XZ.pas' {Frm_GDH_XZ},
  uFrm_zdgy in 'Source\uFrm_zdgy.pas' {Frm_zdgy},
  uPub_Text in 'Source\uPub_Text.pas',
  uFrm_LableGroup in 'Source\uFrm_LableGroup.pas' {Frm_LableGroup},
  uFra_XQCX in 'Source\uFra_XQCX.pas' {Fra_XQCX: TFrame},
  uFra_FHFK in 'Source\uFra_FHFK.pas' {Fra_FHFK: TFrame},
  uWorkOrder in 'Source\uWorkOrder.pas' {Frm_WorkOrder},
  uOrderList in 'Source\uOrderList.pas' {Frm_OrderList},
  uFrm_YSDH in 'Source\uFrm_YSDH.pas' {Frm_YSDH},
  uFrm_CL in 'Source\uFrm_CL.pas' {Frm_CL},
  uFrm_ZB in 'Source\uFrm_ZB.pas' {Frm_ZB},
  uFra_MatlManage in 'Source\uFra_MatlManage.pas' {Fra_MatlManage: TFrame},
  uMachineManage in 'Source\uMachineManage.pas' {Fra_MachineManage: TFrame},
  uFra_XHQD in 'Source\uFra_XHQD.pas' {Fra_XHQD: TFrame},
  uFra_CPLB_GL in 'Source\uFra_CPLB_GL.pas' {Fra_CPLB_GL: TFrame},
  uUser_Limit in 'Source\uUser_Limit.pas' {Frm_User_Limit},
  uFra_ZBGX_GL in 'Source\uFra_ZBGX_GL.pas' {Fra_ZBGX_GL: TFrame},
  uUser_Allow in 'Source\uUser_Allow.pas' {Frm_User_Allow},
  uPub_Func in 'Source\uPub_Func.pas',
  uDM_DataBase in 'Source\uDM_DataBase.pas' {DM_DataBase: TDataModule},
  uFra_ZBGXLB_GL in 'Source\uFra_ZBGXLB_GL.pas' {Fra_ZBGXLB_GL: TFrame},
  uDDMX_DZX in 'Source\uDDMX_DZX.pas' {Frm_DDMX_DZX},
  uFrm_WorkOrder_ZB in 'Source\uFrm_WorkOrder_ZB.pas' {Frm_WorkOrder_ZB},
  uFrm_WorkOrder_ZB_GXTJ in 'Source\uFrm_WorkOrder_ZB_GXTJ.pas' {Frm_WorkOrder_ZB_GXTJ},
  uFrm_WorkOrder_History in 'Source\uFrm_WorkOrder_History.pas' {Frm_WorkOrder_History},
  uFra_FYDHLR in 'Source\uFra_FYDHLR.pas' {Fra_FYDHLR: TFrame},
  uFrm_FHMX in 'Source\uFrm_FHMX.pas' {Frm_FHMX},
  u_Frm_FYDH_Add in 'Source\u_Frm_FYDH_Add.pas' {Frm_FYDH_Add},
  uFrm_ZTMX in 'Source\uFrm_ZTMX.pas' {Frm_ZTMX},
  uFrm_WorkOrder_RJHD in 'Source\uFrm_WorkOrder_RJHD.pas' {Frm_WorkOrder_RJHD},
  uFrm_SCGL_BFJC in 'Source\uFrm_SCGL_BFJC.pas' {Frm_SCGL_BFJC},
  uFra_FHTJ in 'Source\uFra_FHTJ.pas' {Fra_FHTJ: TFrame},
  uFra_CLTJ in 'Source\uFra_CLTJ.pas' {Fra_CLTJ: TFrame},
  uFrm_Select_ZBGX in 'Source\uFrm_Select_ZBGX.pas' {Frm_Select_ZBGX},
  uFrm_Select_CL in 'Source\uFrm_Select_CL.pas' {Frm_Select_CL},
  uFrm_Select_JT in 'Source\uFrm_Select_JT.pas' {Frm_Select_JT},
  uFra_JTTJ in 'Source\uFra_JTTJ.pas' {Fra_JTTJ: TFrame},
  uFra_WGYBB in 'Source\uFra_WGYBB.pas' {Fra_WGYBB: TFrame},
  uFra_CPYBB in 'Source\uFra_CPYBB.pas' {Fra_CPYBB: TFrame},
  uFrm_CLRK in 'Source\uFrm_CLRK.pas' {Frm_CLRK},
  uFra_CLRK in 'Source\uFra_CLRK.pas' {Fra_CLRK: TFrame},
  uFrm_Select in 'Source\uFrm_Select.pas' {Frm_Select},
  uFra_WYNJQD in 'Source\uFra_WYNJQD.pas' {Fra_WYNJQD: TFrame},
  uFrm_XQDYXG in 'Source\uFrm_XQDYXG.pas' {Frm_XQDYXG},
  uFrm_SelectDlg in 'Source\uFrm_SelectDlg.pas' {Frm_SelectDlg},
  uFrm_Remind in 'Source\uFrm_Remind.pas' {Frm_Remind},
  uFrm_ListView in 'Source\uFrm_ListView.pas' {Frm_ListView},
  FrmMain_New in '邮电印刷厂-界面\FrmMain_New.pas' {Frm_Main_New},
  U_FrmList in '邮电印刷厂-界面\U_FrmList.pas',
  PubDef in '邮电印刷厂-界面\PubDef.pas',
  uFrm_BulletinBoard in 'Source\uFrm_BulletinBoard.pas' {Frm_BulletinBoard},
  uFra_YSMDDY in 'Source\uFra_YSMDDY.pas' {Fra_YSMDDY: TFrame},
  uFrm_WorkOrder_DDTH in 'Source\uFrm_WorkOrder_DDTH.pas' {Frm_ddth},
  uFrm_FHGL_JZFS in 'Source\uFrm_FHGL_JZFS.pas' {Frm_FHGL_JZFS},
  uFrm_FHMX_YSDH in 'Source\uFrm_FHMX_YSDH.pas' {Frm_FHMX_YSDH},
  uFra_WarehEntryBarCode in 'Source\uFra_WarehEntryBarCode.pas' {Fra_WarehEntryBarCode: TFrame},
  uFra_DataArchiving in 'Source\uFra_DataArchiving.pas' {Fra_DataArchiving: TFrame},
  uFrm_DataArcProgress in 'Source\uFrm_DataArcProgress.pas' {Frm_DataArcProgress},
  FileClientDll in 'Source\FileClientDll.pas',
  NetDataDef in 'Source\NetDataDef.pas',
  InitSock in 'Source\InitSock.pas',
  U_FileMd5 in 'Source\U_FileMd5.pas',
  uFrm_TSGYGL in 'Source\uFrm_TSGYGL.pas' {Frm_TSGYGL},
  uFrm_TSGYGL_Dlg in 'Source\uFrm_TSGYGL_Dlg.pas' {Frm_TSGYGL_Dlg},
  uBaseForm in 'Source\uBaseForm.pas',
  uOrderRecoveryFrm in 'Source\YCXDDQD\uOrderRecoveryFrm.pas' {Frm_OrderRecovery},
  uYCXDDQDFrm in 'Source\YCXDDQD\uYCXDDQDFrm.pas' {Frm_YCXDDQD};

{$R *.res}
//var
//  StartupInfo:TStartupInfo;
//  ProcessInfo:TProcessInformation;


begin
  Application.Initialize;
  CreateMutex(nil,false,'邮电贺卡系统更新');
  if GetLastError<>Error_Already_Exists then
  begin
    FrmUpdateModuleCheck.p_Sys_UpdateModuleCheck('邮电贺卡系统');
    p_CheckUpdate('邮电贺卡系统','',False);
  end;
  DM_DataBase := TDM_DataBase.Create(Application);
  Frm_login := Tfrm_login.Create(Application);
  Application.Title := '邮电印刷厂';
  if Frm_login.ShowModal = mrok then
  begin
    Application.Title := '邮电印刷厂';
    Application.CreateForm(TFrm_Main, Frm_Main);
  //Application.CreateForm(TFrm_Main_New, Frm_Main_New);
  end;
  Frm_login.Free;
  Application.Run;

  (*
  //结束程序再运行
  FillChar(StartupInfo,Sizeof(StartupInfo),#0);
  StartupInfo.cb:=Sizeof(StartupInfo);
  if Frm_Main.g_bIsRunAgain then
  CreateProcess(nil,
    PChar(Application.exename),               { pointer to command line string }
    nil,                           { pointer to process security attributes }
    nil,                           { pointer to thread security attributes }
    False,                          { handle inheritance flag }
    NORMAL_PRIORITY_CLASS,
    nil,                           { pointer to new environment block }
    nil,                { pointer to current directory name, PChar}
    StartupInfo,                   { pointer to STARTUPINFO }
    ProcessInfo);                 { pointer to PROCESS_INF }
  *)
end.
