unit uFrm_GDFK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, StdCtrls, RzCmboBx, iComboBox, ComCtrls, RzListVw,
  ExtCtrls, RzPanel,ADODB, Menus, ImgList;

const
  c_jg = 0;
  c_khmc = 1;
  c_cpbh = 2;
  c_zl = 3;
  c_yztmc = 4;
  c_yl = 5;
  c_qy = 6;
  c_jy = 7;
  c_tgzt = 8;
  c_Lrbz = 9;
  c_DetailsID = 10;
  c_OrderType = 11;
  c_OrderID = 12;


type
  TFrm_GDFK = class(TForm)
    gb_dd: TRzGroupBox;
    lv_dd: TRzListView;
    GroupBox1: TGroupBox;
    cbb_llzt: Ti_ComboBox;
    btn_fk: TRzButton;
    ImageList1: TImageList;
    pm_jhxd: TPopupMenu;
    menu_ddmx: TMenuItem;
    menu_ddmxPic: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure lv_ddColumnClick(Sender: TObject; Column: TListColumn);
    procedure lv_ddCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lv_ddMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_fkClick(Sender: TObject);
  private
    { Private declarations }
    procedure ReadDataDD(ADO_Data: TADOQuery);
  public
    { Public declarations }
    vWorkID: integer;
  end;

var
  Frm_GDFK: TFrm_GDFK;

implementation

uses
  uDM_DataBase, uPub_Type, uPub_Func, uPrint, PubStr, PostService,
  uMain, uPub_Text;
{$R *.dfm}

{ TFrm_GDFK }

procedure TFrm_GDFK.ReadDataDD(ADO_Data: TADOQuery);
var
  iYl: Integer;
  sQY,sJY: string;
begin
  with ADO_Data do
  begin
    lv_dd.Items.Clear;
    GetPostageTypeList;
    while not Eof do
    begin
      lv_dd.Items.Add.Caption := '';
      lv_dd.Items.Item[lv_dd.Items.Count -1].SubItems.Add(FieldByName('F_sJg').AsString);
      lv_dd.Items.Item[lv_dd.Items.Count -1].SubItems.Add(FieldByName('F_sKhmc').AsString);
      lv_dd.Items.Item[lv_dd.Items.Count -1].SubItems.Add(FieldByName('F_sCpbh').AsString);
      lv_dd.Items.Item[lv_dd.Items.Count -1].SubItems.Add(FieldByName('Zl').AsString);
      lv_dd.Items.Item[lv_dd.Items.Count -1].SubItems.Add(FieldByName('F_sYztmc').AsString);
      iYl := Round(FieldByName('F_nYl').AsFloat*10000);
      lv_dd.Items.Item[lv_dd.Items.Count -1].SubItems.Add(IntToStr(iYl));
      case FieldByName('F_tiQy').AsInteger of
        0: sQY := '无';
        1: sQY := '签样'
      end;
      lv_dd.Items.Item[lv_dd.Items.Count -1].SubItems.Add(sQY);
      case FieldByName('F_tiJybz').AsInteger of
        0: sJY := '无';
        1: sJY := '加印'
      end;
      lv_dd.Items.Item[lv_dd.Items.Count -1].SubItems.Add(sJY);
      lv_dd.Items.Item[lv_dd.Items.Count -1].SubItems.Add(FieldByName('FKTGZT').AsString);
      lv_dd.Items.Item[lv_dd.Items.Count -1].SubItems.Add(FieldByName('F_tiLrbz').AsString);
      lv_dd.Items.Item[lv_dd.Items.Count -1].SubItems.Add(FieldByName('F_iDetailsID').AsString);
      lv_dd.Items.Item[lv_dd.Items.Count -1].SubItems.Add(FieldByName('F_tiOrderType').AsString);
      lv_dd.Items.Item[lv_dd.Items.Count -1].SubItems.Add(FieldByName('F_iID').AsString);
      lv_dd.Items.Item[lv_dd.Items.Count -1].Checked := True;
      Next;
    end;
  end;

end;

