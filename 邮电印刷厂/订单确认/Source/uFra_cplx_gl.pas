unit uFra_cplx_gl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, iGrid, RzCmboBx, iComboBox, RzButton,
  ButtonEdit, ExtCtrls, RzPanel,ADODB;

type
  TFra_cplx_gl = class(TFrame)
    GroupBox1: TGroupBox;
    stg_cplxxx: Ti_StgEdit;
    RzGroupBox2: TRzGroupBox;
    cbb_CPLX: Ti_TxtFilter;
    cbb_XH: Ti_TxtFilter;
    cbb_FJNJ: Ti_ComboBox;
    edt_BM: Ti_TxtFilter;
    cbb_cplb: Ti_ComboBox;
    btn_Add: TRzButton;
    btn_Modify: TRzButton;
    btn_Del: TRzButton;
    Label3: TLabel;
    cbb_year: Ti_ComboBox;
    cbb_month: Ti_ComboBox;
    cbb_day: Ti_ComboBox;
    edt_PrefixStyle: Ti_TxtFilter;
    Label1: TLabel;
    Label2: TLabel;
    edt_SmallPrefixStyle: Ti_TxtFilter;
    procedure btn_AddClick(Sender: TObject);
    procedure stg_cplxxxSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btn_ModifyClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure cbb_XHKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    stgSeletedID : Integer;
    procedure ClearBlank;
  public
    { Public declarations }
    procedure ReadDataCPLXXX;
  end;

implementation

uses
  uDM_DataBase,PubStr, uPub_Func, uPub_Text, DateUtils;

{$R *.dfm}

const
  c_cplb             = 0;
  c_xh               = 1;
  c_cplx             = 2;
  c_bm               = 3;
  c_fjnj             = 4;
  c_GDHQZ            = 5;
  c_XPLGDHQZ         = 6;
  c_NFGBRQ           = 7;
  c_PrefixStyle      = 8;
  c_SmallPrefixStyle = 9;
  c_F_iID            = 10;


procedure TFra_cplx_gl.ReadDataCPLXXX;
var
  n: Integer;
  sCplb, sCplx: string;
  ADO_Rec: TADOQuery;
  sFJNJBZ,sProductCategoryID: string;
begin
  try
    ADO_Rec := TADOQuery.Create(Self);
    DM_DataBase.GetTableData(ADO_Rec,'Set_ProductType','1=1 order by F_iProductCategoryID,F_iSort');
    stg_cplxxx.Clear;
    stg_cplxxx.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
    n := 1;
    with ADO_Rec do
    begin
      First;
      while not Eof do
      begin
        sCplb := '';
        sProductCategoryID := FieldByName('F_iProductCategoryID').AsString;
        if sProductCategoryID <> '' then
          sCplb :=  DM_DataBase.GetTableFirst('Select F_sClassName from Set_ProductCategory where F_iID='+sProductCategoryID);
        stg_cplxxx.cells[c_cplb ,n] := sCplb;
        stg_cplxxx.cells[c_xh ,n] := FieldByName('F_iSort').AsString;
        stg_cplxxx.cells[c_cplx,n] := FieldByName('F_sTypeName').AsString;
        stg_cplxxx.cells[c_bm,n] := FieldByName('F_sTypeCode').AsString;
        case FieldByName('F_tiFJNJBZ').AsInteger  of
          0: sFJNJBZ :='否';
          1: sFJNJBZ :='是';
        end;
        stg_cplxxx.cells[c_fjnj,n] := sFJNJBZ;
        stg_cplxxx.cells[c_GDHQZ,n] := FieldByName('F_sPrefixCode').AsString;
        stg_cplxxx.cells[c_XPLGDHQZ,n] := FieldByName('F_sSmallPrefixCode').AsString;
        stg_cplxxx.cells[c_NFGBRQ,n] := FieldByName('F_sNFGBRQ').AsString;
        stg_cplxxx.Cells[c_PrefixStyle,n] := FieldByName('F_sPrefixStyle').AsString;
        stg_cplxxx.Cells[c_SmallPrefixStyle,n] := FieldByName('F_sSmallPrefixStyle').AsString;
        stg_cplxxx.cells[c_F_iID,n] := FieldByName('F_iID').AsString;
        inc(n);
        Next;
      end;
    end;
    stg_cplxxx.ColWidths[c_PrefixStyle] := 0;
    stg_cplxxx.ColWidths[c_SmallPrefixStyle] := 0;
    stg_cplxxx.ColWidths[c_F_iID] := 0;
  finally
    ADO_Rec.Free;
  end;
end;

procedure TFra_cplx_gl.btn_AddClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  iProductCategoryID: Integer;
  sPrefixStyle,sSmallPrefixStyle, sPrefixCode, sSmallPrefixCode, sYear, sMonth, sDay, sDate, sNFGBRQ: string;
