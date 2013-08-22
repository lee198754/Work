unit uFraddcx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, RzListVw, StdCtrls, ButtonEdit, RzCmboBx, iComboBox,
  RzButton, ExtCtrls, RzPanel, uDM_DataBase, ADODB, DB,
  Menus,iLabel, ImgList, RzRadChk, RzDTP,
  GridsEh, DBGridEh, EhLibADO,EhLibMTE, RzEdit, DBGridEhGrouping;

type
  TFra_ddcx = class(TFrame)
    gb_cx: TRzGroupBox;
    cbb_bb: Ti_ComboBox;
    gb_dd: TRzGroupBox;
    RzPanel1: TRzPanel;
    edt_cpbh: Ti_TxtFilter;
    pm_jhxd: TPopupMenu;
    menu_ddmx: TMenuItem;
    cbb_cplb: Ti_ComboBox;
    cbb_cplx: Ti_ComboBox;
    cbb_nf: Ti_ComboBox;
    ImageList1: TImageList;
    menu_cxfj: TMenuItem;
    Label3: TLabel;
    dtp_jsq: TRzDateTimePicker;
    dtp_jsz: TRzDateTimePicker;
    cb_jsrq: TRzCheckBox;
    menu_ddmxPic: TMenuItem;
    cbb_xpl: Ti_ComboBox;
    dbg_jhxd: TDBGridEh;
    btn_cx: TRzButton;
    tmr_cx: TTimer;
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
    edt_gdh: Ti_TxtFilter;
    cbb_scjd: Ti_ComboBox;
    edt_jgmc: Ti_TxtFilter;
    edt_kfmc: Ti_TxtFilter;
    btn_export: TRzButton;
    SavePath: TSaveDialog;
    cb_ljhrqfw: TRzCheckBox;
    edt_ljhrqq: TEdit;
    edt_ljhrqz: TEdit;
    Label1: TLabel;
    menu_fhmx: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    cbb_tgzt: Ti_ComboBox;
    menu_ztmx: TMenuItem;
    lab_tsQB: TLabel;
    lab_ts15: TLabel;
    lab_ts20: TLabel;
    cbb_txlx: Ti_ComboBox;
    edt_ysdh: Ti_TxtFilter;
    cb_History: TCheckBox;
    procedure lv_jhxdMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure menu_ddmxClick(Sender: TObject);
    procedure cbb_cplbChange(Sender: TObject);
    procedure lv_jhxdCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lv_jhxdColumnClick(Sender: TObject; Column: TListColumn);
    procedure menu_cxfjClick(Sender: TObject);
    procedure cb_jsrqClick(Sender: TObject);
    procedure cbb_bbChange(Sender: TObject);
    procedure btn_cxClick(Sender: TObject);
    procedure dbg_jhxdTitleClick(Column: TColumnEh);
    procedure tmr_cxTimer(Sender: TObject);
    procedure lab_ts50Click(Sender: TObject);
    procedure btn_goClick(Sender: TObject);
    procedure lab_firstClick(Sender: TObject);
    procedure lab_upClick(Sender: TObject);
    procedure lab_downClick(Sender: TObject);
    procedure lab_lastClick(Sender: TObject);
    procedure dbg_jhxdCellClick(Column: TColumnEh);
    procedure pm_jhxdPopup(Sender: TObject);
    procedure btn_exportClick(Sender: TObject);
    procedure cb_ljhrqfwClick(Sender: TObject);
    procedure menu_fhmxClick(Sender: TObject);
    procedure menu_ztmxClick(Sender: TObject);
  private
    { Private declarations }
    vSort: Integer;
    vOredrType: Integer;
    vMYTS: Integer;     //当前每页条数
    vYs: integer;       //当前页数
    vSqlData: string;
    procedure WaitSelect(btn:TRzButton);
    procedure GDHClick;
    procedure GDHClick_Old;  //12.5.16
    function p_LoadWorkOrderData: Boolean;    //读取工单数据到数组中(不用)
    function f_MakeAllow: Boolean;   //操作允许
  public
    { Public declarations }
//    ProductCategory: array of  TProductCategory;
    procedure Init;
    procedure FraShow;
  end;

implementation

uses
  PubStr,uFrmFJ,uDDMX_DZX,uDDMX_XSX,uPrint,uFrm_GDH_XZ,
  uWorkOrder, uPub_Type, uPub_Func, uPub_Text, DBGridEhImpExp,uFrm_FHMX,
  uFrm_ZTMX ;

{$R *.dfm}

{ TFra_ddcx }


procedure TFra_ddcx.lv_jhxdMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Point: TPoint;
  iType: integer;
begin
  if Button = mbRight then
  begin
    if Assigned(TListView(Sender).Selected) then
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
  end;
end;

procedure TFra_ddcx.menu_ddmxClick(Sender: TObject);
var
  SelItem: TListItem;
  iType,iOrderID: integer;
begin
  if not DM_DataBase.ADO_DataRec.Active then Exit;
  if DM_DataBase.mte_DataRec.FieldByName('OrderID').IsNull then
  begin
    Application.MessageBox('请选择订单!','提示',MB_ICONINFORMATION);
  end;
  iOrderID := DM_DataBase.mte_DataRec.FieldByName('OrderID').AsInteger;

  iType := DM_DataBase.mte_DataRec.FieldByName('OrderType').AsInteger;
  
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

procedure TFra_ddcx.cbb_cplbChange(Sender: TObject);
var
  iProductCategoryID: Integer;
begin
  iProductCategoryID := FindProductCategoryID(cbb_cplb.ItemIndex);
  cbb_cplx.Clear;
  cbb_cplx.Items.Add('--全部--');
  CbbAdd(cbb_cplx,pkProductType,iProductCategoryID);
  cbb_cplx.ItemIndex := 0;
end;

procedure TFra_ddcx.lv_jhxdCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  i: integer;
begin
{  i:= (Sender as TrzListView).Items.IndexOf(Item);
  if odd(i) then sender.Canvas.Brush.Color:= clWhite
  else sender.Canvas.Brush.Color:= $02F0EED7;
  Sender.Canvas.FillRect(Item.DisplayRect(drIcon)); }
  if (Item.Index mod 2) = 0 then
    Sender.Canvas.Brush.Color := $00F0FFF0
  else
    Sender.Canvas.Brush.Color := $00F2F2F2;
  LVDrawItem(TRzListView(Sender), Item, State, DefaultDraw);

end;

procedure TFra_ddcx.lv_jhxdColumnClick(Sender: TObject;
  Column: TListColumn);
begin
//  vSort := (vSort+1) mod 2;
  TRzListView(Sender).CustomSort(@RzCustomSortProc,Column.Index)
end;

