unit uPub_Text;

interface

const
  //c_TitleName = 'ӡˢ��ERPϵͳ�ؿ���ϵͳ V1.0 ';
  c_TitleName = '�ʵ�ӡˢ�� v3.0.12_1 ';

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
  {Frm_login}  //�ݲ���
  UpdateUser='ydysca';
  UpdatePwd='ydys';
  AutoUpdatePath= '\\172.29.116.7\������\�ؿ�2011�ͻ������\';

const
  c_Web_UserName = 'wsfj1';
  c_Web_UserPwd = '000000';

const
  c_PicUrl='http://211.156.193.135/FPKIMG/';  //ͼ�����ص�ַ                                                                                           
  c_DownLoadPicPort = 8011;                //ͼ�����ط���˵Ķ˿ں�
  c_NetClientDLL = 'NetClient_D.dll';     //���罻��DLL
  c_PicPath='OrderPic\';                   //��������ͼ��·��ǰ׺
  c_TempPicPath = 'YDPrint\YDPicCache\';          //��ʱ�ļ���Ŀ¼����

const
  {�û�����}
  c_User = 0;         //��ͨ�û�
  c_Admin = 1;        //����Ա
  c_User_Small=5;     //��ͨ�û�(С����)
  c_Admin_Small=6;    //����Ա(С����)
  c_SuperAdmin = 10;  //��������Ա



const
  {Ĭ��ѡ��}
  c_Default_CPLB = 0;       {0:ȫ��;�����鿴Set_ProductCategory��F_iSort}
  c_LoadBulletinTime = 10000; {ˢ���������ms}

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
  c_WorkOrder_Select  = 0;      //��ѯ
  c_WorkOrder_Modify  = 1;      //�޸�
  c_WorkOrder_KD      = 2;      //����

const
  {Frm_WorkOrder_ZB}
  c_ZB_GXBH  = 0;  //������
  c_ZB_GXMC  = 1;  //��������
  c_ZB_LBGG  = 2;  //�����
  c_ZB_CL    = 3;  //����
  c_ZB_DW    = 4;  //��λ
  c_ZB_BZ    = 5;  //��ע
  c_ZB_CZ_XG = 6;  //�޸�
  c_ZB_CZ_SC = 7;  //ɾ��
  c_ZB_GXID  = 8;  //����ID

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

  c_CPLB_NextYear = '�ڶ���';
  c_CPLB_ThisYear = 'ÿ��';

//const
//  {Set_LimitInfo}
//  c_Limit_fwddtg    = '���ʶ���ͼ��';

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
  c_Allow_FWDDTG         = 'FWDDTG';               //'���ʶ���ͼ��';
  c_Allow_CZMBSJ         = 'CZMBSJ';               //'����ģ�����';
  c_Allow_DDMX_TSGYXG    = 'DDMX_TSGYXG';          //'����������ϸ���⹤���޸�';
  c_Allow_DDMX_YZJGXG    = 'DDMX_YZJGXG';           //'����������ϸ����ӡ���޸�';
  c_Allow_TG_CXCFDD      = 'TG_CXCFDD';            //'�����������';
  c_Allow_TG_DDCY        = 'TG_DDCY';              //'����������ӡ';
  c_Allow_TG_DDSCNJBYS   = 'TG_DDSCNJBYS';         //'��������ɾ���ڼ�(��ӡˢ)';
  c_Allow_TG_ZTSH        = 'TG_ZTSH';              //'����ͼ��״̬���'
  c_Allow_TG_DDSC        = 'TG_DDSC';              //'��������ɾ��';
  c_Allow_ZB_OK          = 'ZB_OK';                //'�����������ư��ȷ��';
  c_Allow_YS_OK          = 'YS_OK';                //'����������ӡˢ��ȷ��';
  c_Allow_YS_YSDH        = 'YS_YSDH';              //'����������ӡˢ��ӡˢ������''
  c_Allow_DH_OK          = 'DH_OK';                //'���������д�ŵ�ȷ��';
  c_Allow_HDJG_OK        = 'HDJG_OK';              //'���������к���ӹ���ȷ��';
  c_Allow_FH_OK          = 'FH_OK';                //'���������з����ķ���';
  c_Allow_FH_JCQR        = 'FH_JCQR';              //'���������з����ķ���ȷ��';
  c_Allow_FHDY_DY        = 'FHDY_DY';              //'���������з�����ӡ�Ĵ�ӡ';
  c_Allow_FHDY_BCXG      = 'FHDY_BCXG';            //'���������з�����ӡ�ı����޸�';
  c_Allow_FHDY_CX        = 'FHDY_CX';              //'���������з�����ӡ�ĳ���';
  c_Allow_XQ_BCQR        = 'XQ_BCQR';              //'������������ǩ�ı��沢ȷ��';
  c_Allow_XQ_BC          = 'XQ_BC';                //'������������ǩ�ı���';
  c_Allow_FHFK_OK        = 'FHFK_OK';              //'���������з��������ķ�������';
  c_Allow_WorkOrder_SQXG = 'WorkOrder_SQXG';       //'������Ȩ�޸�';
  c_Allow_WorkOrder_CX   = 'WorkOrder_CX';         //'������������';
  c_Allow_FHFK_QCDD      = 'FHFK_QCDD';            //'���������з��������������ѡ����';
  c_Allow_FHFK_CXFH      = 'FHFK_CXFH';            //'���������з��������ĳ�������';
  c_Allow_XSDHGDQY       = 'XSDHGDQY';             //'��ʾ���ϸ��ǩ��';
  c_Allow_Bulletin_FB    = 'Bulletin_FB';           //'���淢��'

