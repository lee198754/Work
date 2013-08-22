unit uFrakd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, iLabel, RzCmboBx, iComboBox, ButtonEdit, RzButton,
  ComCtrls, RzDTP, ExtCtrls, RzPanel, RzListVw, uDM_DataBase, 
  DB, ADODB, uPrint, Menus, ImgList, RzRadChk,RzEdit;

type
  TFra_kd = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    btn_cx: TRzButton;
    cbb_ddlx: Ti_ComboBox;
    Panel1: TPanel;
    gb_dd: TRzGroupBox;
    lv_jhxd: TRzListView;
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    btn_kgd_old: TRzBitBtn;
    cbb_yztmc: TComboBox;
    Label1: TLabel;
    edt_cpbh: Ti_TxtFilter;
    cbb_cplb: Ti_ComboBox;
    cbb_cplx: Ti_ComboBox;
    cbb_nf: Ti_ComboBox;
    ImageList1: TImageList;
    pm_jhxd: TPopupMenu;
    menu_ddmx: TMenuItem;
    menu_ddmxPic: TMenuItem;
    cbb_xpl: Ti_ComboBox;
    cbb_qyzt: Ti_ComboBox;
    cb_Cookie: TRzCheckBox;
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
    btn_kgd: TButton;
    Label4: TLabel;
    cb_syyl: TRzCheckBox;
    edt_syylq: TEdit;
    edt_syylz: TEdit;
    procedure cbb_cplbChange(Sender: TObject);
    procedure btn_cxClick(Sender: TObject);
    procedure btn_kgd_oldClick(Sender: TObject);
    procedure lv_jhxdColumnClick(Sender: TObject; Column: TListColumn);
    procedure lv_jhxdCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure menu_ddmxClick(Sender: TObject);
    procedure lv_jhxdMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lab_ts50Click(Sender: TObject);
    procedure btn_goClick(Sender: TObject);
    procedure lab_firstClick(Sender: TObject);
    procedure lab_upClick(Sender: TObject);
    procedure lab_downClick(Sender: TObject);
    procedure lab_lastClick(Sender: TObject);
    procedure btn_kgdClick(Sender: TObject);
    procedure cb_syylClick(Sender: TObject);
    procedure lv_jhxdCheckStateChange(Sender: TObject; Item: TListItem);
  private
    { Private declarations }
    vCount: integer;
    vMYTS: Integer;     //��ǰÿҳ����
    vYs: integer;       //��ǰҳ��
    vSqlData: string;
    procedure ReadDataJHXD(ADO_Data: TADOQuery;Bz: integer);
    procedure GetCookie(Frm: TForm);
  public
    { Public declarations }
    procedure FraShow;
    procedure CustomLvAdd;
    procedure SellLvAdd;

  end;

implementation

uses
  PubStr, uPub_Type, uPub_Func, uDDMX_DZX, uDDMX_XSX,
  Registry, DateUtils, uWorkOrder, uPub_Text;
  
{$R *.dfm}

const
  c_jg         = 0;
  c_CPBH       = 1;
  c_cplx       = 2;
  c_yztmc      = 3;
  c_lgrq       = 4;
  c_khmc       = 5;
  c_zyl        = 6;
  c_tsgy       = 7;
  c_fjgy       = 8;
  c_jybz       = 9;
  c_cybz       = 10;
  c_syyl       = 11;
  c_sfqy       = 12;
  c_xpl        = 13;
  c_tgzt       = 14;
  c_OrderID    = 15;
  c_OrderType  = 16;
  c_ApartID    = 17;
//c_ProductTypeID=10;

var
  viItemIndex: Integer=-1;   //��¼��һ����ѡ��λ��

procedure TFra_kd.cbb_cplbChange(Sender: TObject);
var
  iProductCategoryID: Integer;
begin
  iProductCategoryID := FindProductCategoryID(cbb_cplb.ItemIndex);
  cbb_cplx.Clear;
  cbb_cplx.Items.Add('--ȫ��--');
  CbbAdd(cbb_cplx,pkProductType,iProductCategoryID);
  cbb_cplx.ItemIndex := 0;
end;

procedure TFra_kd.btn_cxClick(Sender: TObject);
var
  iCplb, iCplx, iDdlx, iXpl,iQyzt: Integer;
  iSYYLQ,iSYYLZ,iYS,iTs: integer;
  sCpbh, sNf: string;
  ADO_Rec: TADOQuery;
begin
//  DB_jhdzs.DataSource := DM_DataBase.ds_show;
  Screen.Cursor := crHourGlass;
  viItemIndex := -1;
  btn_cx.Caption := '��ѯ��...';
  vCount := 0;
