unit uFra_XQCX;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzPanel, StdCtrls, ExtCtrls, GridsEh,
  DBGridEh, RzRadChk, ComCtrls, RzDTP, RzButton, ButtonEdit, RzCmboBx,
  iComboBox, DBGridEhGrouping, DB, ADODB, MemTableDataEh, DataDriverEh,
  MemTableEh, Grids, iGrid, RM_Dataset, RM_System, RM_Common, RM_Class,
  RM_BarCode, Menus,iLabel, RM_GridReport,uBaseForm;


type
  TFra_XQCX = class(TFrmFrame)
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
    cbb_qrbz: Ti_ComboBox;
    gb_dd: TRzGroupBox;
    dbg_xqxx: TDBGridEh;
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
    btn_save: TRzBitBtn;
    btn_print: TRzBitBtn;
    rmr_CustomPrit: TRMReport;
    rmdb_CartonLablePrint: TRMDBDataSet;
    rmr_SellPrit: TRMReport;
    tmr_zxs: TTimer;
    pm_xqxx: TPopupMenu;
    menu_ddmx: TMenuItem;
    menu_ddmxPic: TMenuItem;
    edt_shrxx: Ti_TxtFilter;
    edt_shrdz: Ti_TxtFilter;
    rmr_CustomPritB5: TRMReport;
    rmr_SellPritB5: TRMReport;
    btn_printB5: TRzBitBtn;
    btn_xgdyxx: TRzBitBtn;
    btn_gxrjhd: TRzBitBtn;
    cbb_xpl: Ti_ComboBox;
    btn_export: TRzButton;
    SavePath: TSaveDialog;
    btn_BQPrint: TRzBitBtn;
    procedure btn_cxClick(Sender: TObject);
    procedure btn_saveClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure lab_ts50Click(Sender: TObject);
    procedure lab_firstClick(Sender: TObject);
    procedure lab_upClick(Sender: TObject);
    procedure lab_downClick(Sender: TObject);
    procedure lab_lastClick(Sender: TObject);
    procedure btn_goClick(Sender: TObject);
    procedure btn_printClick(Sender: TObject);
    procedure dbg_xqxxColumns3EditButtons0Click(Sender: TObject;
      var Handled: Boolean);
    procedure dbg_xqxxTitleClick(Column: TColumnEh);
    procedure dbg_xqxxColumns7UpdateData(Sender: TObject; var Text: String;
      var Value: Variant; var UseText, Handled: Boolean);
    procedure tmr_zxsTimer(Sender: TObject);
    procedure edt_rjhdqExit(Sender: TObject);
    procedure menu_ddmxClick(Sender: TObject);
    procedure pm_xqxxPopup(Sender: TObject);
    procedure dbg_xqxxColumns0UpdateData(Sender: TObject; var Text: String;
      var Value: Variant; var UseText, Handled: Boolean);
    procedure btn_printB5Click(Sender: TObject);
    procedure btn_xgdyxxClick(Sender: TObject);
    procedure btn_gxrjhdClick(Sender: TObject);
    procedure btn_exportClick(Sender: TObject);
    procedure btn_BQPrintClick(Sender: TObject);
  private
    { Private declarations }
    vMYTS: Integer;     //当前每页条数
    vYs: integer;       //当前页数
    vSqlData: string;
    bBlank : boolean;
    vZXS: Integer;
    vRowField: TField;
    pMark: Pointer;
    vbXZUpdate: Boolean; //"选择"列是否允许更新
    procedure CartonLablePrint;
    procedure p_SetPrint(Rmrprt:TRMReport;sName, sValue: string;sType: integer=0);
    function p_GetRJHD(sZH,sRJHDQ,sRJHDZ: string): string;
    function f_MakeAllow: Boolean;   //操作允许
    //检查兑奖号码数量与订单印量是否匹配
    function f_IsRJHDPP(iYL: Integer): Boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;        
    procedure FraShow;
  end;

implementation

uses
  uPub_Text, PubStr, uDM_DataBase, uPub_Type, uPub_Func, uFrm_LableGroup,
  uDDMX_DZX, uDDMX_XSX, uFrm_XQDYXG, uFrm_SelectDlg, DBGridEhImpExp,uXQBQInfoFrm;
{$R *.dfm}

{ TFraXQCX }

procedure TFra_XQCX.btn_cxClick(Sender: TObject);
var
  sSqlData: string;
  sCPBH,sGDH, sZH, sJCq,sJCz,sRJHDQ,sRJHDZ: string;
  iFHBZ,iQRBZ,iYS,iMYTS,n,iXPL: Integer;
begin
  Screen.Cursor := crHourGlass;
  try
    if cb_jcrq.Checked then
    begin
      sJCq := FormatDateTime('yyyy.MM.dd 00:00:00',dtp_jcq.DateTime);
      sJCz := FormatDateTime('yyyy.MM.dd 23:59:59',dtp_jcz.DateTime);
    end;
    sGDH := Trim(edt_gdh.Text);
    sZH := Trim(edt_zh.Text);
    sCPBH := Trim(edt_cpbh.Text);
    sRJHDQ := Trim(edt_rjhdq.Text);
    sRJHDZ := Trim(edt_rjhdz.Text);
    iFHBZ := cbb_fhbz.ItemIndex;
    iQRBZ := cbb_qrbz.ItemIndex;

    case cbb_xpl.ItemIndex of
      0:iXPL := -1;  //全部
      1:iXPL := 0;   //非小批量
      2:iXPL := 1;   //小批量
    end;

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
    sSqlData := Format('p_xqcx ''%s'',''%s'',''%s'',''%s'',''%s'',%d,%d,''%s'',''%s'',%d,%d,%d'
      ,[sCPBH,sGDH,sZH,sRJHDQ,sRJHDZ,iQRBZ,iFHBZ,sJCq,sJCz,iYS,iMYTS,iXPL]);
  //  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sCPBH,sGDH,sZH,sRJHDQ,sRJHDZ,iQRBZ,iFHBZ,sJCq,sJCz,iYS,iMYTS]);
    with DM_DataBase do
    begin
      ado_xqxx.Close;
      ado_xqxx.SQL.Text := sSqlData;
      ado_xqxx.Open;
      //mte_xqxx.Close;
      //mte_xqxx.Open;
    end;
    vSqlData := Format('p_xqcx ''%s'',''%s'',''%s'',''%s'',''%s'',%d,%d,''%s'',''%s'',%s,%s,%d'
      ,[sCPBH,sGDH,sZH,sRJHDQ,sRJHDZ,iQRBZ,iFHBZ,sJCq,sJCz,'%d','%d',iXPL]);
  //  ReadDataXQ(ADO_Rec);
  //  ADO_Rec.Free;
    n := 0;
    if DM_DataBase.ADO_XQXX.RecordCount > 0 then
    begin
      n := DM_DataBase.ADO_XQXX.FieldByName('Count').AsInteger;
  //  n := DM_DataBase.ADO_DataRec.RecordCount;
    end;
    gb_dd.Caption := '订单  总数:'+IntToStr(n)+'条';
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);
  //  gb_dd.Caption := '订单  总数:'+IntToStr(n)+'条';
    btn_cx.Caption := '查询';
    SetLength(LabelGroup,0);
    if iFHBZ=1 then
    begin
      btn_save.Enabled := False;
      btn_save.Caption := '撤销';
      //btn_ok.Enabled := False;
    end else
    begin
      btn_save.Enabled := True;
      btn_ok.Enabled := True;
    end;

    if (iQRBZ = 1) and (iFHBZ=0) then
    begin
      btn_save.Visible := True;;
      btn_save.Enabled := True;
      btn_save.Caption := '撤销';
    end else
    if (iQRBZ = 0) and (iFHBZ=0) then
    begin
      btn_save.Visible := False;
      btn_save.Enabled := True;
      btn_save.Caption := '保存';
    end;
    case cbb_qrbz.ItemIndex of
      0:
        begin
          btn_print.Visible   := False;
          btn_printB5.Visible := False;
          btn_BQPrint.Visible := False;
          btn_xgdyxx.Visible  := False;
          edt_shrdz.Visible   := False;
          edt_shrxx.Visible   := False;
          btn_gxrjhd.Visible  := False;
        end;
      1:
        begin
          btn_print.Visible   := True;
          btn_printB5.Visible := True;
          btn_BQPrint.Visible := True;
          btn_xgdyxx.Visible  := True;
          edt_shrdz.Visible   := True;
          edt_shrxx.Visible   := True;
          btn_gxrjhd.Visible  := True;
        end;
    end;
  except
    on E: Exception do
    begin
      p_MessageBoxDlg('错误：'+E.message);
    end;
  end;          
  Screen.Cursor := crDefault;
end;

procedure TFra_XQCX.FraShow;
var
  i: Integer;
  sSqlData, sParam1: string;
  ADO_Rec: TADOQuery;
begin
  vbXZUpdate := True;
  if (cbb_fhbz.ItemIndex = 0) and (cbb_qrbz.ItemIndex =0) then
    btn_save.Visible := False; //不需要保存功能
  f_MakeAllow;
  for i := 0 to dbg_xqxx.Columns.Count -1 do
  begin
    if dbg_xqxx.Columns.Items[i].FieldName = 'CXSL' then
    begin
      sSqlData := 'Select F_sParam1 from Set_ParamList where F_sName=''%s''  order by F_sParam1';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,['成箱数量']);
      if Assigned(ADO_Rec) and (ADO_Rec.RecordCount>0) then
      begin
        dbg_xqxx.Columns.Items[i].PickList.Clear;
        while not ADO_Rec.Eof do
        begin
          sParam1 := ADO_Rec.FieldByName('F_sParam1').AsString;
          if sParam1 <> '' then
            dbg_xqxx.Columns.Items[i].PickList.Add(sParam1);
          ADO_Rec.Next;
        end;
      end;
      ADO_Rec.Free;
    end;
  end;
end;

procedure TFra_XQCX.btn_saveClick(Sender: TObject);
var
  sOrderID,sOrderType,sCustomID,sSellID: string;
  sSqlData, sTMBZ, sZH, sRJHDQ, sRJHDZ, sRJHD, sTXM: string;
  i,n: integer;
  ADO_Custom,ADO_Sell,ADO_Rec: TADOQuery;
  pBookmark: Pointer;
  iTMBZ: Integer;
