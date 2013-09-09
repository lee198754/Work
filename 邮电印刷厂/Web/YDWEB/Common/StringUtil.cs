using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Drawing;
using System.Web;
using System.Web.Security;

namespace Common
{
   public  class StringUtil
   {
       private static string passWord;	//加密字符串

       #region 是否位正确的日期时间格式
       /// <summary>
       /// 是否位正确的日期时间格式
       /// </summary>
       /// <returns>true</returns>
       public static bool IsDataformat(string str)
       {
           if (str == null) return false;
           if (str == "") return false;

           try
           {
               System.Convert.ToDateTime(str.Trim());
               return true;
           }
           catch
           {
               return false;
           }


       }
       #endregion

       #region 校验输入字串是否是正数
       /// <summary>
       /// 校验输入字串是否是正数
       /// </summary>
       /// <param name="strIn"></param>
       /// <returns></returns>
       public static bool IsInteger(string strIn)
       {
           if (Regex.IsMatch(strIn, @"^[0-9]+$"))
               return true;
           return false;
       }
       #endregion

       #region 校验输入字串是否是正数（小数或整数）
       /// <summary>
       /// 校验输入字串是否是正数（小数或整数）
       /// </summary>
       public static bool IsPosNumber(string strIn)
       {
           if (Regex.IsMatch(strIn, @"^[0-9]*\.{0,1}[0-9]+$"))
               return true;
           return false;
       }
       #endregion

       #region 中国公民身份证号码
       /// <summary>
       /// 中国公民身份证号码
       /// </summary>
       /// <returns>true</returns>
       public static bool IsPersonIDCard(string str)
       {
           if (str == null) return false;
           if (str == "") return false;

           str = str.Trim();
           if (str.Length != 18 && str.Length != 16) return false;//长度检查

           for (int i = 0; i < str.Length; i++)
           {
               if ("0123456789".IndexOf(str.Substring(i, 1)) == -1)
               {
                   return false;
               }
           }

           return true;
       }
       #endregion

       #region 邮件编码
       /// <summary>
       /// 邮件编码
       /// </summary>
       /// <param name="str"></param>
       /// <returns></returns>
       public static bool IsPostCode(string str)
       {
           if (str == null) return false;
           if (str == "") return false;
           if (Regex.IsMatch(str, @"\d{6}"))
               return true;
           else
               return false;
       }
       #endregion

       #region 验证电话
       /// <summary>
       /// 验证电话
       /// </summary>
       /// <param name="str"></param>
       /// <returns></returns>
       public static bool IsPhone(string str)
       {
           if (str == null) return false;
           if (str == "") return false;
           if (Regex.IsMatch(str, @"(\(\d{3}\)|\d{3}-)?\d{8}"))
               return true;
           else
               return false;
       }
       #endregion

       #region 验证电话和手机
       /// <summary>
       /// 验证电话和手机
       /// </summary>
       /// <param name="str"></param>
       /// <returns></returns>
       public static bool IsPhoneOrMobile(string str)
       {
           if (str == null) return false;
           if (str == "") return false;
           if (Regex.IsMatch(str, @"(^[0-9]{3,4}\-[0-9]{3,8}$)|(^[0-9]{3,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)|(^(13[0-9]|15[0|3|6|8|9])\d{8}$)"))
               return true;
           else
               return false;
       }
       #endregion

       #region 中国电子邮件地址
       /// <summary>
       /// 中国电子邮件地址
       /// </summary>
       /// <returns>true</returns>
       public static bool IsEmail(string str)
       {
           if (str == null) return false;
           if (str == "") return false;
           if (Regex.IsMatch(str, @"\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"))
               return true;
           else
               return false;
       }
       #endregion

       #region 检查是否为32位整数
       /// <summary>
       /// 检查是否为32位整数
       /// </summary>
       /// <returns>true</returns>
       public static bool IsInt32(string str)
       {
           if (str == null) return false;
           if (str == "") return false;

           try
           {
               System.Convert.ToInt32(str.Trim());
               return true;
           }
           catch
           {
               return false;
           }
       }
       #endregion

       #region 检查是否为64位整数
       /// <summary>
       /// 检查是否为64位整数
       /// </summary>
       /// <returns>true</returns>
       public static bool IsInt64(string str)
       {
           if (str == null) return false;
           if (str == "") return false;

           try
           {
               System.Convert.ToInt64(str.Trim());
               return true;
           }
           catch
           {
               return false;
           }

       }
       #endregion