procedure TFra_ddcx.menu_cxfjClick(Sender: TObject);
var
  SelItem: TListItem;
  i,iOrderID,iType: integer;
  SqlData,sTableName: string;
begin
//  if TMenuItem(Sender).Name = 'menu_cxfj' then
//    SelItem := lv_jhxd.Selected;
//  if not Assigned(SelItem) then Exit;
//  iOrderID := StrToIntDef(SelItem.SubItems.Strings[SelItem.SubItems.Count-1],0);
//  iType := StrToIntDef(SelItem.SubItems.Strings[SelItem.SubItems.Count-2],0);
  iOrderID := DM_DataBase.mte_DataRec.FieldByName('OrderID').AsInteger;
  iType := DM_DataBase.mte_DataRec.FieldByName('OrderType').AsInteger;
  Frm_FJ := TFrm_FJ.Create(Self);
  Frm_FJ.ReadDataYL(iOrderID,iType);
  Frm_FJ.ShowModal;
  if Frm_FJ.vSucceed then
    btn_cx.Click;
  Frm_FJ.Free;
end;

procedure TFra_ddcx.cb_jsrqClick(Sender: TObject);
begin
  dtp_jsq.Enabled := cb_jsrq.Checked;
  dtp_jsz.Enabled := cb_jsrq.Checked;
  //dtp_jsq.DateTime := Now;
  //dtp_jsz.DateTime := Now;
end;

{ TLoadData }

procedure TFra_ddcx.cbb_bbChange(Sender: TObject);
begin
  case cbb_bb.ItemIndex of
    0:
      begin
        cbb_xpl.Enabled := True;
      end;
    1:
      begin
        cbb_xpl.Enabled := True;
      end;
    2:
      begin
        cbb_xpl.Enabled := False;
      end;
  end;

end;

procedure TFra_ddcx.btn_cxClick(Sender: TObject);
var
  iCplb, iCplx, iDdlx, iXpl, iSczt, iTgzt, iLJHRQ, iLJHRQQ,iLJHRQZ,iTXLX: Integer;
  iYS,iMYTS: Integer;
  sNf, sJsq, sJsz, sCpbh, sGdh,sJg,sKfmc,sYSDH: string;
  rCplx: TProductType;
  ADO_Rec: TADOQuery;
  sSqlData: string;
  time, n: Integer;
begin
//  tmr_cx.Enabled := True;
  Screen.Cursor := crHourGlass;
  btn_cx.Caption := '查询中...';
  time:= GetTickCount;
  sCpbh := edt_cpbh.Text;
  iCplb := FindProductCategoryCode(cbb_cplb.ItemIndex);
  iCplx := FindProductTypeID(cbb_cplx.ItemIndex,iCplb);
  case cbb_scjd.ItemIndex of
    0: iSczt := -2;
    1: iSczt := -1;
    2: iSczt := 0;
    3: iSczt := 1;
    4: iSczt := 2;
    5: iSczt := 3;
    //6: iSczt := 4;
    6: iSczt := 5;
    7: iSczt := 6;
    8: iSczt := 7;
    9: iSczt := 8;
  end;
  case cbb_tgzt.ItemIndex of
    1: iTgzt := 0;
    2: iTgzt := 1;
    3: iTgzt := 2;
    4: iTgzt := 3;
    5: iTgzt := 4;
    6: iTgzt := 5;
    7: iTgzt := 6;
    8: iTgzt := 7;
  else
    iTgzt := -1;
  end;
  sGdh :=  Trim(edt_gdh.Text);
  sNf := cbb_nf.Text;
  sJg := edt_jgmc.Text;
  sKfmc := edt_kfmc.Text;
  case cbb_bb.ItemIndex of
    0:   iDdlx := -1;
    1:   iDdlx := 0;
    2:   iDdlx := 1;
  else
    iDdlx := -1;
  end;
  case cbb_txlx.ItemIndex of
    0:   iTXLX := -1;
    1:   iTXLX := 0;
  else
    iTXLX := -1;
  end;
  if cb_ljhrqfw.Checked then
  begin
    iLJHRQ := 1;
    iLJHRQQ := StrToNum(edt_ljhrqq.Text);
    iLJHRQZ := StrToNum(edt_ljhrqz.Text);
    edt_ljhrqq.Text := IntToStr(iLJHRQQ);
    edt_ljhrqz.Text := IntToStr(iLJHRQZ);
  end else
  begin
    iLJHRQ := 0;
    iLJHRQQ := -1;
    iLJHRQZ := -1;
  end;
  sYSDH := edt_ysdh.Text;

  iYS := 1;
  vYs := iYS;
  edt_ys.Text := IntToStr(iYs);
  if vMYTS = 0 then
  begin
    vMYTS := 20;
    lab_ts20.Font.Color :=  clBlack;
    lab_ts20.Font.Size := 10;
    lab_ts20.Font.Style := [fsBold];
    lab_ts20.Cursor := crDefault;
  end;
  iMYTS := vMYTS;
  case cbb_xpl.ItemIndex of
    0: iXpl := -1;
    1: iXpl := 0;
    2: iXpl := 1;
  end;
  if cb_jsrq.Checked then
  begin
    sJsq := FormatDateTime('yyyy.MM.dd 00:00:00',dtp_jsq.DateTime);
    sJsz := FormatDateTime('yyyy.MM.dd 23:59:59',dtp_jsz.DateTime);
  end;
  vOredrType := cbb_bb.ItemIndex;
  sSqlData := Format('Exec p_ddcx ''%s'',%d,%d,%d,''%s'',''%s'',''%s'',''%s'',%d,%d,''%s'',''%s'',%d,%d,%d,%d,%d,%d,''%s'',%d',
    [sCpbh,iCplb,iCplx,iSczt,sGdh,sJg,sKfmc,sNf,iDdlx,iXpl,sJsq,sJsz,iYS,iMYTS,iLJHRQ,iLJHRQQ,iLJHRQZ,iTgzt,sYSDH,iTXLX]);
  try
    if not cb_History.checked then
    begin
      if DM_DataBase.ADO_DataRec.Connection <> DM_DataBase.Con_YDPrint then
      begin
        DM_DataBase.Con_YDPrint.Connected := True;
        DM_DataBase.ADO_DataRec.Connection := DM_DataBase.Con_YDPrint;
      end;
    end else
    begin
      if DM_DataBase.ADO_DataRec.Connection <> DM_DataBase.Con_History then
      begin
        DM_DataBase.Con_History.Connected := True;
        DM_DataBase.ADO_DataRec.Connection := DM_DataBase.Con_History;
      end;
    end;   
    DM_DataBase.ADO_DataRec.Close;
    DM_DataBase.ADO_DataRec.SQL.Text :=  sSqlData;
    DM_DataBase.ADO_DataRec.Open;
    DM_DataBase.mte_DataRec.Close;
    DM_DataBase.mte_DataRec.Open;
  //  vSqlData := Format('Exec p_ddcx ''%s'',%d,%d,''%s'',%d,%d,''%s'',''%s''',[sCpbh,iCplb,iCplx,sNf,iDdlx,iXpl,sJsq,sJsz])+',%d,%d';
    vSqlData := Format('Exec p_ddcx ''%s'',%d,%d,%d,''%s'',''%s'',''%s'',''%s'',%d,%d,''%s'',''%s'',%s,%s,%d,%d,%d,%d,''%s'',%d ',[sCpbh,iCplb,iCplx,iSczt,sGdh,sJg,sKfmc,sNf,iDdlx,iXpl,sJsq,sJsz,'%d','%d',iLJHRQ,iLJHRQQ,iLJHRQZ,iTgzt,sYSDH,iTXLX]);
    n := 0;
    if DM_DataBase.ADO_DataRec.RecordCount > 0 then
    begin
      n := DM_DataBase.mte_DataRec.FieldByName('Count').AsInteger;
  //  n := DM_DataBase.ADO_DataRec.RecordCount;
    end;
    gb_dd.Caption := '订单  总数:'+IntToStr(n)+'条';
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);
  except
    on E: Exception do
    begin
      p_MessageBoxDlg('错误：'+E.message);
    end;

  end;

  Screen.Cursor := crDefault;
  btn_cx.Caption := '查询';
