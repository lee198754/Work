unit uOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, iGrid, ComCtrls, RzListVw,
  RzGroupBar, RzPanel, RzSplit, ImgList, ADODB;

type
  TFrm_OrderList = class(TForm)
    RzSizePanel1: TRzSizePanel;
    Panel2: TPanel;
    stg_list: Ti_StgEdit;
    Panel1: TPanel;
    btn_ok: TButton;
    btn_close: TButton;
    RzGroupBar1: TRzGroupBar;
    RzGroup1: TRzGroup;
    lv_dd: TRzListView;
    ImageList1: TImageList;
    edt_Temp: TEdit;
    cb_Temp: TCheckBox;
    btn_hdrl: TButton;
    btn_ddth: TButton;
    procedure FormShow(Sender: TObject);
    procedure lv_ddColumnClick(Sender: TObject; Column: TListColumn);
    procedure lv_ddCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lv_ddMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_okClick(Sender: TObject);
    procedure btn_hdrlClick(Sender: TObject);
    procedure edt_TempExit(Sender: TObject);
    procedure stg_listLinkClick(Sender: TObject; ACol, ARow: Integer);
    procedure btn_ddthClick(Sender: TObject);
    procedure stg_listSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    { Private declarations }
    procedure p_LvToStg(Item: TListItem);
    //存入兑奖号段数组
    function SetaRJHD_old(iApartID: Integer;sZH, sRJHDQ, sRJHDZ: string): Boolean;
    function SetaRJHD(iApartID: Integer;sZH, sRJHDQ, sRJHDZ, sCPBH: string): Boolean;
    function CreateRJHD(sZH:string): string;  //生成兑奖号段,返回000001;001000
  public
    { Public declarations }
    vActionType: integer;       {c_WorkOrder_Select,c_WorkOrder_Modify,c_WorkOrder_KD}
    vGroup: Integer;
  end;

var
  Frm_OrderList: TFrm_OrderList;

implementation

uses
  uPub_Type, uPub_Func, uPub_Text, PubStr, uFrm_WorkOrder_RJHD, uDM_DataBase, uFrm_WorkOrder_DDTH;

{$R *.dfm}

procedure TFrm_OrderList.FormShow(Sender: TObject);
var
  i, j, n: integer;
