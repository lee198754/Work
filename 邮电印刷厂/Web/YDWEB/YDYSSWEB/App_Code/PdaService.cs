using System;
using System.Data;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using Bll;


/// <summary>
/// PdaService 的摘要说明
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class PdaService : System.Web.Services.WebService
{
    //PDA调用接口使用账号
    private string PDAUser="yd";
    private string PDAPwd = "000000";
    B_SelectList Blist = new B_SelectList();
    public PdaService()
    {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }

    [WebMethod]
    public DataSet Getp_GetOut(string TXM)
    {
        return Blist.Getp_GetOut(TXM);
    }

    [WebMethod]
    public DataSet Getp_SaveOut(int Rec, int Type, int SBID, string ProductCode, int Tao, int Out,
            string OutCode, string JiangCode, string OutWay, string OverDate, int OutNum, string TXM,
            string ZXS, string CBSL, string BZ)
    {
        return Blist.Getp_SaveOut(Rec, Type, SBID, ProductCode, Tao, Out, OutCode, JiangCode, OutWay, OverDate,
                                    OutNum, TXM, ZXS, CBSL, BZ);
    }
    [WebMethod]
    public DataSet Query(string User,string Pwd,string SQLString, int Times)
    {
        
        if (User==PDAUser && Pwd==PDAPwd) {
            return Blist.Query(SQLString, Times);
        }
        else{
            return null;
        }
    }
    [WebMethod]
    public int ExecuteSql(string User, string Pwd, string SQLString)
    {
        
        if (User==PDAUser && Pwd==PDAPwd) {
            return Blist.ExecuteSql(SQLString);
        }
        else{
            return -100;
        }
    }

}

