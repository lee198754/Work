unit uDM_DataBase;

interface

uses
  SysUtils, Classes, MemTableDataEh, Db, ADODB, DataDriverEh,
  MemTableEh, IdBaseComponent, IdComponent, IdRawBase,
  IdRawClient, IdIcmpClient, Windows, Messages, Variants, Graphics,
  Controls, Forms, Dialogs, RM_e_Graphic, RM_e_Jpeg, RM_Common, RM_Class,
  RM_e_Xls, GridRow;



const
  DatabaseUserName = 'yd';
  DatabaseUserPwd = '000000';

type
  //TADOQueryM = TADOQuery;
  TReconnectionThread=class(TThread)     //重新连接数据库
  protected
    procedure   Execute;override;
  end;

  TDM_DataBase = class(TDataModule)
    ADO_DataRec: TADOQuery;
    Con_YDPrint: TADOConnection;
    ds_show: TDataSource;
    ADO_Print: TADOQuery;
    ADO_Temp: TADOQuery;
    IdIcmpClient1: TIdIcmpClient;
    mte_DataRec: TMemTableEh;
    dsd_DataRec: TDataSetDriverEh;
    ds_Temp: TDataSource;
    ADO_MOD: TADOQuery;
    ADO_FHCX: TADOQuery;
    ds_FHCX: TDataSource;
    dsd_FHCX: TDataSetDriverEh;
    mte_FHCX: TMemTableEh;
    ADO_XQXX: TADOQuery;
    ds_XQXX: TDataSource;
    dsd_xqxx: TDataSetDriverEh;
    mte_xqxx: TMemTableEh;
    ADO_FHFK: TADOQuery;
    ds_FHFK: TDataSource;
    ADO_XHQD: TADOQuery;
    ds_XHQD: TDataSource;
    RMXLSExport1: TRMXLSExport;
    RMJPEGExport1: TRMJPEGExport;
    gr_dc: TGridRow_X;
    ADO_DataArchiving: TADOQuery;
    ds_DataArchiving: TDataSource;
    Con_History: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure ADO_XQXXAfterEdit(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    vServicesConnect: string;
    vUrl: string;
    function GetTableData(out ADO_Rec: TADOQuery;TableName: string;Data: string='1=2'): Boolean;   //获取返回数据集
    function OpenQuery(SQLText: String; const Args: array of const;bRaise: Boolean=False;bHistory: Boolean=False): TADOQuery; overload;   //获取返回数据集;bRaise(是否抛出异常)
    function ExecQuery(SQLText: String; const Args: array of const;bRaise: Boolean=False;bHistory: Boolean=False): Boolean;  overload;  //获取执行SQL语句;bRaise(是否抛出异常)
    function OpenQuery(SQLText: String; const Args: array of const;bRaise: Boolean;ADOCon: TADOConnection): TADOQuery; overload;  //使用传入的TADOConnection,获取返回数据集;bRaise(是否抛出异常)
    function ExecQuery(SQLText: String; const Args: array of const;bRaise: Boolean;ADOCon: TADOConnection): Boolean;  overload;  //使用传入的TADOConnection,获取执行SQL语句;bRaise(是否抛出异常)
    function GetMaxID(Sql: string): Integer;  overload;       //取最大值
    function GetMaxID(TableName,Name: string; var Value: string;iType:  Integer=0;iCount: Integer=1): Boolean; overload;       //取最大值
    function GetTableFirst(Sql: string): Variant;        //取第一项的值
    function UpdateTable(Sql: string): Boolean;        //更新表
    function WriteSynLog(TableName: string;TableDateID: Integer;OperateType: Integer): Boolean; overload;       //写同步日志
    function WriteSynLog(sSQL: string): Boolean; overload;        //写同步日志语句
  end;

var
  DM_DataBase: TDM_DataBase;
  vServicesIP: string;


implementation

uses
  IniFiles;

{$R *.dfm}

var
  ReconnectionThread: TReconnectionThread;
  vbReconnection: Boolean=False;   //重新连接数据库

procedure TDM_DataBase.DataModuleCreate(Sender: TObject);
var
  ini: TIniFile;
  str, sPath: string;
  ServicesIP,InstanceName,ServicesConnect: string;
begin
  Con_YDPrint.Connected := False;
  Con_History.Connected := False;
  Con_YDPrint.Close;
  Con_History.Close;
  sPath := ExtractFilePath(Application.ExeName);
  ini := TIniFile.Create(sPath+'set.ini');
//  ReconnectionThread := TReconnectionThread.Create(False);
  ServicesConnect := ini.ReadString('Set','ServicesConnect','');
   vServicesIP := ini.ReadString('Set','ServicesIP','');
  if vServicesIP = '' then
    vServicesIP := '127.0.0.1';
  //当前TADOConnection连接设置
  if ServicesConnect = '' then
  begin
    ServicesIP := ini.ReadString('Set','ServicesIP','');
//    if ServicesIP <> '' then
//    begin
//      IdIcmpClient1.Host := ServicesIP;
//      IdIcmpClient1.Ping;
//    end;
    InstanceName := ini.ReadString('Set','InstanceName','');
    if InstanceName <> '' then
      InstanceName := '\'+InstanceName;
    if ServicesIP <> '' then
      str := Format('Provider=SQLOLEDB.1;Password=%s;Persist Security Info=True;User ID=%s;Initial Catalog=%s;Data Source=',
        [DatabaseUserPwd,DatabaseUserName,'YDPrint'])
    else
      str := Format('Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=%s;Data Source=.',
        ['YDPrint']);
    vServicesConnect := str + ServicesIP+InstanceName;
  end else
    vServicesConnect := ServicesConnect;

  Con_YDPrint.ConnectionString := vServicesConnect;

  //历史TADOConnection连接设置
  if ServicesConnect = '' then
  begin
    if ServicesIP <> '' then
      str := Format('Provider=SQLOLEDB.1;Password=%s;Persist Security Info=True;User ID=%s;Initial Catalog=%s;Data Source=',
        [DatabaseUserPwd,DatabaseUserName,'YDPrint_History'])
    else
      str := Format('Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=%s;Data Source=.',
        ['YDPrint_History']);
    Con_History.ConnectionString := str + ServicesIP+InstanceName;
  end else
    Con_History.ConnectionString := StringReplace(ServicesConnect,'YDPrint','YDPrint_History',[rfReplaceAll,rfIgnoreCase]);


  vUrl := ini.ReadString('WebServices','Url','');
//  vUserName := ini.ReadString('Set','UserName','');
//  vUserPwd := ini.ReadString('Set','UserPwd','');

  ini.Free;
end;

procedure TDM_DataBase.ADO_XQXXAfterEdit(DataSet: TDataSet);
begin
//  if ADO_XQXX.FieldByName('XZ').AsBoolean = False then
//    ADO_XQXX.FieldByName('XZ').AsBoolean := True;
end;

function TDM_DataBase.OpenQuery(SQLText: String;
  const Args: array of const; bRaise: Boolean;bHistory: Boolean): TADOQuery;
begin
  if not bHistory then
    Result := OpenQuery(SQLText,Args,bRaise,Con_YDPrint)
  else
    Result := OpenQuery(SQLText,Args,bRaise,Con_History);

//  Result := nil;
//  vbThreadStopping := True;
//  try
//    Result:= TADOQuery.Create(Self);
//    if not bHistory then
//      Result.Connection := Con_YDPrint
//    else
//      Result.Connection := Con_History;
//    Result.SQL.Text := Format(SQLText,Args);
//
//    Result.Open;
//  except
//    on E: Exception do
//    begin
//      Result.Free;
//      Result := nil;
//      if Pos('连接失败',E.message)>0 then
//      begin
//        vbReconnection := True;
//      end;
//      if not bRaise then
//        Application.MessageBox(PChar('错误:'+E.message),'提示',MB_ICONINFORMATION)
//      else
//        raise Exception.Create(E.message);
//    end;
//  end;
//  vbThreadStopping := False;
end;

function TDM_DataBase.ExecQuery(SQLText: String;
  const Args: array of const; bRaise: Boolean;bHistory: Boolean): Boolean;
//var
//  ADO_Rec: TADOQuery;
begin
  if not bHistory then
    Result := ExecQuery(SQLText,Args,bRaise,Con_YDPrint)
  else
    Result := ExecQuery(SQLText,Args,bRaise,Con_History);


//  Result := False;
//  vbThreadStopping := True;
//  ADO_Rec := TADOQuery.Create(Self);
//  try
//    try
//      if not bHistory then
//        ADO_Rec.Connection := Con_YDPrint
//      else
//        ADO_Rec.Connection := Con_History;
//      ADO_Rec.SQL.Text := Format(SQLText,Args);
//
//      ADO_Rec.ExecSQL;
//      Result := True;
//    except
//      on E: Exception do
//      begin
//        if Pos('连接失败',E.message)>0 then
//        begin
//          vbReconnection := True;
//        end;
//        if not bRaise then
//          Application.MessageBox(PChar('错误:'+E.message),'提示',MB_ICONINFORMATION)
//        else
//          raise Exception.Create(E.message);
//      end;
//    end;    
//  finally
//    ADO_Rec.Free;
//  end;
//  vbThreadStopping := False;

end;

function TDM_DataBase.OpenQuery(SQLText: String;
  const Args: array of const; bRaise: Boolean;
  ADOCon: TADOConnection): TADOQuery;
begin
  Result := nil;
  try
    Result:= TADOQuery.Create(Self);
    Result.Connection := ADOCon;
    if Length(Args) > 0 then
      Result.SQL.Text := Format(SQLText,Args)
    else
      Result.SQL.Text := SQLText;
    Result.Open;
  except
    on E: Exception do
    begin
      Result.Free;
      Result := nil;
      if Pos('连接失败',E.message)>0 then
      begin
        vbReconnection := True;
      end;
      if not bRaise then
        Application.MessageBox(PChar('错误:'+E.message),'提示',MB_ICONINFORMATION)
      else
        raise Exception.Create(E.message);
    end;
  end;
end;

function TDM_DataBase.ExecQuery(SQLText: String;
  const Args: array of const; bRaise: Boolean;
  ADOCon: TADOConnection): Boolean;
var
  ADO_Rec: TADOQuery;
begin
  Result := False;
  ADO_Rec := TADOQuery.Create(Self);
  try
    try
      ADO_Rec.Connection := ADOCon;
      if Length(Args) > 0 then
        ADO_Rec.SQL.Text := Format(SQLText,Args)
      else
        ADO_Rec.SQL.Text := SQLText;
      ADO_Rec.ExecSQL;
      Result := True;
    except
      on E: Exception do
      begin
        if Pos('连接失败',E.message)>0 then
        begin
          vbReconnection := True;
        end;
        if not bRaise then
          Application.MessageBox(PChar('错误:'+E.message),'提示',MB_ICONINFORMATION)
        else
          raise Exception.Create(E.message);
      end;
    end;    
  finally
    ADO_Rec.Free;
  end;
end;

function TDM_DataBase.GetMaxID(TableName, Name: string; var Value: string;
  iType, iCount: Integer): Boolean;
var
  ADO_Rec: TADOQuery;
  SqlData: string;
begin
  Result:= False;
  try
    SqlData := 'declare @sID varchar(10) ';
    SqlData := SqlData +#13#10+ Format(' Exec P_GetMaxNum ''%s'',''%s'',@sID output,%d,%d ',[TableName,Name,iType,iCount]);
    SqlData := SqlData +#13#10+ ' select @sID ID';
//    ADO_Rec := TADOQuery.Create(Self);
//    ADO_Rec.Connection := Con_YDPrint;
//    ADO_Rec.Close;
//    ADO_Rec.SQL.Text := SqlData;
//    ADO_Rec.Open;
    ADO_Rec := OpenQuery(SqlData,[],True);
{    ADO_Rec.SQL.Text := 'declare @sID varchar(10) ';
    ADO_Rec.SQL.Append(Format('Exec P_GetMaxNum ''%s'',''%s'',@sID,%d,%d ',[TableName,Name,iType,iCount]));
    ADO_Rec.SQL.Append('select @sID ID');     }
    Value := ADO_Rec.FieldByName('ID').AsString;
    Result:= True;
  finally
    ADO_Rec.Free;
  end;
end;

function TDM_DataBase.GetMaxID(Sql: string): Integer;
var
  ADO_Rec: TADOQuery;
begin
  Result:= 0;
  try
    try
      ADO_Rec := OpenQuery(Sql,[],True);
      ADO_Rec.Open;
      if ADO_Rec.RecordCount > 0 then
        Result := ADO_Rec.Fields[0].AsInteger;
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar('错误:'+E.message),'提示',MB_ICONINFORMATION);
        Exit;
      end;
    end;
  finally
    ADO_Rec.Free;
  end;
