unit uFra_DDJY_CX;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, iGrid, StdCtrls, ExtCtrls, RzButton, RzRadChk, ComCtrls,
  RzDTP, ButtonEdit, RzCmboBx, iComboBox, RzPanel,ADODB;

const
  c_jg     = 0;
  c_CPBH   = 1;
  c_zl     = 2;
  c_yzt    = 3;
  c_yl     = 4;
  c_jybz   = 5;
  c_qy     = 6;
  c_jsrq   = 7;
  c_cz     = 8;
  c_ddlx   = 9;
  c_F_iID  = 10;
type
  TFra_DDJY_CX = class(TFrame)
    gb_dd: TRzGroupBox;
    RzGroupBox2: TRzGroupBox;
    Label3: TLabel;
    cbb_bb: Ti_ComboBox;
    edt_cpbh: Ti_TxtFilter;
    cbb_cplb: Ti_ComboBox;
    cbb_cplx: Ti_ComboBox;
    dtp_jsq: TRzDateTimePicker;
    dtp_jsz: TRzDateTimePicker;
    cb_jsrq: TRzCheckBox;
    btn_cx: TRzButton;
    pan_data: TPanel;
    lab_up: TLabel;
    lab_down: TLabel;
    lab_ts50: TLabel;
    lab_first: TLabel;
    lab_last: TLabel;
    Label2: TLabel;
    lab_zys: TLabel;
    lab_ts100: TLabel;
    lab_ts200: TLabel;
    lab_ts500: TLabel;
    Label6: TLabel;
    edt_ys: TEdit;
    btn_go: TButton;
    stg_dd: Ti_StgEdit;
    edt_Temp: TEdit;
    cbb_nf: Ti_ComboBox;
    procedure btn_cxClick(Sender: TObject);
    procedure lab_ts50Click(Sender: TObject);
    procedure lab_firstClick(Sender: TObject);
    procedure lab_upClick(Sender: TObject);
    procedure lab_downClick(Sender: TObject);
    procedure lab_lastClick(Sender: TObject);
    procedure btn_goClick(Sender: TObject);
    procedure stg_ddLinkClick(Sender: TObject; ACol, ARow: Integer);
    procedure stg_ddSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure stg_ddMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cb_jsrqClick(Sender: TObject);
    procedure cbb_cplbChange(Sender: TObject);
  private
    { Private declarations }
    vSort: Integer;
    vOredrType: Integer;
    vMYTS: Integer;     //当前每页条数
    vYs: integer;       //当前页数
    vSqlData: string;
    procedure ReadDataDD(ADO_Data: TADOQuery;Bz: integer);
    procedure edtOnMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure edtOnMouseWheelup(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ColBuddyExit;
  public
    { Public declarations }
    bBlank: boolean;
    procedure FraShow;
  end;

implementation

uses
  uDM_DataBase, PubStr, uPub_Func, uPub_Type, DateUtils, uFrm_DDJY, uPub_Text,
  uFra_DDLR;
{$R *.dfm}

procedure TFra_DDJY_CX.btn_cxClick(Sender: TObject);
var
  iCplb, iCplx, iDdlx, iXpl: Integer;
  iYS,iMYTS: Integer;
  sNf, sJsq, sJsz, sCpbh: string;
  rCplx: TProductType;
  ADO_Rec: TADOQuery;
  sSqlData: string;
  time, n: Integer;
begin
  Screen.Cursor := crHourGlass;
  time:= GetTickCount;
  sJsq := '';
  sJsz := '';
  sCpbh := edt_cpbh.Text;
  iCplb := FindProductCategoryCode(cbb_cplb.ItemIndex);
  iCplx := FindProductTypeID(cbb_cplx.ItemIndex,iCplb);
  sNf := cbb_nf.Text;
  iDdlx := cbb_bb.ItemIndex;
  iYS := 1;
  vYs := iYS;
  edt_ys.Text := IntToStr(iYs);
  if vMYTS = 0 then
  begin
    vMYTS := 50;
    lab_ts50.Font.Color :=  clBlack;
    lab_ts50.Font.Size := 10;
    lab_ts50.Font.Style := [fsBold];
    lab_ts50.Cursor := crDefault;
  end;
  iMYTS := vMYTS;
  if cb_jsrq.Checked then
  begin
    sJsq := FormatDateTime('yyyy.MM.dd 00:00:00',dtp_jsq.DateTime);
    sJsz := FormatDateTime('yyyy.MM.dd 23:59:59',dtp_jsz.DateTime);
  end;
  vOredrType := iDdlx;
  sSqlData := Format('Exec p_ddjycx ''%s'',%d,%d,''%s'',%d,''%s'',''%s'',%d,%d',[sCpbh,iCplb,iCplx,sNf,iDdlx,sJsq,sJsz,iYS,iMYTS]);
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);

  vSqlData := Format('Exec p_ddjycx ''%s'',%d,%d,''%s'',%d,''%s'',''%s'',%s,%s ',[sCpbh,iCplb,iCplx,sNf,iDdlx,sJsq,sJsz,'%d','%d']);
