using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Collections;
using System.Data.OleDb;

namespace Common
{
    public class Excels
    {
        /// <summary>
        /// 导出Excels
        /// </summary>
        /// <param name="FileType"></param>
        /// <param name="FileName"></param>
        /// <param name="GridView1"></param>

        public void Export(string FileType, string FileName, GridView GridView1)
        {
            HttpContext.Current.Response.Charset = "GB2312";
            HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.UTF7;
            HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(FileName, Encoding.UTF8).ToString());
            HttpContext.Current.Response.ContentType = FileType;
            //this.EnableViewState = false;
            StringWriter tw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(tw);
            GridView1.RenderControl(hw);
            HttpContext.Current.Response.Write(tw.ToString());
            HttpContext.Current.Response.End();
        }
        /// <summary>
        /// 导出Excels
        /// </summary>
        /// <param name="FileType"></param>
        /// <param name="FileName"></param>
        /// <p
        public void ExportDataFromGridView(System.Web.UI.Control control, string FileName)
        {
            HttpContext.Current.Response.Charset = "GB2312";
            HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.Default;
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment;filename=" + "" + FileName + ".xls");
            control.Page.EnableViewState = false;
            System.IO.StringWriter tw = new System.IO.StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(tw);
            control.RenderControl(hw);
            HttpContext.Current.Response.Write(tw.ToString());
            HttpContext.Current.Response.End();
        }

        #region 导出Excels
        /// <summary>
        /// 输出
        /// </summary>
        /// <param name="title"></param>
        /// <param name="coumnTitles"></param>
        /// <param name="textList"></param>
        public static void OutExcel(string title, ArrayList coumnTitles, ArrayList textList)
        {
            //外部Excel对象
            Microsoft.Office.Interop.Excel.Application app = new Microsoft.Office.Interop.Excel.Application();
            app.Visible = true;

            Microsoft.Office.Interop.Excel.Workbooks workbooks = app.Workbooks;
            Microsoft.Office.Interop.Excel._Workbook workbook = workbooks.Add(Microsoft.Office.Interop.Excel.XlWBATemplate.xlWBATWorksheet);
            Microsoft.Office.Interop.Excel.Sheets sheets = workbook.Worksheets;
            Microsoft.Office.Interop.Excel._Worksheet worksheet = (Microsoft.Office.Interop.Excel._Worksheet)sheets.get_Item(1);
            Microsoft.Office.Interop.Excel.Range range = worksheet.get_Range("A1", System.Reflection.Missing.Value);

            //标题
            worksheet.get_Range(app.Cells[1, 1], app.Cells[1, 1]).Value2 = title;
            worksheet.get_Range(app.Cells[1, 1], app.Cells[1, 9]).Merge(0);
            worksheet.get_Range(app.Cells[1, 1], app.Cells[1, 9]).VerticalAlignment = Microsoft.Office.Interop.Excel.XlVAlign.xlVAlignCenter;
            worksheet.get_Range(app.Cells[1, 1], app.Cells[1, 9]).HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter;
            worksheet.get_Range(app.Cells[1, 1], app.Cells[1, 9]).Font.Size = 16;
            worksheet.get_Range(app.Cells[1, 1], app.Cells[1, 9]).Font.Bold = true;

            //列标题
            for (int i = 1; i <= coumnTitles.Count; i++)
            {
                worksheet.get_Range(app.Cells[3, i], app.Cells[3, i]).Value2 = coumnTitles[i - 1].ToString();
                worksheet.get_Range(app.Cells[3, i], app.Cells[3, i]).Font.Size = 10;
                worksheet.get_Range(app.Cells[3, i], app.Cells[3, i]).Font.Bold = true;
            }

            //内容
            for (int i = 0; i < textList.Count; i++)
            {
                string[] text = (string[])textList[i];

                for (int j = 1; j <= text.Length; j++)
                {
                    worksheet.get_Range(app.Cells[4 + i, j], app.Cells[4 + i, j]).Value2 = text[j - 1].ToString();
                    worksheet.get_Range(app.Cells[4 + i, j], app.Cells[4 + i, j]).Font.Size = 9;
                }
            }
        }
        #endregion

        public DataSet ExcelDataSource(string filepath, string sheetname)
        {
            string strConn;
            strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filepath + ";Extended Properties=Excel 8.0;";
            OleDbConnection conn = new OleDbConnection(strConn);
            OleDbDataAdapter oada = new OleDbDataAdapter("select * from [" + sheetname + "$]", strConn);
            DataSet ds = new DataSet();
            oada.Fill(ds);
            return ds;
        }
    }
}