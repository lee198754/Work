<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>福建省邮电印刷厂邮政贺卡信息查询系统</title>
 <link href="CSS/Main.css" rel="stylesheet" type="text/css" />
</head>
<body >
    <form id="form1" runat="server">
    <iframe src="Top.aspx" style="width:100%; height:105px;"></iframe>
    <div>
    
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
      <td align="center" valign="top" class="MainLeft" style="height: 520px">
         <table border="0" cellpadding="0" cellspacing="0" style=" text-align:center;" width="450px">
           <tr>
              <td style="height:90px; width:90px" ><a id="ywcx2"  runat="server" visible="false" href="SelectList.aspx" target="_blank"><img src="Images/YY2.png" alt="" border="0" /></a></td>
               <td style="width: 90px; height: 30px">
                </td>
              <td style="height:90px; width:90px"><a  id="ywtj2"  runat="server" visible="false" href="Sel_YWTJ.aspx" target="_blank"><img src="Images/TJXX.png" alt="" border="0" /></a></td>
               <td style="width: 90px; height: 90px">
               </td>
               <td style="height:90px; width:90px" id="tdsql2" runat="server" visible="false"><a href="managedata.aspx" target="_blank"><img src="Images/database.png" alt="" border="0" /></a> </td>
           </tr>
            <tr>
              <td style="height:30px; width:90px" ><a  id="ywcx" runat="server" visible="false" href="SelectList.aspx" target="_blank">业务查询</a></td>
              <td></td>
              <td style="height:30px; width:90px" ><a id="ywtj" runat="server" visible="false" href="Sel_YWTJ.aspx" target="_blank">业务统计</a></td>
                <td style="width: 90px; height: 30px">
                </td>
                <td style="height:30px; width:90px" id="tdsql" runat="server" visible="false"><a href="managedata.aspx" target="_blank">数据库管理</a>
                </td>
           </tr>
           <tr>
              <td style="height:90px; width:90px"></td>
              <td></td>
              <td style="height:90px; width:90px"><%--<img src="Images/j1.png" alt="" border="0" />--%></td>
               <td style="width: 90px; height: 90px">
               </td>
               <td style="width: 90px; height: 90px">
               </td>
           </tr>
           <tr>
                <td style="height:90px; width:90px"  ><a id="sctj2" visible="false" runat="server" href="Sel_SCTJ.aspx" target="_blank"><img src="Images/KHXQD.png" alt="" border="0" /></a></td>
              <td><%--<img src="Images/j2.png" alt="" border="0" />--%></td>
              <td style="height:90px; width:90px" ><a id="td1" runat="server" visible="false" href="UserList.aspx" target="_blank"><img src="Images/ZGL.png" alt="" border="0" /></a></td>
               <td runat="server" style="width: 90px; height: 90px" visible="True">
               </td>
               <td runat="server" style="width: 90px; height: 90px" visible="True">
                   <a id="yztxz1" runat="server" visible="False" href="FileBrowse.aspx" 
                       target="_blank">
                   <img src="Images/My%20Documents.png" alt="" border="0" /></a></td>
              
           </tr>
           <tr>
              <td style="height:30px; width:90px" ><a id="sctj" runat="server" visible="false" href="Sel_SCTJ.aspx" target="_blank">生产统计</a></td>
              <td></td>
              <td style="height:30px; width:90px"><a  id="td2" runat="server" visible="false" href="UserList.aspx" target="_blank">用户管理</a></td>
               <td runat="server" style="width: 90px; height: 30px" visible="True">
               </td>
               <td runat="server" style="width: 90px; height: 30px" visible="True">
               <a  id="yztxz2" runat="server" visible="false" href="FileBrowse.aspx" target="_blank">
                   邮资图库下载</a></td>
           </tr>
         </table>
      </td>
    </tr>
    </table>
    
    
    </div>
    </form>
</body>
</html>
