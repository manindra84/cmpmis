using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Collections;
using System.Threading;
using Npgsql;

public partial class EnterDirection : System.Web.UI.Page
{
    Dropdown drop = new Dropdown();
    DataTable dt2 = new DataTable();
    message msg = new message();
    Random randObj = new Random();
    Int32 UniqueRandomNumber = 0;
    MD5Util md5util = new MD5Util();
    string viewonly = "";
    string SQL = string.Empty;
    GetData objgetdata = new GetData();
    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (!IsPostBack)
        {
            //ViewState["RefUrl"] = Request.UrlReferrer.ToString();

            if (StringUtil.GetQueryString(Request.Url.ToString()) != null)
            {

                //if (md5util.IsURLTampered(StringUtil.GetWithoutDigest(StringUtil.GetQueryString(Request.Url.ToString())),
                //StringUtil.GetDigest(StringUtil.GetQueryString(Request.Url.ToString()))) == true)
                //{
                //    Response.Redirect("Login.aspx?id=0");
                //}
            }
          
            if (Request.QueryString["pcode"] != null)
            {
                hfpcode.Value = MD5Util.Decrypt(Request.QueryString["pcode"].ToString(), true);
            }

            //aarush changes
            if (Request.QueryString["view"] != null)
            {
                viewonly = MD5Util.Decrypt(Request.QueryString["view"].ToString(), true);
                //for Activity > View List
                if (viewonly.ToString() == "view")
                {
                    tr1.Visible = false;
                    tr2.Visible = false;
                    //aarush_uat
                    //tr3.Visible = false;
                    tr4.Visible = false;
                    tr5.Visible = false;
                    tr6.Visible = false;

                    lblheader.Text = "List of Activity in the Project";

                }
                //for Project > View List
                else if (viewonly.ToString() == "noview")
                {
                    tr1.Visible = false;
                    tr2.Visible = false;
                    //aarush_uat
                    //tr3.Visible = false;
                    tr4.Visible = false;
                    tr5.Visible = false;
                    tr6.Visible = false;

                    lblheader.Text = "List of Activity in the Project";
                }
                //for Activity > Add New
                else if (viewonly.ToString() == "add")
                {
                    lblheader.Text = " Assign New Activity in the Project";
                    divsubprojname.Visible = true;
                }



                if (Session["usertype"].ToString() == "13")
                {
                    grdprojview.Columns[7].Visible = false;
                    grdprojview.Columns[8].Visible = true;
                }



            }
            //if view in query string is null
            else
            {
                Response.Redirect("ErrorPage.aspx");
            }
          
        
            filllabels();
            txtdirection.Focus();
            fill_grid();
            fill_Department();
            fillSubProjeName();
        }
       
    }


    private void fill_grid()
    {
        DataTable dtfill = new DataTable();
        DataTable dt3 = new DataTable();
        dt3 = drop.getdept_taskmaster_2(hfpcode.Value);


        if (hfpcode.Value != "")
        {
            dtfill = drop.getdept_taskmaster(hfpcode.Value);
        }  
        if(dtfill.Rows.Count > 0)
        {
           
            grdprojview.DataSource = dtfill;
            grdprojview.DataBind();
           
        }
        
                
        for (int i = 0; i < dtfill.Rows.Count; i++)
        {
             //rows for which due date has passed current date, will become red.
            if (dt3.Rows[i]["enddt"].ToString() != null && dt3.Rows[i]["enddt"].ToString() !="")
            {
                DateTime endt = Convert.ToDateTime(dt3.Rows[i]["enddt"]);
                if (endt < DateTime.Now)
                {
                    grdprojview.Rows[i].ForeColor = System.Drawing.Color.Red;
                }
            }

            //fill revised timeline dates for activity
            string taskid = dtfill.Rows[i]["taskid"].ToString();
            dt2 = drop.get_revisetimelinelog(taskid);
            if(dt2.Rows.Count > 0)
            {
                for(int j=0;j<dt2.Rows.Count;j++)
                {
                    //grdprojview.Columns[3].
                }
            }
        }


        //string removeduplicate = grdprojview.Rows[0].Cells[2].Text.Trim();
        //for (int i = 1; i < grdprojview.Rows.Count; i++)
        //{
        //    if (grdprojview.Rows[i].Cells[2].Text.Trim() == removeduplicate)
        //    {
        //        grdprojview.Rows[i].Cells[2].Text = string.Empty;
        //    }
        //    else
        //    {
        //        removeduplicate = grdprojview.Rows[i].Cells[2].Text.Trim();
        //    }

        //}

        //Logic for unique names
        string initialnamevalue = grdprojview.Rows[0].Cells[2].Text;
        for (int i = 1; i < grdprojview.Rows.Count; i++)
        {

            if (grdprojview.Rows[i].Cells[2].Text == initialnamevalue)
                grdprojview.Rows[i].Cells[2].Text = string.Empty;
            else
                initialnamevalue = grdprojview.Rows[i].Cells[2].Text;
        }



    }

    protected void btnsbmt_Click(object sender, EventArgs e)
    {
        try
        {
            string ipaddress = Request.ServerVariables["REMOTE_ADDR"].ToString();
            string userid = Session["userid"].ToString();
            DateTime edate = DateTime.Now;
            string officerid = string.Empty;

            //aarush_uat
            //if (txtboxtargetdate.Text != "" && Utlity.comparedatesDMY(txtboxtargetdate.Text, txtdateofissue.Text) <= 0)
            //{
            //    msg.Show("Target Date Should be greater than Date of Activity completion date");
            //    return;
            //}

            DataTable dt;
            string query = @"select * from  taskmaster where taskname =@taskname and pcode=@pcode ";
            NpgsqlCommand cmd1 = new NpgsqlCommand(query);
            cmd1.Parameters.AddWithValue("@taskname", txtdirection.Text);
            cmd1.Parameters.AddWithValue("@pcode", hfpcode.Value);
            dt = objgetdata.GetDataTable(cmd1);

            if (dt.Rows.Count > 0)
            {
                if (txtdirection.Text.Trim().ToUpper() == dt.Rows[0]["taskname"].ToString().ToUpper())
                {
                    message msg = new message();
                    msg.Show("Duplicate Entry Found , Activity not be Same");
                    return;
                }
            }


            int result = drop.inserttask(txtdirection.Text, ipaddress, userid, hfpcode.Value, "P",ddldeptnodal.SelectedValue,txtboxtargetdate.Text,ddlsubprojname.SelectedValue,txtactivityremarks.Text.Trim());
            if (result > 0)
            {
                //Server.Transfer("Project_details.aspx?flag=view");

                Response.Redirect("EnterDirection.aspx?pcode=" + MD5Util.Encrypt(hfpcode.Value, true) + "&view=" + MD5Util.Encrypt("view", true));
            }
        }
        catch (ThreadAbortException TAE)
        {
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }

    public void fill_Department()
    {
        Dropdown objddl = new Dropdown();
        DataTable dt1 = new DataTable();
        //dt1 = objddl.GetNodalDept(hfpcode.Value);
        dt1 = objddl.GetAllDept();
        for (int i = 0; i < dt1.Rows.Count; i++)
        {
            for (int j = 0; j < dt1.Columns.Count; j++)
            {
                //dt.Rows[i][j] = Utility.getstring(dt.Rows[i][j].ToString());
                if (string.IsNullOrEmpty(dt1.Rows[i][j].ToString()))
                {

                }
                else
                {
                    dt1.Rows[i][j] = Utlity.getstring(dt1.Rows[i][j].ToString());
                }
            }
        }
        ddldeptnodal.DataValueField = "deptcode";
        ddldeptnodal.DataTextField = "deptname";
        ddldeptnodal.DataSource = dt1;
        if (dt1.Rows.Count > 0)
        {          
            ddldeptnodal.DataBind();
            ddldeptnodal.Items.Insert(0, Utlity.FirstItem());
        }
        else
        {
     

        }
    }


    private void filllabels()
    {
        string str = null;
        try
        {
            DataTable dt = null;
            //new function
            //dt = drop.ViewDirections("",hftaskid.Value);
            dt = drop.GetProjname(hfpcode.Value);
            if (dt.Rows.Count>0)
            {
                lblprojectname.InnerText = dt.Rows[0]["pname"].ToString();
                //Label1projstarteddate.InnerText = dt.Rows[0]["startdate"].ToString();
                lblppcomdate.InnerText = dt.Rows[0]["enddate"].ToString();
                lblnodaldept.InnerText = dt.Rows[0]["deptname"].ToString();


                //lblmeeting.Text = hfmeetindatetime.Value;
                //lblissuename.Text = dt.Rows[0]["taskname"].ToString();

                //aarush changes
                //for (int i = 0; i < dt.Rows.Count; i++)
                //{
                //    lblprojectname.InnerText = dt.Rows[0]["pname"].ToString();
                //    Label1projstarteddate.InnerText = dt.Rows[0]["startdate"].ToString();
                //    lblppcomdate.InnerText = dt.Rows[0]["enddate"].ToString();
                //    if (dt.Rows[i]["nodaldept"].ToString() == "Y")
                //    {
                //        lblnodaldept.InnerText = dt.Rows[i]["deptname"].ToString();
                        
                //    }
                //    else
                //    {
                //        str = str + dt.Rows[i]["deptname"].ToString() +",";                     
                //        lblotherconcerneddept.InnerText = str;

                //    }
                //    lblotherconcerneddept.InnerText = lblotherconcerneddept.InnerText.TrimEnd(new char[] { ',' });
                //    if(lblotherconcerneddept.InnerText == null || lblotherconcerneddept.InnerText == "")
                //    {
                //        lblotherconcerneddept.InnerText = "--";
                //    }
              
                //    //lblotherconcerneddept.Text.TrimEnd(',');
                //}
            }
         
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }

    protected void grdprojview_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string pcode = (grdprojview.DataKeys[e.Row.RowIndex].Values["pcode"]).ToString().Trim();
            string taskid = (grdprojview.DataKeys[e.Row.RowIndex].Values["taskid"]).ToString().Trim();

            HyperLink h2 = (HyperLink)e.Row.FindControl("hlinkdirectionAdd");
            h2.NavigateUrl = md5util.CreateTamperProofURL("EnterCMODirection.aspx", null, "pcode=" + MD5Util.Encrypt(pcode, true) + "&taskid=" + MD5Util.Encrypt(taskid, true) + "&flag=" + MD5Util.Encrypt("add", true));

            HyperLink h3 = (HyperLink)e.Row.FindControl("hlinkdirectionView");
            h3.NavigateUrl = md5util.CreateTamperProofURL("EnterCMODirection.aspx", null, "pcode=" + MD5Util.Encrypt(pcode, true) + "&taskid=" + MD5Util.Encrypt(taskid, true) + "&cmview=" + MD5Util.Encrypt("cmview", true) + "&flag=" + MD5Util.Encrypt("view", true));
            //h3.NavigateUrl = md5util.CreateTamperProofURL("EnterCMODirection.aspx", null, "pcode=" + MD5Util.Encrypt(pcode, true) + "&taskid=" + MD5Util.Encrypt(taskid, true) + "&flag=" + MD5Util.Encrypt("view", true));

            if (viewonly.ToString() == "view")
            {
                h2.Visible = false;
            }
            //h3.NavigateUrl = md5util.CreateTamperProofURL("ViewworkDone.aspx", null, "pcode=" + MD5Util.Encrypt(pcode, true));
        }

        //string oldValue = string.Empty;
        //string newValue = string.Empty;
        ////  for (int count = 0; count < gvList.Rows.Count; count++)
        //for (int j = 3; j <2; j++)
        //{         
        //        for (int count = 0; count < grdprojview.Rows.Count; count++)
        //    {
        //        oldValue = grdprojview.Rows[count].Cells[j].Text;
        //        if (oldValue == newValue)
        //        {
        //            grdprojview.Rows[count].Cells[j].Text = string.Empty;
        //        }
        //        newValue = oldValue;
        //    }
        //}

       


    }

    //protected void btnback_Click(object sender, EventArgs e)
    //{
    //    object refUrl = ViewState["RefUrl"];
    //    if (refUrl != null)
    //        Response.Redirect((string)refUrl);
    //}

    public void fillSubProjeName()
    {
        Dropdown objddl = new Dropdown();
        DataTable dt1 = new DataTable();
        dt1 = objddl.GetddlSubprojname(hfpcode.Value);
        for (int i = 0; i < dt1.Rows.Count; i++)
        {
            for (int j = 0; j < dt1.Columns.Count; j++)
            {
                //dt.Rows[i][j] = Utility.getstring(dt.Rows[i][j].ToString());
                if (string.IsNullOrEmpty(dt1.Rows[i][j].ToString()))
                {

                }
                else
                {
                    dt1.Rows[i][j] = Utlity.getstring(dt1.Rows[i][j].ToString());
                }
            }
        }
        ddlsubprojname.DataValueField = "id";
        ddlsubprojname.DataTextField = "subprojname";
        ddlsubprojname.DataSource = dt1;

        if (dt1.Rows.Count > 0 && viewonly.ToString() == "add")
        {
             
            divsubprojname.Visible = true;
            ddlsubprojname.DataBind();
            ddlsubprojname.Items.Insert(0, Utlity.First());
        }
        else
        {
            divsubprojname.Visible = false;
        }

    }

    protected void grdprojview_RowCommand(object sender, GridViewCommandEventArgs e)
    {
       if (e.CommandName.Equals("deletetask"))
        {

            List<NpgsqlCommand> cmdList = new List<NpgsqlCommand>();
            NpgsqlCommand cmd = null;

            int rowIndex = int.Parse(e.CommandArgument.ToString());
            //Get the value of column from the DataKeys using the RowIndex.
            int pcode = Convert.ToInt32(grdprojview.DataKeys[rowIndex].Values[0]);
            int taskid = Convert.ToInt32(grdprojview.DataKeys[rowIndex].Values[1]);


            SQL = @"delete from task_dept where taskid in (select taskid from taskmaster where pcode=@pcode and taskid=@taskid)";
            cmd = new NpgsqlCommand(SQL);
            cmd.Parameters.AddWithValue("@pcode", pcode);
            cmd.Parameters.AddWithValue("@taskid", taskid);
            cmdList.Add(cmd);


            SQL = @"delete from taskmaster where pcode=@pcode and taskid=@taskid";
            cmd = new NpgsqlCommand(SQL);
            cmd.Parameters.AddWithValue("@pcode", pcode);
            cmd.Parameters.AddWithValue("@taskid", taskid);
            cmdList.Add(cmd);

            SQL = @"delete from cmdirection where pcode=@pcode and taskid=@taskid";
            cmd = new NpgsqlCommand(SQL);
            cmd.Parameters.AddWithValue("@pcode", pcode);
            cmd.Parameters.AddWithValue("@taskid", taskid);
            cmdList.Add(cmd);




            long[] InsCount = objgetdata.DeleteTransactionalData(cmdList);
            if (InsCount[0] > 0)
            {
                string msgStr = "Task Details Deleted  Successfully";
                //string redirectPage = "EnterDirection.aspx?flag=" + MD5Util.Encrypt("no", true);
                string redirectPage = "EnterDirection.aspx?pcode=" + MD5Util.Encrypt(pcode.ToString(), true) + "&view=" + MD5Util.Encrypt("view", true);
                string script = "alert('" + msgStr + "');\n";
                script += "location.href='" + redirectPage + "';\n";
                Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);
            }

        }
    }
}