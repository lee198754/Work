using System;
using System.Collections.Generic;
using System.Text;

namespace Common
{
    public class GetSepll
    {
        /// <summary> 
        /// 汉字转拼音缩写 
        /// Code By MuseStudio@hotmail.com 
        /// 2004-11-30 
        /// </summary> 
        /// <param name="str">要转换的汉字字符串</param> 
        /// <returns>拼音缩写</returns> 

        public string GetPYString(string str)
        {
            string tempStr = "";
            foreach (char c in str)
            {
                if ((int)c >= 33 && (int)c <= 126)
                {//字母和符号原样保留 
                    tempStr = tempStr + c.ToString();
                }
                else
                {//累加拼音声母 
                    tempStr = tempStr + GetPYChar(c.ToString());
                }
            }
            return tempStr;
        }

        /// <summary> 
        /// 取单个字符的拼音声母 
        /// Code By MuseStudio@hotmail.com 
        /// 2004-11-30 
        /// </summary> 
        /// <param name="c">要转换的单个汉字</param> 
        /// <returns>拼音声母</returns> 
        public string GetPYChar(string c)
        {
            byte[] array = new byte[2];
            array = System.Text.Encoding.Default.GetBytes(c);
            int i = (short)(array[0] - '\0') * 256 + ((short)(array[1] - '\0'));

            if (i < 0xB0A1) return "*";
            if (i < 0xB0C5) return "A";
            if (i < 0xB2C1) return "B";
            if (i < 0xB4EE) return "C";
            if (i < 0xB6EA) return "D";
            if (i < 0xB7A2) return "E";
            if (i < 0xB8C1) return "F";
            if (i < 0xB9FE) return "G";
            if (i < 0xBBF7) return "H";
            if (i < 0xBFA6) return "G";
            if (i < 0xC0AC) return "K";
            if (i < 0xC2E8) return "L";
            if (i < 0xC4C3) return "M";
            if (i < 0xC5B6) return "N";
            if (i < 0xC5BE) return "0";
            if (i < 0xC6DA) return "P";
            if (i < 0xC8BB) return "Q";
            if (i < 0xC8F6) return "R";
            if (i < 0xCBFA) return "S";
            if (i < 0xCDDA) return "T";
            if (i < 0xCEF4) return "W";
            if (i < 0xD1B9) return "X";
            if (i < 0xD4D1) return "Y";
            if (i < 0xD7FA) return "Z";

            return "*";
        }

    }
}
