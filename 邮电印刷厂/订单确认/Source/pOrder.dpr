program pOrder;

{$R 'img.res' 'img.rc'}

uses
  Forms,
  Windows,
  System,
  Controls,
  PostService in 'PostService.pas',
  uBSTPrint in 'uBSTPrint.pas' {Frm_BSTPrint},
  uDDCX_BZ in 'uDDCX_BZ.pas' {Frm_DDCX_BZ},
  uDDMX_XSX in 'uDDMX_XSX.pas' {Frm_DDMX_XSX},
  uFra_cplx_gl in 'uFra_cplx_gl.pas' {Fra_cplx_gl: TFrame},
  uFra_DDJY_CX in 'uFra_DDJY_CX.pas' {Fra_DDJY_CX: TFrame},
  uFra_DDLR in 'uFra_DDLR.pas' {Fra_DDLR: TFrame},
  uFra_FHGL in 'uFra_FHGL.pas' {Fra_FHGL: TFrame},
  uFra_FHGL_DYCX in 'uFra_FHGL_DYCX.pas' {Fra_FHGL_DYCX: TFrame},
  uFra_Pwd_Modify in 'uFra_Pwd_Modify.pas' {Fra_Pwd_Modify: TFrame},
  uFra_sctj in 'uFra_sctj.pas' {Fra_sctj: TFrame},
  uFra_ywtj in 'uFra_ywtj.pas' {Fra_ywtj: TFrame},
  uFraddcx in 'uFraddcx.pas' {Fra_ddcx: TFrame},
  uFragdcx in 'uFragdcx.pas' {fra_gdcx: TFrame},
  uFrakd in 'uFrakd.pas' {Fra_kd: TFrame},
  uFraParamSet in 'uFraParamSet.pas' {Fra_ParamSet: TFrame},
  uFrascgl in 'uFrascgl.pas' {Fra_scgl: TFrame},
  uFratg in 'uFratg.pas' {Fra_tg: TFrame},
  uFraUserAdd in 'uFraUserAdd.pas' {Fra_UserAdd: TFrame},
  uFraWorkerManage in 'uFraWorkerManage.pas' {Fra_WorkerManage: TFrame},
  uFraYZTGL in 'uFraYZTGL.pas' {Fra_yztgl: TFrame},
  uFrm_DDJY in 'uFrm_DDJY.pas' {Frm_DDJY},
  uFrm_FHGL_DY in 'uFrm_FHGL_DY.pas' {Frm_FHGL_DY},
  uFrm_GDFK in 'uFrm_GDFK.pas' {Frm_GDFK},
  uFrm_Tsgy_modif in 'uFrm_Tsgy_modif.pas' {Frm_Tsgy_modif},
  uFrmFJ in 'uFrmFJ.pas' {Frm_FJ},
  uFrmzbap in 'uFrmzbap.pas' {Frm_zbap},
  uHBST in 'uHBST.pas' {Frm_HBST},
  uLogin in 'uLogin.pas' {Frm_Login},
  uMain in 'uMain.pas' {Frm_Main},
  uPrint in 'uPrint.pas' {Frm_Print},
  uPub_Type in 'uPub_Type.pas',
  uUser_License in 'uUser_License.pas' {Frm_User_License},
  uWrOdrPrint in 'uWrOdrPrint.pas' {Frm_WrOdrPrint},
  FrmUpdateModuleCheck in 'FrmUpdateModuleCheck.pas' {Frm_UpdateModuleCheck},
  UpdateClientDll in 'UpdateClientDll.pas',
  uFrm_DDXG in 'uFrm_DDXG.pas' {Frm_ddxg},
  uFrm_GDH_XZ in 'uFrm_GDH_XZ.pas' {Frm_GDH_XZ},
  uFrm_zdgy in 'uFrm_zdgy.pas' {Frm_zdgy},
  uPub_Text in 'uPub_Text.pas',
  uFrm_LableGroup in 'uFrm_LableGroup.pas' {Frm_LableGroup},
  uFra_XQCX in 'uFra_XQCX.pas' {Fra_XQCX: TFrame},
  uFra_FHFK in 'uFra_FHFK.pas' {Fra_FHFK: TFrame},
  uWorkOrder in 'uWorkOrder.pas' {Frm_WorkOrder},
  uOrderList in 'uOrderList.pas' {Frm_OrderList},
  uFrm_YSDH in 'uFrm_YSDH.pas' {Frm_YSDH},
  uFrm_CL in 'uFrm_CL.pas' {Frm_CL},
  uFrm_ZB in 'uFrm_ZB.pas' {Frm_ZB},
  uFra_MatlManage in 'uFra_MatlManage.pas' {Fra_MatlManage: TFrame},
  uMachineManage in 'uMachineManage.pas' {Fra_MachineManage: TFrame},
  uFra_XHQD in 'uFra_XHQD.pas' {Fra_XHQD: TFrame},
  uFra_CPLB_GL in 'uFra_CPLB_GL.pas' {Fra_CPLB_GL: TFrame},
  uUser_Limit in 'uUser_Limit.pas' {Frm_User_Limit},
  uFra_ZBGX_GL in 'uFra_ZBGX_GL.pas' {Fra_ZBGX_GL: TFrame},
  uUser_Allow in 'uUser_Allow.pas' {Frm_User_Allow},
  uPub_Func in 'uPub_Func.pas',
  uDM_DataBase in 'uDM_DataBase.pas' {DM_DataBase: TDataModule},
  uFra_ZBGXLB_GL in 'uFra_ZBGXLB_GL.pas' {Fra_ZBGXLB_GL: TFrame},
  uDDMX_DZX in 'uDDMX_DZX.pas' {Frm_DDMX_DZX},
  uFrm_WorkOrder_ZB in 'uFrm_WorkOrder_ZB.pas' {Frm_WorkOrder_ZB},
  uFrm_WorkOrder_ZB_GXTJ in 'uFrm_WorkOrder_ZB_GXTJ.pas' {Frm_WorkOrder_ZB_GXTJ},
  uFrm_WorkOrder_History in 'uFrm_WorkOrder_History.pas' {Frm_WorkOrder_History},
  uFra_FYDHLR in 'uFra_FYDHLR.pas' {Fra_FYDHLR: TFrame},
  uFrm_FHMX in 'uFrm_FHMX.pas' {Frm_FHMX},
  u_Frm_FYDH_Add in 'u_Frm_FYDH_Add.pas' {Frm_FYDH_Add},
  uFrm_ZTMX in 'uFrm_ZTMX.pas' {Frm_ZTMX},
  uFrm_WorkOrder_RJHD in 'uFrm_WorkOrder_RJHD.pas' {Frm_WorkOrder_RJHD},
  uFrm_SCGL_BFJC in 'uFrm_SCGL_BFJC.pas' {Frm_SCGL_BFJC},
  uFra_FHTJ in 'uFra_FHTJ.pas' {Fra_FHTJ: TFrame},
  uFra_CLTJ in 'uFra_CLTJ.pas' {Fra_CLTJ: TFrame},
  uFrm_Select_ZBGX in 'uFrm_Select_ZBGX.pas' {Frm_Select_ZBGX},
  uFrm_Select_CL in 'uFrm_Select_CL.pas' {Frm_Select_CL},
  uFrm_Select_JT in 'uFrm_Select_JT.pas' {Frm_Select_JT},
  uFra_JTTJ in 'uFra_JTTJ.pas' {Fra_JTTJ: TFrame},
  uFra_WGYBB in 'uFra_WGYBB.pas' {Fra_WGYBB: TFrame},
  uFra_CPYBB in 'uFra_CPYBB.pas' {Fra_CPYBB: TFrame},
  uFrm_CLRK in 'uFrm_CLRK.pas' {Frm_CLRK},
  uFra_CLRK in 'uFra_CLRK.pas' {Fra_CLRK: TFrame},
  uFrm_Select in 'uFrm_Select.pas' {Frm_Select},
  uFra_WYNJQD in 'uFra_WYNJQD.pas' {Fra_WYNJQD: TFrame},
  uFrm_XQDYXG in 'uFrm_XQDYXG.pas' {Frm_XQDYXG},
  uFrm_SelectDlg in 'uFrm_SelectDlg.pas' {Frm_SelectDlg},
  uFrm_Remind in 'uFrm_Remind.pas' {Frm_Remind},
  uFrm_ListView in 'uFrm_ListView.pas' {Frm_ListView},
  FrmMain_New in '..\邮电印刷厂-界面\FrmMain_New.pas' {Frm_Main_New},
  U_FrmList in '..\邮电印刷厂-界面\U_FrmList.pas',
  PubDef in '..\邮电印刷厂-界面\PubDef.pas',
  uFrm_BulletinBoard in 'uFrm_BulletinBoard.pas' {Frm_BulletinBoard},
  uFra_YSMDDY in 'uFra_YSMDDY.pas' {Fra_YSMDDY: TFrame},
  uFrm_WorkOrder_DDTH in 'uFrm_WorkOrder_DDTH.pas' {Frm_ddth},
  uFrm_FHGL_JZFS in 'uFrm_FHGL_JZFS.pas' {Frm_FHGL_JZFS},
  uFrm_FHMX_YSDH in 'uFrm_FHMX_YSDH.pas' {Frm_FHMX_YSDH},
  uFra_WarehEntryBarCode in 'uFra_WarehEntryBarCode.pas' {Fra_WarehEntryBarCode: TFrame},
  uFra_DataArchiving in 'uFra_DataArchiving.pas' {Fra_DataArchiving: TFrame},
  uFrm_DataArcProgress in 'uFrm_DataArcProgress.pas' {Frm_DataArcProgress},
  FileClientDll in 'FileClientDll.pas',
  NetDataDef in 'NetDataDef.pas',
  InitSock in 'InitSock.pas',
  U_FileMd5 in 'U_FileMd5.pas',
  uFrm_TSGYGL in 'uFrm_TSGYGL.pas' {Frm_TSGYGL},
  uFrm_TSGYGL_Dlg in 'uFrm_TSGYGL_Dlg.pas' {Frm_TSGYGL_Dlg};

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
