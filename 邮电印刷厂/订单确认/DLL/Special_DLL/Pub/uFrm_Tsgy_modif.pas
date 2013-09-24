unit uFrm_Tsgy_modif;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ButtonEdit, CheckLst, ExtCtrls, RzPanel, RzEdit,ADODB;

type
  TFrm_Tsgy_modif = class(TForm)
    btn_ok: TButton;
    btn_cancel: TButton;
    mmo_tsgy: TRzMemo;
    Label1: TLabel;
    RzGroupBox1: TRzGroupBox;
    cb_gyyq: TCheckListBox;
    procedure btn_okClick(Sender: TObject);
    procedure cb_gyyqClickCheck(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vCustomID: Integer;
    vUpdate: Boolean;
    vNJBZ: Integer; //内件标志
  end;

var
  Frm_Tsgy_modif: TFrm_Tsgy_modif;

implementation

uses
  uPub_Type,PubStr,uDM_DataBase;

{$R *.dfm}

procedure TFrm_Tsgy_modif.btn_okClick(Sender: TObject);
var
  sSqlData,sTsgy: string;
  ADO_Rec: TADOQuery;
begin
  if not vUpdate then Exit;
  sTsgy := Trim(mmo_tsgy.Text);
  if vCustomID > 0 then
  begin
//        sSqlData := 'Select F_sQttsgyms,F_iXGR_Tsgy,F_sOldTsgy from BI_CustomOrderDetails where F_iID=%d';
    sSqlData := 'Select F_sTsgy,F_iXGR_Tsgy from DO_OrderApart where F_tiOrderType=0 and F_iOrderID=%d and F_tiNJBZ=%d and F_tiCXBZ = 0';
    try
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[vCustomID,vNJBZ]);
      while not ADO_Rec.Eof do
      begin
        ADO_Rec.Edit;
        //if ADO_Rec.FieldByName('F_sOldTsgy').AsString = '' then
        //  ADO_Rec.FieldByName('F_sOldTsgy').AsString := ADO_Rec.FieldByName('F_sQttsgyms').AsString;
        //ADO_Rec.FieldByName('F_sQttsgyms').AsString := sTsgy;
        ADO_Rec.FieldByName('F_sTsgy').AsString := sTsgy;
        ADO_Rec.FieldByName('F_iXGR_Tsgy').AsInteger := LoginData.m_iUserID;
        ADO_Rec.Post;
        ADO_Rec.Next;
      end;
    finally
      ADO_Rec.Free;
    end;
  end;    
end;

procedure TFrm_Tsgy_modif.cb_gyyqClickCheck(Sender: TObject);
var
  sTsgy: string;
  n: integer;
begin
  sTsgy := mmo_tsgy.Text;
  n := cb_gyyq.ItemIndex;
  if cb_gyyq.Checked[cb_gyyq.ItemIndex] then
  begin
    if Pos(cb_gyyq.Items.Strings[n],sTsgy) = 0 then
      mmo_tsgy.Text := sTsgy + iif(sTsgy='','',',') + cb_gyyq.Items.Strings[cb_gyyq.ItemIndex];
  end else
  begin
    sTsgy := StrCut(sTsgy,','+cb_gyyq.Items.Strings[n]);
    if mmo_tsgy.Text = sTsgy then
      sTsgy := StrCut(sTsgy,cb_gyyq.Items.Strings[n]);
    mmo_tsgy.Text := sTsgy;
  end;
end;

end.
