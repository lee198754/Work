unit InitSock;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Winsock, IniFiles, SyncObjs,
  SConnect, ActiveX, Comobj, MidConst, DB, DBClient, MConnect;

const
  CallSig         = $DA00; // Call signature
  ResultSig       = $DB00; // Result signature

type
  TInitSock = class(TObject)
  public
    constructor Create(minorVer: Byte = 2; majorVer: Byte = 2);
    destructor Destroy; override;
  end;

procedure CheckSignature(Sig: Integer);
function p_StreamToBlock(tr: IDataBlock; pData: pointer; nLen: integer): boolean;

// byte型变体 begin
function p_StringToVariant(const Value: string): Variant;
function p_StreamToVariant1(out Value: Variant; var sData: array of char; nLen: integer): integer;

function p_VariantToString(const Value: Variant): string;
function p_VariantToStream1(const Value: Variant; var sData: array of char; nLen: integer): integer;

function p_VariantToData(const Data: Variant; var Dest; count: Integer): boolean;
function p_DataToVariant(const Source; count: Integer): Variant;
// byte型变体 end

// 树型变体 begin
function p_StreamToVariant(out Value: Variant; tr: IDataBlock; pData: pointer; nLen: integer): boolean; overload;
// 加同步处理
function p_StreamToVariant(out Value: Variant; pData: pointer; nLen: integer): boolean; overload;

function p_VariantToStream(out s: string; Value: Variant; tr: IDataBlock; Sig: Integer = CallSig): boolean; overload;
function p_VariantToStream(out s: string; Value: Variant; Sig: Integer = CallSig): boolean; overload;

procedure WriteVariant(const Value: OleVariant; const Data: IDataBlock);
function ReadVariant(out Flags: TVarFlags; const Data: IDataBlock): OleVariant;
// 树型变体 end

implementation

{ TInitSock }

const
  EasyArrayTypes = [varSmallInt, varInteger, varSingle, varDouble, varCurrency,
                    varDate, varBoolean, varShortInt, varByte, varWord, varLongWord];

  VariantSize: array[0..varLongWord] of Word  = (0, 0, SizeOf(SmallInt), SizeOf(Integer),
    SizeOf(Single), SizeOf(Double), SizeOf(Currency), SizeOf(TDateTime), 0, 0,
    SizeOf(Integer), SizeOf(WordBool), 0, 0, 0, 0, SizeOf(ShortInt), SizeOf(Byte),
    SizeOf(Word), SizeOf(LongWord));

var
  g_Var_CriticalSection: TCriticalSection;
  g_tr: IDataBlock;

procedure CheckSignature(Sig: Integer);
begin
  if (Sig and $FF00 <> CallSig) and
     (Sig and $FF00 <> ResultSig) then
    raise Exception.CreateRes(@SInvalidDataPacket);
end;

function p_VariantToData(const Data: Variant; var Dest; count: Integer): boolean;
var
  p: Pointer;
begin
  Result := VarArrayHighBound(Data, 1) + 1 = count;
  if not Result then exit;

  p := VarArrayLock(Data);
  try
     Move(p^, Dest, VarArrayHighBound(Data, 1) + 1);
  finally
    VarArrayUnlock(Data);
  end;
end;

function p_DataToVariant(const Source; count: Integer): Variant;
var
  p: Pointer;
begin
  Result := VarArrayCreate([0, count - 1], varByte);
  p := VarArrayLock(Result);
  try
    Move(Source, p^, count);
  finally
    VarArrayUnlock(Result);
  end; 
end;

function p_StreamToBlock(tr: IDataBlock; pData: pointer; nLen: integer): boolean;
var
  Flags: TVarFlags;
  Sig, StreamLen: Integer;
  P: Pointer;
begin
  Result := false;
  tr.Clear;
  if nLen < SizeOf(Sig) + SizeOf(StreamLen) then exit;
  Move(pData^, Sig, SizeOf(Sig));
  CheckSignature(Sig);
  Move(pointer(integer(pData) + SizeOf(Sig))^, StreamLen, SizeOf(StreamLen));

  tr.Size := StreamLen;
  tr.Signature := Sig;
  P := tr.Memory;
  Inc(Integer(P), tr.BytesReserved);

  if nLen < SizeOf(Sig) + SizeOf(StreamLen) + StreamLen then exit;
  Move(pointer(integer(pData) + SizeOf(Sig) + SizeOf(StreamLen))^, P^, StreamLen);
  Result := true;
