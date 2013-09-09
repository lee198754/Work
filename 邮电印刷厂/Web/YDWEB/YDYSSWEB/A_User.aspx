<%@ Page Language="C#" AutoEventWireup="true" CodeFile="A_User.aspx.cs" Inherits="A_User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>福建省邮电印刷厂邮政贺卡信息查询系统</title>
    <link href="CSS/A_Main.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
   <div align="center">
       <div class="sContent">
          <div>
          <table border="0" cellpadding="0" cellspacing="0" class="HeadTable">
            <tr>
              <td class="HeadTd1" style="width: 12px"></td>
              <td class="HeadTd2">&nbsp</td>
              <td>添加/修改用户信息</td>
              <td class="HeadTd3" style="width: 16px"></td>
            </tr>
          </table>
         </div>
         <div class="sList">
             <div style="margin:80px 0px 0px 0px;" align="center">
             <fieldset style="width:550px;" align="center">
              <%--<legend >修改密码</legend>--%>
              <table border="0" cellpadding="0" cellspacing="0" width="550px;">
                  <tr>
                      <td colspan="2" style="height: 25px" align="center">
                      <span style="color:Red;">*</span> <span style="color: #999999;">带星号为必填项</span></td>
                  </tr>
                <tr>
                  <td style="width: 120px; height: 25px">
                      用户名：</td>
                  <td style="height: 25px" align="left">
                      <asp:TextBox ID="txt_UserName" runat="server" CssClass="TextBox" MaxLength="20" Width="150px"></asp:TextBox>
                      <span style="color:Red;">*</span></td>
                </tr>
                  <tr>
                      <td style="width: 120px; height: 25px">
                          密&nbsp; &nbsp; 码：</td>
                      <td style="height: 25px" align="left">
                          <asp:TextBox ID="txt_Password" runat="server" CssClass="TextBox" MaxLength="16" Width="150px" TextMode="Password"></asp:TextBox>
                          <span style="color:Red;">*</span> <span style="color: #999999;">密码长度为 ≥ 6, ≤ 16 位。</span></td>
                  </tr>
                  <tr>
                      <td style="width: 120px; height: 25px">
                          权 &nbsp;&nbsp; 限：</td>
                      <td style="height: 25px" align="left">
                          <asp:DropDownList ID="DL_Sex" runat="server" Width="155px">
                          </asp:DropDownList></td>
                  </tr>
                   <tr>
                      <td style="width: 120px; height: 25px">
                          真实姓名：</td>
                      <td align="left" style="height: 25px">
                          <asp:TextBox ID="txt_RealName" runat="server" CssClass="TextBox" Width="150px" MaxLength="100"></asp:TextBox>
                          <span style="color: #999999;"></span></td>
                  </tr>
                   <tr>
                      <td style="width: 120px; height: 25px">
                          客户名称：</td>
                      <td align="left" style="height: 25px">
                          <asp:TextBox ID="txt_Name" runat="server" CssClass="TextBox" Width="150px" MaxLength="100"></asp:TextBox>
                          <span style="color: #999999;"></span></td>
                  </tr>
                  <tr>
                      <td style="width: 120px; height: 25px">
                          代 &nbsp; 码：</td>
                      <td align="left" style="height: 25px">
                          <asp:TextBox ID="txt_Phone" runat="server" CssClass="TextBox" Width="150px" MaxLength="20"></asp:TextBox>
                          <span style="color: #999999;"></span></td>
                  </tr>
                  <tr>
                      <td style="width: 120px; height: 25px">
                          操作模块：</td>
                      <td align="left" style="height: 25px">
                          <asp:CheckBoxList ID="CheckBoxList1" runat="server" RepeatDirection="Horizontal"
                              RepeatLayout="Flow">
                              <asp:ListItem Value="1">业务查询</asp:ListItem>
                              <asp:ListItem Value="2">业务统计</asp:ListItem>
                              <asp:ListItem Value="3">生产统计</asp:ListItem>
                              <asp:ListItem Value="4">用户管理</asp:ListItem>
                              <asp:ListItem Value="5">邮资图下载</asp:ListItem>
                          </asp:CheckBoxList></td>
                  </tr>
                   <tr>
                      <td style="width: 120px; height: 25px">
                          备 &nbsp; 注：</td>
                      <td align="left" style="height: 25px">
                          <asp:TextBox ID="txt_F_sText1" runat="server" CssClass="TextBox" Width="328px" MaxLength="100" Height="65px" TextMode="MultiLine"></asp:TextBox>
                          <span style="color: #999999;"></span></td>
                  </tr>
                  <tr>
                      <td style="height: 25px" colspan="2" align="center">
                          <asp:Button ID="btn_Confrim" runat="server" OnClick="btn_Confrim_Click" Text="提  交" SkinID="ButtonSkin" Height="20px" />
                          &nbsp;&nbsp;
                          <input id="Reset1" type="reset" value="重  置" runat="server" style="height: 20px" />
                          &nbsp;&nbsp;
                          <asp:Button ID="btn_Return" runat="server" Height="20px" Text="返  回" OnClick="btn_Return_Click" /></td>
                  </tr>
             </table>
             </fieldset>
             </div>
         </div>
       </div>
    </div>
     <input id="txt_iID" type="hidden" value="0" runat="server" />
        <input id="txt_cUserName" type="hidden" value="" runat="server" />
    </form>
</body>
</html>
