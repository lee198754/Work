unit uFra_ywtj;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, RzButton, ComCtrls, RzDTP, StdCtrls, RzPanel,ADODB,
  RM_Dataset, RM_System, RM_Common, RM_Class, RM_GridReport, DB, RM_e_Xls,
  RzCmboBx, iComboBox, RM_e_Graphic, RM_e_Jpeg;

type
  TFra_ywtj = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    RzGroupBox2: TRzGroupBox;
    Shape46: TShape;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    lab_lgzms: TLabel;
    lab_lgms: TLabel;
    lab_fhzms: TLabel;
    lab_fhms: TLabel;
    lab_wfhzms: TLabel;
    lab_wfhms: TLabel;
    dtp_cxq: TRzDateTimePicker;
    dtp_cxz: TRzDateTimePicker;
    btn_cx: TRzButton;
    Label7: TLabel;
    rmr_YWTJ: TRMGridReport;
    rmdb_YWTJ: TRMDBDataSet;
    ADO_YWTJ: TADOQuery;
    btn_dy: TButton;
    Label1: TLabel;
    cbb_cplb: Ti_ComboBox;
    cbb_sf: Ti_ComboBox;
    cbb_cs: Ti_ComboBox;
    cbb_qx: Ti_ComboBox;
    cbb_xpl: Ti_ComboBox;
    procedure btn_cxClick(Sender: TObject);
    procedure btn_dyClick(Sender: TObject);
    procedure cbb_sfChange(Sender: TObject);
    procedure cbb_csChange(Sender: TObject);
    procedure cbb_qxChange(Sender: TObject);
  private
    { Private declarations }
    vPlaceCode: string;
    procedure ReadYWTJ(ADO_Rec: TADOQuery);
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

uses
  uDM_DataBase, uPub_Type, uPub_Func, uPub_Text;

{$R *.dfm}

{ TFrame1 }

procedure TFra_ywtj.ReadYWTJ(ADO_Rec: TADOQuery);
var
  lgms , lgpkms , lgxkms , lghkfms , lghkms:Integer;
  yfhms , yfhpkms , yfhxkms , yfhhkfms , yfhhkms:Integer;
  wfhms , wfhpkms , wfhxkms , wfhhkfms , wfhhkms:Integer;
begin
  with ADO_Rec do
  begin
    while not Eof do
    begin       
      lgms := FieldByName('LGMS').AsInteger;
      lab_lgzms.Caption := Format('¹²À´¸å£º%d Ã¶£¬ÆäÖÐ',[lgms]);
      lgpkms := FieldByName('LGPKMS').AsInteger;
      lgxkms := FieldByName('LGXKMS').AsInteger;
      lghkfms := FieldByName('LGHKFMS').AsInteger;
      lghkms := FieldByName('LGHKMS').AsInteger;
      lab_lgms.Caption := Format('ÆÕ¿¨ %d Ã¶£¬ÐÅ¿¨ %d Ã¶£¬ºØ¿¨·â %d Ã¶£¬ºØ¿¨ %d Ã¶',[lgpkms,lgxkms,lghkfms,lghkms]);
      yfhms := FieldByName('YFHMS').AsInteger;
      lab_fhzms.Caption := Format('¹²·¢»õ£º%d Ã¶£¬ÆäÖÐ',[yfhms]);
      yfhpkms := FieldByName('YFHPKMS').AsInteger;
      yfhxkms := FieldByName('YFHXKMS').AsInteger;
      yfhhkfms := FieldByName('YFHHKFMS').AsInteger;
      yfhhkms := FieldByName('YFHHKMS').AsInteger;
      lab_fhms.Caption := Format('ÆÕ¿¨ %d Ã¶£¬ÐÅ¿¨ %d Ã¶£¬ºØ¿¨·â %d Ã¶£¬ºØ¿¨ %d Ã¶',[yfhpkms,yfhxkms,yfhhkfms,yfhhkms]);
      wfhms := FieldByName('WFHMS').AsInteger;
      lab_wfhzms.Caption := Format('Î´·¢»õ£º%d Ã¶£¬ÆäÖÐ',[wfhms]);
      wfhpkms := FieldByName('WFHPKMS').AsInteger;
      wfhxkms := FieldByName('WFHXKMS').AsInteger;
      wfhhkfms := FieldByName('WFHHKFMS').AsInteger;
      wfhhkms := FieldByName('WFHHKMS').AsInteger;
      lab_wfhms.Caption := Format('ÆÕ¿¨ %d Ã¶£¬ÐÅ¿¨ %d Ã¶£¬ºØ¿¨·â %d Ã¶£¬ºØ¿¨ %d Ã¶',[wfhpkms,wfhxkms,wfhhkfms,wfhhkms]);
      Next;
    end;
  end;
end;

