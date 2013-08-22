unit uBSTPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ButtonEdit, iComboBox, RzEdit,
  RzButton,ADODB, RM_Dataset, RM_RichEdit, RM_System, RM_Common, RM_Class;

const
  c_sh_Width = 250;
  c_sh_Height = 100;
  c_cbb_Width = 170;
  c_edt_Width = 170;
  c_edt_Left = 70;
  c_edt_Top = 56;
  c_cbb_Left = 70;
  c_cbb_Top = 16;

type
  TFrm_BSTPrint = class(TForm)
    mmo_bz: TRzMemo;
    lab_bz: TLabel;
    btn_ok: TRzButton;
    btn_print: TRzButton;
    RMDBDataSet1: TRMDBDataSet;
    btn_czbst: TRzButton;
    rmrprt_1_4: TRMReport;
    rmrprt_1_3: TRMReport;
    rmrprt_1_2: TRMReport;
    rmrprt_1_1: TRMReport;
    rmrprt_2_4: TRMReport;
    rmrprt_2_3: TRMReport;
    rmrprt_2_2: TRMReport;
    rmrprt_2_1: TRMReport;
    rmrprt_3_4: TRMReport;
    rmrprt_3_3: TRMReport;
    rmrprt_3_2: TRMReport;
    rmrprt_3_1: TRMReport;
    rmrprt_4_4: TRMReport;
    rmrprt_4_3: TRMReport;
    rmrprt_4_2: TRMReport;
    rmrprt_4_1: TRMReport;
    rmrprt_10_4: TRMReport;
    rmrprt_10_3: TRMReport;
    rmrprt_10_2: TRMReport;
    rmrprt_10_1: TRMReport;
    rmrprt_5_4: TRMReport;
    rmrprt_5_3: TRMReport;
    rmrprt_5_2: TRMReport;
    rmrprt_5_1: TRMReport;
    rmrprt_6_4: TRMReport;
    rmrprt_6_3: TRMReport;
    rmrprt_6_2: TRMReport;
    rmrprt_6_1: TRMReport;
    rmrprt_7_4: TRMReport;
    rmrprt_7_3: TRMReport;
    rmrprt_7_2: TRMReport;
    rmrprt_7_1: TRMReport;
    rmrprt_8_4: TRMReport;
    rmrprt_8_3: TRMReport;
    rmrprt_8_2: TRMReport;
    rmrprt_8_1: TRMReport;
    rmrprt_9_4: TRMReport;
    rmrprt_9_3: TRMReport;
    rmrprt_9_2: TRMReport;
    rmrprt_9_1: TRMReport;
    btn_Close: TRzButton;
    pan_jg: TPanel;
    tmr_close: TTimer;
    procedure btn_okClick(Sender: TObject);
    procedure btn_printClick(Sender: TObject);
    procedure btn_czbstClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure tmr_closeTimer(Sender: TObject);
  private
    { Private declarations }
    procedure FrameCreate(iLeft,iTop: Integer);
    procedure GetOrderList;
    procedure LoadData;
    procedure p_SetPrint(Rmrprt:TRMReport;sName, sValue: string);
    function p_GetPrint(Rmrprt:TRMReport;sName: string): string;
    function FindRmrprt: TRMReport;
    function p_AddArrBST:Boolean;
    function p_SaveBST: Boolean;
    function p_PrintBST: Boolean;
    function p_GetData: Boolean;
  public
    { Public declarations }
    vRow,vCol: integer;
    vClose: Boolean;
    vCplx: string;
    vYztmc: string;
    vBSTID: Integer;
    vBSTZS: integer;
    vBSTYS: integer;
    vGDH: string;
    vActionType: integer;
    vGroupID: integer;
    vWorkID: integer;
  end;

var
  Frm_BSTPrint: TFrm_BSTPrint;
  Shape: array of TShape;
  cbb: array of Ti_ComboBox;
  edt: array of Ti_TxtFilter;
  OrderList: TStrings;

implementation

uses
  uDM_DataBase, uPrint, uPub_Type, uPub_Func, uHBST, PubStr, uWorkOrder, uPub_Text;

{$R *.dfm}

procedure TFrm_BSTPrint.FormShow(Sender: TObject);
var
  i,j,iCount: integer;
  iWidth,iHeight,iTop,iLeft: Integer;