end;

function p_StreamToVariant(out Value: Variant; tr: IDataBlock; pData: pointer; nLen: integer): boolean; overload;
var
  Flags: TVarFlags;
begin
  Result := p_StreamToBlock(tr, pData, nLen);
  if Result then
    Value := ReadVariant(Flags, tr);
end;

function p_StreamToVariant(out Value: Variant; pData: pointer; nLen: integer): boolean; overload;
var
  Flags: TVarFlags;
begin
  g_Var_CriticalSection.Enter;
  try
    Result := p_StreamToBlock(g_tr, pData, nLen);
    if Result then
      Value := ReadVariant(Flags, g_tr);
  finally
    g_Var_CriticalSection.Leave;
  end;  
end;

function p_VariantToStream(out s: string; Value: Variant; tr: IDataBlock; Sig: Integer): boolean;
var
  nSize: Integer;
  P: Pointer;
begin
  Result := false;
  tr.Clear;
  tr.Signature := Sig;  // CallSig
  WriteVariant(Value, tr);
  P := tr.Memory;
  nSize := tr.Size + tr.BytesReserved;
  SetLength(s, nSize);
  Move(P^, PChar(s)^, nSize);
  Result := true;
end;

function p_VariantToStream(out s: string; Value: Variant; Sig: Integer): boolean;
var
  nSize: Integer;
  P: Pointer;
begin
  Result := false;
  g_tr.Clear;
  g_tr.Signature := Sig;  // CallSig
  WriteVariant(Value, g_tr);
  P := g_tr.Memory;
  nSize := g_tr.Size + g_tr.BytesReserved;
  SetLength(s, nSize);
  Move(P^, PChar(s)^, nSize);
  Result := true;
end;

procedure WriteArray(const Value: OleVariant;
  const Data: IDataBlock);
var
  LVarData: TVarData;
  VType: Integer;
  VSize, i, DimCount, ElemSize: Integer;
  LSafeArray: PSafeArray;
  LoDim, HiDim, Indices: PIntArray;
  V: OleVariant;
  P: Pointer;
begin
  LVarData := FindVarData(Value)^;
  VType := LVarData.VType;
  LSafeArray := PSafeArray(LVarData.VPointer);
                         
  Data.Write(VType, SizeOf(Integer));
  DimCount := VarArrayDimCount(Value);
  Data.Write(DimCount, SizeOf(DimCount));
  VSize := SizeOf(Integer) * DimCount;
  GetMem(LoDim, VSize);
  try
    GetMem(HiDim, VSize);
    try
      for i := 1 to DimCount do
      begin
        LoDim[i - 1] := VarArrayLowBound(Value, i);
        HiDim[i - 1] := VarArrayHighBound(Value, i);
      end;
      Data.Write(LoDim^,VSize);
      Data.Write(HiDim^,VSize);
      if VType and varTypeMask in EasyArrayTypes then
      begin
        ElemSize := SafeArrayGetElemSize(LSafeArray);
        VSize := 1;
        for i := 0 to DimCount - 1 do
          VSize := (HiDim[i] - LoDim[i] + 1) * VSize;
        VSize := VSize * ElemSize;
        P := VarArrayLock(Value);
        try
          Data.Write(VSize, SizeOf(VSize));
          Data.Write(P^,VSize);
        finally
          VarArrayUnlock(Value);
        end;
      end else
      begin
        GetMem(Indices, VSize);
        try
          for I := 0 to DimCount - 1 do
            Indices[I] := LoDim[I];
          while True do
          begin
            if VType and varTypeMask <> varVariant then
            begin
              OleCheck(SafeArrayGetElement(LSafeArray, Indices^, TVarData(V).VPointer));
              TVarData(V).VType := VType and varTypeMask;
            end else
              OleCheck(SafeArrayGetElement(LSafeArray, Indices^, V));
            WriteVariant(V, Data);
            Inc(Indices[DimCount - 1]);
            if Indices[DimCount - 1] > HiDim[DimCount - 1] then
              for i := DimCount - 1 downto 0 do
                if Indices[i] > HiDim[i] then
                begin
                  if i = 0 then Exit;
                  Inc(Indices[i - 1]);
                  Indices[i] := LoDim[i];
                end;
          end;
        finally
          FreeMem(Indices);
        end;
      end;
    finally
      FreeMem(HiDim);
    end;
  finally
    FreeMem(LoDim);
  end;
