unit uFrm_FHGL_DY;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, StdCtrls, ButtonEdit, Grids, iGrid, RzRadChk,
  ComCtrls, RzDTP, ADODB, RM_Common, RM_Class, RM_System, RM_Dataset,
  RM_GridReport;

type
  TFHDDXX = record
    m_iKCID : Integer;   //库存ID
    m_sCPBH : string;    //产品名称
    m_sCPLX : string;    //产品类型
    m_sSL   : string;    //数量
    m_sCPDW : string;    //产品单位
    m_sZL   : string;    //重量       (1000~1999枚:普卡 9，信卡11，封10，内件15)若2000枚则*2
    m_sFY   : string;    //费用       (1000~1999枚:普卡 22.5，信卡25，封12.5，内件12.5，内件15)若2000枚则*2
    m_sSJRY : string;    //收寄人员
    m_sNJPM : string;    //内件品名
    m_sNJSL : string;    //内件数量
  end;

  TFrm_FHGL_DY = class(TForm)
    stg_fhd: Ti_StgEdit;
    Label1: TLabel;
    edt_fhdw: Ti_TxtFilter;
    edt_spdw: Ti_TxtFilter;
    edt_lxr: Ti_TxtFilter;
    edt_fzds: Ti_TxtFilter;
    edt_lxdh: Ti_TxtFilter;
    lab_FHDH: TLabel;
    edt_Temp: TEdit;
    btn_dy: TRzButton;
    Label3: TLabel;
    dtp_fprq: TRzDateTimePicker;
    Label4: TLabel;
    dtp_sprq: TRzDateTimePicker;
    cb_sprq: TRzCheckBox;
    RMDBDataSet1: TRMDBDataSet;
    rmr_Print: TRMReport;
    btn_Close: TRzButton;
    btn_Mod: TRzButton;
    cbb_fhfs: TComboBox;
    Label2: TLabel;
    btn_cx: TButton;
    btn_ok: TRzButton;
    btn_ddcx: TButton;
    btn_ysmddy: TButton;
    rmr_ysmddy: TRMReport;      //暂没用(以前版本)
    edt_shdz: Ti_TxtFilter;
    btn_sjysmd: TButton;
    rmr_qmjz_old: TRMReport;
    rmr_hmjz_old: TRMReport;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    rmr_qmjz: TRMReport;
    rmr_hmjz: TRMReport;
    procedure stg_fhdSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure edt_TempExit(Sender: TObject);
    procedure cb_sprqClick(Sender: TObject);
    procedure btn_dyClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_ModClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_cxClick(Sender: TObject);
    procedure btn_ddcxClick(Sender: TObject);
    procedure btn_ysmddyClick(Sender: TObject);
    procedure btn_sjysmdClick(Sender: TObject);
    procedure rmr_qmjz_oldBeforePrintBand(aBand: TRMBand;
      var aPrintBand: Boolean);
    procedure rmr_hmjz_oldBeforePrintBand(aBand: TRMBand;
      var aPrintBand: Boolean);
    procedure rmr_ysmddyBeforePrintBand(aBand: TRMBand;
      var aPrintBand: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    vsTempPath: string;
    function f_MakeAllow: Boolean;   //操作允许
  public
    { Public declarations }
    vFHDH: string;
    vSHDZ: string;
    vInvoiceID: integer;
    FHDDXX: array of TFHDDXX;
    vNum: integer;
  end;

var
  Frm_FHGL_DY: TFrm_FHGL_DY;

implementation

uses
  PubStr, uDM_DataBase, uPub_Type, uPub_Text, uPub_Func, uFrm_ListView, uFrm_FHGL_JZFS;
{$R *.dfm}

var
  aYZZL: TYZZL;
  aYZFY: TYZFY;
  vsSJRY: string;

procedure TFrm_FHGL_DY.stg_fhdSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if ACol In [c_FHGL_MS,c_FHGL_BZ,c_FHGL_MBMS] then
  begin
    Ti_StgEdit(Sender).ColBuddy[ACol] := 'edt_Temp';
    if Trim(Ti_StgEdit(Sender).Cells[c_FHGL_PPMC,ARow]) = '共计' then
      Ti_StgEdit(Sender).ColBuddy[ACol] := '';
  end;
end;

procedure TFrm_FHGL_DY.edt_TempExit(Sender: TObject);
var
  i,iBs,iZms: integer;
begin
  if edt_Temp.Enabled = False then Exit;
  if (stg_fhd.Col In [c_FHGL_MS,c_FHGL_MBMS]) and (Trim(stg_fhd.Cells[c_FHGL_PPMC,stg_fhd.Row])<>'共计') then
  begin
    if (edt_Temp.Text <>'') and (stg_fhd.Cells[c_FHGL_MS,stg_fhd.Row] <> '') and (stg_fhd.Cells[c_FHGL_MBMS,stg_fhd.Row] <> '') then
    begin
      iBs := -1;
      iZms := 0;
      case stg_fhd.Col of
        c_FHGL_MBMS:
          begin
            iBs := StrToNum(stg_fhd.Cells[c_FHGL_MS,stg_fhd.Row]) div StrToNum(edt_Temp.Text);
            if StrToNum(stg_fhd.Cells[c_FHGL_MS,stg_fhd.Row]) mod StrToNum(edt_Temp.Text) <>0 then
              iBs := iBs +1;
          end;
        c_FHGL_MS:
          begin
            iBs := StrToNum(edt_Temp.Text) div  StrToNum(stg_fhd.Cells[c_FHGL_MBMS,stg_fhd.Row]);
            if StrToNum(edt_Temp.Text) mod  StrToNum(stg_fhd.Cells[c_FHGL_MBMS,stg_fhd.Row])<>0 then
              iBs := iBs +1;
            for i := 1 to stg_fhd.RowCount -1 do
            begin
              if Trim(stg_fhd.Cells[c_FHGL_PPMC,i])='共计' then
              begin
                stg_fhd.Cells[c_FHGL_MS,i] := IntToStr(iZms);
                Break;
              end;
              if i =  stg_fhd.Row then
                iZms := iZms +StrToNum(edt_Temp.Text)
              else
                iZms := iZms +StrToNum(stg_fhd.Cells[c_FHGL_MS,i]);
            end;
          end;
      end;
      if iBs <> -1 then
        stg_fhd.Cells[c_FHGL_BS,stg_fhd.Row] := IntToStr(iBs);

    end;
  end;

end;

procedure TFrm_FHGL_DY.cb_sprqClick(Sender: TObject);
begin
  dtp_sprq.Enabled := cb_sprq.Checked;
end;

procedure TFrm_FHGL_DY.btn_dyClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData,sCZR,str,sKCID, sCPBH: string;
  i,iInvoiceID,iKCID,n: integer;
  iDYCS, iFHSL, iSBSL: Integer;
begin
  if cbb_fhfs.Text = '--请选择--' then
  begin
    p_MessageBoxDlg('请选择发货方式!');
    Exit;
  end;

  try
    if vInvoiceID = 0 then
    begin
      sKCID := '';
      for i := 1 to stg_fhd.RowCount -1 do
      begin
        iKCID := StrToNum(stg_fhd.Cells[c_FHGL_KCID,i]);
        if iKCID > 0 then
          sKCID := sKCID + ','+ IntToStr(iKCID);
      end;
      sKCID := Copy(sKCID,2,Length(sKCID));
      sSqlData := 'select * from BI_InventoryManagement a,DO_OrderApart b  where a.F_iApartID=b.F_iID and a.F_iID in (%s) and b.F_tiCXBZ = 0';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sKCID],True);
      if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
      begin
        sCPBH := '';
        while not ADO_Rec.Eof do
        begin
          for i := 1 to stg_fhd.RowCount -1 do
          begin
            iKCID := StrToNum(stg_fhd.Cells[c_FHGL_KCID,i]);
            if ADO_Rec.FieldByName('F_iID').AsInteger = iKCID then
            begin
              iSBSL := Trunc(ADO_Rec.FieldByName('F_nYL').AsFloat* 10000);
              iFHSL := ADO_Rec.FieldByName('F_iFHSL').AsInteger + StrToNum(stg_fhd.Cells[c_FHGL_MS,i]);
              if iSBSL > iFHSL then
              begin
               // sCPBH := sCPBH +','+ stg_fhd.Cells[c_FHGL_CPBH,i];
                sCPBH := stg_fhd.Cells[c_FHGL_CPBH,i];
                str := str + Format('%s 订单,申报数量为 %d ,已发货数据为 %d ,此次发货数量为 %d '+#13#10,
                  [sCPBH,iSBSL,ADO_Rec.FieldByName('F_iFHSL').AsInteger,Integer(StrToNum(stg_fhd.Cells[c_FHGL_MS,i]))])
              end;
            end;
          end;
          ADO_Rec.Next;
        end;
        if sCPBH <> '' then
        begin
          Copy(sCPBH,2,Length(sCPBH));
          if p_MessageBoxDlg(str+' 以上订单只有部分发货,是否继续发货?','提示',MB_ICONINFORMATION+ MB_YESNO) = IDNO then
          begin
            Exit;
          end;
        end;
      end;
      if Assigned(ADO_Rec) then
        ADO_Rec.Free;
      DM_DataBase.Con_YDPrint.BeginTrans;

      if vInvoiceID = 0 then
        sSqlData := 'Select * from DO_Invoice where 1=%d'
      else
        sSqlData := 'Select * from DO_Invoice where F_iID=%d';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[vInvoiceID],true);
      with ADO_Rec do
      begin
        if RecordCount = 0 then
          Insert
        else
          Edit;
        FieldByName('F_sFHDH').AsString := vFHDH;
        FieldByName('F_sFPDW').AsString := edt_fhdw.Text;
        FieldByName('F_dFPRQ').AsDateTime := dtp_fprq.DateTime;
        FieldByName('F_sSPDW').AsString := edt_spdw.Text;
        if cb_sprq.Checked then
          FieldByName('F_dSPRQ').AsDateTime := dtp_sprq.DateTime;
        FieldByName('F_sLXR').AsString := edt_lxr.Text;
        FieldByName('F_sLXDH').AsString := edt_lxdh.Text;
        FieldByName('F_sSHDZ').AsString := edt_shdz.Text;;
        FieldByName('F_sFZDS').AsString := edt_fzds.Text;
        FieldByName('F_sFHFS').AsString := cbb_fhfs.Text;
    //    FieldByName('F_sZGR').AsString := edt_fhdw.Text;
        FieldByName('F_sDYCS').AsInteger := iif(TRzButton(Sender).Name = 'btn_dy',1,0);
        FieldByName('F_sCZR').AsString := LoginData.m_sUserName;
        FieldByName('F_dCZRQ').AsDateTime := Now;
        if RecordCount = 0 then
          FieldByName('F_sFHR').AsString := LoginData.m_sUserName;
    //    FieldByName('F_sFZR').AsString := edt_fhdw.Text;
        Post;
        iInvoiceID := FieldByName('F_iID').AsInteger;
        vInvoiceID := iInvoiceID;
        Free;
      end;
      sSqlData := 'Select * from DO_InvoiceDetails where F_iInvoiceID=%d order by F_iID';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iInvoiceID]);
      with ADO_Rec do
      begin
        sSqlData := '';
        for i := 1 to stg_fhd.RowCount -1 do
        begin
          if Trim(stg_fhd.Cells[c_FHGL_PPMC,i])='共计' then Break;
          Insert;
          FieldByName('F_sPPMC').AsString := stg_fhd.Cells[c_FHGL_PPMC,i];
          FieldByName('F_sMZ').AsString := stg_fhd.Cells[c_FHGL_MZ,i];
          FieldByName('F_sTB').AsString := stg_fhd.Cells[c_FHGL_TB,i];
          FieldByName('F_iBS').AsInteger := StrToNum(stg_fhd.Cells[c_FHGL_BS,i]);
          FieldByName('F_iMS').AsInteger := StrToNum(stg_fhd.Cells[c_FHGL_MS,i]);
          FieldByName('F_sBZ').AsString := stg_fhd.Cells[c_FHGL_BZ,i];
          FieldByName('F_iMBMS').AsInteger := StrToNum(stg_fhd.Cells[c_FHGL_MBMS,i]);
          FieldByName('F_iInvoiceID').AsInteger := iInvoiceID;
          FieldByName('F_sCPBH').AsString := stg_fhd.Cells[c_FHGL_CPBH,i];
          iKCID := StrToNum(stg_fhd.Cells[c_FHGL_KCID,i]);
          if iKCID <> 0 then
            sSqlData := sSqlData + Format(' Update BI_InventoryManagement set F_iFHSL=IsNull(F_iFHSL,0)+%d,F_dFHRQ=GetDate() where F_iID=%d '
              ,[StrToIntDef(stg_fhd.Cells[c_FHGL_MS,i],0),iKCID]);
          FieldByName('F_iInventoryID').AsInteger := iKCID;
        end;
        post;
        Free;
      end;
       if sSqlData =''then
         raise Exception.Create('更新 BI_InventoryManagement表 失败');
      DM_DataBase.ExecQuery(sSqlData,[],True);
      DM_DataBase.Con_YDPrint.CommitTrans;
    end else
    if vInvoiceID > 0 then
    begin
      sSqlData := 'select F_sDYCS,F_sCZR from DO_Invoice where F_iID=%d';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[vInvoiceID]);
      if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
      begin
        iDYCS := ADO_Rec.FieldByName('F_sDYCS').AsInteger;
        sCZR := ADO_Rec.FieldByName('F_sCZR').AsString;
        if iDYCS > 0 then
        begin
          str := '此发货单已打印过 '+IntToStr(iDYCS)+' 次,最后打印的用户为 ' +sCZR+ ' ,请问是否继续打印?';
          if Application.MessageBox(PChar(str),'提示',MB_YESNO + MB_ICONINFORMATION)= IDNO then Exit;
        end;
        ADO_Rec.Edit;
        ADO_Rec.FieldByName('F_sDYCS').AsInteger := iDYCS + 1;
        ADO_Rec.FieldByName('F_sCZR').AsString := LoginData.m_sUserName;
        ADO_Rec.Post;
        ADO_Rec.Free;
      end;
    end;
    with DM_DataBase.ADO_Print do
    begin
      Close;
      sSqlData := 'select * from DO_Invoice a,DO_InvoiceDetails b where a.F_iID=b.F_iInvoiceID and a.F_iID =%d';
      SQL.Text := Format(sSqlData,[vInvoiceID]);
      Open;
    end;
    if TRzButton(Sender).Name = 'btn_dy' then
    begin
      rmr_Print.PrepareReport;
      rmr_Print.ShowReport;
    end;
    Close;
  except
    on E: Exception do
    begin
      DM_DataBase.Con_YDPrint.RollbackTrans;
      Application.MessageBox(PChar('错误:'+E.message),'提示',MB_ICONINFORMATION);
      Exit;
    end;
  end;
