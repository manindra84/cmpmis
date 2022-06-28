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

public partial class EnterUserDetails : System.Web.UI.Page
{
    Random randObj = new Random();
    Int32 UniqueRandomNumber = 0;
    MD5Util md5Util = new MD5Util();

    protected void Page_Load(object sender, EventArgs e)
    {
        //lblstrhdn.Text = Request.QueryString[0].ToString();
        if (Session["usertype"] == null)
        {
            //Response.Write("<script language=\"javascript\" type=\"text/javascript\">alert('You are not a administrator');var windowObject = window.self; windowObject.opener = window.self; windowObject.close();</script>");
            Response.Write("<script language=\"javascript\" type=\"text/javascript\">alert('You are not authorized');</script>");
            Server.Transfer("login.aspx");
            //window.open('login.aspx');


        }

        if (!IsPostBack)
        {
            if (StringUtil.GetQueryString(Request.Url.ToString()) != null)
            {
                if (md5Util.IsURLTampered(StringUtil.GetWithoutDigest(StringUtil.GetQueryString(Request.Url.ToString())),
                                          StringUtil.GetDigest(StringUtil.GetQueryString(Request.Url.ToString()))) == true)
                {
                    Response.Redirect("Login.aspx?id=0");
                }
            }
        
        }
        //else
        //{
        //    if (((Request.Form["csrftoken"] != null) && (Session["token"] != null)) && (Request.Form["csrftoken"].ToString().Equals(Session["token"].ToString())))
        //    {
        //        //valid Page
        //    }
        //    else
        //    {
        //        Response.Redirect("ErrorPage.aspx");
        //    }
        //}

    }
    protected void btn1_Click(object sender, EventArgs e)
    {
       //Session.Clear();
        //Response.Redirect("Login.aspx");
        //Response.Redirect("Logout.aspx");
        Random randObj = new Random();
        Int32 UniqueRandomNumber = randObj.Next(1, 10000);
        Session["logoutvariable"] = UniqueRandomNumber;
        Response.Redirect("Logout.aspx?logoutvariable=" + UniqueRandomNumber.ToString()); 
    }
}
