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

public partial class EditProject : System.Web.UI.Page
{
    Dropdown drop = new Dropdown();
    public DataTable dt;
    DataTable dt2 = new DataTable();
    message msg = new message();
    Random randObj = new Random();
    Int32 UniqueRandomNumber = 0;
    MD5Util md5util = new MD5Util();
    string viewonly = "";
    GetData objgetdata = new GetData();

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {


            if (Request.QueryString["pcode"] != null)
            {
                hfpcode.Value = MD5Util.Decrypt(Request.QueryString["pcode"].ToString(), true);
            }
            lblheader.Text = "Project Details";
        }



        filllabels();
        txtprojectname.Focus();
        //fill_grid();
       // fill_Department();
    }
        
    private void filllabels()
    {        
        try
        {
            DataTable dt = null;       
            dt = drop.GetProjname(hfpcode.Value);
            if (dt.Rows.Count>0)
            {
                lblprojectname.InnerText = dt.Rows[0]["pname"].ToString();
                //Label1projstarteddate.InnerText = dt.Rows[0]["startdate"].ToString();
                lblppcomdate.InnerText = dt.Rows[0]["enddate"].ToString();
                //lblnodaldept.InnerText = dt.Rows[0]["deptname"].ToString();
      
            }
         
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }



    protected void btn_submit_Click(object sender, EventArgs e)
    {
        try
        {
            string ipaddress = Request.ServerVariables["REMOTE_ADDR"].ToString();
            string userid = Session["userid"].ToString();
            DateTime edate = DateTime.Now;

            //Checking Duplicate Project Name 
            //DataTable dt;
            //string query = @"select pname from  projectmaster where pname ilike @pname and pcode=@pcode ";
            //NpgsqlCommand cmd1 = new NpgsqlCommand(query);
            //cmd1.Parameters.AddWithValue("@pname", "%" + txtprojectname.Text.Trim() + "%");
            //cmd1.Parameters.AddWithValue("@pcode", hfpcode.Value);
            //dt = objgetdata.GetDataTable(cmd1);
            //if (dt.Rows.Count > 0)
            //{
            //    if (txtprojectname.Text.Trim().ToUpper().Trim() == dt.Rows[0]["pname"].ToString().ToUpper().Trim())
            //    {
            //        txtprojectname.Text = "";
            //        txtenddate.Text = "";

            //        message msg = new message();
            //        msg.Show("Duplicate Entry Found , Project name cannot be Same");
            //        return;
            //    }
            //}

            if (Validation.chkLeve28(txtprojectname.Text))
            {
                msg.Show("Invaild Inputs");
                return;
            }
            int result = drop.UpdateProjectDetails(txtprojectname.Text.ToUpper().Trim(), hfpcode.Value, ipaddress, userid,txtenddate.Text.Trim());           
            if (result > 0)
            {
                txtprojectname.Text = "";               
                string msgStr = "Project Details Updated Successfully";
                string redirectPage = "Project_Details.aspx?pcode=" + MD5Util.Encrypt(hfpcode.Value, true) + "&flag=" + MD5Util.Encrypt("view", true);
                string script = "alert('" + msgStr + "');\n";
                script += "location.href='" + redirectPage + "';\n";
                Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);             
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

}