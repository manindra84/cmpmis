using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CMOViewAll : System.Web.UI.Page
{  
    message msg = new message();
    Query query = new Query();
    DataTable dt = new DataTable();
    GetQuery objgq = new GetQuery();
    Dropdown drop = new Dropdown();
    string pcode = string.Empty, taskid = string.Empty, flag = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["taskid"] != null)
            { taskid = MD5Util.Decrypt(Request.QueryString["taskid"].ToString(), true);
                hftaskid.Value = taskid;
            }
            else
            { taskid = string.Empty; }

            if (Request.QueryString["pcode"] != null)
            { pcode = MD5Util.Decrypt(Request.QueryString["pcode"].ToString(), true); }
            else
            { pcode = string.Empty; }


            FillGrid();
            filllabels();
            fill_activitylabels();
        }
    }


    private void fill_activitylabels()
    {
        DataTable dtfill = new DataTable();
        if (pcode != "")
        {
            dtfill = drop.CMOAddviewdirection(pcode, taskid);
        }
        if (dtfill.Rows.Count > 0)
        {
            lblactivityname.Text = dtfill.Rows[0]["taskname"].ToString();
            //lblactivityissuedate.Text = dtfill.Rows[0]["startdt"].ToString();
            lblactivityduedate.Text = dtfill.Rows[0]["enddt"].ToString();
            FillGridCMRemrks();
        }
        else
        {
            //msg.Show("No Record Found");
        }
    }

    public void FillGridCMRemrks()
    {
        GetQuery objgq = new GetQuery();
        DataTable dt = new DataTable();
        dt = objgq.GetCMRemarks(taskid, pcode);
        if (dt.Rows.Count > 0)
        {
            Gridcmremarks.Visible = true;
            Gridcmremarks.DataSource = dt;
            trcmview.Visible = true;
            trview12.Visible = true;
            lblformessageactions.Text = "";
          
            Gridcmremarks.DataBind();

        }
        else
        {
            lblformessageactions.Visible = true;
            lblformessageactions.Text = "No Directions Found";
            Gridcmremarks.Visible = false;
            trcmview.Visible = true;
            trview12.Visible = true;
           
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
            dt = drop.GetProjname(pcode);
            if (dt.Rows.Count > 0)
            {
                //lblmeeting.Text = hfmeetindatetime.Value;
                //lblissuename.Text = dt.Rows[0]["taskname"].ToString();
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    lblprojectname.Text = dt.Rows[0]["pname"].ToString();
                    //Label1projstarteddate.Text = dt.Rows[0]["startdate"].ToString();
                    lblduedate.Text = dt.Rows[0]["enddate"].ToString();
                    if (dt.Rows[i]["nodaldept"].ToString() == "Y")
                    {
                        lblnodaldept.Text = dt.Rows[i]["deptname"].ToString();

                    }
                    else
                    {
                        str = str + dt.Rows[i]["deptname"].ToString() + ",";
                        //lblotherconcerneddept.Text = str;
                    }                
                }
            }

        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }
    public void FillGrid()
    {
        dt = objgq.GetCMOViewActions(taskid);
        if (dt.Rows.Count > 0)
        {
            tractions.Visible = true;
            Gridviewactions.Visible = true;
            lblactions.Visible = false;
            Gridviewactions.DataSource = dt;
            Gridviewactions.DataBind();
        }
        else
        {
            lblactions.Visible = true;
            lblactions.Text = "No Work found" ;
            tractions.Visible = true;
            //Gridcmremarks.Caption = "No Action Found";
            Gridviewactions.Visible = false;
        }
    }

    protected void btn_showhist_Click(object sender, EventArgs e)
    {
        FillGridReviseHistory();
    }


    public void FillGridReviseHistory()
    {
        dt = objgq.Getrevisehistory(hftaskid.Value);
        if (dt.Rows.Count > 0)
        {
            btn_showhist.Visible = true;
            gridrevisehistroy.Visible = true;
            gridrevisehistroy.DataSource = dt;
            gridrevisehistroy.DataBind();
        }
        else
        {
            btn_showhist.Visible = false;
        }
    }
}