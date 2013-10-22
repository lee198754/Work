unit uFra_FHGL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzPanel, GridsEh, DBGridEh, RzRadChk,
  StdCtrls, iComboBox, ComCtrls, RzDTP, RzButton, ButtonEdit,
  ExtCtrls, ADODB,EhLibADO,EhLibMTE, DBGridEhGrouping, RzCmboBx;

type
  TFra_FHGL = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    Label3: TLabel;
    edt_gdh: Ti_TxtFilter;
    btn_cx: TRzBitBtn;
    dtp_jcq: TRzDateTimePicker;
    dtp_jcz: TRzDateTimePicker;
    cb_jcrq: TRzCheckBox;
    gb_dd: TRzGroupBox;
    dbg_jhxd_dzx: TDBGridEh;
    RzPanel2: TRzPanel;
    btn_ok: TRzBitBtn;
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
    edt_cpbh: Ti_TxtFilter;
    btn_jcqr: TRzBitBtn;
    cbb_jcqk: Ti_ComboBox;
    lab_tsQB: TLabel;
    btn_cxjcqr: TRzBitBtn;
    procedure btn_cxClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure dbg_jhxd_dzxTitleClick(Column: TColumnEh);
    procedure cb_jcrqClick(Sender: TObject);
    procedure lab_ts50Click(Sender: TObject);
    procedure lab_firstClick(Sender: TObject);
    procedure lab_upClick(Sender: TObject);
    procedure lab_downClick(Sender: TObject);
    procedure lab_lastClick(Sender: TObject);
    procedure btn_goClick(Sender: TObject);
    procedure btn_JCQRClick(Sender: TObject);
    procedure btn_cxjcqrClick(Sender: TObject);
  private
    { Private declarations }
    vMYTS: Integer;     //当前每页条数
    vYs: integer;       //当前页数
    vSqlData: string;
    function f_MakeAllow: Boolean;   //操作允许
  public
    { Public declarations }
    procedure FrmShow;
  end;

implementation

uses
  uDM_DataBase,uFrm_FHGL_DY,PubStr, uPub_Type, uPub_Text, uPub_Func;

{$R *.dfm}

procedure TFra_FHGL.btn_cxClick(Sender: TObject);
var
  sSqlData,sJcq,sJcz: string;
  n: Integer;
  iYS,iMYTS,iJCQK: integer;
begin
  btn_cx.Caption := '查询中...';
  if cb_jcrq.Checked then
  begin
    sJcq := FormatDateTime('yyyy.MM.dd 00:00:00',dtp_jcq.DateTime);
    sJcz := FormatDateTime('yyyy.MM.dd 23:59:59',dtp_jcz.DateTime);
  end;
  iYS := 1;
  vYs := iYS;
  edt_ys.Text := IntToStr(iYs);
  case cbb_jcqk.ItemIndex of
    0:   iJCQK := -1;
    1:   iJCQK := 0;
    2:   iJCQK := 1;
  else
    iJCQK := -1;
  end;
  if vMYTS = 0 then
  begin
    vMYTS := 50;
    lab_ts50.Font.Color :=  clBlack;
    lab_ts50.Font.Size := 10;
    lab_ts50.Font.Style := [fsBold];
    lab_ts50.Cursor := crDefault;
  end;
  iMYTS := vMYTS;
  try
    sSqlData := Format('Exec p_fhcx ''%s'',''%s'',''%s'',''%s'',%d,%d,%d',[Trim(edt_cpbh.Text),Trim(edt_gdh.Text),sJcq,sJcz,iYS,iMYTS,iJCQK]);
    DM_DataBase.ADO_FHCX.Close;
    DM_DataBase.ADO_FHCX.SQL.Text :=  sSqlData;
    DM_DataBase.ADO_FHCX.Open;
  //  DM_DataBase.mte_FHCX.Close;
  //  DM_DataBase.mte_FHCX.Open;
  //  n := DM_DataBase.ADO_FHCX.RecordCount;
    vSqlData := Format('Exec p_fhcx ''%s'',''%s'',''%s'',''%s'',%s,%s',[Trim(edt_cpbh.Text),Trim(edt_gdh.Text),sJcq,sJcz,'%d','%d']);
    n := 0;
    if DM_DataBase.ADO_FHCX.RecordCount > 0 then
    begin
      n := DM_DataBase.ADO_FHCX.FieldByName('Count').AsInteger;
  //  n := DM_DataBase.ADO_DataRec.RecordCount;
    end;
    gb_dd.Caption := '订单  总数:'+IntToStr(n)+'条';
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);
  //  gb_dd.Caption := '订单  总数:'+IntToStr(n)+'条';
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar('错误:'+E.message),'提示',MB_ICONINFORMATION)
    end;
  end;        
  btn_cx.Caption := '查询';

