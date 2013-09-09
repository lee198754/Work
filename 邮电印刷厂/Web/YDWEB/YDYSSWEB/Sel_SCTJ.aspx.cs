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
using System.Data.SqlClient;
using Bll;
using Common;
public partial class Sel_SCTJ : PageWebBase
{
    Message mes = new Message();
    B_SelectList Blist = new B_SelectList();
    DropDownListBind Bind = new DropDownListBind();
    B_Sys_UserInfo Buser = new B_Sys_UserInfo();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                BindDrop();
                txt_BegionTime.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txt_endTime.Text = DateTime.Now.ToString("yyyy-MM-dd");
                if (Session["LoginName"] != null)
                {
                    txt_User.Value = Session["LoginName"].ToString();
                }
            }
        }
        catch (Exception ex)
        {
            Logs.WriteLog("业务统计加载---错误", ex.Message);
        }

    }
    protected void btn_sel_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = Blist.GetSCTJ(txt_BegionTime.Text.ToString() + " 00:00:00", txt_endTime.Text.ToString() + " 23:59:59", int.Parse(DropType.SelectedValue.ToString()),txt_User.Value.Trim().ToString()).Tables[0];
            if (dt.Rows.Count > 0)
            {
                //@kds KDS, @kdms KDMS, @qgdh QGDH, @zgdh ZGDH,
                //declare @kds int, @kdms int, @qgdh varchar(50), @zgdh varchar(50) --开单数,总开单枚数,第一个工单号,最后一个工单号
                //declare @cds int  --撤单数
                Label1.Text = dt.Rows[0]["KDS"].ToString();
                Label2.Text = dt.Rows[0]["KDMS"].ToString();
                Label3.Text = dt.Rows[0]["QGDH"].ToString();
                Label4.Text = dt.Rows[0]["ZGDH"].ToString();
                Label5.Text = dt.Rows[0]["CDS"].ToString();
                ///////////////////////////////////////////////////////////

                //@pks PKS, @pkms PKMS,@pkyz PKYZ, @pkch PKCH,
                //@pks int, @pkms int, @pkyz int, @pkch int  --普卡数,普卡枚数,普卡用纸个数,普卡消耗纸数
                Label6.Text = dt.Rows[0]["PKS"].ToString();
                Label7.Text = dt.Rows[0]["PKMS"].ToString();
                Label8.Text = dt.Rows[0]["PKYZ"].ToString();
                Label9.Text = dt.Rows[0]["PKCH"].ToString();
                ///
                int count = int.Parse(Label8.Text) + int.Parse(Label9.Text);
                Label10.Text = count.ToString();
                double cou = double.Parse(count.ToString()) / double.Parse("500");
                Label11.Text = cou.ToString("0.00");

                //@xks XKS, @xkms XKMS,@xkyz XKYZ, @xkch XKCH,
                Label12.Text = dt.Rows[0]["XKS"].ToString();
                Label13.Text = dt.Rows[0]["XKMS"].ToString();
                Label14.Text = dt.Rows[0]["XKYZ"].ToString();
                Label15.Text = dt.Rows[0]["XKCH"].ToString();

                count = int.Parse(Label14.Text) + int.Parse(Label15.Text);
                Label16.Text = count.ToString();
                cou = double.Parse(count.ToString()) / double.Parse("500");
                Label17.Text = cou.ToString("0.00");

                //@hks HKS, @hkms HKMS,@hkyz HKYZ, @hkch HKCH,
                Label18.Text = dt.Rows[0]["HKS"].ToString();
                Label19.Text = dt.Rows[0]["HKMS"].ToString();
                Label20.Text = dt.Rows[0]["HKYZ"].ToString();
                Label21.Text = dt.Rows[0]["HKCH"].ToString();

                count = int.Parse(Label20.Text) + int.Parse(Label21.Text);
                Label22.Text = count.ToString();
                cou = double.Parse(count.ToString()) / double.Parse("500");
                Label23.Text = cou.ToString("0.00");

                
                //@hkfs HKFS, @hkfms HKFMS,@hkfyz HKFYZ, @hkfch HKFCH,
                Label24.Text = dt.Rows[0]["HKFS"].ToString();
                Label25.Text = dt.Rows[0]["HKFMS"].ToString();
                Label26.Text = dt.Rows[0]["HKFYZ"].ToString();
                Label27.Text = dt.Rows[0]["HKFCH"].ToString();

                count = int.Parse(Label26.Text) + int.Parse(Label27.Text);
                Label28.Text = count.ToString();
                cou = double.Parse(count.ToString()) / double.Parse("500");
                Label29.Text = cou.ToString("0.00");

                //  @dkbk DKBK,@skbk SKBK,
                Label30.Text = dt.Rows[0]["DKBK"].ToString();
                Label31.Text = dt.Rows[0]["SKBK"].ToString();
                // @yzbs YZBS, @yzbms YZBMS, @yzbpks YZBPKS, @yzbpkms YZBPKMS, @yzbxks YZBXKS, 
                //@yzbxkms YZBXKMS, @yzbhks YZBHKS, @yzbhkms YZBHKMS, @yzbhkfs YZBHKFS, @yzbhkfms YZBHKFMS,
                Label32.Text = dt.Rows[0]["YZBS"].ToString();
                Label33.Text = dt.Rows[0]["YZBMS"].ToString();
                Label34.Text = dt.Rows[0]["YZBPKS"].ToString();
                Label35.Text = dt.Rows[0]["YZBPKMS"].ToString();
                Label36.Text = dt.Rows[0]["YZBXKS"].ToString();
                Label37.Text = dt.Rows[0]["YZBXKMS"].ToString();
                Label38.Text = dt.Rows[0]["YZBHKS"].ToString();
                Label39.Text = dt.Rows[0]["YZBHKMS"].ToString();
                Label40.Text = dt.Rows[0]["YZBHKFS"].ToString();
                Label41.Text = dt.Rows[0]["YZBHKFMS"].ToString();

                //@yyss YYSS, @yysms YYSMS,@yyspks YYSPKS, @yyspkms YYSPKMS, @yysxks YYSXKS, 
                //@yysxkms YYSXKMS, @yyshks YYSHKS, @yyshkms YYSHKMS, @yyshkfs YYSHKFS, @yyshkfms YYSHKFMS,

                Label42.Text = dt.Rows[0]["YYSS"].ToString();
                Label43.Text = dt.Rows[0]["YYSMS"].ToString();
                Label44.Text = dt.Rows[0]["YYSPKS"].ToString();
                Label45.Text = dt.Rows[0]["YYSPKMS"].ToString();
                Label46.Text = dt.Rows[0]["YYSXKS"].ToString();
                Label47.Text = dt.Rows[0]["YYSXKMS"].ToString();
                Label48.Text = dt.Rows[0]["YYSHKS"].ToString();
                Label49.Text = dt.Rows[0]["YYSHKMS"].ToString();
                Label50.Text = dt.Rows[0]["YYSHKFS"].ToString();
                Label51.Text = dt.Rows[0]["YYSHKFMS"].ToString();

                //@yzds YZDS, @yzdms YZDMS,@yzdpks YZDPKS, @yzdpkms YZDPKMS, @yzdxks YZDXKS, @yzdxkms YZDXKMS,
                //@yzdhks YZDHKS, @yzdhkms YZDHKMS, @yzdhkfs YZDHKFS, @yzdhkfms YZDHKFMS
                Label52.Text = dt.Rows[0]["YZDS"].ToString();
                Label53.Text = dt.Rows[0]["YZDMS"].ToString();
                Label54.Text = dt.Rows[0]["YZDPKS"].ToString();
                Label55.Text = dt.Rows[0]["YZDPKMS"].ToString();
                Label56.Text = dt.Rows[0]["YZDXKS"].ToString();
                Label57.Text = dt.Rows[0]["YZDXKMS"].ToString();
                Label58.Text = dt.Rows[0]["YZDHKS"].ToString();
                Label59.Text = dt.Rows[0]["YZDHKMS"].ToString();
                Label60.Text = dt.Rows[0]["YZDHKFS"].ToString();
                Label61.Text = dt.Rows[0]["YZDHKFMS"].ToString();



            }
        }
        catch (Exception ex)
        {
            Logs.WriteLog("业务统计查询---错误", ex.Message);
        }
    }

    public void BindDrop()
    {
        DataTable dt = new DataTable();
        dt = Buser.GetListCategory("").Tables[0];
        Bind.DListBind(dt, DropType, "F_sClassName", "F_iID");
        DropType.Items.Insert(0, new ListItem("全部", "-1"));
    }
}