//  lv_jhxd.Items.BeginUpdate;
  //lv_jhxd.Clear;
  sCpbh := edt_cpbh.Text;
  iCplb := FindProductCategoryCode(cbb_cplb.ItemIndex);
  iCplx := FindProductTypeID(cbb_cplx.ItemIndex,iCplb);
  sNf := cbb_nf.Text;
  iDdlx := cbb_ddlx.ItemIndex;
  if cb_syyl.Checked then
  begin
    iSYYLQ := StrToNum(edt_syylq.Text);
    iSYYLZ := StrToNum(edt_syylz.Text);
    edt_syylq.Text := IntToStr(iSYYLQ);
    edt_syylz.Text := IntToStr(iSYYLZ);
  end else
  begin
    iSYYLQ := -1;
    iSYYLZ := -1;
  end;
  case cbb_xpl.ItemIndex of
    0: iXpl := -1;
    1: iXpl := 0;
    2: iXpl := 1;
  end;
  case cbb_qyzt.ItemIndex of
    0: iQyzt := -1;
    1: iQyzt := 0;
    2: iQyzt := 1;
  end;
  iYs := 1;                                          
  vYs := iYs;
  edt_ys.Text := IntToStr(iYs);
  if vMYTS = 0 then
  begin
    vMYTS := 50;
    lab_ts50.Font.Color :=  clBlack;
    lab_ts50.Font.Size := 10;
    lab_ts50.Font.Style := [fsBold];
    lab_ts50.Cursor := crDefault;
  end;
  iTs := vMYTS;
  ADO_Rec := DM_DataBase.OpenQuery('Exec p_kdcx ''%s'',%d,%d,''%s'',%d,%d,%d,%d,%d,%d,%d',
    [sCpbh,iCplb,iCplx,sNf,iDdlx-1,iXpl,iQyzt,iSYYLQ,iSYYLZ,iYs,iTs]);
  if Assigned(ADO_Rec) then
  begin
    ReadDataJHXD(ADO_Rec,iDdlx-1);
    ADO_Rec.Free;
  end;
  vSqlData := Format('Exec p_kdcx ''%s'',%d,%d,''%s'',%d,%d,%d,%d,%d,%s,%s',[sCpbh,iCplb,iCplx,sNf,iDdlx-1,iXpl,iQyzt,iSYYLQ,iSYYLZ,'%d','%d']);

  btn_cx.Caption := '��ѯ';
  Screen.Cursor := crDefault;

end;




procedure TFra_kd.btn_kgd_oldClick(Sender: TObject);
var
  i,n,iOrderID,iOrderType,iTemp: Integer;
  sGDH: string;
  sCpbh, sKhmc,sApartID,sSl: string;
  sTempZB,sTempZD: string;
  ADO_Rec: TADOQuery;
  sTableName,SqlData,sFBDW,sHS,sLXR,sYZTA,sCPCC: string;
  sCPLX, sYZTMC, sXPL: string;
  bDdlx:Boolean;
  
begin
  bDdlx := False;
  n := 0;
  for i := 0 to lv_jhxd.Items.Count -1 do
  begin
    if lv_jhxd.Items[i].Checked then
    begin
      if sCPLX = '' then
        sCPLX := lv_jhxd.Items[i].SubItems[c_cplx];
      if sCPLX <> lv_jhxd.Items[i].SubItems[c_cplx] then
        bDdlx := True;
      Inc(n);
    end;
  end;
  if (n=0) or (lv_jhxd.Items.Count = 0) then
  begin
    Application.MessageBox('��ѡ������һ��','��ʾ',MB_ICONINFORMATION);
    Exit;
  end;
  if n > 100 then
  begin
    if Application.MessageBox('�������ѳ���100��!ȷ�Ͻ��д˲���?','��ʾ',MB_YESNO+MB_ICONINFORMATION)=IDNO then
      Exit;
  end;
  if bDdlx then
  begin
    if Application.MessageBox('��ѡ�Ķ����д��ڶ������Ͳ�һ���Ķ���,�Ƿ�����˲���?','��ʾ',MB_YESNO+MB_ICONINFORMATION)=IDNO then
      Exit;
  end;

  TRzBitBtn(Sender).Caption := '������...';
  Frm_Print := TFrm_Print.Create(self);
  Frm_Print.lab_HBST.Caption := '����ʽͼ';
  with Frm_Print do
  begin
    for i := 0 to ComponentCount -1 do
    begin
      if Components[i] is TRzDateTimePicker then
      begin
        if Components[i].Name = 'dtp_jhrq' then
          TRzDateTimePicker(Components[i]).DateTime := IncDay(Now,5)
        else
          TRzDateTimePicker(Components[i]).DateTime := Now;
      end;
    end;
    n := 0;
    iTemp := 0;
    SetLength(OrderData,0);
    mmo_zbbz.Clear;
    mmo_dybz.Clear;
    for i := 0 to lv_jhxd.Items.Count -1 do
    begin
      if lv_jhxd.Items[i].Checked then
      begin
        sCpbh := lv_jhxd.Items[i].SubItems[c_CPBH];
        if Copy(sCpbh,1,1) = '*' then
          sCpbh := Copy(sCpbh,2,Length(sCpbh));
        sKhmc := lv_jhxd.Items[i].SubItems[c_khmc];
        sSl := lv_jhxd.Items[i].SubItems[c_syyl];
        sCPLX := lv_jhxd.Items[i].SubItems[c_cplx];
        sYZTMC := lv_jhxd.Items[i].SubItems[c_yztmc];
        sXPL := lv_jhxd.Items[i].SubItems[c_xpl];
        edt_zl.Text := StrToNum(edt_zl.Text)+StrToNum(sSl);
        iOrderID := StrToNum(lv_jhxd.Items[i].SubItems[c_OrderID]);
        if iTemp = 0 then iTemp := iOrderID;
        if iTemp <> iOrderID then  iTemp := -1;
        iOrderType := StrToInt(lv_jhxd.Items[i].SubItems[c_OrderType]);
        sApartID := lv_jhxd.Items[i].SubItems[c_ApartID];
        SetLength(OrderData,Length(OrderData)+1);
        OrderData[Length(OrderData)-1].m_iXH := n;
        if pos('(�ڼ�)',sCpbh) >0 then
          sCpbh := StrLeft(sCpbh,Length(sCpbh)-6);
        OrderData[Length(OrderData)-1].m_sCPBH := sCpbh;
        OrderData[Length(OrderData)-1].m_sKhmc := sKhmc;
        OrderData[Length(OrderData)-1].m_sCplx := sCPLX;
        OrderData[Length(OrderData)-1].m_sYztmc := sYZTMC;
        OrderData[Length(OrderData)-1].m_iXPL := iif(sXPL='С����',1,0);
