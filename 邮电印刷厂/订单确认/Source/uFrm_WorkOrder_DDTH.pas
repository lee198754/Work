unit uFrm_WorkOrder_DDTH;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzRadChk, ButtonEdit, RzCmboBx, iComboBox, RzButton,
  RzPanel, ComCtrls, RzListVw, ExtCtrls, Grids, iGrid, ADODB, ImgList,
  Menus,iLabel;

type
  TFrm_ddth = class(TForm)
    pgc_ddth: TPageControl;
    ts_bth: TTabSheet;
    ts_thc: TTabSheet;
    Panel3: TPanel;
    RzGroupBox1: TRzGroupBox;
    btn_cx: TRzButton;
    cbb_ddlx: Ti_ComboBox;
    edt_cpbh: Ti_TxtFilter;
    cbb_cplb: Ti_ComboBox;
    cbb_cplx: Ti_ComboBox;
    cbb_xpl: Ti_ComboBox;
    cbb_qyzt: Ti_ComboBox;
    gb_dd: TRzGroupBox;
    lv_jhxd: TRzListView;
    pan_data: TPanel;
    lab_up: TLabel;
    lab_down: TLabel;
    lab_first: TLabel;
    lab_last: TLabel;
    lab_zys: TLabel;
    lab_ts50: TLabel;
    Label2: TLabel;
    lab_ts100: TLabel;
    lab_ts200: TLabel;
    lab_ts500: TLabel;
    Label6: TLabel;
    edt_ys: TEdit;
    btn_go: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    stg_ddxx: Ti_StgEdit;
    btn_next1: TButton;
    btn_ok: TButton;
    Label4: TLabel;
    cb_syyl: TRzCheckBox;
    edt_syylq: TEdit;
    edt_syylz: TEdit;
    ImageList1: TImageList;
    pm_jhxd: TPopupMenu;
    menu_ddmx: TMenuItem;
    menu_ddmxPic: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure lv_ddCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure btn_next1Click(Sender: TObject);
    procedure btn_cxClick(Sender: TObject);
    procedure btn_goClick(Sender: TObject);
    procedure lab_ts50Click(Sender: TObject);
    procedure lab_firstClick(Sender: TObject);
    procedure lab_upClick(Sender: TObject);
    procedure lab_downClick(Sender: TObject);
    procedure lab_lastClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure lv_jhxdMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure menu_ddmxClick(Sender: TObject);
    procedure cbb_cplbChange(Sender: TObject);
    procedure stg_ddxxDblClick(Sender: TObject);
  private
    { Private declarations }
    vCount: Integer;
    vYs: Integer;
    vMYTS: Integer;
    vSqlData: string;
    procedure p_LoadDDXX;
    procedure ReadDataJHXD(ADO_Data: TADOQuery;Bz: integer);
  public
    { Public declarations }
  end;

var
  Frm_ddth: TFrm_ddth;

implementation

uses
  uPub_Func,uPub_Text,uPub_Type, uDM_DataBase, PubStr, uDDMX_DZX,
  uDDMX_XSX;

{$R *.dfm}

const
  c_jhxd_jg         = 0;
  c_jhxd_CPBH       = 1;
  c_jhxd_cplx       = 2;
  c_jhxd_yztmc      = 3;
  c_jhxd_lgrq       = 4;
  c_jhxd_khmc       = 5;
  c_jhxd_zyl        = 6;
  c_jhxd_tsgy       = 7;
  c_jhxd_fjgy       = 8;
  c_jhxd_jybz       = 9;
  c_jhxd_cybz       = 10;
  c_jhxd_syyl       = 11;
  c_jhxd_sfqy       = 12;
  c_jhxd_xpl        = 13;
  c_jhxd_tgzt       = 14;
  c_jhxd_OrderID    = 15;
  c_jhxd_OrderType  = 16;
  c_jhxd_ApartID    = 17;

  c_DDXX_KHMC     = 0;
  c_DDXX_CPBH     = 1;
  c_DDXX_YZTMC    = 2;
  c_DDXX_SYYL     = 3;
  c_DDXX_BCYL     = 4;
  c_DDXX_BZ       = 5;
  c_DDXX_ApartID  = 6;

