using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Configuration;
using System.IO;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class Service : System.Web.Services.WebService
{
    public static string FilePaht = ConfigurationManager.AppSettings["FilePath"];
    public Service () {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }
    /// <summary>
    /// 文件上传
    /// </summary>
    /// <param name="filename">文件名称</param>
    /// <param name="byteFile">二进制文件流</param>
    /// <returns>是否上传成功</returns>
    [WebMethod]
    public bool UpLogdFile(string filename, byte[] byteFile)
    {
        try
        { 
            File.WriteAllBytes(@""+ FilePaht + filename, byteFile);
        }
        catch
        {
            return false;
        }
        return true;
    }

    
}