       #region HTML encode 过滤HTML代码
       /// <summary>
       /// HTML encode 过滤HTML代码
       /// </summary>
       /// <param name="inputString"></param>
       /// <returns></returns>
       public static string OutputText(string inputString)
       {
           string retVal = inputString;
           retVal = retVal.Replace("&", "&amp;");
           retVal = retVal.Replace("\"", "&quot;");
           retVal = retVal.Replace("<", "&lt;");
           retVal = retVal.Replace(">", "&gt;");
           retVal = retVal.Replace(" ", "&nbsp;");
           retVal = retVal.Replace("  ", "");
           retVal = retVal.Replace("\t", "");
           retVal = retVal.Replace("\r", "<br>");
           retVal = retVal.Replace("\n", "<br>");
           retVal = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + retVal;
           return retVal;
       }

       public static string OutputString(string inputString)
       {
           string retVal = inputString;
           //retVal = retVal.Replace("&", "&amp;");
           // retVal = retVal.Replace("\"", "&quot;");
           //retVal = retVal.Replace("<", "&lt;");
           //retVal = retVal.Replace(">", "&gt;");
           retVal = retVal.Replace("  ", "&nbsp; ");
           // retVal = retVal.Replace("  ", " ");
           // retVal = retVal.Replace("\t", "");
           retVal = retVal.Replace("\r", "");
           retVal = retVal.Replace("\n", "<br>");
           return retVal;
       }
       #endregion

       #region 对字符串进行HTML解码
       /// <summary>
       /// 对字符串进行HTML解码
       /// </summary>
       /// <param name="str"></param>
       /// <returns></returns>

       public static string Decode(string str)
       {
           str = str.Replace("<br>", "\n");
           str = str.Replace("&gt;", ">");
           str = str.Replace("&nbsp;", "<");
           str = str.Replace("&nbsp;", "");
           str = str.Replace("&quot;", "\"");
           return str;
       }
       #endregion

       #region 返回文本编辑器替换后的字符串
       /// <summary>
       /// 返回文本编辑器替换后的字符串
       /// </summary>
       /// <param name="str">要替换的字符串</param>
       /// <returns></returns>
       static public string GetHtmlEditReplace(string str)
       {
           return str.Replace("'", "''").Replace("&nbsp;", " ").Replace(",", "，").Replace("%", "％").Replace("script", "").Replace(".js", "");
       }
       #endregion

       #region 截取字符串函数
       /// <summary>
       /// 截取字符串函数
       /// </summary>
       /// <param name="str">所要截取的字符串</param>
       /// <param name="num">截取字符串的长度</param>
       /// <returns></returns>
       static public string GetSubString(string str, int num)
       {
           return (str.Length > num) ? str.Substring(0, num) + "..." : str;
       }
       #endregion
       #region 截取字符串函数
       /// <summary>
       /// 截取字符串函数
       /// </summary>
       /// <param name="str">所要截取的字符串</param>
       /// <param name="num">截取字符串的长度</param>
       /// <returns></returns>
       static public string sGetSubString(string str, int num)
       {
           return (str.Length > num) ? str.Substring(0, num) + "**" : str;
       }
       #endregion

       #region 过滤输入信息
       /// <summary>
       /// 过滤输入信息
       /// </summary>
       /// <param name="text">内容</param>
       /// <param name="maxLength">最大长度</param>
       /// <returns></returns>
       public static string InputText(string text, int maxLength)
       {
           text = text.Trim();
           if (text == null && text == "")
               return string.Empty;
           if (text.Length > maxLength)
               text = text.Substring(0, maxLength);
           text = Regex.Replace(text, "[\\s]{2,}", " ");	//two or more spaces
           text = Regex.Replace(text, "(<[b|B][r|R]/*>)+|(<[p|P](.|\\n)*?>)", "\n");	//<br>
           text = Regex.Replace(text, "(\\s*&[n|N][b|B][s|S][p|P];\\s*)+", " ");	//&nbsp;
           text = Regex.Replace(text, "<(.|\\n)*?>", string.Empty);	//any other tags
           text = text.Replace("'", "''");
           return text;
       }
       #endregion

