using Npgsql;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewFile : System.Web.UI.Page
{

    GetData data = new GetData();
    public DataTable dt;
    public string taskid = string.Empty, DocID = string.Empty, FilePath = string.Empty, FileType = string.Empty, Source = string.Empty;
    public string actionid = string.Empty;
    public int counter = 0;
    public bool ShowFlag = false;
    public Stream download = null;
    const int bufferLength = 10000;
    byte[] buffer = new Byte[bufferLength];
    message msg = new message();


    protected void Page_Load(object sender, EventArgs e)
    {
        if ((Session["usertype"].ToString() == "10"))
        {

        }
        else
        {
            Response.Redirect("UnauthoriseUser.aspx");
            //string msgStr = "You are UnAuthorised User to View this page";
            //string redirectPage = "UnauthoriseUser.aspx";
            //string script = "alert('" + msgStr + "');\n";
            //script += "location.href='" + redirectPage + "';\n";
            //Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);
        }

        if (Request.QueryString["taskid"].ToString() != null)
        {
            taskid = MD5Util.Decrypt(Request.QueryString["taskid"].ToString(), true);
        }
        else
        {
            taskid = string.Empty;
        }

        if (Request.QueryString["actionid"].ToString() != null)
        {
            actionid = MD5Util.Decrypt(Request.QueryString["actionid"].ToString(), true);
        }
        else
        {
            actionid = string.Empty;
        }
        

        FillData();
    }

    protected void FillData()
    {
        try
        {
            string SQL = "";
            //if (Source == "Objection")
           // {
                SQL = "select taskid,contenttype,FilePath from actionmaster where taskid = @taskid and actionid=@actionid ";
            //}
            //else
            //{
               // SQL = "select contenttype,FilePath from billmaster where billidn = @billidn ";
           // }


            NpgsqlCommand cmd = new NpgsqlCommand(SQL);
            cmd.Parameters.AddWithValue("@taskid", taskid);
            cmd.Parameters.AddWithValue("@actionid", actionid);

            dt = data.GetDataTable(cmd);
            {
                if (dt != null && dt.Rows.Count > 0)
                {
                    FileType = dt.Rows[0]["contenttype"].ToString();
                    FilePath = dt.Rows[0]["FilePath"].ToString();
                }
               
                    if (FileType == ".pdf")
                    {
                        WebClient User = new WebClient();
                        Byte[] FileBuffer = User.DownloadData(FilePath);
                        if (FileBuffer != null)
                        {
                            Response.ContentType = "application/pdf";
                            Response.AddHeader("content-length", FileBuffer.Length.ToString());
                            Response.BinaryWrite(FileBuffer);
                        }
                    }
                    else if (FileType.ToLower() == ".jpg" || FileType.ToLower() == ".jpeg")
                    {
                        Response.ContentType = "image/jpeg"; // for JPEG file
                        Response.WriteFile(FilePath);
                    }
                    else
                {
                    msg.Show("No Document Uploaded");
                }              
            }
           
        }
        catch { Response.Redirect("ErrorPage.aspx"); }


    }
}