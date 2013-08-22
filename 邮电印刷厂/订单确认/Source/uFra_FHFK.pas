unit uFra_FHFK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, RzPanel, StdCtrls, ExtCtrls, GridsEh,
  DBGridEh, RzRadChk, ComCtrls, RzDTP, RzButton, ButtonEdit, ADODB,
  RzCmboBx, iComboBox, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, DBGridEhImpExp, Menus,iLabel, PostService;

type
  TFra_FHFK = class(TFrame)
    gb_dd: TRzGroupBox;
    dbg_fhfk: TDBGridEh;
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
    RzPanel2: TRzPanel;
    btn_ok: TRzBitBtn;
    RzGroupBox1: TRzGroupBox;
    Label3: TLabel;
    edt_gdh: Ti_TxtFilter;
    btn_cx: TRzBitBtn;
    dtp_jcq: TRzDateTimePicker;
    dtp_jcz: TRzDateTimePicker;
    cb_jcrq: TRzCheckBox;
    edt_cpbh: Ti_TxtFilter;
    edt_rjhdq: Ti_TxtFilter;
    edt_zh: Ti_TxtFilter;
    edt_rjhdz: Ti_TxtFilter;
    cbb_fhbz: Ti_ComboBox;
    cbb_jsbz: Ti_ComboBox;
    dtp_fhrq: TRzDateTimePicker;
    lab_flrq: TLabel;
    btn_Save: TRzBitBtn;
    btn_qcdd: TButton;
    Label4: TLabel;
    dtp_fkrqq: TRzDateTimePicker;
    dtp_fkrqz: TRzDateTimePicker;
    cb_fjrq: TRzCheckBox;
    btn_cxfh: TButton;
    btn_export: TRzButton;
    SavePath: TSaveDialog;
    pm_jhxd: TPopupMenu;
    menu_ddmx: TMenuItem;
    menu_ddmxPic: TMenuItem;
    N2: TMenuItem;
    menu_ztmx: TMenuItem;
    menu_fhmx: TMenuItem;
    procedure btn_cxClick(Sender: TObject);
    procedure lab_ts50Click(Sender: TObject);
    procedure lab_firstClick(Sender: TObject);
    procedure lab_upClick(Sender: TObject);
    procedure lab_downClick(Sender: TObject);
    procedure lab_lastClick(Sender: TObject);
    procedure btn_goClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure dbg_fhfkTitleClick(Column: TColumnEh);
    procedure edt_rjhdqExit(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure cb_fjrqClick(Sender: TObject);
    procedure cbb_fhbzChange(Sender: TObject);
    procedure btn_qcddMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btn_cxfhClick(Sender: TObject);
    procedure btn_exportClick(Sender: TObject);
    procedure pm_jhxdPopup(Sender: TObject);
    procedure menu_ddmxClick(Sender: TObject);
    procedure menu_ztmxClick(Sender: TObject);
    procedure menu_fhmxClick(Sender: TObject);
  private
    { Private declarations }
    vMYTS: Integer;     //��ǰÿҳ����
    vYs: integer;       //��ǰҳ��
    vSqlData: string;
    function f_MakeAllow: Boolean;   //��������
    function f_SaveXQXX: Boolean;
    function f_ErrorCodeToStr(iRec: integer): string;
    function f_GetJiangCode(var _XH: Integer;SYSL: Integer): string;
    function f_SetArrJiangCode(OrderID,OrderType: Integer): Boolean;
    function f_GetFYDH(_TXM: string): string;
    function f_FHFK(const obj: PostServicePortType;const Dfbbz: integer;const OrderID: Integer;const OrderType: Integer;CPBH: string; const Type_: Integer; const ID: WideString;
                         const ProductCode: WideString; const Tao: Integer; const Out_: Integer; const OutCode: WideString; const JiangCode: WideString; const OutWay: WideString;
                         const OverDate: WideString; const OutNum: Integer; const TXM: WideString; const ZXS: WideString; const CBSL: WideString; const BZ: WideString;var iRec: integer; bRaise: Boolean=False): Boolean;
    function f_IsRJHDPP(iOrderID,iOrderType: Integer): Boolean;        //���ҽ����������붩��ӡ���Ƿ�ƥ��
    procedure btn_qcddClick_old(Sender: TObject);
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

uses
  uDM_DataBase, PubStr, uPub_Text,
  uMain, DB, uPub_Type, uPub_Func, uDDMX_DZX, uDDMX_XSX, uFrm_ZTMX,
  uFrm_FHMX;

{$R *.dfm}

type
  TJiangCode = record
    m_sZH: string;
    m_iRJHDQ: Integer;
    m_iRJHDZ: Integer;
  end;
var
  aJiangCode: array of TJiangCode;
  LabelGroup:array of TCartonLableGroup;

procedure TFra_FHFK.btn_cxClick(Sender: TObject);
var
  sSqlData,sFkq,sFkz: string;
  n: Integer;
  iYS,iMYTS: integer;
  iFHBZ: integer;
begin
  Screen.Cursor := crHourGlass;
  btn_cx.Caption := '��ѯ��...';
  sFkq := '';
  sFkz := '';
  if cb_fjrq.Checked then
  begin
    sFkq := FormatDateTime('yyyy.MM.dd 00:00:00',dtp_Fkrqq.DateTime);
    sFkz := FormatDateTime('yyyy.MM.dd 23:59:59',dtp_Fkrqz.DateTime);
  end;
  iFHBZ := cbb_fhbz.ItemIndex;
  case iFHBZ of
    0:
      begin
        btn_ok.Visible   := True;
        lab_flrq.Visible := True;
        dtp_fhrq.Visible := True;
        btn_qcdd.Visible := True;
        btn_Save.Visible := True;
        btn_cxfh.Visible := False;
       // dbg_fhfk.Columns.Items.FieldName
      end;                                                            
    1:
      begin
        if LoginData.m_sUserName <> 'admin' then
        begin
          btn_ok.Visible   := False;
          lab_flrq.Visible := False;
          dtp_fhrq.Visible := False;
        end;          
        btn_Save.Visible := False;
        btn_qcdd.Visible := False;
        btn_cxfh.Visible := True;
      end;
    2:
      begin
        btn_ok.Visible   := False;
        lab_flrq.Visible := False;
        dtp_fhrq.Visible := False;
        btn_Save.Visible := False;
        btn_qcdd.Visible := False;
        btn_cxfh.Visible := True;
      end;
  else
    btn_ok.Visible   := True;
    lab_flrq.Visible := True;
    dtp_fhrq.Visible := True;
    btn_qcdd.Visible := True;
    btn_Save.Visible := True;
    btn_cxfh.Visible := False;
  end;
  Application.ProcessMessages;   //��ť��˸���
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
  try
    sSqlData := Format('Exec p_fhfkcx ''%s'',''%s'',''%s'',''%s'',%d,%d,%d',[Trim(edt_cpbh.Text),Trim(edt_gdh.Text),sFkq,sFkz,iFHBZ,iYS,iMYTS]);
    DM_DataBase.ADO_FHFK.Close;
    DM_DataBase.ADO_FHFK.SQL.Text :=  sSqlData;
    DM_DataBase.ADO_FHFK.Open;
  //  DM_DataBase.ADO_FHFK.Close;
  //  DM_DataBase.ADO_FHFK.Open;
  //  n := DM_DataBase.ADO_FHFK.RecordCount;
    vSqlData := Format('Exec p_fhfkcx ''%s'',''%s'',''%s'',''%s'',%d,%s,%s',[Trim(edt_cpbh.Text),Trim(edt_gdh.Text),sFkq,sFkz,iFHBZ,'%d','%d']);
    n := 0;
    if DM_DataBase.ADO_FHFK.RecordCount > 0 then
    begin
      n := DM_DataBase.ADO_FHFK.FieldByName('Count').AsInteger;
    end;
    gb_dd.Caption := '����  ����:'+IntToStr(n)+'��';
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    lab_zys.Caption := 'ҳ�Σ�1/'+ IntToStr(lab_zys.Tag);
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar('����:'+E.message),'��ʾ',MB_ICONINFORMATION);
    end;
  end;          
  btn_cx.Caption := '��ѯ';
  Screen.Cursor := crDefault;
end;

procedure TFra_FHFK.lab_ts50Click(Sender: TObject);
var
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
  DM_DataBase.ADO_FHFK.Close;
  sSqlData := Format(vSqlData,[1,vMYTS]);
  DM_DataBase.ADO_FHFK.SQL.Text :=  sSqlData;
  DM_DataBase.ADO_FHFK.Open;
//  DM_DataBase.ADO_FHFK.Close;
//  DM_DataBase.ADO_FHFK.Open;
  LabFontClear(lab_ts50);
  LabFontClear(lab_ts100);
  LabFontClear(lab_ts200);
  LabFontClear(lab_ts500);
  TLabel(Sender).Font.Color :=  clBlack;
  TLabel(Sender).Font.Size := 10;
  TLabel(Sender).Font.Style := [fsBold];
  TLabel(Sender).Cursor := crDefault;
  vYs := 1;
  edt_ys.Text := '1';
  if DM_DataBase.ADO_FHFK.RecordCount > 0 then
  begin
    n := DM_DataBase.ADO_FHFK.FieldByName('Count').AsInteger;
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    lab_zys.Caption := 'ҳ�Σ�1/'+ IntToStr(lab_zys.Tag);
  end;
end;

procedure TFra_FHFK.lab_firstClick(Sender: TObject);
begin
  if vYs = 1 then Exit;
  edt_ys.Text := '1';
  btn_go.Click;
end;

procedure TFra_FHFK.lab_upClick(Sender: TObject);
begin
  if vYs > 1 then
  begin
    edt_ys.Text := IntToStr(vYs -1);
    btn_go.Click;
  end;
end;

procedure TFra_FHFK.lab_downClick(Sender: TObject);
begin
  if vYs < lab_zys.Tag then
  begin
    edt_ys.Text := IntToStr(vYs +1);
    btn_go.Click;
  end;
end;

procedure TFra_FHFK.lab_lastClick(Sender: TObject);
begin
  if vYs = lab_zys.Tag then Exit;
  edt_ys.Text := IntToStr(lab_zys.Tag);
  btn_go.Click;
end;

procedure TFra_FHFK.btn_goClick(Sender: TObject);
var
  iYs,n: Integer;
  sSqlData: string;
begin
  Screen.Cursor := crHourGlass;
  iYs := StrToNum(edt_ys.Text);
  DM_DataBase.ADO_FHFK.Close;
  sSqlData := Format(vSqlData,[iYs,vMYTS]);
  DM_DataBase.ADO_FHFK.SQL.Text :=  sSqlData;
  DM_DataBase.ADO_FHFK.Open;
