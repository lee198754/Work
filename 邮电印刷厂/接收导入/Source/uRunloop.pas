unit uRunloop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzTray, StdCtrls,XPMan;

type
  TFRunloop = class(TForm)
    Timer1: TTimer;
    RzTrayIcon1: TRzTrayIcon;
    Timer2: TTimer;
    lab_Time: TLabel;
    lab_Path: TLabel;
    lab_Interval: TLabel;
    btn_zx: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    vTime: TDateTime;
  public
    { Public declarations }
  end;

var
  FRunloop: TFRunloop;

implementation

uses
  DateUtils;
{$R *.dfm}

procedure TFRunloop.Timer1Timer(Sender: TObject);
var
  str: string;
begin
   str := lab_Path.Caption;
   if FileExists(str) then
     WinExec(pchar(Str),SW_MINIMIZE);
end;

procedure TFRunloop.Timer2Timer(Sender: TObject);
begin
  vTime := IncSecond(vTime);
  lab_Time.Caption := FormatDateTime('已运行：hh:mm:ss',vTime);
end;

procedure TFRunloop.FormShow(Sender: TObject);
begin
  lab_Interval.Caption := '每隔 30 分钟执行 ';
  lab_Path.Caption := ExtractFilePath(Application.ExeName)+'接收订单.exe';
//  if lab_Path.Width >170 then
  Width := lab_Path.Left+ lab_Path.Width + btn_zx.Width +50;

end;

end.
