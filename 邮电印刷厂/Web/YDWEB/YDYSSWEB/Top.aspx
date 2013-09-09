<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Top.aspx.cs" Inherits="Top" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
 <link href="CSS/Top.css" rel="stylesheet" type="text/css" />
    <%--<script language="javascript" type="text/javascript" src="../JS/Popedom.js"></script>--%>
    <script language="javascript" type="text/javascript">		
  function ComfirmExit(action)
   {
	if(action==1)
	{
		myconfirm = confirm("确定要关闭窗口,退出展厅WEB管理系统吗？");
		if (myconfirm==true){
			top.location.href="logout.aspx?Action=1";
		}
	}
	if(action==2)
	{
		myconfirm = confirm("确定要重新登陆吗？");
		if (myconfirm==true){
			top.location.href="logout.aspx?Action=2";
		}
		
	}
 }
 
  //修改密码
 function OpenEidtPassWord()
      {
         var ret=window.open('EidtPassWord.aspx','','height=300,width=400,scrollbars=no');
         width=screen.width;
         height=screen.height;
         ret.moveTo((width-400)/2,(height-300)/2);
 }
		
</script>
</head>
<body>
    <form id="form1" runat="server">
      <div class="DivHead">
       <div id="top">
         <ul>
         <li><a onclick="ComfirmExit(1)" href="javascript:void(0)" target="_self"><img src="Images/btn3.png" style="height:24px; width:111px;" border="0" alt="退出系统"  /></a>
         <li><a href="javascript:void(0)" onclick="OpenEidtPassWord();"><img src="Images/btn2.png"  style="height:24px; width:111px;" border="0" alt="桌面" /></a></li>
         <li><a onclick="ComfirmExit(2)" href="javascript:void(0)" target="_self"><img src="Images/btn1.png" style="height:24px; width:111px;" border="0" alt="注销系统"   /></a></li>
         </ul>
       </div>
    </div>
  <%--<div class="Menu">
      <table style="width:100%"  cellpadding="0" cellspacing="0" border="0">
        <tr>
         <td align="left" class="Menuleft"><span class="tMeun">&nbsp;&nbsp;主功能选项</span></td>
         <td align="left"><span class="dMeun">业务处理</span></td>
         <td align="left"><span>&nbsp;</span></td>
         <td align="right" class="Menuright" ><span class="dMeun" >&nbsp; 基本列表</span></td>
        </tr>
       </table>
    </div>--%>
    </form>
</body>
</html>

