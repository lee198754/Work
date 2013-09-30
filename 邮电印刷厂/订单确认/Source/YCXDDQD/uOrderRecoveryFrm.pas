unit uOrderRecoveryFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, ADODB,uBaseForm;

type
  TFrm_OrderRecovery = class(TForm)
    gb_HFDD: TGroupBox;
    lal_Cxr: TLabel;
    lab_Cpbh: TLabel;
    edt_CXR: TEdit;
    edt_CPBH: TEdit;
    lal_Hfyy: TLabel;
    mem_HFYY: TMemo;
    lal_hfr: TLabel;
    edt_HFR: TEdit;
    btn_QUXIAO: TButton;
    btn_QUEDING: TButton;
    lal_cxyy: TLabel;
    edt_CXYY: TEdit;
    lal_cxbz: TLabel;
    edt_CXBZ: TEdit;
    lal_cxrq: TLabel;
    edt_CXRQ: TEdit;
    lbl_sczts: TLabel;
    lal_czrbm: TLabel;
    edt_CZRBM: TEdit;
    lal_ddid: TLabel;
    edt_DDID: TEdit;
    procedure btn_QUXIAOClick(Sender: TObject);
    procedure btn_QUEDINGClick(Sender: TObject);
    procedure mem_HFYYKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    FOrderType:Integer;
    { Public declarations }
  end;

var
  Frm_OrderRecovery: TFrm_OrderRecovery;

implementation

uses
  uDM_DataBase,uPub_Func;

{$R *.dfm}


procedure TFrm_OrderRecovery.btn_QUXIAOClick(Sender: TObject);
begin
  Close;
end;

procedure TFrm_OrderRecovery.btn_QUEDINGClick(Sender: TObject);
var
  Str,sSqlData:string;
begin
  mem_HFYY.Lines.Text:='';
  str:=FormatDateTime('yyyy-mm-dd hh:MM:ss',now);
  try
    DM_DataBase.Con_YDPrint.BeginTrans;
    if  FOrderType=0 then
    begin
      sSqlData := 'insert into Log_OrderOperation (F_iType,F_iOrderID,F_tiOrderType,F_sOperatorCode,F_dOperationTime,F_sContent) values (3,'''+trim( edt_ddid.text)+''',0,'''+trim( edt_cxrq.text)+''','''+str+''','''+trim(mem_hfyy.Lines.Text)+''')';
      sSqlData := sSqlData + ' update BI_CustomOrderDetails set F_tiCXBZ=0,F_sCXYY='''',F_sCXBZ='''',F_dCXRQ = null where F_iID='+trim( edt_ddid.Text);
    end
    else if FOrderType=1 then
    begin
      sSqlData := 'insert into Log_OrderOperation (F_iType,F_iOrderID,F_tiOrderType,F_sOperatorCode,F_dOperationTime,F_sContent) values (3,'''+trim( edt_ddid.text)+''',1,'''+trim(edt_cxrq.text)+''','''+str+''','''+trim(mem_hfyy.Lines.Text)+''')';
      sSqlData := sSqlData + ' update BI_SellOrderDetails set F_tiCXBZ=0,F_sCXBZ='''',F_sCXBZ='''',F_dCXRQ = null where F_iID='+trim(edt_ddid.Text);
    end;
    DM_DataBase.ExecQuery(sSqlData,[],True);
    DM_DataBase.Con_YDPrint.CommitTrans;
    p_MessageBoxDlg('恢复成功！');
    Close;
  except
    on E: Exception do
    begin
      DM_DataBase.Con_YDPrint.RollbackTrans;
      p_MessageBoxDlg('恢复失败:'+E.message);
    end;
  end;
end;

procedure TFrm_OrderRecovery.mem_HFYYKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i:integer;
  StrM:pchar;
begin
  StrM:=pchar(mem_hfyy.Lines.text);
  i:=strlen(StrM);
  i:=i div 2+1;
  lbl_sczts.Caption:=Format('还可以输入%d 个字',[100-i]);
end;

end.

