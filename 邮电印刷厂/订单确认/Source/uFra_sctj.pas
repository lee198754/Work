unit uFra_sctj;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel, ComCtrls, RzDTP, RzButton, 
  StdCtrls, iLabel,ADODB, DB, RM_Dataset, RM_System, RM_Common, RM_Class,
  RM_GridReport, RM_e_Xls, RzCmboBx, iComboBox, RM_e_Graphic, RM_e_Jpeg;

type
  TFra_sctj = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    RzGroupBox2: TRzGroupBox;
    dtp_cxq: TRzDateTimePicker;
    dtp_cxz: TRzDateTimePicker;
    Shape26: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    lab_xks: TLabel;
    lab_xkyz: TLabel;
    Label11: TLabel;
    lab_xkch: TLabel;
    Label13: TLabel;
    lab_xkzzs: TLabel;
    Label15: TLabel;
    lab_xkls: TLabel;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape19: TShape;
    Shape20: TShape;
    Shape21: TShape;
    lab_hks: TLabel;
    lab_hkyz: TLabel;
    Label19: TLabel;
    lab_hkch: TLabel;
    Label21: TLabel;
    lab_hkzzs: TLabel;
    Label23: TLabel;
    lab_hkls: TLabel;
    Shape24: TShape;
    Shape25: TShape;
    lab_dkb: TLabel;
    lab_dkbyz: TLabel;
    Shape34: TShape;
    Shape35: TShape;
    lab_skb: TLabel;
    lab_skbyz: TLabel;
    Shape40: TShape;
    Shape41: TShape;
    Shape42: TShape;
    Shape43: TShape;
    Shape44: TShape;
    Shape45: TShape;
    Shape46: TShape;
    Label41: TLabel;
    lab_kgd: TLabel;
    lab_yzbs: TLabel;
    lab_yzbks: TLabel;
    lab_yyss: TLabel;
    lab_yysks: TLabel;
    lab_yzds: TLabel;
    lab_yzdks: TLabel;
    btn_cx: TRzButton;
    lab_hkfs: TLabel;
    Shape47: TShape;
    Shape48: TShape;
    Shape49: TShape;
    Shape50: TShape;
    Shape51: TShape;
    Shape52: TShape;
    Shape53: TShape;
    Shape55: TShape;
    lab_hkfyz: TLabel;
    Label51: TLabel;
    lab_hkfch: TLabel;
    Label53: TLabel;
    lab_hkfzzs: TLabel;
    Label55: TLabel;
    lab_hkfls: TLabel;
    Shape80: TShape;
    Shape54: TShape;
    Shape28: TShape;
    Shape2: TShape;
    Shape1: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    lab_pks: TLabel;
    lab_pkyz: TLabel;
    Label3: TLabel;
    lab_pkch: TLabel;
    Label5: TLabel;
    lab_pkzzs: TLabel;
    Label7: TLabel;
    lab_pkls: TLabel;
    Shape22: TShape;
    Shape23: TShape;
    Shape27: TShape;
    Shape29: TShape;
    Shape30: TShape;
    Shape31: TShape;
    Shape32: TShape;
    Shape33: TShape;
    Shape36: TShape;
    Shape37: TShape;
    Shape38: TShape;
    Shape39: TShape;
    Label1: TLabel;
    btn_dy: TButton;
    rmr_SCTJ: TRMGridReport;
    rmdb_SCTJ: TRMDBDataSet;
    ADO_SCTJ: TADOQuery;
    cbb_cplb: Ti_ComboBox;
    Label2: TLabel;
    procedure btn_cxClick(Sender: TObject);
    procedure btn_dyClick(Sender: TObject);
  private
    { Private declarations }
    procedure ReadSCTJ(ADO_Rec: TADOQuery);
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

uses
  uDM_DataBase, uPub_Type, uPub_Func, uPub_Text;
{$R *.dfm}

procedure TFra_sctj.btn_cxClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sCxq,sCxz: string;
  iCplb: integer;
begin
  sCxq := FormatDateTime('yyyyMMdd',dtp_cxq.DateTime)+' 00:00:00';
  sCxz := FormatDateTime('yyyyMMdd',dtp_cxz.DateTime)+' 23:59:59';
  iCplb := FindProductCategoryID(cbb_cplb.ItemIndex);
  //ADO_Rec := DM_DataBase.OpenQuery('Exec p_sctj ''%s'',''%s''',[sCxq,sCxz]);
  ADO_SCTJ.Close;
  ADO_SCTJ.SQL.Text := Format('Exec p_sctj ''%s'',''%s'',%d',[sCxq,sCxz,iCplb]);
  ADO_SCTJ.Open;
  ReadSCTJ(ADO_SCTJ);
//  ADO_Rec.Free;
end;

