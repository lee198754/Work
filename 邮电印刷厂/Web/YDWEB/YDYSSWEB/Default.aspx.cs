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
using Bll;
using System.Data;
using System.Data.SqlClient;
public partial class _Default : System.Web.UI.Page
{
    Message Mes = new Message();
    B_Sys_UserInfo Buser = new B_Sys_UserInfo();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                Response.Redirect("Login.aspx", false);
            }
            catch (Exception ex)
            {
                //Mes.Alert("还原失败!", Page);
                Logs.WriteLog("还原错误", ex.Message);
            }

        }


    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try 
        {
            string path=@"Backup\\Police.bak";
            Buser.RestoreDataBase("Police", path);
            Mes.Alert("还原成功!", Page);
        }
        catch (Exception ex) 
        {
            Mes.Alert("还原失败!", Page);
            Logs.WriteLog("还原错误", ex.Message);
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        //SQLDMO.Restore restore = new SQLDMO.RestoreClass();
        //SQLDMO.SQLServer server = new SQLDMO.SQLServerClass();
        ////显示进度条
        //SQLDMO.RestoreSink_PercentCompleteEventHandler progress = new SQLDMO.RestoreSink_PercentCompleteEventHandler(Step);
        //restore.PercentComplete += progress;

        ////KILL DataBase Process
        //SqlConnection conn = new SqlConnection("Server=.;Database=master;User ID=sa;Password=sa;Trusted_Connection=False");
        //conn.Open();
        //SqlCommand cmd = new SqlCommand("SELECT spid FROM sysprocesses ,sysdatabases WHERE sysprocesses.dbid=sysdatabases.dbid AND sysdatabases.Name='test'", conn);
        //SqlDataReader dr;
        //dr = cmd.ExecuteReader();
        //ArrayList list = new ArrayList();
        //while (dr.Read())
        //{
        //    list.Add(dr.GetInt16(0));
        //}
        //dr.Close();
        //for (int i = 0; i < list.Count; i++)
        //{
        //    cmd = new SqlCommand(string.Format("KILL {0}", list), conn);
        //    cmd.ExecuteNonQuery();
        //}
        //conn.Close();

        //try
        //{
        //    server.LoginSecure = false;
        //    server.Connect(".", "sa", "sa");
        //    restore.Action = SQLDMO.SQLDMO_RESTORE_TYPE.SQLDMORestore_Database;
        //    restore.Database = "test";
        //    restore.Files = @"D:\test\myProg\backupTest";
        //    restore.FileNumber = 1;
        //    restore.ReplaceDatabase = true;
        //    restore.SQLRestore(server);
        //    MessageBox.Show("Restore successed.");
        //}
        //catch (Exception ex)
        //{
        //    MessageBox.Show(ex.Message);
        //}
        //finally
        //{
        //    server.DisConnect();
        //}
        //this.pbDB.Value = 0; 

    }
}
