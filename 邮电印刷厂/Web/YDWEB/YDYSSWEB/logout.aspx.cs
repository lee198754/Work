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

public partial class logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
         Response.Buffer = true;
        Response.Expires = 0;
        Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
        Response.Expires = -1;
        Response.CacheControl = "no-cache";
        Request.Cookies.Remove("UserName");
        if (Request["Action"] != null)
        {
            if (Request["Action"].ToString() == "1")
            {
                Session.Clear();
                Session.Abandon();
                Response.Write("<script language=javascript>window.opener=null;window.close();</script>");
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
        else
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}
