unit bainaADOQuery;

interface

uses
  SysUtils, Classes, DB, ADODB,DataClass,Dialogs,DBClient,cxGridCustomTableView,
  cxGraphics,cxGridDBTableView,Types;
{
  ���ۿ���˵��
  1.����  AllowPriceAcc (�Ƿ������ۿ���Ϊ True)
  2.������������
    PriceFieldName ������λ�� ��Ϊ�� ��Ĭ��  Price
    SumPriceFieldName �����λ�� ��Ϊ�� ��Ĭ�� sumprice
    DeptIDName ����ID��λ��  ��Ϊ�� ��Ĭ�� DeptID_
    BelongIDName ��������λ  ��Ϊ�� ��Ĭ�� BelongID
}
type
  {
    ���ݹ�����¼,���ڴ������ݹ�������
  }
  TDataSetLink = Record
    Child:TDataSet;
    MasterKey:String;
    ChildKey:String;
  End;

  {
    ��λ����,�������ø�����λ����
    PriceFieldName    ������λ
    SumPriceFieldName  �����λ
    DeptFieldName      ���ű����λ
    BelongFieldName    ��������λ
    CreatedByFieldName   ��������λ
    CheckFieldName   �����λ
    CheckByFieldName �������λ
    CheckdateFieldName ���������λ
  }
  TFieldOption = Class(TPersistent)
  private
    fPriceFieldName:String;
    fSumPriceFieldName:String;
    fDeptFieldName:String;
    fBelongFieldName:String;
    fCreatedByFieldName:String;
    fCheckFieldName:String;
    fCheckByFieldName:String;
    fCheckdateFieldName:String;
  published
    Property PriceFieldName:String read fPriceFieldName write fPriceFieldName;
    Property SumPriceFieldName:String read fSumPriceFieldName write fSumPriceFieldName;
    Property DeptFieldName:String read fDeptFieldName write fDeptFieldName;
    Property BelongFieldName:String read fBelongFieldName write fBelongFieldName;
    Property CreatedByFieldName:String read fCreatedByFieldName write fCreatedByFieldName;
    Property CheckFieldName:String read fCheckFieldName write fCheckFieldName;
    Property CheckByFieldName:String read fCheckByFieldName write fCheckByFieldName;
    Property CheckdateFieldName:String read fCheckdateFieldName write fCheckdateFieldName;
  End;
  TbainaADOQuery = class(TADOQuery)
  private
    {
      �����Ƿ�������ѯ(���ڿ���,����Ȩ��)
    }
    fisMainQuery:Boolean;

    {
      ����Where ���,�ݲ���
    }
    fWhereSQL:TStrings;

    {
      ���ݼ��Ļ�����Ϣ
      fTableName         ����
      fAliasName         ����
      fTableCaption      ��˵��
    }
    fTableName:string;
    fAliasName:String;
    fTableCaption:String; 
    {
      ���ӱ��ϵͳ����
      fMasterDataSet �������ݼ�
      fchildDataSets �ӱ����ݼ�
    }
    fMasterDataSet:TDataSetLink;
    fchildDataSets:Array of TDataSetLink;

    {
      �䱾��λ����,����Ȩ�޿���
      fFieldOption     ���ڶ�һЩ������λ���Ƶ�����
      fDeptPriceAcc   ����Щ���ž��е��۲鿴��Ȩ��
      fBelongPriceAcc   ����Щ��Ա���е��۲鿴��Ȩ��
    }
    fFieldOption:TFieldOption;
    fDeptPriceAcc:TStringList;
    fBelongPriceAcc:TStringList;

    {
      �����Ƿ���ҪȨ�޿���
      fAllowPriceAcc      �Ƿ�������Ƶ���Ȩ��
      isAccess:Boolean;  ��fAllowDeleteOrModifyAcc���Խ��г�ʼ��
      fAllowDeleteOrModifyAcc �Ƿ���Ҫ��ĳ�����Ͻ���ɾ�����޸�Ȩ�޿���
      AllowCheck:Boolean ��fAllowCheckAcc ���Խ��г�ʼ��
      fAllowCheckAcc  �Ƿ���Ҫ��ĳ�����Ͻ������Ȩ�޿���
    }
    fAllowPriceAcc:Boolean;
    fAllowDeleteOrModifyAcc:Boolean;
    fAllowCheckAcc:Boolean;
    function isAccess:Boolean;
    function AllowCheck:Boolean;
    
    procedure SetTableName(Value:String);
    procedure SetisMainQuery(Value:Boolean);
    procedure SetMasterDataSet(Value:TDataSetLink);
    function GetAccSql:String;

    //����״̬ȷ����ť״̬
    function SetButtonState:Boolean;
  protected
    function GetWhereSql:TStrings;
    procedure SetWhereSql(Value:TStrings);
    procedure DoAfterScroll;overload;
  public
    procedure InternalOpen;override;
    procedure InternalInsert; override;
    procedure InternalDelete; override;
    procedure InternalEdit; override;
    procedure InternalPost; override;
    procedure InternalCancel; override;
    function ExecSQL: Integer;
    procedure Post;
    function GetRecord(Buffer: PChar; GetMode: TGetMode; DoCheck: Boolean): TGetResult; override;
    function GetFieldData(Field: TField; Buffer: Pointer): Boolean;override;

    {
      ���ӱ����
    }
    function AddchildDataSet(DataSet:TbainaADOQuery;MasterKey:String;ChildKey:String):Boolean;
    Property MasterDataSet:TDataSetLink read fMasterDataSet write SetMasterDataSet;
    
    {
      Ȩ�޿���SQL ���
    }
    property AccSQL:String read GetAccSql;
    constructor Create(AOwner: TComponent);override;

    {
      ��ĳ�����Ͼ���ɾ��Ȩ��
    }
    function DeleteAcc(BelongID:Integer):Boolean;overload;
    function DeleteAcc:Boolean;overload;  

    {
      ��ĳ�����Ͼ����޸�Ȩ��
    }
    function ModifyAcc(BelongID:Integer):Boolean;overload;
    function ModifyAcc:Boolean;overload;

    {
      ��ĳ�����Ͼ��е��۲鿴Ȩ��
    }
    function isPriceAcc(BelongID:Integer):Boolean;overload;
    function isPriceAcc:Boolean;overload;
    function isPriceAcc(DeptID,BelongID:Integer):Boolean;overload;

    {
      ��ĳ�����Ͻ������
    }
    function Check(RecordID:Integer;RecordFieldName:String):Boolean;overload;
    function Check(RecordFieldName:String):Boolean;overload;
    function UnCheck(RecordID:integer;RecordFieldName:String):Boolean;overload;
    function UnCheck(RecordFieldName:String):Boolean;overload;

     {
     ������Ҫ���Ƶ��۵�CXGRID
     }
    procedure SetpricGrid(Sender: TcxCustomGridTableView);
    procedure PriceGrid1DBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

  published
    {
      ���ݼ�������Ϣ
    }
    property TableName:String read fTableName write SetTableName;
    property AliasName:String read fAliasName write fAliasName;
    property TableCaption:String read fTableCaption write fTableCaption;

    {
      �Ƿ�������ѯ
    }
    property isMainQuery:Boolean read fisMainQuery write SetisMainQuery;
    property WhereSQL:TStrings read  GetWhereSql write SetWhereSql;

    {
    ������λ����
    }
    Property FieldOption :TFieldOption read fFieldOption write fFieldOption;

    {
      �Ƿ�����Ȩ�޿�������
    }
    property AllowPriceAcc:Boolean read fAllowPriceAcc write fAllowPriceAcc;
    property AllowDeleteOrModifyAcc:Boolean read fAllowDeleteOrModifyAcc write fAllowDeleteOrModifyAcc;
    property AllowCheckAcc:Boolean read fAllowCheckAcc write fAllowCheckAcc;
  end;

