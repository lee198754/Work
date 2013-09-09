<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Sel_Detail.aspx.cs" Inherits="Sel_Detail" %>

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
    <div style=" width:900px; height:600px; margin-top:60px;"><%--bgcolor="#DFD4D4"--%>
     <table width="98%" class="table1" cellpadding="0" style=" border:0px;" cellspacing="1px" bgcolor="#000">
     <tr>
     <td>
         &nbsp;<br />
        <br />
         <fieldset style="width:90%; height:330px; vertical-align:middle; ">
            <legend>邮电贺卡详细资料</legend>
            <br />
            <br />
            <table width="90%" class="table1" cellpadding="0" style="text-align:left; border:0px; padding-left:5px; line-height:25px;" cellspacing="1px" bgcolor="#DFD4D4">
            <tr>
                <td>机构名称：<asp:Label ID="Label1" runat="server" Text=""></asp:Label></td>
                <td>产品编号：<asp:Label ID="Label2" runat="server" Text=""></asp:Label></td>
                <td>客户名称：<asp:Label ID="Label3" runat="server" Text=""></asp:Label></td>
            </tr>
             <tr>
                <td>印量：<asp:Label ID="Label4" runat="server" Text=""></asp:Label></td>
                <td>接收时间：<asp:Label ID="Label5" runat="server" Text=""></asp:Label></td>
                <td>是否签样：<asp:Label ID="Label6" runat="server" Text=""></asp:Label></td>
            </tr>
             <tr>
                <td>产品类型：<asp:Label ID="Label7" runat="server" Text=""></asp:Label></td>
                <td>邮资图名称：<asp:Label ID="Label8" runat="server" Text=""></asp:Label></td>
                <td>要货日期：<asp:Label ID="Label9" runat="server" Text=""></asp:Label></td>
            </tr>
             <tr>
                <td>加印：<asp:Label ID="Label10" runat="server" Text=""></asp:Label></td>
                <td>申报表ID：<asp:Label ID="Label11" runat="server" Text=""></asp:Label></td>
                <td></td>
            </tr>
            <tr>
                <td colspan="3">
                    <strong>生产情况</strong></td>
            </tr>
             <tr>
                <td>工单号：<asp:Label ID="Label12" runat="server" Text=""></asp:Label></td>
                <td>开单产量：<asp:Label ID="Label13" runat="server" Text=""></asp:Label></td>
                <td>开单日期：<asp:Label ID="Label14" runat="server" Text=""></asp:Label></td>
            </tr>
             <tr>
                <td>制版完成日期：<asp:Label ID="Label15" runat="server" Text=""></asp:Label></td>
                <td>印完日期：<asp:Label ID="Label16" runat="server" Text=""></asp:Label></td>
                <td>入库日期：<asp:Label ID="Label17" runat="server" Text=""></asp:Label></td>
            </tr>
             <tr>
                <td colspan="3">
                    <strong>发货</strong></td>
            </tr>
             <tr>
                <td>已发货总量：<asp:Label ID="Label18" runat="server" Text=""></asp:Label></td>
                <td>剩余库存：<asp:Label ID="Label19" runat="server" Text=""></asp:Label></td>
                <td>未发货总量：<asp:Label ID="Label20" runat="server" Text=""></asp:Label></td>
            </tr>
             <tr>
                <td>发货日期：<asp:Label ID="Label21" runat="server" Text=""></asp:Label></td>
                <td></td>
                <td></td>
            </tr>
            
            
           
            </table>
         </fieldset>
         <br />
         <br />
          
         <fieldset style="width:90%; vertical-align:middle; ">
            <legend>发货明细</legend>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="false" Width="98%" AutoGenerateColumns="False">
                    <Columns>
                         <asp:BoundField DataField="CPBH" HeaderText="产品编号">
                                <HeaderStyle CssClass="ListTH" Width="20%" />
                                <ItemStyle CssClass="ListTd1" Width="20%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="FHDH" HeaderText="发货单号" >
                                <HeaderStyle CssClass="ListTH" Width="15%" />
                                <ItemStyle CssClass="ListTd1" Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FHFS" HeaderText="发货方式">
                                <HeaderStyle CssClass="ListTH" Width="12%" />
                                <ItemStyle CssClass="ListTd1" Width="12%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FYDH" HeaderText="发运单号">
                                <HeaderStyle CssClass="ListTH" Width="15%" />
                                <ItemStyle CssClass="ListTd1" Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FPRQ" HeaderText="发票日期">
                                <HeaderStyle CssClass="ListTH" Width="18%" />
                                <ItemStyle CssClass="ListTd1" Width="18%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FHSL" HeaderText="发货数量">
                                <HeaderStyle CssClass="ListTH" Width="15%" />
                                <ItemStyle CssClass="ListTd1" Width="15%" />
                            </asp:BoundField>
                    </Columns>
                    </asp:GridView>
                    </fieldset>
                    <br /><br />
     </td>
     </tr>
     </table>
    </div>
        <input id="txt_F_iID" type="hidden" runat="server" value="0" />
   
    </form>
</body>
</html>
