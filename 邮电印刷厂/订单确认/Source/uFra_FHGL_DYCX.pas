unit uFra_FHGL_DYCX;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, iGrid, RzRadChk, ComCtrls, RzDTP, RzButton, StdCtrls,
  iComboBox, ButtonEdit, ExtCtrls, RzPanel,ADODB, DB;

const
  c_cz = 0;
  c_cs = 1;
  c_fhdh = 2;
  c_spdw = 3;
  c_lxr = 4;
  c_fpdw = 5;
  c_fprq = 6;
  c_F_iID= 7;

type
  TFra_FHGL_DYCX = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    Label3: TLabel;
    edt_spdw: Ti_TxtFilter;
    edt_fhdh: Ti_TxtFilter;
    btn_cx: TRzBitBtn;
    dtp_fpq: TRzDateTimePicker;
    dtp_fpz: TRzDateTimePicker;
    cb_fprq: TRzCheckBox;
    gb_fhd: TRzGroupBox;
    stg_fhd: Ti_StgEdit;
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
    edt_Temp: TEdit;
    edt_cpbh: Ti_TxtFilter;
    Splitter2: TSplitter;
    RzPanel1: TRzPanel;
    RzGroupBox2: TRzGroupBox;
    stg_fhmx: Ti_StgEdit;
    edt_Temp2: TEdit;
    lab_tsQB: TLabel;
    cb_History: TCheckBox;
    procedure btn_cxClick(Sender: TObject);
    procedure stg_fhdLinkClick(Sender: TObject; ACol, ARow: Integer);
    procedure cb_fprqClick(Sender: TObject);
    procedure lab_ts50Click(Sender: TObject);
    procedure lab_firstClick(Sender: TObject);
    procedure lab_upClick(Sender: TObject);
    procedure lab_downClick(Sender: TObject);
    procedure lab_lastClick(Sender: TObject);
    procedure btn_goClick(Sender: TObject);
    procedure stg_fhdSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure stg_fhdMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    vMYTS: Integer;     //当前每页条数
    vYs: integer;       //当前页数
    vSqlData: string;
    bBlank : boolean;
    procedure ReadDataFHD(ADO_Data: TADOQuery);
    procedure edtOnMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure edtOnMouseWheelup(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ColBuddyExit;
    procedure ReadDataFHMX(ADOQ_Data: TADOQuery);
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

uses
  uDM_DataBase, PubStr, DateUtils, uFrm_FHGL_DY, uPub_Type, uPub_Func, uPub_Text;
{$R *.dfm}

const
  c_KHMC     = 0;
  c_CPBH     = 1;
  c_MZ       = 2;
  c_TB       = 3;
  c_XS       = 4;
  c_MXMS     = 5;
  c_MS       = 6;
  c_BZ       = 7;

procedure TFra_FHGL_DYCX.btn_cxClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  sCPBH,sFHDH, sSPDW, sFPq,sFPz: string;
  i, iYS,iMYTS: Integer;
begin
  if cb_fprq.Checked then
  begin
    sFPq := FormatDateTime('yyyy.MM.dd 00:00:00',dtp_fpq.DateTime);
    sFPz := FormatDateTime('yyyy.MM.dd 23:59:59',dtp_fpz.DateTime);
  end;
  sFHDH := Trim(edt_fhdh.Text);
  sSPDW := Trim(edt_spdw.Text);
  sCPBH := Trim(edt_cpbh.Text);
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
{  sSqlData := 'Select * from DO_Invoice where 1=1 ';
  if cb_fprq.Checked then
    sSqlData := sSqlData + ' and F_dFPRQ >= '''+sFPq+''' and F_dFPRQ<='''+sFPz+''' ';
  if sFHDH <> '' then
    sSqlData := sSqlData + ' and F_sFHDH = '''+sFHDH+''' ';
  if sSPDW <> '' then
    sSqlData := sSqlData + ' and F_sSPDW = '''+sSPDW+''' ';
  sSqlData := sSqlData + ' order by F_dFPRQ desc'; }
//  sSqlData := 'p_fhdycx ''%s'',''%s'',''%s'',''%s'',%d,%d';
//  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sFHDH,sSPDW,sFPq,sFPz,iYS,iMYTS]);
//  vSqlData := Format('p_fhdycx ''%s'',''%s'',''%s'',''%s''',[sFHDH,sSPDW,sFPq,sFPz])+',%d,%d';
  sSqlData := 'p_fhdycx ''%s'',''%s'',''%s'',''%s'',''%s'',%d,%d';
  if not cb_History.checked then
  begin
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sCPBH,sFHDH,sSPDW,sFPq,sFPz,iYS,iMYTS],False,False);
  end else
  begin
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sCPBH,sFHDH,sSPDW,sFPq,sFPz,iYS,iMYTS],False,True);
  end;
  vSqlData := Format('p_fhdycx ''%s'',''%s'',''%s'',''%s'',''%s'',%s,%s',[sCPBH,sFHDH,sSPDW,sFPq,sFPz,'%d','%d']);
  if Assigned(ADO_Rec) then
  begin
    ReadDataFHD(ADO_Rec);
    if not cb_History.checked then
    begin
      for i := 1 to stg_fhd.RowCount -1 do
      begin
        stg_fhd.CellsFontColor[c_cz,i] := clBlack;
        stg_fhd.CellsLink[c_cz,i] := '详细';
      end;
    end else
    begin
      for i := 1 to stg_fhd.RowCount -1 do
      begin
        stg_fhd.CellsFontColor[c_cz,i] := clSilver;
        stg_fhd.CellsLink[c_cz,i] := '';
      end;
    end;

    ADO_Rec.Free;
  end;

