using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace Common
{
    /// <summary>
    /// д��־
    /// </summary>
    public class Logs
    {
        /// <summary>
        /// д��־
        /// </summary>
        /// <param name="LogType">��־����</param>
        /// <param name="ContentString">��־����</param>
        public static void WriteLog(string LogType, string ContentString)
        {
            string LogPath = System.Web.HttpContext.Current.Server.MapPath(System.Web.HttpContext.Current.Request.ApplicationPath) + "/Logs/";
            string LogFile = LogPath + DateTime.Now.ToString("yyyy-MM-dd") + ".log";
            if (!Directory.Exists(LogPath))
            {
                //������־Ŀ¼
                Directory.CreateDirectory(LogPath);
            }
            //�жϵ�����־�ļ��Ƿ����
            if (!File.Exists(LogFile))
            {
                //����������־�ļ�
                System.IO.FileStream fs = System.IO.File.Create(LogFile);
                fs.Close();
            }
            System.IO.FileInfo LogFileInfo = new FileInfo(LogFile);

            StreamWriter sw = new StreamWriter(LogFileInfo.FullName, true);

            sw.WriteLine(DateTime.Now.ToString() + "   ��" + LogType + "��   " + ContentString + "\r\n");

            sw.Close();
        }
    }

}
