using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Create_User : System.Web.UI.Page
{
    MD5Util md5Util = new MD5Util();
    DataTable dt = new DataTable();
    message msg = new message();
    GetQuery objGetQuery = new GetQuery();
    Random randObj = new Random();
    Int32 UniqueRandomNumber = 0;
    Master objmast = new Master();
    Master mast = new Master();
    Query query = new Query();
    Dropdown drop = new Dropdown();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
          
            fill_usertype();
            fill_Dept();
            if (Request.QueryString["dept_abb"] != null)
            {
                txtuserid.Text = MD5Util.Decrypt(Request.QueryString["dept_abb"].ToString(), true).ToLower();
                txtuserid.Enabled = false;

            }
            if (Request.QueryString["deptcode"] != null)
            {
                drputype.SelectedValue = "10";
                drputype.Enabled = false;
                drputype_SelectedIndexChanged(sender, e);
                ddldept.SelectedValue = MD5Util.Decrypt(Request.QueryString["deptcode"].ToString(), true);
                ddldept.Enabled = false;
            }
            
        }

    }
    protected void txtuserid_TextChanged(object sender, EventArgs e)
    {
        bool IsExis = objGetQuery.ExistUser(Utlity.putstring(txtuserid.Text));
        if (IsExis == true)
        {
            lblMessage.Text = "User ID Already Exits :" + txtuserid.Text;
            txtuserid.Text = "";
        }
        else
        {
            lblMessage.Text = "";
        }

    }

    public void fill_usertype()
    {
        dt = mast.GetUserType();

        drputype.DataValueField = "typeno";
        drputype.DataTextField = "typedes";
        drputype.DataSource = dt;
        drputype.DataBind();
        drputype.Items.Insert(0, Utlity.FirstItem());
    }

    public void fill_Dept()
    {
        dt = drop.getdeptmaster();

        ddldept.DataValueField = "deptcode";
        ddldept.DataTextField = "deptname";
        ddldept.DataSource = dt;
        ddldept.DataBind();
        ddldept.Items.Insert(0, Utlity.FirstItem());
    }
    protected void btnsbmt_Click(object sender, EventArgs e)
    {
        DateTime Crntdate = DateTime.Now;
        int temp = 0;
        try
        {
            message msg = new message();
            if (Validation.chkLevel0(txtname.Text) || Validation.chkLevel(txtcontact.Text) || Validation.chkLevel(txtuserid.Text) || !ValidateDropdown.validate(ddldept.SelectedValue, "DeptMaster", "deptcode") || !ValidateDropdown.validate(drputype.SelectedValue, "usertype", "typeno"))
            {
                msg.Show("Invalid Inputs");
            }
            else
            {
                //string utype = drputype.SelectedValue;
                //  string pwd = txtuserid.Text + "@123#";
                //password is - ems@123
                string pwd = "4a685863e2e4f13fe9e12c523781f4941a7f6fd0bb58a8ad6b93eb7b05e9f245352913884fd02cb800a8ca5d20bd94a8e6de47138c970f32bcd96796007b2daf";
                string ip = Request.ServerVariables["REMOTE_ADDR"].ToString();
                if (Request.QueryString["userid"] == "" || Request.QueryString["userid"] == null)
                {
                    //temp = query.insertuser_master(Utlity.putstring(txtname.Text.Trim()), Utlity.putstring(txtuserid.Text.Trim()), drputype.SelectedValue, ddldept.SelectedValue, MD5Util.md5(pwd), ip, Utlity.formatDatewithtime_PostGres(Crntdate), Session["userid"].ToString().Trim(), Utlity.putstring(txtcontact.Text).Trim(), Utlity.putstring(txtemail.Text).Trim(), Utlity.formatDatewithtime_PostGres(Crntdate));
                    temp = query.insertuser_master(Utlity.putstring(txtname.Text.Trim()), Utlity.putstring(txtuserid.Text.Trim()), drputype.SelectedValue, ddldept.SelectedValue, pwd, ip, Utlity.formatDatewithtime_PostGres(Crntdate), Session["userid"].ToString().Trim(), Utlity.putstring(txtcontact.Text).Trim(), Utility.putstring(txtemail.Text), Utlity.formatDatewithtime_PostGres(Crntdate));



                }

            }
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx");
        }
        if (temp > 0)
        {
            msg.Show("User Created");
            Server.Transfer("DeptMaster.aspx");
        }


    }

    protected void drputype_SelectedIndexChanged(object sender, EventArgs e)
    {
            TRDepartment.Visible = true;
    }
}