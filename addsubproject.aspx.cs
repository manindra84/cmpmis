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

public partial class addsubproject : System.Web.UI.Page
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
            lblheader.Text = "List of SubProjects";
        }



        filllabels();
        txtsubprojectname.Focus();
        fill_grid();
       // fill_Department();
    }
        



    private void fill_grid()
    {
        DataTable dtfill = new DataTable();
        DataTable dt3 = new DataTable();
        dt3 = drop.getdept_taskmaster_2(hfpcode.Value);

        dt = drop.getsubprojectdetails(hfpcode.Value);


        if (hfpcode.Value != "")
        {
            dtfill = drop.getdept_taskmaster(hfpcode.Value);
        }  
        if(dtfill.Rows.Count > 0)
        {
            //grdprojview.DataSource = dtfill;
            //grdprojview.DataBind();
        }
        
                
        for (int i = 0; i < dtfill.Rows.Count; i++)
        {
            //rows for which due date has passed current date, will become red.
            //if (dt3.Rows[i]["enddt"].ToString() != null && dt3.Rows[i]["enddt"].ToString() != "")
            //{
            //    DateTime endt = Convert.ToDateTime(dt3.Rows[i]["enddt"]);
            //    if (endt < DateTime.Now)
            //    {
            //        grdprojview.Rows[i].ForeColor = System.Drawing.Color.Red;
            //    }
            //}

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
                lblnodaldept.InnerText = dt.Rows[0]["deptname"].ToString();
      
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

            DataTable dt;
            string query = @"select subprojname from  subprojectmaster where subprojname =@subprojname and pcode=@pcode ";
            NpgsqlCommand cmd1 = new NpgsqlCommand(query);
            cmd1.Parameters.AddWithValue("@subprojname", txtsubprojectname.Text.Trim());
            cmd1.Parameters.AddWithValue("@pcode", hfpcode.Value);
            dt = objgetdata.GetDataTable(cmd1);

            if (dt.Rows.Count > 0)
            {
                if (txtsubprojectname.Text.Trim().ToUpper() == dt.Rows[0]["subprojname"].ToString().ToUpper())
                {
                    message msg = new message();
                    msg.Show("Duplicate Entry Found , Subproject name cannot be Same for this Project");
                    return;
                }
            }


            int result = drop.insertSubprojectname(txtsubprojectname.Text.Trim(), hfpcode.Value, ipaddress, userid);
            if (result > 0)
            {               
                txtsubprojectname.Text = "";
                //Server.Transfer("addsubproject.aspx");
                string msgStr = "Record Inserted Successfully";
                string redirectPage = "addsubproject.aspx?pcode=" + MD5Util.Encrypt(hfpcode.Value, true);
                string script = "alert('" + msgStr + "');\n";
                script += "location.href='" + redirectPage + "';\n";
                Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);

                //Response.Redirect("EnterDirection.aspx?pcode=" + MD5Util.Encrypt(hfpcode.Value, true) + "&view=" + MD5Util.Encrypt("view", true));
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