begin
  sPrefixStyle := edt_PrefixStyle.Text;
  sSmallPrefixStyle := edt_SmallPrefixStyle.Text;
  sNFGBRQ := cbb_year.Text+cbb_month.Text+cbb_day.Text;
  try
    try
      ADO_Rec := TADOQuery.Create(Self);
      DM_DataBase.GetTableData(ADO_Rec,'Set_ProductType');
      with ADO_Rec do
      begin
        Insert;
        iProductCategoryID := FindProductCategoryID(cbb_cplb.ItemIndex);
        FieldByName('F_iProductCategoryID').AsInteger := iProductCategoryID;
        FieldByName('F_iSort').AsInteger := StrToNum(cbb_XH.Text);
        FieldByName('F_sTypeName').AsString := cbb_CPLX.Text;
        FieldByName('F_sTypeCode').AsString := edt_BM.Text;
        FieldByName('F_tiFJNJBZ').AsInteger := cbb_FJNJ.ItemIndex;
        FieldByName('F_sPrefixStyle').AsString := Trim(sPrefixStyle);
        FieldByName('F_sSmallPrefixStyle').AsString := Trim(sSmallPrefixStyle);
        FieldByName('F_sNFGBRQ').AsString := sNFGBRQ;
        sPrefixCode := StrReplace(Trim(sPrefixStyle),'year',FormatDateTime('yy',now));
        sSmallPrefixCode := StrReplace(Trim(sSmallPrefixStyle),'year',FormatDateTime('yy',now));
        //---------如果当天为更变日期,则前缀更变-----------------
        sYear := cbb_year.Text;
        sMonth := Copy(cbb_month.Text,1,Pos('月',cbb_month.Text)-1);
        sDay := Copy(cbb_day.Text,1,Pos('日',cbb_day.Text)-1);
        sDate := sMonth+sDay;
        if FormatDateTime('MMdd',Now) > sDate then
        begin
          if sYear = c_CPLB_NextYear then
            sYear := FormatDateTime('yy',Now)
          else if sYear= c_CPLB_ThisYear then
            sYear := FormatDateTime('yy',IncYear(Now));
          sPrefixCode := StrReplace(Trim(sPrefixStyle),'year',sYear);
          sSmallPrefixCode := StrReplace(Trim(sSmallPrefixStyle),'year',sYear);
        end;
        //---------------------------------------------------------
        FieldByName('F_sPrefixCode').AsString := Trim(sPrefixCode);
        FieldByName('F_sSmallPrefixCode').AsString := Trim(sSmallPrefixCode);
        Post;
      end;
      p_MessageBoxDlg('添加成功!');
      ClearBlank;
      ReadDataCPLXXX;
      cbb_cplb.SetFocus;
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar(e.Message),'提示',MB_ICONINFORMATION);
        Exit;
      end;
    end;
  finally
    ADO_Rec.Free;
  end;
end;

procedure TFra_cplx_gl.ClearBlank;
var
  i: Integer;
begin
  for i := 0 to Self.ComponentCount -1 do
  begin
    if Self.Components[i] is Ti_TxtFilter then
      Ti_TxtFilter(Self.Components[i]).Text := ''
    else
    if (Self.Components[i] is Ti_ComboBox) or (Self.Components[i] is TComboBox) then
      Ti_ComboBox(Self.Components[i]).ItemIndex := 0;
  end;
  stgSeletedID := 0;
end;

procedure TFra_cplx_gl.stg_cplxxxSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  sNFGBRQ: string;
  sYear,sMonth,sDay: string;

begin
  cbb_cplb.ItemIndex := cbb_cplb.IndexOf(stg_cplxxx.cells[c_cplb ,ARow]);
  cbb_XH.Text := stg_cplxxx.cells[c_xh ,ARow];
  cbb_CPLX.Text := stg_cplxxx.cells[c_cplx ,ARow];
  edt_BM.Text := stg_cplxxx.cells[c_bm ,ARow];
  cbb_FJNJ.ItemIndex := cbb_FJNJ.IndexOf(stg_cplxxx.cells[c_fjnj ,ARow]);
  edt_PrefixStyle.Text := stg_cplxxx.Cells[c_PrefixStyle, ARow];
  edt_SmallPrefixStyle.Text := stg_cplxxx.Cells[c_SmallPrefixStyle, ARow];
  sNFGBRQ := stg_cplxxx.Cells[c_NFGBRQ, ARow];
  sYear := Copy(sNFGBRQ,1,pos('年',sNFGBRQ)+1);
  sMonth := Copy(sNFGBRQ,pos('年',sNFGBRQ)+2,pos('月',sNFGBRQ)+1-length(sYear));
  sDay := Copy(sNFGBRQ,pos('月',sNFGBRQ)+2,Length(sNFGBRQ));
  cbb_year.ItemIndex := cbb_year.IndexOf(sYear);
  cbb_month.ItemIndex := cbb_month.IndexOf(sMonth);
  cbb_day.ItemIndex := cbb_day.IndexOf(sDay);
  stgSeletedID := StrToNum(stg_cplxxx.cells[c_F_iID ,ARow]);
