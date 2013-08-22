unit uFra_CPLB_GL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzCmboBx, iComboBox, RzButton, ButtonEdit, ExtCtrls,
  RzPanel, Grids, iGrid, ADODB;

type
  TFra_CPLB_GL = class(TFrame)
    GroupBox1: TGroupBox;
    stg_cplbxx: Ti_StgEdit;
    RzGroupBox2: TRzGroupBox;
    edt_cplb: Ti_TxtFilter;
    edt_XH: Ti_TxtFilter;
    edt_bm: Ti_TxtFilter;
    btn_Add: TRzButton;
    btn_Modify: TRzButton;
    procedure stg_cplbxxSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btn_AddClick(Sender: TObject);
    procedure stg_cplbxxLinkClick(Sender: TObject; ACol, ARow: Integer);
    procedure btn_ModifyClick(Sender: TObject);
    procedure edt_XHExit(Sender: TObject);
  private
    { Private declarations }
    stgSeletedID: integer;
    procedure p_LoadProceductCategory;
    function IsCheck: Boolean;
    procedure ClearText;
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

uses
  uDM_DataBase, PubStr, uPub_Text, uPub_Func;

{$R *.dfm}

procedure TFra_CPLB_GL.FraShow;
begin
  p_LoadProceductCategory;
end;

procedure TFra_CPLB_GL.p_LoadProceductCategory;
var
  n: Integer;
  sSqlData: string;
  ADO_Rec: TADOQuery;
begin
  sSqlData := 'select * from Set_ProductCategory order by F_iSort';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
  stg_cplbxx.Clear;
  stg_cplbxx.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
  n := 1;
  with ADO_Rec do
  begin
    First;
    while Assigned(ADO_Rec) and (not Eof) do
    begin
      stg_cplbxx.Cells[c_CPLB_XH,n] := FieldByName('F_iSort').AsString;
      stg_cplbxx.Cells[c_CPLB_BM,n] := FieldByName('F_iClassCode').AsString;
      stg_cplbxx.Cells[c_CPLB_CPLBMC,n] := FieldByName('F_sClassName').AsString;
      //stg_cplbxx.Cells[c_CPLB_GDHQZ,n] := FieldByName('F_sPrefixCode').AsString;
      //stg_cplbxx.Cells[c_CPLB_NFGBRQ,n] := FieldByName('F_sNFGBRQ').AsString;
      stg_cplbxx.Cells[c_CPLB_CZ,n] := '删除';
      stg_cplbxx.CellsLink[c_CPLB_CZ,n] := '删除';
      //stg_cplbxx.Cells[c_CPLB_PrefixStyle,n] := FieldByName('F_sPrefixStyle').AsString;
      stg_cplbxx.Cells[c_CPLB_CategoryID,n] := FieldByName('F_iID').AsString;
      inc(n);
      Next;
    end;
  end;
  //stg_cplbxx.ColWidths[c_CPLB_PrefixStyle] := 0;
  stg_cplbxx.ColWidths[c_CPLB_CategoryID] := 0;
  ADO_Rec.Free;

end;

procedure TFra_CPLB_GL.stg_cplbxxSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  sNFGBRQ: string;
  sYear,sMonth,sDay: string;
begin
  edt_XH.Text := stg_cplbxx.cells[c_CPLB_XH ,ARow];
  edt_cplb.Text := stg_cplbxx.Cells[c_CPLB_CPLBMC,ARow];
  edt_bm.Text := stg_cplbxx.Cells[c_CPLB_BM, ARow];
//  edt_PrefixStyle.Text := stg_cplbxx.Cells[c_CPLB_Prefixstyle, ARow];
//  sNFGBRQ := stg_cplbxx.Cells[c_CPLB_NFGBRQ, ARow];
//  sYear := Copy(sNFGBRQ,1,pos('年',sNFGBRQ)+1);
//  sMonth := Copy(sNFGBRQ,pos('年',sNFGBRQ)+2,pos('月',sNFGBRQ)+1-length(sYear));
//  sDay := Copy(sNFGBRQ,pos('月',sNFGBRQ)+2,Length(sNFGBRQ));
//  cbb_year.ItemIndex := cbb_year.IndexOf(sYear);
//  cbb_month.ItemIndex := cbb_month.IndexOf(sMonth);
//  cbb_day.ItemIndex := cbb_day.IndexOf(sDay);
  stgSeletedID := StrToNum(stg_cplbxx.Cells[c_CPLB_CategoryID, ARow])