//        OrderData[Length(OrderData)-1].m_iSyyl := StrToInt(sSl);
        OrderData[Length(OrderData)-1].m_iApartID := StrToInt(sApartID);
        OrderData[Length(OrderData)-1].m_iType := iOrderType;
        OrderData[Length(OrderData)-1].m_iOrderID :=  iOrderID;
        //CreateFrame(sKhmc,sCpbh,'','1',sSl,'',sApartID,n);
        if sTempZB <> sKhmc then
        begin
          sTempZB := sKhmc;
          mmo_zbbz.Lines.Add(sKhmc);
        end;
        mmo_zbbz.Lines.Add(sCpbh);
//        mmo_dybz.Lines.Add(sCpbh+#13#10);

        inc(n);
      end;
    end;
    //�����Ƶ���ʱ������,�������ɵĹ������˷�
//    vOrderType := cbb_bb.ItemIndex;
//    DM_DataBase.GetMaxID('BI_WorkOrder','BK_GDH',sGDH);
//    sGDH := '12BK-'+StrRight(sGDH,10);
//    edt_gdh.Text := sGDH;

{    if iTemp <> -1 then       //�ؿ��Ĳ����Լ�д������Ϣ
    begin
      case iOrderType of
        0: sTableName := 'BI_CustomOrderDetails';
        1: sTableName := 'BI_SellOrderDetails';
      end;
      if sTableName = '' then Exit;
      SqlData := 'F_iID='+IntToStr(iOrderID);
      try
        ADO_Rec := TADOQuery.Create(Self);
        DM_DataBase.GetTableData(ADO_Rec,sTableName,SqlData);
        sFBDW:='';
        if iOrderType = 0 then
          sFBDW := '������λ��'+ADO_Rec.FieldByName('F_sGgfbdw').AsString+#13#10;
        sHS := '��    �ͣ�'+ADO_Rec.FieldByName('F_sShrdz').AsString;
        sLXR := '��ϵ�ˣ�'+ADO_Rec.FieldByName('F_sShr').AsString+'  '+ADO_Rec.FieldByName('F_sShrsj').AsString;
        sYZTA := '����ͼ����'+ADO_Rec.FieldByName('F_sYztmc').AsString;
        mmo_bz.Text := sFBDW+sHS+'        '+sLXR +#13#10+sYZTA;
        sCPCC := ADO_Rec.FieldByName('F_sCpcc').AsString;
        edt_cpc.Text := StrLeft(sCPCC,'*');
        edt_cpk.Text := StrRight(sCPCC,'*');
      finally
        ADO_Rec.Free;
      end;
    end;    }
//    edt_bsts.Text := StrToNum(edt_zl.Text) div Length(OrderData);    //�����Լ��ϰ�ʽͼ��
    cbb_dyjb.Text := '���±��Ŀ���ɫ��';
    mmo_dysb.Text := '(TKTHK)�����ơ�|ר��';
    edt_hm.Text := '�й��������Ź�˾';
    cbb_sbks.Text := '4';
    cbb_sblb.Text := 'CTP';
    if Self.cb_Cookie.Checked then
      GetCookie(Frm_Print);
    Frm_Print.ShowModal;
    SetLength(OrderData,0);
    setLength(lab, 0);
    setLength(edt, 0);
    setLength(cbb, 0);
    Frm_Print.Free;
  end;
  TRzBitBtn(Sender).Caption := '������';
  btn_cx.Click;
end;