end;

procedure TFra_FHGL.btn_okClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  s,sSqlData,sFHDH,sPPMC,sSPDW,sLXR,sLXDH,sSHDZ,sFHFS: string;
  sTB,sMZ,sKCID: string;
  i,j,n,iMs,iMbms,iBs,iZms: Integer;
  str,sCPBH,sTGZT,sCPLX: string;
  pBookMark:Pointer;
  aYJCPBH, aNJCPBH: array of string;
  sJCQR: string;

begin
  n := 0;
  pBookMark := DM_DataBase.ADO_FHCX.GetBookmark;
  if DM_DataBase.ADO_FHCX.RecordCount > 0 then
  begin
    DM_DataBase.ADO_FHCX.FindFirst;
    str := '';
    sCPBH := '';
    SetLength(aYJCPBH,0);
    SetLength(aNJCPBH,0);
    for i := 0 to DM_DataBase.ADO_FHCX.RecordCount -1 do
    begin
      if DM_DataBase.ADO_FHCX.FindField('FH').AsBoolean then
      begin
        if n = 0 then
        begin
          sSPDW := DM_DataBase.ADO_FHCX.FindField('F_sJg').AsString;
          sLXR :=  DM_DataBase.ADO_FHCX.FindField('F_sShr').AsString;
          sLXDH :=  DM_DataBase.ADO_FHCX.FindField('F_sShrdh').AsString;
          sSHDZ := DM_DataBase.ADO_FHCX.FindField('F_sShrdz').AsString;
          sFHFS := DM_DataBase.ADO_FHCX.FindField('F_sFHFS').AsString;
        end;
        sCPBH := DM_DataBase.ADO_FHCX.FindField('F_sCPBH').AsString;
        if Trim(DM_DataBase.ADO_FHCX.FindField('NJ').AsString) = '有'  then
        begin
          SetLength(aYJCPBH,Length(aYJCPBH)+1);
          aYJCPBH[Length(aYJCPBH)-1] := sCPBH;
        end;
        if Trim(DM_DataBase.ADO_FHCX.FindField('F_sCPLX').AsString) = '内件'  then
        begin
          SetLength(aNJCPBH,Length(aNJCPBH)+1);
          aNJCPBH[Length(aNJCPBH)-1] := sCPBH;
        end;
        if Trim(DM_DataBase.ADO_FHCX.FindField('TGZT').AsString) <> '' then
          sTGZT := sTGZT + sCPBH + '  ' + DM_DataBase.ADO_FHCX.FindField('TGZT').AsString+#13#10;
        if Trim(DM_DataBase.ADO_FHCX.FindField('JCQR').AsString) <> '' then
          sJCQR := sJCQR + sCPBH + '  ' + DM_DataBase.ADO_FHCX.FindField('JCQR').AsString+'进仓'+#13#10;
        if (sSPDW <> DM_DataBase.ADO_FHCX.FindField('F_sJg').AsString) then
          str := str +',收票单位';
        if (sLXR <>  DM_DataBase.ADO_FHCX.FindField('F_sShr').AsString) then
          str := str +',联系人名称';
        if (sLXDH <>  DM_DataBase.ADO_FHCX.FindField('F_sShrdh').AsString) then
          str := str +',联系人电话';
        if (sSHDZ <> DM_DataBase.ADO_FHCX.FindField('F_sShrdz').AsString) then
          str := str +',收货地址';
        if (sFHFS <> DM_DataBase.ADO_FHCX.FindField('F_sFHFS').AsString) then
          str := str +',发货方式';
        if str <> '' then
          Break;
        inc(n);
      end;
      if i < DM_DataBase.ADO_FHCX.RecordCount -1 then
        DM_DataBase.ADO_FHCX.FindNext;

    end;
  end;
  DM_DataBase.ADO_FHCX.GotoBookmark(pBookMark);
  if n=0 then
  begin
    Application.MessageBox('请选择至少一项','提示',MB_ICONINFORMATION);
    Exit;
  end;
  sCPBH := '';
  if Length(aYJCPBH) > 0 then
  begin
    for i := 0 to Length(aYJCPBH) -1 do
    begin
      for j := 0 to Length(aNJCPBH) -1 do
      begin
        if aYJCPBH[i] = aNJCPBH[j] then
          Break;
      end;
      if j = Length(aNJCPBH) then
      begin
        sCPBH := sCPBH + ',' + aYJCPBH[i];
      end;
    end;
  end;
  if sCPBH <> '' then
  begin
    sCPBH := Copy(sCPBH,2,Length(sCPBH));
    if Application.MessageBox(PChar(sCPBH+' 订单有内件未一起选择,是否继续?'),'提示',MB_YESNO+ MB_ICONINFORMATION)=IDNO then
      Exit;
  end;
  if str <> '' then
  begin
    str := Copy(str,2,Length(str));
    if Application.MessageBox(PChar('所选订单存在 '+str+' 不一样的订单,是否继续?'),'提示',MB_YESNO+ MB_ICONINFORMATION)=IDNO then
      Exit;
  end;
  //图稿状态未合格未签样 
  if sTGZT <> '' then
  begin
   // DM_DataBase.ADO_FHCX.GotoBookmark(pBookMark);
    p_MessageBoxDlg('失败：'+sTGZT);
    Exit;
  end;
  if sJCQR <> '' then
  begin
    //DM_DataBase.ADO_FHCX.GotoBookmark(pBookMark);
    p_MessageBoxDlg('失败：'+sJCQR);
    Exit;
  end;
  Frm_FHGL_DY := TFrm_FHGL_DY.Create(Self);
  Frm_FHGL_DY.stg_fhd.Clear;
  DM_DataBase.ADO_FHCX.FindFirst;
  if str = '' then
  begin
    {sSPDW := DM_DataBase.ADO_FHCX.FindField('F_sJg').AsString;
    sLXR :=  DM_DataBase.ADO_FHCX.FindField('F_sShr').AsString;
    sLXDH :=  DM_DataBase.ADO_FHCX.FindField('F_sShrdh').AsString;
    sSHDZ := DM_DataBase.ADO_FHCX.FindField('F_sShrdz').AsString;   }
    Frm_FHGL_DY.edt_lxr.Text := sLXR;
    Frm_FHGL_DY.edt_lxdh.Text := sLXDH;
    Frm_FHGL_DY.edt_spdw.Text := sSPDW;
    Frm_FHGL_DY.edt_shdz.Text := sSHDZ;
    if Trim(sFHFS) <> '' then
      Frm_FHGL_DY.cbb_fhfs.Text := sFHFS;
  end;
  iZms := 0;
  n := 1;
  SetLength(Frm_FHGL_DY.FHDDXX,0);
  for i := 0 to DM_DataBase.ADO_FHCX.RecordCount -1 do
  begin
    if DM_DataBase.ADO_FHCX.FindField('FH').AsBoolean then
    begin
      Frm_FHGL_DY.stg_fhd.RowCount := n+1;
      sCpbh := DM_DataBase.ADO_FHCX.FindField('F_sCpbh').AsString;
      sCPLX := DM_DataBase.ADO_FHCX.FindField('F_sCPLX').AsString;
      sPPMC := sCPLX+sCpbh+DM_DataBase.ADO_FHCX.FindField('KHMC').AsString;
      iMs := DM_DataBase.ADO_FHCX.FindField('BCFHL').AsInteger;
      iMbms := DM_DataBase.ADO_FHCX.FindField('MBMS').AsInteger;
      if iMbms = 0 then iMbms := 1000;
      iBs := iMs div iMbms;
      if iMs mod iMbms <> 0 then
        iBs := iBs + 1;
      sMZ := DM_DataBase.ADO_FHCX.FindField('F_sMz').AsString;
      sTB :=  DM_DataBase.ADO_FHCX.FindField('F_sYZTMC').AsString;
      sKCID:=  DM_DataBase.ADO_FHCX.FindField('KCID').AsString;
      Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_PPMC,n]:= sPPMC;
      Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_MZ,n]:= sMZ;
      Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_TB,n]:= sTB;
      Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_MS,n]:= IntToStr(iMs);
      Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_MBMS,n]:= IntToStr(iMbms);
      Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_BS,n]:= IntToStr(iBs);
      iZms := iZms + iMs;
      Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_CPBH,n]:= sCPBH;
      Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_KCID,n]:= sKCID;
      SetLength(Frm_FHGL_DY.FHDDXX,n);
      Frm_FHGL_DY.FHDDXX[n-1].m_iKCID := StrToNum(sKCID);
      Frm_FHGL_DY.FHDDXX[n-1].m_sCPBH := sCPBH;
      Frm_FHGL_DY.FHDDXX[n-1].m_sCPLX := sCPLX;
      inc(n)
    end;
    if i < DM_DataBase.ADO_FHCX.RecordCount -1 then
      DM_DataBase.ADO_FHCX.FindNext;
  end;
  Frm_FHGL_DY.stg_fhd.RowCount := n+1;
  Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_PPMC,n]:='共计';
  Frm_FHGL_DY.stg_fhd.Cells[c_FHGL_MS,n]:=IntToStr(iZms);
  Frm_FHGL_DY.dtp_fprq.DateTime := Now;
  Frm_FHGL_DY.dtp_sprq.DateTime := Now;
  DM_DataBase.GetMaxID('DO_Invoice','F_sFHDH',sFHDH);
  sFHDH := 'FH-12BK-'+StrRight(sFHDH,6);
  Frm_FHGL_DY.lab_FHDH.Caption := '发票单照 第 '+sFHDH+' 号';
  Frm_FHGL_DY.edt_fhdw.Text := '福建省邮电印刷厂';
  Frm_FHGL_DY.vFHDH := sFHDH;
  Frm_FHGL_DY.vSHDZ := sSHDZ;
  Frm_FHGL_DY.stg_fhd.ColWidths[c_FHGL_CPBH] := 0;
  Frm_FHGL_DY.stg_fhd.ColWidths[c_FHGL_KCID] := 0;
  DM_DataBase.ADO_FHCX.GotoBookmark(pBookMark);
  Frm_FHGL_DY.ShowModal;
  Frm_FHGL_DY.Free;
  Self.btn_cx.Click;
