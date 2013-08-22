unit uFrm_TSGYGL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, iGrid,ADODB;

type
  TFrm_TSGYGL = class(TForm)
    GroupBox1: TGroupBox;
    stg_TSGY: Ti_StgEdit;
    GroupBox2: TGroupBox;
    BitBtn1: TBitBtn;
    btn_Add: TBitBtn;
    BitBtn4: TBitBtn;
    procedure btn_AddClick(Sender: TObject);
    procedure stg_TSGYLinkClick(Sender: TObject; ACol, ARow: Integer);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure FrmInit;
    procedure WriteTSGY(ADO_Data:TADOQuery);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  Frm_TSGYGL: TFrm_TSGYGL;

implementation

uses uFrm_TSGYGL_Dlg,uDM_DataBase,uPub_Type,uPub_Func,PubStr;

{$R *.dfm}

const
  c_BM = 0;  //编码
  c_MC = 1;  //名称
  c_DJ = 2;  //单价
  c_XG = 3;  //修改
  c_SC = 4;  //删除
  c_ID = 5;  //ID


procedure TFrm_TSGYGL.btn_AddClick(Sender: TObject);
var
  sSqlData: string;
  sBM,sMC,sDJ: string;
begin
  if FrmTSGYGL_Dlg.ShowModal = mrOK then
  begin
    sBM := FrmTSGYGL_Dlg.edt_bm.Text;
    sMC := FrmTSGYGL_Dlg.edt_mc.Text;
    sDJ := FrmTSGYGL_Dlg.edt_dj.Text;
    if (sBM = '') or (sMC = '') or (sDJ = '') then
    begin
      p_MessageBoxDlg('请输入完整数据!');
      btn_Add.Click;
      Exit;
    end;
    try
      sSqlData := 'Insert into Set_SpecialCraftInfo (F_sBM,F_sMC,F_mDJ,F_sCZRBM) values (''%s'',''%s'',''%s'',''%s'')';
      DM_DataBase.ExecQuery(sSqlData,[sBM,sMC,sDJ,LoginData.m_sUserName],True);
      FrmTSGYGL_Dlg.Free;
      FrmInit;
    except
      on E: Exception do
      begin
        p_MessageBoxDlg(e.Message);
        btn_Add.Click;
        Exit;
      end;
    end;
  end else
  begin
    FrmTSGYGL_Dlg.Free;
  end;
end;

procedure TFrm_TSGYGL.FrmInit;
var
  sSqlData: string;
  ADO_Rec:TADOQuery;
begin
  sSqlData := 'Select * from Set_SpecialCraftInfo where F_tiFlag=1';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
  if Assigned(ADO_Rec) then
  begin
    WriteTSGY(ADO_Rec);
    ADO_Rec.Free;
  end;

end;

procedure TFrm_TSGYGL.stg_TSGYLinkClick(Sender: TObject; ACol,
  ARow: Integer);
var
  PStr:PChar;
  sSqlData: string;
  sBM,sMC,sDJ: string;
  bGoto: Boolean;
  iInfoID: Integer;
  label n1;
begin
  iInfoID := StrToNum(stg_TSGY.Cells[c_ID,ARow]);
  if iInfoID = 0 then Exit;
  case ACol of
    c_XG:
        begin
          FrmTSGYGL_Dlg.gb_TSGY.Caption := '修改';
          FrmTSGYGL_Dlg.edt_bm.Text := stg_TSGY.Cells[c_BM,ARow];
          FrmTSGYGL_Dlg.edt_mc.Text := stg_TSGY.Cells[c_MC,ARow];
          FrmTSGYGL_Dlg.edt_dj.Text := stg_TSGY.Cells[c_DJ,ARow];
          n1:
          if FrmTSGYGL_Dlg.ShowModal = mrOK then
          begin
            sBM := FrmTSGYGL_Dlg.edt_bm.Text;
            sMC := FrmTSGYGL_Dlg.edt_mc.Text;
            sDJ := FrmTSGYGL_Dlg.edt_dj.Text;
            if (sBM = '') or (sMC = '') or (sDJ = '') then
            begin
              p_MessageBoxDlg('请输入完整数据!');
              goto  n1;
            end;
            try
              bGoto := False;

              sSqlData := 'Update Set_SpecialCraftInfo set F_sBM=''%s'',F_sMC=''%s'',F_mDJ=''%s'',F_sCZRBM=''%s'',F_dCZRQ=getdate() where F_iID = %d ';
              DM_DataBase.ExecQuery(sSqlData,[sBM,sMC,sDJ,LoginData.m_sUserName,iInfoID],True);
              FrmTSGYGL_Dlg.Free;
              FrmInit;
            except
              on E: Exception do
              begin
                p_MessageBoxDlg(e.Message);
                bGoto := True;
              end;
            end;
            if bGoto then goto  n1;

          end;
        end;
    c_SC:
         begin
           PStr := PChar(Format('是否要删除:'+#13#10+'特殊工艺编号：%s' +#13#10+ '特殊工艺名称：%s'
              +#13#10+'特殊工艺单价：%s',[stg_TSGY.Cells[c_BM,ARow],stg_TSGY.Cells[c_MC,ARow],stg_TSGY.Cells[c_DJ,ARow]]));
            if  Application.MessageBox(PStr,'提示',MB_ICONINFORMATION+ MB_YESNO) = IDYES then
            begin
              sSqlData := 'Update Set_SpecialCraftInfo set F_sCZRBM=''%s'',F_dCZRQ=getdate(),F_tiFlag=0  where F_iID = %d';
              if DM_DataBase.ExecQuery(sSqlData,[LoginData.m_sUserName,iInfoID]) then
              begin
                FrmTSGYGL_Dlg.Free;
                FrmInit;
              end;
            end;

         end;
  end;

end;

procedure TFrm_TSGYGL.WriteTSGY(ADO_Data:TADOQuery);
var
  n: Integer;
begin
  stg_TSGY.Clear;
  stg_TSGY.RowCount := iif(ADO_Data.RecordCount > 0, ADO_Data.RecordCount +1, 2);
  n := 1;
  with ADO_Data do
  begin
    First;
    while not Eof do
    begin
      stg_TSGY.cells[c_BM ,n] := FieldByName('F_sBM').AsString;
      stg_TSGY.cells[c_MC ,n] := FieldByName('F_sMC').AsString;
      stg_TSGY.cells[c_DJ ,n] := FieldByName('F_mDJ').AsString;
      stg_TSGY.Cells[c_XG,n] := '修改';
      stg_TSGY.CellsLink[c_XG,n] := '修改';
      stg_TSGY.Cells[c_SC,n] := '删除';
      stg_TSGY.CellsLink[c_SC,n] := '删除';
      stg_TSGY.cells[c_ID ,n] := FieldByName('F_iID').AsString;
      inc(n);
      Next;
    end;
    stg_TSGY.ColWidths[c_ID] := 0;
  end;
end;

procedure TFrm_TSGYGL.BitBtn4Click(Sender: TObject);
begin
  FrmInit;
end;

procedure TFrm_TSGYGL.FormShow(Sender: TObject);
begin
  FrmInit;
end;

constructor TFrm_TSGYGL.Create(AOwner: TComponent);
begin
  inherited;
  BorderStyle := bsNone;
  Hide;
  Parent := TWinControl(AOwner);
  Align := alClient;

end;



end.
