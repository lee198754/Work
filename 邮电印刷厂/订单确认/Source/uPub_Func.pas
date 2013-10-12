unit uPub_Func;

interface

uses Windows,SysUtils,Controls,Classes,Messages,Variants,StdCtrls,ADODB,iComboBox,
     RzListVw,CommCtrl,ComCtrls,Graphics,RzButton,CheckLst,Forms,uPub_Type,RM_System,
     RM_Common, RM_Class,iGrid;


const
  ECM_FIRST               = $1500;      // Edit control messages
  EM_SHOWBALLOONTIP   = ECM_FIRST + 3; // Show a balloon tip associated to the edit control
  EM_HIDEBALLOONTIP   = ECM_FIRST + 4; // Hide any balloon tip associated with the edit control
type
  TFun = (fnHideBalloonTip);
  IpFun=procedure(_Params: array of Integer);
  PFunStruct = ^TFunStruct;
  TFunStruct = record
    m_Fun: IpFun;
    m_Params: array of Integer;
  end;

  TMyThread=class(TThread)
  private
  protected
    procedure Execute;override;
  end;

  _tagEDITBALLOONTIP = packed record
    cbStruct: DWORD;
    pszTitle,
    pszText : PWideChar;
    ttiIcon : integer;
  end;
  TEditBalloonTip = _tagEDITBALLOONTIP;
  TBalloonTipFlags = (btfShow, btfHide);

  function  ExecThread(p: Pointer): DWORD;
  //edit控件气泡提示 (必需引用XPMan)
  procedure EditBalloonTip(_Handle: HWnd; _Text: WideString; _Title: WideString='提示'; _BalloonTipFlags: TBalloonTipFlags=btfShow);
  procedure p_HideBalloonTip(Params: array of Integer);
  function GetSystemUserName: string;
  function StrMD5(CheckStr: string): String;  //MD5加密
  function GetDeclareNumbersList: Boolean; //获取申报编号
  function GetProductCategoryList: Boolean; //获取产品类别
  function GetProductTypeList: Boolean; //获取产品类型
  function GetPostageTypeList: Boolean; //获取邮资图类型
  function FindProductTypeData(ID: integer): TProductType; //查找产品类型数据
  function FindProductTypeID(XH: integer; iClassCode: Integer=0): Integer; //查找产品类型ID
  function FindProductCategoryData(ID: integer): TProductCategory; //查找产品类别数据
  function FindProductCategoryID(XH: integer): Integer; //查找产品类别ID
  function FindProductCategoryCode(XH: integer): Integer; //查找产品类别代码
  function FindPostageTypeData(ID: integer): TPostageType; //查找邮资图数据
  function FindOrderData(sCpbh: string): TOrderData; //查找订单数据
  procedure ClearOrderDataBSTS; //订单数据版式图个数清空
  procedure IncOrderDataBSTS(iApartID: Integer;Num: Integer=1); //自增指定订单数据版式图个数

  function f_GetTXM(_iOrderID,_iOrderType,_iTao: Integer):string;    //获取条形码
  function f_CheckRJHD(RJHD: TArrRJHD):TArrRJHD;      //判断兑奖号码是否重复


  function CbbAdd(cbb: Ti_ComboBox;FType: TProductKind;iID: integer=0): Boolean;    //Ti_ComboBox控件产品类型添加
  function CbbParamAdd(cbb: TComboBox;ParamName: string): Boolean;             //ComboBox控件添加参数
  function CBParamAdd(cb: TCheckListBox;ParamName: string): Boolean;           //TCheckBox控件添加参数
  function CbbPlaceAdd(sf,cs,qx: Ti_ComboBox;Flag: Integer): string;                 //Ti_ComboBox控件省市县添加(Flag: 省=1;市=2;区县=3)

  procedure LVDrawItem(Sender: TRzListView; Item: TListItem; State: TCustomDrawState;
    var DefaultDraw: Boolean);              //LV

  procedure edtEnterFrame(Sender: TObject);  //edt控件下拉框
  procedure edtCookie(Sender: TObject; sRegPath: string='SOFTWARE\YDPrint\Cookie\');  //记录edt对象的Cookie


  //procedure QuickSort(var   A:   array   of   Integer;   iLo,   iHi:   Integer);  //快速排序
  procedure quicksort(var a:array of integer;left: Integer=-2; right:integer= -2);       //快速排序
  function p_MessageBoxDlg(const Text: string; const Caption: string='提示'; Flags: Longint=64): integer;
//  function p_ShowMessage(const ACaption, APrompt: string;  var Value: string;EdtType: Integer=0): Boolean;
  function InputQueryEH(const ACaption, APrompt: string;  var Value: string;EdtType: Integer=0): Boolean; overload;
  function InputQueryEH(const ACaption:string; APrompt: array of string;  var Value: array of string;EdtType: array of Integer): Boolean; overload;
  function f_SelectDlg(const Text: string; const Caption: string; AButtom: string; BButtom: string): Integer;  overload;
  function f_SelectDlg(const Text: string; const Caption: string; aBtnCap: array of const): Integer;  overload;
  function f_ShowSelectCL(sBM: string=''):TArrSelectField;
  function f_ShowSelectCLPCH(sBM: string;iSL: Integer):TArrSelectField;
  function f_ShowSelectSHXX(sCPBH: string=''):TArrSelectField;
  procedure p_SetPrint(Rmrprt:TRMReport;sName, sValue: string);
  procedure ExportExcelFile(FileName: string; bWriteTitle: Boolean; aLv: TListView);  //TListView导出成Excel 

  function CovFileDate(Fd:_FileTime):TDateTime;  //文件日期格式转正常日期格式
  procedure DelFileList(_Path: string;_Size: Int64);   //超过大小按日期顺序删除文件
  procedure DelTempPic;    //超过大小按日期顺序删除临时下载的图稿
  function f_WriteOperationLog(_sOperation: string;_iFlag: Integer=0):Boolean;
//  function Zip(ZipMode,PackSize:Integer;ZipFile,UnzipDir:String):Boolean; //压缩或解压缩文件
  type
    TStgFieldInfo = record
      m_sName: string;
      m_sFieldName: string;
      m_iWidth: Integer;
      m_bLink: Boolean;
    end;

  function f_WriteStgEdit(var AStgEdit:Ti_StgEdit;AADO_Data: TADOQuery;AaStgFieldInfo: array of TStgFieldInfo): Boolean;  //写入StgEdit表格控件


  //从服务端下载图稿,成功返回true不成功则为false
  // sLocalPath为本地文件，绝对路径文件名
  // sServerPath为服务端文件，相对路径文件名
  function p_DownloadFile(const sLocalPath, sServerPath: string): boolean;

  //存入兑奖号段数组
  function SetLabelGroup(iOrderID,iOrderType: Integer;sZH, sRJHDQ, sRJHDZ: string): Boolean;
  //兑奖号段数组写入DO_CartonLableGroupNum表
  procedure p_WriteGroup(iCartonID,iOrderID,iOrderType: Integer; sZH,sRJHDQ,sRJHDZ: string);



implementation

uses
  uDM_DataBase,IdHashMessageDigest, Registry, PubStr, DB,
  uFrm_Select, uFrm_SelectDlg, U_FileMd5,
  NetDataDef,FileClientDll,InitSock, uPub_Text,uDDMX_DZX;

var
  EdtHanle: HWND;
  FunStruct: TFunStruct;

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

function GetSystemUserName: string;
var
 arr: array[0..254] of Char;
 d: DWORD;
begin
  d := SizeOf(arr);
  GetUserName(arr, d);
  Result := arr; 
end;

function  ExecThread(p: Pointer): DWORD;
var
//  FunStruct1: TFunStruct;
  Ip: IpFun;
//  i: integer;
begin
  Result := 0;
  //Ip := PFunStruct(p);
//  FunStruct1 := TFunStruct(p^);
//  Ip := PFunStruct(p).m_Fun;                                           //传参有错
//  Ip(PFunStruct(p).m_Params);
  Ip := FunStruct.m_Fun;
  Ip(FunStruct.m_Params);
//  FunStruct1.m_Fun([]);
end;

procedure EditBalloonTip(_Handle: HWnd; _Text: WideString; _Title: WideString; _BalloonTipFlags: TBalloonTipFlags);
var
  ebt: TEditBalloonTip;
  PFun: PFunStruct;
//  Fun: TFunStruct;
  ThreadID: DWORD;
begin
  with ebt do
  begin
    cbStruct := SizeOf(ebt);
    pszTitle := PWideChar(_Title);
    pszText := PWideChar(_Text);
    ttiIcon := 1;      {NONE:0;INFO:1;WARNING:2;ERROR:3}
  end;
  if _BalloonTipFlags = btfShow then
  begin
    SendMessage(_Handle,EM_SHOWBALLOONTIP,0,Longint(@ebt));
    //PFun.m_Fun := @p_HideBalloonTip;
    //SetLength(PFun.m_Params,2);
    FunStruct.m_Fun := @p_HideBalloonTip;
    SetLength(FunStruct.m_Params,2);
    FunStruct.m_Params[0] := _Handle;
    FunStruct.m_Params[1] := 5000;
    PFun := @FunStruct;
    EdtHanle := _Handle;
    //PFun.m_Params[0] := _Handle;
    //PFun.m_Params[1] := 5000;
    CreateThread(nil, 0, @ExecThread,PFun, 0, ThreadID);
    //TMyThread.Create(False);
  end else
  if _BalloonTipFlags = btfHide then
    SendMessage(_Handle,EM_HIDEBALLOONTIP,0,Longint(@ebt));

end;

function StrMD5(CheckStr: string): String;
var
  MyMD5:   TIdHashMessageDigest5;
begin
  MyMD5:=TIdHashMessageDigest5.Create;
  Result:=MyMD5.AsHex(MyMD5.HashValue(CheckStr));
  MyMD5.Free;
end;

function p_MessageBoxDlg(const Text: string; const Caption: string; Flags: Longint): integer;
begin
  Result := Application.MessageBox(PChar(Text),PChar(Caption),Flags);
end;

function f_SelectDlg(const Text: string; const Caption: string; AButtom: string; BButtom: string): Integer;
begin
    Frm_SelectDlg := TFrm_SelectDlg.Create(nil);
    Frm_SelectDlg.Caption := Caption;
    Frm_SelectDlg.lab_Text.Caption := Text;
    Frm_SelectDlg.btn_A.Caption := AButtom;
    Frm_SelectDlg.btn_B.Caption := BButtom;
    if Frm_SelectDlg.btn_B.Left+ Frm_SelectDlg.btn_B.Width > Frm_SelectDlg.lab_Text.Left+ Frm_SelectDlg.lab_Text.Width then
      Frm_SelectDlg.Width := Frm_SelectDlg.btn_B.Left+ Frm_SelectDlg.btn_B.Width + 50
    else
      Frm_SelectDlg.Width := Frm_SelectDlg.lab_Text.Width + 50;
    Result := Frm_SelectDlg.ShowModal;
    Frm_SelectDlg.Free;

end;

function f_SelectDlg(const Text: string; const Caption: string; aBtnCap:array of const): Integer;
const
  c_BtnTop = 64;
var
  i,n: Integer;
  aBtn: array of TRzButton;
begin
    Frm_SelectDlg := TFrm_SelectDlg.Create(nil);
    Frm_SelectDlg.Caption := Caption;
    Frm_SelectDlg.lab_Text.Caption := Text;
    Frm_SelectDlg.btn_A.Hide;
    Frm_SelectDlg.btn_B.Hide;
    for i := 0 to Length(aBtnCap) -1 do
    begin
      SetLength(aBtn,i+1);
      aBtn[i] :=TRzButton.Create(Frm_SelectDlg);
      aBtn[i].Caption := aBtnCap[i].VPChar;
      aBtn[i].Tag := i+1;
      aBtn[i].OnClick := Frm_SelectDlg.btnClick;
      aBtn[i].Parent := Frm_SelectDlg;
      aBtn[i].Top := c_BtnTop;
      case i of
        0:aBtn[i].Left := 100;
      else
        aBtn[i].Left := aBtn[i-1].Left + aBtn[i-1].Left+50;
      end;

    end;

    n:= Length(aBtn)-1;
    if aBtn[n].Left+  aBtn[n].Width > Frm_SelectDlg.lab_Text.Left+ Frm_SelectDlg.lab_Text.Width then
      Frm_SelectDlg.Width :=  aBtn[n].Left+  aBtn[n].Width + 50
    else
      Frm_SelectDlg.Width := Frm_SelectDlg.lab_Text.Width + 50;
    Result := Frm_SelectDlg.ShowModal;
    Frm_SelectDlg.Free;

end;


function InputQueryEH(const ACaption, APrompt: string;
  var Value: string;EdtType: Integer=0): Boolean;
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := False;
  Form := TForm.Create(Application);
  with Form do
    try
      Font.Name := '新宋体';
      Font.Charset := GB2312_CHARSET;
      Font.Size := 9;
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      Position := poScreenCenter;
      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        Caption := APrompt;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
        WordWrap := True;
      end;
      Edit := TEdit.Create(Form);
      with Edit do
      begin
        Parent := Form;
        Left := Prompt.Left;
        Top := Prompt.Top + Prompt.Height + 5;
        Width := MulDiv(164, DialogUnits.X, 4);
        MaxLength := 255;
        Text := Value;
        case EdtType of
          0:PasswordChar := #0;
          1:PasswordChar := '*';
        end;
        SelectAll;
      end;
      ButtonTop := Edit.Top + Edit.Height + 15;
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := '确定';
        ModalResult := mrOk;
        Default := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := '取消';
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), Edit.Top + Edit.Height + 15,
          ButtonWidth, ButtonHeight);
        Form.ClientHeight := Top + Height + 13;          
      end;
      if ShowModal = mrOk then
      begin
        Value := Edit.Text;
        Result := True;
      end;
    finally
      Form.Free;
    end;