procedure TFra_kd.CustomLvAdd;
begin
  lv_jhxd.Items.BeginUpdate;
  lv_jhxd.Clear;
  lv_jhxd.Columns.Clear;
  lv_jhxd.Columns.Add.Caption := 'ѡ��';
  lv_jhxd.Columns.Items[lv_jhxd.Columns.Count-1].Width := 40;
  lv_jhxd.Columns.Add.Caption := '������������';
  lv_jhxd.Columns.Items[lv_jhxd.Columns.Count-1].Width := 100;
  lv_jhxd.Columns.Add.Caption := '�ջ�������';
  lv_jhxd.Columns.Items[lv_jhxd.Columns.Count-1].Width := 100;
  lv_jhxd.Columns.Add.Caption := '����ͼ����';
  lv_jhxd.Columns.Items[lv_jhxd.Columns.Count-1].Width := 100;
  lv_jhxd.Columns.Add.Caption := '�����';
  lv_jhxd.Columns.Items[lv_jhxd.Columns.Count-1].Width := 60;
  lv_jhxd.Columns.Add.Caption := 'ӡ��';
  lv_jhxd.Columns.Items[lv_jhxd.Columns.Count-1].Width := 40;
  lv_jhxd.Columns.Add.Caption := '��Ʒ�ߴ�';
  lv_jhxd.Columns.Items[lv_jhxd.Columns.Count-1].Width := 80;
  lv_jhxd.Columns.Add.Caption := '�Ƿ�ǩ��';
  lv_jhxd.Columns.Items[lv_jhxd.Columns.Count-1].Width := 80;
  lv_jhxd.Items.EndUpdate;
end;

procedure TFra_kd.SellLvAdd;
begin
  lv_jhxd.Items.BeginUpdate;
  lv_jhxd.Clear;
  lv_jhxd.Columns.Clear;
  lv_jhxd.Columns.Add.Caption := 'ѡ��';
  lv_jhxd.Columns.Items[lv_jhxd.Columns.Count-1].Width := 40;
  lv_jhxd.Columns.Add.Caption := 'Ҫ����������';
  lv_jhxd.Columns.Items[lv_jhxd.Columns.Count-1].Width := 150;
  lv_jhxd.Columns.Add.Caption := '�ջ�������';
  lv_jhxd.Columns.Items[lv_jhxd.Columns.Count-1].Width := 100;
  lv_jhxd.Columns.Add.Caption := '��Ʒ����';
  lv_jhxd.Columns.Items[lv_jhxd.Columns.Count-1].Width := 150;
  lv_jhxd.Columns.Add.Caption := '����ͼ����';
  lv_jhxd.Columns.Items[lv_jhxd.Columns.Count-1].Width := 80;
  lv_jhxd.Columns.Add.Caption := 'ӡ��';
  lv_jhxd.Columns.Items[lv_jhxd.Columns.Count-1].Width := 40;
  lv_jhxd.Columns.Add.Caption := '�Ƿ�ǩ��';
  lv_jhxd.Columns.Items[lv_jhxd.Columns.Count-1].Width := 80;
  lv_jhxd.Items.EndUpdate;
end;

procedure TFra_kd.ReadDataJhxd(ADO_Data: TADOQuery; Bz: integer);
var
  sQy, sJybz, sTgzt, sYztmc, sXpl, sCPBH: string;
  i,iCount,iType: integer;
begin
  lv_jhxd.Items.BeginUpdate;
  lv_jhxd.Items.Clear;
  iCount := 0;
  with ADO_Data do
  begin
    i := 0;
    while not Eof do
    begin
      iCount := FieldByName('Count').AsInteger;
      inc(i);
      if i mod 100 = 0 then
        btn_cx.Caption := '��ѯ��'+StrLeft(StrRep('.',(i div 100) Mod 4)+'   ',3);
      lv_jhxd.Items.Add.Caption := '';
     { case FieldByName('F_tiNJBZ').AsInteger of
        0:
          begin
            sYztmc := FieldByName('F_sYztmc').AsString
          end;
        1:
          begin
            sYztmc := '������ͼ';
          end;
      end;  }
      lab_zys.Tag := iCount div vMYTS;
      if iCount mod vMYTS > 0 then
        lab_zys.Tag := lab_zys.Tag +1;
      lab_zys.Caption := 'ҳ�Σ�1/'+ IntToStr(lab_zys.Tag);
      iType := FieldByName('F_tiOrderType').AsInteger;
      if iType = 0 then
      begin
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('F_sJg').AsString);
        if FieldByName('LRBZ').AsInteger > 0 then
          sCPBH := '*'+FieldByName('CPBH').AsString
        else
          sCPBH := FieldByName('CPBH').AsString;
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(sCPBH);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('CPLX').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('F_sYztmc').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('LGRQ').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('F_sKhmc').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('ZYL').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('F_sQttsgyms').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('F_sFJGY').AsString);
        case FieldByName('F_tiJybz').AsInteger of
          0: sJybz:= '��';
          1: sJybz:= '��ӡ';
        end;
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(sJybz);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('CYBZ').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('SYYL').AsString);
        case FieldByName('F_tiQy').AsInteger of
          0: sQy:= '��ǩ��';
          1: sQy:= 'ǩ��';
        end;
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(sQy);
        case FieldByName('F_iTgzt').AsInteger of
          0: sTgzt := 'ͼ��δ�յ�';
          1: sTgzt := 'ͼ�����յ�';
          2: sTgzt := 'ͼ��δ�ϸ�';
          3: sTgzt := 'ͼ���Ѻϸ�';
          4: sTgzt := '�Ѵ���';
          5: sTgzt := '��ǩ��';
          //6: sTgzt := 'ͼ�������';
        else
          sTgzt := FieldByName('F_iTgzt').AsString
        end;
        case FieldByName('F_tiXpl').AsInteger of
          0: sXpl := '��';
          1: sXpl := 'С����';
        end;
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(sXpl);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(sTgzt);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('F_iID').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(IntToStr(iType));
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('ApartID').AsString);
      end else
      if iType = 1 then
      begin
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('F_sJg').AsString);
        if FieldByName('LRBZ').AsInteger > 0 then
          sCPBH := '*'+FieldByName('CPBH').AsString
        else
          sCPBH := FieldByName('CPBH').AsString;
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(sCPBH);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('CPLX').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('F_sYztmc').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('LGRQ').AsString);
        //lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('F_sCpmc').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('F_sKhmc').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('ZYL').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('F_sQttsgyms').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('F_sFJGY').AsString);
        case FieldByName('F_tiJybz').AsInteger of
          0: sJybz:= '��';
          1: sJybz:= '��ӡ';
        end;
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(sJybz);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('CYBZ').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('SYYL').AsString);
        case FieldByName('F_tiQy').AsInteger of
          0: sQy:= '��ǩ��';
          1: sQy:= 'ǩ��';
        end;
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(sQy);
        case FieldByName('F_iTgzt').AsInteger of
          0: sTgzt := 'ͼ��δ�յ�';
          1: sTgzt := 'ͼ�����յ�';
          2: sTgzt := 'ͼ��δ�ϸ�';
          3: sTgzt := 'ͼ���Ѻϸ�';
          4: sTgzt := '�Ѵ���';
          5: sTgzt := '��ǩ��';
          //6: sTgzt := 'ͼ�������';
        else
          sTgzt := FieldByName('F_iTgzt').AsString
        end;
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add('��');
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(sTgzt);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('F_iID').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(IntToStr(iType));
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('ApartID').AsString);
      end;
      Next;
    end;
  end;
  lv_jhxd.Items.EndUpdate;
  vCount := vCount+i;
  gb_dd.Caption := '����  ����:'+IntToStr(iCount)+'��';
