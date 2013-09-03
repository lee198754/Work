unit uPub_Text;

interface

const
  //c_TitleName = '印刷厂ERP系统贺卡子系统 V1.0 ';
  c_TitleName = '邮电印刷厂 v3.0.12_1 ';

resourcestring
  c_Reg_Login_CookiePath     = 'SOFTWARE\YDPrint\Cookie\Frm_Login\';  {Frm_login}
  c_Reg_CookiePath           = 'SOFTWARE\YDPrint\Cookie\';
  c_Reg_WorkOrder_CookiePath = 'SOFTWARE\YDPrint\Cookie\Frm_WorkOrder\';          {Frm_WorkOrder}
  c_Reg_YSDH_CookiePath      = 'SOFTWARE\YDPrint\Cookie\Frm_YSDH\';               {Frm_YSDH}
  c_Reg_CL_CookiePath        = 'SOFTWARE\YDPrint\Cookie\Frm_CL\';                 {Frm_CL}
  c_Reg_ZB_CookiePath        = 'SOFTWARE\YDPrint\Cookie\Frm_WorkOrder_ZB\';       {Frm_WorkOrder_ZB}
  c_Reg_GXTJ_CookiePath      = 'SOFTWARE\YDPrint\Cookie\Frm_WorkOrder_ZB_GXTJ\';  {Frm_WorkOrder_ZB_GXTJ}
  c_Reg_MachineManage_CookiePath = 'SOFTWARE\YDPrint\Cookie\Frm_MachineManage\';  {Frm_MachineManage}

const
  {Frm_login}  //暂不用
  UpdateUser='ydysca';
  UpdatePwd='ydys';
  AutoUpdatePath= '\\172.29.116.7\公共区\贺卡2011客户端软件\';

const
  c_Web_UserName = 'wsfj1';
  c_Web_UserPwd = '000000';

const
  c_PicUrl='http://211.156.193.135/FPKIMG/';  //图稿下载地址                                                                                           
  c_DownLoadPicPort = 8011;                //图稿下载服务端的端口号
  c_NetClientDLL = 'NetClient_D.dll';     //网络交互DLL
  c_PicPath='OrderPic\';                   //服务器中图稿路径前缀
  c_TempPicPath = 'YDPrint\YDPicCache\';          //临时文件夹目录名称

const
  {用户类型}
  c_User = 0;         //普通用户
  c_Admin = 1;        //管理员
  c_User_Small=5;     //普通用户(小批量)
  c_Admin_Small=6;    //管理员(小批量)
  c_SuperAdmin = 10;  //超级管理员



const
  {默认选项}
  c_Default_CPLB = 0;       {0:全部;其他查看Set_ProductCategory中F_iSort}
  c_LoadBulletinTime = 10000; {刷公告栏间隔ms}

const
 {Fra_XQCX}
  c_XQXX_XZ        =  0;
  c_XQXX_CPBH      =  1;
  c_XQXX_RJBZ      =  2;
  c_XQXX_ZH        =  3;
  c_XQXX_RJHDQ     =  4;
  c_XQXX_RJHDZ     =  5;
  c_XQXX_YL        =  6;
  c_XQXX_CXSL      =  7;
  c_XQXX_ZXS       =  8;
  c_XQXX_TMBZ      =  9;
  c_XQXX_FJGYF     = 10;
  c_XQXX_FHFS      = 11;
  c_XQXX_BZ        = 12;
  c_XQXX_OrderType = 13;
  c_XQXX_OrderID   = 14;

const
  {frm_LableGroup}
  c_Group_ZH     = 0;
  c_Group_RJHDQ  = 1;
  c_Group_RJHDZ  = 2;

const
  {Frm_OrderList}
  c_List_XZ       = 0;
  c_List_KHMC     = 1;
  c_List_CPBH     = 2;
  c_List_YZTMC    = 3;
  c_List_SYYL     = 4;
  //c_List_YL       = 4;
  c_List_BCYL     = 5;
  c_List_ZH       = 6;
  c_List_RJHDQ    = 7;
  c_List_RJHDZ    = 8;
  c_List_BZ       = 9;
  c_List_DHDLR    = 10;
  c_List_ApartID  = 11;

  c_LV_CPBH       = 0;
  c_LV_Group      = 1;
  c_LV_ApartID    = 2;