begin
  with DM_DataBase do
  begin
    if ADO_xqxx.RecordCount > 0 then
    begin
      //mte_xqxx.FindFirst;
      sCustomID := '';
      sSellID := '';
      pBookmark := ADO_xqxx.GetBookmark;
      n := 0;
      ADO_xqxx.FindFirst;
      for i := 0 to ADO_xqxx.RecordCount -1 do
      begin
        if ADO_xqxx.FindField('XZ').AsBoolean then
        begin
          case ADO_xqxx.FindField('OrderType').AsInteger of
            0: sCustomID := sCustomID + ',' + ADO_xqxx.FindField('OrderID').AsString;
            1: sSellID := sSellID + ',' + ADO_xqxx.FindField('OrderID').AsString;
          end;
          inc(n);
        end;
        if i < ADO_xqxx.RecordCount -1 then
          ADO_xqxx.FindNext;
      end;
      if n = 0 then
      begin
        ADO_xqxx.GotoBookmark(pBookmark);
        p_MessageBoxDlg('请选择要保存的订单!');
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
      ADO_xqxx.FindFirst;
      for i := 0 to ADO_xqxx.RecordCount -1 do
      begin
        if ADO_xqxx.FindField('XZ').AsBoolean then
        begin

          if btn_save.Caption = '保存' then
          begin
            sSqlData := 'select 1 from Set_ParamList where F_sName = ''%s'' and F_sParam1=1 ';
            ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[c_XQRJHDPP]);
            if Assigned(ADO_Rec)and (ADO_Rec.RecordCount > 0) then
            begin
              if  ADO_xqxx.FindField('RJBZ').AsBoolean then
              begin
                SetLabelGroup(ADO_xqxx.FindField('OrderID').AsInteger,ADO_xqxx.FindField('OrderType').AsInteger,
                            ADO_xqxx.FindField('ZH').AsString,ADO_xqxx.FindField('RJHDQ').AsString,
                            ADO_xqxx.FindField('RJHDZ').AsString);
                if not f_IsRJHDPP(Trunc(ADO_xqxx.FindField('YL').AsFloat*10000)) then
                begin
                  p_MessageBoxDlg(ADO_xqxx.FindField('F_sCPBH').AsString+' 兑奖号码数量与印量不匹配!');
                  Exit;
                end;
              end;
            end;
            if Assigned(ADO_Rec) then ADO_Rec.Free;
          end;
                      
          ADO_xqxx.Edit;
          ADO_xqxx.FindField('XZ').AsBoolean := False;
          ADO_xqxx.Post;
          sTMBZ := ADO_xqxx.FindField('TMBZ').AsString;
          if  Trim(sTMBZ) = '枚' then
            iTMBZ := 0
          else if  Trim(sTMBZ) = '套' then
            iTMBZ := 1;
          case ADO_xqxx.FindField('OrderType').AsInteger of
            0:
              begin
                ADO_Custom.First;
                while not ADO_Custom.Eof do
                begin
                  if ADO_Custom.FieldByName('F_iOrderID').AsInteger = ADO_xqxx.FindField('OrderID').AsInteger then
                  begin
                    ADO_Custom.Edit;
                    ADO_Custom.FieldByName('F_bRJBZ').AsBoolean := ADO_xqxx.FindField('RJBZ').AsBoolean;
                    sZH := ADO_xqxx.FindField('ZH').AsString;
                    sRJHDQ := ADO_xqxx.FindField('RJHDQ').AsString;
                    sRJHDZ := ADO_xqxx.FindField('RJHDZ').AsString;
                    ADO_Custom.FieldByName('F_sRJHD').AsString := p_GetRJHD(sZH,sRJHDQ,sRJHDZ);
                    ADO_Custom.FieldByName('F_sZH').AsString := ADO_xqxx.FindField('ZH').AsString;
                    ADO_Custom.FieldByName('F_sRJHDQ').AsString := ADO_xqxx.FindField('RJHDQ').AsString;
                    ADO_Custom.FieldByName('F_sRJHDZ').AsString := ADO_xqxx.FindField('RJHDZ').AsString;
                    ADO_Custom.FieldByName('F_sTXM').AsString := f_GetTXM(ADO_xqxx.FindField('OrderID').AsInteger,0,iTMBZ);
                    ADO_Custom.FieldByName('F_nYL').AsFloat := ADO_xqxx.FindField('YL').AsFloat;
                    ADO_Custom.FieldByName('F_iCXSL').AsInteger := ADO_xqxx.FindField('CXSL').AsInteger;
                    ADO_Custom.FieldByName('F_iCBSL').AsInteger := ADO_xqxx.FindField('CBSL').AsInteger;
                    ADO_Custom.FieldByName('F_iZXS').AsInteger := ADO_xqxx.FindField('ZXS').AsInteger;
//                    sTMBZ := ADO_xqxx.FindField('TMBZ').AsString;
//                    if  Trim(sTMBZ) = '枚' then
//                      ADO_Custom.FieldByName('F_tiTMBZ').AsInteger := 0
//                    else if  Trim(sTMBZ) = '套' then
//                      ADO_Custom.FieldByName('F_tiTMBZ').AsInteger := 1;
                    ADO_Custom.FieldByName('F_tiTMBZ').AsInteger := iTMBZ;
                    ADO_Custom.FieldByName('F_nFJGYF').AsFloat := ADO_xqxx.FindField('FJGYF').AsFloat;
                    ADO_Custom.FieldByName('F_sFHFS').AsString := ADO_xqxx.FindField('FHFS').AsString;
                    ADO_Custom.FieldByName('F_sYSDH').AsString := ADO_xqxx.FindField('YSDH').AsString;
                    ADO_Custom.FieldByName('F_sBZ').AsString := ADO_xqxx.FindField('BZ').AsString;
                    ADO_Custom.FieldByName('F_sCZRBM').AsString := LoginData.m_sUserName;
                    ADO_Custom.FieldByName('F_dCZRQ').AsDateTime := Now;
                    ADO_Custom.FieldByName('F_iStatus').AsInteger := 0;
                    ADO_Custom.Post;
                    p_WriteGroup(ADO_Custom.FieldByName('F_iID').AsInteger,
                      ADO_Custom.FieldByName('F_iOrderID').AsInteger,ADO_Custom.FieldByName('F_tiOrderType').AsInteger,
                      ADO_Custom.FieldByName('F_sZH').AsString,ADO_Custom.FieldByName('F_sRJHDQ').AsString,
                      ADO_Custom.FieldByName('F_sRJHDZ').AsString);
                    Break;
                  end;
                  ADO_Custom.Next;
                end;                                                              
                if ADO_Custom.Eof then
                begin
                  ADO_Custom.Insert;
                  ADO_Custom.FieldByName('F_iOrderID').AsInteger := ADO_xqxx.FindField('OrderID').AsInteger;
                  ADO_Custom.FieldByName('F_tiOrderType').AsInteger := ADO_xqxx.FindField('OrderType').AsInteger;
                  ADO_Custom.FieldByName('F_bRJBZ').AsBoolean := ADO_xqxx.FindField('RJBZ').AsBoolean;
                  sZH := ADO_xqxx.FindField('ZH').AsString;
                  sRJHDQ := ADO_xqxx.FindField('RJHDQ').AsString;
                  sRJHDZ := ADO_xqxx.FindField('RJHDZ').AsString;
                  ADO_Custom.FieldByName('F_sRJHD').AsString := p_GetRJHD(sZH,sRJHDQ,sRJHDZ);
                  ADO_Custom.FieldByName('F_sZH').AsString := ADO_xqxx.FindField('ZH').AsString;
                  ADO_Custom.FieldByName('F_sRJHDQ').AsString := ADO_xqxx.FindField('RJHDQ').AsString;
                  ADO_Custom.FieldByName('F_sRJHDZ').AsString := ADO_xqxx.FindField('RJHDZ').AsString;
                  ADO_Custom.FieldByName('F_sTXM').AsString := f_GetTXM(ADO_xqxx.FindField('OrderID').AsInteger,0,iTMBZ);
                  ADO_Custom.FieldByName('F_nYL').AsFloat := ADO_xqxx.FindField('YL').AsFloat;
                  ADO_Custom.FieldByName('F_iCXSL').AsInteger := ADO_xqxx.FindField('CXSL').AsInteger;
                  ADO_Custom.FieldByName('F_iCBSL').AsInteger := ADO_xqxx.FindField('CBSL').AsInteger;
                  ADO_Custom.FieldByName('F_iZXS').AsInteger := ADO_xqxx.FindField('ZXS').AsInteger;
//                  sTMBZ := ADO_xqxx.FindField('TMBZ').AsString;
//                  if  Trim(sTMBZ) = '枚' then
//                    ADO_Custom.FieldByName('F_tiTMBZ').AsInteger := 0
//                  else if  Trim(sTMBZ) = '套' then
//                    ADO_Custom.FieldByName('F_tiTMBZ').AsInteger := 1;
                  ADO_Custom.FieldByName('F_tiTMBZ').AsInteger := iTMBZ;
                  ADO_Custom.FieldByName('F_nFJGYF').AsFloat := ADO_xqxx.FindField('FJGYF').AsFloat;
                  ADO_Custom.FieldByName('F_sFHFS').AsString := ADO_xqxx.FindField('FHFS').AsString;
                  ADO_Custom.FieldByName('F_sYSDH').AsString := ADO_xqxx.FindField('YSDH').AsString;
                  ADO_Custom.FieldByName('F_sBZ').AsString := ADO_xqxx.FindField('BZ').AsString;
                  ADO_Custom.FieldByName('F_sCZRBM').AsString := LoginData.m_sUserName;
                  ADO_Custom.FieldByName('F_dCZRQ').AsDateTime := Now;
                  ADO_Custom.FieldByName('F_iStatus').AsInteger := 0;
                  ADO_Custom.Post;
                    p_WriteGroup(ADO_Custom.FieldByName('F_iID').AsInteger,
                      ADO_Custom.FieldByName('F_iOrderID').AsInteger,ADO_Custom.FieldByName('F_tiOrderType').AsInteger,
                      ADO_Custom.FieldByName('F_sZH').AsString,ADO_Custom.FieldByName('F_sRJHDQ').AsString,
                      ADO_Custom.FieldByName('F_sRJHDZ').AsString);
                end;
              end;
            1:
              begin
                ADO_Sell.First;
                while not ADO_Sell.Eof do
                begin
                  if ADO_Sell.FieldByName('F_iOrderID').AsInteger = ADO_xqxx.FindField('OrderID').AsInteger then
                  begin
                    ADO_Sell.Edit;
                    ADO_Sell.FieldByName('F_bRJBZ').AsBoolean := ADO_xqxx.FindField('RJBZ').AsBoolean;
                    sZH := ADO_xqxx.FindField('ZH').AsString;
                    sRJHDQ := ADO_xqxx.FindField('RJHDQ').AsString;
                    sRJHDZ := ADO_xqxx.FindField('RJHDZ').AsString;
                    ADO_Sell.FieldByName('F_sRJHD').AsString := p_GetRJHD(sZH,sRJHDQ,sRJHDZ);
                    ADO_Sell.FieldByName('F_sZH').AsString := ADO_xqxx.FindField('ZH').AsString;
                    ADO_Sell.FieldByName('F_sRJHDQ').AsString := ADO_xqxx.FindField('RJHDQ').AsString;
                    ADO_Sell.FieldByName('F_sRJHDZ').AsString := ADO_xqxx.FindField('RJHDZ').AsString;
                    ADO_Sell.FieldByName('F_sTXM').AsString := f_GetTXM(ADO_xqxx.FindField('OrderID').AsInteger,1,iTMBZ);
                    ADO_Sell.FieldByName('F_nYL').AsFloat := ADO_xqxx.FindField('YL').AsFloat;
                    ADO_Sell.FieldByName('F_iCXSL').AsInteger := ADO_xqxx.FindField('CXSL').AsInteger;
                    ADO_Sell.FieldByName('F_iCBSL').AsInteger := ADO_xqxx.FindField('CBSL').AsInteger;
                    ADO_Sell.FieldByName('F_iZXS').AsInteger := ADO_xqxx.FindField('ZXS').AsInteger;
