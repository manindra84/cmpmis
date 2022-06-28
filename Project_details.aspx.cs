using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;
using Npgsql;

public partial class Project_details : System.Web.UI.Page
{
    Dropdown drop = new Dropdown();
    MD5Util md5util = new MD5Util();
    Random randObj = new Random();
    Int32 UniqueRandomNumber = 0;
    string flag = string.Empty;
    string projectstatus = "";
    string SQL = string.Empty;
    GetData objgetdata = new GetData();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.QueryString["flag"].ToString() != null)
        {
            //flag = Request.QueryString["flag"].ToString();
            flag = MD5Util.Decrypt(Request.QueryString["flag"].ToString(), true);
        }
        else
        {
            flag = string.Empty;
        }

        if (!IsPostBack)
        {
            //if (StringUtil.GetQueryString(Request.Url.ToString()) != null)
            //{

            //    //if (md5util.IsURLTampered(StringUtil.GetWithoutDigest(StringUtil.GetQueryString(Request.Url.ToString())),
            //    //StringUtil.GetDigest(StringUtil.GetQueryString(Request.Url.ToString()))) == true)
            //    //{
            //    //    Response.Redirect("Login.aspx?id=0");
            //    //}
            //}

            

            if (flag == "view")
            {
                lbl_gridheading.Text = "#Click S.No to view activity details.";              
                grdprojctdtls.Columns[2].Visible = true;

            }
            else if(flag == "add")
            {
                lbl_gridheading.Text = "#Click S.No to add activity details.";               
                grdprojctdtls.Columns[1].Visible = true;
            }
            else if(flag == "no")
            {
                lbl_gridheading.Text = "#Click S.No to view project details.";
                grdprojctdtls.Columns[0].Visible = true;
                grdprojctdtls.Columns[8].Visible = true;

                //grdprojctdtls.Columns[0].Visible = true;
                //grdprojctdtls.Columns[8].Visible = true;
            }

            if (Session["usertype"].ToString() == "13")
            {
                lbl_gridheading.Text = "#Click S.No to view project details.";
                //grdprojctdtls.Columns[0].Visible = true;
                grdprojctdtls.Columns[8].Visible = false;
                grdprojctdtls.Columns[9].Visible = true;
                grdprojctdtls.Columns[10].Visible = true;
            }


            //if (Request.QueryString["new"] != null)
            //{
            //    View = Request.QueryString["new"].ToString();
            //    if (View == "n")
            //    {
            //        grdprojctdtls.Columns[7].Visible = false;
            //        grdprojctdtls.Columns[6].Visible = true;
            //        //trentry.Visible = false;
            //        // lblheader.Visible = true;
            //        tr1.Visible = true;
            //    }
            //}

            if (Request.QueryString["cmoview"] != null)
            {
                string cmoview = MD5Util.Decrypt(Request.QueryString["cmoview"].ToString(), true);
                if (cmoview == "y")
                {
                    //trentry.Visible = false;
                    ddlstatus.Visible = true;
                    grdprojctdtls.Columns[7].Visible = true;
                    lblstatus.Visible = true;
                }
            }

            if (Request.QueryString["cmostatus"] != null)
            {
                // if (Request.QueryString["cmostatus"].ToString() == "P")
                // {
                 projectstatus = MD5Util.Decrypt(Request.QueryString["cmostatus"].ToString(), true);
                if (projectstatus == "P")
                {
                    //projectstatus = Request.QueryString["cmostatus"].ToString();
                    ddlstatus.SelectedValue = projectstatus;
                    //}
                    //trentry.Visible = false;
                    ddlstatus.Visible = false;
                    lblstatus.Visible = false;
                }
                if (projectstatus == "C")
                {
                    //to do
                }

            }


            fill_grid();
            fill_Department();
            fillstatus();
        }
    }

    private void fill_grid()
    {
        try
        {
            DataTable dt = new DataTable();
            dt = drop.getprojectdtls(projectstatus);
            if (dt.Rows.Count > 0)
            {

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        if (!string.IsNullOrEmpty(dt.Rows[i][j].ToString()))
                        {
                            dt.Rows[i][j] = Utlity.getstring(dt.Rows[i][j].ToString());
                        }
                    }
                }            

                ViewState["sortorder"] = "DESC";
                string status = "";
                if (Request.QueryString["status"] != null)
                {
                    status = MD5Util.Decrypt(Request.QueryString["status"].ToString(), true);
                }

                if (status != "")
                {
                    // trentry.Visible = false;
                    //trback.Visible = true;
                    DataRow[] dr = dt.Select("statuscode='" + status + "'");
                    DataTable dt2 = dr.CopyToDataTable();
                    grdprojctdtls.DataSource = dt2;
                    grdprojctdtls.DataBind();
                }
                else
                {
                    if (Session["usertype"].ToString() == "11")
                    {
                        // trback.Visible = false;
                    }
                    else
                    {
                        
                        // trentry.Visible = true;
                    }
                   // trback.Visible = false;
                    grdprojctdtls.DataSource = dt;
                    grdprojctdtls.DataBind();
                }
            }
            else
            {
                lblnorecord.InnerText = "No Record Found";
                trsearch.Visible = false;
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx");
        }
        
    }


    //protected void grdprojctdtls_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        string pcode = (grdprojctdtls.DataKeys[e.Row.RowIndex].Values["pcode"]).ToString().Trim();

    //        HyperLink h2 = (HyperLink)e.Row.FindControl("hlinkIssues");
    //        h2.NavigateUrl = md5util.CreateTamperProofURL("EnterDirection.aspx", null, "pcode=" + MD5Util.Encrypt(pcode, true));

    //        HyperLink h3 = (HyperLink)e.Row.FindControl("hlinkviewworkdone");
    //        h3.NavigateUrl = md5util.CreateTamperProofURL("EnterDirection.aspx", null, "pcode=" + MD5Util.Encrypt(pcode, true) + "&view=" + MD5Util.Encrypt("View", true));

    //        //h3.NavigateUrl = md5util.CreateTamperProofURL("ViewworkDone.aspx", null, "pcode=" + MD5Util.Encrypt(pcode, true));
    //    }
      
    //}
    protected void grdprojctdtls_Sorting(object sender, GridViewSortEventArgs e)
    {
        DataTable dataTable = (DataTable)ViewState["grddatatable"];

        if (dataTable != null)
        {
            DataView dataView = new DataView(dataTable);
            dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql();
            grdprojctdtls.DataSource = dataView;
            grdprojctdtls.DataBind();
        }
    }

    private string ConvertSortDirectionToSql()
    {
        string newSortDirection = String.Empty;
        string sortDirection = ViewState["sortorder"].ToString();
        switch (sortDirection)
        {
            case "ASC":
                newSortDirection = "DESC";
                break;

            case "DESC":
                newSortDirection = "ASC";
                break;
        }
        ViewState["sortorder"] = newSortDirection;
        return newSortDirection;
    }

   
    public void fill_Department()
    {
        Dropdown objddl = new Dropdown();
        DataTable dt1 = new DataTable();
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
        ddldept.DataValueField = "deptcode";
        ddldept.DataTextField = "deptname";
        ddldept.DataSource = dt1;
        if (dt1.Rows.Count > 0)
        {
            ddldept.DataBind();
            ddldept.Items.Insert(0, Utlity.FirstItem());
        }
        
    }


    public void fillstatus()
    {
        Dropdown objddl = new Dropdown();
        DataTable dt1 = new DataTable();
        dt1 = objddl.GetStatus();
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
        ddlstatus.DataValueField = "status";
        ddlstatus.DataTextField = "statusdesc";
        ddlstatus.DataSource = dt1;
        if (dt1.Rows.Count > 0)
        {
            ddlstatus.DataBind();
            ddlstatus.Items.Insert(0, Utlity.FirstItem());
        }

    }
    protected void btnsearch_Click(object sender, EventArgs e)
    {
        Dropdown objddl = new Dropdown();
        DataTable  dt = objddl.Searchproject(ddldept.SelectedValue,txtboxpname.Text,ddlstatus.SelectedValue);
        if (dt.Rows.Count > 0)
        {
            grdprojctdtls.DataSource = dt;
            grdprojctdtls.DataBind();
            grdprojctdtls.Visible = true;

        }
        else
        {
            //fill_grid();
            grdprojctdtls.Visible = false;
           
        }
    }


    protected void grdprojctdtls_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridView testGrid = (GridView)sender;

        if (e.CommandName.Equals("normal"))
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            //Get the value of column from the DataKeys using the RowIndex.            
            int pcode = Convert.ToInt32(testGrid.DataKeys[rowIndex].Values[1]);

            //Response.Redirect("Action.aspx?taskid=" + MD5Util.Encrypt(taskid.ToString(),true) +"&pcode="+ MD5Util.Encrypt(pcode.ToString(), true));            
            Response.Redirect("EnterDirection.aspx?pcode=" + MD5Util.Encrypt(pcode.ToString(), true) + "&view=" + MD5Util.Encrypt("noview",true));

        }
        else if (e.CommandName.Equals("newactivity"))
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            //Get the value of column from the DataKeys using the RowIndex.            
            int pcode = Convert.ToInt32(testGrid.DataKeys[rowIndex].Values[1]);

            //Response.Redirect("Action.aspx?taskid=" + MD5Util.Encrypt(taskid.ToString(),true) +"&pcode="+ MD5Util.Encrypt(pcode.ToString(), true));

            Response.Redirect("EnterDirection.aspx?pcode=" + MD5Util.Encrypt(pcode.ToString(), true) + "&view=" + MD5Util.Encrypt("add", true));
        }
        else if (e.CommandName.Equals("viewactivity"))
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            //Get the value of column from the DataKeys using the RowIndex.
            
            int pcode = Convert.ToInt32(testGrid.DataKeys[rowIndex].Values[1]);

            //Response.Redirect("Action.aspx?taskid=" + MD5Util.Encrypt(taskid.ToString(),true) +"&pcode="+ MD5Util.Encrypt(pcode.ToString(), true));

            Response.Redirect("EnterDirection.aspx?pcode=" + MD5Util.Encrypt(pcode.ToString(), true) + "&view=" + MD5Util.Encrypt("view", true));
        }

      
        //adding subproject name
        else if (e.CommandName.Equals("addsubproject"))
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            //Get the value of column from the DataKeys using the RowIndex.
            int pcode = Convert.ToInt32(testGrid.DataKeys[rowIndex].Values[1]);

            Response.Redirect("addsubproject.aspx?pcode=" + MD5Util.Encrypt(pcode.ToString(), true));
        }


        //Edit project name
        else if (e.CommandName.Equals("editproject"))
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            //Get the value of column from the DataKeys using the RowIndex.
            int pcode = Convert.ToInt32(testGrid.DataKeys[rowIndex].Values[1]);

            Response.Redirect("EditProject.aspx?pcode=" + MD5Util.Encrypt(pcode.ToString(), true));
        }



        else if (e.CommandName.Equals("deleteproject"))
        {

            List<NpgsqlCommand> cmdList = new List<NpgsqlCommand>();
            NpgsqlCommand cmd = null;

            int rowIndex = int.Parse(e.CommandArgument.ToString());
            //Get the value of column from the DataKeys using the RowIndex.
            int pcode = Convert.ToInt32(testGrid.DataKeys[rowIndex].Values[1]);



            SQL = @"delete from project_dept where pcode=@pcode";
            cmd = new NpgsqlCommand(SQL);
            cmd.Parameters.AddWithValue("@pcode", pcode);
            cmdList.Add(cmd);

            SQL = @"delete from subprojectmaster where pcode=@pcode";
            cmd = new NpgsqlCommand(SQL);
            cmd.Parameters.AddWithValue("@pcode", pcode);
            cmdList.Add(cmd);

            SQL = @"delete from projectmaster where pcode=@pcode";
            cmd = new NpgsqlCommand(SQL);
            cmd.Parameters.AddWithValue("@pcode", pcode);
            cmdList.Add(cmd);

            SQL = @"delete from task_dept where taskid in (select taskid from taskmaster where pcode=@pcode)";
            cmd = new NpgsqlCommand(SQL);
            cmd.Parameters.AddWithValue("@pcode", pcode);
            cmdList.Add(cmd);

            SQL = @"delete  from tasktimelinehistory where taskid in (select taskid from taskmaster where pcode=@pcode)";
            cmd = new NpgsqlCommand(SQL);
            cmd.Parameters.AddWithValue("@pcode", pcode);
            cmdList.Add(cmd);

            SQL = @"delete from taskmaster where pcode=@pcode";
            cmd = new NpgsqlCommand(SQL);
            cmd.Parameters.AddWithValue("@pcode", pcode);
            cmdList.Add(cmd);

            SQL = @"delete from cmdirection where pcode=@pcode";
            cmd = new NpgsqlCommand(SQL);
            cmd.Parameters.AddWithValue("@pcode", pcode);
            cmdList.Add(cmd);
         
            SQL = @"delete from actionmaster where pcode=@pcode";
            cmd = new NpgsqlCommand(SQL);
            cmd.Parameters.AddWithValue("@pcode", pcode);
            cmdList.Add(cmd);


            long[] InsCount = objgetdata.DeleteTransactionalData(cmdList);
            if (InsCount[0] > 0)
            {
                string msgStr = "Project Details, Task Details Deleted  Successfully";
                string redirectPage = "Project_details.aspx?flag=" + MD5Util.Encrypt("no", true);
                string script = "alert('" + msgStr + "');\n";
                script += "location.href='" + redirectPage + "';\n";
                Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);
            }

        }


    }
}