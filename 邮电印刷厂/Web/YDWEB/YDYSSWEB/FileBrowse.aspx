<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FileBrowse.aspx.cs" Inherits="_FileBrowse" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>福建省邮电印刷厂邮政贺卡信息查询系统</title>
    <link href="images/StyleSheet.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/jqModal.js" type="text/javascript"></script>  
    <script type="text/javascript" language="javascript">  
    $(function() {
        $("#checkedAll").click(function() { 
            if ($(this).attr("checked") == true) { // 全选
                    $("input[@type='checkbox']").each(function() {
                    $(this).attr("checked", true);
                    });
                } else { // 取消全选
                    $("input[@type='checkbox']").each(function() {
                    $(this).attr("checked", false);
                });
            }
        });
    });

    $().ready(function() {
        $('#divCreate').jqm({trigger: '#create'});
        $('#divRename').jqm({trigger: '#rename'});
        $('#divDelete').jqm({trigger: '#delete'});
        $('#divUpload').jqm({trigger: '#upload'});
        $('#divCopy').jqm({trigger: '#copy'});
        $('#divPaste').jqm({trigger: '#paste'});
        $('#divEdit').jqm({trigger: '#edit'});
        $('#divCut').jqm({trigger: '#cut'});
        $('#divCreateFile').jqm({trigger: '#createfile'}); 
        $('#divErr').jqm();
        $('#divEditFile').jqm();     
    });
    </script>
