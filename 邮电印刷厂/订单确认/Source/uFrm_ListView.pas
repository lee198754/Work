unit uFrm_ListView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, RzButton, ImgList, RzListVw;

type
  TFrm_ListView = class(TForm)
    lb_Title: TLabel;
    btn_ok: TRzButton;
    btn_close: TRzButton;
    ImageList1: TImageList;
    lv_xx: TRzListView;
    procedure lv_xxCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure btn_okClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_ListView: TFrm_ListView;

implementation

uses
  uPub_Func;

{$R *.dfm}

procedure TFrm_ListView.lv_xxCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if (Item.Index mod 2) = 0 then
    Sender.Canvas.Brush.Color := $00F0FFF0
  else
    Sender.Canvas.Brush.Color := $00F2F2F2;
  LVDrawItem(TRzListView(Sender), Item, State, DefaultDraw);
end;

procedure TFrm_ListView.btn_okClick(Sender: TObject);
begin


  ModalResult := mrOk;
end;

end.
