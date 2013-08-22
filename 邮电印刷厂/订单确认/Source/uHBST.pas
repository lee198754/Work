unit uHBST;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, StdCtrls, ButtonEdit;

type
  TFrm_HBST = class(TForm)
    edt_Col: Ti_TxtFilter;
    edt_Row: Ti_TxtFilter;
    btn_ok: TRzButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure btn_okClick(Sender: TObject);
  private
    { Private declarations }
  public
    vSucceed: Boolean;
    { Public declarations }
  end;

var
  Frm_HBST: TFrm_HBST;

implementation

uses
  PubStr,uBSTPrint;

{$R *.dfm}

procedure TFrm_HBST.btn_okClick(Sender: TObject);
var
  iRow,iCol: integer;
begin
  vSucceed := False;
  iRow := StrToNum(edt_Row.Text);
  iCol := StrToNum(edt_Col.Text);
  if (iRow >10) or (iCol>4) or (iRow =0) or (iCol=0)then
  begin
    Application.MessageBox('行必需为:1~10行,列必需为:1~4列','提示',MB_ICONINFORMATION);
    Exit;
  end;
  Self.Visible := False;
//  if not Assigned(Frm_BSTPrint) then
//    Frm_BSTPrint := TFrm_BSTPrint.Create(Self);

  Frm_BSTPrint.vRow := iRow;
  Frm_BSTPrint.vCol := iCol;
  Frm_BSTPrint.vClose := False;
  vSucceed := True;
//  if Frm_BSTPrint.ShowModal<>mrNo then
//    Frm_BSTPrint.Free;
  Close;

end;

end.
