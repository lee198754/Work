program CRM;

uses
  Forms,
  SearchFrom in '..\ϵͳ��\SearchFrom.pas' {Search_Frm},
  bainaADOQuery in '..\ϵͳ��\bainaADOQuery.pas',
  BaseDataFrom in '..\ϵͳ��\BaseDataFrom.pas' {BaseData_Frm},
  BaseFrom in '..\ϵͳ��\BaseFrom.pas' {Base_Frm},
  DataClass in '..\ϵͳ��\DataClass.pas',
  FindDataFrom in '..\ϵͳ��\FindDataFrom.pas' {FindData_Frm},
  PublicClass in '..\ϵͳ��\PublicClass.pas',
  ReportFrom in '..\ϵͳ��\ReportFrom.pas' {Report_Frm},
  LoginFrm in 'System\LoginFrm.pas' {Login_Frm},
  MainFrm in 'System\MainFrm.pas' {Main_Frm},
  DataBase in 'System\DataBase.pas' {DataBaseModule: TDataModule},
  NewUser in 'System\NewUser.pas' {Frm_User},
  Dept in 'System\Dept.pas' {Frm_Dept},
  Password in 'System\Password.pas' {Frm_Password},
  AddUserGrp in 'System\AddUserGrp.pas' {Frm_UserGrpAdd},
  Right in 'System\Right.pas' {Frm_Right},
  Dict in 'System\Dict.pas' {Frm_Dict},
  Customer in 'System\Customer.pas' {Frm_CustManager},
  NewCust in 'System\NewCust.pas' {Frm_NewCust},
  CustActive in 'System\CustActive.pas' {Frm_CustActive},
  CustContact in 'System\CustContact.pas' {Frm_CustContact},
  Warn in 'System\Warn.pas' {Frm_Warn},
  Search in 'System\Search.pas' {Frm_Search},
  NewContract in 'System\NewContract.pas' {Frm_NewContract},
  FileCenter in 'System\FileCenter.pas' {Frm_FileCenter},
  Contract in 'System\Contract.pas' {Frm_Contract},
  NewProd in 'System\NewProd.pas' {Frm_NewCode},
  NewExpend in 'System\NewExpend.pas' {Frm_NewExpend},
  Expend in 'System\Expend.pas' {Frm_Expend},
  SalePre in 'System\SalePre.pas' {Frm_SalePre},
  PreService in 'System\PreService.pas' {Frm_PreService},
  Select in 'System\Select.pas' {Frm_Select},
  PreWrite in 'System\PreWrite.pas' {Frm_Pre},
  SerProc in 'System\SerProc.pas' {Frm_SerProc},
  ImportData in 'System\ImportData.pas' {Frm_ImportData},
  Preview in 'System\Preview.pas' {ExcelLook_Frm},
  Bulletin in 'System\Bulletin.pas' {Frm_Bulletin},
  NewBulletin in 'System\NewBulletin.pas' {Frm_NewBulletin},
  cxSchedulerEventEditor in 'E:\lpj\delphi\����\�������ؼ�\DevExpress VCL\ExpressScheduler 3\Sources\cxSchedulerEventEditor.pas' {cxSchedulerEventEditorForm},
  EventEditForm in 'System\EventEditForm.pas' {Frm_EventEdit},
  Day in 'System\Day.pas' {Frm_Day},
  Sale in 'System\Sale.pas' {Frm_SaleManage},
  NewSale in 'System\NewSale.pas' {Frm_SaleMake},
  NewsaleList in 'System\NewsaleList.pas' {Frm_NewSaleList},
  CustChange in 'System\CustChange.pas' {Frm_Move},
  PReceive in 'System\PReceive.pas' {Frm_Receive},
  FArrearage in 'System\FArrearage.pas' {Frm_FArrearage},
  Pay in 'System\Pay.pas' {Frm_Pay},
  Cash in 'System\Cash.pas' {Frm_Cash},
  Note in 'System\Note.pas' {Frm_Note},
  NewNote in 'System\NewNote.pas' {Frm_NewNote},
  Count in 'System\Count.pas' {Frm_Count},
  Default in 'System\Default.pas' {Frm_Default},
  SysSet in 'System\SysSet.pas' {Frm_SysSet},
  EMailSelectLinkman in 'Email\EMailSelectLinkman.pas' {EMailSelectLinkman_Frm},
  ProgressFrm in 'Email\ProgressFrm.pas' {Progress_Frm},
  EMailSet in 'Email\EMailSet.pas' {EMailSet_Frm},
  about in 'System\about.pas' {Frm_About},
  ServiceRecord in 'System\ServiceRecord.pas' {Frm_ServiceRecord},
  SelectDate in 'System\SelectDate.pas' {Frm_SelectDate},
  TelManagerUnt in 'System\TelManagerUnt.pas' {TelManagerFrm},
  SoundMager in 'System\SoundMager.pas' {Frm_SoundManager},
  ScreeUnt in 'System\ScreeUnt.pas' {ScreeFrm},
  LineSelect in 'System\LineSelect.pas' {Frm_HideSelect},
  Style in 'System\Style.pas' {Frm_Style},
  ShareCust in 'System\ShareCust.pas' {Frm_ShareCust},
  EMailFrm in 'Email\EMailFrm.pas' {EMail_Frm},
  NewMailFrm in 'Email\NewMailFrm.pas' {NewMail_Frm},
  SaleReceipt in 'Rep\SaleReceipt.pas' {Rep_SaleReceipt},
  ProdCode in 'System\ProdCode.pas' {Frm_ProdCode},
  Supply in 'System\Supply.pas' {Frm_Supply},
  IMECode in '..\ϵͳ��\IMECode.pas',
  Dictother in 'System\Dictother.pas' {Frm_Dictother},
  BaseSet in 'System\BaseSet.pas' {Frm_BaseSet},
  AdoConEd in '..\ϵͳ��\AdoConEd.pas' {ConnEditForm},
  TMNC_OCX_TLB in 'System\TMNC_OCX_TLB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDataBaseModule, DataBaseModule);
  Application.CreateForm(TMain_Frm, Main_Frm);
  Application.CreateForm(TFrm_Day, Frm_Day);
  Application.CreateForm(TFrm_ShareCust, Frm_ShareCust);
  Application.CreateForm(TFrm_Supply, Frm_Supply);
  Application.CreateForm(TFrm_Dictother, Frm_Dictother);
  Application.CreateForm(TFrm_BaseSet, Frm_BaseSet);
  Application.Run;
end.