procedure Register;

implementation
uses
  BaseDataFrom;
procedure Register;
begin
  RegisterComponents('BaiNa', [TbainaADOQuery]);
end;

{ TbainaADOQuery }


constructor TbainaADOQuery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fWhereSQL := TStringList.Create;
  fDeptPriceAcc   := TStringList.Create;
  fBelongPriceAcc := TStringList.Create;

  fFieldOption := TFieldOption.Create;
  fFieldOption.PriceFieldName        := 'Price';
  fFieldOption.SumPriceFieldName     := 'sumprice';
  fFieldOption.DeptFieldName         := 'DeptID_';
  fFieldOption.BelongFieldName       := 'BelongID';
  fFieldOption.CreatedByFieldName    := 'CreatedBy';
  fFieldOption.CheckFieldName        := 'IFCheck';
  fFieldOption.CheckByFieldName      := 'CheckMan';
  fFieldOption.CheckdateFieldName    := 'CheckDate';
  
  fAllowDeleteOrModifyAcc:= isAccess;
  fAllowCheckAcc         := AllowCheck;
end;

function TbainaADOQuery.DeleteAcc(BelongID: Integer): Boolean;
var
  UserID_:Integer;
  msql:String;
begin
  Result  := False;
  UserID_ := TDataClass(Self.Connection).UserID_;
  if UserID_ = BelongID  Then
  Begin
     Result := True;
     Exit;
  End;
  msql := 'Exec isDeleteAcc '+Inttostr(UserID_) + ','+ Inttostr(BelongID);
  try
     Result := Not TDataClass(Self.Connection).Query(msql).IsEmpty;
  finally
  End;
