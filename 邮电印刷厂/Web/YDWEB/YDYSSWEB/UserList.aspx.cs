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
using Common;
public partial class UserList : PageWebBase
{
    B_Sys_UserInfo UserInfo = new B_Sys_UserInfo();
    Message Mes = new Message();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindUser();
        }
    }

    #region 绑定用户列表
    public void BindUser()
    {
        try
        {
            GridView_UserName.DataSource = null;
            GridView_UserName.DataBind();
            DataTable dt = UserInfo.GetListJoin("").Tables[0];
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows.Count > GridView_UserName.PageSize)
                {
                    GridView_UserName.AllowPaging = true;
                }
                else
                {
                    GridView_UserName.AllowPaging = false;
                }
                GridView_UserName.DataSource = dt.DefaultView;
                GridView_UserName.DataBind();
            }
        }
        catch (Exception ex)
        {
            Logs.WriteLog("Error", ex.Message);
        }
    }
    #endregion

    #region 分页
    protected void GridView_UserName_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView theGrid = sender as GridView;
        int newPageIndex = 0;
        if (-2 == e.NewPageIndex)
        {
            TextBox txtNewPageIndex = null;
            GridViewRow pagerRow = theGrid.BottomPagerRow;
            if (null != pagerRow)
            {
                txtNewPageIndex = pagerRow.FindControl("txtNewPageIndex") as TextBox;
            }
            if (null != txtNewPageIndex)
            {
                try
                {
                    newPageIndex = int.Parse(txtNewPageIndex.Text) - 1;
                }
                catch
                {
                    newPageIndex = 0;
                }
            }
        }
        else
        {
            newPageIndex = e.NewPageIndex;
        }
        newPageIndex = newPageIndex < 0 ? 0 : newPageIndex;
        newPageIndex = newPageIndex >= theGrid.PageCount ? theGrid.PageCount - 1 : newPageIndex;
        theGrid.PageIndex = newPageIndex;
        BindUser();

    }
    #endregion

    #region 删除
    protected void GridView_UserName_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            int iID = int.Parse(GridView_UserName.DataKeys[e.RowIndex].Values[0].ToString());
            string UserName = GridView_UserName.DataKeys[e.RowIndex].Values[1].ToString();
            if (UserName.Trim().Equals("admin"))
            {
                Mes.Alert("超级管理员不能删除！", this.Page);
                return;
            }
            else
            {
                UserInfo.Delete(iID);
                BindUser();
            }
        }
        catch (Exception ex)
        {
            Logs.WriteLog("错误", ex.Message);
        }
    }

    protected void GridView_UserName_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        try
        {
            //如果是绑定数据行 
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate)
                {
                    e.Row.Cells[7].Attributes.Add("onclick", "javascript:return confirm('删除用户?')");
                    //string str =e.Row.Cells[1].Text.Trim().ToString();
                    //if (str.Equals("1"))
                    //{
                    //    e.Row.Cells[1].Text = "集团用户";
                    //}
                    //else if(str.Equals("2"))
                    //{
                    //    e.Row.Cells[1].Text = "省级用户";
                    //}
                    //else if (str.Equals("3"))
                    //{
                    //    e.Row.Cells[1].Text = "市级用户";
                    //}
                    //else
                    //{
                    //    e.Row.Cells[1].Text = "超级管理员";
                    //}
                }
            }
        }
        catch (Exception ex)
        {
            Logs.WriteLog("错误", ex.Message);
        }
    }
    #endregion

    #region 编辑
    protected void GridView_UserName_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            int iID = int.Parse(GridView_UserName.DataKeys[e.NewEditIndex].Values[0].ToString());
            Response.Redirect("A_User.aspx?ID=" + iID.ToString(), false);
        }
        catch (Exception ex)
        {
            Logs.WriteLog("Error", ex.Message);
        }
    }
    #endregion
}