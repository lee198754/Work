unit uFra_XQCX7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzPanel, StdCtrls, ExtCtrls, GridsEh,
  DBGridEh, RzRadChk, ComCtrls, RzDTP, RzButton, ButtonEdit, RzCmboBx,
  iComboBox, DBGridEhGrouping, DB, ADODB, MemTableDataEh, DataDriverEh,
  MemTableEh, Grids, iGrid, RM_Dataset, RM_System, RM_Common, RM_Class,
  RM_BarCode;

type
  TFraXQCX = class(TFrame)
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
    Button1: TButton;
    btn_print: TRzBitBtn;
    ADO_xqxx: TADOQuery;
    ds_xqxx: TDataSource;
    mte_xqxx: TMemTableEh;
    dsd_xqxx: TSQLDataDriverEh;
    rmr_CustomPrit: TRMReport;
    rmdb_CartonLablePrint: TRMDBDataSet;
    rmr_SellPrit: TRMReport;
    procedure btn_cxClick(Sender: TObject);
    procedure mte_xqxxAfterEdit(DataSet: TDataSet);
    procedure btn_saveClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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
  private
    { Private declarations }
    vMYTS: Integer;     //当前每页条数
    vYs: integer;       //当前页数
    vSqlData: string;
    bBlank : boolean;
    procedure CartonLablePrint;
    procedure p_SetPrint(Rmrprt:TRMReport;sName, sValue: string;sType: integer=0);
    function p_GetPrint(Rmrprt:TRMReport;sName: string;sType: integer=0): string;
    procedure p_WriteGroup(iCartonID,iOrderID,iOrderType: Integer; sZH,sRJHDQ,sRJHDZ: string);
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

uses
  uPub_Text,PubStr,uDataInterface,uPubType,uFrm_LableGroup;
{$R *.dfm}

{ TFraXQCX }


procedure TFraXQCX.btn_cxClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  sCPBH,sGDH, sZH, sJCq,sJCz,sRJHDQ,sRJHDZ: string;
  iFHBZ,iQRBZ,iYS,iMYTS,n: Integer;
begin
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
  sSqlData := Format('p_xqcx ''%s'',''%s'',''%s'',''%s'',''%s'',%d,%d,''%s'',''%s'',%d,%d'
    ,[sCPBH,sGDH,sZH,sRJHDQ,sRJHDZ,iQRBZ,iFHBZ,sJCq,sJCz,iYS,iMYTS]);
//  ADO_Rec := Frm_DataInterface.OpenQuery(sSqlData,[sCPBH,sGDH,sZH,sRJHDQ,sRJHDZ,iQRBZ,iFHBZ,sJCq,sJCz,iYS,iMYTS]);
  with Frm_DataInterface do
  begin
    ado_xqxx.Close;
    ado_xqxx.SQL.Text := sSqlData;
    ado_xqxx.Open;
    //mte_xqxx.Close;
    //mte_xqxx.Open;
  end;
  vSqlData := Format('p_xqcx ''%s'',''%s'',''%s'',''%s'',''%s'',%d,%d,''%s'',''%s'''
    ,[sCPBH,sGDH,sZH,sRJHDQ,sRJHDZ,iQRBZ,iFHBZ,sJCq,sJCz])+',%d,%d';
//  ReadDataXQ(ADO_Rec);
//  ADO_Rec.Free;
  n := 0;
  if Frm_DataInterface.ADO_XQXX.RecordCount > 0 then
  begin
    n := Frm_DataInterface.ADO_XQXX.FieldByName('Count').AsInteger;
//  n := Frm_DataInterface.ADO_DataRec.RecordCount;
  end;
  gb_dd.Caption := '订单  总数:'+IntToStr(n)+'条';
  lab_zys.Tag := n div vMYTS;
  if n mod vMYTS > 0 then
    lab_zys.Tag := lab_zys.Tag +1;
  lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);
//  gb_dd.Caption := '订单  总数:'+IntToStr(n)+'条';
  btn_cx.Caption := '查询';
  SetLength(LabelGroup,0);
  case cbb_qrbz.ItemIndex of
    0:btn_print.Visible := False;
    1:btn_print.Visible := True;
  end;
