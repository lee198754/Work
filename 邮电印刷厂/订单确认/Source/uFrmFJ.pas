unit uFrmFJ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzButton, Grids, iGrid,ADODB, ExtCtrls,
  RzRadChk;



type
  TFrm_FJ = class(TForm)
    btn_Ok: TRzButton;
    RzButton1: TRzButton;
    Bevel1: TBevel;
    Label1: TLabel;
    lab_zyl: TLabel;
    Label2: TLabel;
    lab_cpbh: TLabel;
    btn_Add: TRzButton;
    edt_yl: TEdit;
    edt_czyl: TEdit;
    edt_czcpbh: TEdit;
    stg_yl: Ti_StgEdit;
    cb_NJBS: TRzCheckBox;
    cb_czcybz: TComboBox;
    cbb_cybz: TComboBox;
    Label3: TLabel;
    cbb_NJBZ: TComboBox;
    Label4: TLabel;
    cbb_YZTMC: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure stg_ylLinkClick(Sender: TObject; ACol, ARow: Integer);
    procedure btn_OkClick(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
    procedure edt_czylExit(Sender: TObject);
  private
    { Private declarations }
    vOrderID: Integer;
    vOrderType: Integer;
    FYZTMC: string;
  public
    { Public declarations }
    vSucceed: Boolean;
    procedure ReadDataYL(OrderID,BZ: Integer);
  end;

var
  Frm_FJ: TFrm_FJ;

implementation

uses
  PubStr,uDM_DataBase,uPub_Type,uPub_Func, DB;

{$R *.dfm}

const
  c_cpbh    = 0;
  c_yztmc   = 1;
  c_yl      = 2;
  c_cybz    = 3;
  c_cz      = 4;
  c_ApartID = 5;

procedure TFrm_FJ.FormShow(Sender: TObject);
var
  i: integer;
begin
  stg_yl.ColBuddy[c_cpbh]  := 'edt_czcpbh';
  stg_yl.ColBuddy[c_yztmc]  := 'cbb_YZTMC';
  stg_yl.ColBuddy[c_yl]  := 'edt_czyl';
  stg_yl.ColBuddy[c_cybz]  := 'cb_czcybz';

  for i := 0 to Self.ComponentCount -1 do
  begin
    if Self.Components[i].Tag <> 1 then Continue;
    if Self.Components[i] is TLabel then
      TLabel(Self.Components[i]).Caption := ''
    else
    if Self.Components[i] is TEdit then
      TEdit(Self.Components[i]).Text := '';
  end;
  vSucceed := False;
end;

procedure TFrm_FJ.btn_AddClick(Sender: TObject);
var
  sCpbh: string;
  n, iNum: Integer;
begin
  if not IsNum(edt_yl.Text) then
  begin
    Application.MessageBox('请输入数字!','提示',MB_ICONINFORMATION);
    Exit;
  end;
  n := stg_yl.RowCount-1;
  sCpbh := stg_yl.cells[c_cpbh,n];
  if StrRight(lab_cpbh.Caption,3)='999' then
  begin
    iNum := StrtoNum(StrRight(sCpbh,2))+1;
    sCpbh := Copy(sCpbh,1,Length(sCpbh)-2)+StrRight('00'+IntToStr(iNum),2);
  end;    
  stg_yl.AddRow;
  stg_yl.cells[c_cpbh ,n+1] := sCpbh;
  stg_yl.cells[c_yztmc ,n+1] := iif(cbb_NJBZ.ItemIndex=0,FYZTMC,'无邮资图');
  stg_yl.cells[c_yl,n+1] := edt_yl.Text;
  stg_yl.cells[c_cybz,n+1] := cbb_cybz.Text;
  stg_yl.cells[c_cz,n+1] := '删除';
  stg_yl.CellsLink[c_cz,n+1] := '删除';

  //  lv_yl.Items.Add.Caption := sCpbh + StrRight(StrRep('0',3)+IntToStr(lv_yl.Items.Count+1),3);
//  lv_yl.Items.Item[lv_yl.Items.Count-1].SubItems.Add(edt_yl.Text);

end;

procedure TFrm_FJ.ReadDataYL(OrderID,BZ: Integer);
var
  n: Integer;
  sCpbh,sYl,sCz,sTableName,sSqlData: string;
  iOredrID,iOrderType,iApart,iNJBS: Integer;
  ADO_Rec: TADOQuery;
begin
  vOrderID := OrderID;
  vOrderType := BZ;
  try
    case vOrderType of
      0: sSqlData := 'Select F_tiNJBS from BI_CustomOrderDetails where F_iID='+IntToStr(vOrderID);
      1: sSqlData := 'Select F_tiNJBS from BI_SellOrderDetails where F_iID='+IntToStr(vOrderID);
    end;
    iNJBS := DM_DataBase.GetMaxID(sSqlData);
    case iNJBS of
      0: cb_NJBS.Checked := False;
      1: cb_NJBS.Checked := True;
    end;
    ADO_Rec := TADOQuery.Create(Self);
    case BZ of
      0: sTableName := 'BI_CustomOrderDetails';
      1: sTableName := 'BI_SellOrderDetails';
    end;
    DM_DataBase.GetTableData(ADO_Rec,sTableName,'F_iID='+IntToStr(OrderID));
    sCpbh := ADO_Rec.FieldByName('F_sCpbh').AsString;
    sYl := ADO_Rec.FieldByName('F_nYl').AsString;
    FYZTMC := ADO_Rec.FieldByName('F_sYZTMC').AsString;
    cbb_YZTMC.Clear;
    cbb_YZTMC.Items.Add(FYZTMC);
    cbb_YZTMC.Items.Add('无邮资图');
    Frm_FJ.lab_cpbh.Caption := sCpbh;
    Frm_FJ.lab_zyl.Caption := '总印量：'+ sYl;
    DM_DataBase.GetTableData(ADO_Rec,'DO_OrderApart','F_tiOrderType='+IntToStr(BZ)+' and F_iOrderID='+IntToStr(OrderID)+' and F_tiCXBZ=0 order by F_sCPBH,F_iID');
    stg_yl.Clear;
    stg_yl.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
    n := 1;
    with ADO_Rec do
    begin
      First;
      while not Eof do
      begin
        stg_yl.cells[c_cpbh ,n] := FieldByName('F_sCPBH').AsString;;
        stg_yl.cells[c_yztmc ,n] := FieldByName('F_sYZTMC').AsString;;
        stg_yl.cells[c_yl,n] := FieldByName('F_nYl').AsString;
        stg_yl.cells[c_cybz,n] := iif(FieldByName('F_tiCYBZ').AsInteger=1,'重印','无');
        stg_yl.cells[c_cz,n] := '删除';
        stg_yl.CellsLink[c_cz,n] := '删除';
        stg_yl.cells[c_APartID,n] := FieldByName('F_iID').AsString ;
        inc(n);
        Next;
      end;
    end;
    stg_yl.ColWidths[c_APartID] := 0;
  finally
    ADO_Rec.Free;
  end;
end;

procedure TFrm_FJ.stg_ylLinkClick(Sender: TObject; ACol, ARow: Integer);
var
  i,n,iNum: integer;
  sCpbh: string;
begin
  if ACol = c_cz then
  begin
    if Application.MessageBox(PChar('是否删除'+#13#10+'    产品编号：'+stg_yl.cells[c_cpbh ,ARow]+#13#10+'    印量: '+stg_yl.cells[c_yl ,ARow]+#13#10+'    重印标志: '+stg_yl.cells[c_cybz ,ARow]),'提示',MB_ICONINFORMATION+MB_YESNO)=IDYES then
    begin
      stg_yl.DelRow(ARow);
      if StrRight(lab_cpbh.Caption,3)='999' then
      begin
        n := 1;
        for i := 0 to stg_yl.RowCount -1 do
        begin
          sCpbh :=  stg_yl.cells[c_cpbh ,n];
          iNum := StrtoNum(StrRight(sCpbh,2))+1;
          sCpbh := Copy(sCpbh,1,Length(sCpbh)-2)+StrRight('00'+IntToStr(iNum),2);
          stg_yl.cells[c_cpbh ,n+1] := sCpbh;
          Inc(n);
        end;
      end;
    end;
  end;

end;

procedure TFrm_FJ.btn_OkClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  str, sSqlData, sYZTMC, sTSGY, sCYBZ: string;
  i,j,n,iNJBS,iCZR,iCYBZ: integer;
  bModfiyOrder,bModfiyNJ,bSucceed: Boolean;
  ExclusionList: TStringList;

begin
  vSucceed := False;
  //iNJBS := iif(cb_NJBS.Checked,1,0);
  iNJBS := 0;
  for i := 1 to stg_yl.RowCount do
  begin
    if stg_yl.Cells[c_yztmc,i]='无邮资图' then
    begin
      iNJBS := 1;
      Break;
    end;
  end;
  sSqlData :='Select * from DO_OrderApart where F_iOrderID=%d and F_tiOrderType=%d and F_tiCXBZ = 0 order by F_sCPBH,F_iID  ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[vOrderID,vOrderType]);
  if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
  begin
    str := '此次未做修改,';
    if ADO_Rec.RecordCount = stg_yl.RowCount -1 then
    begin
      n := 1;
      for i := 0 to stg_yl.RowCount -2 do
      begin
        if stg_yl.cells[c_cpbh ,n]='' then
        begin
          Inc(n);
          Continue;
        end;
        ADO_Rec.First;
        while not ADO_Rec.Eof do
        begin
          if stg_yl.cells[c_cybz ,n]='重印' then
            iCYBZ := 1
          else
            iCYBZ := 0;
          if (ADO_Rec.FieldByName('F_sCPBH').AsString = stg_yl.cells[c_cpbh ,n])
            and (ADO_Rec.FieldByName('F_sYZTMC').AsString = stg_yl.cells[c_yztmc ,n])
            and (ADO_Rec.FieldByName('F_nYl').AsString = stg_yl.cells[c_yl ,n])
            and (ADO_Rec.FieldByName('F_tiCYBZ').AsInteger = iCYBZ)
            and (ADO_Rec.FieldByName('F_iID').AsString = stg_yl.cells[c_ApartID ,n]) then
          begin
            Break;
          end;
          ADO_Rec.Next;
        end;
        if ADO_Rec.Eof then Break;
        inc(n);
      end;
      bModfiyOrder := False;
      if ADO_Rec.Eof then
      begin
        str := '此次修改了分解订单数据会影响到已开单数据(如果还未开单则无影响),';
        bModfiyOrder := True;
      end;
    end else
    begin
      str := '此次修改了分解订单数据会影响到已开单数据(如果还未开单则无影响),';
      bModfiyOrder := True;
    end;
    ADO_Rec.Free;
    case vOrderType of
      0: sSqlData := 'select * from BI_CustomOrderDetails where F_iID=%d' ;
      1: sSqlData := 'select * from BI_SellOrderDetails  where F_iID=%d' ;
    end;
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[vOrderID]);
    bModfiyNJ := False;
    if ADO_Rec.FieldByName('F_tiNJBS').AsInteger <> iNJBS then
    begin
      if bModfiyOrder then
      begin
        case iNJBS of
          0: str := str + '并且删除生成的内件(会影响到已开单的内件),';
          1: str := str + '并且生成内件,';
        end;
      end else
      begin
        case iNJBS of
          0: str := '此次未修改分解订单数据,只删除生成的内件,会影响到已开单的内件(如果还未开单则无影响)';
          1: str := '此次未修改分解订单数据,只生成内件,';
        end;
      end;
      bModfiyNJ := True;
    end;
    str := str+'是否还要保存修改?';
    if bModfiyOrder then  bModfiyNJ := False;
  end else
  begin
    str := '是否要保存?';
    bModfiyNJ := False;
    bModfiyOrder := True;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;
  if Application.MessageBox(pchar(str),'提示',MB_ICONINFORMATION+MB_YESNO)=IDYES then
  begin
    try
      DM_DataBase.Con_YDPrint.BeginTrans;
      if bModfiyNJ then
      begin
        case vOrderType of
          0: sSqlData := 'Update BI_CustomOrderDetails Set F_tiNJBS=%d where F_iID=%d';
          1: sSqlData := 'Update BI_SellOrderDetails Set F_tiNJBS=%d where F_iID=%d';
        end;
        DM_DataBase.ExecQuery(sSqlData,[iNJBS,vOrderID,vOrderID],True);
        case iNJBS of
          0:       //有内件改为无内件,删除原来的内件
            begin
              //sSqlData := 'Delete from DO_OrderApart where F_iOrderID=%d and F_tiOrderType=%d and F_tiNJBZ=1';
              sSqlData := 'Update DO_OrderApart set F_tiCXBZ=1,F_sCXBZ=''通过拆分订单撤销内件'',F_sCXRBM=''%s'',F_dCXRQ=''%s'' where F_iOrderID=%d and F_tiOrderType=%d and F_tiNJBZ=1 and F_tiCXBZ = 0 ';
              DM_DataBase.ExecQuery(sSqlData,[LoginData.m_sUserName,FormatDateTime('yyyy-MM-dd hh:mm:ss',Now),vOrderID,vOrderType],True);
            end;
          1:    //无内件改为有内件,添加的内件
            begin
              sSqlData := 'Insert into DO_OrderApart (F_tiOrderType,F_iOrderID,F_sCPBH,F_sYZTMC,F_sTSGY,F_nYl,F_iCZR,F_dCZRQ,F_tiNJBZ,F_tiCXBZ) '
                +' Select F_tiOrderType,F_iOrderID,F_sCPBH,''无邮资图'',F_sTSGY,F_nYl,F_iCZR,F_dCZRQ,1,0 from DO_OrderApart where F_iOrderID=%d and F_tiOrderType=%d and F_tiNJBZ=0 and F_tiCXBZ = 0 ';
              DM_DataBase.ExecQuery(sSqlData,[vOrderID,vOrderType],True);
            end;
        end;
      end;
      if bModfiyOrder then
      begin
        ADO_Rec := TADOQuery.Create(Self);
        DM_DataBase.GetTableData(ADO_Rec,'DO_OrderApart','F_tiOrderType='+IntToStr(vOrderType)+' and F_iOrderID='+IntToStr(vOrderID)+' and F_tiCXBZ = 0 order by F_sCPBH,F_iID ');
        if Assigned(ADO_Rec) then
        begin
          if ADO_Rec.RecordCount >0 then
          begin
            ADO_Rec.First;
            sTSGY := ADO_Rec.FieldByName('F_sTSGY').AsString;
            ExclusionList := TStringList.Create;
            while not ADO_Rec.Eof do
            begin
              bSucceed := False;
              sYZTMC := ADO_Rec.FieldByName('F_sYZTMC').AsString;
              for n := 1 to stg_yl.RowCount do
              begin
                case ADO_Rec.FieldByName('F_tiCYBZ').AsInteger of
                  0: sCYBZ := '无';
                  1: sCYBZ := '重印';
                end;
                if (StrToNum(stg_yl.cells[c_ApartID ,n]) = ADO_Rec.FieldByName('F_iID').AsInteger)
                  and (stg_yl.cells[c_cpbh ,n] = ADO_Rec.FieldByName('F_sCPBH').AsString)
                  and (StrToNum(stg_yl.cells[c_yl ,n]) = StrToNum(ADO_Rec.FieldByName('F_nYl').AsString))
                  and (stg_yl.cells[c_yztmc ,n] = sYZTMC)
                  and (stg_yl.cells[c_cybz ,n] = sCYBZ) and (stg_yl.cells[c_cpbh ,n]<>'') then
                begin
                  ExclusionList.Add(stg_yl.cells[c_ApartID ,n]);
                  bSucceed := True;
                  Break;
                end;
              end;
              if bSucceed then
              begin
                ADO_Rec.Next;
                Continue;
              end;
              ADO_Rec.Edit;
              ADO_Rec.FieldByName('F_tiCXBZ').AsInteger := 1;
              ADO_Rec.FieldByName('F_sCXBZ').AsString := '通过拆分订单撤销内件';
              ADO_Rec.FieldByName('F_sCXRBM').AsString := LoginData.m_sUserName;
              ADO_Rec.Next;
            end;
          end;
          with ADO_Rec do
          begin
            n := 1;
            for i := 0 to stg_yl.RowCount -1 do
            begin
              if stg_yl.cells[c_cpbh ,n]='' then
              begin
                Inc(n);
                Continue;
              end;

              if Assigned(ExclusionList) then
              begin
                bSucceed := False;
                if ExclusionList.IndexOf(stg_yl.cells[c_ApartID ,n]) > -1 then
                begin
                  inc(n);
                  Continue;
                end;
//                for j := 0 to ExclusionList.Count-1 do
//                begin
//                  if StrToNum(stg_yl.cells[c_ApartID ,n]) = ExclusionList.Strings[j] then
//                  begin
//                    Inc(n);
//                    bSucceed := False;
//                    Break;
//                  end;
//                end;
              end;
//              if bSucceed then Continue;
              sYZTMC := stg_yl.cells[c_yztmc ,n];
              Insert;
              FieldByName('F_tiOrderType').AsInteger := vOrderType;
              FieldByName('F_iOrderID').AsInteger := vOrderID;
              FieldByName('F_sCPBH').AsString := stg_yl.cells[c_cpbh ,n];
              FieldByName('F_sYZTMC').AsString := sYZTMC;
              FieldByName('F_sTSGY').AsString := sTSGY;
              FieldByName('F_nYl').AsString := stg_yl.cells[c_yl ,n];
              FieldByName('F_iCZR').AsInteger := LoginData.m_iUserID;
              if stg_yl.cells[c_cybz ,n]='重印' then
                iCYBZ := 1
              else
                iCYBZ := 0;
              FieldByName('F_tiCYBZ').AsInteger := iCYBZ;
              FieldByName('F_dCZRQ').AsDateTime := Now;
              FieldByName('F_tiNJBZ').AsInteger := iif(sYZTMC='无邮资图',1,0);
              {if iNJBS = 1 then
              begin
                Insert;
                FieldByName('F_tiOrderType').AsInteger := vOrderType;
                FieldByName('F_iOrderID').AsInteger := vOrderID;
                FieldByName('F_sCPBH').AsString := stg_yl.cells[c_cpbh ,n];
                FieldByName('F_sYZTMC').AsString := '无邮资图';
                FieldByName('F_sTSGY').AsString := sTSGY;
                FieldByName('F_nYl').AsString := stg_yl.cells[c_yl ,n];
                FieldByName('F_iCZR').AsInteger := LoginData.m_iUserID;
                FieldByName('F_tiCYBZ').AsInteger := iCYBZ;
                FieldByName('F_dCZRQ').AsDateTime := Now;
                FieldByName('F_tiNJBZ').AsInteger := 1;
              end;   }
              Post;
              Inc(n);
            end;
          end;
          if Assigned(ExclusionList) then  ExclusionList.Free;
          ADO_Rec.Free;
        end;
      end;
      DM_DataBase.Con_YDPrint.CommitTrans;
      p_MessageBoxDlg('保存成功!');
      vSucceed := True;
      Close;
    except
      on E: Exception do
      begin
        DM_DataBase.Con_YDPrint.RollbackTrans;
        Application.MessageBox(PChar('保存失败：'+E.Message),'提示',MB_ICONINFORMATION);
        Exit;
      end;
    end;
  end;
end;

procedure TFrm_FJ.RzButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrm_FJ.edt_czylExit(Sender: TObject);
var
  sYL: string;
begin
  sYL := TEdit(Sender).Text;
  if StrToNum(sYL) >200000 then
  begin
    p_MessageBoxDlg('印量超出范围!');
    TEdit(Sender).Text := '';
    Exit;

  end;
end;

end.
