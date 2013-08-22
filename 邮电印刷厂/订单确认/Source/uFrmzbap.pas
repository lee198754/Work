unit uFrmzbap;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, ComCtrls, RzListVw, ExtCtrls, RzPanel, StdCtrls,
  ButtonEdit, RzCmboBx, iComboBox, uDM_DataBase,ADODB, 
  RzGroupBar, RzEdit, RzDTP, iLabel, Menus;

type
  TParamData = record      //参数
    m_iID: Integer;  //参数ID
    m_iXH: string;  //序号
  end;
  TPParamData = ^TParamData;

type
  TFrm_zbap = class(TForm)
    RzGroupBar1: TRzGroupBar;
    RzPanel1: TRzPanel;
    RzGroup1: TRzGroup;
    RzGroup2: TRzGroup;
    dtp_jgrq: TRzDateTimePicker;
    dtp_wgrq: TRzDateTimePicker;
    cbb_zgsh: Ti_ComboBox;
    lab_gzdh: Ti_Label;
    lab_cpmc: Ti_Label;
    Label1: TLabel;
    Label2: TLabel;
    mmo_bz: TRzMemo;
    Label3: TLabel;
    RzButton1: TRzButton;
    GroupBox1: TGroupBox;
    cbb_gx: Ti_ComboBox;
    cbb_czr: Ti_ComboBox;
    cbb_ks: Ti_ComboBox;
    btn_Add: TRzButton;
    RzGroupBox1: TRzGroupBox;
    lv_ap: TRzListView;
    pm_ap: TPopupMenu;
    menu_Del: TMenuItem;
    edt_sl: Ti_TxtFilter;
    procedure btn_AddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure menu_DelClick(Sender: TObject);
    procedure lv_apMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    procedure RefreshLv;         //读取安排表
    procedure LoadCbbGX;         //初始化工序
    procedure LoadCbbKS;         //初始化开数
    procedure LoadCbbCzr;        //初始化操作人,主管申核,业务员
    procedure LoadData;          //读取信息
  public
    { Public declarations }

  end;

var
  Frm_zbap: TFrm_zbap;
  GxArr,KsArr,CzrArr:array of Integer;   //记录参数ID
  vWorkID: Integer; //工单ID

implementation

uses
  PubStr;

{$R *.dfm}


procedure TFrm_zbap.btn_AddClick(Sender: TObject);
var
  SqlData: string;
  iGx,iKs,iCzr: integer;
  iSl: Integer;
begin
  if (cbb_gx.ItemIndex = -1) or (cbb_gx.ItemIndex = -1) or (cbb_gx.ItemIndex = -1) or (edt_sl.Text='') then
  begin
    Application.MessageBox('数据不完整','提示',MB_ICONINFORMATION);
    Exit;
  end;
  if not IsNum(edt_sl.Text) then
  begin
    Application.MessageBox('数量输入不正确','提示',MB_ICONINFORMATION);
    Exit;
  end;
  iGx := GxArr[cbb_gx.ItemIndex];
  iKs := KsArr[cbb_ks.ItemIndex];
  iSl := StrToNum(edt_sl.Text);
  iCzr := CzrArr[cbb_czr.ItemIndex];
  SqlData := Format('Insert into #TraceDetails (F_iGx,F_iKs,F_iSl,F_iCzr) Values (%d,%d,%d,%d)',[iGx,iKs,iSl,iCzr]);
  DM_DataBase.UpdateTable(SqlData);
  lv_ap.Items.Add.Caption := cbb_gx.Text;
  lv_ap.Items.Item[lv_ap.Items.Count -1].SubItems.Add(cbb_ks.Text);
  lv_ap.Items.Item[lv_ap.Items.Count -1].SubItems.Add(IntToStr(iSl));
  lv_ap.Items.Item[lv_ap.Items.Count -1].SubItems.Add(cbb_czr.Text);
  lv_ap.Items.Item[lv_ap.Items.Count -1].SubItems.Add(IntToStr(lv_ap.Items.Count));      //记录#TraceDetails表的ID

end;

procedure TFrm_zbap.LoadCbbCzr;
var
  ADO_Rec: TADOQuery;
  i: Integer;
begin
  try
    ADO_Rec := TADOQuery.Create(Self);
    DM_DataBase.GetTableData(ADO_Rec,'BI_WorkerList','1=1');
    if ADO_Rec.RecordCount > 0 then
    begin
      SetLength(CzrArr,ADO_Rec.RecordCount);
      cbb_czr.Clear;
      cbb_zgsh.Clear;
      ADO_Rec.First;
      i:= 0;
      while not ADO_Rec.Eof do
      begin
        CzrArr[i] := ADO_Rec.FieldByName('F_iID').AsInteger;
        cbb_czr.Add(ADO_Rec.FieldByName('F_sName').AsString);
        cbb_zgsh.Add(ADO_Rec.FieldByName('F_sName').AsString);
        inc(i);
        ADO_Rec.Next;
      end;
    end;
  finally
    ADO_Rec.Free;
  end;
