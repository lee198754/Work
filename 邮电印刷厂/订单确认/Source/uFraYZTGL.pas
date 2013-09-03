unit uFraYZTGL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, iGrid, RzButton, StdCtrls, ButtonEdit, RzCmboBx,
  iComboBox, ExtCtrls, RzPanel,ADODB,uBaseForm;

const
  c_cplb = 0;    //产品类别
  c_xh = 1;      //序号
  c_nf = 2;      //年份
  c_cplx = 3;    //产品类型
  c_yztmc = 4;   //邮资图名称
  c_PPGZ = 5;    //匹配规则
  c_FHGL_MZ = 6;      //面值
  c_F_iID = 7;    //Set_ProductCategory表ID

type
  TFra_yztgl = class(TFrmFrame)
    RzGroupBox1: TRzGroupBox;
    stg_yztxx: Ti_StgEdit;
    RzGroupBox2: TRzGroupBox;
    cbb_cplb: Ti_ComboBox;
    cbb_yztmc: Ti_TxtFilter;
    cbb_mz: Ti_TxtFilter;
    btn_Add: TRzButton;
    btn_Modify: TRzButton;
    btn_Del: TRzButton;
    cbb_nf: Ti_TxtFilter;
    cbb_xh: Ti_TxtFilter;
    cbb_cplx: Ti_ComboBox;
    edt_PPGZ: Ti_TxtFilter;
    Label1: TLabel;
    procedure stg_yztxxSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btn_ModifyClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure ClearBlank;
    procedure btn_DelClick(Sender: TObject);
    procedure cbb_cplbChange(Sender: TObject);
    procedure cbb_xhKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    stgSeletedID: Integer;
    function GetBlankData: string;
    function IsCheck: Boolean;
    procedure ReadDataYZTXX;
  public
    { Public declarations }
    procedure FraShow;
  end;

implementation

uses
  uDM_DataBase,PubStr,uPub_Type,uPub_Func,uPub_Text;

{$R *.dfm}


{ TFra_yztgl }

procedure TFra_yztgl.ReadDataYZTXX;
var
  n: Integer;
  sCplb,sProductCategoryID: string;
  ADO_Rec: TADOQuery;
begin
  try
    ADO_Rec := TADOQuery.Create(Self);
    DM_DataBase.GetTableData(ADO_Rec,'Set_PostageType','1=1 order by F_sNf desc,F_iProductCategoryID,F_iSort ');
    stg_yztxx.Clear;
    stg_yztxx.RowCount := iif(ADO_Rec.RecordCount > 0, ADO_Rec.RecordCount +1, 2);
    n := 1;
    with ADO_Rec do
    begin
      First;
      while not Eof do
      begin
        sProductCategoryID := FieldByName('F_iProductCategoryID').AsString;
        if sProductCategoryID = '' then sProductCategoryID := '0';
        sCplb :=  DM_DataBase.GetTableFirst('Select F_sClassName from Set_ProductCategory where F_iID='+sProductCategoryID);
        stg_yztxx.cells[c_cplb ,n] := sCplb;
        stg_yztxx.cells[c_xh,n] := FieldByName('F_iSort').AsString;
        stg_yztxx.cells[c_nf,n] := FieldByName('F_sNf').AsString;
        stg_yztxx.cells[c_cplx,n] := FieldByName('F_sCPLX').AsString;
        stg_yztxx.cells[c_yztmc,n] := FieldByName('F_sYZTMC').AsString ;
        stg_yztxx.cells[c_PPGZ,n] := FieldByName('F_sPPGZ').AsString ;
        stg_yztxx.cells[c_FHGL_MZ,n] := FieldByName('F_sMz').AsString ;
        stg_yztxx.Cells[c_F_iID,n] := FieldByName('F_iID').AsString;
        inc(n);
        Next;
      end;
    end;
    stg_yztxx.ColWidths[c_F_iID] := 0;
  finally
    ADO_Rec.Free;
  end;
end;

procedure TFra_yztgl.stg_yztxxSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  iProductCategoryID: Integer;
begin
  cbb_cplb.ItemIndex := cbb_cplb.IndexOf(stg_yztxx.cells[c_cplb ,ARow]);
  cbb_xh.Text := stg_yztxx.cells[c_xh ,ARow];
  cbb_nf.Text := stg_yztxx.cells[c_nf ,ARow];
  iProductCategoryID := FindProductCategoryID(cbb_cplb.ItemIndex);
  cbb_cplx.Clear;
  CbbAdd(cbb_cplx,pkProductType,iProductCategoryID);
  cbb_cplx.ItemIndex := cbb_cplx.IndexOf(stg_yztxx.cells[c_cplx ,ARow]);
  cbb_yztmc.Text := stg_yztxx.cells[c_yztmc ,ARow];
  edt_PPGZ.Text := stg_yztxx.cells[c_PPGZ ,ARow];
  cbb_mz.Text := stg_yztxx.cells[c_FHGL_MZ ,ARow];
  stgSeletedID := StrToNum(stg_yztxx.cells[c_F_iID ,ARow]);