begin
  if vActionType = c_WorkOrder_Select then
  begin
    lv_dd.OnColumnClick := nil;
    lv_dd.OnMouseDown := nil;
    lv_dd.Enabled := False;
    btn_ok.Enabled := False;
    edt_Temp.ReadOnly := True;
    btn_ddth.Enabled := False;
  end;
  SetLength(aTempRJHD,Length(aRJHD));
  for i := 0 to Length(aRJHD) -1 do
  begin
    aTempRJHD[i] := aRJHD[i];
  end;
  //aTempRJHD := Copy(aRJHD,0,Length(aRJHD));
  stg_list.Clear();
  stg_list.ColBuddy[c_List_XZ]    := 'cb_Temp';
  stg_list.ColBuddy[c_List_BCYL]  := 'edt_Temp';
  stg_list.ColBuddy[c_List_ZH]    := 'edt_Temp';
  stg_list.ColBuddy[c_List_RJHDQ] := 'edt_Temp';
  stg_list.ColBuddy[c_List_RJHDZ] := 'edt_Temp';
  stg_list.ColBuddy[c_List_BZ]    := 'edt_Temp';
  stg_list.ColBuddy[c_List_KHMC ] := 'edt_Temp';
  stg_list.ColBuddy[c_List_CPBH ] := 'edt_Temp';
  stg_list.ColBuddy[c_List_YZTMC] := 'edt_Temp';
  stg_list.ColBuddy[c_List_SYYL ] := 'edt_Temp';

  //stg_list.ColWidths[c_List_DHDLR] :=  0;
  lv_dd.Items.Clear;
  n := 0;
  for i := 0 to Length(OrderData) - 1 do
  begin
    lv_dd.Items.Add.Caption := '';
    lv_dd.Items.Item[lv_dd.Items.Count - 1].SubItems.Add(OrderData[i].m_sCPBH);
    if (OrderData[i].m_iGroupID > 0 ) and (OrderData[i].m_iGroupID <> vGroup) then
    begin
      lv_dd.Items.Item[lv_dd.Items.Count - 1].SubItems.Add(IntToStr(OrderData[i].m_iGroupID));
    end else
      lv_dd.Items.Item[lv_dd.Items.Count - 1].SubItems.Add('');

    lv_dd.Items.Item[lv_dd.Items.Count - 1].SubItems.Add(IntToStr(OrderData[i].m_iApartID));
    if OrderData[i].m_iGroupID=vGroup then
    begin
      if  Trim(stg_list.Cells[c_List_ApartID,stg_list.RowCount-1]) <> '' then
        stg_list.RowCount := stg_list.RowCount +1;
      lv_dd.Items.Item[lv_dd.Items.Count - 1].Checked := True;
      Inc(n);
      stg_list.Cells[c_List_XZ,n] := '√';
      stg_list.Cells[c_List_KHMC,n] := OrderData[i].m_sKhmc;
      stg_list.Cells[c_List_CPBH,n] := OrderData[i].m_sCPBH;
      stg_list.Cells[c_List_YZTMC,n] := OrderData[i].m_sYztmc;
      stg_list.Cells[c_List_SYYL,n] := FloatToStr(OrderData[i].m_iSyyl);
      //stg_list.Cells[c_List_YL,n] := FloatToStr(OrderData[i].m_iYl);
      stg_list.Cells[c_List_BCYL,n] := IntToStr(OrderData[i].m_iBCYL);
      stg_list.Cells[c_List_ZH,n] := OrderData[i].m_sZH;
      stg_list.Cells[c_List_RJHDQ,n] := OrderData[i].m_sRJHDQ;
      stg_list.Cells[c_List_RJHDZ,n] := OrderData[i].m_sRJHDZ;
      stg_list.Cells[c_List_BZ,n] := OrderData[i].m_sBZ;
      stg_list.Cells[c_List_ApartID,n] := IntToStr(OrderData[i].m_iApartID);
      stg_list.Cells[c_List_DHDLR,n] := '更多';
      stg_list.CellsLink[c_List_DHDLR,n] := '更多';
    end;
{    for j := 0 to Length(OrderGroup) - 1 do
    begin
      if (OrderGroup[j].m_iGroupID=vGroup) and (OrderData[i].m_iApartID = OrderGroup[j].m_iApartID) then
      begin
        if  Trim(stg_list.Cells[c_List_ApartID,stg_list.RowCount-1]) <> '' then
          stg_list.RowCount := stg_list.RowCount +1;
        lv_dd.Items.Item[lv_dd.Items.Count - 1].Checked := True;
        Inc(n);
        stg_list.Cells[c_List_XZ,n] := '√';
        stg_list.Cells[c_List_KHMC,n] := OrderData[i].m_sKhmc;
        stg_list.Cells[c_List_CPBH,n] := OrderData[i].m_sCPBH;
        stg_list.Cells[c_List_SYYL,n] := FloatToStr(OrderData[i].m_iSyyl);
        stg_list.Cells[c_List_YL,n] := FloatToStr(OrderData[i].m_iYl);
        stg_list.Cells[c_List_ZH,n] := OrderData[j].m_sZH;
        stg_list.Cells[c_List_RJHDQ,n] := OrderData[j].m_sRJHDQ;
        stg_list.Cells[c_List_RJHDZ,n] := OrderData[j].m_sRJHDZ;
        stg_list.Cells[c_List_ApartID,n] := IntToStr(OrderData[i].m_iApartID);
        Break;
      end;
    end;   }
  end;

  stg_list.ColWidths[c_List_XZ] := 0;
  stg_list.ColWidths[c_List_ApartID] := 0;
end;

procedure TFrm_OrderList.lv_ddColumnClick(Sender: TObject;
  Column: TListColumn);
var
  i: Integer;
  bQx: Boolean;
begin
  if Column.Caption = '选择' then
  begin
    bQx := False;
    for i := 0 to TRzListView(Sender).Items.Count -1 do
    begin
      if Trim(TRzListView(Sender).Items[i].SubItems.Strings[c_LV_Group]) <> '' then
        Continue;
      if not TRzListView(Sender).Items[i].Checked then
      begin
        bQx := True;
        Break                                             
      end;
    end;
    if bQx then
    begin
      for i := 0 to TRzListView(Sender).Items.Count -1 do
      begin
        if Trim(TRzListView(Sender).Items[i].SubItems.Strings[c_LV_Group]) = '' then
        begin
          TRzListView(Sender).Items[i].Checked := True;
          p_LvToStg(TRzListView(Sender).Items[i]);
        end;
      end;
    end else
    begin
      for i := 0 to TRzListView(Sender).Items.Count -1 do
      begin
        TRzListView(Sender).Items[i].Checked := False;
        p_LvToStg(TRzListView(Sender).Items[i]);
      end;
    end;
  end else
  begin
    TRzListView(Sender).CustomSort(@RzCustomSortProc,Column.Index)
  end;
end;

procedure TFrm_OrderList.lv_ddCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if (Item.Index mod 2) = 0 then
    Sender.Canvas.Brush.Color := $00F0FFF0//clWhite
  else
    Sender.Canvas.Brush.Color := $00F2F2F2;//$00EBEBEB;
  LVDrawItem(lv_dd, Item, State, DefaultDraw);

end;

