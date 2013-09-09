using System;
using System.Collections.Generic;
using System.Text;

namespace Common
{
    public class CutStrings
    {
        ///   <summary>   
        ///   截取字符串(适用于中英文混合)   
        ///   </summary>   
        ///   <param   name="str">原字符串</param>   
        ///   <param   name="len">长度</param>   
        ///   <returns></returns>   
        public static string CutString(string str, int len)
        {
            str = str.Trim();
            byte[] myByte = System.Text.Encoding.Default.GetBytes(str);
            if (myByte.Length > len)
            {
                string result = "";
                for (int i = 0; i < str.Length; i++)
                {
                    byte[] tempByte = System.Text.Encoding.Default.GetBytes(result);
                    if (tempByte.Length < len)
                    {
                        result += str.Substring(i, 1);
                    }
                    else
                    {
                        break;
                    }
                }
                return result + "...";
            }
            else
            {
                return str;
            }
        }

        #region FormatStr 位数不足前不零
        public static string FormatStr(string s1, int s2, int iLen)
        {
            for (int i = s1.Length; i < iLen; i++)
            {
                s1 = Convert.ToString(s2) + s1;
            }
            return s1;
        }
        #endregion

    }
}
