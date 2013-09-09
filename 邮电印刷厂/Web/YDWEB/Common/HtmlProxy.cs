using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.IO;

namespace Common
{
    /// <summary>
    /// 动态页面转静态页面
    /// </summary>

    public class HtmlProxy
    {
        public HtmlProxy()
        {
        }
        public static bool ChangeFile(int id)
        {
            string filename = HttpContext.Current.Server.MapPath("Post_" + id + ".html");
            //尝试读取已有文件 
            Stream st = GetFileStream(filename);
            //如果文件存在并且读取成功 
            if (st != null)
            {
                using (st)
                {
                    StreamToStream(st, HttpContext.Current.Response.OutputStream);
                    return true;
                    //Response.End();
                }
            }
            else
            {
                StringWriter sw = new StringWriter();
                HttpContext.Current.Server.Execute("ForumDetail.aspx?PID=" + id, sw);

                string content = sw.ToString();
                //写进文件
                try
                {
                    using (FileStream fs = new FileStream(filename, FileMode.Create, FileAccess.Write, FileShare.Write))
                    {
                        using (StreamWriter stw = new StreamWriter(fs, HttpContext.Current.Response.ContentEncoding))
                        {
                            stw.Write(content);
                        }
                    }
                    return true;
                }
                catch { return false; }
            }
        }

        /// <summary>
        /// 判断文件是否存在
        /// </summary>
        /// <param name="filename">文件页面路径</param>
        /// <returns></returns>
        private static Stream GetFileStream(string filename)
        {
            try
            {
                DateTime dt = File.GetLastWriteTime(filename);
                TimeSpan ts = dt - DateTime.Now;
                if (ts.TotalHours > 1)
                {
                    //一小时后过期
                    return null;
                }
                return new FileStream(filename, FileMode.Open, FileAccess.Read, FileShare.Read);
            }
            catch { return null; }
        }


        static public void StreamToStream(Stream src, Stream dst)
        {
            byte[] buf = new byte[4096];
            while (true)
            {
                int c = src.Read(buf, 0, buf.Length);
                if (c == 0)
                    return;
                dst.Write(buf, 0, c);
            }
        }
    }
}