procedure TFrm_OrderList.lv_ddMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: integer;
begin
  if (X <= 20) then
  begin
    if Assigned(TRzListView(Sender).GetItemAt(X,Y)) then
      TRzListView(Sender).ItemIndex := TRzListView(Sender).GetItemAt(X,Y).Index;
  end;
  if not Assigned(TRzListView(Sender).Selected) then
  begin
    if (Button = mbleft) then
    begin
      for i := 0 to TRzListView(Sender).Items.Count -1 do
      begin
        if Trim(TRzListView(Sender).Items.Item[i].SubItems.Strings[c_LV_Group]) = '' then
           p_LvToStg(TRzListView(Sender).Items.Item[i]);
      end;
    end;
    Exit;
  end;
  if (Button = mbleft) and (X > 20) then
  begin
    TRzListView(Sender).Selected.Checked := not TRzListView(Sender).Selected.Checked;
    if Trim(TRzListView(Sender).Selected.SubItems.Strings[c_LV_Group]) = '' then
    begin
      p_LvToStg(TRzListView(Sender).Selected);
    end;
  end;
  if (Button = mbleft) then
  begin
    for i := 0 to TRzListView(Sender).Items.Count -1 do
    begin
      if Trim(TRzListView(Sender).Items.Item[i].SubItems.Strings[c_LV_Group]) <> '' then
        TRzListView(Sender).Items.Item[i].Checked := False
      else
        p_LvToStg(TRzListView(Sender).Items.Item[i]);
    end;
  end;
end;

procedure TFrm_OrderList.p_LvToStg(Item: TListItem);
var
  i, j, k, n: integer;
  sApartID: string;
  bCheck, bInsert: Boolean;       {bCheck:是否已选择,bInsert:是否要插入}
  str, sCPBH: string;
  QH: string; //区号
  sCode: string;
begin
  sApartID := Item.SubItems.Strings[c_LV_ApartID];
  bCheck := False;
  for i := 1 to stg_list.RowCount -1 do
  begin
    if  Trim(stg_list.Cells[c_List_ApartID,i]) = Trim(sApartID) then
    begin
      bCheck := True;         //已选择
      k := i;
      Break;
    end;
  end;
  n := Item.Index;
  if Item.Checked then
  begin
    if not bCheck then
    begin
      if  Trim(stg_list.Cells[c_List_ApartID,stg_list.RowCount-1]) <> '' then
        stg_list.RowCount := stg_list.RowCount+1;
      i := stg_list.RowCount -1;
      stg_list.Cells[c_List_KHMC,i] := OrderData[n].m_sKhmc;
      stg_list.Cells[c_List_CPBH,i] := OrderData[n].m_sCPBH;
      stg_list.Cells[c_List_YZTMC,i] := OrderData[n].m_sYztmc;
      stg_list.Cells[c_List_SYYL,i] := FloatToStr(OrderData[n].m_iSyyl);
      //stg_list.Cells[c_List_YL,i] := FloatToStr(OrderData[n].m_iYl);
      //stg_list.Cells[c_List_BCYL,i] := OrderData[n].m_sSl;
      if (OrderData[n].m_iBCYL = 0) and (vActionType = c_WorkOrder_KD) then
        stg_list.Cells[c_List_BCYL,i] := FloatToStr(OrderData[n].m_iSyyl)
      else
        stg_list.Cells[c_List_BCYL,i] := IntToStr(OrderData[n].m_iBCYL);
      stg_list.Cells[c_List_ZH,i] := OrderData[n].m_sZH;
      stg_list.Cells[c_List_RJHDQ,i] := OrderData[n].m_sRJHDQ;
      stg_list.Cells[c_List_RJHDZ,i] := OrderData[n].m_sRJHDZ;
      stg_list.Cells[c_List_BZ,i] := OrderData[n].m_sBZ;
      stg_list.Cells[c_List_ApartID,i] := IntToStr(OrderData[n].m_iApartID);
      stg_list.Cells[c_List_DHDLR,i] := '更多';
      stg_list.CellsLink[c_List_DHDLR,i] := '更多';
      bInsert := True;
      for j := 0 to Length(OrderGroup) -1 do
      begin
        if OrderGroup[j].m_iGroupID = -1 then
        begin
          OrderGroup[j].m_sCPBH := OrderData[n].m_sCPBH;
          OrderGroup[j].m_sZH := OrderData[n].m_sZH;
          OrderGroup[j].m_sRJHDQ := OrderData[n].m_sRJHDQ;
          OrderGroup[j].m_sRJHDZ := OrderData[n].m_sRJHDZ;
          OrderGroup[j].m_sBZ := OrderData[n].m_sBZ;
          OrderGroup[j].m_iApartID := OrderData[n].m_iApartID;
          OrderGroup[j].m_iGroupID := vGroup;
          bInsert := False;
          Break;
        end;
      end;
      if bInsert  then
      begin
        SetLength(OrderGroup,Length(OrderGroup)+1);
        OrderGroup[Length(OrderGroup)-1].m_sCPBH := OrderData[n].m_sCPBH;
        OrderGroup[Length(OrderGroup)-1].m_sZH := OrderData[n].m_sZH;
        OrderGroup[Length(OrderGroup)-1].m_sRJHDQ := OrderData[n].m_sRJHDQ;
        OrderGroup[Length(OrderGroup)-1].m_sRJHDZ := OrderData[n].m_sRJHDZ;
        OrderGroup[Length(OrderGroup)-1].m_sBZ := OrderData[n].m_sBZ;
        OrderGroup[Length(OrderGroup)-1].m_iApartID := OrderData[n].m_iApartID;
        OrderGroup[Length(OrderGroup)-1].m_iGroupID := vGroup;
      end;
    end;
  end else
  begin
    if bCheck then
    begin
      stg_list.p_DelRow(k);
      for j := 0 to Length(OrderGroup) -1 do
      begin
        if (OrderGroup[j].m_iGroupID = vGroup) and (OrderGroup[j].m_iApartID = StrToNum(sApartID) )  then
        begin
          OrderGroup[j].m_iGroupID := -1;
          Break;
        end;
      end;
    end;
  end;

  //发布单位加入备注
  if vActionType = c_WorkOrder_KD then
  begin
    QH := '';
    sCPBH := '';
    for i := 1 to  stg_list.RowCount -1 do
    begin
      if (Trim(stg_list.Cells[c_List_CPBH,i]) <> '') and (not SameText(sCPBH,StrLeft(stg_list.Cells[c_List_CPBH,i],17)) ) then
      begin
        sCPBH := StrLeft(stg_list.Cells[c_List_CPBH,i],17);
        QH := Copy(stg_list.Cells[c_List_CPBH,i],4,4);
        for j := 0 to Length(aDeclareNumbers) -1 do
        begin
          sCode := aDeclareNumbers[j].m_sCode;
          if aDeclareNumbers[j].m_iFlag = 2 then
          begin
            if QH = sCode then
            begin
              str := aDeclareNumbers[j].m_sPlaceName;
              if Pos('发布',stg_list.Cells[c_List_BZ,i])= 0 then
              begin
                if Trim(stg_list.Cells[c_List_BZ,i]) <> '' then
                  stg_list.Cells[c_List_BZ,i] := Format('%s市邮政函件局发布 %s',[str,stg_list.Cells[c_List_BZ,i]])
                else
                  stg_list.Cells[c_List_BZ,i] := Format('%s市邮政函件局发布',[str]);
              end;
              Break;
            end;
          end else
          if aDeclareNumbers[j].m_iFlag = 1 then
          begin
            if Length(sCode)=2 then
              sCode := sCode + '00';
            if QH = sCode then
            begin
              str := aDeclareNumbers[j].m_sPlaceName;
              if Pos('发布',stg_list.Cells[c_List_BZ,i])= 0 then
              begin
                if Trim(stg_list.Cells[c_List_BZ,i]) <> '' then
                  stg_list.Cells[c_List_BZ,i] := Format('%s省邮政函件局发布 %s',[str,stg_list.Cells[c_List_BZ,i]])
                else
                  stg_list.Cells[c_List_BZ,i] := Format('%s省邮政函件局发布',[str]);
              end;
              Break;
            end;
           end;
        end;
      end;
    end;
  end;    

  //客户名称加入备注
{  for i := 1 to  stg_list.RowCount -1 do
  begin
    if (Trim(stg_list.Cells[c_List_KHMC,i]) <> '') and (not SameText(str,stg_list.Cells[c_List_KHMC,i]) ) then
    begin
      str := stg_list.Cells[c_List_KHMC,i];
      stg_list.Cells[c_List_BZ,i] := str;
    end;
  end;   }


