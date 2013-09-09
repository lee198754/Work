<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SelectList.aspx.cs" Inherits="SelectList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>福建省邮电印刷厂邮政贺卡信息查询系统</title>
<link href="CSS/A_Main.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function blurCase()
        {
            var xx=document.getElementById("txtSearch");
            if(xx.value=="") xx.value="用户号码";
        }
        function focusCase()
        {
            var xx=document.getElementById("txtSearch")
            if(xx.value=="用户号码") {xx.value="";}
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div align="center">
            <div class="sContent">
                <div>
                    <table border="0" cellpadding="0" cellspacing="0" class="HeadTable">
                        <tr>
                            <td class="HeadTd1" style="width: 12px; ">
                            </td>
                            <td class="HeadTd2" >
                                &nbsp</td>
                            <td  >
                                业务查询</td>
                            <td class="HeadTdAdd" >
                                <%--<a href="AddNews.aspx" target="Main">
                                    <img src="../../../Images/Add.gif" width="14" height="14" border="0" class="HeadImage" />添加</a>--%></td>
                            <td class="HeadTd3" style="width: 16px;  ">
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="sList" style="height:550px;">
                    <table cellspacing="0" border="0" style="border-style: None; width: 100%; border-collapse: collapse;">
                        <tr>
                            <td class="ListTd" scope="col" style="text-align:left;">
                                &nbsp;<%--<asp:TextBox ID="txtSearch" name="txtSearch" onblur="blurCase()" onfocus="focusCase()"
                                    runat="server" CssClass="TextBox" Text="用户号码"></asp:TextBox>--%>
                                <%--<asp:Button ID="Button1" runat="server" Text="   " CssClass="Search" OnClick="Button1_Click" />--%>
                                快速查询：<asp:TextBox ID="txt_12" runat="server" MaxLength="2" Width="20px"></asp:TextBox>-<asp:Label ID="lb_DM" runat="server" Text=""></asp:Label>
                                <asp:TextBox ID="txt_code1" runat="server" MaxLength="16" Width="60px"></asp:TextBox>-<asp:TextBox ID="txt_13" runat="server" MaxLength="2" Width="20px"></asp:TextBox>-
                                <asp:TextBox ID="txt_code2" runat="server" Width="66px"></asp:TextBox>
                                &nbsp; &nbsp;稿件名称关键字：<asp:TextBox ID="txt_select" runat="server" Width="160px"></asp:TextBox>
                                &nbsp;
                                <asp:Button ID="btn_sel" runat="server" Text="查  询" OnClick="Button1_Click"/>
                                <span style="color: #ff0000">
                                （您可以根据需要，有选择地输入三个文本框的内容）</span>
                                </td>
                                </tr>
                    </table>
                    <asp:GridView ID="GridView_News" runat="server" Width="100%" AutoGenerateColumns="False"
                        BorderStyle="None" GridLines="None" AllowPaging="True" PageSize="15" DataKeyNames=""
                        EmptyDataText='<table cellspacing="0" border="0"style="border-style:None;width:100%;border-collapse:collapse;"><tr><th class="ListTH" scope="col">标题</th><th class="ListTH" scope="col">日期</th><th class="ListTH" scope="col" style="width:30px;">查看</th><th class="ListTH" scope="col" style="width:30px;">删除</th></tr></table>'
                        OnRowDataBound="GridView_News_RowDataBound"
                        OnPageIndexChanging="GridView_News_PageIndexChanging" >
                        <Columns>
                        <asp:BoundField HeaderText="编号" Visible="false">
                                <HeaderStyle CssClass="ListTH" Width="5%" />
                                <ItemStyle CssClass="ListTd1" Width="5%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="F_sJg" HeaderText="客户">
                                <HeaderStyle CssClass="ListTH" Width="12%" />
                                <ItemStyle CssClass="ListTd1" Width="12%"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="F_sCpbh" HeaderText="产品编号" >
                                <HeaderStyle CssClass="ListTH" Width="15%" />
                                <ItemStyle CssClass="ListTd1" Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="F_sKhmc" HeaderText="品名">
                                <HeaderStyle CssClass="ListTH" Width="16%" />
                                <ItemStyle CssClass="ListTd1" Width="16%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="F_sType" HeaderText="种类">
                                <HeaderStyle CssClass="ListTH" Width="5%" />
                                <ItemStyle CssClass="ListTd1" Width="5%" />
                            </asp:BoundField>
                           
                            <asp:BoundField DataField="F_dJsrq" HeaderText="接收时间" DataFormatString="{0:d}" HtmlEncode="false">
                                <HeaderStyle CssClass="ListTH" Width="10%" />
                                <ItemStyle CssClass="ListTd1" Width="10%" />
                            </asp:BoundField>
                            
                             <asp:BoundField DataField="F_nYl" HeaderText="数量(枚)">
                                <HeaderStyle CssClass="ListTH" Width="10%" />
                                <ItemStyle CssClass="ListTd1" Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="F_tiJybz" HeaderText="加印标志">
                                <HeaderStyle CssClass="ListTH" Width="7%" />
                                <ItemStyle CssClass="ListTd1" Width="7%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="WorkOrder" HeaderText="生产状态">
                                <HeaderStyle CssClass="ListTH" Width="10%" />
                                <ItemStyle CssClass="ListTd1" Width="10%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="WorkOrder" HeaderText="要货时间">
                                <HeaderStyle CssClass="ListTH" Width="10%" />
                                <ItemStyle CssClass="ListTd1" Width="10%" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="操作">
                            <HeaderStyle CssClass="ListTH" Width="10%" />
                            <ItemStyle CssClass="ListTd1" Width="5%" />
                            <ItemTemplate>
                            <a href="Sel_Detail.aspx?ID=<%# GetID(DataBinder.Eval(Container.DataItem,"F_iID")) %>" target="_blank">详细</a>
                                 <%--<asp:Label ID="Label1" runat="server" Text='<%# GetState(DataBinder.Eval(Container.DataItem,"F_iState")) %>'></asp:Label>--%>
                            </ItemTemplate>
                            </asp:TemplateField>
                          
                        </Columns>
                        <PagerTemplate>
                            <table width="98%">
                                <tr>
                                    <td style="text-align: right; font-size: 12px;">
                                        第<asp:Label ID="lblPageIndex" runat="server" Text='<%# ((GridView)Container.Parent.Parent).PageIndex + 1  %>'></asp:Label>页,共<asp:Label
                                            ID="lblPageCount" runat="server" Text='<%# ((GridView)Container.Parent.Parent).PageCount  %>'></asp:Label>页
                                        &nbsp;
                                        <asp:LinkButton ID="btnFirst" runat="server" CausesValidation="False" CommandArgument="First"
                                            CommandName="Page" Text="首页" Visible="<%# ((GridView)Container.NamingContainer).PageIndex != 0 %>"></asp:LinkButton>
                                        <asp:LinkButton ID="btnPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                            CommandName="Page" Text="上一页" Visible="<%# ((GridView)Container.NamingContainer).PageIndex != 0 %>"></asp:LinkButton>
                                        <asp:LinkButton ID="btnNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                            CommandName="Page" Text="下一页" Visible="<%# ((GridView)Container.NamingContainer).PageIndex != ((GridView)Container.NamingContainer).PageCount - 1 %>"></asp:LinkButton>
                                        <asp:LinkButton ID="btnLast" runat="server" CausesValidation="False" CommandArgument="Last"
                                            CommandName="Page" Text="尾页" Visible="<%# ((GridView)Container.NamingContainer).PageIndex != ((GridView)Container.NamingContainer).PageCount - 1 %>"></asp:LinkButton>
                                        <asp:TextBox ID="txtNewPageIndex" runat="server" CssClass="PageTextBox" MaxLength="6"
                                            onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/\D/g,''))"
                                            onkeypress="return event.keyCode>=48&&event.keyCode<=57" onkeyup="if(event.keyCode !=37 && event.keyCode != 39) value=value.replace(/\D/g,'');"
                                            onpaste="return !clipboardData.getData('text').match(/\D/)" Text='<%# ((GridView)Container.Parent.Parent).PageIndex + 1  %>'
                                            Width="20px"></asp:TextBox>
                                        <asp:LinkButton ID="btnGo" runat="server" CausesValidation="False" CommandArgument="-1"
                                            CommandName="Page" Text="搜"></asp:LinkButton>
                                        <!-- here set the CommandArgument of the Go Button to '-1' as the flag -->
                                    </td>
                                </tr>
                                
                            </table>
                        </PagerTemplate>
                    </asp:GridView>
                    <div id="divnum" runat="server" ></div>
                </div>
                
                <br />
                <br />
            </div>
        </div>
   <input type="hidden" id="txtwhere" runat="server" /> 
   <input type="hidden" id="txtwhere2" runat="server" /> 
   <input id="txtiCSID" runat="server" type="hidden" />
   <input type="hidden" id="txtMonth" runat="server" /> 
   <input type="hidden" id="txtType" runat="server" />
   <input type="hidden" id="txt_Name" runat="server" />
    </form>
</body>
</html>

