using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Npgsql;
using SecurityUtility.Salt;
using System.Text;
using System.Web.Security;
using SecurityUtility.Cryptography;
using System.Drawing;
using ClientsideEncryption;
using CaptchaDLL;
using System.Threading;

public partial class Login : System.Web.UI.Page
{
    DataTable dT;
    NpgsqlCommand sqlCmd;
    GetData data = new GetData();
    Random randObj = new Random();
    List<NpgsqlCommand> cmdList = new List<NpgsqlCommand>();
    public string newsalt = string.Empty, sqlStr = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {

        // @@@ Added by Manindra on dated 17052022
        Response.Buffer = true;
        Response.ExpiresAbsolute = DateTime.Now.AddDays(-1d);
        Response.Expires = -1500;
        Response.CacheControl = "no-cache";
        Response.CacheControl = "private";
        Response.AddHeader("Pragma", "no-cache");


        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
        Response.Cache.SetNoStore();
        txtUserId.Focus();
        // @@@ Added by Manindra on dated 17052022

        if (!Page.IsPostBack)
        {
            txtUserId.Attributes.Add("autocomplete", "off");
            txtCaptcha.Attributes.Add("autocomplete", "off");
            Session["CaptchaImageText"] = CaptchaImage.GenerateRandomCode(CaptchaType.Numeric, 6);
            newsalt = RandomSaltGenerator.Generate(Context, Page.IsPostBack);
            Session["randomno"] = newsalt;// added by Manindra 31052022
            txtClientSignature.Value = newsalt;
        }

        if (Request.Browser.Type.Contains("Internet"))
        {
            Session.Add("Message", "We recommend Google Chrome/Mozilla Explorer to run this application, Otherwise Some feature will not work properly. ");
            Response.Redirect("Message.aspx", true);
        }
        Session["userid"] = null;
        Session["AuthToken"] = null;
       
    }
    public static string GetRandomString(int Length)
    {
        Random rnd = new Random();
        StringBuilder str = new StringBuilder("");
        for (int i = 0; i < Length; i++)
            str.Append(Convert.ToChar(rnd.Next(65, 90)).ToString());
        return str.ToString();
    }
    protected void ibtnRefresh_Click(object sender, ImageClickEventArgs e)
    {
        clear();
    }
    private void clear()
    {
        Session["CaptchaImageText"] = CaptchaImage.GenerateRandomCode(CaptchaType.Numeric, 6); //generate new string
        txtCaptcha.Text = "";

    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtUserId.Text) )
        {
            lblMsgLogin.Text = "Provide UserId.";
            this.lblMsgLogin.ForeColor = System.Drawing.Color.Red;
            txtCaptcha.Text = "";
            return;
        }
        if (string.IsNullOrEmpty(txtPwd.Text))
        {
            lblMsgLogin.Text = "Provide Password.";
            this.lblMsgLogin.ForeColor = System.Drawing.Color.Red;
            txtCaptcha.Text = "";
            return;
        }
      
        
        if (Session["CaptchaImageText"] != null && txtCaptcha.Text.ToLower() == Session["CaptchaImageText"].ToString().ToLower())
        {
            string userId = AESEncrytDecry.DecryptStringAES(txtUserId.Text.ToString());
            string actionPage = "Login.aspx";
            try
            {
                //sqlStr = "select * from usermaster where upper(userid)=@userId and isactive = true and login_attempt<5";
                sqlStr = "Select * from user_master where user_id=@user_id and instrength=1 and loginattempt<20 ";
                sqlCmd = new NpgsqlCommand(sqlStr);
                sqlCmd.Parameters.AddWithValue("@user_id", userId.ToLower());
                dT = data.GetDataTable(sqlCmd);
                if (dT.Rows.Count > 0)
                {
                    string PwdHash = dT.Rows[0]["password"].ToString();
                    bool svrSignature = false;


                    string pass = dT.Rows[0]["password"].ToString().Trim();
                 
                    string dbLogAttempt = dT.Rows[0]["loginattempt"].ToString().Trim();
                    //    string salt = RandomSaltGenerator.GetSessionSalt(Context);
                    //string salt = txtClientSignature.Value; // commented by Manindra on dated 31052022
                    string salt = Convert.ToString(Session["randomno"]); // Added by Manindra on dated 31052022
                    string input = pass + salt;
                    if (Hasher.VerifySHA512Hash(input, txtPwd.Text.ToString()))
                     {
                        svrSignature = true;
                    }
                    else
                    {
                        svrSignature = false;
                    }


                    if (svrSignature == true)
                    {
                        FormsAuthentication.SetAuthCookie(dT.Rows[0]["user_id"].ToString().Trim(), false);
                        var authTicket = new FormsAuthenticationTicket(1,                    // version
                                                                        dT.Rows[0]["user_name"].ToString().ToUpper(),       // user name
                                                                        DateTime.Now,         // created 
                                                                        DateTime.Now.AddMinutes(30),// expires
                                                                        false,                // persistent Remeber me?
                                                                        dT.Rows[0]["user_type"].ToString() // can be used to store roles
                                                                        );
                        string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                        var authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                        HttpContext.Current.Response.Cookies.Add(authCookie);

                       
                        if (Convert.ToInt16(dbLogAttempt) > 0)
                        {
                            string uptLogin = null;
                            uptLogin = "Update user_master set loginattempt=0 where user_id = @user_id";
                            sqlCmd = new NpgsqlCommand(uptLogin);
                            sqlCmd.Parameters.AddWithValue("@user_id", dT.Rows[0]["user_id"].ToString().Trim());
                            cmdList.Add(sqlCmd);
                            int insertCount = data.SaveData(cmdList);
                        }
                     

                        Session["userid"] = dT.Rows[0]["user_id"].ToString();
                        Session["usertype"] = dT.Rows[0]["user_type"].ToString();
                        Session["username"] = dT.Rows[0]["user_name"].ToString().ToUpper();
                        Session["deptcode"] = dT.Rows[0]["department_code"].ToString();
                        Session["salt"] = CaptchaImage.GenerateRandomCode(CaptchaType.Numeric, 6);


                        // status= Y successful attempt 
                        StringBuilder InsertHistQuery = new StringBuilder("insert into auditlog(userid,ipaddress,logindatetime,status) values(@userid,@ipaddress,now(),@status)");
                        NpgsqlCommand InsertHistCmd = new NpgsqlCommand(InsertHistQuery.ToString());
                        InsertHistCmd.Parameters.AddWithValue("@userid", Session["UserId"].ToString().Trim());
                        InsertHistCmd.Parameters.AddWithValue("@ipaddress", Utlity.GetIP4Address());
                        InsertHistCmd.Parameters.AddWithValue("@status", 'Y');
                        cmdList.Add(InsertHistCmd);
                        int insertCount1 = data.SaveData(cmdList);

                   
                        if (Session["usertype"].ToString() == "10")
                        {

                            //Response.Redirect("DeptLogin.aspx?flag=imXblvk2We4=");
                            Response.Redirect("DeptLogin.aspx?flag=" + MD5Util.Encrypt("add", true));
                        }
                        else if (Session["usertype"].ToString() == "11")
                        {

                            //string redirectPage = "AddBillForm.aspx?BTFCode=" + RijndaelSimple.EncryptString(BTFCode, Session["salt"].ToString());
                            //MD5Util.Decrypt(Request.QueryString["flag"].ToString(), true);

                            //Response.Redirect("CMOProject_details.aspx?cmoview=y");
                            Response.Redirect("CMOProject_details.aspx?cmoview=" + MD5Util.Encrypt("y", true));
                            //Response.Redirect("CMOProject_details.aspx?cmoview=y");
                        }
                        else if(Session["usertype"].ToString() == "12")
                        {
                            // Response.Redirect("Home.aspx");
                            //Response.Redirect("Project_details.aspx?flag=view");
                            Response.Redirect("Project_details.aspx?flag=" + MD5Util.Encrypt("view", true));

                        }
                        else
                        {
                            Response.Redirect("Home.aspx");
                        }

                        Response.Redirect(actionPage);

                    }
                    else
                    {
                        // Loginstatus= 0 Falied attempt 
                        StringBuilder InsertHistQuery = new StringBuilder("insert into auditlog(userid,ipaddress,logindatetime,status) values(@userid,@ipaddress,now(),@status)");
                        NpgsqlCommand InsertHistCmd = new NpgsqlCommand(InsertHistQuery.ToString());

                        InsertHistCmd.Parameters.AddWithValue("@userid", dT.Rows[0]["user_id"].ToString().Trim());
                        InsertHistCmd.Parameters.AddWithValue("@ipaddress", Utlity.GetIP4Address());
                        InsertHistCmd.Parameters.AddWithValue("@status", 'N');
                        cmdList.Add(InsertHistCmd);


                        string uptLogin = null;
                        uptLogin = "Update user_master set loginattempt = loginattempt + 1 where trim(user_id) = @user_id";
                        sqlCmd = new NpgsqlCommand(uptLogin);
                        sqlCmd.Parameters.AddWithValue("@user_id", dT.Rows[0]["user_id"].ToString().Trim());
                        cmdList.Add(sqlCmd);
                        int insertCount = data.SaveData(cmdList);


                        lblMsgLogin.Text = "Invalid UserId or Password !!!";
                        lblMsgLogin.ForeColor = Color.Red;

                        txtUserId.Text = string.Empty;
                        txtCaptcha.Text = string.Empty;
                        txtClientSignature.Value = Session["randomno"].ToString(); //Added by Manindra on dated 31052022
                        clear();
                    }

                }
                else
                {
                    clear();
                    txtUserId.Text = string.Empty;
                    txtCaptcha.Text = string.Empty;

                    lblMsgLogin.ForeColor = Color.Red;
                    lblMsgLogin.Visible = true;
                    txtClientSignature.Value = Session["randomno"].ToString(); //Added by Manindra on dated 31052022
                    lblMsgLogin.Text = "Invalid User Id Or Your account has been locked. Kindly contact administrator.";
                    return;
                }
            }
            catch (ThreadAbortException TAE)
            {
            }
            catch (Exception ex)
            {
                txtUserId.Text = string.Empty;
                txtCaptcha.Text = string.Empty;
                clear();
                lblMsgLogin.Text = "Some Error Occured!!";
                lblMsgLogin.ForeColor = Color.Red;
                txtClientSignature.Value = Session["randomno"].ToString(); //Added by Manindra on dated 31052022
            }
        }
        else
        {
            txtUserId.Text = string.Empty;
            txtCaptcha.Text = string.Empty;
            clear();
            lblMsgLogin.Text = "The security code you entered is incorrect. Enter the security code as shown in the image.";
            this.lblMsgLogin.ForeColor = System.Drawing.Color.Red;
            txtCaptcha.Text = "";
            txtClientSignature.Value = Session["randomno"].ToString(); //Added by Manindra on dated 31052022
            return;

        }
           
       
    }
}