using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Npgsql;
using System.Data;

public partial class CreateUser : System.Web.UI.Page
{
    List<NpgsqlCommand> cmdList = new List<NpgsqlCommand>();
    string msgStr = "";
    public DataTable dtView = new DataTable();
    string sqlStr = "";
    NpgsqlCommand sqlCmd;
    GetData data = new GetData();
    string uId = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(Session["UserId"].ToString()))
            {
                Session["loginMsg"] = "Session Expired,Please Re-Login";
                Session.Clear();
                Session.Abandon();
                Response.Redirect("Logout.aspx");
            }
        }
        catch { Response.Redirect("Login.aspx"); }
        try { uId = Utlity.Decryptdata(Request.QueryString["Userid"].ToString()); }
        catch { uId = string.Empty; }

        if (!IsPostBack)
        {
            fillData();
            if (!String.IsNullOrEmpty(uId))
            {
                populateData();
            }
        }
    }

    private void populateData()
    {
        DataTable dt = new DataTable();
        sqlStr = "Select userid,username,mobileno,emailid,Designation,usertypeid,case isactive when TRUE then 'true' else 'false' end as isactive from usermaster where trim(upper(userid))=@userid";
        sqlCmd = new NpgsqlCommand(sqlStr);
        sqlCmd.Parameters.AddWithValue("@userid", uId.ToUpper());
        dt = data.GetDataTable(sqlCmd);
        if (dt.Rows.Count > 0)
        {
            btnSubmit.Visible = false;
            btnUpdate.Visible = true;

            txtUserId.Text = dt.Rows[0]["userid"].ToString();
            txtUserId.ReadOnly = true;
            txtUserName.Text = dt.Rows[0]["username"].ToString();
            txtUserName.ReadOnly = true;  
            txtDesignation.Text = dt.Rows[0]["Designation"].ToString();
            txtEmail.Text = dt.Rows[0]["emailid"].ToString();
            txtMobileNo.Text = dt.Rows[0]["mobileno"].ToString();
            ddlActive.ClearSelection();
            ddlUserType.SelectedValue = dt.Rows[0]["usertypeid"].ToString();
            ddlActive.SelectedValue = dt.Rows[0]["isactive"].ToString();

        }
        else
        {
            btnSubmit.Visible = true;
            btnUpdate.Visible = false;
        }
    }

    protected void fillData()
    {
        sqlStr = "Select userid,username,mobileno,emailid,case isactive when true then 'Active' else 'Inactive' end as status,usertypeid from usermaster where isactive =@isactive and usertypeid not in (3) order by username";
        sqlCmd = new NpgsqlCommand(sqlStr);
        sqlCmd.Parameters.AddWithValue("@isactive", true);
        dtView = data.GetDataTable(sqlCmd);

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try {
            GetData data = new GetData();
            string SQL = "insert into usermaster (UserId,UserName,Designation,mobileno,usertypeid,changepassword,password,isactive,emailid,usercreatedby,ipno,actiondatetime ) values (@UserId,@UserName,@Designation,@mobileno,@usertypeid,@changepassword,@password,@isactive,@emailid,@usercreatedby,@ipno,@actiondatetime )";
            NpgsqlCommand cmd = new NpgsqlCommand(SQL);
            cmd.Parameters.AddWithValue("@UserId", txtUserId.Text.Trim().ToUpper());
            cmd.Parameters.AddWithValue("@UserName", txtUserName.Text.Trim());
            cmd.Parameters.AddWithValue("@Designation", txtDesignation.Text.Trim());
            cmd.Parameters.AddWithValue("@mobileno", txtMobileNo.Text.Trim());
            cmd.Parameters.AddWithValue("@usertypeid", ddlUserType.SelectedValue);
            cmd.Parameters.AddWithValue("@changepassword", false);
            cmd.Parameters.AddWithValue("@password", "c084f7dddde585b0b4042543d39d433f30677fa06d32b89b41520cf1395c101838cdd6be9ba720a8b2813de24834579c3fc78b3dd4913d3143d9cb7548cfe3e2");
            cmd.Parameters.AddWithValue("@isactive", ddlActive.SelectedValue);
            cmd.Parameters.AddWithValue("@emailid", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@usercreatedby", Session["UserId"].ToString().Trim());
            cmd.Parameters.AddWithValue("@ipno", Utlity.GetIP4Address());
            cmd.Parameters.AddWithValue("@actiondatetime", DateTime.Now);
            cmdList.Add(cmd);
            int insertCount = data.SaveData(cmdList);
            if (insertCount > 0)
            {
                string Pwd = "cmrf@1234";
                msgStr = "User Added Successfully Your Password is " + Pwd + ".";
                string redirectPage = "CreateUser.aspx";
                string script = "alert('" + msgStr + "');\n";
                script += "location.href='" + redirectPage + "';\n";
                Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);
            }
        }
        catch 
        {
            Response.Redirect("ErrorPage.aspx");
        }
       
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        string SQL = "update usermaster set UserName=@UserName,Designation=@Designation,mobileno=@mobileno,usertypeid=@usertypeid,isactive=@isactive,emailid=@emailid,usercreatedby=@usercreatedby,ipno=@ipno,actiondatetime=@actiondatetime where trim(upper(userid))=@userid";
        NpgsqlCommand cmd = new NpgsqlCommand(SQL);
        cmd.Parameters.AddWithValue("@UserId", uId.ToUpper());
        cmd.Parameters.AddWithValue("@UserName", txtUserName.Text.Trim());
        cmd.Parameters.AddWithValue("@Designation", txtDesignation.Text.Trim());
        cmd.Parameters.AddWithValue("@mobileno", txtMobileNo.Text.Trim());
        cmd.Parameters.AddWithValue("@usertypeid", ddlUserType.SelectedValue);        
        cmd.Parameters.AddWithValue("@isactive", ddlActive.SelectedValue);
        cmd.Parameters.AddWithValue("@emailid", txtEmail.Text.Trim());
        cmd.Parameters.AddWithValue("@usercreatedby", Session["UserId"].ToString().Trim());
        cmd.Parameters.AddWithValue("@ipno", Utlity.GetIP4Address());
        cmd.Parameters.AddWithValue("@actiondatetime", DateTime.Now);
        cmdList.Add(cmd);
        int insertCount = data.SaveData(cmdList);
        if (insertCount > 0)
        {
            msgStr = "User Updated Successfully..";
            string redirectPage = "CreateUser.aspx";
            string script = "alert('" + msgStr + "');\n";
            script += "location.href='" + redirectPage + "';\n";
            Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);
        }
    }
}