end;

procedure TFrm_OrderList.btn_okClick(Sender: TObject);
var
  i, j: integer;
  bCheck: Boolean;
  aApartID: array of string;
  sZH,sRJHDQ,sRJHDZ: string;
  aCheckRJHD: TArrRJHD;
  str: string;
begin
  if edt_Temp.Visible then
    edt_TempExit(nil);
{  SetLength(aRJHD,Length(aTempRJHD));
  for i := 0 to Length(aTempRJHD) -1 do
  begin
    aRJHD[i] := aTempRJHD[i];
  end;  }
  SetLength(aTempRJHD,0);
  aTempRJHD := aRJHD;
  for i := 0 to Length(OrderData) -1 do
  begin
    if OrderData[i].m_iGroupID = vGroup then
      OrderData[i].m_iGroupID := -1;
  end;
  for i := 0 to Length(aTempRJHD) -1 do
  begin
    if aTempRJHD[i].m_iGroupID = vGroup then
      aTempRJHD[i].m_iGroupID := -1;
  end;
  for i := 1 to stg_list.RowCount -1 do
  begin
    for j := 0 to Length(OrderData) -1 do
    begin
      if OrderData[j].m_iApartID = StrToNum(stg_list.Cells[c_List_ApartID,i])  then
      begin
        OrderData[j].m_iXH := i;
        OrderData[j].m_iGroupID := vGroup;
        OrderData[j].m_iBCYL := StrToNum(stg_list.Cells[c_List_BCYL,i]);
        OrderData[j].m_sSl := StrToNum(stg_list.Cells[c_List_BCYL,i]) /10000;
        OrderData[j].m_sWJFSL := StrToNum(stg_list.Cells[c_List_BCYL,i]) /10000;
        OrderData[j].m_sZH := stg_list.Cells[c_List_ZH,i];
        OrderData[j].m_sRJHDQ := stg_list.Cells[c_List_RJHDQ,i];
        OrderData[j].m_sRJHDZ := stg_list.Cells[c_List_RJHDZ,i];
        OrderData[j].m_sBZ := stg_list.Cells[c_List_BZ,i];
        SetaRJHD(OrderData[j].m_iApartID,OrderData[j].m_sZH,OrderData[j].m_sRJHDQ,OrderData[j].m_sRJHDZ,OrderData[j].m_sCPBH);
        Break;
      end;
    end;

    for j := 0 to Length(aTempRJHD) -1 do
    begin
      if aTempRJHD[j].m_iApartID = StrToNum(stg_list.Cells[c_List_ApartID,i])  then
      begin
        aTempRJHD[j].m_iGroupID := vGroup;
        //SetaRJHD(aTempRJHD[j].m_iApartID,stg_list.Cells[c_List_ZH,i],stg_list.Cells[c_List_RJHDQ,i]
        //  ,stg_list.Cells[c_List_RJHDZ,i]);
        Break;
      end;
    end;

   { bCheck := False;
    for j := 0 to Length(aRJHD) -1 do
    begin
      if (aRJHD[j].m_iApartID = StrToNum(stg_list.Cells[c_List_ApartID,i])) and (aRJHD[j].m_sZH = stg_list.Cells[c_List_ZH,i])
        and (aRJHD[j].m_sRJHDQ = stg_list.Cells[c_List_RJHDQ,i]) and (aRJHD[j].m_sRJHDZ = stg_list.Cells[c_List_RJHDZ,i]) then
      begin
        bCheck := True;
      end;
    end;
    if not bCheck then
    begin
      SetLength(aRJHD,Length(aRJHD)+1);
      aRJHD[Length(aRJHD)-1].m_sZH := stg_list.Cells[c_List_ZH,i];
      aRJHD[Length(aRJHD)-1].m_sRJHDQ := stg_list.Cells[c_List_RJHDQ,i];
      aRJHD[Length(aRJHD)-1].m_sRJHDZ := stg_list.Cells[c_List_RJHDZ,i];
      aRJHD[Length(aRJHD)-1].m_iApartID := StrToNum(stg_list.Cells[c_List_ApartID,i]);
    end;     }


    bCheck := False;
    for j := 0 to Length(OrderGroup) -1 do
    begin
      if OrderGroup[j].m_iApartID = StrToNum(stg_list.Cells[c_List_ApartID,i]) then
      begin
        if OrderGroup[j].m_iGroupID <> vGroup then
          OrderGroup[j].m_iGroupID := vGroup;
        OrderGroup[j].m_sBCYL := stg_list.Cells[c_List_BCYL,i];
        OrderGroup[j].m_sZH := stg_list.Cells[c_List_ZH,i];
        OrderGroup[j].m_sRJHDQ := stg_list.Cells[c_List_RJHDQ,i];
        OrderGroup[j].m_sRJHDZ := stg_list.Cells[c_List_RJHDZ,i];
        OrderGroup[j].m_sBZ := stg_list.Cells[c_List_BZ,i];
        bCheck := True;
        Break;
      end;
    end;
    if not bCheck then
    begin
      SetLength(OrderGroup,Length(OrderGroup)+1);
      OrderGroup[Length(OrderGroup)-1].m_sBCYL := stg_list.Cells[c_List_BCYL,i];
      OrderGroup[Length(OrderGroup)-1].m_sCPBH := stg_list.Cells[c_List_CPBH,i];
      OrderGroup[Length(OrderGroup)-1].m_sYZTMC := stg_list.Cells[c_List_YZTMC,i];
      OrderGroup[Length(OrderGroup)-1].m_sZH := stg_list.Cells[c_List_ZH,i];
      OrderGroup[Length(OrderGroup)-1].m_sRJHDQ := stg_list.Cells[c_List_RJHDQ,i];
      OrderGroup[Length(OrderGroup)-1].m_sRJHDZ := stg_list.Cells[c_List_RJHDZ,i];
      OrderGroup[Length(OrderGroup)-1].m_iApartID := StrToNum(stg_list.Cells[c_List_ApartID,i]);
      OrderGroup[Length(OrderGroup)-1].m_sBZ := stg_list.Cells[c_List_BZ,i];
      OrderGroup[Length(OrderGroup)-1].m_iGroupID := vGroup;
    end;
  end;
  str := '';
  aCheckRJHD:=f_CheckRJHD(aTempRJHD);
  if Length(aCheckRJHD) > 0 then
  begin
    for i := 0 to Length(aCheckRJHD)-1 do
    begin
      str := str + Format('与%s %s %s-%s 重复'+#13#10 ,
        [aCheckRJHD[i].m_sCPBH,aCheckRJHD[i].m_sZH,aCheckRJHD[i].m_sRJHDQ,aCheckRJHD[i].m_sRJHDZ]) ;
    end;
    p_MessageBoxDlg(str);
    Exit;
  end;
  aRJHD := aTempRJHD;
  ModalResult := mrOk;
