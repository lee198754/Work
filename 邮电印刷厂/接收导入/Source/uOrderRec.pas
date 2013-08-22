unit uOrderRec;

interface

uses
  Windows, Messages, ShLwApi, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, StdCtrls, iLabel, DB, ADODB, ComCtrls,
  RzButton, RzRadChk, ExtCtrls, RzPanel, msxmldom, XMLDoc, Menus, RzTray,
  PostService, RzDTP, DBGridEhGrouping, GridsEh, DBGridEh, ShellAPI,IdHTTP,
  ActnList;

const
  UserID = 'wsfj1';
  UserPwd ='000000';
  DatabaseUserName = 'yd';
  DatabaseUserPwd = '000000';
  WM_PicURL = WM_USER + 1000;
  c_PicUrl = 'http://211.156.193.135/FPKIMG/';  //ͼ�����ص�ַ
  const WM_NID = WM_User + 1000; //����һ������

type
  TDownLoadPic=class(TThread)
  protected
    procedure DownLoadPic;
  public
    vUrl: string;
  protected
        procedure   Execute;override;
  end;

  TMyDownLoad=class(TThread)
  private
//    procedure  LoadPic;        //��ȡ���ݺ�����ͼƬ
    procedure  DownCustomOrder;    //���ض����Ͷ���
    procedure  DownSellOrder;
    procedure DownLoadOrder;    //���������Ͷ���

    procedure WriteWorkLog(LogType,LogData: string);
  protected
        procedure   Execute;override;
  end;
  TFrm_OrderRec = class(TForm)
    XML_Rec: TXMLDocument;
    RzGroupBox1: TRzGroupBox;
    Chk_0: TRzRadioButton;
    Chk_1: TRzRadioButton;
    Btn_NewList: TRzButton;
    Box_msbz: TComboBox;
    ADOConnection1: TADOConnection;
    ADO_Write: TADOQuery;
    Label1: TLabel;
    Edit1: TEdit;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    tmr_CustomRec: TTimer;
    tmr_SellRec: TTimer;
    PopupMenu_Sys: TPopupMenu;
    N1: TMenuItem;
    GroupBox2: TGroupBox;
    btn_Rec: TButton;
    Label2: TLabel;
    lab_Time: TLabel;
    tmr_Time: TTimer;
    Label3: TLabel;
    lab_RecCount: TLabel;
    dtp_DateEnd: TRzDateTimePicker;
    dtp_DateBegin: TRzDateTimePicker;
    Label4: TLabel;
    tmr_qycx: TTimer;
    btn_qycx: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit2: TEdit;
    Button6: TButton;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    ADOTable1: TADOTable;
    Button5: TButton;
    tmr_EverydayStart: TTimer;
    tmr_lrfk: TTimer;
    Button7: TButton;
    tmr_ggcx: TTimer;
    btn_OpenLog: TButton;
    btn_ggcx: TButton;
    tmr_Error: TTimer;
    RzTrayIcon1: TRzTrayIcon;
    procedure Btn_NewListClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmr_CustomRecTimer(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure tmr_SellRecTimer(Sender: TObject);
    procedure btn_RecClick(Sender: TObject);
    procedure tmr_TimeTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Chk_0Click(Sender: TObject);
    procedure Chk_1Click(Sender: TObject);
    procedure tmr_qycxTimer(Sender: TObject);
    procedure btn_qycxClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure tmr_EverydayStartTimer(Sender: TObject);
    procedure tmr_lrfkTimer(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure btn_ggcxClick(Sender: TObject);
    procedure tmr_ggcxTimer(Sender: TObject);
    procedure btn_OpenLogClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tmr_ErrorTimer(Sender: TObject);
  private
    { Private declarations }
    vdSrartTime: TDateTime;  //�Զ�����Ŀ�ʼ����
    vbConnectionError: Boolean;
    vaConnectionErrorDate: array of TDate;
    pNotifyIcon: ^TNotifyIconData;
    procedure SysCommand(var SysMsg: TMessage);// message WM_SYSCOMMAND;
    procedure WMNID(var msg:TMessage);// message WM_NID;

    function f_GetConnectionErrorDate: Boolean;
    function f_ContinueRecDate: Boolean;
    function f_GetGGCXDate(_date: TDateTime): Boolean;
    function UpdateCustomData(sFileName: string;Rec_Date: TDateTime=0):Boolean;    //���ض����Ͷ���
    function UpdateSellData(sFileName: string;Rec_Date: TDateTime=0):Boolean;       //�����������Ͷ���
    function UpdateCartonLableData(sDetailsID: string;iType: integer;Rec_Date:TDateTime=0):Boolean;       //������ǩ����

    function UpdateChangeData(sFileName: string;OrderType: Integer):Boolean;    //���س������Ķ���
    function WriteChangeOrder(Node: IXMLNode;out Rec_ID: Integer; OrderType: integer): Boolean;  //¼�뵽��ChangeOrder
    function WriteChangeTSGY(Node: IXMLNode;Rec_ID: Integer; OrderType: integer): Boolean;  //¼�뵽��ChangeTSGY
    function ModifOrderData(Rec_ID: Integer):Boolean;    //�޸Ķ����Ͷ��� (���ø��ĳ����ӿ�)

    function ModifCustomData_old(sFileName: string;Rec_Date: TDateTime=0):Boolean;    //�������ض����Ͷ��� �޸�ԭ�ж���

    function OpenQuery(SQLText: String; const Args: array of const): TADOQuery;   //��ȡ�������ݼ�
    function ExecQuery(SQLText: String; const Args: array of const): Boolean;   //��ȡ�������ݼ�
    function GetFieldName(out NameList: TStringList;TableName: string): Boolean;   //��ȡ���ֶ���
    function FindFieldName(NameList: TStringList; Name: string): string;           //���Ҷ�Ӧ������
    function GetTableData(out ADO_Rec: TADOQuery;TableName: string;Data: string='1=2'): Boolean;   //��ȡ�������ݼ�
    function GetMaxID(Sql: string): Integer;        //ȡ���ֵ
    function GetTableFirst(Sql: string): Variant;        //ȡ��һ���ֵ
    function UpdateTable(Sql: string): Boolean;        //���±�

    function WriteCustomOrder(Node: IXMLNode;var Rec_ID: Integer; Rec_Date: TDateTime=0): Boolean;      //¼�뵽��BI_CustomOrder
    function WriteCustomOrderDetails(Node: IXMLNode;var Rec_ID: Integer): Boolean;  //¼�뵽��BI_CustomOrderDetails    sDetailsIDΪ��������,���������޸�
    function WriteCustomOrderImg(Node: IXMLNode;var Rec_ID: Integer): Boolean;    //¼�뵽��BI_CustomOrderImg
    function WriteCustomOrderTsgy(Node: IXMLNode;var Rec_ID: Integer): Boolean;    //¼�뵽��BI_CustomOrderTsgy
    function WriteCartonLable(Node: IXMLNode;out Rec_ID: Integer): Boolean;    //¼�뵽��BI_CartonLable
    function WritePackageLable(Node: IXMLNode;Rec_ID: Integer): Boolean;    //¼�뵽��BI_PackageLable

    function ModifCustomOrderDetails(Node: IXMLNode;var Rec_ID: Integer;sDetailsID: string): Boolean;  //�޸ı�BI_CustomOrderDetails    sDetailsIDΪ��������,���������޸�)

    function WriteSellOrder(Node: IXMLNode;var Rec_ID: Integer; Rec_Date:TDateTime=0): Boolean;         //¼�뵽��BI_SellOrder
    function WriteSellOrderDetails(Node: IXMLNode;var Rec_ID: Integer): Boolean;  //¼�뵽��BI_SellOrderDetails

    function WriteOrderApart(Node: IXMLNode;iDetailsID: Integer; Bz: Integer): Boolean;    //��ֶ���
    function ModifOrderApart(Node: IXMLNode;iDetailsID: Integer; Bz: Integer): Boolean;    //�޸Ĳ�ֶ���(�ݲ���)

    function UpdateData: Boolean;             //ʹ���߳�,���õ�ȫ�ֱ���,��ʱ�����⹦��

    function IsPosCpbh(Node: IXMLNode;SubStr: string): Boolean;    //��Ʒ����Ƿ���� SubStr;

    procedure AppException(Sender: TObject; E: Exception);
    procedure AppMinimize( Sender: TObject );

    procedure  DownLoadPic(sUrl: string);    //����ͼ��
//    function CustomThread(p: Pointer): Integer; stdcall;
//    function SellThread(p: Pointer): Integer; stdcall;
    procedure DelFileList(_Path: string;_Size: Int64);   //������С������˳��ɾ���ļ�
  public
    procedure WriteWorkLog(LogType,LogData: string);       //��־



    { Public declarations }
  end;

var
  Frm_OrderRec: TFrm_OrderRec;
  hTCustom,hTSell: THandle;
  vUrl: string;
  vTime,vSJRQ: TDateTime;
  vRecCount: Integer=0;
  vIsFileDel: Integer=0;               //�Ƿ����ص�XML�����ɾ��(0:��,1:��)
  vIsContinue: Integer=0;              //����������Ƿ����¼��δ���ն���������(0:��,1:��)
  vIsDownLoadPic: Integer=0;           //�Ƿ��Զ�����ͼ��(0:��,1:��)
  vPicPath: string;                    //�Զ�����ͼ��·��

implementation

uses
  PubStr, IniFiles, DateUtils, uFrm_PicPathDlg, Jpeg, Registry;



{$R *.dfm}
const
  TitleName = '�������� v1.6 ';
  c_Reg_Program = 'SOFTWARE\YDPrint\OrderRec\';

function CustomThread(p: Pointer): Integer;
var
  obj: PostServicePortType;
  data: ArrayOfArrayOfString;
  s: String;
  ms: TMemoryStream;
  sType: string;
  i: integer;
  XML_Rec: TXMLDocument;
  sFileName: string;
begin
  while 1=1 do
  begin
    obj := GetPostServicePortType(true, vUrl, nil);
    if obj = nil then exit;
    try
      data := obj.getOrderID(UserID, userpwd, 0, 0, '');
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar(E.Message),'����',MB_ICONERROR);
        Exit;
      end;
    end;
    if High(Data) > -1 then
    begin
      for i := 0 to High(Data) do
      begin
        case StrToInt(Data[i][2]) of
          0: sType := '������';
          1: sType := '������';
          3: sType := '�ط���';
        else
          sType:= '';
        end;
        frm_OrderRec.WriteWorkLog('��¼','��δ����'+sType+'�ƻ���');
        frm_OrderRec.WriteWorkLog('��¼','�ƻ���ID��'+Data[i][0]);
        frm_OrderRec.WriteWorkLog('��¼','�ƻ������ţ�'+Data[i][1]);
        if Data[i][2] = '0' then
          s := obj.getOrderD(UserID, UserPwd, Data[i][0], 1)
        else if Data[i][2] = '1' then
        begin
          s := obj.getOrderX(UserID, UserPwd, Data[i][0], 1);
        end;
        if s <> '' then
        begin
          if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\') then
            CreateDir(ExtractFilePath(Application.ExeName)+'�ƻ�������\');
          try
            ms := TMemoryStream.Create;
            ms.WriteBuffer(Pointer(s)^, Length(s));
            XML_Rec := TXMLDocument.Create(frm_OrderRec);
            XML_Rec.XML.Clear;
            XML_Rec.LoadFromStream(ms);
            if Data[i][2] = '0' then
            begin
              if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\') then
                CreateDir(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\');
              sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\������\' + Data[i][0] +'.xml';
              XML_Rec.SaveToFile(sFileName);
              frm_OrderRec.UpdateCustomData(sFileName);
            end else
            if Data[i][2] = '1' then
            begin
              if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\') then
                CreateDir(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\');
              sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\������\' + Data[i][0] +'.xml';
              XML_Rec.SaveToFile(sFileName);
              frm_OrderRec.UpdateSellData(sFileName);
            end;
          finally
            ms.Free;
          end;
        end;
      end;

    end;

    obj := nil;
    Sleep(10000);
  end;
end;

function SellThread(p: Pointer): Integer;
var
  obj: PostServicePortType;
  data: ArrayOfArrayOfString;
  s: String;
  ms: TMemoryStream;
  sType: string;
  i: integer;
begin
  while 1=1 do
  begin
    try
      obj := GetPostServicePortType(true, vUrl, nil);
      if obj = nil then exit;
      data := obj.getOrderID(UserID, userpwd, 1, 0, '');
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar(E.Message),'����',MB_ICONERROR);
        Exit;
      end;
    end;
    if High(Data) > -1 then
    begin
      for i := 0 to High(Data) do
      begin
        case StrToInt(Data[i][2]) of
          0: sType := '������';
          1: sType := '������';
          3: sType := '�ط���';
        else
          sType:= '';
        end;
        frm_OrderRec.WriteWorkLog('��¼','��δ����'+sType+'�ƻ���');
        frm_OrderRec.WriteWorkLog('��¼','�ƻ���ID��'+Data[i][0]);
        frm_OrderRec.WriteWorkLog('��¼','�ƻ������ţ�'+Data[i][1]);
        if Data[i][2] = '0' then
          s := obj.getOrderD(UserID, UserPwd, Data[i][0], 1)
        else if Data[i][2] = '1' then
        begin
          s := obj.getOrderX(UserID, UserPwd, Data[i][0], 1);
        end;
        if s <> '' then
        begin
          if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\') then
            CreateDir(ExtractFilePath(Application.ExeName)+'�ƻ�������\');
          try
            ms := TMemoryStream.Create;
            ms.WriteBuffer(Pointer(s)^, Length(s));
            frm_OrderRec.XML_Rec.XML.Clear;
            frm_OrderRec.XML_Rec.LoadFromStream(ms);
            if Data[i][2] = '0' then
            begin
              if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\') then
                CreateDir(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\');
              frm_OrderRec.XML_Rec.SaveToFile(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\' + Data[i][0] +'.xml');
              frm_OrderRec.UpdateCustomData('');
            end else
            if Data[i][2] = '1' then
            begin
              if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\') then
                CreateDir(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\');
              frm_OrderRec.XML_Rec.SaveToFile(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\' + Data[i][0] +'.xml');
              frm_OrderRec.UpdateSellData('');
            end;
          finally
            ms.Free;
          end;
        end;
      end;

    end;

    obj := nil;
    Sleep(10000);
  end;
end;



procedure TFrm_OrderRec.Btn_NewListClick(Sender: TObject);
label
  lab_loop;
var
  obj: PostServicePortType;
  data: ArrayOfArrayOfString;
  SDate: string;
  s: String;
  ms: TMemoryStream;
  sType, i, j, k: integer;
  NodeList, ChildNodeList:IXMLNodeList;
  Node, ChildNode:IXMLNode;
  iDayCount: Integer;
  dDate,Rec_Date: TDateTime;
  XML_Rec: TXMLDocument;
  sFileName: string;
  bRec: Boolean;
  iYH,iZYH: Integer;
begin
  try
    obj := nil;
    obj := GetPostServicePortType(true, Edit1.Text, nil);
    if obj = nil then exit;

    Memo1.Clear;
    sType := Box_msbz.ItemIndex;
  //  sType := -1;
    iDayCount := DaysBetween(dtp_DateBegin.DateTime,dtp_DateEnd.DateTime);
    dDate := dtp_DateBegin.DateTime;
    iDayCount := iif(Chk_0.Checked, 0, iDayCount);
    for k := 0 to iDayCount do
    begin
      sDate := FormatDateTime('yyyy-MM-dd',dDate);
      WriteWorkLog('�ֶ�����','��ʼ���� '+sDate+' �ƻ���');
      Rec_Date := now;
      if not Chk_0.Checked then
        Rec_Date := DateOf(dDate);
  //  sDate := FormatDateTime('yyyy-MM-dd',dtp_Date.DateTime);
      try
        data := obj.getOrderID(UserID, UserPwd, sType,
          iif(Chk_0.Checked, 0, 1), iif(Chk_0.Checked, '', sDate));
      except
        on E:Exception do
        begin
          WriteWorkLog('���ʳ���',E.Message);
          Exit;
        end;
      end;
      Caption := TitleName+IntToStr(High(Data));
      if High(Data) > -1 then
      begin
        for i := 0 to High(Data) do
        begin
          Memo1.Lines.Add(Data[i][0]);
          Memo1.Lines.Add(Data[i][1]);
          Memo1.Lines.Add(Data[i][2]);
          iYH := 1;
lab_loop:
          if (Data[i][2] = '0') or (Data[i][2] = '3')  then
            s := obj.getOrderD(UserID, UserPwd, Data[i][0], iYH)
          //else if sType = 1 then
          else if Data[i][2] = '1' then
          begin
            s := obj.getOrderX(UserID, UserPwd, Data[i][0], iYH);
          end;
          if s <> '' then
          begin
            if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\') then
              ForceDirectories(PChar(ExtractFilePath(Application.ExeName)+'�ƻ�������\'));
            try
              ms := TMemoryStream.Create;
              ms.WriteBuffer(Pointer(s)^, Length(s));
              XML_Rec := TXMLDocument.Create(Self);
              XML_Rec.XML.Clear;
              XML_Rec.LoadFromStream(ms);
      //        node := XML_Rec.DocumentElement;
      //        ShowMessage(node.NodeName);
      //        Node := XML_Rec.DocumentElement.ChildNodes[0];
  //            if not IsPosCpbh(Node,'-13-') then Continue;      //�����Ϊ�ؿ�,��¼��
              Memo1.Lines.Add(s);
              if Data[i][2] = '0' then
              begin
                if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\') then
                  ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\');
                sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\' + Data[i][0] +'_'+IntToStr(iYH)+'.xml';
                XML_Rec.SaveToFile(sFileName);
                if UpdateCustomData(sFileName,Rec_Date) then
                begin
                  WriteWorkLog('�ֶ�����','���� '+sDate+' ������ '+String(Data[i][0])+'_'+IntToStr(iYH)+' �ɹ�!');
  //                Application.MessageBox(pchar('����'+String(Data[i][0])+'�ɹ�!'),'��ʾ',MB_ICONINFORMATION);
                end;
              end else
              if Data[i][2] = '1' then
              begin
                if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\') then
                  ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\');
                sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\' + Data[i][0] +'_'+IntToStr(iYH)+'.xml';
                XML_Rec.SaveToFile(sFileName);
                if UpdateSellData(sFileName,Rec_Date) then
                begin
                  WriteWorkLog('�ֶ�����','���� '+sDate+' ������ '+String(Data[i][0])+'_'+IntToStr(iYH)+' �ɹ�!');
  //                Application.MessageBox(pchar('����'+String(Data[i][0])+'�ɹ�!'),'��ʾ',MB_ICONINFORMATION);
                end;
              end else
              if Data[i][2] = '3' then
              begin
                if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\'+sDate+'') then
                  ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\'+sDate+'');
                sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\'+sDate+'\' + Data[i][0] +'_'+IntToStr(iYH)+'.xml';
                XML_Rec.SaveToFile(sFileName);
                if sType = 0 then
                  bRec := UpdateCustomData(sFileName,Rec_Date)
                else
                if sType = 1 then
                  bRec := UpdateSellData(sFileName,Rec_Date);
                if bRec then
                begin
                  WriteWorkLog('�ֶ�����','���� '+sDate+' �ط��� '+String(Data[i][0])+'_'+IntToStr(iYH)+' �ɹ�!');
  //                Application.MessageBox(pchar('����'+String(Data[i][0])+'�ɹ�!'),'��ʾ',MB_ICONINFORMATION);
                end;
              end;
              nodeList := XML_Rec.DocumentElement.ChildNodes[0].ChildNodes;
              node := nodeList.FindNode('zyh');
              iZYH  := StrToNum(Node.NodeValue);
            finally
              ms.Free;
              XML_Rec.Free;
            end;
            if iYH < iZYH then
            begin
              inc(iYH);
              goto lab_loop;
            end;
          end;

        end;

      end;
      dDate := IncDay(dDate);
    end;
    Application.MessageBox(pchar('�������!'),'��ʾ',MB_ICONINFORMATION);
  finally
    obj := nil;
  end;

end;

function TFrm_OrderRec.GetFieldName(out NameList: TStringList;TableName: string): Boolean;
var
  i: Integer;
  ADO_Rec: TADOQuery;
begin
  Result := False;
  try
    ADO_Rec := TADOQuery.Create(Self);
    if not GetTableData(ADO_Rec,TableName,'1=2') then Exit;
    with ADO_Rec do
    begin
      for i := 0 to FieldCount - 1 do
        NameList.Add(Fields[i].FieldName);
    end;
    if NameList.Count >0 then
      Result := True;
  finally
    ADO_Rec.Free;
  end;
end;

function TFrm_OrderRec.UpdateCustomData(sFileName: string;Rec_Date: TDateTime):Boolean;
var
  i,j,iID,iCusdomID,iDetailsID,iImgID,iTsgyID,iDfbbz: integer;
  NodeList,ChildNodeList: IXMLNodeList;
  Node,ChildNode: IXMLNode;
  ADO_Rec,ADO_Exist: TADOQuery;
  bLost: Boolean;
  sDetailsID,sOrderDetailsID: string;
  XML_Rec: TXMLDocument;
begin
  Result := False;
  bLost := False;
  XML_Rec := TXMLDocument.Create(Self);
  if sFileName <> '' then
    XML_Rec.LoadFromFile(sFileName);
  nodeList := XML_Rec.DocumentElement.ChildNodes[0].ChildNodes;
  node := nodeList.FindNode('id');
  iDfbbz := nodeList.FindNode('dfbbz').NodeValue;
  try
    ADO_Rec := TADOQuery.Create(self);
    GetTableData(ADO_Rec,'BI_CustomOrder','F_iID='+node.NodeValue);
    iID := node.NodeValue;
    node := XML_Rec.DocumentElement.ChildNodes[0];
    if ADO_Rec.RecordCount > 0 then
    begin
      WriteWorkLog('�����Ѵ���','�����ͼƻ������ţ�'+IntToStr(iID)+' ���ݴ���');
      //Exit;
    end else
    if not WriteCustomOrder(node,iID,Rec_Date) then
      Exit;
//    if not GetTableData(ADO_Write,'BI_CustomOrder','1=2') then Exit;
//    ADO_Write.Insert;
    iCusdomID := iID;
    nodeList := node.ChildNodes;
    for i := 0 to nodeList.Count -1 do
    begin
      iID := iCusdomID;
      node := nodeList[i];
      if (node.NodeName = 'item') and (node.HasChildNodes) then
      begin
        sDetailsID :=node.ChildNodes.FindNode('id').NodeValue;
        ADO_Exist := TADOQuery.Create(self);
        GetTableData(ADO_Exist,'BI_CustomOrderDetails','F_iDetailsID='+sDetailsID);
        if ADO_Exist.RecordCount >0 then
        begin
          WriteWorkLog('�����Ѵ���','�����ͼƻ��� '+IntToStr(iCusdomID)+' �ж��� �걨ID:'+sDetailsID+' �Ѵ���!');
          sOrderDetailsID := ADO_Exist.FieldByName('F_iID').AsString;
          GetTableData(ADO_Exist,'BI_CustomOrderImg','F_iCustomDetailsID='+sOrderDetailsID);
          if ADO_Exist.RecordCount > 0 then
          begin
            WriteWorkLog('�����Ѵ���','�걨ID:'+sDetailsID+' ͼ���Ѵ���!');
          end else
          begin
            if node.ChildNodes['img'].HasChildNodes then
            begin
              ChildNodeList := node.ChildNodes['img'].ChildNodes;
              for j := 0 to ChildNodeList.Count -1 do
              begin
                iID := StrToNum(sOrderDetailsID);
                ChildNode := ChildNodeList[j];
                WriteCustomOrderImg(ChildNode,iID);
              end;
            end;
          end;
          GetTableData(ADO_Exist,'BI_CustomOrderTSGY','F_iCustomDetailsID='+sOrderDetailsID);
          if ADO_Exist.RecordCount > 0 then
          begin
            WriteWorkLog('�����Ѵ���','�걨ID:'+sDetailsID+' ���⹤���Ѵ���!');
          end else
          begin
            if node.ChildNodes['tsgy'].HasChildNodes then
            begin
              ChildNodeList := node.ChildNodes['tsgy'].ChildNodes;
              for j := 0 to ChildNodeList.Count -1 do
              begin
                iID := StrToNum(sOrderDetailsID);;
                ChildNode := ChildNodeList[j];
                WriteCustomOrderTsgy(ChildNode,iID);
              end;
            end;
          end;
          GetTableData(ADO_Exist,'BI_CartonLable','F_iSBID='+sDetailsID);
          if ADO_Exist.RecordCount >0 then
          begin
            WriteWorkLog('�����Ѵ���','�걨ID:'+sDetailsID+' ��ǩ�Ѵ���!');
          end else
            UpdateCartonLableData(sDetailsID,iif(iDfbbz=0,0,2),Rec_Date);
          ADO_Exist.Free;

          Continue;
        end else
        begin
          ADO_Exist.Free;
          if WriteCustomOrderDetails(node,iID) then
          begin
            iDetailsID := iID;
            WriteOrderApart(node,iDetailsID,0);
            if node.ChildNodes['img'].HasChildNodes then
            begin
              ChildNodeList := node.ChildNodes['img'].ChildNodes;
              for j := 0 to ChildNodeList.Count -1 do
              begin
                iID := iDetailsID;
                ChildNode := ChildNodeList[j];
                WriteCustomOrderImg(ChildNode,iID);
              end;
            end;
            if node.ChildNodes['tsgy'].HasChildNodes then
            begin
              ChildNodeList := node.ChildNodes['tsgy'].ChildNodes;
              for j := 0 to ChildNodeList.Count -1 do
              begin
                iID := iDetailsID;
                ChildNode := ChildNodeList[j];
                WriteCustomOrderTsgy(ChildNode,iID);
              end;
            end;
            //WriteWorkLog('�ɹ�','�����ͼƻ��� '+IntToStr(iCusdomID)+' �ж��� �걨ID:'+sDetailsID+' ����ɹ�!');
            UpdateCartonLableData(sDetailsID,iif(iDfbbz=0,0,2),Rec_Date);
          end else
          begin
            bLost := True;
            sDetailsID := '';
            sDetailsID :=node.ChildNodes.FindNode('id').NodeValue;
            WriteWorkLog('ʧ��','�����ͼƻ��� '+IntToStr(iCusdomID)+' �ж��� �걨ID:'+sDetailsID+' ����ʧ��!');
          end;
        end;
        Result := True;
      end;
    end;
    if bLost then
      Result := false;
    if (vIsFileDel = 1) and (not bLost)   then
      DeleteFile(sFileName);

  finally
    ADO_Rec.Free;
    XML_Rec.Free;
  end;

end;


procedure TFrm_OrderRec.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    if UpdateCustomData(OpenDialog1.FileName) then
    begin
      Application.MessageBox(pchar('����'+ExtractFileName(OpenDialog1.FileName)+'�ɹ�!'),'��ʾ',MB_ICONINFORMATION);
      WriteWorkLog('�ֶ�����','����'+ExtractFileName(OpenDialog1.FileName)+'�ɹ�!');
      if vIsFileDel = 1 then
        DeleteFile(OpenDialog1.FileName);
    end;
end;

function TFrm_OrderRec.FindFieldName(NameList: TStringList;Name: string): string;
var
  i: integer;
  str: string;
begin
  Result := '';
  for i := 0 to NameList.Count -1 do
  begin
    str := NameList.Strings[i];
    if Pos('F_ti',str) >0 then
      str := Copy(str,5,Length(str))
    else
      str := Copy(str,4,Length(str));
    if LowerCase(Name) = LowerCase(str) then
    begin
      Result := NameList.Strings[i];
      Break;
    end;
  end;
end;




function TFrm_OrderRec.WriteCustomOrder(Node: IXMLNode;var Rec_ID: Integer;Rec_Date:TDateTime): Boolean;
var
  nodeList: IXMLNodeList;
  strName,strValue, FieldName: string;
  NameList: TStringList;
  i: Integer;
  ADO_Rec: TADOQuery;
begin
  Result := False;
  if not node.HasChildNodes then Exit;
  NameList := TStringList.Create;
  if not GetFieldName(NameList,'BI_CustomOrder') then
  begin
    NameList.Free;
    Exit;
  end;
  ADO_Rec := TADOQuery.Create(Self);
  nodeList := node.ChildNodes;
  try
    try
      GetTableData(ADO_Rec,'BI_CustomOrder','1=2');
      ADO_Rec.Insert;
      for i := 0 to nodeList.Count -1 do
      begin
        if nodeList[i].IsTextElement then
        begin
          strName := nodeList[i].NodeName;
          strValue := nodeList[i].NodeValue;
          FieldName := FindFieldName(NameList,strName);
          if UpperCase(strName) = UpperCase('id') then
            Rec_ID := StrToInt(strValue);
          if FieldName <> '' then
            ADO_Rec.FieldByName(FieldName).AsString := Trim(strValue) ;
        end;
      end;
      if Rec_Date =0 then
        ADO_Rec.FieldByName('F_dJsrq').AsDateTime := Now
      else
        ADO_Rec.FieldByName('F_dJsrq').AsDateTime := Rec_Date;
      ADO_Rec.Post;
      Result := True;
    except
      on E: Exception do
      begin
//        Application.MessageBox(PChar(E.Message),'����',MB_ICONERROR);
        WriteWorkLog('���ݴ���','BI_CustomOrder������У�'+E.Message);
      end;
    end;
  finally
    NameList.Free;
    ADO_Rec.Free;
  end;
end;

function TFrm_OrderRec.GetMaxID(Sql: string): Integer;
var
  ADO_Rec: TADOQuery;
begin
  Result:= 0;
  try
    try
      ADO_Rec := TADOQuery.Create(Self);
      ADO_Rec.Connection := ADOConnection1;
      ADO_Rec.Close;
      ADO_Rec.SQL.Text := Sql;
      ADO_Rec.Open;
      if ADO_Rec.RecordCount > 0 then
        Result := ADO_Rec.Fields[0].AsInteger;
    except
      on E: Exception do
      begin
//        Application.MessageBox(PChar('����:'+E.message),'��ʾ',MB_ICONINFORMATION);
        WriteWorkLog('���ݴ���','���ѯ'+Sql+'��'+E.Message);
        Exit;
      end;

    end;
  finally
    ADO_Rec.Free;
  end;
end;

function TFrm_OrderRec.GetTableData(out ADO_Rec: TADOQuery; TableName,
  Data: string): Boolean;
begin
  Result:= False;
  try
    ADO_Rec.Connection := ADOConnection1;
    ADO_Rec.Close;
    ADO_Rec.SQL.Text := 'select * from ' + TableName + ' where  '+ Data;
    ADO_Rec.Open;
    Result:= True;
  except
    on E: Exception do
    begin
//      Application.MessageBox(PChar(E.Message),'����',MB_ICONERROR);
      WriteWorkLog('���ݴ���',TableName+'���ѯ��'+E.Message);

    end;
  end;
end;

function TFrm_OrderRec.WriteCustomOrderDetails(Node: IXMLNode;var Rec_ID: Integer): Boolean;
var
  nodeList: IXMLNodeList;
  strName,strValue, FieldName,sSqlData: string;
  NameList: TStringList;
  i: Integer;
  ADO_Rec: TADOQuery;
begin
  Result := False;
  if not node.HasChildNodes then Exit;
  NameList := TStringList.Create;
  if not GetFieldName(NameList,'BI_CustomOrderDetails') then
  begin
    NameList.Free;
    Exit;
  end;
  ADO_Rec := TADOQuery.Create(Self);
  nodeList := node.ChildNodes;
  try
    sSqlData := 'Select * from BI_CustomOrderDetails where 1=2';
    //GetTableData(ADO_Rec,'BI_CustomOrderDetails','1=2');
    ADO_Rec := OpenQuery(sSqlData,[]);
    ADO_Rec.Insert;
    FieldName := FindFieldName(NameList,'CustomID');
    if FieldName <> ''  then
        ADO_Rec.FieldByName(FieldName).AsInteger := Rec_ID ;
    FieldName := FindFieldName(NameList,'ID');
    if FieldName <> '' then
    begin
      Rec_ID := GetMaxID('select IsNull(Max(F_iID),0) from BI_CustomOrderDetails')+1 ;
      ADO_Rec.FieldByName(FieldName).AsInteger := Rec_ID;
    end;
    for i := 0 to nodeList.Count -1 do
    begin
      if nodeList[i].IsTextElement then
      begin
        strName := nodeList[i].NodeName;
        strValue := nodeList[i].NodeValue;
        if strName = 'fqttsgyf' then        //���ϵ��õ�
           strName:='fqttsgyf';
        if UpperCase(strName) = UpperCase('ID') then
        begin
          strName := 'DetailsID';
        end;
        if UpperCase(strName) = UpperCase('cpbh') then
          if Pos('-13-',strValue) >0 then              //����Ǻؿ�,�ĳɺؿ����
          begin
            ADO_Rec.FieldByName('F_iProductType').AsInteger := 13;
//            Result := False;
//            Exit;
          end;
        FieldName := FindFieldName(NameList,strName);
      end;
      if FieldName <> '' then
        ADO_Rec.FieldByName(FieldName).AsString := Trim(strValue) ;
    end;
    ADO_Rec.Post;
    Result := True;
  finally
    NameList.Free;
    ADO_Rec.Free;
  end;
end;

function TFrm_OrderRec.WriteCustomOrderImg(Node: IXMLNode;
  var Rec_ID: Integer): Boolean;
var
  nodeList: IXMLNodeList;
  strName,strValue, FieldName,sUrl: string;
  NameList: TStringList;
  i: Integer;
  ADO_Rec: TADOQuery;
begin
  Result := False;
  if not node.HasChildNodes then Exit;
  NameList := TStringList.Create;
  if not GetFieldName(NameList,'BI_CustomOrderImg') then
  begin
    NameList.Free;
    Exit;
  end;
  ADO_Rec := TADOQuery.Create(Self);
  nodeList := node.ChildNodes;
  try
    GetTableData(ADO_Rec,'BI_CustomOrderImg','1=2');
    ADO_Rec.Insert;
    FieldName := FindFieldName(NameList,'CustomDetailsID');
    if FieldName <> '' then
      ADO_Rec.FieldByName(FieldName).AsInteger := Rec_ID;
    FieldName := FindFieldName(NameList,'ID');
    if FieldName <> '' then
    begin
      Rec_ID := GetMaxID('select IsNull(Max(F_iID),0) from BI_CustomOrderImg')+1 ;
      ADO_Rec.FieldByName(FieldName).AsInteger := Rec_ID ;
    end;
    for i := 0 to nodeList.Count -1 do
    begin
      if nodeList[i].IsTextElement then
      begin
        strName := nodeList[i].NodeName;
        strValue := nodeList[i].NodeValue;
        FieldName := FindFieldName(NameList,strName);
        if strName = 'path' then
        begin
          sUrl := strValue;
          if sUrl <> '' then
            DownLoadPic(sUrl);
        end;
      end;
      if FieldName <> '' then
        ADO_Rec.FieldByName(FieldName).AsString := Trim(strValue) ;
    end;
    ADO_Rec.Post;
    Result := True;
  finally
    NameList.Free;
    ADO_Rec.Free;
  end;
end;

function TFrm_OrderRec.UpdateSellData(sFileName: string;Rec_Date: TDateTime):Boolean;
var
  i,iID,iSellID: integer;
  nodeList: IXMLNodeList;
  node: IXMLNode;
  ADO_Rec,ADO_Exist: TADOQuery;
  bLost: Boolean;
  sDetailsID: string;
  XML_Rec: TXMLDocument;
begin
  Result := False;
  bLost := False;
  XML_Rec := TXMLDocument.Create(Self);
  if sFileName <> '' then
    XML_Rec.LoadFromFile(sFileName);
  nodeList := XML_Rec.DocumentElement.ChildNodes[0].ChildNodes;
  node := nodeList.FindNode('id');
  try
    ADO_Rec := TADOQuery.Create(self);
    GetTableData(ADO_Rec,'BI_SellOrder','F_iID='+node.NodeValue);
    iID := node.NodeValue;
    node := XML_Rec.DocumentElement.ChildNodes[0];
    if ADO_Rec.RecordCount > 0 then
    begin
      WriteWorkLog('�����Ѵ���','�����ͼƻ������ţ�'+IntToStr(iID)+' ���ݴ���');
      //Exit;
    end else
    if not WriteSellOrder(node,iID,Rec_Date) then
      Exit;

//    if not GetTableData(ADO_Write,'BI_SellOrder','1=2') then Exit;
//    ADO_Write.Insert;
    iSellID := iID;
    nodeList := node.ChildNodes;
    for i := 0 to nodeList.Count -1 do
    begin
      iID := iSellID;
      node := nodeList[i];
      if (node.NodeName = 'item') and (node.HasChildNodes) then
      begin
        sDetailsID :=node.ChildNodes.FindNode('id').NodeValue;
        ADO_Exist := TADOQuery.Create(self);
        GetTableData(ADO_Exist,'BI_SellOrderDetails','F_iDetailsID='+sDetailsID);
        if ADO_Exist.RecordCount >0 then
        begin
          WriteWorkLog('�����Ѵ���','�����ͼƻ��� '+IntToStr(iSellID)+' �ж��� �걨ID:'+sDetailsID+' �Ѵ���!');
          if ADO_Exist.RecordCount >0 then
          begin
            WriteWorkLog('�����Ѵ���','�걨ID:'+sDetailsID+' ��ǩ�Ѵ���!');
          end else
            UpdateCartonLableData(sDetailsID,1,Rec_Date);
          ADO_Exist.Free;
          Continue;
        end else
        if WriteSellOrderDetails(node,iID) then
        begin
          WriteOrderApart(node,iID,1);
          //WriteWorkLog('�ɹ�','�����ͼƻ��� '+IntToStr(iSellID)+' �ж��� �걨ID:'+sDetailsID+' ����ɹ�!');
          UpdateCartonLableData(sDetailsID,1,Rec_Date);
         { GetTableData(ADO_Rec,'BI_SellOrder','F_iID='+IntToStr(iSellID));
          if ADO_Rec.RecordCount > 0 then
          begin
            ADO_Rec.First;
            while not ADO_Rec.Eof do
              ADO_Rec.Delete;
          end;   }
        end else
        begin
          bLost := True;
          sDetailsID := '';
          sDetailsID :=node.ChildNodes.FindNode('id').NodeValue;
          WriteWorkLog('ʧ��','�����ͼƻ��� '+IntToStr(iSellID)+' �ж��� �걨ID:'+sDetailsID+' ����ʧ��!');
        end;
        Result := True;
      end;
    end;
//      ShowMessage('�ɹ�');
    if bLost then
      Result := False;
    if (vIsFileDel = 1) and (not bLost)  then
      DeleteFile(sFileName);

  finally
    ADO_Rec.Free;
    XML_Rec.Free;
  end;
end;

function TFrm_OrderRec.WriteSellOrder(Node: IXMLNode; var Rec_ID: Integer;Rec_Date:TDateTime): Boolean;
var
  nodeList: IXMLNodeList;
  strName,strValue, FieldName: string;
  NameList: TStringList;
  i: Integer;
  ADO_Rec: TADOQuery;
begin
  Result := False;
  if not node.HasChildNodes then Exit;
  NameList := TStringList.Create;
  if not GetFieldName(NameList,'BI_SellOrder') then
  begin
    NameList.Free;
    Exit;
  end;
  ADO_Rec := TADOQuery.Create(Self);
  nodeList := node.ChildNodes;
  try
    try
      GetTableData(ADO_Rec,'BI_SellOrder','1=2');
      ADO_Rec.Insert;;
      for i := 0 to nodeList.Count -1 do
      begin
        if nodeList[i].IsTextElement then
        begin
          strName := nodeList[i].NodeName;
          strValue := nodeList[i].NodeValue;
          FieldName := FindFieldName(NameList,strName);
          if UpperCase(strName) = UpperCase('id') then
            Rec_ID := StrToInt(strValue);
          if FieldName <> '' then
            ADO_Rec.FieldByName(FieldName).AsString := Trim(strValue) ;
        end;
      end;
      if Rec_Date =0 then
        ADO_Rec.FieldByName('F_dJsrq').AsDateTime := Now
      else
        ADO_Rec.FieldByName('F_dJsrq').AsDateTime := Rec_Date;
      ADO_Rec.Post;
      Result := True;
    except
      on E: Exception do
      begin
//        Application.MessageBox(PChar(E.Message),'����',MB_ICONERROR);
        WriteWorkLog('���ݴ���','BI_SellOrder������У�'+E.Message);
      end;
    end;
  finally
    NameList.Free;
    ADO_Rec.Free;
  end;
end;

function TFrm_OrderRec.WriteSellOrderDetails(Node: IXMLNode;
  var Rec_ID: Integer): Boolean;
var
  nodeList: IXMLNodeList;
  strName,strValue, FieldName: string;
  NameList: TStringList;
  i: Integer;
  ADO_Rec: TADOQuery;
begin
  Result := False;
  if not node.HasChildNodes then Exit;
  NameList := TStringList.Create;
  if not GetFieldName(NameList,'BI_SellOrderDetails') then
  begin
    NameList.Free;
    Exit;
  end;
  ADO_Rec := TADOQuery.Create(Self);
  nodeList := node.ChildNodes;
  try
    GetTableData(ADO_Rec,'BI_SellOrderDetails','1=2');
    ADO_Rec.Insert;
    FieldName := FindFieldName(NameList,'SellID');
    if FieldName <> '' then
        ADO_Rec.FieldByName(FieldName).AsInteger := Rec_ID ;
    FieldName := FindFieldName(NameList,'ID');
    if FieldName <> '' then
    begin
      Rec_ID := GetMaxID('select IsNull(Max(F_iID),0) from BI_SellOrderDetails')+1 ;
      ADO_Rec.FieldByName(FieldName).AsInteger := Rec_ID;
    end;
    for i := 0 to nodeList.Count -1 do
    begin
      if nodeList[i].IsTextElement then
      begin
        strName := nodeList[i].NodeName;
        strValue := nodeList[i].NodeValue;
        if UpperCase(strName) = UpperCase('ID') then
        begin
          strName := 'DetailsID';
          ADO_Rec.FieldByName('F_iTgzt').AsInteger := 3; //������Ĭ��Ϊ�Ѻϸ�
          ADO_Rec.FieldByName('F_dCzrq').AsDateTime := Now;
          ADO_Rec.FieldByName('F_iCzrID').AsInteger := 9999;
          ADO_Rec.FieldByName('F_iFktgzt').AsInteger := 3; //������Ĭ��Ϊ�Ѻϸ�
          ADO_Rec.FieldByName('F_dFkrq').AsDateTime := Now;
          ADO_Rec.FieldByName('F_iFkrID').AsInteger := 9999;
          ADO_Rec.FieldByName('F_dLGRQ').AsDateTime := Now;
          ADO_Rec.FieldByName('F_sLGCZRBM').AsString := 'ϵͳ';
        end;
        if UpperCase(strName) = UpperCase('cpbh') then
          if Pos('-13-',strValue) >0 then             //����Ǻؿ�,�ĳɺؿ����
          begin
            ADO_Rec.FieldByName('F_iProductType').AsInteger := 13;
//            Result := False;
//            Exit;
          end;
        FieldName := FindFieldName(NameList,strName);
      end;
      if FieldName <> '' then
        ADO_Rec.FieldByName(FieldName).AsString := Trim(strValue) ;
    end;
    ADO_Rec.Post;
    Result := True;
  finally
    NameList.Free;
    ADO_Rec.Free;
  end;
end;

procedure TFrm_OrderRec.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    if UpdateSellData(OpenDialog1.FileName) then
    begin
      Application.MessageBox(pchar('����'+ExtractFileName(OpenDialog1.FileName)+'�ɹ�!'),'��ʾ',MB_ICONINFORMATION);
      if vIsFileDel = 1 then
        DeleteFile(OpenDialog1.FileName);
    end;
end;

procedure TFrm_OrderRec.FormCreate(Sender: TObject);
var
  ini: TIniFile;
  str,ServicesIP,InstanceName: string;
  MyReg: TRegistry;
  sFileName: string;
  SysMsg: TMessage;
begin
  Application.OnException := AppException;

  Application.OnMinimize := AppMinimize;

  MyReg := TRegistry.Create;
  MyReg.RootKey := HKEY_LOCAL_MACHINE;
  if MyReg.OpenKey(c_Reg_Program,True) then
  begin
    if MyReg.ValueExists('FileName') then
    begin
      sFileName := MyReg.ReadString('FileName');
      if sFileName <> Application.ExeName then
        MyReg.WriteString('FileName', Application.ExeName);
    end else
      MyReg.WriteString('FileName', Application.ExeName);
  end;
  MyReg.CloseKey;
  MyReg.Free;
  Caption := TitleName;
  WriteWorkLog('��������','');
  vdSrartTime := IncDay(now,-1);
  vbConnectionError := False;
  SetLength(vaConnectionErrorDate,0);
  str := ExtractFilePath(Application.ExeName);
  ini := TIniFile.Create(str+'set.ini');
  ServicesIP := ini.ReadString('Set','ServicesIP','');
  InstanceName := ini.ReadString('Set','InstanceName','');
  if InstanceName <> '' then
    InstanceName := '\'+InstanceName;

  if ServicesIP <> '' then
    str := 'Provider=SQLOLEDB.1;Password='+DatabaseUserPwd+';Persist Security Info=True;User ID='+DatabaseUserName+';Initial Catalog=YDPrint;Data Source='+ServicesIP
  else
   str := 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=YDPrint;Data Source=.';
//  str := str + ini.ReadString('Set','ServicesIP','.');
  ADOConnection1.ConnectionString := str+InstanceName;
  vUrl := ini.ReadString('WebServices','Url','');
  vIsFileDel := StrToNum(ini.ReadString('Set','IsFileDel','0'));
  vIsContinue := StrToNum(ini.ReadString('Set','IsContinue','0'));
  vIsDownLoadPic := StrToNum(ini.ReadString('Set','IsDownLoadPic','0'));
  if vIsDownLoadPic = 1 then
  begin
    vPicPath  := ini.ReadString('Set','PicPath','');
    if vPicPath = '' then
    begin
      Frm_PicPathDlg := TFrm_PicPathDlg.Create(Self);
      Frm_PicPathDlg.edt_Path.Text := ExtractFilePath(Application.ExeName)+'Pic\';
      Frm_PicPathDlg.dlgSave_Pic.FileName := ExtractFilePath(Application.ExeName);
      if Frm_PicPathDlg.ShowModal = mrOk then
      begin
        vPicPath := Trim(Frm_PicPathDlg.edt_Path.Text);
        if vPicPath <> '' then
          ini.WriteString('Set','PicPath',vPicPath)
        else
        begin
          vIsDownLoadPic := 0;
        end;
      end;
      Frm_PicPathDlg.Free;
    end else
    if vPicPath <> '' then
    begin
      if PathIsRelative(PAnsiChar(vPicPath)) then
      begin
        if StrLeft(vPicPath,1) <> '\' then
          vPicPath := vPicPath + '\';
        vPicPath := ExtractFilePath(Application.ExeName) + vPicPath;
      end;
      if (StrRight(vPicPath,1)<>'\') then
        vPicPath := vPicPath + '\';
      if not ForceDirectories(vPicPath) then
      begin
        Application.MessageBox('ͼ������·������ʧ��', '��ʾ', MB_OK +
          MB_ICONINFORMATION + MB_TOPMOST);
        vIsDownLoadPic := 0;
      end;

    end;
  end;
  if vIsContinue = 1then
    f_ContinueRecDate;
  if btn_Rec.Caption = '��ʼ����' then
    btn_Rec.Click;
//  UpdateData;
  ini.Free;

end;

procedure TFrm_OrderRec.tmr_CustomRecTimer(Sender: TObject);
label
  lab_loop;
var
  obj: PostServicePortType;
  data: ArrayOfArrayOfString;
  s: String;
  ms: TMemoryStream;
  sType: string;
  i: integer;
  Node: IXMLNode;
  sFileName: string;
  XML_Rec: TXMLDocument;
  iYH,iZYH: Integer;
  NodeList:IXMLNodeList;
  sDate: string;
begin
  try
    tmr_CustomRec.Enabled := False;
    obj := GetPostServicePortType(true, vUrl, nil);
    if obj = nil then exit;
    try
      data := obj.getOrderID(UserID, userpwd, 0, 0, '');
    except
      on E:Exception do
      begin
        vbConnectionError := True;
        f_GetConnectionErrorDate;
        WriteWorkLog('���ʳ���',E.Message);
        Exit;
      end;
    end;
    vbConnectionError := False;
    if High(Data) > -1 then
    begin
      sDate := FormatDateTime('yyyy-MM-dd',Now);
      for i := 0 to High(Data) do
      begin
        case StrToInt(Data[i][2]) of
          0: sType := '������';
          1: sType := '������';
          3: sType := '�ط���';
        else
          sType:= Data[i][2];
        end;
        WriteWorkLog('��¼','��δ����'+sType+'�ƻ���');
        WriteWorkLog('��¼','�ƻ���ID��'+Data[i][0]);
        WriteWorkLog('��¼','�ƻ������ţ�'+Data[i][1]);
        iYH := 1;
lab_loop:
        if (Data[i][2] = '0') or (Data[i][2] = '3') then
          s := obj.getOrderD(UserID, UserPwd, Data[i][0], iYH)
        else if Data[i][2] = '1' then
        begin
          s := obj.getOrderX(UserID, UserPwd, Data[i][0], iYH);
        end;
        if s <> '' then
        begin
          if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\') then
            ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\');
          try
            ms := TMemoryStream.Create;
            ms.WriteBuffer(Pointer(s)^, Length(s));
            XML_Rec := TXMLDocument.Create(self);
            XML_Rec.XML.Clear;
            XML_Rec.LoadFromStream(ms);
  //          Node := XML_Rec.DocumentElement.ChildNodes[0];
  //          if not IsPosCpbh(Node,'-13-') then Continue;      //�����Ϊ�ؿ�,��¼��
            if Data[i][2] = '0' then                             //������
            begin
              if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\') then
                ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\');
              sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\' + Data[i][0] +'_'+IntToStr(iYH)+'.xml';
              XML_Rec.SaveToFile(sFileName);
              if UpdateCustomData(sFileName) then
              begin
                inc(vRecCount);
                lab_RecCount.Caption := inttostr(vRecCount);
                WriteWorkLog('�ɹ�','���ն����ͼƻ������ţ�'+Data[i][0]+'_'+IntToStr(iYH)+' �ɹ�');
                if vIsFileDel = 1 then
                  DeleteFile(sFileName);
              end;
            end else
            if Data[i][2] = '1' then                           //������
            begin
              if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\') then
                ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\');
              sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\' + Data[i][0] +'_'+IntToStr(iYH)+'.xml';
              XML_Rec.SaveToFile(sFileName);
              if UpdateSellData(sFileName) then
              begin
                inc(vRecCount);
                lab_RecCount.Caption := inttostr(vRecCount);
                WriteWorkLog('�ɹ�','���������ͼƻ������ţ�'+Data[i][0]+'_'+IntToStr(iYH)+' �ɹ�');
              end;
            end else
            if Data[i][2] = '3' then                           //�ط���
            begin
              if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\'+sDate+'\') then
                ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\'+sDate+'\');
              sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\'+sDate+'\' + Data[i][0] +'_'+IntToStr(iYH)+'.xml';
              XML_Rec.SaveToFile(sFileName);
              if UpdateCustomData(sFileName) then
              begin
                WriteWorkLog('�ɹ�','���ն����͵ط���ƻ������� '+String(Data[i][0])+'_'+IntToStr(iYH)+' �ɹ�!');
//                Application.MessageBox(pchar('����'+String(Data[i][0])+'�ɹ�!'),'��ʾ',MB_ICONINFORMATION);
              end;
            end;
            nodeList := XML_Rec.DocumentElement.ChildNodes[0].ChildNodes;
            node := nodeList.FindNode('zyh');
            iZYH  := StrToNum(Node.NodeValue);

          finally
            ms.Free;
            XML_Rec.Free;
          end;
          if iYH < iZYH then
          begin
            inc(iYH);
            goto lab_loop;
          end;
        end;
      end;

    end;
  finally
    obj := nil;
    tmr_CustomRec.Enabled := True;
  end;
end;

procedure TFrm_OrderRec.WriteWorkLog(LogType,LogData: string);
var filev: TextFile;
  ss,str,sPath: string;
begin
  str:=DateTimeToStr(Now)+'��'+LogType+'��: '+LogData;
  sPath := ExtractFilePath(Application.ExeName) + 'RunLog\'+IntToStr(YearOf(Now))+'��' +IntToStr(MonthOf(Now))+'��\';
  ss:= sPath + FormatDateTime('yyyy-MM-DD',Now) + '.log';
//  if not DirectoryExists(sPath) then
//    CreateDir(ExtractFilePath(Application.ExeName)+'RunLog\');
  if not  ForceDirectories(sPath) then Exit;
  if FileExists(ss) then
  begin
    AssignFile(filev, ss);
    append(filev);
    writeln(filev, str);
  end else begin
    AssignFile(filev, ss);
    ReWrite(filev);
    writeln(filev, str);
  end;
  CloseFile(filev);
end;

procedure TFrm_OrderRec.N1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrm_OrderRec.tmr_SellRecTimer(Sender: TObject);
label
  lab_loop;
var
  obj: PostServicePortType;
  data: ArrayOfArrayOfString;
  s: String;
  ms: TMemoryStream;
  sType: string;
  i: integer;
  Node: IXMLNode;
  sFileName: string;
  XML_Rec: TXMLDocument;
  iYH,iZYH: Integer;
  NodeList:IXMLNodeList;
  sDate: string;
begin
  try
    tmr_SellRec.Enabled := False;
    obj := GetPostServicePortType(true, vUrl, nil);
    if obj = nil then exit;
    try
      data := obj.getOrderID(UserID, userpwd, 1, 0, '');
    except
      on E:Exception do
      begin
        vbConnectionError := True;
        f_GetConnectionErrorDate;
        WriteWorkLog('���ʳ���',E.Message);
        Exit;
      end;
    end;
    vbConnectionError := False;
    if High(Data) > -1 then
    begin
      for i := 0 to High(Data) do
      begin
        sDate := FormatDateTime('yyyy-MM-dd',Now);
        case StrToInt(Data[i][2]) of
          0: sType := '������';
          1: sType := '������';
          3: sType := '�ط���';
        else
          sType:= Data[i][2];
        end;
        WriteWorkLog('��¼','��δ����'+sType+'�ƻ���');
        WriteWorkLog('��¼','�ƻ���ID��'+Data[i][0]);
        WriteWorkLog('��¼','�ƻ������ţ�'+Data[i][1]);
        iYH := 1;
lab_loop:
        if Data[i][2] = '0' then
          s := obj.getOrderD(UserID, UserPwd, Data[i][0], 1)
        else if (Data[i][2] = '1')  or (Data[i][2] = '3') then
        begin
          s := obj.getOrderX(UserID, UserPwd, Data[i][0], 1);
        end;
        if s <> '' then
        begin
          if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\') then
            ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\');
          try
            ms := TMemoryStream.Create;
            ms.WriteBuffer(Pointer(s)^, Length(s));
            XML_Rec := TXMLDocument.Create(Self);
            XML_Rec.XML.Clear;
            XML_Rec.LoadFromStream(ms);
  //          Node := XML_Rec.DocumentElement.ChildNodes[0];
  //          if not IsPosCpbh(Node,'-13-') then Continue;      //�����Ϊ�ؿ�,��¼��
            if Data[i][2] = '0' then
            begin
              if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\') then
                ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\');
              sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\' + Data[i][0] +'_'+IntToStr(iYH)+'.xml';
              XML_Rec.SaveToFile(sFileName);
              if UpdateCustomData(sFileName) then
              begin
                inc(vRecCount);
                lab_RecCount.Caption := inttostr(vRecCount);
                WriteWorkLog('�ɹ�','���ն����ͼƻ������ţ�'+Data[i][0]+'_'+IntToStr(iYH)+' �ɹ�');
                if vIsFileDel = 1 then
                  DeleteFile(sFileName);
              end;
            end else
            if Data[i][2] = '1' then
            begin
              if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\') then
                ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\');
              sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\' + Data[i][0] +'_'+IntToStr(iYH)+'.xml';
              XML_Rec.SaveToFile(sFileName);
              if UpdateSellData(sFileName) then
              begin
                inc(vRecCount);
                lab_RecCount.Caption := inttostr(vRecCount);
                WriteWorkLog('�ɹ�','���������ͼƻ������ţ�'+Data[i][0]+'_'+IntToStr(iYH)+' �ɹ�');
              end;
            end else
            if Data[i][2] = '3' then                           //�ط���
            begin
              if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\'+sDate+'\') then
                ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\'+sDate+'\');
              sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\'+sDate+'\' + Data[i][0] +'_'+IntToStr(iYH)+'.xml';
              XML_Rec.SaveToFile(sFileName);
              if UpdateSellData(sFileName) then
              begin
                WriteWorkLog('�ɹ�','���������͵ط���ƻ������ţ�'+String(Data[i][0])+'_'+IntToStr(iYH)+' �ɹ�!');
  //                Application.MessageBox(pchar('����'+String(Data[i][0])+'�ɹ�!'),'��ʾ',MB_ICONINFORMATION);
              end;
            end;
            nodeList := XML_Rec.DocumentElement.ChildNodes[0].ChildNodes;
            node := nodeList.FindNode('zyh');
            iZYH  := StrToNum(Node.NodeValue);
            XML_Rec.Free;
          finally
            ms.Free;
            XML_Rec.Free;
          end;
          if iYH < iZYH then
          begin
            inc(iYH);
            goto lab_loop;
          end;
        end;
      end;

    end;


  finally
    obj := nil;
    tmr_SellRec.Enabled := True;
  end;
end;

function TFrm_OrderRec.UpdateData: Boolean;
var
  ID: Cardinal;
begin
  Result := False;
  hTCustom := CreateThread(nil, 0, @CustomThread, nil, 0, ID);
  hTSell := CreateThread(nil, 0, @SellThread, nil, 0, ID);
  Result := True;
end;



procedure TFrm_OrderRec.btn_RecClick(Sender: TObject);
begin
  if btn_Rec.Caption = '��ʼ����' then
  begin
    vTime := StrToDateTime2(FormatDateTime('yyyy-MM-dd 00:00:00',Now));
    vSJRQ := vTime;
    lab_Time.Caption := '0 �� 00:00:00';
    vRecCount := 0;
    lab_RecCount.Caption := inttostr(vRecCount);
    tmr_CustomRec.Enabled := True;
    tmr_SellRec.Enabled := True;
    tmr_Time.Enabled := True;
    tmr_qycx.Enabled := True;
    tmr_lrfk.Enabled := True;
    tmr_ggcx.Enabled := True;
    btn_Rec.Caption := '��ͣ����';
    WriteWorkLog('��ʼ����','');
  end else
  if btn_Rec.Caption = '��ͣ����' then
  begin
    tmr_CustomRec.Enabled := False;
    tmr_SellRec.Enabled := False;
    tmr_Time.Enabled := False;
    tmr_qycx.Enabled := False;
    tmr_lrfk.Enabled := False;
    tmr_ggcx.Enabled := False;
    btn_Rec.Caption := '��ʼ����';
    WriteWorkLog('��ͣ����','');
  end;
end;

procedure TFrm_OrderRec.tmr_TimeTimer(Sender: TObject);
begin
  vTime := IncSecond(vTime);
  lab_Time.Caption := IntToStr(DaysBetween(vSJRQ,vTime)) +' �� ' +FormatDateTime('hh:mm:ss',vTime);
end;

function TFrm_OrderRec.WriteCustomOrderTsgy(Node: IXMLNode;
  var Rec_ID: Integer): Boolean;
var
  nodeList: IXMLNodeList;
  strName,strValue, FieldName: string;
  NameList: TStringList;
  i: Integer;
  ADO_Rec: TADOQuery;
begin
  Result := False;
  if not node.HasChildNodes then Exit;
  NameList := TStringList.Create;
  if not GetFieldName(NameList,'BI_CustomOrderTsgy') then
  begin
    NameList.Free;
    Exit;
  end;
  ADO_Rec := TADOQuery.Create(Self);
  nodeList := node.ChildNodes;
  try
    GetTableData(ADO_Rec,'BI_CustomOrderTsgy','1=2');
    ADO_Rec.Insert;
    FieldName := FindFieldName(NameList,'CustomDetailsID');
    if FieldName <> '' then
      ADO_Rec.FieldByName(FieldName).AsInteger := Rec_ID;
    FieldName := FindFieldName(NameList,'ID');
    if FieldName <> '' then
    begin
      Rec_ID := GetMaxID('select IsNull(Max(F_iID),0) from BI_CustomOrderTsgy')+1 ;
      ADO_Rec.FieldByName(FieldName).AsInteger := Rec_ID ;
    end;
    FieldName := '';
    for i := 0 to nodeList.Count -1 do
    begin
      if nodeList[i].IsTextElement then
      begin
        strName := nodeList[i].NodeName;
        strValue := nodeList[i].NodeValue;
        FieldName := FindFieldName(NameList,strName);
      end;
      if FieldName <> '' then
        ADO_Rec.FieldByName(FieldName).AsString := Trim(strValue) ;
    end;
    ADO_Rec.Post;
    Result := True;
  finally
    NameList.Free;
    ADO_Rec.Free;
  end;
end;

function TFrm_OrderRec.IsPosCpbh(Node: IXMLNode; SubStr: string): Boolean;
var
  i: Integer;
  NodeList: IXMLNodeList;
  ChildNode: IXMLNode;
  StrName,StrValue: string;
begin
  Result := False;
  if not Node.HasChildNodes then Exit;
  NodeList := Node.ChildNodes;
  for i := 0 to nodeList.Count -1 do
  begin
    Node := NodeList[i];
    if (NodeList[i].NodeName = 'item') and (NodeList[i].HasChildNodes) then
    begin
      ChildNode := NodeList[i].ChildNodes.FindNode('cpbh');
      StrName := ChildNode.NodeName;
      StrValue := ChildNode.NodeValue;
      if UpperCase(StrName) = UpperCase('cpbh') then
        if Pos(SubStr,StrValue) >0 then
        begin
          Result := True;
          Break;
        end;
    end;
  end;
end;





function TFrm_OrderRec.WriteOrderApart(Node: IXMLNode; iDetailsID,
  Bz: Integer): Boolean;
const
  c_PT=0;      //��ͨ
  c_NJ=1;      //�ڼ�
var
  ADO_Rec, ADO_Type: TADOQuery;
  sYztmc, sCpbh,sFjCpbh, sNJCPBH, sYl: string;
  i, iFJNJBZ, iFJBZ, iGjs,iDfbbz: Integer;
  sSqlData: string;
begin
  Result := False;
  iGjs := 0;
  sCpbh := node.ChildNodes.FindNode('cpbh').NodeValue;
  sYl := node.ChildNodes.FindNode('yl').NodeValue;
  sYztmc := node.ChildNodes.FindNode('yztmc').NodeValue;
  try
    try
      ADO_Rec := TADOQuery.Create(Self);
      ADO_Type := TADOQuery.Create(Self);
      {case Bz of                                //��BI_CustomOrderDetails���е� F_tiFJBZ(�ֽ��־����)
        0:sSqlData := 'Select F_tiFJBZ from BI_CustomOrderDetails where F_iID='+IntToStr(iDetailsID);
        1:sSqlData := 'Select F_tiFJBZ from BI_SellOrderDetails where F_iID='+IntToStr(iDetailsID);
      end;
      iFJBZ := GetTableFirst(sSqlData); }
      case Bz of                                //��BI_CustomOrderDetails���е� F_tiFJBZ(�ֽ��־����)
        0:
          begin
            sSqlData := 'Select F_iGjs from BI_CustomOrderDetails where F_iID='+IntToStr(iDetailsID);
            iGjs := GetTableFirst(sSqlData);
          end;
        1:
          begin
            sSqlData := 'Select F_iGjs from BI_SellOrderDetails where F_iID='+IntToStr(iDetailsID);
            if sCpbh = '13-100000-13-0263-999' then
              iGjs := 12
            else if sCpbh = '13-100000-13-0256-999' then
              iGjs := 6;
            //if StrRight(sCpbh,4)='-999' then iGjs := 0;
          end;
      end;

      if GetTableData(ADO_Rec,'DO_OrderApart','F_tiOrderType = '+IntToStr(Bz)+' and F_iOrderID='+IntToStr(iDetailsID)) then   //���Ƿ�����ж��Ƿ�ֽ��
      begin
        if ADO_Rec.RecordCount = 0 then
        begin
          if StrRight(sCpbh,4)<>'-999' then iGjs := 1;
          sSqlData := Format('Select a.F_tiDfbbz from BI_CustomOrder a,BI_CustomOrderDetails b where a.F_iID=b.F_iCustomID and b.F_iID=%d',[iDetailsID]);
          iDfbbz := GetMaxID(sSqlData);
          sSqlData := 'Select IsNull(Max(b.F_tiFJNJBZ),0) F_tiFJNJBZ from Set_PostageType a,Set_ProductType b where a.F_iProductTypeID = b.F_iID and a.F_sYZTMC='''+sYztmc+''' ';
          iFJNJBZ := GetMaxID(sSqlData);
          for i := 0 to iGjs -1 do
          begin
            ADO_Rec.Insert;
            ADO_Rec.FieldByName('F_tiOrderType').AsInteger := Bz;
            ADO_Rec.FieldByName('F_iOrderID').AsInteger := iDetailsID;
            if StrRight(sCpbh,4)='-999' then
            begin
              case Bz of
                0:
                  begin
                    case iDfbbz of
                      0:
                        begin
                          sFjCpbh := StrLeft(sCpbh,Length(sCpbh)-3)+StrRight('000'+IntToStr(i+1),3);
                          sNJCPBH := StrLeft(sCpbh,Length(sCpbh)-3)+StrRight('000'+IntToStr(i+1),3);
                        end;
                      1:
                        begin
                          case iFJNJBZ of
                            0:sFjCpbh := StrLeft(sCpbh,Length(sCpbh)-3)+'0'+StrRight('00'+IntToStr(i+1),2);
                            1:sFjCpbh := StrLeft(sCpbh,Length(sCpbh)-3)+'1'+StrRight('00'+IntToStr(i+1),2);
                          end;
                          sNJCPBH := StrLeft(sCpbh,Length(sCpbh)-3)+'2'+StrRight('00'+IntToStr(i+1),2);
                        end;
                    end;
                  end;
                1:
                  begin
                    case iFJNJBZ of
                      0:sFjCpbh := StrLeft(sCpbh,Length(sCpbh)-3)+'0'+StrRight('00'+IntToStr(i+1),2);
                      1:sFjCpbh := StrLeft(sCpbh,Length(sCpbh)-3)+'1'+StrRight('00'+IntToStr(i+1),2);
                    end;
                    sNJCPBH := StrLeft(sCpbh,Length(sCpbh)-3)+'2'+StrRight('00'+IntToStr(i+1),2);
                  end;
              end;
            end else
            begin
              sFjCpbh := sCpbh;
              case Bz of
                0:
                  begin
                    case iDfbbz of
                      0: sNJCPBH := sCpbh;
                      1: sNJCPBH := StrLeft(sCpbh,Length(sCpbh)-3)+'2'+StrRight(sCpbh,2);
                    end;
                  end;
                1:sNJCPBH := StrLeft(sCpbh,Length(sCpbh)-3)+'2'+StrRight(sCpbh,2);
              end
            end;
            ADO_Rec.FieldByName('F_sCPBH').AsString := sFjCpbh;
            ADO_Rec.FieldByName('F_nYl').AsString :=FloatToStr(SureFloat(sYl,4) / iGjs);     //�������ƽ����
            ADO_Rec.FieldByName('F_sYztmc').AsString :=sYztmc;
            ADO_Rec.FieldByName('F_tiNJBZ').AsInteger := c_PT;
            GetTableData(ADO_Type,'Set_PostageType','1=1');
  //          iType := GetMaxID('Select F_iProductTypeCode from Set_PostageType where CHARINDEX(F_sYZTMC,'''+sYztmc+''')>0');
        //    case iType  of                         //�����ڼ�,ͨ��  Set_PostageType���� F_iProductTypeCode �����ж�
        //      2,3:
//            sSqlData := 'Select IsNull(Max(b.F_tiFJNJBZ),0) F_tiFJNJBZ from Set_PostageType a,Set_ProductType b where a.F_iProductTypeID = b.F_iID and CHARINDEX(a.F_sYZTMC,'''+sYztmc+''')=1 ';
//            iFJNJBZ := GetMaxID(sSqlData);
            if iFJNJBZ = 1 then                      //�����ڼ�,ͨ��  Set_ProductType���� iFJNJBZ=1 �ж�
            begin
              ADO_Rec.Insert;
              ADO_Rec.FieldByName('F_tiOrderType').AsInteger := Bz;
              ADO_Rec.FieldByName('F_iOrderID').AsInteger := iDetailsID;
             { if StrRight(sCpbh,4)='-999' then
              begin
                case Bz of
                  1:sNJCPBH := StrLeft(sCpbh,Length(sCpbh)-3)+'2'+StrRight('00'+IntToStr(i+1),2);
                end;
              end;  }
              ADO_Rec.FieldByName('F_sCPBH').AsString := sNJCPBH;
              ADO_Rec.FieldByName('F_nYl').AsString := FloatToStr(SureFloat(sYl,4) / iGjs);
              ADO_Rec.FieldByName('F_sYztmc').AsString :='������ͼ';
              ADO_Rec.FieldByName('F_tiNJBZ').AsInteger := c_NJ;
              case Bz of
                0: UpdateTable('Update BI_CustomOrderDetails set F_tiNJBS=1 where F_iID='+IntToStr(iDetailsID));
                1: UpdateTable('Update BI_SellOrderDetails set F_tiNJBS=1 where F_iID='+IntToStr(iDetailsID));
              end;
            end;
            ADO_Rec.Post;
          end;
          case Bz of
            0: UpdateTable('Update BI_CustomOrderDetails set F_tiFJBZ=1 where F_iID='+IntToStr(iDetailsID));
            1: UpdateTable('Update BI_SellOrderDetails set F_tiFJBZ=1 where F_iID='+IntToStr(iDetailsID));
          end;
          Result := True;
        end;
      end;
    except
      on E: Exception do
      begin
//        Application.MessageBox(PChar(E.Message),'����',MB_ICONERROR);
        WriteWorkLog('���ݴ���',E.Message);
        Exit;
      end;
    end;
  finally
    ADO_Rec.Free;
  end;

end;

function TFrm_OrderRec.UpdateTable(Sql: string): Boolean;
var
  ADO_Rec: TADOQuery;
begin
  Result:= False;
  try
    ADO_Rec := TADOQuery.Create(Self);
    ADO_Rec.Connection := ADOConnection1;
    ADO_Rec.Close;
    ADO_Rec.SQL.Text := Sql;
    ADO_Rec.ExecSQL;
    Result:= True;
  finally
    ADO_Rec.Free;
  end;
end;

procedure TFrm_OrderRec.FormShow(Sender: TObject);
begin
  dtp_DateBegin.DateTime := Now;
  dtp_DateEnd.DateTime := Now;
end;

procedure TFrm_OrderRec.Chk_0Click(Sender: TObject);
begin
  dtp_DateBegin.Enabled := False;
  dtp_DateEnd.Enabled := False;
end;

procedure TFrm_OrderRec.Chk_1Click(Sender: TObject);
begin
  dtp_DateBegin.Enabled := True;
  dtp_DateEnd.Enabled := True;

end;

function TFrm_OrderRec.GetTableFirst(Sql: string): Variant;
var
  ADO_Rec: TADOQuery;
begin
  Result:= '';
  try
    try
      ADO_Rec := TADOQuery.Create(Self);
      ADO_Rec.Connection := ADOConnection1;
      ADO_Rec.Close;
      ADO_Rec.SQL.Text := Sql;
      ADO_Rec.Open;
      if ADO_Rec.RecordCount > 0 then
        Result := ADO_Rec.Fields[0].AsVariant;
    except
      on E: Exception do
      begin
        WriteWorkLog('���ݴ���','���ѯ'+Sql+'��'+E.Message);
        Exit;
      end;
    end;
  finally
    ADO_Rec.Free;
  end;
end;

procedure TFrm_OrderRec.tmr_qycxTimer(Sender: TObject);
const
  c_dzx=0;
  c_dfb=3;
  c_ysd=1;
  c_hg=3;
  c_dy=4;
  c_yqy=5;
var
  ADO_Rec: TADOQuery;
  data: ArrayOfArrayOfString ;
  sSqlData,Cpbh: string;
  i,Sbid,Dfbbz,iOrderID: Integer;
  obj: PostServicePortType;
  sDate: string;
begin
  //�Ƿ�ǩ����ѯ
  try
    ADO_Rec := TADOQuery.Create(Self);
    ADO_Rec.Connection := ADOConnection1;
    ADO_Rec.Close;
    sSqlData := Format('Select *,(Select F_tiDfbbz from BI_CustomOrder where a.F_iCustomID=F_iID) '
      +'Dfbbz from BI_CustomOrderDetails a where a.F_tiQy = 1 and IsNull(F_tiCXBZ,0)=0  and a.F_iTgzt < %d',[c_yqy]);
    ADO_Rec.SQL.Text := sSqlData;
    ADO_Rec.Open;
    if ADO_Rec.RecordCount > 0 then
    begin
      obj := GetPostServicePortType(true, vUrl, nil);
      if obj = nil then exit;
    end;
    while not ADO_Rec.Eof do
    begin
      Sbid := ADO_Rec.FieldByName('F_iDetailsID').AsInteger;
      Cpbh := ADO_Rec.FieldByName('F_sCpbh').AsString;
      Dfbbz := ADO_Rec.FieldByName('Dfbbz').AsInteger;
      Cpbh :=StrLeft(Cpbh,17);
      sDate := FormatDateTime('yyyy-MM-dd',Now);
      try
        data := obj.getOrderQY(UserID,UserPwd,iif(Dfbbz=0,c_dzx,c_dfb),IntToStr(Sbid),Cpbh,sDate);
      except
        on E:Exception do
        begin
          WriteWorkLog('���ʳ���',E.Message);
          Exit;
        end;
      end;
      if High(Data) > -1 then
      begin
        if Data[0][2]='2' then
        begin
          ADO_Rec.Edit;
          ADO_Rec.FieldByName('F_iTgzt').AsInteger := c_yqy;
          ADO_Rec.FieldByName('F_iFktgzt').AsInteger := c_yqy;
          ADO_Rec.FieldByName('F_dCzrq').AsDateTime := Now;
          ADO_Rec.FieldByName('F_dFkrq').AsDateTime := StrToDateTimeDef(Data[0][3],Now);
          ADO_Rec.Post;
          iOrderID := ADO_Rec.FieldByName('F_iID').AsInteger;
          sSqlData := 'Update DO_OrderPicDate_Log set F_dYQY = getdate() where F_iOrderID=%d and F_tiOrderType=0';
          ExecQuery(sSqlData,[iOrderID]);
        end;
      end;
      ADO_Rec.Next;
    end;
  finally
    if obj <> nil then obj := nil;
    ADO_Rec.Free;
  end;

end;

procedure TFrm_OrderRec.btn_qycxClick(Sender: TObject);
begin
  tmr_qycx.Enabled := not tmr_qycx.Enabled;
end;

{ TMyDownLoad }

procedure TMyDownLoad.DownCustomOrder;
var
  obj: PostServicePortType;
  data: ArrayOfArrayOfString;
  s: String;
  ms: TMemoryStream;
  sType: string;
  i: integer;
  Node: IXMLNode;
  sFileName: string;
  XML_Rec: TXMLDocument;
begin
  try
//    tmr_CustomRec.Enabled := False;
    obj := GetPostServicePortType(true, vUrl, nil);
    if obj = nil then exit;
    try
      data := obj.getOrderID(UserID, userpwd, 0, 0, '');
    except
      on E:Exception do
      begin
        WriteWorkLog('���ʳ���',E.Message);
        Exit;
      end;
    end;
    if High(Data) > -1 then
    begin
      for i := 0 to High(Data) do
      begin
        case StrToInt(Data[i][2]) of
          0: sType := '������';
          1: sType := '������';
          3: sType := '�ط���';
        else
          sType:= '';
        end;
        WriteWorkLog('��¼','��δ����'+sType+'�ƻ���');
        WriteWorkLog('��¼','�ƻ���ID��'+Data[i][0]);
        WriteWorkLog('��¼','�ƻ������ţ�'+Data[i][1]);
        if Data[i][2] = '0' then
          s := obj.getOrderD(UserID, UserPwd, Data[i][0], 1)
        else if Data[i][2] = '1' then
        begin
          s := obj.getOrderX(UserID, UserPwd, Data[i][0], 1);
        end;
        if s <> '' then
        begin
          if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\') then
            CreateDir(ExtractFilePath(Application.ExeName)+'�ƻ�������\');
          try
            ms := TMemoryStream.Create;
            ms.WriteBuffer(Pointer(s)^, Length(s));
            XML_Rec := TXMLDocument.Create(Frm_OrderRec);
            XML_Rec.XML.Clear;
            XML_Rec.LoadFromStream(ms);
            Node := XML_Rec.DocumentElement.ChildNodes[0];
  //          if not IsPosCpbh(Node,'-13-') then Continue;      //�����Ϊ�ؿ�,��¼��
            if Data[i][2] = '0' then                             //������
            begin
              if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\') then
                CreateDir(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\');
              sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\������\' + Data[i][0] +'.xml';
              XML_Rec.SaveToFile(sFileName);
              if Frm_OrderRec.UpdateCustomData(sFileName) then
              begin
                inc(vRecCount);
                Frm_OrderRec.lab_RecCount.Caption := inttostr(vRecCount);
                WriteWorkLog('�ɹ�','���ն����ͼƻ������ţ�'+Data[i][0]+'�ɹ�');
                if vIsFileDel = 1 then
                  DeleteFile(sFileName);
              end;
            end else
            if Data[i][2] = '1' then                           //������
            begin
              if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\') then
                CreateDir(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\');
              sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\������\' + Data[i][0] +'.xml';
              XML_Rec.SaveToFile(sFileName);
              if Frm_OrderRec.UpdateSellData(sFileName) then
              begin
                inc(vRecCount);
                Frm_OrderRec.lab_RecCount.Caption := inttostr(vRecCount);
                WriteWorkLog('�ɹ�','���������ͼƻ������ţ�'+Data[i][0]+'�ɹ�');
              end;
            end else
            if Data[i][2] = '3' then                           //�ط���
            begin
              if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\') then
                CreateDir(ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\');
              sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\' + Data[i][0] +'.xml';
              XML_Rec.SaveToFile(sFileName);
              if Frm_OrderRec.UpdateCustomData(sFileName) then
              begin
                WriteWorkLog('�ɹ�','���ն����͵ط���ƻ�������'+String(Data[i][0])+'�ɹ�!');
//                Application.MessageBox(pchar('����'+String(Data[i][0])+'�ɹ�!'),'��ʾ',MB_ICONINFORMATION);
              end;
            end;
          finally
            ms.Free;
            XML_Rec.Free;
          end;
        end;
      end;

    end;
  finally
    obj := nil;
//    tmr_CustomRec.Enabled := True;
  end;
end;

procedure TMyDownLoad.DownLoadOrder;
begin

end;

procedure TMyDownLoad.DownSellOrder;
begin

end;

procedure TMyDownLoad.Execute;
begin
  inherited;
  DownCustomOrder;
  Sleep(5000);
  DownSellOrder;
end;

procedure TMyDownLoad.WriteWorkLog(LogType,LogData: string);
begin
  Frm_OrderRec.WriteWorkLog(LogType,LogData);
end;

procedure TFrm_OrderRec.Button3Click(Sender: TObject);
var
  obj: PostServicePortType;
  data: ArrayOfArrayOfString;
  SDate: string;
  s: String;
  ms: TMemoryStream;
  sType, i, j, k: integer;
  NodeList, ChildNodeList:IXMLNodeList;
  Node, ChildNode:IXMLNode;
  iDayCount: Integer;
  dDate,Rec_Date: TDateTime;
  XML_Rec: TXMLDocument;
  sFileName: string;
  bRec: Boolean;
begin
  try
    obj := nil;
    obj := GetPostServicePortType(true, Edit1.Text, nil);
    if obj = nil then exit;
    Memo1.Clear;
    sType := Box_msbz.ItemIndex;
  //  sType := -1;
    iDayCount := DaysBetween(dtp_DateBegin.DateTime,dtp_DateEnd.DateTime);
    dDate := dtp_DateBegin.DateTime;
    iDayCount := iif(Chk_0.Checked, 0, iDayCount);
    for k := 0 to iDayCount do
    begin
      sDate := FormatDateTime('yyyy-MM-dd',dDate);
      if not Chk_0.Checked then
        Rec_Date := DateOf(dDate);
  //  sDate := FormatDateTime('yyyy-MM-dd',dtp_Date.DateTime);
      try
        data := obj.getOrderID(UserID, UserPwd, sType,
          iif(Chk_0.Checked, 0, 1), iif(Chk_0.Checked, '', sDate));
      except
        on E:Exception do
        begin
          WriteWorkLog('���ʳ���',E.Message);
          Exit;
        end;
      end;
      Caption := TitleName + IntToStr(High(Data)+1);
      if High(Data) > -1 then
      begin
        Memo1.Lines.Add('���ڣ�'+sDate+'��  ������'+ Caption+' ��');
        for i := 0 to High(Data) do
        begin
          Memo1.Lines.Add(Data[i][0]);
          //Memo1.Lines.Add(Data[i][1]);
          //Memo1.Lines.Add(Data[i][2]);
        end;
        Memo1.Lines.Add('-------------------------------------');
      end;
      dDate := IncDay(dDate);
    end;
    Application.MessageBox(pchar('�������!'),'��ʾ',MB_ICONINFORMATION);
  finally
    obj := nil;
  end;

end;

procedure TFrm_OrderRec.Button4Click(Sender: TObject);
var
  obj: PostServicePortType;
  data: ArrayOfArrayOfString;
  SDate: string;
  s: String;
  ms: TMemoryStream;
  sType, i, j, k: integer;
  NodeList, ChildNodeList:IXMLNodeList;
  Node, ChildNode:IXMLNode;
  iDayCount: Integer;
  dDate,Rec_Date: TDateTime;
  XML_Rec: TXMLDocument;
  sFileName: string;
  bRec: Boolean;
begin
  try
    obj := nil;
    obj := GetPostServicePortType(true, Edit1.Text, nil);
    if obj = nil then exit;
    Memo1.Clear;
    sType := Box_msbz.ItemIndex;
    try
      s := obj.getFXSJ(UserID, UserPwd, Trim(Edit2.Text),0);
    except
      on E:Exception do
      begin
        WriteWorkLog('���ʳ���',E.Message);
        Exit;
      end;
    end;
    if s <> '' then
    begin
      {ms := TMemoryStream.Create;
      ms.WriteBuffer(Pointer(s)^, Length(s));
      XML_Rec := TXMLDocument.Create(Self);
      XML_Rec.XML.Clear;
      XML_Rec.LoadFromStream(ms);
      ForceDirectories(PChar(ExtractFilePath(Application.ExeName)+'��ǩ\'));
      sFileName := ExtractFilePath(Application.ExeName)+'��ǩ\'+Trim(edit2.Text)+'.xml';
      XML_Rec.SaveToFile(sFileName);
      Application.MessageBox(pchar('���!'),'��ʾ',MB_ICONINFORMATION);    }
    end;
  finally
    obj := nil;
    ms.free;
  end;

end;

procedure TFrm_OrderRec.Button6Click(Sender: TObject);
var
  obj: PostServicePortType;
  data: ArrayOfArrayOfString;
  SDate: string;
  s: String;
  ms: TMemoryStream;
  sType, i, j, k: integer;
  NodeList, ChildNodeList:IXMLNodeList;
  Node, ChildNode:IXMLNode;
  iDayCount: Integer;
  dDate,Rec_Date: TDateTime;
  XML_Rec: TXMLDocument;
  sFileName: string;
  bRec: Boolean;
begin
  try
    obj := nil;
    obj := GetPostServicePortType(true, Edit1.Text, nil);
    if obj = nil then exit;
    Memo1.Clear;
    sType := Box_msbz.ItemIndex;
    try
     // s := obj.setOutInfo(UserID, UserPwd,0, Trim(Edit2.Text),'11-110105-11-0018-000',0,0,0,A1,1,160000,'EMS');
    except
      on E:Exception do
      begin
        WriteWorkLog('���ʳ���',E.Message);
        Exit;         
      end;
    end;
    if s <> '' then
    begin
      ms := TMemoryStream.Create;
      ms.WriteBuffer(Pointer(s)^, Length(s));
      XML_Rec := TXMLDocument.Create(Self);
      XML_Rec.XML.Clear;
      XML_Rec.LoadFromStream(ms);
      sFileName := ExtractFilePath(Application.ExeName)+'��ǩ\'+Trim(edit2.Text)+'.xml';
      XML_Rec.SaveToFile(sFileName);
      Application.MessageBox(pchar('���!'),'��ʾ',MB_ICONINFORMATION);
    end;
  finally
    obj := nil;
    ms.free;
  end;

end;

function TFrm_OrderRec.UpdateCartonLableData(sDetailsID: string;iType: integer;Rec_Date:TDateTime): Boolean;
var
  obj: PostServicePortType;
  SData,sType: string;
  s: String;
  ms: TMemoryStream;
  i, j ,Rec_ID: integer;
  NodeList, ChildNodeList:IXMLNodeList;
  Node, ChildNode:IXMLNode;
  dData: TDateTime;
  XML_Rec: TXMLDocument;
  sFileName: string;
begin
  try
    obj := nil;
    obj := GetPostServicePortType(true, Edit1.Text, nil);
    if obj = nil then exit;
    case iType of
      0: sType := '������';
      1: sType := '������';
      2:
        begin
         sType := '�ط���';
         iType := 1;
        end;
    end;
    try
      s := obj.getFXSJ(UserID, UserPwd,sDetailsID,iType);
    except
      on E:Exception do
      begin
        WriteWorkLog('ʧ��',E.Message);
        Exit;
      end;
    end;
    if s <> '' then
    begin
      ms := TMemoryStream.Create;
      ms.WriteBuffer(Pointer(s)^, Length(s));
      XML_Rec := TXMLDocument.Create(Self);
//      XML_Rec.Encoding := DOMString('GBK');
      XML_Rec.XML.Clear;
      XML_Rec.LoadFromStream(ms);
      if Rec_Date =0 then
        dData := Now
      else
        dData := Rec_Date;
      sData := FormatDateTime('yyyy-MM-dd',dData);
      if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\'+sType+'\'+sData+'\��ǩ\') then
        ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\'+sType+'\'+sData+'\��ǩ\');
      sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\'+sType+'\'+sData+'\��ǩ\'+sDetailsID+'.xml';
      XML_Rec.SaveToFile(sFileName);
      nodeList := XML_Rec.DocumentElement.ChildNodes;
      for i := 0 to nodeList.Count -1 do
      begin
        node := nodeList[i];
        if WriteCartonLable(node,Rec_ID) then
        begin
          if node.ChildNodes['bqtxms'].HasChildNodes then
          begin
            ChildNode := node.ChildNodes['bqtxms'];
            WritePackageLable(ChildNode,Rec_ID);
//            ChildNodeList := node.ChildNodes['bqtxms'].ChildNodes;
//            for j := 0 to ChildNodeList.Count -1 do
//            begin
//              ChildNode := ChildNodeList[j];
//              WritePackageLable(ChildNode,Rec_ID);
//            end;
          end;
        end else
        begin
          WriteWorkLog('ʧ��','�걨ID:'+sDetailsID+'_'+IntToStr(i)+' ��ǩ����ʧ��!');
        end;
      end;
      WriteWorkLog('�ɹ�','�걨ID:'+sDetailsID+' ��ǩ����ɹ�!');
    end else
    begin
      WriteWorkLog('������','�걨ID:'+sDetailsID+' ��ǩ����Ϊ��!');
    end;

  finally
    obj := nil;
    ms.free;
    XML_Rec.free;
  end;
end;

function TFrm_OrderRec.WriteCartonLable(Node: IXMLNode;
  out Rec_ID: Integer): Boolean;
var
  nodeList: IXMLNodeList;
  strName,strValue, FieldName: string;
  NameList: TStringList;
  i: Integer;
  ADO_Rec: TADOQuery;
begin
  Result := False;
  if not node.HasChildNodes then Exit;
  NameList := TStringList.Create;
  if not GetFieldName(NameList,'BI_CartonLable') then
  begin
    NameList.Free;
    Exit;
  end;
  ADO_Rec := TADOQuery.Create(Self);
  nodeList := node.ChildNodes;
  try
    GetTableData(ADO_Rec,'BI_CartonLable','1=2');
    ADO_Rec.Insert;
    for i := 0 to nodeList.Count -1 do
    begin
      if nodeList[i].IsTextElement then
      begin
        strName := nodeList[i].NodeName;
        strValue := nodeList[i].NodeValue;
        FieldName := FindFieldName(NameList,strName);
      end;
      if FieldName <> '' then
        ADO_Rec.FieldByName(FieldName).AsString := Trim(strValue) ;
    end;
    ADO_Rec.Post;
    Rec_ID := ADO_Rec.FieldByName('F_iID').AsInteger;
    Result := True;
  finally
    NameList.Free;
    ADO_Rec.Free;
  end;
end;

function TFrm_OrderRec.WritePackageLable(Node: IXMLNode;
  Rec_ID: Integer): Boolean;
var
  nodeList: IXMLNodeList;
  strName,strValue, FieldName: string;
  NameList: TStringList;
  i: Integer;
  ADO_Rec: TADOQuery;
begin
  Result := False;
  if not node.HasChildNodes then Exit;
  NameList := TStringList.Create;
  if not GetFieldName(NameList,'BI_PackageLable') then
  begin
    NameList.Free;
    Exit;
  end;
  ADO_Rec := TADOQuery.Create(Self);
  nodeList := node.ChildNodes;
  try
    for i := 0 to nodeList.Count -1 do
    begin
      GetTableData(ADO_Rec,'BI_PackageLable','1=2');
      ADO_Rec.Insert;
      FieldName := FindFieldName(NameList,'CartonLableID');
      if FieldName <> '' then
        ADO_Rec.FieldByName(FieldName).AsInteger := Rec_ID;
      if nodeList[i].IsTextElement then
      begin
        strName := nodeList[i].NodeName;
        strValue := nodeList[i].NodeValue;
        FieldName := FindFieldName(NameList,strName);
      end;
      if FieldName <> '' then
        ADO_Rec.FieldByName(FieldName).AsString := Trim(strValue) ;
      ADO_Rec.Post;
    end;
    Result := True;
  finally
    NameList.Free;
    ADO_Rec.Free;
  end;
end;

procedure TFrm_OrderRec.Button5Click(Sender: TObject);
var
  sDetailsID : string;
  ADO_Rec: TADOQuery;
begin
  ADOTable1.First;
  ADO_Rec := TADOQuery.Create(self);
  while not ADOTable1.Eof do
  begin
    Application.ProcessMessages;
    sDetailsID := ADOTable1.FieldByName('F_iDetailsID').AsString;
    GetTableData(ADO_Rec,'BI_CartonLable','F_iSBID='+sDetailsID);
    if (ADO_Rec.RecordCount = 0) and (sDetailsID <> '') then
      UpdateCartonLableData(sDetailsID,0);
    ADOTable1.Next;
  end;
  ShowMessage('�������');
  ADO_Rec.Free;
end;

procedure TFrm_OrderRec.tmr_EverydayStartTimer(Sender: TObject);
label
  lab_loop;
var
  obj: PostServicePortType;
  data: ArrayOfArrayOfString;
  SDate: string;
  s,sType: String;
  ms: TMemoryStream;
  iType, i, j, k,t: integer;
  NodeList, ChildNodeList:IXMLNodeList;
  Node, ChildNode:IXMLNode;
  iDayCount: Integer;
  dDate,Rec_Date: TDateTime;
  XML_Rec: TXMLDocument;
  sFileName: string;
  bRec: Boolean;
  iYH,iZYH: Integer;
begin
  //ÿ������23��ɾ�����õ�ͼ��
  if (HourOf(Now) = 23) and (DayOf(Now) > DayOf(vdSrartTime)) then
  begin
    if vPicPath <> '' then
      DelFileList(vPicPath,1024*1024*1024);
  end;
  //ÿ������7�����ǰһ��Ķ���
  if (HourOf(Now) = 7) and (DayOf(Now) > DayOf(vdSrartTime)) then
  begin
    tmr_EverydayStart.Enabled := False;
    if btn_Rec.Caption = '��ͣ����' then
      btn_Rec.Click;
    try
      obj := nil;
      obj := GetPostServicePortType(true, vUrl, nil);
      if obj = nil then exit;

      for t := 0 to 1 do
      begin
        iType := t;
      //  sType := -1;
        iDayCount :=  DayOf(Now) - DayOf(vdSrartTime);
       // iDayCount := DaysBetween(vdSrartTime,Now);
        dDate := vdSrartTime;

        for k := 1 to iDayCount do
        begin
          sDate := FormatDateTime('yyyy-MM-dd',dDate);
          sType := iif(iType=0,'������','������');
          WriteWorkLog('�Զ�����','��ʼ���� '+sDate+' '+sType+'�ƻ���');
          Rec_Date := DateOf(dDate);
      //  sDate := FormatDateTime('yyyy-MM-dd',dtp_Date.DateTime);
          try
            data := obj.getOrderID(UserID, UserPwd, iType,
              1, sDate);
          except
            on E:Exception do
            begin
              WriteWorkLog('���ʳ���',E.Message);
              Exit;
            end;
          end;
          Caption := TitleName + IntToStr(High(Data));
          if High(Data) > -1 then
          begin
            for i := 0 to High(Data) do
            begin
              iYH := 1;
    lab_loop:
              if (Data[i][2] = '0') or (Data[i][2] = '3')  then
                s := obj.getOrderD(UserID, UserPwd, Data[i][0], iYH)
              //else if sType = 1 then
              else if Data[i][2] = '1' then
              begin
                s := obj.getOrderX(UserID, UserPwd, Data[i][0], iYH);
              end;
              if s <> '' then
              begin
                if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\') then
                  ForceDirectories(PChar(ExtractFilePath(Application.ExeName)+'�ƻ�������\'));
                try
                  ms := TMemoryStream.Create;
                  ms.WriteBuffer(Pointer(s)^, Length(s));
                  XML_Rec := TXMLDocument.Create(Self);
                  XML_Rec.XML.Clear;
                  XML_Rec.LoadFromStream(ms);
          //        node := XML_Rec.DocumentElement;
          //        ShowMessage(node.NodeName);
          //        Node := XML_Rec.DocumentElement.ChildNodes[0];
      //            if not IsPosCpbh(Node,'-13-') then Continue;      //�����Ϊ�ؿ�,��¼��
                  if Data[i][2] = '0' then
                  begin
                    if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\') then
                      ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\');
                    sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\' + Data[i][0] +'_'+IntToStr(iYH)+'.xml';
                    XML_Rec.SaveToFile(sFileName);
                    if UpdateCustomData(sFileName,Rec_Date) then
                    begin
                      WriteWorkLog('�Զ�����','���� '+sDate+' ������ '+String(Data[i][0])+'_'+IntToStr(iYH)+' �ɹ�!');
      //                Application.MessageBox(pchar('����'+String(Data[i][0])+'�ɹ�!'),'��ʾ',MB_ICONINFORMATION);
                    end;
                  end else
                  if Data[i][2] = '1' then
                  begin
                    if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\') then
                      ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\');
                    sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\' + Data[i][0] +'_'+IntToStr(iYH)+'.xml';
                    XML_Rec.SaveToFile(sFileName);
                    if UpdateSellData(sFileName,Rec_Date) then
                    begin
                      WriteWorkLog('�Զ�����','���� '+sDate+' ������ '+String(Data[i][0])+'_'+IntToStr(iYH)+' �ɹ�!');
      //                Application.MessageBox(pchar('����'+String(Data[i][0])+'�ɹ�!'),'��ʾ',MB_ICONINFORMATION);
                    end;
                  end else
                  if Data[i][2] = '3' then
                  begin
                    if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\'+sDate+'') then
                      ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\'+sDate+'');
                    sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\'+sDate+'\' + Data[i][0] +'_'+IntToStr(iYH)+'.xml';
                    XML_Rec.SaveToFile(sFileName);
                    if iType = 0 then
                      bRec := UpdateCustomData(sFileName,Rec_Date)
                    else
                    if iType = 1 then
                      bRec := UpdateSellData(sFileName,Rec_Date);
                    if bRec then
                    begin
                      WriteWorkLog('�Զ�����','���� '+sDate+' �ط��� '+String(Data[i][0])+'_'+IntToStr(iYH)+' �ɹ�!');
      //                Application.MessageBox(pchar('����'+String(Data[i][0])+'�ɹ�!'),'��ʾ',MB_ICONINFORMATION);
                    end;
                  end;
                  nodeList := XML_Rec.DocumentElement.ChildNodes[0].ChildNodes;
                  node := nodeList.FindNode('zyh');
                  iZYH  := StrToNum(Node.NodeValue);
                finally
                  ms.Free;
                  XML_Rec.Free;
                end;
                if iYH < iZYH then
                begin
                  inc(iYH);
                  goto lab_loop;
                end;
              end;

            end;

          end;
          if t = 0 then
            f_GetGGCXDate(dDate);
          dDate := IncDay(dDate);
        end;
      end;
      vdSrartTime := Now;
    finally
      obj := nil;
      if btn_Rec.Caption = '��ʼ����' then
        btn_Rec.Click;
      tmr_EverydayStart.Enabled := True;
    end;
  end;
end;

procedure TFrm_OrderRec.tmr_lrfkTimer(Sender: TObject);
var
  ADO_Rec, ADO_Temp: TADOQuery;
  data: ArrayOfArrayOfString ;
  sSqlData,sCpbh: string;
  i,iID,iSbid,iDfbbz,iOrderType,iTgzt,iRec: Integer;
  obj: PostServicePortType;
  sDate: string;
begin
  ADO_Rec := nil;

  sSqlData := 'exec p_ddpp';
  ExecQuery(sSqlData,[]);

  sSqlData := 'Select F_iID,F_iSBID,F_tiDfbbz,F_tiOrderType,F_sCpbh,F_iTGZT,F_dPPRQ from DO_FeedbackMakeOrder a '
    +' where  F_tiFKBZ=0 and datediff(n,F_dPPRQ,getdate())>60';

  try
    ADO_Rec := OpenQuery(sSqlData,[]);
    if Assigned(ADO_Rec) and (ADO_Rec.RecordCount >0) then
    begin
      obj := GetPostServicePortType(true, vUrl, nil);
      if obj = nil then exit;
      while not ADO_Rec.Eof do
      begin
        iID := ADO_Rec.FieldByName('F_iID').AsInteger;
        iSbid := ADO_Rec.FieldByName('F_iSBID').AsInteger;
        iDfbbz := ADO_Rec.FieldByName('F_tiDfbbz').AsInteger;
        iOrderType := ADO_Rec.FieldByName('F_tiOrderType').AsInteger;
        sCpbh := ADO_Rec.FieldByName('F_sCpbh').AsString;
        iTgzt := ADO_Rec.FieldByName('F_iTGZT').AsInteger;
        case iOrderType of
          0: sSqlData := ' Select 1 from BI_CustomOrderDetails where IsNull(F_iFKTGZT,0)=0 and F_iDetailsID=%d ';
          1: sSqlData := ' Select 1 from BI_SellOrderDetails where IsNull(F_iFKTGZT,0)=0 and F_iDetailsID=%d ';
        else
          sSqlData := '';
        end;
        ADO_Temp := nil;
        if sSqlData <> '' then
          ADO_Temp := OpenQuery(sSqlData,[iSbid]);
        if Assigned(ADO_Temp) and (ADO_Temp.RecordCount =0)then
        begin
          ADO_Temp.Free;
          ADO_Rec.Next;
          Continue;
        end;
        if (ADO_Temp.RecordCount >0) then
        begin
          try
            iRec := obj.setProductInfo(UserID,UserPwd,iif(iDfbbz=0,iOrderType,3),IntToStr(iSbid),sCpbh,iTgzt);
          except
            on E:Exception do
            begin
              WriteWorkLog('���ʳ���',E.Message);
              Exit;
            end;
          end;
          if iRec =0 then
          begin
            sSqlData := 'Update DO_FeedbackMakeOrder Set F_tiFKBZ=1,F_dFKRQ=getdate() where F_iID=%d';
            ExecQuery(sSqlData,[iID]);
            if iOrderType = 0 then
              sSqlData := 'Update BI_CustomOrderDetails Set F_iFktgzt=%d,F_dFkrq=getdate() where F_iDetailsID=%d'
            else if iOrderType = 1 then
              sSqlData := 'Update BI_CustomOrderDetails Set F_iFktgzt=%d,F_dFkrq=getdate() where F_iDetailsID=%d';
            ExecQuery(sSqlData,[iTgzt,iSbid]);
            WriteWorkLog('�����ɹ�','�걨ID:'+IntToStr(iSbid)+' ,��Ʒ���:'+sCpbh+',����ͼ��״̬'+IntToStr(iTgzt)+' �����ɹ�');
          end else
          begin
            WriteWorkLog('����ʧ��','�걨ID:'+IntToStr(iSbid)+' ,��Ʒ���:'+sCpbh+' ����ʧ��');
          end;
        end else
        begin
          sSqlData := 'Update DO_FeedbackMakeOrder Set F_tiFKBZ=2,F_dFKRQ=getdate() where F_iID=%d';
          ExecQuery(sSqlData,[iID]);
          WriteWorkLog('����ʧ��','�걨ID:'+IntToStr(iSbid)+' ,��Ʒ���:'+sCpbh+' �Ѿ����з������� ');
        end;
        ADO_Rec.Next;
      end;
    end;
  finally
    if obj <> nil then obj := nil;
    ADO_Rec.Free;
  end;

end;

function TFrm_OrderRec.ExecQuery(SQLText: String;
  const Args: array of const): Boolean;
var
  ADO_Rec: TADOQuery;
begin
  Result := False;
  try
    try
      ADO_Rec := TADOQuery.Create(Self);
      ADO_Rec.Connection := ADOConnection1;
      ADO_Rec.SQL.Text := Format(SQLText,Args);

      ADO_Rec.ExecSQL;
      Result := True;
    except
      on E: Exception do
      begin
        WriteWorkLog('���ݿ����','ִ�� '+Format(SQLText,Args)+' ����, ����:'+E.message);
        //Application.MessageBox(PChar('����:'+E.message),'��ʾ',MB_ICONINFORMATION);
        //raise Exception.Create(E.message);
      end;
    end;
  finally
    ADO_Rec.Free;
  end;
end;

function TFrm_OrderRec.OpenQuery(SQLText: String;
  const Args: array of const): TADOQuery;
var
  str: string;
begin
  try
    Result:= TADOQuery.Create(Self);;
    Result.Connection := ADOConnection1;
    Result.SQL.Text := Format(SQLText,Args);

    Result.Open;
  except
    on E: Exception do
    begin
      WriteWorkLog('���ݿ����','ִ�� '+Format(SQLText,Args)+' ����,����:'+E.message);
      //Application.MessageBox(PChar('����:'+E.message),'��ʾ',MB_ICONINFORMATION);
      Result.Free;
      Result := nil;
    end;
  end;
end;

function TFrm_OrderRec.ModifOrderData(Rec_ID: Integer): Boolean;
var
  sSqlData: string;
begin
  sSqlData := 'p_ggcx %d';
  ExecQuery(sSqlData,[Rec_ID]);
end;

function TFrm_OrderRec.ModifCustomOrderDetails(Node: IXMLNode;
  var Rec_ID: Integer; sDetailsID: string): Boolean;
var
  nodeList: IXMLNodeList;
  strName,strValue, FieldName,sSqlData: string;
  NameList: TStringList;
  i: Integer;
  ADO_Rec: TADOQuery;
begin
  Result := False;
  if not node.HasChildNodes then Exit;
  NameList := TStringList.Create;
  if not GetFieldName(NameList,'BI_CustomOrderDetails') then
  begin
    NameList.Free;
    Exit;
  end;
  ADO_Rec := TADOQuery.Create(Self);
  nodeList := node.ChildNodes;
  try
    sSqlData := 'Select * from BI_CustomOrderDetails where F_iDetailsID=%s';
    ADO_Rec := OpenQuery(sSqlData,[sDetailsID]);
    if ADO_Rec.RecordCount >0 then
      ADO_Rec.Edit
    else
      ADO_Rec.Insert;
    FieldName := FindFieldName(NameList,'CustomID');
    if FieldName <> ''  then
        ADO_Rec.FieldByName(FieldName).AsInteger := Rec_ID ;
    FieldName := FindFieldName(NameList,'ID');
    if (FieldName <> '') and (ADO_Rec.RecordCount = 0) then   //�����Ӳ�ȡ���ID
    begin
      Rec_ID := GetMaxID('select IsNull(Max(F_iID),0) from BI_CustomOrderDetails')+1 ;
      ADO_Rec.FieldByName(FieldName).AsInteger := Rec_ID;
    end;
    for i := 0 to nodeList.Count -1 do
    begin
      if nodeList[i].IsTextElement then
      begin
        strName := nodeList[i].NodeName;
        strValue := nodeList[i].NodeValue;
        if strName = 'fqttsgyf' then        //���ϵ��õ�
           strName:='fqttsgyf';
        if (strName = 'qttsgyms') and (ADO_Rec.RecordCount > 0) then        //Ϊ���⹤�ղ��޸�
           Continue;
        if UpperCase(strName) = UpperCase('ID') then
        begin
          strName := 'DetailsID';
        end;
        if UpperCase(strName) = UpperCase('cpbh') then
          if Pos('-13-',strValue) >0 then              //����Ǻؿ�,�ĳɺؿ����
          begin
            ADO_Rec.FieldByName('F_iProductType').AsInteger := 13;
//            Result := False;
//            Exit;
          end;
        FieldName := FindFieldName(NameList,strName);
      end;
      if FieldName <> '' then
        ADO_Rec.FieldByName(FieldName).AsString := Trim(strValue) ;
    end;
    ADO_Rec.Post;
    Result := True;
  finally
    NameList.Free;
    ADO_Rec.Free;
  end;
end;

function TFrm_OrderRec.ModifOrderApart(Node: IXMLNode; iDetailsID,
  Bz: Integer): Boolean;
const
  c_PT=0;      //��ͨ
  c_NJ=1;      //�ڼ�
var
  ADO_Rec, ADO_Type: TADOQuery;
  sYztmc, sCpbh,sFjCpbh, sYl: string;
  i,n, iType, iFJNJBZ, iFJBZ, iGjs: Integer;
  sSqlData: string;
begin
  Result := False;
  sCpbh := node.ChildNodes.FindNode('cpbh').NodeValue;
  sYl := node.ChildNodes.FindNode('yl').NodeValue;
  sYztmc := node.ChildNodes.FindNode('yztmc').NodeValue;
  try
    try
      ADO_Rec := TADOQuery.Create(Self);
      ADO_Type := TADOQuery.Create(Self);
      {case Bz of                                //��BI_CustomOrderDetails���е� F_tiFJBZ(�ֽ��־����)
        0:sSqlData := 'Select F_tiFJBZ from BI_CustomOrderDetails where F_iID='+IntToStr(iDetailsID);
        1:sSqlData := 'Select F_tiFJBZ from BI_SellOrderDetails where F_iID='+IntToStr(iDetailsID);
      end;
      iFJBZ := GetTableFirst(sSqlData); }
      case Bz of                                //��BI_CustomOrderDetails���е� F_tiFJBZ(�ֽ��־����)
        0:
          begin
            sSqlData := 'Select F_iGjs from BI_CustomOrderDetails where F_iID='+IntToStr(iDetailsID);
            iGjs := GetTableFirst(sSqlData);
          end;
        1:
          begin
            sSqlData := 'Select F_iGjs from BI_SellOrderDetails where F_iID='+IntToStr(iDetailsID);
            //if StrRight(sCpbh,4)='-999' then iGjs := 0;
          end;
      end;
      //�ж���û���ڼ�
      sSqlData := 'Select b.F_tiFJNJBZ from Set_PostageType a,Set_ProductType b where a.F_iProductTypeID = b.F_iID and CHARINDEX(a.F_sYZTMC,'''+sYztmc+''')=1 ';
      iFJNJBZ := GetMaxID(sSqlData);
      if GetTableData(ADO_Rec,'DO_OrderApart','F_tiOrderType = '+IntToStr(Bz)+' and F_iOrderID='+IntToStr(iDetailsID)) then   //���Ƿ�����ж��Ƿ�ֽ��
      begin
        if ADO_Rec.RecordCount = iGjs*(iFJNJBZ+1) then
        begin
          ADO_Rec.Edit;
        end else
        if ADO_Rec.RecordCount >0 then
        begin
          n := ADO_Rec.RecordCount;
          for i := 0 to n  -1 do
            ADO_Rec.Delete;
          ADO_Rec.Insert;
        end else
          ADO_Rec.Insert;
        begin
          if StrRight(sCpbh,4)<>'-999' then iGjs := 1;
          for i := 0 to iGjs -1 do
          begin
            ADO_Rec.FieldByName('F_tiOrderType').AsInteger := Bz;
            ADO_Rec.FieldByName('F_iOrderID').AsInteger := iDetailsID;
            if StrRight(sCpbh,4)='-999' then
            begin
              case Bz of
                0:sFjCpbh := StrLeft(sCpbh,Length(sCpbh)-3)+StrRight('000'+IntToStr(i+1),3);
                1:sFjCpbh := StrLeft(sCpbh,Length(sCpbh)-3)+'1'+StrRight('00'+IntToStr(i+1),2);
              end;
            end else
              sFjCpbh := sCpbh;
            ADO_Rec.FieldByName('F_sCPBH').AsString := sFjCpbh;
            ADO_Rec.FieldByName('F_nYl').AsString :=FloatToStr(SureFloat(sYl,4) / iGjs);     //�������ƽ����
            ADO_Rec.FieldByName('F_sYztmc').AsString :=sYztmc;
            ADO_Rec.FieldByName('F_tiNJBZ').AsInteger := c_PT;
            GetTableData(ADO_Type,'Set_PostageType','1=1');
  //          iType := GetMaxID('Select F_iProductTypeCode from Set_PostageType where CHARINDEX(F_sYZTMC,'''+sYztmc+''')>0');
        //    case iType  of                         //�����ڼ�,ͨ��  Set_PostageType���� F_iProductTypeCode �����ж�
        //      2,3:
            sSqlData := 'Select b.F_tiFJNJBZ from Set_PostageType a,Set_ProductType b where a.F_iProductTypeID = b.F_iID and CHARINDEX(a.F_sYZTMC,'''+sYztmc+''')=1 ';
            iFJNJBZ := GetMaxID(sSqlData);
            if iFJNJBZ = 1 then                      //�����ڼ�,ͨ��  Set_ProductType���� iFJNJBZ=1 �ж�
            begin
              ADO_Rec.Insert;
              ADO_Rec.FieldByName('F_tiOrderType').AsInteger := Bz;
              ADO_Rec.FieldByName('F_iOrderID').AsInteger := iDetailsID;
              if StrRight(sCpbh,4)='-999' then
              begin
                case Bz of
                  1:sFjCpbh := StrLeft(sCpbh,Length(sCpbh)-3)+'2'+StrRight('00'+IntToStr(i+1),2);
                end;
              end;
              ADO_Rec.FieldByName('F_sCPBH').AsString := sFjCpbh;
              ADO_Rec.FieldByName('F_nYl').AsString := FloatToStr(SureFloat(sYl,4) / iGjs);
              ADO_Rec.FieldByName('F_sYztmc').AsString :='������ͼ';
              ADO_Rec.FieldByName('F_tiNJBZ').AsInteger := c_NJ;
              case Bz of
               0: UpdateTable('Update BI_CustomOrderDetails set F_tiNJBS=1 where F_iID='+IntToStr(iDetailsID));
               1: UpdateTable('Update BI_SellOrderDetails set F_tiNJBS=1 where F_iID='+IntToStr(iDetailsID));
              end;
            end;
            ADO_Rec.Post;
          end;
          case Bz of
           0: UpdateTable('Update BI_CustomOrderDetails set F_tiFJBZ=1 where F_iID='+IntToStr(iDetailsID));
           1: UpdateTable('Update BI_SellOrderDetails set F_tiFJBZ=1 where F_iID='+IntToStr(iDetailsID));
          end;
          Result := True;
        end;
      end;
    except
      on E: Exception do
      begin
//        Application.MessageBox(PChar(E.Message),'����',MB_ICONERROR);
        WriteWorkLog('���ݴ���',E.Message);
        Exit;
      end;
    end;
  finally
    ADO_Rec.Free;
  end;
end;

procedure TFrm_OrderRec.Button7Click(Sender: TObject);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
begin

end;

procedure TFrm_OrderRec.btn_ggcxClick(Sender: TObject);
var
  obj: PostServicePortType;
  k,iType ,iDayCount: integer;
  dDate,Rec_Date: TDateTime;
  s,sDate,data,sFileName: string;
  ms: TMemoryStream;
begin
    obj := nil;
    obj := GetPostServicePortType(true, Edit1.Text, nil);
    if obj = nil then exit;

    Memo1.Clear;
    iType := Box_msbz.ItemIndex;
  //  sType := -1;
    iDayCount := DaysBetween(dtp_DateBegin.DateTime,dtp_DateEnd.DateTime);
    dDate := dtp_DateBegin.DateTime;
    iDayCount := iif(Chk_0.Checked, 0, iDayCount);
    for k := 0 to iDayCount do
    begin
      Application.ProcessMessages;
      sDate := FormatDateTime('yyyy-MM-dd',dDate);
      WriteWorkLog('�ֶ�����','��ʼ���� '+sDate+' ���ĳ����ƻ���');
      if not Chk_0.Checked then
        Rec_Date := DateOf(dDate);
  //  sDate := FormatDateTime('yyyy-MM-dd',dtp_Date.DateTime);
      try
        if Box_msbz.ItemIndex = 0 then
          data := obj.getGGCX(UserID, UserPwd, sDate)
        else
          data := obj.getGGCXD(UserID, UserPwd, sDate)
      except
        on E:Exception do
        begin
          WriteWorkLog('���ʳ���',E.Message);
          Exit;
        end;
      end;
//      Caption := IntToStr(High(Data));
      if data <> '' then
      begin
        Memo1.Lines.Add(data);
        ms := TMemoryStream.Create;
        ms.WriteBuffer(Pointer(data)^, Length(data));
        XML_Rec := TXMLDocument.Create(Self);
        XML_Rec.XML.Clear;
        XML_Rec.LoadFromStream(ms);
        ms.Free;
        if not DirectoryExists(ExtractFilePath(Application.ExeName)+'���ĳ�������\������\'+FormatDateTime('yyyy��MM��',dDate)+'\') then
          ForceDirectories(PChar(ExtractFilePath(Application.ExeName)+'���ĳ�������\������\'+FormatDateTime('yyyy��MM��',dDate)+'\'));
        sFileName := ExtractFilePath(Application.ExeName)+'���ĳ�������\������\'+FormatDateTime('yyyy��MM��',dDate)+'\'+sDate+'.xml';
        XML_Rec.SaveToFile(sFileName);
        XML_Rec.Free;
        if UpdateChangeData(sFileName,iif(Box_msbz.ItemIndex=1,0,3)) then
          WriteWorkLog('�ɹ�',sDate+'���ĳ�������ɹ�!')
        else
          WriteWorkLog('ʧ��',sDate+'���ĳ�������ʧ��!')
      end;
      dDate := IncDay(dDate);
    end;
    ShowMessage('���');
end;

function TFrm_OrderRec.UpdateChangeData(sFileName: string;
  OrderType: Integer): Boolean;
var
  i,j,iID,iChangeID,iDetailsID,iImgID,iTsgyID,iDfbbz: integer;
  NodeList,ChildNodeList: IXMLNodeList;
  Node,ChildNode: IXMLNode;
  ADO_Rec,ADO_Exist: TADOQuery;
  bLost: Boolean;
  sDetailsID: string;
  XML_Rec: TXMLDocument;
  sSqlData: string;
  iGLZCID,iZXBZ, iSBID: integer;
  sTypeName: string;
begin
  Result := False;
  try
    XML_Rec := TXMLDocument.Create(Self);
    XML_Rec.XML.Clear;
    if sFileName <> '' then
      XML_Rec.LoadFromFile(sFileName);
    nodeList := XML_Rec.DocumentElement.ChildNodes;
    for i := 0 to nodeList.Count -1 do
    begin
      node := nodeList[i];
      if (node.NodeName = 'item') and (node.HasChildNodes) then
      begin
        iGLZCID := node.ChildNodes['glzcid'].NodeValue;
        iZXBZ := node.ChildNodes['zxbz'].NodeValue;
        iSBID := node.ChildNodes['sbid'].NodeValue;
        sSqlData := 'Select * from BI_ChangeOrder where F_iGLZCID=%d and F_tiZXBZ=%d and F_iSBID=%d';
        ADO_Rec := OpenQuery(sSqlData,[iGLZCID,iZXBZ,iSBID]);
        if ADO_Rec.RecordCount > 0 then
        begin
          case OrderType of
           0: sTypeName := '������';
           3: sTypeName := '�ط���';
          end;
          WriteWorkLog('�����Ѵ���',sTypeName+' ���ĳ����걨ID��'+IntToStr(iSBID)+' ���ݴ���');
        end else
        begin
          if WriteChangeOrder(node,iID,OrderType) then
          begin
            ChildNodeList := node.ChildNodes['tsgy'].ChildNodes;
            iChangeID := iID;
            for j := 0 to ChildNodeList.Count -1 do
            begin
              iID := iChangeID;
              ChildNode := ChildNodeList[j];
              WriteChangeTSGY(ChildNode,iID,OrderType);
            end;
            ModifOrderData(iChangeID);
            Result := True;
          end;
        end;
        ADO_Rec.Free;
      end;
    end;
  finally
    XML_Rec.Free;
  end;

end;

function TFrm_OrderRec.WriteChangeOrder(Node: IXMLNode;
  out Rec_ID: Integer; OrderType: integer): Boolean;
var
  nodeList: IXMLNodeList;
  strName,strValue, FieldName: string;
  NameList: TStringList;
  i: Integer;
  ADO_Rec: TADOQuery;
begin
  Result := False;
  if not node.HasChildNodes then Exit;
  NameList := TStringList.Create;
  if not GetFieldName(NameList,'BI_ChangeOrder') then
  begin
    NameList.Free;
    Exit;
  end;
  ADO_Rec := TADOQuery.Create(Self);
  nodeList := node.ChildNodes;
  try
    try
      GetTableData(ADO_Rec,'BI_ChangeOrder','1=2');
      ADO_Rec.Insert;
      for i := 0 to nodeList.Count -1 do
      begin
        if nodeList[i].IsTextElement then
        begin
          strName := nodeList[i].NodeName;
          strValue := nodeList[i].NodeValue;
          FieldName := FindFieldName(NameList,strName);
          if FieldName <> '' then
            ADO_Rec.FieldByName(FieldName).AsString := Trim(strValue) ;
          if (UpperCase(Trim(strName)) = UpperCase('yzmc') ) and (Trim(strValue) <> '') then
            ADO_Rec.FieldByName('F_sYZTMC').AsString := Trim(strValue) ;
        end;
      end;
      ADO_Rec.FieldByName('F_tiOrderType').AsInteger := OrderType;
      ADO_Rec.FieldByName('F_dJSRQ').AsDateTime := Now;
      ADO_Rec.Post;
      Rec_ID := ADO_Rec.FieldByName('F_iID').AsInteger;
      Result := True;
    except
      on E: Exception do
      begin
//        Application.MessageBox(PChar(E.Message),'����',MB_ICONERROR);
        WriteWorkLog('���ݴ���','BI_CustomOrder������У�'+E.Message);
      end;
    end;
  finally
    NameList.Free;
    ADO_Rec.Free;
  end;
end;

function TFrm_OrderRec.WriteChangeTSGY(Node: IXMLNode;
  Rec_ID: Integer; OrderType: integer): Boolean;
var
  nodeList: IXMLNodeList;
  strName,strValue, FieldName,sSqlData: string;
  NameList: TStringList;
  i: Integer;
  ADO_Rec: TADOQuery;
begin
  Result := False;
  if not node.HasChildNodes then Exit;
  NameList := TStringList.Create;
  if not GetFieldName(NameList,'BI_ChangeTSGY') then
  begin
    NameList.Free;
    Exit;
  end;
  ADO_Rec := TADOQuery.Create(Self);
  nodeList := node.ChildNodes;
  try
    sSqlData := 'Select * from BI_ChangeTSGY where 1=2';
    //GetTableData(ADO_Rec,'BI_CustomOrderDetails','1=2');
    ADO_Rec := OpenQuery(sSqlData,[]);
    ADO_Rec.Insert;
    for i := 0 to nodeList.Count -1 do
    begin
      if nodeList[i].IsTextElement then
      begin
        strName := nodeList[i].NodeName;
        strValue := nodeList[i].NodeValue;
        FieldName := FindFieldName(NameList,strName);
      end;
      if FieldName <> '' then
        ADO_Rec.FieldByName(FieldName).AsString := Trim(strValue) ;
    end;
    FieldName := FindFieldName(NameList,'ChangeID');
    if FieldName <> ''  then
        ADO_Rec.FieldByName(FieldName).AsInteger := Rec_ID ;
    ADO_Rec.Post;
    Result := True;
  finally
    NameList.Free;
    ADO_Rec.Free;
  end;
end;

procedure TFrm_OrderRec.tmr_ggcxTimer(Sender: TObject);
var
  obj: PostServicePortType;
  k,iType ,iDayCount: integer;
  dDate,Rec_Date: TDateTime;
  s,sDate,data,sFileName: string;
  ms: TMemoryStream;
begin
    obj := nil;
    obj := GetPostServicePortType(true, vUrl, nil);
    if obj = nil then exit;

    for k := 0 to 1 do
    begin
      case k of
       0: iType := 0;
       1: iType := 3;
      end;
      sDate := FormatDateTime('yyyy-MM-dd',Now);
      //WriteWorkLog('�Զ�����','��ʼ���� '+sDate+' ���ĳ����ƻ���');
      Rec_Date := DateOf(Now);
  //  sDate := FormatDateTime('yyyy-MM-dd',dtp_Date.DateTime);
      try
        if iType = 0 then
          data := obj.getGGCX(UserID, UserPwd, sDate)
        else
          data := obj.getGGCXD(UserID, UserPwd, sDate)
      except
        on E:Exception do
        begin
          WriteWorkLog('���ʳ���',E.Message);
          Exit;
        end;
      end;
//      Caption := IntToStr(High(Data));
      if data <> '' then
      begin
        Memo1.Lines.Add(data);
        ms := TMemoryStream.Create;
        ms.WriteBuffer(Pointer(data)^, Length(data));
        XML_Rec := TXMLDocument.Create(Self);
        XML_Rec.XML.Clear;
        XML_Rec.LoadFromStream(ms);
        ms.Free;
        case iType of
          0:
            begin
              if not DirectoryExists(ExtractFilePath(Application.ExeName)+'���ĳ�������\������\'+FormatDateTime('yyyy��MM��',Rec_Date)+'\') then
                ForceDirectories(PChar(ExtractFilePath(Application.ExeName)+'���ĳ�������\������\'+FormatDateTime('yyyy��MM��',Rec_Date)+'\'));
              sFileName := ExtractFilePath(Application.ExeName)+'���ĳ�������\������\'+FormatDateTime('yyyy��MM��',Rec_Date)+'\'+sDate+'.xml';
            end;
          3:
            begin
              if not DirectoryExists(ExtractFilePath(Application.ExeName)+'���ĳ�������\�ط���\'+FormatDateTime('yyyy��MM��',Rec_Date)+'\') then
                ForceDirectories(PChar(ExtractFilePath(Application.ExeName)+'���ĳ�������\�ط���\'+FormatDateTime('yyyy��MM��',Rec_Date)+'\'));
              sFileName := ExtractFilePath(Application.ExeName)+'���ĳ�������\�ط���\'+FormatDateTime('yyyy��MM��',Rec_Date)+'\'+sDate+'.xml';
            end;
        end;
        XML_Rec.SaveToFile(sFileName);
        XML_Rec.Free;
        if UpdateChangeData(sFileName,iType) then
          WriteWorkLog('�ɹ�',sDate+'���ĳ�������ɹ�!')
        else
          WriteWorkLog('ʧ��',sDate+'���ĳ�������ʧ��!')
      end;
    end;
end;

function TFrm_OrderRec.ModifCustomData_old(sFileName: string;
  Rec_Date: TDateTime): Boolean;
var
  i,j,iID,iCusdomID,iDetailsID,iImgID,iTsgyID,iDfbbz: integer;
  NodeList,ChildNodeList: IXMLNodeList;
  Node,ChildNode: IXMLNode;
  ADO_Rec,ADO_Exist: TADOQuery;
  bLost: Boolean;
  sDetailsID: string;
  XML_Rec: TXMLDocument;
begin
  Result := False;
  bLost := False;
  XML_Rec := TXMLDocument.Create(Self);
  if sFileName <> '' then
    XML_Rec.LoadFromFile(sFileName);
  nodeList := XML_Rec.DocumentElement.ChildNodes[0].ChildNodes;
  node := nodeList.FindNode('id');
  iDfbbz := nodeList.FindNode('dfbbz').NodeValue;
  try
    ADO_Rec := TADOQuery.Create(self);
    GetTableData(ADO_Rec,'BI_CustomOrder','F_iID='+node.NodeValue);
    iID := node.NodeValue;
    node := XML_Rec.DocumentElement.ChildNodes[0];
    if ADO_Rec.RecordCount > 0 then
    begin
      WriteWorkLog('�����Ѵ���','�����ͼƻ������ţ�'+IntToStr(iID)+' ���ݴ���');
      //Exit;
    end else
    if not WriteCustomOrder(node,iID,Rec_Date) then
      Exit;
//    if not GetTableData(ADO_Write,'BI_CustomOrder','1=2') then Exit;
//    ADO_Write.Insert;
    iCusdomID := iID;
    nodeList := node.ChildNodes;
    for i := 0 to nodeList.Count -1 do
    begin
      iID := iCusdomID;
      node := nodeList[i];
      if (node.NodeName = 'item') and (node.HasChildNodes) then
      begin
        sDetailsID :=node.ChildNodes.FindNode('id').NodeValue;
        ADO_Exist := TADOQuery.Create(self);
        GetTableData(ADO_Exist,'BI_CustomOrderDetails','F_iDetailsID='+sDetailsID);
        if ADO_Exist.RecordCount >0 then
        begin
          if ModifCustomOrderDetails(node,iID,sDetailsID) then
          begin
            iDetailsID := iID;
          //  WriteOrderApart(node,iDetailsID,0);
          end else
          begin
            WriteWorkLog('�޸Ķ���','�����ͼƻ��� '+IntToStr(iCusdomID)+' �ж��� �걨ID:'+sDetailsID+' �޸�ʧ��!');
          end;
          GetTableData(ADO_Exist,'BI_CartonLable','F_iSBID='+sDetailsID);
          if ADO_Exist.RecordCount >0 then
          begin
            WriteWorkLog('�����Ѵ���','�걨ID:'+sDetailsID+' ��ǩ�Ѵ���!');
          end else
            UpdateCartonLableData(sDetailsID,iif(iDfbbz=0,0,2),Rec_Date);
          ADO_Exist.Free;
          Continue;
        end else
        begin
          ADO_Exist.Free;
          if WriteCustomOrderDetails(node,iID) then
          begin
            iDetailsID := iID;
            WriteOrderApart(node,iDetailsID,0);
            if node.ChildNodes['img'].HasChildNodes then
            begin
              ChildNodeList := node.ChildNodes['img'].ChildNodes;
              for j := 0 to ChildNodeList.Count -1 do
              begin
                iID := iDetailsID;
                ChildNode := ChildNodeList[j];
                WriteCustomOrderImg(ChildNode,iID);
              end;
            end;
            if node.ChildNodes['tsgy'].HasChildNodes then
            begin
              ChildNodeList := node.ChildNodes['tsgy'].ChildNodes;
              for j := 0 to ChildNodeList.Count -1 do
              begin
                iID := iDetailsID;
                ChildNode := ChildNodeList[j];
                WriteCustomOrderTsgy(ChildNode,iID);
              end;
            end;
            //WriteWorkLog('�ɹ�','�����ͼƻ��� '+IntToStr(iCusdomID)+' �ж��� �걨ID:'+sDetailsID+' ����ɹ�!');
            UpdateCartonLableData(sDetailsID,iif(iDfbbz=0,0,2),Rec_Date);
          end else
          begin
            bLost := True;
            sDetailsID := '';
            sDetailsID :=node.ChildNodes.FindNode('id').NodeValue;
            WriteWorkLog('ʧ��','�����ͼƻ��� '+IntToStr(iCusdomID)+' �ж��� �걨ID:'+sDetailsID+' ����ʧ��!');
          end;
        end;
        Result := True;
      end;
    end;
    if bLost then
      Result := false;
    if (vIsFileDel = 1) and (not bLost)   then
      DeleteFile(sFileName);

  finally
    ADO_Rec.Free;
    XML_Rec.Free;
  end;
end;

procedure TFrm_OrderRec.btn_OpenLogClick(Sender: TObject);
var
  sPath: string;
begin
  sPath := ExtractFilePath(Application.ExeName);
  ShellExecute(Handle,'open','Explorer.exe',PChar(sPath+'RunLog\'),nil,SW_SHOWNORMAL);
end;

procedure TFrm_OrderRec.FormDestroy(Sender: TObject);
begin
  WriteWorkLog('����ر�','');
end;

procedure TFrm_OrderRec.tmr_ErrorTimer(Sender: TObject);
label
  lab_loop;
var
  obj: PostServicePortType;
  data: ArrayOfArrayOfString;
  SDate: string;
  s,sType: String;
  ms: TMemoryStream;
  iType, i, j, k,t: integer;
  NodeList, ChildNodeList:IXMLNodeList;
  Node, ChildNode:IXMLNode;
  iDayCount: Integer;
  dDate,Rec_Date: TDate;
  XML_Rec: TXMLDocument;
  sFileName: string;
  bRec: Boolean;
  iYH, iZYH, iLen: Integer;
begin
  //���µ�������ʧ���������ڵĶ���
  iLen := Length(vaConnectionErrorDate);
  if not vbConnectionError and (iLen>0) then
  begin
    tmr_Error.Enabled := False;
    if btn_Rec.Caption = '��ͣ����' then
      btn_Rec.Click;
    try
      obj := nil;
      obj := GetPostServicePortType(true, vUrl, nil);
      if obj = nil then exit;

      for t := 0 to 1 do
      begin
        iType := t;
        for k := 0 to iLen -1 do
        begin
          dDate := vaConnectionErrorDate[k];
          sDate := FormatDateTime('yyyy-MM-dd',dDate);
          sType := iif(iType=0,'������','������');
          WriteWorkLog('���µ���','��ʼ���� '+sDate+' '+sType+'�ƻ���');
          Rec_Date := DateOf(dDate);
      //  sDate := FormatDateTime('yyyy-MM-dd',dtp_Date.DateTime);
          try
            data := obj.getOrderID(UserID, UserPwd, iType,
              1, sDate);
          except
            on E:Exception do
            begin
              WriteWorkLog('���ʳ���',E.Message);
              Exit;
            end;
          end;
          Caption := IntToStr(High(Data));
          if High(Data) > -1 then
          begin
            for i := 0 to High(Data) do
            begin
              iYH := 1;
    lab_loop:
              if (Data[i][2] = '0') or (Data[i][2] = '3')  then
                s := obj.getOrderD(UserID, UserPwd, Data[i][0], iYH)
              //else if sType = 1 then
              else if Data[i][2] = '1' then
              begin
                s := obj.getOrderX(UserID, UserPwd, Data[i][0], iYH);
              end;
              if s <> '' then
              begin
                if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\') then
                  ForceDirectories(PChar(ExtractFilePath(Application.ExeName)+'�ƻ�������\'));
                try
                  ms := TMemoryStream.Create;
                  ms.WriteBuffer(Pointer(s)^, Length(s));
                  XML_Rec := TXMLDocument.Create(Self);
                  XML_Rec.XML.Clear;
                  XML_Rec.LoadFromStream(ms);
          //        node := XML_Rec.DocumentElement;
          //        ShowMessage(node.NodeName);
          //        Node := XML_Rec.DocumentElement.ChildNodes[0];
      //            if not IsPosCpbh(Node,'-13-') then Continue;      //�����Ϊ�ؿ�,��¼��
                  if Data[i][2] = '0' then
                  begin
                    if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\') then
                      ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\');
                    sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\' + Data[i][0] +'_'+IntToStr(iYH)+'.xml';
                    XML_Rec.SaveToFile(sFileName);
                    if UpdateCustomData(sFileName,Rec_Date) then
                    begin
                      WriteWorkLog('���µ���','���� '+sDate+' ������ '+String(Data[i][0])+'_'+IntToStr(iYH)+' �ɹ�!');
      //                Application.MessageBox(pchar('����'+String(Data[i][0])+'�ɹ�!'),'��ʾ',MB_ICONINFORMATION);
                    end;
                  end else
                  if Data[i][2] = '1' then
                  begin
                    if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\') then
                      ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\');
                    sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\' + Data[i][0] +'_'+IntToStr(iYH)+'.xml';
                    XML_Rec.SaveToFile(sFileName);
                    if UpdateSellData(sFileName,Rec_Date) then
                    begin
                      WriteWorkLog('���µ���','���� '+sDate+' ������ '+String(Data[i][0])+'_'+IntToStr(iYH)+' �ɹ�!');
      //                Application.MessageBox(pchar('����'+String(Data[i][0])+'�ɹ�!'),'��ʾ',MB_ICONINFORMATION);
                    end;
                  end else
                  if Data[i][2] = '3' then
                  begin
                    if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\'+sDate+'') then
                      ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\'+sDate+'');
                    sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\'+sDate+'\' + Data[i][0] +'_'+IntToStr(iYH)+'.xml';
                    XML_Rec.SaveToFile(sFileName);
                    if iType = 0 then
                      bRec := UpdateCustomData(sFileName,Rec_Date)
                    else
                    if iType = 1 then
                      bRec := UpdateSellData(sFileName,Rec_Date);
                    if bRec then
                    begin
                      WriteWorkLog('���µ���','���� '+sDate+' �ط��� '+String(Data[i][0])+'_'+IntToStr(iYH)+' �ɹ�!');
      //                Application.MessageBox(pchar('����'+String(Data[i][0])+'�ɹ�!'),'��ʾ',MB_ICONINFORMATION);
                    end;
                  end;
                  nodeList := XML_Rec.DocumentElement.ChildNodes[0].ChildNodes;
                  node := nodeList.FindNode('zyh');
                  iZYH  := StrToNum(Node.NodeValue);
                finally
                  ms.Free;
                  XML_Rec.Free;
                end;
                if iYH < iZYH then
                begin
                  inc(iYH);
                  goto lab_loop;
                end;
              end;

            end;

          end;
        end;
      end;
      SetLength(vaConnectionErrorDate,0);
    finally
      obj := nil;
      if btn_Rec.Caption = '��ʼ����' then
        btn_Rec.Click;
      tmr_Error.Enabled := True;
    end;
  end;
end;

function TFrm_OrderRec.f_GetConnectionErrorDate: Boolean;
var
  i, iLen: integer;
  dDate: TDate;
begin
  Result := False;
  dDate := DateOf(Now);
  iLen := Length(vaConnectionErrorDate);
  if iLen > 0 then
  begin
    if vaConnectionErrorDate[iLen-1] <> dDate then
    begin
      SetLength(vaConnectionErrorDate,iLen+1);
      vaConnectionErrorDate[iLen] := dDate;
    end;
  end else
  begin
    SetLength(vaConnectionErrorDate,1);
    vaConnectionErrorDate[0] := dDate;
  end;
  Result := True;
end;

function TFrm_OrderRec.f_ContinueRecDate: Boolean;
label
  lab_loop;
var
  obj: PostServicePortType;
  data: ArrayOfArrayOfString;
  SDate: string;
  s,sType: String;
  ms: TMemoryStream;
  iType, i, j, k,t: integer;
  NodeList, ChildNodeList:IXMLNodeList;
  Node, ChildNode:IXMLNode;
  iDayCount: Integer;
  dDate,Rec_Date: TDateTime;
  XML_Rec: TXMLDocument;
  sFileName: string;
  bRec: Boolean;
  iYH,iZYH: Integer;
  sSqlData: string;
  ADOQ_Rec: TADOQuery;
  dJSRQ: TDateTime;
begin
  Result := False;
  dJSRQ := vdSrartTime;
  sSqlData := 'Select max(F_djsrq) JSRQ from BI_CustomOrder where F_djsrq is not null';
  ADOQ_Rec := OpenQuery(sSqlData,[]);
  if Assigned(ADOQ_Rec) and (ADOQ_Rec.RecordCount>0) then
    dJSRQ := ADOQ_Rec.FieldByName('JSRQ').AsDateTime;
  ADOQ_Rec.Free;
  sSqlData := 'Select max(F_djsrq) JSRQ from BI_SellOrder where F_djsrq is not null';
  ADOQ_Rec := OpenQuery(sSqlData,[]);
  if Assigned(ADOQ_Rec) and (ADOQ_Rec.RecordCount>0) and (dJSRQ < ADOQ_Rec.FieldByName('JSRQ').AsDateTime)then
    dJSRQ := ADOQ_Rec.FieldByName('JSRQ').AsDateTime;
  ADOQ_Rec.Free;

  if dJSRQ <> vdSrartTime then
  begin
    if btn_Rec.Caption = '��ͣ����' then
      btn_Rec.Click;
    try
      obj := nil;
      obj := GetPostServicePortType(true, vUrl, nil);
      if obj = nil then exit;

      for t := 0 to 1 do
      begin
        iType := t;
      //  sType := -1;
        iDayCount :=  DayOf(Now) - DayOf(dJSRQ);
       // iDayCount := DaysBetween(vdSrartTime,Now);
        dDate := dJSRQ;

        for k := 0 to iDayCount do
        begin
          sDate := FormatDateTime('yyyy-MM-dd',dDate);
          sType := iif(iType=0,'������','������');
          WriteWorkLog('���¼�������','��ʼ���� '+sDate+' '+sType+'�ƻ���');
          Rec_Date := DateOf(dDate);
      //  sDate := FormatDateTime('yyyy-MM-dd',dtp_Date.DateTime);
          try
            data := obj.getOrderID(UserID, UserPwd, iType,
              1, sDate);
          except
            on E:Exception do
            begin
              WriteWorkLog('���ʳ���',E.Message);
              Exit;
            end;
          end;
          Caption := IntToStr(High(Data));
          if High(Data) > -1 then
          begin
            for i := 0 to High(Data) do
            begin
              iYH := 1;
    lab_loop:
              if (Data[i][2] = '0') or (Data[i][2] = '3')  then
                s := obj.getOrderD(UserID, UserPwd, Data[i][0], iYH)
              //else if sType = 1 then
              else if Data[i][2] = '1' then
              begin
                s := obj.getOrderX(UserID, UserPwd, Data[i][0], iYH);
              end;
              if s <> '' then
              begin
                if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\') then
                  ForceDirectories(PChar(ExtractFilePath(Application.ExeName)+'�ƻ�������\'));
                try
                  ms := TMemoryStream.Create;
                  ms.WriteBuffer(Pointer(s)^, Length(s));
                  XML_Rec := TXMLDocument.Create(Self);
                  XML_Rec.XML.Clear;
                  XML_Rec.LoadFromStream(ms);
          //        node := XML_Rec.DocumentElement;
          //        ShowMessage(node.NodeName);
          //        Node := XML_Rec.DocumentElement.ChildNodes[0];
      //            if not IsPosCpbh(Node,'-13-') then Continue;      //�����Ϊ�ؿ�,��¼��
                  if Data[i][2] = '0' then
                  begin
                    if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\') then
                      ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\');
                    sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\' + Data[i][0] +'_'+IntToStr(iYH)+'.xml';
                    XML_Rec.SaveToFile(sFileName);
                    if UpdateCustomData(sFileName,Rec_Date) then
                    begin
                      WriteWorkLog('���¼�������','���� '+sDate+' ������ '+String(Data[i][0])+'_'+IntToStr(iYH)+' �ɹ�!');
      //                Application.MessageBox(pchar('����'+String(Data[i][0])+'�ɹ�!'),'��ʾ',MB_ICONINFORMATION);
                    end;
                  end else
                  if Data[i][2] = '1' then
                  begin
                    if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\') then
                      ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\');
                    sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\������\'+sDate+'\' + Data[i][0] +'_'+IntToStr(iYH)+'.xml';
                    XML_Rec.SaveToFile(sFileName);
                    if UpdateSellData(sFileName,Rec_Date) then
                    begin
                      WriteWorkLog('���¼�������','���� '+sDate+' ������ '+String(Data[i][0])+'_'+IntToStr(iYH)+' �ɹ�!');
      //                Application.MessageBox(pchar('����'+String(Data[i][0])+'�ɹ�!'),'��ʾ',MB_ICONINFORMATION);
                    end;
                  end else
                  if Data[i][2] = '3' then
                  begin
                    if not DirectoryExists(ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\'+sDate+'') then
                      ForceDirectories(ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\'+sDate+'');
                    sFileName := ExtractFilePath(Application.ExeName)+'�ƻ�������\�ط���\'+sDate+'\' + Data[i][0] +'_'+IntToStr(iYH)+'.xml';
                    XML_Rec.SaveToFile(sFileName);
                    if iType = 0 then
                      bRec := UpdateCustomData(sFileName,Rec_Date)
                    else
                    if iType = 1 then
                      bRec := UpdateSellData(sFileName,Rec_Date);
                    if bRec then
                    begin
                      WriteWorkLog('���¼�������','���� '+sDate+' �ط��� '+String(Data[i][0])+'_'+IntToStr(iYH)+' �ɹ�!');
      //                Application.MessageBox(pchar('����'+String(Data[i][0])+'�ɹ�!'),'��ʾ',MB_ICONINFORMATION);
                    end;
                  end;
                  nodeList := XML_Rec.DocumentElement.ChildNodes[0].ChildNodes;
                  node := nodeList.FindNode('zyh');
                  iZYH  := StrToNum(Node.NodeValue);
                finally
                  ms.Free;
                  XML_Rec.Free;
                end;
                if iYH < iZYH then
                begin
                  inc(iYH);
                  goto lab_loop;
                end;
              end;

            end;

          end;
          if t = 0 then
            f_GetGGCXDate(dDate);
          dDate := IncDay(dDate);
        end;
      end;
      Result := True;
    finally
      obj := nil;
      if btn_Rec.Caption = '��ʼ����' then
        btn_Rec.Click;
    end;
  end;
end;

function TFrm_OrderRec.f_GetGGCXDate(_date: TDateTime): Boolean;
var
  obj: PostServicePortType;
  k,iType ,iDayCount: integer;
  dDate,Rec_Date: TDateTime;
  s,sDate,data,sFileName: string;
  ms: TMemoryStream;
begin
  Result := False;

  obj := nil;
  obj := GetPostServicePortType(true, vUrl, nil);
  if obj = nil then exit;

  for k := 0 to 1 do
  begin
    case k of
     0: iType := 0;
     1: iType := 3;
    end;
    sDate := FormatDateTime('yyyy-MM-dd',_date);
    //WriteWorkLog('�Զ�����','��ʼ���� '+sDate+' ���ĳ����ƻ���');
    Rec_Date := DateOf(_date);
//  sDate := FormatDateTime('yyyy-MM-dd',dtp_Date.DateTime);
    try
      if iType = 0 then
        data := obj.getGGCX(UserID, UserPwd, sDate)
      else
        data := obj.getGGCXD(UserID, UserPwd, sDate)
    except
      on E:Exception do
      begin
        WriteWorkLog('���ʳ���',E.Message);
        Exit;
      end;
    end;
//      Caption := IntToStr(High(Data));
    if data <> '' then
    begin
      Memo1.Lines.Add(data);
      ms := TMemoryStream.Create;
      ms.WriteBuffer(Pointer(data)^, Length(data));
      XML_Rec := TXMLDocument.Create(Self);
      XML_Rec.XML.Clear;
      XML_Rec.LoadFromStream(ms);
      ms.Free;
      case iType of
        0:
          begin
            if not DirectoryExists(ExtractFilePath(Application.ExeName)+'���ĳ�������\������\'+FormatDateTime('yyyy��MM��',Rec_Date)+'\') then
              ForceDirectories(PChar(ExtractFilePath(Application.ExeName)+'���ĳ�������\������\'+FormatDateTime('yyyy��MM��',Rec_Date)+'\'));
            sFileName := ExtractFilePath(Application.ExeName)+'���ĳ�������\������\'+FormatDateTime('yyyy��MM��',Rec_Date)+'\'+sDate+'.xml';
          end;
        3:
          begin
            if not DirectoryExists(ExtractFilePath(Application.ExeName)+'���ĳ�������\�ط���\'+FormatDateTime('yyyy��MM��',Rec_Date)+'\') then
              ForceDirectories(PChar(ExtractFilePath(Application.ExeName)+'���ĳ�������\�ط���\'+FormatDateTime('yyyy��MM��',Rec_Date)+'\'));
            sFileName := ExtractFilePath(Application.ExeName)+'���ĳ�������\�ط���\'+FormatDateTime('yyyy��MM��',Rec_Date)+'\'+sDate+'.xml';
          end;
      end;
      XML_Rec.SaveToFile(sFileName);
      XML_Rec.Free;
      if UpdateChangeData(sFileName,iType) then
        WriteWorkLog('�ɹ�',sDate+'���ĳ�������ɹ�!')
      else
        WriteWorkLog('ʧ��',sDate+'���ĳ�������ʧ��!')
    end;
  end;
  Result := True;

end;

procedure TFrm_OrderRec.AppException(Sender: TObject; E: Exception);
begin
  WriteWorkLog('system',E.Message);
end;

procedure TDownLoadPic.DownLoadPic;
var
  idhtp_pic:TIdHTTP;
  ms: TMemoryStream;
  sPicPath,sFileName: string;
begin
  try
    ms := TMemoryStream.Create;
    idhtp_pic := TIdHTTP.Create(nil);
    sPicPath := vUrl;
    if sPicPath = '' then
    begin
      Frm_OrderRec.WriteWorkLog('ͼ������ʧ��','ͼ�����ص�ַΪ��!');
      Exit;
    end;
    sFileName :=  StrReplace(sPicPath,'/','\');
    ms.Clear;
    idhtp_pic.Get(c_PicUrl+sPicPath,ms);
    if ForceDirectories(ExtractFilePath(vPicPath + sFileName)) then
    begin
      ms.SaveToFile(vPicPath+sFileName);
      Frm_OrderRec.WriteWorkLog('ͼ�����سɹ�','������'+sFileName);
    end;
  finally
    idhtp_pic.Free;
    ms.Free;
  end;
end;

procedure TDownLoadPic.Execute;

begin
  inherited;
  FreeOnTerminate := True;
  DownLoadPic;

end;



procedure TFrm_OrderRec.DownLoadPic(sUrl: string);
begin
  with TDownLoadPic.Create(True) do
  begin
    vUrl := sUrl;
    Resume;
  end;
end;

procedure TFrm_OrderRec.DelFileList(_Path: string; _Size: Int64);
type
  TFileInfo= record
    m_iID: integer;
    m_sPath: string;
    m_iSize: Integer;
    m_dLastWriteTime: TDateTime;
  end;
var
  sTempPath: string;
  FileInfo: array of TFileInfo;
  i: integer;
  iSize: Int64;
function CovFileDate(Fd:_FileTime):TDateTime;
{ ת���ļ���ʱ���ʽ }
var
  Tct:_SystemTime;
  Temp:_FileTime;
begin
  FileTimeToLocalFileTime(Fd,Temp);
  FileTimeToSystemTime(Temp,Tct);
  CovFileDate:=SystemTimeToDateTime(Tct);
end;
procedure Sort(var Data: array of TFileInfo;l, r: Integer);
var
  i, j: integer;
  x, y: TFileInfo;
begin
     i := l;
     j := r;
     x := Data[(l+r) DIV 2];
     while i<=j do
     begin
          while Data[i].m_dLastWriteTime < x.m_dLastWriteTime do inc(i);
          while x.m_dLastWriteTime < Data[j].m_dLastWriteTime do dec(j);
          if i <= j then
          begin
               y := Data[i];
               Data[i] := Data[j];
               Data[j] := y;
               inc(i);
               dec(j);
          end;
     end;
     if l < j then Sort(Data, l, j);
     if i < r then Sort(Data, i, r);
end;

function   GetFolderSize(vFolder:   String):   Int64;
var
    sr:  TSearchRec;
    Len: integer;
begin
  Result := 0;
  try
    if FindFirst(vFolder + '*.* ', faAnyFile, sr) = 0 then
      repeat
        if (sr.Name <> '.') and (sr.Name <> '..') then
        begin
          Result := Result + sr.Size;
          if (sr.Attr and faDirectory) <> 0 then
            Result := Result + GetFolderSize(vFolder + sr.Name + '\')
          else begin
            Len := Length(FileInfo);
            SetLength(FileInfo,Len+1);
            FileInfo[Len].m_dLastWriteTime := CovFileDate(sr.FindData.ftLastWriteTime);
            FileInfo[Len].m_sPath := vFolder+sr.Name;
            FileInfo[Len].m_iID := Len;
            FileInfo[Len].m_iSize := sr.Size;
          end;
        end;
      until FindNext(sr) <> 0;
      SysUtils.FindClose(sr);
  finally

  end;
end;

begin
  SetLength(FileInfo,1);
  iSize :=GetFolderSize(_Path);
  if iSize > _Size then
  begin
    Sort(FileInfo,1,Length(FileInfo)-1);
    iSize := 0;
    for i := 1 to Length(FileInfo)-1 do
    begin
      SysUtils.DeleteFile(FileInfo[i].m_sPath);
      iSize := iSize + FileInfo[i].m_iSize;
      if iSize > (_Size div 2) then  Break;
    end;
  end;
end;

procedure TFrm_OrderRec.SysCommand(var SysMsg: TMessage);
begin
  case SysMsg.WParam of

    SC_MINIMIZE: // ����С��ʱ
    begin
      SetWindowPos(Application.Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_HIDEWINDOW);
      Hide; // �����������س���
      // ����������ʾͼ��
      if not Assigned(pNotifyIcon) then
      begin
        New(pNotifyIcon);
        with pNotifyIcon^ do
        begin
          cbSize := SizeOf(TNotifyIconData);
          Wnd := Handle;
          uID := 1;
          uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
          uCallBackMessage := WM_NID;
          hIcon := Application.Icon.Handle;
          szTip := TitleName;
        end;
      end;
      Shell_NotifyIcon(NIM_ADD, Pointer(pNotifyIcon)); // ����������ʾͼ��

    end;

  else
    inherited;
  end;
end;

procedure TFrm_OrderRec.WMNID(var msg: TMessage);
var
mousepos: TPoint;
begin
  GetCursorPos(mousepos); //��ȡ���λ��
  case msg.LParam of
    WM_LBUTTONUP: // ����������������
    begin
      //Self.Visible := not Self.Visible; // ��ʾ���������
      Self.Show;
      ShowWindow(Handle,SW_RESTORE);
      Shell_NotifyIcon(NIM_DELETE, Pointer(pNotifyIcon)); // ��ʾ�������ɾ����������ͼ��
      SetWindowPos(Application.Handle, HWND_TOP, 0, 0, 0, 0, SWP_SHOWWINDOW); // ����������ʾ����

    end;

    WM_RBUTTONUP: PopupMenu_Sys.Popup(mousepos.X, mousepos.Y); // �����˵�

  end;
end;

procedure TFrm_OrderRec.AppMinimize( Sender: TObject );
var
  SysMsg: TMessage;
begin
  Application.Minimize;
  ShowWindow( Handle, sw_Hide );
  SysMsg.Msg := Handle;
  SysMsg.WParam := SC_MINIMIZE;
  SysMsg.LParam := 0;
  SysMsg.Result := 0;
  SysCommand(SysMsg);

end;

end.





