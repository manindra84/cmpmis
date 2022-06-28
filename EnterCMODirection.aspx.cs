using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Collections;
using System.Threading;
public partial class EnterCMODirection : System.Web.UI.Page
{
    Dropdown drop = new Dropdown();
    message msg = new message();
    Random randObj = new Random();
    Int32 UniqueRandomNumber = 0;
    MD5Util md5util = new MD5Util();
    string viewonly = "",flag = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ViewState["RefUrl"] = Request.UrlReferrer.ToString();

            //if (StringUtil.GetQueryString(Request.Url.ToString()) != null)
            //{

            //    if (md5util.IsURLTampered(StringUtil.GetWithoutDigest(StringUtil.GetQueryString(Request.Url.ToString())),
            //    StringUtil.GetDigest(StringUtil.GetQueryString(Request.Url.ToString()))) == true)
            //    {
            //        Response.Redirect("Login.aspx?id=0");
            //    }
            //}
            if(Request.QueryString["flag"] != null)
            {
                flag = MD5Util.Decrypt(Request.QueryString["flag"].ToString(), true);
                hfview.Value = flag;
            }
            else
            {
                flag = string.Empty;
            }   

            if (Request.QueryString["pcode"] != null)
            {
                hfpcode.Value = MD5Util.Decrypt(Request.QueryString["pcode"].ToString(), true);
            }

            if (Request.QueryString["taskid"] != null)
            {
                hftaskid.Value = MD5Util.Decrypt(Request.QueryString["taskid"].ToString(), true);
            }

            if (Request.QueryString["cmview"] != null)
            {
                hfcmview.Value = MD5Util.Decrypt(Request.QueryString["cmview"].ToString(), true);
                tr5.Visible = false;
                tr7.Visible = false;
                tr8.Visible = false;
                FillGridCMRemrks();
                trcmview.Visible = true;
                //trview12.Visible = true;
            }
            if(flag == "add")
            {
                chk_whetherdeptvisible.Visible = true;
            }
            

            filllabels();
            txtcmremarks.Focus();
            fill_grid();
            
        }
        
    }

    public void FillGridCMRemrks()
    {
        GetQuery objgq = new GetQuery();
        DataTable dt = new DataTable();
        dt = objgq.GetCMRemarks(hftaskid.Value, hfpcode.Value);
        if (dt.Rows.Count > 0)
        {
            Gridcmremarks.Visible = true;
            Gridcmremarks.DataSource = dt;
            trcmview.Visible = true;
            //trview12.Visible = true;
            Gridcmremarks.DataBind();
            
        }
        else
        {
            Gridcmremarks.Visible = false;
            trcmview.Visible = true;
            trcmview.Text = "No Directions Entered";
            //trview12.Visible = false;
        }
    }

    private void fill_grid()
    {
        DataTable dtfill = new DataTable();
        if (hfpcode.Value != "")
        {
            dtfill = drop.CMOAddviewdirection(hfpcode.Value,hftaskid.Value);
        }
        if (dtfill.Rows.Count > 0)
        {                                       
           lblactivityname.Text = dtfill.Rows[0]["taskname"].ToString();
            //aarush_uat
           //lblactivityissuedate.Text = dtfill.Rows[0]["startdt"].ToString();
            lblactivityduedate.Text = dtfill.Rows[0]["enddt"].ToString();
            FillGridCMRemrks();
        }
        else
        {

           
            //msg.Show("No Record Found");
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
            string whtrdeptvisible = "";
            if(chk_whetherdeptvisible.Checked)
            {
                whtrdeptvisible = "Y";
            }
            else
            {
                whtrdeptvisible = "N";
            }
            int result = drop.InsertCMDirection(hftaskid.Value, hfpcode.Value, txtcmremarks.Text,txtboxcmdirdate.Text,  ipaddress,userid, whtrdeptvisible);
            if (result > 0)
            {
                //Server.Transfer("Project_details.aspx");

                Response.Redirect("EnterCMODirection.aspx?pcode=" + MD5Util.Encrypt(hfpcode.Value, true) + "&taskid=" + MD5Util.Encrypt(hftaskid.Value, true) + "&cmview=" + MD5Util.Encrypt("cmview",true));
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

    private void filllabels()
    {
        string str = null;
        try
        {
            DataTable dt = null;         
            dt = drop.GetProjname(hfpcode.Value);
            if (dt.Rows.Count>0)
            {
                //lblmeeting.Text = hfmeetindatetime.Value;
                //lblissuename.Text = dt.Rows[0]["taskname"].ToString();
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    lblprojectname.Text = dt.Rows[0]["pname"].ToString();
                    //aarush_uat
                    //Label1projstarteddate.Text = dt.Rows[0]["startdate"].ToString();
                    lblppcomdate.Text = dt.Rows[0]["enddate"].ToString();
                    if (dt.Rows[i]["nodaldept"].ToString() == "Y")
                    {
                        lblnodaldept.Text = dt.Rows[i]["deptname"].ToString();                      
                    }
                    else
                    {
                        str = str + dt.Rows[i]["deptname"].ToString() +",";                     
                        lblotherconcerneddept.Text = str;

                    }
                    lblotherconcerneddept.Text = lblotherconcerneddept.Text.TrimEnd(new char[] { ',' });
                    if(lblotherconcerneddept.Text==null || lblotherconcerneddept.Text=="")
                    {
                        lblotherconcerneddept.Text = "--";
                    }             
                   //lblotherconcerneddept.Text.TrimEnd(',');
                }
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
           

        }
    }

    protected void btnback_Click(object sender, EventArgs e)
    {

        object refUrl = ViewState["RefUrl"];
        if (refUrl != null)
            Response.Redirect((string)refUrl);

        // Response.Redirect("EnterDirection.aspx?view=" + MD5Util.Encrypt(hfview.Value, true));

        //Response.Redirect("EnterDirection.aspx");
    }
}