end;

procedure TFrm_FHGL_DY.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure TFrm_FHGL_DY.btn_ModClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData,sCZR,str: string;
  i,iInvoiceID,iKCID: integer;
  iDYCS,iMs: Integer;
begin
  try
    try
      if vInvoiceID > 0 then
      begin
        DM_DataBase.Con_YDPrint.BeginTrans;
        sSqlData := 'Select * from DO_Invoice where F_iID=%d';
        ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[vInvoiceID]);
        with ADO_Rec do
        begin
          Edit;
          FieldByName('F_sFHDH').AsString := vFHDH;
          FieldByName('F_sFPDW').AsString := edt_fhdw.Text;
          FieldByName('F_dFPRQ').AsDateTime := dtp_fprq.DateTime;
          FieldByName('F_sSPDW').AsString := edt_spdw.Text;
          if cb_sprq.Checked then
            FieldByName('F_dSPRQ').AsDateTime := dtp_sprq.DateTime;
          FieldByName('F_sLXR').AsString := edt_lxr.Text;
          FieldByName('F_sLXDH').AsString := edt_lxdh.Text;
          FieldByName('F_sSHDZ').AsString := edt_shdz.Text;
          FieldByName('F_sFHFS').AsString := cbb_fhfs.Text;
          FieldByName('F_sFZDS').AsString := edt_fzds.Text;
      //    FieldByName('F_sZGR').AsString := edt_fhdw.Text;
          FieldByName('F_sCZR').AsString := LoginData.m_sUserName;
          FieldByName('F_dCZRQ').AsDateTime := Now;
      //    FieldByName('F_sFZR').AsString := edt_fhdw.Text;
          Post;
          //iInvoiceID := FieldByName('F_iID').AsInteger;
         // vInvoiceID := iInvoiceID;
          Free;
        end;
        sSqlData := 'Select * from DO_InvoiceDetails where F_iInvoiceID=%d order by F_iID';
        ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[vInvoiceID]);
        with ADO_Rec do
        begin
          sSqlData := '';
          //i := 0;
          for i := 1 to stg_fhd.RowCount -1 do
          begin
            First;
            while not Eof do
            begin
              //inc(i);
              if Trim(stg_fhd.Cells[c_FHGL_PPMC,i])='共计' then Break;
              if StrToIntDef(stg_fhd.Cells[c_FHGL_KCID,i],0) = FieldByName('F_iInventoryID').AsInteger then
              begin
                Edit;
                FieldByName('F_sPPMC').AsString := stg_fhd.Cells[c_FHGL_PPMC,i];
                FieldByName('F_sMZ').AsString := stg_fhd.Cells[c_FHGL_MZ,i];
                FieldByName('F_sTB').AsString := stg_fhd.Cells[c_FHGL_TB,i];
                FieldByName('F_iBS').AsInteger := StrToNum(stg_fhd.Cells[c_FHGL_BS,i]);
                iMs := FieldByName('F_iMS').AsInteger;
                FieldByName('F_iMS').AsInteger := StrToNum(stg_fhd.Cells[c_FHGL_MS,i]);
                FieldByName('F_sBZ').AsString := stg_fhd.Cells[c_FHGL_BZ,i];
                FieldByName('F_iMBMS').AsInteger := StrToNum(stg_fhd.Cells[c_FHGL_MBMS,i]);
                FieldByName('F_iInvoiceID').AsInteger := vInvoiceID;
                iKCID := StrToNum(stg_fhd.Cells[c_FHGL_KCID,i]);
                if iKCID <> 0 then
                  sSqlData := sSqlData + Format(' Update BI_InventoryManagement set F_iFHSL=IsNull(F_iFHSL,0)+%d,F_dFHRQ=GetDate() where F_iID=%d '
                    ,[StrToIntDef(stg_fhd.Cells[c_FHGL_MS,i],0)-iMs,iKCID]);
                FieldByName('F_iInventoryID').AsInteger := iKCID;
                post;
                Break;
              end;
              Next;
            end;
          end;
        end;
        if sSqlData =''then
          raise Exception.Create('更新 BI_InventoryManagement表 失败');
        DM_DataBase.ExecQuery(sSqlData,[],True);

        DM_DataBase.Con_YDPrint.CommitTrans;
        Application.MessageBox('修改成功!','提示',MB_ICONINFORMATION);
      end else
        Application.MessageBox('修改失败!','提示',MB_ICONINFORMATION);

    except
      on E: Exception do
      begin
        DM_DataBase.Con_YDPrint.RollbackTrans;
        Application.MessageBox(PChar('错误:'+E.message),'提示',MB_ICONINFORMATION);
        Exit;
      end;
    end;
  finally
    if Assigned(ADO_Rec) then
      ADO_Rec.Free;
  end;