begin
  vClose := True;
  if Assigned(Frm_Print) then
  begin
    vBSTID:= Frm_Print.vBSTID;
    vBSTZS:= Frm_Print.vBSTZS;
    vBSTYS:= StrToNum(Frm_Print.edt_bsts.Text);
    vGDH:= Frm_Print.edt_gdh.Text;
    vActionType:= Frm_Print.vActionType;
    vWorkID:= Frm_Print.vWorkID;
  end;
  if Assigned(Frm_WorkOrder) then
  begin
    vBSTID := Frm_WorkOrder.vBSTID;
    vBSTZS := Frm_WorkOrder.ADO_WorkOrder.FieldByName('BSTZS').AsInteger;
    vBSTYS := Frm_WorkOrder.ADO_WorkOrder.FieldByName('BSTYS').AsInteger;
    vGDH := Frm_WorkOrder.edt_gdh.Text;
    //vActionType := Frm_WorkOrder.vActionType;
    vWorkID := Frm_WorkOrder.vWorkID;
    vGroupID := Frm_WorkOrder.ADO_WorkOrder.RecNo;
  end;
  if vBSTZS=0 then
  begin
    Frm_HBST := TFrm_HBST.Create(Self);
    Frm_HBST.ShowModal;
    if vClose then
    begin
      tmr_close.Enabled := True;
      Frm_HBST.Free;
      Exit;
    end;
    Frm_HBST.Free;
  end;
  if vActionType = c_WorkOrder_Select then
  begin
    btn_ok.Enabled := False;
    btn_czbst.Enabled := False;
    mmo_bz.ReadOnly := True;
  end;

{  for i := 0 to
    Shape: array of TShape;
  cbb: array of Ti_ComboBox;
  edt: array of Ti_TxtFilter;    }

  OrderList := TStringList.Create;
  GetOrderList;
  SetLength(Shape,0);
  SetLength(edt,0);
  SetLength(cbb,0);
  iCount := vRow*vCol;
  iWidth := c_sh_Width*vCol;
  iHeight := c_sh_Height*vRow;
  if Self.Width > iWidth then
    iLeft :=  (Self.Width - iWidth) div 2
  else
  begin
    iLeft := 30;
    Self.Width := iWidth + 60;
  end;
  iTop := 20;
  for i := 0 to vRow -1 do
  begin
    for j := 0 to vCol -1 do
      FrameCreate(iLeft+j*c_sh_Width,iTop+i*c_sh_Height);
  end;
  if vBSTZS >0 then begin
    //LoadData;
    p_GetData;
  end;
  lab_bz.Top := iHeight +40;
  mmo_bz.Top := iHeight +35;
  mmo_bz.Left := (Self.Width - mmo_bz.Width) div 2 ;
  lab_bz.Left := mmo_bz.Left -50;
  btn_ok.Top := mmo_bz.Top + mmo_bz.Height + 20;
  btn_ok.Left := (Self.Width - btn_ok.Width-32-btn_print.Width-32-btn_czbst.Width-32-btn_Close.Width) div 2 ;
  btn_print.Top := btn_ok.Top;
  btn_print.Left := btn_ok.Left+btn_ok.Width+32;
  btn_czbst.Top := btn_print.Top;
  btn_czbst.Left := btn_print.Left+btn_print.Width+32;
  btn_Close.Top := btn_czbst.Top;
  btn_Close.Left := btn_czbst.Left+btn_czbst.Width+32;
  pan_jg.top :=  btn_Close.Top + btn_Close.Height;
  OrderList.Free;
  VertScrollBar.Position := 0;
end;

procedure TFrm_BSTPrint.FrameCreate(iLeft,iTop: Integer);
var
  iLen: integer;
begin
  iLen := Length(Shape);
  SetLength(Shape,iLen+1);
  Shape[iLen] := TShape.Create(Self);
  Shape[iLen].Left := iLeft;
  Shape[iLen].Top := iTop;
  Shape[iLen].Height := c_sh_Height;
  Shape[iLen].Width := c_sh_Width;
  Shape[iLen].Parent := Self;
  iLen := Length(cbb);
  SetLength(cbb,iLen+1);
  cbb[iLen] := Ti_ComboBox.Create(Self);
  cbb[iLen].Left := iLeft+c_cbb_Left;
  cbb[iLen].Top := iTop+c_cbb_Top;
  cbb[iLen].Width := c_cbb_Width;
  cbb[iLen].LabelCaption := '产品编号：';
  cbb[iLen].Parent := Self;
  if OrderList.Count >0 then
    cbb[iLen].Items := OrderList;
  iLen := Length(edt);
  SetLength(edt,iLen+1);
  edt[iLen] := Ti_TxtFilter.Create(Self);
  edt[iLen].Left := iLeft+c_edt_Left;
  edt[iLen].Top := iTop+c_edt_Top;
  edt[iLen].Width := c_edt_Width;
  edt[iLen].LabelCaption := '说明：';
  edt[iLen].Parent := Self;
  if vActionType = c_WorkOrder_Select then
  begin