end;

procedure TFra_FHGL_DYCX.ReadDataFHD(ADO_Data: TADOQuery);
var
  i,n: Integer;
  dDate: TDateTime;
begin
  stg_fhd.Clear;
  stg_fhd.RowCount := iif(ADO_Data.RecordCount > 0, ADO_Data.RecordCount +1, 2);
  btn_cx.Caption := '查询中...';
  with ADO_Data do
  begin
    First;
    n := 0;
    if RecordCount > 0 then
    begin
      n := FieldByName('Count').AsInteger;
    end;
    gb_fhd.Caption := '发货单  总数:'+IntToStr(n)+'条';
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
      stg_fhd.Cells[c_cz,n] := '详细';
      stg_fhd.CellsLink[c_cz,n] := '详细';
      stg_fhd.cells[c_cs,n] := FieldByName('F_sDYCS').AsString ;
      stg_fhd.cells[c_fhdh,n] := FieldByName('F_sFHDH').AsString ;
      stg_fhd.cells[c_spdw,n] := FieldByName('F_sSPDW').AsString;
      stg_fhd.cells[c_lxr,n] := FieldByName('F_sLXR').AsString;
      stg_fhd.cells[c_fpdw,n] := FieldByName('F_sFPDW').AsString;
      dDate := FieldByName('F_dFPRQ').AsDateTime;
      if YearOf(dDate)>2000 then
        stg_fhd.cells[c_fprq,n] := FormatDateTime('yyyy-MM-dd',dDate)
      else
        stg_fhd.cells[c_fprq,n] := '';
//      stg_gd.FormatString := '工单号|户名|品名|打印类型|总张数|交版日期|印完日期|装完日期|操作|ID'
      stg_fhd.Cells[c_F_iID,n] := FieldByName('F_iID').AsString;
      inc(n);
      Next;
    end;
  end;
  stg_fhd.ColWidths[c_F_iID] := 0;
  stg_fhd.Row :=1;
  btn_cx.Caption := '查询';
end;

procedure TFra_FHGL_DYCX.stg_fhdLinkClick(Sender: TObject; ACol,
  ARow: Integer);
var
  ADO_Rec: TADOQuery;
  n,iMs,iZms, iInvoiceID: Integer;
  sSqlData,sFHDH,sSPDW,sLXR,sLXDH,sSHDZ,sFHFS,sFZDS: string;
  dFPRQ,dSPRQ: TDateTime;
  sPPMC,sCPLX,sCPBH,sKCID: string;
