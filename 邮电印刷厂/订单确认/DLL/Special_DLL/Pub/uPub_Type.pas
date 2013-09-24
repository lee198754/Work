unit uPub_Type;

interface

uses Sysutils,Windows,Controls,Classes,Messages,Variants,ADODB,iComboBox,
     Graphics,RzButton,CheckLst,Forms,FileClientDll;

type
  TProductKind = (pkProductType, pkProductCategory);

  TLoginData = record
    m_iLoginID: Integer;   //��½��־ID
    m_iUserID: Integer;    //�û�ID
    m_sUserName: String;   //�û���
    m_iUserType: Integer;  //�û�����
    m_sRealName: string; //��ʵ����
    m_iLicenseCode: LONGLONG;  //��Ȩ���
    m_iAllowCode: LONGLONG;  //������
    //m_iLimitCode: LONGLONG;  //���Ʊ��
  end;

  TIniInfo = record
    m_iLoginID: Integer;   //��½��־ID
    m_iUserID: Integer;    //�û�ID
    m_sUserName: String;   //�û���
    m_iUserType: Integer;  //�û�����
    m_sRealName: string; //��ʵ����
    m_iLicenseCode: LONGLONG;  //��Ȩ���
    m_iAllowCode: LONGLONG;  //������
    //m_iLimitCode: LONGLONG;  //���Ʊ��
  end;

  TProductCategory = record
    m_iID: Integer;  //��Ʒ���ID
    m_iXH: Integer;  //��Ʒ�����cbb�ؼ������
    m_iSort: Integer;  //��Ʒ������
    m_sClassName: string; //��Ʒ�������
    m_iClassCode: Integer; //��Ʒ������
  end;
  PProductCategory = ^TProductCategory;

  TProductType = record
    m_iID: Integer;  //��Ʒ����ID
    m_iXH: Integer;  //��Ʒ������cbb�ؼ������
    m_iSort: Integer;  //��Ʒ�������
    m_sTypeCode: string; //��Ʒ���ʹ���
    m_sTypeName: string; //��Ʒ��������
    m_iFJNJBZ: integer;  //�Ƿ����ڼ�
    m_rProductCategory: TProductCategory; //��Ӧ�Ĳ�Ʒ���
  end;
  PProductType = ^TProductType;

  TPostageType  = record
    m_iID: Integer;  //��Ʒ����ID
    m_iXH: Integer;  //��Ʒ������cbb�ؼ������
    m_iSort: Integer;  //��Ʒ�������
    m_sNF: string;
    m_rProductType: TProductType; //��Ӧ�Ĳ�Ʒ����
    m_sYZTMC: string;
    m_sMz: string;
    m_rProductCategory: TProductCategory; //��Ӧ�Ĳ�Ʒ���
  end;

  TOrderData = record
    m_iXH: integer;
    m_sCPBH: string;
    m_sKhmc: string;
    m_sSl: string;
    m_sWJFSL: string;  //δ��������
    m_iBCYL: Integer;  //����ӡ��
    m_sDw: Integer;
    m_sCplx: string;
    m_sYztmc: string;
    m_iXPL: Integer;
    m_sZH: string;
    m_sRJHDQ: string;
    m_sRJHDZ: string;
    m_sBZ: string;
    m_iSyyl: Double; //������ǰʣ��ӡ��
    m_iYl: Double; //������ӡ��
    m_iBSTS: Integer; //�����ڰ�ʽͼ�еĸ���
    m_iApartID: Integer;
    m_iOrderID: Integer;
    m_iType: Integer;
//    m_iClassCode: Integer;
    m_iGroupID: integer;
  end;

  TCartonLableGroup = record
    m_iID: Integer;
    m_iGroupID: Integer;  //��ID
    m_iOrderID: Integer;  //����ID
    m_iOrderType: Integer; //��������
    m_sZH: String;     //���
    m_sRJHDQ: String;  //�ҽ��Ŷ���
    m_sRJHDZ: String;  //�ҽ��Ŷ�ֹ
    m_iApartID: Integer; //�����ֽ��ID
    m_iDetailsID: Integer; //������ϸID
  end;