end;

function TFrm_FHGL_DY.f_MakeAllow: Boolean;
var
  sSqlData, sCode: string;
  ADO_Rec: TADOQuery;
  iAllowID, iAllowCode: Integer;
begin
  Result := False;
  if LoginData.m_iAllowCode >= 0 then
  begin
    sCode := Format('''%s'',''%s'',''%s''',[c_Allow_FHDY_DY,c_Allow_FHDY_BCXG,c_Allow_FHDY_CX]);
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
          if sCode = c_Allow_FHDY_DY then
          begin
            btn_dy.Enabled := True;
            btn_dy.Tag := c_Tag_MakeAllow;
          end else
          if sCode = c_Allow_FHDY_BCXG then
          begin
            btn_Mod.Enabled := True;
            btn_Mod.Tag := c_Tag_MakeAllow;
          end else
          if sCode = c_Allow_FHDY_CX then
          begin
            btn_cx.Enabled := True;
            btn_cx.Tag := c_Tag_MakeAllow;
          end;
        end else
        begin
          if sCode = c_Allow_FHDY_DY then
          begin
            btn_dy.Enabled := False;
            btn_dy.Tag := 0;
          end else
          if sCode = c_Allow_FHDY_BCXG then
          begin
            btn_Mod.Enabled := False;
            btn_Mod.Tag := 0;
          end else
          if sCode = c_Allow_FHDY_CX then
          begin
            btn_cx.Enabled := False;
            btn_cx.Tag := 0;
          end;
        end;
        ADO_Rec.Next;
      end;
    end;
    if Assigned(ADO_Rec) then
      ADO_Rec.Free;
  end;
  Result := True;
