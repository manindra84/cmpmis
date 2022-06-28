using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using emsproject;
using Npgsql;


    public partial class UserControls_UserDetailsHeader : System.Web.UI.UserControl
    {
        public DataTable dtUser;
        public string SQL = string.Empty;
        GetData data = new GetData();
        protected void Page_Load(object sender, EventArgs e)
        {
            FillData();
        }
        protected void FillData()
        {
            try
            {
                string SQL = @"select username,designation,rpad(Left(mobileno,4), 10, 'XXXXXX') mobileno,emailid, to_char(lh.actiondatetime,'dd/MM/yyyy HH24:MM') lastlogin 
                              from usermaster um,loginhistory lh where lh.userid = um.userid and loginstatus = '1' 
                            and um.userid= @userid order by lh.actiondatetime desc limit 1 ";
                NpgsqlCommand cmd = new NpgsqlCommand(SQL);
                cmd.Parameters.AddWithValue("@userid", Session["UserId"].ToString());
                dtUser = data.GetDataTable(cmd);
            }
            catch { Response.Redirect("ErrorPage.aspx"); }
        }
    }
