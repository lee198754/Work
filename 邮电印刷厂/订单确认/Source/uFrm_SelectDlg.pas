unit uFrm_SelectDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzButton;

type
  TFrm_SelectDlg = class(TForm)
    btn_A: TRzButton;
    btn_B: TRzButton;
    lab_Text: TLabel;
    procedure btn_AClick(Sender: TObject);
    procedure btn_BClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure btnClick(Sender: TObject);
  end;

var
  Frm_SelectDlg: TFrm_SelectDlg;

implementation

{$R *.dfm}

procedure TFrm_SelectDlg.btn_AClick(Sender: TObject);
begin
  ModalResult := mrYes;
end;

procedure TFrm_SelectDlg.btn_BClick(Sender: TObject);
begin
  ModalResult := mrNo;
end;

procedure TFrm_SelectDlg.btnClick(Sender: TObject);
begin
  ModalResult := TRzButton(Sender).Tag;
end;

end.
