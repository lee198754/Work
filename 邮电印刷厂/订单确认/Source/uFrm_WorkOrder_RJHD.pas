unit uFrm_WorkOrder_RJHD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, iGrid, ExtCtrls;

type
  TFrm_WorkOrder_RJHD = class(TForm)
    btn_ok: TButton;
    btn_close: TButton;
    edt_Temp: TEdit;
    Bevel1: TBevel;
    stg_RJHD: Ti_StgEdit;
    procedure btn_okClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure stg_RJHDSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure edt_TempExit(Sender: TObject);
  private
    { Private declarations }
    function IsCheck: Boolean;
  public
    { Public declarations }
    vSucceed: Boolean;
    vApartID: integer;
    vActionType: integer;
    vBCYL: Integer;
  end;

var
  Frm_WorkOrder_RJHD: TFrm_WorkOrder_RJHD;

implementation

uses
  PubStr, uPub_Text, uPub_Type, uPub_Func;
{$R *.dfm}

const
  c_ZH    = 0;
  c_RJHDQ = 1;
  c_RJHDZ = 2;


procedure TFrm_WorkOrder_RJHD.btn_okClick(Sender: TObject);
var
  i, j, len: integer;
begin
  vSucceed := False;
  if not IsCheck then  Exit;
  for i := 0 to Length(aTempRJHD) -1 do
  begin
    if aTempRJHD[i].m_iApartID = vApartID then
    begin
      aTempRJHD[i].m_iApartID := -1;
    end;
  end;
  for i := 1 to stg_RJHD.RowCount -1 do
  begin
    Len := Length(aTempRJHD);
    for j := 0 to  Len -1 do
    begin
      if aTempRJHD[j].m_iApartID = -1 then
      begin
        aTempRJHD[j].m_sZH := stg_RJHD.Cells[c_ZH,i];
        aTempRJHD[j].m_sRJHDQ := stg_RJHD.Cells[c_RJHDQ,i];
        aTempRJHD[j].m_sRJHDZ := stg_RJHD.Cells[c_RJHDZ,i];
        aTempRJHD[j].m_iApartID := vApartID;
        Break;
      end;
    end;
    if j < len -1 then Continue;
    SetLength(aTempRJHD,Len+1);
    aTempRJHD[Len].m_sZH := stg_RJHD.Cells[c_ZH,i];
    aTempRJHD[Len].m_sRJHDQ := stg_RJHD.Cells[c_RJHDQ,i];
    aTempRJHD[Len].m_sRJHDZ := stg_RJHD.Cells[c_RJHDZ,i];
    aTempRJHD[Len].m_iApartID := vApartID;
  end;      
  vSucceed := True;
  Close;
end;

procedure TFrm_WorkOrder_RJHD.FormShow(Sender: TObject);
var
  i,n: Integer;
begin
  if vActionType = c_WorkOrder_Select then
  begin
    btn_ok.Enabled := False;
    edt_Temp.ReadOnly := True;
  end;
  vSucceed := False;
  stg_RJHD.ColBuddy[c_RJHD_ZH] := 'edt_Temp';
  stg_RJHD.ColBuddy[c_RJHD_RJHDQ] := 'edt_Temp';
  stg_RJHD.ColBuddy[c_RJHD_RJHDZ] := 'edt_Temp';
 { for i := 0 to Length(aTempRJHD) -1 do
  begin
    if aTempRJHD[i].m_iApartID = vApartID then
    begin
      if  Trim(stg_RJHD.Cells[c_ZH,stg_RJHD.RowCount-1]) <> '' then
        stg_RJHD.RowCount := stg_RJHD.RowCount+1;
      n := stg_RJHD.RowCount -1;
      stg_RJHD.Cells[c_ZH,n] := aTempRJHD[i].m_sZH;
      stg_RJHD.Cells[c_RJHDQ,n] := aTempRJHD[i].m_sRJHDQ;
      stg_RJHD.Cells[c_RJHDZ,n] := aTempRJHD[i].m_sRJHDZ;
    end;
  end;     }

end;

function TFrm_WorkOrder_RJHD.IsCheck: Boolean;
var
  i, iHMSL: Integer;
  str: string;
begin
  Result := False;
  iHMSL := 0;
  for i := 1 to stg_RJHD.RowCount -1 do
  begin
    if (stg_RJHD.Cells[c_ZH,i]='') and  (stg_RJHD.Cells[c_RJHDQ,i]='') and (stg_RJHD.Cells[c_RJHDZ,i]='') then Continue;
    str := stg_RJHD.Cells[c_RJHD_RJHDQ,i];
    if (Trim(str) <> '') and (StrToNum(str)=0) then
    begin
      p_MessageBoxDlg('起始号码必需大于0!');
      Exit;
    end;
    if (stg_RJHD.Cells[c_ZH,i]='') or  (stg_RJHD.Cells[c_RJHDQ,i]='') or (stg_RJHD.Cells[c_RJHDZ,i]='') then
    begin
      p_MessageBoxDlg('请完整输入兑奖号段!');
      Exit;
    end;
    iHMSL := iHMSL + StrToNum(iif(stg_RJHD.Cells[c_RJHDZ,i]='000000','1000000',stg_RJHD.Cells[c_RJHDZ,i]))-StrToNum(iif(stg_RJHD.Cells[c_RJHDQ,i]='000000','1000000',stg_RJHD.Cells[c_RJHDQ,i]))+1;
  end;
  if iHMSL < vBCYL then
  begin
    p_MessageBoxDlg('兑奖号码总数('+IntTOStr(iHMSL)+')小于本次印量('+IntToStr(vBCYL)+')');
    Exit;
  end else
  if iHMSL > vBCYL then
  begin
    p_MessageBoxDlg('兑奖号码总数('+IntTOStr(iHMSL)+')大于本次印量('+IntToStr(vBCYL)+')');
    Exit;
  end;
  Result := True;
end;

procedure TFrm_WorkOrder_RJHD.stg_RJHDSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if stg_RJHD.RowCount = ARow+1 then
    stg_RJHD.RowCount := stg_RJHD.RowCount +1;
    

end;

procedure TFrm_WorkOrder_RJHD.edt_TempExit(Sender: TObject);
var
  str, sRJHDQ, sRJHDZ: string;
begin
  str := TEdit(Sender).Text;
  if stg_RJHD.Col in [c_RJHD_RJHDQ,c_RJHD_RJHDZ] then
  begin
    if Trim(str) <> '' then
      TEdit(Sender).Text := StrRight('000000'+str,6);
  end;

end;

end.
