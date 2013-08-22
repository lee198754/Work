unit uFrm_SCGL_BFJC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, iGrid, ExtCtrls;

type
  TFrm_SCGL_BFJC = class(TForm)
    Bevel1: TBevel;
    btn_ok: TButton;
    btn_close: TButton;
    stg_BFJC: Ti_StgEdit;
    edt_Temp: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    { Private declarations }
    function IsCheck:Boolean;
  public
    { Public declarations }
    vSuccess: Boolean;
    vJTXXID: Integer;
    vWorkID: Integer;
  end;

var
  Frm_SCGL_BFJC: TFrm_SCGL_BFJC;

implementation

uses
  uPub_Text,PubStr, uDM_DataBase, uPub_Type;

{$R *.dfm}



procedure TFrm_SCGL_BFJC.FormShow(Sender: TObject);
begin
  vSuccess := False;
  stg_BFJC.ColBuddy[c_BFJC_BCJCYL] := 'edt_Temp';
  stg_BFJC.ColWidths[c_BFJC_DetailsID] := 0;
end;

procedure TFrm_SCGL_BFJC.btn_okClick(Sender: TObject);
const
  c_HDJG = 4;
  c_JC   = 5;
var
  i, iBCJCYL, iDetailsID, iSCZT: Integer;
  sInsertSQL, sSqlData: string;
  sDetailsID,sScrqFieldName,sCzrFieldName: string;
begin
  vSuccess := False;
  if not IsCheck then Exit;
  sInsertSQL := '';
  sDetailsID := '';
  for i := 1 to stg_BFJC.RowCount -1 do
  begin
    iBCJCYL := StrToNum(stg_BFJC.Cells[c_BFJC_BCJCYL,i]);
    iDetailsID := StrToNum(stg_BFJC.Cells[c_BFJC_DetailsID,i]);
    if sInsertSQL = '' then
      sInsertSQL := Format(' Select %d,%d ',[iDetailsID,iBCJCYL])
    else
      sInsertSQL := sInsertSQL + Format(' union all Select %d,%d ',[iDetailsID,iBCJCYL]);
    if iBCJCYL = StrToNum(stg_BFJC.Cells[c_BFJC_WJCYL,i]) then
      sDetailsID := IntToStr(iDetailsID) +',' + sDetailsID;
  end;
  if sDetailsID <> '' then
  begin
    sDetailsID := Copy(sDetailsID,1,Length(sDetailsID)-1);
  end;

  DM_DataBase.Con_YDPrint.BeginTrans;

  try
    if sDetailsID <> ''  then
    begin
      iSCZT := c_HDJG;
      sScrqFieldName := 'F_dYZDRQ';
      sCzrFieldName := 'F_iYZDCZRID';
      sSqlData := ' Update DO_WorkOrderDetails set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d where F_iID in (%s)  ';
      sSqlData := sSqlData + ' Update DO_WorkOrderPrtProc set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d from DO_WorkOrderPrtProc a '
        +' where not exists(Select 1 from DO_WorkOrderDetails where F_iSczt<%d and F_iWorkID=a.F_iWorkID and F_iGroupID=a.F_iGroupID) '
        +' and F_iID = %d ';
      sSqlData := sSqlData+' Update DO_ProductDate_Log set %s=Getdate(),%s=%d  from DO_ProductDate_Log  a '
        +' ,DO_WorkOrderPrtProc b where a.F_iWorkID=b.F_iWorkID and a.F_iGroupID=b.F_iGroupID and a.F_iWorkID=b.F_iWorkID and b.F_iID = %d '
        +' and not exists(Select 1 from DO_WorkOrderDetails where F_iSczt<%d and F_iWorkID=a.F_iWorkID and F_iGroupID=a.F_iGroupID)';
      sSqlData := sSqlData + ' Update DO_WorkOrder set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d from DO_WorkOrder a where a.F_iID = %d '
        +' and not exists(Select 1 from DO_WorkOrderDetails where F_iSczt<%d and F_iWorkID=a.F_iID ) ';
      DM_DataBase.ExecQuery(sSqlData,[iSczt,LoginData.m_iUserID,sDetailsID
        ,iSczt,LoginData.m_iUserID,iSczt,vJTXXID
        ,sScrqFieldName,sCzrFieldName,LoginData.m_iUserID,vJTXXID,iSczt
        ,iSczt,LoginData.m_iUserID,vWorkID,iSczt],True);
    end;


    sSqlData := 'create table #ApartID (F_iApartID int ,F_iDetailsID int,F_iSL int) ';
    sSqlData := sSqlData + ' insert into #ApartID (F_iDetailsID,F_iSL) ' + sInsertSQL;
    DM_DataBase.ExecQuery(sSqlData,[],True);
    sSqlData := ' p_jcgl ''%s''';
    DM_DataBase.ExecQuery(sSqlData,[sDetailsID],True);
    sSqlData := 'drop table #ApartID';
    DM_DataBase.ExecQuery(sSqlData,[],True);

    if sDetailsID <> ''  then
    begin
      iSCZT := c_JC;
      sScrqFieldName := 'F_dYJCRQ';
      sCzrFieldName := 'F_iYJCCZRID';
      sSqlData := ' Update DO_WorkOrderDetails set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d where F_iID in (%s)  ';
      sSqlData := sSqlData + ' Update DO_WorkOrderPrtProc set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d from DO_WorkOrderPrtProc a '
        +' where not exists(Select 1 from DO_WorkOrderDetails where F_iSczt<%d and F_iWorkID=a.F_iWorkID and F_iGroupID=a.F_iGroupID) '
        +' and F_iID = %d ';
      sSqlData := sSqlData+' Update DO_ProductDate_Log set %s=Getdate(),%s=%d  from DO_ProductDate_Log  a '
        +' ,DO_WorkOrderPrtProc b where a.F_iWorkID=b.F_iWorkID and a.F_iGroupID=b.F_iGroupID and a.F_iWorkID=b.F_iWorkID and b.F_iID =%d '
        +' and not exists(Select 1 from DO_WorkOrderDetails where F_iSczt<%d and F_iWorkID=a.F_iWorkID and F_iGroupID=a.F_iGroupID)';
      sSqlData := sSqlData + ' Update DO_WorkOrder set F_iSczt=%d,F_dCzrq=Getdate(),F_iCzrID=%d from DO_WorkOrder a where a.F_iID = %d '
        +' and not exists(Select 1 from DO_WorkOrderDetails where F_iSczt<%d and F_iWorkID=a.F_iID ) ';
      DM_DataBase.ExecQuery(sSqlData,[iSczt,LoginData.m_iUserID,sDetailsID
        ,iSczt,LoginData.m_iUserID,iSczt,vJTXXID
        ,sScrqFieldName,sCzrFieldName,LoginData.m_iUserID,vJTXXID,iSczt
        ,iSczt,LoginData.m_iUserID,vWorkID,iSczt],True);
    end;
    DM_DataBase.Con_YDPrint.CommitTrans;
  except
    on E: Exception do
    begin
      DM_DataBase.Con_YDPrint.RollbackTrans;
      Application.MessageBox(PChar('Ê§°Ü:'+E.message),'ÌáÊ¾',MB_ICONINFORMATION);
    end;
  end;

  vSuccess := True;
  Close;
end;

function TFrm_SCGL_BFJC.IsCheck: Boolean;
begin
  Result := False;

  Result := True;
end;

end.
