unit uFra_WarehEntryBarCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Grids, iGrid, RzButton, RzPanel, ButtonEdit, ExtCtrls,
  ADODB;

type
  TFra_WarehEntryBarCode = class(TFrame)
    RzGroupBox2: TRzGroupBox;
    RzPanel1: TRzPanel;
    RzBitBtn1: TRzBitBtn;
    rb_fydh: TRzGroupBox;
    stg_jctxm: Ti_StgEdit;
    edt_Temp: TEdit;
    RzPanel2: TRzPanel;
    btn_Save: TRzBitBtn;
    OpenDialog1: TOpenDialog;
    procedure RzBitBtn1Click(Sender: TObject);
    procedure stg_jctxmLinkClick(Sender: TObject; ACol, ARow: Integer);
    procedure btn_SaveClick(Sender: TObject);
    procedure edt_TempExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

uses
  uDM_DataBase,PubStr,uPub_Type,uPub_Text,uPub_Func;

{$R *.dfm}

const
  c_XQTXM       = 0;
  c_CPBH        = 1;
  c_YZTMC       = 2;
  c_CZ          = 3;
  c_SYKC        = 4;
  c_YFHZL       = 5;
  c_WFHZL       = 6;
  c_ApartID     = 7;
  c_OrderType   = 8;
  c_OrderID     = 9;

procedure TFra_WarehEntryBarCode.RzBitBtn1Click(Sender: TObject);
var
  F: TextFile;
  S, sSqlData: string;
  i, n, iSBID, iNJBZ, iTXMNJBZ:Integer;
  ADOQ_Rec: TADOQuery;
  sXQTXM,sDDWH: string;
  iFlag: integer;
begin
  RzBitBtn1.Caption := '进仓导入中...';
  ADOQ_Rec := nil;
  iFlag := TRzBitBtn(Sender).Tag;
  if OpenDialog1.Execute then            { Display Open dialog box }
  begin
    stg_jctxm.Clear;
    AssignFile(F, OpenDialog1.FileName); //绑定文件到文件类型变量
    Reset(F);//打开一个存在的文件,另Rewrite创建文件并打开
    //stg_fydh.RowCount := iif(ADO_Data.RecordCount > 0, ADO_Data.RecordCount +1, 2);
    n := 1;
    while not eof(F) do begin
      stg_jctxm.RowCount := n+1;
      Readln(F, S);
      sXQTXM := PosCopy(S,',',1);
      stg_jctxm.Cells[c_XQTXM,n] := sXQTXM;
      if (sXQTXM <> '') and (Length(sXQTXM) >= 14) then
      begin
        iSBID := StrToNum(Copy(Trim(s),2,10));
        sDDWH := Copy(Trim(s),13,2);
        iTXMNJBZ := StrToNum(Copy(Trim(s),12,1));
        case iTXMNJBZ of
          2: iNJBZ:=1;
        else
          iNJBZ:=0;
        end;
        if sDDWH <> '99' then
        begin
          //产品编号尾数不一定=套内号,地方版套内号01,产品编号是00,所以用right(a.F_sCPBH,2)=''00'' or right(a.F_sCPBH,2)=''%s''
          sSqlData := 'select F_iID F_iApartID,F_iOrderID,F_tiOrderType,F_sCPBH,F_sYZTMC from DO_OrderApart a where F_tiNJBZ=%d and (right(a.F_sCPBH,2)=''00'' or right(a.F_sCPBH,2)=''%s'' ) ';
          sSqlData := sSqlData + 'and ((F_tiOrderType=0 and exists(select 1 from dbo.BI_CustomOrderDetails where  F_iID=a.F_iOrderID and F_iDetailsID=%d))'
            +'  or (F_tiOrderType=1 and exists(select 1 from dbo.BI_SellOrderDetails where  F_iID=a.F_iOrderID and F_iDetailsID=%d)) )  ';
          ADOQ_Rec := DM_DataBase.OpenQuery(sSqlData,[iNJBZ,sDDWH,iSBID,iSBID]);
        end else
        begin
          sSqlData := 'if exists(Select 1 from BI_CustomOrderDetails where F_iDetailsID=%d ) ';
          sSqlData := sSqlData + 'Select F_iApartID=0,F_iID F_iOrderID,F_tiOrderType=0,F_sCPBH,F_sYZTMC from BI_CustomOrderDetails where F_iDetailsID=%d ';
          sSqlData := sSqlData + ' else Select F_iApartID=0,F_iID F_iOrderID,F_tiOrderType=1,F_sCPBH,F_sYZTMC from BI_SellOrderDetails where F_iDetailsID=%d ';
          ADOQ_Rec := DM_DataBase.OpenQuery(sSqlData,[iSBID,iSBID,iSBID]);
        end;
        if Assigned(ADOQ_Rec) and (ADOQ_Rec.RecordCount > 0) then
        begin
          with ADOQ_Rec do
          begin
            stg_jctxm.Cells[c_CPBH,n] := FieldByName('F_sCPBH').AsString;
            stg_jctxm.Cells[c_YZTMC,n] := FieldByName('F_sYZTMC').AsString;
            stg_jctxm.Cells[c_ApartID,n] := FieldByName('F_iApartID').AsString;;
            stg_jctxm.Cells[c_OrderID,n] := FieldByName('F_iOrderID').AsString;;
            stg_jctxm.Cells[c_OrderType,n] := FieldByName('F_tiOrderType').AsString;;
          end;
        end;
        stg_jctxm.Cells[c_CZ,n] := '删除';
        stg_jctxm.CellsLink[c_CZ,n] := '删除';

      end;

      Inc(n)
    end;
    CloseFile(F);
    if Assigned(ADOQ_Rec) then
      ADOQ_Rec.Free;
    rb_fydh.Caption := '进仓条形码 共导入 '+IntToStr(stg_jctxm.RowCount-1) + '条';
  end;
  RzBitBtn1.Caption := '进仓导入';
