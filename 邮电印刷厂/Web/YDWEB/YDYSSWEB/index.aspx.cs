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
public partial class index : PageWebBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //if (Session["Type"].ToString().Equals("9"))
            //{
            //    td1.Visible = true;
            //    td2.Visible = true;
            //    tdsql.Visible = false;
            //    tdsql2.Visible = false;
            //}
            //if (Request["ID"] != null)
            //{
            //    string strID = Request["ID"].ToString();
            //    if (strID.Equals("1"))
            //    {

            //    }
            //}
            if (Session["Per"] != null)
            {
                tdsql.Visible = false;
                tdsql2.Visible = false;
                string[] str = Session["Per"].ToString().Split(',');
                for (int i = 0; i < str.Length; i++)
                {
                    if (str[i].ToString().Equals("1"))
                    {
                        ywcx.Visible = true;
                        ywcx2.Visible = true;
                    }
                    else if (str[i].ToString().Equals("2"))
                    {
                        ywtj.Visible = true;
                        ywtj2.Visible = true;
                    }
                    else if (str[i].ToString().Equals("3"))
                    {
                        sctj.Visible = true;
                        sctj2.Visible = true;
                    }
                    else if (str[i].ToString().Equals("4"))
                    {
                        td1.Visible = true;
                        td2.Visible = true;
                    }
                    else if (str[i].ToString().Equals("4"))
                    {
                        td1.Visible = true;
                        td2.Visible = true;
                    }
                    else if (str[i].ToString().Equals("5"))
                    {
                        yztxz1.Visible = true;
                        yztxz2.Visible = true;
                    }
                }
            }
        }
    }
}
