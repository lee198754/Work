unit uFrm_TSGYGL_Dlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ButtonEdit, ExtCtrls, Buttons;

type
  TFrm_TSGYGL_Dlg = class(TForm)
    btn_ok: TBitBtn;
    gb_TSGY: TGroupBox;
    Bevel1: TBevel;
    edt_bm: Ti_TxtFilter;
    edt_mc: Ti_TxtFilter;
    edt_dj: Ti_TxtFilter;
    procedure btn_okClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;
  end;
  function FrmTSGYGL_Dlg:TFrm_TSGYGL_Dlg;


implementation

{$R *.dfm}

var
  Frm_TSGYGL_Dlg: TFrm_TSGYGL_Dlg;

{ TFrm_TSGYGL_Dlg }

function FrmTSGYGL_Dlg: TFrm_TSGYGL_Dlg;
begin
  if not Assigned(Frm_TSGYGL_Dlg) then
    Frm_TSGYGL_Dlg := TFrm_TSGYGL_Dlg.Create(Application);
  Result := Frm_TSGYGL_Dlg;
end;

procedure TFrm_TSGYGL_Dlg.btn_okClick(Sender: TObject);
begin
  ModalResult := mrNone;

  ModalResult := mrOk;
end;

destructor TFrm_TSGYGL_Dlg.Destroy;
begin
  Frm_TSGYGL_Dlg := nil;
  inherited;
end;

end.
