unit uFrm_WorkOrder_History;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, iGrid, ADODB;

type
  TFrm_WorkOrder_History = class(TForm)
    stg_HistoryList: Ti_StgEdit;
    procedure FormShow(Sender: TObject);
    procedure stg_HistoryListLinkClick(Sender: TObject; ACol,
      ARow: Integer);
  private
    { Private declarations }
    procedure ReadDataHistoryList(ADO_Data: TADOQuery);
//    function FIndDifferentia(iLastID,iHIstoryID: Integer): string;

  public
    { Public declarations }
    vWorkID: integer;
  end;

var
  Frm_WorkOrder_History: TFrm_WorkOrder_History;

implementation

uses
  uDM_DataBase, uWorkOrder, uPub_Text, PubStr;

{$R *.dfm}

const
  c_CZSJ      = 0;
  c_CZR       = 1;
  c_CZ        = 2;
  c_HistoryID = 3;

{ TFrm_WorkOrder_History }

procedure TFrm_WorkOrder_History.ReadDataHistoryList(ADO_Data: TADOQuery);
var
  n: Integer;
begin
  stg_HistoryList.Clear;
  stg_HistoryList.RowCount := iif(ADO_Data.RecordCount > 0, ADO_Data.RecordCount +1, 2);
  with ADO_Data do
  begin
    First;
    n := 1;
    while not Eof do
    begin
      stg_HistoryList.cells[c_CZSJ,n] := FormatDateTime('yyyy-MM-dd hh:mm:ss',FieldByName('CZSJ').AsDateTime) ;
      stg_HistoryList.cells[c_CZR,n] := FieldByName('CZR').AsString;
      stg_HistoryList.Cells[c_CZ,n] := '�鿴';
      stg_HistoryList.CellsLink[c_CZ,n] := '�鿴';
      stg_HistoryList.Cells[c_HistoryID,n] := FieldByName('F_iID').AsString;
      inc(n);
      Next;
    end;
  end;
  stg_HistoryList.ColWidths[c_HistoryID] := 0;
end;

procedure TFrm_WorkOrder_History.FormShow(Sender: TObject);
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
begin
  sSqlData := 'Select a.F_iID,IsNull(a.F_dXGRQ,a.F_dKDRQ) CZSJ,case when IsNull(b.F_sRealName,'''') = '''' then b.F_sName else  b.F_sRealName end CZR '
    + ' from History_WorkOrder a,BI_UserList b where ( (IsNull(a.F_sXGR,'''')='''' and b.F_sName=a.F_sKDR) '
    + ' or (IsNull(a.F_sXGR,'''') <> '''' and b.F_sName=substring(a.F_sXGR,1,charindex('';'',F_sXGR)-1)) ) '
    + ' and a.F_iRealWorkID=%d order by IsNull(a.F_dXGRQ,a.F_dKDRQ) desc';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[vWorkID],False);
  if Assigned(ADO_Rec) then
    ReadDataHistoryList(ADO_Rec);
  ADO_Rec.Free;
end;

procedure TFrm_WorkOrder_History.stg_HistoryListLinkClick(Sender: TObject;
  ACol, ARow: Integer);
begin
  if ACol = c_CZ then
  begin
    SetLength(aFrm_WorkOrder,Length(aFrm_WorkOrder)+1);
    aFrm_WorkOrder[Length(aFrm_WorkOrder)-1] := TFrm_WorkOrder.Create(nil);
    with aFrm_WorkOrder[Length(aFrm_WorkOrder)-1] do
    begin
      btn_dy.Hide;
      btn_History_dy.Left := btn_dy.Left;
      btn_History_dy.Top := btn_dy.Top;
      btn_History_dy.Show;
      btn_History.Hide;
      vbCXBZ := False;
      vbHistory := True;
      vActionType := c_WorkOrder_Select;
      vWorkID := StrToNum(stg_HistoryList.Cells[c_HistoryID,ARow]);
      vGroupID := 1;

      p_LoadHistoryWorkOrderData;
      ShowModal;
      Free;
    end;

  end;
