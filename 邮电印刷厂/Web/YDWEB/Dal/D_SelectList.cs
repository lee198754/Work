using System;
using System.Collections.Generic;
using System.Text;
using Model;
using System.Data;
using System.Data.SqlClient;

namespace Dal
{
    public class D_SelectList
    {
        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select b.F_iID,a.F_sJg,b.F_sCpbh,a.F_sKhmc,");
            strSql.Append(" case b.F_tiNJBZ when 0 then (Select F_sCPLX from Set_PostageType ");
            strSql.Append(" where CHARINDEX(F_sYZTMC,a.F_sYztmc)=1 ) when 1 then '内件' end as F_sType, ");
            strSql.Append(" a.F_sYztmc,c.F_dJsrq, b.F_nYl,a.F_tiJybz, ");
            strSql.Append(" WorkOrder = dbo.f_strWorkOrder(b.F_iID) ");
            strSql.Append(" from BI_CustomOrderDetails a, DO_OrderApart b,BI_CustomOrder c ");
            strSql.Append(" where b.F_tiOrderType=0 and a.F_iID=b.F_iOrderID and c.F_iID= a.F_iCustomID and a.F_tiCXBZ=0 ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(strWhere);
            }
            strSql.Append(" order by c.F_dJsrq desc ");
            return DbHelperSQL.Query(strSql.ToString());
        }


        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList2(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select b.F_iID,a.F_sJg,b.F_sCpbh,a.F_sCpmc as F_sKhmc ,");
            strSql.Append(" case b.F_tiNJBZ when 0 then (Select F_sCPLX from Set_PostageType");
            strSql.Append(" where CHARINDEX(F_sYZTMC,a.F_sYztmc)=1 ) when 1 then '内件' end as F_sType, ");
            strSql.Append(" a.F_sYztmc,c.F_dJsrq, b.F_nYl,a.F_tiJybz, ");
            strSql.Append(" WorkOrder = dbo.f_strWorkOrder(b.F_iID) ");
            strSql.Append(" from BI_SellOrderDetails a, DO_OrderApart b,BI_SellOrder c ");
            strSql.Append(" where b.F_tiOrderType=1 and a.F_iID=b.F_iOrderID and c.F_iID= a.F_iSellID and a.F_tiCXBZ=0 ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(strWhere);
            }
            strSql.Append(" order by c.F_dJsrq desc ");
            return DbHelperSQL.Query(strSql.ToString());
        }
        /// <summary>
        /// 业务统计
        /// </summary>
        /// <param name="TimeStrar">开始时间</param>
        /// <param name="TimeEnd">结束时间</param>
        /// <returns>查询结果</returns>
        public DataSet GetYWTJ(string TimeStrar, string TimeEnd, int type,string F_User)
        {
            IDataParameter[] iData = new SqlParameter[4];
            iData[0] = new SqlParameter("@qrq", TimeStrar);
            iData[1] = new SqlParameter("@zrq", TimeEnd);
            iData[2] = new SqlParameter("@ProductCategoryID", type);
            iData[3] = new SqlParameter("@UserName", F_User);
            return DbHelperSQL.RunProcedure2("p_webywtj", iData);
        }

        /// <summary>
        /// 生产统计
        /// </summary>
        /// <param name="TimeStrar">开始时间</param>
        /// <param name="TimeEnd">结束时间</param>
        /// <returns>查询结果</returns>
        public DataSet GetSCTJ(string TimeStrar, string TimeEnd,int type,string UserName)
        {
            IDataParameter[] iData = new SqlParameter[4];
            iData[0] = new SqlParameter("@qrq", TimeStrar);
            iData[1] = new SqlParameter("@zrq", TimeEnd);
            iData[2] = new SqlParameter("@ProductCategoryID", type);
            iData[3] = new SqlParameter("@UserName", UserName);
            return DbHelperSQL.RunProcedure2("p_websctj", iData);
        }

        /// <summary>
        /// 详细资料
        /// </summary>
        /// <param name="F_iID">ID</param>
        /// <returns>查询结果</returns>
        public DataSet GetYWXX(string F_iID)
        {
            IDataParameter[] iData = new SqlParameter[1];
            iData[0] = new SqlParameter("@ApartID", F_iID);
            return DbHelperSQL.RunProcedure2("p_webddmx", iData);
        }

