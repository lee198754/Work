using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Web.Services;

using FileManager;


public partial class _FileBrowse : PageWebBase
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Write(HttpContext.Current.Request.PhysicalApplicationPath);
        //this.RegisterStartupScript("", "<script> $('#divErr').jqm();</script>");
        if (!IsPostBack)
        {
            BindGrid();
        }
    }


    #region BindGrid()
    private void BindGrid()
    {
        List<FileSystemItem> list = FileSystemManager.GetItems();
        GridView1.DataSource = list;
        GridView1.DataBind();
        lblCurrentPath.Text = FileSystemManager.GetRootPath();
        lblCurrentShortPath.Text = "\\";
    }

    private void BindGrid(string path)
    {
        List<FileSystemItem> list = FileSystemManager.GetItems(path);
        GridView1.DataSource = list;
        GridView1.DataBind();
        lblCurrentPath.Text = path;
        lblCurrentShortPath.Text = path.Replace(FileSystemManager.GetRootPath(), "");
        if (lblCurrentShortPath.Text == "") 
        {
            lblCurrentShortPath.Text = "\\";
        }
    }
    #endregion

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton lb = (LinkButton)e.Row.Cells[1].FindControl("LinkButton1");
            if (lb.Text != "[根目录]" && lb.Text != "[上一级]")
            {
                if (Directory.Exists(lb.CommandArgument.ToString()))
                {
                    lb.Text = string.Format("<img src=\"images/file/folder.gif\" style=\"border:none; vertical-align:middle;\" /> {0}", lb.Text);
                }
                else
                {
                    string ext = lb.CommandArgument.ToString().Substring(lb.CommandArgument.LastIndexOf(".") + 1);
                    if ( (ext.IndexOf("\\")==-1) && (File.Exists(Server.MapPath(string.Format("images/file/{0}.gif", ext)))) )
                    {
                        lb.Text = string.Format("<img src=\"images/file/{0}.gif\" style=\"border:none; vertical-align:middle;\" /> {1}", ext, lb.Text);
                    }
                    else
                    {
                        lb.Text = string.Format("<img src=\"images/file/other.gif\" style=\"border:none; vertical-align:middle;\" /> {0}", lb.Text);
                    }
                }
            }
            else
            {
                e.Row.Cells[0].Controls.Clear();
            }
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (Directory.Exists(e.CommandArgument.ToString()))
        {
            BindGrid(e.CommandArgument.ToString());
        }
        else
        {
            DownloadFile.ResponseFile(e.CommandArgument.ToString(), System.Web.HttpContext.Current, false);
            //string path = e.CommandArgument.ToString(); 
            //path = path.Replace(FileSystemManager.GetRootPath(), "UserFile");
            //path = path.Replace("\\", "/");
            //Response.Redirect(path);
            //RegisterClientScriptBlock("", "<script language=javascript>window.open('" + path + "')</script>");
            //ResponseFile(Page.Request, Page.Response, "ReportToExcel.xls"
            //, System.Web.HttpRuntime.AppDomainAppPath + "XMLFiles//EduceWordFiles//" + this.Context.User.Identity.Name + ".xls", 1024000);
        }
    }

    /// <summary>
    /// 删除
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox cb = (CheckBox)row.Cells[0].FindControl("CheckBox1");
                if (cb.Checked)
                {
                    LinkButton lb = (LinkButton)row.Cells[1].FindControl("LinkButton1");
                    if (Directory.Exists(lb.CommandArgument))
                    {
                        if (!FileSystemManager.DeleteFolder(lb.CommandArgument))
                        { ShowErr("目录里面有文件！"); }
                    }
                    else
                    {
                        FileSystemManager.DeleteFile(lb.CommandArgument);
                    }
                }
            }
        }
        BindGrid(lblCurrentPath.Text);
    }

    /// <summary>
    /// 新建文件夹
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnCreateFolder_Click(object sender, EventArgs e)
    {
        if (FileSystemManager.IsUnsafeName(TextBox2.Text.ToString()))
        {
            ShowErr("文件夹名称违法！不允许添加本名称文件夹！");
        }
        else
        {
            FileSystemManager.CreateFolder(TextBox2.Text, lblCurrentPath.Text);        
        }
        BindGrid(lblCurrentPath.Text);
    }

    /// <summary>
    /// 新建文件
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnCreateFile_Click(object sender, EventArgs e)
    {
        if(FileSystemManager.IsSafeName(TextBox4.Text.ToString()))
        {
            FileSystemManager.CreateFile(TextBox4.Text, lblCurrentPath.Text);
        }
        else
        {
            ShowErr("文件名称违法！不允许添加本格式文件！");
        }
        BindGrid(lblCurrentPath.Text);
    }

    /// <summary>
    /// 上传
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnUpload_Click(object sender, EventArgs e)
    {
            if (FileSystemManager.IsSafeName(FileUpload1.FileName))
            {
                if (FileUpload1.HasFile)
                {
                        string path = lblCurrentPath.Text + "\\";
                        path += Path.GetFileName(FileUpload1.FileName);
                        FileUpload1.PostedFile.SaveAs(path);
                }
            }
            else
            {
                ShowErr("非法文件格式！" );           
            }
                BindGrid(lblCurrentPath.Text);
    }

    /// <summary>
    /// 剪切
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnCut_Click(object sender, EventArgs e)
    {
        List<string> items = new List<string>();
        foreach (GridViewRow row in GridView1.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox cb = (CheckBox)row.Cells[0].FindControl("CheckBox1");
                if (cb.Checked)
                {
                    LinkButton lb = (LinkButton)row.Cells[1].FindControl("LinkButton1");
                    items.Add(lb.CommandArgument);
                }
            }
        }
        ViewState["clipboard"] = items;
        ViewState["action"] = "cut";
    }

    /// <summary>
    /// 粘贴
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnPaste_Click(object sender, EventArgs e)
    {
        if (ViewState["clipboard"] != null)
        {
            if (ViewState["action"].ToString() == "cut")
            {
                List<string> items = (List<string>)ViewState["clipboard"];
                foreach (string s in items)
                {
                    if (Directory.Exists(s))
                    {
                        if (!Directory.Exists(lblCurrentPath.Text + s.Substring(s.LastIndexOf("\\"))))
                        {
                            Directory.Move(s, lblCurrentPath.Text + s.Substring(s.LastIndexOf("\\")));
                        }
                        else
                        {
                            ShowErr("当文件夹已存在时，无法创建该文件夹。");
                        }
                    }
                    else
                    {
                        if (!File.Exists(lblCurrentPath.Text + "\\" + Path.GetFileName(s)))
                        {
                            File.Move(s, lblCurrentPath.Text + "\\" + Path.GetFileName(s));
                        }
                        else
                        {
                            ShowErr("当文件已存在时，无法创建该文件。");
                        }
                    }
                }
            }
            else
            {
                List<string> items = (List<string>)ViewState["clipboard"];
                foreach (string s in items)
                {
                    if (Directory.Exists(s))
                    {
                        DirectoryInfo di = new DirectoryInfo(s);
                        FileSystemManager.CopyFolder(s, lblCurrentPath.Text + "\\" + di.Name);
                    }
                    else
                    {
                        File.Copy(s, lblCurrentPath.Text + "\\复件 " + Path.GetFileName(s), true);
                    }
                }
            }
        }
        ViewState["clipboard"] = null;
        ViewState["action"] = null;
        BindGrid(lblCurrentPath.Text);
    }

    /// <summary>
    /// 编辑
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox cb = (CheckBox)row.Cells[0].FindControl("CheckBox1");
                if (cb.Checked)
                {
                    LinkButton lb = (LinkButton)row.Cells[1].FindControl("LinkButton1");
                    if (Directory.Exists(lb.CommandArgument))
                    {
                         ShowErr("不能编辑文件夹！");
                    }
                    else
                    {
                        if (FileSystemManager.IsCanEdit(lb.CommandArgument))
                        {
                            FilePath.Text = lb.CommandArgument;
                            //打开读取文件
                            TextBox5.Text = FileSystemManager.OpenText(lb.CommandArgument);
                            Type cstype = this.GetType();
                            String csname2 = "ButtonClickScript";
                            ClientScript.RegisterClientScriptBlock(cstype, csname2, "<script> $().ready(function() {$('#divEditFile').jqmShow();});</script>");
                        }
                        else
                        {
                            ShowErr("不能编辑本格式文件！");
                        }
                        
                    }
                }
            }
        }
        BindGrid(lblCurrentPath.Text);
    }
    /// <summary>
    /// 编辑
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnEditFile(object sender, EventArgs e)
    {
        FileSystemManager.WriteAllText(FilePath.Text, TextBox5.Text);
        BindGrid(lblCurrentPath.Text);
    }

    /// <summary>
    /// 复制
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnCopy_Click(object sender, EventArgs e)
    {
        List<string> items = new List<string>();
        foreach (GridViewRow row in GridView1.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox cb = (CheckBox)row.Cells[0].FindControl("CheckBox1");
                if (cb.Checked)
                {
                    LinkButton lb = (LinkButton)row.Cells[1].FindControl("LinkButton1");
                    items.Add(lb.CommandArgument);
                }
            }
        }
        ViewState["clipboard"] = items;
        ViewState["action"] = "copy";
    }

    /// <summary>
    /// 重命名
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnRename_Click(object sender, EventArgs e)
    {
        string src = "";
        string dest = "";
        foreach (GridViewRow row in GridView1.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox cb = (CheckBox)row.Cells[0].FindControl("CheckBox1");
                if (cb.Checked)
                {
                    LinkButton lb = (LinkButton)row.Cells[1].FindControl("LinkButton1");
                    src = lb.CommandArgument;
                }
            }
        }
        if (src.Length > 0)
        {
            dest = src.Substring(0, src.LastIndexOf('\\'));
            dest = dest + "\\" + TextBox3.Text;
            if (Directory.Exists(src))
            {
                FileSystemManager.MoveFolder(src, dest);
            }
            else
            {
                FileSystemManager.MoveFile(src, dest);
            }
            BindGrid(lblCurrentPath.Text);
        }
    }
    protected void ShowErr(string Err)
    {
        ErrText.Text = Err;
        Type cstype = this.GetType();
        String csname2 = "ButtonClickScript";
        ClientScript.RegisterClientScriptBlock(cstype, csname2, "<script> $().ready(function() {$('#divErr').jqmShow();});</script>");
    }
}