using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Drawing;
public partial class CheckCode : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
        string checkCode = CreateRandomCode(4);
        Session["CheckCode"] = checkCode;
        CreateImage(checkCode);

    }
    private string CreateRandomCode(int codeCount)
    {
        string allChar = "8,1,2,3,4,5,6,7,8,9,0,1,2,3,5,4,6,8,9,0,5,6,8,9,8,1,4,8,6,6,8,8,8,8,8";
        string[] allCharArray = allChar.Split(',');
        string randomCode = "";
        int temp = -1;

        Random rand = new Random();
        for (int i = 0; i < codeCount; i++)
        {
            if (temp != -1)
            {
                rand = new Random(i * temp * ((int)DateTime.Now.Ticks));
            }
            int t = rand.Next(35);
            if (temp == t)
            {
                return CreateRandomCode(codeCount);
            }
            temp = t;
            randomCode += allCharArray[t];
        }
        return randomCode;
    }

    private void CreateImage(string checkCode)
    {
        //在这里将O 改称○
        int iwidth = (int)(checkCode.Length * 11);
        System.Drawing.Bitmap image = new System.Drawing.Bitmap(iwidth, 20);
        Graphics g = Graphics.FromImage(image);
        Font f = new System.Drawing.Font("Arial", 10, System.Drawing.FontStyle.Bold);
        Brush b = new System.Drawing.SolidBrush(Color.Blue);
        g.Clear(Color.White);
        g.DrawString(checkCode, f, b, 3, 3);

        Pen blackPen = new Pen(Color.Black, 0);
        Random rand = new Random();
        for (int i = 0; i < 5; i++)
        {
            int y = rand.Next(image.Height);
        }

        System.IO.MemoryStream ms = new System.IO.MemoryStream();
        image.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
        Response.ClearContent();
        Response.ContentType = "image/Jpeg";
        Response.BinaryWrite(ms.ToArray());
        g.Dispose();
        image.Dispose();
    }
}
