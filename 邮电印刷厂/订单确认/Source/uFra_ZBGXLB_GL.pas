unit uFra_ZBGXLB_GL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RzButton, ButtonEdit, Grids, iGrid, ExtCtrls, RzPanel;

type
  TFra_ZBGXLB_GL = class(TFrame)
    RzGroupBox1: TRzGroupBox;
    stg_gxlbxx: Ti_StgEdit;
    RzGroupBox2: TRzGroupBox;
    Label1: TLabel;
    edt_gxbh: Ti_TxtFilter;
    edt_gxmc: Ti_TxtFilter;
    btn_add: TRzButton;
    btn_mod: TRzButton;
    edt_cl: Ti_TxtFilter;
    edt_lbgg: Ti_TxtFilter;
    cbb_dw: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
