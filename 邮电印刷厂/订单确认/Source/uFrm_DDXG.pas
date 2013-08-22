unit uFrm_DDXG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, iLabel, ButtonEdit,ADODB;

type
  TFrm_ddxg = class(TForm)
    Shape45: TShape;
    Shape47: TShape;
    shape_1: TShape;
    shape_2: TShape;
    Shape52: TShape;
    Shape98: TShape;
    Shape93: TShape;
    Shape92: TShape;
    Shape91: TShape;
    Shape90: TShape;
    Shape89: TShape;
    Shape87: TShape;
    Shape85: TShape;
    Shape83: TShape;
    Shape82: TShape;
    Shape81: TShape;
    Shape80: TShape;
    Shape72: TShape;
    Shape67: TShape;
    Shape66: TShape;
    Shape65: TShape;
    Shape64: TShape;
    Shape63: TShape;
    Shape61: TShape;
    Shape59: TShape;
    Shape57: TShape;
    Shape56: TShape;
    Shape55: TShape;
    Shape54: TShape;
    Shape48: TShape;
    Shape46: TShape;
    Shape44: TShape;
    Shape43: TShape;
    Shape42: TShape;
    Shape41: TShape;
    Shape40: TShape;
    Shape39: TShape;
    Shape38: TShape;
    Shape37: TShape;
    Shape36: TShape;
    Shape35: TShape;
    Shape34: TShape;
    Shape33: TShape;
    Shape32: TShape;
    Shape31: TShape;
    Shape30: TShape;
    Shape29: TShape;
    Shape28: TShape;
    Shape22: TShape;
    Shape21: TShape;
    Shape20: TShape;
    Shape19: TShape;
    Shape18: TShape;
    Shape17: TShape;
    Shape16: TShape;
    Shape15: TShape;
    Shape14: TShape;
    Shape13: TShape;
    Shape12: TShape;
    Shape11: TShape;
    Shape10: TShape;
    Shape9: TShape;
    Shape8: TShape;
    Shape7: TShape;
    Shape6: TShape;
    Shape5: TShape;
    Shape4: TShape;
    Shape3: TShape;
    Shape2: TShape;
    lab_qttsgy: T_TxtFilter;
    i_Label2: T_TxtFilter;
    i_Label3: T_TxtFilter;
    lab_tsgybz: T_TxtFilter;
    i_Label5: T_TxtFilter;
    i_Label6: T_TxtFilter;
    i_Label7: T_TxtFilter;
    i_Label9: T_TxtFilter;
    i_Label10: T_TxtFilter;
    i_Label11: T_TxtFilter;
    i_Label12: T_TxtFilter;
    i_Label14: T_TxtFilter;
    i_Label15: T_TxtFilter;
    i_Label16: T_TxtFilter;
    i_Label17: T_TxtFilter;
    i_Label18: T_TxtFilter;
    lab_qy: T_TxtFilter;
    i_Label20: T_TxtFilter;
    lab_jybz: T_TxtFilter;
    lab_xpl: T_TxtFilter;
    i_Label23: T_TxtFilter;
    i_Label24: T_TxtFilter;
    i_Label25: T_TxtFilter;
    i_Label26: T_TxtFilter;
    i_Label27: T_TxtFilter;
    i_Label28: T_TxtFilter;
    lab_wxbz: T_TxtFilter;
    i_Label31: T_TxtFilter;
    i_Label32: T_TxtFilter;
    i_Label33: T_TxtFilter;
    i_Label34: T_TxtFilter;
    i_Label35: T_TxtFilter;
    i_Label36: T_TxtFilter;
    Shape1: TShape;
    Shape26: TShape;
    lab_SbID: T_TxtFilter;
    Shape58: TShape;
    lab_dfbbz: T_TxtFilter;
    lab_njtsgy: T_TxtFilter;
    pan_jg: TPanel;
    btn_tsgy: TButton;
    pan_gy: TPanel;
    Shape60: TShape;
    Shape62: TShape;
    Shape68: TShape;
    Shape69: TShape;
    i_Label1: T_TxtFilter;
    i_Label4: T_TxtFilter;
    Shape70: TShape;
    Shape71: TShape;
    Shape73: TShape;
    Shape75: TShape;
    Shape78: TShape;
    Shape84: TShape;
    Shape86: TShape;
    Shape88: TShape;
    Shape94: TShape;
    Shape95: TShape;
    Shape96: TShape;
    Shape97: TShape;
    i_Label13: T_TxtFilter;
    i_Label19: T_TxtFilter;
    i_Label21: T_TxtFilter;
    i_Label22: T_TxtFilter;
    i_Label29: T_TxtFilter;
    i_Label43: T_TxtFilter;
  private
    { Private declarations }
    vCustomID: Integer;
    vTGSHOW: Boolean;
    procedure LoadOrderData;
  public
    { Public declarations }
  end;