end;

procedure WriteVariant(const Value: OleVariant;
  const Data: IDataBlock);
var
  I, VType: Integer;
  W: WideString;
begin
  VType := VarType(Value);
  if VType and varArray <> 0 then
    WriteArray(Value, Data)
  else
    case (VType and varTypeMask) of
      varEmpty, varNull:
        Data.Write(VType, SizeOf(Integer));
      varOleStr:
      begin
        W := WideString(Value);
        I := Length(W);
        Data.Write(VType, SizeOf(Integer));
        Data.Write(I,SizeOf(Integer));
        Data.Write(W[1], I * 2);
      end;
      {varDispatch:
      begin
        if VType and varByRef = varByRef then
          raise EInterpreterError.CreateResFmt(@SBadVariantType,[IntToHex(VType,4)]);
        I := StoreObject(Value);
        Data.Write(VType, SizeOf(Integer));
        Data.Write(I, SizeOf(Integer));
      end;}
      varVariant:
      begin
        if VType and varByRef <> varByRef then
          raise EInterpreterError.CreateResFmt(@SBadVariantType,[IntToHex(VType,4)]);
        I := varByRef;
        Data.Write(I, SizeOf(Integer));
        WriteVariant(Variant(TVarData(Value).VPointer^), Data);
      end;
      varUnknown:
        raise EInterpreterError.CreateResFmt(@SBadVariantType,[IntToHex(VType,4)]);
    else
      Data.Write(VType, SizeOf(Integer));
      if VType and varByRef = varByRef then
        Data.Write(TVarData(Value).VPointer^, VariantSize[VType and varTypeMask])
      else
        Data.Write(TVarData(Value).VPointer, VariantSize[VType and varTypeMask]);
    end;
end;

function ReadArray(VType: Integer;
  const Data: IDataBlock): OleVariant;
var
  Flags: TVarFlags;
  LoDim, HiDim, Indices, Bounds: PIntArray;
  DimCount, VSize, i: Integer;
  {P: Pointer;}
  V: OleVariant;
  LSafeArray: PSafeArray;
  P: Pointer;
begin
  VarClear(Result);
  Data.Read(DimCount, SizeOf(DimCount));
  VSize := DimCount * SizeOf(Integer);
  GetMem(LoDim, VSize);
  try
    GetMem(HiDim, VSize);
    try
      Data.Read(LoDim^, VSize);
      Data.Read(HiDim^, VSize);
      GetMem(Bounds, VSize * 2);
      try
        for i := 0 to DimCount - 1 do
        begin
          Bounds[i * 2] := LoDim[i];
          Bounds[i * 2 + 1] := HiDim[i];
        end;
        Result := VarArrayCreate(Slice(Bounds^,DimCount * 2), VType and varTypeMask);
      finally
        FreeMem(Bounds);
      end;
      if VType and varTypeMask in EasyArrayTypes then
      begin
        Data.Read(VSize, SizeOf(VSize));
        P := VarArrayLock(Result);
        try
          Data.Read(P^, VSize);
        finally
          VarArrayUnlock(Result);
        end;
      end else
      begin
        LSafeArray := PSafeArray(TVarData(Result).VArray);
        GetMem(Indices, VSize);
        try
          FillChar(Indices^, VSize, 0);
          for I := 0 to DimCount - 1 do
            Indices[I] := LoDim[I];
          while True do
          begin
            V := ReadVariant(Flags, Data);
            if VType and varTypeMask = varVariant then
              OleCheck(SafeArrayPutElement(LSafeArray, Indices^, V)) else
              OleCheck(SafeArrayPutElement(LSafeArray, Indices^, TVarData(V).VPointer^));
            Inc(Indices[DimCount - 1]);
            if Indices[DimCount - 1] > HiDim[DimCount - 1] then
              for i := DimCount - 1 downto 0 do
                if Indices[i] > HiDim[i] then
                begin
                  if i = 0 then Exit;
                  Inc(Indices[i - 1]);
                  Indices[i] := LoDim[i];
                end;
          end;
        finally
          FreeMem(Indices);
        end;
      end;
    finally
      FreeMem(HiDim);
    end;
  finally
    FreeMem(LoDim);
  end;