//  DM_DataBase.ADO_FHFK.Close;
//  DM_DataBase.ADO_FHFK.Open;
  if DM_DataBase.ADO_FHFK.RecordCount > 0 then
  begin
    n := DM_DataBase.ADO_FHFK.FieldByName('Count').AsInteger;
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    vYs := iYs;
    lab_zys.Caption := 'ҳ�Σ�'+IntToStr(iYs)+'/'+ IntToStr(lab_zys.Tag);
  end;
  Screen.Cursor := crDefault;
end;

procedure TFra_FHFK.FraShow;
begin
  dtp_fhrq.DateTime := Now;
  dtp_fkrqq.DateTime := Now;
  dtp_fkrqz.DateTime := Now;
  //btn_cxfh.Left := dtp_fhrq.Left;
  f_MakeAllow;
end;

procedure TFra_FHFK.btn_okClick(Sender: TObject);
var
  ADO_Rec, ADO_Save, ADO_Temp: TADOQuery;
  sSqlData, sLableInfoID, str, sSBID: string;
  obj: PostServicePortType;
  nYL: Real;
  i, j, n, k, iFeedbackID, iLableInfoID, iOrderID, iOrderType, iApartCount, iPackages, iPackageID, iTempNum, iRec,  iXH, iSYSL: Integer;
  iZMS: integer;
  sProductCode,sOldProductCode, sOutCode,sZOutCode, sJiangCode, sOutWay, sOverDate, sTXM, sBZ: string;
  sCPBH,sTGZT,sALLCPBH: string;
  iDfbbz, iType, iSBID, iTao, iOut, iOutNum, iZXS, iCBSL, iCXSL: Integer;
  pBookMark: Pointer;
  iPos: Integer;
  sTemp: string;
  sYSDH: string;
  sName: string;
begin
  sName := TRzButton(Sender).Name;
  str := '';
  with DM_DataBase do
  begin
    pBookMark := ADO_FHFK.GetBookmark;
    if ADO_FHFK.RecordCount > 0 then
    begin
      sLableInfoID := '';
      sCPBH := '';
      sTGZT := '';
      n := 0;
      ADO_FHFK.FindFirst;
      for i := 0 to ADO_FHFK.RecordCount -1 do
      begin
        if ADO_FHFK.FindField('XZ').AsBoolean then
        begin
          sLableInfoID := sLableInfoID + ',' + ADO_FHFK.FindField('LableInfoID').AsString;
          str := ADO_FHFK.FindField('F_sCPBH').AsString;
          sSqlData := 'select 1 from Set_ParamList where F_sName = ''%s'' and F_sParam1=1 ';
          ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[c_FHFKRJHDPP]);
          if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
          begin
            if not f_IsRJHDPP(ADO_FHFK.FindField('OrderID').AsInteger,ADO_FHFK.FindField('OrderType').AsInteger) then
            begin
              p_MessageBoxDlg(str+' ��������������ҽ�������������!');
              Exit;
            end;
          end;
          if Assigned(ADO_Rec) then ADO_Rec.Free;
          if Copy(str,1,1)= '*' then
            sCPBH := sCPBH + ',' + Copy(str,2,Length(str));
          sALLCPBH := sALLCPBH+','+str;
          //if Trim(ADO_FHFK.FindField('TGZT').AsString) <> '' then
          //  sTGZT := sTGZT + str + '  ' + ADO_FHFK.FindField('TGZT').AsString+#13#10;
          inc(n);
        end;
        if i < ADO_FHFK.RecordCount -1 then
          ADO_FHFK.FindNext;
      end;
      if n = 0 then
      begin
        DM_DataBase.ADO_FHFK.GotoBookmark(pBookMark);
        p_MessageBoxDlg('��ѡ��Ҫ�����Ķ���!');
        Exit;
      end;
      if sLableInfoID <> '' then
      begin
        sLableInfoID := Copy(sLableInfoID,2,Length(sLableInfoID));
      end else
        sLableInfoID := '-1';
    end;
  end;
//  ͼ��״̬δ�ϸ�δǩ��  
//  if sTGZT <> '' then
//  begin
//    DM_DataBase.ADO_FHFK.GotoBookmark(pBookMark);
//    p_MessageBoxDlg('ʧ�ܣ�'+sTGZT);
//    Exit;
//  end;
  //�ж��Ƿ�ֻ�в��ַ���
  if sALLCPBH <> '' then
    sALLCPBH := Copy(sALLCPBH,2,Length(sALLCPBH));
  DM_DataBase.ADO_FHFK.GotoBookmark(pBookMark);
  if (sName = 'btn_qcdd') and (p_MessageBoxDlg(sALLCPBH+' �����Ƿ���ȷ���ڹ�����������������?','��ʾ',MB_ICONINFORMATION+ MB_YESNO) = IDNO) then
  begin
    Exit;
  end;
  if sCPBH <> '' then
  begin
    sCPBH := Copy(sCPBH,2,Length(sCPBH));
    DM_DataBase.ADO_FHFK.GotoBookmark(pBookMark);
    if p_MessageBoxDlg(sCPBH+' ����ֻ�в��ַ���,�Ƿ��������?','��ʾ',MB_ICONINFORMATION+ MB_YESNO) = IDNO then
    begin
      Exit;
    end;
  end;
  if not f_SaveXQXX then
  begin
    p_MessageBoxDlg('�������!');
    Exit;
  end;
   //�ж��Ƿ�ֻ�в��ַ���.�����
{  sSqlData := 'select a. from DO_CartonLableInfo a where exists(select 1 form DO_OrderApart b,BI_InventoryManagement c '
    +' where a.F_iOrderID=b.F_iOrderID and a.F_tiOrderType=b.F_tiOrderType and b.F_iID=c.F_iApartID and c.F_iSL > F_iFHSL and a.F_iID in (%s) ) ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sLableInfoID]);
  str := '';
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount>0) then
  begin

  end;    }
  obj := GetPostServicePortType(true,uMain.vUrl, nil);
  if obj = nil then
  begin
    p_MessageBoxDlg('��������ʧ��,�����Ƿ���Է�������!!!');
    exit;
  end;
  sSqlData := 'Select *,ZMS=F_nYL*10000 from DO_CartonLableInfo where F_iID in (%s) ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sLableInfoID]);
  sSqlData := 'Select * from DO_FeedbackInvoricInfo where 1=2 ';
  ADO_Save := DM_DataBase.OpenQuery(sSqlData,[sProductCode]);
  DM_DataBase.ADO_FHFK.FindFirst;
  str := '';
  sSBID := '';
  for i := 0 to DM_DataBase.ADO_FHFK.RecordCount -1 do
  begin
    if DM_DataBase.ADO_FHFK.FindField('XZ').AsBoolean then
    begin
     { sSqlData := 'select 1 from Set_ParamList where F_sName = ''%s'' and F_sParam1=1 ';
      ADO_Temp := DM_DataBase.OpenQuery(sSqlData,[c_XQRJHDPP]);
      if Assigned(ADO_Temp) and (ADO_Temp.RecordCount > 0) then
      begin
        SetLabelGroup(ADO_Rec.FindField('OrderID').AsInteger,ADO_Rec.FindField('OrderType').AsInteger);
        if not f_IsRJHDPP(Trunc(ADO_Rec.FindField('YL').AsFloat*10000)) then
        begin
          p_MessageBoxDlg(ADO_xqxx.FindField('F_sCPBH').AsString+' �ҽ�����������ӡ����ƥ��!');
          Exit;
        end;
      end;
      if Assigned(ADO_Temp) then ADO_Temp.Free;  }
      iDfbbz := DM_DataBase.ADO_FHFK.FieldByName('F_tiDfbbz').AsInteger;
      iSBID := DM_DataBase.ADO_FHFK.FieldByName('SBID').AsInteger;
      iLableInfoID := DM_DataBase.ADO_FHFK.FieldByName('LableInfoID').AsInteger;
      if iDfbbz = 0 then
        iType := DM_DataBase.ADO_FHFK.FieldByName('OrderType').AsInteger
      else
        iType := 1;
//      sProductCode := DM_DataBase.ADO_FHFK.FieldByName('F_sCPBH').AsString;
      sOutCode := DM_DataBase.ADO_FHFK.FieldByName('F_sYSDH').AsString;
      sOverDate := FormatDateTime('yyyy-MM-dd',dtp_fhrq.DateTime);
      n := 0;
      k := 0;
      sOldProductCode := '';
      with ADO_Rec do
      begin
        First;
        while not Eof do
        begin
          if FieldByName('F_iID').AsInteger <> iLableInfoID then
          begin
            Next;
            Continue;
          end;
