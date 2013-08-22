unit uFra_FHTJ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, RM_e_Graphic, RM_e_Jpeg, RM_Common, RM_Class, RM_e_Xls, DB,
  ADODB, RM_Dataset, RM_System, RM_GridReport, ExtCtrls, StdCtrls,
  RzCmboBx, iComboBox, RzButton, ComCtrls, RzDTP, RzPanel;

type
  TFra_FHTJ = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    Label7: TLabel;
    Label1: TLabel;
    dtp_cxq: TRzDateTimePicker;
    dtp_cxz: TRzDateTimePicker;
    btn_cx: TRzButton;
    btn_dy: TButton;
    cbb_cplb: Ti_ComboBox;
    cbb_sf: Ti_ComboBox;
    cbb_cs: Ti_ComboBox;
    cbb_qx: Ti_ComboBox;
    cbb_xpl: Ti_ComboBox;
    RzGroupBox2: TRzGroupBox;
    Shape2: TShape;
    Shape3: TShape;
    lab_fhzms: TLabel;
    lab_fhms: TLabel;
    rmr_FHTJ: TRMGridReport;
    rmdb_FHTJ: TRMDBDataSet;
    ADO_FHTJ: TADOQuery;
    GroupBox1: TGroupBox;
    Shape4: TShape;
    lab_yrlysdh: TLabel;
    procedure btn_cxClick(Sender: TObject);
    procedure btn_dyClick(Sender: TObject);
    procedure cbb_sfChange(Sender: TObject);
    procedure cbb_csChange(Sender: TObject);
    procedure cbb_qxChange(Sender: TObject);
  private
    { Private declarations }
    vPlaceCode: string;
    procedure ReadFHTJ(ADO_Rec: TADOQuery);
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

{$R *.dfm}

uses
  uPub_Func, uPub_Type, uPub_Text;

{ TFra_FHGJ }

procedure TFra_FHTJ.FraShow;
var
  sCPLB: string;
  sSF,sCS,sQX: string;
begin
  if cbb_cplb.Text <> '' then
    sCPLB := cbb_cplb.Text;
  cbb_cplb.Clear;
  cbb_cplb.Items.Add('--»´≤ø--');
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

procedure TFra_FHTJ.btn_cxClick(Sender: TObject);
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
  ADO_FHTJ.Close;
  ADO_FHTJ.SQL.Text := Format('Exec p_fhtj ''%s'',''%s'',%d,''%s'',%d ',[sCxq,sCxz,iCplb,vPlaceCode,iXPL]);
  ADO_FHTJ.Open;
  ReadFHTJ(ADO_FHTJ);
 // ADO_Rec.Free;

end;

procedure TFra_FHTJ.ReadFHTJ(ADO_Rec: TADOQuery);
var
  yfhms , yfhpkms , yfhxkms , yfhhkfms , yfhhkms:Integer;
  yfhxs , yfhpkxs , yfhxkxs , yfhhkfxs , yfhhkxs:Integer;
  ylrysdh: Integer;
begin
  with ADO_Rec do
  begin
    while not Eof do
    begin
      yfhms := FieldByName('YFHMS').AsInteger;
      yfhxs := FieldByName('YFHXS').AsInteger;
      lab_fhzms.Caption := Format('π≤∑¢ªı£∫%d √∂(%d œ‰)£¨∆‰÷–',[yfhms,yfhxs]);
      yfhpkms := FieldByName('YFHPKMS').AsInteger;
      yfhxkxs := FieldByName('YFHXKXS').AsInteger;
      yfhxkms := FieldByName('YFHXKMS').AsInteger;
      yfhpkxs := FieldByName('YFHPKXS').AsInteger;
      yfhhkfms := FieldByName('YFHHKFMS').AsInteger;
      yfhhkfxs := FieldByName('YFHHKFXS').AsInteger;
      yfhhkms := FieldByName('YFHHKMS').AsInteger;
      yfhhkxs := FieldByName('YFHHKXS').AsInteger;
      lab_fhms.Caption := Format('∆’ø® %d √∂(%d œ‰)£¨–≈ø® %d √∂(%d œ‰)£¨∫ÿø®∑‚ %d √∂(%d œ‰)£¨∫ÿø® %d √∂(%d œ‰)',
        [yfhpkms,yfhpkxs,yfhxkms,yfhxkxs,yfhhkfms,yfhhkfxs,yfhhkms,yfhhkxs]);
      ylrysdh := FieldByName('YRLYSDH').AsInteger;
      lab_yrlysdh.Caption := Format('π≤¬º»Î£∫%d œ‰',[ylrysdh]);
      Next;
    end;
  end;
end;

procedure TFra_FHTJ.btn_dyClick(Sender: TObject);
begin
  rmr_FHTJ.PrepareReport;
  rmr_FHTJ.ShowReport;

end;

procedure TFra_FHTJ.cbb_sfChange(Sender: TObject);
begin
  vPlaceCode := CbbPlaceAdd(cbb_sf,cbb_cs,cbb_qx,2);
end;

procedure TFra_FHTJ.cbb_csChange(Sender: TObject);
begin
  vPlaceCode := CbbPlaceAdd(cbb_sf,cbb_cs,cbb_qx,3);

end;

procedure TFra_FHTJ.cbb_qxChange(Sender: TObject);
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