//    cbb[iLen].Enabled := False;
    edt[iLen].ReadOnly := True;
  end;
end;

procedure TFrm_BSTPrint.btn_okClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  iBSTID: Integer;  //版式图ID
  i, n: integer;
begin
  p_SaveBST;
  Exit;

  try
    try
      DM_DataBase.Con_YDPrint.BeginTrans;
      ADO_Rec := TADOQuery.Create(Self);
      DM_DataBase.GetTableData(ADO_Rec,'DO_WorkOrderMKPic','F_iID='+IntToStr(vBSTID));
      if ADO_Rec.RecordCount > 0 then
        ADO_Rec.Edit
      else
        ADO_Rec.Insert;
      ADO_Rec.FieldByName('F_iRow').AsInteger := vRow;
      ADO_Rec.FieldByName('F_iCol').AsInteger := vCol;
      ADO_Rec.FieldByName('F_sBZ').AsString := mmo_bz.Text;
      ADO_Rec.FieldByName('F_sCZR').AsString := LoginData.m_sUserName;
      ADO_Rec.FieldByName('F_dCZRQ').AsDateTime := Now;
      ADO_Rec.FieldByName('F_iZl').AsInteger := vBSTYS;
      ADO_Rec.Post;
      iBSTID := ADO_Rec.FieldByName('F_iID').AsInteger;
      if Assigned(Frm_Print) then
        Frm_Print.vBSTID := iBSTID;
      vBSTID := iBSTID;
      DM_DataBase.GetTableData(ADO_Rec,'DO_WorkOrderMKPicPrt','F_iBSTID='+IntToStr(iBSTID));
      if ADO_Rec.RecordCount > 0 then
      begin
        ADO_Rec.First;
        while not ADO_Rec.Eof do ADO_Rec.Delete;
      end;
      ClearOrderDataBSTS;
      n := 0;
      for i := 0 to Length(cbb)-1 do
      begin
        if Trim(cbb[i].Text) = '' then Continue;
        Inc(n);
        ADO_Rec.Insert;
        ADO_Rec.FieldByName('F_iRow').AsInteger := i div vCol;
        ADO_Rec.FieldByName('F_iCol').AsInteger := i mod vCol;
        ADO_Rec.FieldByName('F_iApartID').AsInteger := OrderData[cbb[i].ItemIndex].m_iApartID;
        ADO_Rec.FieldByName('F_sCPBH').AsString := OrderData[cbb[i].ItemIndex].m_sCPBH;
        OrderData[cbb[i].ItemIndex].m_iBSTS := OrderData[cbb[i].ItemIndex].m_iBSTS+1;
//        IncOrderDataBSTS(OrderData[cbb[i].ItemIndex].m_iApartID);
        ADO_Rec.FieldByName('F_sBZ').AsString := edt[i].Text;
        ADO_Rec.FieldByName('F_iBSTID').AsInteger := iBSTID;
        ADO_Rec.Post;
      end;
     { if vWorkID > 0 then
      begin
        DM_DataBase.GetTableData(ADO_Rec,'BI_WorkOrder','F_iID='+IntToStr(vWorkID));
        ADO_Rec.Edit;
        ADO_Rec.FieldByName('F_iBSTID').AsInteger := iBSTID;
        ADO_Rec.Post;
      end;             }
      if Assigned(Frm_Print) then
        Frm_Print.vBSTZS := n;
      vBSTZS := n;
      Application.MessageBox('成功','提示',MB_ICONINFORMATION);
      DM_DataBase.Con_YDPrint.CommitTrans;
      btn_print.Click;
    except
      on E: Exception do
      begin
        DM_DataBase.Con_YDPrint.RollbackTrans;
        Application.MessageBox(PChar(E.Message),'提示', MB_ICONINFORMATION);
        Exit;
      end;
    end;
  finally
    ADO_Rec.Free;
  end;
