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
using Model;
using Common;
using Bll;
public partial class EidtPassWord : PageWebBase
{
    Message Mes = new Message();
    M_Sys_UserInfo MUser = new M_Sys_UserInfo();
    B_Sys_UserInfo BUser = new B_Sys_UserInfo();
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Write("<script language='javascript'>window.parent.topFrame.test('修改密码');</script>");
    }
    #region 保存
    protected void btn_submit_ServerClick(object sender, EventArgs e)
    {
        try
        {

            if (!txt_newpass.Value.Trim().Equals(txt_password.Value.Trim()))
            {
                Mes.Alert("提示", "两次密码输入不一致!", this.Page);
                return;
            }
            string sPass = DESEncrypt.Encrypt(txt_yuanpass.Value.Trim());
            DataTable dt = BUser.GetList("F_sName='" + Request.Cookies["Login_USERID"].Value.ToString() + "'").Tables[0];
            if (dt.Rows.Count > 0)
            {
               MUser.F_sPwd = dt.Rows[0]["F_sPwd"].ToString().Trim();
               MUser.F_iID = int.Parse(dt.Rows[0]["F_iID"].ToString().Trim());
            }
            if (!sPass.Equals(MUser.F_sPwd.Trim()))
            {
                Mes.Alert("提示", "原密码输入错误,请重新输入!", this.Page);
                return;
            }
            string sNewPass = DESEncrypt.Encrypt(txt_newpass.Value.Trim());
            //MUser.F_sName = Request.Cookies["Login_USERID"].Value.ToString();
            MUser.F_sPwd = sNewPass;
            BUser.UpdatePwd(MUser.F_iID, MUser.F_sPwd);
            Mes.Alert("提示", "提交成功!", this.Page);

        }
        catch (Exception ex)
        {
            Mes.Alert("提示", "提交失败!", this.Page);
            Logs.WriteLog("登录失败！", ex.Message);
        }

    }
    #endregion
}

