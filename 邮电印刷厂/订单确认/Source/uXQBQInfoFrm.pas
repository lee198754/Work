unit uXQBQInfoFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, iGrid, ADODB, ExtCtrls;

type
  TJiangCode = record
    m_sZH: string;
    m_iRJHDQ: Integer;
    m_iRJHDZ: Integer;
  end;

  TFrm_XQBQInfo = class(TForm)
    GroupBox2: TGroupBox;
    stg_BQXX: Ti_StgEdit;
    Panel1: TPanel;
    btn_DYBQ: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edt_CPBH: TEdit;
    edt_BB: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edt_ZXS: TEdit;
    edt_ZBS: TEdit;
    Label5: TLabel;
    edt_CBSL: TEdit;
    Label6: TLabel;
    edt_CXSL: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FCPBH: string;
    FOrderID: Integer;
    FOrderType: Integer;
    FXQTXM: string;
    FZXS: Integer;
    FCXSL: Integer;
    FZBS: Integer;
    FCBSL: integer;
    FYL: Integer;
    FMZBZ: integer;
    aJiangCode: array of TJiangCode;
    procedure WriteStgBQXX;
    procedure PrintTXM;
    function f_GetJiangCode(var _XH: Integer;SYSL: Integer): string;
    function f_SetArrJiangCode(OrderID,OrderType: Integer): Boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;const Args: array of const );
  end;

var
  Frm_XQBQInfo: TFrm_XQBQInfo;

implementation

{$R *.dfm}

uses
  PubStr, StrUtils, uDM_DataBase,uCDFPSKAPI;
{ TFrm_XQBQInfo }


const
  c_Name      = 0;
  c_TXM       = 1;
  c_JiangCode =2;

constructor TFrm_XQBQInfo.Create(AOwner: TComponent;const Args: array of const );
begin
  inherited Create(AOwner);
  if Length(Args) > 0 then
  begin
    FCPBH      := Args[0].VPChar;
    FOrderID   := Args[1].VInteger;
    FOrderType := Args[2].VInteger;
    FXQTXM     := Args[3].VPChar;
    FZXS       := Args[4].VInteger;
    FCXSL      := Args[5].VInteger;
    FCBSL      := Args[6].VInteger;
    FZBS       := FCXSL div FCBSL;
    FYL        := Args[7].VInteger;
    FMZBZ      := Args[8].VInteger;
    if FCXSL mod FCBSL > 0 then
      FZBS := FZBS + 1;
    edt_BB.Text   := iif(FOrderType=0,'定制型','销售型');
    edt_CPBH.Text := FCPBH;
    edt_ZXS.Text  := IntToStr(FZXS);
    edt_CXSL.Text := IntToStr(FCXSL);
    edt_ZBS.Text  := IntToStr(FZBS);
    edt_CBSL.Text := IntToStr(FCBSL);
    WriteStgBQXX;
  end;
end;


procedure TFrm_XQBQInfo.WriteStgBQXX;
var
  i,j,n,iOrderNum,iApartCount,iZXS,iZBS: Integer;
  sName,sXQTXM,sBQTXM,sJiangCode: string;
  ADOQ_Rec: TADOQuery;
  sSqlData: string;
  iPackages,iTao,iPackageID,iOutNum,iCXSL,iXH,iTempNum,iZMS,iCBSL: integer;