end;

procedure TFrm_BSTPrint.GetOrderList;
var
  ADO_Rec: TADOQuery;
  sCpbh, sKhmc: string;
  i, n, iApartID, iOrderType: integer;
begin
  OrderList.Clear;
//  if vWorkID =0 then Exit;
  if Length(OrderData) > 0 then
  begin
    for i := 0 to Length(OrderData) -1 do
    begin
      //OrderList.Add(OrderData[i].m_sCPBH);
      OrderList.Add(IntToStr(i)+'：'+OrderData[i].m_sCPBH);
    end;
  end else
  begin
    p_MessageBoxDlg('读取订单信息失败!'); 
    Close;
  end;    

end;

procedure TFrm_BSTPrint.LoadData;
var
  ADO_Rec: TADOQuery;
  i,n,k,iRow,iCol,iApartID: integer;
  sCpbh,sBz: string;
begin
  try
    ADO_Rec := TADOQuery.Create(Self);
    DM_DataBase.GetTableData(ADO_Rec,'DO_WorkOrderMKPicPrt','F_iBSTID='+IntToStr(vBSTID));
    //ADO_Rec := DM_DataBase.OpenQuery('select * from DO_WorkOrderMKPicPrt where F_iBSTID=%d',[vBSTID],True);
    if ADO_Rec.RecordCount >0 then
    begin
      ADO_Rec.First;
      while not ADO_Rec.Eof do
      begin
        iRow := ADO_Rec.FieldByName('F_iRow').AsInteger;
        iCol := ADO_Rec.FieldByName('F_iCol').AsInteger;
        iApartID := ADO_Rec.FieldByName('F_iApartID').AsInteger;
        sCpbh := ADO_Rec.FieldByName('F_sCPBH').AsString;
        sBz := ADO_Rec.FieldByName('F_sBZ').AsString;
        n :=  iRow*vCol + iCol;
        for i := 0 to Length(OrderData) do
        begin
          if OrderData[i].m_iApartID =iApartID then
          begin
            k := i;
            Break;
          end;
        end;
        cbb[n].ItemIndex := k;
        edt[n].Text := sBz;
        ADO_Rec.Next;
      end;
    end;
  finally
    ADO_Rec.Free;
  end;

end;

procedure TFrm_BSTPrint.btn_printClick(Sender: TObject);
var
//  rmr_Memo: TRMMemoView;
//  Page: TRMCustomPage;
  Rmrprt: TRMReport;
  AOD_Rec: TADOQuery;
  i,j,iRow,iCol: integer;
  str, sCpbh,sBz,sGdh, sKhmc: string;
  sMmoName,sMmoValue: string;
begin
  p_PrintBST;
  Exit;

{  rmr_Memo := TRMMemoView(RMCreateObject(rmgtMemo,''));
  rmr_Memo.Top := 10;
  rmr_Memo.LeftRightFrame := 20;
  rmr_Memo.Memo.Text := '3233';
  rmr_Memo.Visible := true;
  rmr_Memo.Name := '11';
//  RMReport1.Pages.Clear;

  Page.Objects.Add(rmr_Memo);
//  RMReport1.PrepareReport;
  RMReport1.ShowReport; }
  Rmrprt := FindRmrprt;
  if Rmrprt = nil then Exit;
  try
    AOD_Rec := TADOQuery.Create(Self);
    DM_DataBase.GetTableData(AOD_Rec,'DO_WorkOrderMKPicPrt','F_iBSTID='+IntToStr(vBSTID));
    if AOD_Rec.RecordCount >0 then
    begin
      AOD_Rec.First;
      while not AOD_Rec.Eof do
      begin
        iRow := AOD_Rec.FieldByName('F_iRow').AsInteger;
        iCol := AOD_Rec.FieldByName('F_iCol').AsInteger;
        sCpbh := AOD_Rec.FieldByName('F_sCPBH').AsString;
        sKhmc := FindOrderData(sCpbh).m_sKhmc;
        if Length(sKhmc) > 22 then
        begin
          str := sKhmc;
          sKhmc := StrLeft(sKhmc,22)+#13#10+strRight(sKhmc,Length(sKhmc)-22);
        end;
        sBz := AOD_Rec.FieldByName('F_sBZ').AsString;
        sMmoName := 'mmo_'+IntToStr(iRow+1)+'_'+IntToStr(iCol+1);
        sMmoValue := '    '+vCplx+'  '+vYztmc+#13#10+'编号：'+sCpbh+#13#10+'客户：'+sKhmc+#13#10+'说明：'+sBz;
        p_SetPrint(Rmrprt,sMmoName,sMmoValue);
        AOD_Rec.Next;
      end;
      for i := 1 to vRow do
      begin
        for j := 1 to vCol do
        begin
          sMmoName := 'mmo_'+IntToStr(i)+'_'+IntToStr(j);
          sMmoValue :=p_GetPrint(Rmrprt,sMmoName);
          if Trim(sMmoValue) ='批号:11-350101-13-0004-000' then
            p_SetPrint(Rmrprt,sMmoName,'');
        end;
      end;
      sGdh := vGDH;
      p_SetPrint(Rmrprt,'mmo_gdh','工单号：'+sGdh+' 的版式图');
      p_SetPrint(Rmrprt,'mmo_bz','备注：'+mmo_bz.Text);
      p_SetPrint(Rmrprt,'mmo_yl','本版共印： '+IntToStr(vBSTYS)+' 张');
      Rmrprt.PrepareReport;
      Rmrprt.ShowReport
    end else
    begin
      Application.MessageBox('请先保存,再进行打印!','提示',MB_ICONINFORMATION);
      Exit;
    end;

  finally
    AOD_Rec.Free;
  end;