end;

procedure TFra_CPLB_GL.btn_AddClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData, str, sPrefixStyle, sPrefixCode: string;
  sYear, sMonth, sDay, sDate: string;
begin
  if not IsCheck then Exit;
  try
    sSqlData := 'Select * from Set_ProductCategory where F_sClassName=''%s'' or F_iClassCode=''%s'' ';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[edt_cplb.Text,edt_bm.Text],True);
    if ADO_rec.RecordCount > 0 then
    begin
      str := '';
      if edt_bm.Text =  ADO_rec.FieldByName('F_iClassCode').AsString then
        str := str+',编码';
      if edt_cplb.Text =  ADO_rec.FieldByName('F_sClassName').AsString then
        str := str+',产品类别';
      str := Copy(str,2,Length(str));
      Application.MessageBox(PChar(str+'已存在,请重新输入!'),'提示',MB_ICONINFORMATION);
      ADO_Rec.Free;
      Exit;
    end;
    with ADO_Rec do
    begin
      Insert;
      FieldByName('F_iSort').AsString := edt_XH.Text;
      FieldByName('F_sClassName').AsString := edt_cplb.Text;
      FieldByName('F_iClassCode').AsString := edt_bm.Text;
//      sPrefixStyle := edt_PrefixStyle.Text;
//      FieldByName('F_sPrefixStyle').AsString := Trim(sPrefixStyle);
//      FieldByName('F_sNFGBRQ').AsString := cbb_year.Text+cbb_month.Text+cbb_day.Text;
//      sPrefixCode := StrReplace(sPrefixStyle,'year',FormatDateTime('yy',now));
//      //---------如果当天为更变日期,则前缀更变-----------------
//      sYear := cbb_year.Text;
//      sMonth := Copy(cbb_month.Text,1,Pos('月',cbb_month.Text)-1);
//      sDay := Copy(cbb_day.Text,1,Pos('日',cbb_day.Text)-1);
//      sDate := sMonth+sDay;
//      if FormatDateTime('MMdd',Now) = sDate then
//      begin
//        if sYear = c_CPLB_NextYear then
//          sYear := FormatDateTime('yy',Now)
//        else if sYear= c_CPLB_ThisYear then
//          sYear := FormatDateTime('yy',IncYear(Now));
//        sPrefixCode := StrReplace(sPrefixStyle,'year',sYear);
//      end;
//      //---------------------------------------------------------
//      FieldByName('F_sPrefixCode').AsString := Trim(sPrefixCode);
      Post;
    end;
    p_MessageBoxDlg('添加成功!');
    ClearText;
    p_LoadProceductCategory;
    edt_XH.SetFocus;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(e.Message),'提示',MB_ICONINFORMATION);
      Exit;
    end;
  end;
  ADO_Rec.Free;
end;

function TFra_CPLB_GL.IsCheck: Boolean;
var
  i: Integer;
  comp: TComponent;
begin
  Result := False;
  for i := 0 to Self.ComponentCount -1 do
  begin
    comp := Self.Components[i];
    if (comp is Ti_TxtFilter) or (comp is Ti_ComboBox) then
    begin
      if  comp.Tag <> 10 then
      begin
        if Ti_TxtFilter(comp).Text = '' then
        begin
          Application.MessageBox(PChar('请输入 '+Ti_TxtFilter(comp).LabelCaption+'!'),'提示',MB_ICONINFORMATION);
          Ti_TxtFilter(comp).SetFocus;
          Exit;
        end;
      end;        
    end;
  end;
  Result := True;
end;

procedure TFra_CPLB_GL.ClearText;
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