//ShowMessage(IntToStr(GetTickCount-time));
//  tmr_cx.Enabled := False;
end;

procedure TFra_ddcx.dbg_jhxdTitleClick(Column: TColumnEh);
begin
//  if not Assigned(dbg_jhxd_dzx.DataSource.DataSet) then
{  if DM_DataBase.ADO_DataRec.Active then
  begin
    if Column.Title.SortMarker = smDownEh then
      DM_DataBase.ADO_DataRec.Sort := Column.FieldName+' DESC';
  //    DM_DataBase.mte_DataRec.SortOrder := Column.FieldName+' DESC';
    if Column.Title.SortMarker = smUpEh then
      DM_DataBase.ADO_DataRec.Sort := Column.FieldName+' ASC';
  //    DM_DataBase.mte_DataRec.SortOrder := Column.FieldName+' ASC';
  end;   }
end;

procedure TFra_ddcx.WaitSelect(btn: TRzButton);
begin
  btn.Caption := '查询';
end;

procedure TFra_ddcx.tmr_cxTimer(Sender: TObject);
var
  str: string;
begin
  tmr_cx.Tag := tmr_cx.Tag +1;
  tmr_cx.Tag := tmr_cx.Tag mod 4;
  str := StrRep('.',tmr_cx.Tag);
  btn_cx.Caption := '查询'+str;
end;

procedure TFra_ddcx.lab_ts50Click(Sender: TObject);
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
  DM_DataBase.ADO_DataRec.Close;
  sSqlData := Format(vSqlData,[1,vMYTS]);
  DM_DataBase.ADO_DataRec.SQL.Text :=  sSqlData;
  DM_DataBase.ADO_DataRec.Open;
  DM_DataBase.mte_DataRec.Close;
  DM_DataBase.mte_DataRec.Open;
  LabFontClear(lab_ts15);
  LabFontClear(lab_ts20);
  //LabFontClear(lab_ts50);
  //LabFontClear(lab_ts100);
  LabFontClear(lab_ts200);
  LabFontClear(lab_ts500);
  LabFontClear(lab_tsQB);
  TLabel(Sender).Font.Color :=  clBlack;
  TLabel(Sender).Font.Size := 10;
  TLabel(Sender).Font.Style := [fsBold];
  TLabel(Sender).Cursor := crDefault;
  vYs := 1;
  edt_ys.Text := '1';
  if DM_DataBase.ADO_DataRec.RecordCount > 0 then
  begin
    n := DM_DataBase.mte_DataRec.FieldByName('Count').AsInteger;
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    lab_zys.Caption := '页次：1/'+ IntToStr(lab_zys.Tag);
  end;
end;

procedure TFra_ddcx.btn_goClick(Sender: TObject);
var
  iYs,n: Integer;
  sSqlData: string;
begin
  Screen.Cursor := crHourGlass;
  iYs := StrToNum(edt_ys.Text);
  DM_DataBase.ADO_DataRec.Close;
  sSqlData := Format(vSqlData,[iYs,vMYTS]);
  DM_DataBase.ADO_DataRec.SQL.Text :=  sSqlData;
  DM_DataBase.ADO_DataRec.Open;
  DM_DataBase.mte_DataRec.Close;
  DM_DataBase.mte_DataRec.Open;
  if DM_DataBase.ADO_DataRec.RecordCount > 0 then
  begin
    n := DM_DataBase.ADO_DataRec.FieldByName('Count').AsInteger;
    lab_zys.Tag := n div vMYTS;
    if n mod vMYTS > 0 then
      lab_zys.Tag := lab_zys.Tag +1;
    vYs := iYs;
    lab_zys.Caption := '页次：'+IntToStr(iYs)+'/'+ IntToStr(lab_zys.Tag);
  end;
  Screen.Cursor := crDefault;
end;

procedure TFra_ddcx.lab_firstClick(Sender: TObject);
begin
  if vYs = 1 then Exit;
  edt_ys.Text := '1';
  btn_go.Click;
end;

procedure TFra_ddcx.lab_upClick(Sender: TObject);
begin
  if vYs > 1 then
  begin
    edt_ys.Text := IntToStr(vYs -1);
    btn_go.Click;
  end;
end;

procedure TFra_ddcx.lab_downClick(Sender: TObject);
begin
  if vYs < lab_zys.Tag then
  begin
    edt_ys.Text := IntToStr(vYs +1);
    btn_go.Click;
  end;
end;

procedure TFra_ddcx.lab_lastClick(Sender: TObject);
begin
  if vYs = lab_zys.Tag then Exit;
  edt_ys.Text := IntToStr(lab_zys.Tag);
  btn_go.Click;

end;


procedure TFra_ddcx.dbg_jhxdCellClick(Column: TColumnEh);
begin
  if Column.FieldName = 'GDH' then
  begin
    GDHClick;
    {Frm_WorkOrder := TFrm_WorkOrder.Create(Self);
    if p_LoadWorkOrderData then
      Frm_WorkOrder.ShowModal;
    Frm_WorkOrder.Free;
    Exit;         }
  end;
end;