const
  {Frm_WorkOrder_RJHD}
  c_RJHD_ZH     = 0;
  c_RJHD_RJHDQ  = 1;
  c_RJHD_RJHDZ  = 2;


const
  {Frm_YSDH}
  c_YSDH_BH     = 0;
  c_YSDH_JT     = 1;
  c_YSDH_SC     = 2;
  c_YSDH_SBS    = 3;
  c_YSDH_SB     = 4;
  c_YSDH_YS     = 5;
  c_YSDH_YZLX   = 6;
  c_YSDH_QT     = 7;
  c_YSDH_BZ     = 8;

const
  {Frm_WorkOrder}
  c_WorkOrder_Select  = 0;      //查询
  c_WorkOrder_Modify  = 1;      //修改
  c_WorkOrder_KD      = 2;      //开单

const
  {Frm_WorkOrder_ZB}
  c_ZB_GXBH  = 0;  //工序编号
  c_ZB_GXMC  = 1;  //工序名称
  c_ZB_LBGG  = 2;  //类别规格
  c_ZB_CL    = 3;  //产量
  c_ZB_DW    = 4;  //单位
  c_ZB_BZ    = 5;  //备注
  c_ZB_CZ_XG = 6;  //修改
  c_ZB_CZ_SC = 7;  //删除
  c_ZB_GXID  = 8;  //工序ID

const
  {Fra_CPLB_GL}
  c_CPLB_XH          = 0;
  c_CPLB_BM          = 1;
  c_CPLB_CPLBMC      = 2;
  //c_CPLB_GDHQZ       = 3;
  //c_CPLB_NFGBRQ      = 4;
  c_CPLB_CZ          = 3;
  //c_CPLB_PrefixStyle = 6;
  c_CPLB_CategoryID  = 4;

  c_CPLB_NextYear = '第二年';
  c_CPLB_ThisYear = '每年';

//const
//  {Set_LimitInfo}
//  c_Limit_fwddtg    = '访问订单图稿';

const
  {Frm_FHGL_DY.stg_fhd}
  c_FHGL_PPMC    = 0;
  c_FHGL_MZ      = 1;
  c_FHGL_TB      = 2;
  c_FHGL_BS      = 3;
  c_FHGL_MBMS    = 4;
  c_FHGL_MS      = 5;
  c_FHGL_BZ      = 6;
  c_FHGL_CPBH    = 7;
  c_FHGL_KCID    = 8;

const
  {Frm_FHGL_JZFS.stg_njxx}
  c_NJXX_CPBH = 0;
  c_NJXX_NJPM = 1;
  c_NJXX_CPLX = 2;
  c_NJXX_SL = 3;
  c_NJXX_CPDW = 4;


const
  {Frm_SCGL_BFJC}
  c_BFJC_CPBH    = 0;
  c_BFJC_KDYL    = 1;
  c_BFJC_WJCYL   = 2;
  c_BFJC_BCJCYL  = 3;
  c_BFJC_DetailsID = 4;

