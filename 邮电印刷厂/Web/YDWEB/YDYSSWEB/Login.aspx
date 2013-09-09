 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="LoginX" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>福建省邮电印刷厂邮政贺卡信息查询系统</title>
 <style  type="text/css">
<!-- 
body{
	margin:0px;
	background-color:#ececec;
	}
td{
	font-family:"宋体",Arial, Helvetica, sans-serif;
	font-size:12px;
	line-height:20px;
	color:#000000;
	}
-->
</style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width="781" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="85" valign="bottom"><img src="Images/xt_03.jpg" width="834" height="32" />&nbsp;</td>
  </tr>
</table>
<table width="834" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="29" background="images/xt_05.jpg" style="height: 478px">&nbsp;</td>
    <td valign="top" style="height: 478px"><table width="781" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="130" bgcolor="#ffffff" style="height: 86px">&nbsp;</td>
        <td width="336" background="Images/glpt_04.jpg" style="height: 86px">&nbsp;</td>
        <td width="315" background="Images/glpt_05.jpg"  align="right" style="height: 86px">&nbsp;&nbsp;&nbsp;&nbsp;<a href="yzcx/index.htm" target="_parent" style="font-weight: bold; font-size: 12pt; color: red"><%--<img src="images/reg_icon.jpg" style="border:0" width="60" height="30" />--%></a>&nbsp;</td>
      </tr>
    </table>
      <table width="781" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td background="Images/glpt_07.jpg" style="height: 289px; width: 467px;">&nbsp;</td>
          <td valign="top" style="height: 289px; width: 270px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="Images/glpt_08.jpg" width="270" height="69" alt="" /></td>
              </tr>
              <tr>
                <td valign="top" background="Images/glpt_10.jpg" style="height: 200px">
                <form id="form2" name="form1" method="post" action="" style="margin-bottom:0px; margin-top:0px;">
                    <table width="90%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td style="height: 10px"></td>
                      </tr>
                    </table>
                  <table width="80%" height="110" border="0" align="center" cellpadding="0" cellspacing="0">
                      <tr>
                        <td width="29%" style="height: 25px">用户名：</td>
                        <td colspan="2" style="height: 25px">
                            <asp:TextBox ID="txt_UserName" runat="server" TabIndex="1" Width="110px" MaxLength="20"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td>密　码：</td>
                        <td colspan="2">
                            <asp:TextBox ID="txt_Paw" runat="server" TabIndex="2" TextMode="Password" Width="110px" MaxLength="20"></asp:TextBox></td>
                      </tr>
                     <%-- <tr>
                          <td>
                              验证码：</td>
                          <td colspan="2">
                              <asp:TextBox ID="TextBox3" runat="server" MaxLength="4" Width="52px"></asp:TextBox>
                              <asp:Image ID="Image1" runat="server" ImageUrl="CheckCode.aspx" /></td>
                      </tr>--%>
                      <tr>
                        <td style="height: 21px">&nbsp;</td>
                        <td colspan="2" style="height: 21px">
                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/gl_13.jpg" OnClick="btn_login_Click" /></td>
                      </tr>
                    </table>
                </form></td>
              </tr>
          </table></td>
          </form>
    
          <td valign="top" bgcolor="#FFFFFF" style="height: 289px; width: 42px;"><img src="Images/glpt_09.jpg" width="45" height="228" alt="" />&nbsp;</td>
        </tr>
      </table>
      <table width="781" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="83" background="Images/xt_16.jpg">&nbsp;</td>
        </tr>
      </table></td>
    <td width="24" background="Images/xt_10.jpg" style="height: 478px">&nbsp;</td>
  </tr>
</table>
    </div>
</body>
</html>