procedure TFra_ddcx.GDHClick_Old;
var
  ADO_Rec: TADOQuery;
  i, n, iOrderType: Integer;
  sHint, sID, sCXBZ, sSczt: string;
  comp: TComponent;
  iBsts: Integer;
  khmc,cpbh,bz,dw,sl,zh,ApartID,sGDH,sSqlData: string;
begin

  if not DM_DataBase.ADO_DataRec.Active then Exit;
  sGDH := Trim(DM_DataBase.mte_DataRec.FieldByName('GDH').AsString);
  if sGDH = '' then Exit;
  try
    ADO_Rec := TADOQuery.Create(Self);
    if Pos(',',sGDH) > 0 then
    begin
      Frm_GDH_XZ := TFrm_GDH_XZ.Create(Self);
      Frm_GDH_XZ.rg_gdh.Items.Clear;
      for i := 0 to PosNum(sGDH,',') do
      begin
        Frm_GDH_XZ.rg_gdh.Items.Add(PosCopy(sGDH,',',i+1));
      end;
      Frm_GDH_XZ.rg_gdh.ItemIndex := 0;
      if Frm_GDH_XZ.ShowModal <> mrok then
      begin
        Frm_GDH_XZ.Free;
        Exit;
      end else
      begin
        sGDH := Frm_GDH_XZ.rg_gdh.Items.Strings[Frm_GDH_XZ.rg_gdh.ItemIndex];
        Frm_GDH_XZ.Free;
      end;

    end;
    sSqlData := 'select * from BI_WorkOrder where F_sGDH=''%s'' ';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sGDH]);
    if ADO_Rec.RecordCount > 0 then
    begin
      with Frm_Print,ADO_Rec do
      begin
        sID := FieldByName('F_iID').AsString;
        Frm_Print := TFrm_Print.Create(Self);
        for i := 0 to Frm_Print.ComponentCount -1 do
        begin
          comp := Frm_Print.Components[i];
          if (comp is Ti_TxtFilter) or (comp is Ti_ComboBox) or (comp is TComboBox) or (comp is TRzDateTimePicker) or (comp is TRzMemo) then
          begin
            sHint := TCustomControl(comp).Hint;
            if (Copy(sHint,1,2) = 'F_') then
            begin
              if comp is TRzDateTimePicker then
                TRzDateTimePicker(comp).DateTime := FieldByName(sHint).AsDateTime
              else
              if (comp is Ti_ComboBox) or (comp is TComboBox) then
                Ti_ComboBox(comp).Text := FieldByName(sHint).AsString
              else
                TEdit(comp).Text := FieldByName(sHint).AsString;
            end;
          end;
        end;
        Frm_Print.vBSTID := FieldByName('F_iBSTID').AsInteger;
        case FieldByName('F_iSczt').AsInteger of
          0: sSczt:='制版';
          1: sSczt:='印刷';
          2: sSczt:='打号';
          3: sSczt:='后道加工';
          4: sSczt:='进仓';
          5,6: sSczt:='已进仓';
        end;
        {Frm_WorkOrder.lab_jbrq.Visible := True;
        Frm_WorkOrder.lab_ywrq.Visible := True;
        Frm_WorkOrder.lab_zwrq.Visible := True;
        DM_DataBase.GetTableData(ADO_Rec,'DO_ProductDate_Log','F_iWorkID='+sID);
        if ADO_Rec.RecordCount >0 then
        begin
          Frm_WorkOrder.lab_jbrq.Caption := FormatDateTime('yyyy-MM-dd',ADO_Rec.FieldByName('F_dYZBRQ').AsDateTime);
          Frm_WorkOrder.lab_ywrq.Caption := FormatDateTime('yyyy-MM-dd',ADO_Rec.FieldByName('F_dYYSRQ').AsDateTime);
          Frm_WorkOrder.lab_zwrq.Caption := FormatDateTime('yyyy-MM-dd',ADO_Rec.FieldByName('F_dYZDRQ').AsDateTime);
        end;       }
        Frm_Print.lab_sczt.Caption := '该工单目前生产进度： '+sSczt;
        DM_DataBase.GetTableData(ADO_Rec,'DO_WorkOrderDetails','F_iWorkID='+sID);
        n := 0;
        SetLength(OrderData,0);
        iBsts := StrToNum(edt_bsts.Text);
        First;
        while not Eof do
        begin
          khmc := FieldByName('F_sKhmc').AsString;
          cpbh := FieldByName('F_sCpbh').AsString;
          bz := FieldByName('F_sBz').AsString;
          dw := FieldByName('F_sDw').AsString;
          sl := FieldByName('F_sSl').AsString;
          zh := FieldByName('F_sZh').AsString;
          ApartID := FieldByName('F_iApartID').AsString;
          iOrderType := ADO_Rec.FieldByName('F_tiOrderType').AsInteger;
          SetLength(OrderData,Length(OrderData)+1);
          OrderData[Length(OrderData)-1].m_iXH := n;
          OrderData[Length(OrderData)-1].m_sCPBH := cpbh;
          OrderData[Length(OrderData)-1].m_sKhmc := khmc;
          OrderData[Length(OrderData)-1].m_iSyyl := StrToNum(sl);
          OrderData[Length(OrderData)-1].m_iApartID := StrToNum(ApartID);
          OrderData[Length(OrderData)-1].m_iType := iOrderType;
          OrderData[Length(OrderData)-1].m_sSl := sl;
          OrderData[Length(OrderData)-1].m_sDw := StrToNum(dw);
          if iBsts =0 then
            OrderData[Length(OrderData)-1].m_iBSTS := 0
          else
            OrderData[Length(OrderData)-1].m_iBSTS := StrToNum(sl)*10000 div iBsts;
          //CreateFrame(khmc, cpbh,bz,dw,sl,zh,ApartID,n);
          ADO_Rec.Next;
          inc(n);
        end;
        Frm_Print.vWorkID := StrToInt(sID);
        Frm_Print.lab_HBST.Caption := '打印版式图';
//          Frm_Print.EnableCom(False);
        btn_zd.Enabled := False;
        Frm_Print.btn_xg.Enabled := True;
        Frm_Print.btn_dy.Enabled := True;
        Frm_Print.btn_cx.Enabled := True;
        if sCXBZ = '已撤消' then
          Frm_Print.btn_cx.Caption := '恢复';
        cb_Cookie.Checked := False;
        Frm_Print.vActionType :=  c_WorkOrder_Select ;
        Frm_Print.ShowModal;
        Frm_Print.btn_cx.Caption := '撤消';
        setLength(lab, 0);
        setLength(edt, 0);
        setLength(cbb, 0);
        Frm_Print.Free;
      end;
      //btn_cx.Click;
    end;
  finally
    ADO_Rec.Free;
  end;
end;