begin
  if ACol = c_cz then
  begin
    iInvoiceID := StrToNum(stg_fhd.Cells[c_F_iID,ARow]);
    if iInvoiceID = 0 then Exit;
    try
      sSqlData := 'select * from DO_Invoice a where a.F_iID =%d';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iInvoiceID]);
      if ADO_Rec.RecordCount > 0 then
      begin
        Frm_FHGL_DY := TFrm_FHGL_DY.Create(Self);
        Frm_FHGL_DY.dtp_fprq.DateTime := Now;
        Frm_FHGL_DY.dtp_sprq.DateTime := Now;
        Frm_FHGL_DY.stg_fhd.Clear;
        sFHDH := ADO_Rec.FieldByName('F_sFHDH').AsString;
        sSPDW := ADO_Rec.FieldByName('F_sSPDW').AsString;
        sLXR  := ADO_Rec.FieldByName('F_sLXR').AsString;
        sLXDH := ADO_Rec.FieldByName('F_sLXDH').AsString;
        sSHDZ := ADO_Rec.FieldByName('F_sSHDZ').AsString;
        dFPRQ := ADO_Rec.FieldByName('F_dFPRQ').AsDateTime;
        dSPRQ := ADO_Rec.FieldByName('F_dSPRQ').AsDateTime;
        sFHFS := ADO_Rec.FieldByName('F_sFHFS').AsString;
        sFZDS := ADO_Rec.FieldByName('F_sFZDS').AsString;
        Frm_FHGL_DY.dtp_fprq.DateTime := dFPRQ;
        if YearOf(dSPRQ)>2000 then
        begin
          Frm_FHGL_DY.cb_sprq.Checked := True;
          Frm_FHGL_DY.dtp_sprq.DateTime := dSPRQ;
        end;
        Frm_FHGL_DY.edt_lxr.Text := sLXR;
        Frm_FHGL_DY.edt_lxdh.Text := sLXDH;
        Frm_FHGL_DY.edt_spdw.Text := sSPDW;
        Frm_FHGL_DY.edt_shdz.Text := sSHDZ;
        Frm_FHGL_DY.cbb_fhfs.ItemIndex := -1;
        Frm_FHGL_DY.cbb_fhfs.Text := sFHFS;
        Frm_FHGL_DY.edt_fzds.Text := sFZDS;
        ADO_Rec.Free;
        sSqlData := 'select * from DO_InvoiceDetails a where a.F_iInvoiceID =%d order by F_iID';
        ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iInvoiceID]);
        Frm_FHGL_DY.stg_fhd.Clear;
        Frm_FHGL_DY.stg_fhd.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
        iZms := 0;
        n := 1;
        while not ADO_Rec.Eof do
        begin
          sPPMC := ADO_Rec.FindField('F_sPPMC').AsString;
          sCPBH := ADO_Rec.FieldByName('F_sCPBH').AsString;
          sKCID := ADO_Rec.FindField('F_iInventoryID').AsString;;
          Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_PPMC,n] := sPPMC;
          Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_MZ,n] := ADO_Rec.FindField('F_sMZ').AsString;
          Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_BS,n] :=  ADO_Rec.FindField('F_iBS').AsString;
          iMs := ADO_Rec.FindField('F_iMS').AsInteger;
          iZms := iZms + iMs;
          Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_MS,n] := IntToStr(iMs);
          Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_BZ,n] :=  ADO_Rec.FindField('F_sBZ').AsString;
          Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_TB,n] :=  ADO_Rec.FindField('F_sTB').AsString;
          Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_MBMS,n] := ADO_Rec.FindField('F_iMBMS').AsString;
          Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_CPBH,n] := sCPBH;
          Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_KCID,n] := sKCID;
          sCPLX := Copy(sPPMC,1,Pos('-',sPPMC)-3);
          SetLength(Frm_FHGL_DY.FHDDXX,n);
          Frm_FHGL_DY.FHDDXX[n-1].m_iKCID := StrToNum(sKCID);
          Frm_FHGL_DY.FHDDXX[n-1].m_sCPBH := sCPBH;
          Frm_FHGL_DY.FHDDXX[n-1].m_sCPLX := sCPLX;
          inc(n);
          ADO_Rec.Next;
        end;
        with Frm_FHGL_DY do
        begin
          stg_fhd.RowCount := n+1;
          stg_fhd.Cells[c_FHGL_PPMC,n]:='共计';
          stg_fhd.Cells[c_FHGL_MS,n]:=IntToStr(iZms);
          lab_FHDH.Caption := '发票单照 第 '+sFHDH+' 号';
          edt_fhdw.Text := '福建省邮电印刷厂';
          if not (LoginData.m_iUserType in [1,10]) then
          begin
            edt_lxr.ReadOnly := True;
            edt_lxdh.ReadOnly := True;
            edt_lxdh.ReadOnly := True;
            edt_fhdw.ReadOnly := True;
            edt_Temp.ReadOnly := True;
            dtp_fprq.Enabled := False;
            cb_sprq.Enabled := False;
          end;

          vFHDH := sFHDH;
          vSHDZ := sSHDZ;
          vInvoiceID := iInvoiceID;
          stg_fhd.ColWidths[c_FHGL_CPBH] := 0;
          stg_fhd.ColWidths[c_FHGL_KCID] := 0;
          ShowModal;
          Free;
        end;
        btn_cx.Click;
      end;
    finally
      ADO_Rec.Free;
    end;
  end;