procedure TFrm_ddth.FormShow(Sender: TObject);
begin
  cbb_cplb.Clear;
  cbb_cplb.Items.Add('--全部--');
  CbbAdd(cbb_cplb,pkProductCategory);
  cbb_cplb.ItemIndex := c_Default_CPLB;
  cbb_cplx.Clear;
  cbb_cplx.Items.Add('--全部--');
  CbbAdd(cbb_cplx,pkProductType,FindProductCategoryID(cbb_cplb.ItemIndex));
  if cbb_cplx.ItemIndex = -1 then
    cbb_cplx.ItemIndex := 0;

  if cbb_ddlx.ItemIndex = -1 then
    cbb_ddlx.ItemIndex := 0;
  //lv_jhxd.Columns[0].Width := 0;
  p_LoadDDXX;
end;

procedure TFrm_ddth.lv_ddCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if (Item.Index mod 2) = 0 then
    Sender.Canvas.Brush.Color := $00F0FFF0//clWhite
  else
    Sender.Canvas.Brush.Color := $00F2F2F2;//$00EBEBEB;
  LVDrawItem(lv_jhxd, Item, State, DefaultDraw);

end;

procedure TFrm_ddth.btn_next1Click(Sender: TObject);
begin
  pgc_ddth.ActivePageIndex :=1;
  ts_thc.Enabled := True
end;

procedure TFrm_ddth.p_LoadDDXX;
var
  i,n: Integer;
begin
  stg_ddxx.Clear();
  stg_ddxx.ColWidths[c_DDXX_ApartID] := 0;
  n := 0;
  for i := 0 to Length(OrderData) - 1 do
  begin
    if  Trim(stg_ddxx.Cells[c_DDXX_ApartID,stg_ddxx.RowCount-1]) <> '' then
      stg_ddxx.RowCount := stg_ddxx.RowCount +1;
    Inc(n);
    stg_ddxx.Cells[c_DDXX_KHMC,n] := OrderData[i].m_sKhmc;
    stg_ddxx.Cells[c_DDXX_CPBH,n] := OrderData[i].m_sCPBH;
    stg_ddxx.Cells[c_DDXX_YZTMC,n] := OrderData[i].m_sYztmc;
    stg_ddxx.Cells[c_DDXX_SYYL,n] := FloatToStr(OrderData[i].m_iSyyl);
    stg_ddxx.Cells[c_DDXX_BCYL,n] := IntToStr(OrderData[i].m_iBCYL);
    stg_ddxx.Cells[c_DDXX_BZ,n] := OrderData[i].m_sBZ;
    stg_ddxx.Cells[c_DDXX_ApartID,n] := IntToStr(OrderData[i].m_iApartID);
  end;

end;

procedure TFrm_ddth.btn_cxClick(Sender: TObject);
var
  iCplb, iCplx, iDdlx, iXpl,iQyzt: Integer;
  iSYYLQ,iSYYLZ,iYS,iTs: integer;
  sCpbh, sNf: string;
  ADO_Rec: TADOQuery;
begin
//  DB_jhdzs.DataSource := DM_DataBase.ds_show;
  Screen.Cursor := crHourGlass;
  btn_cx.Caption := '查询中...';
  vCount := 0;
//  lv_jhxd.Items.BeginUpdate;
  //lv_jhxd.Clear;
  sCpbh := edt_cpbh.Text;
  iCplb := FindProductCategoryCode(cbb_cplb.ItemIndex);
  iCplx := FindProductTypeID(cbb_cplx.ItemIndex,iCplb);
  sNf :='';
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
  else
    iXpl := -1;
  end;
  case cbb_qyzt.ItemIndex of
    0: iQyzt := -1;
    1: iQyzt := 0;
    2: iQyzt := 1;
  else
    iQyzt := -1;
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

  btn_cx.Caption := '查询';
  Screen.Cursor := crDefault;
end;