end;

procedure TFrm_OrderList.btn_hdrlClick(Sender: TObject);
var
  i: integer;
  bStart: Boolean;
  sZH, sRJHDQ, sRJHDZ: string;
begin
  if edt_Temp.Visible then
    edt_TempExit(nil);
  bStart := False;
  for i := 1 to stg_list.RowCount -1 do
  begin
    if not bStart then
    begin
      if (stg_list.Cells[c_List_ZH,i] <> '') and (Pos(',',stg_list.Cells[c_List_ZH,i])=0) then
      begin
        sZH := stg_list.Cells[c_List_ZH,i];
        sRJHDQ := stg_list.Cells[c_List_RJHDQ,i];
        sRJHDZ := stg_list.Cells[c_List_RJHDZ,i];
        if Trim(stg_list.Cells[c_List_BCYL,i]) = '' then
        begin
          if  (Trim(sRJHDQ) = '') or (Trim(sRJHDZ)='') then
          begin
            if StrToNum(stg_list.Cells[c_List_SYYL,i]) >= 0 then
              stg_list.Cells[c_List_BCYL,i] := stg_list.Cells[c_List_SYYL,i]
          end else
            stg_list.Cells[c_List_BCYL,i] := StrToNum(sRJHDZ) - StrToNum(sRJHDQ) + 1;
        end;
        bStart := True;
      end;
      Continue;
    end;
    if StrToNum(stg_list.Cells[c_List_BCYL,i]) = 0 then
    begin
      if StrToNum(stg_list.Cells[c_List_SYYL,i]) >= 0 then
        stg_list.Cells[c_List_BCYL,i] := stg_list.Cells[c_List_SYYL,i];
    end;
    if StrToNum(stg_list.Cells[c_List_BCYL,i]) > 0 then
    begin
      stg_list.Cells[c_List_ZH,i] := sZH;
      sRJHDQ := StrToNum(sRJHDZ) + 1;
      stg_list.Cells[c_List_RJHDQ,i] := StrRight('000000'+sRJHDQ,6);
      sRJHDZ := sRJHDQ + StrToNum(stg_list.Cells[c_List_BCYL,i]) -1;
      stg_list.Cells[c_List_RJHDZ,i] := StrRight('000000'+sRJHDZ,6);
    end else
    begin
      p_MessageBoxDlg('请先输入本次印量!');
      Exit;
    end;

  end;
  if not bStart then
  begin
    p_MessageBoxDlg('请先输入一组有效数据!')
  end;