//                    sTMBZ := ADO_xqxx.FindField('TMBZ').AsString;
//                    if  Trim(sTMBZ) = '枚' then
//                      ADO_Sell.FieldByName('F_tiTMBZ').AsInteger := 0
//                    else if  Trim(sTMBZ) = '套' then
//                      ADO_Sell.FieldByName('F_tiTMBZ').AsInteger := 1;
                    ADO_Sell.FieldByName('F_tiTMBZ').AsInteger := iTMBZ;
                    ADO_Sell.FieldByName('F_nFJGYF').AsFloat := ADO_xqxx.FindField('FJGYF').AsFloat;
                    ADO_Sell.FieldByName('F_sFHFS').AsString := ADO_xqxx.FindField('FHFS').AsString;
                    ADO_Sell.FieldByName('F_sYSDH').AsString := ADO_xqxx.FindField('YSDH').AsString;
                    ADO_Sell.FieldByName('F_sBZ').AsString := ADO_xqxx.FindField('BZ').AsString;
                    ADO_Sell.FieldByName('F_sCZRBM').AsString := LoginData.m_sUserName;
                    ADO_Sell.FieldByName('F_dCZRQ').AsDateTime := Now;
                    ADO_Sell.FieldByName('F_iStatus').AsInteger := 0;
                    ADO_Sell.Post;
                    p_WriteGroup(ADO_Sell.FieldByName('F_iID').AsInteger,
                      ADO_Sell.FieldByName('F_iOrderID').AsInteger,ADO_Sell.FieldByName('F_tiOrderType').AsInteger,
                      ADO_Sell.FieldByName('F_sZH').AsString,ADO_Sell.FieldByName('F_sRJHDQ').AsString,
                      ADO_Sell.FieldByName('F_sRJHDZ').AsString);
                    Break;
                  end;
                  ADO_Sell.Next;
                end;
                if ADO_Sell.Eof then
                begin
                  ADO_Sell.Insert;
                  ADO_Sell.FieldByName('F_iOrderID').AsInteger := ADO_xqxx.FindField('OrderID').AsInteger;
                  ADO_Sell.FieldByName('F_tiOrderType').AsInteger := ADO_xqxx.FindField('OrderType').AsInteger;
                  ADO_Sell.FieldByName('F_bRJBZ').AsBoolean := ADO_xqxx.FindField('RJBZ').AsBoolean;
                  sZH := ADO_xqxx.FindField('ZH').AsString;
                  sRJHDQ := ADO_xqxx.FindField('RJHDQ').AsString;
                  sRJHDZ := ADO_xqxx.FindField('RJHDZ').AsString;
                  ADO_Sell.FieldByName('F_sRJHD').AsString := p_GetRJHD(sZH,sRJHDQ,sRJHDZ);
                  ADO_Sell.FieldByName('F_sZH').AsString := ADO_xqxx.FindField('ZH').AsString;
                  ADO_Sell.FieldByName('F_sRJHDQ').AsString := ADO_xqxx.FindField('RJHDQ').AsString;
                  ADO_Sell.FieldByName('F_sRJHDZ').AsString := ADO_xqxx.FindField('RJHDZ').AsString;
                  ADO_Sell.FieldByName('F_sTXM').AsString := f_GetTXM(ADO_xqxx.FindField('OrderID').AsInteger,1,iTMBZ);
                  ADO_Sell.FieldByName('F_nYL').AsFloat := ADO_xqxx.FindField('YL').AsFloat;
                  ADO_Sell.FieldByName('F_iCXSL').AsInteger := ADO_xqxx.FindField('CXSL').AsInteger;
                  ADO_Sell.FieldByName('F_iCBSL').AsInteger := ADO_xqxx.FindField('CBSL').AsInteger;
                  ADO_Sell.FieldByName('F_iZXS').AsInteger := ADO_xqxx.FindField('ZXS').AsInteger;
//                  sTMBZ := ADO_xqxx.FindField('TMBZ').AsString;
//                  if  Trim(sTMBZ) = '枚' then
//                    ADO_Sell.FieldByName('F_tiTMBZ').AsInteger := 0
//                  else if  Trim(sTMBZ) = '套' then
//                    ADO_Sell.FieldByName('F_tiTMBZ').AsInteger := 1;
                  ADO_Sell.FieldByName('F_tiTMBZ').AsInteger := iTMBZ;
                  ADO_Sell.FieldByName('F_nFJGYF').AsFloat := ADO_xqxx.FindField('FJGYF').AsFloat;
                  ADO_Sell.FieldByName('F_sFHFS').AsString := ADO_xqxx.FindField('FHFS').AsString;
                  ADO_Sell.FieldByName('F_sYSDH').AsString := ADO_xqxx.FindField('YSDH').AsString;
                  ADO_Sell.FieldByName('F_sBZ').AsString := ADO_xqxx.FindField('BZ').AsString;
                  ADO_Sell.FieldByName('F_sCZRBM').AsString := LoginData.m_sUserName;
                  ADO_Sell.FieldByName('F_dCZRQ').AsDateTime := Now;
                  ADO_Sell.FieldByName('F_iStatus').AsInteger := 0;
                  ADO_Sell.Post;
                  p_WriteGroup(ADO_Sell.FieldByName('F_iID').AsInteger,
                    ADO_Sell.FieldByName('F_iOrderID').AsInteger,ADO_Sell.FieldByName('F_tiOrderType').AsInteger,
                    ADO_Sell.FieldByName('F_sZH').AsString,ADO_Sell.FieldByName('F_sRJHDQ').AsString,
                    ADO_Sell.FieldByName('F_sRJHDZ').AsString);
                end;
              end;
          end;
        end;
        if i < ADO_xqxx.RecordCount -1 then
          ADO_xqxx.FindNext;
      end;
      ADO_Custom.Free;
      ADO_Sell.Free;
    end;
  end;
  btn_cx.Click;
end;

procedure TFra_XQCX.btn_okClick(Sender: TObject);
var
  sOrderID,sOrderType,sCustomID,sSellID: string;
  sSqlData, sTMBZ, sZH, sRJHDQ, sRJHDZ: string;
  i,n: integer;
  ADO_Custom,ADO_Sell, ADO_Rec: TADOQuery;
  pBookmark: Pointer;
  iMZBZ: Integer;

