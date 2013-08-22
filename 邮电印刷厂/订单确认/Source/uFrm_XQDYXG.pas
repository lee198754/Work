unit uFrm_XQDYXG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RM_Dataset, RM_System, RM_Common, RM_Class, RzButton, Grids,
  iGrid, ExtCtrls, RzPanel, ADODB, StdCtrls;

type
  TFrm_XQDYXG = class(TForm)
    RzGroupBox1: TRzGroupBox;
    stg_XQDYXG: Ti_StgEdit;
    rmr_SellPritB5: TRMReport;
    rmr_CustomPritB5: TRMReport;
    rmr_SellPrit: TRMReport;
    rmr_CustomPrit: TRMReport;
    rmdb_CartonLablePrint: TRMDBDataSet;
    RzPanel1: TRzPanel;
    btn_print: TRzBitBtn;
    btn_printB5: TRzBitBtn;
    btn_xxfz: TRzBitBtn;
    edt_Temp: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btn_printClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ReadDataXQDYXG(ADO_Data: TADOQuery);
  end;

var
  Frm_XQDYXG: TFrm_XQDYXG;

implementation

uses
  PubStr, uDM_DataBase, uPub_Func;
{$R *.dfm}

const
 c_YCPBH         = 0;              //原产品编号
 c_BT            = 1;              //标题
 c_NJBZ          = 2;              //内件标志
 c_MSBZ          = 3;              //模式标志
 c_CPBH          = 4;              //产品编号
 c_KHMC          = 5;              //客户名称
 c_DYSL          = 6;              //订印数量
 c_BXMS          = 7;              //本箱枚数
 c_ZXS           = 8;              //总箱数
 c_FXS           = 9;              //分箱号
 c_SHDW          = 10;             //收货单位
 c_SHWXX         = 11;             //收货人信息
 c_XNRJ          = 12;             //箱内兑奖(组)
 c_ZYHMD         = 13;             //准印号码段
 c_SCSGDH        = 14;             //生产施工单号
 c_YSS           = 15;             //要数省
 c_YSJG          = 16;             //要数机构
 c_TXM           = 17;             //条形码
{ TFrm_XQDYXG }

procedure TFrm_XQDYXG.ReadDataXQDYXG(ADO_Data: TADOQuery);
var
  n,j: Integer;
  sSczt,sCxbz: string;
  dDate: TDateTime;
begin
  if stg_XQDYXG.cells[c_YCPBH,1] = '' then
  begin
    stg_XQDYXG.Clear;
    stg_XQDYXG.RowCount := iif(ADO_Data.RecordCount > 0, ADO_Data.RecordCount + 1, 2);
    n := 1
  end else
  begin
    n := stg_XQDYXG.RowCount;
    stg_XQDYXG.RowCount := iif(ADO_Data.RecordCount > 0, stg_XQDYXG.RowCount + ADO_Data.RecordCount, stg_XQDYXG.RowCount);
  end;
  with ADO_Data do
  begin
    First;
    while not Eof do
    begin
      stg_XQDYXG.cells[c_YCPBH,n]  :=  FieldByName('F_sCPBH').AsString ;
      stg_XQDYXG.cells[c_BT,n]     :=  FieldByName('Title').AsString ;
      stg_XQDYXG.cells[c_NJBZ,n]   :=  FieldByName('NJBZ').AsString ;
      stg_XQDYXG.cells[c_MSBZ,n]   :=  FieldByName('MSBZ').AsString ;
      stg_XQDYXG.cells[c_CPBH,n]   :=  FieldByName('F_sCPBH').AsString ;
      stg_XQDYXG.cells[c_KHMC,n]   :=  FieldByName('F_sKHMC').AsString ;
      stg_XQDYXG.cells[c_DYSL,n]   :=  FieldByName('YL').AsString ;
      stg_XQDYXG.cells[c_BXMS,n]   :=  FieldByName('F_iCXSL').AsString ;
      stg_XQDYXG.cells[c_ZXS,n]    :=  FieldByName('F_iZXS').AsString ;
      stg_XQDYXG.cells[c_FXS,n]    :=  FieldByName('XH').AsString ;
      stg_XQDYXG.cells[c_SHDW,n]   :=  FieldByName('F_sShrdz').AsString ;
      stg_XQDYXG.cells[c_SHWXX,n]  :=  FieldByName('SHRXX').AsString ;
      stg_XQDYXG.cells[c_XNRJ,n]   :=  FieldByName('RJHD').AsString ;
      stg_XQDYXG.cells[c_ZYHMD,n]  :=  FieldByName('HMD').AsString ;
      stg_XQDYXG.cells[c_SCSGDH,n] :=  FieldByName('GDH').AsString ;
      stg_XQDYXG.cells[c_YSS,n]    :=  FieldByName('F_sSjg').AsString ;
      stg_XQDYXG.cells[c_YSJG,n]   :=  FieldByName('F_sJg').AsString ;
      stg_XQDYXG.cells[c_TXM,n]   :=  FieldByName('F_sTXM').AsString ;

      inc(n);
      Next;
    end;
  end;

end;

