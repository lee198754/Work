using System;
using System.Collections.Generic;
using System.Text;

namespace Common
{
    public class Functions
    {
        #region 判断是否是数字
        /// <summary>
        /// 判断是否是数字
        /// </summary>
        /// <param name="str">字符串</param>
        /// <returns></returns>
        public static bool IsNumeric(string str)
        {
            if (str == null || str.Length == 0)
                return false;
            System.Text.ASCIIEncoding ascii = new System.Text.ASCIIEncoding();
            byte[] bytestr = ascii.GetBytes(str);
            foreach (byte c in bytestr)
            {
                if (c < 48 || c > 57)
                {
                    return false;
                }
            }
            return true;
        }
        #endregion

        #region HTML encode 过滤HTML代码
        /// <summary>
        /// HTML encode 过滤HTML代码
        /// </summary>
        /// <param name="str">string</param>
        /// <returns></returns>
        public static string Encode(string str)
        {
            str = str.Replace("&", "&amp;");
            str = str.Replace("'", "''");
            str = str.Replace("\"", "&quot;");
            str = str.Replace(" ", "&nbsp;");
            str = str.Replace("<", "&lt;");
            str = str.Replace(">", "&gt;");
            str = str.Replace("\n", "<br>");
            return str;
        }
        #endregion

        #region HTML代码 转换HTML encode
        /// <summary>
        /// decode
        /// </summary>
        /// <param name="str">string</param>
        /// <returns></returns>
        public static string Decode(string str)
        {
            str = str.Replace("<br>", "\n");
            str = str.Replace("&gt;", ">");
            str = str.Replace("&lt;", "<");
            str = str.Replace("&nbsp;", " ");
            str = str.Replace("&quot;", "\"");
            return str;
        }
        #endregion

        #region 防SQL注入
        /// <summary>
        /// 防SQL注入
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static string Encodesql(string str)
        {
            str = str.Replace("'", "");
            str = str.Replace(" ", "");
            return str;
        }
        #endregion
        #region 删除字符串最后一个不合法字符
        /// <summary>
        /// 删除字符串最后一个不合法字符
        /// </summary>
        /// <param name="str">传入一个字符串</param>
        /// <returns>返回删除后的字符串，传入参数为空时，返回为空</returns>
        public static string GetString(string str)
        {
                string getstr = "";
                for (int i = str.Length; i > 0; i--)
                {
                    char c = str[i - 1];
                    if (c >= 97 && c <= 122)
                    {
                        getstr = str.Substring(0, i);
                        break;
                    }
                }
                return getstr;
        }
        #endregion

           #region 删除字符串最后一个不合法字符
        /// <summary>
        /// 删除字符串最后一个不合法字符
        /// </summary>
        /// <param name="str">传入一个字符串</param>
        /// <returns>返回删除后的字符串，传入参数为空时，返回为空</returns>
        public static string GetPhnoe(string str)
        {
                string getstr = "";
                for (int i = str.Length; i > 0; i--)
                {
                    char c = str[i - 1];
                    if (c >= 48 && c <= 57)
                    {
                        getstr = str.Substring(0, i);
                        break;
                    }
                }
                return getstr;
        }
        #endregion
    }
}