end;

procedure TFrm_FHGL_DY.FormShow(Sender: TObject);
begin
  vsTempPath := GetTempDirectory+'YDPrint\YSMD\';
  if not DirectoryExists(vsTempPath) then
    ForceDirectories(vsTempPath);
  rmr_qmjz.SaveToFile(vsTempPath+c_Temp_QMJZ_ExeName);
  rmr_hmjz.SaveToFile(vsTempPath+c_Temp_HMJZ_ExeName);
  if vInvoiceID > 0 then
  begin
    btn_cx.Visible := True;
    btn_Mod.Visible := True;
    btn_ok.Visible := False;
  end;
  f_MakeAllow;
  aYZZL.m_rPK  := c_ZL_PK;
  aYZZL.m_rXK := c_ZL_XK;
  aYZZL.m_rXF  := c_ZL_XF;
  aYZZL.m_rNJ  := c_ZL_NJ;

  aYZFY.m_rPK  := c_FY_PK;
  aYZFY.m_rXK  := c_FY_XK;
  aYZFY.m_rXF  := c_FY_XF;
  aYZFY.m_rNJ  := c_FY_NJ;

  vsSJRY := c_YSMD_SJRY;

end;

procedure TFrm_FHGL_DY.btn_cxClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData,sCZR,str: string;
  i,iInvoiceID,iKCID: integer;
  iDYCS,iMs: Integer;
