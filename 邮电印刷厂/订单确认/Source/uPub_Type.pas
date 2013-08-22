unit uPub_Type;

interface

uses Sysutils,Windows,Controls,Classes,Messages,Variants,ADODB,iComboBox,
     Graphics,RzButton,CheckLst,Forms,FileClientDll;

type
  TProductKind = (pkProductType, pkProductCategory);

  TLoginData = record
    m_iLoginID: Integer;   //登陆日志ID
    m_iUserID: Integer;    //用户ID
    m_sUserName: String;   //用户名
    m_iUserType: Integer;  //用户类型
    m_sRealName: string; //真实姓名
    m_iLicenseCode: LONGLONG;  //授权编号
    m_iAllowCode: LONGLONG;  //允许编号
    //m_iLimitCode: LONGLONG;  //限制编号
  end;

  TIniInfo = record
    m_iLoginID: Integer;   //登陆日志ID
    m_iUserID: Integer;    //用户ID
    m_sUserName: String;   //用户名
    m_iUserType: Integer;  //用户类型
    m_sRealName: string; //真实姓名
    m_iLicenseCode: LONGLONG;  //授权编号
    m_iAllowCode: LONGLONG;  //允许编号
    //m_iLimitCode: LONGLONG;  //限制编号
  end;

  TProductCategory = record
    m_iID: Integer;  //产品类别ID
    m_iXH: Integer;  //产品类别在cbb控件中序号
    m_iSort: Integer;  //产品类别序号
    m_sClassName: string; //产品类别名称
    m_iClassCode: Integer; //产品类别代码
  end;
  PProductCategory = ^TProductCategory;

  TProductType = record
    m_iID: Integer;  //产品类型ID
    m_iXH: Integer;  //产品类型在cbb控件中序号
    m_iSort: Integer;  //产品类型序号
    m_sTypeCode: string; //产品类型代码
    m_sTypeName: string; //产品类型名称
    m_iFJNJBZ: integer;  //是否含有内件
    m_rProductCategory: TProductCategory; //对应的产品类别
  end;
  PProductType = ^TProductType;

  TPostageType  = record
    m_iID: Integer;  //产品类型ID
    m_iXH: Integer;  //产品类型在cbb控件中序号
    m_iSort: Integer;  //产品类型序号
    m_sNF: string;
    m_rProductType: TProductType; //对应的产品类型
    m_sYZTMC: string;
    m_sMz: string;
    m_rProductCategory: TProductCategory; //对应的产品类别
  end;

  TOrderData = record
    m_iXH: integer;
    m_sCPBH: string;
    m_sKhmc: string;
    m_sSl: string;
    m_sWJFSL: string;  //未进仓数量
    m_iBCYL: Integer;  //本次印量
    m_sDw: Integer;
    m_sCplx: string;
    m_sYztmc: string;
    m_iXPL: Integer;
    m_sZH: string;
    m_sRJHDQ: string;
    m_sRJHDZ: string;
    m_sBZ: string;
    m_iSyyl: Double; //订单当前剩余印量
    m_iYl: Double; //订单总印量
    m_iBSTS: Integer; //订单在版式图中的个数
    m_iApartID: Integer;
    m_iOrderID: Integer;
    m_iType: Integer;
//    m_iClassCode: Integer;
    m_iGroupID: integer;
  end;

  TCartonLableGroup = record
    m_iID: Integer;
    m_iGroupID: Integer;  //组ID
    m_iOrderID: Integer;  //订单ID
    m_iOrderType: Integer; //订单类型
    m_sZH: String;     //组号
    m_sRJHDQ: String;  //兑奖号段起
    m_sRJHDZ: String;  //兑奖号段止
    m_iApartID: Integer; //订单分解后ID
    m_iDetailsID: Integer; //工单明细ID
  end;

var
    ProductCategory: array of  TProductCategory;  //大类类信息
    ProductType: array of TProductType;   //小类信息
    PostageType: array of TPostageType; //邮资图信息
    OrderData: array of TOrderData;    //订单信息
    LoginData: TLoginData;          //登陆信息
    LabelGroup: array of TCartonLableGroup;  //箱签中每个订单中兑奖号码记录


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
    m_iZL: Integer;    //总量
    m_rZJ: Real;       //左距
    m_rTJ: Real;       //头距
    m_sKS: Integer;    //开数
    m_rCPK: Real;      //成品宽
    m_rCPC: Real;      //成品长
    m_iGroupID: Integer; //组ID
  end;

  TYSDH = record
    m_iID: Integer;
    m_sGJMC: string;   //构件名称
    m_sJTBH: string;    //编号
    m_sJTMC: string;  //机台名称
    m_sSC: string;    //色次
    m_iSBS: Integer;  //上版
    m_sSB: string;    //色别
    m_iYS: Integer;   //总印数
    m_iYS_1: Integer;   //印数正面
    m_iYS_2: Integer;   //印数反面
    m_sYZLX: string;  //印制类型
    m_sQT: string;    //其它
    m_sYQGX: string;  //印前工序
    m_sYQGXSL: string; //印前工序数量
    m_sYQGXDW: string; //印前工序单位
    m_sYSYQ: string;   //印刷要求
    m_sBZ: string;    //备注
    m_iBSTID: Integer; //版式图ID
    m_iBSTYS: Integer; //版式图印数
    m_iBSTZS: Integer; //版式图总数