var
    ProductCategory: array of  TProductCategory;  //��������Ϣ
    ProductType: array of TProductType;   //С����Ϣ
    PostageType: array of TPostageType; //����ͼ��Ϣ
    OrderData: array of TOrderData;    //������Ϣ
    LoginData: TLoginData;          //��½��Ϣ
    LabelGroup: array of TCartonLableGroup;  //��ǩ��ÿ�������жҽ������¼


type     {Frm_WorkOrder}
  TOrderGroup = record
    m_iID: Integer;
    m_sCPBH: string;
    m_sYZTMC: string;
    m_sBCYL: string;
    m_sZH: string;
    m_sRJHDQ: string;
    m_sRjHDZ: string;
    m_sBZ: string;
    m_iApartID: Integer;
    m_iGroupID: integer;
  end;

  TYJYQ = record
    m_iID: Integer;
    m_iZL: Integer;    //����
    m_rZJ: Real;       //���
    m_rTJ: Real;       //ͷ��
    m_sKS: Integer;    //����
    m_rCPK: Real;      //��Ʒ��
    m_rCPC: Real;      //��Ʒ��
    m_iGroupID: Integer; //��ID
  end;

  TYSDH = record
    m_iID: Integer;
    m_sGJMC: string;   //��������
    m_sJTBH: string;    //���
    m_sJTMC: string;  //��̨����
    m_sSC: string;    //ɫ��
    m_iSBS: Integer;  //�ϰ�
    m_sSB: string;    //ɫ��
    m_iYS: Integer;   //��ӡ��
    m_iYS_1: Integer;   //ӡ������
    m_iYS_2: Integer;   //ӡ������
    m_sYZLX: string;  //ӡ������
    m_sQT: string;    //����
    m_sYQGX: string;  //ӡǰ����
    m_sYQGXSL: string; //ӡǰ��������
    m_sYQGXDW: string; //ӡǰ����λ
    m_sYSYQ: string;   //ӡˢҪ��
    m_sBZ: string;    //��ע
    m_iBSTID: Integer; //��ʽͼID
    m_iBSTYS: Integer; //��ʽͼӡ��
    m_iBSTZS: Integer; //��ʽͼ����
//    m_sJTCLBH: String; //��̨������ϱ��
//    m_sJTCLMC: String; //��̨�����������
//    m_sJTCLGG: String; //��̨������Ϲ��
//    m_sJTCLDW: String; //��̨������ϵ�λ
    m_iGroupID: Integer; //��ID
  end;

  TCL = record
    m_iID: Integer;
    m_sCLBH: string;    //���ϱ��
    m_sCLMC: string;    //��������
    m_sCLGG: string;    //���Ϲ��
    m_sCJGG: string;    //�ü����
    m_sCJKS: string;    //�ü�����
    m_iJFQS: Integer;   //�ӷ�ǰ��
    m_iJFS: Integer;    //�ӷ���
    m_sSL: string;      //����
    m_sDW: string;      //��λ
    m_sPCH: string;     //���κ�
    m_iFlag: integer;   //���ɱ�־(0:�ֶ����;1:����̨����)
    m_iGroupID: Integer; //��ID
  end;

  TZB = record
    m_iID: Integer;
    m_sTS: string;      //��ɫ
    m_sGB: string;      //�İ�
    m_sJD: string;      //У��
    m_sDY: string;      //����
    m_sPB: string;      //ƴ��
    m_sCP: string;      //��Ƭ
    m_sSBLB: string;    //ɹ�����
    m_sSBKS: string;   //ɹ�濪��
    m_iSBK: Integer;    //ɹ���
    m_sQT: string;      //����
    m_iGroupID: Integer; //��ID
  end;

  TZBGX = record
    m_iID: Integer;
    m_sCode: string;         //���
    m_sName: string;         //����
    m_sCategorySpec: string; //�����
    m_sOutput: string;       //����
    m_sUnit: string;         //��λ
    m_sBZ: string;           //��ע
    m_iMkProcID: Integer;    //�ư�ID
    m_iGroupID: Integer;     //��ID