       #region 生成随机数
       /// <summary>
       /// 生成随机数
       /// </summary>
       /// <returns></returns>
       private string GenerateCheckCode()
       {
           int number;
           char code;
           string checkCode = String.Empty;

           System.Random random = new Random();

           for (int i = 0; i < 5; i++)
           {
               number = random.Next();

               if (number % 2 == 0)
                   code = (char)('0' + (char)(number % 10));
               else
                   code = (char)('A' + (char)(number % 26));

               checkCode += code.ToString();
           }

           HttpContext.Current.Response.Cookies.Add(new HttpCookie("CheckCode", checkCode));

           return checkCode;
       }

       #endregion

       #region 生成验证码图片
       /// <summary>
       /// 生成验证码图片
       /// </summary>
       public void CreateCheckCodeImage()
       {
           #region
           string checkCode = GenerateCheckCode();
           if (checkCode == null || checkCode.Trim() == String.Empty)
               return;

           System.Drawing.Bitmap image = new System.Drawing.Bitmap((int)Math.Ceiling((checkCode.Length * 12.5)), 22);
           Graphics g = Graphics.FromImage(image);

           try
           {
               //生成随机生成器
               Random random = new Random();

               //清空图片背景色
               g.Clear(Color.White);

               //画图片的背景噪音线
               for (int i = 0; i < 25; i++)
               {
                   int x1 = random.Next(image.Width);
                   int x2 = random.Next(image.Width);
                   int y1 = random.Next(image.Height);
                   int y2 = random.Next(image.Height);

                   g.DrawLine(new Pen(Color.Silver), x1, y1, x2, y2);
               }

               Font font = new System.Drawing.Font("Arial", 12, (System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic));
               System.Drawing.Drawing2D.LinearGradientBrush brush = new System.Drawing.Drawing2D.LinearGradientBrush(new Rectangle(0, 0, image.Width, image.Height), Color.Blue, Color.DarkRed, 1.2f, true);
               g.DrawString(checkCode, font, brush, 2, 2);

               //画图片的前景噪音点
               for (int i = 0; i < 100; i++)
               {
                   int x = random.Next(image.Width);
                   int y = random.Next(image.Height);

                   image.SetPixel(x, y, Color.FromArgb(random.Next()));
               }

               //画图片的边框线
               g.DrawRectangle(new Pen(Color.Silver), 0, 0, image.Width - 1, image.Height - 1);

               System.IO.MemoryStream ms = new System.IO.MemoryStream();
               image.Save(ms, System.Drawing.Imaging.ImageFormat.Gif);
               HttpContext.Current.Response.ClearContent();
               HttpContext.Current.Response.ContentType = "image/Gif";
               HttpContext.Current.Response.BinaryWrite(ms.ToArray());
           }
           finally
           {
               g.Dispose();
               image.Dispose();
           }
           #endregion
       }
       #endregion

       #region 获取汉字第一个拼音
       /// <summary>
       /// 获取汉字第一个拼音
       /// </summary>
       /// <param name="input"></param>
       /// <returns></returns>
       static public string getSpells(string input)
       {
           int len = input.Length;
           string reVal = "";
           for (int i = 0; i < len; i++)
           {
               reVal += getSpell(input.Substring(i, 1));
           }
           return reVal;
       }
       static public string getSpell(string cn)
       {
           byte[] arrCN = Encoding.Default.GetBytes(cn);
           if (arrCN.Length > 1)
           {
               int area = (short)arrCN[0];
               int pos = (short)arrCN[1];
               int code = (area << 8) + pos;
               int[] areacode = { 45217, 45253, 45761, 46318, 46826, 47010, 47297, 47614, 48119, 48119, 49062, 49324, 49896, 50371, 50614, 50622, 50906, 51387, 51446, 52218, 52698, 52698, 52698, 52980, 53689, 54481 };
               for (int i = 0; i < 26; i++)
               {
                   int max = 55290;
                   if (i != 25) max = areacode[i + 1];
                   if (areacode[i] <= code && code < max)
                   {
                       return Encoding.Default.GetString(new byte[] { (byte)(65 + i) });
                   }
               }
               return "?";
           }
           else return cn;
       }
       #endregion

