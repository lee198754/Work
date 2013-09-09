using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using Model;
using Dal;

namespace Bll
{
    public class B_Sys_UserInfo
    {
        private readonly D_Sys_UserInfo dal = new D_Sys_UserInfo();
        public B_Sys_UserInfo()
        { }
        #region  成员方法
        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int F_iID)
        {
            return dal.Exists(F_iID);
        }

        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(M_Sys_UserInfo model)
        {
            return dal.Add(model);
        }

        /// <summary>
        /// 更新一条数据
        /// </summary>
        public void Update(M_Sys_UserInfo model)
        {
            dal.Update(model);
        }

        /// <summary>
        /// 删除一条数据
        /// </summary>
        public void Delete(int F_iID)
        {

            dal.Delete(F_iID);
        }

        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public M_Sys_UserInfo GetModel(int F_iID)
        {

            return dal.GetModel(F_iID);
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            return dal.GetList(strWhere);
        }
        /// <summary>
        /// 获得前几行数据
        /// </summary>
        public DataSet GetList(int Top, string strWhere, string filedOrder)
        {
            return dal.GetList(Top, strWhere, filedOrder);
        }

        public void RestoreDataBase(string databasename, string databasefile)
        {
            dal.RestoreDataBase(databasename, databasename);
        }

         /// <summary>
        /// 更新一条数据
        /// </summary>
        public void UpdatePwd(int F_iID, string F_sPwd)
        {
            dal.UpdatePwd(F_iID, F_sPwd);
        }

         /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetListUsertype(string strWhere)
        {
            return dal.GetListUsertype(strWhere);
        }

         /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetListJoin(string strWhere)
        {
            return dal.GetListJoin(strWhere);
        }

         /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetListCategory(string strWhere)
        {
            return dal.GetListCategory(strWhere);
        }
        #endregion  成员方法
    }
}