end;

function TDM_DataBase.GetTableData(out ADO_Rec: TADOQuery; TableName,
  Data: string): Boolean;
begin
  Result:= False;
  //ADO_Rec.Free;
  //ADO_Rec := OpenQuery('select * from %s where  %s',[TableName,Data],True);
  ADO_Rec.Connection := Con_YDPrint;
  ADO_Rec.Close;
  ADO_Rec.SQL.Text := 'select * from ' + TableName + ' where  '+ Data;
  ADO_Rec.Open;
  Result:= True;
end;

function TDM_DataBase.GetTableFirst(Sql: string): Variant;
var
  ADO_Rec: TADOQuery;
begin
  Result:= '';
  try
    try
//      ADO_Rec := TADOQuery.Create(Self);
//      ADO_Rec.Connection := Con_YDPrint;
//      ADO_Rec.Close;
//      ADO_Rec.SQL.Text := Sql;
//      ADO_Rec.Open;
      ADO_Rec := OpenQuery(Sql,[],True);
      if ADO_Rec.RecordCount > 0 then
        Result := ADO_Rec.Fields[0].AsVariant;
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar('错误：'+E.message),'提示',MB_ICONINFORMATION);
        Exit;
      end;
    end;
  finally
    if Assigned(ADO_Rec) then ADO_Rec.Free;
  end;