end;

procedure TFra_FHGL.dbg_jhxd_dzxTitleClick(Column: TColumnEh);
var
  i: Integer;
  bFH: Boolean;
  pMark: Pointer;
begin
  if Column.Index = 0 then
  begin
    bFH := False;
    with DM_DataBase.ADO_FHCX do
    begin
      pMark := GetBookmark;
      FindFirst;
      for i := 0 to RecordCount -1 do
      begin
        if not FindField('FH').AsBoolean then
        begin
          bFH := True;
          Break;
        end;
        if i< RecordCount -1 then
          FindNext;
      end;
      FindFirst;
      for i := 0 to RecordCount -1 do
      begin
        Edit;
        FindField('FH').AsBoolean := bFH;
        if i< RecordCount -1 then
          FindNext;
      end;
      Post;
      GotoBookmark(pMark);
    end;
  end;
end;

procedure TFra_FHGL.cb_jcrqClick(Sender: TObject);
begin
   dtp_jcq.Enabled := cb_jcrq.Checked;
   dtp_jcz.Enabled := cb_jcrq.Checked;
end;

procedure TFra_FHGL.lab_ts50Click(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  iTs,n: Integer;
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
  vMYTS := iTs;
  DM_DataBase.ADO_FHCX.Close;
  sSqlData := Format(vSqlData,[1,vMYTS]);
  DM_DataBase.ADO_FHCX.SQL.Text :=  sSqlData;
  DM_DataBase.ADO_FHCX.Open;
//  DM_DataBase.mte_FHCX.Close;
//  DM_DataBase.mte_FHCX.Open;
  LabFontClear(lab_ts50);
  LabFontClear(lab_ts100);
  LabFontClear(lab_ts200);
  LabFontClear(lab_ts500);
  LabFontClear(lab_tsQB);
  TLabel(Sender).Font.Color :=  clBlack;
  TLabel(Sender).Font.Size := 10;
  TLabel(Sender).Font.Style := [fsBold];
  TLabel(Sender).Cursor := crDefault;
  vYs := 1;
  edt_ys.Text := '1';
  if DM_DataBase.ADO_FHCX.RecordCount > 0 then
  begin
    n := DM_DataBase.ADO_FHCX.FieldByName('Count').AsInteger;
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);
  end;