//          iLableInfoID := FieldByName('F_iID').AsInteger;
          iOrderID := FieldByName('F_iOrderID').AsInteger;
          iOrderType := FieldByName('F_tiOrderType').AsInteger;
          iTao := FieldByName('F_tiTMBZ').AsInteger;
          iOut := iif(cbb_fhbz.ItemIndex=2,0,cbb_fhbz.ItemIndex);
          iZXS := FieldByName('F_iZXS').AsInteger;
          sOutWay := FieldByName('F_sFHFS').AsString;
          iZMS := FieldByName('ZMS').AsInteger;
          iCBSL := FieldByName('F_iCBSL').AsInteger;
          iCXSL := FieldByName('F_iCXSL').AsInteger;
          sBZ := FieldByName('F_sBZ').AsString;
          sSqlData := 'select count(F_iID) ApartCount from DO_OrderApart where F_iOrderID=%d and F_tiOrderType=%d and F_tiNjbz=0 and F_tiCXBZ = 0 ';
          ADO_Temp  := DM_DataBase.OpenQuery(sSqlData,[iOrderID,iOrderType]);
          iApartCount := 0;
          if Assigned(ADO_Temp) and (ADO_Temp.RecordCount > 0) then
          begin
            iApartCount := ADO_Temp.FieldByName('ApartCount').AsInteger;
          end;
          ADO_Temp.Free;
          iXH := 0;
          f_SetArrJiangCode(iOrderID,iOrderType);
          sTXM := FieldByName('F_sTXM').AsString;
          if sTXM= '' then
          begin
            sTXM := f_GetTXM(iOrderID,iOrderType,iTao);
          end;
          for j := 1 to  iZXS do
          begin
            sCPBH := DM_DataBase.ADO_FHFK.FieldByName('F_sCPBH').AsString;
            sProductCode := sCPBH;
            if Copy(sProductCode,1,1) = '*' then
              sProductCode := Copy(sProductCode,2,Length(sProductCode));
            sTXM := StrLeft(sTXM,14)+StrRight('00000'+IntToStr(j),5) + StrRight(sTXM,4);
            if (StrRight(sCPBH,3)='999') then
            begin
              iPackages :=  iZXS div iApartCount;
              if iZXS mod iApartCount > 0 then
              begin
                iPackages := iPackages + 1;
              end;
              if iTao=1 then
              begin
                iPackages := iZXS;
              end;
              iPackageID := j mod iPackages;
              if j mod iPackages =0  then
                iPackageID := iPackages;
              iTempNum := ((j-1) div iPackages) + 1;
              case iTao of
                0:
                  begin
                    sProductCode := Copy(sProductCode,1,Length(sProductCode)-3)+copy(sTXM,12,1)+StrRight('00'+IntToStr(iTempNum),2);
                    //���������Ű�����β����
                    // sTXM := StrLeft(sTXM,11)+StrRight('000'+IntToStr(iTempNum),3)+StrRight('00000'+IntToStr(iPackageID),5) + StrRight(sTXM,4);
                    //���������Ű�˳����
                    sTXM := StrLeft(sTXM,12)+StrRight('00'+IntToStr(iTempNum),2)+StrRight('00000'+IntToStr(j),5) + StrRight(sTXM,4);
                  end;
                1:
                  begin
                    sTXM := StrLeft(sTXM,11)+'999' + StrRight(sTXM,9);
                  end;
              end;
              if j mod iPackages = 0 then
              begin
                if iTao = 1 then
                  iOutNum := iZMS - iCXSL * (iPackages-1)
                else
                  iOutNum := iZMS div iApartCount - iCXSL * (iPackages-1);
              end else
                iOutNum := iCXSL;
            end else
            begin
              sProductCode := StrLeft(sProductCode,Length(sProductCode)-3)+Copy(sTXM,12,3);
              iOutNum := iCXSL;
              if j = iZXS then
              begin
                iOutNum := iZMS - iCXSL*(iZXS-1)
              end;
            end;
            sJiangCode := f_GetJiangCode(iXH, iOutNum);
            sYSDH := f_GetFYDH(sTXM);
            if (sYSDH <> '') or (Length(sOutCode)>100) then       //(Length(sOutCode)>100 ������Ϊ�˷�ֹ����)
              sOutCode := sYSDH;
            if sName <> 'btn_qcdd' then
            begin
              if not f_FHFK(obj,iDfbbz,iOrderID,iOrderType,sCPBH,iType,IntToStr(iSBID),sProductCode,iTao,
                  iOut,sOutCode,sJiangCode,sOutWay,sOverDate,iOutNum,sTXM,IntToStr(iZXS),IntToStr(iCBSL),sBZ,iRec,False) then
              begin
                try
                  f_WriteOperationLog('[��������]'+sCPBH+' ����������һ��ʧ��!',999);
                  f_FHFK(obj,iDfbbz,iOrderID,iOrderType,sCPBH,iType,IntToStr(iSBID),sProductCode,iTao,
                    iOut,sOutCode,sJiangCode,sOutWay,sOverDate,iOutNum,sTXM,IntToStr(iZXS),IntToStr(iCBSL),sBZ,iRec,True);
                  f_WriteOperationLog('[��������]'+sCPBH+' ���������ڶ��γɹ�!',999);
                except
                  on E: Exception do
                  begin
                    f_WriteOperationLog('[��������]�����������ӳ���:'+E.message,999);
                    p_MessageBoxDlg(PChar('���ӳ���:'+E.message));
                    Exit;
                  end;
                end;
              end;
//ԭ�������������ӿڵ���,���ַ�����һ�γ���,�ڶ��γɹ�,���Խ��з�װf_FHFK,���������ٽ��з��� (��װ�� f_FHFK)
{              try
                iRec := obj.setOutInfo(c_Web_UserName, c_Web_UserPwd,iType,IntToStr(iSBID),sProductCode,iTao,
                  iOut,sOutCode,sJiangCode,sOutWay,sOverDate,iOutNum,sTXM,IntToStr(iZXS),IntToStr(iCBSL),sBZ);
                //�������ͼ��δ�ϸ�
                if iRec= 41 then
                begin
                  case iOrderType of
                    0: sSqlData :='select 1 from BI_CustomOrderDetails where F_iFktgzt=3 and F_iID=%d';
                    1: sSqlData :='select 1 from BI_SellOrderDetails where F_iFktgzt=3 and F_iID=%d';
                  else
                    sSqlData :='select 1 from BI_CustomOrderDetails where F_iFktgzt=3 and F_iID=%d';
                  end;
                  ADO_Temp := DM_DataBase.OpenQuery(sSqlData,[iOrderID]);
                  if Assigned(ADO_Temp) and (ADO_Temp.RecordCount > 0) then
                  begin
                    if obj.setProductInfo('wsfj1', '000000',iif(iDfbbz=0,iOrderType,3),IntToStr(iSBID),sCPBH,3) = 0 then
                    begin
                      iRec := obj.setOutInfo(c_Web_UserName, c_Web_UserPwd,iType,IntToStr(iSBID),sProductCode,iTao,
                        iOut,sOutCode,sJiangCode,sOutWay,sOverDate,iOutNum,sTXM,IntToStr(iZXS),IntToStr(iCBSL),sBZ);
                    end;
                    ADO_Temp.Free;
                  end;
                end;
              except
                on E: Exception do
                begin
                  p_MessageBoxDlg(PChar('���ӳ���:'+E.message));
                  Exit;
                end;
              end;  }
            end;
            with ADO_Save do
            begin
              try
                Insert;
                FieldByName('F_tiType').AsInteger := iType;
                FieldByName('F_iSBID').AsInteger := iSBID;
                FieldByName('F_sProductCode').AsString := sProductCode;
                FieldByName('F_tiTao').AsInteger := iTao;
                FieldByName('F_tiOut').AsInteger := iOut;
                FieldByName('F_sOutCode').AsString := sOutCode;
                FieldByName('F_sJiangCode').AsString := sJiangCode;
                FieldByName('F_sOutWay').AsString := sOutWay;
                FieldByName('F_dOverDate').AsDateTime := dtp_fhrq.DateTime;
                FieldByName('F_iOutNum').AsInteger := iOutNum;
                FieldByName('F_sTXM').AsString := sTXM;
                FieldByName('F_iZXS').AsInteger := iZXS;
                FieldByName('F_iCBSL').AsInteger := iCBSL;
                FieldByName('F_iCXSL').AsInteger := iCXSL;
                FieldByName('F_sBZ').AsString := sBZ;
                FieldByName('F_iOrderID').AsInteger := iOrderID;
                FieldByName('F_tiOrderType').AsInteger := iOrderType;
                FieldByName('F_tiFKBZ').AsInteger := iif(sName = 'btn_qcdd',10,iif(iRec >0,0,1));
                FieldByName('F_iErrorCode').AsInteger := iif(sName = 'btn_qcdd',1000,iRec);
                FieldByName('F_sFKR').AsString := LoginData.m_sUserName;
                Post;
                iFeedbackID := FieldByName('F_iID').AsInteger;
              except
                on E: Exception do
                begin
                  Application.MessageBox(PChar('����:'+E.message),'��ʾ',MB_ICONINFORMATION);
                  if Pos(IntToStr(iSBID),sSBID)=0 then
                    sSBID := sSBID + ','+IntToStr(iSBID);
                  str := str+ sProductCode+ ' ����ʧ�ܡ�����ԭ��: ��־�������!'+#13#10 ;
                end;
              end;
            end;
            if sName <> 'btn_qcdd' then
            begin
              if (sOldProductCode='') or (sOldProductCode=sProductCode) then
                inc(k)
              else
              begin
                if Pos(sOldProductCode+'�����ɹ���(%d)',str)>0 then
                  str := Format(str,[k]);
                k := 1;
              end;
              if iRec >0 then
              begin
                if Pos(IntToStr(iSBID),sSBID)=0 then
                  sSBID := sSBID + ','+IntToStr(iSBID);
                str := str+ sProductCode+ ' ����ʧ�ܡ�����ԭ��: ' +f_ErrorCodeToStr(iRec) + '('+ IntToStr(iFeedbackID) +')'+#13#10 ;
              end else
              if iRec = 0 then
              begin
                inc(n);
                if Pos(sProductCode+'�����ɹ�',str)=0 then
                begin
                  sOldProductCode := sProductCode;
                  str := str+ sProductCode+ '�����ɹ���(%d)'+#13#10;
                end;

              end;
            end;
          end;
          if sName <> 'btn_qcdd' then
          begin
            if (n < iZXS) and (Pos(IntToStr(iSBID),sSBID)=0) then
            begin
              sTemp := sProductCode+'����ʧ�ܡ�����ԭ��: ������ǩ��('+IntToStr(n)+')С��������('+IntToStr(iZXS)+')'  ;
              iPos := Pos(sProductCode+ '�����ɹ���(%d)',str);
              if iPos > 0 then
                Str := Copy(str,1,iPos-1) + sTemp + Copy(str,iPos+length(sProductCode+ '�����ɹ���(%d)'),Length(str))
              else
                Str := Str +  sTemp;
              sSBID := sSBID + ','+IntToStr(iSBID);
            end;
            if Pos(sProductCode+'�����ɹ���(%d)',str)>0 then
              str := Format(str,[k]);
          end;
          Break;
        end;
      end;
    end;
    if i < DM_DataBase.ADO_FHFK.RecordCount -1 then
      DM_DataBase.ADO_FHFK.FindNext;
  end;
  ADO_Rec.Free;
  ADO_Save.Free;
  if sName = 'btn_qcdd' then
  begin
    DM_DataBase.ADO_FHFK.GotoBookmark(pBookMark);
    p_MessageBoxDlg('�����ɹ�');
    btn_cx.Click;
  end else
  begin
    if sSBID<> '' then
    begin
      sSBID := Copy(sSBID,2,Length(sSBID));
      sSqlData := 'update DO_FeedbackInvoricInfo set F_tiFKBZ = 0 where F_iSBID in (%s) ';
      DM_DataBase.ExecQuery(sSqlData,[sSBID])
    end;
    if Pos('����ʧ��',str) = 0 then
    begin
      DM_DataBase.ADO_FHFK.GotoBookmark(pBookMark);
      p_MessageBoxDlg(str);
      btn_cx.Click;
      Exit;
    end else
    begin
      DM_DataBase.ADO_FHFK.GotoBookmark(pBookMark);
      p_MessageBoxDlg(str);
      Exit;
    end;
  end;

end;

procedure TFra_FHFK.dbg_fhfkTitleClick(Column: TColumnEh);
var
  i: Integer;
  bFH: Boolean;
  pMark: Pointer;
