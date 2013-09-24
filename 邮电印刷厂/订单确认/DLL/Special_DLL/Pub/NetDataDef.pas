unit NetDataDef;

interface

uses
  Winsock, Classes, Controls, Windows;

const
//// 网络协议码
  // 二进制
  c_PacketCheckCode = $ABCDEFCC;
  // 文本格式
  //c_PacketProtocol_text = $74657874;       // 'text'
  // '<11>'，完成后开始OP_READ_Data_xml，在IO中使用，一收到就附加，每次都从[0]接收
  c_PacketProtocol_xml_Begin = $6D783F3C;  //
  c_PacketProtocol_xml_Begin_Text = '<?xm';  //

  c_PacketProtocol_xml_Begin2 = $3E6D783C;  //
  //c_PacketProtocol_xml_Begin_Text2 = '<xm>';  //

  c_PacketProtocol_xml_End_Text = '</xm>';      // 完成还是开始OP_READ_Data_xml，在应用回调中使用
  // <?xml version="1.0" encoding="UTF-8"?><xm>heartbeat</xm>
  c_PacketProtocol_xml_InitText = '<?xml version="1.0"?><xm></xm>';  

  c_Msg_Heart1 = '<?xml version="1.0" encoding="UTF-8"?><xm>breth</xm>';
  c_Msg_Heart2 = '<?xml version="1.0" encoding="UTF-8"?><xm>heartbeat</xm>';

  c_PacketProtocol_xml_Begin_Len = Length(c_PacketProtocol_xml_End_Text);
  c_PacketProtocol_xml_End_Len = Length(c_PacketProtocol_xml_End_Text);

//// 应用协议码
const
  C_NetDataTypeBase = $FFFFE000;
  C_NetDataType_RunLog = C_NetDataTypeBase + 1;
  C_NetDataType_Pic = C_NetDataTypeBase + 2;
  C_NetDataType_DeskTopPic = C_NetDataTypeBase + 3;   // 远程桌面
  C_NetDataType_TestTime = C_NetDataTypeBase + 4;     // 响应时间
  C_NetDataType_VideoData = C_NetDataTypeBase + 5;    // 视频
  C_NetDataType_KeyMouse = C_NetDataTypeBase + 6;     // 键鼠事件
  C_NetDataType_InternalService = C_NetDataTypeBase + 10;     // 内部服务，用于分布式系统

  // 自定义
  C_NetDataType_Custom = C_NetDataTypeBase + 200;

  //C_NetDataType_xml_Base = $FFFFF000;
  //C_NetDataType_xml = C_NetDataType_xml_Base + 1;

  {         
  请求包 code[y20]a4c
  返回包 sock b4 rdata
  code: 从[y20]找到Socket
  [y20]: 目标的编号
  a4: 预留空间，用于填充源Socket，服务端直接修改转发不必重新打包
  c: 1为完整图，0为差异图

  sock: b4为目标Socket
  b4:目标Socket
  rdata: 返回值=index(从1开始) number left top width height 内容，一个包分为多个小块连续发送
  }

// 视频子命令
const
  C_NetDataType_VideoData_AskLink = 1;    // 请求视频
  C_NetDataType_VideoData_AskLinkRY = 2;  // 对方接受视频
  C_NetDataType_VideoData_AskLinkRN = 3;  // 对方拒绝视频
  C_NetDataType_VideoData_Data = 4;       // 视频数据

