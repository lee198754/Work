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
        /// ����Ŀ¼
        /// </summary>
        /// <returns></returns>
        public static string GetRootPath()
        {
            return strRootFolder;
        }

        /// <summary>
        /// д��Ŀ¼
        /// </summary>
        /// <param name="path"></param>
        public static void SetRootPath(string path)
        {
            strRootFolder = path;
        }

        /// <summary>
        /// ��ȡ�б�
        /// </summary>
        /// <returns></returns>
        public static List<FileSystemItem> GetItems()
        {
            return GetItems(strRootFolder);
        }

        /// <summary>
        /// ��ȡ�б�
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
                topitem.Name = "[��һ��]";
                topitem.FullName = topdi.FullName;
                list.Insert(0, topitem);
            
                FileSystemItem rootitem = new FileSystemItem();
                DirectoryInfo rootdi = new DirectoryInfo(strRootFolder);
                rootitem.Name = "[��Ŀ¼]";
                rootitem.FullName = rootdi.FullName;
                list.Insert(0, rootitem);
               
            }
            return list;
        }

        /// <summary>
        /// ��ȡ�ļ���
        /// </summary>
        /// <param name="name"></param>
        /// <param name="parentName"></param>
        public static void CreateFolder(string name, string parentName)
        {
            DirectoryInfo di = new DirectoryInfo(parentName);
            di.CreateSubdirectory(name);
        }

        /// <summary>
        /// ɾ���ļ���
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
        /// �ƶ��ļ���
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
        /// �����ļ�
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
        /// �����ļ�
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
        /// ��ȡ�ļ�
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
        /// д��һ�����ļ������ļ���д�����ݣ�Ȼ��ر��ļ������Ŀ���ļ��Ѵ��ڣ����д���ļ��� 
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
        /// ɾ���ļ�
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
        /// �ƶ��ļ�
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
        /// ��ȡ�ļ���Ϣ
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
        /// �����ļ��� 5-1-aspx
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
        /// �ж��Ƿ�Ϊ��ȫ�ļ���
        /// </summary>
        /// <param name="str">�ļ���</param>
        /// <returns></returns>
        public static bool IsSafeName(string strExtension)
        {
            strExtension = strExtension.ToLower();//��ΪСд
            //�õ�string��.XXX���ļ�����׺ LastIndexOf���õ����λ�ã� Substring�����д�X��λ�ã�

            if (strExtension.LastIndexOf(".") >= 0)
            { strExtension = strExtension.Substring(strExtension.LastIndexOf(".")); }
            else
            { strExtension = ".txt"; }//���û�е� �͵���txt�ļ�

            //�����ϴ�����չ�������Ըĳɴ������ļ��ж��� 
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
        ///  �ж��Ƿ�Ϊ����ȫ�ļ���
        /// </summary>
        /// <param name="str">�ļ������ļ�����</param>
        /// <returns>bool</returns>
        public static bool IsUnsafeName(string strExtension)
        {
            strExtension = strExtension.ToLower();//��ΪСд
            //�õ�string��.XXX���ļ�����׺ LastIndexOf���õ����λ�ã� Substring�����д�X��λ�ã�

            if (strExtension.LastIndexOf(".") >= 0)
            { strExtension = strExtension.Substring(strExtension.LastIndexOf(".")); }
            else
            { strExtension = ".txt"; }//���û�е� �͵���txt�ļ�

            //�����ϴ�����չ�������Ըĳɴ������ļ��ж��� 
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
        ///  �ж��Ƿ�Ϊ�ɱ༭�ļ�
        /// </summary>
        /// <param name="str">�ļ������ļ�����</param>
        /// <returns>bool</returns>
        public static bool IsCanEdit(string strExtension)
        {
            strExtension = strExtension.ToLower();//��ΪСд
            //�õ�string��.XXX���ļ�����׺ LastIndexOf���õ����λ�ã� Substring�����д�X��λ�ã�

            if (strExtension.LastIndexOf(".") >= 0)
            { strExtension = strExtension.Substring(strExtension.LastIndexOf(".")); }
            else
            { strExtension = ".txt"; }//���û�е� �͵���txt�ļ�

            //�����ϴ�����չ�������Ըĳɴ������ļ��ж��� 
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