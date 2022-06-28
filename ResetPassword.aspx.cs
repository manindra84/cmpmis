using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Npgsql;
using System.Data;
using System.Text;
using SecurityUtility.Cryptography;

public partial class ResetPassword : System.Web.UI.Page
{
    List<NpgsqlCommand> cmdList = new List<NpgsqlCommand>();
    string msgStr = "";
    public DataTable dt = new DataTable();
    string sqlStr = "";
    NpgsqlCommand sqlCmd;
    GetData data = new GetData();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] != null)
        {

        }
        else
        {
            Session["loginMsg"] = "Session Expired,Please Re-Login";
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Logout.aspx");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        try
        {
            string query = null;
            NpgsqlCommand SqlCmd1 = null;
            query = @"select  userid from usermaster where trim(upper(userid))=@userid ";
            SqlCmd1 = new NpgsqlCommand(query);
            SqlCmd1.Parameters.AddWithValue("@userid", txtUserId.Text.Trim().ToUpper());
            dt = data.GetDataTable(SqlCmd1);
            if (dt.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "myScript", "alert('User Id Does Not Exist.Kindly Check');", true);
                return;
            }
            else
            {

                StringBuilder applicationImage = null;
                string NewPassword = Utlity.GetRandomString(6);
                string NewPasswordHash = Hasher.GenerateSHA512(NewPassword);
                applicationImage = new StringBuilder(@"Update usermaster set password=@Password,login_attempt=0,changepassword=@changepassword where trim(upper(userid))=@userid");

                NpgsqlCommand Imgcmd = new NpgsqlCommand(applicationImage.ToString());
                Imgcmd.Parameters.AddWithValue("@userid", txtUserId.Text.Trim().ToUpper());
                Imgcmd.Parameters.AddWithValue("@Password", NewPasswordHash);
                Imgcmd.Parameters.AddWithValue("@changepassword", false);
                cmdList.Add(Imgcmd);
                int insertCount = data.SaveData(cmdList);
                if (insertCount >= 1)
                {
                    msgStr = "Password Reset successfully and Your New Password is " + NewPassword + "";
                    string redirectPage = "ResetPassword.aspx";
                    string script = "alert('" + msgStr + "');\n";
                    script += "location.href='" + redirectPage + "';\n";
                    Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);
                }
            }
        }
        catch (Exception ex)
        {
            //lblMsg.Text = ex.Message + "," + ex.Source;
            //Server.Transfer("Error.aspx");
        }
        finally
        {
           
        }
    }
}