function TFra_ddcx.p_LoadWorkOrderData: Boolean;
var
  ADO_Rec: TADOQuery;
  i, j, n, iOrderType: Integer;
  sHint, sSczt, str: string;
  comp: TComponent;
  iBsts, iWorkID, iApartID, iGroupID, iCXBZ: Integer;
  sKHMC,sCPBH,SBZ,sDW,sSL,sZH,sRJHDQ,sRJHDZ: string;
  iSYYL, iMax: integer;
  sSqlData: string;
  sGDH: string;

begin
  Result := False;
  Screen.Cursor := crHourGlass;
  if not DM_DataBase.ADO_DataRec.Active then Exit;
  sGDH := Trim(DM_DataBase.mte_DataRec.FieldByName('GDH').AsString);
  iApartID := DM_DataBase.mte_DataRec.FieldByName('ApartID').AsInteger;
  if sGDH = '' then Exit;
  try
    sSqlData := 'Select a.*,a.F_tiCXBZ,b.F_iSCZT SCZT from DO_WorkOrder a,DO_WorkOrderPrtProc b,DO_WorkOrderDetails c '
        +' where a.F_sGDH=''%s'' and c.F_iApartID=%d and a.F_iID=b.F_iWorkID and a.F_iID=c.F_iWorkID and  b.F_iGroupID=c.F_iGroupID';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sGDH,iApartID],True);
    if ADO_Rec.RecordCount > 0 then
    begin
      with ADO_Rec do
      begin
        for i := 0 to Frm_WorkOrder.ComponentCount -1 do
        begin
          comp := Frm_WorkOrder.Components[i];
          if (comp is Ti_TxtFilter) or (comp is Ti_ComboBox) or (comp is TComboBox) or (comp is TRzDateTimePicker) or (comp is TMemo) then
          begin
            sHint := TCustomControl(comp).Hint;
            if (Copy(sHint,1,2) = 'F_') then
            begin
              if comp is TRzDateTimePicker then
                TRzDateTimePicker(comp).DateTime := FieldByName(sHint).AsDateTime
              else
              if (comp is Ti_ComboBox) or (comp is TComboBox) then
                Ti_ComboBox(comp).Text := FieldByName(sHint).AsString
              else
                TEdit(comp).Text := FieldByName(sHint).AsString;
            end;
          end;
        end;
        //Frm_Print.vBSTID := FieldByName('F_iBSTID').AsInteger;
        iWorkID := FieldByName('F_iID').AsInteger;
        iCXBZ := FieldByName('F_tiCXBZ').AsInteger;
        if iCXBZ = 1 then
          Frm_WorkOrder.btn_cx.Caption := '恢复';
        case FieldByName('SCZT').AsInteger of
          0: sSczt:='制版';
          1: sSczt:='印刷';
          2: sSczt:='打号';
          3: sSczt:='后道加工';
          4: sSczt:='进仓';
          5,6: sSczt:='已进仓';
        end;
        //Frm_WorkOrder.lab_jbrq.Visible := True;
        //Frm_WorkOrder.lab_ywrq.Visible := True;
