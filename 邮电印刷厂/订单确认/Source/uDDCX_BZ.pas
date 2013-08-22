unit uDDCX_BZ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzEdit, RzButton,ADODB, ExtCtrls, RzCmboBx, iComboBox;

type
  TFrm_DDCX_BZ = class(TForm)
    Label1: TLabel;
    mmo_cxbz: TRzMemo;
    Label2: TLabel;
    btn_ok: TRzButton;
    btn_cancel: TRzButton;
    lab_cpbh: TLabel;
    Bevel1: TBevel;
    cbb_cxfs: Ti_ComboBox;
    procedure btn_okClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vOrderID,vOrderType: integer;
  end;

var
  Frm_DDCX_BZ: TFrm_DDCX_BZ;

implementation

uses
  uDM_DataBase,uPub_Type;
{$R *.dfm}

procedure TFrm_DDCX_BZ.btn_okClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
begin
  if vOrderType = 0 then
    sSqlData := 'Update BI_CustomOrderDetails Set F_tiCXBZ=1,F_sCXYY=''%s'',F_sCXBZ=''%s'',F_sCXRBM=''%s'',F_dCXRQ=GetDate() where F_iID=%d'
  else if vOrderType = 1 then
    sSqlData := 'Update BI_SellOrderDetails Set F_tiCXBZ=1,F_sCXYY=''%s'',F_sCXBZ=''%s'',F_sCXRBM=''%s'',F_dCXRQ=GetDate() where F_iID=%d';
  DM_DataBase.ExecQuery(sSqlData,[cbb_cxfs.Text,mmo_cxbz.Text,LoginData.m_sUserName,vOrderID],False);

end;

end.
