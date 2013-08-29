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
  NewCust in 'System\NewCust.pas' {Frm_NewCust};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDataBaseModule, DataBaseModule);
  Application.CreateForm(TMain_Frm, Main_Frm);
  Application.CreateForm(TFrm_NewCust, Frm_NewCust);
  Application.Run;
end.
