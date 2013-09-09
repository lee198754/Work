using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using WebGetID;
public partial class _Default : System.Web.UI.Page 
{
    //WebGetID Webg = new WebGetID();
    PostService postser = new PostService();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
               
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        int type = int.Parse(DropDownList1.SelectedValue.Trim().ToString());
        int State = int.Parse(RadioButtonList1.SelectedValue.Trim().ToString());
        DateTime dt1 = DateTime.Parse(TextBox3.Text.Trim().ToString());
        DateTime dt2 = DateTime.Parse(TextBox4.Text.Trim().ToString());
        DateTime dt3 = dt1;
        do
        {
            string[][] str = postser.getOrderID("wsfj1", "000000", type, State, dt3.ToString("yyyy-MM-dd"));
            
            if (str != null)
            {
                Response.Write("日期为：" + dt3.ToString("yyyy-MM-dd") + "；当天总数为：" + str.Length.ToString() + " 条。<br />");
                for (int i = 0; i < str.Length; i++)
                {
                    Response.Write("计划单ID:" + str[i][0].ToString() + "；<br />");
                    //Response.Write("计划单ID:" + str[i][0].ToString() + "；    计划单单号：" + str[i][1].ToString() + "模式标志：" + str[i][1].ToString() + "<br />");
                }
            }
            else
            {
                Response.Write("日期为：" + dt3.ToString("yyyy-MM-dd") + "；当天总数为：0条。<br />");
                //Response.Write("数据为空!");
            }

            Response.Write("-------------------------------------------------------------------------------------<br />");
            dt3 = dt3.AddDays(1);
        } while (dt3.CompareTo(dt2) < 1);
        //string[][] str = postser.getOrderID("wsfj1", "000000", int.Parse(TextBox1.Text.Trim().ToString()), int.Parse(TextBox2.Text.Trim().ToString()), TextBox3.Text.Trim().ToString());
        //if (str != null)
        //{
        //    for (int i = 0; i < str.Length; i++)
        //    {
        //        Response.Write("计划单ID:" + str[i][0].ToString() + "；计划单单号：" + str[i][1].ToString() + "模式标志：" + str[i][1].ToString() + "<br />");
        //    }
        //}
        //else
        //{
        //    Response.Write("数据为空!");
        //}
    }
}