end;

function TbainaADOQuery.DeleteAcc: Boolean;
var
  BelongID:Integer;
begin
  Result := False;
  if Not fAllowDeleteOrModifyAcc Then
  Begin
    Result := True;
    Exit;
  End;
  if Self.IsEmpty  Then Exit;
  BelongID := FieldByName('BelongID').Asinteger;
  Result :=  DeleteAcc(BelongID);
end;

procedure TbainaADOQuery.DoAfterScroll;
begin
  inherited  DoAfterScroll;
end;


function TbainaADOQuery.GetAccSql: String;
var
  msql:String;
  UserID_ :Integer;
  Asname:String;
begin
  if  fAliasName <> '' Then AsName := fAliasName else AsName := Self.fTableName;
  UserID_ := TDataClass(Self.Connection).UserID_;
  msql := 'Exec GetRecordAccSql '''+Inttostr(UserID_)+''','''+AsName+'''';
  with TDataClass(Self.Connection).Query(msql) do
    if IsEmpty Then
      Result := ''
    else
      Result := Fields[0].AsString;
end;

function TbainaADOQuery.GetRecord(Buffer: PChar; GetMode: TGetMode;
  DoCheck: Boolean): TGetResult;
begin
  Result :=  inherited GetRecord(Buffer,GetMode,DoCheck);
end;

function TbainaADOQuery.GetWhereSql: TStrings;
begin
  Result := fWhereSQL;
end;

procedure TbainaADOQuery.InternalCancel;
begin
  inherited;
  
end;

procedure TbainaADOQuery.InternalDelete;
begin
  inherited;
end;

procedure TbainaADOQuery.InternalEdit;
begin
  inherited;
end;


procedure TbainaADOQuery.InternalInsert;
begin
  inherited;

end;

procedure TbainaADOQuery.InternalOpen;
begin
  inherited InternalOpen;
end;


procedure TbainaADOQuery.InternalPost;
begin
  inherited InternalPost;
end;

function TbainaADOQuery.isAccess: Boolean;
var
  msql:String;
begin
  Result := fisMainQuery;
  if Not Result Then Exit;
  msql :=
    'Select name from sysobjects  '+#10+
    'where '+#10+
	  'name = '''+fTableName+''' and  '+#10+
	  'id in   '+#10+
		'('+#10+
			  'select'+#10+ 
				 'id'+#10+
			  'from syscolumns '+#10+
			  'where '+#10+
			  'name = '''+fFieldOption.DeptFieldName+''''+#10+
		')  and '+#10+
	  'id in '+#10+
		'( '+#10+
			'select '+#10+
				'id'+#10+
			'from syscolumns'+#10+
			'where'+#10+
			'name = '''+fFieldOption.BelongFieldName+''''+#10+
		')';
    Result := not TDataClass(Self.Connection).Query(msql).IsEmpty;
end;

function TbainaADOQuery.ModifyAcc(BelongID: Integer): Boolean;
var
  UserID_:Integer;
  msql:String;
begin
  Result  := False;
  UserID_ := TDataClass(Self.Connection).UserID_;
  if UserID_ = BelongID  Then
  Begin
     Result := True;
     Exit;
  End;
  msql := 'Exec isModifyAcc '+Inttostr(UserID_) + ','+ Inttostr(BelongID);
  try
     Result :=not TDataClass(Self.Connection).Query(msql).IsEmpty;
  finally
  End;
end;

function TbainaADOQuery.isPriceAcc: Boolean;
var
  BelongID:Integer;
begin
  Result := False;
  If (not AllowPriceAcc) or (fFieldOption.BelongFieldName='') Then Exit;
  if Self.IsEmpty  Then Exit;
  BelongID := FieldByName(fFieldOption.BelongFieldName).Asinteger;
  Result :=  isPriceAcc(BelongID);
end;

function TbainaADOQuery.ModifyAcc: Boolean;
var
  BelongID:Integer;
begin
  Result := False;
  if Not fAllowDeleteOrModifyAcc Then
  Begin
    Result := True;
    Exit;
  End;
  if Self.IsEmpty  Then Exit;
  BelongID := FieldByName('BelongID').Asinteger;
  Result :=  ModifyAcc(BelongID);
end;

function TbainaADOQuery.SetButtonState: Boolean;
begin
  
end;

procedure TbainaADOQuery.SetisMainQuery(Value: Boolean);
var
  i:integer;
begin
  fisMainQuery := Value;
  if Owner is TBaseData_Frm Then
  begin
    TBaseData_Frm(Owner).MainQuery := nil;
    for i := 0 to  TBaseData_Frm(Owner).ComponentCount -1 do
    begin
      if (TBaseData_Frm(Owner).Components[i] is TbainaADOQuery) and
        TbainaADOQuery(TBaseData_Frm(Owner).Components[i]).isMainQuery Then
      Begin
        TBaseData_Frm(Owner).MainQuery := TbainaADOQuery(TBaseData_Frm(Owner).Components[i]);
      End;
    end;
  end;
end;

procedure TbainaADOQuery.SetTableName(Value: String);
begin
  if value = fTableName Then exit;
  fTableName := Value;
  SQL.Text := 'Select * From '+fTableName;
end;

procedure TbainaADOQuery.SetWhereSql(Value: TStrings);
begin
  if Value = nil Then exit;
  fWhereSQL.Assign(Value);
end;

function TbainaADOQuery.isPriceAcc(BelongID: Integer): Boolean;
var
  UserID_:Integer;
  msql:String;
begin
  Result  := False;
  UserID_ := TDataClass(Self.Connection).UserID_;
  if UserID_ = BelongID  Then
  Begin
     Result := True;
     Exit;
  End;
  msql := 'Exec isPriceAcc '+Inttostr(UserID_) + ','+ Inttostr(BelongID);
  try
     Result :=not TDataClass(Self.Connection).Query(msql).IsEmpty;
  finally
  End;
end;

function TbainaADOQuery.AllowCheck: Boolean;
var
  msql:String;
begin
  Result := fisMainQuery;
  if Not Result Then Exit;
  msql :=
    'Select name from sysobjects  '+#10+
    'where '+#10+
	  'name = '''+fTableName+''' and  '+#10+
	  'id in   '+#10+
		'('+#10+
			  'select'+#10+
				 'id'+#10+
			  'from syscolumns '+#10+
			  'where '+#10+
			  'name = '''+fFieldOption.CheckFieldName+''''+#10+
		')';
  try
    Result := not TDataClass(Self.Connection).Query(msql).IsEmpty;
  finally
  end;
end;

function TbainaADOQuery.Check(RecordFieldName:String): Boolean;
var
  RecordID:Integer;
begin
  Result := False;
  If (Not Active) or (isEmpty) Then Exit;
  RecordID := FieldByName(RecordFieldname).asinteger;
  Result := Check(RecordID,RecordFieldName);
end;

function TbainaADOQuery.Check(RecordID: Integer;RecordFieldName:String): Boolean;
var
  msql,mes:String;
begin
  Result := False;
  if (RecordID = 0) or (Self.fTableName ='') Then Exit;
  if Not fAllowCheckAcc Then
  Begin
    if Self.fTableCaption <> '' Then
      mes := Self.TableCaption + '����Ҫ���!'
    else
      mes := Self.fTableName  + '����Ҫ���!';
    ShowMessage(mes);
    Exit;
  End;
  
  Try
    Edit;
    Self.FieldByName(fFieldOption.CheckFieldName).AsBoolean:=Boolean(1);
    Self.FieldByName(fFieldOption.CheckByFieldName).AsString:=TDataClass(Self.Connection).UserName_;
    Self.FieldByName(fFieldOption.CheckdateFieldName).AsDateTime:=Date;
    Post;
  Finally
  End;
end;

function TbainaADOQuery.UnCheck(RecordID: integer;RecordFieldName:String): Boolean;
var
  mes:String;
begin
  Result := False;
  if (RecordID = 0) or (Self.fTableName ='') Then Exit;
  if Not fAllowCheckAcc Then
  Begin
    if Self.fTableCaption <> '' Then
      mes := Self.TableCaption + '����Ҫ�����!'
    else
      mes := Self.fTableName  + '����Ҫ�����!';
    ShowMessage(mes);
    Exit;
  End;
  Try
    Edit;
    Self.FieldByName(fFieldOption.CheckFieldName).AsBoolean:=Boolean(0);
    Self.FieldByName(fFieldOption.CheckByFieldName).AsString:=TDataClass(Self.Connection).UserName_;
    Self.FieldByName(fFieldOption.CheckdateFieldName).AsDateTime:=Date;
    Post;
  Finally
  End;
end;

function TbainaADOQuery.UnCheck(RecordFieldName:String): Boolean;
var
  RecordID:Integer;
begin
  Result := False;
  If (Not Active) or (isEmpty) Then Exit;
  RecordID := FieldByName(RecordFieldname).asinteger;
  Result := Check(RecordID,RecordFieldName);
end;

function TbainaADOQuery.GetFieldData(Field: TField;
  Buffer: Pointer): Boolean;
begin
  Result := inherited GetFieldData(Field,Buffer);
end;

function TbainaADOQuery.isPriceAcc(DeptID, BelongID: Integer): Boolean;
var
  i:integer;
  UserID_:integer;
  //ȡȨ��
  function FiterAllPriceAcc(userID:integer):Boolean;
  var
    msql :String;
  begin
     msql := 'Exec GetAllPriceAcc '+Inttostr(userID);
    try
      With TDataClass(Connection).Query(msql) Do
      Begin
        While Not Eof Do
        Begin
          if FieldByname('SType').AsInteger = 0 Then
            fDeptPriceAcc.Add(FieldByname('Dept_').AsString)
          else
            fBelongPriceAcc.Add(FieldByname('Dept_').AsString);
          Next;
        End;
      End;
    finally
    end;
  end;
begin
  Result := False;
  UserID_ := TDataClass(Connection).UserID_;
  if (Not fAllowPriceAcc) or (Connection = nil) or (UserID_ = BelongID)  Then
  Begin
    Result := True;
    Exit;
  End;
  if (fBelongPriceAcc.Count <=0) and (fDeptPriceAcc.Count <=0) Then
     FiterAllPriceAcc(UserID_);

  //ȡȨ�� (�û�)
  for i := 0 To fBelongPriceAcc.Count -1 Do
  Begin
    if  fBelongPriceAcc.Strings[i] = Inttostr(BelongID) Then
    Begin
      Result := True;
      Exit;
    End;
  End;

  //ȡȨ��(����)
  for i := 0 To fDeptPriceAcc.Count -1 Do
  Begin
    if fDeptPriceAcc.Strings[i] = IntToStr(DeptID) Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

procedure TbainaADOQuery.PriceGrid1DBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  FBounds:TRect;
  FieldName:String;
  BelongID,DeptID:Integer;

  function GetIDValueByName(Fieldname:String):Integer;
  var
    row,col:integer;
  begin
    row := AviewInfo.GridRecord.Index;
    for col := 0 To (Sender as TcxGridDBTableView).ColumnCount -1 Do
    Begin
      if (Sender as TcxGridDBTableView).Columns[col].DataBinding.FieldName =
         Fieldname Then
         break; 
    End;
    if Col >=  (Sender as TcxGridDBTableView).ColumnCount Then
    Begin
      Result := 0 ;
      Exit;
    End;
    Result := (Sender as TcxGridDBTableView).DataController.Values[row,col];
  end;
begin
  if (not fAllowPriceAcc)  or
      (fFieldOption.PriceFieldName = '') or
      (fFieldOption.SumPriceFieldName ='') or
      (fFieldOption.DeptFieldName = '') or
      (fFieldOption.BelongFieldName='')  Then Exit;
  
  FieldName := TcxGridDBColumn(AViewInfo.Item).DataBinding.fieldname;
  if (FieldName <> fFieldOption.PriceFieldName) and (FieldName <> fFieldOption.SumPriceFieldName) Then Exit;

  //��ʼ����Ȩ��
  BelongID := GetIDValueByName(fFieldOption.BelongFieldName);
  DeptID   := GetIDValueByName(fFieldOption.DeptFieldName);
  if (BelongID = 0) and (DeptID = 0) Then Exit;

  if Not isPriceAcc(DeptID,BelongID) Then
  Begin
    FBounds   :=   AViewInfo.Bounds;
    ACanvas.FillRect(FBounds);
    ACanvas.DrawTexT('***',FBounds,1);
    ADone := True;
  End Else
  Begin
    FBounds   :=   AViewInfo.Bounds;
    ACanvas.FillRect(FBounds);
    ACanvas.DrawTexT(aviewinfo.Text,FBounds,1);
    ADone := True;
  End;
end;

procedure TbainaADOQuery.SetpricGrid(Sender: TcxCustomGridTableView);
begin
  Sender.OnCustomDrawCell := PriceGrid1DBTableView1CustomDrawCell;
end;

function TbainaADOQuery.AddchildDataSet(DataSet: TbainaADOQuery; MasterKey,
  ChildKey: String): Boolean;
var
  i:Integer;
  MasterLink:TDataSetLink;
  function ExistsChildDataSet(DataSet:TBainaADOQuery):Boolean;
  var
    t:Integer;
  begin
    Result := False;
    for t := 0 To high(fchildDataSets) do
    Begin
      if fchildDataSets[t].Child = DataSet Then
      Begin
        Result := True;
        Exit;
      End;
    End;
  end;
begin
  if ExistsChildDataSet(DataSet) Then Exit;
  i := high(fchildDataSets);
  if i <= 0 Then i := 0;
  i := i + 1;
  SetLength(fchildDataSets,i);
  fchildDataSets[i-1].Child     := DataSet;
  fchildDataSets[i-1].MasterKey := MasterKey;
  fchildDataSets[i-1].ChildKey  := ChildKey;

  MasterLink.Child.Assign(Self);
  MasterLink.MasterKey  := MasterKey;
  MasterLink.ChildKey   := ChildKey;
  TbainaADOQuery(fchildDataSets[i-1].Child).SetMasterDataSet(MasterLink);
end;

procedure TbainaADOQuery.SetMasterDataSet(Value: TDataSetLink);
begin
  fMasterDataSet.Child.Assign(Value.Child);
  fMasterDataSet.MasterKey := Value.MasterKey;
  fMasterDataSet.ChildKey  := Value.ChildKey;
end;

function TbainaADOQuery.ExecSQL: Integer;
begin
  try
    Result := inherited ExecSQL ;
    TDataClass(Connection).WriteoperateLog(SQL.Text);
  Except
    TDataClass(Connection).WriteErrorLog(SQL.Text);
  End;
end;

procedure TbainaADOQuery.Post;
var
  info,Table_Name:String;
begin
  if TableCaption <> '' Then
    Table_Name := TableCaption
  else
    Table_Name := TableName;
  try
    inherited Post();
    Info := Table_Name + ' ����ɹ�!';
    TDataClass(Connection).WriteoperateLog(Info);
  except
    Info := Table_Name + ' �������:'+Sql.Text;
    TDataClass(Connection).WriteErrorLog(Info);
  end;
end; 

end.