procedure TFra_CPLB_GL.stg_cplbxxLinkClick(Sender: TObject; ACol,
  ARow: Integer);
var
  sSqlData: string;
  iID: integer;
begin
  iID := StrToNum(stg_cplbxx.Cells[c_CPLB_CategoryID,ARow]);
  if iID = 0 then Exit;
  if ACol = c_CPLB_CZ then
  begin
    if Application.MessageBox(PChar('是否删除产品类别名称 "'+stg_cplbxx.Cells[c_CPLB_CPLBMC,ARow]+'" ?'),'提示',MB_YESNO +MB_ICONINFORMATION)= IDNO then Exit;
    if iID in [1,2] then
    begin
      p_MessageBoxDlg('此产品类别已使用,不能删除!');
      Exit;
    end;
    sSqlData := 'Delete Set_ProductCategory where F_iID=%d';
    try
      DM_DataBase.ExecQuery(sSqlData,[iID],True);
      stg_cplbxx.p_Delrow(ARow);
      p_MessageBoxDlg('删除成功!');
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar('删除失败:'+E.message),'提示',MB_ICONINFORMATION);
      end;
    end;                
  end;
end;

procedure TFra_CPLB_GL.btn_ModifyClick(Sender: TObject);
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
  sPrefixStyle, sPrefixCode: string;
  sYear, sMonth, sDay, sDate: string;
begin
  if stgSeletedID =0 then
  begin
    Application.MessageBox('请选择要修改的数据!','提示',MB_ICONINFORMATION);
    Exit;
  end;
  try
    sSqlData := 'Select * from Set_ProductCategory where F_iID=%d ';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[stgSeletedID],True);
    if ADO_Rec.RecordCount = 0 then
    begin
      p_MessageBoxDlg('数据不存在,不能修改!');
      ADO_Rec.Free;
      Exit;
    end;
    with ADO_Rec do
    begin
      Edit;
      FieldByName('F_iSort').AsString := edt_XH.Text;
      FieldByName('F_sClassName').AsString := edt_cplb.Text;
      FieldByName('F_iClassCode').AsString := edt_bm.Text;
//      sPrefixStyle := edt_PrefixStyle.Text;
//      FieldByName('F_sPrefixStyle').AsString := Trim(sPrefixStyle);
//      FieldByName('F_sNFGBRQ').AsString := cbb_year.Text+cbb_month.Text+cbb_day.Text;
//      sPrefixCode := StrReplace(sPrefixStyle,'year',FormatDateTime('yy',now));
//      //------------如果当天为更变日期,则前缀更变---------
//      sYear := cbb_year.Text;
//      sMonth := Copy(cbb_month.Text,1,Pos('月',cbb_month.Text)-1);
//      sDay := Copy(cbb_day.Text,1,Pos('日',cbb_day.Text)-1);
//      sDate := sMonth+sDay;
//      if FormatDateTime('MMdd',Now) = sDate then
//      begin
//        if sYear = c_CPLB_NextYear then
//          sYear := FormatDateTime('yy',Now)
//        else if sYear= c_CPLB_ThisYear then
//          sYear := FormatDateTime('yy',IncYear(Now));
//        sPrefixCode := StrReplace(sPrefixStyle,'year',sYear);
//      end;
//      //-------------------------------------------------
//      FieldByName('F_sPrefixCode').AsString := Trim(sPrefixCode);
      Post;
    end;
    p_MessageBoxDlg('修改成功!');
    ClearText;
    p_LoadProceductCategory;
  except
    on E: Exception do      
    begin
      Application.MessageBox(PChar('修改失败：'+E.Message),'提示',MB_ICONINFORMATION);
      Exit;
    end;
  end;
  ADO_Rec.Free;
end;

procedure TFra_CPLB_GL.edt_XHExit(Sender: TObject);
begin
  if (Ti_TxtFilter(Sender).Text <> '') and (not IsNum(Ti_TxtFilter(Sender).Text)) then
  begin
    p_MessageBoxDlg('字符无效,请输入数字!');
    Ti_TxtFilter(Sender).SetFocus;
    Exit;
  end;

end;

end.
