using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class lgcmrelief_ErrorPage : System.Web.UI.Page
{
    public string Message = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        //try { Message = Request.QueryString["Message"].ToString(); }
        //catch { Message = string.Empty; }
        Session.Abandon();
    }
}