end;

function TDM_DataBase.UpdateTable(Sql: string): Boolean;
begin
  Result:= False;
  try
    ExecQuery(Sql,[],True);
    Result:= True;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar('修改错误:'+E.message),'提示',MB_ICONINFORMATION)
    end;
  end;
end;

function TDM_DataBase.WriteSynLog(sSQL: string): Boolean;
var
  sSqlDate: string;
begin
  Result := False;
  sSqlDate := 'Insert into Sys_Synchronous_Log (F_sOperateSQL) values (''%s'')';
  ExecQuery(sSqlDate,[sSQL],False);
  Result := True;
end;

function TDM_DataBase.WriteSynLog(TableName: string; TableDateID,
  OperateType: Integer): Boolean;
var
  sSqlDate: string;
begin
  Result := False;
  sSqlDate := 'Insert into Sys_Synchronous_Log (F_sTableName,F_iTableDateID,F_iOperateType) values (''%s'',%d,%d)';
  ExecQuery(sSqlDate,[TableName,TableDateID,OperateType],False);
  Result := True;

end;

{ TReconnectionThread }

procedure TReconnectionThread.Execute;
begin
  inherited;
  while 1=1 do
  begin
    if vbReconnection then
    begin
      try
        DM_DataBase.Con_YDPrint.Connected := False;
        DM_DataBase.Con_YDPrint.Connected := True;
        if DM_DataBase.Con_YDPrint.Connected then
          vbReconnection := False;
      finally

      end;
    end;
    Sleep(5000);
  end;

end;

end.