end;

function InputQueryEH(const ACaption:string; APrompt: array of string;
  var Value: array of string;EdtType: array of Integer): Boolean;
var
  Form: TForm;
  Prompt: array of TLabel;
  Edit: array of TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
  i: Integer;
begin
  Result := False;
  Form := TForm.Create(Application);
  with Form do
    try
      Font.Name := '新宋体';
      Font.Charset := GB2312_CHARSET;
      Font.Size := 9;
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      Position := poScreenCenter;
      SetLength(Prompt,Length(APrompt));
      SetLength(Edit,Length(APrompt));
      for i := 0 to Length(APrompt)-1 do
      begin
        SetLength(Prompt,Length(APrompt));
        Prompt[i] := TLabel.Create(Form);
        with Prompt[i] do
        begin
          Parent := Form;
          Caption := APrompt[i];
          if i = 0 then
          begin
            Left := MulDiv(8, DialogUnits.X, 4);
            Top := MulDiv(8, DialogUnits.Y, 8);
          end else
          begin
            Left := Edit[i-1].Left;
            Top := Edit[i-1].Top + Edit[i-1].Height + 10;
          end;
          Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
          WordWrap := True;
        end;
        Edit[i] := TEdit.Create(Form);
        with Edit[i] do
        begin
          Parent := Form;
          Left := Prompt[i].Left;
          Top := Prompt[i].Top + Prompt[i].Height + 5;
          Width := MulDiv(164, DialogUnits.X, 4);
          MaxLength := 255;
          Text := Value[i];
          case EdtType[i] of
            0:PasswordChar := #0;
            1:PasswordChar := '*';
          end;
          SelectAll;
        end;
      end;
      ButtonTop := Edit[Length(Edit)-1].Top + Edit[Length(Edit)-1].Height + 15;
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := '确定';
        ModalResult := mrOk;
        Default := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := '取消';
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), Edit[Length(Edit)-1].Top + Edit[Length(Edit)-1].Height + 15,
          ButtonWidth, ButtonHeight);
        Form.ClientHeight := Top + Height + 13;          
      end;
      if ShowModal = mrOk then
      begin
        for i := 0 to Length(Edit) -1 do
          Value[i] := Edit[i].Text;
        Result := True;
      end;
    finally
      Form.Free;
    end;
end;

procedure quicksort(var a:array of integer;left: Integer=-2; right:integer= -2);
var
i,j,povit :Integer;
begin
  if left = -2 then
    i := 0
  else
    i := left;
  if right = -2 then
    j := Length(a) -1
  else
    j := right;
  povit := a[i];
  if(i<j) then begin
     while(i<j) do begin
       while((i<j) and (a[j]>=povit)) do
          dec(j);
       if(i<j) then begin
          a[i]:=a[j];
          inc(i);
       end;
       while((i<j) and (a[i]<=povit)) do
          inc(i);
       if(i<j) then begin
          a[j]:=a[i];
          dec(j);
       end;
     end;
     a[i]:=povit;
     quicksort(a,left,i-1);
     quicksort(a,i+1,right);
  end;
end;

function FindProductTypeData(ID: integer): TProductType;
var
  i: integer;
begin
//  Result := nil;
  for i := 0 to Length(ProductType) -1 do
  begin
    if ProductType[i].m_iID = ID then
    begin
      Result := ProductType[i];
      Break;
    end;
  end;
end;

function FindProductTypeID(XH: integer; iClassCode: Integer): Integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to Length(ProductType) -1 do
  begin
    if ProductType[i].m_rProductCategory.m_iClassCode = iClassCode then
    begin
      if ProductType[i].m_iXH = XH then
      begin
        Result := ProductType[i].m_iID;
        Break;
      end;
    end;
  end;
  if (Result = -1) and (iClassCode = 0) then
  begin
    for i := 0 to Length(ProductType) -1 do
    begin
      if ProductType[i].m_iXH = XH then
      begin
        Result := ProductType[i].m_iID;
        Break;
      end;
    end;

  end;