begin
  with DM_DataBase do
  begin
    if ADO_xqxx.RecordCount > 0 then
    begin
      //mte_xqxx.FindFirst;
      sCustomID := '';
      sSellID := '';
      n := 0;
      pBookmark := ADO_xqxx.GetBookmark;
      ADO_xqxx.FindFirst;
      for i := 0 to ADO_xqxx.RecordCount -1 do
      begin
        if ADO_xqxx.FindField('XZ').AsBoolean then
        begin
          case ADO_xqxx.FindField('OrderType').AsInteger of
            0: sCustomID := sCustomID + ',' + ADO_xqxx.FindField('OrderID').AsString;
            1: sSellID := sSellID + ',' + ADO_xqxx.FindField('OrderID').AsString;
          end;
          inc(n);
        end;
        if i < ADO_xqxx.RecordCount -1 then
          ADO_xqxx.FindNext;
      end;
      if n = 0 then
      begin
        ADO_xqxx.GotoBookmark(pBookmark);
        p_MessageBoxDlg('请选择要保存确认的订单!');
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
      ADO_xqxx.FindFirst;
      for i := 0 to ADO_xqxx.RecordCount -1 do
      begin
        if ADO_xqxx.FindField('XZ').AsBoolean then
        begin
          sSqlData := 'select 1 from Set_ParamList where F_sName = ''%s'' and F_sParam1=1 ';
          ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[c_XQRJHDPP]);
          if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
          begin
            if  ADO_xqxx.FindField('RJBZ').AsBoolean then
            begin
              SetLabelGroup(ADO_xqxx.FindField('OrderID').AsInteger,ADO_xqxx.FindField('OrderType').AsInteger,
                          ADO_xqxx.FindField('ZH').AsString,ADO_xqxx.FindField('RJHDQ').AsString,
                          ADO_xqxx.FindField('RJHDZ').AsString);
              if not f_IsRJHDPP(Trunc(ADO_xqxx.FindField('YL').AsFloat*10000)) then
              begin
                p_MessageBoxDlg(ADO_xqxx.FindField('F_sCPBH').AsString+' 兑奖号码数量与印量不匹配!');
                Exit;
              end;
            end;
          end;
          if Assigned(ADO_Rec) then ADO_Rec.Free;

          ADO_xqxx.Edit;
          ADO_xqxx.FindField('XZ').AsBoolean := False;
          ADO_xqxx.Post;
          sTMBZ := ADO_xqxx.FindField('TMBZ').AsString;
          if  Trim(sTMBZ) = '枚' then
            iMZBZ := 0
          else if  Trim(sTMBZ) = '套' then
            iMZBZ := 1;
          case ADO_xqxx.FindField('OrderType').AsInteger of
            0:
              begin
                ADO_Custom.First;
                while not ADO_Custom.Eof do
                begin
                  if ADO_Custom.FieldByName('F_iOrderID').AsInteger = ADO_xqxx.FindField('OrderID').AsInteger then
                  begin
                    ADO_Custom.Edit;
                    ADO_Custom.FieldByName('F_bRJBZ').AsBoolean := ADO_xqxx.FindField('RJBZ').AsBoolean;
                    sZH := ADO_xqxx.FindField('ZH').AsString;
                    sRJHDQ := ADO_xqxx.FindField('RJHDQ').AsString;
                    sRJHDZ := ADO_xqxx.FindField('RJHDZ').AsString;
                    ADO_Custom.FieldByName('F_sRJHD').AsString := p_GetRJHD(sZH,sRJHDQ,sRJHDZ);
                    ADO_Custom.FieldByName('F_sZH').AsString := ADO_xqxx.FindField('ZH').AsString;
                    ADO_Custom.FieldByName('F_sRJHDQ').AsString := ADO_xqxx.FindField('RJHDQ').AsString;
                    ADO_Custom.FieldByName('F_sRJHDZ').AsString := ADO_xqxx.FindField('RJHDZ').AsString;
                    ADO_Custom.FieldByName('F_sTXM').AsString := f_GetTXM(ADO_xqxx.FindField('OrderID').AsInteger,0,iMZBZ);
                    ADO_Custom.FieldByName('F_nYL').AsFloat := ADO_xqxx.FindField('YL').AsFloat;
                    ADO_Custom.FieldByName('F_iCXSL').AsInteger := ADO_xqxx.FindField('CXSL').AsInteger;
                    ADO_Custom.FieldByName('F_iCBSL').AsInteger := ADO_xqxx.FindField('CBSL').AsInteger;
                    ADO_Custom.FieldByName('F_iZXS').AsInteger := ADO_xqxx.FindField('ZXS').AsInteger;
                    ADO_Custom.FieldByName('F_tiTMBZ').AsInteger := iMZBZ;
                    ADO_Custom.FieldByName('F_nFJGYF').AsFloat := ADO_xqxx.FindField('FJGYF').AsFloat;
                    ADO_Custom.FieldByName('F_sFHFS').AsString := ADO_xqxx.FindField('FHFS').AsString;
                    ADO_Custom.FieldByName('F_sYSDH').AsString := ADO_xqxx.FindField('YSDH').AsString;
                    ADO_Custom.FieldByName('F_sBZ').AsString := ADO_xqxx.FindField('BZ').AsString;
                    ADO_Custom.FieldByName('F_sCZRBM').AsString := LoginData.m_sUserName;
                    ADO_Custom.FieldByName('F_dCZRQ').AsDateTime := Now;
                    ADO_Custom.FieldByName('F_iStatus').AsInteger := 1;
                    ADO_Custom.Post;
                    p_WriteGroup(ADO_Custom.FieldByName('F_iID').AsInteger,
                      ADO_Custom.FieldByName('F_iOrderID').AsInteger,ADO_Custom.FieldByName('F_tiOrderType').AsInteger,
                      ADO_Custom.FieldByName('F_sZH').AsString,ADO_Custom.FieldByName('F_sRJHDQ').AsString,
                      ADO_Custom.FieldByName('F_sRJHDZ').AsString);
                    Break;
                  end;
                  ADO_Custom.Next;
                end;
                if ADO_Custom.Eof then
                begin
                  ADO_Custom.Insert;
                  ADO_Custom.FieldByName('F_iOrderID').AsInteger := ADO_xqxx.FindField('OrderID').AsInteger;
                  ADO_Custom.FieldByName('F_tiOrderType').AsInteger := ADO_xqxx.FindField('OrderType').AsInteger;
                  ADO_Custom.FieldByName('F_bRJBZ').AsBoolean := ADO_xqxx.FindField('RJBZ').AsBoolean;
                  sZH := ADO_xqxx.FindField('ZH').AsString;
                  sRJHDQ := ADO_xqxx.FindField('RJHDQ').AsString;
                  sRJHDZ := ADO_xqxx.FindField('RJHDZ').AsString;
                  ADO_Custom.FieldByName('F_sRJHD').AsString := p_GetRJHD(sZH,sRJHDQ,sRJHDZ);
                  ADO_Custom.FieldByName('F_sZH').AsString := ADO_xqxx.FindField('ZH').AsString;
                  ADO_Custom.FieldByName('F_sRJHDQ').AsString := ADO_xqxx.FindField('RJHDQ').AsString;
                  ADO_Custom.FieldByName('F_sRJHDZ').AsString := ADO_xqxx.FindField('RJHDZ').AsString;
                  ADO_Custom.FieldByName('F_sTXM').AsString := f_GetTXM(ADO_xqxx.FindField('OrderID').AsInteger,0,iMZBZ);
                  ADO_Custom.FieldByName('F_nYL').AsFloat := ADO_xqxx.FindField('YL').AsFloat;
                  ADO_Custom.FieldByName('F_iCXSL').AsInteger := ADO_xqxx.FindField('CXSL').AsInteger;
                  ADO_Custom.FieldByName('F_iCBSL').AsInteger := ADO_xqxx.FindField('CBSL').AsInteger;
                  ADO_Custom.FieldByName('F_iZXS').AsInteger := ADO_xqxx.FindField('ZXS').AsInteger;
                  ADO_Custom.FieldByName('F_tiTMBZ').AsInteger := iMZBZ;
                  ADO_Custom.FieldByName('F_nFJGYF').AsFloat := ADO_xqxx.FindField('FJGYF').AsFloat;
                  ADO_Custom.FieldByName('F_sFHFS').AsString := ADO_xqxx.FindField('FHFS').AsString;
                  ADO_Custom.FieldByName('F_sYSDH').AsString := ADO_xqxx.FindField('YSDH').AsString;
                  ADO_Custom.FieldByName('F_sBZ').AsString := ADO_xqxx.FindField('BZ').AsString;
                  ADO_Custom.FieldByName('F_sCZRBM').AsString := LoginData.m_sUserName;
                  ADO_Custom.FieldByName('F_dCZRQ').AsDateTime := Now;
                  ADO_Custom.FieldByName('F_iStatus').AsInteger := 1;
                  ADO_Custom.Post;
                  p_WriteGroup(ADO_Custom.FieldByName('F_iID').AsInteger,
                    ADO_Custom.FieldByName('F_iOrderID').AsInteger,ADO_Custom.FieldByName('F_tiOrderType').AsInteger,
                    ADO_Custom.FieldByName('F_sZH').AsString,ADO_Custom.FieldByName('F_sRJHDQ').AsString,
                    ADO_Custom.FieldByName('F_sRJHDZ').AsString);
                end;
              end;
            1:
              begin
                ADO_Sell.First;
                while not ADO_Sell.Eof do
                begin
                  if ADO_Sell.FieldByName('F_iOrderID').AsInteger = ADO_xqxx.FindField('OrderID').AsInteger then
                  begin
                    ADO_Sell.Edit;
                    ADO_Sell.FieldByName('F_bRJBZ').AsBoolean := ADO_xqxx.FindField('RJBZ').AsBoolean;
                    sZH := ADO_xqxx.FindField('ZH').AsString;
                    sRJHDQ := ADO_xqxx.FindField('RJHDQ').AsString;
                    sRJHDZ := ADO_xqxx.FindField('RJHDZ').AsString;
                    ADO_Sell.FieldByName('F_sRJHD').AsString := p_GetRJHD(sZH,sRJHDQ,sRJHDZ);
                    ADO_Sell.FieldByName('F_sZH').AsString := ADO_xqxx.FindField('ZH').AsString;
                    ADO_Sell.FieldByName('F_sRJHDQ').AsString := ADO_xqxx.FindField('RJHDQ').AsString;
                    ADO_Sell.FieldByName('F_sRJHDZ').AsString := ADO_xqxx.FindField('RJHDZ').AsString;
                    ADO_Sell.FieldByName('F_sTXM').AsString := f_GetTXM(ADO_xqxx.FindField('OrderID').AsInteger,1,iMZBZ);
                    ADO_Sell.FieldByName('F_nYL').AsFloat := ADO_xqxx.FindField('YL').AsFloat;
                    ADO_Sell.FieldByName('F_iCXSL').AsInteger := ADO_xqxx.FindField('CXSL').AsInteger;
                    ADO_Sell.FieldByName('F_iCBSL').AsInteger := ADO_xqxx.FindField('CBSL').AsInteger;
                    ADO_Sell.FieldByName('F_iZXS').AsInteger := ADO_xqxx.FindField('ZXS').AsInteger;
                    ADO_Sell.FieldByName('F_tiTMBZ').AsInteger := iMZBZ;
                    ADO_Sell.FieldByName('F_nFJGYF').AsFloat := ADO_xqxx.FindField('FJGYF').AsFloat;
                    ADO_Sell.FieldByName('F_sFHFS').AsString := ADO_xqxx.FindField('FHFS').AsString;
                    ADO_Sell.FieldByName('F_sYSDH').AsString := ADO_xqxx.FindField('YSDH').AsString;
                    ADO_Sell.FieldByName('F_sBZ').AsString := ADO_xqxx.FindField('BZ').AsString;
                    ADO_Sell.FieldByName('F_sCZRBM').AsString := LoginData.m_sUserName;
                    ADO_Sell.FieldByName('F_dCZRQ').AsDateTime := Now;
                    ADO_Sell.FieldByName('F_iStatus').AsInteger := 1;
                    ADO_Sell.Post;
                    p_WriteGroup(ADO_Sell.FieldByName('F_iID').AsInteger,
                      ADO_Sell.FieldByName('F_iOrderID').AsInteger,ADO_Sell.FieldByName('F_tiOrderType').AsInteger,
                      ADO_Sell.FieldByName('F_sZH').AsString,ADO_Sell.FieldByName('F_sRJHDQ').AsString,
                      ADO_Sell.FieldByName('F_sRJHDZ').AsString);
                    Break;
                  end;
                  ADO_Sell.Next;
                end;
                if ADO_Sell.Eof then
                begin
                  ADO_Sell.Insert;
                  ADO_Sell.FieldByName('F_iOrderID').AsInteger := ADO_xqxx.FindField('OrderID').AsInteger;
                  ADO_Sell.FieldByName('F_tiOrderType').AsInteger := ADO_xqxx.FindField('OrderType').AsInteger;
                  ADO_Sell.FieldByName('F_bRJBZ').AsBoolean := ADO_xqxx.FindField('RJBZ').AsBoolean;
                  sZH := ADO_xqxx.FindField('ZH').AsString;
                  sRJHDQ := ADO_xqxx.FindField('RJHDQ').AsString;
                  sRJHDZ := ADO_xqxx.FindField('RJHDZ').AsString;
                  ADO_Sell.FieldByName('F_sRJHD').AsString := p_GetRJHD(sZH,sRJHDQ,sRJHDZ);
                  ADO_Sell.FieldByName('F_sZH').AsString := ADO_xqxx.FindField('ZH').AsString;
                  ADO_Sell.FieldByName('F_sRJHDQ').AsString := ADO_xqxx.FindField('RJHDQ').AsString;
                  ADO_Sell.FieldByName('F_sRJHDZ').AsString := ADO_xqxx.FindField('RJHDZ').AsString;
                  ADO_Sell.FieldByName('F_sTXM').AsString := f_GetTXM(ADO_xqxx.FindField('OrderID').AsInteger,1,iMZBZ);
                  ADO_Sell.FieldByName('F_nYL').AsFloat := ADO_xqxx.FindField('YL').AsFloat;
                  ADO_Sell.FieldByName('F_iCXSL').AsInteger := ADO_xqxx.FindField('CXSL').AsInteger;
                  ADO_Sell.FieldByName('F_iCBSL').AsInteger := ADO_xqxx.FindField('CBSL').AsInteger;
                  ADO_Sell.FieldByName('F_iZXS').AsInteger := ADO_xqxx.FindField('ZXS').AsInteger;
                  ADO_Sell.FieldByName('F_tiTMBZ').AsInteger := iMZBZ;
                  ADO_Sell.FieldByName('F_nFJGYF').AsFloat := ADO_xqxx.FindField('FJGYF').AsFloat;
                  ADO_Sell.FieldByName('F_sFHFS').AsString := ADO_xqxx.FindField('FHFS').AsString;
                  ADO_Sell.FieldByName('F_sYSDH').AsString := ADO_xqxx.FindField('YSDH').AsString;
                  ADO_Sell.FieldByName('F_sBZ').AsString := ADO_xqxx.FindField('BZ').AsString;
                  ADO_Sell.FieldByName('F_sCZRBM').AsString := LoginData.m_sUserName;
                  ADO_Sell.FieldByName('F_dCZRQ').AsDateTime := Now;
                  ADO_Sell.FieldByName('F_iStatus').AsInteger := 1;
                  ADO_Sell.Post;
                  p_WriteGroup(ADO_Sell.FieldByName('F_iID').AsInteger,
                      ADO_Sell.FieldByName('F_iOrderID').AsInteger,ADO_Sell.FieldByName('F_tiOrderType').AsInteger,
                      ADO_Sell.FieldByName('F_sZH').AsString,ADO_Sell.FieldByName('F_sRJHDQ').AsString,
                      ADO_Sell.FieldByName('F_sRJHDZ').AsString);
                end;
              end;
          end;
        end;
        if i < ADO_xqxx.RecordCount -1 then
          ADO_xqxx.FindNext;
      end;
      ADO_Custom.Free;
      ADO_Sell.Free;
      btn_cx.Click;
    end;
  end;