begin

  sSqlData := 'Select 1 from DO_OrderApart where F_iOrderID=%d and F_tiOrderType=%d and IsNull(F_tiNJBZ,0)=0 and F_tiCXBZ = 0 ';
  ADOQ_Rec := DM_DataBase.OpenQuery(sSqlData,[FOrderID,FOrderType]);
  iApartCount := ADOQ_Rec.RecordCount;
  ADOQ_Rec.Free;

  f_SetArrJiangCode(FOrderID,FOrderType);
  n:= 1;
  iOrderNum := 1;
  iZXS := FZXS;
  iTao := FMZBZ;
  iCXSL := FCXSL;
  iCBSL := FCBSL;
  iXH := 0;
  iZMS := FYL;
  for i := 1 to iZXS do
  begin
    iZBS := FZBS;
    sName := '第 '+IntToStr(i)+' 箱';
    sXQTXM  :=  StrLeft(FXQTXM,14)+RightStr('00000'+IntToStr(i),5)+ RightStr(FXQTXM,4);
    if (StrRight(FCPBH,3)='999') then
    begin
      iPackages :=  iZXS div iApartCount;
      if iZXS mod iApartCount > 0 then
      begin
        iPackages := iPackages + 1;
      end;
      if iTao=1 then
      begin
        iPackages := iZXS;
      end;
      iPackageID := i mod iPackages;
      if i mod iPackages =0  then
        iPackageID := iPackages;
      iTempNum := ((i-1) div iPackages) + 1;
      case iTao of
        0:
          begin
            sXQTXM := StrLeft(sXQTXM,12)+StrRight('00'+IntToStr(iTempNum),2)+StrRight('00000'+IntToStr(i),5) + StrRight(sXQTXM,4);
            if i mod (FZXS div iApartCount) = 0 then
            begin
              inc(iOrderNum);
              iZBS :=  (FZXS div iApartCount*iCXSL - iZMS div iApartCount) div iCBSL;
              if (FZXS div iApartCount*iCXSL - iZMS div iApartCount) mod iCBSL > 0 then
                iZBS := iZBS+1;
            end;
          end;
        1:
          begin
            sXQTXM := StrLeft(sXQTXM,11)+'999' + StrRight(sXQTXM,9);
          end;
      end;
      if i mod iPackages = 0 then
      begin
        if iTao = 1 then
          iOutNum := iZMS - iCXSL * (iPackages-1)
        else
          iOutNum := iZMS div iApartCount - iCXSL * (iPackages-1);
      end else
        iOutNum := iCXSL;
    end else
    begin
      iOutNum := iCXSL;
      if i = iZXS then
      begin
        iOutNum := iZMS - iCXSL*(iZXS-1)
      end;
    end;
    if (i = iZXS) and (iTao = 1) then
    begin
      iZBS :=  (iZXS*iCXSL - iZMS) div iCBSL;
      if (iZXS*iCXSL - iZMS) mod iCBSL > 0 then
        iZBS := iZBS + 1;
    end;
    sJiangCode := f_GetJiangCode(iXH, iOutNum);


    if (RightStr(FCPBH,3)='999') and (FMZBZ=0) then
    begin
      sXQTXM :=  Copy(sXQTXM,1,11)+RightStr('000'+IntToStr(iOrderNum),3)+Copy(sXQTXM,14,Length(sXQTXM));
      if i mod (FZXS div iApartCount) = 0 then
      begin
        inc(iOrderNum);
        iZBS :=  (FZXS div iApartCount*iCXSL - iZMS div iApartCount) div iCBSL;
        if (FZXS div iApartCount*iCXSL - iZMS div iApartCount) mod iCBSL > 0 then
          iZBS := iZBS+1;
      end;
    end;
    if (i = FZXS) and (FMZBZ = 1) then
    begin
      iZBS :=  (FZXS*iCXSL - iZMS) div iCBSL;
      if (FZXS*iCXSL - iZMS) mod iCBSL > 0 then
        iZBS := iZBS + 1;
    end;
    stg_BQXX.Cells[c_Name,n] := sName;
    stg_BQXX.Cells[c_TXM,n] := sXQTXM;
    stg_BQXX.Cells[c_JiangCode,n] := sJiangCode;
    stg_BQXX.RowCount := stg_BQXX.RowCount + 1;
    Inc(n);
    for j := 1 to iZBS do
    begin
      sName := IntToStr(i)+' - ' + IntToStr(j);
      sBQTXM  :=  sXQTXM+RightStr('000'+IntToStr(j),3);
      stg_BQXX.Cells[c_Name,n] := sName;
      stg_BQXX.Cells[c_TXM,n] := sBQTXM;
      stg_BQXX.RowCount := stg_BQXX.RowCount + 1;
      Inc(n);
    end;
  end;
  if FZXS > 0 then
    stg_BQXX.RowCount := stg_BQXX.RowCount - 1;
end;