end;

procedure TFraXQCX.FraShow;
begin

end;

procedure TFraXQCX.mte_xqxxAfterEdit(DataSet: TDataSet);
begin
  mte_xqxx.FieldByName('XZ').AsBoolean := True;
end;

procedure TFraXQCX.btn_saveClick(Sender: TObject);
var
  sOrderID,sOrderType,sCustomID,sSellID: string;
  sSqlData: string;
  i,n: integer;
  ADO_Custom,ADO_Sell,ADO_Rec: TADOQuery;
  pBookmark: Pointer;
begin
  with Frm_DataInterface do
  begin
    if ADO_xqxx.RecordCount > 0 then
    begin
      //mte_xqxx.FindFirst;
      sCustomID := '';
      sSellID := '';
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
      if sCustomID <> '' then
      begin
        sCustomID := Copy(sCustomID,2,Length(sCustomID));
      end else
        sCustomID := '-1';
      sSqlData := 'Select * from DO_CartonLableInfo where F_tiOrderType = 0 and F_iOrderID in (%s)';
      ADO_Custom := Frm_DataInterface.OpenQuery(sSqlData,[sCustomID]);
      if sSellID <> '' then
      begin
        sSellID := Copy(sCustomID,2,Length(sCustomID));
      end else
        sSellID := '-1';
      sSqlData := 'Select * from DO_CartonLableInfo where F_tiOrderType = 1 and F_iOrderID in (%s)';
      ADO_Sell := Frm_DataInterface.OpenQuery(sSqlData,[sSellID]);
      ADO_xqxx.FindFirst;
      for i := 0 to ADO_xqxx.RecordCount -1 do
      begin
        if ADO_xqxx.FindField('XZ').AsBoolean then
        begin
          ADO_xqxx.Edit;
          ADO_xqxx.FindField('XZ').AsBoolean := False;
          ADO_xqxx.Post;
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
                    ADO_Custom.FieldByName('F_sZH').AsString := ADO_xqxx.FindField('ZH').AsString;
                    ADO_Custom.FieldByName('F_sRJHDQ').AsString := ADO_xqxx.FindField('RJHDQ').AsString;
                    ADO_Custom.FieldByName('F_sRJHDZ').AsString := ADO_xqxx.FindField('RJHDZ').AsString;
                    ADO_Custom.FieldByName('F_nYL').AsFloat := ADO_xqxx.FindField('YL').AsFloat;
                    ADO_Custom.FieldByName('F_iCXSL').AsInteger := ADO_xqxx.FindField('CXSL').AsInteger;
                    ADO_Custom.FieldByName('F_iZXS').AsInteger := ADO_xqxx.FindField('ZXS').AsInteger;
                    ADO_Custom.FieldByName('F_sTMBZ').AsString := ADO_xqxx.FindField('TMBZ').AsString;
                    ADO_Custom.FieldByName('F_nFJGYF').AsFloat := ADO_xqxx.FindField('FJGYF').AsFloat;
                    ADO_Custom.FieldByName('F_sFHFS').AsString := ADO_xqxx.FindField('FHFS').AsString;
                    ADO_Custom.FieldByName('F_sBZ').AsString := ADO_xqxx.FindField('BZ').AsString;
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
                  ADO_Custom.FieldByName('F_sZH').AsString := ADO_xqxx.FindField('ZH').AsString;
                  ADO_Custom.FieldByName('F_sRJHDQ').AsString := ADO_xqxx.FindField('RJHDQ').AsString;
                  ADO_Custom.FieldByName('F_sRJHDZ').AsString := ADO_xqxx.FindField('RJHDZ').AsString;
                  ADO_Custom.FieldByName('F_nYL').AsFloat := ADO_xqxx.FindField('YL').AsFloat;
                  ADO_Custom.FieldByName('F_iCXSL').AsInteger := ADO_xqxx.FindField('CXSL').AsInteger;
                  ADO_Custom.FieldByName('F_iZXS').AsInteger := ADO_xqxx.FindField('ZXS').AsInteger;
                  ADO_Custom.FieldByName('F_sTMBZ').AsString := ADO_xqxx.FindField('TMBZ').AsString;
                  ADO_Custom.FieldByName('F_nFJGYF').AsFloat := ADO_xqxx.FindField('FJGYF').AsFloat;
                  ADO_Custom.FieldByName('F_sFHFS').AsString := ADO_xqxx.FindField('FHFS').AsString;
                  ADO_Custom.FieldByName('F_sBZ').AsString := ADO_xqxx.FindField('BZ').AsString;
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
                    ADO_Sell.FieldByName('F_bRJBZ').AsInteger := ADO_xqxx.FindField('RJBZ').AsInteger;
                    ADO_Sell.FieldByName('F_sZH').AsString := ADO_xqxx.FindField('ZH').AsString;
                    ADO_Sell.FieldByName('F_sRJHDQ').AsString := ADO_xqxx.FindField('RJHDQ').AsString;
                    ADO_Sell.FieldByName('F_sRJHDZ').AsString := ADO_xqxx.FindField('RJHDZ').AsString;
                    ADO_Sell.FieldByName('F_nYL').AsFloat := ADO_xqxx.FindField('YL').AsFloat;
                    ADO_Sell.FieldByName('F_iCXSL').AsInteger := ADO_xqxx.FindField('CXSL').AsInteger;
                    ADO_Sell.FieldByName('F_iZXS').AsInteger := ADO_xqxx.FindField('ZXS').AsInteger;
                    ADO_Sell.FieldByName('F_sTMBZ').AsString := ADO_xqxx.FindField('TMBZ').AsString;
                    ADO_Sell.FieldByName('F_nFJGYF').AsFloat := ADO_xqxx.FindField('FJGYF').AsFloat;
                    ADO_Sell.FieldByName('F_sFHFS').AsString := ADO_xqxx.FindField('FHFS').AsString;
                    ADO_Sell.FieldByName('F_sBZ').AsString := ADO_xqxx.FindField('BZ').AsString;
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
                  ADO_Sell.FieldByName('F_bRJBZ').AsInteger := ADO_xqxx.FindField('RJBZ').AsInteger;
                  ADO_Sell.FieldByName('F_sZH').AsString := ADO_xqxx.FindField('ZH').AsString;
                  ADO_Sell.FieldByName('F_sRJHDQ').AsString := ADO_xqxx.FindField('RJHDQ').AsString;
                  ADO_Sell.FieldByName('F_sRJHDZ').AsString := ADO_xqxx.FindField('RJHDZ').AsString;
                  ADO_Sell.FieldByName('F_nYL').AsFloat := ADO_xqxx.FindField('YL').AsFloat;
                  ADO_Sell.FieldByName('F_iCXSL').AsInteger := ADO_xqxx.FindField('CXSL').AsInteger;
                  ADO_Sell.FieldByName('F_iZXS').AsInteger := ADO_xqxx.FindField('ZXS').AsInteger;
                  ADO_Sell.FieldByName('F_sTMBZ').AsString := ADO_xqxx.FindField('TMBZ').AsString;
                  ADO_Sell.FieldByName('F_nFJGYF').AsFloat := ADO_xqxx.FindField('FJGYF').AsFloat;
                  ADO_Sell.FieldByName('F_sFHFS').AsString := ADO_xqxx.FindField('FHFS').AsString;
                  ADO_Sell.FieldByName('F_sBZ').AsString := ADO_xqxx.FindField('BZ').AsString;
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
      ADO_xqxx.GotoBookmark(pBookmark);
    end;
  end;
  btn_cx.Click;