end;

procedure TFra_XQCX.lab_ts50Click(Sender: TObject);
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
  DM_DataBase.ADO_XQXX.Close;
  sSqlData := Format(vSqlData,[1,vMYTS]);
  DM_DataBase.ADO_XQXX.SQL.Text :=  sSqlData;
  DM_DataBase.ADO_XQXX.Open;
//  DM_DataBase.mte_FHCX.Close;
//  DM_DataBase.mte_FHCX.Open;
  LabFontClear(lab_ts50);
  LabFontClear(lab_ts100);
  LabFontClear(lab_ts200);
  LabFontClear(lab_ts500);
  TLabel(Sender).Font.Color :=  clBlack;
  TLabel(Sender).Font.Size := 10;
  TLabel(Sender).Font.Style := [fsBold];
  TLabel(Sender).Cursor := crDefault;
  vYs := 1;
  if DM_DataBase.ADO_XQXX.RecordCount > 0 then
  begin
    n := DM_DataBase.ADO_XQXX.FieldByName('Count').AsInteger;
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);
  end;
end;

procedure TFra_XQCX.lab_firstClick(Sender: TObject);
begin
  if vYs = 1 then Exit;
  edt_ys.Text := '1';
  btn_go.Click;
end;

procedure TFra_XQCX.lab_upClick(Sender: TObject);
begin
  if vYs > 1 then
  begin
    edt_ys.Text := IntToStr(vYs -1);
    btn_go.Click;
  end;
end;

procedure TFra_XQCX.lab_downClick(Sender: TObject);
begin
  if vYs < lab_zys.Tag then
  begin
    edt_ys.Text := IntToStr(vYs +1);
    btn_go.Click;
  end;
end;

procedure TFra_XQCX.lab_lastClick(Sender: TObject);
begin
  if vYs = lab_zys.Tag then Exit;
  edt_ys.Text := IntToStr(lab_zys.Tag);
  btn_go.Click;

end;

procedure TFra_XQCX.btn_goClick(Sender: TObject);
var
  iYs,n: Integer;
  sSqlData: string;
begin
  Screen.Cursor := crHourGlass;
  iYs := StrToNum(edt_ys.Text);
  DM_DataBase.ADO_XQXX.Close;
  sSqlData := Format(vSqlData,[iYs,vMYTS]);
  DM_DataBase.ADO_XQXX.SQL.Text :=  sSqlData;
  DM_DataBase.ADO_XQXX.Open;
//  DM_DataBase.mte_FHCX.Close;
//  DM_DataBase.mte_FHCX.Open;
  if DM_DataBase.ADO_XQXX.RecordCount > 0 then
  begin
    n := DM_DataBase.ADO_XQXX.FieldByName('Count').AsInteger;
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    vYs := iYs;
    lab_zys.Caption := '页次：'+IntToStr(iYs)+'/'+ IntToStr(lab_zys.Tag);
  end;
  Screen.Cursor := crDefault;
end;

procedure TFra_XQCX.CartonLablePrint;
var
  sSqlData: string;
begin
 { with DM_DataBase.ADO_Print do
  begin
    Close;
    sSqlData := 'select *,CPLX=(select F_sTypeName from Set_ProductType where F_iID=a.F_iProductTypeID) from BI_WorkOrder a where a.F_iID=%d';
    SQL.Text := Format(sSqlData,[vWorkID]) ;
    Open;
  end;
  rmr_CustomPrit.PrepareReport;
  rmr_CustomPrit.ShowReport;    }
end;

procedure TFra_XQCX.btn_printClick(Sender: TObject);
var
  iOrderID, iOrderType,iDfbbz: Integer;
  sSqlData, sCPBH: string;
  i, n, iNJBZ: Integer;
  pBookmark: Pointer;
  ADO_Rec: TADOQuery;
  sText , sCaption ,AButtom ,BButtom: string;
begin
  Screen.Cursor := crHourGlass;
  with DM_DataBase do
  begin
    pBookmark := ADO_xqxx.GetBookmark;
    ADO_xqxx.FindFirst;
    n := 0;
    for i := 0 to ADO_xqxx.RecordCount -1 do
    begin
      if ADO_xqxx.FindField('XZ').AsBoolean then
      begin
        iOrderID := ADO_XQXX.FindField('OrderID').AsInteger;
        iOrderType := ADO_XQXX.FindField('OrderType').AsInteger;
        sCPBH := ADO_XQXX.FindField('F_sCpbh').AsString;
        inc(n);
      end;
      if i < ADO_xqxx.RecordCount -1 then
        ADO_xqxx.FindNext;
    end;
    ADO_xqxx.GotoBookmark(pBookmark);
  end;
  if n > 1 then
  begin
    p_MessageBoxDlg('一次只能选择一个订单进行打印!','提示');
    Screen.Cursor := crDefault;
    Exit;
  end;
  if n = 0 then
  begin
    Screen.Cursor := crDefault;
    p_MessageBoxDlg('请选择一个订单!','提示');
    Exit;
  end;  //iOrderID := DM_DataBase.ADO_XQXX.FieldByName('OrderID').AsInteger;
  //iOrderType := DM_DataBase.ADO_XQXX.FieldByName('OrderType').AsInteger;
  //-------判断是否含有内件,含有内件选择打印信封或内件-----------------------
  iNJBZ := 0;
  sSqlData := 'Select 1 from DO_OrderApart where F_iOrderID=%d and F_tiOrderType=%d and F_tiNJBZ=1 and F_tiCXBZ=0';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iOrderID,iOrderType]);
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    sText := '订单('+sCPBH+')含有内件,请选择打印信封还是内件：';
    sCaption := '提示';
    AButtom := '打印信封';
    BButtom := '打印内件';
    Screen.Cursor := crDefault;
    case f_SelectDlg(sText,sCaption,[AButtom,BButtom]) of
      1: iNJBZ := 0;
      2: iNJBZ := 1;
    else
      Exit
    end;
    Screen.Cursor := crHourGlass;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;
  //----------------------------------------------------------------------------
  try
    with DM_DataBase.ADO_Print do
    begin
      Close;
      sSqlData := 'exec p_CartonLablePrint %d,%d,''%s'',''%s'',%d ';
      SQL.Text := Format(sSqlData,[iOrderID,iOrderType,Trim(edt_shrxx.Text),Trim(edt_shrdz.Text),iNJBZ]);
      Open;
      if RecordCount = 0 then
      begin
        p_MessageBoxDlg('查找不到此订单数据!','提示');
        Screen.Cursor := crDefault;
        Exit;
      end;
      iDfbbz := FieldByName('DFBBZ').AsInteger;
    end;
  //  p_SetPrint('BarCode1',);
    case iOrderType of
      0:
        begin
          if iDfbbz = 0 then
          begin
            rmr_CustomPrit.PrepareReport;
            rmr_CustomPrit.ShowReport;
          end else
          if iDfbbz = 1 then
          begin
            rmr_SellPrit.PrepareReport;
            rmr_SellPrit.ShowReport;
          end;
        end;
      1:
        begin
          rmr_SellPrit.PrepareReport;
          rmr_SellPrit.ShowReport;
        end;
    end;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar('错误:'+E.message),'提示',MB_ICONINFORMATION)
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TFra_XQCX.p_SetPrint(Rmrprt: TRMReport; sName, sValue: string;sType: integer);
var
  rmView: TRMView;
begin
  rmView := Rmrprt.FindObject(sName);
  if rmView <> nil then
  begin
    case sType of
      0:
        begin
          TRMMemoView(rmView).DataField := sValue;
        end;
      1:
        begin
          TRMBarCodeView(rmView).DataField := sValue;
        end;
    end;
  end;

end;

procedure TFra_XQCX.dbg_xqxxColumns3EditButtons0Click(Sender: TObject;
  var Handled: Boolean);
var
  iOrderID,iOrderType: integer;
  i, n: Integer;
  sSqlData,sCPHB: string;
  ADO_Rec: TADOQuery;
  sZH,sRJHDQ,sRJHDZ: string;
begin
  iOrderID := DM_DataBase.ADO_XQXX.FieldByName('OrderID').AsInteger;
  iOrderType := DM_DataBase.ADO_XQXX.FieldByName('OrderType').AsInteger;
  sCPHB := DM_DataBase.ADO_XQXX.FieldByName('F_sCpbh').AsString;
  if iOrderID > 0 then
  begin
    Frm_LableGroup := TFrm_LableGroup.Create(Self);
    Frm_LableGroup.Caption := PChar('订单: '+ sCPHB);
    sZH := DM_DataBase.ADO_XQXX.FieldByName('ZH').AsString;
    sRJHDQ := DM_DataBase.ADO_XQXX.FieldByName('RJHDQ').AsString;
    sRJHDZ := DM_DataBase.ADO_XQXX.FieldByName('RJHDZ').AsString;
    Frm_LableGroup.stg_LableGroup.RowCount := 2;
    n := 0;
    for i := 1 to PosNum(sZH,',')+1 do
    begin
      inc(n);
      Frm_LableGroup.stg_LableGroup.RowCount := Frm_LableGroup.stg_LableGroup.RowCount+1;
      Frm_LableGroup.stg_LableGroup.Cells[0,n] := PosCopy(sZH,',',i);
      Frm_LableGroup.stg_LableGroup.Cells[1,n] := PosCopy(sRJHDQ,',',i);
      Frm_LableGroup.stg_LableGroup.Cells[2,n] := PosCopy(sRJHDZ,',',i);
    end;
    {n := 0;
    if Length(LabelGroup) >0 then
    begin
      Frm_LableGroup.stg_LableGroup.RowCount := 2;
      for i := 0 to  Length(LabelGroup) -1 do
      begin
        if (LabelGroup[i].m_iOrderID = iOrderID) and (LabelGroup[i].m_iOrderType = iOrderType) then
        begin
          inc(n);
          Frm_LableGroup.stg_LableGroup.RowCount := Frm_LableGroup.stg_LableGroup.RowCount+1;
          Frm_LableGroup.stg_LableGroup.Cells[0,n] := LabelGroup[i].m_sZH;
          Frm_LableGroup.stg_LableGroup.Cells[1,n] := LabelGroup[i].m_sRJHDQ;
          Frm_LableGroup.stg_LableGroup.Cells[2,n] := LabelGroup[i].m_sRJHDZ;
        end;
      end;
    end;
    if Frm_LableGroup.stg_LableGroup.RowCount = 2 then
    begin
      sSqlData := 'Select b.* from DO_CartonLableInfo a,DO_CartonLableGroupNum b where a.F_iID=b.F_iCartonInfoID and a.F_iOrderID=%d and a.F_tiOrderType=%d  ';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iOrderID,iOrderType]);
      Frm_LableGroup.stg_LableGroup.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +2, 2);
      i := 0;
      while not ADO_Rec.Eof do
      begin
        Inc(i);
        Frm_LableGroup.stg_LableGroup.Cells[0,i] := ADO_Rec.FieldByName('F_sZH').AsString;
        Frm_LableGroup.stg_LableGroup.Cells[1,i] := ADO_Rec.FieldByName('F_sRJHDQ').AsString;
        Frm_LableGroup.stg_LableGroup.Cells[2,i] := ADO_Rec.FieldByName('F_sRJHDZ').AsString;
        ADO_Rec.Next;
      end;
    end;                 }
    Frm_LableGroup.vOrderID := iOrderID;
    Frm_LableGroup.vOrderType := iOrderType;
    if Frm_LableGroup.ShowModal = mrOk then
    begin
      sZH := '';
      sRJHDQ := '';
      sRJHDZ := '';
      for i := 0 to Length(LabelGroup) -1 do
      begin
        if (LabelGroup[i].m_iOrderID = iOrderID) and (LabelGroup[i].m_iOrderType = iOrderType) then
        begin
          sZH := sZH+',' + LabelGroup[i].m_sZH;
          sRJHDQ := sRJHDQ+',' + LabelGroup[i].m_sRJHDQ;
          sRJHDZ := sRJHDZ + ',' + LabelGroup[i].m_sRJHDZ;
        end;
      end;
      sZH := Copy(sZH,2,Length(sZH));
      sRJHDQ := Copy(sRJHDQ,2,Length(sRJHDQ));
      sRJHDZ := Copy(sRJHDZ,2,Length(sRJHDZ));
      DM_DataBase.ADO_XQXX.Edit;
      DM_DataBase.ADO_XQXX.FieldByName('ZH').AsString := sZH;
      DM_DataBase.ADO_XQXX.FieldByName('RJHDQ').AsString := sRJHDQ;
      DM_DataBase.ADO_XQXX.FieldByName('RJHDZ').AsString := sRJHDZ;
      if Trim(sZH) <> '' then
        DM_DataBase.ADO_XQXX.FieldByName('RJBZ').AsBoolean := True;
      DM_DataBase.ADO_XQXX.Post;
    end;      
    Frm_LableGroup.Free;
  end else
  begin
    p_MessageBoxDlg('此订单不存在!','提示');
  end;