end;



procedure TFra_kd.lv_jhxdColumnClick(Sender: TObject; Column: TListColumn);
var
  i: Integer;
  bQx: Boolean;
begin
  if Column.Caption = 'ѡ��' then
  begin
    bQx := False;
    for i := 0 to TRzListView(Sender).Items.Count -1 do
    begin
      if not TRzListView(Sender).Items[i].Checked then
      begin
        bQx := True;
        Break
      end;
    end;
    if bQx then
    begin
      for i := 0 to TRzListView(Sender).Items.Count -1 do
        TRzListView(Sender).Items[i].Checked := True;
    end else
    begin
      for i := 0 to TRzListView(Sender).Items.Count -1 do
        TRzListView(Sender).Items[i].Checked := False;
    end;
  end else
  begin
    TRzListView(Sender).CustomSort(@RzCustomSortProc,Column.Index)
  end;
end;

procedure TFra_kd.lv_jhxdCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if (Item.Index mod 2) = 0 then
    Sender.Canvas.Brush.Color := $00F0FFF0//clWhite
  else
    Sender.Canvas.Brush.Color := $00F2F2F2;//$00EBEBEB;
  LVDrawItem(lv_jhxd, Item, State, DefaultDraw);

end;

procedure TFra_kd.menu_ddmxClick(Sender: TObject);
var
  SelItem: TListItem;
  iType,iOrderID: integer;
begin
//  if TMenuItem(Sender).Name = 'menu_ddmx' then
  SelItem := lv_jhxd.Selected;
  if not Assigned(SelItem) then Exit;
  iOrderID := StrToNum(SelItem.SubItems.Strings[c_OrderID]);
  iType := StrToNum(SelItem.SubItems.Strings[c_OrderType]);
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

procedure TFra_kd.lv_jhxdMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Point: TPoint;
  iType: integer;
begin
  if (X <= 20) then
  begin
    if Assigned(TRzListView(Sender).GetItemAt(X,Y)) then
      TRzListView(Sender).ItemIndex := TRzListView(Sender).GetItemAt(X,Y).Index;
  end;
  if Button = mbRight then
  begin
    if Assigned(TListView(Sender).Selected) and (X > 20) then
    begin
      GetCursorPos(Point);
      if TListView(Sender).Name = 'lv_jhxd' then
      begin
        //if menu_ddmxPic.Tag = c_Tag_MakeAllow then
        begin
          iType := StrToNum(TListView(Sender).Selected.SubItems.Strings[TListView(Sender).Selected.SubItems.Count-2]);
          if iType = 1 then
            menu_ddmxPic.Visible := False
          else
            menu_ddmxPic.Visible := True;
        end;
        pm_jhxd.Popup(Point.X,Point.Y);
      end;
    end;
  end else
  if (Button = mbleft) and (X > 20) then
  begin
    if not Assigned(TRzListView(Sender).Selected) then Exit;
    TRzListView(Sender).Selected.Checked := not TRzListView(Sender).Selected.Checked;
  end;
end;

procedure TFra_kd.GetCookie(Frm: TForm);
var
  i: integer;
  sValue,sName: string;
  MyReg: TRegistry;
