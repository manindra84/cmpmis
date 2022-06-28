using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["usertype"] == null)
        {
            //Response.Write("<script language=\"javascript\" type=\"text/javascript\">alert('You are not a administrator');var windowObject = window.self; windowObject.opener = window.self; windowObject.close();</script>");
            //Response.Write("<script language=\"javascript\" type=\"text/javascript\">alert('You are not authorized');</script>");
            //Server.Transfer("login.aspx");
            //window.open('login.aspx');
        }
    }
}
