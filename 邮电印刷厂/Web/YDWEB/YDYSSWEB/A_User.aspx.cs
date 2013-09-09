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
using Bll;
using Model;
using Common;
public partial class A_User : System.Web.UI.Page
{
    B_Sys_UserInfo UserInfo = new B_Sys_UserInfo();
    M_Sys_UserInfo MUserInfo = new M_Sys_UserInfo();
    DropDownListBind Bind = new DropDownListBind();
    Message Mes = new Message();
    public static int F_iID = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindType();
            HttpCookie cookies = HttpContext.Current.Request.Cookies["MotorCook"];
            if (cookies != null)
            {
                txt_cUserName.Value = StringUtil.GetCookid(cookies.Values["UserName"]);

            }
            if (Request["ID"] != null)
            {
                txt_iID.Value = Request["ID"].ToString();
                int iID = int.Parse(txt_iID.Value);
                if (iID > 0)
                {
                    txt_UserName.Enabled = false;
                    MUserInfo = UserInfo.GetModel(iID);
                    GetUser();
                    Reset1.Visible = false;
                }
            }
        }
    }
    #region 提交
    protected void btn_Confrim_Click(object sender, EventArgs e)
    {
        try
        {
            if (ValidateString())
            {
                int iID = int.Parse(txt_iID.Value);
                if (iID == 0)
                {
                    DataTable dt = UserInfo.GetList("F_sName='" + txt_UserName.Text.Trim() + "'").Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        Mes.Alert("用户名【" + txt_UserName.Text.Trim() + "】已存在！", this.Page);
                        return;
                    }
                    //F_iID = UserInfo.GetMaxId();
                    ConfrimUser();
                    UserInfo.Add(MUserInfo);
                }
                else
                {
                    DataTable dt = UserInfo.GetList("F_sName='" + txt_UserName.Text.Trim() + "' and F_iID<>" + iID + "").Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        Mes.Alert("用户名【" + txt_UserName.Text.Trim() + "】已存在！", this.Page);
                        return;
                    }
                    F_iID = iID;
                    ConfrimUser();
                    UserInfo.Update(MUserInfo);
                }
                Celar();
                //Mes.Alert("提交成功！", this.Page);
                Page.Response.Write("<script language='javascript'>alert('提交成功！');top.location.href='UserList.aspx'</script>");
                
            }
        }
        catch (Exception ex)
        {
            Mes.Alert("提交失败！", this.Page);
            Logs.WriteLog("错误", ex.Message);
        }
    }
    #endregion

    #region 验证信息
    /// <summary>
    /// 验证信息
    /// </summary>
    public bool ValidateString()
    {
        try
        {
            if (string.IsNullOrEmpty(txt_UserName.Text.Trim()))
            {
                Mes.Alert("用户名不能为空!", this.Page);
                return false;
            }
            if (string.IsNullOrEmpty(txt_Password.Text.Trim()))
            {
                Mes.Alert("密码不能为空!", this.Page);
                return false;
            }
            if (txt_Password.Text.Trim().Length < 6 || txt_Password.Text.Trim().Length > 17)
            {
                Mes.Alert("密码长度为：≥6,≤16位!", this.Page);
                return false;
            }
            if (!StringUtil.IsPaw(txt_Password.Text.Trim()))
            {
                Mes.Alert("密码只能是字母、数字和下划线!", this.Page);
                return false;
            }

            if (DL_Sex.SelectedValue.ToString().Equals("2") || DL_Sex.SelectedValue.ToString().Equals("3"))
            {
                if (string.IsNullOrEmpty(txt_Phone.Text.Trim().ToString()))
                {
                    Mes.Alert("代码不能为空!", this.Page);
                    return false;
                }
            }
            //if (string.IsNullOrEmpty(txt_Name.Text.Trim()))
            //{
            //    Mes.Alert("姓名不能为空!", this.Page);
            //    return false;
            //}
            //if (!string.IsNullOrEmpty(txt_Phone.Text.Trim()))
            //{
            //    if (!StringUtil.IsPhoneOrMobile(txt_Phone.Text.Trim()))
            //    {
            //        Mes.Alert("电话格式有勿!", this.Page);
            //        return false;
            //    }
            //}
            //if (!string.IsNullOrEmpty(txt_Email.Text.Trim()))
            //{
            //    if (!StringUtil.IsEmail(txt_Email.Text.Trim()))
            //    {
            //        Mes.Alert("邮箱格式有勿!", this.Page);
            //        return false;
            //    }
            //}
            return true;
        }
        catch (Exception ex)
        {
            Logs.WriteLog("错误", ex.Message);
            return false;

        }
    }
    #endregion

    #region 获取用户信息
    public void GetUser()
    {
        txt_UserName.Text = MUserInfo.F_sName;
        txt_Password.Attributes.Add("value", DESEncrypt.Decrypt(MUserInfo.F_sPwd));
        //txt_Password.Text = DESEncrypt.Decrypt(MUserInfo.F_sPwd);
        txt_Phone.Text = MUserInfo.F_iCode;
        DL_Sex.SelectedValue = MUserInfo.F_iType.ToString();
        txt_F_sText1.Text = MUserInfo.F_sText1;
        txt_Name.Text = MUserInfo.F_sUserName.ToString();
        txt_RealName.Text = MUserInfo.F_sRealName.ToString();
        SetValue(MUserInfo.F_sPermissions.Trim().ToString(), CheckBoxList1);

    }
    #endregion

    #region 提交用户信息
    public void ConfrimUser()
    {
        MUserInfo.F_iID = F_iID;
        MUserInfo.F_sPwd = DESEncrypt.Encrypt(txt_Password.Text);
        MUserInfo.F_sName = txt_UserName.Text.Trim().ToString();
        MUserInfo.F_iType = int.Parse(DL_Sex.SelectedValue.ToString());
        MUserInfo.F_iCode = txt_Phone.Text.Trim().ToString();
        MUserInfo.F_sText = DateTime.Now.ToString();
        MUserInfo.F_sText1 = txt_F_sText1.Text.Trim().ToString();
        MUserInfo.F_sUserName = txt_Name.Text.Trim().ToString();
        MUserInfo.F_sRealName = txt_RealName.Text.Trim().ToString();
        MUserInfo.F_sPermissions = GetChkvalue(CheckBoxList1);
        
    }
    #endregion

    #region 返回
    protected void btn_Return_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("UserList.aspx", false);
        }
        catch (Exception ex)
        {
            Logs.WriteLog("错误", ex.Message);
        }
    }
    #endregion

    public void Celar()
    {
        txt_UserName.Text = "";
        txt_Phone.Text = "";
        txt_Password.Text = "";
        DL_Sex.SelectedValue = "3";
        txt_F_sText1.Text = "";
        txt_Name.Text = "";
        txt_RealName.Text = "";
    }

    public void BindType()
    {
        DataTable dt = new DataTable();
        dt = UserInfo.GetListUsertype("").Tables[0];
        if (dt.Rows.Count > 0)
        {
            Bind.DListBind(dt, DL_Sex, "F_sName", "F_iID");
        }
    }

    #region 设置复选框单个选中项
    /// <summary>
    /// 设置复选框
    /// </summary>
    /// <param name="st"></param>
    public void SetChked(string st, CheckBoxList chklist)
    {
        try
        {
            foreach (ListItem li in chklist.Items)
            {
                if (li.Value.Equals(st))
                {
                    li.Selected = true;
                }
            }
        }
        catch (Exception ex)
        {
            Logs.WriteLog("错误", ex.Message);
        }
    }
    #endregion

    #region 设置一个复选框的值
    public void SetValue(string strperID, CheckBoxList chklist)
    {
        try
        {
            if (!string.IsNullOrEmpty(strperID))
            {
                string[] strID = strperID.Split(',');
                for (int i = 0; i < strID.Length; i++)
                {
                    SetChked(strID[i].ToString(), chklist);
                }
            }

        }
        catch (Exception ex)
        {
            Logs.WriteLog("设置复选框值错误！", ex.Message);
        }
    }
    #endregion
    #region 获取复选框的值
    public string GetChkvalue(CheckBoxList chklist)
    {
        string str = "";
        try
        {
            foreach (ListItem li in chklist.Items)
            {
                if (li.Selected == true)
                {
                    if (str.Equals(""))
                    {
                        str = li.Value.ToString();
                    }
                    else
                    {
                        str += "," + li.Value.ToString();
                    }
                }

            }
        }
        catch (Exception ex)
        {
            Logs.WriteLog("获取复选框的值错误！", ex.Message);
        }
        return str;
    }
    #endregion
}