begin
  MyReg := TRegistry.Create;
  MyReg.RootKey := HKEY_LOCAL_MACHINE;
  if MyReg.OpenKey('SOFTWARE\YDPrint\Cookie\WorkOrder\',False) then
  begin
    for i := 0 to Frm.ComponentCount -1 do
    begin
      sValue := '';
      if (Frm.Components[i] is Ti_TxtFilter) or (Frm.Components[i] is Ti_ComboBox) or (Frm.Components[i] is TComboBox) or (Frm.Components[i] is TRzDateTimePicker)
        or (Frm.Components[i] is TRzMemo) then
      begin
        sName := Frm.Components[i].Name;
        if MyReg.ValueExists(sName) then
        begin
          sValue := MyReg.ReadString(sName);
          if Frm.Components[i] is TRzDateTimePicker then
          begin
            if TRzDateTimePicker(Frm.Components[i]).Enabled then
              TRzDateTimePicker(Frm.Components[i]).Date := StrToDate(sValue);;
          end;
          if (Frm.Components[i] is Ti_ComboBox) or (Frm.Components[i] is TComboBox) then
            Ti_ComboBox(Frm.Components[i]).Text := sValue
          else
            TEdit(Frm.Components[i]).Text := sValue;
        end;
      end;
  end;
  MyReg.CloseKey;
  MyReg.Free;
  end
end;

procedure TFra_kd.lab_ts50Click(Sender: TObject);
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
  TLabel(Sender).Font.Color :=  clBlack;
  TLabel(Sender).Font.Size := 10;
  TLabel(Sender).Font.Style := [fsBold];
  TLabel(Sender).Cursor := crDefault;
  ReadDataJHXD(ADO_Rec,-1);
  ADO_Rec.Free;
  vYs := 1;
  lab_zys.Caption := 'ҳ�Σ�1/'+ IntToStr(lab_zys.Tag);

end;

procedure TFra_kd.btn_goClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  iYs: Integer;
begin
  Screen.Cursor := crHourGlass;
  iYs := StrToNum(edt_ys.Text);
  ADO_Rec := DM_DataBase.OpenQuery(vSqlData,[iYs,vMYTS]);
  ReadDataJHXD(ADO_Rec,-1);
  lab_zys.Caption := 'ҳ�Σ�'+IntToStr(iYs)+'/'+ IntToStr(lab_zys.Tag);
  vYs := iYs;
  Screen.Cursor := crDefault;
end;

procedure TFra_kd.lab_firstClick(Sender: TObject);
begin
  if vYs = 1 then Exit;
  edt_ys.Text := '1';
  btn_go.Click;
end;

procedure TFra_kd.lab_upClick(Sender: TObject);
begin
  if vYs > 1 then
  begin
    edt_ys.Text := IntToStr(vYs -1);
    btn_go.Click;
  end;
end;

procedure TFra_kd.lab_downClick(Sender: TObject);
begin
  if vYs < lab_zys.Tag then
  begin
    edt_ys.Text := IntToStr(vYs +1);
    btn_go.Click;
  end;
end;

procedure TFra_kd.lab_lastClick(Sender: TObject);
begin
  if vYs = lab_zys.Tag then Exit;
  edt_ys.Text := IntToStr(lab_zys.Tag);
  btn_go.Click;

end;

procedure TFra_kd.btn_kgdClick(Sender: TObject);
var
  i,n,iOrderID,iOrderType,iTemp,iIndex: Integer;
  sGDH,sPM: string;
  sCpbh, sKhmc,sApartID,sSl,sYl: string;
  sTempZB,sTempZD: string;
  ADO_Rec: TADOQuery;
  sTableName,SqlData,sFBDW,sHS,sLXR,sYZTA,sCPCC,sPrefixCode,sNFGBRQ,sPrefixStyle: string;
  sCPLX, sYZTMC, sXPL: string;
  bDdlx:Boolean;
  sSqlData: string;
  sDate, sYear, sMonth, sDay: string;
begin
  bDdlx := False;
  n := 0;
  for i := 0 to lv_jhxd.Items.Count -1 do
  begin
    if lv_jhxd.Items[i].Checked then
    begin
      if sCPLX = '' then
        sCPLX := lv_jhxd.Items[i].SubItems[c_cplx];
      if sCPLX <> lv_jhxd.Items[i].SubItems[c_cplx] then
        bDdlx := True;
      Inc(n);
    end;
  end;
  if (n=0) or (lv_jhxd.Items.Count = 0) then
  begin
    Application.MessageBox('��ѡ������һ��','��ʾ',MB_ICONINFORMATION);
    Exit;
  end;
  if n > 100 then
  begin
    if Application.MessageBox('�������ѳ���100��!ȷ�Ͻ��д˲���?','��ʾ',MB_YESNO+MB_ICONINFORMATION)=IDNO then
      Exit;
  end;
  if bDdlx then
  begin
    if Application.MessageBox('��ѡ�Ķ����д��ڶ������Ͳ�һ���Ķ���,�Ƿ�����˲���?','��ʾ',MB_YESNO+MB_ICONINFORMATION)=IDNO then
      Exit;
  end;

  TRzBitBtn(Sender).Caption := '������...';
  Frm_WorkOrder := TFrm_WorkOrder.Create(Self);
  iIndex := 0;
  sPM := '';
  n := 0;
  iTemp := 0;
  SetLength(OrderData,0);
  for i := 0 to lv_jhxd.Items.Count -1 do
  begin
    if lv_jhxd.Items[i].Checked then
    begin
      sCpbh := lv_jhxd.Items[i].SubItems[c_CPBH];
      if Copy(sCpbh,1,1) = '*' then
        sCpbh := Copy(sCpbh,2,Length(sCpbh));
      sKhmc := lv_jhxd.Items[i].SubItems[c_khmc];
      sSl := lv_jhxd.Items[i].SubItems[c_syyl];
      sYl := lv_jhxd.Items[i].SubItems[c_zyl];
      sCPLX := lv_jhxd.Items[i].SubItems[c_cplx];
      sYZTMC := lv_jhxd.Items[i].SubItems[c_yztmc];
      sXPL := lv_jhxd.Items[i].SubItems[c_xpl];
      Frm_WorkOrder.edt_zl.Text := StrToNum(Frm_WorkOrder.edt_zl.Text)+StrToNum(sSl);
      iOrderID := StrToNum(lv_jhxd.Items[i].SubItems[c_OrderID]);
      if iTemp = 0 then iTemp := iOrderID;
      if iTemp <> iOrderID then  iTemp := -1;
      iOrderType := StrToInt(lv_jhxd.Items[i].SubItems[c_OrderType]);
      sApartID := lv_jhxd.Items[i].SubItems[c_ApartID];
      SetLength(OrderData,Length(OrderData)+1);
      OrderData[Length(OrderData)-1].m_iXH := n;
      if pos('(�ڼ�)',sCpbh) >0 then
        sCpbh := StrLeft(sCpbh,Length(sCpbh)-6);
      OrderData[Length(OrderData)-1].m_sCPBH := sCpbh;
      OrderData[Length(OrderData)-1].m_sKhmc := sKhmc;
      OrderData[Length(OrderData)-1].m_sCplx := sCPLX;
      OrderData[Length(OrderData)-1].m_sYztmc := sYZTMC;
      OrderData[Length(OrderData)-1].m_iXPL := iif(sXPL='С����',1,0);
      OrderData[Length(OrderData)-1].m_iSyyl := StrToInt(sSl);
      OrderData[Length(OrderData)-1].m_iYl := StrToInt(sYl);
      OrderData[Length(OrderData)-1].m_iApartID := StrToInt(sApartID);
      OrderData[Length(OrderData)-1].m_iType := iOrderType;
      OrderData[Length(OrderData)-1].m_iOrderID :=  iOrderID;
      OrderData[Length(OrderData)-1].m_sSl :=  '';
      OrderData[Length(OrderData)-1].m_sZH :=  '';
      OrderData[Length(OrderData)-1].m_sRJHDQ :=  '';
      OrderData[Length(OrderData)-1].m_sRJHDZ :=  '';
      OrderData[Length(OrderData)-1].m_sBZ :=  '';

      if viItemIndex = i then
        iIndex := Length(OrderData)-1;

      //CreateFrame(sKhmc,sCpbh,'','1',sSl,'',sApartID,n);
      {if sTempZB <> sKhmc then
      begin
        sTempZB := sKhmc;
        mmo_zbbz.Lines.Add(sKhmc);
      end;
      mmo_zbbz.Lines.Add(sCpbh);                }
//        mmo_dybz.Lines.Add(sCpbh+#13#10);

      inc(n);
    end;
  end;
  //if (viItemIndex >= 0)  and (viItemIndex < Length(OrderData))then
  //  iIndex := viItemIndex;
  //------�ж����ɹ����������Ƿ�����------------------------------------
  if OrderData[iIndex].m_iType = 0 then
    sSqlData := 'Select e.F_sPrefixCode,e.F_sNFGBRQ,e.F_sPrefixStyle '
      +' from DO_OrderApart a,BI_CustomOrderDetails b,Set_ProductCategory c,Set_PostageType d,Set_ProductType e   '
      +' where a.F_iOrderID=b.F_iID and a.F_tiCXBZ = 0 and a.F_sYZTMC like ''%%''+d.F_sYZTMC+''%%'' and b.F_iProductType=c.F_iClassCode '
      +' and c.F_iID = e.F_iProductCategoryID and d.F_iProductTypeID=e.F_iID and a.F_iID=%d '
  else if OrderData[iIndex].m_iType = 1 then
    sSqlData := 'Select e.F_sPrefixCode,e.F_sNFGBRQ,e.F_sPrefixStyle '
      +' from DO_OrderApart a,BI_SellOrderDetails b,Set_ProductCategory c,Set_PostageType d,Set_ProductType e   '
      +' where a.F_iOrderID=b.F_iID and a.F_tiCXBZ = 0 and a.F_sYZTMC like ''%%''+d.F_sYZTMC+''%%'' and b.F_iProductType=c.F_iClassCode '
      +' and c.F_iID = e.F_iProductCategoryID and d.F_iProductTypeID=e.F_iID and a.F_iID=%d ';

  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[OrderData[iIndex].m_iApartID],False);
  if ADO_Rec = nil then
  begin
    TRzBitBtn(Sender).Caption := '������';
    Frm_WorkOrder.Free;
    Exit;
  end;
  sPrefixCode := '';
  if ADO_Rec.RecordCount > 0 then
  begin
    if trim(ADO_Rec.FieldByName('F_sPrefixStyle').AsString) = '' then
    begin
      p_MessageBoxDlg('�������ù�����ǰ׺!');
      TRzBitBtn(Sender).Caption := '������';
      Frm_WorkOrder.Free;
      ADO_Rec.Free;
      Exit;
    end;
  end else
  begin
    p_MessageBoxDlg('���󣺻�ȡ����������,����������ͼ�Ĳ�Ʒ����!!!');
    TRzBitBtn(Sender).Caption := '������';
    Frm_WorkOrder.Free;
    ADO_Rec.Free;
    Exit;
  end;

  sPM := OrderData[iIndex].m_sCplx;
  //---------------------------------------
  //�������ڼ��Ķ���
  sSqlData := ' select 1 from DO_OrderApart where F_iOrderID=%d and F_tiOrderType=%d and F_tiNJBZ=1 and F_iID<>%d and F_tiCXBZ=0' ;
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[OrderData[iIndex].m_iOrderID,OrderData[iIndex].m_iType,OrderData[iIndex].m_iApartID]);
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount>0) then
  begin
    sPM := sPM + '(���ڼ�)';
  end;
  ADO_Rec.Free;
  Frm_WorkOrder.edt_pm.Text := sPM;
  with Frm_WorkOrder do
  begin
    sSqlData := 'select cast('''' as varchar(500)) orders,cast('''' as varchar(500)) JTMC,cast(0 as int) BSTYS,cast(0 as int) BSTZS '
      +',cast('''' as varchar(500)) CL,cast('''' as varchar(500)) ZB  into #s '
      +'select * from #s ';
    with Frm_WorkOrder.ADO_WorkOrder do
    begin
      Close;
      SQL.Text := sSqlData;
      Open;
    end;