//          Frm_WorkOrder.lab_zwrq.Visible := True;
//          Frm_WorkOrder.lab_jbrq.Caption := stg_gd.cells[c_jbrq,ARow];
//          Frm_WorkOrder.lab_ywrq.Caption := stg_gd.cells[c_ywrq,ARow];
//          Frm_WorkOrder.lab_zwrq.Caption := stg_gd.cells[c_zwrq,ARow];
        Frm_WorkOrder.gb_zt.Show;
        Frm_WorkOrder.lab_sczt.Caption := '该工单目前生产进度： '+sSczt;
        //DM_DataBase.GetTableData(ADO_Rec,'DO_WorkOrderDetails','F_iWorkID='+sID);
        ADO_Rec.Free;
        //读取订单信息到数组
        sSqlData := 'select *,SYYL=dbo.f_GetSYYL(F_iApartID) from DO_WorkOrderDetails where F_iWorkID=%d ';
        ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iWorkID],True);
        n := 0;
        SetLength(OrderData,0);
        //iBsts := StrToNum(edt_bsts.Text);
        First;
        while not Eof do
        begin
          sKHMC := FieldByName('F_sKhmc').AsString;
          sCPBH := FieldByName('F_sCpbh').AsString;
          SBZ := FieldByName('F_sBz').AsString;
          sDW := FieldByName('F_sDw').AsString;
          sSL := FieldByName('F_sSl').AsString;
          sZH := FieldByName('F_sZh').AsString;
          sRJHDQ := FieldByName('F_sRJHDQ').AsString;
          sRJHDZ := FieldByName('F_sRJHDZ').AsString;
          iSYYL := FieldByName('SYYL').AsInteger;
          iApartID := FieldByName('F_iApartID').AsInteger;
          iGroupID := FieldByName('F_iGroupID').AsInteger;
          iOrderType := FieldByName('F_tiOrderType').AsInteger;
          SetLength(OrderData,Length(OrderData)+1);
          OrderData[Length(OrderData)-1].m_iXH := n;
          OrderData[Length(OrderData)-1].m_sCPBH := sCPBH;
          OrderData[Length(OrderData)-1].m_sKhmc := sKHMC;
          OrderData[Length(OrderData)-1].m_sSl := StrToNum(sSL);
          OrderData[Length(OrderData)-1].m_iBCYL := StrToNum(sSL)*10000;
          OrderData[Length(OrderData)-1].m_iSyyl := StrToNum(sSL)*10000+iSYYL;
          OrderData[Length(OrderData)-1].m_iApartID := iApartID;
          OrderData[Length(OrderData)-1].m_iType := iOrderType;
          OrderData[Length(OrderData)-1].m_sZH := sZH;
          OrderData[Length(OrderData)-1].m_sRJHDQ := sRJHDQ;
          OrderData[Length(OrderData)-1].m_sRJHDZ := sRJHDZ;
          OrderData[Length(OrderData)-1].m_sDw := StrToNum(sDW);
          OrderData[Length(OrderData)-1].m_sBZ := SBZ;
          OrderData[Length(OrderData)-1].m_iGroupID := iGroupID;
         { if iBsts =0 then
            OrderData[Length(OrderData)-1].m_iBSTS := 0
          else
            OrderData[Length(OrderData)-1].m_iBSTS := StrToNum(sl)*10000 div iBsts;  }
          //CreateFrame(khmc, cpbh,bz,dw,sl,zh,ApartID,n);
          ADO_Rec.Next;
          inc(n);
        end;
        Frm_WorkOrder.vWorkID := iWorkID;
        //Frm_WorkOrder.lab_HBST.Caption := '打印版式图';
  //          Frm_Print.EnableCom(False);
        ADO_Rec.Free;
        //读取材料信息到数组
        sSqlData := 'select * from DO_WorkOrderMatl where F_iWorkID = %d';
        ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iWorkID],True);
        SetLength(aCL,0);
        with ADO_Rec do
        begin
          while not ADO_Rec.Eof do
          begin
            SetLength(aCL,Length(aCL)+1);
            aCL[Length(aCL)-1].m_iID := FieldByName('F_iID').AsInteger;
            aCL[Length(aCL)-1].m_sCLBH := FieldByName('F_sCLBH').AsString;
            aCL[Length(aCL)-1].m_sCLMC := FieldByName('F_sCLMC').AsString;
            aCL[Length(aCL)-1].m_sCLGG := FieldByName('F_sCLGG').AsString;
            aCL[Length(aCL)-1].m_sCJGG := FieldByName('F_sCJGG').AsString;
            aCL[Length(aCL)-1].m_iJFQS := FieldByName('F_iJFQS').AsInteger;
            aCL[Length(aCL)-1].m_iJFS := FieldByName('F_iJFS').AsInteger;
            aCL[Length(aCL)-1].m_iGroupID := FieldByName('F_iGroupID').AsInteger;
            Next;
          end;
        end;
        ADO_Rec.Free;
        //读取机台信息到数组
        sSqlData := 'select * from DO_WorkOrderPrtProc where F_iWorkID = %d';
        ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iWorkID],True);
        SetLength(aYSDH,0);
        with ADO_Rec do
        begin
          while not ADO_Rec.Eof do
          begin
            SetLength(aYSDH,Length(aYSDH)+1);
            aYSDH[Length(aYSDH)-1].m_iID      := FieldByName('F_iID').AsInteger;
            aYSDH[Length(aYSDH)-1].m_sJTMC    := FieldByName('F_sJTMC').AsString;
            aYSDH[Length(aYSDH)-1].m_sJTBH    := FieldByName('F_sJTBH').AsString;
            aYSDH[Length(aYSDH)-1].m_sSC      := FieldByName('F_sSC').AsString;
            aYSDH[Length(aYSDH)-1].m_iSBS     := FieldByName('F_iSBS').AsInteger;
            aYSDH[Length(aYSDH)-1].m_sSB      := FieldByName('F_sSB').AsString;
            aYSDH[Length(aYSDH)-1].m_iYS      := FieldByName('F_iYS').AsInteger;
            aYSDH[Length(aYSDH)-1].m_iYS_1      := FieldByName('F_iYS_1').AsInteger;
            aYSDH[Length(aYSDH)-1].m_iYS_2      := FieldByName('F_iYS_2').AsInteger;
            aYSDH[Length(aYSDH)-1].m_sYZLX    := FieldByName('F_sYZLX').AsString;
            aYSDH[Length(aYSDH)-1].m_sQT      := FieldByName('F_sQT').AsString;
            aYSDH[Length(aYSDH)-1].m_sYQGX    := FieldByName('F_sYQGX').AsString;
            aYSDH[Length(aYSDH)-1].m_sYQGXSL  := FieldByName('F_sYQGXSL').AsString;
            aYSDH[Length(aYSDH)-1].m_sYQGXDW  := FieldByName('F_sYQGXDW').AsString;
            aYSDH[Length(aYSDH)-1].m_sYSYQ    := FieldByName('F_sYSYQ').AsString;
            //aYSDH[Length(aYSDH)-1].m_sBZ := FieldByName('F_sBZ').AsString;
            aYSDH[Length(aYSDH)-1].m_iBSTID   := FieldByName('F_iBSTID').AsInteger;
            aYSDH[Length(aYSDH)-1].m_iBSTYS   := FieldByName('F_iBSTYS').AsInteger;
            aYSDH[Length(aYSDH)-1].m_iBSTZS   := FieldByName('F_iBSTZS').AsInteger;