procedure TFrm_XQDYXG.FormShow(Sender: TObject);
begin
  stg_XQDYXG.ColBuddy[c_BT] := 'edt_Temp';
  stg_XQDYXG.ColBuddy[c_NJBZ] := 'edt_Temp';
  stg_XQDYXG.ColBuddy[c_MSBZ] := 'edt_Temp';
  stg_XQDYXG.ColBuddy[c_CPBH] := 'edt_Temp';
  stg_XQDYXG.ColBuddy[c_KHMC] := 'edt_Temp';
  stg_XQDYXG.ColBuddy[c_DYSL] := 'edt_Temp';
  stg_XQDYXG.ColBuddy[c_BXMS] := 'edt_Temp';
  stg_XQDYXG.ColBuddy[c_ZXS] := 'edt_Temp';
  stg_XQDYXG.ColBuddy[c_FXS] := 'edt_Temp';
  stg_XQDYXG.ColBuddy[c_SHDW] := 'edt_Temp';
  stg_XQDYXG.ColBuddy[c_SHWXX] := 'edt_Temp';
  stg_XQDYXG.ColBuddy[c_XNRJ] := 'edt_Temp';
  stg_XQDYXG.ColBuddy[c_ZYHMD] := 'edt_Temp';
  stg_XQDYXG.ColBuddy[c_SCSGDH] := 'edt_Temp';
  stg_XQDYXG.ColBuddy[c_YSS] := 'edt_Temp';
  stg_XQDYXG.ColBuddy[c_YSJG] := 'edt_Temp';
  stg_XQDYXG.ColWidths[c_TXM] := 0;
end;

procedure TFrm_XQDYXG.btn_printClick(Sender: TObject);
var
  i,n,iMSBZ: Integer;
  sSqlData: string;
  ADO_Rec: TADOQuery;
  iOrderType: Integer;
begin
  try
    ADO_Rec := nil;
    sSqlData := 'Create table #XQInfo (Title varchar(50),NJBZ varchar(50),'
      + ' MSBZ varchar(50),F_sCPBH varchar(50),F_sKHMC varchar(50),YL varchar(50),F_iCXSL varchar(50),'
      + ' F_iZXS varchar(50),XH varchar(50),F_sShrdz varchar(50), SHRXX varchar(50),RJHD varchar(50),'
      + ' HMD varchar(50),GDH varchar(50),F_sSjg varchar(50),F_sJg varchar(50),F_sTXM varchar(50) ) ';
    DM_DataBase.ExecQuery(sSqlData,[],True);
    sSqlData := 'select * from #XQInfo';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[],True);
    n := 1;
    for i := 1 to stg_XQDYXG.RowCount -1 do
    begin
      with ADO_Rec do
      begin
        iMSBZ := StrToNum(stg_XQDYXG.cells[c_NJBZ,n]);
        Insert;
        FieldByName('Title').AsString := stg_XQDYXG.cells[c_BT,n] ;
        FieldByName('NJBZ').AsString := stg_XQDYXG.cells[c_NJBZ,n] ;
        FieldByName('MSBZ').AsString := stg_XQDYXG.cells[c_MSBZ,n] ;
        FieldByName('F_sCPBH').AsString := stg_XQDYXG.cells[c_CPBH,n] ;
        FieldByName('F_sKHMC').AsString := stg_XQDYXG.cells[c_KHMC,n] ;
        FieldByName('YL').AsString := stg_XQDYXG.cells[c_DYSL,n] ;
        FieldByName('F_iCXSL').AsString := stg_XQDYXG.cells[c_BXMS,n] ;
        FieldByName('F_iZXS').AsString := stg_XQDYXG.cells[c_ZXS,n] ;
        FieldByName('XH').AsString := stg_XQDYXG.cells[c_FXS,n] ;
        FieldByName('F_sShrdz').AsString := stg_XQDYXG.cells[c_SHDW,n] ;
        FieldByName('SHRXX').AsString := stg_XQDYXG.cells[c_SHWXX,n] ;
        FieldByName('RJHD').AsString := stg_XQDYXG.cells[c_XNRJ,n] ;
        FieldByName('HMD').AsString := stg_XQDYXG.cells[c_ZYHMD,n] ;
        FieldByName('GDH').AsString := stg_XQDYXG.cells[c_SCSGDH,n] ;
        FieldByName('F_sSjg').AsString := stg_XQDYXG.cells[c_YSS,n] ;
        FieldByName('F_sJg').AsString := stg_XQDYXG.cells[c_YSJG,n] ;
        FieldByName('F_sTXM').AsString := stg_XQDYXG.cells[c_TXM,n] ;
        inc(n);
        Post;
      end;
    end;
    rmdb_CartonLablePrint.DataSet := ADO_Rec;
    case iMSBZ of
      0:
        begin
          if TRzBitBtn(Sender).Name = 'btn_print' then
          begin
            rmr_CustomPrit.PrepareReport;
            rmr_CustomPrit.ShowReport;
          end;
          if TRzBitBtn(Sender).Name = 'btn_printB5' then
          begin
            rmr_CustomPritB5.PrepareReport;
            rmr_CustomPritB5.ShowReport;
          end;
        end;
      1:
        begin
          if TRzBitBtn(Sender).Name = 'btn_print' then
          begin
            rmr_SellPrit.PrepareReport;
            rmr_SellPrit.ShowReport;
          end;
          if TRzBitBtn(Sender).Name = 'btn_printB5' then
          begin
            rmr_SellPritB5.PrepareReport;
            rmr_SellPritB5.ShowReport;
          end;
        end;
    end;
    sSqlData := 'drop table #XQInfo ';
    DM_DataBase.ExecQuery(sSqlData,[],True);
    ADO_Rec.Free;
  except
    on E: Exception do
    begin
      p_MessageBoxDlg('失败:'+ E.Message);
      if Assigned(ADO_Rec) then
      begin
        sSqlData := 'drop table #XQInfo ';
        DM_DataBase.ExecQuery(sSqlData,[],True);
        ADO_Rec.Free;
      end;
    end;
  end;
end;

end.
                                                                                 
                                                                                 
                                                                                 

                                                                                 