end;

function FindProductCategoryData(ID: integer): TProductCategory;
var
  i: integer;
begin
//  Result := nil;
  for i := 0 to Length(ProductCategory) -1 do
  begin
    if ProductCategory[i].m_iID = ID then
    begin
      Result := ProductCategory[i];
      Break;
    end;
  end;
end;

function FindProductCategoryID(XH: integer): Integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to Length(ProductCategory) -1 do
  begin
    if ProductCategory[i].m_iXH = XH then
    begin
      Result := ProductCategory[i].m_iID;
      Break;
    end;
  end;
end;

function FindProductCategoryCode(XH: integer): Integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to Length(ProductCategory) -1 do
  begin
    if ProductCategory[i].m_iXH = XH then
    begin
      Result := ProductCategory[i].m_iClassCode;
      Break;
    end;
  end;
end;

function FindPostageTypeData(ID: integer): TPostageType; //查找邮资图数据
var
  i: integer;
begin
//  Result := nil;
  for i := 0 to Length(PostageType) -1 do
  begin
    if PostageType[i].m_iID = ID then
    begin
      Result := PostageType[i];
      Break;
    end;
  end;
end;

function FindOrderData(sCpbh: string): TOrderData; //查找订单数据
var
  i: integer;
begin
  for i := 0 to Length(OrderData) -1 do
  begin
    if OrderData[i].m_sCPBH = sCpbh then
    begin
      Result := OrderData[i];
      Break;
    end;
  end;
end;

procedure ClearOrderDataBSTS; //订单数据版式图个数清空
var
  i: integer;
begin
  for i := 0 to Length(OrderData) -1 do
  begin
    OrderData[i].m_iBSTS := 0;
  end;
end;

procedure IncOrderDataBSTS(iApartID: Integer;Num: Integer=1); //订单数据版式图个数自增
var
  i: integer;
begin
  for i := 0 to Length(OrderData) -1 do
  begin
    if OrderData[i].m_iApartID = iApartID then
    begin
      OrderData[i].m_iBSTS := OrderData[i].m_iBSTS+Num;
      Break;
    end;
  end;
end;


function GetDeclareNumbersList: Boolean; //获取申报编号
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
  iLen: integer;
begin
  Result := False;
  ADO_Rec := nil;
  try
    sSqlData := 'Select * from BI_DeclareNumbers Order By F_iID';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
    SetLength(aDeclareNumbers,0);
    ADO_Rec.First;
    iLen := 0;
    while not ADO_Rec.Eof do
    begin
      SetLength(aDeclareNumbers,iLen+1);
      aDeclareNumbers[iLen].m_iID := ADO_Rec.FieldByName('F_iID').AsInteger;;
      aDeclareNumbers[iLen].m_sCode := ADO_Rec.FieldByName('F_sCode').AsString;;
      aDeclareNumbers[iLen].m_sPlaceName := ADO_Rec.FieldByName('F_sPlaceName').AsString;
      aDeclareNumbers[iLen].m_iFlag := ADO_Rec.FieldByName('F_iFlag').AsInteger;
      inc(iLen);
      ADO_Rec.Next;
    end;
    Result := True;
  finally
    if Assigned(ADO_Rec) then
      ADO_Rec.Free;
  end;          
end;


function GetProductCategoryList: Boolean;
var
  ADO_Rec: TADOQuery;
  iLen: Integer;
begin
  Result := False;
  ADO_Rec := TADOQuery.Create(nil);
  try
    DM_DataBase.GetTableData(ADO_Rec,'Set_ProductCategory','1=1 order by F_iSort');
    if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
    begin
      SetLength(ProductCategory,0);
      ADO_Rec.First;
      while not ADO_Rec.Eof do
      begin
        iLen := Length(ProductCategory);
        SetLength(ProductCategory,iLen+1);
        ProductCategory[iLen].m_iID := ADO_Rec.FieldByName('F_iID').AsInteger;;
        ProductCategory[iLen].m_iSort := ADO_Rec.FieldByName('F_iSort').AsInteger;;
        ProductCategory[iLen].m_sClassName := ADO_Rec.FieldByName('F_sClassName').AsString;
        ProductCategory[iLen].m_iClassCode := ADO_Rec.FieldByName('F_iClassCode').AsInteger;
        ADO_Rec.Next;
      end;
      Result := True;
    end;
  except
    on E: Exception do
    begin
      ADO_Rec := nil;
      Application.MessageBox(PChar('错误:'+E.message),'提示',MB_ICONINFORMATION)
    end;
  end;
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;


end;

function GetProductTypeList: Boolean;
var
  ADO_Rec: TADOQuery;
  iLen: Integer;
  iProductCategoryID: Integer;
begin
  Result := False;
  ADO_Rec := TADOQuery.Create(nil);
  try
    DM_DataBase.GetTableData(ADO_Rec,'Set_ProductType','1=1 order by F_iSort');
    if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
    begin
      SetLength(ProductType,0);
      ADO_Rec.First;
      while not ADO_Rec.Eof do
      begin
        iLen := Length(ProductType);
        SetLength(ProductType,iLen+1);
        ProductType[iLen].m_iID := ADO_Rec.FieldByName('F_iID').AsInteger;;
        ProductType[iLen].m_iSort := ADO_Rec.FieldByName('F_iSort').AsInteger;;
        ProductType[iLen].m_sTypeName := ADO_Rec.FieldByName('F_sTypeName').AsString;
        ProductType[iLen].m_sTypeCode := ADO_Rec.FieldByName('F_sTypeCode').AsString;
        ProductType[iLen].m_iFJNJBZ := ADO_Rec.FieldByName('F_tiFJNJBZ').AsInteger;
        iProductCategoryID :=  ADO_Rec.FieldByName('F_iProductCategoryID').AsInteger;
        ProductType[iLen].m_rProductCategory := FindProductCategoryData(iProductCategoryID);
        ADO_Rec.Next;
      end;
      Result := True;;
    end;
  except
    on E: Exception do
    begin
      ADO_Rec := nil;
      Application.MessageBox(PChar('错误:'+E.message),'提示',MB_ICONINFORMATION)
    end;
  end;          
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

end;

function GetPostageTypeList: Boolean;
var
  ADO_Rec: TADOQuery;
  iLen: Integer;
  iProductTypeID, iProductCategoryID: Integer;
begin
  Result := False;
  ADO_Rec := TADOQuery.Create(nil);
  try
    DM_DataBase.GetTableData(ADO_Rec,'Set_PostageType','1=1 order by F_iSort');
    if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
    begin
      SetLength(PostageType,0);
      ADO_Rec.First;
      if not GetProductCategoryList then Exit;
      if not GetProductTypeList then Exit;
      while not ADO_Rec.Eof do
      begin
        iLen := Length(PostageType);
        SetLength(PostageType,iLen+1);
        PostageType[iLen].m_iID := ADO_Rec.FieldByName('F_iID').AsInteger;;
        PostageType[iLen].m_iSort := ADO_Rec.FieldByName('F_iSort').AsInteger;;
        PostageType[iLen].m_sNF := ADO_Rec.FieldByName('F_sNF').AsString;
        PostageType[iLen].m_sYZTMC := ADO_Rec.FieldByName('F_sYZTMC').AsString;
        PostageType[iLen].m_sMz := ADO_Rec.FieldByName('F_sMz').AsString;
        iProductTypeID := ADO_Rec.FieldByName('F_iProductTypeID').AsInteger;
        PostageType[iLen].m_rProductType := FindProductTypeData(iProductTypeID);
        iProductCategoryID :=  ADO_Rec.FieldByName('F_iProductCategoryID').AsInteger;
        PostageType[iLen].m_rProductCategory := FindProductCategoryData(iProductCategoryID);
        ADO_Rec.Next;
      end;
      Result := True;;
    end;
  except
    on E: Exception do
    begin
      ADO_Rec := nil;
      Application.MessageBox(PChar('错误:'+E.message),'提示',MB_ICONINFORMATION)
    end;
  end;          
  if Assigned(ADO_Rec) then
    ADO_Rec.Free;

end;

function CbbAdd(cbb: Ti_ComboBox;FType: TProductKind;iID: integer=0): Boolean;
var
  i,j,n: integer;
begin
  n := cbb.Items.Count;
  Result := False;
  j := 0;
  case FType of
    pkProductCategory:
      begin
//        if GetProductCategoryList then
        begin
          for i := 0 to  Length(ProductCategory) -1 do
          begin
            cbb.Items.Add(ProductCategory[i].m_sClassName);
            ProductCategory[i].m_iXH := n+j;
            inc(j)
          end;
          cbb.ItemIndex := -1;
        end;
      end;
   pkProductType:
     begin
