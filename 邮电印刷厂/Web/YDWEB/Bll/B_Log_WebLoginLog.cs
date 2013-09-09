using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using Model;
using Dal;

namespace Bll
{
    public class B_Log_WebLoginLog
    {

        private readonly D_Log_WebLoginLog dal = new D_Log_WebLoginLog();
        public B_Log_WebLoginLog()
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
        public int Add(M_Log_WebLoginLog model)
        {
            return dal.Add(model);
        }

        /// <summary>
        /// 更新一条数据
        /// </summary>
        public void Update(M_Log_WebLoginLog model)
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
        public M_Log_WebLoginLog GetModel(int F_iID)
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
       

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetAllList()
        {
            return GetList("");
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        //public DataSet GetList(int PageSize,int PageIndex,string strWhere)
        //{
        //return dal.GetList(PageSize,PageIndex,strWhere);
        //}

        #endregion  成员方法
    }
}
