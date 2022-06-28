
using Npgsql;
using SecurityUtility.Cryptography;
using SecurityUtility.Salt;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


    public partial class ChangePassword : System.Web.UI.Page
    {
        NpgsqlCommand sqlCmd;
        List<NpgsqlCommand> cmdList = new List<NpgsqlCommand>();
        public NpgsqlDataReader dr = null;
        public DataTable dt = new DataTable();
        //GetDataDHB dUT = new GetDataDHB();
        NpgsqlConnection cnObj;
        public string uId, UserId, newsalt = string.Empty;
        string msgStr = "";
        public bool currentUser = false;


        protected void Page_Load(object sender, EventArgs e)
        {
            Random randomobj = new Random();
            Session["randomno"] = randomobj.Next();
            csrfval.Value = Session["randomno"].ToString();
            ChangePasswordPushButton.Attributes.Add("onclick", "return SignValidate();");
            newsalt = RandomSaltGenerator.Generate(Context, Page.IsPostBack);

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

            if (!IsPostBack)
            {

            }
        }

        protected void ChangePasswordPushButton_Click(object sender, EventArgs e)
        {

            if (csrfval.Value.ToString() != Session["randomno"].ToString())
            {
                Response.Redirect("Login.aspx");
                return;
            }

            GetData data = new GetData();
            //DataTable dt = DataOperations.CurrentUserDetails;


            string UsrID = Session["userid"].ToString();
            if (Session["userid"] != null)
            {
                StringBuilder SelectQuery = new StringBuilder("select password from user_master where trim(user_id)=@user_id");
                NpgsqlCommand SelectCmd = new NpgsqlCommand(SelectQuery.ToString());
                SelectCmd.Parameters.AddWithValue("@user_id", UsrID.Trim());

                DataTable usr = data.GetDataTable(SelectCmd);

                if (usr.Rows.Count > 0)
                {
                    string hash = usr.Rows[0][0].ToString();
                }
                //string salt = HttpContext.Current.Session["salt"].ToString();
                // DataTable currentUser = data.ValidateUser(UserName.Trim(), CurrentPassword.Text.ToString().Trim(), RandomSaltGenerator.GetSessionSalt(Context), "N");


                StringBuilder SQuery = new StringBuilder("select * from user_master where trim(user_id)=@user_id");
                NpgsqlCommand SelectCmd1 = new NpgsqlCommand(SQuery.ToString());
                SelectCmd1.Parameters.AddWithValue("@user_id", UsrID.Trim());
                DataTable dtu = data.GetDataTable(SelectCmd1);

                if (dtu.Rows.Count > 0)
                {

                    string pass = dtu.Rows[0]["password"].ToString().Trim();
                    string salt = RandomSaltGenerator.GetSessionSalt(Context);
                    if (Hasher.VerifySHA512Hash(pass + salt, CurrentPassword.Text.ToString().Trim()))
                    {
                        List<NpgsqlCommand> cmdList = new List<NpgsqlCommand>();
                        StringBuilder updateQuery = new StringBuilder("update user_master set loginattempt=@loginattempt, password=@password,changepassword=@changepassword where user_id=@user_id");
                        NpgsqlCommand updateCmd = new NpgsqlCommand(updateQuery.ToString());
                        updateCmd.Parameters.AddWithValue("@loginattempt", 0);
                        updateCmd.Parameters.AddWithValue("@password", HdNewPass.Value.Trim());
                        updateCmd.Parameters.AddWithValue("@user_id", dtu.Rows[0]["user_id"].ToString().Trim());
                        updateCmd.Parameters.AddWithValue("@changepassword", true);
                        cmdList.Add(updateCmd);
                        data.SaveData(cmdList);
                        dtu.Rows[0]["password"] = null;
                        currentUser = true;
                    }
                    else
                    {
                        currentUser = false;
                    }

                }

                if (currentUser == true)
                {
                    if (NewPassword.Text.Equals(ConfirmNewPassword.Text))
                    {
                        Session.Add("Message", "Password Change sucessfully!!.. ");
                        Session.Remove("userid");
                        Response.Redirect("Login.aspx");
                    }
                    else
                    {
                        Session.Remove("userid");
                        string qy = "New Password and Confirm password does not match";
                        Response.Redirect("ErrorPage.aspx?Message=" + qy);

                    }
                }
                //else 
                //{
                //    string strScript = "<script>" + "alert('Provided Old Password is Wrong!!');";
                //    strScript += "window.location='ChangePassword.aspx';";
                //    strScript += "</script>";
                //    Page.ClientScript.RegisterStartupScript(this.GetType(), "Startup", strScript);
                //    return;
                //}
            }
            else
            {
                Session.Remove("userid");
                string qy = "User id does not match with current logged user";
                Response.Redirect("ErrorPage.aspx?Message=" + qy);
            }
        }
    }