procedure TFrm_ddth.ReadDataJHXD(ADO_Data: TADOQuery; Bz: integer);
var
  sQy, sJybz, sTgzt, sXpl, sCPBH: string;
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
        btn_cx.Caption := '查询中'+StrLeft(StrRep('.',(i div 100) Mod 4)+'   ',3);
      lv_jhxd.Items.Add.Caption := '';
      lab_zys.Tag := iCount div vMYTS;
      if iCount mod vMYTS > 0 then
        lab_zys.Tag := lab_zys.Tag +1;
      lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);
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
          0: sJybz:= '无';
          1: sJybz:= '加印';
        end;
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(sJybz);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('CYBZ').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('SYYL').AsString);
        case FieldByName('F_tiQy').AsInteger of
          0: sQy:= '不签样';
          1: sQy:= '签样';
        end;
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(sQy);
        case FieldByName('F_iTgzt').AsInteger of
          0: sTgzt := '图稿未收到';
          1: sTgzt := '图稿已收到';
          2: sTgzt := '图稿未合格';
          3: sTgzt := '图稿已合格';
          4: sTgzt := '已打样';
          5: sTgzt := '已签样';
          //6: sTgzt := '图稿审核中';
        else
          sTgzt := FieldByName('F_iTgzt').AsString
        end;
        case FieldByName('F_tiXpl').AsInteger of
          0: sXpl := '否';
          1: sXpl := '小批量';
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
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('CPBH').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('CPLX').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('F_sYztmc').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('LGRQ').AsString);
        //lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('F_sCpmc').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('F_sKhmc').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('ZYL').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('F_sQttsgyms').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('F_sFJGY').AsString);
        case FieldByName('F_tiJybz').AsInteger of
          0: sJybz:= '无';
          1: sJybz:= '加印';
        end;
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(sJybz);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('CYBZ').AsString);
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(FieldByName('SYYL').AsString);
        case FieldByName('F_tiQy').AsInteger of
          0: sQy:= '不签样';
          1: sQy:= '签样';
        end;
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add(sQy);
        case FieldByName('F_iTgzt').AsInteger of
          0: sTgzt := '图稿未收到';
          1: sTgzt := '图稿已收到';
          2: sTgzt := '图稿未合格';
          3: sTgzt := '图稿已合格';
          4: sTgzt := '已打样';
          5: sTgzt := '已签样';
          //6: sTgzt := '图稿审核中';
        else
          sTgzt := FieldByName('F_iTgzt').AsString
        end;
        lv_jhxd.Items.Item[lv_jhxd.Items.Count -1].SubItems.Add('否');
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
  gb_dd.Caption := '订单  总数:'+IntToStr(iCount)+'条';
end;

procedure TFrm_ddth.btn_goClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  iYs: Integer;
begin
  Screen.Cursor := crHourGlass;
  iYs := StrToNum(edt_ys.Text);
  ADO_Rec := DM_DataBase.OpenQuery(vSqlData,[iYs,vMYTS]);
  ReadDataJHXD(ADO_Rec,-1);
  lab_zys.Caption := '页次：'+IntToStr(iYs)+'/'+ IntToStr(lab_zys.Tag);
  vYs := iYs;
  Screen.Cursor := crDefault;
end;

procedure TFrm_ddth.lab_ts50Click(Sender: TObject);
var
  ADO_Rec: TADOQuery;
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
  lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);

end;

procedure TFrm_ddth.lab_firstClick(Sender: TObject);
begin
  if vYs = 1 then Exit;
  edt_ys.Text := '1';
  btn_go.Click;

end;

procedure TFrm_ddth.lab_upClick(Sender: TObject);
begin
  if vYs > 1 then
  begin
    edt_ys.Text := IntToStr(vYs -1);
    btn_go.Click;
  end;

end;

procedure TFrm_ddth.lab_downClick(Sender: TObject);
begin
  if vYs < lab_zys.Tag then
  begin
    edt_ys.Text := IntToStr(vYs +1);
    btn_go.Click;
  end;

end;

procedure TFrm_ddth.lab_lastClick(Sender: TObject);
begin
  if vYs = lab_zys.Tag then Exit;
  edt_ys.Text := IntToStr(lab_zys.Tag);
  btn_go.Click;

end;

procedure TFrm_ddth.btn_okClick(Sender: TObject);
var
  i, n, iOrderID, iTemp, iOrderType: Integer;
  str, sCPBH, sKhmc, sSl, sYl, sCPLX, sYZTMC, sXPL, sApartID: string;
