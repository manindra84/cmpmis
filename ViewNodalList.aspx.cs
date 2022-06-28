using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewNodalList : System.Web.UI.Page
{
    public DataTable dt = new DataTable();
    GetQuery objgq = new GetQuery();
    string flag = string.Empty;
    Query objqry = new Query();
    message msg = new message();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.QueryString["flag"] != null)
        {
            //flag = Request.QueryString["flag"].ToString();
            flag = MD5Util.Decrypt(Request.QueryString["flag"].ToString(), true);
        }
        else
        {
            flag = string.Empty;
        }

        FillGrid();

               
    }

    public void FillGrid()
    {
        dt = objgq.getuser_nodal(Session["deptcode"].ToString(), flag);
        if (dt.Rows.Count > 0)
        {
            grd_nodallist.DataSource = dt;
            grd_nodallist.DataBind();
        }
        else
        {
            msg.Show("No data found !");
        }
    }

    protected void btn_reset_Click(object sender, EventArgs e)
    {
        string pwd;
        string userid = Session["userid"].ToString();
        string ip = Request.ServerVariables["REMOTE_ADDR"].ToString();
        //hash for password - Csc@1234
        pwd = "540e0733bee921e50965034ed8f6590e2a16ac53caf807c047cec2c2e6d5b1e681d1df728d5d7325f4ef589b69813de7a9bf430227003fabec6f2d7de622317d";

        int temp = objqry.ResetPassword(pwd, userid, ip, Session["userid"].ToString(), Utlity.formatDatewithtime_PostGres(DateTime.Now), 'N');
        if (temp > 0)
        {
            //message msg = new message();
            //msg.Show("Password reset to 'Csc@1234', Please login to continue!");

            string msgStr = "Password reset successfully, Please login to continue!";
            string redirectPage = "ViewNodalList.aspx?flag=" + MD5Util.Encrypt("16", true);
            string script = "alert('" + msgStr + "');\n";
            script += "location.href='" + redirectPage + "';\n";
            Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);
            return;
        }
       // Response.Redirect("Updateofficerdetails.aspx?flag=15");
        //Response.Redirect("Updateofficerdetails.aspx?flag=" + MD5Util.Encrypt("15", true));
    }

    protected void addnodal_Click(object sender, EventArgs e)
    {
       // Response.Redirect("Updateofficerdetails.aspx?flag=16");
        Response.Redirect("Updateofficerdetails.aspx?flag=" + MD5Util.Encrypt("16", true));
    }
}