end;

function ReadVariant(out Flags: TVarFlags;
  const Data: IDataBlock): OleVariant;
var
  I, VType: Integer;
  W: WideString;
  TmpFlags: TVarFlags;
begin
  VarClear(Result);
  Flags := [];
  Data.Read(VType, SizeOf(VType));
  if VType and varByRef = varByRef then
    Include(Flags, vfByRef);
  if VType = varByRef then
  begin
    Include(Flags, vfVariant);
    Result := ReadVariant(TmpFlags, Data);
    Exit;
  end;
  if vfByRef in Flags then
    VType := VType xor varByRef;
  if (VType and varArray) = varArray then
    Result := ReadArray(VType, Data) else
  case VType and varTypeMask of
    varEmpty: VarClear(Result);
    varNull: Result := NULL;
    varOleStr:
    begin
      Data.Read(I, SizeOf(Integer));
      SetLength(W, I);
      Data.Read(W[1], I * 2);
      Result := W;
    end;
    {varDispatch:
    begin
      Data.Read(I, SizeOf(Integer));
      Result := TDataDispatch.Create(Self, I) as IDispatch;
    end;}
    varUnknown:
      raise EInterpreterError.CreateResFmt(@SBadVariantType,[IntToHex(VType,4)]);
  else
    TVarData(Result).VType := VType;
    Data.Read(TVarData(Result).VPointer, VariantSize[VType and varTypeMask]);
  end;
end;

constructor TInitSock.Create;
var
  wsaData: TWSADATA;
  sockVersion: WORD;
begin
  // 初始化WS2_32.dll
  sockVersion := MAKEWORD(minorVer, majorVer);
  if (WSAStartup(sockVersion, wsaData) <> 0) then
  begin
    raise Exception.Create('');
  end;
end;

destructor TInitSock.Destroy;
begin
  WSACleanup();
  inherited;
end;

function p_VariantToStream1(const Value: Variant; var sData: array of char; nLen: integer): integer;
var
  p : pointer;
begin
  Result := VarArrayHighBound(Value, 1) - VarArrayLowBound(Value, 1) + 1;
  if Result > nLen then
  begin
    Result := -1;
    exit;
  end;
  
  p := VarArrayLock(Value);
  try
    Move(p^, sData, Result);
  finally
    VarArrayUnlock(Value);
  end;
end;

function p_VariantToString(const Value: Variant): string;
var
  p : pointer;
  s: string;
begin
  Result := '';
  SetLength(s, VarArrayHighBound(Value, 1) + 1);

  p := VarArrayLock(Value);
  try
    Move(p^, s[1], Length(s));
    Result := s;
  finally
    VarArrayUnlock(Value);
  end;
end;

function p_StringToVariant(const Value: string): Variant;
var
  p : pointer;
begin
  Result := VarArrayCreate([0, Length(Value) - 1], VarByte);

  p := VarArrayLock(Result);
  try
    Move(Value[1], p^, Length(Value));
  finally
    VarArrayUnlock(Result);
  end;
end;

function p_StreamToVariant1(out Value: Variant; var sData: array of char; nLen: integer): integer;
var
  p : pointer;
begin
  Value := VarArrayCreate([0, nLen - 1], varByte);
  p := VarArrayLock(Value);
  try
    Move(sData, p^, nLen);
  finally
    VarArrayUnlock(Value);
  end;  
end;

initialization
  g_Var_CriticalSection := TCriticalSection.Create;
  g_tr := TDataBlock.Create;

finalization
  g_Var_CriticalSection.Free;
  g_tr := nil;

end.
