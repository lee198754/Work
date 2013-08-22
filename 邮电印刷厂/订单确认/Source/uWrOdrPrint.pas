unit uWrOdrPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel, ComCtrls, RzDTP, StdCtrls, ButtonEdit;

type
  TFrm_WrOdrPrint = class(TForm)
    Label3: TLabel;
    edt_hm: Ti_TxtFilter;
    edt_pm: Ti_TxtFilter;
    edt_gdh: Ti_TxtFilter;
    dtp_kdrq: TRzDateTimePicker;
    RzGroupBox1: TRzGroupBox;
    RzGroupBox2: TRzGroupBox;
    RzGroupBox3: TRzGroupBox;
    RzGroupBox4: TRzGroupBox;
    RzGroupBox5: TRzGroupBox;
    ListView1: TListView;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_WrOdrPrint: TFrm_WrOdrPrint;

implementation

{$R *.dfm}

end.