begin
  try
    if p_MessageBoxDlg('是否确定撤销发货单号：'+ vFHDH + ' ?','提示',MB_YESNO + MB_ICONINFORMATION)=IDNO then
      Exit;
    if vInvoiceID > 0 then
    begin
      try
        DM_DataBase.Con_YDPrint.BeginTrans;
        sSqlData := 'Select * from DO_Invoice where F_iID=%d';
        ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[vInvoiceID]);
        with ADO_Rec do
        begin
          Edit;
          FieldByName('F_tiCXBZ').AsInteger := 1;
          FieldByName('F_sCXRBM').AsString := LoginData.m_sUserName;
          FieldByName('F_dCXRQ').AsDateTime := Now;
          Post;
          Free;
        end;
        sSqlData := 'Select * from DO_InvoiceDetails where F_iInvoiceID=%d order by F_iID';
        ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[vInvoiceID]);
        with ADO_Rec do
        begin
          sSqlData := '';
          //i := 0;
          for i := 1 to stg_fhd.RowCount -1 do
          begin
            First;
            while not Eof do
            begin
              if Trim(stg_fhd.Cells[c_FHGL_PPMC,i])='共计' then Break;
              if StrToIntDef(stg_fhd.Cells[c_FHGL_KCID,i],0) = FieldByName('F_iInventoryID').AsInteger then
              begin
                iMs := FieldByName('F_iMS').AsInteger;
                iKCID := StrToNum(stg_fhd.Cells[c_FHGL_KCID,i]);
                if iKCID <> 0 then
                  sSqlData := sSqlData + Format(' Update BI_InventoryManagement set F_iFHSL=IsNull(F_iFHSL,0)-%d,F_dFHRQ=GetDate() where F_iID=%d '
                    ,[iMs,iKCID]);
                Break;
              end;
              Next;
            end;
          end;
        end;
         if sSqlData =''then
           raise Exception.Create('更新 BI_InventoryManagement表 失败');
         DM_DataBase.ExecQuery(sSqlData,[],True);

        DM_DataBase.Con_YDPrint.CommitTrans;
        Application.MessageBox('撤销成功!','提示',MB_ICONINFORMATION);
        Close;
      except
        on E: Exception do
        begin
          DM_DataBase.Con_YDPrint.RollbackTrans;
          Application.MessageBox(PChar('错误:'+E.message),'提示',MB_ICONINFORMATION);
          Exit;
        end;
      end;
    end else
        Application.MessageBox('撤销失败!','提示',MB_ICONINFORMATION);
  finally
    if Assigned(ADO_Rec) then
      ADO_Rec.Free;
  end;
end;

procedure TFrm_FHGL_DY.btn_ddcxClick(Sender: TObject);
const
  c_CPBH = 0;
  c_PPBC = 1;
  c_MS   = 2;
  c_KCID = 3;
var
  ADO_Rec: TADOQuery;
  sSqlData,sKCID: string;
  aKCID: array of Integer;
  i,iLen: Integer;