//    m_sJTCLBH: String; //机台所需材料编号
//    m_sJTCLMC: String; //机台所需材料名称
//    m_sJTCLGG: String; //机台所需材料规格
//    m_sJTCLDW: String; //机台所需材料单位
    m_iGroupID: Integer; //组ID
  end;

  TCL = record
    m_iID: Integer;
    m_sCLBH: string;    //材料编号
    m_sCLMC: string;    //材料名称
    m_sCLGG: string;    //材料规格
    m_sCJGG: string;    //裁剪规格
    m_sCJKS: string;    //裁剪开数
    m_iJFQS: Integer;   //加放前数
    m_iJFS: Integer;    //加放数
    m_sSL: string;      //数量
    m_sDW: string;      //单位
    m_sPCH: string;     //批次号
    m_iFlag: integer;   //生成标志(0:手动添加;1:按机台生成)
    m_iGroupID: Integer; //组ID
  end;

  TZB = record
    m_iID: Integer;
    m_sTS: string;      //调色
    m_sGB: string;      //改版
    m_sJD: string;      //校对
    m_sDY: string;      //打样
    m_sPB: string;      //拼版
    m_sCP: string;      //出片
    m_sSBLB: string;    //晒版类别
    m_sSBKS: string;   //晒版开数
    m_iSBK: Integer;    //晒版块
    m_sQT: string;      //其它
    m_iGroupID: Integer; //组ID
  end;

  TZBGX = record
    m_iID: Integer;
    m_sCode: string;         //编号
    m_sName: string;         //名称
    m_sCategorySpec: string; //类别规格
    m_sOutput: string;       //产量
    m_sUnit: string;         //单位
    m_sBZ: string;           //备注
    m_iMkProcID: Integer;    //制版ID
    m_iGroupID: Integer;     //组ID
//    m_iSCBZ: Integer;       //删除标志(0:正常;1:删除)
  end;

  TBST = record
    m_iID: Integer;                                                
    m_iRow: Integer;      //行号                                   
    m_iCol: Integer;      //列号                                   
    m_sBZ: string;        //备注
    //m_iBSTYS: integer;    //版式图印数
    //m_iBSTBS: integer;    //版式图版数(每版的成品数)
    m_iGroupID: Integer;    //组ID
  end;

  TBSTPrint = record
    m_iID: Integer;
    m_iRow: Integer;      //行号
    m_iCol: Integer;      //列号
    m_iApartID: Integer;  //订单分解后ID
    m_sCPBH: string;      //产品编号
    m_sBZ: string;        //备注
    m_iBSTID: integer;    //版式图ID
    m_iGroupID: Integer;    //组ID
  end;

  TZD = record
   m_iID: integer;
   m_sBZ: string;       //备注
   m_iGroupID: Integer;   //组ID
  end;

  TBZ = record
   m_iID: integer;
   m_sBZ: string;        //备注
   m_iGroupID: Integer;    //组ID
  end;

  TWorkData = record
    m_iID: Integer;
    m_sGDH: string;
    m_iZL: integer;
    m_sHM: string;
    m_sCPGG: string;  //成品宽*成品长(开数)
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
    m_sGXBH: string;        //工序编号
    m_sGXMC: string;        //工序名称
    m_sLBGG: string;        //工序类别
    m_sCL: string;          //产量
    m_sDW: string;          //单位
  end;

  TRJHD = record
    m_iID: Integer;
    m_sZH: String;     //组号
    m_sRJHDQ: String;  //兑奖号段起
    m_sRJHDZ: String;  //兑奖号段止
    m_iApartID: Integer; //订单分解后ID
    m_iDetailsID: Integer; //工单明细ID
    m_iGroupID: integer;   //组ID
    m_sCPBH: string;       //产品编号
  end;
  TArrRJHD = array of TRJHD;

  TDeclareNumbers = record          //申报编号
    m_iID: Integer;
    m_sCode: String;     //编号
    m_sPlaceName: String;  //地名
    m_iFlag: Integer;  //标志(1:省,2:市,3:县)
  end;

  TFieldMode=(fmNone,fmSelect,fmLink);
  TSelectField = record          //uFrm_Select列名
    m_sName: string;
    m_sField: string;
    m_iWidth: Integer;
    m_FMode: TFieldMode;
    m_sValue: string;
  end;

  TArrSelectField = array of TSelectField;

  TYZZL = record  //邮资重量
    m_rPK: Double;     //普卡重量
    m_rXK: Double;    //信卡重量
    m_rXF: Double;    //信封重量
    m_rNJ: Double;    //内件重量
  end;

  TYZFY = record  //邮资费用
    m_rPK: Double;     //普卡费用
    m_rXK: Double;    //信卡费用
    m_rXF: Double;    //信封费用
    m_rNJ: Double;    //内件费用
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
