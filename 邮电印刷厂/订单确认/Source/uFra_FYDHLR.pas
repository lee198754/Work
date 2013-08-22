unit uFra_FYDHLR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, iGrid, RzButton, StdCtrls, ExtCtrls, RzPanel,
  ADODB, ButtonEdit;

type
  TFra_FYDHLR = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    RzGroupBox2: TRzGroupBox;
    edt_cpbh: Ti_TxtFilter;
    edt_fhdh: Ti_TxtFilter;
    btn_cx: TRzButton;
    RzPanel2: TRzPanel;
    btn_Save: TRzBitBtn;
    RzPanel1: TRzPanel;
    RzBitBtn1: TRzBitBtn;
    OpenDialog1: TOpenDialog;
    rb_fydh: TRzGroupBox;
    stg_fydh: Ti_StgEdit;
    edt_Temp: TEdit;
    RzBitBtn2: TRzBitBtn;
    RzBitBtn3: TRzBitBtn;
    procedure edt_TempKeyPress(Sender: TObject; var Key: Char);
    procedure edt_TempExit(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure stg_fydhLinkClick(Sender: TObject; ACol, ARow: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

uses
  uDM_DataBase, PubStr, uPub_Func, uPub_Type, DB;

{$R *.dfm}

const
  c_XQTXM       = 0;
  c_FYDH        = 1;
  c_CPBH        = 2;
  c_YZTMC       = 3;
  c_CZ          = 4;
  c_SYKC        = 5;
  c_YFHZL       = 6;
  c_WFHZL       = 7;
  c_OrderType   = 8;
  c_OrderID     = 9;

procedure TFra_FYDHLR.FraShow;
var
  sSqlData: string;
begin

  stg_fydh.ColBuddy[c_XQTXM] := 'edt_Temp';
  stg_fydh.ColBuddy[c_FYDH] := 'edt_Temp';
  stg_fydh.ColWidths[c_SYKC] := 0;
  stg_fydh.ColWidths[c_YFHZL] := 0;
  stg_fydh.ColWidths[c_WFHZL] := 0;
  stg_fydh.ColWidths[c_OrderType] := 0;
  stg_fydh.ColWidths[c_OrderID] := 0;

  stg_fydh.p_SetColSortType(0,c_SetColSortType_Str );
  stg_fydh.p_SetColSortType(1,c_SetColSortType_Str );
  stg_fydh.p_SetColSortType(2,c_SetColSortType_Str );
  stg_fydh.p_SetColSortType(3,c_SetColSortType_Str );

end;

procedure TFra_FYDHLR.edt_TempKeyPress(Sender: TObject; var Key: Char);

begin
  if Key = #13 then
  begin

  end;
end;

procedure TFra_FYDHLR.edt_TempExit(Sender: TObject);
var
  sSqlData: string;
  ADOQ_Rec: TADOQuery;
  iSBID,iTXMNJBZ: integer;
  sYZTMC: string;
begin
    if stg_fydh.Row = stg_fydh.RowCount -1 then
      stg_fydh.RowCount := stg_fydh.RowCount + 1;
    case stg_fydh.Col of
      c_XQTXM:
        begin
          if Trim(TEdit(Sender).Text) <> '' then
          begin
            iSBID := StrToNum(Copy(Trim(TEdit(Sender).Text),2,10));
            iTXMNJBZ := StrToNum(Copy(Trim(TEdit(Sender).Text),12,1));
            sSqlData := 'if exists(Select 1 from BI_CustomOrderDetails where F_iDetailsID=%d ) ';
            sSqlData := sSqlData + 'Select * from BI_CustomOrderDetails where F_iDetailsID=%d ';
            sSqlData := sSqlData + ' else Select * from BI_SellOrderDetails where F_iDetailsID=%d ';
            ADOQ_Rec := DM_DataBase.OpenQuery(sSqlData,[iSBID,iSBID,iSBID]);
            if Assigned(ADOQ_Rec) and (ADOQ_Rec.RecordCount > 0) then
            begin
              with ADOQ_Rec do
              begin
                stg_fydh.Cells[c_CPBH,stg_fydh.Row] := FieldByName('F_sCPBH').AsString;
                sYZTMC := FieldByName('F_sYZTMC').AsString;
                if (sYZTMC <> '无邮资图') and (iTXMNJBZ=2) then
                  sYZTMC := '无邮资图';
                stg_fydh.Cells[c_YZTMC,stg_fydh.Row] := sYZTMC;

              end;
            end;
            stg_fydh.Cells[c_CZ,stg_fydh.Row] := '删除';
            stg_fydh.CellsLink[c_CZ,stg_fydh.Row] := '删除';
          end else
          begin
            stg_fydh.Cells[c_FYDH,stg_fydh.Row] := '';
            stg_fydh.Cells[c_CPBH,stg_fydh.Row] := '';
            stg_fydh.Cells[c_YZTMC,stg_fydh.Row] := '';
          end;
          //stg_fydh.Col := c_FYDH;
        end;

      c_FYDH:
        begin
          //stg_fydh.RowCount := stg_fydh.RowCount +1;
          //stg_fydh.Row := stg_fydh.Row + 1;
          //stg_fydh.Col := c_XQTXM;
        end;
    end;
end;

procedure TFra_FYDHLR.RzBitBtn1Click(Sender: TObject);
var
  F: TextFile;
  S, sSqlData, sYZTMC: string;
  i, n, iSBID, iNJBZ, iTXMNJBZ:Integer;
  ADOQ_Rec: TADOQuery;
  sXQTXM,sFYDH: string;
  iFlag: integer;
begin
  ADOQ_Rec := nil;
  iFlag := TRzBitBtn(Sender).Tag;
  if OpenDialog1.Execute then            { Display Open dialog box }
  begin
    stg_fydh.Clear;
    AssignFile(F, OpenDialog1.FileName); //绑定文件到文件类型变量
    Reset(F);//打开一个存在的文件,另Rewrite创建文件并打开
    //stg_fydh.RowCount := iif(ADO_Data.RecordCount > 0, ADO_Data.RecordCount +1, 2);
    n := 1;
    while not eof(F) do begin
      stg_fydh.RowCount := n+1;
      Readln(F, S);
      sXQTXM := PosCopy(S,',',1);
      sFYDH := PosCopy(S,',',2);
      case iFlag of
        1:sFYDH := '自提';
        2:sFYDH := '邮袋';
      end;
      stg_fydh.Cells[c_XQTXM,n] := sXQTXM;
      if (sXQTXM <> '') and (Length(sXQTXM) >= 11) then
      begin
        iSBID := StrToNum(Copy(Trim(s),2,10));
        iTXMNJBZ := StrToNum(Copy(Trim(s),12,1));
        sSqlData := 'if exists(Select 1 from BI_CustomOrderDetails where F_iDetailsID=%d ) ';
        sSqlData := sSqlData + 'Select F_iOrderID=F_iID,F_tiOrderType=0,F_sCPBH,F_sYZTMC from BI_CustomOrderDetails where F_iDetailsID=%d ';
        sSqlData := sSqlData + ' else Select F_iOrderID=F_iID,F_tiOrderType=1,F_sCPBH,F_sYZTMC from BI_SellOrderDetails where F_iDetailsID=%d ';
        ADOQ_Rec := DM_DataBase.OpenQuery(sSqlData,[iSBID,iSBID,iSBID]);
        if Assigned(ADOQ_Rec) and (ADOQ_Rec.RecordCount > 0) then
        begin
          with ADOQ_Rec do
          begin
            stg_fydh.Cells[c_CPBH,n] := FieldByName('F_sCPBH').AsString;
            sYZTMC := FieldByName('F_sYZTMC').AsString;
            if (sYZTMC <> '无邮资图') and (iTXMNJBZ=2) then
              sYZTMC := '无邮资图';
            stg_fydh.Cells[c_YZTMC,n] := sYZTMC;
            stg_fydh.Cells[c_OrderID,n] := FieldByName('F_iOrderID').AsString;
            stg_fydh.Cells[c_OrderType,n] := FieldByName('F_tiOrderType').AsString;
          end;
        end;
        stg_fydh.Cells[c_CZ,n] := '删除';
        stg_fydh.CellsLink[c_CZ,n] := '删除';

      end;

      stg_fydh.Cells[c_FYDH,n] := sFYDH;
      Inc(n)
    end;
    CloseFile(F);
    if Assigned(ADOQ_Rec) then
      ADOQ_Rec.Free;
    rb_fydh.Caption := '运输单号 共导入 '+IntToStr(stg_fydh.RowCount-1) + '条';
  end;
 { if stg_fydh.Col = 0 then
  begin
    stg_fydh.Col := 1;
  end
  else if stg_fydh.Col = 1 then
  begin
    stg_fydh.Col := 0;
    stg_fydh.Row := stg_fydh.Row + 1;
  end;     }

end;

procedure TFra_FYDHLR.btn_SaveClick(Sender: TObject);
var
  i, j: Integer;
  ADO_Rec: TADOQuery;
  sSqlData: string;
begin
  for i := 1 to stg_fydh.RowCount -1 do
  begin
    if (stg_fydh.Cells[c_XQTXM,i]<>'') and (stg_fydh.Cells[c_CPBH,i]='') then
    begin
      if p_MessageBoxDlg('其中有未进行匹配的条形码,是否进行导入?','提示',MB_ICONINFORMATION+MB_YESNO) = IDNO then
      begin
        stg_fydh.Row := i;
        Exit;
      end;
    end;
  end;
  try
    DM_DataBase.Con_YDPrint.BeginTrans;
   //发运单号录入
    sSqlData := 'create table #fydh (F_sTXM varchar(50),F_sFYDH varchar(50),F_sCZRBM varchar(50),F_iOrderID int,F_tiOrderType int) ';
    sSqlData := sSqlData+'select * from #fydh';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[],True);
    for i := 1 to stg_fydh.RowCount -1 do
    begin
      if stg_fydh.Cells[c_XQTXM,i]<>'' then
      begin
        ADO_Rec.Insert;
        ADO_Rec.FieldByName('F_sTXM').AsString := stg_fydh.Cells[c_XQTXM,i];
        ADO_Rec.FieldByName('F_sFYDH').AsString := stg_fydh.Cells[c_FYDH,i];
        ADO_Rec.FieldByName('F_sCZRBM').AsString := LoginData.m_sUserName;
        ADO_Rec.FieldByName('F_iOrderID').AsString := stg_fydh.Cells[c_OrderID,i];
        ADO_Rec.FieldByName('F_tiOrderType').AsString := stg_fydh.Cells[C_OrderType,i];
        ADO_Rec.Post;
      end;
    end;
    sSqlData := 'exec p_fydhrl ';
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
    
    sSqlData := 'drop table #fydh  ';
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

procedure TFra_FYDHLR.stg_fydhLinkClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  if ACol = c_CZ then
  begin
   if stg_fydh.RowCount <= 2 then
    stg_fydh.Clear
   else
     stg_fydh.DelRow(ARow);
  end;
end;

end.

