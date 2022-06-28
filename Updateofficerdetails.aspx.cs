using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Updateofficerdetails : System.Web.UI.Page
{
    string flag = string.Empty;
    DataTable dthod = new DataTable();
    GetQuery objgq = new GetQuery();
    message msg = new message();
    Query objqry = new Query();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.QueryString["flag"].ToString() != "")
        {
            //flag = Request.QueryString["flag"].ToString();
            flag = MD5Util.Decrypt(Request.QueryString["flag"].ToString(), true);
        }
        else
        {
            flag = string.Empty;
        } 
        
        if(!IsPostBack)
        {
            if (flag == "10")
            {
                lbl_pgheader.Text = "Update HOD Details";
                FillHODDetails();
            }

            else
            {                
                lbl_pgheader.Text = "Nodal Officer";
                div_userid.Visible = false;
                txt_name.Text = "";                
                txt_mobno.Text = "";
                txt_email.Text = "";
                btn_saveHOD.Text = "Save";
            }
        }
        
    }

    public void FillHODDetails()
    {
        dthod = objgq.gethodetails(Session["deptcode"].ToString(), flag);
        if(dthod.Rows.Count > 0)
        {
            txt_name.Text = Utility.getstring(dthod.Rows[0]["user_name"].ToString());
            txt_userid.Text = dthod.Rows[0]["user_id"].ToString();
            txt_desig.Text = dthod.Rows[0]["designation"].ToString();
            txt_mobno.Text = dthod.Rows[0]["contactno"].ToString().Trim();
            txt_email.Text = Utility.getstring(dthod.Rows[0]["email"].ToString());
            btn_saveHOD.Text = "Update";
            div_userid.Visible = true;
            hdf_userid.Value = dthod.Rows[0]["user_id"].ToString();
        }
        else
        {
            txt_name.Text = "";
            txt_desig.Text = "";
            txt_mobno.Text = "";
            txt_email.Text = "";
            btn_saveHOD.Text = "Save";
            div_userid.Visible = false;
        }
    }



    protected void btn_saveHOD_Click(object sender, EventArgs e)
    {
        if (txt_name.Text == "")
        {
            msg.Show("Please enter name of HOD !");
        }

        if (txt_desig.Text == "")
        {
            msg.Show("Please enter designation !");
        }

        else if (txt_mobno.Text == "")
        {
            msg.Show("Please enter Mobile No !");
        }
        else if (txt_email.Text == "")
        {
            msg.Show("Please enter Email !");
        }
        else
        {
            string ipaddress = Request.ServerVariables["REMOTE_ADDR"].ToString();
            string userid = "";
            //int nod = Convert.ToInt32(objgq.getuserdetails(Session["deptcode"].ToString()));
            int nod = Convert.ToInt32(objgq.getuserdetails(Session["deptcode"].ToString()));
            //DataTable dthod = new DataTable();
            //dthod = objgq.getuserdetails1(Session["deptcode"].ToString());
            //string userid_prev = dthod.Rows[0]["user_id"].ToString();            
            string deptname = objgq.getdeptname(Session["deptcode"].ToString());
            
            //string count = dtnod.Rows[0]["user_id"].ToString();            

            if (flag == "10")
            {
                userid = deptname;
            }
            else
            {
                //if there is a nodal officer already then
                if(nod != 0)
                {
                    userid = "no" + deptname + (nod+1);
                }
                //if no nodal officer is present 
                else
                {
                    userid = "no" + deptname;
                }
            }
            
            DateTime edate = DateTime.Now;
            string username = string.Empty;
            string actionpage = string.Empty;
            string pwd = "540e0733bee921e50965034ed8f6590e2a16ac53caf807c047cec2c2e6d5b1e681d1df728d5d7325f4ef589b69813de7a9bf430227003fabec6f2d7de622317d";

            if (btn_saveHOD.Text == "Save")
            {
                int result = objqry.insert_HOD(userid.ToLower(), Utility.putstring(txt_name.Text), flag, Session["deptcode"].ToString(), "1", txt_mobno.Text, Utility.putstring(txt_email.Text), ipaddress,pwd ,Session["userid"].ToString().Trim(),txt_desig.Text);
                if (result > 0)
                {
                   // msg.Show("Details added successfully !");
                    if (flag == "10")
                    {
                        // Response.Redirect("Updateofficerdetails.aspx?flag=10");
                        //Response.Redirect("Updateofficerdetails.aspx?flag=" + MD5Util.Encrypt("10", true));
                        actionpage = "Updateofficerdetails.aspx?flag=" + MD5Util.Encrypt("10", true);
                    }
                    else if(flag=="16")
                    {
                        //Response.Redirect("ViewNodalList.aspx?flag=16");
                        //Response.Redirect("ViewNodalList.aspx?flag=" + MD5Util.Encrypt("16", true));
                        actionpage = "ViewNodalList.aspx?flag=" + MD5Util.Encrypt("16", true);
                    }
                    string msgStr = "Details Added successfully !";
                    string redirectPage = actionpage;
                    string script = "alert('" + msgStr + "');\n";
                    script += "location.href='" + redirectPage + "';\n";
                    Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);
                    return;
                }
            }
            else if (btn_saveHOD.Text == "Update")
            {
               
                int result = objqry.update_HOD(hdf_userid.Value, Utility.putstring(txt_name.Text), Session["deptcode"].ToString(), txt_mobno.Text, Utility.putstring(txt_email.Text),txt_desig.Text);
                if (result > 0)
                {
                    //msg.Show("Details updated successfully !");
                    if (flag == "10")
                    {
                        //Response.Redirect("Updateofficerdetails.aspx?flag=10");
                        //Response.Redirect("Updateofficerdetails.aspx?flag=" + MD5Util.Encrypt("10", true));
                        actionpage= "Updateofficerdetails.aspx?flag=" + MD5Util.Encrypt("10", true);
                    }
                    else if (flag == "16")
                    {
                        //Response.Redirect("ViewNodalList.aspx?flag=16");
                        //Response.Redirect("ViewNodalList.aspx?flag=" + MD5Util.Encrypt("16", true));
                        actionpage = "ViewNodalList.aspx?flag=" + MD5Util.Encrypt("16", true);
                    }

                    string msgStr = "Details updated successfully !";
                    string redirectPage = actionpage;
                    string script = "alert('" + msgStr + "');\n";
                    script += "location.href='" + redirectPage + "';\n";
                    Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);
                    return;
                }
                
            }

            txt_name.Text = "";            
            txt_mobno.Text = "";
            txt_email.Text = "";
        }
    }

    protected void btn_resetuser_Click(object sender, EventArgs e)
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

            string msgStr = "Password reset successfully";
            string redirectPage = "Updateofficerdetails.aspx?flag=" + MD5Util.Encrypt("10", true);
            string script = "alert('" + msgStr + "');\n";
            script += "location.href='" + redirectPage + "';\n";
            Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);
            return;

        }
       // Response.Redirect("Updateofficerdetails.aspx?flag=15");
        //Response.Redirect("Updateofficerdetails.aspx?flag=" + MD5Util.Encrypt("15", true));
    }
}