//            aYSDH[Length(aYSDH)-1].m_sJTCLBH  := FieldByName('F_sJTCLBH').AsString;
//            aYSDH[Length(aYSDH)-1].m_sJTCLMC  := FieldByName('F_sJTCLMC').AsString;
//            aYSDH[Length(aYSDH)-1].m_sJTCLGG  := FieldByName('F_sJTCLGG').AsString;
//            aYSDH[Length(aYSDH)-1].m_sJTCLDW  := FieldByName('F_sJTCLDW').AsString;
            aYSDH[Length(aYSDH)-1].m_iGroupID := FieldByName('F_iGroupID').AsInteger;
            Next;
          end;
        end;
        ADO_Rec.Free;
        //读取制版信息到数组
        sSqlData := 'select * from DO_WorkOrderMkProc where F_iWorkID = %d';
        ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iWorkID],True);
        SetLength(aZB,0);
        with ADO_Rec do
        begin
          while not ADO_Rec.Eof do
          begin
            SetLength(aZB,Length(aZB)+1);
            aZB[Length(aZB)-1].m_iID      := FieldByName('F_iID').AsInteger;
            aZB[Length(aZB)-1].m_sTS      := FieldByName('F_sTS').AsString;
            aZB[Length(aZB)-1].m_sGB      := FieldByName('F_sGB').AsString;
            aZB[Length(aZB)-1].m_sJD      := FieldByName('F_sJD').AsString;
            aZB[Length(aZB)-1].m_sDY      := FieldByName('F_sDY').AsString;
            aZB[Length(aZB)-1].m_sPB      := FieldByName('F_sPB').AsString;
            aZB[Length(aZB)-1].m_sSBLB    := FieldByName('F_sSBLB').AsString;
            aZB[Length(aZB)-1].m_sSBKS    := FieldByName('F_sSBKS').AsString;
            aZB[Length(aZB)-1].m_iSBK     := FieldByName('F_iSBK').AsInteger;
            aZB[Length(aZB)-1].m_sQT      := FieldByName('F_sQT').AsString;
            aZB[Length(aZB)-1].m_iGroupID := FieldByName('F_iGroupID').AsInteger;
            Next;
          end;
        end;
        ADO_Rec.Free;
      end;

      sSqlData := 'select cast('''' as varchar(500)) orders,cast('''' as varchar(500)) JTMC,cast(0 as int) BSTYS,cast(0 as int) BSTZS '
        +',cast('''' as varchar(500)) CL,cast('''' as varchar(500)) ZB into #s '
        +'select * from #s';
      with Frm_WorkOrder.ADO_WorkOrder do
      begin
        Close;
        SQL.Text := sSqlData;
        Open;
        //取最大行数
        iMax := 0;
        for i := 0 to Length(OrderData) -1 do
        begin
          if iMax < OrderData[i].m_iGroupID then
            iMax := OrderData[i].m_iGroupID;
        end;
        for i := 0 to Length(aYSDH) -1 do
        begin
          if iMax < aYSDH[i].m_iGroupID then
            iMax := aYSDH[i].m_iGroupID;
        end;
        for i := 0 to Length(aCL) -1 do
        begin
          if iMax < aCL[i].m_iGroupID then
            iMax := aCL[i].m_iGroupID;
        end;
        for i := 0 to Length(aZB) -1 do
        begin
          if iMax < aZB[i].m_iGroupID then
            iMax := aZB[i].m_iGroupID;
        end;
        //添加数据
        First;
        sCPBH := '';
        for i := 0 to iMax -1 do
        begin
          for j := 0 to Length(OrderData) -1 do
          begin
            if OrderData[j].m_iGroupID = Frm_WorkOrder.ADO_WorkOrder.RecNo then
            begin
              sCPBH := sCPBH + OrderData[j].m_sCPBH + '; ';
            end;
          end;
          if not Eof then
            Edit
          else
            Insert;
          FieldByName('orders').AsString := sCPBH;
          Post;
          Next;
        end;
        First;
        while not Eof do
        begin
          for i := 0 to Length(aYSDH) -1 do
          begin
            if aYSDH[i].m_iGroupID = Frm_WorkOrder.ADO_WorkOrder.RecNo then
            begin
              Edit;
              FieldByName('JTMC').AsString := aYSDH[i].m_sJTMC;
              FieldByName('BSTYS').AsInteger := aYSDH[i].m_iBSTYS;
              FieldByName('BSTZS').AsInteger := aYSDH[i].m_iBSTZS;
              Post;
            end;
          end;
          Next;
        end;
        First;
        while not Eof do
        begin
          for i := 0 to Length(aCL) -1 do
          begin
            if aCL[i].m_iGroupID = Frm_WorkOrder.ADO_WorkOrder.RecNo then
            begin
              Edit;
              FieldByName('CL').AsString := aCL[i].m_sCLMC;
              Post;
            end;
          end;
          Next;
        end;
        First;
        while not Eof do
        begin
          {for i := 0 to Length(aZB) -1 do
          begin
            if aZB[i].m_iGroupID = Frm_WorkOrder.ADO_WorkOrder.RecNo then
            begin
              str := aZB[i].m_sSBLB + '版 ' + aZB[i].m_sSBKS + '开 ' + IntToStr(aZB[i].m_iSBK) + '块';
              Edit;
              FieldByName('ZB').AsString := str;
              Post;
            end;
          end;    }
          str := '';
          for i := 0 to Length(aZBGX) -1 do
          begin
            if aZBGX[i].m_iGroupID = Frm_WorkOrder.ADO_WorkOrder.RecNo then
              str := str + ';' + aZBGX[i].m_sName ;
          end;
          str := Copy(str,2,Length(str));
          Edit;
          FieldByName('ZB').AsString := str;
          Post;

          Next;
        end;
      end;

      Result := True;
    end;
  except
    on E:Exception do
    begin
      p_MessageBoxDlg('错误：'+e.Message);
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TFra_ddcx.FraShow;
begin
  if FormatDateTime('hh:mm:ss',dtp_jsq.Time) = '00:00:00' then
  begin
    cb_jsrq.Checked := True;
    dtp_jsq.Enabled := cb_jsrq.Checked;
    dtp_jsz.Enabled := cb_jsrq.Checked;
    dtp_jsq.DateTime := IncMonth(Now,-6);
    dtp_jsz.DateTime := Now;
  end;

  f_MakeAllow;
end;

procedure TFra_ddcx.pm_jhxdPopup(Sender: TObject);
var
  iType: Integer;
begin
  iType := DM_DataBase.mte_DataRec.FieldByName('OrderType').AsInteger;
  //if menu_ddmxPic.Tag = c_Tag_MakeAllow then
  begin
    if iType = 1 then
      menu_ddmxPic.Visible := False
    else
      menu_ddmxPic.Visible := True;
  end;
end;

function TFra_ddcx.f_MakeAllow: Boolean;
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
  //iLimitID,iLimitCode: integer;
  iAllowID, iAllowCode: Integer;
begin
  Result := False;
  if LoginData.m_iAllowCode >= 0 then
  begin
    //iLimitCode := LoginData.m_iLimitCode;
    //sSqlData := 'Select F_iID from Set_LimitInfo where F_tiStatus = 1 and F_sLimitName=''%s'' order by F_iID';
    iAllowCode := LoginData.m_iAllowCode;
    sSqlData := 'Select F_iID,F_sCode from Set_AllowInfo where F_tiStatus = 1 and F_sCode in (''%s'',''%s'') order by F_iID';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[c_Allow_FWDDTG,c_Allow_XSDHGDQY],False);
    if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
    begin
      while not ADO_Rec.Eof do
      begin
        iAllowID := ADO_Rec.FieldByName('F_iID').AsInteger;
        if ADO_Rec.FieldByName('F_sCode').AsString = c_Allow_FWDDTG then
        begin
          if 1 shl iAllowID or iAllowCode = iAllowCode then
          begin
            menu_ddmxPic.Enabled := True;
            menu_ddmxPic.Tag := c_Tag_MakeAllow;;
          end else
          begin
            menu_ddmxPic.Enabled := False;
            menu_ddmxPic.Tag := 0;
          end;
        end else
        if ADO_Rec.FieldByName('F_sCode').AsString = c_Allow_XSDHGDQY then
        begin
          if 1 shl iAllowID or iAllowCode = iAllowCode then
          begin
            if cbb_tgzt.Items.IndexOf('发货待合格') < 0 then
              cbb_tgzt.Items.Add('发货待合格');
            if cbb_tgzt.Items.IndexOf('发货待签样') < 0 then
              cbb_tgzt.Items.Add('发货待签样');
          end else
          begin
            if cbb_tgzt.Items.IndexOf('发货待合格') >= 0 then
              cbb_tgzt.Items.Delete(cbb_tgzt.Items.IndexOf('发货待合格'));
            if cbb_tgzt.Items.IndexOf('发货待签样') >= 0 then
              cbb_tgzt.Items.Delete(cbb_tgzt.Items.IndexOf('发货待签样'));
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

procedure TFra_ddcx.btn_exportClick(Sender: TObject);
begin
  if SavePath.Execute then
  begin
    if (SavePath.FileName <> '') then
      if UpperCase(Copy(SavePath.FileName,Length(SavePath.FileName)-4,Length(SavePath.FileName))) = UpperCase('.xls') then
        SavePath.FileName := Copy(SavePath.FileName,1,Length(SavePath.FileName)-4);
    Screen.Cursor := crHourGlass;
    try
      SaveDBGridEhToExportFile(TDBGridEhExportAsXLS,dbg_jhxd, SavePath.FileName,True);
    except

    end;                
    Screen.Cursor := crDefault;
    p_MessageBoxDlg('导出成功!')
  end;