end;

procedure TFraXQCX.Button1Click(Sender: TObject);
var
  i,n: integer;
  sCustomID,sSellID: string;
  pBookmark: Pointer;
begin
  with Frm_DataInterface do
  begin
    pBookmark := mte_xqxx.GetBookmark;
    mte_xqxx.FindFirst;
    for i := 0 to mte_xqxx.RecordCount -1 do
    begin
      if mte_xqxx.FieldByName('XZ').AsBoolean then
      begin
        case mte_xqxx.FieldByName('OrderType').AsInteger of
          0: sCustomID := sCustomID + ',' + mte_xqxx.FieldByName('OrderID').AsString;
          1: sSellID := sSellID + ',' + mte_xqxx.FieldByName('OrderID').AsString;
        end;
        inc(n);
      end;
      if i < mte_xqxx.RecordCount -1 then
        mte_xqxx.Next;
      if mte_xqxx.FindField('XZ').AsBoolean then
      begin
        case mte_xqxx.FindField('OrderType').AsInteger of
          0: sCustomID := sCustomID + ',' + mte_xqxx.FindField('OrderID').AsString;
          1: sSellID := sSellID + ',' + mte_xqxx.FindField('OrderID').AsString;
        end;
        inc(n);
      end;
      if i < mte_xqxx.RecordCount -1 then
        mte_xqxx.FindNext;

    end;
    mte_xqxx.GotoBookmark(pBookmark);
  end;

