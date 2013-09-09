using System;
using System.Collections.Generic;
using System.Web;

using System.Threading;
using System.IO;
public static class DownloadFile
{
    public static void ResponseFile(string path, HttpContext context,bool hasfileName)
    {
        context = HttpContext.Current;
        //+5+1+a+s+p+x
        System.IO.Stream iStream = null;
        byte[] buffer = new Byte[10000];
        int length;
        long dataToRead;
        string filename;
        if (!hasfileName)
        {
            filename = System.IO.Path.GetFileName(path);
        }
        else
        {
            filename = "down_" + DateTime.Now.ToString("yyyyMMddHHmmss")+".zip";
        }

        try
        {
            iStream = new System.IO.FileStream(path, System.IO.FileMode.Open, System.IO.FileAccess.Read, System.IO.FileShare.Read);
            dataToRead = iStream.Length;
            context.Response.ContentType = "application/octet-stream";
            context.Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8));

            while (dataToRead > 0)
            {
                if (context.Response.IsClientConnected)
                {
                    length = iStream.Read(buffer, 0, 10000);
                    context.Response.OutputStream.Write(buffer, 0, length);
                    context.Response.Flush();

                    buffer = new Byte[10000];
                    dataToRead = dataToRead - length;
                }
                else
                {
                    dataToRead = -1;
                }
            }
        }
        catch (Exception ex)
        {
            context.Response.Write(ex.Message);
        }
        finally
        {
            if (iStream != null)
            {
                iStream.Close();
            }
        }
    }

    #region '输出硬盘文件，提供下载'
    ///<summary>
    /// 输出硬盘文件，提供下载
    /// </summary>
    /// <param name="_Request">Page.Request对象</param>
    /// <param name="_Response">Page.Response对象</param>
    /// <param name="_fileName">下载文件名</param>
    /// <param name="_fullPath">带文件名下载路径</param>
    /// <param name="_speed">每秒允许下载的字节数</param>
    /// <returns>返回是否成功</returns>
    #endregion
    public static bool ResponseFile(HttpRequest _Request, HttpResponse _Response, string _fileName, string _fullPath, long _speed)
    {
        try
        {
            FileStream myFile = new FileStream(_fullPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
            BinaryReader br = new BinaryReader(myFile);
            try
            {
                _Response.AddHeader("Accept-Ranges", "bytes");
                _Response.Buffer = false;
                long fileLength = myFile.Length;
                long startBytes = 0;

                int pack = 10240; //10K bytes
                //int sleep = 200;   //每秒5次   即5*10K bytes每秒
                int sleep = (int)Math.Floor((decimal)1000 * pack / _speed) + 1;
                if (_Request.Headers["Range"] != null)
                {
                    _Response.StatusCode = 206;
                    string[] range = _Request.Headers["Range"].Split(new char[] { '=', '-' });
                    startBytes = Convert.ToInt64(range[1]);
                }
                _Response.AddHeader("Content-Length", (fileLength - startBytes).ToString());
                if (startBytes != 0)
                {
                    _Response.AddHeader("Content-Range", string.Format(" bytes {0}-{1}/{2}", startBytes, fileLength - 1, fileLength));
                }
                _Response.AddHeader("Connection", "Keep-Alive");
                _Response.ContentType = "application/octet-stream";
                _Response.Charset = "UTF-8";
                _Response.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");
                _Response.AddHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(_fileName, System.Text.Encoding.UTF8));

                br.BaseStream.Seek(startBytes, SeekOrigin.Begin);
                int maxCount = (int)Math.Floor((decimal)(fileLength - startBytes) / pack) + 1;

                for (int i = 0; i < maxCount; i++)
                {
                    if (_Response.IsClientConnected)
                    {
                        _Response.BinaryWrite(br.ReadBytes(pack));
                        Thread.Sleep(sleep);
                    }
                    else
                    {
                        i = maxCount;
                    }
                }
                _Response.End();
            }
            catch
            {
                return false;
            }
            finally
            {
                br.Close();
                myFile.Close();
            }
        }
        catch
        {
            return false;
        }
        return true;
    }

}