end;

procedure TFrm_OrderList.edt_TempExit(Sender: TObject);
var
  str, sRJHDQ, sRJHDZ: string;
begin
  str := TEdit(Sender).Text;
//  if (stg_list.Col in [c_List_ZH])  and (Trim(str) <> '')
//    and (Trim(stg_list.Cells[c_List_RJHDZ,stg_list.Row]) = '') and (IsNum(stg_list.Cells[c_List_BCYL,stg_list.Row])) then
//  begin
//    sRJHDQ := CreateRJHD(Trim(str));
//    if sRJHDQ = '' then sRJHDQ :='000001';
//    stg_list.Cells[c_List_RJHDQ,stg_list.Row] := sRJHDQ;
//    sRJHDZ := StrToNum(sRJHDQ) + StrToNum(stg_list.Cells[c_List_BCYL,stg_list.Row]) -1;
//    stg_list.Cells[c_List_RJHDZ,stg_list.Row] := StrRight('000000'+sRJHDZ,6);
//  end;
  if stg_list.Col in [c_List_RJHDQ,c_List_RJHDZ] then
  begin
    if Trim(str) <> '' then
      TEdit(Sender).Text := StrRight('000000'+str,6);
  end;
  if (stg_list.Col in [c_List_RJHDQ]) and (Trim(str) <> '')
    and (Trim(stg_list.Cells[c_List_RJHDZ,stg_list.Row]) = '') and (IsNum(stg_list.Cells[c_List_BCYL,stg_list.Row]))  then
  begin
    sRJHDZ := StrToNum(str) + StrToNum(stg_list.Cells[c_List_BCYL,stg_list.Row]) -1;
    stg_list.Cells[c_List_RJHDZ,stg_list.Row] := StrRight('000000'+sRJHDZ,6);
  end;
end;

procedure TFrm_OrderList.stg_listLinkClick(Sender: TObject; ACol,
  ARow: Integer);
var
  i, iApartID: Integer;
  bCheck: Boolean;
  sZH, sRJHDQ ,sRJHDZ: string;
