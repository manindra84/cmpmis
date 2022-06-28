using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Threading;

public partial class Master_new : System.Web.UI.MasterPage
{
    private const string AntiXsrfTokenKey = "__AntiXsrfToken";
    private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
    private string _antiXsrfTokenValue;
    string url;

    protected void Page_Init(object sender, EventArgs e)
    {
        // The code below helps to protect against XSRF attacks
        var requestCookie = Request.Cookies[AntiXsrfTokenKey];
        Guid requestCookieGuidValue;
        if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
        {
            // Use the Anti-XSRF token from the cookie
            _antiXsrfTokenValue = requestCookie.Value;
            Page.ViewStateUserKey = _antiXsrfTokenValue;
        }
        else
        {
            // Generate a new Anti-XSRF token and save to the cookie
            _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
            Page.ViewStateUserKey = _antiXsrfTokenValue;
            var responseCookie = new HttpCookie(AntiXsrfTokenKey)
            {
                HttpOnly = true,
                Value = _antiXsrfTokenValue
            };
            if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
            {
                responseCookie.Secure = true;
            }
            Response.Cookies.Set(responseCookie);
        }
        Page.PreLoad += master_Page_PreLoad;
    }

    protected void master_Page_PreLoad(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Set Anti-XSRF token
            ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
            ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
        }
        else
        {
            // Validate the Anti-XSRF token
            if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue ||
               (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
            {
                throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
            }
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["userid"] == null)
                Response.Redirect("Login.aspx");
        }
        catch
        {
            Response.Redirect("Login.aspx");
        }

        Validatepage();
    }

    public void Validatepage()
    {
        try
        {
            url = Request.Url.AbsolutePath;
            url = url.Substring(url.LastIndexOf("/") + 1);

            if ((url.Equals("UnauthoriseUser.aspx", StringComparison.OrdinalIgnoreCase)))
            {
                return;
            }

            if ((Session["usertype"].ToString() == "12")) //cmoentry
            {
                if ((url.Equals("SearchBTF.aspx", StringComparison.OrdinalIgnoreCase))
                        || (url.Equals("projectmaster.aspx", StringComparison.OrdinalIgnoreCase))
                        || (url.Equals("project_details.aspx", StringComparison.OrdinalIgnoreCase))
                        || (url.Equals("DeptMaster.aspx", StringComparison.OrdinalIgnoreCase))
                        || (url.Equals("OfficerList.aspx", StringComparison.OrdinalIgnoreCase))
                        || (url.Equals("EnterDirection.aspx", StringComparison.OrdinalIgnoreCase))
                        || (url.Equals("EnterCMODirection.aspx", StringComparison.OrdinalIgnoreCase))
                        || (url.Equals("create_user.aspx", StringComparison.OrdinalIgnoreCase))
                        || (url.Equals("ChangePassword.aspx", StringComparison.OrdinalIgnoreCase))
                        || (url.Equals("Logout.aspx", StringComparison.OrdinalIgnoreCase))             
                        || (url.Equals("ErrorPage.aspx", StringComparison.OrdinalIgnoreCase))
                        || (url.Equals("addsubproject.aspx", StringComparison.OrdinalIgnoreCase)))
                {

                }
                else
                {
                    string msgStr = "You are UnAuthorised User to View this page";
                    string redirectPage = "UnauthoriseUser.aspx";
                    string script = "alert('" + msgStr + "');\n";
                    script += "location.href='" + redirectPage + "';\n";
                    Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);
                    //Response.Redirect("UnauthoriseUser.aspx");
                }
            }

            else if ((Session["usertype"].ToString() == "11")) //CMO 
            {

                if ((url.Equals("CMOProject_details.aspx", StringComparison.OrdinalIgnoreCase))
                    || (url.Equals("OfficerList.aspx", StringComparison.OrdinalIgnoreCase))
                    || (url.Equals("CMOEnterDirection.aspx", StringComparison.OrdinalIgnoreCase))
                    || (url.Equals("CMOViewAll.aspx", StringComparison.OrdinalIgnoreCase))
                    || (url.Equals("ViewProjectTrail.aspx", StringComparison.OrdinalIgnoreCase))                
                    || (url.Equals("Logout.aspx", StringComparison.OrdinalIgnoreCase))
                    || (url.Equals("ChangePassword.aspx", StringComparison.OrdinalIgnoreCase))
                    || (url.Equals("ErrorPage.aspx", StringComparison.OrdinalIgnoreCase)))
                {

                }
                else
                {
                    //Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", "UnauthoriseUser.aspx", true);
                    //Response.Redirect("login.aspx");
                    //Server.Transfer("UnauthoriseUser.aspx");

                    string msgStr = "You are UnAuthorised User to View this page";
                    string redirectPage = "UnauthoriseUser.aspx";
                    string script = "alert('" + msgStr + "');\n";
                    script += "location.href='" + redirectPage + "';\n";
                    Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);

                }

            }

            else if ((Session["usertype"].ToString() == "10")) //Department user 
            {

                if ((url.Equals("DeptLogin.aspx", StringComparison.OrdinalIgnoreCase))
                    || (url.Equals("Updateofficerdetails.aspx", StringComparison.OrdinalIgnoreCase))
                    || (url.Equals("ViewNodalList.aspx", StringComparison.OrdinalIgnoreCase))
                    || (url.Equals("taskAction.aspx", StringComparison.OrdinalIgnoreCase))
                    || (url.Equals("ViewFile.aspx", StringComparison.OrdinalIgnoreCase))
                    || (url.Equals("AssignNodalOfficer.aspx", StringComparison.OrdinalIgnoreCase))                   
                    || (url.Equals("Logout.aspx", StringComparison.OrdinalIgnoreCase))
                    || (url.Equals("ChangePassword.aspx", StringComparison.OrdinalIgnoreCase))
                    || (url.Equals("ErrorPage.aspx", StringComparison.OrdinalIgnoreCase)))
                {

                }
                else
                {
                    //Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", "UnauthoriseUser.aspx", true);
                    //Response.Redirect("login.aspx");
                    //Server.Transfer("UnauthoriseUser.aspx");

                    string msgStr = "You are UnAuthorised User to View this page";
                    string redirectPage = "UnauthoriseUser.aspx";
                    string script = "alert('" + msgStr + "');\n";
                    script += "location.href='" + redirectPage + "';\n";
                    Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);

                }

            }
        }
        catch (ThreadAbortException tae)
        {

        }
        catch (Exception ex)
        {
            Response.Redirect("login.aspx");

            //string msgStr = "You are Authorised User to View this page";
            //string redirectPage = "UnauthoriseUser.aspx";
            //string script = "alert('" + msgStr + "');\n";
            //script += "location.href='" + redirectPage + "';\n";
            //Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);
        }
    }

}
