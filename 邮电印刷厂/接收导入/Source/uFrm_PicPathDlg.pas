unit uFrm_PicPathDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, Dialogs;

type
  TFrm_PicPathDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    edt_Path: TEdit;
    btn_Path: TButton;
    dlgSave_Pic: TSaveDialog;
    procedure btn_PathClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_PicPathDlg: TFrm_PicPathDlg;

implementation

uses
  Filectrl;
{$R *.dfm}

procedure TFrm_PicPathDlg.btn_PathClick(Sender: TObject);
var
  dir: string;
begin
  dir := ExtractFilePath(Application.ExeName);
  SelectDirectory('Ñ¡ÔñÂ·¾¶', '', dir);
  edt_Path.Text := dir;
//  if dlgSave_Pic.Execute then
//  begin
//    edt_Path.Text := dlgSave_Pic.FileName;
//  end;

end;

end.
