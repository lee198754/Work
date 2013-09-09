using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Common
{
    public class DropDownListBind
    {
        /// <summary>
        /// 数据绑定DropDownList
        /// </summary>
        public bool DListBind(DataTable table, DropDownList DList, string Pamtext, string Pamvalue)
        {
            try
            {
                DList.DataSource = table;
                DList.DataTextField = Pamtext;
                DList.DataValueField = Pamvalue;
                DList.DataBind();
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}