end;

procedure TFra_yztgl.btn_ModifyClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  iProductCategoryID, iProductTypeID, iClassCode: Integer;
  str: string;
  sSqlData: string;
  sClassName, sCPLX: string;
begin
  if stgSeletedID =0 then
  begin
    Application.MessageBox('请选择要修改的数据!','提示',MB_ICONINFORMATION);
    Exit;
  end;
  str := GetBlankData;
  if str <> '' then
  begin
    Application.MessageBox(PChar(str),'提示',MB_ICONINFORMATION);
    Exit;
  end;
  if not IsCheck then Exit;
  try
    try
      sSqlData := 'Select b.F_sClassName,a.F_sCPLX from Set_PostageType a,Set_ProductCategory b '
        +' where a.F_iProductCategoryID=b.F_iID and a.F_sYZTMC=''%s'' and a.F_sNF=''%s'' and b.F_sClassName=''%s'' and IsNull(a.F_sPPGZ,'''')=''%s'' '
        +' and a.F_iID <> %d ';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[cbb_yztmc.Text,cbb_nf.Text,cbb_cplb.Text,edt_PPGZ.Text,stgSeletedID],True);
      if ADO_Rec.RecordCount > 0 then
      begin
        sClassName := ADO_Rec.FieldByName('F_sClassName').AsString;
        sCPLX := ADO_Rec.FieldByName('F_sCPLX').AsString;
        str := '此相同匹配规则的邮资图已存在。'+'产品类别：'+sClassName+'; 产品类型：'+sCPLX+'！';
        p_MessageBoxDlg(str);
        Exit;
      end;
      DM_DataBase.GetTableData(ADO_Rec,'Set_PostageType','F_iID='+IntToStr(stgSeletedID));
      with ADO_Rec do
      begin
        Edit;
        FieldByName('F_iSort').AsInteger := Trunc(StrToNum(cbb_xh.Text));
        FieldByName('F_sNF').AsString := cbb_nf.Text;
        iClassCode := FindProductCategoryCode(cbb_cplb.ItemIndex);
        iProductTypeID := FindProductTypeID(cbb_cplx.ItemIndex,iClassCode);
        FieldByName('F_iProductTypeID').AsInteger := iProductTypeID;
        FieldByName('F_sCPLX').AsString := cbb_cplx.Text;
        FieldByName('F_sYZTMC').AsString := cbb_yztmc.Text;
        FieldByName('F_sMz').AsString := cbb_mz.Text;
        FieldByName('F_sPPGZ').AsString := edt_PPGZ.Text;
        iProductCategoryID := FindProductCategoryID(cbb_cplb.ItemIndex);
        FieldByName('F_iProductCategoryID').AsInteger := iProductCategoryID;
        Post;
      end;
      p_MessageBoxDlg('修改成功!');
      ClearBlank;
      ReadDataYZTXX;
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

procedure TFra_yztgl.btn_AddClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  iProductCategoryID, iProductTypeID, iClassCode: Integer;
  str: string;
  sSqlData: string;
  sClassName, sCPLX, sNF: string;
begin
  str := GetBlankData;
  if str <> '' then
  begin
    Application.MessageBox(PChar(str),'提示',MB_ICONINFORMATION);
    Exit;
  end;
  if not IsCheck then Exit;
  try
    try
      //暂不限制邮资图重复添加
      sSqlData := 'Select b.F_sClassName,a.F_sCPLX,a.F_sNF from Set_PostageType a,Set_ProductCategory b '
        + ' where a.F_iProductCategoryID=b.F_iID and a.F_sYZTMC=''%s'' and a.F_sNF=''%s'' and b.F_sClassName=''%s'' and IsNull(a.F_sPPGZ,'''')=''%s''';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[cbb_yztmc.Text,cbb_nf.Text,cbb_cplb.Text,edt_PPGZ.Text],True);
      if ADO_Rec.RecordCount > 0 then
      begin
        sClassName := ADO_Rec.FieldByName('F_sClassName').AsString;
        sCPLX := ADO_Rec.FieldByName('F_sCPLX').AsString;
        sNF := ADO_Rec.FieldByName('F_sNF').AsString;
        str := '此相同匹配规则的邮资图已存在。'+'年份：'+sNF+'; 产品类别：'+sClassName+'; 产品类型：'+sCPLX+'！';
        p_MessageBoxDlg(str);
        Exit;
      end;
      ADO_Rec := TADOQuery.Create(Self);
      DM_DataBase.GetTableData(ADO_Rec,'Set_PostageType');
      with ADO_Rec do
      begin
        Insert;
        FieldByName('F_iSort').AsInteger := StrToNum(cbb_xh.Text);
        FieldByName('F_sNF').AsString := cbb_nf.Text;
        iClassCode := FindProductCategoryCode(cbb_cplb.ItemIndex);
        iProductTypeID := FindProductTypeID(cbb_cplx.ItemIndex,iClassCode);
        FieldByName('F_iProductTypeID').AsInteger := iProductTypeID;
        FieldByName('F_sCPLX').AsString := cbb_cplx.Text;
        FieldByName('F_sYZTMC').AsString := cbb_yztmc.Text;
        FieldByName('F_sPPGZ').AsString := edt_PPGZ.Text;
        FieldByName('F_sMz').AsString := cbb_mz.Text;
        iProductCategoryID := FindProductCategoryID(cbb_cplb.ItemIndex);
        FieldByName('F_iProductCategoryID').AsInteger := iProductCategoryID;
        Post;
      end;
      p_MessageBoxDlg('添加成功!');
      ClearBlank;
      ReadDataYZTXX;
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

