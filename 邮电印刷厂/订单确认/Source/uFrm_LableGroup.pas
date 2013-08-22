unit uFrm_LableGroup;

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
    btn_hdrl: TButton;
    procedure FormShow(Sender: TObject);
    procedure stg_LableGroupSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure btn_okClick(Sender: TObject);
    procedure btn_hdrlClick(Sender: TObject);
    procedure edt_TempExit(Sender: TObject);
  private
    { Private declarations }
    procedure SetValueLabelGroup(n,iRow: integer);
  public
    { Public declarations }
    vOrderID: integer;
    vOrderType: integer;
  end;

var
  Frm_LableGroup: TFrm_LableGroup;

implementation

uses
  uPub_Type, uPub_Func, uPub_Text, PubStr;
  
{$R *.dfm}

procedure TFrm_LableGroup.FormShow(Sender: TObject);
begin
  stg_LableGroup.ColBuddy[c_Group_ZH] := 'edt_Temp';
  stg_LableGroup.ColBuddy[c_Group_RJHDQ] := 'edt_Temp';
  stg_LableGroup.ColBuddy[c_Group_RJHDZ] := 'edt_Temp';
end;

procedure TFrm_LableGroup.stg_LableGroupSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
//  stg_LableGroup.ColBuddy[ACol] := 'edt_Temp';
  if stg_LableGroup.RowCount = ARow+1 then
    stg_LableGroup.RowCount := stg_LableGroup.RowCount +1;
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
    SetValueLabelGroup(n,j);
   // LabelGroup[n].m_iOrderID := vOrderID;
   // LabelGroup[n].m_iOrderType := vOrderType;
   // LabelGroup[n].m_sZH := stg_LableGroup.Cells[c_Group_ZH,j];
   // LabelGroup[n].m_sRJHDQ := stg_LableGroup.Cells[c_Group_RJHDQ,j];
   // LabelGroup[n].m_sRJHDZ := stg_LableGroup.Cells[c_Group_RJHDZ,j];
  end;
  //p_MessageBoxDlg('提交成功!','提示');
end;



procedure TFrm_LableGroup.SetValueLabelGroup(n, iRow: integer);
begin
    LabelGroup[n].m_iOrderID := vOrderID;
    LabelGroup[n].m_iOrderType := vOrderType;
    LabelGroup[n].m_sZH := stg_LableGroup.Cells[c_Group_ZH,iRow];
    LabelGroup[n].m_sRJHDQ := stg_LableGroup.Cells[c_Group_RJHDQ,iRow];
    LabelGroup[n].m_sRJHDZ := stg_LableGroup.Cells[c_Group_RJHDZ,iRow];
end;

procedure TFrm_LableGroup.btn_hdrlClick(Sender: TObject);
var
  i: integer;
  bStart: Boolean;
  sZH, sRJHDQ, sRJHDZ: string;
begin
 { if edt_Temp.Visible then
    edt_TempExit(nil);
  bStart := False;
  for i := 1 to stg_LableGroup.RowCount -1 do
  begin
    if not bStart then
    begin
      if stg_LableGroup.Cells[c_Group_ZH,i] <> '' then
      begin
        sZH := stg_LableGroup.Cells[c_Group_ZH,i];
        sRJHDQ := stg_LableGroup.Cells[c_Group_RJHDQ,i];
        sRJHDZ := stg_LableGroup.Cells[c_Group_RJHDZ,i];
        if Trim(stg_LableGroup.Cells[c_Group_BCYL,i]) = '' then
        begin
          if  (Trim(sRJHDQ) = '') or (Trim(sRJHDZ)='') then
            stg_LableGroup.Cells[c_Group_BCYL,i] := stg_LableGroup.Cells[c_Group_SYYL,i]
          else
            stg_LableGroup.Cells[c_Group_BCYL,i] := StrToNum(sRJHDZ) - StrToNum(sRJHDQ) + 1;
        end;
        bStart := True;
      end;
      Continue;
    end;
    if StrToNum(stg_LableGroup.Cells[c_Group_BCYL,i]) = 0 then
    begin
      stg_LableGroup.Cells[c_Group_BCYL,i] := stg_LableGroup.Cells[c_Group_SYYL,i];
    end;
    stg_LableGroup.Cells[c_Group_ZH,i] := sZH;
    sRJHDQ := StrToNum(sRJHDZ) + 1;
    stg_LableGroup.Cells[c_Group_RJHDQ,i] := StrRight('000000'+sRJHDQ,6);
    sRJHDZ := sRJHDQ + StrToNum(stg_LableGroup.Cells[c_Group_BCYL,i]) -1;
    stg_LableGroup.Cells[c_Group_RJHDZ,i] := StrRight('000000'+sRJHDZ,6);

  end;
  if not bStart then
  begin
    p_MessageBoxDlg('请先输入一组数据!')
  end;       }
end;

procedure TFrm_LableGroup.edt_TempExit(Sender: TObject);
var
  str, sRJHDQ, sRJHDZ: string;
begin
  str := TEdit(Sender).Text;
  if stg_LableGroup.Col in [c_Group_RJHDQ,c_Group_RJHDZ] then
  begin
    if Trim(str) <> '' then
      TEdit(Sender).Text := StrRight('000000'+str,6);
  end;
  {
  if (stg_LableGroup.Col in [c_Group_RJHDQ]) and (Trim(str) <> '')
    and (Trim(stg_LableGroup.Cells[c_Group_RJHDZ,stg_LableGroup.Row]) = '') and (IsNum(stg_LableGroup.Cells[c_Group_BCYL,stg_LableGroup.Row]))  then
  begin
    //sRJHDZ := StrToNum(stg_list.Cells[c_List_RJHDQ,stg_list.Row]) + StrToNum(stg_list.Cells[c_List_BCYL,stg_list.Row]) -1;
    sRJHDZ := StrToNum(str) + StrToNum(stg_LableGroup.Cells[c_Group_BCYL,stg_LableGroup.Row]) -1;
    stg_LableGroup.Cells[c_Group_RJHDZ,stg_LableGroup.Row] := StrRight('000000'+sRJHDZ,6);
  end;      }
end;

end.