begin
  if Column.Index = 0 then
  begin
    bFH := False;
    with DM_DataBase.ADO_FHFK do
    begin
      pMark := GetBookmark;
      FindFirst;
      for i := 0 to RecordCount -1 do
      begin
        if not FindField('XZ').AsBoolean then
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
        FindField('XZ').AsBoolean := bFH;
        if i< RecordCount -1 then
          FindNext;
      end;
      Post;
      GotoBookmark(pMark);
    end;
  end;
end;

procedure TFra_FHFK.edt_rjhdqExit(Sender: TObject);
begin
  if (Ti_TxtFilter(Sender).Text <> '') and (not IsNum(Ti_TxtFilter(Sender).Text)) then
  begin
    p_MessageBoxDlg('�ַ���Ч,����������!');
    Ti_TxtFilter(Sender).SetFocus;
  end;
end;

function TFra_FHFK.f_MakeAllow: Boolean;
var
  i: Integer;
  ADO_Rec: TADOQuery;
  sSqlData: string;
  iAllowID, iAllowCode: Integer;
begin
  if LoginData.m_iAllowCode >= 0 then
  begin
    iAllowCode := LoginData.m_iAllowCode;
    sSqlData := 'Select F_iID,F_sCode from Set_AllowInfo where F_tiStatus = 1 and F_sCode in (''%s'',''%s'',''%s'') order by F_iID';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[c_Allow_FHFK_OK,c_Allow_FHFK_QCDD,c_Allow_FHFK_CXFH],False);
    if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
    begin
      while not ADO_Rec.Eof do
      begin
        if ADO_Rec.FieldByName('F_sCode').AsString = c_Allow_FHFK_OK then
        begin
          iAllowID := ADO_Rec.FieldByName('F_iID').AsInteger;
          if 1 shl iAllowID or iAllowCode = iAllowCode then
          begin
            btn_ok.Enabled := True;
            btn_ok.Tag := c_Tag_MakeAllow;
          end else
          begin
            btn_ok.Enabled := False;
            btn_ok.Tag := 0;
          end;
        end else
        if ADO_Rec.FieldByName('F_sCode').AsString = c_Allow_FHFK_QCDD then
        begin
          iAllowID := ADO_Rec.FieldByName('F_iID').AsInteger;
          if 1 shl iAllowID or iAllowCode = iAllowCode then
          begin
            btn_qcdd.Enabled := True;
            btn_qcdd.Tag := c_Tag_MakeAllow;
          end else
          begin
            btn_qcdd.Enabled := False;
            btn_qcdd.Tag := 0;
          end;
        end else
        if ADO_Rec.FieldByName('F_sCode').AsString = c_Allow_FHFK_CXFH then
        begin
          iAllowID := ADO_Rec.FieldByName('F_iID').AsInteger;
          if 1 shl iAllowID or iAllowCode = iAllowCode then
          begin
            btn_cxfh.Enabled := True;
            btn_cxfh.Tag := c_Tag_MakeAllow;
          end else
          begin
            btn_cxfh.Enabled := False;
            btn_cxfh.Tag := 0;
          end;
        end;
        ADO_Rec.Next;
      end;
    end;
    if Assigned(ADO_Rec) then
      ADO_Rec.Free;
  end;
end;

function TFra_FHFK.f_SaveXQXX: Boolean;
var
  sOrderID,sOrderType,sCustomID,sSellID: string;
  sSqlData, sTMBZ, sZH, sRJHDQ, sRJHDZ: string;
  i,n: integer;
  ADO_Custom,ADO_Sell,ADO_Rec: TADOQuery;
  pBookmark: Pointer;
