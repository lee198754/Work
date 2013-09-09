using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace Common
{
    /// <summary>
    /// 写日志
    /// </summary>
    public class Logs
    {
        /// <summary>
        /// 写日志
        /// </summary>
        /// <param name="LogType">日志类型</param>
        /// <param name="ContentString">日志内容</param>
        public static void WriteLog(string LogType, string ContentString)
        {
            string LogPath = System.Web.HttpContext.Current.Server.MapPath(System.Web.HttpContext.Current.Request.ApplicationPath) + "/Logs/";
            string LogFile = LogPath + DateTime.Now.ToString("yyyy-MM-dd") + ".log";
            if (!Directory.Exists(LogPath))
            {
                //创建日志目录
                Directory.CreateDirectory(LogPath);
            }
            //判断当天日志文件是否存在
            if (!File.Exists(LogFile))
            {
                //创建当天日志文件
                System.IO.FileStream fs = System.IO.File.Create(LogFile);
                fs.Close();
            }
            System.IO.FileInfo LogFileInfo = new FileInfo(LogFile);

            StreamWriter sw = new StreamWriter(LogFileInfo.FullName, true);

            sw.WriteLine(DateTime.Now.ToString() + "   【" + LogType + "】   " + ContentString + "\r\n");

            sw.Close();
        }
    }

}