end;

procedure TFra_FHGL.lab_firstClick(Sender: TObject);
begin
  if vYs = 1 then Exit;
  edt_ys.Text := '1';
  btn_go.Click;
end;

procedure TFra_FHGL.lab_upClick(Sender: TObject);
begin
  if vYs > 1 then
  begin
    edt_ys.Text := IntToStr(vYs -1);
    btn_go.Click;
  end;
end;

procedure TFra_FHGL.lab_downClick(Sender: TObject);
begin
  if vYs < lab_zys.Tag then
  begin
    edt_ys.Text := IntToStr(vYs +1);
    btn_go.Click;
  end;
end;

procedure TFra_FHGL.lab_lastClick(Sender: TObject);
begin
  if vYs = lab_zys.Tag then Exit;
  edt_ys.Text := IntToStr(lab_zys.Tag);
  btn_go.Click;

end;

procedure TFra_FHGL.btn_goClick(Sender: TObject);
var
  iYs,n: Integer;
  sSqlData: string;
begin
  Screen.Cursor := crHourGlass;
  iYs := StrToNum(edt_ys.Text);
  DM_DataBase.ADO_FHCX.Close;
  sSqlData := Format(vSqlData,[iYs,vMYTS]);
  DM_DataBase.ADO_FHCX.SQL.Text :=  sSqlData;
  DM_DataBase.ADO_FHCX.Open;
