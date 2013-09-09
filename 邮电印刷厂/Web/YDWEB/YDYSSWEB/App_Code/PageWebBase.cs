using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// PageWebBase 的摘要说明
/// </summary>
public class PageWebBase : System.Web.UI.Page
{
    public PageWebBase()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }

    #region 页面预初始事件
    /// <summary>
    /// 页面预初始事件
    /// </summary>
    /// <param name="e"></param>
    protected override void OnPreInit(EventArgs e)
    {
        base.OnPreInit(e);
        //this.Theme = "MainTheme";
    }
    #endregion

    #region 页面初始事件
    /// <summary>
    /// 页面初始事件
    /// </summary>
    /// <param name="e"></param>
    protected override void OnInit(EventArgs e)
    {
        //Session["LoginID"] = "admin";
        if (Session["LoginID"] == null || Session["Per"] == null || Session["Code"] == null)
        {
            //Page.Response.Write("<script language='javascript'>alert('您的登录已超时，请重新登录！');window.location=right.aspx?'+Math.random();'</script>");
            //

            Page.Response.Write("<script language='javascript'>alert('您的登录已超时，请重新登录！');window.opener.opener=null;window.opener.close();top.location.href='Login.aspx'</script>");
            Page.Response.End();
            // Page.RegisterStartupScript("", "<script>alert('您的登录已超时，请重新登录！!');window.location=right.aspx?'+Math.random();</script>");
            //Page.Response.Write("<script language='javascript'>alert('您的登陆已超时，请重新登陆！');window.opener=null;window.open('','_self','');window.close();</script>");
            //Page.Response.End();
        }
        base.OnInit(e);
    }
    #endregion
}
