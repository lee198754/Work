<%@ Page Language="C#" AutoEventWireup="true" CodeFile="managedata.aspx.cs" Inherits="managedata" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>数据库管理</title>
 <link href="main.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
	<!--
	body{
	margin:0;
	padding:0;
	font-family:Arial, Helvetica, sans-serif;
	font-size:12px;}
	.p1{
	margin:70px 0 0 230px;
	vertical-align:bottom;}
	-->
	.p2{
	margin:15px 0 0 230px;
	vertical-align:bottom;}
	.btn{
	vertical-align:middle;
	height:25px;
	}
	</style>
    </head>
<body style="background-color: #dddddd;">
    <form id="form1" runat="server">
    <p class="itemp"></p>
    <div style="text-align: center" >
        <table cellpadding="0" cellspacing="0" style="background-image: url(Images/background.jpg);
            width: 644px; background-repeat: no-repeat; height: 400px">
            <tr><td>
            	<p class="p1" style="text-align: left">
                	<span >上传备份文件：</span><asp:FileUpload ID="FileUpload1" runat="server" Width="194px" CssClass="btn"/>
                 <asp:Button ID="btnupload" runat="server" OnClick="btnupload_Click" Text="上传备份" ToolTip="把备份文件上传至服务器" CssClass="btn" CausesValidation="False" />
                 </p>
                 <p class="p2" style="text-align: left">
                 	选择还原文件：<asp:DropDownList ID="DropDownList1" runat="server" Width="124px" CssClass="btn"></asp:DropDownList><asp:Button ID="btnreturn" runat="server" OnClick="btnreturn_Click" Text="还原备份" ToolTip="还原系统数据库" CssClass="btn" CausesValidation="False" Width="63px" /> <asp:Button ID="btndownload" runat="server"  OnClick="btndownload_Click" Text="下载备份" ToolTip="下载备份" CssClass="btn" CausesValidation="False" Width="63px" />
                     <asp:Button ID="btn_DelFile" runat="server"  Text="删除备份" ToolTip="删除备份" CssClass="btn" CausesValidation="False" Width="63px" OnClick="btn_DelFile_Click" /></p>
                  <p class="p2" style="text-align: left">
                      <span>备份文件名称：</span><asp:TextBox ID="TextBox1" runat="server"  Width="117px" ></asp:TextBox> <asp:Button ID="Button1" runat="server"  OnClick="Button1_Click" Text="备份数据" ToolTip="备份系统数据库" CssClass="btn"></asp:Button>
                   </p>
          </td>
            </tr>
        </table>
    </div>
        <input id="txt_DBName" type="hidden" runat="server" value="" />
    </form>
</body>
</html>