//       if GetProductTypeList then
       begin
         for i := 0 to  Length(ProductType) -1 do
         begin
           ProductType[i].m_iXH := -2;
           if ProductType[i].m_rProductCategory.m_iID = iID then
           begin
             cbb.Items.Add(ProductType[i].m_sTypeName);
             ProductType[i].m_iXH := n+j;
             inc(j);
           end;
         end;
         cbb.ItemIndex := -1;
       end;
     end;
  end;
  Result := True;
end;

function CbbParamAdd(cbb: TComboBox;ParamName: string): Boolean;    //ComboBox控件添加参数
var
  ADO_Rec: TADOQuery;
  sSqlData,sParam1: string;
begin
  Result := False;
  sSqlData := 'Select * from Set_ParamList where F_sName=''%s'' ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[ParamName]);
  cbb.Clear;
  while not ADO_Rec.Eof do
  begin
    sParam1 := ADO_Rec.FieldByName('F_sParam1').AsString;
    if sParam1 <> '' then
      cbb.Items.Add(sParam1);
    ADO_Rec.Next;
  end;
  ADO_Rec.Free;
  Result := True;
end;

function CBParamAdd(cb: TCheckListBox;ParamName: string): Boolean;    //TCheckBox控件添加参数
var
  ADO_Rec: TADOQuery;
  sSqlData,sParam1: string;
begin
  Result := False;
  sSqlData := 'Select * from Set_ParamList where F_sName=''%s'' ';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[ParamName]);
  cb.Clear;
  while not ADO_Rec.Eof do
  begin
    sParam1 := ADO_Rec.FieldByName('F_sParam1').AsString;
    if sParam1 <> '' then
      cb.Items.Add(sParam1);
    ADO_Rec.Next;
  end;
  ADO_Rec.Free;
  Result := True;
end;

function CbbPlaceAdd(sf,cs,qx: Ti_ComboBox;Flag: Integer): string;                 //Ti_ComboBox控件省市县添加(Flag: 省=1;市=2;区县=3)
var
  sCode: string;
  n, i: Integer;
begin
  Result := '';
  case Flag of
    1:
      begin
        sf.Clear;
        sf.Items.Add('--全部--');
      end;
    2:
      begin
        cs.Clear;
        cs.Items.add('--全部--');
        cs.ItemIndex := 0;
        if sf.ItemIndex < 1 then
        begin
          qx.Clear;
          qx.Items.add('--全部--');
          qx.ItemIndex := 0;
          Exit;
        end;
        for i := 0 to Length(aDeclareNumbers) -1 do
        begin
          if aDeclareNumbers[i].m_sPlaceName = sf.Text then
            sCode := aDeclareNumbers[i].m_sCode;
        end;
      end;
    3:
      begin
        qx.Clear;
        qx.Items.add('--全部--');
        qx.ItemIndex := 0;
        if cs.ItemIndex < 1 then
        begin
          for i := 0 to Length(aDeclareNumbers) -1 do
          begin
            if aDeclareNumbers[i].m_sPlaceName = sf.Text then
              sCode := aDeclareNumbers[i].m_sCode;
          end;
          Result := sCode;
          Exit;
        end;
        for i := 0 to Length(aDeclareNumbers) -1 do
        begin
          if aDeclareNumbers[i].m_sPlaceName = cs.Text then
            sCode := aDeclareNumbers[i].m_sCode;
        end;
      end;
  end;
  for i := 0 to Length(aDeclareNumbers) -1 do
  begin
    case Flag of
      1:
        begin
          if aDeclareNumbers[i].m_iFlag = 1 then
            sf.Items.add(aDeclareNumbers[i].m_sPlaceName);
        end;
      2:
        begin
          if (Copy(aDeclareNumbers[i].m_sCode,1,Length(sCode)) = sCode) and (aDeclareNumbers[i].m_iFlag =2) then
            cs.Items.add(aDeclareNumbers[i].m_sPlaceName);
        end;
      3:
        begin
          if (Copy(aDeclareNumbers[i].m_sCode,1,Length(sCode)) = sCode) and (aDeclareNumbers[i].m_iFlag =3) then
            qx.Items.add(aDeclareNumbers[i].m_sPlaceName);
        end;
    end;
  end;
  case Flag of
    1:
      begin
        sf.ItemIndex := 0;
        cs.ItemIndex := 0;
        qx.ItemIndex := 0;
      end;
    2:
      begin
        cs.ItemIndex := 0;
        qx.ItemIndex := 0;
      end;
    3: qx.ItemIndex := 0;
  end;
  Result := sCode;
end;