begin
  if ACol = c_List_DHDLR then
  begin
    iApartID := StrToNum(stg_list.Cells[c_List_ApartID,ARow]);
    Frm_WorkOrder_RJHD := TFrm_WorkOrder_RJHD.Create(Self);
    {bCheck := False;
    for i := 0 to Length(aTempRJHD) -1 do
    begin
      if (aTempRJHD[i].m_iApartID = StrToNum(stg_list.Cells[c_List_ApartID,ARow])) and (aTempRJHD[i].m_sZH = stg_list.Cells[c_List_ZH,ARow])
        and (aTempRJHD[i].m_sRJHDQ = stg_list.Cells[c_List_RJHDQ,ARow]) and (aTempRJHD[i].m_sRJHDZ = stg_list.Cells[c_List_RJHDZ,ARow]) then
      begin
        bCheck := True;
      end;
    end;
    if not bCheck then
    begin
      SetLength(aTempRJHD,Length(aTempRJHD)+1);
      aTempRJHD[Length(aTempRJHD)-1].m_sZH := stg_list.Cells[c_List_ZH,ARow];
      aTempRJHD[Length(aTempRJHD)-1].m_sRJHDQ := stg_list.Cells[c_List_RJHDQ,ARow];
      aTempRJHD[Length(aTempRJHD)-1].m_sRJHDZ := stg_list.Cells[c_List_RJHDZ,ARow];
      aTempRJHD[Length(aTempRJHD)-1].m_iApartID := StrToNum(stg_list.Cells[c_List_ApartID,ARow]);
    end;     }

    sZH := stg_list.Cells[c_List_ZH,ARow];
    sRJHDQ :=stg_list.Cells[c_List_RJHDQ,ARow];
    sRJHDZ := stg_list.Cells[c_List_RJHDZ,ARow];
    Frm_WorkOrder_RJHD.stg_RJHD.RowCount := 2;
   // n := 0;
    for i := 1 to PosNum(sZH,',')+1 do
    begin
      //inc(n);
      Frm_WorkOrder_RJHD.stg_RJHD.RowCount := Frm_WorkOrder_RJHD.stg_RJHD.RowCount+1;
      Frm_WorkOrder_RJHD.stg_RJHD.Cells[0,i] := PosCopy(sZH,',',i);
      Frm_WorkOrder_RJHD.stg_RJHD.Cells[1,i] := PosCopy(sRJHDQ,',',i);
      Frm_WorkOrder_RJHD.stg_RJHD.Cells[2,i] := PosCopy(sRJHDZ,',',i);
    end;


    Frm_WorkOrder_RJHD.vApartID := iApartID;
    Frm_WorkOrder_RJHD.vActionType := Self.vActionType;
    Frm_WorkOrder_RJHD.vBCYL := StrToNum(stg_list.Cells[c_List_BCYL,ARow]);
    Frm_WorkOrder_RJHD.ShowModal;
    if Frm_WorkOrder_RJHD.vSucceed then
    begin
      sZH := '';
      sRJHDQ := '';
      sRJHDZ := '';
      with Frm_WorkOrder_RJHD do
      begin
        if (stg_RJHD.RowCount > 1) and (stg_RJHD.Cells[c_RJHD_ZH,2] <> '' ) then
        begin
          for i := 1 to stg_RJHD.RowCount -1 do
          begin
            if stg_RJHD.Cells[c_RJHD_ZH,i] = '' then Continue;
            sZH := sZH + ','+ stg_RJHD.Cells[c_RJHD_ZH,i];
            sRJHDQ := sRJHDQ + ','+ stg_RJHD.Cells[c_RJHD_RJHDQ,i];
            sRJHDZ := sRJHDZ + ','+ stg_RJHD.Cells[c_RJHD_RJHDZ,i];
          end;
          stg_list.Cells[c_List_ZH,ARow] := Copy(sZH,2,Length(sZH));
          stg_list.Cells[c_List_RJHDQ,ARow] := Copy(sRJHDQ,2,Length(sRJHDQ));
          stg_list.Cells[c_List_RJHDZ,ARow] := Copy(sRJHDZ,2,Length(sRJHDZ));
        end else
        if stg_RJHD.Cells[c_RJHD_ZH,1] <> ''  then
        begin
          stg_list.Cells[c_List_ZH,ARow] := stg_RJHD.Cells[c_RJHD_ZH,1];
          stg_list.Cells[c_List_RJHDQ,ARow] := stg_RJHD.Cells[c_RJHD_RJHDQ,1];
          stg_list.Cells[c_List_RJHDZ,ARow] := stg_RJHD.Cells[c_RJHD_RJHDZ,1];
        end;
      end;
    end;
    Frm_WorkOrder_RJHD.Free;

  end;
end;

function TFrm_OrderList.SetaRJHD_old(iApartID: Integer; sZH, sRJHDQ,
  sRJHDZ: string): Boolean;
var
  i, j, len: integer;