</head>
<body>
<form id="form1" runat="server">
   <div id="menu" style="display: none" >
    <ul>
        <li><a href="Default.aspx"><img title="刷新" alt="刷新" src="images/ico/refresh.gif" /> 刷新</a></li>
        <li><a href="javascript:void(0);" id="create"><img title="新建" alt="新建" src="images/ico/folder_new.gif" /> 新建文件夹</a></li>
        <li><a href="javascript:void(0);" id="createfile"><img title="新建" alt="新建" src="images/ico/file_new.gif" /> 新建文件</a></li>
        <li><a href="javascript:void(0);" id="cut"><img title="剪切" alt="剪切" src="images/ico/cut.gif" /> 剪切</a></li>
        <li><a href="javascript:void(0);" id="copy"><img title="复制" alt="复制" src="images/ico/copy.gif" /> 复制</a></li>
        <li><a href="javascript:void(0);" id="paste"><img title="粘贴" alt="粘贴" src="images/ico/paste.gif" /> 粘贴</a></li>
        <li><a href="javascript:void(0);" id="edit"><img title="编辑" alt="编辑" src="images/ico/edit.gif" /> 编辑</a></li>
        <li><a href="javascript:void(0);" id="rename"><img title="重命名" alt="重命名" src="images/ico/rename.gif" /> 重命名</a></li>
        <li><a href="javascript:void(0);" id="delete"><img title="删除" alt="删除" src="images/ico/delete.gif" /> 删除</a></li>
        <li><a href="javascript:void(0);" id="upload"><img title="上传" alt="上传" src="images/ico/up.gif" /> 上传</a></li>
    </ul>
   </div>
   
   <div id="divCreate" class="jqmWindow" style="display:none;">
       <h3>新建文件夹</h3>
       名称：<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
       <asp:Button ID="btnCreateFolder" runat="server" Text="确定" OnClick="btnCreateFolder_Click" />
       <asp:Button ID="btnPanel2Cancel" runat="server" Text="取消" /><br />
   </div>
   
      <div id="divCreateFile" class="jqmWindow" style="display:none;">
       <h3>新建文件</h3>
       名称：<asp:TextBox ID="TextBox4" runat="server" Text="New File.txt"></asp:TextBox>
       <asp:Button ID="Button1" runat="server" Text="确定" OnClick="btnCreateFile_Click" />
       <asp:Button ID="Button4" runat="server" Text="取消" /><br />
   </div>
   
   <div id="divUpload" class="jqmWindow" style="display:none;">
       <h3>文件上传</h3>
       选择文件：<asp:FileUpload ID="FileUpload1" runat="server" />
       <asp:Button ID="btnUpload" runat="server" Text="确定"  OnClick="btnUpload_Click"/>
       <asp:Button ID="btnPanel3Cancel" runat="server" Text="取消" />
   </div>
   
   <div id="divRename" class="jqmWindow" style="display:none;">
       <h3>重命名</h3>
       新名称：
       <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
       <asp:Button ID="btnRename" runat="server" Text="确定" OnClick="btnRename_Click" />
       <asp:Button ID="btnPanel4Cancel" runat="server" Text="取消" />
   </div>
   
   <div id="divDelete" class="jqmWindow" style="display:none;">
       <h3>删除文件</h3>
       <p>确定删除选中的文件或文件夹吗？<br /><br />
       <asp:Button ID="btnDelete" runat="server" Text="确定" OnClick="btnDelete_Click" />
       <asp:Button ID="Button2" runat="server" Text="取消" /></p>
   </div>
   
   <div id="divCopy" class="jqmWindow" style="display:none;">
       <h3>复制文件</h3>
       <p>确定复制选中的文件或文件夹吗？<br /><br />
       <asp:Button ID="btnCopy" runat="server" Text="确定" OnClick="btnCopy_Click" />
       <asp:Button ID="Button3" runat="server" Text="取消" /></p>
   </div>
   
   <div id="divPaste" class="jqmWindow" style="display:none;">
       <h3>粘贴文件</h3>
       <p>确定粘贴选中的文件或文件夹吗？<br /><br />
       <asp:Button ID="btnPaste" runat="server" Text="确定" OnClick="btnPaste_Click" />
       <asp:Button ID="Button5" runat="server" Text="取消" /></p>
   </div>
   
   
   <div id="divEdit" class="jqmWindow" style="display:none;">
       <h3>编辑文件</h3>
       <p>确定编辑文件吗？<br /><br />
       <asp:Button ID="Button8" runat="server" Text="确定" OnClick="btnEdit_Click" />
       <asp:Button ID="Button9" runat="server" Text="取消" /></p>
   </div>
   
   <div id="divCut" class="jqmWindow" style="display:none;">
       <h3>剪切文件</h3>
       <p>确定剪切选中的文件或文件夹吗？<br /><br />
       <asp:Button ID="btnCut" runat="server" Text="确定" OnClick="btnCut_Click" />
       <asp:Button ID="Button7" runat="server" Text="取消" /></p>
   </div>
   
   <div id="divErr" class="jqmWindow" style="display:none;">
       <h3>Error</h3>
       <p><asp:Label ID="ErrText" Text="Err" Font-Bold="true" runat="server" Font-Names="Verdana" Font-Size="12px"></asp:Label><br /><br />
       <asp:Button ID="Button6" runat="server" Text="确定" /></p>
   </div>
   
   <div id="divEditFile" class="jqmWindow" style="display:none;">
       <h3>编辑文件</h3>
            <p>路径：<asp:Label ID="FilePath" Text="FilePath" Font-Bold="true" runat="server" Font-Names="Verdana" Font-Size="12px"></asp:Label><br /><br />
            <p><asp:TextBox ID="TextBox5" runat="server" Width="100%" Height="300px" TextMode="MultiLine"></asp:TextBox><br /><br />
       <asp:Button ID="Button10" runat="server" Text="确定" OnClick="btnEditFile" /></p>
   </div>

   <div style="padding:5px;"><strong>路径: </strong><asp:Label ID="lblCurrentPath" 
           Font-Bold="True" runat="server" Font-Names="Verdana" Font-Size="12px" 
           Visible="False"></asp:Label><asp:Label ID="lblCurrentShortPath" 
           Font-Bold="True" runat="server" Font-Names="Verdana" Font-Size="12px"></asp:Label></div>

    <div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%" OnRowCommand="GridView1_RowCommand" Font-Names="Verdana" Font-Size="12px" OnRowDataBound="GridView1_RowDataBound" CellPadding="3" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" />
                    </ItemTemplate>
                    <HeaderTemplate>
                        <input type="checkbox" name="checkedAll" id="checkedAll"/>
                    </HeaderTemplate>
                    <ItemStyle Width="3%" Wrap="False" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="名称">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("FullName") %>' Text='<%# Eval("Name") %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="CreationDate" HeaderText="创建日期" >
                    <ItemStyle Width="12%" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="Size" HeaderText="大小" DataFormatString="{0} KB" >
                    <ItemStyle HorizontalAlign="Right" Width="5%" Wrap="False" />
                </asp:BoundField>
            </Columns>
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <RowStyle ForeColor="#000066" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
        </asp:GridView>
    </div>
   <div style="text-align:center; margin:5px 0px;">Copyright (C) XRUI. All rights reserved. </div> 
</form>
</body>
</html>