begin
  Frm_ListView := TFrm_ListView.Create(Self);
  Frm_ListView.lv_xx.Checkboxes := True;
  Frm_ListView.lv_xx.Columns.Add.Caption := '选择';
  Frm_ListView.lv_xx.Columns[0].Width := 40;
  Frm_ListView.lv_xx.Columns.Add.Caption := '产品编号';
  Frm_ListView.lv_xx.Columns[1].Width := 180;
  Frm_ListView.lv_xx.Columns.Add.Caption := '票品名称';
  Frm_ListView.lv_xx.Columns[2].Width := 300;
  for i := 1 to stg_fhd.RowCount -1 do
  begin
    Frm_ListView.lv_xx.Items.Add.Caption := '';
    iLen := Frm_ListView.lv_xx.Items.Count;
    Frm_ListView.lv_xx.Items.Item[iLen -1].SubItems.Add(stg_fhd.Cells[c_FHGL_CPBH,i]);
    Frm_ListView.lv_xx.Items.Item[iLen -1].SubItems.Add(stg_fhd.Cells[c_FHGL_PPMC,i]);
    Frm_ListView.lv_xx.Items.Item[iLen -1].SubItems.Add(stg_fhd.Cells[c_FHGL_MS,i]);
    Frm_ListView.lv_xx.Items.Item[iLen -1].SubItems.Add(stg_fhd.Cells[c_FHGL_KCID,i]);
  end;
  if Frm_ListView.ShowModal = mrOk then
  begin
    sKCID := '';
    for i := 0 to Frm_ListView.lv_xx.Items.Count -1 do
    begin
     if Frm_ListView.lv_xx.Items.Item[i].Checked then
     begin
       sKCID := sKCID + ',' + Frm_ListView.lv_xx.Items.Item[i].SubItems[c_KCID];
     end;
    end;
    if sKCID <> '' then
    begin
      try
        DM_DataBase.Con_YDPrint.BeginTrans;
        sKCID := Copy(sKCID,2,Length(sKCID));
        sSqlData := 'Select * from BI_InventoryManagement where F_iID in (%s) ';
        ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sKCID]);
        if Assigned(ADO_Rec) and (ADO_Rec.RecordCount>0) then
        begin
          while not ADO_Rec.Eof do
          begin
            ADO_Rec.Edit;
            for i := 0 to Frm_ListView.lv_xx.Items.Count -1 do
            begin

            end;
            ADO_Rec.Post;
          end;

        end;
        sSqlData := 'Select * from DO_InvoiceDetails where F_iKCID in (%s) ';
        ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sKCID]);
        if Assigned(ADO_Rec) and (ADO_Rec.RecordCount>0) then
        begin
          while not ADO_Rec.Eof do
          begin
            ADO_Rec.Edit;

            ADO_Rec.Post;
          end;

        end;
        DM_DataBase.Con_YDPrint.CommitTrans;
      except
        on E: Exception do
        begin
          DM_DataBase.Con_YDPrint.RollbackTrans;
          ADO_Rec.Free;
          Application.MessageBox(PChar('错误:'+E.message),'提示',MB_ICONINFORMATION);
        end;

      end;
    end;

  end;



end;

procedure TFrm_FHGL_DY.btn_ysmddyClick(Sender: TObject);
var
  sSqlData,sFileName: string;
  iJZ: integer; //(0:前面进纸,1:后面进纸)
  sText , sCaption ,AButtom ,BButtom: string;
  i,n: Integer;
