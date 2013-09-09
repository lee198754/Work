<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>读取数据测试</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    读取数据测试<br />
    <br />
        模式标志：<asp:DropDownList ID="DropDownList1" runat="server">
            <asp:ListItem Value="0">定制型</asp:ListItem>
            <asp:ListItem Value="1">销售型</asp:ListItem>
            <asp:ListItem Value="2">个性化邮票</asp:ListItem>
        </asp:DropDownList><br />
            <br />
            接收标志：<asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal"
            RepeatLayout="Flow">
            <asp:ListItem Value="0">未接收</asp:ListItem>
            <asp:ListItem Selected="True" Value="1">已接收</asp:ListItem>
        </asp:RadioButtonList><br />
                <br />
                复核日期：<asp:TextBox ID="TextBox3"
                        runat="server" Width="124px"></asp:TextBox>
        至&nbsp;
        <asp:TextBox ID="TextBox4" runat="server" Width="124px"></asp:TextBox><br />
                    <br />
                    <asp:Button ID="Button1" runat="server" Text="查  询" OnClick="Button1_Click" /></div>
    </form>
</body>
</html>