end;

procedure TFra_cplx_gl.btn_ModifyClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  iProductCategoryID: Integer;
  sPrefixStyle, sSmallPrefixStyle, sPrefixCode, sSmallPrefixCode: string;
  sYear, sMonth, sDay, sDate, sNFGBRQ: string;
begin
  if stgSeletedID =0 then
  begin
    Application.MessageBox('请选择要修改的数据!','提示',MB_ICONINFORMATION);
    Exit;
  end;
  sPrefixStyle := edt_PrefixStyle.Text;
  sSmallPrefixStyle := edt_SmallPrefixStyle.Text;
  sNFGBRQ := cbb_year.Text+cbb_month.Text+cbb_day.Text;
  try
    ADO_Rec := DM_DataBase.OpenQuery('select * from Set_ProductType where F_iID=%d',[stgSeletedID],True);
    with ADO_Rec do
    begin
      Edit;
      iProductCategoryID := FindProductCategoryID(cbb_cplb.ItemIndex);
      FieldByName('F_iProductCategoryID').AsInteger := iProductCategoryID;
      FieldByName('F_iSort').AsInteger := StrToNum(cbb_XH.Text);
      FieldByName('F_sTypeName').AsString := cbb_CPLX.Text;
      FieldByName('F_sTypeCode').AsString := edt_BM.Text;
      FieldByName('F_tiFJNJBZ').AsInteger := cbb_FJNJ.ItemIndex;
      FieldByName('F_sPrefixStyle').AsString := Trim(sPrefixStyle);
      FieldByName('F_sSmallPrefixStyle').AsString := Trim(sSmallPrefixStyle);
      FieldByName('F_sNFGBRQ').AsString := sNFGBRQ;
      sPrefixCode := StrReplace(Trim(sPrefixStyle),'year',FormatDateTime('yy',now));
      sSmallPrefixCode := StrReplace(Trim(sSmallPrefixStyle),'year',FormatDateTime('yy',now));
      //------------如果当天为更变日期,则前缀更变---------
      sYear := cbb_year.Text;
      sMonth := Copy(cbb_month.Text,1,Pos('月',cbb_month.Text)-1);
      sDay := Copy(cbb_day.Text,1,Pos('日',cbb_day.Text)-1);
      sDate := sMonth+sDay;
      if FormatDateTime('MMdd',Now) > sDate then
      begin
        if sYear = c_CPLB_NextYear then
          sYear := FormatDateTime('yy',Now)
        else if sYear= c_CPLB_ThisYear then
          sYear := FormatDateTime('yy',IncYear(Now));
        sPrefixCode := StrReplace(Trim(sPrefixStyle),'year',sYear);
        sSmallPrefixCode := StrReplace(Trim(sSmallPrefixStyle),'year',sYear);
      end;
      //-------------------------------------------------
      FieldByName('F_sPrefixCode').AsString := Trim(sPrefixCode);
      FieldByName('F_sSmallPrefixCode').AsString := Trim(sSmallPrefixCode);
      Post;
    end;
    p_MessageBoxDlg('修改成功!');
    ClearBlank;
    ReadDataCPLXXX;
  except
    on E: Exception do      
    begin
      Application.MessageBox(PChar('修改失败：'+E.Message),'提示',MB_ICONINFORMATION);
      Exit;
    end;
  end;
end;

procedure TFra_cplx_gl.btn_DelClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  PStr: PChar;
begin
  if stgSeletedID =0 then
  begin
    Application.MessageBox('请选择要删除的数据!','提示',MB_ICONINFORMATION);
    Exit;
  end;
  PStr := PChar('是否要删除:'+#13#10+'产品类别：'+ cbb_cplb.Text +#13#10+'序号：'+ cbb_XH.Text +#13#10+'产品类型：'
    + cbb_CPLX.Text +#13#10+'编码：'+ edt_BM.Text+#13#10+'是否含有内件：'+ cbb_FJNJ.Text);
  if  Application.MessageBox(PStr,'提示',MB_ICONINFORMATION+ MB_YESNO) = IDNO then Exit;
  try
    try
      ADO_Rec := TADOQuery.Create(Self);
      DM_DataBase.GetTableData(ADO_Rec,'Set_ProductType','F_iID='+IntToStr(stgSeletedID));
      ADO_Rec.Delete;
      p_MessageBoxDlg('删除成功!');
      ClearBlank;
      ReadDataCPLXXX;
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar('修改失败：'+E.Message),'提示',MB_ICONINFORMATION);
        Exit;
      end;
    end;
  finally
    ADO_Rec.Free;
  end;
end;

procedure TFra_cplx_gl.cbb_XHKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Ord(Key) < Ord('0')) or (Ord(Key)>Ord('9'))) and (Ord(Key)<> VK_BACK)  then
    Key := #0;
end;

end.

