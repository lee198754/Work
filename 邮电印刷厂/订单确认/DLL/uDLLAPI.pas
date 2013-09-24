unit uDLLAPI;

interface

uses
  Forms;

procedure p_Special(qk: Integer; clc: ShortString;iParentWindow:Thandle; iHandle: Thandle); stdcall;

implementation

procedure p_Special(qk: Integer; clc: ShortString;iParentWindow:Thandle; iHandle: Thandle); external 'E:\lpj\Work\邮电印刷厂\订单确认\DLL\Special_DLL\bin\dll_Special.dll';

end.