end;

{procedure TFra_XQCX.p_WriteGroup(iCartonID,iOrderID,iOrderType: Integer; sZH,sRJHDQ,sRJHDZ: string);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  i: integer;
begin
  sSqlData := 'Select * from DO_CartonLableGroupNum where F_iCartonInfoID=%d';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iCartonID]);
  SetLabelGroup(iOrderID,iOrderType,sZH,sRJHDQ,sRJHDZ);
  for i := 0 to Length(LabelGroup) -1 do
  begin
    if (LabelGroup[i].m_iOrderID = iOrderID) and (LabelGroup[i].m_iOrderType = iOrderType) then
    begin
      if (LabelGroup[i].m_sZH = '') and (LabelGroup[i].m_sRJHDQ = '') and (LabelGroup[i].m_sRJHDZ = '') then Continue;
      if not ADO_Rec.Eof then
      begin
        ADO_Rec.Edit;
        ADO_Rec.FieldByName('F_sZH').AsString :=  LabelGroup[i].m_sZH;
        ADO_Rec.FieldByName('F_sRJHDQ').AsString :=  LabelGroup[i].m_sRJHDQ;
        ADO_Rec.FieldByName('F_sRJHDZ').AsString :=  LabelGroup[i].m_sRJHDZ;
        ADO_Rec.FieldByName('F_iGroupID').AsInteger :=  LabelGroup[i].m_iGroupID;
        ADO_Rec.FieldByName('F_iCartonInfoID').AsInteger :=  iCartonID;

        ADO_Rec.Post;
        ADO_Rec.Next;
      end else
      begin
        ADO_Rec.Insert;
        ADO_Rec.FieldByName('F_sZH').AsString :=  LabelGroup[i].m_sZH;
        ADO_Rec.FieldByName('F_sRJHDQ').AsString :=  LabelGroup[i].m_sRJHDQ;
        ADO_Rec.FieldByName('F_sRJHDZ').AsString :=  LabelGroup[i].m_sRJHDZ;
        ADO_Rec.FieldByName('F_iGroupID').AsInteger :=  LabelGroup[i].m_iGroupID;
        ADO_Rec.FieldByName('F_iCartonInfoID').AsInteger :=  iCartonID;
        ADO_Rec.Post;
        ADO_Rec.Next;
      end;
    end;
  end;
  while not ADO_Rec.Eof do
  begin
    ADO_Rec.Delete
  end;



end;   }

procedure TFra_XQCX.dbg_xqxxTitleClick(Column: TColumnEh);
var
  i: Integer;
  bFH: Boolean;
  pMark: Pointer;
begin
  if Column.Index = 0 then
  begin
    bFH := False;
    with DM_DataBase.ADO_XQXX do
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

procedure TFra_XQCX.dbg_xqxxColumns7UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  nYl: Real;
  iZXS, iOrderID, iOrderType, iOrderCount: integer;
  sCPBH: string;
  sSqlData:string;
  ADOQ_Rec: TADOQuery;
  sTMBZ: string;
  iCXSL: Variant;
begin
  if TDBGridColumnEh(Sender).FieldName = 'CXSL' then
  begin
    sTMBZ := DM_DataBase.ADO_XQXX.FieldByName('TMBZ').AsString;
    iCXSL := Value;
  end else
  if TDBGridColumnEh(Sender).FieldName = 'TMBZ' then
  begin
    sTMBZ := Value;
    iCXSL := DM_DataBase.ADO_XQXX.FieldByName('CXSL').AsInteger;
  end;
  nYl := DM_DataBase.ADO_XQXX.FieldByName('YL').AsFloat;
  vRowField := DM_DataBase.ADO_XQXX.FieldByName('ZXS');
  sCPBH := DM_DataBase.ADO_XQXX.FieldByName('F_sCpbh').AsString;
  iOrderID := DM_DataBase.ADO_XQXX.FieldByName('OrderID').AsInteger;
  iOrderType := DM_DataBase.ADO_XQXX.FieldByName('OrderType').AsInteger;
  pMark := DM_DataBase.ADO_XQXX.GetBookmark;
  if (StrRight(sCPBH,3)<>'999') or (Trim(sTMBZ) = '套')then
  begin
    iZXS := Trunc (nYl*10000/iCXSL);     //总印量/每箱枚数 取整
    if nYl*10000 mod iCXSL > 0 then
      iZXS := iZXS + 1;
  end else
  begin
    sSqlData := 'Select 1 from DO_OrderApart where F_iOrderID=%d and F_tiOrderType=%d and IsNull(F_tiNJBZ,0)=0 and F_tiCXBZ = 0 ';
    ADOQ_Rec := DM_DataBase.OpenQuery(sSqlData,[iOrderID,iOrderType]);
    iOrderCount := ADOQ_Rec.RecordCount;
    iZXS := Trunc (nYl*10000/iCXSL);
    if iZXS mod iOrderCount > 0 then
      iZXS := Trunc (iZXS/iOrderCount)*iOrderCount + iOrderCount;
    ADOQ_Rec.Free;
  end;
  vZXS := iZXS;
  tmr_zxs.Enabled := True;
 { with DM_DataBase.ADO_XQXX do
  begin
    Edit;
    FieldByName('ZXS').AsInteger := iZXS;
    Post;
  end;   }
end;

procedure TFra_XQCX.tmr_zxsTimer(Sender: TObject);
var
  pBookMark: Pointer;
begin
  if vRowField = nil then Exit;
  with DM_DataBase.ADO_XQXX do
  begin
    pBookMark := GetBookmark;
    GotoBookmark(pMark);
    Edit;
    vRowField.AsInteger := vZXS;
    Post;
    GotoBookmark(pBookMark);
  end;
  vRowField := nil;
  tmr_zxs.Enabled := False;
end;

//按格式组合兑奖号段并返回
function TFra_XQCX.p_GetRJHD(sZH, sRJHDQ, sRJHDZ: string): string;
var
  i: Integer;
begin
  Result := '';
  if Trim(sZH)='' then Exit;
  for i := 1 to PosNum(sZH,',')+1 do
  begin
    Result := Result + PosCopy(sZH,',',i) +' ';
    Result := Result + PosCopy(sRJHDQ,',',i) + '-';
    Result := Result + PosCopy(sRJHDZ,',',i) + '; ';
  end;
end;

procedure TFra_XQCX.edt_rjhdqExit(Sender: TObject);
begin
  if (Ti_TxtFilter(Sender).Text <> '') and (not IsNum(Ti_TxtFilter(Sender).Text)) then
  begin
    p_MessageBoxDlg('字符无效,请输入数字!');
    Ti_TxtFilter(Sender).SetFocus;
  end;
end;

procedure TFra_XQCX.menu_ddmxClick(Sender: TObject);
var
  SelItem: TListItem;
  iType,iOrderID: integer;
begin
  if not DM_DataBase.ado_xqxx.Active then Exit;
  if DM_DataBase.ado_xqxx.FieldByName('OrderID').IsNull then
  begin
    Application.MessageBox('请选择订单!','提示',MB_ICONINFORMATION);
  end;
  iOrderID := DM_DataBase.ado_xqxx.FieldByName('OrderID').AsInteger;
  iType := DM_DataBase.ado_xqxx.FieldByName('OrderType').AsInteger;

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

procedure TFra_XQCX.pm_xqxxPopup(Sender: TObject);
var
  iType: integer;
begin
  iType := DM_DataBase.ado_xqxx.FieldByName('OrderType').AsInteger;
  //if menu_ddmxPic.Tag = c_Tag_MakeAllow then
  begin
    if iType = 1 then
      menu_ddmxPic.Visible := False
    else
      menu_ddmxPic.Visible := True;
  end;
end;

function TFra_XQCX.f_MakeAllow: Boolean;
var
  sSqlData, sCode: string;
  ADO_Rec: TADOQuery;
  iAllowID, iAllowCode: Integer;
begin
  Result := False;
  if LoginData.m_iAllowCode >= 0 then
  begin
    sCode := Format('''%s'',''%s'',''%s''',[c_Allow_FWDDTG,c_Allow_XQ_BCQR,c_Allow_XQ_BC]);
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
          if sCode = c_Allow_FWDDTG then
          begin
            menu_ddmxPic.Enabled := True;
            menu_ddmxPic.Tag := c_Tag_MakeAllow;
          end else
          if sCode = c_Allow_XQ_BCQR then
          begin
            btn_ok.Enabled := True;
            btn_ok.Tag := c_Tag_MakeAllow;
          end else
          if sCode = c_Allow_XQ_BC then
          begin
            btn_save.Enabled := True;
            btn_save.Tag := c_Tag_MakeAllow;
          end;
        end else
        begin
          if sCode = c_Allow_FWDDTG then
          begin
            menu_ddmxPic.Enabled := False;
            menu_ddmxPic.Tag := 0;
          end else
          if sCode = c_Allow_XQ_BCQR then
          begin
            btn_ok.Enabled := False;
            btn_ok.Tag := 0;
          end else
          if sCode = c_Allow_XQ_BC then
          begin
            btn_save.Enabled := False;
            btn_save.Tag := 0;
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


