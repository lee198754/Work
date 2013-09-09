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
using Bll;
using Common;
public partial class Sel_Detail : System.Web.UI.Page
{
    Message mes = new Message();
    B_SelectList Blist = new B_SelectList();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                if (Request["ID"] != null)
                {
                    txt_F_iID.Value = DESEncrypt.Decrypt(Request["ID"].ToString());
                    //txt_F_iID.Value = Request["ID"].ToString();

                    DataTable dt = new DataTable();
                    DataTable dt2 = new DataTable();
                    dt = Blist.GetYWXX(txt_F_iID.Value.Trim().ToString()).Tables[0];
                    if (dt.Rows.Count > 0)
                    {

                      //@jg JG, @cpbh CPBH, @khmc KHMC,   --承揽机构名称, 产品编号, 客户名称
                      //@yl YL, @jsrq JSRQ, @qyrq QYRQ,             --印量, 接收时候, 是否签样(0:不签样;1:签样)
                      //@cplx CPLX, @yztmc YZTMC, @jhrq JHRQ,  --产品类型, 邮资图名称, 交货日期
                      //@jy JY, @sbbbh SBBBH,                  --加印标志(0,不加印;1,加印), 申报表ID
                        Label1.Text = dt.Rows[0]["JG"].ToString();
                        Label2.Text = dt.Rows[0]["CPBH"].ToString();
                        Label3.Text = dt.Rows[0]["KHMC"].ToString();
                        Label4.Text = dt.Rows[0]["YL"].ToString();
                        Label5.Text = dt.Rows[0]["JSRQ"].ToString();
                        Label6.Text = dt.Rows[0]["QYRQ"].ToString();
                        Label7.Text = dt.Rows[0]["CPLX"].ToString();
                        Label8.Text = dt.Rows[0]["YZTMC"].ToString();
                        Label9.Text = dt.Rows[0]["JHRQ"].ToString();
                        Label10.Text = dt.Rows[0]["JY"].ToString();
                        Label11.Text = dt.Rows[0]["SBBBH"].ToString();
                        //生产情况
                        //@gdh GDH, @kdyl KDYL, @kdrq KDRQ,         --工单号, 开单产量, 开单日期
                        //@zbwcrq ZBWCRQ, @ywrq YWRQ, @rkrq RKRQ,   --制版完成日期, 印完日期, 入库日期
                       
                        Label12.Text = dt.Rows[0]["GDH"].ToString();
                        Label13.Text = dt.Rows[0]["KDYL"].ToString();
                        Label14.Text = dt.Rows[0]["KDRQ"].ToString();
                        Label15.Text = dt.Rows[0]["ZBWCRQ"].ToString();
                        Label16.Text = dt.Rows[0]["YWRQ"].ToString();
                        Label17.Text = dt.Rows[0]["RKRQ"].ToString();
                        //发货
                        //@yfhzl YFHZL, @sykc SYKC, @wfhzl WFHZL    --已发货总量, 剩余库存, 未发货总量
                        Label18.Text = dt.Rows[0]["YFHZL"].ToString();
                        Label19.Text = dt.Rows[0]["SYKC"].ToString();
                        Label20.Text = dt.Rows[0]["WFHZL"].ToString();
                        Label21.Text = dt.Rows[0]["FHRQ"].ToString();
                    }

                    
                    dt2 = Blist.GetYWXXList(txt_F_iID.Value.Trim().ToString()).Tables[0];
                    if (dt2.Rows.Count > 0)
                    {
                        GridView1.DataSource = dt2.DefaultView;
                        GridView1.DataBind();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Logs.WriteLog("业务统计加载---错误", ex.Message);
        }

    }
    //protected void btn_sel_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        DataTable dt = new DataTable();
    //        dt = Blist.GetYWTJ(txt_BegionTime.Text.ToString(), txt_endTime.Text.ToString()).Tables[0];
    //        if (dt.Rows.Count > 0)
    //        {
    //            Label1.Text = dt.Rows[0]["LGMS"].ToString();
    //            Label2.Text = dt.Rows[0]["LGPKMS"].ToString();
    //            Label3.Text = dt.Rows[0]["LGXKMS"].ToString();
    //            Label4.Text = dt.Rows[0]["LGHKFMS"].ToString();
    //            Label5.Text = dt.Rows[0]["LGHKMS"].ToString();

    //            Label6.Text = dt.Rows[0]["YFHMS"].ToString();
    //            Label7.Text = dt.Rows[0]["YFHPKMS"].ToString();
    //            Label8.Text = dt.Rows[0]["YFHXKMS"].ToString();
    //            Label9.Text = dt.Rows[0]["YFHHKFMS"].ToString();
    //            Label10.Text = dt.Rows[0]["YFHHKMS"].ToString();

    //            Label11.Text = dt.Rows[0]["WFHMS"].ToString();
    //            Label12.Text = dt.Rows[0]["WFHPKMS"].ToString();
    //            Label13.Text = dt.Rows[0]["WFHXKMS"].ToString();
    //            Label14.Text = dt.Rows[0]["WFHHKFMS"].ToString();
    //            Label15.Text = dt.Rows[0]["WFHHKMS"].ToString();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        Logs.WriteLog("业务统计查询---错误", ex.Message);
    //    }
    //}
}
