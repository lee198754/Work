unit uDLLAPI;

interface

uses
  Forms;

procedure p_Special(qk: Integer; clc: ShortString;iParentWindow:Thandle; iHandle: Thandle); stdcall;

implementation

procedure p_Special(qk: Integer; clc: ShortString;iParentWindow:Thandle; iHandle: Thandle); external 'E:\lpj\Work\�ʵ�ӡˢ��\����ȷ��\DLL\Special_DLL\bin\dll_Special.dll';

end.
