using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
/// <summary>
/// SQLcs 的摘要说明
/// </summary>
public class SQLcs
{
    public SQLcs()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }

    /// <summary>
    /// 创建数据库连接
    /// </summary>
    /// <returns>返回SQLConnection</returns>
    public static SqlConnection CreateCon()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        return con;
    }

    /// <summary>
    /// 弹出对话框
    /// </summary>
    /// <param name="js">显示的值</param>
    /// <param name="url">跳转的链接</param>
    public static void AlertShow(string js, string url)
    {
        HttpContext.Current.Response.Write("<script>alert('" + js + "');location='" + url + "'</script>");
    }

    /// <summary>
    /// 数据库的插入，删除，更新操作
    /// </summary>
    /// <param name="sql">ＳＱＬ语句</param>
    /// <returns>返回True操作成功；返回False操作失败</returns>
    public static bool DataOperater(string sql)
    {
        SqlConnection con = CreateCon();
        SqlCommand cmd = new SqlCommand(sql, con);
        con.Open();
        try
        {
            cmd.ExecuteNonQuery();
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
        finally
        {
            con.Close();
        }
    }

    /// <summary>
    /// 弹出对话框
    /// </summary>
    /// <param name="js">显示的值</param>
    public static void AlertShow(string js)
    {
        HttpContext.Current.Response.Write("<script>alert('" + js + "')</script>");
    }
}