procedure TFra_XQCX.dbg_xqxxColumns0UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  pBookmark : Pointer;
  i: integer;
begin
  if btn_print.Visible then
  begin
    //if not vbXZUpdate then  Exit;
    edt_shrdz.Text := '';
    edt_shrxx.Text := '';
  {  if Value = True then
    begin
      with DM_DataBase do
      begin
        vbXZUpdate := False;
       // pBookmark := ADO_xqxx.GetBookmark;
        ADO_xqxx.FindFirst;
        for i := 0 to ADO_xqxx.RecordCount -1 do
        begin
          if ADO_xqxx.FindField('XZ').AsBoolean then
          begin
           // ADO_xqxx.Edit;
           // ADO_xqxx.FindField('XZ').AsBoolean := False;
           // ADO_xqxx.Post;
          end;
          if i < ADO_xqxx.RecordCount -1 then
            ADO_xqxx.FindNext;
        end;
        //ADO_xqxx.GotoBookmark(pBookmark);
        vbXZUpdate := True
      end;
      Value := True;
    end;   }
  end;
end;

{function TFra_XQCX.SetLabelGroup(iOrderID,iOrderType: Integer; sZH, sRJHDQ,
  sRJHDZ: string): Boolean;
var
  i, j, len: integer;
  b: Boolean;
begin
  Result := False;
  for i := 0 to Length(LabelGroup) -1 do
  begin
    if (LabelGroup[i].m_iOrderID = iOrderID) and  (LabelGroup[i].m_iOrderType = iOrderType) then
    begin
      LabelGroup[i].m_iOrderID := -1;
      LabelGroup[i].m_iOrderType := -1;
    end;
  end;
  for i := 1 to PosNum(sZH,',') + 1 do
  begin
    Len := Length(LabelGroup);
    for j := 0 to  Len -1 do
    begin
      b := False;
      if LabelGroup[j].m_iOrderID = -1 then
      begin
        LabelGroup[j].m_sZH        := PosCopy(sZH,',',i);
        LabelGroup[j].m_sRJHDQ     := PosCopy(sRJHDQ,',',i);
        LabelGroup[j].m_sRJHDZ     := PosCopy(sRJHDZ,',',i);
        LabelGroup[j].m_iOrderID   := iOrderID;
        LabelGroup[j].m_iOrderType := iOrderType;
        b := True;
        Break;
      end;
    end;
    if b then Continue;
    SetLength(LabelGroup,Len+1);
    LabelGroup[Len].m_sZH        := PosCopy(sZH,',',i);
    LabelGroup[Len].m_sRJHDQ     := PosCopy(sRJHDQ,',',i);
    LabelGroup[Len].m_sRJHDZ     := PosCopy(sRJHDZ,',',i);
    LabelGroup[Len].m_iOrderID   := iOrderID;
    LabelGroup[Len].m_iOrderType := iOrderType;
  end;
  Result := True;
end; }

procedure TFra_XQCX.btn_printB5Click(Sender: TObject);
var
  iOrderID, iOrderType,iDfbbz: Integer;
  sSqlData, sCPBH: string;
  i,n,iNJBZ: Integer;
  pBookmark: Pointer;
  ADO_Rec: TADOQuery;
  sText , sCaption ,AButtom ,BButtom: string;
begin
  Screen.Cursor := crHourGlass;
  with DM_DataBase do
  begin
    pBookmark := ADO_xqxx.GetBookmark;
    ADO_xqxx.FindFirst;
    n := 0;
    for i := 0 to ADO_xqxx.RecordCount -1 do
    begin
      if ADO_xqxx.FindField('XZ').AsBoolean then
      begin
        iOrderID := ADO_XQXX.FindField('OrderID').AsInteger;
        iOrderType := ADO_XQXX.FindField('OrderType').AsInteger;
        sCPBH := ADO_XQXX.FindField('F_sCpbh').AsString;
        inc(n);
      end;
      if i < ADO_xqxx.RecordCount -1 then
        ADO_xqxx.FindNext;
    end;
    ADO_xqxx.GotoBookmark(pBookmark);
  end;
  if n > 1 then
  begin
    p_MessageBoxDlg('一次只能选择一个订单进行打印!','提示');
    Screen.Cursor := crDefault;
    Exit;
  end;
  if n = 0 then
  begin
    Screen.Cursor := crDefault;
    p_MessageBoxDlg('请选择一个订单!','提示');
    Exit;
  end;  //iOrderID := DM_DataBase.ADO_XQXX.FieldByName('OrderID').AsInteger;
  //iOrderType := DM_DataBase.ADO_XQXX.FieldByName('OrderType').AsInteger;
  //-------判断是否含有内件,含有内件选择打印信封或内件-----------------------
  iNJBZ := 0;
  sSqlData := 'Select 1 from DO_OrderApart where F_iOrderID=%d and F_tiOrderType=%d and F_tiNJBZ=1 and F_tiCXBZ=0';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iOrderID,iOrderType]);
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    sText := '订单('+sCPBH+')含有内件,请选择打印信封还是内件：';
    sCaption := '提示';
    AButtom := '打印信封';
    BButtom := '打印内件';
    Screen.Cursor := crDefault;
    case f_SelectDlg(sText,sCaption,[AButtom,BButtom]) of
      1: iNJBZ := 0;
      2: iNJBZ := 1;
    else
      Exit
    end;
    Screen.Cursor := crHourGlass;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

  //----------------------------------------------------------------------------

  with DM_DataBase.ADO_Print do
  begin
    Close;
    sSqlData := 'exec p_CartonLablePrint %d,%d,''%s'',''%s'',%d ';
    SQL.Text := Format(sSqlData,[iOrderID,iOrderType,Trim(edt_shrxx.Text),Trim(edt_shrdz.Text),iNJBZ]);
    Open;
    if RecordCount = 0 then
    begin
      p_MessageBoxDlg('查找不到此订单数据!','提示');
      Screen.Cursor := crDefault;
      Exit;
    end;
    iDfbbz := FieldByName('DFBBZ').AsInteger;
  end;
//  p_SetPrint('BarCode1',);
  case iOrderType of
    0:
      begin
        if iDfbbz = 0 then
        begin
          rmr_CustomPritB5.PrepareReport;
          rmr_CustomPritB5.ShowReport;
        end else
        if iDfbbz = 1 then
        begin
          rmr_SellPritB5.PrepareReport;
          rmr_SellPritB5.ShowReport;
        end;
      end;
    1:
      begin
        rmr_SellPritB5.PrepareReport;
        rmr_SellPritB5.ShowReport;
      end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TFra_XQCX.btn_xgdyxxClick(Sender: TObject);
type
  TOrder = record
    m_sCPBH: string;
    m_iOrderID: integer;
    m_iOrderType: Integer;
    m_iDFBBZ: integer;
  end;
var
  iOrderID, iOrderType,iDfbbz: Integer;
  sSqlData: string;
  i,j,n,iNJBZ: Integer;
  pBookmark: Pointer;
  aOrderInfo: array of TOrder;
  aCustomID,aSellID: array of Integer;
  sCustomID,sSellID: string;
  ADO_Rec: TADOQuery;
begin
  with DM_DataBase do
  begin
    pBookmark := ADO_xqxx.GetBookmark;
    ADO_xqxx.FindFirst;
    n := 0;
    SetLength(aOrderInfo,0);
    SetLength(aCustomID,0);
    SetLength(aSellID,0);
    for i := 0 to ADO_xqxx.RecordCount -1 do
    begin
      if ADO_xqxx.FindField('XZ').AsBoolean then
      begin
        SetLength(aOrderInfo,Length(aOrderInfo)+1);
        aOrderInfo[Length(aOrderInfo)-1].m_sCPBH :=  ADO_XQXX.FindField('F_sCpbh').AsString;
        aOrderInfo[Length(aOrderInfo)-1].m_iOrderID:= ADO_XQXX.FindField('OrderID').AsInteger;
        aOrderInfo[Length(aOrderInfo)-1].m_iOrderType := ADO_XQXX.FindField('OrderType').AsInteger;
        aOrderInfo[Length(aOrderInfo)-1].m_iDFBBZ := ADO_XQXX.FindField('DFBBZ').AsInteger;
        case ADO_XQXX.FindField('OrderType').AsInteger of
          0:
          begin
            SetLength(aCustomID,Length(aCustomID)+1);
            aCustomID[Length(aCustomID)-1] :=  ADO_XQXX.FindField('OrderID').AsInteger;
          end;
          1:
          begin
            SetLength(aSellID,Length(aSellID)+1);
            aSellID[Length(aSellID)-1] :=  ADO_XQXX.FindField('OrderID').AsInteger;
          end;
          3:
          begin
            SetLength(aCustomID,Length(aCustomID)+1);
            aCustomID[Length(aCustomID)-1] :=  ADO_XQXX.FindField('OrderID').AsInteger;
          end;
        end;
      end;
      if i < ADO_xqxx.RecordCount -1 then
        ADO_xqxx.FindNext;
    end;
    ADO_xqxx.GotoBookmark(pBookmark);
  end;
  if  Length(aOrderInfo) = 0 then
  begin
    p_MessageBoxDlg('请选择数据!');
    Exit;
  end;
  //判断订单类型是否一致
  iOrderType := aOrderInfo[0].m_iOrderType;
  iDfbbz := aOrderInfo[0].m_iDFBBZ;
  for i := 1 to Length(aOrderInfo) -1 do
  begin
    if (aOrderInfo[i].m_iOrderType <> iOrderType) or  (aOrderInfo[i].m_iDFBBZ <> iDfbbz) then
    begin
      p_MessageBoxDlg('失败,所选订单产品类型必需一致!');
      Exit;
    end;
  end;
  //判断订单类型(已用上面替代)
{  n := 0;
  sCustomID := '';
  for i := 0 to Length(aCustomID) -1 do
  begin
    sCustomID := ',' +IntToStr(aCustomID[i]);
    Inc(n);
  end;
  if sCustomID <> '' then
  begin
    sCustomID := Copy(sCustomID,2,Length(sCustomID));
    sSqlData := 'select 1 from DO_OrderApart where F_iOrderID in (%s) and F_tiOrderType=0 and F_tiNJBZ=0 and F_tiCXBZ=0';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sCustomID]);
    if Assigned(ADO_Rec) then
    begin
      if n <> ADO_Rec.RecordCount then
      begin
        p_MessageBoxDlg('失败,所选订单产品类型必需一致!');
        exit;
      end;
    end else
      Exit;
  end;

  n := 0;
  sSellID := '';
  for i := 0 to Length(aSellID) -1 do
  begin
    sSellID := ',' +IntToStr(aSellID[i]);
    Inc(n);
  end;
  if sSellID <> '' then
  begin
    sSellID := Copy(sSellID,2,Length(sSellID));
    sSqlData := 'select 1 from DO_OrderApart where F_iOrderID in (%s) and F_tiOrderType=1 and F_tiNJBZ=0 and F_tiCXBZ=0';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sSellID]);
    if Assigned(ADO_Rec) then
    begin
      if n <> ADO_Rec.RecordCount then
      begin
        p_MessageBoxDlg('失败,所选订单产品类型必需一致!');
        exit;
      end;
    end else
      Exit;
  end;
}
  Frm_XQDYXG := TFrm_XQDYXG.Create(Self);
  // 按CustomID升序快速排序后添加
  if Length(aCustomID) > 0 then
    quicksort(aCustomID);
  for i := 0 to Length(aCustomID) -1 do
  begin
    for j := 0 to Length(aOrderInfo) -1 do
    begin
      if (aOrderInfo[j].m_iOrderID = aCustomID[i]) and (aOrderInfo[j].m_iOrderType=0) then
      begin
        iOrderID := aOrderInfo[j].m_iOrderID;
        iOrderType := aOrderInfo[j].m_iOrderType;
        inc(n);
        with DM_DataBase.ADO_Print do
        begin
          Close;
          sSqlData := 'exec p_CartonLablePrint %d,%d,''%s'',''%s'' ';
          SQL.Text := Format(sSqlData,[iOrderID,iOrderType,Trim(edt_shrxx.Text),Trim(edt_shrdz.Text),iNJBZ]);
          Open;
          if RecordCount = 0 then
          begin
            p_MessageBoxDlg('查找不到此订单数据!','提示');
            Screen.Cursor := crDefault;
            Exit;
          end;
          iDfbbz := FieldByName('DFBBZ').AsInteger;
          Frm_XQDYXG.ReadDataXQDYXG(DM_DataBase.ADO_Print);
        end;
      end;
    end;
  end;
  // 按SellID升序快速排序后添加
  if Length(aSellID) > 0 then
    quicksort(aSellID);
  for i := 0 to Length(aSellID) -1 do
  begin
    for j := 0 to Length(aOrderInfo) -1 do
    begin
      if (aOrderInfo[j].m_iOrderID = aSellID[i]) and (aOrderInfo[j].m_iOrderType=1) then
      begin
        iOrderID := aOrderInfo[j].m_iOrderID;
        iOrderType := aOrderInfo[j].m_iOrderType;
        inc(n);
        with DM_DataBase.ADO_Print do
        begin
          Close;
          sSqlData := 'exec p_CartonLablePrint %d,%d,''%s'',''%s'' ';
          SQL.Text := Format(sSqlData,[iOrderID,iOrderType,Trim(edt_shrxx.Text),Trim(edt_shrdz.Text)]);
          Open;
          if RecordCount = 0 then
          begin
            p_MessageBoxDlg('查找不到此订单数据!','提示');
            Screen.Cursor := crDefault;
            Exit;
          end;
          iDfbbz := FieldByName('DFBBZ').AsInteger;
          Frm_XQDYXG.ReadDataXQDYXG(DM_DataBase.ADO_Print);
        end;
      end;
    end;
  end;
  Frm_XQDYXG.ShowModal;
  Frm_XQDYXG.Free;