begin
  if lv_jhxd.ItemIndex > -1 then
  begin
    n := stg_ddxx.Row-1;
    i := lv_jhxd.ItemIndex;
    sCpbh := lv_jhxd.Items[i].SubItems[c_jhxd_CPBH];
    if Copy(sCpbh,1,1) = '*' then
      sCpbh := Copy(sCpbh,2,Length(sCpbh));
    sKhmc := lv_jhxd.Items[i].SubItems[c_jhxd_khmc];
    sSl := lv_jhxd.Items[i].SubItems[c_jhxd_syyl];
    sYl := lv_jhxd.Items[i].SubItems[c_jhxd_zyl];
    sCPLX := lv_jhxd.Items[i].SubItems[c_jhxd_cplx];
    sYZTMC := lv_jhxd.Items[i].SubItems[c_jhxd_yztmc];
    sXPL := lv_jhxd.Items[i].SubItems[c_jhxd_xpl];
    iOrderID := StrToNum(lv_jhxd.Items[i].SubItems[c_jhxd_OrderID]);
    if iTemp = 0 then iTemp := iOrderID;
    if iTemp <> iOrderID then  iTemp := -1;
    iOrderType := StrToInt(lv_jhxd.Items[i].SubItems[c_jhxd_OrderType]);
    sApartID := lv_jhxd.Items[i].SubItems[c_jhxd_ApartID];
    if pos('(内件)',sCpbh) >0 then
      sCpbh := StrLeft(sCpbh,Length(sCpbh)-6);
    str := '是否将'+#13#10
      +'  客户名称: '+OrderData[n].m_sKhmc+#13#10+'  产品编号: '+OrderData[n].m_sCPBH+#13#10
      +'  邮资图: '+OrderData[n].m_sYztmc+#13#10+'  剩余印量: '+FloatToStr(OrderData[n].m_iSyyl)+#13#10
      +'替换为'+#13#10
      +'  客户名称: '+sKhmc+#13#10+'  产品编号: '+sCpbh+#13#10
      +'  邮资图: '+sYZTMC+#13#10+'  剩余印量: '+sSl+'  ?'+#13#10;
    if p_MessageBoxDlg(str,'提示',MB_ICONINFORMATION+MB_YESNO)= IDNO then
      Exit;
    for i := 0 to Length(OrderData) -1 do
    begin
      if OrderData[n].m_iApartID = StrToNum(sApartID) then
      begin
        p_MessageBoxDlg('一个工单里同个订单只能出现一次!');
        Break;
      end;
    end;
    if OrderData[n].m_iSyyl > StrToInt(sSl) then
    begin
      p_MessageBoxDlg(sCpbh+'剩余印量 '+sSl+' 小于被替换的订单剩余印量 '+FloatToStr(OrderData[n].m_iSyyl)+' !','提示');
      Exit;
    end;
    if OrderData[n].m_iSyyl < StrToInt(sSl) then
    begin
      if p_MessageBoxDlg(sCpbh+'剩余印量 '+sSl+' 大于被替换的订单剩余印量 '+FloatToStr(OrderData[n].m_iSyyl)+' ,是否进行修改?','提示',MB_ICONINFORMATION+MB_YESNO)= IDNO then
        Exit;
    end;
    for i := 0 to Length(aRJHD) -1 do
    begin
      if aRJHD[i].m_iApartID = OrderData[n].m_iApartID then
      begin
        aRJHD[i].m_iApartID := StrToInt(sApartID);;
        Break;
      end;
    end;
    OrderData[n].m_sCPBH := sCpbh;
    OrderData[n].m_sKhmc := sKhmc;
    OrderData[n].m_sCplx := sCPLX;
    OrderData[n].m_sYztmc := sYZTMC;
    OrderData[n].m_iXPL := iif(sXPL='小批量',1,0);
    OrderData[n].m_iSyyl := StrToInt(sSl);
    OrderData[n].m_iYl := StrToInt(sYl);
    OrderData[n].m_iApartID := StrToInt(sApartID);
    OrderData[n].m_iType := iOrderType;
    OrderData[n].m_iOrderID :=  iOrderID;
    OrderData[n].m_iGroupID :=  -1;
    ModalResult :=  mrOk;
  end;
end;

procedure TFrm_ddth.lv_jhxdMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i: integer;
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

  if lv_jhxd.Selected.Checked then
  begin
    for i := 0 to lv_jhxd.Items.Count -1 do
    begin
      if i <> lv_jhxd.Selected.Index then
        lv_jhxd.Items.Item[i].Checked := False;
    end;
  end;

end;

procedure TFrm_ddth.menu_ddmxClick(Sender: TObject);
var
  SelItem: TListItem;
  iType,iOrderID: integer;
begin
  SelItem := lv_jhxd.Selected;
  if not Assigned(SelItem) then Exit;
  iOrderID := StrToNum(SelItem.SubItems.Strings[c_jhxd_OrderID]);

  iType := StrToNum(SelItem.SubItems.Strings[c_jhxd_OrderType]);

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

procedure TFrm_ddth.cbb_cplbChange(Sender: TObject);
var
  iProductCategoryID: Integer;
begin
  iProductCategoryID := FindProductCategoryID(cbb_cplb.ItemIndex);
  cbb_cplx.Clear;
  cbb_cplx.Items.Add('--全部--');
  CbbAdd(cbb_cplx,pkProductType,iProductCategoryID);
  cbb_cplx.ItemIndex := 0;

end;

procedure TFrm_ddth.stg_ddxxDblClick(Sender: TObject);
begin
  btn_next1.Click;
end;

end.



