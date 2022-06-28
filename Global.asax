<%@ Application Language="C#" %>

<script runat="server">


    protected void Application_BeginRequest(object sender, EventArgs e)
    {

        //HttpContext context = HttpContext.Current;
        //if (!context.Request.IsSecureConnection && !context.Request.IsLocal)
        //{
        //    // Response.Redirect(context.Request.Url.ToString().Replace("http:", "https:"));
        //}
        //HttpContext.Current.Response.AddHeader("x-frame-options", "ALLOW");
    }

    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup

    }

    void Application_End(object sender, EventArgs e)
    {
        ////  Code that runs on application shutdown
        //Session.Abandon();
        //Session.RemoveAll();
        //Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", ""));
        //Response.Cookies.Add(new HttpCookie("newId", ""));
        //FormsAuthentication.SignOut();

        //  Code that runs on application shutdown
        Response.Redirect("logout.aspx");

    }

    void Application_Error(object sender, EventArgs e)
    {
        // Code that runs when an unhandled error occurs
        Response.Redirect("logout.aspx");

    }

    void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new session is started
        // Code that runs when a new session is started
        if (Session["sessionId"] == null)
        {
            //  Response.Redirect("Home.aspx");

        }

    }

    void Session_End(object sender, EventArgs e)
    {

        Response.Redirect("Logout.aspx");


    }
    protected void Application_PreSendRequestHeaders(object sender, EventArgs e)
    {

        //HttpContext.Current.Response.Headers.Remove("X-Powered-By");
        //HttpContext.Current.Response.Headers.Remove("X-AspNet-Version");
        //HttpContext.Current.Response.Headers.Remove("X-AspNetMvc-Version");
        //HttpContext.Current.Response.Headers.Remove("Server");



        //Start @@@ This block to be commented on LIVE Web server when to published 
        //var httpContext = HttpContext.Current;
        //if (httpContext != null)
        //{
        //    var cookieValueSuffix = "; Secure; SameSite=Lax";
        //    var cookies = httpContext.Response.Cookies;
        //    for (var i = 0; i < cookies.Count; i++)
        //    {
        //        var cookie = cookies[i]; cookie.Value += cookieValueSuffix;
        //    }
        //}
        // End @@@ This block to be commented on LIVE Web server when to published 
    }


</script>