//  if ADO_Rec.RecordCount > 0 then
  begin
    ReadDataDD(ADO_Rec,vOredrType);
   { n := ADO_Rec.FieldByName('Count').AsInteger;
    gb_dd.Caption := '订单  总数:'+IntToStr(n)+'条';
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);   }
  end;
  Screen.Cursor := crDefault;
end;

procedure TFra_DDJY_CX.ReadDataDD(ADO_Data: TADOQuery; Bz: integer);
var
  i,n: Integer;
  dDate: TDateTime;
begin
  stg_dd.Clear;
  stg_dd.RowCount := iif(ADO_Data.RecordCount > 0, ADO_Data.RecordCount +1, 2);
  btn_cx.Caption := '查询中...';
  with ADO_Data do
  begin
    First;
    n:=0;
    if RecordCount > 0 then
    begin
      n := FieldByName('Count').AsInteger;
    end;
    gb_dd.Caption := '订单  总数:'+IntToStr(n)+'条';
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);
    n := 1;
    while not Eof do
    begin
      inc(i);
      if i mod 100 = 0 then
        btn_cx.Caption := '查询中'+StrLeft(StrRep('.',(i div 100) Mod 4)+'   ',3);
      stg_dd.cells[c_jg,n] := FieldByName('F_sJg').AsString ;
      stg_dd.cells[c_CPBH,n] := FieldByName('CPBH').AsString ;
      stg_dd.cells[c_zl,n] := FieldByName('CPLX').AsString;
      stg_dd.cells[c_yzt,n] := FieldByName('F_sYztmc').AsString;
      stg_dd.cells[c_yl,n] := FieldByName('YL').AsString;                  
      stg_dd.cells[c_jybz,n] := FieldByName('JYBZ').AsString;                  
      stg_dd.cells[c_qy,n] := FieldByName('QY').AsString;
      dDate := FieldByName('JSQR').AsDateTime;                             
      if YearOf(dDate)>2000 then
        stg_dd.cells[c_jsrq,n] := FormatDateTime('yyyy-MM-dd',dDate)       
      else                                                                 
        stg_dd.cells[c_jsrq,n] := '';                                      
      stg_dd.Cells[c_cz,n] := '加印';                                      
      stg_dd.CellsLink[c_cz,n] := '加印';                                  
      stg_dd.Cells[c_ddlx,n] := FieldByName('OrderType').AsString;         
      stg_dd.Cells[c_F_iID,n] := FieldByName('OrderID').AsString;
      inc(n);                                                              
      Next;
    end;
  end;
  stg_dd.ColWidths[c_ddlx] := 0;
  stg_dd.ColWidths[c_F_iID] := 0;
  stg_dd.Row :=1;
  btn_cx.Caption := '查询';
end;

procedure TFra_DDJY_CX.lab_ts50Click(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  iTs: Integer;
procedure LabFontClear(lab: TLabel);
begin
  lab.Font.Size := 9;
  lab.Font.Style := [];
  lab.Font.Color := clBlue;
  lab.Cursor := crHandPoint;
end;
begin
  if TLabel(Sender).Tag = vMYTS then Exit;
  iTs := TLabel(Sender).Tag;
  ADO_Rec := DM_DataBase.OpenQuery(vSqlData,[1,iTs]);
  vMYTS := iTs;
  LabFontClear(lab_ts50);
  LabFontClear(lab_ts100);
  LabFontClear(lab_ts200);
  LabFontClear(lab_ts500);
  TLabel(Sender).Font.Color :=  clBlack;
  TLabel(Sender).Font.Size := 10;
  TLabel(Sender).Font.Style := [fsBold];
  TLabel(Sender).Cursor := crDefault;
  ReadDataDD(ADO_Rec,vOredrType);
  ADO_Rec.Free;
  vYs := 1;
  edt_ys.Text := '1';
  lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);