end;

procedure TFraXQCX.btn_okClick(Sender: TObject);
var
  sOrderID,sOrderType,sCustomID,sSellID: string;
  sSqlData: string;
  i,n: integer;
  ADO_Custom,ADO_Sell: TADOQuery;
begin
  with Frm_DataInterface do
  begin
    if ADO_xqxx.RecordCount > 0 then
    begin
      mte_xqxx.FindFirst;
      sCustomID := '';
      sSellID := '';
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
      if sCustomID <> '' then
      begin
        sCustomID := Copy(sCustomID,2,Length(sCustomID));
      end else
        sCustomID := '-1';
      sSqlData := 'Select * from DO_CartonLableInfo where F_tiOrderType = 0 and F_iOrderID in (%s)';
      ADO_Custom := Frm_DataInterface.OpenQuery(sSqlData,[sCustomID]);
      if sSellID <> '' then
      begin
        sSellID := Copy(sCustomID,2,Length(sCustomID));
      end else
        sSellID := '-1';
      sSqlData := 'Select * from DO_CartonLableInfo where F_tiOrderType = 1 and F_iOrderID in (%s)';
      ADO_Sell := Frm_DataInterface.OpenQuery(sSqlData,[sSellID]);
      ADO_xqxx.FindFirst;
      for i := 0 to ADO_xqxx.RecordCount -1 do
      begin
        if ADO_xqxx.FindField('XZ').AsBoolean then
        begin
          ADO_xqxx.Edit;
          ADO_xqxx.FindField('XZ').AsBoolean := False;
          ADO_xqxx.Post;
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
                    ADO_Custom.FieldByName('F_sZH').AsString := ADO_xqxx.FindField('ZH').AsString;
                    ADO_Custom.FieldByName('F_sRJHDQ').AsString := ADO_xqxx.FindField('RJHDQ').AsString;
                    ADO_Custom.FieldByName('F_sRJHDZ').AsString := ADO_xqxx.FindField('RJHDZ').AsString;
                    ADO_Custom.FieldByName('F_nYL').AsFloat := ADO_xqxx.FindField('YL').AsFloat;
                    ADO_Custom.FieldByName('F_iCXSL').AsInteger := ADO_xqxx.FindField('CXSL').AsInteger;
                    ADO_Custom.FieldByName('F_iZXS').AsInteger := ADO_xqxx.FindField('ZXS').AsInteger;
                    ADO_Custom.FieldByName('F_sTMBZ').AsString := ADO_xqxx.FindField('TMBZ').AsString;
                    ADO_Custom.FieldByName('F_nFJGYF').AsFloat := ADO_xqxx.FindField('FJGYF').AsFloat;
                    ADO_Custom.FieldByName('F_sFHFS').AsString := ADO_xqxx.FindField('FHFS').AsString;
                    ADO_Custom.FieldByName('F_sBZ').AsString := ADO_xqxx.FindField('BZ').AsString;
                    ADO_Custom.FieldByName('F_iStatus').AsInteger := 1;
                    ADO_Custom.Post;
                    p_WriteGroup(ADO_Custom.FieldByName('F_iID').AsInteger,
                      ADO_Custom.FieldByName('F_iOrderID').AsInteger,ADO_Custom.FieldByName('F_tiOrderType').AsInteger,
                      ADO_Custom.FieldByName('F_sZH').AsString,ADO_Sell.FieldByName('F_sRJHDQ').AsString,
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
                  ADO_Custom.FieldByName('F_sZH').AsString := ADO_xqxx.FindField('ZH').AsString;
                  ADO_Custom.FieldByName('F_sRJHDQ').AsString := ADO_xqxx.FindField('RJHDQ').AsString;
                  ADO_Custom.FieldByName('F_sRJHDZ').AsString := ADO_xqxx.FindField('RJHDZ').AsString;
                  ADO_Custom.FieldByName('F_nYL').AsFloat := ADO_xqxx.FindField('YL').AsFloat;
                  ADO_Custom.FieldByName('F_iCXSL').AsInteger := ADO_xqxx.FindField('CXSL').AsInteger;
                  ADO_Custom.FieldByName('F_iZXS').AsInteger := ADO_xqxx.FindField('ZXS').AsInteger;
                  ADO_Custom.FieldByName('F_sTMBZ').AsString := ADO_xqxx.FindField('TMBZ').AsString;
                  ADO_Custom.FieldByName('F_nFJGYF').AsFloat := ADO_xqxx.FindField('FJGYF').AsFloat;
                  ADO_Custom.FieldByName('F_sFHFS').AsString := ADO_xqxx.FindField('FHFS').AsString;
                  ADO_Custom.FieldByName('F_sBZ').AsString := ADO_xqxx.FindField('BZ').AsString;
                  ADO_Custom.FieldByName('F_iStatus').AsInteger := 1;
                  ADO_Custom.Post;
                  p_WriteGroup(ADO_Custom.FieldByName('F_iID').AsInteger,
                    ADO_Custom.FieldByName('F_iOrderID').AsInteger,ADO_Custom.FieldByName('F_tiOrderType').AsInteger,
                    ADO_Custom.FieldByName('F_sZH').AsString,ADO_Sell.FieldByName('F_sRJHDQ').AsString,
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
                    ADO_Sell.FieldByName('F_sZH').AsString := ADO_xqxx.FindField('ZH').AsString;
                    ADO_Sell.FieldByName('F_sRJHDQ').AsString := ADO_xqxx.FindField('RJHDQ').AsString;
                    ADO_Sell.FieldByName('F_sRJHDZ').AsString := ADO_xqxx.FindField('RJHDZ').AsString;
                    ADO_Sell.FieldByName('F_nYL').AsFloat := ADO_xqxx.FindField('YL').AsFloat;
                    ADO_Sell.FieldByName('F_iCXSL').AsInteger := ADO_xqxx.FindField('CXSL').AsInteger;
                    ADO_Sell.FieldByName('F_iZXS').AsInteger := ADO_xqxx.FindField('ZXS').AsInteger;
                    ADO_Sell.FieldByName('F_sTMBZ').AsString := ADO_xqxx.FindField('TMBZ').AsString;
                    ADO_Sell.FieldByName('F_nFJGYF').AsFloat := ADO_xqxx.FindField('FJGYF').AsFloat;
                    ADO_Sell.FieldByName('F_sFHFS').AsString := ADO_xqxx.FindField('FHFS').AsString;
                    ADO_Sell.FieldByName('F_sBZ').AsString := ADO_xqxx.FindField('BZ').AsString;
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
                  ADO_Sell.FieldByName('F_sZH').AsString := ADO_xqxx.FindField('ZH').AsString;
                  ADO_Sell.FieldByName('F_sRJHDQ').AsString := ADO_xqxx.FindField('RJHDQ').AsString;
                  ADO_Sell.FieldByName('F_sRJHDZ').AsString := ADO_xqxx.FindField('RJHDZ').AsString;
                  ADO_Sell.FieldByName('F_nYL').AsFloat := ADO_xqxx.FindField('YL').AsFloat;
                  ADO_Sell.FieldByName('F_iCXSL').AsInteger := ADO_xqxx.FindField('CXSL').AsInteger;
                  ADO_Sell.FieldByName('F_iZXS').AsInteger := ADO_xqxx.FindField('ZXS').AsInteger;
                  ADO_Sell.FieldByName('F_sTMBZ').AsString := ADO_xqxx.FindField('TMBZ').AsString;
                  ADO_Sell.FieldByName('F_nFJGYF').AsFloat := ADO_xqxx.FindField('FJGYF').AsFloat;
                  ADO_Sell.FieldByName('F_sFHFS').AsString := ADO_xqxx.FindField('FHFS').AsString;
                  ADO_Sell.FieldByName('F_sBZ').AsString := ADO_xqxx.FindField('BZ').AsString;
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

procedure TFraXQCX.lab_ts50Click(Sender: TObject);
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
  Frm_DataInterface.ADO_XQXX.Close;
  sSqlData := Format(vSqlData,[1,vMYTS]);
  Frm_DataInterface.ADO_XQXX.SQL.Text :=  sSqlData;
  Frm_DataInterface.ADO_XQXX.Open;
//  Frm_DataInterface.mte_FHCX.Close;
//  Frm_DataInterface.mte_FHCX.Open;
  LabFontClear(lab_ts50);
  LabFontClear(lab_ts100);
  LabFontClear(lab_ts200);
  LabFontClear(lab_ts500);
  TLabel(Sender).Font.Color :=  clBlack;
  TLabel(Sender).Font.Size := 10;
  TLabel(Sender).Font.Style := [fsBold];
  TLabel(Sender).Cursor := crDefault;
  vYs := 1;
  if Frm_DataInterface.ADO_XQXX.RecordCount > 0 then
  begin
    n := Frm_DataInterface.ADO_XQXX.FieldByName('Count').AsInteger;
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);
  end;
end;

procedure TFraXQCX.lab_firstClick(Sender: TObject);
begin
  if vYs = 1 then Exit;
  edt_ys.Text := '1';
  btn_go.Click;
end;

procedure TFraXQCX.lab_upClick(Sender: TObject);
begin
  if vYs > 1 then
  begin
    edt_ys.Text := IntToStr(vYs -1);
    btn_go.Click;
  end;
end;

procedure TFraXQCX.lab_downClick(Sender: TObject);
begin
  if vYs < lab_zys.Tag then
  begin
    edt_ys.Text := IntToStr(vYs +1);
    btn_go.Click;
  end;
end;

procedure TFraXQCX.lab_lastClick(Sender: TObject);
begin
  if vYs = lab_zys.Tag then Exit;
  edt_ys.Text := IntToStr(lab_zys.Tag);
  btn_go.Click;

end;

procedure TFraXQCX.btn_goClick(Sender: TObject);
var
  iYs,n: Integer;
  sSqlData: string;
begin
  iYs := StrToNum(edt_ys.Text);
  Frm_DataInterface.ADO_XQXX.Close;
  sSqlData := Format(vSqlData,[iYs,vMYTS]);
  Frm_DataInterface.ADO_XQXX.SQL.Text :=  sSqlData;
  Frm_DataInterface.ADO_XQXX.Open;
//  Frm_DataInterface.mte_FHCX.Close;
//  Frm_DataInterface.mte_FHCX.Open;
  if Frm_DataInterface.ADO_XQXX.RecordCount > 0 then
  begin
    n := Frm_DataInterface.ADO_XQXX.FieldByName('Count').AsInteger;
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    vYs := iYs;
    lab_zys.Caption := '页次：'+IntToStr(iYs)+'/'+ IntToStr(lab_zys.Tag);
  end;
end;

procedure TFraXQCX.CartonLablePrint;
var
  sSqlData: string;
begin
 { with Frm_DataInterface.ADO_Print do
  begin
    Close;
    sSqlData := 'select *,CPLX=(select F_sTypeName from Set_ProductType where F_iID=a.F_iProductTypeID) from BI_WorkOrder a where a.F_iID=%d';
    SQL.Text := Format(sSqlData,[vWorkID]) ;
    Open;
  end;
  rmr_CustomPrit.PrepareReport;
  rmr_CustomPrit.ShowReport;    }
end;

procedure TFraXQCX.btn_printClick(Sender: TObject);
var
  iOrderID, iOrderType,iDfbbz: Integer;
  sSqlData: string;
  i,n: Integer;
  pBookmark: Pointer;
begin
  with Frm_DataInterface do
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
    Exit;
  end;
  if n = 0 then
  begin
    p_MessageBoxDlg('请选择一个订单!','提示');
    Exit;
  end;  //iOrderID := Frm_DataInterface.ADO_XQXX.FieldByName('OrderID').AsInteger;
  //iOrderType := Frm_DataInterface.ADO_XQXX.FieldByName('OrderType').AsInteger;
  with Frm_DataInterface.ADO_Print do
  begin
    Close;
    sSqlData := 'exec p_CartonLablePrint %d,%d';
    SQL.Text := Format(sSqlData,[iOrderID,iOrderType]) ;
    Open;
    if RecordCount = 0 then
    begin
      p_MessageBoxDlg('请选择订单!','提示');
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
end;

function TFraXQCX.p_GetPrint(Rmrprt: TRMReport; sName: string;sType: integer): string;
var
  rmView: TRMView;
begin
  Result := '';
  rmView := Rmrprt.FindObject(sName);
  if rmView <> nil then
  begin
    case sType of
      0:
        begin
          Result := TRMMemoView(rmView).DataField;
        end;
      1:
        begin

        end;
    end;
  end;

end;

procedure TFraXQCX.p_SetPrint(Rmrprt: TRMReport; sName, sValue: string;sType: integer);
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

procedure TFraXQCX.dbg_xqxxColumns3EditButtons0Click(Sender: TObject;
  var Handled: Boolean);
var
  iOrderID,iOrderType: integer;
  i, n: Integer;
  sSqlData,sCPHB: string;
  ADO_Rec: TADOQuery;
  sZH,sRJHDQ,sRJHDZ: string;
begin
  iOrderID := Frm_DataInterface.ADO_XQXX.FieldByName('OrderID').AsInteger;
  iOrderType := Frm_DataInterface.ADO_XQXX.FieldByName('OrderType').AsInteger;
  sCPHB := Frm_DataInterface.ADO_XQXX.FieldByName('F_sCpbh').AsString;
  if iOrderID > 0 then
  begin
    Frm_LableGroup := TFrm_LableGroup.Create(Self);
    Frm_LableGroup.Caption := PChar('订单: '+ sCPHB);
    sZH := Frm_DataInterface.ADO_XQXX.FieldByName('ZH').AsString;
    sRJHDQ := Frm_DataInterface.ADO_XQXX.FieldByName('RJHDQ').AsString;
    sRJHDZ := Frm_DataInterface.ADO_XQXX.FieldByName('RJHDZ').AsString;
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
      ADO_Rec := Frm_DataInterface.OpenQuery(sSqlData,[iOrderID,iOrderType]);
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
      Frm_DataInterface.ADO_XQXX.Edit;
      Frm_DataInterface.ADO_XQXX.FieldByName('ZH').AsString := sZH;
      Frm_DataInterface.ADO_XQXX.FieldByName('RJHDQ').AsString := sRJHDQ;
      Frm_DataInterface.ADO_XQXX.FieldByName('RJHDZ').AsString := sRJHDZ;
      if Trim(sZH) <> '' then
        Frm_DataInterface.ADO_XQXX.FieldByName('RJBZ').AsBoolean := True;
      Frm_DataInterface.ADO_XQXX.Post;
    end;      
    Frm_LableGroup.Free;
  end else
  begin
    p_MessageBoxDlg('此订单不存在!','提示');
  end;
end;

procedure TFraXQCX.p_WriteGroup(iCartonID,iOrderID,iOrderType: Integer; sZH,sRJHDQ,sRJHDZ: string);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  i: integer;
begin
  sSqlData := 'Select * from DO_CartonLableGroupNum where F_iCartonInfoID=%d';
  ADO_Rec := Frm_DataInterface.OpenQuery(sSqlData,[iCartonID]);
  for i := 0 to Length(LabelGroup) -1 do
  begin
    if (LabelGroup[i].m_iOrderID = iOrderID) and (LabelGroup[i].m_iOrderType = iOrderType) then
    begin
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



end;

procedure TFraXQCX.dbg_xqxxTitleClick(Column: TColumnEh);
var
  i: Integer;
  bFH: Boolean;
  pMark: Pointer;
begin
  if Column.Index = 0 then
  begin
    bFH := False;
    with Frm_DataInterface.ADO_XQXX do
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

end.