procedure TFra_ywtj.btn_cxClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sCxq,sCxz: string;
  iCplb, iXPL: integer;
begin
  sCxq := FormatDateTime('yyyyMMdd',dtp_cxq.DateTime)+' 00:00:00';
  sCxz := FormatDateTime('yyyyMMdd',dtp_cxz.DateTime)+' 23:59:59';
  iCplb := FindProductCategoryID(cbb_cplb.ItemIndex);
  case cbb_xpl.ItemIndex of
    0: iXPL := -1;
    1: iXPL := 0;
    2: iXPL := 1;
  end;

 // ADO_Rec := DM_DataBase.OpenQuery('Exec p_ywtj ''%s'',''%s''',[sCxq,sCxz]);
  ADO_YWTJ.Close;
  ADO_YWTJ.SQL.Text := Format('Exec p_ywtj ''%s'',''%s'',%d,''%s'',''%d'' ',[sCxq,sCxz,iCplb,vPlaceCode,iXPL]);
  ADO_YWTJ.Open;
  ReadYWTJ(ADO_YWTJ);
 // ADO_Rec.Free;

end;

procedure TFra_ywtj.btn_dyClick(Sender: TObject);
begin
  rmr_YWTJ.PrepareReport;
  rmr_YWTJ.ShowReport;
end;

procedure TFra_ywtj.FraShow;
var
  sCPLB: string;
  sSF,sCS,sQX: string;
begin
  if cbb_cplb.Text <> '' then
    sCPLB := cbb_cplb.Text;
  cbb_cplb.Clear;
  cbb_cplb.Items.Add('--È«²¿--');
  CbbAdd(cbb_cplb,pkProductCategory);
  if sCPLB <> '' then
    cbb_cplb.ItemIndex := cbb_cplb.Items.IndexOf(sCPLB)
  else
    cbb_cplb.ItemIndex := c_Default_CPLB;
  if sCPLB = '' then
  begin
    dtp_cxq.DateTime := Now;
    dtp_cxz.DateTime := Now;
  end;

  if not GetDeclareNumbersList then Exit;
  if cbb_sf.Text <> '' then
    sSF := cbb_sf.Text;
  if cbb_cs.Text <> '' then
    sCS := cbb_cs.Text;
  if cbb_qx.Text <> '' then
    sQX := cbb_qx.Text;

  CbbPlaceAdd(cbb_sf,cbb_cs,cbb_qx,1);
  if sSF <> '' then
    cbb_sf.ItemIndex := cbb_sf.Items.IndexOf(sSF)
  else
    cbb_sf.ItemIndex := 0;

  CbbPlaceAdd(cbb_sf,cbb_cs,cbb_qx,2);
  if sCS <> '' then
    cbb_cs.ItemIndex := cbb_cs.Items.IndexOf(sCS)
  else
    cbb_cs.ItemIndex := 0;

  CbbPlaceAdd(cbb_sf,cbb_cs,cbb_qx,3);
  if sQX <> '' then
    cbb_qx.ItemIndex := cbb_qx.Items.IndexOf(sQX)
  else
    cbb_qx.ItemIndex := 0;
end;

procedure TFra_ywtj.cbb_sfChange(Sender: TObject);
begin
  vPlaceCode := CbbPlaceAdd(cbb_sf,cbb_cs,cbb_qx,2);
end;

procedure TFra_ywtj.cbb_csChange(Sender: TObject);
begin
  vPlaceCode := CbbPlaceAdd(cbb_sf,cbb_cs,cbb_qx,3);
end;

procedure TFra_ywtj.cbb_qxChange(Sender: TObject);
var
  i: Integer;
begin
  if cbb_qx.ItemIndex < 1 then
  begin
    if cbb_cs.ItemIndex < 1 then
    begin
      if cbb_sf.ItemIndex < 1 then
      begin
        vPlaceCode := '';
      end else
      begin
        for i := 0 to Length(aDeclareNumbers) -1 do
        begin
          if (aDeclareNumbers[i].m_iFlag = 2) and (aDeclareNumbers[i].m_sPlaceName = cbb_sf.Text) then
            vPlaceCode := aDeclareNumbers[i].m_sCode;
        end;
      end;
    end else
    begin
      for i := 0 to Length(aDeclareNumbers) -1 do
      begin
        if (aDeclareNumbers[i].m_iFlag = 2) and (aDeclareNumbers[i].m_sPlaceName = cbb_cs.Text) then
          vPlaceCode := aDeclareNumbers[i].m_sCode;
      end;
    end;
  end else
  begin
    for i := 0 to Length(aDeclareNumbers) -1 do
    begin
      if (aDeclareNumbers[i].m_iFlag = 3) and (aDeclareNumbers[i].m_sPlaceName= cbb_qx.Text)then
        vPlaceCode := aDeclareNumbers[i].m_sCode;
    end;
  end;
end;

end.
