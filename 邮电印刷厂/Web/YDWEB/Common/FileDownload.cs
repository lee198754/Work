using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace Common
{
    public class FileDownload
    {
        public static void DownloadFile(string FileName)
        {
            String FullFileName = System.Web.HttpContext.Current.Server.MapPath(FileName);
            FileInfo DownloadFile = new FileInfo(FullFileName);
            System.Web.HttpContext.Current.Response.Clear();
            System.Web.HttpContext.Current.Response.ClearHeaders();
            System.Web.HttpContext.Current.Response.Buffer = false;
            System.Web.HttpContext.Current.Response.ContentType = "application/octet-stream";
            System.Web.HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment;filename=" + System.Web.HttpUtility.UrlEncode(DownloadFile.FullName, System.Text.Encoding.UTF8));
            System.Web.HttpContext.Current.Response.AppendHeader("Content-Length", DownloadFile.Length.ToString());
            System.Web.HttpContext.Current.Response.WriteFile(DownloadFile.FullName);
            System.Web.HttpContext.Current.Response.Flush();
            System.Web.HttpContext.Current.Response.End();
        } 

    }

}