procedure TFra_sctj.ReadSCTJ(ADO_Rec: TADOQuery);
var
  str: string;
  kds , kdms: Integer;  //������,�ܿ���ö��
  qgdh , zgdh: string; //��һ��������,���һ��������
  cds: Integer;   //������
  pks , pkms , pkyz , pkch , pkzzs: Integer;   //�տ���,�տ�ö��,�տ���ֽ����,�տ�����ֽ��
  xks , xkms ,xkyz , xkch, xkzzs: Integer;
  hks , hkms ,hkyz , hkch, hkzzs: Integer;
  hkfs , hkfms ,hkfyz , hkfch, hkfzzs: Integer;
  pkls , xkls , hkls , hkfls:Real;
  dkbk: Integer;
  skbk: Integer;
  yzbs , yzbms, yzbpks , yzbpkms , yzbxks , yzbxkms , yzbhks , yzbhkms , yzbhkfs , yzbhkfms: Integer;
  yyss , yysms ,yyspks , yyspkms , yysxks , yysxkms , yyshks , yyshkms , yyshkfs , yyshkfms: Integer;
  yzds , yzdms ,yzdpks , yzdpkms , yzdxks , yzdxkms , yzdhks , yzdhkms , yzdhkfs , yzdhkfms: Integer;
begin
  with ADO_Rec do
  begin
    while not Eof do
    begin
      kds := FieldByName('KDS').AsInteger;
      kdms := FieldByName('KDMS').AsInteger;
      qgdh := FieldByName('QGDH').AsString;
      zgdh := FieldByName('ZGDH').AsString;
      cds := FieldByName('CDS').AsInteger;
