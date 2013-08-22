unit uFrm_ZTMX;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, iLabel, ExtCtrls, RzPanel, Grids, iGrid, ADODB;

type
  TFrm_ZTMX = class(TForm)
    stg_ztmx: Ti_StgEdit;
    RzGroupBox1: TRzGroupBox;
    lab_wkdyl: Ti_Label;
    lab_ykdyl: Ti_Label;
    lab_zyl: Ti_Label;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    g_iApartID: Integer;
    procedure p_LoadZTMX(ADOQ_Data: TADOQuery);
  public
    { Public declarations }
    procedure p_ShowWindow(Args: array of const);
  end;

var
  Frm_ZTMX: TFrm_ZTMX;

implementation

uses
  uDM_DataBase, PubStr, DB;

{$R *.dfm}

{ TFrm_ZTMX }

const
  c_CPBH  = 0;
  c_ZT    = 1;
  c_CZRBM = 2;
  c_CZRQ  = 3;

procedure TFrm_ZTMX.p_ShowWindow(Args: array of const);
var
  i: integer;
begin
  for i := 0 to Length(args) -1 do
  begin
    case i of
      0: g_iApartID := args[i].VInteger;
    end;
  end;
  try
    Frm_ZTMX.ShowModal;
  finally
    Frm_ZTMX.Free;
  end;
end;

procedure TFrm_ZTMX.FormShow(Sender: TObject);
var
  sSqlData: string;
  ADOQ_Rec: TADOQuery;
begin
  sSqlData := 'exec p_ztmx %d ';
  ADOQ_Rec := DM_DataBase.OpenQuery(sSqlData,[g_iApartID]);
  if Assigned(ADOQ_Rec) and (ADOQ_Rec.RecordCount > 0) then
  begin
    p_LoadZTMX(ADOQ_Rec);
  end;
  ADOQ_Rec.Free;
end;

procedure TFrm_ZTMX.p_LoadZTMX(ADOQ_Data: TADOQuery);
var
  n: Integer;
begin
  stg_ztmx.Clear;
  stg_ztmx.RowCount := iif(ADOQ_Data.RecordCount > 0, ADOQ_Data.RecordCount +1, 2);
  n := 1;
  with ADOQ_Data do
  begin
    First;
    if ADOQ_Data.RecordCount > 0 then
    begin
      lab_ykdyl.Caption := FieldByName('YKDYL').AsString;
      lab_wkdyl.Caption  := FieldByName('WKDYL').AsString;
      lab_zyl.Caption := FieldByName('ZYL').AsString;
    end;
    while not Eof do
    begin
      stg_ztmx.cells[c_CPBH,n] := FieldByName('CPBH').AsString;
      stg_ztmx.cells[c_ZT,n] := FieldByName('ZT').AsString;
      stg_ztmx.cells[c_CZRBM,n] := FieldByName('CZRBM').AsString;
      //stg_ztmx.cells[c_CZRQ,n] := FieldByName('CZRQ').AsString;
      stg_ztmx.cells[c_CZRQ,n] := FormatDateTime('yyyy-MM-dd hh:mm:ss', FieldByName('CZRQ').AsDateTime);
      inc(n);
      Next;
    end;
  end;
end;

end.