//    m_iSCBZ: Integer;       //ɾ����־(0:����;1:ɾ��)
  end;

  TBST = record
    m_iID: Integer;                                                
    m_iRow: Integer;      //�к�                                   
    m_iCol: Integer;      //�к�                                   
    m_sBZ: string;        //��ע
    //m_iBSTYS: integer;    //��ʽͼӡ��
    //m_iBSTBS: integer;    //��ʽͼ����(ÿ��ĳ�Ʒ��)
    m_iGroupID: Integer;    //��ID
  end;

  TBSTPrint = record
    m_iID: Integer;
    m_iRow: Integer;      //�к�
    m_iCol: Integer;      //�к�
    m_iApartID: Integer;  //�����ֽ��ID
    m_sCPBH: string;      //��Ʒ���
    m_sBZ: string;        //��ע
    m_iBSTID: integer;    //��ʽͼID
    m_iGroupID: Integer;    //��ID
  end;

  TZD = record
   m_iID: integer;
   m_sBZ: string;       //��ע
   m_iGroupID: Integer;   //��ID
  end;

  TBZ = record
   m_iID: integer;
   m_sBZ: string;        //��ע
   m_iGroupID: Integer;    //��ID
  end;

  TWorkData = record
    m_iID: Integer;
    m_sGDH: string;
    m_iZL: integer;
    m_sHM: string;
    m_sCPGG: string;  //��Ʒ��*��Ʒ��(����)
    m_sZH: string;
    m_sRJHDQ: string;
    m_sRJHDZ: string;
    m_sZD: string;
    m_sBZ: string;
  end;

  TMatlInfo = record
    m_iID: Integer;
    m_sCLBH: string;
    m_sCLMC: string;
    m_sCLGG: string;
    m_sCJGG: string;
    m_sCJSL: string;
    m_sCJDW: string;
  end;

  TWorkProcInfo = record
    m_iID: Integer;
    m_sGXBH: string;        //������
    m_sGXMC: string;        //��������
    m_sLBGG: string;        //�������
    m_sCL: string;          //����
    m_sDW: string;          //��λ
  end;

  TRJHD = record
    m_iID: Integer;
    m_sZH: String;     //���
    m_sRJHDQ: String;  //�ҽ��Ŷ���
    m_sRJHDZ: String;  //�ҽ��Ŷ�ֹ
    m_iApartID: Integer; //�����ֽ��ID
    m_iDetailsID: Integer; //������ϸID
    m_iGroupID: integer;   //��ID
    m_sCPBH: string;       //��Ʒ���
  end;
  TArrRJHD = array of TRJHD;

  TDeclareNumbers = record          //�걨���
    m_iID: Integer;
    m_sCode: String;     //���
    m_sPlaceName: String;  //����
    m_iFlag: Integer;  //��־(1:ʡ,2:��,3:��)
  end;

  TFieldMode=(fmNone,fmSelect,fmLink);
  TSelectField = record          //uFrm_Select����
    m_sName: string;
    m_sField: string;
    m_iWidth: Integer;
    m_FMode: TFieldMode;
    m_sValue: string;
  end;

  TArrSelectField = array of TSelectField;

  TYZZL = record  //��������
    m_rPK: Double;     //�տ�����
    m_rXK: Double;    //�ſ�����
    m_rXF: Double;    //�ŷ�����
    m_rNJ: Double;    //�ڼ�����
  end;

  TYZFY = record  //���ʷ���
    m_rPK: Double;     //�տ�����
    m_rXK: Double;    //�ſ�����
    m_rXF: Double;    //�ŷ����
    m_rNJ: Double;    //�ڼ�����
  end;


  var
    OrderGroup: array of TOrderGroup;
    aBST: array of TBST;
    aBSTPrint: array of TBSTPrint;
    aYSDH: array of TYSDH;
    aCL: array of TCL;
    aZB: array of TZB;
    aZBGX: array of TZBGX;
    aRJHD: TArrRJHD;
    aTempRJHD: TArrRJHD;
    MatlInfo: array of TMatlInfo;
    WorkProcInfo: array of TWorkProcInfo;
    aDeclareNumbers: array of TDeclareNumbers;
    m_Net: TFileClientDll;

implementation


end.
