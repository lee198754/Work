unit uFra_XHQD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, GridsEh, DBGridEh, ExtCtrls, RzPanel,
  RzButton, ComCtrls, RzDTP, StdCtrls, RzCmboBx, iComboBox,ADODB,
  DBGridEhGrouping;

type
  TFra_XHQD = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    RzGroupBox2: TRzGroupBox;
    dbg_XHQD: TDBGridEh;
    Label1: TLabel;
    dtp_kdq: TRzDateTimePicker;
    dtp_kdz: TRzDateTimePicker;
    btn_cx: TRzButton;
    btn_export: TRzButton;
    cbb_cplb: Ti_ComboBox;
    Label2: TLabel;
    SavePath: TSaveDialog;
    procedure btn_cxClick(Sender: TObject);
    procedure btn_exportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

{$R *.dfm}

uses
  uDM_DataBase, uPub_Type, uPub_Func, DBGridEhImpExp, uPub_Text ;

procedure TFra_XHQD.btn_cxClick(Sender: TObject);
var
  iCplb, iCplx, iDdlx, iXpl, iSczt: Integer;
  iYS,iMYTS: Integer;
  sKDq, sKDz: string;
  rCplx: TProductType;
  sSqlData: string;
  time, n: Integer;
begin
  Screen.Cursor := crHourGlass;
  btn_cx.Caption := '查询中...';
  iCplb := FindProductCategoryID(cbb_cplb.ItemIndex);
  sKDq := FormatDateTime('yyyy.MM.dd 00:00:00',dtp_kdq.DateTime);
  sKDz := FormatDateTime('yyyy.MM.dd 23:59:59',dtp_kdz.DateTime);
  try
    sSqlData := 'Exec p_xhqd ''%s'',''%s'',%d';
    DM_DataBase.ADO_XHQD.Close;
    DM_DataBase.ADO_XHQD.SQL.Text := Format(sSqlData,[sKDq,sKDz,iCplb]);
    DM_DataBase.ADO_XHQD.Open;
  except
    on E: Exception do
    begin
      p_MessageBoxDlg(e.Message);
    end;
  end;          
  btn_cx.Caption := '查询';
  Screen.Cursor := crDefault;
end;

procedure TFra_XHQD.FraShow;
var
  sCPLB: string;
begin
  if cbb_cplb.Text <> '' then
    sCPLB := cbb_cplb.Text;
  if sCPLB = '' then
  begin
    dtp_kdq.DateTime := Now;
    dtp_kdz.DateTime := Now;
  end;
  cbb_cplb.Clear;
  cbb_cplb.Items.Add('--全部--');
  CbbAdd(cbb_cplb,pkProductCategory);
  if sCPLB <> '' then
    cbb_cplb.ItemIndex := cbb_cplb.Items.IndexOf(sCPLB)
  else
    cbb_cplb.ItemIndex := c_Default_CPLB;
end;

procedure TFra_XHQD.btn_exportClick(Sender: TObject);
begin
  if SavePath.Execute then
  begin
    if (SavePath.FileName <> '') then
    if UpperCase(Copy(SavePath.FileName,Length(SavePath.FileName)-4,Length(SavePath.FileName))) = UpperCase('.xls') then
      SavePath.FileName := Copy(SavePath.FileName,1,Length(SavePath.FileName)-4);
    Screen.Cursor := crHourGlass;
    SaveDBGridEhToExportFile(TDBGridEhExportAsXLS,dbg_XHQD, SavePath.FileName,True);
    Screen.Cursor := crDefault;
    p_MessageBoxDlg('导出成功!')
  end;
end;

end.