end;

procedure TFrm_zbap.LoadCbbGX;
var
  ADO_Rec: TADOQuery;
  i, iType: Integer;
  Param1: string;
begin
  iType := DM_DataBase.GetMaxID('select Max(F_iType) from Set_ParamList where F_sName=''制版工序'' and F_sParam1 = '''' ');
  try
    ADO_Rec := TADOQuery.Create(Self);
    DM_DataBase.GetTableData(ADO_Rec,'Set_ParamList','F_iType='+IntToStr(iType));
    if ADO_Rec.RecordCount > 0 then
    begin
      SetLength(GxArr,ADO_Rec.RecordCount);
      cbb_gx.Clear;
      ADO_Rec.First;
      i:= 0;
      while not ADO_Rec.Eof do
      begin
        Param1 := ADO_Rec.FieldByName('F_sParam1').AsString;
        if Param1 <> '' then
        begin
          GxArr[i] := ADO_Rec.FieldByName('F_iID').AsInteger;
          cbb_gx.Add(Param1);
          inc(i);
        end;
        ADO_Rec.Next;
      end;
    end;
  finally
    ADO_Rec.Free;
  end;
end;

procedure TFrm_zbap.LoadCbbKS;
var
  ADO_Rec: TADOQuery;
  i, iType: Integer;
  Param1: string;
begin
  iType := DM_DataBase.GetMaxID('select Max(F_iType) from Set_ParamList where F_sName=''开数'' ');
  try
    ADO_Rec := TADOQuery.Create(Self);
    DM_DataBase.GetTableData(ADO_Rec,'Set_ParamList','F_iType='+IntToStr(iType));
    if ADO_Rec.RecordCount > 0 then
    begin
      SetLength(KsArr,ADO_Rec.RecordCount);
      cbb_ks.Clear;
      ADO_Rec.First;
      i:= 0;
      while not ADO_Rec.Eof do
      begin
        Param1 := ADO_Rec.FieldByName('F_sParam1').AsString;
        if Param1 <> '' then
        begin
          KsArr[i] := ADO_Rec.FieldByName('F_iID').AsInteger;
          cbb_ks.Add(Param1);
          inc(i);
        end;          
        ADO_Rec.Next;
      end;
    end;
  finally
    ADO_Rec.Free;
  end;
end;

procedure TFrm_zbap.RefreshLv;
var
  SqlData: string;
begin
  SqlData := 'Select Gx=(Select F_sParam1 from Set_ParamList where a.F_iGx=F_iID),';
  SqlData := SqlData + ' Ks=(Select F_sParam1 from Set_ParamList where a.F_iKs=F_iID),';
  SqlData := SqlData + ' F_iSl,';
  SqlData := SqlData + ' Czr=(Select F_sName from BI_WorkerList where a.F_iCzr=F_iID), F_iID from #TraceDetails a';
  with DM_DataBase.ADO_DataRec do
  begin
    Close;
    SQL.Text := SqlData;
    Open;
    if RecordCount > 0 then
    begin
      lv_ap.Clear;
      First;
      while not Eof do
      begin
        lv_ap.Items.Add.Caption := FieldByName('Gx').AsString;
        lv_ap.Items.Item[lv_ap.Items.Count -1].SubItems.Add(FieldByName('Ks').AsString);
        lv_ap.Items.Item[lv_ap.Items.Count -1].SubItems.Add(FieldByName('F_iSl').AsString);
        lv_ap.Items.Item[lv_ap.Items.Count -1].SubItems.Add(FieldByName('Czr').AsString);
        lv_ap.Items.Item[lv_ap.Items.Count -1].SubItems.Add(FieldByName('F_iID').AsString);
        Next;
      end;
    end;
  end;
end;

procedure TFrm_zbap.FormShow(Sender: TObject);
var
  SqlData: string;
begin
  SqlData := 'create table #TraceDetails (F_iID int identity,F_iGx  int,F_iKs int,F_iSl int,F_iCzr int) ';
  DM_DataBase.UpdateTable(SqlData);
  SqlData := 'insert into #TraceDetails ';
  SqlData := SqlData + #13#10 + Format('select F_iGx, F_iKs, F_iSl, F_iCzr from DO_MakingDetails a '
    +' where exists(select 1 from DO_MakingTrace where F_iID=a.F_iTraceID and F_iWorkID=%d)',[vWorkID]);
  DM_DataBase.UpdateTable(SqlData);
  RefreshLv;
  LoadCbbGX;
  LoadCbbKS;
  LoadCbbCzr;
  LoadData;
end;

procedure TFrm_zbap.RzButton1Click(Sender: TObject);
var
  SqlData: string;
  sNum: string;
  iZGID: integer;
  iTrarcID: integer;
  ADO_Rec: TADOQuery;
begin
  iZGID := CzrArr[cbb_zgsh.ItemIndex];
  SqlData := 'Select F_iID from DO_MakingTrace where F_iWorkID = '+IntToStr(vWorkID);
  iTrarcID := DM_DataBase.GetMaxID(SqlData);
  try
    ADO_Rec := TADOQuery.Create(Self);
    with ADO_Rec do
    begin
      if iTrarcID = 0 then
      begin
        DM_DataBase.GetMaxID('DO_MakingTrace','F_sNum',sNum);
        DM_DataBase.GetTableData(ADO_Rec,'DO_MakingTrace');
        Insert;
        FieldByName('F_sNum').AsString := sNum;
        FieldByName('F_iWorkID').AsInteger := vWorkID;
        FieldByName('F_sRemarks').AsString := mmo_bz.Text;
        FieldByName('F_dJGRQ').AsDateTime := dtp_jgrq.DateTime;
        FieldByName('F_dWGRQ').AsDateTime := dtp_wgrq.DateTime;
        FieldByName('F_iZGID').AsInteger := iZGID;
      end else
      begin
        SqlData :=  'F_iWorkID='+IntToStr(vWorkID);
        DM_DataBase.GetTableData(ADO_Rec,'DO_MakingTrace',SqlData);
        Edit;
        FieldByName('F_sRemarks').AsString := mmo_bz.Text;
        FieldByName('F_dJGRQ').AsDateTime := dtp_jgrq.DateTime;
        FieldByName('F_dWGRQ').AsDateTime := dtp_wgrq.DateTime;
        FieldByName('F_iZGID').AsInteger := iZGID;
      end;
      Post;
      iTrarcID := FieldByName('F_iID').AsInteger;
      SqlData := 'F_iTraceID='+IntToStr(iTrarcID);
      DM_DataBase.GetTableData(ADO_Rec,'DO_MakingDetails',SqlData);
      while not Eof do Delete;
      SqlData := 'Insert Into DO_MakingDetails select F_iGx,F_iKs,F_iSl,F_iCzr,F_iTraceID='+IntToStr(iTrarcID)+' from #TraceDetails';
      DM_DataBase.UpdateTable(SqlData)
    end;
    Application.MessageBox('保存成功!','提示',MB_ICONINFORMATION);
    Close;
  finally
    ADO_Rec.Free;
  end;
//  DM_DataBase.GetMaxID('DO_MakingDetails','F_sDetailsID',sDetailsID);

end;

procedure TFrm_zbap.FormDestroy(Sender: TObject);
var
  SqlData: string;
begin
  SqlData := 'drop table #TraceDetails ';;
  DM_DataBase.UpdateTable(SqlData);
end;

procedure TFrm_zbap.menu_DelClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  SelItem: TListItem;
  sID: string;
  SqlData: string;
begin
  SelItem := lv_ap.Selected;
  if not Assigned(SelItem) then Exit;
  sID := SelItem.SubItems.Strings[SelItem.SubItems.Count-1];
  SqlData := 'F_iID='+sID;
  try
    ADO_Rec := TADOQuery.Create(Self);
    DM_DataBase.GetTableData(ADO_Rec,'#TraceDetails',SqlData);
    ADO_Rec.Delete;
    lv_ap.Selected.Delete;
  finally
    ADO_Rec.Free;
  end;
end;

procedure TFrm_zbap.lv_apMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Point: TPoint;
begin
  if Button = mbRight then
  begin
    if Assigned(TListView(Sender).Selected) then
    begin
      GetCursorPos(Point);
      pm_ap.Popup(Point.X,Point.Y);
    end;
  end;
end;

procedure TFrm_zbap.LoadData;
var
  ADO_Rec: TADOQuery;
  SqlData: string;
  i, iZGSH: Integer;
begin
  SqlData := 'F_iWorkID = '+IntToStr(vWorkID);
  try
    ADO_Rec := TADOQuery.Create(Self);
    DM_DataBase.GetTableData(ADO_Rec,'DO_MakingTrace',SqlData);
    with ADO_Rec do
    begin
      if RecordCount>0 then
      begin
        dtp_jgrq.DateTime := FieldByName('F_dJGRQ').AsDateTime;
        dtp_wgrq.DateTime := FieldByName('F_dWGRQ').AsDateTime;
        iZGSH := -1;
        for i := 0 to Length(CzrArr) -1 do
        begin
          if CzrArr[i] = FieldByName('F_iZGID').AsInteger then
            iZGSH := i;
        end;
        if iZGSH <> -1 then
          cbb_zgsh.ItemIndex := iZGSH;
        mmo_bz.Text := FieldByName('F_sRemarks').AsString;
      end else
      begin
        dtp_jgrq.DateTime := Now;
        dtp_wgrq.DateTime := Now;
      end;
    end;
  finally
    ADO_Rec.Free;
  end;
end;

end.
