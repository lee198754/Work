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
using System.IO;
using Common;
public partial class managedata : PageWebBase
{
    public string bakpath = HttpContext.Current.Server.MapPath("Backup");
    Message mes = new Message();
    protected void Page_Load(object sender, EventArgs e)
    {
        //AdminCs.CheckLoginState();
        //获取备份文件并添加到DropDownList
        if (!IsPostBack)
        {
            btn_DelFile.Attributes.Add("onclick", "javascript:return confirm('您确定要删除?')");
            DropDownList1.Items.Clear();
            txt_DBName.Value = ConfigurationManager.AppSettings["DbName"].ToString();
            string[] files = Directory.GetFiles(bakpath);
            foreach (string i in files)
            {
                string ii = i.Substring(i.LastIndexOf("\\") + 1);
                DropDownList1.Items.Add(new ListItem(ii));
            }
        }
    }
    //备份数据
    protected void Button1_Click(object sender, EventArgs e)
    {
        string bakname = TextBox1.Text.Trim();
        //去掉文件名中的非法字符
        bakname = bakname.Replace("\\", "").Replace("//", "").Replace("*", "").Replace(":", "").Replace("?", "").Replace("\"", "").Replace("<", "").Replace(">", "").Replace("|", "");
        string sql = "backup database " + txt_DBName.Value + " to disk='" + bakpath + "\\" + bakname + ".bak'";
        try
        {
            if (File.Exists(bakpath + "\\" + bakname + ".bak"))
            {
                SQLcs.AlertShow("此文件已存在，请从新输入！", "managedata.aspx");
                return;
            }
            if (SQLcs.DataOperater(sql))
            {
                SQLcs.AlertShow("备份数据成功！", "managedata.aspx");
            }
        }
        catch(Exception ex)
        {
            SQLcs.AlertShow("备份数据失败！", "managedata.aspx");
            Logs.WriteLog("备份数据失败！", ex.Message);
        }
    }
    //还原备份
    protected void btnreturn_Click(object sender, EventArgs e)
    {
        try
        {
            string str = DropDownList1.SelectedItem.Text;
            if (str == "")
            {
                SQLcs.AlertShow("请选择备份文件！", "managedata.aspx");
            }
            string sql = "ALTER DATABASE " + txt_DBName.Value + " SET SINGLE_USER WITH ROLLBACK IMMEDIATE use master restore database " + txt_DBName.Value + " from disk='" + bakpath + "\\" + str + "'  with replace ALTER DATABASE  " + txt_DBName.Value + " SET MULTI_USER";
            if (SQLcs.DataOperater(sql))
            {
                SQLcs.AlertShow("还原数据成功！", "managedata.aspx");
            }
            else
            {
                SQLcs.AlertShow("还原数据失败！", "managedata.aspx");
            }
        }
        catch (Exception ex)
        {
            
            SQLcs.AlertShow("还原数据失败！", "managedata.aspx");
            Logs.WriteLog("备份数据失败！", ex.Message);
            mes.Alert(ex.Message, Page);
        }
    }
    //下载备份文件
    protected void btndownload_Click(object sender, EventArgs e)
    {
        string url = "backup/" + DropDownList1.SelectedItem.Text.Trim();
        string path = Server.MapPath("backup");
        FileInfo fi = new FileInfo(path + "//" + DropDownList1.SelectedItem.Text.Trim());
        if (fi.Exists)
        {
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;filename=" + Server.UrlEncode(DropDownList1.SelectedItem.Text.Trim()));
            Response.AddHeader("Content-Lenght", fi.Length.ToString());
            Response.ContentType = "application/octet-stream;charset=gb2312";
            Response.Filter.Close();
            Response.WriteFile(fi.FullName);
            Response.End();
        }
    }
    //上传备份
    protected void btnupload_Click(object sender, EventArgs e)
    {
        string filename = FileUpload1.PostedFile.FileName;
        filename = filename.Substring(filename.LastIndexOf("\\") + 1);
        string val = filename.Substring(filename.LastIndexOf(".") + 1);
        if (val != "bak")
        {
            SQLcs.AlertShow("只能上传bak格式的文件！");
            return;
        }
        try
        {
            FileUpload1.SaveAs(bakpath + "\\" + filename);
            SQLcs.AlertShow("上传成功！", "managedata.aspx");
        }
        catch(Exception ex)
        {
            SQLcs.AlertShow("上传失败");
            mes.Alert(ex.Message, Page);
            Logs.WriteLog("错误提示信息", ex.Message);
        }
    }
    protected void btn_DelFile_Click(object sender, EventArgs e)
    {
        string url = "backup/" + DropDownList1.SelectedItem.Text.Trim();
        string path = Server.MapPath("backup");
        FileInfo fi = new FileInfo(path + "//" + DropDownList1.SelectedItem.Text.Trim());
        mes.Alert(path + "//" + DropDownList1.SelectedItem.Text.Trim(), Page);
        if (fi.Exists)
        {
            try
            {
                fi.Delete();
                SQLcs.AlertShow("删除成功！", "managedata.aspx");
            }
            catch(Exception ex)
            {
                SQLcs.AlertShow("删除失败！");
                mes.Alert(ex.Message, Page);
                Logs.WriteLog("删除失败！", ex.Message);
            }
        }
    }
}
