<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EidtPassWord.aspx.cs" Inherits="EidtPassWord" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>修改密码</title>
       <link href="CSS/Style.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../JS/Popedom.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div align="center">
     <div align="center" >
        <table border="0" cellspacing="0" cellpadding="0" style="width:98%">
            <tr>
                <td style="height:30px;">
                    <span>&nbsp;</span>
                </td>
            </tr>
             <tr>
                <td align="left" class="TDBack ">
                    <span>&nbsp;</span> 修改密码</td>
            </tr>
            <tr>
                <td align="center" style="height:30px;">
                   <span>原 密 码：</span><input type="password" runat="server" style="width:200px;" id="txt_yuanpass" maxlength="16" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="原密码不为空,请重新输入!" ControlToValidate="txt_yuanpass">＊</asp:RequiredFieldValidator></td>
            </tr>
            <tr >
                <td  align="center" style="height:30px; ">
                  <span>新 密 码：</span><input type="password" style="width:200px;" id="txt_newpass" runat="server" maxlength="16" />
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="新密码不为空,请重新输入!" ControlToValidate="txt_newpass">＊</asp:RequiredFieldValidator>
                    </td>
            </tr>
            <tr>
                <td align="center" style="height:30px;">
                 <span>确认密码：</span><input type="password" style="width:200px;" id="txt_password" runat="server" maxlength="16" />
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="两次输入的密码不一致，请重新输入！！" ControlToCompare="txt_newpass" ControlToValidate="txt_password">＊</asp:CompareValidator></td>
                <td>
                    </td>
            </tr>
            <tr>
                <td align="center" style="height: 54px">
                    <input type="submit" value="提  交" class="Button" runat="server" id="btn_submit" onserverclick="btn_submit_ServerClick"/>
                    &nbsp;&nbsp; &nbsp;<input type="reset" class="Button" runat="server" id="btn_reset" value="重　置"  />
                </td>
            </tr>
        </table>
    </div>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" />
    </div>
    </form>
</body>
</html>