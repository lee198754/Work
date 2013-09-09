using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using Model;
using Dal;

namespace Bll
{
    public class B_SelectList
    {
        private readonly D_SelectList dal = new D_SelectList();
        public B_SelectList()
		{}

         /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            return dal.GetList(strWhere);
        }

         /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList2(string strWhere)
        {
            return dal.GetList2(strWhere);
        }

         /// <summary>
        /// 业务统计
        /// </summary>
        /// <param name="TimeStrar">开始时间</param>
        /// <param name="TimeEnd">结束时间</param>
        /// <returns>查询结果</returns>
        public DataSet GetYWTJ(string TimeStrar, string TimeEnd, int type, string F_User)
        {
            return dal.GetYWTJ(TimeStrar, TimeEnd, type, F_User);
        }

          /// <summary>
        /// 生产统计
        /// </summary>
        /// <param name="TimeStrar">开始时间</param>
        /// <param name="TimeEnd">结束时间</param>
        /// <returns>查询结果</returns>
        public DataSet GetSCTJ(string TimeStrar, string TimeEnd, int type,string UserName)
        {
            return dal.GetSCTJ(TimeStrar, TimeEnd,type,UserName);
        }

         /// <summary>
        /// 详细资料
        /// </summary>
        /// <param name="F_iID">ID</param>
        /// <returns>查询结果</returns>
        public DataSet GetYWXX(string F_iID)
        {
            return dal.GetYWXX(F_iID);
        }

         /// <summary>
        /// 详细资料列表
        /// </summary>
        /// <param name="F_iID">ID</param>
        /// <returns>查询结果</returns>
        public DataSet GetYWXXList(string F_iID)
        {
            return dal.GetYWXXList(F_iID);
        }

        /// <summary>
        /// 业务查询
        /// </summary>
        /// <param name="cpbh1">产品编号第1部分</param>
        /// <param name="cpbh2">产品编号第2部分</param>
        /// <param name="cpbh3">产品编号第3部分</param>
        /// <param name="cpbh4">产品编号第4部分</param>
        /// <param name="khmc">客户名称</param>
        /// <param name="Name">用户名</param>
        /// <returns></returns>
        public DataSet p_webddcx(string cpbh1, string cpbh2, string cpbh3, string cpbh4, string khmc, string Name)
        {
            return dal.p_webddcx(cpbh1, cpbh2, cpbh3, cpbh4, khmc, Name);
        }

        /// <summary>
        /// 获取发货反馈信息参数
        /// </summary>
        /// <param name="F_iID">ID</param>
        /// <returns>查询结果</returns>
        public DataSet Getp_GetOut(string TXM)
        {
            return dal.Getp_GetOut(TXM);
        }

        /// <summary>
        /// 保存反馈信息
        /// </summary>
        /// <param name="Rec"></param>
        /// <param name="Type"></param>
        /// <param name="SBID"></param>
        /// <param name="ProductCode"></param>
        /// <param name="Tao"></param>
        /// <param name="Out"></param>
        /// <param name="OutCode"></param>
        /// <param name="JiangCode"></param>
        /// <param name="OutWay"></param>
        /// <param name="OverDate"></param>
        /// <param name="OutNum"></param>
        /// <param name="TXM"></param>
        /// <param name="ZXS"></param>
        /// <param name="CBSL"></param>
        /// <param name="BZ"></param>
        /// <returns>返回结果集</returns>
        public DataSet Getp_SaveOut(int Rec, int Type, int SBID, string ProductCode, int Tao, int Out,
            string OutCode, string JiangCode, string OutWay, string OverDate, int OutNum, string TXM,
            string ZXS, string CBSL, string BZ)
        {
            return dal.Getp_SaveOut(Rec, Type, SBID, ProductCode, Tao, Out, OutCode, JiangCode, OutWay, OverDate, 
                                    OutNum, TXM, ZXS,CBSL, BZ);
        }
        
        /// <summary>
        /// 获取发货反馈信息参数
        /// </summary>
        /// <param name="F_iID">ID</param>
        /// <returns>查询结果</returns>
        public DataSet Query(string SQLString, int Times)
        {
            return dal.Query(SQLString, Times);
        }
        /// <summary>
        /// 执行SQL语句，返回影响的记录数
        /// </summary>
        /// <param name="SQLString">SQL语句</param>
        /// <returns>影响的记录数</returns>
        public  int ExecuteSql(string SQLString)
        {
            return dal.ExecuteSql(SQLString);
        }
    }
}
