program pRunloop;

uses
  Forms,
  uRunloop in 'uRunloop.pas' {FRunloop};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ѭ������';
  Application.CreateForm(TFRunloop, FRunloop);
  Application.Run;
end.