begin
  Result := False;
  for i := 0 to Length(aRJHD) -1 do
  begin
    if aRJHD[i].m_iApartID = iApartID then
    begin
      aRJHD[i].m_iApartID := -1;
    end;
  end;
  for i := 1 to PosNum(sZH,',') + 1 do
  begin
    Len := Length(aRJHD);
    for j := 0 to  Len -1 do
    begin
      if aRJHD[j].m_iApartID = -1 then
      begin
        aRJHD[j].m_sZH      := PosCopy(sZH,',',i);
        aRJHD[j].m_sRJHDQ   := PosCopy(sRJHDQ,',',i);
        aRJHD[j].m_sRJHDZ   := PosCopy(sRJHDZ,',',i);
        aRJHD[j].m_iApartID := iApartID;
        Break;
      end;
    end;
    if j <= len -1 then Continue;
    SetLength(aRJHD,Len+1);
    aRJHD[Len].m_sZH      := PosCopy(sZH,',',i);
    aRJHD[Len].m_sRJHDQ   := PosCopy(sRJHDQ,',',i);
    aRJHD[Len].m_sRJHDZ   := PosCopy(sRJHDZ,',',i);
    aRJHD[Len].m_iApartID := iApartID;
  end;
  Result := True;
end;



function TFrm_OrderList.SetaRJHD(iApartID: Integer; sZH, sRJHDQ,
  sRJHDZ,sCPBH: string): Boolean;
var
  i, j, k, len: integer;
begin
  Result := False;
  for i := 1 to PosNum(sZH,',') + 1 do
  begin
    Len := Length(aTempRJHD);
    for j := 0 to  Len -1 do
    begin
      if aTempRJHD[j].m_iApartID = iApartID then
      begin
        aTempRJHD[j].m_sZH      := PosCopy(sZH,',',i);
        aTempRJHD[j].m_sRJHDQ   := PosCopy(sRJHDQ,',',i);
        aTempRJHD[j].m_sRJHDZ   := PosCopy(sRJHDZ,',',i);
        Break;
      end;
    end;
    if j < len then Continue;
    SetLength(aTempRJHD,Len+1);
    aTempRJHD[Len].m_iApartID := iApartID;
    aTempRJHD[Len].m_sZH      := PosCopy(sZH,',',i);
    aTempRJHD[Len].m_sRJHDQ   := PosCopy(sRJHDQ,',',i);
    aTempRJHD[Len].m_sRJHDZ   := PosCopy(sRJHDZ,',',i);
    aTempRJHD[Len].m_sCPBH    := PosCopy(sCPBH,',',i);
  end;
  Result := True;
end;

function TFrm_OrderList.CreateRJHD(sZH: string): string;
var
  sSqlData, sRJHDQ, sRJHDZ: string;
  ADO_Rec:TADOQuery;
  iLen, i, j: Integer;
begin
  Result := '';
  sSqlData := ' select max(F_sRJHDZ) F_sRJHDZ from dbo.DO_WorkOrderDetGroupNum where F_sZH=''%s'' ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[sZH]);
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount>0) then
  begin
    sRJHDZ := ADO_Rec.FieldByName('F_sRJHDZ').AsString;
    iLen := Length(sRJHDZ);
    sRJHDZ := StrToNum(sRJHDZ)+1;
    Result := StrRight('000000'+sRJHDZ,iLen);
  end;
  for i := 1 to stg_list.RowCount -1 do
  begin
    if Trim(UpperCase(stg_list.Cells[c_List_ZH,i])) = Trim(UpperCase(sZH)) then
    begin
      sRJHDQ := stg_list.Cells[c_List_RJHDQ,i];
      sRJHDZ := stg_list.Cells[c_List_RJHDZ,i];
      if (Result <= StrToNum(sRJHDZ)) and (Result>=StrToNum(sRJHDQ)) then
      begin
        iLen := Length(sRJHDZ);
        sRJHDZ := StrToNum(sRJHDZ)+1;
        Result := StrRight('000000'+sRJHDZ,iLen);
      end;
    end;
  end;
  for i := 0 to Length(OrderData) -1 do
  begin
    if OrderData[i].m_iGroupID <> vGroup then
    begin
      for j := 0 to Length(aRJHD) -1 do
      begin
        if aRJHD[j].m_iApartID <> OrderData[i].m_iApartID then Continue;
        sRJHDQ := aRJHD[j].m_sRJHDQ;
        sRJHDZ := aRJHD[j].m_sRJHDZ;
        if (Result <= StrToNum(sRJHDZ)) and (Result>=StrToNum(sRJHDQ)) then
        begin
          iLen := Length(sRJHDZ);
          sRJHDZ := StrToNum(sRJHDZ)+1;
          Result := StrRight('000000'+sRJHDZ,iLen);
        end;
      end;
    end;
  end;


end;

procedure TFrm_OrderList.btn_ddthClick(Sender: TObject);
begin
  Frm_ddth := TFrm_ddth.Create(Self);
  Frm_ddth.pgc_ddth.TabIndex := 0;
  if Frm_ddth.ShowModal = mrok then
  begin
    FormShow(nil);
  end;
  Frm_ddth.Free;
end;

procedure TFrm_OrderList.stg_listSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if ACol in [c_List_XZ,c_List_BCYL,c_List_ZH,c_List_RJHDQ,c_List_RJHDZ,c_List_BZ] then
    edt_Temp.ReadOnly := False
  else
    edt_Temp.ReadOnly := True;
  if ACol in [c_List_ZH] then
    edt_Temp.CharCase := ecUpperCase
  else
    edt_Temp.CharCase := ecNormal;

end;

end.