procedure TFra_yztgl.ClearBlank;
var
  i: Integer;
begin
  for i := 0 to Self.ComponentCount -1 do
  begin
    if Self.Components[i] is Ti_TxtFilter then
      Ti_TxtFilter(Self.Components[i]).Text := ''
    else
    if Self.Components[i] is Ti_ComboBox then
      Ti_ComboBox(Self.Components[i]).Clear;
  end;
  CbbAdd(cbb_cplb,pkProductCategory);
  stgSeletedID := 0;
end;

procedure TFra_yztgl.btn_DelClick(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  PStr: PChar;
begin
  if stgSeletedID =0 then
  begin
    Application.MessageBox('请选择要删除的数据!','提示',MB_ICONINFORMATION);
    Exit;
  end;
  PStr := PChar('是否要删除:'+#13#10+'产品类别：'+ cbb_cplb.Text +#13#10+'年份：'
    + cbb_nf.Text +#13#10+'产品类型：'+ cbb_cplx.Text +#13#10+'邮资图名称：'+ cbb_yztmc.Text);
  if  Application.MessageBox(PStr,'提示',MB_ICONINFORMATION+ MB_YESNO) = IDNO then Exit;
  try
    try
      ADO_Rec := TADOQuery.Create(Self);
      DM_DataBase.GetTableData(ADO_Rec,'Set_PostageType','F_iID='+IntToStr(stgSeletedID));
      ADO_Rec.Delete;
      p_MessageBoxDlg('删除成功!');
      ClearBlank;
      ReadDataYZTXX;
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

procedure TFra_yztgl.cbb_cplbChange(Sender: TObject);
var
  iProductCategoryID: Integer;
begin
  iProductCategoryID := FindProductCategoryID(cbb_cplb.ItemIndex);
  cbb_cplx.Clear;
  CbbAdd(cbb_cplx,pkProductType,iProductCategoryID);
end;

procedure TFra_yztgl.cbb_xhKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Ord(Key) < Ord('0')) or (Ord(Key)>Ord('9'))) and (Ord(Key)<> VK_BACK)  then
    Key := #0;
end;

function TFra_yztgl.GetBlankData: string;
begin
  Result := '';
  if cbb_yztmc.Text = '' then
    Result := Result+',邮资图名称';
  if cbb_nf.Text = '' then
    Result := Result+',年份';
  if cbb_cplb.Text = '' then
    Result := Result+',产品类别';
  if cbb_cplx.Text = '' then
    Result := Result+',产品类型';
  if Result <> '' then
    Result := Copy(Result,2,Length(Result))+'不能为空!';
end;


function TFra_yztgl.IsCheck: Boolean;
var
  iLen: integer;
begin
  Result := False;
  iLen := Length(edt_PPGZ.Text);
  if (iLen>0) and (iLen<>17) then
  begin

    p_MessageBoxDlg('请输入产品编号前 17 位!(当前输入了 '+IntToStr(iLen)+' 位)');
    edt_PPGZ.SetFocus;
    Exit;
  end else
  if iLen = 17 then
  begin
    if not (((Copy(edt_PPGZ.Text,3,1)='-') or (Copy(edt_PPGZ.Text,3,1)='*'))
      and ((Copy(edt_PPGZ.Text,10,1)='-') or (Copy(edt_PPGZ.Text,10,1)='*'))
      and ((Copy(edt_PPGZ.Text,13,1)='-') or (Copy(edt_PPGZ.Text,13,1)='*'))) then
    begin
      p_MessageBoxDlg('匹配规则输入有误!');
      edt_PPGZ.SetFocus;
      Exit;
    end;
  end;
  Result := True;
end;

procedure TFra_yztgl.FraShow;
var
  sCplb,sCplx: string;
begin
  ReadDataYZTXX;
  sCplb := cbb_cplb.Text;
  cbb_cplb.Clear;
  CbbAdd(cbb_cplb,pkProductCategory);
  cbb_cplb.ItemIndex := cbb_cplb.IndexOf(sCplb);
  sCplx := cbb_cplx.Text;
  cbb_cplbChange(cbb_cplb);
  cbb_cplx.ItemIndex := cbb_cplx.IndexOf(sCplx);

end;

end.