       #region 半角转全角
       /// <summary>
       ///  半角转全角
       /// </summary>
       /// <param name="BJstr"></param>
       /// <returns></returns>
       static public string GetQuanJiao(string BJstr)
       {
           char[] c = BJstr.ToCharArray();
           for (int i = 0; i < c.Length; i++)
           {
               byte[] b = System.Text.Encoding.Unicode.GetBytes(c, i, 1);
               if (b.Length == 2)
               {
                   if (b[1] == 0)
                   {
                       b[0] = (byte)(b[0] - 32);
                       b[1] = 255;
                       c[i] = System.Text.Encoding.Unicode.GetChars(b)[0];
                   }
               }
           }

           string strNew = new string(c);
           return strNew;

       }
       #endregion

       #region 全角转半角
       /// <summary>
       /// 全角转半角
       /// </summary>
       /// <param name="QJstr"></param>
       /// <returns></returns>
       static public string GetBanJiao(string QJstr)
       {
           char[] c = QJstr.ToCharArray();
           for (int i = 0; i < c.Length; i++)
           {
               byte[] b = System.Text.Encoding.Unicode.GetBytes(c, i, 1);
               if (b.Length == 2)
               {
                   if (b[1] == 255)
                   {
                       b[0] = (byte)(b[0] + 32);
                       b[1] = 0;
                       c[i] = System.Text.Encoding.Unicode.GetChars(b)[0];
                   }
               }
           }
           string strNew = new string(c);
           return strNew;
       }
       #endregion

       #region 加密的类型
       /// <summary>
       /// 加密的类型
       /// </summary>
       public enum PasswordType
       {
           SHA1,
           MD5
       }
       #endregion

       #region 字符串加密
       /// <summary>
       /// 字符串加密
       /// </summary>
       /// <param name="PasswordString">要加密的字符串</param>
       /// <param name="PasswordFormat">要加密的类别</param>
       /// <returns></returns>
       static public string EncryptPassword(string PasswordString, string PasswordFormat)
       {
           #region
           switch (PasswordFormat)
           {
               case "SHA1":
                   {
                       passWord = FormsAuthentication.HashPasswordForStoringInConfigFile(PasswordString, "SHA1");
                       break;
                   }
               case "MD5":
                   {
                       passWord = FormsAuthentication.HashPasswordForStoringInConfigFile(PasswordString, "MD5");
                       break;
                   }
               default:
                   {
                       passWord = string.Empty;
                       break;
                   }
           }
           return passWord;
           #endregion
       }
       #endregion

       #region 用于解密用户密码
       /// <summary>
       /// 用于解密用户密码
       /// </summary>
       /// <param name="password"></param>
       /// <returns></returns>
       public static string Decrypt(string password)
       {
           string str = "";
           str = FormsAuthentication.Decrypt(password).Name.ToString();
           return str;
       }
       #endregion

       #region 对cookie进行UTF编码
       /// <summary>
       /// 对cookie进行UTF编码
       /// </summary>
       /// <param name="str"></param>
       /// <returns></returns>
       public static string GetCookid(string str)
       {
           Encoding stre = Encoding.GetEncoding("UTF-8");
           return HttpUtility.UrlDecode(str, stre);
       }
       #endregion

       #region 生成随机数
       /// <summary>
       /// 生成随机数
       /// </summary>
       /// <param name="length"></param>
       /// <returns></returns>
       public static string GenerateRandomString(int length)
       {
           System.Text.StringBuilder MyStringBuilder = new System.Text.StringBuilder();
           char[] chars = "0123456789ABCDEFHJKLMNOPQRSTUVWXYZ".ToCharArray();
           int index;
           Random rnd = new Random();
           for (int i = 0; i < length; i++)
           {
               index = rnd.Next(chars.Length);
               MyStringBuilder.Append(chars[index].ToString());
           }
           return MyStringBuilder.ToString();
       }

       #endregion

       #region 验证用户密码
       /// <summary>
       /// 验证用户密码："^[a-zA-Z]\w{5,17}$"正确格式为：
       /// 以字母开头，长度在6~18之间，只能包含字符、数字和下划线。
       /// </summary>
       /// <param name="strPwd">传入一字符串</param>
       /// <returns>格式是否正确</returns>
       public static bool IsPaw(String strPwd)
       {
           if (strPwd == null) return false;
           if (strPwd == "") return false;
           return Regex.IsMatch(strPwd, @"^[a-zA-Z0-9_]+$");
       }
       #endregion
   }
}