procedure LVDrawItem(Sender: TRzListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
var
  BoundRect, Rect: TRect;
  i: integer;
  TextFormat: Word;
  LV: TRzListView;
  procedure Draw_CheckBox_ImageList(r: TRect; aCanvas: TCanvas; Checked: Boolean);
  var
    R1: TRect;
  begin
    if Sender.Checkboxes then
    begin
      aCanvas.Pen.Color := clBlack;
      aCanvas.Pen.Width := 1;
      //画CheckBox外框

      aCanvas.Rectangle(r.Left + 4, r.Top + 5, r.Left + 14, r.Bottom - 5);
      if Checked then
      begin //画CheckBox的勾
        aCanvas.Pen.Color := clRed;
        aCanvas.Pen.Width := 2;
        aCanvas.MoveTo(r.Left + 6, r.Top + 8);
        aCanvas.LineTo(r.Left + 8, r.Top + 13);
        aCanvas.LineTo(r.Left + 18, r.Top + 4);
        aCanvas.Pen.Width := 1;
        aCanvas.Pen.Color := clBlack;
      end;
      aCanvas.Pen.Width := 1;
    end;
    //开始画图标
    if (Item.ImageIndex > -1)and(LV.SmallImages <>nil) then
    begin
    //获取图标的RECT
      if Boolean(ListView_GetSubItemRect(sender.Handle, item.Index, 0, LVIR_ICON, @R1)) then
      begin
        LV.SmallImages.Draw(LV.Canvas, R1.Left, R1.Top, Item.ImageIndex);
      end;
    end;
  end;
begin
  LV := Sender;
  BoundRect := Item.DisplayRect(drBounds);
  InflateRect(BoundRect, -1, 0);
  if Item.Selected then
  begin
    if cdsFocused in State then
    begin
      LV.Canvas.Brush.Color := $00ECCCB9; //  //clHighlight;
//      LV.Canvas.Font.Color := clBtnText; //clHighlightText;
    end
    else
    begin
      LV.Canvas.Brush.Color := $00F8ECE5; //clSilver;
//      LV.Canvas.Font.Color := clBtnText;
    end;
  end
  else
  begin
//    LV.Canvas.Brush.Color := clWindow;
//    LV.Canvas.Font.Color := clWindowText;
  end;
 
  LV.Canvas.FillRect(BoundRect); //初始化背景
 
  for i := 0 to LV.Columns.Count - 1 do
  begin
  //获取SubItem的Rect
    ListView_GetSubItemRect(LV.Handle, Item.Index, i, LVIR_LABEL, @Rect);
    case LV.Columns[i].Alignment of
      taLeftJustify:
        TextFormat := 0;
      taRightJustify:
        TextFormat := DT_RIGHT;
      taCenter:
        TextFormat := DT_CENTER;
    end;
    case i of
      0: //画Caption
        begin
          Draw_CheckBox_ImageList(BoundRect, LV.Canvas, Item.Checked);

          InflateRect(Rect, -3, 0); //向后移3个像素,避免被后面画线框时覆盖
          DrawText(
            LV.Canvas.Handle,
            PCHAR(Item.Caption),
            Length(Item.Caption),
            Rect,
            DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS or TextFormat);
        end;
      1..MaxInt: //画Subitems[i]
        begin
          if i - 1 <= Item.SubItems.Count - 1 then
            DrawText(
              LV.Canvas.Handle,
              PCHAR(Item.SubItems[i - 1]),
              Length(Item.SubItems[i - 1]),
              Rect,
              DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS or TextFormat);
        end;
    end;
 
  end;
 
 
  LV.Canvas.Brush.Color := clWhite;
 
  if Item.Selected then //画选中条外框
  begin
    if cdsFocused in State then
      LV.Canvas.Brush.Color := $00DAA07A // $00E2B598; //clHighlight;
    else
      LV.Canvas.Brush.Color := $00E2B598; //$00DAA07A // clHighlight;
    LV.Canvas.FrameRect(BoundRect); // DrawFocusRect(Item.DisplayRect(drBounds)); //
  end;
 
  DefaultDraw := False; //True;//cdsSelected in State;
 
  with Sender.Canvas do
    if Assigned(Font.OnChange) then Font.OnChange(Font);
 
end;

procedure edtEnterFrame(Sender: TObject);
begin

end;

procedure edtCookie(Sender: TObject; sRegPath: string);
var
  MyReg: TRegistry;
  i,n: integer;
  ItemList,str: string;
  edt: TEdit;
  List: TStringList;
begin
  edt := TEdit(Sender);
  MyReg := TRegistry.Create;
  MyReg.RootKey := HKEY_LOCAL_MACHINE;
  MyReg.OpenKey(sRegPath,True);
  if MyReg.ValueExists(edt.Name) then
    ItemList := MyReg.ReadString(edt.Name);
  List := TStringList.Create;
  n := PosNum(ItemList,';');
  for i := 1 to n do
  begin
    str := PosCopy(ItemList,';',i);
    if str <> '' then
      List.Add(str)
  end;
  n := List.IndexOf(edt.Text);
  if n >= 0 then
    List.Delete(n);
  List.Insert(0,edt.Text);
  ItemList := '';
  for i := 0 to 99 do
  begin
    if i < List.Count then
      ItemList := ItemList + List.Strings[i] + ';';
  end;
  MyReg.WriteString(edt.Name, ItemList);
  MyReg.CloseKey;
  MyReg.Free;
end;

{ TMyThread }

procedure TMyThread.Execute;
begin
  inherited;
  FunStruct.m_Fun(FunStruct.m_Params);
  //p_HideBalloonTip([EdtHanle,5000]);

end;

procedure p_HideBalloonTip(Params: array of Integer);
var
  h: HWnd;
begin
  Sleep(Params[1]);
  h:= Params[0];
  SendMessage(h,EM_HIDEBALLOONTIP,0,0);
end;

function f_ShowSelectCL(sBM: string): TArrSelectField;
begin
  Result := nil;
  Frm_Select := TFrm_Select.Create(Application);
  Frm_Select.Caption := '选择材料';
  Frm_Select.cbb_type.Clear;
  Frm_Select.cbb_type.Add('材料编号');
  Frm_Select.cbb_type.Add('材料名称');
  Frm_Select.cbb_type.ItemIndex := 0;
  Frm_Select.edt_value.Text := sBM;
  Frm_Select.vSqlData := 'select * from BI_MatlManage where F_sCLBH like ''%%%s%%'' and F_sCLMC like ''%%%s%%'' order by F_sCLBH ';   //
  SetLength(Frm_Select.vaSelectField,7);
  Frm_Select.vaSelectField[0].m_sName := '材料编号';
  Frm_Select.vaSelectField[0].m_sField := 'F_sCLBH';
  Frm_Select.vaSelectField[0].m_iWidth := 80;
  Frm_Select.vaSelectField[1].m_sName := '材料名称';
  Frm_Select.vaSelectField[1].m_sField := 'F_sCLMC';
  Frm_Select.vaSelectField[1].m_iWidth := 120;
  Frm_Select.vaSelectField[2].m_sName := '材料规格';
  Frm_Select.vaSelectField[2].m_sField := 'F_sCLGG';
  Frm_Select.vaSelectField[2].m_iWidth := 80;
  Frm_Select.vaSelectField[3].m_sName := '裁剪规格';
  Frm_Select.vaSelectField[3].m_sField := 'F_sCJGG';
  Frm_Select.vaSelectField[3].m_iWidth := 80;
  Frm_Select.vaSelectField[4].m_sName := '实际价格';
  Frm_Select.vaSelectField[4].m_sField := 'F_nSJJG';
  Frm_Select.vaSelectField[4].m_iWidth := 80;
  Frm_Select.vaSelectField[5].m_sName := '计划价格';
  Frm_Select.vaSelectField[5].m_sField := 'F_nJHJG';
  Frm_Select.vaSelectField[5].m_iWidth := 80;
  Frm_Select.vaSelectField[6].m_sName := '材料单位';
  Frm_Select.vaSelectField[6].m_sField := 'F_sDW';
  Frm_Select.vaSelectField[6].m_iWidth := 60;
  Frm_Select.ShowModal;
  if Frm_Select.vSuccess then
    Result := Frm_Select.vaSelectField;

  Frm_Select.Free;
end;

function f_ShowSelectSHXX(sCPBH: string): TArrSelectField;
begin
  Result := nil;
  Frm_Select := TFrm_Select.Create(Application);
  Frm_Select.Caption := '选择收货信息';
  Frm_Select.cbb_type.Clear;
  Frm_Select.cbb_type.Add('产品编号');
  Frm_Select.cbb_type.ItemIndex := 0;
  Frm_Select.edt_value.Text := sCPBH;
  Frm_Select.vSqlData := 'declare @Param1 varchar(50),@Param2 varchar(50)  set @Param1=''%s'' set @Param2=''%s'' ';
  Frm_Select.vSqlData := Frm_Select.vSqlData + 'select Top 500 F_sJg,F_sCpbh,F_sYztmc,F_sShr,F_sShrdz,F_sShrdh,F_sShrsj from BI_CustomOrderDetails where F_tiCXBZ=0 and F_sCPBH like ''%%''+@Param1 +''%%''  ';   //
  Frm_Select.vSqlData := Frm_Select.vSqlData + ' union all select Top 500 F_sJg,F_sCpbh,F_sYztmc,F_sShr,F_sShrdz,F_sShrdh,F_sShrsj from BI_SellOrderDetails where F_tiCXBZ=0 and F_sCPBH like ''%%''+@Param1 +''%%'' ';
  SetLength(Frm_Select.vaSelectField,7);
  Frm_Select.vaSelectField[0].m_sName := '机构名称';
  Frm_Select.vaSelectField[0].m_sField := 'F_sJg';
  Frm_Select.vaSelectField[0].m_iWidth := 150;
  Frm_Select.vaSelectField[1].m_sName := '产品编号';
  Frm_Select.vaSelectField[1].m_sField := 'F_sCpbh';
  Frm_Select.vaSelectField[1].m_iWidth := 150;
  Frm_Select.vaSelectField[2].m_sName := '邮资图名称';
  Frm_Select.vaSelectField[2].m_sField := 'F_sYztmc';
  Frm_Select.vaSelectField[2].m_iWidth := 100;
  Frm_Select.vaSelectField[3].m_sName := '收货人姓名';
  Frm_Select.vaSelectField[3].m_sField := 'F_sShr';
  Frm_Select.vaSelectField[3].m_iWidth := 60;
  Frm_Select.vaSelectField[4].m_sName := '收货人地址';
  Frm_Select.vaSelectField[4].m_sField := 'F_sShrdz';
  Frm_Select.vaSelectField[4].m_iWidth := 150;
  Frm_Select.vaSelectField[5].m_sName := '收货人电话';
  Frm_Select.vaSelectField[5].m_sField := 'F_sShrdh';
  Frm_Select.vaSelectField[5].m_iWidth := 80;
  Frm_Select.vaSelectField[6].m_sName := '收货人手机';
  Frm_Select.vaSelectField[6].m_sField := 'F_sShrsj';
  Frm_Select.vaSelectField[6].m_iWidth := 80;

  Frm_Select.ShowModal;
  if Frm_Select.vSuccess then
    Result := Frm_Select.vaSelectField;

  Frm_Select.Free;
end;


function f_ShowSelectCLPCH(sBM: string;iSL: integer):TArrSelectField;
  function IsCheck: Boolean;
  var
    iKC: Integer;
    iYQSL: integer;
  begin
    Result := False;
    iYQSL := Frm_Select.vYQSL;
    iKC:= StrToNum(Frm_Select.vaSelectField[5].m_sValue);
    if iKC < iYQSL then
    begin
      p_MessageBoxDlg('所选批次当前库存不足 '+inttostr(iYQSL)+' ,请重新选择!');
      Exit;
    end;
    Result := True;
  end;
begin
  Result := nil;
  Frm_Select := TFrm_Select.Create(Application);
  Frm_Select.Caption := '选择批次';
  Frm_Select.cbb_type.Clear;
  Frm_Select.cbb_type.Add('材料编号');
  Frm_Select.cbb_type.Add('材料名称');
  Frm_Select.cbb_type.ItemIndex := 0;
  Frm_Select.edt_value.Text := sBM;
  Frm_Select.cbb_type.Enabled := False;
  //Frm_Select.cbb_type.Color := clBtnFace;
  Frm_Select.edt_value.ReadOnly := True;
  Frm_Select.edt_value.Color := clBtnFace;
//  Frm_Select.vSqlData := 'select a.F_sPCH,a.F_nSJJG,a.F_nJHJG,b.F_sCLBH,b.F_sCLMC,b.F_sDW,DQKC=(Select sum(a.F_nSL)-sum(F_nSL) from DO_StockOutInfo where F_tiCXBZ=0 and F_sPCH=a.F_sPCH)'
//    +' from DO_StockInInfo a left join BI_MatlManage b on a.F_iXM=1 and a.F_sBM=b.F_sCLBH '
//    +' where a.F_tiCXBZ=0 and b.F_sCLBH like ''%%%s%%'' and b.F_sCLMC like ''%%%s%%''  '
//    +' group by F_sPCH,b.F_sCLBH,b.F_sCLMC,b.F_sDW,a.F_nSJJG,a.F_nJHJG order by a.F_sPCH ';
  Frm_Select.vSqlData := 'select a.PCH,a.SJJG,a.JHJG,a.CLBH,a.CLMC,a.DW,a.KCSL DQKC from v_clkc a where a.CLBH = ''%%%s%%'' and a.CLMC like ''%%%s%%'' ';
  SetLength(Frm_Select.vaSelectField,7);
  Frm_Select.vaSelectField[0].m_sName := '材料编号';
  Frm_Select.vaSelectField[0].m_sField := 'CLBH';
  Frm_Select.vaSelectField[0].m_iWidth := 80;
  Frm_Select.vaSelectField[1].m_sName := '材料名称';
  Frm_Select.vaSelectField[1].m_sField := 'CLMC';
  Frm_Select.vaSelectField[1].m_iWidth := 120;
  Frm_Select.vaSelectField[2].m_sName := '批次号';
  Frm_Select.vaSelectField[2].m_sField := 'PCH';
  Frm_Select.vaSelectField[2].m_iWidth := 80;
  Frm_Select.vaSelectField[3].m_sName := '实际价格';
  Frm_Select.vaSelectField[3].m_sField := 'SJJG';
  Frm_Select.vaSelectField[3].m_iWidth := 80;
  Frm_Select.vaSelectField[4].m_sName := '计划价格';
  Frm_Select.vaSelectField[4].m_sField := 'JHJG';
  Frm_Select.vaSelectField[4].m_iWidth := 80;
  Frm_Select.vaSelectField[5].m_sName := '当前库存';
  Frm_Select.vaSelectField[5].m_sField := 'DQKC';
  Frm_Select.vaSelectField[5].m_iWidth := 80;
  Frm_Select.vaSelectField[6].m_sName := '材料单位';
  Frm_Select.vaSelectField[6].m_sField := 'DW';
  Frm_Select.vaSelectField[6].m_iWidth := 60;
  Frm_Select.vYQSL := iSL;
  @Frm_Select.fIsCheck := @IsCheck;
  Frm_Select.ShowModal;
  if Frm_Select.vSuccess then
    Result := Frm_Select.vaSelectField;

  Frm_Select.Free;
end;

function f_GetTXM(_iOrderID, _iOrderType, _iTao: Integer): string;
var
  sSqlData, sTableName, sTXM: string;
  ADOQ_Rec: TADOQuery;
  iNJBZ: Integer;
begin
  Result := '';
//获取箱签的条码
  try
    sTableName := iif(_iOrderType=0,'BI_CustomOrderDetails','BI_SellOrderDetails');
    sSqlData := 'select min(F_sTXM) TXM from %s a,BI_CartonLable b '
      + ' where a.F_iDetailsID=b.F_iSBID and a.F_iID=%d ';
    ADOQ_Rec := DM_DataBase.OpenQuery(sSqlData,[sTableName,_iOrderID]);
    if Assigned(ADOQ_Rec) and (ADOQ_Rec.RecordCount > 0) and (not ADOQ_Rec.FieldByName('TXM').IsNull)  then
    begin
      Result := ADOQ_Rec.FieldByName('TXM').AsString;
    end else
    begin
      ADOQ_Rec.Free;
      case _iOrderType of
        0:
          begin
            sSqlData := 'select top 1 TXM=(convert(varchar(1),b.F_tiDfbbz)+ '
              +' right(''0000000000''+convert(varchar(10),a.F_iDetailsID),10)+ '
              +' right(a.F_sCPBH,3)+''00001''+a.F_sXzqh) '
              +' from BI_CustomOrderDetails a,BI_CustomOrder b '
              +' where a.F_iCustomID=b.F_iID and a.F_iID=%d ';
          end;
        1:
          begin
            sSqlData := 'select top 1 TXM=(''1''+ '
              +' right(''0000000000''+convert(varchar(10),a.F_iDetailsID),10)+ '
              +' right(a.F_sCPBH,3)+''00001''+a.F_sXzqh) '
              +' BI_SellOrderDetails a,BI_SellOrder b,BI_SellOrderDetails c '
              +' where a.F_iSellID=b.F_iID and a.F_iID=%d ';
          end;
      end;
      ADOQ_Rec := DM_DataBase.OpenQuery(sSqlData,[_iOrderID]);
      if Assigned(ADOQ_Rec) and (ADOQ_Rec.RecordCount > 0) then
      begin
        sTXM := ADOQ_Rec.FieldByName('TXM').AsString;
        if _iTao = 0 then
        begin
          ADOQ_Rec.Free;
          //sSqlData := 'Select 1 from DO_OrderApart where F_tiCXBZ=0 and F_iOrderID=''%d'' and F_tiOrderType=''%d'' and F_tiNJBZ=1 ';
          //ADOQ_Rec := DM_DataBase.OpenQuery(sSqlData,[_iOrderID,_iOrderType]);
          if _iOrderType = 1 then
            sSqlData := 'select 1 from dbo.BI_SellOrderDetails a,Set_PostageType b,dbo.Set_ProductType c  where a.F_iID=%d and a.F_sYZTMC =b.F_sYZTMC and b.F_iProductTypeID=c.F_iID and c.F_tiFJNJBZ=1'
          else
            sSqlData := 'select 1 from dbo.BI_CustomOrderDetails a,Set_PostageType b,dbo.Set_ProductType c  where a.F_iID=%d and a.F_sYZTMC =b.F_sYZTMC and b.F_iProductTypeID=c.F_iID and c.F_tiFJNJBZ=1';
          ADOQ_Rec := DM_DataBase.OpenQuery(sSqlData,[_iOrderID]);
          if Assigned(ADOQ_Rec) and (ADOQ_Rec.RecordCount > 0) then
              sTXM := StrLeft(sTXM,11)+'101' + StrRight(sTXM,9)
          else
          if Copy(sTXM,12,3) = '999' then
              sTXM := StrLeft(sTXM,11)+'001' + StrRight(sTXM,9)
        end;
        Result := sTXM;
      end;

    end;
  finally
    ADOQ_Rec.Free;
  end;
end;

function f_CheckRJHD(RJHD: TArrRJHD):TArrRJHD;      //判断兑奖号码是否重复
var
  sSqlData: string;
  ADO_Rec: TADOQuery;
  i,j,Len: Integer;
begin
  sSqlData := '';
  SetLength(Result,0);
  if Length(RJHD) = 0 then Exit;
  for i := 0 to Length(RJHD) -1 do
  begin
    if (RJHD[i].m_iGroupID = -1) or (RJHD[i].m_sZH = '') or (RJHD[i].m_sRJHDQ = '') or (RJHD[i].m_sRJHDZ = '') then
      Continue;
    for j := 0 to Length(RJHD) -1 do
    begin
      if RJHD[i].m_iApartID = RJHD[j].m_iApartID then Continue;
      if (RJHD[i].m_sZH = RJHD[j].m_sZH) and (RJHD[i].m_sRJHDQ <= RJHD[j].m_sRJHDQ)
        and (RJHD[i].m_sRJHDZ >= RJHD[j].m_sRJHDQ) and (RJHD[i].m_sRJHDQ <= RJHD[j].m_sRJHDZ)
        and (RJHD[i].m_sRJHDZ >= RJHD[j].m_sRJHDZ) then
        begin
          Len := Length(Result);
          SetLength(Result,Len+1);
          Result[Len].m_iID := RJHD[j].m_iID;
          Result[Len].m_sZH := RJHD[j].m_sZH;
          Result[Len].m_sRJHDQ := RJHD[j].m_sRJHDQ;
          Result[Len].m_sRJHDZ := RJHD[j].m_sRJHDZ;
          Result[Len].m_iApartID := RJHD[j].m_iApartID;
          Result[Len].m_iDetailsID := RJHD[j].m_iDetailsID;
          Result[Len].m_sCPBH := RJHD[j].m_sCPBH;
        end;
    end;

  end;


  for i := 0 to Length(RJHD) -1 do
  begin
    if (RJHD[i].m_iGroupID = -1) or (RJHD[i].m_sZH = '') then Continue;
    if sSqlData = '' then
    begin
      sSqlData := 'select a.*,b.F_sCPBH from DO_WorkOrderDetGroupNum a,DO_OrderApart b where a.F_iApartID=b.F_iID'
        +' and IsNull(F_sZH,'''') <> '''' and IsNull(F_sRJHDQ,'''') <> '''' and IsNull(F_sRJHDZ,'''') <> '''' ';
      sSqlData := sSqlData + format(' and (( F_sZH=''%s'' '
        + ' and ( F_sRJHDQ <= right(''000000''+''%s'',6) and F_sRJHDZ >= right(''000000''+''%s'',6) '
        + ' or F_sRJHDQ <= right(''000000''+''%s'',6) and F_sRJHDZ >= right(''000000''+''%s'',6) ) '
        + ' and SubString(b.F_sCPBH,1,2)=''%s'''
        + ' and a.F_iID <> %d)',[RJHD[i].m_sZH,RJHD[i].m_sRJHDQ,RJHD[i].m_sRJHDQ,RJHD[i].m_sRJHDZ,RJHD[i].m_sRJHDZ,Copy(RJHD[i].m_sCPBH,1,2),RJHD[i].m_iID]);
    end else
    begin
      sSqlData := sSqlData + format(' or ( F_sZH=''%s'' '
        + ' and ( F_sRJHDQ <= right(''000000''+''%s'',6) and F_sRJHDZ >= right(''000000''+''%s'',6) '
        + ' or F_sRJHDQ <= right(''000000''+''%s'',6) and F_sRJHDZ >= right(''000000''+''%s'',6) ) '
        + ' and SubString(b.F_sCPBH,1,2)=''%s'''
        + ' and a.F_iID <> %d)',[RJHD[i].m_sZH,RJHD[i].m_sRJHDQ,RJHD[i].m_sRJHDQ,RJHD[i].m_sRJHDZ,RJHD[i].m_sRJHDZ,Copy(RJHD[i].m_sCPBH,1,2),RJHD[i].m_iID]);
    end;
    if Length(sSqlData) > 2000 then
    begin
      sSqlData := sSqlData + ' ) ';
      ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
      if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
      begin
        while not ADO_Rec.Eof do
        begin
          Len := Length(Result);
          SetLength(Result,Len+1);
          Result[Len].m_iID := ADO_Rec.FieldByName('F_iID').AsInteger;
          Result[Len].m_sZH := ADO_Rec.FieldByName('F_sZH').AsString;
          Result[Len].m_sRJHDQ := ADO_Rec.FieldByName('F_sRJHDQ').AsString;
          Result[Len].m_sRJHDZ := ADO_Rec.FieldByName('F_sRJHDZ').AsString;
          Result[Len].m_iApartID := ADO_Rec.FieldByName('F_iApartID').AsInteger;
          Result[Len].m_iDetailsID := ADO_Rec.FieldByName('F_iDetailsID').AsInteger;
          Result[Len].m_sCPBH := ADO_Rec.FieldByName('F_sCPBH').AsString;
          ADO_Rec.Next;
        end;
      end;
      if Assigned(ADO_Rec) then
        ADO_Rec.Free;
      sSqlData := '';
    end;
  end;
  if sSqlData <> '' then
  begin
    sSqlData := sSqlData + ' ) ';
    ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[]);
    if Assigned(ADO_Rec) and (ADO_Rec.RecordCount > 0) then
    begin
      while not ADO_Rec.Eof do
      begin
        Len := Length(Result);
        SetLength(Result,Len+1);
        Result[Len].m_iID := ADO_Rec.FieldByName('F_iID').AsInteger;
        Result[Len].m_sZH := ADO_Rec.FieldByName('F_sZH').AsString;
        Result[Len].m_sRJHDQ := ADO_Rec.FieldByName('F_sRJHDQ').AsString;
        Result[Len].m_sRJHDZ := ADO_Rec.FieldByName('F_sRJHDZ').AsString;
        Result[Len].m_iApartID := ADO_Rec.FieldByName('F_iApartID').AsInteger;
        Result[Len].m_iDetailsID := ADO_Rec.FieldByName('F_iDetailsID').AsInteger;
        Result[Len].m_sCPBH := ADO_Rec.FieldByName('F_sCPBH').AsString;
        ADO_Rec.Next;
      end;
    end;
    if Assigned(ADO_Rec) then
      ADO_Rec.Free;
  end;

