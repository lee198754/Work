unit NetDataDef;

interface

uses
  Winsock, Classes, Controls, Windows;

const
//// ����Э����
  // ������
  c_PacketCheckCode = $ABCDEFCC;
  // �ı���ʽ
  //c_PacketProtocol_text = $74657874;       // 'text'
  // '<11>'����ɺ�ʼOP_READ_Data_xml����IO��ʹ�ã�һ�յ��͸��ӣ�ÿ�ζ���[0]����
  c_PacketProtocol_xml_Begin = $6D783F3C;  //
  c_PacketProtocol_xml_Begin_Text = '<?xm';  //

  c_PacketProtocol_xml_Begin2 = $3E6D783C;  //
  //c_PacketProtocol_xml_Begin_Text2 = '<xm>';  //

  c_PacketProtocol_xml_End_Text = '</xm>';      // ��ɻ��ǿ�ʼOP_READ_Data_xml����Ӧ�ûص���ʹ��
  // <?xml version="1.0" encoding="UTF-8"?><xm>heartbeat</xm>
  c_PacketProtocol_xml_InitText = '<?xml version="1.0"?><xm></xm>';  

  c_Msg_Heart1 = '<?xml version="1.0" encoding="UTF-8"?><xm>breth</xm>';
  c_Msg_Heart2 = '<?xml version="1.0" encoding="UTF-8"?><xm>heartbeat</xm>';

  c_PacketProtocol_xml_Begin_Len = Length(c_PacketProtocol_xml_End_Text);
  c_PacketProtocol_xml_End_Len = Length(c_PacketProtocol_xml_End_Text);

//// Ӧ��Э����
const
  C_NetDataTypeBase = $FFFFE000;
  C_NetDataType_RunLog = C_NetDataTypeBase + 1;
  C_NetDataType_Pic = C_NetDataTypeBase + 2;
  C_NetDataType_DeskTopPic = C_NetDataTypeBase + 3;   // Զ������
  C_NetDataType_TestTime = C_NetDataTypeBase + 4;     // ��Ӧʱ��
  C_NetDataType_VideoData = C_NetDataTypeBase + 5;    // ��Ƶ
  C_NetDataType_KeyMouse = C_NetDataTypeBase + 6;     // �����¼�
  C_NetDataType_InternalService = C_NetDataTypeBase + 10;     // �ڲ��������ڷֲ�ʽϵͳ

  // �Զ���
  C_NetDataType_Custom = C_NetDataTypeBase + 200;

  //C_NetDataType_xml_Base = $FFFFF000;
  //C_NetDataType_xml = C_NetDataType_xml_Base + 1;

  {         
  ����� code[y20]a4c
  ���ذ� sock b4 rdata
  code: ��[y20]�ҵ�Socket
  [y20]: Ŀ��ı��
  a4: Ԥ���ռ䣬�������ԴSocket�������ֱ���޸�ת���������´��
  c: 1Ϊ����ͼ��0Ϊ����ͼ

  sock: b4ΪĿ��Socket
  b4:Ŀ��Socket
  rdata: ����ֵ=index(��1��ʼ) number left top width height ���ݣ�һ������Ϊ���С����������
  }

// ��Ƶ������
const
  C_NetDataType_VideoData_AskLink = 1;    // ������Ƶ
  C_NetDataType_VideoData_AskLinkRY = 2;  // �Է�������Ƶ
  C_NetDataType_VideoData_AskLinkRN = 3;  // �Է��ܾ���Ƶ
  C_NetDataType_VideoData_Data = 4;       // ��Ƶ����

type
  PDeskTopPicHead = ^TDeskTopPicHead;
  TDeskTopPicHead = packed record
    nCmd: Cardinal;  // ������
    sType: array[0..3] of char;
  end;

  TVideoHead = TDeskTopPicHead;
  PVideoHead = PDeskTopPicHead;

  //
  PVideoData = ^TVideoData;
  TVideoData = packed record
    rHead: TVideoHead;
    nVer: integer;
    nCmd: integer;  // ������
    sCode: array[0..19] of char;  // ����ʱ����Ϊ'code'
    sock: TSocket;                // �ڷ��������Ϊ���Ͷ˵�sock

    bKeyF: boolean;
    nLastFrame: Cardinal;         // ��ǰ֡�����
    nLen: integer;
    sPin: PChar;
  end;
  
  //
  PDeskTopPic = ^TDeskTopPic;
  TDeskTopPic = packed record
    rHead: TDeskTopPicHead;
    sCode: array[0..19] of char;  // ����ʱ����Ϊ'code'
    sock: TSocket;                // �ڷ��������Ϊ���Ͷ˵�sock

    // ��չ����
    nParam1: integer;
    nParam2: integer;
    nParam3: integer;
    nParam4: integer;

    //
    nType: integer;
    nPosType: integer; // 1=ȫ����11=�������12=�Ұ�����21=�ϰ�����22=�°���

    nLeft: integer;
    nTop: integer;
    nWidth: integer;
    nHeight: integer;
  end;

  PDeskTopPicR = ^TDeskTopPicR;
  TDeskTopPicR = packed record
    rHead: TDeskTopPicHead;
    sock: TSocket;  // �ɷ���������ֵΪ���Ͷ˵�sock��TDeskTopPic.sock
    nVer: integer;

    // ��չ����
    nParam1: integer;
    nParam2: integer;
    nParam3: integer;
    nParam4: integer;

    // ��չ����2
    fParam1: double;
    fParam2: double;
    fParam3: double;
    fParam4: double;

    // ��չ����3
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
    sCode: array[0..19] of char;  // ����ʱ����Ϊ'code'
    sock: TSocket;                // �ڷ��������Ϊ���Ͷ˵�sock

    //
    nType: integer;  // 1 Key, 2 Mouse
    nMsg: Cardinal;
    //Button: TMouseButton;
    //Shift: TShiftState;
    X, Y: Short;
  end;

const
  c_DeskTopPicRType_Full = 0;  // ������jpegͼ
  c_DeskTopPicRType_Dif = 1;   // ����ͼ
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
function p_NetDta_GetStr4(Value: Cardinal): string;        // �ĸ��ַ�

implementation

function p_NetDta_GetValue(pData: pointer; nLen: integer): Cardinal;
begin
  Result := 0;
  if nLen < sizeof(Result) then exit;
  Move(pData^, Result, sizeof(Result));
end;

function p_NetDta_GetStr4(Value: Cardinal): string;  // �ĸ��ַ�
begin
  SetLength(Result, sizeof(Value));
  Move(Value, PChar(Result)^, sizeof(Value));
end;

end.