begin
  Result := False;
  with DM_DataBase do
  begin
    if ADO_fhfk.RecordCount > 0 then
    begin
      //mte_xqxx.FindFirst;
      sCustomID := '';
      sSellID := '';
      pBookmark := ADO_fhfk.GetBookmark;
      n := 0;
      ADO_fhfk.FindFirst;
      for i := 0 to ADO_fhfk.RecordCount -1 do
      begin
        if ADO_fhfk.FindField('XZ').AsBoolean then
        begin
          case ADO_fhfk.FindField('OrderType').AsInteger of
            0: sCustomID := sCustomID + ',' + ADO_fhfk.FindField('OrderID').AsString;
            1: sSellID := sSellID + ',' + ADO_fhfk.FindField('OrderID').AsString;
          end;
          inc(n);
        end;
        if i < ADO_fhfk.RecordCount -1 then
          ADO_fhfk.FindNext;
      end;
      if n = 0 then
      begin
        DM_DataBase.ADO_FHFK.GotoBookmark(pBookMark);
        p_MessageBoxDlg('��ѡ��Ҫ����Ķ���!');
        Exit;
      end;
      if sCustomID <> '' then
      begin
        sCustomID := Copy(sCustomID,2,Length(sCustomID));
      end else
        sCustomID := '-1';
      sSqlData := 'Select * from DO_CartonLableInfo where F_tiOrderType = 0 and F_iOrderID in (%s)';
      ADO_Custom := DM_DataBase.OpenQuery(sSqlData,[sCustomID]);
      if sSellID <> '' then
      begin
        sSellID := Copy(sCustomID,2,Length(sCustomID));
      end else
        sSellID := '-1';
      sSqlData := 'Select * from DO_CartonLableInfo where F_tiOrderType = 1 and F_iOrderID in (%s)';
      ADO_Sell := DM_DataBase.OpenQuery(sSqlData,[sSellID]);
      ADO_fhfk.FindFirst;
      for i := 0 to ADO_fhfk.RecordCount -1 do
      begin
        if ADO_fhfk.FindField('XZ').AsBoolean then
        begin
          //ADO_fhfk.Edit;
          //ADO_fhfk.FindField('XZ').AsBoolean := False;
          //ADO_fhfk.Post;
          case ADO_fhfk.FindField('OrderType').AsInteger of
            0:
              begin
                ADO_Custom.First;
                while not ADO_Custom.Eof do
                begin
                  if ADO_Custom.FieldByName('F_iOrderID').AsInteger = ADO_fhfk.FindField('OrderID').AsInteger then
                  begin
                    ADO_Custom.Edit;
                    //ADO_Custom.FieldByName('F_bRJBZ').AsBoolean := ADO_fhfk.FindField('RJBZ').AsBoolean;
                    //sZH := ADO_fhfk.FindField('ZH').AsString;
                    //sRJHDQ := ADO_fhfk.FindField('RJHDQ').AsString;
                    //sRJHDZ := ADO_fhfk.FindField('RJHDZ').AsString;
                    //ADO_Custom.FieldByName('F_sRJHD').AsString := p_GetRJHD(sZH,sRJHDQ,sRJHDZ);
                    //ADO_Custom.FieldByName('F_sZH').AsString := ADO_fhfk.FindField('ZH').AsString;
                    //ADO_Custom.FieldByName('F_sRJHDQ').AsString := ADO_fhfk.FindField('RJHDQ').AsString;
                    //ADO_Custom.FieldByName('F_sRJHDZ').AsString := ADO_fhfk.FindField('RJHDZ').AsString;
                    //ADO_Custom.FieldByName('F_nYL').AsFloat := ADO_fhfk.FindField('YL').AsFloat;
                    //ADO_Custom.FieldByName('F_iCXSL').AsInteger := ADO_fhfk.FindField('CXSL').AsInteger;
                    //ADO_Custom.FieldByName('F_iCBSL').AsInteger := ADO_fhfk.FindField('CBSL').AsInteger;
                    //ADO_Custom.FieldByName('F_iZXS').AsInteger := ADO_fhfk.FindField('ZXS').AsInteger;
                    //if  Trim(sTMBZ) = 'ö' then
                    //  ADO_Custom.FieldByName('F_tiTMBZ').AsInteger := 0
                    //else if  Trim(sTMBZ) = '��' then
                    //  ADO_Custom.FieldByName('F_tiTMBZ').AsInteger := 1;
                    //ADO_Custom.FieldByName('F_nFJGYF').AsFloat := ADO_fhfk.FindField('FJGYF').AsFloat;
                    ADO_Custom.FieldByName('F_sYSDH').AsString := ADO_fhfk.FindField('F_sYSDH').AsString;
                    ADO_Custom.FieldByName('F_sFHFS').AsString := ADO_fhfk.FindField('F_sFHFS').AsString;
                    ADO_Custom.FieldByName('F_sBZ').AsString := ADO_fhfk.FindField('F_sBZ').AsString;
                    //ADO_Custom.FieldByName('F_iStatus').AsInteger := 0;
                    ADO_Custom.Post;
                   { p_WriteGroup(ADO_Custom.FieldByName('F_iID').AsInteger,
                      ADO_Custom.FieldByName('F_iOrderID').AsInteger,ADO_Custom.FieldByName('F_tiOrderType').AsInteger,
                      ADO_Custom.FieldByName('F_sZH').AsString,ADO_Custom.FieldByName('F_sRJHDQ').AsString,
                      ADO_Custom.FieldByName('F_sRJHDZ').AsString);   }
                    Break;
                  end;
                  ADO_Custom.Next;
                end;
                if ADO_Custom.Eof then
                begin
                  ADO_Custom.Insert;
                  ADO_Custom.FieldByName('F_iOrderID').AsInteger := ADO_fhfk.FindField('OrderID').AsInteger;
                  ADO_Custom.FieldByName('F_tiOrderType').AsInteger := ADO_fhfk.FindField('OrderType').AsInteger;
                  //ADO_Custom.FieldByName('F_bRJBZ').AsBoolean := ADO_fhfk.FindField('RJBZ').AsBoolean;
                  //sZH := ADO_fhfk.FindField('ZH').AsString;
                  //sRJHDQ := ADO_fhfk.FindField('RJHDQ').AsString;
                  //sRJHDZ := ADO_fhfk.FindField('RJHDZ').AsString;
                  //ADO_Custom.FieldByName('F_sRJHD').AsString := p_GetRJHD(sZH,sRJHDQ,sRJHDZ);
                  //ADO_Custom.FieldByName('F_sZH').AsString := ADO_fhfk.FindField('ZH').AsString;
                  //ADO_Custom.FieldByName('F_sRJHDQ').AsString := ADO_fhfk.FindField('RJHDQ').AsString;
                  //ADO_Custom.FieldByName('F_sRJHDZ').AsString := ADO_fhfk.FindField('RJHDZ').AsString;
                  //ADO_Custom.FieldByName('F_nYL').AsFloat := ADO_fhfk.FindField('YL').AsFloat;
                  //ADO_Custom.FieldByName('F_iCXSL').AsInteger := ADO_fhfk.FindField('CXSL').AsInteger;
                  //ADO_Custom.FieldByName('F_iZXS').AsInteger := ADO_fhfk.FindField('ZXS').AsInteger;
                  //if  Trim(sTMBZ) = 'ö' then
                  //  ADO_Custom.FieldByName('F_tiTMBZ').AsInteger := 0
                  //else if  Trim(sTMBZ) = '��' then
                  //  ADO_Custom.FieldByName('F_tiTMBZ').AsInteger := 1;
                  //ADO_Custom.FieldByName('F_nFJGYF').AsFloat := ADO_fhfk.FindField('FJGYF').AsFloat;
                  ADO_Custom.FieldByName('F_sYSDH').AsString := ADO_fhfk.FindField('F_sYSDH').AsString;
                  ADO_Custom.FieldByName('F_sFHFS').AsString := ADO_fhfk.FindField('F_sFHFS').AsString;
                  ADO_Custom.FieldByName('F_sBZ').AsString := ADO_fhfk.FindField('F_sBZ').AsString;
                  //ADO_Custom.FieldByName('F_iStatus').AsInteger := 0;
                  ADO_Custom.Post;
                   { p_WriteGroup(ADO_Custom.FieldByName('F_iID').AsInteger,
                      ADO_Custom.FieldByName('F_iOrderID').AsInteger,ADO_Custom.FieldByName('F_tiOrderType').AsInteger,
                      ADO_Custom.FieldByName('F_sZH').AsString,ADO_Custom.FieldByName('F_sRJHDQ').AsString,
                      ADO_Custom.FieldByName('F_sRJHDZ').AsString);    }
                end;
              end;
            1:
              begin
                ADO_Sell.First;
                while not ADO_Sell.Eof do
                begin
                  if ADO_Sell.FieldByName('F_iOrderID').AsInteger = ADO_fhfk.FindField('OrderID').AsInteger then
                  begin
                    ADO_Sell.Edit;
                    //ADO_Sell.FieldByName('F_bRJBZ').AsInteger := ADO_fhfk.FindField('RJBZ').AsInteger;
                    //sZH := ADO_fhfk.FindField('ZH').AsString;
                    //sRJHDQ := ADO_fhfk.FindField('RJHDQ').AsString;
                    //sRJHDZ := ADO_fhfk.FindField('RJHDZ').AsString;
                    //ADO_Sell.FieldByName('F_sRJHD').AsString := p_GetRJHD(sZH,sRJHDQ,sRJHDZ);
                    //ADO_Sell.FieldByName('F_sZH').AsString := ADO_fhfk.FindField('ZH').AsString;
                    //ADO_Sell.FieldByName('F_sRJHDQ').AsString := ADO_fhfk.FindField('RJHDQ').AsString;
                    //ADO_Sell.FieldByName('F_sRJHDZ').AsString := ADO_fhfk.FindField('RJHDZ').AsString;
                    //ADO_Sell.FieldByName('F_nYL').AsFloat := ADO_fhfk.FindField('YL').AsFloat;
                    //ADO_Sell.FieldByName('F_iCXSL').AsInteger := ADO_fhfk.FindField('CXSL').AsInteger;
                    //ADO_Sell.FieldByName('F_iCBSL').AsInteger := ADO_fhfk.FindField('CBSL').AsInteger;
                    //ADO_Sell.FieldByName('F_iZXS').AsInteger := ADO_fhfk.FindField('ZXS').AsInteger;
                    //if  Trim(sTMBZ) = 'ö' then
                    //  ADO_Sell.FieldByName('F_tiTMBZ').AsInteger := 0
                    //else if  Trim(sTMBZ) = '��' then
                    //  ADO_Sell.FieldByName('F_tiTMBZ').AsInteger := 1;
                    //ADO_Sell.FieldByName('F_nFJGYF').AsFloat := ADO_fhfk.FindField('FJGYF').AsFloat;
                    ADO_Sell.FieldByName('F_sYSDH').AsString := ADO_fhfk.FindField('F_sYSDH').AsString;
                    ADO_Sell.FieldByName('F_sFHFS').AsString := ADO_fhfk.FindField('F_sFHFS').AsString;
                    ADO_Sell.FieldByName('F_sBZ').AsString := ADO_fhfk.FindField('F_sBZ').AsString;
                    //ADO_Sell.FieldByName('F_iStatus').AsInteger := 0;
                    ADO_Sell.Post;
                   { p_WriteGroup(ADO_Sell.FieldByName('F_iID').AsInteger,
                      ADO_Sell.FieldByName('F_iOrderID').AsInteger,ADO_Sell.FieldByName('F_tiOrderType').AsInteger,
                      ADO_Sell.FieldByName('F_sZH').AsString,ADO_Sell.FieldByName('F_sRJHDQ').AsString,
                      ADO_Sell.FieldByName('F_sRJHDZ').AsString);    }
                    Break;
                  end;
                  ADO_Sell.Next;
                end;
                if ADO_Sell.Eof then
                begin
                  ADO_Sell.Insert;
                  ADO_Sell.FieldByName('F_iOrderID').AsInteger := ADO_fhfk.FindField('OrderID').AsInteger;
                  ADO_Sell.FieldByName('F_tiOrderType').AsInteger := ADO_fhfk.FindField('OrderType').AsInteger;
                  //ADO_Sell.FieldByName('F_bRJBZ').AsInteger := ADO_fhfk.FindField('RJBZ').AsInteger;
                  //sZH := ADO_fhfk.FindField('ZH').AsString;
                  //sRJHDQ := ADO_fhfk.FindField('RJHDQ').AsString;
                  //sRJHDZ := ADO_fhfk.FindField('RJHDZ').AsString;
                  //ADO_Sell.FieldByName('F_sRJHD').AsString := p_GetRJHD(sZH,sRJHDQ,sRJHDZ);
                  //ADO_Sell.FieldByName('F_sZH').AsString := ADO_fhfk.FindField('ZH').AsString;
                  //ADO_Sell.FieldByName('F_sRJHDQ').AsString := ADO_fhfk.FindField('RJHDQ').AsString;
                  //ADO_Sell.FieldByName('F_sRJHDZ').AsString := ADO_fhfk.FindField('RJHDZ').AsString;
                  //ADO_Sell.FieldByName('F_nYL').AsFloat := ADO_fhfk.FindField('YL').AsFloat;
                  //ADO_Sell.FieldByName('F_iCXSL').AsInteger := ADO_fhfk.FindField('CXSL').AsInteger;
                  //ADO_Sell.FieldByName('F_iCBSL').AsInteger := ADO_fhfk.FindField('CBSL').AsInteger;
                  //ADO_Sell.FieldByName('F_iZXS').AsInteger := ADO_fhfk.FindField('ZXS').AsInteger;
                  //if  Trim(sTMBZ) = 'ö' then
                  //  ADO_Sell.FieldByName('F_tiTMBZ').AsInteger := 0
                  //else if  Trim(sTMBZ) = '��' then
                  //  ADO_Sell.FieldByName('F_tiTMBZ').AsInteger := 1;
                  //ADO_Sell.FieldByName('F_nFJGYF').AsFloat := ADO_fhfk.FindField('FJGYF').AsFloat;
                  ADO_Sell.FieldByName('F_sYSDH').AsString := ADO_fhfk.FindField('F_sYSDH').AsString;
                  ADO_Sell.FieldByName('F_sFHFS').AsString := ADO_fhfk.FindField('F_sFHFS').AsString;
                  ADO_Sell.FieldByName('F_sBZ').AsString := ADO_fhfk.FindField('F_sBZ').AsString;
                  //ADO_Sell.FieldByName('F_iStatus').AsInteger := 0;
                  ADO_Sell.Post;
                  {p_WriteGroup(ADO_Sell.FieldByName('F_iID').AsInteger,
                    ADO_Sell.FieldByName('F_iOrderID').AsInteger,ADO_Sell.FieldByName('F_tiOrderType').AsInteger,
                    ADO_Sell.FieldByName('F_sZH').AsString,ADO_Sell.FieldByName('F_sRJHDQ').AsString,
                    ADO_Sell.FieldByName('F_sRJHDZ').AsString);   }
                end;
              end;
          end;
        end;
        if i < ADO_fhfk.RecordCount -1 then
          ADO_fhfk.FindNext;
      end;
      ADO_Custom.Free;
      ADO_Sell.Free;
      ADO_fhfk.GotoBookmark(pBookmark);
    end;
  end;
  Result := True;
end;

procedure TFra_FHFK.btn_SaveClick(Sender: TObject);
begin
  if not f_SaveXQXX then
  begin
    p_MessageBoxDlg('�������!');
    Exit;
  end;
end;

