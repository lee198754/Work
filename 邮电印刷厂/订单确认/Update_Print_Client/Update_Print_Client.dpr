// 先结束助手，更新后再开启

program Update_Print_Client;

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ShellApi,
  IniFiles,
  PacketWork in 'PacketWork.pas';

{$R *.res}

begin
  Application.Initialize;

  g_sFile := 'pOrder.exe';
  g_sArr := TStringList.Create;
  g_sArr.Add(g_sFile);
  g_sArr.Add('set.ini');
  g_sArr.Add('NetClient_D.dll');

  //
  try
    p_Work;
  finally
    g_sArr.Free;
  end;

  Application.Run;
end.
