using System;
using System.Collections.Generic;
using System.Text;
using System.Security.Cryptography;
using System.IO;

namespace Common
{
    public class MD5
    {
        /// <summary>
        /// MD5加密
        /// </summary>
        /// <param name="password"></param>
        /// <returns></returns>
        /// 
        public static  string EncryptString(string Value)
        {
            byte[] data = System.Text.Encoding.Unicode.GetBytes(Value.ToCharArray());
            //建立加密服务
            System.Security.Cryptography.MD5 md5 = new System.Security.Cryptography.MD5CryptoServiceProvider();
            //加密Byte[]数组
            byte[] result = md5.ComputeHash(data);
            //将加密后的数组转化为字段
            string sResult = System.Text.Encoding.Unicode.GetString(result);
            //显示出来
            //作为密码方式加密
            string EnPswdStr = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(Value.ToString(), "MD5");
            //for (int i = 0; i < result.Length; i++)
            //{
            //    EnPswdStr = EnPswdStr + result[i].ToString("X");
            //}
            return EnPswdStr;

        }
    }
}