function TFra_FHFK.f_ErrorCodeToStr(iRec: integer): string;
begin
  Result := '';
  case iRec of
    1 : Result := '��Ʒӡ��Ϊ0';
    2 : Result := '��Ʒ�����������ܴ���ӡ��';
    3 : Result := '�ܷ����������ܴ�����ӡ��';
    4 : Result := 'û���ҵ���Ʒ�걨��Ҫ����Ϣ';
    5 : Result := '��ѯ��Ʒ��Ϣ����';
    6 : Result := '������δ������������Ӧ��������';
    7 : Result := '�����ӿں�������';
    8 : Result := '��½������ӡ����ҵ';
    9 : Result := '������λ������';
    10: Result := '�������е����ں�����';
    11: Result := '�������еĶ���ID����';
    12: Result := '�������е�ģʽ��־����';
    13: Result := '�����Ͳ�Ʒ�ĳɰ����������ܹ���������������';
    14: Result := '���׷��������������ܹ������������';
    15: Result := '��ƷΪ��ö�����ܰ���';
    16: Result := '�������е�������������';
    17: Result := '����ID��Ϊ0�������������ѷ��������ܽ��в���';
    18: Result := 'ע����־���󣬴����������ѷ��������ܽ��в���';
    19: Result := '����ID��Ϊ0�������ѷ��������ܽ��в���';
    20: Result := 'ע����־���󣬴����ѷ��������ܽ��в���';
    22: Result := '�������ظ������ܽ��в���';
    23: Result := '�������жҽ����룬����ɾ��֮ǰ�Ķҽ�����';
    24: Result := '�����������';
    25: Result := '��ʼ������������';
    26: Result := '��ֹ������������';
    27: Result := '�Ǳ�ӡ�������';
    28: Result := '�˶ҽ�������ʹ�ã������ٴ�ʹ��';
    29: Result := '���뷢������';
    30: Result := '��ԭ���ҽ�����Ϊδʹ�ã���������';
    31: Result := '����ҽ����뷢������';
    32: Result := '���뷢������������';
    33: Result := '��ӡ����ҵ�����ܽ��в���';
    34: Result := '�˲�Ʒ�ڼ���δ�ջ������ܷ���';
    35: Result := 'û�з�������';
    36: Result := '����Ҫͼ��ϸ񣬲��ܽ��з���';
    37: Result := '����Ҫ��ǩ�������ܽ��з���';
    38: Result := '����Ҫ��ǩ�������ܽ��з���';
    39: Result := '���⹤�շ���������';
    40: Result := 'ӡ������������Ʒ����';
    41: Result := '����Ҫͼ��ϸ񣬲��ܽ��з���';
    42: Result := '����Ҫ��ǩ�������ܽ��з���';
    43: Result := '����Ҫ��ǩ�������ܽ��з���';
    44: Result := '��������Э���ܲ��ַ���';
    45: Result := '����ö����������';
    46: Result := '����������������ӡ��';
    47: Result := '�Ǳ�ӡ������';
    48: Result := 'û������,��������';
    49: Result := 'ȡ��ƷĿ¼��������д���';
    50: Result := '��Ʒδ���������ܽ��г����';
    51: Result := '�õ��Ѿ������ĳ��������ܷ���';
    52: Result := '�õ����������ĳ��������ܷ���';
    53: Result := '�ջ�����Ϣ����';
    54: Result := '����������';
    55: Result := '��Ƭ������Ƭ״̬��Ϣ����';
    56: Result := '������������';
    57: Result := '����д������ԭ��';
    58: Result := '�������Ͳ����ڣ�������ѡ��';
    59: Result := '�ؿ����Ʒ����¼��ҽ�����';
    60: Result := '�޷������걨��ˮ��״̬����';
    61: Result := '�޷�����Ҫ����ϸ��״̬����';
    62: Result := 'û���ҵ�ӡ����ҵ���';
    63: Result := '�޷�����״̬����';
    64: Result := 'ÿö�ķ���������ӡ������';
    65: Result := 'ÿö�ķ���������ӡ������';
    66: Result := '��ȫ�������������в���δ���������жҽ����룬����ɾ���ҽ�����';
    67: Result := 'ȡ��ƷĿ¼��������д���';
    68: Result := 'ÿ��ķ����������ܴ��ڲ�Ʒӡ��';
    69: Result := '�Ǳ�ӡ������';
    70: Result := 'ȡ����ͼ��Ϣ����';
	  71: Result := '��Ӱ����Ϣ����';
	  72: Result := '������Ϣ����';
    73: Result := ' ���ܲ����ظ���¼';

    99: Result := '��������������';
  else
    Result := IntToStr(iRec);
  end
end;

procedure TFra_FHFK.btn_qcddClick_old(Sender: TObject);
var
  ADO_Rec, ADO_Save, ADO_Temp: TADOQuery;
  sSqlData, sLableInfoID, str: string;
  obj: PostServicePortType;
  nYL: Real;
  i, j, n, iFeedbackID, iLableInfoID, iOrderID, iOrderType, iRec: Integer;
  sProductCode, sOutCode,sZOutCode, sJiangCode, sOutWay, sOverDate, sTXM, sBZ: string;
  sCPBH,sALLCPBH: string;
  iDfbbz, iType, iSBID, iTao, iOut, iOutNum, iZXS, iCBSL, iZMS, iCXSL: Integer;
  iApartCount, iXH, iPackages, iPackageID, iTempNum: Integer;
  pBookMark: Pointer;
  sYSDH: string;
begin
  str := '';
  with DM_DataBase do
  begin
    pBookMark := ADO_FHFK.GetBookmark;
    if ADO_FHFK.RecordCount > 0 then
    begin
      sLableInfoID := '';
      sCPBH := '';
      n := 0;
      ADO_FHFK.FindFirst;
      for i := 0 to ADO_FHFK.RecordCount -1 do
      begin
        if ADO_FHFK.FindField('XZ').AsBoolean then
        begin
          sLableInfoID := sLableInfoID + ',' + ADO_FHFK.FindField('LableInfoID').AsString;
          str := ADO_FHFK.FindField('F_sCPBH').AsString;
          if Copy(str,1,1)= '*' then
            sCPBH := sCPBH + ',' + Copy(str,2,Length(str));
          sALLCPBH := sALLCPBH+','+str;
          inc(n);
        end;
        if i < ADO_FHFK.RecordCount -1 then
          ADO_FHFK.FindNext;
      end;
      if n = 0 then
      begin
        DM_DataBase.ADO_FHFK.GotoBookmark(pBookMark);
        p_MessageBoxDlg('��ѡ��Ҫ�����Ķ���!');
        Exit;
      end;
      if sLableInfoID <> '' then
      begin
        sLableInfoID := Copy(sLableInfoID,2,Length(sLableInfoID));
      end else
        sLableInfoID := '-1';
    end;
  end;
  if sALLCPBH <> '' then
    sALLCPBH := Copy(sALLCPBH,2,Length(sALLCPBH));
  DM_DataBase.ADO_FHFK.GotoBookmark(pBookMark);
  if p_MessageBoxDlg(sALLCPBH+' �����Ƿ���ȷ���ڹ�����������������?','��ʾ',MB_ICONINFORMATION+ MB_YESNO) = IDNO then
  begin
    Exit;
  end;
  //�ж��Ƿ�ֻ�в��ַ���
  if sCPBH <> '' then
  begin
    sCPBH := Copy(sCPBH,2,Length(sCPBH));
    DM_DataBase.ADO_FHFK.GotoBookmark(pBookMark);
    if p_MessageBoxDlg(sCPBH+' ����ֻ�в��ַ���,�Ƿ��������?','��ʾ',MB_ICONINFORMATION+ MB_YESNO) = IDNO then
    begin
      Exit;
    end;
  end;
  if not f_SaveXQXX then
  begin
    p_MessageBoxDlg('�������!');
    Exit;
  end;
   //�ж��Ƿ�ֻ�в��ַ���.�����
{  sSqlData := 'select a. from DO_CartonLableInfo a where exists(select 1 form DO_OrderApart b,BI_InventoryManagement c '
    +' where a.F_iOrderID=b.F_iOrderID and a.F_tiOrderType=b.F_tiOrderType and b.F_iID=c.F_iApartID and c.F_iSL > F_iFHSL and a.F_iID in (%s) ) ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sLableInfoID]);
  str := '';
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount>0) then
  begin

  end;    }
  sSqlData := 'Select *,ZMS=F_nYL*10000 from DO_CartonLableInfo where F_iID in (%s) ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sLableInfoID]);
  sSqlData := 'Select * from DO_FeedbackInvoricInfo where 1=2 ';
  ADO_Save := DM_DataBase.OpenQuery(sSqlData,[sProductCode]);
  DM_DataBase.ADO_FHFK.FindFirst;
  for i := 0 to DM_DataBase.ADO_FHFK.RecordCount -1 do
  begin
    if DM_DataBase.ADO_FHFK.FindField('XZ').AsBoolean then
    begin
      iDfbbz := DM_DataBase.ADO_FHFK.FieldByName('F_tiDfbbz').AsInteger;
      iSBID := DM_DataBase.ADO_FHFK.FieldByName('SBID').AsInteger;
      iLableInfoID := DM_DataBase.ADO_FHFK.FieldByName('LableInfoID').AsInteger;
      if iDfbbz = 0 then
        iType := DM_DataBase.ADO_FHFK.FieldByName('OrderType').AsInteger
      else
        iType := 1;
//      sProductCode := DM_DataBase.ADO_FHFK.FieldByName('F_sCPBH').AsString;
      sZOutCode := DM_DataBase.ADO_FHFK.FieldByName('F_sYSDH').AsString;
      sOverDate := FormatDateTime('yyyy-MM-dd',dtp_fhrq.DateTime);
      with ADO_Rec do
      begin
        First;
        while not Eof do
        begin
          if FieldByName('F_iID').AsInteger <> iLableInfoID then
          begin
            Next;
            Continue;
          end;
