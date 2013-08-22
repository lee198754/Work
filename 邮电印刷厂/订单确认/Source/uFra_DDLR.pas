unit uFra_DDLR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RzCmboBx, iComboBox, RzButton, RzRadChk, ComCtrls,
  RzDTP, ButtonEdit, ExtCtrls,ADODB,uBaseForm;

type
  TFra_DDLR = class(TFrmFrame)
    edt_khmc: Ti_TxtFilter;
    edt_yl: Ti_TxtFilter;
    cbb_tsgy: Ti_TxtFilter;
    edt_sbbbh: Ti_TxtFilter;
    dtp_lgrq: TRzDateTimePicker;
    dtp_jhrq: TRzDateTimePicker;
    rb_bb_dzx: TRzRadioButton;
    rb_bb_xsx: TRzRadioButton;
    rb_bb_dfb: TRzRadioButton;
    cbb_cplx: Ti_ComboBox;
    cbb_yztmc: Ti_ComboBox;
    edt_cpbh_1: TEdit;
    edt_cpbh_2: TEdit;
    edt_cpbh_3: TEdit;
    Label1: TLabel;
    lab_lry: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    btn_ok_old: TButton;
    btn_reset: TButton;
    Label12: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edt_cpbh_4: TEdit;
    Label17: TLabel;
    Panel1: TPanel;
    rb_qy_yes: TRzRadioButton;
    rb_qy_no: TRzRadioButton;
    Label2: TLabel;
    cb_jy: TCheckBox;
    cbb_kh: Ti_ComboBox;
    btn_tsgy: TButton;
    cbb_cplb: Ti_ComboBox;
    Label16: TLabel;
    Panel2: TPanel;
    rb_xpl_yes: TRzRadioButton;
    rb_xpl_no: TRzRadioButton;
    btn_ok: TButton;
    edt_cpbh_0: TEdit;
    cb_pp: TCheckBox;
    procedure btn_resetClick(Sender: TObject);
    procedure btn_ok_oldClick(Sender: TObject);
    procedure cbb_cplxChange(Sender: TObject);
    procedure edt_cpbh_1KeyPress(Sender: TObject; var Key: Char);
    procedure edt_ylExit(Sender: TObject);
    procedure btn_tsgyClick(Sender: TObject);
    procedure cbb_cplbChange(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    { Private declarations }
    function IsBlack: Boolean;     //判断是否数据都有输入
  public
    { Public declarations }
    vSucceed: Boolean;
    procedure FraShow;
  end;

implementation

uses
  DateUtils, uDM_DataBase, PubStr, uPub_Func, uPub_Type, uFrm_Tsgy_modif,
  uFrmFJ;

{$R *.dfm}

procedure TFra_DDLR.btn_resetClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Self.ComponentCount -1 do
  begin
    if Self.Components[i].Tag <> 10 then
    begin
      if (Self.Components[i] is Ti_TxtFilter)  or (Self.Components[i] is TEdit)  then
        Ti_TxtFilter(Self.Components[i]).Text := '';
      if (Self.Components[i] is TRzRadioButton) then
        TRzRadioButton(Self.Components[i]).Checked := False;
      if (Self.Components[i] is Ti_ComboBox) or (Self.Components[i] is TComboBox) then
        Ti_ComboBox(Self.Components[i]).ItemIndex := 0;
    end;
  end;
  cbb_yztmc.Clear;
//  edt_cpbh_2.Text := '13';
  edt_cpbh_4.Text := '000';
  dtp_lgrq.DateTime := Now;
  dtp_jhrq.DateTime := IncDay(Now,5);
  rb_xpl_no.Checked := True;
  rb_qy_no.Checked := True;
end;

procedure TFra_DDLR.btn_ok_oldClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData,sTableName,sCpbh,sYztmc,sID: string;
  iID,iDetailsID,iFJNJBZ: integer;
  str,sJsrq: string;
  dJsrq: TDateTime;
begin
  vSucceed := False;
  sCpbh := '12-'+trim(edt_cpbh_1.Text)+'-'+trim(edt_cpbh_2.Text)+'-'+trim(edt_cpbh_3.Text)+'-'+trim(edt_cpbh_4.Text);
  if IsBlack then Exit;
  sYztmc := cbb_yztmc.Text;
  if sYztmc = '' then
  begin
    Application.MessageBox(PChar('请选择 "'+cbb_yztmc.LabelCaption+'" !'),'提示',MB_ICONINFORMATION);
    cbb_yztmc.SetFocus;
    exit;
  end;
  if Length(sCpbh) <> 21 then
  begin
    if Application.MessageBox('产品编号长度不对,请问是否继续?','提示',MB_YESNO + MB_ICONQUESTION) = IDNO then
      Exit;
  end;

  sTableName := iif(rb_bb_xsx.Checked,'BI_SellOrder a,BI_SellOrderDetails b','BI_CustomOrder a,BI_CustomOrderDetails b');
  sSqlData := 'Select Max(F_dJsrq) F_dJsrq from %s where b.F_sCpbh=''%s'' and CHARINDEX(''%s'',b.F_sYztmc)=1 and a.F_tiDfbbz=%d and b.F_tiCXBZ=0 and b.F_tiJybz=%d';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sTableName,sCpbh,sYztmc,Integer(iif(rb_bb_dfb.Checked,1,0)),Integer(iif(cb_jy.Checked,1,0))]);
  dJsrq :=  ADO_Rec.FieldByName('F_dJsrq').AsDateTime;
  if (ADO_Rec.RecordCount >0) and (YearOf(dJsrq)>2000) then
  begin
    sJsrq := FormatDateTime('yyyy-MM-dd hh:mm:ss',ADO_Rec.FieldByName('F_dJsrq').AsDateTime);
    str := '产品编号：'+sCpbh+' 已存在,最后操作日期为'+sJsrq+',请问是否继续?';
    if Application.MessageBox(PChar(str),'提示',MB_YESNO + MB_ICONQUESTION) = IDNO then
      Exit;
  end;
  ADO_Rec.Free;
  try
    try
      DM_DataBase.Con_YDPrint.BeginTrans;
      sTableName := iif(rb_bb_xsx.Checked,'BI_SellOrder','BI_CustomOrder');
      DM_DataBase.GetMaxID(sTableName,'F_iID',sID,1,1);
      iID := StrToNum(sID);
      sSqlData := 'Select * from %s where 1=2';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sTableName]);
      with ADO_Rec do
      begin
        Insert;
        FieldByName('F_iID').AsInteger := iID;
        FieldByName('F_tiLrbz').AsInteger := 1;
        FieldByName('F_tiDfbbz').AsInteger := iif(rb_bb_dfb.Checked,1,0);
        FieldByName('F_dJsrq').AsDateTime := dtp_lgrq.DateTime;
        FieldByName('F_sSbbbh').AsString := Trim(edt_sbbbh.Text);
        Post;
      end;
      ADO_Rec.Free;
      sTableName := iif(rb_bb_xsx.Checked,'BI_SellOrderDetails','BI_CustomOrderDetails');
      sSqlData := 'Select * from %s where 1=2';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sTableName]);
      iDetailsID := DM_DataBase.GetMaxID('select IsNull(Max(F_iID),0) from '+sTableName)+1 ;
      with ADO_Rec do
      begin
        Insert;
        FieldByName('F_iID').AsInteger := iDetailsID;
        //FieldByName('F_iProductType').AsInteger := StrToNum(edt_cpbh_2.Text);
        if StrToNum(edt_cpbh_2.Text) = 13 then
          FieldByName('F_iProductType').AsInteger := 13
        else
          FieldByName('F_iProductType').AsInteger := 0;
        FieldByName('F_sJg').AsString := Trim(cbb_kh.Text);
        FieldByName('F_nYl').AsFloat := StrToNum(edt_yl.Text)/10000;
        FieldByName('F_sYztmc').AsString := Trim(cbb_yztmc.Text);
        FieldByName('F_sCPBH').AsString := sCpbh;
        FieldByName('F_sQttsgyms').AsString := Trim(cbb_tsgy.Text);
        FieldByName('F_sCkjhrq').AsDateTime := dtp_jhrq.DateTime;
        FieldByName('F_tiJybz').AsInteger := iif(cb_jy.Checked,1,0);
        FieldByName('F_tiXpl').AsInteger := iif(rb_xpl_yes.Checked,1,0);
        FieldByName('F_tiQy').AsInteger := iif(rb_qy_yes.Checked,1,0);
        FieldByName('F_iTgzt').AsInteger := 1;
        FieldByName('F_sCkjhrq').AsDateTime := dtp_jhrq.DateTime;
        FieldByName('F_dCzrq').AsDateTime := Now;
        FieldByName('F_iCzrID').AsInteger := LoginData.m_iUserID;
        if rb_bb_xsx.Checked then
        begin
          FieldByName('F_sCpmc').AsString := Trim(edt_khmc.Text);
          FieldByName('F_iSellID').AsInteger := iID;
        end else
        begin
          FieldByName('F_sKhmc').AsString := Trim(edt_khmc.Text);
          FieldByName('F_iCustomID').AsInteger := iID;
        end;
        Post;
      end;
      ADO_Rec.Free;
      sSqlData := 'Select * from DO_OrderApart where 1=2';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
      with ADO_Rec do
      begin
        Insert;
        FieldByName('F_tiOrderType').AsInteger := iif(rb_bb_xsx.Checked,1,0);
        FieldByName('F_iOrderID').AsInteger := iDetailsID;
        FieldByName('F_sCPBH').AsString := sCpbh;
        FieldByName('F_nYl').AsFloat := StrToNum(edt_yl.Text)/10000;
        FieldByName('F_sYztmc').AsString := Trim(cbb_yztmc.Text);
        if Trim(cbb_yztmc.Text) = '无邮资图' then
          FieldByName('F_tiNJBZ').AsInteger := 1
        else
          FieldByName('F_tiNJBZ').AsInteger := 0;
        Post;
        //不自动生成内件
        {sSqlData := 'Select F_tiFJNJBZ from Set_ProductType where CHARINDEX(F_sTypeName,'''+Trim(cbb_cplx.Text)+''')=1 ';
        iFJNJBZ := DM_DataBase.GetTableFirst(sSqlData);
        if iFJNJBZ = 1 then
        begin
          if Application.MessageBox('是否要生成内件?','提示',MB_YESNO+MB_ICONINFORMATION) = IDYES then
          begin
            Insert;
            FieldByName('F_tiOrderType').AsInteger := iif(rb_bb_xsx.Checked,1,0);
            FieldByName('F_iOrderID').AsInteger := iDetailsID;
            FieldByName('F_sCPBH').AsString := sCpbh;
            FieldByName('F_nYl').AsFloat := StrToNum(edt_yl.Text)/10000;
            FieldByName('F_sYztmc').AsString := '无邮资图';
            FieldByName('F_tiNJBZ').AsInteger := 1;
            Post;
          end;
        end;   }
      end;
      DM_DataBase.Con_YDPrint.CommitTrans;
      Application.MessageBox('添加成功','提示',MB_ICONINFORMATION);
      vSucceed := True;
      btn_reset.Click
    except
      on E: Exception do
      begin
        DM_DataBase.Con_YDPrint.RollbackTrans;
        Application.MessageBox(PChar('错误:'+E.message),'提示',MB_ICONINFORMATION);
      end;
    end;
  finally
    ADO_Rec.Free;
  end;          

end;

procedure TFra_DDLR.FraShow;
begin
  cbb_cplb.Clear;
  cbb_cplb.Items.Add('--请选择--');
  CbbAdd(cbb_cplb,pkProductCategory);
  cbb_cplb.ItemIndex := 0;
  cbb_cplx.Clear;
  cbb_cplx.Add('--请选择--');
  CbbAdd(cbb_cplx,pkProductType,FindProductCategoryID(cbb_cplb.ItemIndex));
  cbb_cplx.ItemIndex := 0;
  CbbParamAdd(TComboBox(cbb_kh),'客户');
//  cbb_kh.Insert(0,'请选择');
  cbb_kh.Insert(0,'--请选择--');
  cbb_kh.ItemIndex := 0;
  edt_cpbh_0.Text := FormatDateTime('yy',Now);

  btn_reset.Click;
end;

procedure TFra_DDLR.cbb_cplxChange(Sender: TObject);
var
  i, iClassCode: integer;
begin
  cbb_yztmc.Clear;
  iClassCode := FindProductCategoryData(FindProductCategoryID(cbb_cplb.ItemIndex)).m_iClassCode;
  for i := 0 to Length(PostageType) -1 do
  begin
    if PostageType[i].m_rProductType.m_iID=FindProductTypeID(cbb_cplx.ItemIndex,iClassCode) then
    begin
      cbb_yztmc.Add(PostageType[i].m_sYZTMC);
    end;
  end;
  cbb_yztmc.ItemIndex := 0;
end;

function TFra_DDLR.IsBlack: Boolean;
var
  i: Integer;
  comp: TComponent;
begin
  Result := False;
  if (not rb_bb_dzx.Checked) and (not rb_bb_dfb.Checked) and (not rb_bb_xsx.Checked) then
  begin
    Application.MessageBox(PChar('请选择 “版别” ！'),'提示',MB_ICONINFORMATION);
    Result := True;
    Exit;
  end;
  for i := 0 to Self.ComponentCount -1 do
  begin
    comp := Self.Components[i];
    if comp.Tag = 1 then Continue;
    if (comp is Ti_TxtFilter)  then
    begin
      if Ti_TxtFilter(comp).Text = '' then
      begin
        Application.MessageBox(PChar('请输入 "'+Ti_TxtFilter(comp).LabelCaption+'" !'),'提示',MB_ICONINFORMATION);
        Ti_TxtFilter(comp).SetFocus;
        Result := True;
        Exit;
      end;
    end else
    if (comp is Ti_ComboBox) then
    begin
      if (Ti_ComboBox(comp).Text = '') or (Ti_ComboBox(comp).Text = '--请选择--') then
      begin
        Application.MessageBox(PChar('请选择 “'+Ti_ComboBox(comp).LabelCaption+'” ！'),'提示',MB_ICONINFORMATION);
        Ti_ComboBox(comp).SetFocus;
        Result := True;
        Exit;
      end;
    end else
    if (comp is TEdit) then
    begin
      if TEdit(comp).Text = '' then
      begin
        Application.MessageBox(PChar('请输入 “产品编号” ！'),'提示',MB_ICONINFORMATION);
        TEdit(comp).SetFocus;
        Result := True;
        Exit;
      end;
    end;
  end;
end;

procedure TFra_DDLR.edt_cpbh_1KeyPress(Sender: TObject; var Key: Char);
begin
  if ((Ord(Key) < Ord('0')) or (Ord(Key)>Ord('9'))) and (Ord(Key)<> VK_BACK)  then
    Key := #0;
end;

procedure TFra_DDLR.edt_ylExit(Sender: TObject);
begin
  try
    if StrToNum(TEdit(Sender).Text) > High(Integer) then
    begin
      Application.MessageBox('输入数值超过可用范围!','提示',MB_ICONINFORMATION);
      TEdit(Sender).Text:= '';
      TEdit(Sender).SetFocus;
      Exit;
    end;
  except
    Application.MessageBox('输入数值超过可用范围!','提示',MB_ICONINFORMATION);
    TEdit(Sender).Text:= '';
    TEdit(Sender).SetFocus;
    Exit;
  end;
end;

procedure TFra_DDLR.btn_tsgyClick(Sender: TObject);
var
  sTsgy: string;
  i: integer;
begin
  Frm_Tsgy_modif := TFrm_Tsgy_modif.Create(Self);
  sTsgy := cbb_tsgy.Text;
  CbParamAdd(Frm_Tsgy_modif.cb_gyyq,'特殊工艺');
  for i := 0 to Frm_Tsgy_modif.cb_gyyq.Items.Count -1 do
  begin
    if Pos(Frm_Tsgy_modif.cb_gyyq.Items.Strings[i],sTsgy) > 0 then
      Frm_Tsgy_modif.cb_gyyq.Checked[i] := True;
  end;
  Frm_Tsgy_modif.mmo_tsgy.Text := sTsgy;
  Frm_Tsgy_modif.vUpdate := False;
  if Frm_Tsgy_modif.ShowModal = mrOk then
    cbb_tsgy.Text := Frm_Tsgy_modif.mmo_tsgy.Text;
  Frm_Tsgy_modif.Free;
end;

procedure TFra_DDLR.cbb_cplbChange(Sender: TObject);
var
  iProductCategoryID: Integer;
begin
  iProductCategoryID := FindProductCategoryID(cbb_cplb.ItemIndex);
  cbb_cplx.Clear;
  cbb_cplx.Items.Add('--请选择--');
  CbbAdd(cbb_cplx,pkProductType,iProductCategoryID);
  cbb_cplx.ItemIndex := 0;

end;

procedure TFra_DDLR.btn_okClick(Sender: TObject);
var
  ADO_Rec,ADO_Temp: TADOQuery;
  sSqlData,sTableName,sCpbh,sFJCPBH,sNJCPBH,sYztmc,sID: string;
  sBB: string;
  i, iID,iDetailsID,iFJNJBZ,iApartCount,iOrderType,iDFBBZ,iCplb,iJyxh: integer;
  str,sJsrq: string;
  dJsrq: TDateTime;
begin
  vSucceed := False;
  sCpbh := trim(edt_cpbh_0.Text)+'-'+trim(edt_cpbh_1.Text)+'-'+trim(edt_cpbh_2.Text)+'-'+trim(edt_cpbh_3.Text)+'-'+trim(edt_cpbh_4.Text);
  iOrderType := iif(rb_bb_xsx.Checked,1,0);
  iDFBBZ := iif(rb_bb_dfb.Checked,1,0);
  if IsBlack then Exit;
  sYztmc := cbb_yztmc.Text;
  if sYztmc = '' then
  begin
    Application.MessageBox(PChar('请选择 "'+cbb_yztmc.LabelCaption+'" !'),'提示',MB_ICONINFORMATION);
    cbb_yztmc.SetFocus;
    exit;
  end;
  if Length(sCpbh) <> 21 then
  begin
    if Application.MessageBox('产品编号长度不对,请问是否继续?','提示',MB_YESNO + MB_ICONQUESTION) = IDNO then
      Exit;
  end;

  //-----判断是否已存在-------------------------------
  sTableName := iif(rb_bb_xsx.Checked,'BI_SellOrder a,BI_SellOrderDetails b','BI_CustomOrder a,BI_CustomOrderDetails b');
  sSqlData := 'select Max(F_dJsrq) F_dJsrq from %s,DO_OrderApart c where c.F_sCpbh=''%s'' and CHARINDEX(''%s'',c.F_sYztmc)=1 and a.F_tiDfbbz=%d and b.F_tiCXBZ=0 and b.F_tiJybz=%d';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sTableName,sCpbh,sYztmc,Integer(iif(rb_bb_dfb.Checked,1,0)),Integer(iif(cb_jy.Checked,1,0))]);
  dJsrq :=  ADO_Rec.FieldByName('F_dJsrq').AsDateTime;
  if (ADO_Rec.RecordCount >0) and (YearOf(dJsrq)>2000) then
  begin
    sJsrq := FormatDateTime('yyyy-MM-dd hh:mm:ss',ADO_Rec.FieldByName('F_dJsrq').AsDateTime);
    str := '产品编号：'+sCpbh+' 已存在,最后操作日期为'+sJsrq+',请问是否继续?';
    if Application.MessageBox(PChar(str),'提示',MB_YESNO + MB_ICONQUESTION) = IDNO then
      Exit;
  end;
  ADO_Rec.Free;
  //-------------------------------------------------------
  //---录入信息再次确认-----------------------------------
  sBB := iif(rb_bb_dzx.Checked,'定制型','销售型');
  sBB := iif(rb_bb_dfb.Checked,'地方版',sBB);
  str := Format('来搞日期: %s ' + #13#10 + '版别：%s' + #13#10
          + '客户：%s' + #13#10 + '产品编号：%s ' + #13#10
          + '品名：%s' + #13#10 + '印刷数量：%s 枚' + #13#10
          + '是否小批量：%s' + #13#10 + '产品类别：%s' + #13#10
          + '产品类型：%s' + #13#10 + '邮资图：%s' + #13#10
          + '特殊工艺：%s' + #13#10 + '申报编号：%s' + #13#10
          + '交货日期：%s' + #13#10 + '是否签样：%s' + #13#10
          + '录入员：%s',
          [FormatDateTime('yyyy-MM-dd',dtp_lgrq.DateTime),sBB
           ,cbb_kh.Text,sCpbh
           ,edt_khmc.Text,edt_yl.Text
           ,iif(rb_xpl_yes.Checked,'是','否'),cbb_cplb.Text
           ,cbb_cplx.Text,cbb_yztmc.Text
           ,cbb_tsgy.Text,edt_sbbbh.Text
           ,FormatDateTime('yyyy-MM-dd',dtp_jhrq.DateTime),iif(rb_qy_yes.Checked,'是','否')
           ,lab_lry.Caption ]);
  if p_MessageBoxDlg(str,'提示',MB_OKCANCEL + MB_ICONINFORMATION)= IDCANCEL then
    Exit;
  //----------------------------------------------------


  iApartCount := 1;
  if StrRight(sCpbh,3)='999' then
  begin
    str := '1';
    if InputQueryEH('按印量平均分解','分解个数：',str) then
    begin
      iApartCount := StrToNum(str);
      if iApartCount = 0 then
      begin
        p_MessageBoxDlg('分解个数不能为0!');
        Exit;
      end;
    end else
      Exit;
  end;

  try
    try
      DM_DataBase.Con_YDPrint.BeginTrans;
      iCplb := FindProductCategoryID(cbb_cplb.ItemIndex);
      sSqlData := Format('Select IsNull(F_tiFJNJBZ,0) FJNJBZ from Set_ProductType where CHARINDEX(F_sTypeName,''%s'')=1 and F_iProductCategoryID=%d',[Trim(cbb_cplx.Text),iCplb]);
      iFJNJBZ := DM_DataBase.GetTableFirst(sSqlData);
      sTableName := iif(rb_bb_xsx.Checked,'BI_SellOrder','BI_CustomOrder');
      DM_DataBase.GetMaxID(sTableName,'F_iID',sID,1,1);
      iID := StrToNum(sID);
      sSqlData := 'Select * from %s where 1=2';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sTableName]);
      with ADO_Rec do
      begin
        Insert;
        FieldByName('F_iID').AsInteger := iID;
        FieldByName('F_tiLrbz').AsInteger := iif(cb_pp.Checked,1,3);
        FieldByName('F_tiDfbbz').AsInteger := iif(rb_bb_dfb.Checked,1,0);
        FieldByName('F_dJsrq').AsDateTime := dtp_lgrq.DateTime;
        FieldByName('F_sSbbbh').AsString := Trim(edt_sbbbh.Text);
        Post;
      end;
      ADO_Rec.Free;
      sTableName := iif(rb_bb_xsx.Checked,'BI_SellOrderDetails','BI_CustomOrderDetails');
      sSqlData := 'Select * from %s where 1=2';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sTableName]);
      iDetailsID := DM_DataBase.GetMaxID('select IsNull(Max(F_iID),0) from '+sTableName)+1 ;
      with ADO_Rec do
      begin
        Insert;
        FieldByName('F_iID').AsInteger := iDetailsID;
        //FieldByName('F_iProductType').AsInteger := StrToNum(edt_cpbh_2.Text);
        //if StrToNum(edt_cpbh_2.Text) = 13 then
        if Trim(cbb_cplb.Text) = '邮政贺卡' then
          FieldByName('F_iProductType').AsInteger := 13
        else
          FieldByName('F_iProductType').AsInteger := 0;
        FieldByName('F_sJg').AsString := Trim(cbb_kh.Text);
        FieldByName('F_nYl').AsFloat := StrToNum(edt_yl.Text)/10000;
        FieldByName('F_sYztmc').AsString := Trim(cbb_yztmc.Text);
        FieldByName('F_sCPBH').AsString := sCpbh;
        FieldByName('F_sQttsgyms').AsString := Trim(cbb_tsgy.Text);
        FieldByName('F_sCkjhrq').AsDateTime := dtp_jhrq.DateTime;
        FieldByName('F_tiJybz').AsInteger := iif(cb_jy.Checked,1,0);
        if (cb_jy.Checked) and (not rb_bb_xsx.Checked) then
        begin
          sSqlData := 'select Max(F_tiJyxh)+1 F_tiJyxh from BI_CustomOrderDetails where F_sCPBH like ''%s%%'' and F_tiCXBZ=0 and F_tiJybz=1';
          iJyxh := DM_DataBase.GetMaxID(Format(sSqlData,[StrLeft(sCpbh,17)]));
          FieldByName('F_tiJyxh').AsInteger := iJyxh
        end;

        FieldByName('F_tiXpl').AsInteger := iif(rb_xpl_yes.Checked,1,0);
        FieldByName('F_tiQy').AsInteger := iif(rb_qy_yes.Checked,1,0);
        FieldByName('F_iTgzt').AsInteger := 1;
        FieldByName('F_tiNJBS').AsInteger := iFJNJBZ;
        FieldByName('F_sCkjhrq').AsDateTime := dtp_jhrq.DateTime;
        FieldByName('F_dCzrq').AsDateTime := Now;
        FieldByName('F_iCzrID').AsInteger := LoginData.m_iUserID;
        if rb_bb_xsx.Checked then
        begin
          FieldByName('F_sCpmc').AsString := Trim(edt_khmc.Text);
          FieldByName('F_iSellID').AsInteger := iID;
        end else
        begin
          FieldByName('F_sKhmc').AsString := Trim(edt_khmc.Text);
          FieldByName('F_iCustomID').AsInteger := iID;
        end;
        Post;
      end;
      ADO_Rec.Free;
      sSqlData := 'Select * from DO_OrderApart where 1=2';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
      with ADO_Rec do
      begin
        for i := 0 to iApartCount -1 do
        begin
          if StrRight(sCpbh,4)='-999' then
          begin
            case iOrderType of
              0:
                begin
                  case iDFBBZ of
                    0:
                    begin
                      sFjCpbh := StrLeft(sCpbh,Length(sCpbh)-3)+StrRight('000'+IntToStr(i+1),3);
                      sNJCPBH := StrLeft(sCpbh,Length(sCpbh)-3)+StrRight('000'+IntToStr(i+1),3);
                    end;
                    1:
                    begin
                      case iFJNJBZ of
                        0:sFjCpbh := StrLeft(sCpbh,Length(sCpbh)-3)+'0'+StrRight('00'+IntToStr(i+1),2);
                        1:sFjCpbh := StrLeft(sCpbh,Length(sCpbh)-3)+'1'+StrRight('00'+IntToStr(i+1),2);
                      end;
                      sNJCPBH := StrLeft(sCpbh,Length(sCpbh)-3)+'2'+StrRight('00'+IntToStr(i+1),2);
                    end;
                  end;
                end;
              1:
              begin
                case iFJNJBZ of
                  0:sFJCPBH := StrLeft(sCpbh,Length(sCpbh)-3)+'0'+StrRight('00'+IntToStr(i+1),2);
                  1:sFJCPBH := StrLeft(sCpbh,Length(sCpbh)-3)+'1'+StrRight('00'+IntToStr(i+1),2);
                end;
                sNJCPBH := StrLeft(sCpbh,Length(sCpbh)-3)+'2'+StrRight('00'+IntToStr(i+1),2);
              end;
            end;
          end else
          begin
            sFJCPBH := sCpbh;
            case iOrderType of
              0:
                begin
                  case iDFBBZ of
                    0: sNJCPBH := sCpbh;
                    1: sNJCPBH := StrLeft(sCpbh,Length(sCpbh)-3)+'2'+StrRight(sCpbh,2);
                  end;
                end;
              1:sNJCPBH := StrLeft(sCpbh,Length(sCpbh)-3)+'2'+StrRight(sCpbh,2);
            end

          end;
          Insert;
          FieldByName('F_tiOrderType').AsInteger := iif(rb_bb_xsx.Checked,1,0);
          FieldByName('F_iOrderID').AsInteger := iDetailsID;
          FieldByName('F_sCPBH').AsString := sFJCPBH;
          FieldByName('F_nYl').AsFloat := (StrToNum(edt_yl.Text)/10000) / iApartCount;
          FieldByName('F_sYztmc').AsString := Trim(cbb_yztmc.Text);
          if Trim(cbb_yztmc.Text) = '无邮资图' then
            FieldByName('F_tiNJBZ').AsInteger := 1
          else begin
            FieldByName('F_tiNJBZ').AsInteger := 0;
          end;
          FieldByName('F_sTsgy').AsString := Trim(cbb_tsgy.Text);
          Post;
          //------自动生成内件--------------------------------------------
//          iCplb := FindProductCategoryID(cbb_cplb.ItemIndex);
//          sSqlData := Format('Select IsNull(F_tiFJNJBZ,0) FJNJBZ from Set_ProductType where CHARINDEX(F_sTypeName,''%s'')=1 and F_iProductCategoryID=%d',[Trim(cbb_cplx.Text),iCplb]);
//          iFJNJBZ := DM_DataBase.GetTableFirst(sSqlData);
          if iFJNJBZ = 1 then
          begin
            if Application.MessageBox('是否要生成内件?','提示',MB_YESNO+MB_ICONINFORMATION) = IDYES then
            begin
              Insert;
              FieldByName('F_tiOrderType').AsInteger := iif(rb_bb_xsx.Checked,1,0);
              FieldByName('F_iOrderID').AsInteger := iDetailsID;
              FieldByName('F_sCPBH').AsString := sNJCPBH;
              FieldByName('F_nYl').AsFloat := (StrToNum(edt_yl.Text)/10000) / iApartCount;
              FieldByName('F_sYztmc').AsString := '无邮资图';
              FieldByName('F_sTsgy').AsString := Trim(cbb_tsgy.Text);
              FieldByName('F_tiNJBZ').AsInteger := 1;
              Post;
            end;
          end;
          //----------------------------------------------------
        end;
      end;
      DM_DataBase.Con_YDPrint.CommitTrans;
      Application.MessageBox('添加成功','提示',MB_ICONINFORMATION);
      if StrRight(sCpbh,3)='999' then
      begin
        Frm_FJ := TFrm_FJ.Create(Self);
        Frm_FJ.ReadDataYL(iDetailsID,iOrderType);
        Frm_FJ.ShowModal;
        if Frm_FJ.vSucceed then
        Frm_FJ.Free;
      end;        
      vSucceed := True;
      btn_reset.Click
    except
      on E: Exception do
      begin
        DM_DataBase.Con_YDPrint.RollbackTrans;
        Application.MessageBox(PChar('错误:'+E.message),'提示',MB_ICONINFORMATION);
      end;
    end;
  finally
    ADO_Rec.Free;
  end;          

end;



end.