end;

procedure TFrm_BSTPrint.p_SetPrint(Rmrprt:TRMReport;sName, sValue: string);
var
  rmMemo: TRMView;
begin
  rmMemo := Rmrprt.FindObject(sName);
  if rmMemo <> nil then
    TRMMemoView(rmMemo).DataField := sValue;
end;

function TFrm_BSTPrint.p_GetPrint(Rmrprt:TRMReport;sName: string): string;
var
  rmMemo: TRMView;
begin
  Result := '';
  rmMemo := Rmrprt.FindObject(sName);
  if rmMemo <> nil then
    Result := TRMMemoView(rmMemo).DataField;
end;
procedure TFrm_BSTPrint.btn_czbstClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(aBST) -1 do begin
    if aBST[i].m_iGroupID = vGroupID then begin
      aBST[i].m_iGroupID := -1;
    end;
  end;
  for i := 0 to Length(aBSTPrint) -1 do begin
    if aBSTPrint[i].m_iGroupID = vGroupID then begin
      aBSTPrint[i].m_iGroupID := -1;
    end;
  end;
  Exit;

//  Self.Visible := False;
  if vBSTID > 0 then
  begin
    with DM_DataBase.ADO_DataRec do
    begin
      Close;
      SQL.Clear;
      SQL.Add('delete DO_WorkOrderMKPicPrt where F_iBSTID='+ inttostr(vBSTID));
      ExecSQL;
    end;
  end;

//  FormShow(Self);                             
//  Self.Visible := True;
end;

function TFrm_BSTPrint.FindRmrprt: TRMReport;
begin
  Result := nil;
  case vRow of
    1:
      begin
        case vCol of
          1: Result := rmrprt_1_1;
          2: Result := rmrprt_1_2;
          3: Result := rmrprt_1_3;
          4: Result := rmrprt_1_4;
        end;
      end;
    2:
      begin
        case vCol of
          1: Result := rmrprt_2_1;
          2: Result := rmrprt_2_2;
          3: Result := rmrprt_2_3;
          4: Result := rmrprt_2_4;
        end;
      end;
    3:
      begin
        case vCol of
          1: Result := rmrprt_3_1;
          2: Result := rmrprt_3_2;
          3: Result := rmrprt_3_3;
          4: Result := rmrprt_3_4;
        end;
      end;
    4:
      begin
        case vCol of
          1: Result := rmrprt_4_1;
          2: Result := rmrprt_4_2;
          3: Result := rmrprt_4_3;
          4: Result := rmrprt_4_4;
        end;
      end;
    5:
      begin
        case vCol of
          1: Result := rmrprt_5_1;
          2: Result := rmrprt_5_2;
          3: Result := rmrprt_5_3;
          4: Result := rmrprt_5_4;
        end;
      end;
    6:
      begin
        case vCol of
          1: Result := rmrprt_6_1;
          2: Result := rmrprt_6_2;
          3: Result := rmrprt_6_3;
          4: Result := rmrprt_6_4;
        end;
      end;
    7:
      begin
        case vCol of
          1: Result := rmrprt_7_1;
          2: Result := rmrprt_7_2;
          3: Result := rmrprt_7_3;
          4: Result := rmrprt_7_4;
        end;
      end;
    8:
      begin
        case vCol of
          1: Result := rmrprt_8_1;
          2: Result := rmrprt_8_2;
          3: Result := rmrprt_8_3;
          4: Result := rmrprt_8_4;
        end;
      end;
    9:
      begin
        case vCol of
          1: Result := rmrprt_9_1;
          2: Result := rmrprt_9_2;
          3: Result := rmrprt_9_3;
          4: Result := rmrprt_9_4;
        end;
      end;
    10:
      begin
        case vCol of
          1: Result := rmrprt_10_1;
          2: Result := rmrprt_10_2;
          3: Result := rmrprt_10_3;
          4: Result := rmrprt_10_4;
        end;
      end;
   end;
