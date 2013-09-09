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
using Ser;

public partial class FileTest : System.Web.UI.Page
{
    Service SerCla = new Service();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnBrowse_Click(object sender, EventArgs e)
    {
        string strPath = FileUpload1.PostedFile.FileName.Trim().ToString();
        FileStream fs = new FileStream(strPath, FileMode.Open, FileAccess.Read);
        byte[] byteFile = new byte[fs.Length]; fs.Read(byteFile, 0, (int)fs.Length);
        fs.Close();
        bool fal = SerCla.UpLogdFile("aaa.txt", byteFile);
        if (fal)
        {
            Response.Write("成功");
        }else
        {
            Response.Write("失败");
        }
        //int cont = byteFile.Length;
        //File.WriteAllBytes(@"f:\bg22.jpg", byteFile);

        //Response.Write("成功");
        
        



        //OpenFileDialog ofd = new OpenFileDialog();
        //ofd.Title = "请选择要上传的图片：";
        //ofd.Filter = "All Files(*.*)|*.*|位图(*.bmp)|*.bmp|JPEG(*.jpg)|*.jpg";
        //ofd.ShowDialog();
        //textBox1.Text = ofd.FileName;
        //if (!File.Exists(ofd.FileName))
        //{
        //    MessageBox.Show("文件为空"); return;
        //}
    }



    //private void btnUpLoad_Click(object sender, EventArgs e)
    //{
    //    string strPath = textBox1.Text.ToString().Trim();
    //    FileStream fs = new FileStream(strPath, FileMode.Open, FileAccess.Read);
    //    byte[] byteFile = new byte[fs.Length]; fs.Read(byteFile, 0, (int)fs.Length);
    //    fs.Close();
    //    using (SqlConnection cn = new SqlConnection(@"Server=eplot04\ser;Initial Catalog=Test;uid=sa;pwd=sa"))
    //    {
    //        try
    //        {
    //            SqlCommand cmd = new SqlCommand();
    //            cmd.Connection = cn;
    //            string strSql = "Insert into test(FileName,Img) Values(@FileName,@Img)";
    //            cmd.CommandText = strSql;
    //            //cmd.Parameters.AddWithValue("@FileName", strPath);
    //            //cmd.Parameters.AddWithValue("@Img", byteFile); 
    //            //或者如下 
    //            SqlParameter[] parameters = new SqlParameter[2];
    //            parameters[0] = new SqlParameter("@FileName", SqlDbType.NVarChar, 200);
    //            parameters[0].Value = strPath;
    //            parameters[1] = new SqlParameter("@Img", SqlDbType.Image, int.MaxValue);
    //            parameters[1].Value = byteFile;
    //            cmd.Parameters.AddRange(parameters);
    //            cn.Open();
    //            cmd.ExecuteNonQuery();
    //            cn.Close();
    //            MessageBox.Show("上传成功");
    //        }
    //        catch
    //        {
    //            cn.Close();
    //            MessageBox.Show("上传失败！");
    //        }
    //    }
    //}
}