begin
  if vInvoiceID > 0 then
  begin
    with DM_DataBase.ADO_Print do
    begin
      Close;
      sSqlData := 'select * from DO_Invoice a,DO_InvoiceDetails b where a.F_iID=b.F_iInvoiceID and a.F_iID =%d';
      SQL.Text := Format(sSqlData,[vInvoiceID]);
      Open;
    end;
    Frm_FHGL_JZFS := TFrm_FHGL_JZFS.Create(Self);
    n := 2;
    for i := 0 to Length(FHDDXX) -1 do
    begin
      Frm_FHGL_JZFS.stg_njxx.RowCount := n+1;
      Frm_FHGL_JZFS.stg_njxx.Cells[c_NJXX_CPBH,n] := FHDDXX[i].m_sCPBH;
      Frm_FHGL_JZFS.stg_njxx.Cells[c_NJXX_NJPM,n] := FHDDXX[i].m_sCPBH;
      Frm_FHGL_JZFS.stg_njxx.Cells[c_NJXX_CPLX,n] := FHDDXX[i].m_sCPLX;
      Frm_FHGL_JZFS.stg_njxx.Cells[c_NJXX_SL,n] := '';
      Frm_FHGL_JZFS.stg_njxx.Cells[c_NJXX_CPDW,n] := '枚';
      inc(n);
    end;
    case Frm_FHGL_JZFS.ShowModal of
      mrYes: iJZ := 0;
      mrNo: iJZ := 1;
    else
      Frm_FHGL_JZFS.Free;
      Exit;
    end;
    n := 2;
    for i := 0 to Frm_FHGL_JZFS.stg_njxx.RowCount -1 do
    begin
      if Frm_FHGL_JZFS.stg_njxx.Cells[c_NJXX_CPBH,n] <> '' then
      begin
        FHDDXX[i].m_sSL := Frm_FHGL_JZFS.stg_njxx.Cells[c_NJXX_SL,n];
        FHDDXX[i].m_sNJPM := FHDDXX[i].m_sCPLX + ' ' +Frm_FHGL_JZFS.stg_njxx.Cells[c_NJXX_NJPM,n];
        FHDDXX[i].m_sCPLX := Frm_FHGL_JZFS.stg_njxx.Cells[c_NJXX_CPLX,n];
        FHDDXX[i].m_sCPDW := Frm_FHGL_JZFS.stg_njxx.Cells[c_NJXX_CPDW,n];
        FHDDXX[i].m_sSJRY := vsSJRY;
        if FHDDXX[i].m_sSL <> '' then
        begin
          FHDDXX[i].m_sNJSL := FHDDXX[i].m_sSL+ FHDDXX[i].m_sCPDW;
          if Pos('普卡',FHDDXX[i].m_sCPLX) >0 then
          begin
            FHDDXX[i].m_sZL := FloatToStr(aYZZL.m_rPK)*(StrToNum(FHDDXX[i].m_sSL) div 1000);
            //FHDDXX[i].m_sFY := FloatToStr(aYZFY.m_rPK)*(StrToNum(FHDDXX[i].m_sSL) div 1000);
            if StrToNum(FHDDXX[i].m_sSL) div 1000 = 1 then
            begin
              FHDDXX[i].m_sFY := FloatToStr(aYZFY.m_rPK);
            end else
            if StrToNum(FHDDXX[i].m_sSL) div 1000 > 1 then
            begin
              FHDDXX[i].m_sFY := '45';
            end else
            begin
              FHDDXX[i].m_sFY := '0';
            end;
          end else
          if Pos('信卡',FHDDXX[i].m_sCPLX) >0 then
          begin
            FHDDXX[i].m_sZL := FloatToStr(aYZZL.m_rXK)*(StrToNum(FHDDXX[i].m_sSL) div 1000);
            FHDDXX[i].m_sFY := FloatToStr(aYZFY.m_rXK)*(StrToNum(FHDDXX[i].m_sSL) div 1000);
          end else
          if Pos('封',FHDDXX[i].m_sCPLX) >0 then
          begin
            FHDDXX[i].m_sZL := FloatToStr(aYZZL.m_rXF)*(StrToNum(FHDDXX[i].m_sSL) div 1000);
            FHDDXX[i].m_sFY := FloatToStr(aYZFY.m_rXF)*(StrToNum(FHDDXX[i].m_sSL) div 1000);
          end else
          if Pos('内件',FHDDXX[i].m_sCPLX) >0 then
          begin
            FHDDXX[i].m_sZL := FloatToStr(aYZZL.m_rNJ)*(StrToNum(FHDDXX[i].m_sSL) div 1000);
            FHDDXX[i].m_sFY := FloatToStr(aYZFY.m_rNJ)*(StrToNum(FHDDXX[i].m_sSL) div 1000);
          end;
        end else
          FHDDXX[i].m_sNJSL := '';
      end;
      Inc(n);
    end;

//    sText := '请选择进纸方式：';
//    sCaption := '提示';
//    AButtom := '前面进纸';
//    BButtom := '后面进纸';
//    case f_SelectDlg(sText,sCaption,AButtom,BButtom) of
//      mrYes: iJZ := 0;
//      mrNo: iJZ := 1;
//    else
//      Exit;
//    end;
    case iJZ of
      0:
        begin
          sFileName := ExtractFilePath(Application.ExeName)+c_YSMD_QMJZ_ExeName;//c_WorkOrder_PrintExeName;
          if FileExists(sFileName) then
            rmr_qmjz.LoadFromFile(sFileName);
          rmr_qmjz.PrepareReport;
          vNum := 0;
          rmr_qmjz.ShowReport;
        end;
      1:
        begin
          sFileName := ExtractFilePath(Application.ExeName)+c_YSMD_HMJZ_ExeName;//c_WorkOrder_PrintExeName;
          if FileExists(sFileName) then
            rmr_hmjz.LoadFromFile(sFileName);
          rmr_hmjz.PrepareReport;
          vNum := 0;
          rmr_hmjz.ShowReport;
        end;
    else

    end;
  end else
  begin
    p_MessageBoxDlg('请先出仓再进行打印!');
    Exit;
  end;
  vNum := 0;
end;

procedure TFrm_FHGL_DY.btn_sjysmdClick(Sender: TObject);
var
  sFileName: string;
  iJZ: integer;
  sText , sCaption ,AButtom ,BButtom: string;
begin
  sText := '请选择进纸方式：';
  sCaption := '提示';
  AButtom := '前面进纸';
  BButtom := '后面进纸';
  case f_SelectDlg(sText,sCaption,AButtom,BButtom) of
    mrYes: iJZ := 0;
    mrNo: iJZ := 1;
  else
    Exit;
  end;
  case iJZ of
    0:
      begin
        sFileName := ExtractFilePath(Application.ExeName)+c_YSMD_QMJZ_ExeName;//c_WorkOrder_PrintExeName;
        if FileExists(sFileName) then
          rmr_qmjz.LoadFromFile(sFileName);
        rmr_qmjz.DesignReport;
      end;
    1:
      begin
        sFileName := ExtractFilePath(Application.ExeName)+c_YSMD_HMJZ_ExeName;
        if FileExists(sFileName) then
          rmr_hmjz.LoadFromFile(sFileName);
        rmr_hmjz.DesignReport;
      end;
  end;
end;

