using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class taskAction : System.Web.UI.Page
{  
    message msg = new message();
    Query query = new Query();
    DataTable dt = new DataTable();
    GetQuery objgq = new GetQuery();
    MD5Util md5util = new MD5Util();
    string pcode = string.Empty, taskid = string.Empty, flag = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["taskid"] != null)
        { taskid = MD5Util.Decrypt(Request.QueryString["taskid"].ToString(), true); }
        else
        { taskid = string.Empty; }

        if (Request.QueryString["pcode"] != null)
        { pcode = MD5Util.Decrypt(Request.QueryString["pcode"].ToString(), true); }
        else
        { pcode = string.Empty; }

        if (Request.QueryString["flag"] != null)
        { flag = MD5Util.Decrypt(Request.QueryString["flag"].ToString(), true); }
        else
        { flag = string.Empty; }

        if (Request.QueryString["duedate"] != null)
        { hfduedate.Value = MD5Util.Decrypt(Request.QueryString["duedate"].ToString(), true); }
        else
        { hfduedate.Value = string.Empty; }

        if (flag == "add")
        {
            lbl_mainheading.Text = "Enter Action Taken";
            inputaction.Visible = true;
        } 
        else if(flag == "rev")
        {
            lbl_mainheading.Text = "Revise Timeline";            
            updatedate.Visible = true;
        }
        else
        {
            lbl_mainheading.Text = "View Actions";
        }
        FillGrid();
        FillGridCMRemrks();
    }

    public void FillGrid()
    {
        dt = objgq.GetActions(taskid, Session["deptcode"].ToString());
        if (dt.Rows.Count > 0)
        {
            gridheading_workdone.Visible = true;
            Gridviewactions.Visible = true;
            //trheaderactions.Visible = true;
            Gridviewactions.DataSource = dt;
            Gridviewactions.DataBind();
        }
        else
        {
            //trheaderactions.Visible = false;
            Gridviewactions.Visible = false;
        }
    }

    public void FillGridCMRemrks()
    {
        dt = objgq.GetCMRemarks(taskid, pcode);
        if (dt.Rows.Count > 0)
        {
            gridheading_cm.Visible = true;
            Gridcmremarks.Visible = true;
            Gridcmremarks.DataSource = dt;
            Gridcmremarks.DataBind();
        }
        else
        {
            Gridcmremarks.Visible = false;
        }
    }



    protected void btn_add_Click(object sender, EventArgs e)
    {
        if (txtactiondetail.Text == "")
        {
            msg.Show("Please enter new target date!");
        }
        if (txt_actiondt.Text == "")
        {
            msg.Show("Please enter the reason for change!");
        }
        else
        {
            string ip = Request.ServerVariables["REMOTE_ADDR"].ToString();
            string userid = Session["userid"].ToString();
            DateTime edate = DateTime.Now;

            string path = "";
            string FilePath = Path.GetFileName(fuFileUpload.PostedFile.FileName);
            string filetype = Path.GetExtension(this.fuFileUpload.FileName);

            if (FilePath != null && FilePath !="")
            {
                long fileSize = fuFileUpload.PostedFile.ContentLength;
                int ErrorCode = Utility.ValidateUploadedFile(FilePath, filetype, fileSize, true);
                if (ErrorCode > 0)
                {
                    string msgStr = "Error Code " + ErrorCode.ToString();
                    string redirectPage = "taskAction.aspx?taskid=ACESODHQBqk=&pcode=KUQJtBiGX7c=&flag=imXblvk2We4=";
                    string script = "alert('" + msgStr + "');\n";
                    script += "location.href='" + redirectPage + "';\n";
                    Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);
                    return;
                }
                string doa = DateTime.Now.ToString("yyyy-MM-dd");
                string ServiceCode = "9999";
                path = Utility.GetFilePath(ServiceCode, taskid, doa);
                string filenam = taskid + "_" + 4956 + filetype;
                path = path + "\\" + filenam;
                fuFileUpload.PostedFile.SaveAs(path);
            }

            if (Validation.chkLeve28(txtactiondetail.Text.Trim()))
            {
                msg.Show("Invalid Inputs");
                return;
            }

            // int temp = query.insertactionmaster(taskid, Session["deptcode"].ToString(), txtactiondetail.Text, txt_actiondt.Text, ip, userid, edate;
            int temp = query.insertactionmaster(taskid, Session["deptcode"].ToString(), txtactiondetail.Text, txt_actiondt.Text, ip, userid, edate, path, filetype,pcode);

            if (temp > 0)
            {
                msg.Show("Action added Successfully !");
            }
            flag = "add";
            Response.Redirect("taskAction.aspx?taskid=" + MD5Util.Encrypt(taskid, true) + "&pcode=" + MD5Util.Encrypt(pcode, true) + "&flag=" + MD5Util.Encrypt(flag,true));
            

        }
    }

    protected void btnupdt_Click(object sender, EventArgs e)
    {
        if (txtnewdate.Text == "")
        {
            msg.Show("Please enter new target date!");
        }
        if (txtreason.Text == "")
        {
            msg.Show("Please enter the reason for change!");
        }

        if (Validation.chkLeve28(txtreason.Text.Trim()))
        {
            msg.Show("Invalid Inputs");
            return;
        }

        else
        {
            string ip = Request.ServerVariables["REMOTE_ADDR"].ToString();
            string userid = Session["userid"].ToString();
            DateTime edate = DateTime.Now;
            // int temp = query.updatetaskmaster(taskid, pcode, txtnewdate.Text, txtreason.Text);
            int temp = query.updatetaskmaster(taskid, pcode, txtnewdate.Text, txtreason.Text, hfduedate.Value, ip,userid);

            if (temp > 0)
            {
                string msgStr = "Revised timeline updated !";
                string redirectPage = "DeptLogin.aspx?flag=" + MD5Util.Encrypt("rev", true);
                string script = "alert('" + msgStr + "');\n";
                script += "location.href='" + redirectPage + "';\n";
                Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);
            }
            //flag = "rev";
            //Response.Redirect("taskAction.aspx?taskid=" + MD5Util.Encrypt(taskid, true) + "&pcode=" + MD5Util.Encrypt(pcode, true) + "&flag=" + MD5Util.Encrypt(flag, true));
        }
    }

    protected void Gridviewactions_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string taskid = (Gridviewactions.DataKeys[e.Row.RowIndex].Values["taskid"]).ToString().Trim();
            string contenttype = (Gridviewactions.DataKeys[e.Row.RowIndex].Values["contenttype"]).ToString().Trim();
            string actionid = (Gridviewactions.DataKeys[e.Row.RowIndex].Values["actionid"]).ToString().Trim();

            HyperLink hprlinkbtn = (HyperLink)e.Row.FindControl("hprlinkbtn");
            if (contenttype != "")
            {
                hprlinkbtn.NavigateUrl = md5util.CreateTamperProofURL("ViewFile.aspx", null, "taskid=" + MD5Util.Encrypt(taskid, true) + "&actionid=" + MD5Util.Encrypt(actionid, true));
            }
            else
            {
                hprlinkbtn.ToolTip = "No Documents Uploaded";
            }


            //HyperLink hyplinksnoviewdoc = (HyperLink)e.Row.FindControl("lnkbtserialnumberviewdoc");
            //if (contenttype != "")
            //{              
            //    hyplinksnoviewdoc.NavigateUrl = md5util.CreateTamperProofURL("ViewFile.aspx", null, "taskid=" + MD5Util.Encrypt(taskid, true) + "&actionid=" + MD5Util.Encrypt(actionid, true));
            //}
            //else
            //{
            //    hyplinksnoviewdoc.ToolTip = "No Documents Uploaded";
            //}
        }
    }
}