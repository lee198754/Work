using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.Adapters;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

namespace Common
{
    public class Message
    {
        public Message()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }
        /// <summary>
        /// 弹出信息
        /// </summary>
        /// <param name="strMsg"></param>
        /// <returns></returns>
        public string Show(string strMsg)
        {

            //这里0就指strMsg这东西,1就是指\这东西.
            return String.Format("<script language={1}javascript{1}>alert({1}{0}{1});</script>", strMsg, "\"");
           //System.Web.UI.Page.RegisterStartupScript("check", "<script>alert(" + strMsg + ");</script>");   
          
        }

        /// 服务器端弹出alert对话框
        /// </summary>
        /// <param name="str_Ctl_Name">获得焦点控件Id值,比如：txt_Name</param>
        /// <param name="str_Message">提示信息,例子："请输入您姓名!"</param>
        /// <param name="page">Page类</param>
        public void Alert(string str_Ctl_Name, string str_Message, Page page)
        {
            page.RegisterStartupScript("", "<script>alert('" + str_Message + "');</script>"); 
            //page.RegisterStartupScript("alert", "<script>alert('" + str_Message + "');document.forms(0)." + str_Ctl_Name + ".focus(); document.forms(0)." + str_Ctl_Name + ".select();</script>");
        }

        /// <summary>
        /// 服务器端弹出confirm对话框,该函数有个弊端,必须放到响应事件的最后,目前没有妥善解决方案
        /// </summary>
        /// <param name="str_Message">提示信息,例子："您是否确认删除!"</param>
        /// <param name="btn">隐藏Botton按钮Id值,比如：btn_Flow</param>
        /// <param name="page">Page类</param>
        public void Confirm(string str_Message, string btn, Page page)
        {
            page.RegisterStartupScript("", "<script> if (confirm('" + str_Message + "')==true){document.forms(0)." + btn + ".click();}</script>");
        }

        /// 服务器端弹出alert对话框
        /// </summary>
        /// <param name="str_Ctl_Name">获得焦点控件Id值,比如：txt_Name</param>
        /// <param name="str_Message">提示信息,例子："请输入您姓名!"</param>
        /// <param name="page">Page类</param>
        public void Alert(string str_Message, Page page)
        {
            page.RegisterStartupScript("", "<script>alert('" + str_Message + "');</script>");
            //page.RegisterStartupScript("alert", "<script>alert('" + str_Message + "');document.forms(0)." + str_Ctl_Name + ".focus(); document.forms(0)." + str_Ctl_Name + ".select();</script>");
        }

        /// <summary>
        ///  服务器端弹出confirm对话框,询问用户准备转向相应操作，包括“确定”和“取消”时的操作
        /// </summary>
        /// <param name="str_Message">提示信息，比如："成功增加数据,单击\"确定\"按钮填写流程,单击\"取消\"修改数据"</param>
        /// <param name="btn_Redirect_Flow">"确定"按钮id值</param>
        /// <param name="btn_Redirect_Self">"取消"按钮id值</param>
        /// <param name="page">Page类</param>
        public void Confirm(string str_Message, string btn_Redirect_Flow, string btn_Redirect_Self, Page page)
        {
            page.RegisterStartupScript("", "<script> if (confirm('" + str_Message + "')==true){document.forms(0)." + btn_Redirect_Flow + ".click();}else{document.forms(0)." + btn_Redirect_Self + ".click();}</script>");
        }

        /// <summary>
        /// 刷新某个桢
        /// </summary>
        /// <param name="Frame">桢名称</param>
        /// <param name="url">连接</param>
        /// <param name="page">page对象</param>
        public void ReloadFrame(string Frame, string url, Page page)
        {
            page.RegisterStartupScript("", "<script language=\"javascript\">parent.frames('" + Frame + "').document.location.href='" + url + "';</script>");
        }

    }
}
