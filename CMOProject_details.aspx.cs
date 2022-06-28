using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;

public partial class CMOProject_details : System.Web.UI.Page
{
    Dropdown drop = new Dropdown();
    MD5Util md5util = new MD5Util();
    Random randObj = new Random();
    Int32 UniqueRandomNumber = 0;
    string View = "";
    string projectstatus = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["cmoview"] != null)
            {
                string cmoview = MD5Util.Decrypt(Request.QueryString["cmoview"].ToString(), true);
                if (cmoview == "y")
                {
                    //trentry.Visible = false;
                    ddlstatus.Visible = true;
                    lblstatus.Visible = true;
                    grdprojctdtls.Columns[4].Visible = true;
                    //grdprojctdtls.Columns[7].Visible = true;
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
                    grdprojctdtls.Columns[4].Visible = false;
                }

                if (projectstatus == "C")
                {
                    //to do
                    ddlstatus.SelectedValue = projectstatus;
                    //}
                    //trentry.Visible = false;
                    ddlstatus.Visible = false;
                    lblstatus.Visible = false;
                    grdprojctdtls.Columns[4].Visible = false;
                }

            }
            fill_grid();
            fill_Department();
            fillstatus();
        }
    }

    private void fill_grid()
    {
        //try
        //{
            DataTable dt = new DataTable();
            dt = drop.getprojectdtls(projectstatus);
            if (dt.Rows.Count > 0)
            {
          
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
                lblnorecord.Text = "No Record Found";
                trsearch.Visible = false;
            }
       // }
        //catch (Exception ex)
        //{
        //    //Response.Redirect("ErrorPage.aspx");
        //}
        
    }


    protected void grdprojctdtls_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string pcode = (grdprojctdtls.DataKeys[e.Row.RowIndex].Values["pcode"]).ToString().Trim();

            HyperLink h1 = (HyperLink)e.Row.FindControl("lnkbtncmoview");
            h1.NavigateUrl = md5util.CreateTamperProofURL("CMOEnterDirection.aspx", null, "pcode=" + MD5Util.Encrypt(pcode, true) + "&view=" + MD5Util.Encrypt("View", true));
                        
            HyperLink h2 = (HyperLink)e.Row.FindControl("linkbtn_trail");
            h2.NavigateUrl = md5util.CreateTamperProofURL("ViewProjectTrail.aspx", null, "pcode=" + MD5Util.Encrypt(pcode, true));

            //HyperLink h2 = (HyperLink)e.Row.FindControl("hlinkpname");
            //h2.NavigateUrl = md5util.CreateTamperProofURL("CMOEnterDirection.aspx", null, "pcode=" + MD5Util.Encrypt(pcode, true) + "&view=" + MD5Util.Encrypt("View", true));

            //HyperLink h3 = (HyperLink)e.Row.FindControl("hlinknodaldept");
            //h3.NavigateUrl = md5util.CreateTamperProofURL("CMOEnterDirection.aspx", null, "pcode=" + MD5Util.Encrypt(pcode, true) + "&view=" + MD5Util.Encrypt("View", true));

            //HyperLink h4 = (HyperLink)e.Row.FindControl("hlinkenddate");
            //h4.NavigateUrl = md5util.CreateTamperProofURL("CMOEnterDirection.aspx", null, "pcode=" + MD5Util.Encrypt(pcode, true) + "&view=" + MD5Util.Encrypt("View", true));

        }
      
    }
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
            ddlstatus.Items.Insert(0, Utlity.AllItem());
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

}