//  DM_DataBase.mte_FHCX.Close;
//  DM_DataBase.mte_FHCX.Open;
  if DM_DataBase.ADO_FHCX.RecordCount > 0 then
  begin
    n := DM_DataBase.ADO_FHCX.FieldByName('Count').AsInteger;
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    vYs := iYs;
    lab_zys.Caption := '页次：'+IntToStr(iYs)+'/'+ IntToStr(lab_zys.Tag);
  end;
  Screen.Cursor := crDefault;
end;

function TFra_FHGL.f_MakeAllow: Boolean;
var
  i: Integer;
  ADO_Rec: TADOQuery;
  sSqlData, sCode: string;
  iAllowID, iAllowCode: Integer;
begin
  if LoginData.m_iAllowCode >= 0 then
  begin
    sCode := Format('''%s'',''%s''',[c_Allow_FH_OK,c_Allow_FH_JCQR]);
    iAllowCode := LoginData.m_iAllowCode;
    sSqlData := 'Select F_iID,F_sCode from Set_AllowInfo where F_tiStatus = 1 and F_sCode in (%s) order by F_iID';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sCode],False);
    if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
    begin
      while not ADO_Rec.Eof do
      begin
        iAllowID := ADO_Rec.FieldByName('F_iID').AsInteger;
        sCode := ADO_Rec.FieldByName('F_sCode').AsString;
        if 1 shl iAllowID or iAllowCode = iAllowCode then
        begin
          if sCode = c_Allow_FH_OK then
          begin
            btn_ok.Enabled := True;
            btn_ok.Tag := c_Tag_MakeAllow;
          end;
          if sCode = c_Allow_FH_JCQR then
          begin
            btn_jcqr.Enabled := True;
            btn_cxjcqr.Enabled := True;
            btn_jcqr.Tag := c_Tag_MakeAllow;
          end;
        end else
        begin
          if sCode = c_Allow_FH_OK then
          begin
            btn_ok.Enabled := False;
            btn_ok.Tag := 0;
          end;
          if sCode = c_Allow_FH_JCQR then
          begin
            btn_jcqr.Enabled := False;
            btn_cxjcqr.Enabled := False;
            btn_jcqr.Tag := 0;
          end;
        end;
        ADO_Rec.Next;
      end;
    end;
    if Assigned(ADO_Rec) then
      ADO_Rec.Free;
  end;
