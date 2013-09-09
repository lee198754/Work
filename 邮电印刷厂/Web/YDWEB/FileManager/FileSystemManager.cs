using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Text;
using System.Web; 

namespace FileManager
{
    /// <summary>
    /// FileSystemManager
    /// </summary>
    public class FileSystemManager
    {
        private static string strRootFolder;

        static FileSystemManager()
        {
            //strRootFolder = HttpContext.Current.Request.PhysicalApplicationPath + "UserFile\\";
            strRootFolder = ConfigurationManager.AppSettings["strRootFolder"];
            if (strRootFolder.LastIndexOf(@"\") == strRootFolder.Length-1)
            {
                strRootFolder = strRootFolder.Substring(0, strRootFolder.LastIndexOf(@"\"));
            }
            
        }

        /// <summary>
        /// 读根目录
        /// </summary>
        /// <returns></returns>
        public static string GetRootPath()
        {
            return strRootFolder;
        }

        /// <summary>
        /// 写根目录
        /// </summary>
        /// <param name="path"></param>
        public static void SetRootPath(string path)
        {
            strRootFolder = path;
        }

        /// <summary>
        /// 读取列表
        /// </summary>
        /// <returns></returns>
        public static List<FileSystemItem> GetItems()
        {
            return GetItems(strRootFolder);
        }

        /// <summary>
        /// 读取列表
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public static List<FileSystemItem> GetItems(string path)
        {
            string[] folders = Directory.GetDirectories(path);
            string[] files = Directory.GetFiles(path);
            List<FileSystemItem> list = new List<FileSystemItem>();
            foreach (string s in folders)
            {
                FileSystemItem item = new FileSystemItem();
                DirectoryInfo di = new DirectoryInfo(s);
                item.Name = di.Name;
                item.FullName = di.FullName;
                item.CreationDate = di.CreationTime;
                item.IsFolder = false;
                list.Add(item);
            }
            foreach (string s in files)
            {
                FileSystemItem item = new FileSystemItem();
                FileInfo fi = new FileInfo(s);
                item.Name = fi.Name;
                item.FullName = fi.FullName;
                item.CreationDate = fi.CreationTime;
                item.IsFolder = true;
                item.Size = fi.Length;
                list.Add(item);
            }

            if (path.ToLower() != strRootFolder.ToLower())
            {

                FileSystemItem topitem = new FileSystemItem();
                DirectoryInfo topdi = new DirectoryInfo(path).Parent;
                topitem.Name = "[上一级]";
                topitem.FullName = topdi.FullName;
                list.Insert(0, topitem);
            
                FileSystemItem rootitem = new FileSystemItem();
                DirectoryInfo rootdi = new DirectoryInfo(strRootFolder);
                rootitem.Name = "[根目录]";
                rootitem.FullName = rootdi.FullName;
                list.Insert(0, rootitem);
               
            }
            return list;
        }

        /// <summary>
        /// 读取文件夹
        /// </summary>
        /// <param name="name"></param>
        /// <param name="parentName"></param>
        public static void CreateFolder(string name, string parentName)
        {
            DirectoryInfo di = new DirectoryInfo(parentName);
            di.CreateSubdirectory(name);
        }

        /// <summary>
        /// 删除文件夹
        /// </summary>
        /// <param name="path"></param>
        public static bool DeleteFolder(string path)
        {
            try
            {
                Directory.Delete(path);
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 移动文件夹
        /// </summary>
        /// <param name="oldPath"></param>
        /// <param name="newPath"></param>
        public static bool MoveFolder(string oldPath, string newPath)
        {
            try
            {
                Directory.Move(oldPath, newPath);
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 创建文件
        /// </summary>
        /// <param name="filename"></param>
        /// <param name="path"></param>
        public static bool CreateFile(string filename, string path)
        {
            try
            {
                FileStream fs = File.Create(path + "\\" + filename);
                fs.Close();
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 创建文件
        /// </summary>
        /// <param name="filename"></param>
        /// <param name="path"></param>
        /// <param name="contents"></param>
        public static bool CreateFile(string filename, string path, byte[] contents)
        {
            try
            {
                FileStream fs = File.Create(path + "\\" + filename);
                fs.Write(contents, 0, contents.Length);
                fs.Close();
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 读取文件
        /// </summary>
        /// <param name="name"></param>
        /// <param name="parentName"></param>
        public static string OpenText(string parentName)
        {
            StreamReader sr = File.OpenText(parentName);
            StringBuilder output = new StringBuilder();
            string rl;
            while ((rl = sr.ReadLine()) != null)
            {
                output.Append(rl);
            }
            sr.Close();
            return output.ToString();
        }

        /// <summary>
        /// 写入一个新文件，在文件中写入内容，然后关闭文件。如果目标文件已存在，则改写该文件。 
        /// </summary>
        /// <param name="name"></param>
        /// <param name="parentName"></param>
        public static bool WriteAllText(string parentName, string contents)
        {
            try {
            File.WriteAllText(parentName, contents,Encoding.Unicode); 
            return true;         
            }
            catch {
            return false;
            }
        }

        /// <summary>
        /// 删除文件
        /// </summary>
        /// <param name="path"></param>
        public static bool DeleteFile(string path)
        {
            try
            {
                File.Delete(path);
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 移动文件
        /// </summary>
        /// <param name="oldPath"></param>
        /// <param name="newPath"></param>
        public static bool MoveFile(string oldPath, string newPath)
        {
            try
            {
                File.Move(oldPath, newPath);
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 读取文件信息
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public static FileSystemItem GetItemInfo(string path)
        {
            FileSystemItem item = new FileSystemItem();
            if (Directory.Exists(path))
            {
                DirectoryInfo di = new DirectoryInfo(path);
                item.Name = di.Name;
                item.FullName = di.FullName;
                item.CreationDate = di.CreationTime;
                item.IsFolder = true;
                item.LastAccessDate = di.LastAccessTime;
                item.LastWriteDate = di.LastWriteTime;
                item.FileCount = di.GetFiles().Length;
                item.SubFolderCount = di.GetDirectories().Length;
            }
            else
            {
                FileInfo fi = new FileInfo(path);
                item.Name = fi.Name;
                item.FullName = fi.FullName;
                item.CreationDate = fi.CreationTime;
                item.LastAccessDate = fi.LastAccessTime;
                item.LastWriteDate = fi.LastWriteTime;
                item.IsFolder = false;
                item.Size = fi.Length;
            }
            return item;
        }

        /// <summary>
        /// 复制文件夹 5-1-aspx
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static bool CopyFolder(string source, string destination)
        {
            try
            {
                String[] files;
                if (destination[destination.Length - 1] != Path.DirectorySeparatorChar)
                    destination += Path.DirectorySeparatorChar;
                if (!Directory.Exists(destination)) Directory.CreateDirectory(destination);
                files = Directory.GetFileSystemEntries(source);
                foreach (string element in files)
                {
                    if (Directory.Exists(element))
                        CopyFolder(element, destination + Path.GetFileName(element));
                    else
                        File.Copy(element, destination + Path.GetFileName(element), true);
                }
                return true;
            }
            catch
            {
                return false;
            }
        }
        /// <summary>
        /// 判断是否为安全文件名
        /// </summary>
        /// <param name="str">文件名</param>
        /// <returns></returns>
        public static bool IsSafeName(string strExtension)
        {
            strExtension = strExtension.ToLower();//变为小写
            //得到string的.XXX的文件名后缀 LastIndexOf（得到点的位置） Substring（剪切从X的位置）

            if (strExtension.LastIndexOf(".") >= 0)
            { strExtension = strExtension.Substring(strExtension.LastIndexOf(".")); }
            else
            { strExtension = ".txt"; }//如果没有点 就当成txt文件

            //允许上传的扩展名，可以改成从配置文件中读出 
            string[] arrExtension = { ".htm", ".html", ".txt", ".js", ".css", ".xml", ".sitemap", ".jpg", ".gif", ".png", ".rar", ".zip" };

            for (int i = 0; i < arrExtension.Length; i++)
            {
                if (strExtension.Equals(arrExtension[i]))
                {
                    return true;
                }
            }
            return false;
        }
        /// <summary>
        ///  判断是否为不安全文件名
        /// </summary>
        /// <param name="str">文件名、文件夹名</param>
        /// <returns>bool</returns>
        public static bool IsUnsafeName(string strExtension)
        {
            strExtension = strExtension.ToLower();//变为小写
            //得到string的.XXX的文件名后缀 LastIndexOf（得到点的位置） Substring（剪切从X的位置）

            if (strExtension.LastIndexOf(".") >= 0)
            { strExtension = strExtension.Substring(strExtension.LastIndexOf(".")); }
            else
            { strExtension = ".txt"; }//如果没有点 就当成txt文件

            //允许上传的扩展名，可以改成从配置文件中读出 
            string[] arrExtension = { ".", ".asp", ".aspx", ".cs", ".net", ".dll", ".config", ".ascx", ".master", ".asmx", ".asax", ".cd", ".browser", ".rpt", ".ashx", ".xsd", ".mdf", ".resx", ".xsd" };

            for (int i = 0; i < arrExtension.Length; i++)
            {
                if (strExtension.Equals(arrExtension[i]))
                {
                    return true;
                }
            }
            return false;

        }
        /// <summary>
        ///  判断是否为可编辑文件
        /// </summary>
        /// <param name="str">文件名、文件夹名</param>
        /// <returns>bool</returns>
        public static bool IsCanEdit(string strExtension)
        {
            strExtension = strExtension.ToLower();//变为小写
            //得到string的.XXX的文件名后缀 LastIndexOf（得到点的位置） Substring（剪切从X的位置）

            if (strExtension.LastIndexOf(".") >= 0)
            { strExtension = strExtension.Substring(strExtension.LastIndexOf(".")); }
            else
            { strExtension = ".txt"; }//如果没有点 就当成txt文件

            //允许上传的扩展名，可以改成从配置文件中读出 
            string[] arrExtension = { ".htm", ".html", ".txt", ".js", ".css", ".xml", ".sitemap"};

            for (int i = 0; i < arrExtension.Length; i++)
            {
                if (strExtension.Equals(arrExtension[i]))
                {
                    return true;
                }
            }
            return false;
        }
    }
}