end;

procedure TFrm_BSTPrint.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure TFrm_BSTPrint.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  VertScrollBar.Position := VertScrollBar.Position +40;
end;

procedure TFrm_BSTPrint.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  VertScrollBar.Position := VertScrollBar.Position -40;
end;



procedure TFrm_BSTPrint.tmr_closeTimer(Sender: TObject);
begin
  Self.Visible := False;
  Close;
end;

function TFrm_BSTPrint.p_SaveBST: Boolean;
var
  i, j, n: integer;
  bCheck: Boolean;
begin
//  if not IfCheck then Exit;
  p_AddArrBST;
  for i := 0 to Length(aBSTPrint) -1 do
  begin
    if aBSTPrint[i].m_iGroupID = vGroupID then
      aBSTPrint[i].m_iGroupID := -1;
  end;
  n := 0;
  for i := 0 to Length(cbb) -1 do
  begin
    if Trim(cbb[i].Text) = '' then Continue;
    Inc(n);
    bCheck := False;
    for j := 0 to  Length(aBSTPrint) -1 do
    begin
      if aBSTPrint[j].m_iGroupID = -1 then
      begin
        aBSTPrint[j].m_iRow := i div vCol;
        aBSTPrint[j].m_iCol := i mod vCol;
        aBSTPrint[j].m_iApartID := OrderData[cbb[i].ItemIndex].m_iApartID;
        aBSTPrint[j].m_sCPBH := OrderData[cbb[i].ItemIndex].m_sCPBH;
        OrderData[cbb[i].ItemIndex].m_iBSTS := OrderData[cbb[i].ItemIndex].m_iBSTS+1;
        aBSTPrint[j].m_sBZ := edt[i].Text;
        aBSTPrint[j].m_iGroupID := vGroupID;
        bCheck := True;
        Break;
      end;
    end;
    if not bCheck then
    begin
      SetLength(aBSTPrint,Length(aBSTPrint)+1);
      aBSTPrint[Length(aBSTPrint)-1].m_iRow := i div vCol;
      aBSTPrint[Length(aBSTPrint)-1].m_iCol := i mod vCol;
      aBSTPrint[Length(aBSTPrint)-1].m_iApartID := OrderData[cbb[i].ItemIndex].m_iApartID;
      aBSTPrint[Length(aBSTPrint)-1].m_sCPBH := OrderData[cbb[i].ItemIndex].m_sCPBH;
      OrderData[cbb[i].ItemIndex].m_iBSTS := OrderData[cbb[i].ItemIndex].m_iBSTS+1;
      aBSTPrint[Length(aBSTPrint)-1].m_sBZ := edt[i].Text;
      aBSTPrint[Length(aBSTPrint)-1].m_iGroupID := vGroupID;
    end;
  end;
  vBSTZS := n;
  Application.MessageBox('成功','提示',MB_ICONINFORMATION);
  btn_print.Click;
end;

function TFrm_BSTPrint.p_AddArrBST: Boolean;
var
  i, n: Integer;
begin
  n := -1;
  for i := 0 to Length(aBST) -1 do
  begin
    if aBST[i].m_iGroupID = vGroupID then
    begin
      n :=  i;
      Break;
    end;
  end;
  if n = -1 then
  begin
    for i := 0 to Length(aBST) -1 do
    begin
      if aBST[i].m_iGroupID = -1 then
      begin
        n := i;
        Break;
      end;
    end;
    if n = -1 then
    begin
      SetLength(aBST,Length(aBST)+1);
      n := Length(aBST) -1;
    end;
  end;
  aBST[n].m_iRow := vRow;
  aBST[n].m_iCol := vCol;
  aBST[n].m_sBZ := mmo_bz.Text;
  //aBST[n].m_iBSTYS := vBSTYS;
  aBST[n].m_iGroupID := vGroupID;
