unit uFrm_DataArcProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, iGrid, StdCtrls;

type
  TProgress=class(TThread)
  private
    g_MaxID: Integer;
    procedure  p_Progress;    //进度
  protected
    procedure   Execute;override;
  end;

  TFrm_DataArcProgress = class(TForm)
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    lab: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_DataArcProgress: TFrm_DataArcProgress;

implementation

{$R *.dfm}

procedure TFrm_DataArcProgress.FormShow(Sender: TObject);
begin

end;

{ TProgress }

procedure TProgress.Execute;
begin
  inherited;
  p_Progress;
end;

procedure TProgress.p_Progress;
var
  item: TListItem;
  i: Integer;
begin
//  with Frm_DataArcProgress do
//  begin
//    stg_Progress.Cells[1,1] := '订单数据';
//    Sleep(1000);
//    stg_Progress.Cells[1,2] := '工单数据';
//    Sleep(1000);
//    stg_Progress.Cells[1,3] := '发货数据';
//    Application.ProcessMessages;
//    Sleep(1000);
//    for i := 1 to stg_Progress.RowCount -1 do
//    begin
//      stg_Progress.Cells[2,i] := '进行中';
//      Sleep(1000);
//    end;
//  end;
end;

procedure TFrm_DataArcProgress.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Frm_DataArcProgress := nil;
end;

end.