//    Frm_WorkOrder.ADO_WorkOrder.Open;
    for i := 0 to ComponentCount -1 do
    begin
      if Components[i] is TRzDateTimePicker then
      begin
        if Components[i].Name = 'dtp_jhrq' then
          TRzDateTimePicker(Components[i]).DateTime := IncDay(Now,5)
        else
          TRzDateTimePicker(Components[i]).DateTime := Now;
      end;
    end;

    SetLength(OrderGroup,0);
    SetLength(aBST,0);
    SetLength(aYSDH,0);
    SetLength(aCL,0);
    SetLength(aZB,0);
    SetLength(aZBGX,0);
    SetLength(aRJHD,0);
    Frm_WorkOrder.vActionType := c_WorkOrder_KD;
    Frm_WorkOrder.vActionType := c_WorkOrder_KD;

    Frm_WorkOrder.ShowModal;
    SetLength(OrderData,0);
  end;
  TRzBitBtn(Sender).Caption := '������';
  btn_cx.Click;
  Frm_WorkOrder.Free;
end;

procedure TFra_kd.cb_syylClick(Sender: TObject);
begin
  if cb_syyl.Checked then
  begin
    edt_syylq.Enabled :=  True;
    edt_syylz.Enabled :=  True;
    edt_syylq.Color := clWindow;
    edt_syylz.Color := clWindow;
  end else
  begin
    edt_syylq.Enabled :=  False;
    edt_syylz.Enabled :=  False;
    edt_syylq.Color := clBtnFace;
    edt_syylz.Color := clBtnFace;
  end;
