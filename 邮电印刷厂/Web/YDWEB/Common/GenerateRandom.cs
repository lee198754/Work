using System;
using System.Collections.Generic;
using System.Text;

namespace Common
{
    /// <summary>
    /// 生成随机数
    /// </summary>
    public class GenerateRandom
    {
        public GenerateRandom()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }
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

    }
}