end;

procedure TFra_DDJY_CX.lab_firstClick(Sender: TObject);
begin
  if vYs = 1 then Exit;
  edt_ys.Text := '1';
  btn_go.Click;
end;

procedure TFra_DDJY_CX.lab_upClick(Sender: TObject);
begin
  if vYs > 1 then
  begin
    edt_ys.Text := IntToStr(vYs -1);
    btn_go.Click;
  end;
end;

procedure TFra_DDJY_CX.lab_downClick(Sender: TObject);
begin
  if vYs < lab_zys.Tag then
  begin
    edt_ys.Text := IntToStr(vYs +1);
    btn_go.Click;
  end;
end;

procedure TFra_DDJY_CX.lab_lastClick(Sender: TObject);
begin
  if vYs = lab_zys.Tag then Exit;
  edt_ys.Text := IntToStr(lab_zys.Tag);
  btn_go.Click;

end;

procedure TFra_DDJY_CX.btn_goClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  iYs: Integer;
begin
  ColBuddyExit;
  iYs := StrToNum(edt_ys.Text);
  ADO_Rec := DM_DataBase.OpenQuery(vSqlData,[iYs,vMYTS]);
  ReadDataDD(ADO_Rec,vOredrType);
  lab_zys.Caption := '页次：'+IntToStr(iYs)+'/'+ IntToStr(lab_zys.Tag);
  vYs := iYs;
end;

procedure TFra_DDJY_CX.stg_ddLinkClick(Sender: TObject; ACol,
  ARow: Integer);
var
  ADO_Rec: TADOQuery;
  i, n, iID,iOrderType: Integer;
  sSqlData,sCpbh,sCplx: string;
begin
  if ACol = c_cz then
  begin
    iID := StrToNum(stg_dd.Cells[c_F_iID,ARow]);
    iOrderType := StrToNum(stg_dd.Cells[c_ddlx,ARow]);
    sCplx := stg_dd.Cells[c_zl,ARow];
    Frm_DDJY := TFrm_DDJY.Create(Self);
    Frm_DDJY.vOrderID := iID;
    Frm_DDJY.vOrderType := iOrderType;
    Frm_DDJY.vCPLX := sCplx;
    Frm_DDJY.vCpbh := stg_dd.Cells[c_CPBH,ARow];
    Frm_DDJY.ShowModal;
    cbb_cplb.Clear;
    cbb_cplb.Items.Add('--全部--');
    CbbAdd(cbb_cplb,pkProductCategory);
    cbb_cplb.ItemIndex := c_Default_CPLB;       
    cbb_cplx.Clear;
    cbb_cplx.Items.Add('--全部--');
    CbbAdd(cbb_cplx,pkProductType,FindProductCategoryID(cbb_cplb.ItemIndex));
    cbb_cplx.ItemIndex := 0;
    btn_cx.Click;
    Frm_DDJY.Free;
    Exit;
    if iID = 0 then Exit;
    if iOrderType = 0 then
      sSqlData := 'Select * from BI_CustomOrder a,BI_CustomOrderDetails b where a.F_iID=b.F_iCustomID and b.F_iID=%d'
    else if iOrderType = 1 then
      sSqlData := 'Select * from BI_SellOrder a,BI_SellOrderDetails b where a.F_iID=b.F_iSellID and b.F_iID=%d';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iID]);
    if ADO_Rec.RecordCount > 0 then
    begin
      with Frm_DDJY.Fra_DDLR do
      begin
        Frm_DDJY := TFrm_DDJY.Create(Self);
        FraShow;
        if ADO_Rec.FieldByName('F_tiDfbbz').AsInteger = 0 then
        begin
          if iOrderType = 0 then
            rb_bb_dzx.Checked := True
          else if iOrderType = 1 then
            rb_bb_xsx.Checked := True;
        end else
          rb_bb_dfb.Checked := True;
        cbb_kh.Text := ADO_Rec.FieldByName('F_sJg').AsString;
        //sCpbh := ADO_Rec.FieldByName('F_sCpbh').AsString;
        sCpbh := stg_dd.Cells[c_CPBH,ARow];
        edt_cpbh_1.Text := PosCopy(sCpbh,'-',2);
        edt_cpbh_2.Text := PosCopy(sCpbh,'-',3);
        edt_cpbh_3.Text := PosCopy(sCpbh,'-',4);
        edt_cpbh_4.Text := PosCopy(sCpbh,'-',5);
        if iOrderType = 0 then
          edt_khmc.Text := ADO_Rec.FieldByName('F_sKhmc').AsString
        else if iOrderType = 1 then
          edt_khmc.Text := ADO_Rec.FieldByName('F_sCpmc').AsString;
        edt_yl.Text := IntToStr(ADO_Rec.FieldByName('F_nYl').AsInteger*10000);
        cbb_cplx.Text := stg_dd.Cells[c_zl,ARow];
        cbb_yztmc.Text := stg_dd.Cells[c_yzt,ARow];
        cbb_tsgy.Text := ADO_Rec.FieldByName('F_sQttsgyms').AsString;
        edt_sbbbh.Text := ADO_Rec.FieldByName('F_sSbbbh').AsString;
        if ADO_Rec.FieldByName('F_tiQy').AsInteger = 0 then
          rb_qy_no.Checked := True
        else
          rb_qy_yes.Checked := True;
        lab_lry.Caption := LoginData.m_sUserName;
        Frm_DDJY.ShowModal;
        Frm_DDJY.Free;
      end;
      ADO_Rec.Free;
    end;
  end;
