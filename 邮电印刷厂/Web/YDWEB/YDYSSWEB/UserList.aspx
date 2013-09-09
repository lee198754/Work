<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserList.aspx.cs" Inherits="UserList" %>

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
              <td>用户管理</td>
              <td class="HeadTdAdd"><a href="A_User.aspx" target="_parent" ><img src="images/Add.gif" width="14" height="14" border="0" class="HeadImage" alt="添加用户" />添加</a></td>
              <td class="HeadTd3" style="width: 16px"></td>
            </tr>
          </table>
         </div>
         <div class="sList">
              <asp:GridView ID="GridView_UserName" runat="server" Width="100%" AutoGenerateColumns="False" BorderStyle="None" GridLines="None" AllowPaging="True" PageSize="15" DataKeyNames="F_iID,F_sName" OnPageIndexChanging="GridView_UserName_PageIndexChanging" 
                OnRowDataBound="GridView_UserName_RowDataBound" OnRowDeleting="GridView_UserName_RowDeleting" OnRowEditing="GridView_UserName_RowEditing">
                   <Columns>
                         <asp:TemplateField HeaderText="用户名">
                             <ItemTemplate>
                                <%#DataBinder.Eval(Container.DataItem, "F_sName")%>
                             </ItemTemplate>
                            <HeaderStyle CssClass="ListTH" />
                            <ItemStyle CssClass="ListTd1" />
                       </asp:TemplateField>
                        <asp:TemplateField HeaderText="真实姓名">
                             <ItemTemplate>
                                <%#DataBinder.Eval(Container.DataItem, "F_sRealName")%>
                             </ItemTemplate>
                            <HeaderStyle CssClass="ListTH" />
                            <ItemStyle CssClass="ListTd1" />
                       </asp:TemplateField>
                       <asp:BoundField DataField="t_Name" HeaderText="权限" >
                           <HeaderStyle CssClass="ListTH" />
                           <ItemStyle CssClass="ListTd1"  Width="100px" />
                       </asp:BoundField>
                        <asp:BoundField DataField="F_sUserName" HeaderText="客户名称" >
                           <HeaderStyle CssClass="ListTH" />
                           <ItemStyle CssClass="ListTd1" Width="200px"  />
                       </asp:BoundField>
                       <asp:BoundField DataField="F_iCode" HeaderText="代码" >
                           <HeaderStyle CssClass="ListTH" />
                           <ItemStyle CssClass="ListTd1" Width="100px"  />
                       </asp:BoundField>
                      <%-- <asp:BoundField DataField="F_sEmail" HeaderText="邮箱" >
                           <HeaderStyle CssClass="ListTH" />
                           <ItemStyle CssClass="ListTd" />
                       </asp:BoundField>--%>
                       
                       <asp:BoundField DataField="F_sText" HeaderText="注册时间" DataFormatString="{0:d}" HtmlEncode="False" >
                           <HeaderStyle CssClass="ListTH" />
                           <ItemStyle CssClass="ListTd1" Width="80px"/>
                       </asp:BoundField>
                       <asp:ButtonField ButtonType="Image" CommandName="Edit" ImageUrl="~/Images/edt.gif" Text="编辑" HeaderText="编辑">
                           <HeaderStyle CssClass="ListTH" />
                           <ItemStyle CssClass="ListTd1" Width="30px" />
                       </asp:ButtonField>
                        <asp:ButtonField ButtonType="Image" CommandName="Delete" ImageUrl="~/Images/del.gif" Text="删除" HeaderText="删除" CausesValidation="True">
                           <HeaderStyle CssClass="ListTH" />
                           <ItemStyle CssClass="ListTd1" Width="30px" />
                       </asp:ButtonField>
                   </Columns>
                    <PagerTemplate>
                      <table width="98%">
                          <tr>
                              <td style="text-align: right; font-size: 12px;">
                                  <asp:Label ID="lblPageIndex" runat="server" Text='<%# ((GridView)Container.Parent.Parent).PageIndex + 1  %>'></asp:Label>/<asp:Label ID="lblPageCount" runat="server"  Text='<%# ((GridView)Container.Parent.Parent).PageCount  %>'></asp:Label>Page
                                  &nbsp;
                                  <asp:LinkButton ID="btnFirst" runat="server" CausesValidation="False" CommandArgument="First"
                                      CommandName="Page" Text="First" Visible="<%# ((GridView)Container.NamingContainer).PageIndex != 0 %>"></asp:LinkButton>
                                  <asp:LinkButton ID="btnPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                      CommandName="Page" Text="Prev" Visible="<%# ((GridView)Container.NamingContainer).PageIndex != 0 %>"></asp:LinkButton>
                                  <asp:LinkButton ID="btnNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                      CommandName="Page" Text="Next" Visible="<%# ((GridView)Container.NamingContainer).PageIndex != ((GridView)Container.NamingContainer).PageCount - 1 %>"></asp:LinkButton>
                                  <asp:LinkButton ID="btnLast" runat="server" CausesValidation="False" CommandArgument="Last"
                                      CommandName="Page" Text="Last" Visible="<%# ((GridView)Container.NamingContainer).PageIndex != ((GridView)Container.NamingContainer).PageCount - 1 %>"></asp:LinkButton>
                                  <asp:TextBox ID="txtNewPageIndex" runat="server" CssClass="PageTextBox" MaxLength="6" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/\D/g,''))"
                                      onkeypress="return event.keyCode>=48&&event.keyCode<=57" onkeyup="if(event.keyCode !=37 && event.keyCode != 39) value=value.replace(/\D/g,'');"
                                      onpaste="return !clipboardData.getData('text').match(/\D/)" Text='<%# ((GridView)Container.Parent.Parent).PageIndex + 1  %>'
                                      Width="20px"></asp:TextBox>
                                  <asp:LinkButton ID="btnGo" runat="server" CausesValidation="False" CommandArgument="-1" CommandName="Page" Text="GO"></asp:LinkButton>
                                  <!-- here set the CommandArgument of the Go Button to '-1' as the flag -->
                              </td>
                          </tr>
                      </table>
              </PagerTemplate>
               </asp:GridView>
         </div>
       </div>
    </div>
    </form>
</body>
</html>