end;

procedure TFra_FHGL.FrmShow;
begin
  f_MakeAllow;
end;

procedure TFra_FHGL.btn_JCQRClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  s,sSqlData,sFHDH,sPPMC,sSPDW,sLXR,sLXDH,sSHDZ,sFHFS: string;
  sTB,sMZ,sKCID: string;
  i,j,n,iMs,iMbms,iBs,iZms: Integer;
  str,sCPBH,sTGZT,sXQZT: string;
  pBookMark:Pointer;
  aYJCPBH, aNJCPBH: array of string;
begin
  n := 0;
  pBookMark := DM_DataBase.ADO_FHCX.GetBookmark;
  if DM_DataBase.ADO_FHCX.RecordCount > 0 then
  begin
    DM_DataBase.ADO_FHCX.FindFirst;
    sCPBH := '';
    sKCID := '';
    for i := 0 to DM_DataBase.ADO_FHCX.RecordCount -1 do
    begin
      if DM_DataBase.ADO_FHCX.FindField('FH').AsBoolean then
      begin
        sCPBH := DM_DataBase.ADO_FHCX.FindField('F_sCPBH').AsString;
        if Trim(DM_DataBase.ADO_FHCX.FindField('TGZT').AsString) <> '' then
          sTGZT := sTGZT + sCPBH + '  ' + DM_DataBase.ADO_FHCX.FindField('TGZT').AsString+#13#10;
        if Trim(DM_DataBase.ADO_FHCX.FindField('XQZT').AsString) <> '' then
          sXQZT := sXQZT + sCPBH + '  ' + DM_DataBase.ADO_FHCX.FindField('XQZT').AsString+#13#10;
        if Trim(DM_DataBase.ADO_FHCX.FindField('JCQR').AsString) <> '' then
          sKCID := sKCID + ',' +DM_DataBase.ADO_FHCX.FindField('KCID').AsString;
        inc(n);
      end;
      if i < DM_DataBase.ADO_FHCX.RecordCount -1 then
        DM_DataBase.ADO_FHCX.FindNext;

    end;
  end;
  DM_DataBase.ADO_FHCX.GotoBookmark(pBookMark);
  if n=0 then
  begin
    Application.MessageBox('请选择至少一项','提示',MB_ICONINFORMATION);
    Exit;
  end;
  //图稿状态未合格未签样
  if sTGZT <> '' then
  begin
    p_MessageBoxDlg('失败：'+sTGZT);
    Exit;
  end;
  //箱签状态未箱签
  if sXQZT <> '' then
  begin
    p_MessageBoxDlg('失败：'+sXQZT);
    Exit;
  end;

  if sKCID <> '' then
  begin
    sKCID := Copy(sKCID,2,Length(sKCID));
    sSqlData := 'update BI_InventoryManagement set F_tiJCQR = 1,F_dQRRQ=getdate(),F_sRQCZR=''%s'' from BI_InventoryManagement where F_iID in (%s) ';
    DM_DataBase.ExecQuery(sSqlData,[LoginData.m_sUserName,sKCID]);
  end else
  begin
    p_MessageBoxDlg('已进仓确认,不需要重复确认!');
    Exit;
  end;
  p_MessageBoxDlg('进仓确认操作成功!');
  Self.btn_cx.Click;