end;

procedure TFra_DDJY_CX.stg_ddSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if (not  bBlank)  then
  begin
    if not (ACol  in [c_cz]) then
      stg_dd.ColBuddy[ACol] := 'edt_Temp';
  end else
      stg_dd.ColBuddy[ACol] := '';

end;

procedure TFra_DDJY_CX.FraShow;
begin
  stg_dd.ColBuddy[0] := 'edt_Temp';
  Ti_StgEdit(edt_Temp).OnMouseWheelDown := edtOnMouseWheelDown;
  Ti_StgEdit(edt_Temp).OnMouseWheelUp := edtOnMouseWheelUp;
  stg_dd.p_SetColSortType(0,c_SetColSortType_Str );
  stg_dd.p_SetColSortType(1,c_SetColSortType_Str );
  stg_dd.p_SetColSortType(2,c_SetColSortType_Str );
  stg_dd.p_SetColSortType(3,c_SetColSortType_Str );
  stg_dd.p_SetColSortType(4,c_SetColSortType_Num );
  stg_dd.p_SetColSortType(5,c_SetColSortType_Str );
  stg_dd.p_SetColSortType(6,c_SetColSortType_Str );
  stg_dd.p_SetColSortType(7,c_SetColSortType_Str );


end;

procedure TFra_DDJY_CX.edtOnMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  bBlank := true;
  stg_dd.Perform(WM_VSCROLL, SB_LINEDOWN, 0);

end;

procedure TFra_DDJY_CX.edtOnMouseWheelup(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  bBlank := true;
  stg_dd.Perform(WM_VSCROLL, SB_LINEUP, 0);

end;

procedure TFra_DDJY_CX.ColBuddyExit;
var
  i: integer;
begin
  for i := 0 to  stg_dd.ColCount -1 do
  begin
    stg_dd.ColBuddy[i] := ''
  end;
end;

procedure TFra_DDJY_CX.stg_ddMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  if y < stg_dd.RowHeights[0] then
  begin
    bBlank := True;
    ColBuddyExit;
  end else
    bBlank := False;
end;

procedure TFra_DDJY_CX.cb_jsrqClick(Sender: TObject);
begin
  dtp_jsq.Enabled := cb_jsrq.Checked;
  dtp_jsz.Enabled := cb_jsrq.Checked;
end;

procedure TFra_DDJY_CX.cbb_cplbChange(Sender: TObject);
var
  iProductCategoryID: Integer;
begin
  iProductCategoryID := FindProductCategoryID(cbb_cplb.ItemIndex);
  cbb_cplx.Clear;
  cbb_cplx.Items.Add('--全部--');
  CbbAdd(cbb_cplx,pkProductType,iProductCategoryID);
  cbb_cplx.ItemIndex := 0;

end;

end.


