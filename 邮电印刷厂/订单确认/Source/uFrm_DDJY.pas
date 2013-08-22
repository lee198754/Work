unit uFrm_DDJY;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFra_DDLR,ADODB, ExtCtrls;

type
  TFrm_DDJY = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Fra_DDLRbtn_okClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Fra_DDLR: TFra_DDLR;
    vOrderID: Integer;
    vOrderType: Integer;
    vCPLX: string;
    vCpbh: string;
    

  end;

var
  Frm_DDJY: TFrm_DDJY;

implementation

uses
  uDM_DataBase,PubStr,uPub_Type, uPub_Func, DB;
{$R *.dfm}

procedure TFrm_DDJY.FormCreate(Sender: TObject);
begin
{  Fra_DDLR := tFra_DDLR.Create(Self);
  Fra_DDLR.Parent := Self;
  Fra_DDLR.Align := alClient;
  Fra_DDLR.Visible := True;  }
end;

procedure TFrm_DDJY.FormDestroy(Sender: TObject);
begin
  if not Assigned(Fra_DDLR) then
    Fra_DDLR.Free;
end;

procedure TFrm_DDJY.Fra_DDLRbtn_okClick(Sender: TObject);
begin
  Fra_DDLR.btn_okClick(Sender);
  if Fra_DDLR.vSucceed then
    Self.Close;

end;

procedure TFrm_DDJY.FormShow(Sender: TObject);
var
  ADO_Rec, ADO_YZTMC: TADOQuery;
  iID,iOrderType,iCPLX,iCPLB: Integer;
  sSqlData,sCpbh,sCPLX: string;
begin
  Fra_DDLR := TFra_DDLR.Create(Self);
  Fra_DDLR.Visible := True;
  iID := vOrderID;
  iOrderType := vOrderType;
  if iID = 0 then Exit;
  if iOrderType = 0 then
    sSqlData := 'Select * from BI_CustomOrder a,BI_CustomOrderDetails b where a.F_iID=b.F_iCustomID and b.F_iID=%d'
  else if iOrderType = 1 then
    sSqlData := 'Select * from BI_SellOrder a,BI_SellOrderDetails b where a.F_iID=b.F_iSellID and b.F_iID=%d';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iID]);
  if ADO_Rec.RecordCount > 0 then
  begin
    with Fra_DDLR do
    begin
      FraShow;
      if ADO_Rec.FieldByName('F_tiDfbbz').AsInteger = 0 then
      begin
        if iOrderType = 0 then
          rb_bb_dzx.Checked := True
        else if iOrderType = 1 then
          rb_bb_xsx.Checked := True;
      end else
        rb_bb_dfb.Checked := True;
      cbb_kh.Items.Add(ADO_Rec.FieldByName('F_sJg').AsString);
      cbb_kh.ItemIndex := cbb_kh.Items.IndexOf(ADO_Rec.FieldByName('F_sJg').AsString);
      //cbb_kh.Text := ADO_Rec.FieldByName('F_sJg').AsString;
      sCpbh := ADO_Rec.FieldByName('F_sCpbh').AsString;
      sCpbh := vCpbh;
      edt_cpbh_0.Text := PosCopy(sCpbh,'-',1);
      edt_cpbh_1.Text := PosCopy(sCpbh,'-',2);
      edt_cpbh_2.Text := PosCopy(sCpbh,'-',3);
      edt_cpbh_3.Text := PosCopy(sCpbh,'-',4);
      edt_cpbh_4.Text := PosCopy(sCpbh,'-',5);
      if iOrderType = 0 then
        edt_khmc.Text := ADO_Rec.FieldByName('F_sKhmc').AsString
      else if iOrderType = 1 then
        edt_khmc.Text := ADO_Rec.FieldByName('F_sCpmc').AsString;
      //edt_yl.Text := IntToStr(ADO_Rec.FieldByName('F_nYl').AsInteger*10000);
      //cbb_cplx.ItemIndex := cbb_cplx.IndexOf(vCPLX);
      sSqlData := 'Select F_iProductTypeID,F_iProductCategoryID,F_sCPLX,F_sYZTMC from Set_PostageType where CharIndex(F_sYZTMC,''%s'')=1 ';
      ADO_YZTMC := DM_DataBase.OpenQuery(sSqlData,[ADO_Rec.FieldByName('F_sYztmc').AsString]);
      if Assigned(ADO_YZTMC) and (ADO_YZTMC.RecordCount > 0) then
      begin
        iCPLB := ADO_YZTMC.FieldByName('F_iProductCategoryID').AsInteger;
        iCPLX := ADO_YZTMC.FieldByName('F_iProductTypeID').AsInteger;
        sCPLX := ADO_YZTMC.FieldByName('F_sCPLX').AsString;
        cbb_cplb.ItemIndex := FindProductCategoryData(iCPLB).m_iXH;
        cbb_cplx.Clear;
        cbb_cplx.Add(sCPLX);
        cbb_cplx.ItemIndex := 0;
      end;
      cbb_yztmc.Clear;
      cbb_yztmc.Add(ADO_Rec.FieldByName('F_sYztmc').AsString);
      cbb_yztmc.ItemIndex := 0;
//      cbb_yztmc.Text := ADO_Rec.FieldByName('F_sYztmc').AsString;
      cbb_tsgy.Text := ADO_Rec.FieldByName('F_sQttsgyms').AsString;
      edt_sbbbh.Text := ADO_Rec.FieldByName('F_sSbbbh').AsString;
      if ADO_Rec.FieldByName('F_tiXpl').AsInteger = 0 then
        rb_xpl_no.Checked := True
      else
        rb_xpl_yes.Checked := True;

      if ADO_Rec.FieldByName('F_tiQy').AsInteger = 0 then
        rb_qy_no.Checked := True
      else
        rb_qy_yes.Checked := True;
      lab_lry.Caption := LoginData.m_sUserName;
      cb_jy.Checked := True;
      edt_yl.SetFocus;
    end;
    ADO_Rec.Free;
  end;
end;

end.
