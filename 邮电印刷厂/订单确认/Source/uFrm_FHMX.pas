unit uFrm_FHMX;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, iGrid,ADODB, StdCtrls, iLabel, ExtCtrls, RzPanel;

type
  TFrm_FHMX = class(TForm)
    stg_fhmx: Ti_StgEdit;
    RzGroupBox1: TRzGroupBox;
    lab_yfhzl: Ti_Label;
    lab_sykc: Ti_Label;
    lab_wfhzl: Ti_Label;
    procedure FormShow(Sender: TObject);
    procedure stg_fhmxLinkClick(Sender: TObject; ACol, ARow: Integer);
  private
    { Private declarations }
    g_iApartID: Integer;
    g_iOrderID: Integer;
    g_iOrderType: Integer;
    procedure p_LoadFHMX(ADOQ_Data: TADOQuery);
  public
    { Public declarations }
    procedure p_ShowWindow(Args: array of const);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  Frm_FHMX: TFrm_FHMX;

implementation

uses
  uDM_DataBase, PubStr, uFrm_FHMX_YSDH, DateUtils;

{$R *.dfm}

const
  {stg_fhmx}
  c_CPBH     = 0;
  c_FHDH     = 1;
  c_FPRQ     = 2;
  c_FHFS     = 3;
  c_FYDH     = 4;
  c_FHSL     = 5;
//  c_LXR      = 5;
//  c_LXDH     = 6;
  c_FHR      = 6;

procedure TFrm_FHMX.FormShow(Sender: TObject);
var
  sSqlData: string;
  ADOQ_Rec: TADOQuery;
begin
  sSqlData := 'exec p_fhmx %d ';
  ADOQ_Rec := DM_DataBase.OpenQuery(sSqlData,[g_iApartID]);
  if Assigned(ADOQ_Rec) and (ADOQ_Rec.RecordCount > 0) then
  begin
    p_LoadFHMX(ADOQ_Rec);
  end;
  ADOQ_Rec.Free;
end;

procedure TFrm_FHMX.p_ShowWindow(Args: array of const);
var
  i: integer;
begin
  for i := 0 to Length(args) -1 do
  begin
    case i of
      0: g_iApartID   := args[i].VInteger;
      1: g_iOrderID   := args[i].VInteger;
      2: g_iOrderType := args[i].VInteger;
    end;
  end;
  try
    Frm_FHMX.ShowModal;
  finally
    Frm_FHMX.Free;
  end;          
end;

procedure TFrm_FHMX.p_LoadFHMX(ADOQ_Data: TADOQuery);
var
  n: Integer;
begin
  stg_fhmx.Clear;
  stg_fhmx.RowCount := iif(ADOQ_Data.RecordCount > 0, ADOQ_Data.RecordCount +1, 2);
  n := 1;
  with ADOQ_Data do
  begin
    First;
    if ADOQ_Data.RecordCount > 0 then
    begin
      lab_yfhzl.Caption := FieldByName('YFHZL').AsString;
      lab_sykc.Caption  := FieldByName('SYKC').AsString;
      lab_wfhzl.Caption := FieldByName('WFHZL').AsString;
    end;
    while not Eof do
    begin
      stg_fhmx.cells[c_CPBH,n] := FieldByName('CPBH').AsString;
      stg_fhmx.cells[c_FHDH,n] := FieldByName('FHDH').AsString;
      stg_fhmx.cells[c_FPRQ,n] := FieldByName('FPRQ').AsString;
      stg_fhmx.cells[c_FHFS,n] := FieldByName('FHFS').AsString;
      stg_fhmx.cells[c_FYDH,n] := FieldByName('FYDH').AsString;
      stg_fhmx.CellsLink[c_FYDH,n] := FieldByName('FYDH').AsString;
      stg_fhmx.cells[c_FHSL,n] := FieldByName('FHSL').AsString;
      //stg_fhmx.cells[c_LXR ,n] := FieldByName('LXR').AsString;
      //stg_fhmx.cells[c_LXDH,n] := FieldByName('LXDH').AsString;
      stg_fhmx.cells[c_FHR ,n] := FieldByName('FHR').AsString;
      inc(n);
      Next;
    end;
  end;
end;

procedure TFrm_FHMX.CreateParams(var Params: TCreateParams);
begin
  inherited;
  //Params.WndParent :=   0 ;//¾ÍÊÇ×ÀÃæ
end;

procedure TFrm_FHMX.stg_fhmxLinkClick(Sender: TObject; ACol,
  ARow: Integer);
const
  c_FXH  = 0;
  c_CPBH = 1;
  c_YSDM = 2;
  c_CZR  = 3;
  c_CZRQ = 4;
var
  sSqlData: string;
  ADOQ_Rec: TADOQuery;
  n: Integer;
  dDate: TDateTime;
begin
  if ACol = c_FYDH then
  begin
    if stg_fhmx.Cells[c_FYDH,stg_fhmx.Row]='' then Exit;

    sSqlData := 'exec p_ysdhmx %d ';
    ADOQ_Rec := DM_DataBase.OpenQuery(sSqlData,[g_iApartID]);
    if Assigned(ADOQ_Rec) and (ADOQ_Rec.RecordCount > 0) then
    begin
      Frm_FHMX_YSDH := TFrm_FHMX_YSDH.Create(Self);
      Frm_FHMX_YSDH.stg_ysdh.ColBuddy[c_YSDM] := 'edt_Temp';
      with Frm_FHMX_YSDH do
      begin
        stg_ysdh.Clear;
        stg_ysdh.RowCount := iif(ADOQ_Rec.RecordCount > 0, ADOQ_Rec.RecordCount +1, 2);
        n := 1;
        while not ADOQ_Rec.Eof do
        begin
          stg_ysdh.Cells[c_FXH,n] := ADOQ_Rec.FieldByName('FXH').AsString;
          stg_ysdh.Cells[c_CPBH,n] := ADOQ_Rec.FieldByName('F_sCPBH').AsString;
          stg_ysdh.Cells[c_YSDM,n] := ADOQ_Rec.FieldByName('F_sFYDH').AsString;
          stg_ysdh.Cells[c_CZR,n] := ADOQ_Rec.FieldByName('CZR').AsString;
          dDate := ADOQ_Rec.FieldByName('F_dCZRQ').AsDateTime;
          if YearOf(dDate) > 2000 then
            stg_ysdh.Cells[c_CZRQ,n] := FormatDateTime('yyyy-MM-dd hh:MM:ss',dDate);
          Inc(n);
          ADOQ_Rec.Next;
        end;
      end;
      Frm_FHMX_YSDH.ShowModal;
      Frm_FHMX_YSDH.Free;
    end;
    ADOQ_Rec.Free;

  end;
end;

end.
