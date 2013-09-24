unit uDDMX_XSX;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, iLabel,ADODB;

type
  TFrm_DDMX_XSX = class(TForm)
    i_Label2: Ti_Label;
    i_Label3: Ti_Label;
    i_Label5: Ti_Label;
    i_Label7: Ti_Label;
    i_Label9: Ti_Label;
    i_Label10: Ti_Label;
    i_Label11: Ti_Label;
    i_Label12: Ti_Label;
    i_Label14: Ti_Label;
    i_Label16: Ti_Label;
    i_Label17: Ti_Label;
    i_Label20: Ti_Label;
    i_Label25: Ti_Label;
    i_Label26: Ti_Label;
    i_Label27: Ti_Label;
    lab_wxbz: Ti_Label;
    i_Label36: Ti_Label;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape17: TShape;
    Shape28: TShape;
    Shape29: TShape;
    Shape30: TShape;
    Shape31: TShape;
    Shape32: TShape;
    Shape33: TShape;
    Shape40: TShape;
    Shape41: TShape;
    Shape43: TShape;
    Shape54: TShape;
    Shape55: TShape;
    Shape56: TShape;
    Shape57: TShape;
    Shape59: TShape;
    Shape61: TShape;
    Shape66: TShape;
    Shape67: TShape;
    Shape80: TShape;
    Shape81: TShape;
    Shape82: TShape;
    Shape83: TShape;
    Shape85: TShape;
    Shape87: TShape;
    Shape92: TShape;
    Shape93: TShape;
    Shape26: TShape;
    Shape1: TShape;
    lab_SbID: Ti_Label;
    edt_Temp: TEdit;
    btn_bz: TButton;
    Shape23: TShape;
    Shape24: TShape;
    lab_nbbz: Ti_Label;
    procedure FormShow(Sender: TObject);
    procedure i_Label13Click(Sender: TObject);
    procedure btn_bzClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    vSellID: Integer;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

  function FrmDDMX_XSX(_iOrderID: Integer): TFrm_DDMX_XSX;

implementation

uses
  PubStr, uDM_DataBase, uPub_Func;

{$R *.dfm}

function FrmDDMX_XSX(_iOrderID: Integer): TFrm_DDMX_XSX;
var
  i: Integer;
  sSqlData,sHint: string;
  ADO_Rec: TADOQuery;
  Frm_DDMX_XSX: TFrm_DDMX_XSX;
begin
  sSqlData := 'select * from BI_SellOrderDetails where F_iID=%d';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[_iOrderID]);
  Frm_DDMX_XSX := TFrm_DDMX_XSX.Create(Application);


  for i := 0 to Frm_DDMX_XSX.ComponentCount -1 do
  begin
    if Frm_DDMX_XSX.Components[i] is Ti_Label then
    begin
      sHint := Ti_Label(Frm_DDMX_XSX.Components[i]).Hint;
      if sHint = '' then Continue;
      Ti_Label(Frm_DDMX_XSX.Components[i]).Caption := ADO_Rec.FieldByName(sHint).AsString;
    end;
  end;
  Frm_DDMX_XSX.vSellID := _iOrderID;
  Result := Frm_DDMX_XSX;

end;

procedure TFrm_DDMX_XSX.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent :=   0 ;//就是桌面
end;

procedure TFrm_DDMX_XSX.FormShow(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
begin
  case StrToNum(lab_wxbz.Caption) of
    0: lab_wxbz.Caption := '无';
    1: lab_wxbz.Caption := '有';
  end;
  if vSellID <> 0 then
  begin
    sSqlData := 'Select F_tiLrbz,F_sSbbbh from BI_SellOrder a where exists(Select 1 from BI_SellOrderDetails where F_iID=%d and F_iSellID=a.F_iID)';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[vSellID]);
    if ADO_Rec.FieldByName('F_tiLrbz').AsInteger in [1,2,3] then
    begin
      //lab_SbID.Caption := '(手动录入订单)';
      lab_SbID.LabelCaption := '申报表编号 ';
      lab_SbID.Caption := ADO_Rec.FieldByName('F_sSbbbh').AsString;
    end;
    ADO_Rec.Free
  end;
end;

procedure TFrm_DDMX_XSX.i_Label13Click(Sender: TObject);
begin
  edt_Temp.Visible := True;
  edt_Temp.Text := Ti_Label(Sender).Caption;
  edt_Temp.Left := Ti_Label(Sender).Left;
  edt_Temp.Top := Ti_Label(Sender).Top;
  edt_Temp.Height := Ti_Label(Sender).Height;
  edt_Temp.Width := Ti_Label(Sender).Width;
end;

procedure TFrm_DDMX_XSX.btn_bzClick(Sender: TObject);
var
  sBZ, sSqlData: string;
begin
  sBZ := lab_nbbz.Caption;
  if InputQueryEH('修改备注','备注：',sBZ) then
  begin
    sSqlData := 'Update BI_SellOrderDetails set F_sNBBZ = ''%s'' where F_iID=%d ';
    try
      DM_DataBase.ExecQuery(sSqlData,[sBZ,vSellID],True);
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar('添加失败:'+E.message),'提示',MB_ICONINFORMATION);
        Exit;
      end;
    end;
    lab_nbbz.Caption := sBZ;
  end;

end;

procedure TFrm_DDMX_XSX.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

end.