procedure TFrm_XQBQInfo.PrintTXM;
var
  sName,sTXM: string;
  i,n: Integer;
begin
  OpenPort(255);
  //SetPCComPort(38400,TRUE);
  PTK_SetDarkness(10);
  PTK_SetPrintSpeed(4);
  PTK_SetLabelHeight(140,16);
  PTK_SetLabelWidth(500);
  n := 1;
  for i := 0 to stg_BQXX.RowCount -1 do
  begin
    sName := stg_BQXX.Cells[c_Name,n];
    sTXM := stg_BQXX.Cells[c_TXM,n];
    PTK_DrawText (50,30,0,2,1,1,'N',Pchar(sName));
    PTK_DrawBarcode(10, 10, 0, '1B', 3, 2, 60, 'B', Pchar(sTXM));
    // PTK_DrawTextTrueTypeW (80, 50, 40, 0, pchar('Arial'), 1, 400, 0, 0, 0, pchar('AB'), pchar('PosteK Printer'));
    // PTK_DrawText (100, 100, 0, 3, 2, 2, 'N', Pchar('777weis4thhgjt7'));
    // PTK_DrawBar2D_Pdf417 (50, 250, 700, 600, 1, 0, 3, 16, 10, 8, 0, 0, pchar('1234567890ABCDEFGHIJKLMNOPQRSTUVWXY')); //仅仅支持机器版本号2.32以上的版本。
    PTK_PrintLabel(100, 1);
    inc(n);
  end;
  ClosePort();

end;

function TFrm_XQBQInfo.f_GetJiangCode(var _XH: Integer;
  SYSL: Integer): string;
begin
  Result := '';
  while 1=1 do
  begin
    if _XH >= Length(aJiangCode) then Break;
    while ((aJiangCode[_XH].m_sZH = '') or (aJiangCode[_XH].m_iRJHDQ = 0) or (aJiangCode[_XH].m_iRJHDZ = 0))
      and  (_XH < Length(aJiangCode)) do
    begin
      Inc(_XH);
    end;
    if _XH >= Length(aJiangCode) then Break;
    while (aJiangCode[_XH].m_iRJHDZ - aJiangCode[_XH].m_iRJHDQ +1 <= SYSL) and (_XH < Length(aJiangCode)) do
    begin
      Result := Result + aJiangCode[_XH].m_sZH +','+StrRight('000000'+IntToStr (aJiangCode[_XH].m_iRJHDQ),6) +','
        + StrRight('000000'+IntToStr(aJiangCode[_XH].m_iRJHDZ),6)+';';
      SYSL := SYSL - (aJiangCode[_XH].m_iRJHDZ- aJiangCode[_XH].m_iRJHDQ +1);
      Inc(_XH);
    end;
    if aJiangCode[_XH].m_iRJHDZ - aJiangCode[_XH].m_iRJHDQ +1 > SYSL then
    begin
      if SYSL >0 then
      begin
        Result := Result + aJiangCode[_XH].m_sZH +','+StrRight('000000'+IntToStr (aJiangCode[_XH].m_iRJHDQ),6) +','
          + StrRight('000000'+IntToStr (aJiangCode[_XH].m_iRJHDQ + SYSL-1),6)+';';
        aJiangCode[_XH].m_iRJHDQ := aJiangCode[_XH].m_iRJHDQ + SYSL;
      end;
      Break;
    end;

  end;
end;

function TFrm_XQBQInfo.f_SetArrJiangCode(OrderID,
  OrderType: Integer): Boolean;
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
  n: integer;