//          iLableInfoID := FieldByName('F_iID').AsInteger;
          iOrderID := FieldByName('F_iOrderID').AsInteger;
          iOrderType := FieldByName('F_tiOrderType').AsInteger;
          iTao := FieldByName('F_tiTMBZ').AsInteger;
          iOut := iif(cbb_fhbz.ItemIndex=2,0,cbb_fhbz.ItemIndex);
          iZXS := FieldByName('F_iZXS').AsInteger;
          sOutWay := FieldByName('F_sFHFS').AsString;
          iZMS := FieldByName('ZMS').AsInteger;
          iCBSL := FieldByName('F_iCBSL').AsInteger;
          iCXSL := FieldByName('F_iCXSL').AsInteger;
          sBZ := FieldByName('F_sBZ').AsString;
          sSqlData := 'select count(F_iID) ApartCount from DO_OrderApart where F_iOrderID=%d and F_tiOrderType=%d and F_tiNjbz=0 and F_tiCXBZ = 0 ';
          ADO_Temp  := DM_DataBase.OpenQuery(sSqlData,[iOrderID,iOrderType]);
          iApartCount := 0;
          if Assigned(ADO_Temp) and (ADO_Temp.RecordCount > 0) then
          begin
            iApartCount := ADO_Temp.FieldByName('ApartCount').AsInteger;
          end;
          ADO_Temp.Free;
          iXH := 0;
          f_SetArrJiangCode(iOrderID,iOrderType);
          sTXM := FieldByName('F_sTXM').AsString;
          if sTXM= '' then
          begin
            sTXM := f_GetTXM(iOrderID,iOrderType,iTao);
            //sTXM := IntToStr(iType)+StrRight('0000000000'+IntToStr(iSBID),10)+StrRight(sProductCode,3)+StrRight('00000'+IntToStr(j),5) + StrRight(sTXM,4);
          end;
          for j := 1 to  iZXS do
          begin
            sProductCode := DM_DataBase.ADO_FHFK.FieldByName('F_sCPBH').AsString;
            if Copy(sProductCode,1,1) = '*' then
              sProductCode := Copy(sProductCode,2,Length(sProductCode));
            //sJiangCode := FieldByName('F_sRJHD').AsString;
            //sTXM := StrLeft(sTXM,11)+StrRight(sProductCode,3)+StrRight('00000'+IntToStr(j),5) + StrRight(sTXM,4);
            sTXM := StrLeft(sTXM,14)+StrRight('00000'+IntToStr(j),5) + StrRight(sTXM,4);
            sOutCode:=PosCopy(sZOutCode,';',j);
            if (StrRight(sProductCode,3)='999') then
            begin
              iPackages :=  iZXS div iApartCount;
              if iZXS mod iApartCount > 0 then
              begin
                iPackages := iPackages + 1;
              end;
              if iTao=1 then
              begin
                iPackages := iZXS;
              end;
              iPackageID := j mod iPackages;
              if j mod iPackages =0  then
                iPackageID := iPackages;
              iTempNum := ((j-1) div iPackages) + 1;
              case iTao of
                0:
                  begin
                    sProductCode := Copy(sProductCode,1,Length(sProductCode)-3)+copy(sTXM,12,1)+StrRight('00'+IntToStr(iTempNum),2);
                    //���������Ű�����β����
                   // sTXM := StrLeft(sTXM,11)+StrRight('000'+IntToStr(iTempNum),3)+StrRight('00000'+IntToStr(iPackageID),5) + StrRight(sTXM,4);
                   //���������Ű�˳����
                    sTXM := StrLeft(sTXM,12)+StrRight('00'+IntToStr(iTempNum),2)+StrRight('00000'+IntToStr(j),5) + StrRight(sTXM,4);
                  end;
                1:
                  begin
                    sTXM := StrLeft(sTXM,11)+'999' + StrRight(sTXM,9);
                  end;
              end;
              if j mod iPackages = 0 then
              begin
                if iTao = 1 then
                  iOutNum := iZMS - iCXSL * (iPackages-1)
                else
                  iOutNum := iZMS div iApartCount - iCXSL * (iPackages-1);
              end else
                iOutNum := iCXSL;
            end else
            begin
              sProductCode := StrLeft(sProductCode,Length(sProductCode)-3)+Copy(sTXM,12,3);
              iOutNum := iCXSL;
              if j = iZXS then
              begin
                iOutNum := iZMS - iCXSL*(iZXS-1)
              end;
            end;
            sJiangCode := f_GetJiangCode(iXH, iOutNum);
            sYSDH := f_GetFYDH(sTXM);
            if sYSDH <> '' then
              sOutCode := sYSDH;
            with ADO_Save do
            begin
              try
                Insert;
                FieldByName('F_tiType').AsInteger := iType;
                FieldByName('F_iSBID').AsInteger := iSBID;
                FieldByName('F_sProductCode').AsString := sProductCode;
                FieldByName('F_tiTao').AsInteger := iTao;
                FieldByName('F_tiOut').AsInteger := iOut;
                FieldByName('F_sOutCode').AsString := sOutCode;
                FieldByName('F_sJiangCode').AsString := sJiangCode;
                FieldByName('F_sOutWay').AsString := sOutWay;
                FieldByName('F_dOverDate').AsDateTime := dtp_fhrq.DateTime;
                FieldByName('F_iOutNum').AsInteger := iOutNum;
                FieldByName('F_sTXM').AsString := sTXM;
                FieldByName('F_iZXS').AsInteger := iZXS;
                FieldByName('F_iCBSL').AsInteger := iCBSL;
                FieldByName('F_iCXSL').AsInteger := iCXSL;
                FieldByName('F_sBZ').AsString := sBZ;
                FieldByName('F_iOrderID').AsInteger := iOrderID;
                FieldByName('F_tiOrderType').AsInteger := iOrderType;
                FieldByName('F_tiFKBZ').AsInteger := 10;
                FieldByName('F_iErrorCode').AsInteger := 1000;
                FieldByName('F_sFKR').AsString := LoginData.m_sUserName;
                Post;
                iFeedbackID := FieldByName('F_iID').AsInteger;
              except
                on E: Exception do
                begin
                  Application.MessageBox(PChar('����:'+E.message),'��ʾ',MB_ICONINFORMATION);
                  break;
                end;

              end;
            end;
          end;
          break;
        end;
      end;
    end;
    if i < DM_DataBase.ADO_FHFK.RecordCount -1 then
      DM_DataBase.ADO_FHFK.FindNext;
  end;
  ADO_Rec.Free;
  ADO_Save.Free;
  DM_DataBase.ADO_FHFK.GotoBookmark(pBookMark);
  p_MessageBoxDlg('�����ɹ�');
  btn_cx.Click;

end;

procedure TFra_FHFK.cb_fjrqClick(Sender: TObject);
begin
  dtp_fkrqq.Enabled := TRzCheckBox(Sender).Checked;
  dtp_fkrqz.Enabled := TRzCheckBox(Sender).Checked;
end;

procedure TFra_FHFK.cbb_fhbzChange(Sender: TObject);
begin
  case cbb_fhbz.ItemIndex of
    0:
      begin
        cb_fjrq.Enabled := False;
        cb_fjrq.Checked := False;
        dtp_fkrqq.Enabled := False;
        dtp_fkrqz.Enabled := False;
      end;
    1:
      begin
        cb_fjrq.Enabled := True;
        cb_fjrq.Checked := True;
        dtp_fkrqq.Enabled := True;
        dtp_fkrqz.Enabled := True;
      end;
    2:
      begin
        cb_fjrq.Enabled := True;
        cb_fjrq.Checked := True;
        dtp_fkrqq.Enabled := True;
        dtp_fkrqz.Enabled := True;
      end;
  end;

end;

procedure TFra_FHFK.btn_qcddMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  p: TPoint;
begin
  GetCursorPos(p);
  application.ActivateHint(point(p.x,p.y));
end;

procedure TFra_FHFK.btn_cxfhClick(Sender: TObject);
var
  sSqlData, str, sSBID: string;
  obj: PostServicePortType;
  i, n, iRec: Integer;
  sCPBH: string;
  iDfbbz, iType, iSBID: Integer;
  pBookMark: Pointer;

begin
  str := '';
  with DM_DataBase do
  begin
    pBookMark := ADO_FHFK.GetBookmark;
    if ADO_FHFK.RecordCount > 0 then
    begin
      sCPBH := '';
      n := 0;
      ADO_FHFK.FindFirst;
      for i := 0 to ADO_FHFK.RecordCount -1 do
      begin
        if ADO_FHFK.FindField('XZ').AsBoolean then
        begin
          str := ADO_FHFK.FindField('F_sCPBH').AsString;
          if Copy(str,1,1)= '*' then
            sCPBH := sCPBH + ',' + Copy(str,2,Length(str));
          //if Trim(ADO_FHFK.FindField('TGZT').AsString) <> '' then
          //  sTGZT := sTGZT + str + '  ' + ADO_FHFK.FindField('TGZT').AsString+#13#10;
          inc(n);
        end;
        if i < ADO_FHFK.RecordCount -1 then
          ADO_FHFK.FindNext;
      end;
      if n = 0 then
      begin
        DM_DataBase.ADO_FHFK.GotoBookmark(pBookMark);
        p_MessageBoxDlg('��ѡ��Ҫ�������������Ķ���!');
        Exit;
      end;
    end;
  end;

  obj := GetPostServicePortType(true,uMain.vUrl, nil);
  if obj = nil then
  begin
    p_MessageBoxDlg('��������ʧ��,�����Ƿ���Է�������!!!');
    exit;
  end;
  DM_DataBase.ADO_FHFK.First;
  str := '';
  sSBID := '';
  for i := 0 to DM_DataBase.ADO_FHFK.RecordCount -1 do
  begin
    if DM_DataBase.ADO_FHFK.FindField('XZ').AsBoolean then
    begin
      iDfbbz := DM_DataBase.ADO_FHFK.FieldByName('F_tiDfbbz').AsInteger;
      iSBID := DM_DataBase.ADO_FHFK.FieldByName('SBID').AsInteger;
      sCPBH := DM_DataBase.ADO_FHFK.FindField('F_sCPBH').AsString;
      if iDfbbz = 0 then
        iType := DM_DataBase.ADO_FHFK.FieldByName('OrderType').AsInteger
      else
        iType := 1;
      iRec := obj.setCXFH(c_Web_UserName, c_Web_UserPwd,iType,IntToStr(iSBID));
      if iRec = 0 then
      begin
        sSBID := sSBID + ',' + IntToStr(iSBID);
        str := str + sCPBH + ' �������������ɹ�!'+#13#10;
      end else
      begin
        str := str + sCPBH + ' ������������ʧ��!'+#13#10;

      end;
    end;
    if i < DM_DataBase.ADO_FHFK.RecordCount -1 then
      DM_DataBase.ADO_FHFK.FindNext;
  end;
  if (Pos('�������������ɹ�',str)>0) and (sSBID<> '') then
  begin
    sSBID := Copy(sSBID,2,Length(sSBID));
    sSqlData := 'update DO_FeedbackInvoricInfo set F_tiFKBZ = 0 where F_iSBID in (%s) ';
    DM_DataBase.ExecQuery(sSqlData,[sSBID])
  end;
  if Pos('������������ʧ��',str) = 0 then
  begin
    DM_DataBase.ADO_FHFK.GotoBookmark(pBookMark);
    p_MessageBoxDlg(str);
    btn_cx.Click;
    Exit;
  end else
  begin
    DM_DataBase.ADO_FHFK.GotoBookmark(pBookMark);
    p_MessageBoxDlg(str);
    Exit;
  end;
end;

function TFra_FHFK.f_GetJiangCode(var _XH: Integer; SYSL: Integer): string;
begin
  Result := '';
  while 1=1 do
  begin
    if _XH >= Length(aJiangCode) then Break;
    while ((aJiangCode[_XH].m_sZH = '') or (aJiangCode[_XH].m_iRJHDQ = 0) or (aJiangCode[_XH].m_iRJHDZ = 0))
      and  (_XH < Length(aJiangCode)) do
    begin
      Inc(_XH);
    end;
    if _XH >= Length(aJiangCode) then Break;
    while (aJiangCode[_XH].m_iRJHDZ - aJiangCode[_XH].m_iRJHDQ +1 <= SYSL) and (_XH < Length(aJiangCode)) do
    begin
      Result := Result + aJiangCode[_XH].m_sZH +','+StrRight('000000'+IntToStr (aJiangCode[_XH].m_iRJHDQ),6) +','
        + StrRight('000000'+IntToStr(aJiangCode[_XH].m_iRJHDZ),6)+';';
      SYSL := SYSL - (aJiangCode[_XH].m_iRJHDZ- aJiangCode[_XH].m_iRJHDQ +1);
      Inc(_XH);
    end;
    if aJiangCode[_XH].m_iRJHDZ - aJiangCode[_XH].m_iRJHDQ +1 > SYSL then
    begin
      if SYSL >0 then
      begin
        Result := Result + aJiangCode[_XH].m_sZH +','+StrRight('000000'+IntToStr (aJiangCode[_XH].m_iRJHDQ),6) +','
          + StrRight('000000'+IntToStr (aJiangCode[_XH].m_iRJHDQ + SYSL-1),6)+';';
        aJiangCode[_XH].m_iRJHDQ := aJiangCode[_XH].m_iRJHDQ + SYSL;
      end;
      Break;
    end;

  end;

end;

function TFra_FHFK.f_SetArrJiangCode(OrderID, OrderType: Integer): Boolean;
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
  n: integer;
