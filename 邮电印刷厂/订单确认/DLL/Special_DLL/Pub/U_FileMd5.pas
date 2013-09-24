unit U_FileMd5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, md5;

// 使用分段编码，到nPos的内容的编码
function p_GetFileMd5(const sFileName: string; nPos: integer = -1): string;

implementation

const
  c_Size = 1024 * 1024;

var
  Arr: array[0..c_Size - 1] of char;

function p_GetFileMd5(const sFileName: string; nPos: integer): string;
var
  n, nRead, nSize, nBlockSize: integer;
  hFile, hSize: Cardinal;
  s, sBuf: string;
begin
  Result := '';
  s := '';
  if not FileExists(sFileName) then exit;
  hFile := FileOpen(sFileName, fmOpenRead + fmShareDenyNone);
  if hFile = 0 then exit;

  try
    nSize := GetFileSize(hFile, @hSize);
    if nPos > 0 then
    if nPos < nSize then nSize := nPos;
    if nSize < 1 then exit;
    
    n := 0;
    while n < nSize do
    begin
      if n + c_Size < nSize then nBlockSize := c_Size
      else nBlockSize := nSize - n;

      nRead := FileRead(hFile, Arr, nBlockSize);
      if nRead < 1 then exit;
      if nRead < c_Size then
        if nRead + n < nSize then exit;

      SetLength(sBuf, nRead);
      Move(Arr, sBuf[1], nRead);
      s := s + UpperCase(MD5Print(MD5String(sBuf)));
      Inc(n, nBlockSize);
    end;
  finally
    FileClose(hFile);
  end;

  s := UpperCase(MD5Print(MD5String(s)));
  Result := s;
end;

end.
