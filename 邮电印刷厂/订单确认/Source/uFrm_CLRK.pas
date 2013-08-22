unit uFrm_CLRK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzCmboBx, iComboBox, ButtonEdit, ExtCtrls, Grids,
  iGrid, RzPanel, RzButton, ADODB;

type
  TFrm_CLRK = class(TForm)
    RzGroupBox1: TRzGroupBox;
    stg_clkc: Ti_StgEdit;
    RzGroupBox3: TRzGroupBox;
    edt_clmc: Ti_TxtFilter;
    edt_clsjjg: Ti_TxtFilter;
    edt_clbh: Ti_TxtFilter;
    btn_cl: TButton;
    edt_cljhjg: Ti_TxtFilter;
    edt_sl: Ti_TxtFilter;
    RzGroupBox2: TRzGroupBox;
    stg_rkxx: Ti_StgEdit;
    btn_ok: TRzButton;
    procedure btn_clClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure edt_clbhKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function IsCheck: Boolean;
    procedure p_LoadCLXX;
  public
    { Public declarations }
    procedure FraShow;
  end;

var
  Frm_CLRK: TFrm_CLRK;

implementation

uses
  uFrm_Select_CL, uDM_DataBase, uPub_Func;

{$R *.dfm}

const
  c_KC_CLBH   = 0;
  c_KC_CLMC   = 1;
  c_KC_DQKC   = 2;
  c_KC_JCSL   = 3;
  c_KC_CCSL   = 4;
  c_KC_CLDW   = 5;

  c_RK_PCH    = 0;
  c_RK_CLBH   = 1;
  c_RK_CLMC   = 2;
  c_RK_SJJG   = 3;
  c_RK_JHJG   = 4;
  c_RK_CLSL   = 5;
  c_RK_CLDW   = 6;
  c_RK_CZR    = 7;
  c_RK_RQ     = 8;

procedure TFrm_CLRK.btn_clClick(Sender: TObject);
begin
  Frm_Select_CL := TFrm_Select_CL.Create(Self);
  Frm_Select_CL.cbb_type.Text := '²ÄÁÏ±àºÅ';
  Frm_Select_CL.edt_value.Text := edt_clbh.Text;
  Frm_Select_CL.ShowModal;
  if Frm_Select_CL.vSuccess then
  begin
    edt_clbh.Text := Frm_Select_CL.vCLBH;
    edt_clmc.Text := Frm_Select_CL.vCLMC;
    edt_clsjjg.Text := Frm_Select_CL.vCLSJJG;
    edt_cljhjg.Text := Frm_Select_CL.vCLJHJG;
  end;
  Frm_Select_CL.Free;

end;

procedure TFrm_CLRK.btn_okClick(Sender: TObject);
var
  sSqlData,sPCH: string;
  ADO_Rec: TADOQuery;
begin
  if not IsCheck then Exit;
  try
    DM_DataBase.Con_YDPrint.BeginTrans;
    sSqlData := 'select * from DO_MatlInventoryDet where 1=2 ';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[],True);
    with ADO_Rec do
    begin
      Insert;
      DM_DataBase.GetMaxID('DO_MatlInventoryDet','F_sPCH',sPCH);
      FieldByName('F_sPCH').AsString := sPCH;
      FieldByName('F_sCLBH').AsString := edt_clbh.Text;
      FieldByName('F_sBDBZ').AsString := 'J';
      FieldByName('F_nSJJG').AsString := edt_clsjjg.Text;
      FieldByName('F_sPCH').AsString := edt_cljhjg.Text;
      FieldByName('F_sPCH').AsString := edt_sl.Text;
    end;
    DM_DataBase.Con_YDPrint.CommitTrans;
  except
    on E: Exception do
    begin
      DM_DataBase.Con_YDPrint.RollbackTrans;
      p_MessageBoxDlg('´íÎó£º'+e.Message);
    end;
  end;
end;

function TFrm_CLRK.IsCheck: Boolean;
var
  i: Integer;
  comp: TComponent;
