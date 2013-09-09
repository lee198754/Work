using System;
using System.Collections.Generic;
using System.Text;
using Model;
using System.Data;
using System.Data.SqlClient;

namespace Dal
{
    public class D_Log_WebLoginLog
    {
        public D_Log_WebLoginLog()
        { }
        #region  成员方法
        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int F_iID)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from Log_WebLoginLog");
            strSql.Append(" where F_iID=@F_iID ");
            SqlParameter[] parameters = {
					new SqlParameter("@F_iID", SqlDbType.Int,4)};
            parameters[0].Value = F_iID;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }


        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(M_Log_WebLoginLog model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into Log_WebLoginLog(");
            strSql.Append("F_iUserID,F_sUserName,F_dDate,F_sLoginIP)");
            strSql.Append(" values (");
            strSql.Append("@F_iUserID,@F_sUserName,@F_dDate,@F_sLoginIP)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
					new SqlParameter("@F_iUserID", SqlDbType.Int,4),
					new SqlParameter("@F_sUserName", SqlDbType.VarChar,50),
					new SqlParameter("@F_dDate", SqlDbType.DateTime),
					new SqlParameter("@F_sLoginIP", SqlDbType.VarChar,50)};
            parameters[0].Value = model.F_iUserID;
            parameters[1].Value = model.F_sUserName;
            parameters[2].Value = model.F_dDate;
            parameters[3].Value = model.F_sLoginIP;

            object obj = DbHelperSQL.GetSingle(strSql.ToString(), parameters);
            if (obj == null)
            {
                return 1;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }
        /// <summary>
        /// 更新一条数据
        /// </summary>
        public void Update(M_Log_WebLoginLog model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update Log_WebLoginLog set ");
            strSql.Append("F_iUserID=@F_iUserID,");
            strSql.Append("F_sUserName=@F_sUserName,");
            strSql.Append("F_dDate=@F_dDate,");
            strSql.Append("F_sLoginIP=@F_sLoginIP");
            strSql.Append(" where F_iID=@F_iID ");
            SqlParameter[] parameters = {
					new SqlParameter("@F_iID", SqlDbType.Int,4),
					new SqlParameter("@F_iUserID", SqlDbType.Int,4),
					new SqlParameter("@F_sUserName", SqlDbType.VarChar,50),
					new SqlParameter("@F_dDate", SqlDbType.DateTime),
					new SqlParameter("@F_sLoginIP", SqlDbType.VarChar,50)};
            parameters[0].Value = model.F_iID;
            parameters[1].Value = model.F_iUserID;
            parameters[2].Value = model.F_sUserName;
            parameters[3].Value = model.F_dDate;
            parameters[4].Value = model.F_sLoginIP;

            DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
        }

        /// <summary>
        /// 删除一条数据
        /// </summary>
        public void Delete(int F_iID)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from Log_WebLoginLog ");
            strSql.Append(" where F_iID=@F_iID ");
            SqlParameter[] parameters = {
					new SqlParameter("@F_iID", SqlDbType.Int,4)};
            parameters[0].Value = F_iID;

            DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
        }


        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public M_Log_WebLoginLog GetModel(int F_iID)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 F_iID,F_iUserID,F_sUserName,F_dDate,F_sLoginIP from Log_WebLoginLog ");
            strSql.Append(" where F_iID=@F_iID ");
            SqlParameter[] parameters = {
					new SqlParameter("@F_iID", SqlDbType.Int,4)};
            parameters[0].Value = F_iID;

            M_Log_WebLoginLog model = new M_Log_WebLoginLog();
            DataSet ds = DbHelperSQL.Query(strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["F_iID"].ToString() != "")
                {
                    model.F_iID = int.Parse(ds.Tables[0].Rows[0]["F_iID"].ToString());
                }
                if (ds.Tables[0].Rows[0]["F_iUserID"].ToString() != "")
                {
                    model.F_iUserID = int.Parse(ds.Tables[0].Rows[0]["F_iUserID"].ToString());
                }
                model.F_sUserName = ds.Tables[0].Rows[0]["F_sUserName"].ToString();
                if (ds.Tables[0].Rows[0]["F_dDate"].ToString() != "")
                {
                    model.F_dDate = DateTime.Parse(ds.Tables[0].Rows[0]["F_dDate"].ToString());
                }
                model.F_sLoginIP = ds.Tables[0].Rows[0]["F_sLoginIP"].ToString();
                return model;
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select F_iID,F_iUserID,F_sUserName,F_dDate,F_sLoginIP ");
            strSql.Append(" FROM Log_WebLoginLog ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 获得前几行数据
        /// </summary>
        public DataSet GetList(int Top, string strWhere, string filedOrder)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            if (Top > 0)
            {
                strSql.Append(" top " + Top.ToString());
            }
            strSql.Append(" F_iID,F_iUserID,F_sUserName,F_dDate,F_sLoginIP ");
            strSql.Append(" FROM Log_WebLoginLog ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            return DbHelperSQL.Query(strSql.ToString());
        }

        #endregion  成员方法
    }
}