type
  PDeskTopPicHead = ^TDeskTopPicHead;
  TDeskTopPicHead = packed record
    nCmd: Cardinal;  // 主命令
    sType: array[0..3] of char;
  end;

  TVideoHead = TDeskTopPicHead;
  PVideoHead = PDeskTopPicHead;

  //
  PVideoData = ^TVideoData;
  TVideoData = packed record
    rHead: TVideoHead;
    nVer: integer;
    nCmd: integer;  // 子命令
    sCode: array[0..19] of char;  // 发送时设置为'code'
    sock: TSocket;                // 在服务端设置为发送端的sock

    bKeyF: boolean;
    nLastFrame: Cardinal;         // 当前帧的序号
    nLen: integer;
    sPin: PChar;
  end;
  
  //
  PDeskTopPic = ^TDeskTopPic;
  TDeskTopPic = packed record
    rHead: TDeskTopPicHead;
    sCode: array[0..19] of char;  // 发送时设置为'code'
    sock: TSocket;                // 在服务端设置为发送端的sock

    // 扩展参数
    nParam1: integer;
    nParam2: integer;
    nParam3: integer;
    nParam4: integer;

    //
    nType: integer;
    nPosType: integer; // 1=全屏；11=左半屏；12=右半屏；21=上半屏；22=下半屏

    nLeft: integer;
    nTop: integer;
    nWidth: integer;
    nHeight: integer;
  end;

  PDeskTopPicR = ^TDeskTopPicR;
  TDeskTopPicR = packed record
    rHead: TDeskTopPicHead;
    sock: TSocket;  // 由反馈端设置值为发送端的sock，TDeskTopPic.sock
    nVer: integer;

    // 扩展参数
    nParam1: integer;
    nParam2: integer;
    nParam3: integer;
    nParam4: integer;

    // 扩展参数2
    fParam1: double;
    fParam2: double;
    fParam3: double;
    fParam4: double;

    // 扩展参数3
    bt1: byte;
    bt2: byte;
    bt3: byte;
    bt4: byte;

    //
    nType: integer;
    nIndex: integer;
    nNumber: integer;
    
    nLeft: integer;
    nTop: integer;
    nWidth: integer;
    nHeight: integer;

    nLeftBlock: integer;
    nTopBlock: integer;
    nWidthBlock: integer;
    nHeightBlock: integer;
  end;

  PT_KeyMouseMsg = ^T_KeyMouseMsg;
  T_KeyMouseMsg = packed record
    rHead: TDeskTopPicHead;
    sCode: array[0..19] of char;  // 发送时设置为'code'
    sock: TSocket;                // 在服务端设置为发送端的sock

    //
    nType: integer;  // 1 Key, 2 Mouse
    nMsg: Cardinal;
    //Button: TMouseButton;
    //Shift: TShiftState;
    X, Y: Short;
  end;

const
  c_DeskTopPicRType_Full = 0;  // 完整的jpeg图
  c_DeskTopPicRType_Dif = 1;   // 差异图
  c_iMac_Book_Lan = '705AB64484A1';

  c_ClientType_Manager = 'Manager';
  c_ClientType_Terminal = 'Terminal';
  c_ClientType_AdNode = 'AdNode';

const
  r_WM_KeyDown = 1;
  r_WM_KeyUp = 2;

  r_WM_MouseMove = 10;

  r_WM_LBUTTONDOWN = 11;
  r_WM_LBUTTONUP = 12;
  r_WM_LBUTTONCLK = 13;
  r_WM_LBUTTONDBLCLK = 14;

  r_WM_RBUTTONDOWN = 15;
  r_WM_RBUTTONUP = 16;
  r_WM_RBUTTONCLK = 17;
  r_WM_RBUTTONDBLCLK = 18;

function p_NetDta_GetValue(pData: pointer; nLen: integer): Cardinal;
function p_NetDta_GetStr4(Value: Cardinal): string;        // 四个字符

implementation

function p_NetDta_GetValue(pData: pointer; nLen: integer): Cardinal;
begin
  Result := 0;
  if nLen < sizeof(Result) then exit;
  Move(pData^, Result, sizeof(Result));
end;

function p_NetDta_GetStr4(Value: Cardinal): string;  // 四个字符
begin
  SetLength(Result, sizeof(Value));
  Move(Value, PChar(Result)^, sizeof(Value));
end;

end.