end;

procedure TFra_kd.FraShow;
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
  iAllowID, iAllowCode: Integer;
begin
  if LoginData.m_iAllowCode >= 0 then
  begin
    iAllowCode := LoginData.m_iAllowCode;
    sSqlData := 'Select F_iID from Set_AllowInfo where F_tiStatus = 1 and F_sCode=''%s'' order by F_iID';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[c_Allow_FWDDTG],False);
    if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
    begin
      iAllowID := ADO_Rec.FieldByName('F_iID').AsInteger;
      if 1 shl iAllowID or iAllowCode = iAllowCode then
      begin
        menu_ddmxPic.Enabled := True;
        menu_ddmxPic.Tag := c_Tag_MakeAllow;;
      end else
      begin
        menu_ddmxPic.Enabled := False;
        menu_ddmxPic.Tag := 0;
      end;
    end;
    if Assigned(ADO_Rec) then
      ADO_Rec.Free;
  end;
end;

procedure TFra_kd.lv_jhxdCheckStateChange(Sender: TObject;
  Item: TListItem);
var
  i: Integer;
begin
  if Item.Checked then
  begin
    if viItemIndex = -1 then
    begin
      viItemIndex := Item.Index;
    end;
  end else
  begin
    if viItemIndex = Item.Index then
    begin
      viItemIndex := -1;
      for i := 0 to lv_jhxd.Items.Count -1 do
      begin
        if lv_jhxd.Items[i].Checked then
        begin
          viItemIndex := i;
          Break;
        end;
      end;
    end;
  end;
end;

end.