const
  {�����浥}
  c_ZL_PK: Double = 9;     //�տ�����
  c_ZL_XK: Double = 11;    //�ſ�����
  c_ZL_XF: Double = 10;    //�ŷ�����
  c_ZL_NJ: Double = 15;    //�ڼ�����

  c_FY_PK: Double = 25;  //�տ�����
  c_FY_XK: Double = 25;    //�ſ�����
  c_FY_XF: Double = 12.5;  //�ŷ����
  c_FY_NJ: Double = 12.5;  //�ڼ�����

  c_YSMD_SJRY = 'SH01 �콨��';  //�ռ���Ա


const
  {Tag}
   c_Tag_MakeAllow = 20;     //�������ƿؼ��������ʱTag��ֵ
   c_Tag_IsEmpty = 21;       //��Ҫ�жϿؼ�ֵ�Ƿ�Ϊ�յ�Tag��ֵ

const
  {lb_Temp}
  LB_HEIGHT = 98;          //ListBox��ʾ6�еĸ߶�
  LB_LISTCOUNT = 6;        //ListBox��ʾ����
  LB_LISTCONTCOUNT = 6;    //ListBox���ݸ���

const
  {lb_Temp.tag}
  c_LB_Tag_Normal = 0;      //����
  c_LB_Tag_Many   = 1;      //ѡ���зֱ𸳸�����˹�¼�����edt
  c_LB_Tag_SC_Many = 2;      //ѡ���зֱ𸳸�����Զ����ɲ��ϵ�edt

const
  {��ӡģ��}
  c_WorkOrder_PrintExeName = '��ӡģ��\������ӡģ��.rmf';
  c_YSMD_QMJZ_ExeName      = '��ӡ\ǰ���ֽ�˵�ģ��.rmf';
  c_YSMD_HMJZ_ExeName      = '��ӡ\�����ֽ�˵�ģ��.rmf';
  c_YSMD_DD_QMJZ_ExeName    = '��ӡ\ǰ���ֽ�����˵�ģ��.rmf';
  c_YSMD_DD_HMJZ_ExeName    = '��ӡ\�����ֽ�����˵�ģ��.rmf';
  c_Temp_QMJZ_ExeName      = 'qmjz.rmf';
  c_Temp_HMJZ_ExeName      = 'hmjz.rmf';


const
  {TCL.m_iFlag}
  c_CL_Flag_Normal  = 0;   //�ֶ����
  c_CL_Flag_Auto  = 1;     //�Զ�����

const
  {Frm_main.stat_zt}
  c_ZT_YHLX  = 1;   //�û�����
  c_ZT_YHM   = 3;   //�û���
  c_ZT_DLRQ  = 5;   //��½����
  c_ZT_DLSJ  = 7;   //��½ʱ��

const
  {FraParamset}
  c_XQRJHDPP = '�����ǩ�ҽ����������붩��ӡ���Ƿ�ƥ��';
  c_FHFKRJHDPP = '��鷢�������ҽ����������붩��ӡ���Ƿ�ƥ��';

implementation

end.


