using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;

public partial class AssignNodalOfficer : System.Web.UI.Page
{
    Dropdown drop = new Dropdown();
    GetQuery getQuery = new GetQuery();
    MD5Util md5util = new MD5Util();
    Random randObj = new Random();
    Int32 UniqueRandomNumber = 0;
    string flag = string.Empty;
    string projectstatus = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
          
            //lbl_gridheading.Text = "#Click S.No to view project details.";
            
            fill_grid();
        }
    }

    private void fill_grid()
    {
        try
        {
            DataTable dt = new DataTable();
            dt = getQuery.GetAssignedProject(Convert.ToInt32(Session["deptcode"]),txtboxpname.Text.Trim());
            grdprojctdtls.DataSource = dt;
            grdprojctdtls.DataBind();
           
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx");
        }

    }


    protected void grdprojctdtls_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlnodalofficer = (e.Row.FindControl("ddlofficer") as DropDownList);

            string nouserid = (grdprojctdtls.DataKeys[e.Row.RowIndex].Values["nouserid"]).ToString().Trim();
            string pcode = (grdprojctdtls.DataKeys[e.Row.RowIndex].Values["pcode"]).ToString().Trim();
            fill_Nodal(ddlnodalofficer);

            if(nouserid !="" && nouserid !=null)
            {
                ddlnodalofficer.SelectedValue = nouserid;
            }         
        }
    }

    public void fill_Nodal(DropDownList ddlnodal)
    {
        Dropdown objddl = new Dropdown();
        DataTable dt1 = new DataTable();
        dt1 = objddl.GetNodalOfficer(Convert.ToInt32(Session["deptcode"]));     
        ddlnodal.DataValueField = "user_id";
        ddlnodal.DataTextField = "user_name";
        ddlnodal.DataSource = dt1;
        if (dt1.Rows.Count > 0)
        {
            ddlnodal.DataBind();
            ddlnodal.Items.Insert(0, Utlity.First());
        }

    }

    protected void btnsearch_Click(object sender, EventArgs e)
    {

        fill_grid();
       // Dropdown objddl = new Dropdown();
        //DataTable dt = objddl.Searchproject("", txtboxpname.Text, "");
        //if (dt.Rows.Count > 0)
        //{
        //    grdprojctdtls.DataSource = dt;
        //    grdprojctdtls.DataBind();
        //    grdprojctdtls.Visible = true;

        //}
        //else
        //{
        //    //fill_grid();
        //    grdprojctdtls.Visible = false;

        //}
    }


    protected void grdprojctdtls_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        message msg = new message();
        Query objquery = new Query();
        GridView Gridnodal = (GridView)sender;
        if (e.CommandName.Equals("assign"))
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            //GridViewRow row = grdprojctdtls.Rows[rowIndex];

            GridViewRow gvRow = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            DropDownList ddlnodalofficer = (DropDownList)gvRow.FindControl("ddlofficer");

            //Get the value of column from the DataKeys using the RowIndex.            
            int pcode = Convert.ToInt32(Gridnodal.DataKeys[rowIndex].Values["pcode"]);
            if(ddlnodalofficer.SelectedValue =="0" || ddlnodalofficer.SelectedValue == "")
            {
                msg.Show("Please Select Nodal Officer");
                return;
            }

            int temp = objquery.Update_NodalAssign(pcode, ddlnodalofficer.SelectedValue);

            string msgStr = "Nodal Officer Assigned Sucessfully";
            string redirectPage = "AssignNodalOfficer.aspx";
            string script = "alert('" + msgStr + "');\n";
            script += "location.href='" + redirectPage + "';\n";
            Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);
            return;

        }
    }
  
}