end;

procedure p_SetPrint(Rmrprt: TRMReport; sName, sValue: string);
var
  rmMemo: TRMView;
begin
  rmMemo := Rmrprt.FindObject(sName);
  if rmMemo <> nil then
    TRMMemoView(rmMemo).DataField := sValue;

end;

var
  arXlsBegin: array[0..5] of Word = ($809, 8, 0, $10, 0, 0);
  arXlsEnd: array[0..1] of Word = ($0A, 00);
  arXlsString: array[0..5] of Word = ($204, 0, 0, 0, 0, 0);
  arXlsNumber: array[0..4] of Word = ($203, 14, 0, 0, 0);
  arXlsInteger: array[0..4] of Word = ($27E, 10, 0, 0, 0);
  arXlsBlank: array[0..4] of Word = ($201, 6, 0, 0, $17);

procedure ExportExcelFile(FileName: string; bWriteTitle: Boolean;
  aLv: TListView);
var
  i, j: integer;
  Col, row: word;
  s: string;
  aFileStream: TFileStream;

  procedure IncColRow; //增加行列号
  begin
    if Col = aLv.Columns.Count - 1 then
    begin
      Inc(Row);
      Col :=0;
    end
    else
      Inc(Col);
  end;
  
  procedure WriteStringCell(AValue: string);//写字符串数据
  var
    L: Word;
  begin
    L := Length(AValue);
    arXlsString[1] := 8 + L;
    arXlsString[2] := Row;
    arXlsString[3] := Col;
    arXlsString[5] := L;
    aFileStream.WriteBuffer(arXlsString, SizeOf(arXlsString));
    aFileStream.WriteBuffer(Pointer(AValue)^, L);
    IncColRow;
  end;

  procedure WriteIntegerCell(AValue: integer);//写整数
  var
    V: Integer;
  begin
    arXlsInteger[2] := Row;
    arXlsInteger[3] := Col;
    aFileStream.WriteBuffer(arXlsInteger, SizeOf(arXlsInteger));
    V := (AValue shl 2) or 2;
    aFileStream.WriteBuffer(V, 4);
    IncColRow;
  end;
  
  procedure WriteFloatCell(AValue: double);//写浮点数
  begin
    arXlsNumber[2] := Row;
    arXlsNumber[3] := Col;
    aFileStream.WriteBuffer(arXlsNumber, SizeOf(arXlsNumber));
    aFileStream.WriteBuffer(AValue, 8);
    IncColRow;
  end;
  
