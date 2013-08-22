unit uFrm_XQZH;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, iGrid, ExtCtrls, RzPanel, StdCtrls;


type
  TFrm_LableGroup = class(TForm)
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
  Frm_LableGroup: TFrm_LableGroup;

implementation

uses
  uPubType,uPub_Text;
  
{$R *.dfm}

procedure TFrm_LableGroup.FormShow(Sender: TObject);
begin
  stg_LableGroup.ColBuddy[c_Group_ZH] := 'edt_Temp';
end;

procedure TFrm_LableGroup.stg_LableGroupSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  stg_LableGroup.ColBuddy[ACol] := 'edt_Temp';
end;

procedure TFrm_LableGroup.btn_okClick(Sender: TObject);
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
    LabelGroup[n].m_sZH := stg_LableGroup.Cells[c_Group_ZH,j];
    LabelGroup[n].m_sRJHDQ := stg_LableGroup.Cells[c_Group_RJHDQ,j];
    LabelGroup[n].m_sRJHDZ := stg_LableGroup.Cells[c_Group_RJHDZ,j];
  end;

end;

end.