begin
  Result := False;
  for i := 0 to Self.ComponentCount -1 do
  begin
    comp := Self.Components[i];
    if  comp.Tag <> 10 then
    begin
      if (comp is Ti_TxtFilter) or (comp is TComboBox) then
      begin
        if comp is Ti_TxtFilter then
        begin
          if Ti_TxtFilter(comp).Text = '' then
          begin
            Application.MessageBox(PChar('ÇëÊäÈë '+Ti_TxtFilter(comp).LabelCaption+'!'),'ÌáÊ¾',MB_ICONINFORMATION);
            Ti_TxtFilter(comp).SetFocus;
            Exit;
          end;
        end;
      end;
    end;
  end;
  Result := True;
end;

procedure TFrm_CLRK.p_LoadCLXX;
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
  n: Integer;
begin
  sSqlData := 'Select a.*,b.F_sCLMC,b.F_sDW from BI_MatlInventory a left join BI_MatlManage b on a.F_sCLBH=b.F_sCLBH order by a.F_sCLBH ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
  stg_clkc.Clear;
  stg_clkc.RowCount := 2;
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    stg_clkc.RowCount := ADO_Rec.RecordCount +1;
    n := 1;
    while not ADO_Rec.Eof do
    begin
      stg_clkc.Cells[c_KC_CLBH,n] := ADO_Rec.FieldByName('F_sCLBH').AsString;
      stg_clkc.Cells[c_KC_CLMC,n] := ADO_Rec.FieldByName('F_sCLMC').AsString;
      stg_clkc.Cells[c_KC_DQKC,n] := ADO_Rec.FieldByName('F_nSL').AsString;
      stg_clkc.Cells[c_KC_JCSL,n] := ADO_Rec.FieldByName('F_nJCSL').AsString;
      stg_clkc.Cells[c_KC_CCSL,n] := ADO_Rec.FieldByName('F_nCCSL').AsString;
      stg_clkc.Cells[c_KC_CLDW,n] := ADO_Rec.FieldByName('F_sDW').AsString;
      inc(n);
      ADO_Rec.Next;
    end;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

  sSqlData := 'Select a.*,b.F_sCLMC,b.F_sDW,c.F_sRealName from DO_MatlInventoryDet a left join BI_MatlManage b on a.F_sCLBH=b.F_sCLBH,BI_UserList c'
    + ' where a.F_sBDBZ =''J'' and a.CZRBH=c.F_sName order by a.F_iID desc ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
  stg_rkxx.Clear;
  stg_rkxx.RowCount := 2;
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    stg_rkxx.RowCount := ADO_Rec.RecordCount +1;
    n := 1;
    while not ADO_Rec.Eof do
    begin
      stg_rkxx.Cells[c_RK_PCH,n]   := ADO_Rec.FieldByName('F_sPCH').AsString;
      stg_rkxx.Cells[c_RK_CLBH,n]  := ADO_Rec.FieldByName('F_sCLBH').AsString;
      stg_rkxx.Cells[c_RK_CLMC,n]  := ADO_Rec.FieldByName('F_sCLMC').AsString;
      stg_rkxx.Cells[c_RK_SJJG,n]  := ADO_Rec.FieldByName('F_nSJJG').AsString;
      stg_rkxx.Cells[c_RK_JHJG,n]  := ADO_Rec.FieldByName('F_nJHJG').AsString;
      stg_rkxx.Cells[c_RK_CLSL,n]  := ADO_Rec.FieldByName('F_nSL').AsString;
      stg_rkxx.Cells[c_RK_CLDW,n]  := ADO_Rec.FieldByName('F_sDW').AsString;
      stg_rkxx.Cells[c_RK_CZR,n]   := ADO_Rec.FieldByName('F_sRealName').AsString;
      stg_rkxx.Cells[c_RK_RQ,n]    := FormatDateTime('yyyy-MM-dd hh:mm:ss',ADO_Rec.FieldByName('F_dCZRQ').AsDateTime);
      inc(n);
      ADO_Rec.Next;
    end;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

end;

procedure TFrm_CLRK.edt_clbhKeyPress(Sender: TObject; var Key: Char);
begin
 if  Key = #13 then
 begin
   btn_cl.Click;
   Exit;
 end;
end;

procedure TFrm_CLRK.FraShow;
begin

end;

end.
