// ************************************************************************ //
// 在文件中的类声明从 WSDL 文件中读取数据生成, 描述如下:
// WSDL     : http://211.156.193.139/PostWebService/services/PostService?wsdl
// 编码     : UTF-8
// 版本     : 1.0
// (2011/10/20 3:23:47 - 1.33.2.5)
// ************************************************************************ //

unit PostService;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // 下列类型, 提交至 WSDL 文件没有表现在文件中.
  // 它们是其他类型表示或归类的任何一个别名[@]
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // 指示错误的 WSDL 文件声明失败或或导入概要类.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"
  // !:int             - "http://www.w3.org/2001/XMLSchema"


  ArrayOfString = array of WideString;          { "http://www.chinapost.cn/PostService" }
  ArrayOfArrayOfString = array of ArrayOfString;   { "http://www.chinapost.cn/PostService" }

  // ************************************************************************ //
  // Namespace : http://www.chinapost.cn/PostService
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : PostServiceHttpBinding
  // service   : PostService
  // port      : PostServiceHttpPort
  // URL       : http://211.156.193.139/PostWebService/services/PostService
  // ************************************************************************ //
  PostServicePortType = interface(IInvokable)
  ['{188AD6B1-12DE-9B0D-4121-B355EC3602FA}']
    function  setChang(const User: WideString; const Pwd: WideString; const sbid: WideString): Integer; stdcall;
    function  isNewOrder(const User: WideString; const Pwd: WideString; const Type_: Integer): Integer; stdcall;
    function  getFXSJ(const User: WideString; const Pwd: WideString; const sbid: WideString; const msbz: Integer): WideString; stdcall;
    function  ChangYc(const User: WideString; const Pwd: WideString): ArrayOfArrayOfString; stdcall;
    function  setWXNJSHQR(const User: WideString; const Pwd: WideString; const Type_: Integer; const Wxfhid: WideString; const Jszt: Integer): Integer; stdcall;
    function  setOutInfo(const User: WideString; const Pwd: WideString; const Type_: Integer; const ID: WideString; const ProductCode: WideString; const Tao: Integer; const Out_: Integer; const OutCode: WideString; const JiangCode: WideString; const OutWay: WideString; 
                         const OverDate: WideString; const OutNum: Integer; const TXM: WideString; const ZXS: WideString; const CBSL: WideString; const BZ: WideString): Integer; stdcall;
    function  setProductInfo(const User: WideString; const Pwd: WideString; const ProductType: Integer; const ID: WideString; const ProductCode: WideString; const Type_: Integer): Integer; stdcall;
    function  getGGCXD(const User: WideString; const Pwd: WideString; const fhsj: WideString): WideString; stdcall;
    function  getOrderID(const User: WideString; const Pwd: WideString; const Type_: Integer; const State: Integer; const CheckDate: WideString): ArrayOfArrayOfString; stdcall;
    function  getOrderD(const User: WideString; const Pwd: WideString; const OrderID: WideString; const num: Integer): WideString; stdcall;
    function  setCXFH(const User: WideString; const Pwd: WideString; const Type_: Integer; const Sbid: WideString): Integer; stdcall;
    function  checkUser(const User: WideString; const Pwd: WideString): Integer; stdcall;
    function  getOrderQY(const User: WideString; const Pwd: WideString; const Type_: Integer; const Sbid: WideString; const Cpbh: WideString; const CheckDate: WideString): ArrayOfArrayOfString; stdcall;
    function  getWXNJFH(const User: WideString; const Pwd: WideString; const Type_: Integer; const num: Integer): WideString; stdcall;
    function  setDYQR(const User: WideString; const Pwd: WideString; const Type_: Integer; const sbid: WideString; const Yzjhid: Integer; const Cpbh: WideString): Integer; stdcall;
    function  getGGCX(const User: WideString; const Pwd: WideString; const fhsj: WideString): WideString; stdcall;
    function  getOrderX(const User: WideString; const Pwd: WideString; const OrderID: WideString; const num: Integer): WideString; stdcall;
  end;

function GetPostServicePortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): PostServicePortType;


implementation

function GetPostServicePortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): PostServicePortType;
const
  defWSDL = 'http://211.156.193.139/PostWebService/services/PostService?wsdl';
  defURL  = 'http://211.156.193.139/PostWebService/services/PostService';
  defSvc  = 'PostService';
  defPrt  = 'PostServiceHttpPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as PostServicePortType);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  InvRegistry.RegisterInterface(TypeInfo(PostServicePortType), 'http://www.chinapost.cn/PostService', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(PostServicePortType), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(PostServicePortType), ioDocument);
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'setChang', 'out_', 'out');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'isNewOrder', 'Type_', 'Type');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'isNewOrder', 'out_', 'out');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'getFXSJ', 'out_', 'out');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'ChangYc', 'out_', 'out');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'setWXNJSHQR', 'Type_', 'Type');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'setWXNJSHQR', 'out_', 'out');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'setOutInfo', 'Type_', 'Type');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'setOutInfo', 'Out_', 'Out');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'setOutInfo', 'out_', 'out');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'setProductInfo', 'Type_', 'Type');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'setProductInfo', 'out_', 'out');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'getGGCXD', 'out_', 'out');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'getOrderID', 'Type_', 'Type');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'getOrderID', 'out_', 'out');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'getOrderD', 'out_', 'out');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'setCXFH', 'Type_', 'Type');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'setCXFH', 'out_', 'out');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'checkUser', 'out_', 'out');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'getOrderQY', 'Type_', 'Type');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'getOrderQY', 'out_', 'out');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'getWXNJFH', 'Type_', 'Type');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'getWXNJFH', 'out_', 'out');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'setDYQR', 'Type_', 'Type');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'setDYQR', 'out_', 'out');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'getGGCX', 'out_', 'out');
  InvRegistry.RegisterExternalParamName(TypeInfo(PostServicePortType), 'getOrderX', 'out_', 'out');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfString), 'http://www.chinapost.cn/PostService', 'ArrayOfString');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfArrayOfString), 'http://www.chinapost.cn/PostService', 'ArrayOfArrayOfString');

end.