        /// <summary>
        /// 详细资料列表
        /// </summary>
        /// <param name="F_iID">ID</param>
        /// <returns>查询结果</returns>
        public DataSet GetYWXXList(string F_iID)
        {
            IDataParameter[] iData = new SqlParameter[1];
            iData[0] = new SqlParameter("@ApartID", F_iID);
            return DbHelperSQL.RunProcedure2("p_webddmx_fhxx", iData);
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
            IDataParameter[] iData = new SqlParameter[6];
            iData[0] = new SqlParameter("@cpbh1", cpbh1);
            iData[1] = new SqlParameter("@cpbh2", cpbh2);
            iData[2] = new SqlParameter("@cpbh3", cpbh3);
            iData[3] = new SqlParameter("@cpbh4", cpbh4);
            iData[4] = new SqlParameter("@khmc", khmc);
            iData[5] = new SqlParameter("@Name", Name);
            return DbHelperSQL.RunProcedure2("p_webddcx", iData);
        }

        /// <summary>
        /// 获取发货反馈信息参数
        /// </summary>
        /// <param name="F_iID">ID</param>
        /// <returns>查询结果</returns>
        public DataSet Getp_GetOut(string TXM)
        {
            IDataParameter[] iData = new SqlParameter[1];
            iData[0] = new SqlParameter("@TXM", TXM);
            return DbHelperSQL.RunProcedure2("p_PDA_GetOutInfoParam", iData);
        }


       /// <summary>
        /// 保存反馈信息
        /// </summary>
        /// <param name="F_iID">ID</param>
        /// <returns>查询结果</returns>
        public DataSet Getp_SaveOut(int Rec,int Type,int SBID,string ProductCode,int Tao,int Out,
            string OutCode, string JiangCode, string OutWay, string OverDate, int OutNum, string TXM,
            string ZXS, string CBSL, string BZ)
        {

            //[dbo].[p_SaveOutInfo]   /*保存反馈信息*/
            //  @Rec int,                  --反馈返回标志
            //  @Type int,                 --模式标志 0：定制型；1：销售型（包括地方版）；
            //  @SBID int,                 --申报ID/要数ID 
            //  @ProductCode varchar(50),  --产品编号
            //  @Tao int,                  --套标志(0：枚；1：成套)
            //  @Out int,                  --发货标志(0:还未发货，1:已经发货(一般都传0))
            //  @OutCode varchar(50),      --运输单号
            //  @JiangCode varchar(50),    --兑奖号段(格式：组号1,起号1,止号1;组号2,起号2,止号2;)
            //  @OutWay varchar(50),       --发货方式
            //  @OverDate varchar(50),     --生产完成日期(格式为：”yyyy-MM-dd”)
            //  @OutNum int,               --本次发货数量
            //  @TXM varchar(50),          --条形码(格式：模式标志（1位）+产品ID（10位）+产品编号后三位（3位）+箱号（5位）+行政区划（4位）)
            //  @ZXS varchar(50),          --总箱数
            //  @CBSL varchar(50),         --成包数量
            //  @BZ varchar(50)            --备注
            IDataParameter[] iData = new SqlParameter[15];
            iData[0] = new SqlParameter("@Rec", Rec);
            iData[1] = new SqlParameter("@Type", Type);
            iData[2] = new SqlParameter("@SBID", SBID);
            iData[3] = new SqlParameter("@ProductCode", ProductCode);
            iData[4] = new SqlParameter("@Tao", Tao);
            iData[5] = new SqlParameter("@Out", Out);
            iData[6] = new SqlParameter("@OutCode", OutCode);
            iData[7] = new SqlParameter("@JiangCode", JiangCode);
            iData[8] = new SqlParameter("@OutWay", OutWay);
            iData[9] = new SqlParameter("@OverDate", OverDate);
            iData[10] = new SqlParameter("@OutNum", OutNum);
            iData[11] = new SqlParameter("@TXM", TXM);
            iData[12] = new SqlParameter("@ZXS", ZXS);
            iData[13] = new SqlParameter("@CBSL", CBSL);
            iData[14] = new SqlParameter("@BZ", BZ);
            return DbHelperSQL.RunProcedure2("p_PDA_SaveOutInfo", iData);
        }
        /// <summary>
        /// 获取发货反馈信息参数
        /// </summary>
        /// <param name="F_iID">ID</param>
        /// <returns>查询结果</returns>
        public DataSet Query(string SQLString, int Times)
        {
            return DbHelperSQL.KeepQuery(SQLString, Times);
        }
        /// <summary>
        /// 执行SQL语句，返回影响的记录数
        /// </summary>
        /// <param name="SQLString">SQL语句</param>
        /// <returns>影响的记录数</returns>
        public int ExecuteSql(string SQLString)
        {
            return DbHelperSQL.KeepExecuteSql(SQLString);
        }
    }
}