begin
  if FileExists(FileName) then DeleteFile(PAnsiChar(FileName)); //文件存在，先删除
  aFileStream := TFileStream.Create(FileName, fmCreate);
  Try
    aFileStream.WriteBuffer(arXlsBegin, SizeOf(arXlsBegin));
    Col := 0; Row := 0;
    if bWriteTitle then
    begin
      for i := 0 to aLv.Columns.Count - 1 do
        WriteStringCell(aLv.Columns[i].Caption);
    end;

    for i := 0 to aLv.Items.Count - 1 do
    begin
      for j := 0 to aLv.Columns.Count - 1 do
      begin
        if j = 0 then
          s := aLv.Items[i].Caption
        else
          s := aLv.Items[i].SubItems[j-1];
        WriteStringCell(s);
      end;
    end;
    AFileStream.WriteBuffer(arXlsEnd, SizeOf(arXlsEnd));
  Finally
    AFileStream.Free;
  end;
end;

function CovFileDate(Fd:_FileTime):TDateTime;
{ 转换文件的时间格式 }
var
  Tct:_SystemTime;
  Temp:_FileTime;
begin
  FileTimeToLocalFileTime(Fd,Temp);
  FileTimeToSystemTime(Temp,Tct);
  CovFileDate:=SystemTimeToDateTime(Tct);
end;



procedure DelFileList(_Path: string;_Size: Int64);   //超过大小按日期顺序删除文件
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


procedure DelTempPic;
var
  sTempPath: string;
begin
  sTempPath := GetTempDirectory+c_TempPicPath;
  DelFileList(sTempPath,256*1024*1024);

end;

function f_WriteOperationLog(_sOperation: string;_iFlag: Integer):Boolean;
var
  sSqlData: string;
begin
  sSqlData := 'Insert into Log_UserOperationLog (F_sOperation,F_iFlag, F_dDate,F_iLoginID) values (''%s'',%d,getdate(),%d)';
  Result := DM_DataBase.ExecQuery(sSqlData,[_sOperation,_iFlag,LoginData.m_iLoginID],False);

end;

function p_DownloadFile(const sLocalPath, sServerPath: string): boolean;
var
  RData: Variant;
  s, sFileName, sMd5,sDll: string;
procedure p_WriteResourceFile(const sFile, s: string);
var
  hFile: Cardinal;
begin
  if not DirectoryExists(ExtractFilePath(sFile)) then
    ForceDirectories(ExtractFilePath(sFile));


  if FileExists(sFile) then DeleteFile(sFile);
  hFile := FileCreate(sFile);

  FileWrite(hFile, PChar(s)^, Length(s));
  FileClose(hFile);
