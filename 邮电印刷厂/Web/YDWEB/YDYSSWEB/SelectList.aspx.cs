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
public partial class SelectList :PageWebBase
{
    Message mes = new Message();
    B_SelectList BselectList = new B_SelectList();
    #region Load事件
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                //Session["Type"] = "1";
                //lb_DM.Text = "";
                txtType.Value = Session["Type"].ToString();
                lb_DM.Text = Session["Code"].ToString();
                txt_Name.Value = Session["LoginName"].ToString();
                if (lb_DM.Text.Length > 5)
                {
                    txt_code1.Visible = false;
                }
                //if (Session["loginID"] != null)
                //{
                //    txtiCSID.Value = Session["loginID"].ToString();
                //}
                //txtMonth.Value = DateTime.Now.ToString("yyyyMM");
                //txtwhere.Value = " a.get_date_m='" + txtMonth.Value.ToString() + "' ";
                //bindInfo();
            }
        }
        catch (Exception ex)
        {
            Logs.WriteLog("商城新闻---错误", ex.Message);
        }
    }
    #endregion

    #region 加载新闻
    public void bindInfo()
    {
        try
        {
            string cpbh1 = txt_12.Text.Trim().ToString();
            string cpbh2 = "";
            if (string.IsNullOrEmpty(lb_DM.Text))
            {
                cpbh2 = txt_code1.Text.Trim().ToString();
            }
            else
            {
                if (lb_DM.Text.Trim().ToString().Length > 5)
                {
                    cpbh2 = "";
                }
                else
                {
                    cpbh2 = txt_code1.Text.Trim().ToString();
                }
                
            }

            string cpbh3 = txt_13.Text.Trim().ToString();
            string cpbh4 = txt_code2.Text.Trim().ToString();
            string khmc = txt_select.Text.Trim().ToString();
            string Name = txt_Name.Value.Trim().ToString();

            GridView_News.DataSource = null;
            GridView_News.DataBind();
            DataTable dt = new DataTable();
            dt = BselectList.p_webddcx(cpbh1, cpbh2, cpbh3, cpbh4, khmc, Name).Tables[0];
            //if (!string.IsNullOrEmpty(txtwhere.Value))
            //{
            //    dt = BselectList.GetList(txtwhere.Value).Tables[0];
            //}
            //else
            //{
            //    dt = BselectList.GetList("").Tables[0];
            //}

            //DataTable dt2 = new DataTable();

            //if (!string.IsNullOrEmpty(txtwhere2.Value))
            //{
            //    dt2 = BselectList.GetList2(txtwhere2.Value).Tables[0];
            //}
            //else
            //{
            //    dt2 = BselectList.GetList2("").Tables[0];
            //}
            //dt.Merge(dt2, false);

            if (dt.Rows.Count > 0)
            {
                divnum.InnerHtml = "";
                GridView_News.DataSource = dt;
                GridView_News.DataBind();
            }
            else
            {
                divnum.InnerHtml = "<br /><br /><p><center style=\" color:red;\">查询不到该记录</center></p>";
            }
            
        }
        catch (Exception ex)
        {
            Logs.WriteLog("商城新闻---错误", ex.Message);
        }
    }
    #endregion

    #region 数据绑后的行 ----  删除提示
    protected void GridView_News_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
             //如果是绑定数据行
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[7].Text.Trim().ToString().Equals("1"))
                {
                    e.Row.Cells[7].Text = "加印";
                }
                else
                {
                    e.Row.Cells[7].Text = "";
                }
                string str = e.Row.Cells[8].Text.ToString();
                if (!string.IsNullOrEmpty(str) && !str.Equals("&nbsp;"))
                {
                    string[] str2 = str.Split(';');
                    e.Row.Cells[8].Text = str2[1].ToString();
                    e.Row.Cells[9].Text = str2[2].ToString();
                }
                if (!string.IsNullOrEmpty(e.Row.Cells[6].Text.Trim().ToString()))
                {
                    string stnumber = e.Row.Cells[6].Text.Trim().ToString();
                    double number = double.Parse(stnumber) * double.Parse("10000");
                    e.Row.Cells[6].Text = number.ToString("0");
                }
            }
            //如果是绑定数据行
            if (e.Row.RowIndex != -1)
            {
                int id = e.Row.RowIndex + 1;
                e.Row.Cells[0].Text = id.ToString();

            }
        }
        catch (Exception ex)
        {
            Logs.WriteLog("商城新闻---错误", ex.Message);
        }
    }
    #endregion

    #region 分页
    protected void GridView_News_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
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
            bindInfo();
        }
        catch (Exception ex)
        {
            Logs.WriteLog("商城新闻---错误", ex.Message);
        }
    }
    #endregion

    #region 搜索
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            //txtwhere.Value = "";
            //if (string.IsNullOrEmpty(lb_DM.Text.Trim().ToString()))
            //{
            //    txtwhere.Value = " and b.F_sCpbh like '%" + txt_12.Text.Trim().ToString() + "%-%" + txt_code1.Text.Trim().ToString() + "%-%" + txt_13.Text.Trim().ToString() + "%-%" + txt_code2.Text.Trim().ToString() + "%'";
            //}
            //else
            //{
            //    txtwhere.Value = " and b.F_sCpbh like '%" + txt_12.Text.Trim().ToString() + "%-" + lb_DM.Text.Trim().ToString() + txt_code1.Text.Trim().ToString() + "%-%" + txt_13.Text.Trim().ToString() + "%-%" + txt_code2.Text.Trim().ToString() + "%'";
            //}
            //string str1 = "";
            //string str3 = "";
            //if (string.IsNullOrEmpty(txt_code1.Text.Trim().ToString()) && string.IsNullOrEmpty(txt_code2.Text.Trim().ToString()) && string.IsNullOrEmpty(txt_select.Text.Trim().ToString()))
            //{
            //    if (txtType.Value.Equals("2"))
            //    {
            //        txtwhere.Value = " and b.F_sCpbh like '%" + txt_12.Text.Trim().ToString() + "%-%" + lb_DM.Text.Trim().ToString() + str1 + "____%-%" + txt_13.Text.Trim().ToString() + "%-%' ";
            //    }
            //    else if (txtType.Value.Equals("3"))
            //    {
            //        txtwhere.Value = " and b.F_sCpbh like '%" + txt_12.Text.Trim().ToString() + "%-%" + lb_DM.Text.Trim().ToString() + str1 + "__%-%" + txt_13.Text.Trim().ToString() + "%-%' ";
            //    }
            //    else
            //    {
            //        txtwhere.Value = "";
            //    }
            //    txtwhere2.Value = txtwhere.Value;
            //}
            //else
            //{
            //    if (!string.IsNullOrEmpty(txt_code1.Text.Trim().ToString()))
            //    {
            //        int len = 6;
            //        if (txtType.Value.Equals("2"))
            //        {
            //            len = 4;
            //        }
            //        else if (txtType.Value.Equals("3"))
            //        {
            //            len = 2;
            //        }
            //        if (txt_code1.Text.Trim().ToString().Length < 6)
            //        {
            //            len = len - txt_code1.Text.Trim().ToString().Length;
            //        }
            //        else
            //        {
            //            len = 0;
            //        }
            //        str1 = txt_code1.Text.Trim().ToString();
            //        if (len > 0)
            //        {
            //            for (int i = 0; i < len; i++)
            //            {
            //                str1 += "_";
            //            }
            //        }
            //    }
            //    else
            //    {
            //        if (txtType.Value.Equals("2"))
            //        {
            //            str1 = "____";
            //        }
            //        else if (txtType.Value.Equals("3"))
            //        {
            //            str1 = "__";
            //        }
            //        else
            //        {
            //            str1 = "______";
            //        }
            //    }

            //    if (!string.IsNullOrEmpty(txt_code2.Text.Trim().ToString()))
            //    {
            //        //str2 = txt_code2.Text.Trim().ToString();
            //        if (txtType.Value.Equals("2") || txtType.Value.Equals("3"))
            //        {
            //            str3 = txt_12.Text.Trim().ToString() + "%-%" + lb_DM.Text.Trim().ToString() + str1 + "%-%" + txt_13.Text.Trim().ToString() + "%-%" + txt_code2.Text.Trim().ToString() + "%";
            //        }
            //        else
            //        {
            //            str3 = txt_12.Text.Trim().ToString() + "%-%" + str1 + "%-%" + txt_13.Text.Trim().ToString() + "%-%" + txt_code2.Text.Trim().ToString() + "%";
            //        }
            //    }
            //    else
            //    {
            //        if (txtType.Value.Equals("2") || txtType.Value.Equals("3"))
            //        {
            //            str3 = txt_12.Text.Trim().ToString() + "%-%" + lb_DM.Text.Trim().ToString() + str1 + "%-%" + txt_13.Text.Trim().ToString() + "%-%";
            //        }
            //        else
            //        {
            //            str3 = txt_12.Text.Trim().ToString() + "%-%" + str1 + "%-%" + txt_13.Text.Trim().ToString() + "%-%";
            //        }
            //    }
            //    txtwhere.Value = " and b.F_sCpbh like '%" + str3 + "' ";
                //txtwhere2.Value = txtwhere.Value;
                //if (!string.IsNullOrEmpty(txt_select.Text.Trim().ToString()))
                //{
                //    //str3 = txt_select.Text.Trim().ToString();
                //    txtwhere.Value += " and a.F_sKhmc like '%" + txt_select.Text.Trim().ToString() + "%' ";
                //    txtwhere2.Value += " and a.F_sCpmc like '%" + txt_select.Text.Trim().ToString() + "%' ";
                //}
           //}
            bindInfo();
        }
        catch (Exception ex)
        {
            Logs.WriteLog("商城新闻---错误", ex.Message);
        }
    }
    #endregion

    public string GetID(object F_iID)
    {
        return DESEncrypt.Encrypt(F_iID.ToString());
    }

}