end;

procedure TFra_ddcx.GDHClick;
var
  ADO_Rec: TADOQuery;
  i, n, iOrderType, iApartID, iWorkID, iGroupID: Integer;
  sGDH, sSqlData: string;
begin
  if not DM_DataBase.ADO_DataRec.Active then Exit;
  sGDH := Trim(DM_DataBase.mte_DataRec.FieldByName('GDH').AsString);
  iApartID := DM_DataBase.mte_DataRec.FieldByName('ApartID').AsInteger;
  if sGDH = '' then Exit;
  Screen.Cursor := crHourGlass;
  if Pos(',',sGDH) > 0 then
  begin
    Frm_GDH_XZ := TFrm_GDH_XZ.Create(Self);
    Frm_GDH_XZ.rg_gdh.Items.Clear;
    for i := 0 to PosNum(sGDH,',') do
    begin
      Frm_GDH_XZ.rg_gdh.Items.Add(PosCopy(sGDH,',',i+1));
    end;
    Frm_GDH_XZ.rg_gdh.ItemIndex := 0;
    if Frm_GDH_XZ.ShowModal <> mrok then
    begin
      Frm_GDH_XZ.Free;
      Screen.Cursor := crDefault;
      Exit;
    end else
    begin
      sGDH := Frm_GDH_XZ.rg_gdh.Items.Strings[Frm_GDH_XZ.rg_gdh.ItemIndex];
      Frm_GDH_XZ.Free;
    end;
  end;
  sSqlData := 'select b.F_iWorkID,b.F_iGroupID from DO_WorkOrder a,DO_WorkOrderDetails b where a.F_sGDH=''%s'' and b.F_iApartID=%d and a.F_iID=b.F_iWorkID  ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sGDH,iApartID],False);
  if ADO_Rec.RecordCount > 0 then
  begin
    iWorkID := ADO_Rec.FieldByName('F_iWorkID').AsInteger;
    iGroupID := ADO_Rec.FieldByName('F_iGroupID').AsInteger;
    Frm_WorkOrder := TFrm_WorkOrder.Create(Self);
    Frm_WorkOrder.vWorkID := iWorkID;
    Frm_WorkOrder.vGroupID := iGroupID;
    Frm_WorkOrder.vbCXBZ := False;
    if Frm_WorkOrder.p_LoadWorkOrderData then
    begin
      Frm_WorkOrder.btn_zd.Enabled := False;
      Frm_WorkOrder.btn_xg.Enabled := True;
      Frm_WorkOrder.btn_dy.Enabled := True;
      Frm_WorkOrder.btn_cx.Enabled := True;
      Frm_WorkOrder.vActionType :=  c_WorkOrder_Select ;
      Screen.Cursor := crDefault;

      Frm_WorkOrder.ShowModal;
      Frm_WorkOrder.btn_cx.Caption := '撤消';
    end;
    Frm_WorkOrder.Free;

  end;
  Screen.Cursor := crDefault;
end;

procedure TFra_ddcx.cb_ljhrqfwClick(Sender: TObject);
begin
  edt_ljhrqq.Enabled := cb_ljhrqfw.Checked;
  edt_ljhrqz.Enabled := cb_ljhrqfw.Checked;
  if cb_ljhrqfw.Checked then
  begin
    edt_ljhrqq.Color := clWindow;
    edt_ljhrqz.Color := clWindow;
  end else
  begin
    edt_ljhrqq.Color := clBtnFace;
    edt_ljhrqz.Color := clBtnFace;
  end;
end;

procedure TFra_ddcx.menu_fhmxClick(Sender: TObject);
var
  i,iApartID,iOrderID,iOrderType: integer;
begin
  if not DM_DataBase.ADO_DataRec.Active then Exit;
  iApartID := DM_DataBase.mte_DataRec.FieldByName('ApartID').AsInteger;
  iOrderID := DM_DataBase.mte_DataRec.FieldByName('OrderID').AsInteger;
  iOrderType := DM_DataBase.mte_DataRec.FieldByName('OrderType').AsInteger;
  if iApartID <= 0 then
  begin
    Application.MessageBox('请选择订单!','提示',MB_ICONINFORMATION);
    Exit;
  end;
  Frm_FHMX := TFrm_FHMX.Create(Self);
  Frm_FHMX.p_ShowWindow([iApartID,iOrderID,iOrderType]);

end;

procedure TFra_ddcx.menu_ztmxClick(Sender: TObject);
var
  i,iApartID: integer;
begin
  if not DM_DataBase.ADO_DataRec.Active then Exit;
  iApartID := DM_DataBase.mte_DataRec.FieldByName('ApartID').AsInteger;
  if iApartID <= 0 then
  begin
    Application.MessageBox('请选择订单!','提示',MB_ICONINFORMATION);
    Exit;
  end;
  Frm_ZTMX := TFrm_ZTMX.Create(Self);
  Frm_ZTMX.p_ShowWindow([iApartID]);
end;

procedure TFra_ddcx.Init;
var
  i: Integer;
begin
  cbb_xpl.ItemIndex := 0;
  case LoginData.m_iUserType of
    c_User:
      cbb_xpl.ItemIndex := 1;       //普通;
    c_Admin:
      cbb_xpl.ItemIndex := 1;       //普通;
    c_User_Small:
      cbb_xpl.ItemIndex := 2;       //小批量
    c_Admin_Small:
      cbb_xpl.ItemIndex := 2;         //小批量
    c_SuperAdmin:;
  end;
  cbb_txlx.ItemIndex := 0;
  cbb_bb.ItemIndex := 0;
  cbb_bb.Enabled := True;
  cbb_tgzt.ItemIndex := 0;
  cbb_scjd.ItemIndex := 0;

  cbb_cplb.Clear;
  cbb_cplb.Items.Add('--全部--');
  CbbAdd(cbb_cplb,pkProductCategory);
  cbb_cplb.ItemIndex := 0;

  cbb_cplx.Clear;
  cbb_cplx.Items.Add('--全部--');
  CbbAdd(cbb_cplx,pkProductType,FindProductCategoryID(cbb_cplb.ItemIndex));
  cbb_cplx.ItemIndex := 0;

  cb_History.Checked := False;
  for i := 0 to gb_cx.ControlCount -1 do
  begin
    if gb_cx.Controls[i].ClassName = 'Ti_TxtFilter' then
    begin
      Ti_TxtFilter(gb_cx.Controls[i]).Text := '';
    end;
  end;
  edt_cpbh.Text := '';
end;

end.





