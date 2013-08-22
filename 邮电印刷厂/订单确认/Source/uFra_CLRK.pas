unit uFra_CLRK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, RzButton, StdCtrls, ButtonEdit, Grids, iGrid, ExtCtrls, RzPanel,
  ADODB;

type
  TFra_CLRK = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    stg_clkc: Ti_StgEdit;
    RzGroupBox3: TRzGroupBox;
    edt_clmc: Ti_TxtFilter;
    edt_clsjjg: Ti_TxtFilter;
    edt_clbh: Ti_TxtFilter;
    btn_cl: TButton;
    edt_cljhjg: Ti_TxtFilter;
    edt_sl: Ti_TxtFilter;
    btn_ok: TRzButton;
    RzGroupBox2: TRzGroupBox;
    stg_rkxx: Ti_StgEdit;
    procedure stg_rkxxKeyPress(Sender: TObject; var Key: Char);
    procedure btn_clClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    { Private declarations }
    function IsCheck: Boolean;
    procedure p_LoadCLXX;
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

uses
  uFrm_Select_CL, uDM_DataBase, uPub_Func, uPub_Type, PubStr;

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

{ TFra_CLRK }

procedure TFra_CLRK.FraShow;
begin
  p_LoadCLXX;
end;

function TFra_CLRK.IsCheck: Boolean;
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
            Application.MessageBox(PChar('请输入 '+Ti_TxtFilter(comp).LabelCaption+'!'),'提示',MB_ICONINFORMATION);
            Ti_TxtFilter(comp).SetFocus;
            Exit;
          end;
        end;
      end;
    end;
  end;
  Result := True;

end;

procedure TFra_CLRK.p_LoadCLXX;
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
  n: Integer;
begin
  sSqlData := 'Select a.F_sBM,Sum(a.F_nSL) JCSL, CCSL=(select Sum(c.F_nSL) from DO_StockOutInfo c where c.F_tiCXBZ =0 and a.F_sPCH=c.F_sPCH), '
    +' b.F_sCLMC,b.F_sDW from DO_StockInInfo a '
    +' left join BI_MatlManage b on a.F_sBM=b.F_sCLBH and a.F_iXM=1 where a.F_tiCXBZ=0 '
    +' group by a.F_sBM,b.F_sCLMC,b.F_sDW,a.F_sPCH order by a.F_sBM ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
  stg_clkc.Clear;
  stg_clkc.RowCount := 2;
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    stg_clkc.RowCount := ADO_Rec.RecordCount +1;
    n := 1;
    while not ADO_Rec.Eof do
    begin
      stg_clkc.Cells[c_KC_CLBH,n] := ADO_Rec.FieldByName('F_sBM').AsString;
      stg_clkc.Cells[c_KC_CLMC,n] := ADO_Rec.FieldByName('F_sCLMC').AsString;
      stg_clkc.Cells[c_KC_DQKC,n] := IntToStr(ADO_Rec.FieldByName('JCSL').AsInteger-ADO_Rec.FieldByName('CCSL').AsInteger);
      stg_clkc.Cells[c_KC_JCSL,n] := ADO_Rec.FieldByName('JCSL').AsString;
      stg_clkc.Cells[c_KC_CCSL,n] := ADO_Rec.FieldByName('CCSL').AsString;
      stg_clkc.Cells[c_KC_CLDW,n] := ADO_Rec.FieldByName('F_sDW').AsString;
      inc(n);
      ADO_Rec.Next;
    end;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

  sSqlData := 'Select a.*,b.F_sCLMC,b.F_sDW,c.F_sRealName from DO_StockInInfo a left join BI_MatlManage b on a.F_sBM=b.F_sCLBH,BI_UserList c '
    + ' where a.F_sCZRBM=c.F_sName order by a.F_iID desc ';
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
      stg_rkxx.Cells[c_RK_CLBH,n]  := ADO_Rec.FieldByName('F_sBM').AsString;
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

procedure TFra_CLRK.stg_rkxxKeyPress(Sender: TObject; var Key: Char);
begin
 if  Key = #13 then
 begin
   btn_cl.Click;
   Exit;
 end;

end;

procedure TFra_CLRK.btn_clClick(Sender: TObject);
begin
  Frm_Select_CL := TFrm_Select_CL.Create(Self);
  Frm_Select_CL.cbb_type.Text := '材料编号';
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

procedure TFra_CLRK.btn_okClick(Sender: TObject);
var
  sSqlData,sPCH: string;
  ADO_Rec: TADOQuery;
  iXM,iSL: Integer;
  sBM,sCZRBM: string;
  nSJJG,nJHJG: Double;
begin
  if not IsCheck then Exit;
  iXM := 1;
  sBM := edt_clbh.Text;;
  nSJJG := StrToFloat(edt_clsjjg.Text);
  nJHJG := StrToFloat(edt_cljhjg.Text);
  iSL := StrToNum(edt_sl.Text);
  sCZRBM := LoginData.m_sUserName;
  try
    DM_DataBase.Con_YDPrint.BeginTrans;
    sSqlData := 'exec p_StockIn %d,''%s'',%f,%f,%d,%s';  //参数(项目(1:材料),编码,实际价格,计划价格,采购数量,操作人编码 )
    DM_DataBase.ExecQuery(sSqlData,[iXM,sBM,nSJJG,nJHJG,iSL,sCZRBM]);
    {sSqlData := 'select * from DO_StockInInfo where 1=2 ';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[],True);
    with ADO_Rec do
    begin
      Insert;
      DM_DataBase.GetMaxID('DO_StockInInfo','F_sPCH',sPCH);
      FieldByName('F_iXM').AsInteger   := 1;
      FieldByName('F_sPCH').AsString   := sPCH;
      FieldByName('F_sBH').AsString  := edt_clbh.Text;
      //FieldByName('F_sBDBZ').AsString  := 'J';
      FieldByName('F_nSJJG').AsString  := edt_clsjjg.Text;
      FieldByName('F_nJHJG').AsString  := edt_cljhjg.Text;
      FieldByName('F_nSL').AsString    := edt_sl.Text;
      FieldByName('F_sCZRBM').AsString := LoginData.m_sUserName;
      FieldByName('F_dCZRQ').AsDateTime  := Now;
      Post;
    end;     }
    DM_DataBase.Con_YDPrint.CommitTrans;
    p_LoadCLXX;
  except
    on E: Exception do
    begin
      DM_DataBase.Con_YDPrint.RollbackTrans;
      p_MessageBoxDlg('错误：'+e.Message);
    end;
  end;
end;

end.