const
  {Set_AllowInfo}
  c_Allow_FWDDTG         = 'FWDDTG';               //'访问订单图稿';
  c_Allow_CZMBSJ         = 'CZMBSJ';               //'操作模版设计';
  c_Allow_DDMX_TSGYXG    = 'DDMX_TSGYXG';          //'操作订单明细特殊工艺修改';
  c_Allow_DDMX_YZJGXG    = 'DDMX_YZJGXG';           //'操作订单明细特殊印制修改';
  c_Allow_TG_CXCFDD      = 'TG_CXCFDD';            //'操作订单拆分';
  c_Allow_TG_DDCY        = 'TG_DDCY';              //'操作订单重印';
  c_Allow_TG_DDSCNJBYS   = 'TG_DDSCNJBYS';         //'操作订单删除内件(不印刷)';
  c_Allow_TG_ZTSH        = 'TG_ZTSH';              //'操作图稿状态审核'
  c_Allow_TG_DDSC        = 'TG_DDSC';              //'操作订单删除';
  c_Allow_ZB_OK          = 'ZB_OK';                //'生产管理中制版的确认';
  c_Allow_YS_OK          = 'YS_OK';                //'生产管理中印刷的确认';
  c_Allow_YS_YSDH        = 'YS_YSDH';              //'生产管理中印刷的印刷打号完成''
  c_Allow_DH_OK          = 'DH_OK';                //'生产管理中打号的确认';
  c_Allow_HDJG_OK        = 'HDJG_OK';              //'生产管理中后道加工的确认';
  c_Allow_FH_OK          = 'FH_OK';                //'生产管理中发货的发货';
  c_Allow_FH_JCQR        = 'FH_JCQR';              //'生产管理中发货的发货确认';
  c_Allow_FHDY_DY        = 'FHDY_DY';              //'生产管理中发货打印的打印';
  c_Allow_FHDY_BCXG      = 'FHDY_BCXG';            //'生产管理中发货打印的保存修改';
  c_Allow_FHDY_CX        = 'FHDY_CX';              //'生产管理中发货打印的撤销';
  c_Allow_XQ_BCQR        = 'XQ_BCQR';              //'生产管理中箱签的保存并确认';
  c_Allow_XQ_BC          = 'XQ_BC';                //'生产管理中箱签的保存';
  c_Allow_FHFK_OK        = 'FHFK_OK';              //'生产管理中发货反馈的发货反馈';
  c_Allow_WorkOrder_SQXG = 'WorkOrder_SQXG';       //'工单授权修改';
  c_Allow_WorkOrder_CX   = 'WorkOrder_CX';         //'操作工单撤销';
  c_Allow_FHFK_QCDD      = 'FHFK_QCDD';            //'生产管理中发货反馈的清除所选订单';
  c_Allow_FHFK_CXFH      = 'FHFK_CXFH';            //'生产管理中发货反馈的撤销发货';
  c_Allow_XSDHGDQY       = 'XSDHGDQY';             //'显示待合格待签样';
  c_Allow_Bulletin_FB    = 'Bulletin_FB';           //'公告发布'

const
  {运输面单}
  c_ZL_PK: Double = 9;     //普卡重量
  c_ZL_XK: Double = 11;    //信卡重量
  c_ZL_XF: Double = 10;    //信封重量
  c_ZL_NJ: Double = 15;    //内件重量

  c_FY_PK: Double = 25;  //普卡费用
  c_FY_XK: Double = 25;    //信卡费用
  c_FY_XF: Double = 12.5;  //信封费用
  c_FY_NJ: Double = 12.5;  //内件费用

  c_YSMD_SJRY = 'SH01 徐建中';  //收寄人员


const
  {Tag}
   c_Tag_MakeAllow = 20;     //当被限制控件允许操作时Tag的值
   c_Tag_IsEmpty = 21;       //需要判断控件值是否为空的Tag的值

const
  {lb_Temp}
  LB_HEIGHT = 98;          //ListBox显示6行的高度
  LB_LISTCOUNT = 6;        //ListBox显示行数
  LB_LISTCONTCOUNT = 6;    //ListBox内容个数

const
  {lb_Temp.tag}
  c_LB_Tag_Normal = 0;      //正常
  c_LB_Tag_Many   = 1;      //选项中分别赋给多个人工录入材料edt
  c_LB_Tag_SC_Many = 2;      //选项中分别赋给多个自动生成材料的edt

const
  {打印模版}
  c_WorkOrder_PrintExeName = '打印模版\工单打印模板.rmf';
  c_YSMD_QMJZ_ExeName      = '打印\前面进纸运单模板.rmf';
  c_YSMD_HMJZ_ExeName      = '打印\后面进纸运单模板.rmf';
  c_YSMD_DD_QMJZ_ExeName    = '打印\前面进纸单独运单模板.rmf';
  c_YSMD_DD_HMJZ_ExeName    = '打印\后面进纸单独运单模板.rmf';
  c_Temp_QMJZ_ExeName      = 'qmjz.rmf';
  c_Temp_HMJZ_ExeName      = 'hmjz.rmf';


const
  {TCL.m_iFlag}
  c_CL_Flag_Normal  = 0;   //手动添加
  c_CL_Flag_Auto  = 1;     //自动生成

const
  {Frm_main.stat_zt}
  c_ZT_YHLX  = 1;   //用户类型
  c_ZT_YHM   = 3;   //用户名
  c_ZT_DLRQ  = 5;   //登陆日期
  c_ZT_DLSJ  = 7;   //登陆时间

const
  {FraParamset}
  c_XQRJHDPP = '检查箱签兑奖号码数量与订单印量是否匹配';
  c_FHFKRJHDPP = '检查发货反馈兑奖号码数量与订单印量是否匹配';

implementation

end.