end;

procedure TFra_FHGL_DYCX.cb_fprqClick(Sender: TObject);
begin
  dtp_fpq.Enabled := cb_fprq.Checked;
  dtp_fpz.Enabled := cb_fprq.Checked;
end;

procedure TFra_FHGL_DYCX.lab_ts50Click(Sender: TObject);
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
  LabFontClear(lab_tsQB);
  TLabel(Sender).Font.Color :=  clBlack;
  TLabel(Sender).Font.Size := 10;
  TLabel(Sender).Font.Style := [fsBold];
  TLabel(Sender).Cursor := crDefault;
  ReadDataFHD(ADO_Rec);
  ADO_Rec.Free;
  vYs := 1;
  edt_ys.Text := '1';
  lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);
end;

procedure TFra_FHGL_DYCX.lab_firstClick(Sender: TObject);
begin
  if vYs = 1 then Exit;
  edt_ys.Text := '1';
  btn_go.Click;
end;

procedure TFra_FHGL_DYCX.lab_upClick(Sender: TObject);
begin
  if vYs > 1 then
  begin
    edt_ys.Text := IntToStr(vYs -1);
    btn_go.Click;
  end;
end;

procedure TFra_FHGL_DYCX.lab_downClick(Sender: TObject);
begin
  if vYs < lab_zys.Tag then
  begin
    edt_ys.Text := IntToStr(vYs +1);
    btn_go.Click;
  end;
end;

procedure TFra_FHGL_DYCX.lab_lastClick(Sender: TObject);
begin
  if vYs = lab_zys.Tag then Exit;
  edt_ys.Text := IntToStr(lab_zys.Tag);
  btn_go.Click;

end;

procedure TFra_FHGL_DYCX.btn_goClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  iYs: Integer;
begin
  Screen.Cursor := crHourGlass;
  iYs := StrToNum(edt_ys.Text);
  ADO_Rec := DM_DataBase.OpenQuery(vSqlData,[iYs,vMYTS]);
  ReadDataFHD(ADO_Rec);
  lab_zys.Caption := '页次：'+IntToStr(iYs)+'/'+ IntToStr(lab_zys.Tag);
  vYs := iYs;
  Screen.Cursor := crDefault;
end;

