unit uFrm_FHGL_JZFS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, iGrid, StdCtrls, RzButton, ADODB;

type
  TFrm_FHGL_JZFS = class(TForm)
    lab_Text: TLabel;
    btn_A: TRzButton;
    btn_B: TRzButton;
    GroupBox1: TGroupBox;
    stg_njxx: Ti_StgEdit;
    edt_Temp: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btn_AClick(Sender: TObject);
    procedure btn_BClick(Sender: TObject);
  private
    { Private declarations }
    procedure ReadNJXX(ADO_Data: TADOQuery);
    
  public
    { Public declarations }
  end;

var
  Frm_FHGL_JZFS: TFrm_FHGL_JZFS;

implementation

uses
  PubStr,uPub_Text;

{$R *.dfm}

procedure TFrm_FHGL_JZFS.FormShow(Sender: TObject);
begin
  stg_njxx.Cells[c_NJXX_CPBH, 1] := stg_njxx.Cells[c_NJXX_CPBH, 0];
  stg_njxx.Cells[c_NJXX_NJPM, 1] := stg_njxx.Cells[c_NJXX_NJPM, 0];
  stg_njxx.Cells[c_NJXX_CPLX, 1] := '产品类型';
  stg_njxx.Cells[c_NJXX_SL, 1]   := '数量';
  stg_njxx.Cells[c_NJXX_CPDW, 1] := '单位';
  stg_njxx.ColBuddy[c_NJXX_NJPM] := 'edt_Temp';
  stg_njxx.ColBuddy[c_NJXX_CPLX] := 'edt_Temp';
  stg_njxx.ColBuddy[c_NJXX_SL]   := 'edt_Temp';
  stg_njxx.ColBuddy[c_NJXX_CPDW] := 'edt_Temp';
end;

procedure TFrm_FHGL_JZFS.btn_AClick(Sender: TObject);
begin
  ModalResult := mrYes;

end;

procedure TFrm_FHGL_JZFS.btn_BClick(Sender: TObject);
begin
  ModalResult := mrNo;

end;

procedure TFrm_FHGL_JZFS.ReadNJXX(ADO_Data: TADOQuery);
var
  n: Integer;
  sDw: string;
begin
  stg_njxx.Clear;
  stg_njxx.RowCount := iif(ADO_Data.RecordCount > 0, ADO_Data.RecordCount +2, 3);
  n := 1;
  with ADO_Data do
  begin
    First;
    while not Eof do
    begin
//      stg_njxx.Cells[c_CPBH,n] := FieldByName('F_sCpbh').AsString;
//      stg_njxx.Cells[c_NJPM,n] := FieldByName('F_sCpbh').AsString;
//      stg_njxx.Cells[c_CPLX,n] := FieldByName('F_sCpbh').AsString;
//      stg_njxx.Cells[c_NJSL,n] := FieldByName('F_sCpbh').AsString;
//      stg_njxx.Cells[c_CPDW,n] := '枚';

      inc(n);
      Next;
    end;
  end;
end;

end.
