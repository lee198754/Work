unit FrmUpdateModuleCheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, iLabel;

type
  TFrm_UpdateModuleCheck = class(TForm)
    Lbl_Info: Ti_Label;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    procedure p_Check(const sApp: string);
  end;

procedure p_Sys_UpdateModuleCheck(const sApp: string);

var
  Frm_UpdateModuleCheck: TFrm_UpdateModuleCheck;

implementation

{$R *.dfm}

procedure p_Sys_UpdateModuleCheck(const sApp: string);
begin
  if Frm_UpdateModuleCheck = nil then
    Frm_UpdateModuleCheck := TFrm_UpdateModuleCheck.Create(nil);
  Frm_UpdateModuleCheck.p_Check(sApp);
end;

procedure TFrm_UpdateModuleCheck.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
  Close;
end;

procedure TFrm_UpdateModuleCheck.FormCreate(Sender: TObject);
begin
  Lbl_Info.Caption := '';
end;

procedure TFrm_UpdateModuleCheck.p_Check(const sApp: string);
var
  s: string;
begin
  s := ExtractFilePath(Application.ExeName) + 'SoftUpdate\UpdateClient.dll';
  if not FileExists(s) then
  begin
    Lbl_Info.Caption := '提示信息：' + QuotedStr(sApp) + '的更新模块找不到，程序不能自动更新';
    Show;
    Timer1.Enabled := true;
  end;
end;

procedure TFrm_UpdateModuleCheck.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Timer1.Enabled := false;
end;

initialization


finalization
  if Frm_UpdateModuleCheck <> nil then
    FreeAndNil(Frm_UpdateModuleCheck);

end.
