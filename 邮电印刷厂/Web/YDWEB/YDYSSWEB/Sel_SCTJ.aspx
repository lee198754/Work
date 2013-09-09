<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Sel_SCTJ.aspx.cs" Inherits="Sel_SCTJ" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>福建省邮电印刷厂邮政贺卡信息查询系统</title>
 <link href="CSS/A_Main.css" rel="stylesheet" type="text/css" />
<link href="CSS/OpenDate.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="My97DatePicker/WdatePicker.js" type="text/javascript" ></script>
<script language="javascript" src="JS/Quickseldate.js" type="text/javascript" ></script>
     <style type="text/css">
    table.table1 td
    {
    background-color:#FFFFFF;
    }
    </style>
</head>
<body style="text-align:center; vertical-align:middle;">
    <form id="form1" runat="server">
    <div style=" width:950px; height:400px; margin-top:60px;"><%--bgcolor="#DFD4D4"--%>
     <table width="98%" class="table1" cellpadding="0" style=" border:0px;" cellspacing="1px" bgcolor="#000">
     <tr>
     <td>
        <fieldset style="width:95%; height:40px; padding-top:10px; text-align:center;">
            <legend>查询条件</legend>
            查询日期:<asp:TextBox ID="txt_BegionTime" runat="server" CssClass="Wdate" onclick="WdatePicker()"
                                    SkinID="TextBoxSkin" Width="90px"></asp:TextBox>--<asp:TextBox ID="txt_endTime" runat="server"
                                        CssClass="Wdate" onclick="WdatePicker()" SkinID="TextBoxSkin" Width="90px"></asp:TextBox>
                                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txt_BegionTime"
                                    ControlToValidate="txt_endTime" ErrorMessage="结束时间应该大于开始时间" Operator="GreaterThanEqual">*</asp:CompareValidator>
            &nbsp;产品类别：<asp:DropDownList ID="DropType" runat="server">
                
            </asp:DropDownList>
            <asp:RadioButton
                                        ID="rbtnthisweek" runat="server" GroupName="quickdate" onclick="quickseldate('week');"
                                        Text="本周" /><asp:RadioButton ID="rbtnthismonth" runat="server" GroupName="quickdate"
                                            onclick="quickseldate('month');" Text="本月" />
                                &nbsp;<asp:Button ID="btn_sel" runat="server" Text="查  询" OnClick="btn_sel_Click" />
        </fieldset>
        <br />
        <br />
         <fieldset style="width:95%; height:430px; vertical-align:middle; ">
            <legend>业务统计</legend>
            <br />
            <br />
            <table width="98%" class="table1" cellpadding="0" style="text-align:left; border:0px; padding-left:5px; line-height:25px;" cellspacing="1px" bgcolor="#DFD4D4">
            <tr>
                <td colspan="8" style="padding-left:5px;">此段时间内共开出工单<asp:Label ID="Label1" runat="server" Text="0"></asp:Label>张，
                合<asp:Label ID="Label2" runat="server" Text="0"></asp:Label>枚，
                <%--从--%><asp:Label ID="Label3" runat="server" Text=" " Visible="false"></asp:Label><%--到--%><asp:Label ID="Label4" Visible="false" runat="server" Text="0"></asp:Label><%--，--%>耗材使用量为：（其中撤单<asp:Label ID="Label5" runat="server" Text="0"></asp:Label>张，不参与统计）
                </td>
               
            </tr>
            <tr>
                <td style="width:30%; text-align:left; padding-left:5px; padding-right:5px;">普卡<asp:Label ID="Label6" runat="server" Text="0"></asp:Label>张，
                共<asp:Label ID="Label7" runat="server" Text="0"></asp:Label>枚，所用大纸</td>
                <td style="width:10%; text-align:right; padding-left:5px; padding-right:5px;"><asp:Label ID="Label8" runat="server" Text="0"></asp:Label>张，</td>
                <td style="width:5%; text-align:center; padding-left:5px; padding-right:5px;">消耗</td>
                <td style="width:15%; text-align:right; padding-left:5px; padding-right:5px;"><asp:Label ID="Label9" runat="server" Text="0"></asp:Label>张，</td>
                
                <td style="width:5%; text-align:center; padding-left:5px; padding-right:5px;">共</td>
                <td style="width:15%; text-align:right; padding-left:5px; padding-right:5px;"><asp:Label ID="Label10" runat="server" Text="0"></asp:Label>张，</td>
                <td style="width:5%; text-align:center; padding-left:5px; padding-right:5px;">合</td>
                <td style="width:15%; text-align:right; padding-left:5px; padding-right:5px;"><asp:Label ID="Label11" runat="server" Text="0.00"></asp:Label>令</td>
            </tr>
             <tr>
                <td style="width:30%; text-align:left; padding-left:5px; padding-right:5px;">信卡<asp:Label ID="Label12" runat="server" Text="0"></asp:Label>张，
                共<asp:Label ID="Label13" runat="server" Text="0"></asp:Label>枚，所用大纸</td>
                <td style="width:10%; text-align:right; padding-left:5px; padding-right:5px;"><asp:Label ID="Label14" runat="server" Text="0"></asp:Label>张，</td>
                <td style="width:5%; text-align:center; padding-left:5px; padding-right:5px;">消耗</td>
                <td style="width:15%; text-align:right; padding-left:5px; padding-right:5px;"><asp:Label ID="Label15" runat="server" Text="0"></asp:Label>张，</td>
                
                <td style="width:5%; text-align:center; padding-left:5px; padding-right:5px;">共</td>
                <td style="width:15%; text-align:right; padding-left:5px; padding-right:5px;"><asp:Label ID="Label16" runat="server" Text="0"></asp:Label>张，</td>
                <td style="width:5%; text-align:center; padding-left:5px; padding-right:5px;">合</td>
                <td style="width:15%; text-align:right; padding-left:5px; padding-right:5px;"><asp:Label ID="Label17" runat="server" Text="0.00"></asp:Label>令</td>
            </tr>
             <tr>
                <td style="width:30%; text-align:left; padding-left:5px; padding-right:5px;">贺卡<asp:Label ID="Label18" runat="server" Text="0"></asp:Label>张，
                共<asp:Label ID="Label19" runat="server" Text="0"></asp:Label>枚，所用大纸</td>
                <td style="width:10%; text-align:right; padding-left:5px; padding-right:5px;"><asp:Label ID="Label20" runat="server" Text="0"></asp:Label>张，</td>
                <td style="width:5%; text-align:center; padding-left:5px; padding-right:5px;">消耗</td>
                <td style="width:15%; text-align:right; padding-left:5px; padding-right:5px;"><asp:Label ID="Label21" runat="server" Text="0"></asp:Label>张，</td>
                
                <td style="width:5%; text-align:center; padding-left:5px; padding-right:5px;">共</td>
                <td style="width:15%; text-align:right; padding-left:5px; padding-right:5px;"><asp:Label ID="Label22" runat="server" Text="0"></asp:Label>张，</td>
                <td style="width:5%; text-align:center; padding-left:5px; padding-right:5px;">合</td>
                <td style="width:15%; text-align:right; padding-left:5px; padding-right:5px;"><asp:Label ID="Label23" runat="server" Text="0.00"></asp:Label>令</td>
            </tr>
            <tr>
                <td style="width:30%; text-align:left; padding-left:5px; padding-right:5px;">贺卡封<asp:Label ID="Label24" runat="server" Text="0"></asp:Label>张，
                共<asp:Label ID="Label25" runat="server" Text="0"></asp:Label>枚，所用大纸</td>
                <td style="width:10%; text-align:right; padding-left:5px; padding-right:5px;"><asp:Label ID="Label26" runat="server" Text="0"></asp:Label>张，</td>
                <td style="width:5%; text-align:center; padding-left:5px; padding-right:5px;">消耗</td>
                <td style="width:15%; text-align:right; padding-left:5px; padding-right:5px;"><asp:Label ID="Label27" runat="server" Text="0"></asp:Label>张，</td>
                
                <td style="width:5%; text-align:center; padding-left:5px; padding-right:5px;">共</td>
                <td style="width:15%; text-align:right; padding-left:5px; padding-right:5px;"><asp:Label ID="Label28" runat="server" Text="0"></asp:Label>张，</td>
                <td style="width:5%; text-align:center; padding-left:5px; padding-right:5px;">合</td>
                <td style="width:15%; text-align:right; padding-left:5px; padding-right:5px;"><asp:Label ID="Label29" runat="server" Text="0.00"></asp:Label>令</td>
            </tr>
             <tr>
                <td style="width:30%; text-align:left; padding-left:5px; padding-right:5px;">对开版</td>
                <td style="width:10%; text-align:right; padding-left:5px; padding-right:5px;"><asp:Label ID="Label30" runat="server" Text="0"></asp:Label>块</td>
                <td style="width:5%; text-align:center; padding-left:5px; padding-right:5px;"></td>
                <td style="width:15%; text-align:right; padding-left:5px; padding-right:5px;"></td>
                
                <td style="width:5%; text-align:center; padding-left:5px; padding-right:5px;"></td>
                <td style="width:15%; text-align:right; padding-left:5px; padding-right:5px;"></td>
                <td style="width:5%; text-align:center; padding-left:5px; padding-right:5px;"></td>
                <td style="width:15%; text-align:right; padding-left:5px; padding-right:5px;"></td>
            </tr>
             <tr>
                <td style="width:30%; text-align:left; padding-left:5px; padding-right:5px;">四开版</td>
                <td style="width:10%; text-align:right; padding-left:5px; padding-right:5px;"><asp:Label ID="Label31" runat="server" Text="0"></asp:Label>块</td>
                <td style="width:5%; text-align:center; padding-left:5px; padding-right:5px;"></td>
                <td style="width:15%; text-align:right; padding-left:5px; padding-right:5px;"></td>
                
                <td style="width:5%; text-align:center; padding-left:5px; padding-right:5px;"></td>
                <td style="width:15%; text-align:right; padding-left:5px; padding-right:5px;"></td>
                <td style="width:5%; text-align:center; padding-left:5px; padding-right:5px;"></td>
                <td style="width:15%; text-align:right; padding-left:5px; padding-right:5px;"></td>
            </tr>
            <tr>
            <td colspan="8" style="padding-left:5px;">
            此时段内
            </td>
            </tr>
            
             <tr>
            <td colspan="8" style="padding-left:5px;">
            制版车间共完成传票工单<asp:Label ID="Label32" runat="server" Text="0"></asp:Label>张，合<asp:Label ID="Label33" runat="server" Text="0"></asp:Label>枚，其中：
            </td>
            </tr>
             <tr>
            <td colspan="8" style="padding-left:5px;">
            &nbsp;&nbsp;&nbsp;&nbsp;普卡<asp:Label ID="Label34" runat="server" Text="0"></asp:Label>张，
            <asp:Label ID="Label35" runat="server" Text="0"></asp:Label>枚；
            信卡<asp:Label ID="Label37" runat="server" Text="0"></asp:Label>张，
            <asp:Label ID="Label36" runat="server" Text="0"></asp:Label>枚；
             贺卡<asp:Label ID="Label38" runat="server" Text="0"></asp:Label>张，
            <asp:Label ID="Label39" runat="server" Text="0"></asp:Label>枚；
            贺卡封<asp:Label ID="Label40" runat="server" Text="0"></asp:Label>张，
            <asp:Label ID="Label41" runat="server" Text="0"></asp:Label>枚
            </td>
            </tr>
            
             <tr>
            <td colspan="8" style="padding-left:5px;">
            印刷车间共完成传票工单<asp:Label ID="Label42" runat="server" Text="0"></asp:Label>张，合<asp:Label ID="Label43" runat="server" Text="0"></asp:Label>枚，其中：
            </td>
            </tr>
             <tr>
            <td colspan="8" style="padding-left:5px;">
            &nbsp;&nbsp;&nbsp;&nbsp;普卡<asp:Label ID="Label44" runat="server" Text="0"></asp:Label>张，
            <asp:Label ID="Label45" runat="server" Text="0"></asp:Label>枚；
            信卡<asp:Label ID="Label46" runat="server" Text="0"></asp:Label>张，
            <asp:Label ID="Label47" runat="server" Text="0"></asp:Label>枚；
             贺卡<asp:Label ID="Label48" runat="server" Text="0"></asp:Label>张，
            <asp:Label ID="Label49" runat="server" Text="0"></asp:Label>枚；
            贺卡封<asp:Label ID="Label50" runat="server" Text="0"></asp:Label>张，
            <asp:Label ID="Label51" runat="server" Text="0"></asp:Label>枚
            </td>
            </tr>
            
            <tr>
            <td colspan="8" style="padding-left:5px;">
            装订车间共完成传票工单<asp:Label ID="Label52" runat="server" Text="0"></asp:Label>张，合<asp:Label ID="Label53" runat="server" Text="0"></asp:Label>枚，其中：
            </td>
            </tr>
             <tr>
            <td colspan="8" style="padding-left:5px;">
            &nbsp;&nbsp;&nbsp;&nbsp;普卡<asp:Label ID="Label54" runat="server" Text="0"></asp:Label>张，
            <asp:Label ID="Label55" runat="server" Text="0"></asp:Label>枚；
            信卡<asp:Label ID="Label56" runat="server" Text="0"></asp:Label>张，
            <asp:Label ID="Label57" runat="server" Text="0"></asp:Label>枚；
             贺卡<asp:Label ID="Label58" runat="server" Text="0"></asp:Label>张，
            <asp:Label ID="Label59" runat="server" Text="0"></asp:Label>枚；
            贺卡封<asp:Label ID="Label60" runat="server" Text="0"></asp:Label>张，
            <asp:Label ID="Label61" runat="server" Text="0"></asp:Label>枚
            </td>
            </tr>
           <%-- <tr>
                <td>共来稿：<asp:Label ID="Label1" runat="server" Text="0"></asp:Label>枚，其中</td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;&nbsp;
                普卡<asp:Label ID="Label2" runat="server" Text="0"></asp:Label>枚，
                信卡<asp:Label ID="Label3" runat="server" Text="0"></asp:Label>枚，
                贺卡封<asp:Label ID="Label4" runat="server" Text="0"></asp:Label>枚，
                贺卡<asp:Label ID="Label5" runat="server" Text="0"></asp:Label>枚
                </td>
            </tr>
            <tr>
                <td>共发货：<asp:Label ID="Label6" runat="server" Text="0"></asp:Label>枚，其中</td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;&nbsp;
                普卡<asp:Label ID="Label7" runat="server" Text="0"></asp:Label>枚，
                信卡<asp:Label ID="Label8" runat="server" Text="0"></asp:Label>枚，
                贺卡封<asp:Label ID="Label9" runat="server" Text="0"></asp:Label>枚，
                贺卡<asp:Label ID="Label10" runat="server" Text="0"></asp:Label>枚</td>
            </tr>
            <tr>
                <td>未发货：<asp:Label ID="Label11" runat="server" Text="0"></asp:Label>枚，其中</td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;&nbsp;
                普卡<asp:Label ID="Label12" runat="server" Text="0"></asp:Label>枚，
                信卡<asp:Label ID="Label13" runat="server" Text="0"></asp:Label>枚，
                贺卡封<asp:Label ID="Label14" runat="server" Text="0"></asp:Label>枚，
                贺卡<asp:Label ID="Label15" runat="server" Text="0"></asp:Label>枚</td>
            </tr>--%>
            </table>
         </fieldset>
         <br />
         <br />
     </td>
     </tr>
     </table>
    </div>
    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
          ShowSummary="False" />
           <input id="txt_User" type="hidden" runat="server" value="" />
    </form>
</body>
</html>
