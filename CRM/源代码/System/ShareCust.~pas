unit ShareCust;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseDataFrom, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, dxBar, cxLookAndFeels, dxBarExtItems, ImgList,
  ActnList, XPMenu, Buttons, StdCtrls, ADODB, bainaADOQuery, cxContainer,
  DBCtrls,  cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox;

type
  TFrm_ShareCust = class(TBaseData_Frm)
    UserDBTableView1: TcxGridDBTableView;
    UserLevel1: TcxGridLevel;
    User: TcxGrid;
    ShareUserDBTableView1: TcxGridDBTableView;
    ShareUserLevel1: TcxGridLevel;
    ShareUser: TcxGrid;
    BtnSure: TBitBtn;
    BtnExit: TBitBtn;
    DSShareCust: TDataSource;
    LAdoUser: TbainaADOQuery;
    LDSUser: TDataSource;
    LAdoDept: TbainaADOQuery;
    LDSDept: TDataSource;
    UserDBTableView1Column1: TcxGridDBColumn;
    CBXDeptName: TcxLookupComboBox;
    Label1: TLabel;
    ShareUserDBTableView1Column1: TcxGridDBColumn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    LUserTemp: TbainaADOQuery;
    LDSUserTemp: TDataSource;
    Memo1: TMemo;
    Label2: TLabel;
    Query: TbainaADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxLookupComboBox1PropertiesChange(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BtnSureClick(Sender: TObject);
    procedure BtnExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_ShareCust: TFrm_ShareCust;

implementation

uses DataBase;

{$R *.dfm}

procedure TFrm_ShareCust.FormCreate(Sender: TObject);
begin
  inherited;
  LAdoDept.Close;
  LAdoDept.SQL.Clear;
  LAdoDept.SQL.Add('select DeptID_,DeptName_ From DepartMent_');
  LAdoDept.Prepared;
  LAdoDept.Open;
  LUserTemp.Close;
  LUserTemp.SQL.Clear;
  LUserTemp.SQL.Add('Select UserID,UserName From UserTemp');
  LUserTemp.Prepared;
  LUserTemp.Open;
end;

procedure TFrm_ShareCust.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action:=CaFree;
end;

procedure TFrm_ShareCust.cxLookupComboBox1PropertiesChange(
  Sender: TObject);
begin
  inherited;
  if (CBXDeptName.Text <> '') and (LAdoDept.Locate('DeptName_',CBXDeptName.Text,[])) Then
  begin
    LAdoUser.Close;
    lAdoUser.SQL.Clear;
    LAdoUser.SQL.Add('Select UserID_,DeptID_,UserName_ From Users_ Where DeptID_=:DeptID');
    LAdoUser.Parameters.ParamByName('DeptID').Value:=LAdoDept.FieldByName('DeptID_').Value;
    LAdoUser.Prepared;
    LAdoUser.Open;
  End;
end;

procedure TFrm_ShareCust.BitBtn3Click(Sender: TObject);
begin
  inherited;
  IF LAdoUser.IsEmpty Then Exit;
  IF LUserTemp.Locate('UserID',LAdoUser.FieldByName('UserID_').AsInteger,[loCaseInsensitive]) Then Exit;
  LUserTemp.Append;
  LUserTemp.FieldByName('UserID').AsInteger:=LAdoUser.FieldByName('UserID_').AsInteger;
  LUserTemp.FieldByName('UserName').AsString:=LAdoUser.FieldByName('UserName_').AsString;
  LUserTemp.Prepared;
  LUserTemp.Post;
end;

procedure TFrm_ShareCust.BitBtn4Click(Sender: TObject);
begin
  inherited;
  IF LUserTemp.IsEmpty Then Exit;
  LUserTemp.Delete;
end;

procedure TFrm_ShareCust.BtnSureClick(Sender: TObject);
Var
  I:Integer;
begin
  inherited;
  IF LUserTemp.IsEmpty Then Exit;
  LUserTemp.First;
  FOR I:=1 TO LUserTemp.RecordCount DO
    Begin
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('insert into ShareCust (CustID,ShareUserID,ShareUserName,BelongID,CreateBy_,CreateD_,Memo)');
      Query.SQL.Add(' Values (:CustID,:ShareUserID,:ShareUserName,:BelongID,:CreateBy_,:CreateD_,:Memo)');
      //showmessage(query.SQL.Text);
      Query.Parameters.ParamByName('CustID').Value:=DatabaseModule.AdoCust.FieldByName('CustID').Value;
      Query.Parameters.ParamByName('ShareUserID').Value:=LUserTemp.FieldByName('UserID').Value;
      Query.Parameters.ParamByName('ShareUserName').Value:=LUserTemp.FieldByName('UserName').Value;
      Query.Parameters.ParamByName('BelongID').Value:=DatabaseModule.dtclsData.UserID_;
      Query.Parameters.ParamByName('CreateBy_').Value:=DatabaseModule.dtclsData.UserName_;
      Query.Parameters.ParamByName('CreateD_').Value:=Date;
      Query.Parameters.ParamByName('Memo').Value:=Memo1.Text;
      Query.Prepared;
      Query.ExecSQL;
      LuserTemp.Next;
    End;
  Application.MessageBox('共享客户设置成功','系统提示',MB_OK+MB_Iconinformation);
  BtnExit.Click;  
end;

procedure TFrm_ShareCust.BtnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