//      lab_kgd.Caption := Format('��ʱ����ڹ��������� %d �ţ��� %d ö���� %s �� %s���Ĳ�ʹ����Ϊ��(���г��� %d ��,������ͳ��)',[kds,kdms,qgdh,zgdh,cds]);
      lab_kgd.Caption := Format('��ʱ����ڹ��������� %d �ţ��� %d ö���Ĳ�ʹ����Ϊ��(���г��� %d ��,������ͳ��)',[kds,kdms,cds]);
      //�տ�
      pks := FieldByName('PKS').AsInteger;
      pkms := FieldByName('PKMS').AsInteger;
      lab_pks.Caption := Format('�տ� %d �ţ��� %d ö�����ô�ֽ',[pks,pkms]);
      pkyz := FieldByName('PKYZ').AsInteger;
      lab_pkyz.Caption := Format('%d ��,',[pkyz]);
      pkch := FieldByName('PKCH').AsInteger;
      lab_pkch.Caption := Format('%d ��,',[pkch]);
      pkzzs := pkyz+pkch;
      lab_pkzzs.Caption := Format('%d ��,',[pkzzs]);
      lab_pkls.Caption := Format('%6.2f ��',[pkzzs / 500]);
      //�ſ�
      xks := FieldByName('XKS').AsInteger;
      xkms := FieldByName('XKMS').AsInteger;
      lab_xks.Caption := Format('�ſ� %d �ţ��� %d ö�����ô�ֽ',[xks,xkms]);
      xkyz := FieldByName('XKYZ').AsInteger;
      lab_xkyz.Caption := Format('%d ��,',[xkyz]);
      xkch := FieldByName('XKCH').AsInteger;
      lab_xkch.Caption := Format('%d ��,',[xkch]);
      xkzzs := xkyz+xkch;
      lab_xkzzs.Caption := Format('%d ��,',[xkzzs]);
      lab_xkls.Caption := Format('%6.2f ��',[xkzzs / 500]);
      //�ؿ�
      hks := FieldByName('HKS').AsInteger;
      hkms := FieldByName('HKMS').AsInteger;
      lab_hks.Caption := Format('�ؿ� %d �ţ��� %d ö�����ô�ֽ',[hks,hkms]);
      hkyz := FieldByName('HKYZ').AsInteger;
      lab_hkyz.Caption := Format('%d ��,',[hkyz]);
      hkch := FieldByName('HKCH').AsInteger;
      lab_hkch.Caption := Format('%d ��,',[hkch]);
      hkzzs := hkyz+hkch;
      lab_hkzzs.Caption := Format('%d ��,',[hkzzs]);
      lab_hkls.Caption := Format('%6.2f ��',[hkzzs / 500]);
      //�ؿ���
      hkfs := FieldByName('HKFS').AsInteger;
      hkfms := FieldByName('HKFMS').AsInteger;
      lab_hkfs.Caption := Format('�ؿ��� %d �ţ��� %d ö�����ô�ֽ',[hkfs,hkfms]);
      hkfyz := FieldByName('HKFYZ').AsInteger;
      lab_hkfyz.Caption := Format('%d ��,',[hkfyz]);
      hkfch := FieldByName('HKFCH').AsInteger;
      lab_hkfch.Caption := Format('%d ��,',[hkfch]);
      hkfzzs := hkfyz+hkfch;
      lab_hkfzzs.Caption := Format('%d ��,',[hkfzzs]);
      lab_hkfls.Caption := Format('%6.2f ��',[hkfzzs / 500]);
      //�Կ���
      dkbk := FieldByName('DKBK').AsInteger;
      lab_dkbyz.Caption := Format('%d ��',[dkbk]);
      //�Ŀ���
      skbk := FieldByName('SKBK').AsInteger;
      lab_skbyz.Caption := Format('%d ��',[skbk]);
      //���ư�
      yzbs := FieldByName('YZBS').AsInteger;
      yzbms := FieldByName('YZBMS').AsInteger;
      lab_yzbs.Caption := Format('�ư泵�乲��ɴ�Ʊ���� %d �ţ��� %d ö�����У�',[yzbs,yzbms]);
      yzbpks := FieldByName('YZBPKS').AsInteger;
      yzbpkms := FieldByName('YZBPKMS').AsInteger;
      yzbxks := FieldByName('YZBXKS').AsInteger;
      yzbxkms := FieldByName('YZBXKMS').AsInteger;
      yzbhks := FieldByName('YZBHKS').AsInteger;
      yzbhkms := FieldByName('YZBHKMS').AsInteger;
      yzbhkfs := FieldByName('YZBHKFS').AsInteger;
      yzbhkfms := FieldByName('YZBHKFMS').AsInteger;
      lab_yzbks.Caption := Format('�տ� %d �ţ� %d ö�� �ſ� %d �ţ� %d ö�� �ؿ� %d �ţ� %d ö�� �ؿ��� %d �ţ� %d ö'
        ,[yzbpks,yzbpkms,yzbxks,yzbxkms,yzbhks,yzbhkms,yzbhkfs,yzbhkfms]);
      //��ӡˢ
      yyss := FieldByName('YYSS').AsInteger;
      yysms := FieldByName('YYSMS').AsInteger;
      lab_yyss.Caption := Format('ӡˢ���乲��ɴ�Ʊ���� %d �ţ��� %d ö�����У�',[yyss,yysms]);
      yyspks := FieldByName('YYSPKS').AsInteger;
      yyspkms := FieldByName('YYSPKMS').AsInteger;
      yysxks := FieldByName('YYSXKS').AsInteger;
      yysxkms := FieldByName('YYSXKMS').AsInteger;
      yyshks := FieldByName('YYSHKS').AsInteger;
      yyshkms := FieldByName('YYSHKMS').AsInteger;
      yyshkfs := FieldByName('YYSHKFS').AsInteger;
      yyshkfms := FieldByName('YYSHKFMS').AsInteger;
      lab_yysks.Caption := Format('�տ� %d �ţ� %d ö�� �ſ� %d �ţ� %d ö�� �ؿ� %d �ţ� %d ö�� �ؿ��� %d �ţ� %d ö'
        ,[yyspks,yyspkms,yysxks,yysxkms,yyshks,yyshkms,yyshkfs,yyshkfms]);
      //��װ��
      yzds := FieldByName('YZDS').AsInteger;
      yzdms := FieldByName('YZDMS').AsInteger;
      lab_yzds.Caption := Format('װ�����乲��ɴ�Ʊ���� %d �ţ��� %d ö�����У�',[yzds,yzdms]);
      yzdpks := FieldByName('YZDPKS').AsInteger;
      yzdpkms := FieldByName('YZDPKMS').AsInteger;
      yzdxks := FieldByName('YZDXKS').AsInteger;
      yzdxkms := FieldByName('YZDXKMS').AsInteger;
      yzdhks := FieldByName('YZDHKS').AsInteger;
      yzdhkms := FieldByName('YZDHKMS').AsInteger;
      yzdhkfs := FieldByName('YZDHKFS').AsInteger;
      yzdhkfms := FieldByName('YZDHKFMS').AsInteger;
      lab_yzdks.Caption := Format('�տ� %d �ţ� %d ö�� �ſ� %d �ţ� %d ö�� �ؿ� %d �ţ� %d ö�� �ؿ��� %d �ţ� %d ö'
        ,[yzdpks,yzdpkms,yzdxks,yzdxkms,yzdhks,yzdhkms,yzdhkfs,yzdhkfms]);
      Next;
    end;
  end;
end;

procedure TFra_sctj.btn_dyClick(Sender: TObject);
begin
  rmr_SCTJ.PrepareReport;
  rmr_SCTJ.ShowReport;
end;

procedure TFra_sctj.FraShow;
var
  sCPLB: string;
begin
  if cbb_cplb.Text <> '' then
    sCPLB := cbb_cplb.Text;
  if sCPLB = '' then
  begin
    dtp_cxq.DateTime := Now;
    dtp_cxz.DateTime := Now;
  end;
  cbb_cplb.Clear;
  cbb_cplb.Items.Add('--ȫ��--');
  CbbAdd(cbb_cplb,pkProductCategory);
  if sCPLB <> '' then
    cbb_cplb.ItemIndex := cbb_cplb.Items.IndexOf(sCPLB)
  else
    cbb_cplb.ItemIndex := c_Default_CPLB;
end;

end.