var
  Frm_ddxg: TFrm_ddxg;

implementation

{$R *.dfm}

{ TFrm_ddxg }

procedure TFrm_ddxg.LoadOrderData;
var
  ADO_Rec: TADOQuery;
  sOrderID: string;
  i,iType: integer;
  SqlData,sTableName: string;
  sHint: string;
begin
{  if TMenuItem(Sender).Name = 'menu_ddmx' then
  SelItem := lv_jhxd.Selected;
  if not Assigned(SelItem) then Exit;
  sOrderID := SelItem.SubItems.Strings[SelItem.SubItems.Count-1];

//  sOrderID := DM_DataBase.mte_DataRec.FieldByName('OrderID').AsString;
//  if sOrderID = '' then
//  begin
//    Application.MessageBox('请选择订单!','提示',MB_ICONINFORMATION);
//    Exit;
//  end;
//  iType := DM_DataBase.mte_DataRec.FieldByName('OrderType').AsInteger;
  sTableName := 'BI_CustomOrderDetails';
  SqlData := 'F_iID='+sOrderID;
  try
    ADO_Rec := TADOQuery.Create(Self);
    DM_DataBase.GetTableData(ADO_Rec,sTableName,SqlData);
  case iType of
    0:
      begin
        //if Assigned(Frm_DDMX_DZX) then Frm_DDMX_DZX.Free;
        SetLength(aFrm_DDMX_DZX,Length(aFrm_DDMX_DZX)+1);
        Frm_DDMX_DZX := aFrm_DDMX_DZX[Length(aFrm_DDMX_DZX)-1];
        Frm_DDMX_DZX := TFrm_DDMX_DZX.Create(Application);
        for i := 0 to Frm_DDMX_DZX.ComponentCount -1 do
        begin
          if Frm_DDMX_DZX.Components[i] is Ti_Label then
          begin
            sHint := Ti_Label(Frm_DDMX_DZX.Components[i]).Hint;
            if sHint = '' then Continue;
            Ti_Label(Frm_DDMX_DZX.Components[i]).Caption := ADO_Rec.FieldByName(sHint).AsString;
          end;
        end;
        Frm_DDMX_DZX.vCustomID := StrToNum(sOrderID);
        if TMenuItem(Sender).Name = 'menu_ddmxPic' then
          Frm_DDMX_DZX.vTGSHOW := True;
        //Frm_DDMX_DZX.ShowModal;
        //Frm_DDMX_DZX.Free;
//        SetWindowLong(Frm_DDMX_DZX.Handle,GWL_EXSTYLE,GetWindowLong(Frm_DDMX_DZX.Handle,GWL_EXSTYLE) or WS_EX_APPWINDOW);
        Frm_DDMX_DZX.Show;
      end;
    1:
      begin
        //if Assigned(Frm_DDMX_XSX) then Frm_DDMX_XSX.Free;
        SetLength(aFrm_DDMX_DZX,Length(aFrm_DDMX_DZX)+1);
        Frm_DDMX_DZX := aFrm_DDMX_DZX[Length(aFrm_DDMX_DZX)-1];
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
        Frm_DDMX_XSX.vSellID := StrToNum(sOrderID);
        //Frm_DDMX_XSX.ShowModal;
        //Frm_DDMX_XSX.Free;
        FrmDDMX_XSX(iOrderID).Show;
      end;
  end;


  finally
    ADO_Rec.Free;
  end;     }
end;

end.