begin
  Result := False;
  n := 0;
  SetLength(aJiangCode,n);
  sSqlData := 'Select a.F_sZH,a.F_sRJHDQ,a.F_sRJHDZ from DO_CartonLableGroupNum a,DO_CartonLableInfo b '
    + ' where a.F_iCartonInfoID=b.F_iID and b.F_iOrderID=%d and b.F_tiOrderType=%d order by a.F_sZH,case when a.F_sRJHDQ=''000000'' then ''999999'' else a.F_sRJHDQ end ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[OrderID,OrderType]);
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    while not ADO_Rec.Eof do
    begin
      if (ADO_Rec.FieldByName('F_sZH').AsString <> '') and (ADO_Rec.FieldByName('F_sRJHDQ').AsString <>'')
        and (ADO_Rec.FieldByName('F_sRJHDZ').AsString <> '') then
      begin
        SetLength(aJiangCode,n+1);
        aJiangCode[n].m_sZH := ADO_Rec.FieldByName('F_sZH').AsString;
        if ADO_Rec.FieldByName('F_sRJHDQ').AsString = '000000' then
          aJiangCode[n].m_iRJHDQ := 1000000
        else
          aJiangCode[n].m_iRJHDQ := StrToNum(ADO_Rec.FieldByName('F_sRJHDQ').AsString);
        if ADO_Rec.FieldByName('F_sRJHDZ').AsString = '000000' then
          aJiangCode[n].m_iRJHDZ := 1000000
        else
          aJiangCode[n].m_iRJHDZ := StrToNum(ADO_Rec.FieldByName('F_sRJHDZ').AsString);
        inc(n);
      end;
      ADO_Rec.Next;
    end;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

  Result := True;
end;

procedure TFra_FHFK.btn_exportClick(Sender: TObject);
begin
  if SavePath.Execute then
  begin
    if (SavePath.FileName <> '') then
      if UpperCase(Copy(SavePath.FileName,Length(SavePath.FileName)-4,Length(SavePath.FileName))) = UpperCase('.xls') then
        SavePath.FileName := Copy(SavePath.FileName,1,Length(SavePath.FileName)-4);
    Screen.Cursor := crHourGlass;
    try
      SaveDBGridEhToExportFile(TDBGridEhExportAsXLS,dbg_fhfk, SavePath.FileName,True);
    except

    end;                
    Screen.Cursor := crDefault;
    p_MessageBoxDlg('�����ɹ�!')
  end;

end;

function TFra_FHFK.f_GetFYDH(_TXM: string): string;
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
  sTXM1,sTXM2: string;
begin
  Result := '';
  sTXM1 := StrLeft(_TXM,11);
  sTXM2 := Copy(_TXM,13,7);
  sSqlData := 'Select * from DO_TransMap where F_sTXM like ''%s_%s%%'' order by F_iID desc';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sTXM1,sTXM2]);
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    Result := ADO_Rec.FieldByName('F_sFYDH').AsString;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;
end;

procedure TFra_FHFK.pm_jhxdPopup(Sender: TObject);
var
  iType: Integer;
begin
  iType := DM_DataBase.ADO_FHFK.FieldByName('OrderType').AsInteger;
  //if menu_ddmxPic.Tag = c_Tag_MakeAllow then
  begin
    if iType = 1 then
      menu_ddmxPic.Visible := False
    else
      menu_ddmxPic.Visible := True;
  end;

end;

procedure TFra_FHFK.menu_ddmxClick(Sender: TObject);
var
  SelItem: TListItem;
  iType,iOrderID: integer;
begin
  if not DM_DataBase.ADO_FHFK.Active then Exit;
  if DM_DataBase.ADO_FHFK.FieldByName('OrderID').IsNull then
  begin
    Application.MessageBox('��ѡ�񶩵�!','��ʾ',MB_ICONINFORMATION);
  end;
  iOrderID := DM_DataBase.ADO_FHFK.FieldByName('OrderID').AsInteger;

  iType := DM_DataBase.ADO_FHFK.FieldByName('OrderType').AsInteger;

  case iType of
    0:
      begin
        if TMenuItem(Sender).Name = 'menu_ddmxPic' then
        begin
          FrmDDMX_DZX(iOrderID,True).Show;
        end else
          FrmDDMX_DZX(iOrderID,False).Show;
      end;
    1:
      begin
        FrmDDMX_XSX(iOrderID).Show;
      end;
  end;

end;

procedure TFra_FHFK.menu_ztmxClick(Sender: TObject);
var
  i,iApartID,iOrderID,iOrderType: integer;
  sSqlData: string;
  ADO_Rec: TADOQuery;
begin
  if not DM_DataBase.ADO_FHFK.Active then Exit;
  iApartID := 0;
  iOrderID := DM_DataBase.ADO_FHFK.FieldByName('OrderID').AsInteger;
  iOrderType := DM_DataBase.ADO_FHFK.FieldByName('OrderType').AsInteger;
  sSqlData := 'select TOP 1 F_iID from DO_OrderApart where F_iOrderID=%d and F_tiOrderType=%d';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iOrderID,iOrderType]);
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    iApartID := ADO_Rec.FieldByName('F_iID').AsInteger;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;
  if iApartID <= 0 then
  begin
    Application.MessageBox('��ѡ�񶩵�!','��ʾ',MB_ICONINFORMATION);
    Exit;
  end;
  Frm_ZTMX := TFrm_ZTMX.Create(Self);
  Frm_ZTMX.p_ShowWindow([iApartID]);

end;

procedure TFra_FHFK.menu_fhmxClick(Sender: TObject);
var
  i,iApartID,iOrderID,iOrderType: integer;
  sSqlData: string;
  ADO_Rec: TADOQuery;
begin
  if not DM_DataBase.ADO_FHFK.Active then Exit;
  iApartID := 0;
  iOrderID := DM_DataBase.ADO_FHFK.FieldByName('OrderID').AsInteger;
  iOrderType := DM_DataBase.ADO_FHFK.FieldByName('OrderType').AsInteger;
  sSqlData := 'select TOP 1 F_iID from DO_OrderApart where F_iOrderID=%d and F_tiOrderType=%d';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iOrderID,iOrderType]);
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    iApartID := ADO_Rec.FieldByName('F_iID').AsInteger;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;
  if iApartID <= 0 then
  begin
    Application.MessageBox('��ѡ�񶩵�!','��ʾ',MB_ICONINFORMATION);
    Exit;
  end;
  Frm_FHMX := TFrm_FHMX.Create(Self);
  Frm_FHMX.p_ShowWindow([iApartID,iOrderID,iOrderType]);

end;

function TFra_FHFK.f_FHFK(const obj: PostServicePortType;const Dfbbz,OrderID,OrderType: Integer; CPBH: string;
  const Type_: Integer; const ID, ProductCode: WideString; const Tao,
  Out_: Integer; const OutCode, JiangCode, OutWay, OverDate: WideString;
  const OutNum: Integer; const TXM, ZXS, CBSL, BZ: WideString;
  var iRec: integer; bRaise: Boolean): Boolean;
var
  sSqlData: string;
  ADO_Temp: TADOQuery;
begin
  Result := False;
  try
    iRec := obj.setOutInfo(c_Web_UserName, c_Web_UserPwd,Type_,ID,ProductCode,Tao,
      Out_,OutCode,JiangCode,OutWay,OverDate,OutNum,TXM,ZXS,CBSL,BZ);
    //�������ͼ��δ�ϸ�
    if iRec= 41 then
    begin
      f_WriteOperationLog('[��������]����ͼ��δ�ϸ񶩵� '+CPBH,999);
      case OrderType of
        0: sSqlData :='select 1 from BI_CustomOrderDetails where F_iFktgzt=3 and F_iID=%d';
        1: sSqlData :='select 1 from BI_SellOrderDetails where F_iFktgzt=3 and F_iID=%d';
      else
        sSqlData :='select 1 from BI_CustomOrderDetails where F_iFktgzt=3 and F_iID=%d';
      end;
      ADO_Temp := DM_DataBase.OpenQuery(sSqlData,[OrderID]);
      if Assigned(ADO_Temp) and (ADO_Temp.RecordCount > 0) then
      begin
        f_WriteOperationLog('[��������]'+CPBH+' ����ͼ��ϸ�',999);
        if obj.setProductInfo('wsfj1', '000000',iif(Dfbbz=0,OrderType,3),ID,CPBH,3) = 0 then
        begin
          iRec := obj.setOutInfo(c_Web_UserName, c_Web_UserPwd,Type_,ID,ProductCode,Tao,
            Out_,OutCode,JiangCode,OutWay,OverDate,OutNum,TXM,ZXS,CBSL,BZ);
        end;
        ADO_Temp.Free;
      end;
    end;
    Result := True;
  except
    on E: Exception do
    begin
      if bRaise then
        raise Exception.Create(E.message);
    end;
  end;
end;


function TFra_FHFK.f_IsRJHDPP(iOrderID, iOrderType: Integer): Boolean;
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
  LabelGroup: array of TCartonLableGroup;
  i,iNum,iYL: Integer;
begin
  Result := False;
  iYL := 0;
  iNum := 0;
  sSqlData := 'SELECT a.F_nYL*10000 YL ,b.F_sZH ,b.F_sRJHDQ ,b.F_sRJHDZ FROM dbo.DO_CartonLableInfo a,dbo.DO_CartonLableGroupNum b  '
    +'WHERE a.F_iStatus = 1 AND a.F_iOrderID=%d AND a.F_tiOrderType=%d AND a.F_iID=b.F_iCartonInfoID';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iOrderID,iOrderType]);
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    iYL := ADO_Rec.FieldByName('YL').AsInteger;
    SetLength(LabelGroup,0);
    i:=0;
    while not ADO_Rec.Eof do
    begin
      SetLength(LabelGroup,Length(LabelGroup)+1);
      LabelGroup[i].m_sZH := ADO_Rec.FieldByName('F_sZH').AsString;
      LabelGroup[i].m_sRJHDQ := ADO_Rec.FieldByName('F_sRJHDQ').AsString;
      LabelGroup[i].m_sRJHDZ := ADO_Rec.FieldByName('F_sRJHDZ').AsString;
      Inc(i);
      ADO_Rec.Next;
    end;
    iNum := 0;
    for i := 0 to Length(LabelGroup) -1 do
    begin
      if LabelGroup[i].m_sRJHDZ = '000000' then
        iNum := iNum+ 1000000 - StrToNum(LabelGroup[i].m_sRJHDQ)+1
      else
        iNum := iNum + StrToNum(LabelGroup[i].m_sRJHDZ) - StrToNum(LabelGroup[i].m_sRJHDQ)+1;
    end;
  end;
  Result := iNum = iYL;

end;

end.