procedure TFrm_GDFK.FormShow(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  iAllowID, iAllowCode: Integer;
begin
  sSqlData := ' select c.F_sJg,c.F_sKhmc,c.F_sCpbh, '
    +'Zl=(Select F_sCplx from Set_PostageType where CHARINDEX(F_sYztmc,b.F_sYztmc)=1), '
    +'b.F_sYztmc,b.F_nYl,c.F_tiQy,c.F_tiJybz,dbo.PicStatus(c.F_iFktgzt) FKTGZT,d.F_tiLrbz,c.F_iDetailsID,b.F_tiOrderType,c.F_iID '
    +' from BI_WorkOrderDetails a,DO_OrderApart b,BI_CustomOrderDetails c,BI_CustomOrder d '
    +'where a.F_iApartID=b.F_iID and b.F_iOrderID=c.F_iID  and b.F_tiOrderType=0 and b.F_tiCXBZ = 0'
    +'and c.F_iCustomID=d.F_iID and a.F_iWorkID=%d ';
  sSqlData := sSqlData + ' union all ';
  sSqlData := sSqlData +' select c.F_sJg,c.F_sCpmc,c.F_sCpbh, '
    +'Zl=(Select F_sCplx from Set_PostageType where CHARINDEX(F_sYztmc,b.F_sYztmc)=1), '
    +'b.F_sYztmc,b.F_nYl,c.F_tiQy,c.F_tiJybz,dbo.PicStatus(c.F_iFktgzt) FKTGZT,d.F_tiLrbz,c.F_iDetailsID,b.F_tiOrderType,c.F_iID '
    +'from BI_WorkOrderDetails a,DO_OrderApart b,BI_SellOrderDetails c,BI_SellOrder d '
    +'where a.F_iApartID=b.F_iID and b.F_iOrderID=c.F_iID  and b.F_tiOrderType=1 and b.F_tiCXBZ = 0'
    +'and c.F_iSellID=d.F_iID and a.F_iWorkID=%d ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[Frm_Print.vWorkID,Frm_Print.vWorkID]);
  ReadDataDD(ADO_Rec);

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
        menu_ddmxPic.Tag := c_Tag_MakeAllow;
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

procedure TFrm_GDFK.lv_ddColumnClick(Sender: TObject; Column: TListColumn);
var
  i: Integer;
  bQx: Boolean;
begin
  if Column.Caption = '选择' then
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

procedure TFrm_GDFK.lv_ddCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if (Item.Index mod 2) = 0 then
    Sender.Canvas.Brush.Color := $00F0FFF0//clWhite
  else
    Sender.Canvas.Brush.Color := $00F2F2F2;//$00EBEBEB;
  LVDrawItem(lv_dd, Item, State, DefaultDraw);

end;

procedure TFrm_GDFK.lv_ddMouseDown(Sender: TObject; Button: TMouseButton;
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
  end else
  if (Button = mbleft) and (X > 20) then
  begin
    if not Assigned(TRzListView(Sender).Selected) then Exit;
    TRzListView(Sender).Selected.Checked := not TRzListView(Sender).Selected.Checked;
  end;
end;

procedure TFrm_GDFK.btn_fkClick(Sender: TObject);
const
  c_wsd = 0;
  c_ysd = 1;
  c_whg = 2;
  c_yhg = 3;
  c_dy=4;
  c_yqy = 5;
  c_llzt_qxz = 0;
  c_llzt_wsd = 1;
  c_llzt_ysd = 2;
  c_llzt_whg = 3;
  c_llzt_yhg = 4;
  c_llzt_dy = 5;
  c_llzt_yqy = 6;
  c_dzx = 0;
  c_xsx = 1;
var
  obj: PostServicePortType;
  i,iRec,iFktgzt: Integer;
  sDetailsID, sSpbm,sOrderID: string;
  zStr,Str, SqlData, sSqldata: string;
  iOrderType,iDfbbz: integer;
  sCzrqFieldName,sCzrFieldName: string;
  bCheck: Boolean;
begin
  bCheck := False;
  for i := 0 to lv_dd.Items.Count -1 do
  begin
    if lv_dd.Items[i].Checked then
    begin
      bCheck := True;
      Break;
    end;
  end;
  if not bCheck then
  begin
    Application.MessageBox('请选择至少一项','提示',MB_ICONINFORMATION);
    Exit;
  end;
  if cbb_llzt.ItemIndex = 0 then
  begin
    Application.MessageBox('请选择图稿状态','提示',MB_ICONINFORMATION);
    Exit;
  end;
  sOrderID := StrToNum(lv_dd.Items[i].SubItems.Strings[c_OrderID]);
  sDetailsID := StrToNum(lv_dd.Items[i].SubItems.Strings[c_DetailsID]);
  iOrderType := StrToNum(lv_dd.Items[i].SubItems.Strings[c_OrderType]);
  obj := GetPostServicePortType(true,uMain.vUrl, nil);
  if obj = nil then exit;
  zStr := '';
  for i := 0 to lv_dd.Items.Count -1 do
  begin
    if lv_dd.Items[i].Checked then
    begin
      sDetailsID := Trim(lv_dd.Items[i].SubItems.Strings[c_DetailsID]);
      sSpbm := Trim(lv_dd.Items[i].SubItems.Strings[2]);
      if sDetailsID = '' then
      begin
        Str := '产品编号：'+sSpbm+' 国网上无此订单,不能反馈!';
        Application.MessageBox(PChar(Str),'提示',MB_ICONINFORMATION);
        Continue;
      end;
      iDfbbz := 0;
      case iOrderType of
        c_dzx:
          begin
            SqlData := 'Select IsNull(F_tiDfbbz,0) from BI_CustomOrder a where exists(Select 1 from BI_CustomOrderDetails where a.F_iID = F_iCustomID and '
              +' F_iDetailsID='+sDetailsID+')';
            iDfbbz := DM_DataBase.GetTableFirst(SqlData);
          end;
        c_xsx:
          begin
            SqlData := 'Select IsNull(F_tiDfbbz,0) from BI_SellOrder a where exists(Select 1 from BI_SellOrderDetails where a.F_iID = F_iSellID and '
              +' F_iDetailsID='+sDetailsID+')';
            iDfbbz := DM_DataBase.GetTableFirst(SqlData);
          end;
      end;
      if (cbb_llzt.ItemIndex = c_llzt_dy) then     //打样
        iRec := obj.setDYQR('wsfj1', '000000',iif(iDfbbz=0,iOrderType,3),sDetailsID,0,StrLeft(sSpbm,17))
      else
        iRec := obj.setProductInfo('wsfj1', '000000',iif(iDfbbz=0,iOrderType,3),sDetailsID,sSpbm,cbb_llzt.ItemIndex-1);
//      iRec := 0;
      if iRec = 0 then
      begin
        Str := '产品编号：'+sSpbm+' 反馈成功';
        sSqlData := sSqlData +' if not exists(Select 1 from DO_OrderPicDate_Log where F_iOrderID = '+sOrderID+' ' ;
        sSqlData := sSqlData +' and F_tiOrderType = '+IntToStr(iOrderType)+') ' ;
        sSqlData := sSqlData + 'Insert into DO_OrderPicDate_Log (F_iOrderID,F_tiOrderType) VALUES ('+ sOrderID ;
        sSqlData := sSqlData +' ,'+IntToStr(iOrderType)+') ' ;
        DM_DataBase.ExecQuery(sSqlData,[],True);
//        DM_DataBase.WriteSynLog(sSqlData);  //记录日志

        case cbb_llzt.ItemIndex of
          c_llzt_wsd:
            begin
              iFktgzt := c_wsd;
              sCzrqFieldName := 'F_dWSD';
              sCzrFieldName := 'F_iWSDCZRID'
            end;
          c_llzt_ysd:
            begin
              iFktgzt := c_ysd;
              sCzrqFieldName := 'F_dYSD';
              sCzrFieldName := 'F_iYSDCZRID'
            end;
          c_llzt_whg:
            begin
              iFktgzt := c_whg;
              sCzrqFieldName := 'F_dWHG';
              sCzrFieldName := 'F_iWHGCZRID'
            end;
          c_llzt_yhg:
            begin
              iFktgzt := c_yhg;
              sCzrqFieldName := 'F_dYHG';
              sCzrFieldName := 'F_iYHGCZRID'
            end;
          c_llzt_dy:
            begin
              iFktgzt := c_dy;
              sCzrqFieldName := 'F_dYDY';
              sCzrFieldName := 'F_iYDYCZRID'
            end;
          c_llzt_yqy:
            begin
              Application.MessageBox('不能修改成已签到!','提示',MB_ICONINFORMATION);
              Exit;
              iFktgzt := c_yqy;
              sCzrqFieldName := 'F_dWSD';
              sCzrFieldName := 'F_iWSDCZRID'
            end;
        else
          iFktgzt := -1;
        end;
        try
          DM_DataBase.Con_YDPrint.BeginTrans;
          with DM_DataBase.ADO_DataRec do
          begin
            close;
            if iOrderType = c_dzx then
            begin
//            SQL.Text := 'Update BI_CustomOrderDetails set F_iFktgzt='+IntToStr(iFktgzt)+',F_dFkrq=getdate(),F_iFkrID='+IntToStr(LoginData.m_iUserID)+' where F_iDetailsID in ('+sDetailsID+')'         //不改变内部状态
              SQL.Text := 'Update BI_CustomOrderDetails set F_iFktgzt='+IntToStr(iFktgzt)+',F_dFkrq=getdate(),F_iFkrID='+IntToStr(LoginData.m_iUserID)+',F_iTgzt='+IntToStr(cbb_llzt.ItemIndex-1)+',F_dCzrq=getdate() where F_iDetailsID in ('+sDetailsID+') ';  //改变内部状态为反馈状态
              SQL.Add(' Update DO_OrderPicDate_Log set '+sCzrqFieldName+'=getdate(),'+sCzrFieldName+'='+IntToStr(LoginData.m_iUserID)+' where F_tiOrderType = 0 and F_iOrderID in ('+sDetailsID+') ');
            end
            else
            if iOrderType = c_xsx then
            begin
//            SQL.Text := 'Update BI_SellOrderDetails set F_iFktgzt='+IntToStr(iFktgzt)+',F_dFkrq=getdate(),F_iFkrID='+IntToStr(LoginData.m_iUserID)+' where F_iDetailsID in ('+sDetailsID+')';
              SQL.Text := 'Update BI_SellOrderDetails set F_iFktgzt='+IntToStr(iFktgzt)+',F_dFkrq=getdate(),F_iFkrID='+IntToStr(LoginData.m_iUserID)+',F_iTgzt='+IntToStr(cbb_llzt.ItemIndex-1)+',F_dCzrq=getdate() where F_iDetailsID in ('+sDetailsID+') ';
              SQL.Add(' Update DO_OrderPicDate_Log set '+sCzrqFieldName+'=getdate(),'+sCzrFieldName+'='+IntToStr(LoginData.m_iUserID)+' where F_tiOrderType = 1 and F_iOrderID in ('+sDetailsID+') ');
            end;
            ExecSQL;
          end;
//          DM_DataBase.WriteSynLog(DM_DataBase.ADO_DataRec.SQL.Text);   //记录日志
          zStr := zStr +sSpbm+#13#10;
          DM_DataBase.Con_YDPrint.CommitTrans;
          Self.Close;
        except
          on E: Exception do
          begin
            DM_DataBase.Con_YDPrint.RollbackTrans;
            Application.MessageBox(PChar('更新失败,'+e.Message),'提示',MB_ICONINFORMATION);
            Exit;
          end;
        end;                            
      end else
      begin
        Str := '产品编号：'+sSpbm+' 反馈失败,失败原因:'+IntToStr(iRec);
        Application.MessageBox(PChar(Str),'提示',MB_ICONINFORMATION);
      end;
    end;
  end;
  if zStr <> '' then
  begin
    Str := '产品编号：'+#13#10+zStr+' 反馈成功';
    Application.MessageBox(PChar(Str),'提示',MB_ICONINFORMATION);
  end;
end;

end.