end;

{function TFrm_WorkOrder_History.FIndDifferentia(iLastID: Integer;iNextID: Integer): string;
var
  sSqlData: string;
  ADO_Rec, ADO_Soure, ADO_History: TADOQuery;
begin
  Result := '';
  if iLastID = 0 then
  begin
    sSqlData := 'Select * from DO_WorkOrder where F_iID=%d';
    ADO_Soure := DM_DataBase.OpenQuery(sSqlData,[vWorkID]);
  end else
  begin
    sSqlData := 'Select * from History_WorkOrder where F_iID=%d';
    ADO_Soure := DM_DataBase.OpenQuery(sSqlData,[iLastID]);
  end;
  if Assigned(ADO_Soure) and (ADO_Soure.RecordCount>0) then
  begin
    sSqlData := 'Select * from History_WorkOrder where F_iID=%d';
    ADO_History := DM_DataBase.OpenQuery(sSqlData,[iNextID]);
    if Assigned(ADO_History) and (ADO_History.RecordCount>0) then
    begin
      if ADO_SoureFieldByName('F_sHM') <> ADO_History.FieldByName('F_sHM') then Result := Result + ' ԭ����:'+ ADO_SoureFieldByName('F_sHM') + ' �޸�:' +DO_History.FieldByName('F_sHM') +';';
      if ADO_SoureFieldByName('F_sPM') <> ADO_History.FieldByName('F_sPM') then Result := Result + ' ԭƷ��:'+ ADO_SoureFieldByName('F_sPM') + ' �޸�:' +DO_History.FieldByName('F_sPM') +';';
      if ADO_SoureFieldByName('F_iZL') <> ADO_History.FieldByName('F_iZL') then Result := Result + ' ԭ����:'+ ADO_SoureFieldByName('F_iZL') + ' �޸�:' +DO_History.FieldByName('F_iZL') +';';
      if ADO_SoureFieldByName('F_sZLDW') <> ADO_History.FieldByName('F_sZLDW') then Result := Result + 'ԭ������λ:'+ ADO_SoureFieldByName('F_sZLDW') + ' �޸�:' +DO_History.FieldByName('F_sZLDW') +';';
      if ADO_SoureFieldByName('F_sCPKS') <> ADO_History.FieldByName('F_sCPKS') then Result := Result + ' ԭ��Ʒ����:'+ ADO_SoureFieldByName('F_sCPKS') + ' �޸�:' +DO_History.FieldByName('F_sCPKS') +';';
      if ADO_SoureFieldByName('F_sCPGG') <> ADO_History.FieldByName('F_sCPGG') then Result := Result + ' ԭ��Ʒ���:'+ ADO_SoureFieldByName('F_sCPGG') + ' �޸�:' +DO_History.FieldByName('F_sCPGG') +';';
      if ADO_SoureFieldByName('F_nTJ') <> ADO_History.FieldByName('F_nTJ') then Result := Result + ' ԭ:ͷ��'+ ADO_SoureFieldByName('F_nTJ') + ' �޸�:' +DO_History.FieldByName('F_nTJ') +';';
      if ADO_SoureFieldByName('F_nZJ') <> ADO_History.FieldByName('F_nZJ') then Result := Result + ' ԭ:���'+ ADO_SoureFieldByName('F_nZJ') + ' �޸�:' +DO_History.FieldByName('F_nZJ') +';';
      if ADO_SoureFieldByName('F_nCPK') <> ADO_History.FieldByName('F_nCPK') then Result := Result + ' ԭ:��Ʒ��'+ ADO_SoureFieldByName('F_nCPK') + ' �޸�:' +DO_History.FieldByName('F_nCPK') +';';
      if ADO_SoureFieldByName('F_nCPC') <> ADO_History.FieldByName('F_nCPC') then Result := Result + ' ԭ:��Ʒ��'+ ADO_SoureFieldByName('F_nCPC') + ' �޸�:' +DO_History.FieldByName('F_nCPC') +';';
      if ADO_SoureFieldByName('F_sZH') <> ADO_History.FieldByName('F_sZH') then Result := Result + ' ԭ:���'+ ADO_SoureFieldByName('F_sZH') + ' �޸�:' +DO_History.FieldByName('F_sZH') +';';
      if ADO_SoureFieldByName('F_sRJHDQ') <> ADO_History.FieldByName('F_sRJHDQ') then Result := Result + ' ԭ�ҽ��Ŷ���:'+ ADO_SoureFieldByName('F_sRJHDQ') + ' �޸�:' +DO_History.FieldByName('F_sRJHDQ') +';';
      if ADO_SoureFieldByName('F_sRJHDZ') <> ADO_History.FieldByName('F_sRJHDZ') then Result := Result + ' ԭ�ҽ��Ŷ�ֹ:'+ ADO_SoureFieldByName('F_sRJHDZ') + ' �޸�:' +DO_History.FieldByName('F_sRJHDZ') +';';
      if ADO_SoureFieldByName('F_sZYPH') <> ADO_History.FieldByName('F_sZYPH') then Result := Result + ' ԭ׼ӡ����:'+ ADO_SoureFieldByName('F_sZYPH') + ' �޸�:' +DO_History.FieldByName('F_sZYPH') +';';
      if ADO_SoureFieldByName('F_sFPDM') <> ADO_History.FieldByName('F_sFPDM') then Result := Result + ' ԭ��Ʊ����:'+ ADO_SoureFieldByName('F_sFPDM') + ' �޸�:' +DO_History.FieldByName('F_sFPDM') +';';
      if ADO_SoureFieldByName('F_sQSHM') <> ADO_History.FieldByName('F_sQSHM') then Result := Result + ' ԭ��ʼ����:'+ ADO_SoureFieldByName('F_sQSHM') + ' �޸�:' +DO_History.FieldByName('F_sQSHM') +';';
      if ADO_SoureFieldByName('F_sZZHM') <> ADO_History.FieldByName('F_sZZHM') then Result := Result + ' ԭ��ֹ����:'+ ADO_SoureFieldByName('F_sZZHM') + ' �޸�:' +DO_History.FieldByName('F_sZZHM') +';';
      if ADO_SoureFieldByName('F_sZDYQ') <> ADO_History.FieldByName('F_sZDYQ') then Result := Result + ' ԭװ��Ҫ��:'+ ADO_SoureFieldByName('F_sZDYQ') + ' �޸�:' +DO_History.FieldByName('F_sZDYQ') +';';
      if ADO_SoureFieldByName('F_sBZ') <> ADO_History.FieldByName('F_sBZ') then Result := Result + ' ԭ��ע:'+ ADO_SoureFieldByName('F_sBZ') + ' �޸�:' +DO_History.FieldByName('F_sBZ') +';';
    end;

    if iLastID = 0 then
    begin
      sSqlData := 'Select * from DO_WorkOrderDetails where F_iWorkID=%d order by F_iApartID';
      ADO_Soure := DM_DataBase.OpenQuery(sSqlData,[vWorkID]);
    end else
    begin
      sSqlData := 'Select * from History_WorkOrderDetails where F_iWorkID=%d order by F_iApartID';
      ADO_Soure := DM_DataBase.OpenQuery(sSqlData,[iLastID]);
    end;
    sSqlData := 'Select * from History_WorkOrderDetails where F_iWorkID=%d order by F_iApartID';
    ADO_History := DM_DataBase.OpenQuery(sSqlData,[iHIstoryID]);
    if Assigned(ADO_History) and (ADO_History.RecordCount>0) then
    begin
      if ADO_SoureFieldByName('') <> ADO_History.FieldByName('') then Result := Result + ' ԭ:'+ ADO_SoureFieldByName('') + ' �޸�:' +DO_History.FieldByName('') +';';
    end;

  end;

end;    }

end.
