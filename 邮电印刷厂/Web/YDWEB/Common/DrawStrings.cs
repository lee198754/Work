using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using System.Drawing;

namespace Common
{
    public class DrawStrings
    {
        #region 预览
        public static void DrawString(System.Drawing.Printing.PrintPageEventArgs e, string title, string coumnTitle, ArrayList textList)
        {

            Size sTotal = new Size(e.PageBounds.Width, e.PageBounds.Height);
            Graphics g = e.Graphics;
            Font fTitle = new Font("宋体", 16, FontStyle.Bold); // 标题字体
            int titleHeight = 20; // 标题的高度
            int textHeight = 13; // 普通文本的高度
            Font fText = new Font("宋体", 9); // 文本字体
            Font fCoumnTitle = new Font("宋体", 10, FontStyle.Bold);

            int top = 30 + e.MarginBounds.Top; // 顶部间距
            int left = 10 + e.MarginBounds.Left; // 左边距
            int right = 10 + e.MarginBounds.Right; // 右边距
            int titleMargin = 20; // 标题和正文行间距
            int textMargin = 5; // 行间距
            //int rectangleMargin = 3; // 边框和文本间距
            //int oneHeight = 19; // 一行文本 + 2 * 行间距的高度
            int oneWidth = sTotal.Width - left - right; // 打印内容的宽度


            SizeF sTitle = g.MeasureString(title, fTitle); // 计算标题的长度和高度
            Point pTitle = new Point((sTotal.Width - (int)sTitle.Width) / 2, top); // 使标题绝对居中
            g.DrawString(title, fTitle, Brushes.Black, pTitle.X, 0); // 标题

            SizeF sCoumnTitle = g.MeasureString(coumnTitle, fCoumnTitle);
            Point pText = new Point((sTotal.Width - (int)sCoumnTitle.Width) / 2, top + titleMargin);
            g.DrawString(coumnTitle, fCoumnTitle, Brushes.Black, pText.X, titleHeight + titleMargin);

            for (int i = 0; i < textList.Count; i++)
            {
                string text = (string)textList[i];
                g.DrawString(text, fText, Brushes.Black, pText.X, (titleHeight + titleMargin + titleMargin) + (textHeight + textMargin) * i);
            }
        }
        #endregion
    }
}
