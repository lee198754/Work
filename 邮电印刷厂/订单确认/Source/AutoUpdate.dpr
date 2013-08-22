program AutoUpdate;

uses
  Forms,
  uAutoUpdate in 'uAutoUpdate.pas' {Frm_AutoUpdate};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '自动更新';
  Application.CreateForm(TFrm_AutoUpdate, Frm_AutoUpdate);
  Application.Run;
end.
