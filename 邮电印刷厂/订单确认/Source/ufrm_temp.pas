unit ufrm_temp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, iGrid, ExtCtrls, RzPanel;

type
  TForm2 = class(TForm)
    RzGroupBox1: TRzGroupBox;
    stg_LableGroup: Ti_StgEdit;
    btn_ok: TButton;
    btn_close: TButton;
    edt_Temp: TEdit;
    procedure FormShow(Sender: TObject);
    procedure stg_LableGroupSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure btn_okClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vOrderID: integer;
    vOrderType: integer;
  end;

var
  Form2: TForm2;

implementation

uses
  uPubType,uPub_Text;

{$R *.dfm}

{ TForm2 }

procedure TForm2.btn_okClick(Sender: TObject);
var
  i,j,n: integer;
begin
  for i := 0 to Length(LabelGroup) -1 do
  begin
    if (LabelGroup[i].m_iOrderID = vOrderID) and (LabelGroup[i].m_iOrderType = vOrderType) then
    begin
      LabelGroup[i].m_iOrderID := -1;
      LabelGroup[i].m_iOrderType := -1;
    end;
  end;
  for j := 1 to stg_LableGroup.RowCount -1 do
  begin
    if stg_LableGroup.Cells[c_Group_ZH,j] = '' then Continue;
    n := -1;
    for i := 0 to Length(LabelGroup) -1 do
    begin
      if (LabelGroup[i].m_iOrderID = -1) and (LabelGroup[i].m_iOrderType = -1) then
      begin
        //LabelGroup[i].m_iOrderID := -1;
        //LabelGroup[i].m_iOrderType := -1;
        n := i;
        Break;
      end;
    end;
    if n = -1 then
    begin
      n := Length(LabelGroup);
      SetLength(LabelGroup,n+1);
    end;
    LabelGroup[n].m_iOrderID := vOrderID;
    LabelGroup[n].m_iOrderType := vOrderType;
    LabelGroup[n].m_iOrderType := vOrderType;
    LabelGroup[n].m_iOrderType := vOrderType;
    LabelGroup[n].m_iOrderType := vOrderType;
    stg_LableGroup.Cells[c_Group_ZH,J];
    stg_LableGroup.Cells[c_Group_RJHDQ,j];
    stg_LableGroup.Cells[c_Group_RJHDZ,j];
  end;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  stg_LableGroup.ColBuddy[c_Group_ZH] := 'edt_Temp';
end;

procedure TForm2.stg_LableGroupSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  stg_LableGroup.ColBuddy[ACol] := 'edt_Temp';
end;

end.