end;

procedure TFra_XQCX.btn_gxrjhdClick(Sender: TObject);
var
  sOrderID,sOrderType,sCustomID,sSellID: string;
  sSqlData, sTMBZ, sZH, sRJHDQ, sRJHDZ, sRJHD: string;
  i,n: integer;
  ADO_Custom,ADO_Sell, ADO_Rec: TADOQuery;
  pBookmark: Pointer;
begin
  with DM_DataBase do
  begin
    if ADO_xqxx.RecordCount > 0 then
    begin
      //mte_xqxx.FindFirst;
      sCustomID := '';
      sSellID := '';
      n := 0;
      pBookmark := ADO_xqxx.GetBookmark;
      ADO_xqxx.FindFirst;
      for i := 0 to ADO_xqxx.RecordCount -1 do
      begin
        if ADO_xqxx.FindField('XZ').AsBoolean then
        begin
          case ADO_xqxx.FindField('OrderType').AsInteger of
            0: sCustomID := sCustomID + ',' + ADO_xqxx.FindField('OrderID').AsString;
            1: sSellID := sSellID + ',' + ADO_xqxx.FindField('OrderID').AsString;
          end;
          //--------更新兑奖号段-----------------------------
          sSqlData := 'select dbo.f_GetRJHD(%d,%d) RJHD ';
          ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[ADO_xqxx.FindField('OrderID').AsInteger,ADO_xqxx.FindField('OrderType').AsInteger]);
          if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
          begin
            sRJHD := ADO_Rec.FieldByName('RJHD').AsString;
            sZH := PosCopy(sRJHD,';',1);
            sRJHDQ := PosCopy(sRJHD,';',2);
            sRJHDZ := PosCopy(sRJHD,';',3);
            ADO_XQXX.Edit;
            if sZH <> '' then
              ADO_xqxx.FindField('RJBZ').AsBoolean := True;
            ADO_xqxx.FindField('ZH').AsString := sZH;
            ADO_xqxx.FindField('RJHDQ').AsString := sRJHDQ;
            ADO_xqxx.FindField('RJHDZ').AsString := sRJHDZ;
            ADO_XQXX.Post;
          end;
          if Assigned(ADO_Rec) then
            ADO_Rec.Free;
          //----------------------------------------------------

          inc(n);
        end;
        if i < ADO_xqxx.RecordCount -1 then
          ADO_xqxx.FindNext;
      end;
      if n = 0 then
      begin
        ADO_xqxx.GotoBookmark(pBookmark);
        p_MessageBoxDlg('请选择要保存确认的订单!');
        Exit;
      end;
      ADO_xqxx.GotoBookmark(pBookmark);
      if p_MessageBoxDlg('是否保存更新数据?','更新成功!',MB_ICONINFORMATION + MB_YESNO)=IDYES then
      begin
        btn_ok.Click;
      end;
    end;
  end;
end;

procedure TFra_XQCX.btn_exportClick(Sender: TObject);
begin
  if SavePath.Execute then
  begin
    if (SavePath.FileName <> '') then
      if UpperCase(Copy(SavePath.FileName,Length(SavePath.FileName)-4,Length(SavePath.FileName))) = UpperCase('.xls') then
        SavePath.FileName := Copy(SavePath.FileName,1,Length(SavePath.FileName)-4);
    Screen.Cursor := crHourGlass;
    try
      SaveDBGridEhToExportFile(TDBGridEhExportAsXLS,dbg_xqxx, SavePath.FileName,True);
    except

    end;
    Screen.Cursor := crDefault;
    p_MessageBoxDlg('导出成功!')
  end;
end;

function TFra_XQCX.f_IsRJHDPP(iYL: Integer): Boolean;
var
  i,iNum: Integer;
  sRJHDQ,sRJHDZ: string;
begin
  iNum := 0;
  for i := 0 to Length(LabelGroup) -1 do
  begin
    if LabelGroup[i].m_iOrderID >0 then
    begin
      if LabelGroup[i].m_sRJHDZ = '000000' then
        iNum := iNum+ 1000000 - StrToNum(LabelGroup[i].m_sRJHDQ)+1
      else
        iNum := iNum + StrToNum(LabelGroup[i].m_sRJHDZ) - StrToNum(LabelGroup[i].m_sRJHDQ)+1;
    end;
  end;
  Result := iNum = iYL;
end;

constructor TFra_XQCX.Create(AOwner: TComponent);
begin
  inherited;
//  BorderStyle := bsNone;
//  Hide;
//  Parent := TWinControl(AOwner);
  cbb_xpl.ItemIndex := 0;     //小批量标志
  cbb_xpl.Enabled := True;     //小批量
  case LoginData.m_iUserType of
    c_User:;
    c_Admin:;
    c_User_Small:
      cbb_xpl.ItemIndex := 2;
    c_Admin_Small:
      cbb_xpl.ItemIndex := 2;
    c_SuperAdmin:;
  end;
//  Align := alClient;
  {FraShow;
  Application.ProcessMessages;
  btn_cx.Click;}
end;

procedure TFra_XQCX.btn_BQPrintClick(Sender: TObject);
var
  pBookmark: Pointer;
  n,i,iOrderID,iOrderType,iMZBZ,iZXS,iCBSL,iCXSL,iYL: Integer;
  sCPBH,sTXM,sTMBZ: string;
begin
  Screen.Cursor := crHourGlass;
  with DM_DataBase do
  begin
    pBookmark := ADO_xqxx.GetBookmark;
    ADO_xqxx.FindFirst;
    n := 0;
    for i := 0 to ADO_xqxx.RecordCount -1 do
    begin
      if ADO_xqxx.FindField('XZ').AsBoolean then
      begin
        iOrderID := ADO_XQXX.FindField('OrderID').AsInteger;
        iOrderType := ADO_XQXX.FindField('OrderType').AsInteger;
        sCPBH := ADO_XQXX.FindField('F_sCpbh').AsString;
        sTMBZ := ADO_xqxx.FindField('TMBZ').AsString;
        iZXS := ADO_xqxx.FindField('ZXS').AsInteger;
        iCXSL := ADO_xqxx.FindField('CXSL').AsInteger;
        iCBSL := ADO_xqxx.FindField('CBSL').AsInteger;
        iYL := ADO_xqxx.FindField('YL').AsVariant*10000;
        inc(n);
      end;
      if i < ADO_xqxx.RecordCount -1 then
        ADO_xqxx.FindNext;
    end;
    ADO_xqxx.GotoBookmark(pBookmark);
  end;
  if n > 1 then
  begin
    p_MessageBoxDlg('一次只能选择一个订单进行打印!','提示');
    Screen.Cursor := crDefault;
    Exit;
  end;
  if n = 0 then
  begin
    Screen.Cursor := crDefault;
    p_MessageBoxDlg('请选择一个订单!','提示');
    Exit;
  end;

  if  Trim(sTMBZ) = '枚' then
    iMZBZ := 0
  else if  Trim(sTMBZ) = '套' then
    iMZBZ := 1;
  sTXM := f_GetTXM(iOrderID,iOrderType,iMZBZ);
  Frm_XQBQInfo := TFrm_XQBQInfo.Create(Self,[sCPBH,iOrderID,iOrderType,sTXM,iZXS,iCXSL,iCBSL,iYL,iMZBZ]);
  Frm_XQBQInfo.ShowModal;
  Frm_XQBQInfo.Free;
//  A_Prn_Text_TrueType(50, 20, 30, 'Arial', 1, 400, 0, 0, 0, 'TrueType Font', Edt_Address.Text, 1);//save in ram.
//
//  A_Prn_Barcode(50, 60, 1, 'E', 2, 2, 80, 'B', 1, c_BarCode);
//
//  A_Prn_Text_TrueType(50, 160, 30, 'Arial', 1, 400, 0, 0, 0, 'TrueType Font2', Edt_Name.Text, 1);//save in ram.
//  // output.
//  A_Print_Out(1, 1, 1, 1);   // copy 2.
//
//  // close port.
//  A_ClosePrn();
  Screen.Cursor := crDefault;
end;

end.