end;

procedure TFra_WarehEntryBarCode.stg_jctxmLinkClick(Sender: TObject; ACol, ARow: Integer);
begin
  if ACol = c_CZ then
  begin
   if stg_jctxm.RowCount <= 2 then
     stg_jctxm.Clear
   else
     stg_jctxm.DelRow(ARow);
  end;

end;

procedure TFra_WarehEntryBarCode.btn_SaveClick(Sender: TObject);
var
  i, j: Integer;
  ADO_Rec: TADOQuery;
  sSqlData: string;
begin
  for i := 1 to stg_jctxm.RowCount -1 do
  begin
    if (stg_jctxm.Cells[c_XQTXM,i]<>'') and (stg_jctxm.Cells[c_CPBH,i]='') then
    begin
      if p_MessageBoxDlg('其中有未进行匹配的条形码,是否进行导入?','提示',MB_ICONINFORMATION+MB_YESNO) = IDNO then
      begin
        stg_jctxm.Row := i;
        Exit;
      end;
    end;
  end;
  try
    DM_DataBase.Con_YDPrint.BeginTrans;
   //发运单号录入
    sSqlData := 'create table #jctxm (F_sTXM varchar(50),F_iApartID int,F_iOrderID int,F_tiOrderType tinyint,F_sCZRBM varchar(50)) ';
    sSqlData := sSqlData+'select * from #jctxm';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[],True);
    for i := 1 to stg_jctxm.RowCount -1 do
    begin
      if stg_jctxm.Cells[c_XQTXM,i]<>'' then
      begin
        ADO_Rec.Insert;
        ADO_Rec.FieldByName('F_sTXM').AsString := stg_jctxm.Cells[c_XQTXM,i];
        ADO_Rec.FieldByName('F_iApartID').AsInteger := StrToNum(stg_jctxm.Cells[c_ApartID,i]);
        ADO_Rec.FieldByName('F_iOrderID').AsInteger := StrToNum(stg_jctxm.Cells[c_OrderID,i]);
        ADO_Rec.FieldByName('F_tiOrderType').AsInteger := StrToNum(stg_jctxm.Cells[c_OrderType,i]);
        ADO_Rec.FieldByName('F_sCZRBM').AsString := LoginData.m_sUserName;
        ADO_Rec.Post;
      end;
    end;
    sSqlData := 'exec p_jctxmrl ';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[],True);
    if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
    begin
      if ADO_Rec.FieldByName('Flag').AsInteger = 1 then
      begin
        p_MessageBoxDlg(ADO_Rec.FieldByName('Hint').AsString);
      end;
    end;
    if Assigned(ADO_Rec) then
      ADO_Rec.Free;
    
    sSqlData := 'drop table #jctxm  ';
    DM_DataBase.ExecQuery(sSqlData,[],True);
    DM_DataBase.Con_YDPrint.CommitTrans;
  except
    on E: Exception do
    begin
      DM_DataBase.Con_YDPrint.RollbackTrans;
      p_MessageBoxDlg('错误:'+E.message);
      Exit;
    end;

  end;
end;

procedure TFra_WarehEntryBarCode.FraShow;
begin
  stg_jctxm.ColBuddy[c_XQTXM] := 'edt_Temp';
  stg_jctxm.ColWidths[c_SYKC] := 0;
  stg_jctxm.ColWidths[c_YFHZL] := 0;
  stg_jctxm.ColWidths[c_WFHZL] := 0;
  stg_jctxm.ColWidths[c_ApartID] := 0;
  stg_jctxm.ColWidths[c_OrderType] := 0;
  stg_jctxm.ColWidths[c_OrderID] := 0;

  stg_jctxm.p_SetColSortType(0,c_SetColSortType_Str );
  stg_jctxm.p_SetColSortType(1,c_SetColSortType_Str );
  stg_jctxm.p_SetColSortType(2,c_SetColSortType_Str );


