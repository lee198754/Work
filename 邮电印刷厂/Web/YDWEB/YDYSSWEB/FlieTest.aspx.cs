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
using System.IO;
public partial class FlieTest : System.Web.UI.Page
{
    public string bakpath = HttpContext.Current.Server.MapPath("backup");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //string path = System.Web.HttpContext.Current.Server.MapPath("backup/文件测试.txt");
            string path = @"F:\吴灼峰工作资料\邮电印刷厂查询系统\工程文件\YDYSSWEB\backup\文件测试.txt";
            //using (StreamReader sr = File.OpenText(path))
            //{
            //    string s = "";
            //    while ((s = sr.ReadLine()) != null)
            //    {
            //        //Console.WriteLine(s);
            //        Response.WriteFile(s);
            //    }
            //}
            string str = WriteFile(path);
            Response.WriteFile(str);

            //FileStream stream = new FileStream("backup/文件测试.txt", OpenFile);
        }
    }


    private static bool WriteFile(byte[] byData, string path)
    {
        try
        {
            string filepath = System.Web.HttpContext.Current.Server.MapPath(path);
            if (File.Exists(path))
                File.Delete(path);


            System.IO.FileStream fs = System.IO.File.Create(path);
            fs.Write(byData, 0, byData.Length);
            fs.Flush();
            fs.Close();
            return true;

        }
        catch (Exception ex)
        {
            return false;
        }
        finally
        {

        }
    }
    //生成一个文件
    public static bool CreateFile(string filecontent, string path)
    {
        try
        {
            string filePath = System.Web.HttpContext.Current.Server.MapPath(path);
            if (File.Exists(filePath))
                File.Delete(filePath);
            else
            {
                System.IO.FileStream fs = System.IO.File.Create(path);
                byte[] byContent = System.Text.Encoding.GetEncoding("gb2312").GetBytes(filecontent);
                fs.Write(byContent, 0, byContent.Length);
                fs.Flush();
                fs.Close();
            }
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
        finally
        {
        }
    }
    //读入文件
    public static string WriteFile(string path)
    {
        try
        {
            string filepath = System.Web.HttpContext.Current.Server.MapPath(path);
            if (File.Exists(filepath))
                return "false";
            else
            {
                string fileread = System.IO.File.ReadAllText(filepath, System.Text.Encoding.GetEncoding("gb2312"));
                return fileread;
            }
        }
        catch (Exception ex)
        {
            return "false";
        }
        finally
        {

        }
    }
    //向文件中增加内容
    public static bool UpdateFile(string filecontent, string path)
    {
        try
        {
            string filePath = System.Web.HttpContext.Current.Server.MapPath(path);
            if (!File.Exists(filePath))
            {
                System.IO.FileStream fs = System.IO.File.Create(filePath);
                byte[] byContent = System.Text.Encoding.GetEncoding("gb2312").GetBytes(filecontent);
                fs.Write(byContent, 0, byContent.Length);
                fs.Flush();
                fs.Close();
            }
            System.IO.FileStream files = new System.IO.FileStream(filePath, FileMode.Open, FileAccess.ReadWrite);
            StreamReader sReader = new StreamReader(files, System.Text.Encoding.Default);
            string oldstr = sReader.ReadToEnd();
            oldstr += filecontent;
            //把新的内容重新写入
            StreamWriter sWriter = new StreamWriter(files, System.Text.Encoding.Default);
            sWriter.Write(oldstr);
            sWriter.Flush();
            sWriter.Close();
            sReader.Close();
            files.Close();
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }
    //删除文件
    public static bool Delete(string path)
    {
        try
        {
            string filePath = System.Web.HttpContext.Current.Server.MapPath(path);
            if (File.Exists(path))
                File.Delete(filePath);
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
        finally { }
    }
    //创建文件夹
    public static bool CreateFolder(string FolderName)
    {
        try
        {
            if (FolderName.Trim().Length > 0)
            {
                string folderPath = System.Web.HttpContext.Current.Server.MapPath(FolderName);
                if (!System.IO.Directory.Exists(folderPath))
                {
                    System.IO.Directory.CreateDirectory(folderPath);
                    return true;
                }
                else
                    return false;
            }
            else
                return false;
        }
        catch (Exception ex)
        {
            return false;
        }
        finally { }
    }
    //删除整个文件夹以及整个子文件夹和文件
    public static bool DeleteDirctory(string folderName)
    {
        try
        {
            string filePath = System.Web.HttpContext.Current.Server.MapPath(folderName);
            if (System.IO.Directory.Exists(filePath))
            {
                System.IO.Directory.Delete(filePath);
                return true;
            }
            else
                return false;

        }
        catch (Exception ex)
        {
            return false;
        }
        finally
        {
        }
    }
    //遍历一个目录下的全部目录
    public static DataTable GetDir(string foldername)
    {
        try
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("name", typeof(string));
            dt.Columns.Add("fullName", typeof(string));
            string filePath = System.Web.HttpContext.Current.Server.MapPath(foldername);
            System.IO.DirectoryInfo dir = new DirectoryInfo(filePath);
            foreach (System.IO.FileInfo dchild in dir.GetFiles("*"))
            {
                DataRow dr = dt.NewRow();
                dr["name"] = dchild.Name; //目录名
                dr["fullname"] = dchild.FullName;
                dt.Rows.Add(dr);
            }
            return dt;
        }
        catch (Exception ex)
        {
            return null;
        }
        finally { }
    }


}