begin
  Result := False;
  n := 0;
  SetLength(aJiangCode,n);
  sSqlData := 'Select a.F_sZH,a.F_sRJHDQ,a.F_sRJHDZ from DO_CartonLableGroupNum a,DO_CartonLableInfo b '
    + ' where a.F_iCartonInfoID=b.F_iID and b.F_iOrderID=%d and b.F_tiOrderType=%d order by a.F_sZH,case when a.F_sRJHDQ=''000000'' then ''999999'' else a.F_sRJHDQ end ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[OrderID,OrderType]);
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    while not ADO_Rec.Eof do
    begin
      if (ADO_Rec.FieldByName('F_sZH').AsString <> '') and (ADO_Rec.FieldByName('F_sRJHDQ').AsString <>'')
        and (ADO_Rec.FieldByName('F_sRJHDZ').AsString <> '') then
      begin
        SetLength(aJiangCode,n+1);
        aJiangCode[n].m_sZH := ADO_Rec.FieldByName('F_sZH').AsString;
        if ADO_Rec.FieldByName('F_sRJHDQ').AsString = '000000' then
          aJiangCode[n].m_iRJHDQ := 1000000
        else
          aJiangCode[n].m_iRJHDQ := StrToNum(ADO_Rec.FieldByName('F_sRJHDQ').AsString);
        if ADO_Rec.FieldByName('F_sRJHDZ').AsString = '000000' then
          aJiangCode[n].m_iRJHDZ := 1000000
        else
          aJiangCode[n].m_iRJHDZ := StrToNum(ADO_Rec.FieldByName('F_sRJHDZ').AsString);
        inc(n);
      end;
      ADO_Rec.Next;
    end;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

  Result := True;
end;

procedure TFrm_XQBQInfo.Button1Click(Sender: TObject);
var
  i,j,n,iOrderNum,iApartCount,iZBS: Integer;
  sName,sXQTXM,sBQTXM: string;
  ADOQ_Rec: TADOQuery;
  sSqlData: string;
begin
  f_SetArrJiangCode(FOrderID,FOrderType);

  if (RightStr(FCPBH,3)='999') or (FMZBZ=0)then
  begin
    sSqlData := 'Select 1 from DO_OrderApart where F_iOrderID=%d and F_tiOrderType=%d and IsNull(F_tiNJBZ,0)=0 and F_tiCXBZ = 0 ';
    ADOQ_Rec := DM_DataBase.OpenQuery(sSqlData,[FOrderID,FOrderType]);
    iApartCount := ADOQ_Rec.RecordCount;
    ADOQ_Rec.Free;
  end;

  n:= 1;
  iOrderNum := 1;
  for i := 1 to FZXS do
  begin
    iZBS := FZBS;
    sName := '第 '+IntToStr(i)+' 箱';
    sXQTXM  :=  StrLeft(FXQTXM,14)+RightStr('00000'+IntToStr(i),5)+ RightStr(FXQTXM,4);
    if (RightStr(FCPBH,3)='999') and (FMZBZ=0) then
    begin
      sXQTXM :=  Copy(sXQTXM,1,11)+RightStr('000'+IntToStr(iOrderNum),3)+Copy(sXQTXM,14,Length(sXQTXM));
      if i mod (FZXS div iApartCount) = 0 then
      begin
        inc(iOrderNum);
        iZBS :=  (FZXS div iApartCount*FCXSL - FYL div iApartCount) div FCBSL;
        if (FZXS div iApartCount*FCXSL - FYL div iApartCount) mod FCBSL > 0 then
          iZBS := iZBS+1;
      end;
    end;
    if (i = FZXS) and (FMZBZ = 1) then
    begin
      iZBS :=  (FZXS*FCXSL - FYL) div FCBSL;
      if (FZXS*FCXSL - FYL) mod FCBSL > 0 then
        iZBS := iZBS + 1;
    end;
    stg_BQXX.Cells[c_Name,n] := sName;
    stg_BQXX.Cells[c_TXM,n] := sXQTXM;
    stg_BQXX.RowCount := stg_BQXX.RowCount + 1;
    Inc(n);
    for j := 1 to iZBS do
    begin
      sName := IntToStr(i)+' - ' + IntToStr(j);
      sBQTXM  :=  sXQTXM+RightStr('000'+IntToStr(j),3);
      stg_BQXX.Cells[c_Name,n] := sName;
      stg_BQXX.Cells[c_TXM,n] := sBQTXM;
      stg_BQXX.RowCount := stg_BQXX.RowCount + 1;
      Inc(n);
    end;
  end;
  if FZXS > 0 then
    stg_BQXX.RowCount := stg_BQXX.RowCount - 1;
end;

end.