end;

procedure TFra_WarehEntryBarCode.edt_TempExit(Sender: TObject);
var
  sSqlData: string;
  ADOQ_Rec: TADOQuery;
  iSBID: integer;
  s,sDDWH: string;
  iTXMNJBZ,iNJBZ: integer;
begin
    if stg_jctxm.Row = stg_jctxm.RowCount -1 then
      stg_jctxm.RowCount := stg_jctxm.RowCount + 1;
    s := TEdit(Sender).Text;
    case stg_jctxm.Col of
      c_XQTXM:
        begin
          if Trim(s) <> '' then
          begin
            iSBID := StrToNum(Copy(Trim(s),2,10));
            sDDWH := Copy(Trim(s),13,2);
            iTXMNJBZ := StrToNum(Copy(Trim(s),12,1));
            case iTXMNJBZ of
              2: iNJBZ:=1;
            else
              iNJBZ:=0;
            end;
            if sDDWH <> '99' then
            begin
              sSqlData := 'select F_iID F_iApartID,F_sCPBH,F_sYZTMC,F_iOrderID,F_tiOrderType from DO_OrderApart a where F_tiNJBZ=%d and (right(a.F_sCPBH,2)=''00'' or right(a.F_sCPBH,2)=''%s'' ) ';
              sSqlData := sSqlData + 'and ((F_tiOrderType=0 and exists(select 1 from dbo.BI_CustomOrderDetails where  F_iID=a.F_iOrderID and F_iDetailsID=%d))'
                +'  or (F_tiOrderType=1 and exists(select 1 from dbo.BI_SellOrderDetails where  F_iID=a.F_iOrderID and F_iDetailsID=%d)) )  ';
              ADOQ_Rec := DM_DataBase.OpenQuery(sSqlData,[iNJBZ,sDDWH,iSBID,iSBID]);
            end else
            begin
              sSqlData := 'if exists(Select 1 from BI_CustomOrderDetails where F_iDetailsID=%d ) ';
              sSqlData := sSqlData + 'Select F_iApartID=0,F_iID F_iOrderID,F_tiOrderType=0,F_sCPBH,F_sYZTMC from BI_CustomOrderDetails where F_iDetailsID=%d ';
              sSqlData := sSqlData + ' else Select F_iApartID=0,F_iID F_iOrderID,F_tiOrderType=1,F_sCPBH,F_sYZTMC from BI_SellOrderDetails where F_iDetailsID=%d ';
              ADOQ_Rec := DM_DataBase.OpenQuery(sSqlData,[iSBID,iSBID,iSBID]);
            end;
            if Assigned(ADOQ_Rec) and (ADOQ_Rec.RecordCount > 0) then
            begin
              with ADOQ_Rec do
              begin
                stg_jctxm.Cells[c_CPBH,stg_jctxm.Row]       := FieldByName('F_sCPBH').AsString;
                stg_jctxm.Cells[c_YZTMC,stg_jctxm.Row]      := FieldByName('F_sYZTMC').AsString;
                stg_jctxm.Cells[c_ApartID,stg_jctxm.Row]    := FieldByName('F_iApartID').AsString;;
                stg_jctxm.Cells[c_OrderID,stg_jctxm.Row]    := FieldByName('F_iOrderID').AsString;;
                stg_jctxm.Cells[c_OrderType,stg_jctxm.Row]  := FieldByName('F_tiOrderType').AsString;;

              end;
            end else
            begin
              stg_jctxm.Cells[c_CPBH,stg_jctxm.Row]       := '';
              stg_jctxm.Cells[c_YZTMC,stg_jctxm.Row]      := '';
              stg_jctxm.Cells[c_ApartID,stg_jctxm.Row]    := '';
              stg_jctxm.Cells[c_OrderID,stg_jctxm.Row]    := '';
              stg_jctxm.Cells[c_OrderType,stg_jctxm.Row]  := '';
            end;
            stg_jctxm.Cells[c_CZ,stg_jctxm.Row] := '删除';
            stg_jctxm.CellsLink[c_CZ,stg_jctxm.Row] := '删除';
          end else
          begin
            stg_jctxm.Cells[c_CPBH,stg_jctxm.Row] := '';
            stg_jctxm.Cells[c_YZTMC,stg_jctxm.Row] := '';
          end;
          //stg_fydh.Col := c_FYDH;
        end;
    end;
end;

end.
