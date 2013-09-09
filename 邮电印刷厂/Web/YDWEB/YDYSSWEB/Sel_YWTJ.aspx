<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Sel_YWTJ.aspx.cs" Inherits="Sel_YWTJ" %>

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
    <div style=" width:800px; height:400px; margin-top:60px;"><%--bgcolor="#DFD4D4"--%>
     <table width="98%" class="table1" cellpadding="0" style=" border:0px;" cellspacing="1px" bgcolor="#000">
     <tr>
     <td>
        <fieldset style="width:90%; height:50px; padding-top:5px; text-align:center; vertical-align:middle;">
            <legend>查询条件</legend>
            查询日期:<asp:TextBox ID="txt_BegionTime" runat="server" CssClass="Wdate" onclick="WdatePicker()"
                                    SkinID="TextBoxSkin" Width="90px"></asp:TextBox>--<asp:TextBox ID="txt_endTime" runat="server"
                                        CssClass="Wdate" onclick="WdatePicker()" SkinID="TextBoxSkin" Width="90px"></asp:TextBox>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txt_BegionTime"
                                    ControlToValidate="txt_endTime" ErrorMessage="结束时间应该大于开始时间" Operator="GreaterThanEqual">*</asp:CompareValidator>
            产品类别：<asp:DropDownList ID="DropType" runat="server">
               
            </asp:DropDownList>
            <asp:RadioButton
                                        ID="rbtnthisweek" runat="server" GroupName="quickdate" onclick="quickseldate('week');"
                                        Text="本周" /><asp:RadioButton ID="rbtnthismonth" runat="server" GroupName="quickdate"
                                            onclick="quickseldate('month');" Text="本月" />
                                &nbsp;<asp:Button ID="btn_sel" runat="server" Text="查  询" OnClick="btn_sel_Click" />
        </fieldset>
        <br />
        <br />
         <fieldset style="width:90%; height:230px; vertical-align:middle; ">
            <legend><asp:Label ID="lb_Name" runat="server" Text="业务统计"></asp:Label></legend>
            <br />
            <br />
            <table width="90%" class="table1" cellpadding="0" style="text-align:left; border:0px; padding-left:5px; line-height:25px;" cellspacing="1px" bgcolor="#DFD4D4">
            <tr>
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
            </tr>
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
