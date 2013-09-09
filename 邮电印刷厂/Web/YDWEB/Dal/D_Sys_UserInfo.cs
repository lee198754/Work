using System;
using System.Collections.Generic;
using System.Text;
using Model;
using System.Data;
using System.Data.SqlClient;

namespace Dal
{
    public class D_Sys_UserInfo
    {
        public D_Sys_UserInfo()
        { }
        #region  成员方法
        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int F_iID)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from Sys_UserInfo");
            strSql.Append(" where F_iID=@F_iID ");
            SqlParameter[] parameters = {
					new SqlParameter("@F_iID", SqlDbType.Int,4)};
            parameters[0].Value = F_iID;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }


        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(M_Sys_UserInfo model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into Sys_UserInfo(");
            strSql.Append("F_sName,F_sPwd,F_iType,F_iCode,F_iSign,F_sText,F_sText1,F_sText2,F_sUserName,F_sRealName,F_sPermissions)");
            strSql.Append(" values (");
            strSql.Append("@F_sName,@F_sPwd,@F_iType,@F_iCode,@F_iSign,@F_sText,@F_sText1,@F_sText2,@F_sUserName,@F_sRealName,@F_sPermissions)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
					new SqlParameter("@F_sName", SqlDbType.VarChar,50),
					new SqlParameter("@F_sPwd", SqlDbType.VarChar,50),
					new SqlParameter("@F_iType", SqlDbType.Int,4),
					new SqlParameter("@F_iCode", SqlDbType.VarChar,200),
					new SqlParameter("@F_iSign", SqlDbType.Int,4),
					new SqlParameter("@F_sText", SqlDbType.VarChar,50),
					new SqlParameter("@F_sText1", SqlDbType.VarChar,200),
					new SqlParameter("@F_sText2", SqlDbType.Int,4),
					new SqlParameter("@F_sUserName", SqlDbType.VarChar,200),
					new SqlParameter("@F_sRealName", SqlDbType.VarChar,50),
					new SqlParameter("@F_sPermissions", SqlDbType.VarChar,200)};
            parameters[0].Value = model.F_sName;
            parameters[1].Value = model.F_sPwd;
            parameters[2].Value = model.F_iType;
            parameters[3].Value = model.F_iCode;
            parameters[4].Value = model.F_iSign;
            parameters[5].Value = model.F_sText;
            parameters[6].Value = model.F_sText1;
            parameters[7].Value = model.F_sText2;
            parameters[8].Value = model.F_sUserName;
            parameters[9].Value = model.F_sRealName;
            parameters[10].Value = model.F_sPermissions;


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
        public void Update(M_Sys_UserInfo model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update Sys_UserInfo set ");
            strSql.Append("F_sName=@F_sName,");
            strSql.Append("F_sPwd=@F_sPwd,");
            strSql.Append("F_iType=@F_iType,");
            strSql.Append("F_iCode=@F_iCode,");
            strSql.Append("F_iSign=@F_iSign,");
            strSql.Append("F_sText=@F_sText,");
            strSql.Append("F_sText1=@F_sText1,");
            strSql.Append("F_sText2=@F_sText2,");
            strSql.Append("F_sUserName=@F_sUserName,");
            strSql.Append("F_sRealName=@F_sRealName,");
            strSql.Append("F_sPermissions=@F_sPermissions");
            strSql.Append(" where F_iID=@F_iID ");
            SqlParameter[] parameters = {
					new SqlParameter("@F_iID", SqlDbType.Int,4),
					new SqlParameter("@F_sName", SqlDbType.VarChar,50),
					new SqlParameter("@F_sPwd", SqlDbType.VarChar,50),
					new SqlParameter("@F_iType", SqlDbType.Int,4),
					new SqlParameter("@F_iCode", SqlDbType.VarChar,200),
					new SqlParameter("@F_iSign", SqlDbType.Int,4),
					new SqlParameter("@F_sText", SqlDbType.VarChar,50),
					new SqlParameter("@F_sText1", SqlDbType.VarChar,200),
					new SqlParameter("@F_sText2", SqlDbType.Int,4),
					new SqlParameter("@F_sUserName", SqlDbType.VarChar,200),
					new SqlParameter("@F_sRealName", SqlDbType.VarChar,50),
					new SqlParameter("@F_sPermissions", SqlDbType.VarChar,200)};
            parameters[0].Value = model.F_iID;
            parameters[1].Value = model.F_sName;
            parameters[2].Value = model.F_sPwd;
            parameters[3].Value = model.F_iType;
            parameters[4].Value = model.F_iCode;
            parameters[5].Value = model.F_iSign;
            parameters[6].Value = model.F_sText;
            parameters[7].Value = model.F_sText1;
            parameters[8].Value = model.F_sText2;
            parameters[9].Value = model.F_sUserName;
            parameters[10].Value = model.F_sRealName;
            parameters[11].Value = model.F_sPermissions;
            DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
        }

        /// <summary>
        /// 删除一条数据
        /// </summary>
        public void Delete(int F_iID)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from Sys_UserInfo ");
            strSql.Append(" where F_iID=@F_iID ");
            SqlParameter[] parameters = {
					new SqlParameter("@F_iID", SqlDbType.Int,4)};
            parameters[0].Value = F_iID;

            DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
        }


        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public M_Sys_UserInfo GetModel(int F_iID)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 F_iID,F_sName,F_sPwd,F_iType,F_iCode,F_iSign,F_sText,F_sText1,F_sText2,F_sUserName,F_sRealName,F_sPermissions from Sys_UserInfo ");
            strSql.Append(" where F_iID=@F_iID ");
            SqlParameter[] parameters = {
					new SqlParameter("@F_iID", SqlDbType.Int,4)};
            parameters[0].Value = F_iID;

            M_Sys_UserInfo model = new M_Sys_UserInfo();
            DataSet ds = DbHelperSQL.Query(strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["F_iID"].ToString() != "")
                {
                    model.F_iID = int.Parse(ds.Tables[0].Rows[0]["F_iID"].ToString());
                }
                model.F_sName = ds.Tables[0].Rows[0]["F_sName"].ToString();
                model.F_sPwd = ds.Tables[0].Rows[0]["F_sPwd"].ToString();
                if (ds.Tables[0].Rows[0]["F_iType"].ToString() != "")
                {
                    model.F_iType = int.Parse(ds.Tables[0].Rows[0]["F_iType"].ToString());
                }
                model.F_iCode = ds.Tables[0].Rows[0]["F_iCode"].ToString();
                if (ds.Tables[0].Rows[0]["F_iSign"].ToString() != "")
                {
                    model.F_iSign = int.Parse(ds.Tables[0].Rows[0]["F_iSign"].ToString());
                }
                model.F_sText = ds.Tables[0].Rows[0]["F_sText"].ToString();
                model.F_sText1 = ds.Tables[0].Rows[0]["F_sText1"].ToString();
                if (ds.Tables[0].Rows[0]["F_sText2"].ToString() != "")
                {
                    model.F_sText2 = int.Parse(ds.Tables[0].Rows[0]["F_sText2"].ToString());
                }
                model.F_sUserName = ds.Tables[0].Rows[0]["F_sUserName"].ToString();
                model.F_sRealName = ds.Tables[0].Rows[0]["F_sRealName"].ToString();
                model.F_sPermissions = ds.Tables[0].Rows[0]["F_sPermissions"].ToString();
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
            strSql.Append("select F_iID,F_sName,F_sPwd,F_iType,F_iCode,F_iSign,F_sText,F_sText1,F_sText2,F_sUserName,F_sRealName,F_sPermissions ");
            strSql.Append(" FROM Sys_UserInfo ");
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
            strSql.Append(" F_iID,F_sName,F_sPwd,F_iType,F_iCode,F_iSign,F_sText,F_sText1,F_sText2,F_sUserName,F_sRealName,F_sPermissions  ");
            strSql.Append(" FROM Sys_UserInfo ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            return DbHelperSQL.Query(strSql.ToString());
        }

        public void RestoreDataBase(string databasename, string databasefile)
        {
            DbHelperSQL.RestoreDataBase(databasename, databasename);
        }


        /// <summary>
        /// 更新一条数据
        /// </summary>
        public void UpdatePwd(int F_iID, string F_sPwd)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update Sys_UserInfo set ");
            strSql.Append("F_sPwd=@F_sPwd");
            strSql.Append(" where F_iID=@F_iID ");
            SqlParameter[] parameters = {
					new SqlParameter("@F_iID", SqlDbType.Int,4),
					new SqlParameter("@F_sPwd", SqlDbType.VarChar,50)};
            parameters[0].Value = F_iID;
            parameters[1].Value = F_sPwd;
            DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetListUsertype(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * from dbo.SYS_Usertype ");
            //strSql.Append(" FROM Sys_UserInfo ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetListJoin(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select u.F_iID,u.F_sName,u.F_iType,u.F_iCode,u.F_iSign,convert(varchar(10) , u.F_sText, 23 ) as F_sText,u.F_sUserName,u.F_sRealName,t.F_sName as t_Name from Sys_UserInfo as u ");
            strSql.Append(" inner join SYS_Usertype as t on u.F_iType=t.F_iID ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetListCategory(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * from Set_ProductCategory ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by F_iSort ");
            return DbHelperSQL.Query(strSql.ToString());
        }

        #endregion  成员方法
    }
}