end;

function TFrm_BSTPrint.p_PrintBST: Boolean;
var
//  rmr_Memo: TRMMemoView;
//  Page: TRMCustomPage;
  Rmrprt: TRMReport;
  AOD_Rec: TADOQuery;
  i,j,iRow,iCol: integer;
  str, sCpbh,sBz,sGdh, sKhmc: string;
  sMmoName,sMmoValue: string;
begin
{  rmr_Memo := TRMMemoView(RMCreateObject(rmgtMemo,''));
  rmr_Memo.Top := 10;
  rmr_Memo.LeftRightFrame := 20;
  rmr_Memo.Memo.Text := '3233';
  rmr_Memo.Visible := true;
  rmr_Memo.Name := '11';
//  RMReport1.Pages.Clear;

  Page.Objects.Add(rmr_Memo);
//  RMReport1.PrepareReport;
  RMReport1.ShowReport; }
  Rmrprt := FindRmrprt;
  if Rmrprt = nil then Exit;
  if Length(aBSTPrint) > 0 then
  begin
    for i := 0 to Length(aBSTPrint) -1 do
    begin
      if aBSTPrint[i].m_iGroupID = vGroupID then
      begin
        iRow := aBSTPrint[i].m_iRow;
        iCol := aBSTPrint[i].m_iCol;
        sCpbh := aBSTPrint[i].m_sCPBH;
        sKhmc := FindOrderData(sCpbh).m_sKhmc;
        if Length(sKhmc) > 22 then
        begin
          str := sKhmc;
          sKhmc := StrLeft(sKhmc,22)+#13#10+strRight(sKhmc,Length(sKhmc)-22);
        end;
        sBz := aBSTPrint[i].m_sBZ;
        sMmoName := 'mmo_'+IntToStr(iRow+1)+'_'+IntToStr(iCol+1);
        sMmoValue := '    '+vCplx+'  '+vYztmc+#13#10+'编号：'+sCpbh+#13#10+'客户：'+sKhmc+#13#10+'说明：'+sBz;
        p_SetPrint(Rmrprt,sMmoName,sMmoValue);
      end;
    end;
    for i := 1 to vRow do
    begin
      for j := 1 to vCol do
      begin
        sMmoName := 'mmo_'+IntToStr(i)+'_'+IntToStr(j);
        sMmoValue :=p_GetPrint(Rmrprt,sMmoName);
        if Trim(sMmoValue) ='批号:11-350101-13-0004-000' then
          p_SetPrint(Rmrprt,sMmoName,'');
      end;
    end;
    sGdh := vGDH;
    p_SetPrint(Rmrprt,'mmo_gdh','工单号：'+sGdh+' 的版式图');
    p_SetPrint(Rmrprt,'mmo_bz','备注：'+mmo_bz.Text);
    p_SetPrint(Rmrprt,'mmo_yl','本版共印： '+IntToStr(vBSTYS)+' 张');
    Rmrprt.PrepareReport;
    Rmrprt.ShowReport
  end else
  begin
    Application.MessageBox('请先保存,再进行打印!','提示',MB_ICONINFORMATION);
    Exit;
  end;
end;

function TFrm_BSTPrint.p_GetData: Boolean;
var
  i , j, n, k, iRow, iCol, iApartID: integer;
  sCpbh,sBz: string;
begin
  if Length(aBSTPrint) >0 then
  begin
    for i := 0 to Length(aBSTPrint) -1 do begin
      k := -1;
      if aBSTPrint[i].m_iGroupID = vGroupID then begin
        iRow := aBSTPrint[i].m_iRow;
        iCol := aBSTPrint[i].m_iCol;
        iApartID := aBSTPrint[i].m_iApartID;
        sCpbh := aBSTPrint[i].m_sCPBH;
        sBz := aBSTPrint[i].m_sBZ;
        n :=  iRow*vCol + iCol;
        for j := 0 to Length(OrderData) -1 do
        begin
          if OrderData[j].m_iApartID =iApartID then
          begin
            k := j;
            Break;
          end;
        end;
        cbb[n].ItemIndex := k;
        edt[n].Text := sBz;
      end;
    end;
  end;
end;

end.
