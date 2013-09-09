using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Common;
using Bll;
using Model;
public partial class LoginX : System.Web.UI.Page
{
    Message mes = new Message();
    //B_Sys_UserInfo Buser = new B_Sys_UserInfo();
    B_Sys_UserInfo Buser = new B_Sys_UserInfo();
    B_Log_WebLoginLog Blog = new B_Log_WebLoginLog();
    M_Log_WebLoginLog Mlog = new M_Log_WebLoginLog();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //读取Cookies
            if (Request.Cookies["Login_USERID"] != null)
            {
                txt_UserName.Text = Request.Cookies["Login_USERID"].Value.ToString();
            }
        }
    }

    #region 用户登录
    protected void btn_login_Click(object sender, EventArgs e)
    {
        try
        {
            //#region 验证码
            //if (Session["CheckCode"].ToString().ToLower() != this.TextBox3.Text.ToLower())
            //{
            //    Response.Write(Fjeca.Common.JSFunctionString.JS_Alert("您输入的验证码错误。"));
            //    return;
            //}
            //#endregion
            if (txt_UserName.Text.Trim().ToString().Equals("用户名") || string.IsNullOrEmpty(txt_UserName.Text.Trim().ToString()))
            {
                mes.Alert("请输入用户名!", Page);
                return;
            }
            else if (txt_Paw.Text.Trim().ToString().Equals("密码") || string.IsNullOrEmpty(txt_Paw.Text.Trim().ToString()))
            {
                mes.Alert("请输入密码!", Page);
                return;
            }
            else
            {
                DataTable dt = new DataTable();
                dt = Buser.GetList(" F_sName='" + txt_UserName.Text.Trim().ToString() + "' and F_sPwd='" + DESEncrypt.Encrypt(txt_Paw.Text.Trim().ToString()) + "' ").Tables[0];
                if (dt.Rows.Count > 0)
                {
                    //写入Cookies
                    HttpCookie cookieuserid = new HttpCookie("Login_USERID");
                    cookieuserid.Value = dt.Rows[0]["F_sName"].ToString();
                    cookieuserid.Expires = DateTime.Today.AddMonths(3);
                    Response.Cookies.Add(cookieuserid);
                    Session["LoginName"] = dt.Rows[0]["F_sName"].ToString();
                    Session["LoginID"] = dt.Rows[0]["F_iID"].ToString();
                    Session["Type"] = dt.Rows[0]["F_iType"].ToString();
                    Session["Code"] = dt.Rows[0]["F_iCode"].ToString();
                    Session["Per"] = dt.Rows[0]["F_sPermissions"].ToString();
                    Mlog.F_dDate = DateTime.Now;
                    Mlog.F_iUserID = int.Parse(dt.Rows[0]["F_iID"].ToString());
                    Mlog.F_sUserName = dt.Rows[0]["F_sName"].ToString();
                    Mlog.F_sLoginIP = Request.Params["REMOTE_ADDR"].ToString();
                    Blog.Add(Mlog);
                    Response.Redirect("index.aspx", false);
                    Hashtable has = new Hashtable();
                    has = (Hashtable)Application["LoginUser"];
                    if (has.ContainsKey(Session["LoginID"].ToString()))
                    {
                        has.Remove(Session["LoginID"].ToString());
                    }
                    has.Add(Session["LoginID"].ToString(), DateTime.Now);
                    Application["LoginUser"] = has;
                }
                else
                {
                    mes.Alert("登录失败，请检查您的用户名和密码!", Page);
                    return;
                }
            }
        }
        catch (Exception ex)
        {
            Logs.WriteLog("登录失败！", ex.Message);
            return;
        }
    }
    #endregion
}