end;

procedure TFra_FHGL.btn_cxjcqrClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  s,sSqlData,sFHDH,sPPMC,sSPDW,sLXR,sLXDH,sSHDZ,sFHFS: string;
  sTB,sMZ,sKCID: string;
  i,j,n,iMs,iMbms,iBs,iZms: Integer;
  str,sCPBH,sTGZT: string;
  pBookMark:Pointer;
  aYJCPBH, aNJCPBH: array of string;
begin
  n := 0;
  pBookMark := DM_DataBase.ADO_FHCX.GetBookmark;
  if DM_DataBase.ADO_FHCX.RecordCount > 0 then
  begin
    DM_DataBase.ADO_FHCX.FindFirst;
    sCPBH := '';
    sKCID := '';
    for i := 0 to DM_DataBase.ADO_FHCX.RecordCount -1 do
    begin
      if DM_DataBase.ADO_FHCX.FindField('FH').AsBoolean then
      begin
        sCPBH := DM_DataBase.ADO_FHCX.FindField('F_sCPBH').AsString;
        if Trim(DM_DataBase.ADO_FHCX.FindField('TGZT').AsString) <> '' then
          sTGZT := sTGZT + sCPBH + '  ' + DM_DataBase.ADO_FHCX.FindField('TGZT').AsString+#13#10;
        if Trim(DM_DataBase.ADO_FHCX.FindField('JCQR').AsString) = '' then
          sKCID := sKCID + ',' +DM_DataBase.ADO_FHCX.FindField('KCID').AsString;
        inc(n);
      end;
      if i < DM_DataBase.ADO_FHCX.RecordCount -1 then
        DM_DataBase.ADO_FHCX.FindNext;

    end;
  end;
  DM_DataBase.ADO_FHCX.GotoBookmark(pBookMark);
  if n=0 then
  begin
    Application.MessageBox('请选择至少一项','提示',MB_ICONINFORMATION);
    Exit;
  end;
  //图稿状态未合格未签样
  if sTGZT <> '' then
  begin
    p_MessageBoxDlg('失败：'+sTGZT);
    Exit;
  end;

  if sKCID <> '' then
  begin
    sKCID := Copy(sKCID,2,Length(sKCID));
    sSqlData := 'update BI_InventoryManagement set F_tiJCQR = 0,F_dQRRQ=getdate(),F_sRQCZR=''%s'' from BI_InventoryManagement where F_iID in (%s) ';
    DM_DataBase.ExecQuery(sSqlData,[LoginData.m_sUserName,sKCID]);
  end else
  begin
    p_MessageBoxDlg('未进仓确认,不需要撤销操作!');
    Exit;
  end;
  p_MessageBoxDlg('撤销进仓确认操作成功!');
  Self.btn_cx.Click;
end;

end.