procedure TFrm_FHGL_DY.rmr_qmjz_oldBeforePrintBand(aBand: TRMBand;
  var aPrintBand: Boolean);
begin
  if Pos('(',edt_lxdh.Text)=0 then
    p_SetPrint(rmr_qmjz,'mmo_SJDH',edt_lxdh.Text);
  p_SetPrint(rmr_qmjz,'mmo_NJPM',FHDDXX[vNum].m_sNJPM);
  p_SetPrint(rmr_qmjz,'mmo_NJSL',FHDDXX[vNum].m_sNJSL);
  p_SetPrint(rmr_qmjz,'mmo_ZL',FHDDXX[vNum].m_sZL);
  p_SetPrint(rmr_qmjz,'mmo_FY',FHDDXX[vNum].m_sFY);
  p_SetPrint(rmr_qmjz,'mmo_SJRY',FHDDXX[vNum].m_sSJRY);
  inc(vNum);

end;

procedure TFrm_FHGL_DY.rmr_hmjz_oldBeforePrintBand(aBand: TRMBand;
  var aPrintBand: Boolean);
begin
  if Pos('(',edt_lxdh.Text)=0 then
    p_SetPrint(rmr_hmjz,'mmo_SJDH',edt_lxdh.Text);
  p_SetPrint(rmr_hmjz,'mmo_NJPM',FHDDXX[vNum].m_sNJPM);
  p_SetPrint(rmr_hmjz,'mmo_NJSL',FHDDXX[vNum].m_sNJSL);
  p_SetPrint(rmr_hmjz,'mmo_ZL',FHDDXX[vNum].m_sZL);
  p_SetPrint(rmr_hmjz,'mmo_FY',FHDDXX[vNum].m_sFY);
  p_SetPrint(rmr_hmjz,'mmo_SJRY',FHDDXX[vNum].m_sSJRY);
  inc(vNum);

end;

procedure TFrm_FHGL_DY.rmr_ysmddyBeforePrintBand(aBand: TRMBand;
  var aPrintBand: Boolean);
begin
  if Pos('(',edt_lxdh.Text)=0 then
    p_SetPrint(rmr_ysmddy,'mmo_SJDH',edt_lxdh.Text);
  p_SetPrint(rmr_ysmddy,'mmo_NJPM',FHDDXX[vNum].m_sNJPM);
  p_SetPrint(rmr_ysmddy,'mmo_NJSL',FHDDXX[vNum].m_sNJSL);
  inc(vNum);

end;

procedure TFrm_FHGL_DY.Button1Click(Sender: TObject);
var
  sFileName: string;
  iJZ: integer;
  sText , sCaption ,AButtom ,BButtom: string;
begin
  sText := '请选择要导入哪种模版：';
  sCaption := '提示';
  AButtom := '前面进纸';
  BButtom := '后面进纸';
  case f_SelectDlg(sText,sCaption,AButtom,BButtom) of
    mrYes: iJZ := 0;
    mrNo: iJZ := 1;
  else
    Exit;
  end;
  if OpenDialog1.Execute then
  begin
    case iJZ of
      0:
        begin
          sFileName := ExtractFilePath(Application.ExeName)+c_YSMD_QMJZ_ExeName;//c_WorkOrder_PrintExeName;
          if not FileExists(sFileName) then
            ForceDirectories(ExtractFilePath(sFileName));
          CopyFile(PChar(OpenDialog1.FileName),PChar(sFileName),False);
        end;
      1:
        begin
          sFileName := ExtractFilePath(Application.ExeName)+c_YSMD_HMJZ_ExeName;
          if not FileExists(sFileName) then
            ForceDirectories(ExtractFilePath(sFileName));
          CopyFile(PChar(OpenDialog1.FileName),PChar(sFileName),False);
        end;
    end;
    p_MessageBoxDlg('导入成功!')
  end;
end;

procedure TFrm_FHGL_DY.Button2Click(Sender: TObject);
var
  sFileName: string;
  iJZ: integer;
  sText , sCaption ,AButtom ,BButtom: string;
begin
  sText := '请选择要清空哪种模版：';
  sCaption := '提示';
  AButtom := '前面进纸';
  BButtom := '后面进纸';
  case f_SelectDlg(sText,sCaption,AButtom,BButtom) of
    mrYes: iJZ := 0;
    mrNo: iJZ := 1;
  else
    Exit;
  end;
  case iJZ of
    0:
      begin
        sFileName := ExtractFilePath(Application.ExeName)+c_YSMD_QMJZ_ExeName;//c_WorkOrder_PrintExeName;
        if FileExists(sFileName) then
          DeleteFile(sFileName);
        if FileExists(vsTempPath+c_Temp_QMJZ_ExeName) then
          rmr_qmjz.LoadFromFile(vsTempPath+c_Temp_QMJZ_ExeName);
      end;
    1:
      begin
        sFileName := ExtractFilePath(Application.ExeName)+c_YSMD_HMJZ_ExeName;
        if FileExists(sFileName) then
          DeleteFile(sFileName);
        if FileExists(vsTempPath+c_Temp_HMJZ_ExeName) then
          rmr_hmjz.LoadFromFile(vsTempPath+c_Temp_HMJZ_ExeName);
      end;
  end;
  p_MessageBoxDlg('清空成功!')
end;

end.