procedure TFra_FHGL_DYCX.FraShow;
begin
  stg_fhd.p_SetColSortType(1,c_SetColSortType_Num );
  stg_fhd.p_SetColSortType(2,c_SetColSortType_Str );
  stg_fhd.p_SetColSortType(3,c_SetColSortType_Str );
  stg_fhd.p_SetColSortType(4,c_SetColSortType_Str );
  stg_fhd.p_SetColSortType(5,c_SetColSortType_Str );
  stg_fhd.p_SetColSortType(6,c_SetColSortType_Str );
  stg_fhd.ColBuddy[c_fhdh] := 'edt_Temp';
  stg_fhmx.ColBuddy[c_CPBH] := 'edt_Temp2';
  Ti_StgEdit(edt_Temp).OnMouseWheelDown := edtOnMouseWheelDown;
  Ti_StgEdit(edt_Temp).OnMouseWheelUp := edtOnMouseWheelUp;
end;

procedure TFra_FHGL_DYCX.stg_fhdSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  iInvoiceID: integer;
  ADO_Rec: TADOQuery;
  sSqlData: string;
begin
  if not  bBlank then
  begin
    if not (ACol  in [0,1]) then
      stg_fhd.ColBuddy[ACol] := 'edt_Temp';
  end else
      stg_fhd.ColBuddy[ACol] := '';

  stg_fhmx.Clear;
  iInvoiceID := StrToNum(stg_fhd.Cells[c_F_iID,ARow]);
  if iInvoiceID > 0 then
  begin
    try
      //sSqlData := 'Select * from DO_WorkOrderPrtProc where F_iWorkID=%d ';
      sSqlData := 'Select * from DO_InvoiceDetails where F_iInvoiceID=%d ';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iInvoiceID],False);
      if (Assigned(ADO_Rec)) and (ADO_Rec.RecordCount > 0) then
        ReadDataFHMX(ADO_Rec);
    finally
      ADO_Rec.Free;
    end;
  end;

end;

procedure TFra_FHGL_DYCX.edtOnMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
begin
  bBlank := True;
  stg_fhd.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
//  bBlank := False;
end;

procedure TFra_FHGL_DYCX.edtOnMouseWheelup(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
begin
  bBlank := True;
  stg_fhd.Perform(WM_VSCROLL, SB_LINEUP, 0);
//  bBlank := False;

end;

procedure TFra_FHGL_DYCX.stg_fhdMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if y < stg_fhd.RowHeights[0] then
  begin
    bBlank := True;
    ColBuddyExit;
  end else
    bBlank := False;
end;

procedure TFra_FHGL_DYCX.ColBuddyExit;
var
  i: integer;
begin
  for i := 0 to  stg_fhd.ColCount -1 do
  begin
    stg_fhd.ColBuddy[i] := ''
  end;
end;

procedure TFra_FHGL_DYCX.ReadDataFHMX(ADOQ_Data: TADOQuery);
var
  n: Integer;
  sDw: string;
begin
  stg_fhmx.Clear;
  stg_fhmx.RowCount := iif(ADOQ_Data.RecordCount > 0, ADOQ_Data.RecordCount +1, 2);
  n := 1;
  with ADOQ_Data do
  begin
    First;
    while not Eof do
    begin
      stg_fhmx.cells[c_KHMC,n]     := FieldByName('F_sPPMC').AsString ;
      stg_fhmx.cells[c_CPBH,n]     := FieldByName('F_sCPBH').AsString;
      stg_fhmx.cells[c_MZ,n]       := FindField('F_sMZ').AsString;
      stg_fhmx.cells[c_TB,n]       := FieldByName('F_sTB').AsString ;
      stg_fhmx.cells[c_XS,n]       := FieldByName('F_iBS').AsString ;
      stg_fhmx.cells[c_MXMS,n]     := FieldByName('F_iMBMS').AsString ;
      stg_fhmx.cells[c_MS,n]       := FieldByName('F_iMS').AsString;
      stg_fhmx.cells[c_BZ,n]       := FieldByName('F_sBZ').AsString;
      inc(n);
      Next;
    end;
    stg_fhmx.ColWidths[c_KHMC] := 300;
    stg_fhmx.ColWidths[c_CPBH] := 140;
  end;
end;

end.










