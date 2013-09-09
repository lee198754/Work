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
using System.Data.SqlClient;
using Bll;
using Common;
public partial class Sel_YWTJ : PageWebBase
{
    Message mes = new Message();
    B_SelectList Blist = new B_SelectList();
    Message Mes = new Message();
    DropDownListBind Bind = new DropDownListBind();
    B_Sys_UserInfo Buser = new B_Sys_UserInfo();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                    txt_BegionTime.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    txt_endTime.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    BindDrop();
                    if (Session["LoginName"] != null)
                    {
                        txt_User.Value = Session["LoginName"].ToString();
                    }
                    else
                    {
                        Mes.Alert("登录超时，请重新登陆后查询！", Page);
                        btn_sel.Enabled = false;
                    }
            }
        }
        catch (Exception ex)
        {
            Logs.WriteLog("业务统计加载---错误", ex.Message);
        }

    }
    protected void btn_sel_Click(object sender, EventArgs e)
    {
         try
        {
            DataTable dt = new DataTable();
            dt = Blist.GetYWTJ(txt_BegionTime.Text.ToString() + " 00:00:00", txt_endTime.Text.ToString() + " 23:59:59", int.Parse(DropType.SelectedValue.ToString()), txt_User.Value.Trim().ToString()).Tables[0];
            if (dt.Rows.Count > 0)
            {
                lb_Name.Text = dt.Rows[0]["TITLE"].ToString();
                Label1.Text = dt.Rows[0]["LGMS"].ToString();
                Label2.Text = dt.Rows[0]["LGPKMS"].ToString();
                Label3.Text = dt.Rows[0]["LGXKMS"].ToString();
                Label4.Text = dt.Rows[0]["LGHKFMS"].ToString();
                Label5.Text = dt.Rows[0]["LGHKMS"].ToString();

                Label6.Text = dt.Rows[0]["YFHMS"].ToString();
                Label7.Text = dt.Rows[0]["YFHPKMS"].ToString();
                Label8.Text = dt.Rows[0]["YFHXKMS"].ToString();
                Label9.Text = dt.Rows[0]["YFHHKFMS"].ToString();
                Label10.Text = dt.Rows[0]["YFHHKMS"].ToString();

                Label11.Text = dt.Rows[0]["WFHMS"].ToString();
                Label12.Text = dt.Rows[0]["WFHPKMS"].ToString();
                Label13.Text = dt.Rows[0]["WFHXKMS"].ToString();
                Label14.Text = dt.Rows[0]["WFHHKFMS"].ToString();
                Label15.Text = dt.Rows[0]["WFHHKMS"].ToString();
            }
        }
        catch (Exception ex)
        {
            Logs.WriteLog("业务统计查询---错误", ex.Message);
        }
    }

    public void BindDrop()
    {
        DataTable dt = new DataTable();
        dt = Buser.GetListCategory("").Tables[0];
        Bind.DListBind(dt, DropType, "F_sClassName", "F_iID");
        DropType.Items.Insert(0, new ListItem("全部", "-1"));
    }
}