end;
begin
  Result := false;
  try
    sFileName := sLocalPath;
    if not Assigned(m_Net) then
    begin
      sDll := ExtractFilePath(Application.ExeName) + c_NetClientDLL;
      if not FileExists(sDll) then Exit;
      m_Net := TFileClientDll.Create('',False,False);
      if not m_Net.p_IsActive then
      if m_Net.p_LinkToServer('', vServicesIP, c_DownLoadPicPort,
        nil, nil, nil, nil, false) <> 0 then
      begin
        m_Net.p_Close;
        exit;
      end;
    end;
    if m_Net.p_YDHK_SendWait('p_Erp_GetFileData', VarArrayOf([c_PicPath+sServerPath, '']), RData, False) then
    begin
      if not VarIsNull(RData[1]) then
      begin
        s := p_VariantToString(RData[1]);
        if s <> '' then
        begin
          p_WriteResourceFile(sFileName, s);
          Result := true;
        end;
      end;
    end;
  except
    sDll := ExtractFilePath(Application.ExeName) + c_NetClientDLL;
    if not FileExists(sDll) then Exit;
    m_Net := TFileClientDll.Create;
    if not m_Net.p_IsActive then
    if m_Net.p_LinkToServer('', vServicesIP, c_DownLoadPicPort,
      nil, nil, nil, nil, false) <> 0 then
    begin
      m_Net.p_Close;
      exit;
    end;
  end;
end;
{
function Zip(ZipMode,PackSize:Integer;ZipFile,UnzipDir:String):Boolean; //压缩或解压缩文件
var
  ziper:TVCLZip;
begin
//函数用法：Zip(压缩模式，压缩包大小，压缩文件，解压目录)
//ZipMode为0：压缩；为1：解压缩　PackSize为0则不分包；否则为分包的大小
  try
    if copy(UnzipDir, length(UnzipDir), 1) = '\' then
      UnzipDir := copy(UnzipDir, 1, length(UnzipDir) - 1); //去除目录后的“\”
    ziper:=TVCLZip.Create(application); //创建zipper
    ziper.DoAll:=true; //加此设置将对分包文件解压缩有效
    ziper.OverwriteMode:=Always;　//总是覆盖模式
    if　PackSize<>0　then　begin　//如果为0则压缩成一个文件，否则压成多文件
      ziper.MultiZipInfo.MultiMode:=mmBlocks;　//设置分包模式
      ziper.MultiZipInfo.SaveZipInfoOnFirstDisk:=True;　//打包信息保存在第一文件中
      ziper.MultiZipInfo.FirstBlockSize:=PackSize;　//分包首文件大小
      ziper.MultiZipInfo.BlockSize:=PackSize;　//其他分包文件大小
    end;
    ziper.FilesList.Clear;
    ziper.ZipName　:=　ZipFile;　//获取压缩文件名
    if　ZipMode=0　then　begin　//压缩文件处理
      ziper.FilesList.Add(UnzipDir+'\*.*');　//添加解压缩文件列表
      Application.ProcessMessages;　//响应WINDOWS事件
      ziper.Zip;　//压缩
    end　else　begin
      ziper.DestDir:=　UnzipDir;　//解压缩的目标目录
      ziper.UnZip;　//解压缩
    end;
    ziper.Free;　//释放压缩工具资源
    Result:=True;　//执行成功
  except
    Result:=False;//执行失败
  end;
end;
   }

function f_WriteStgEdit(var AStgEdit:Ti_StgEdit;AADO_Data: TADOQuery;AaStgFieldInfo: array of TStgFieldInfo): Boolean;
var
  i,n: Integer;
  sFormatString,sFieldName: string;
begin
  Result := False;
  AStgEdit.Clear();
  sFormatString := '';
  for i := 0 to Length(AaStgFieldInfo) -1 do
  begin
    sFormatString := AaStgFieldInfo[i].m_sName + '|';
  end;
  sFormatString := StrLeft(sFormatString,Length(sFormatString)-1);
  AStgEdit.FormatString := sFormatString;
  AStgEdit.RowCount := iif(AADO_Data.RecordCount > 0, AADO_Data.RecordCount +1, 2);
  n := 0;
  AADO_Data.First;
  while not AADO_Data.Eof do
  begin
    for i := 0 to AStgEdit.ColCount -1 do
    begin
      sFieldName := AaStgFieldInfo[i].m_sFieldName;
      if not AaStgFieldInfo[i].m_bLink then
      begin
        AStgEdit.Cells[i,n] := AADO_Data.FieldValues[sFieldName];
      end else
      begin
        if AADO_Data.FieldValues[sFieldName] <> '' then
        begin
          AStgEdit.Cells[i,n] := AADO_Data.FieldValues[sFieldName];
          AStgEdit.CellsLink[i,n] := AADO_Data.FieldValues[sFieldName];
        end else
        begin
          AStgEdit.Cells[i,n] := sFieldName;
          AStgEdit.CellsLink[i,n] := sFieldName;
        end;
      end;
      AStgEdit.Width := AaStgFieldInfo[i].m_iWidth;
    end;
    Inc(n);
    AADO_Data.Next;
  end;
  Result := True;
end;


procedure p_WriteGroup(iCartonID,iOrderID,iOrderType: Integer; sZH,sRJHDQ,sRJHDZ: string);
var
  ADO_Rec: TADOQuery;
  sSqlData: string;
  i: integer;
begin
  sSqlData := 'Select * from DO_CartonLableGroupNum where F_iCartonInfoID=%d';
  ADO_Rec := DM_DataBase.OpenQuery(sSqlData,[iCartonID]);
  SetLabelGroup(iOrderID,iOrderType,sZH,sRJHDQ,sRJHDZ);
  for i := 0 to Length(LabelGroup) -1 do
  begin
    if (LabelGroup[i].m_iOrderID = iOrderID) and (LabelGroup[i].m_iOrderType = iOrderType) then
    begin
      if (LabelGroup[i].m_sZH = '') and (LabelGroup[i].m_sRJHDQ = '') and (LabelGroup[i].m_sRJHDZ = '') then Continue;
      if not ADO_Rec.Eof then
      begin
        ADO_Rec.Edit;
        ADO_Rec.FieldByName('F_sZH').AsString :=  LabelGroup[i].m_sZH;
        ADO_Rec.FieldByName('F_sRJHDQ').AsString :=  LabelGroup[i].m_sRJHDQ;
        ADO_Rec.FieldByName('F_sRJHDZ').AsString :=  LabelGroup[i].m_sRJHDZ;
        ADO_Rec.FieldByName('F_iGroupID').AsInteger :=  LabelGroup[i].m_iGroupID;
        ADO_Rec.FieldByName('F_iCartonInfoID').AsInteger :=  iCartonID;

        ADO_Rec.Post;
        ADO_Rec.Next;
      end else
      begin
        ADO_Rec.Insert;
        ADO_Rec.FieldByName('F_sZH').AsString :=  LabelGroup[i].m_sZH;
        ADO_Rec.FieldByName('F_sRJHDQ').AsString :=  LabelGroup[i].m_sRJHDQ;
        ADO_Rec.FieldByName('F_sRJHDZ').AsString :=  LabelGroup[i].m_sRJHDZ;
        ADO_Rec.FieldByName('F_iGroupID').AsInteger :=  LabelGroup[i].m_iGroupID;
        ADO_Rec.FieldByName('F_iCartonInfoID').AsInteger :=  iCartonID;
        ADO_Rec.Post;
        ADO_Rec.Next;
      end;
    end;
  end;
  while not ADO_Rec.Eof do
  begin
    ADO_Rec.Delete
  end;
end;

function SetLabelGroup(iOrderID,iOrderType: Integer; sZH, sRJHDQ,
  sRJHDZ: string): Boolean;
var
  i, j, len: integer;
  b: Boolean;
begin
  Result := False;
  for i := 0 to Length(LabelGroup) -1 do
  begin
    if (LabelGroup[i].m_iOrderID = iOrderID) and  (LabelGroup[i].m_iOrderType = iOrderType) then
    begin
      LabelGroup[i].m_iOrderID := -1;
      LabelGroup[i].m_iOrderType := -1;
    end;
  end;
  for i := 1 to PosNum(sZH,',') + 1 do
  begin
    Len := Length(LabelGroup);
    for j := 0 to  Len -1 do
    begin
      b := False;
      if LabelGroup[j].m_iOrderID = -1 then
      begin
        LabelGroup[j].m_sZH        := PosCopy(sZH,',',i);
        LabelGroup[j].m_sRJHDQ     := PosCopy(sRJHDQ,',',i);
        LabelGroup[j].m_sRJHDZ     := PosCopy(sRJHDZ,',',i);
        LabelGroup[j].m_iOrderID   := iOrderID;
        LabelGroup[j].m_iOrderType := iOrderType;
        b := True;
        Break;
      end;
    end;
    if b then Continue;
    SetLength(LabelGroup,Len+1);
    LabelGroup[Len].m_sZH        := PosCopy(sZH,',',i);
    LabelGroup[Len].m_sRJHDQ     := PosCopy(sRJHDQ,',',i);
    LabelGroup[Len].m_sRJHDZ     := PosCopy(sRJHDZ,',',i);
    LabelGroup[Len].m_iOrderID   := iOrderID;
    LabelGroup[Len].m_iOrderType := iOrderType;
  end;
  Result := True;
end;

end.




