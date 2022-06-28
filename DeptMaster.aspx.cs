using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class DeptMaster : System.Web.UI.Page
{
    Dropdown drop = new Dropdown();
    MD5Util md5util = new MD5Util();
    Random randObj = new Random();
    Int32 UniqueRandomNumber = 0;
    message msg = new message();
    Query qury = new Query();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (StringUtil.GetQueryString(Request.Url.ToString()) != null)
            {

                if (md5util.IsURLTampered(StringUtil.GetWithoutDigest(StringUtil.GetQueryString(Request.Url.ToString())),
                StringUtil.GetDigest(StringUtil.GetQueryString(Request.Url.ToString()))) == true)
                {
                    Response.Redirect("Login.aspx?id=0");
                }
            }
          
            fill_grid();
        }
    }

    private void fill_grid()
    {
        try
        {
            DataTable dt = new DataTable();
            dt = drop.getuser();
            grddept.DataSource = dt;
            grddept.DataBind();
        }
        catch (Exception ex)
        {
            Response.Redirect("Errorpage.aspx");
        }

    }


    protected void grddept_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Add")
            {
                TextBox txtFabbr = ((TextBox)(grddept.FooterRow.FindControl("txtFabbr")));
                TextBox txtFname = ((TextBox)(grddept.FooterRow.FindControl("txtFname")));
                if (txtFabbr.Text == "")
                {
                    msg.Show("Please enter Abbreviation of department");
                }
                else if (txtFname.Text == "")
                {
                    msg.Show("PLease Enter Name of Department");
                }
                else
                {
                    string ipaddress = Request.ServerVariables["REMOTE_ADDR"].ToString();
                    DataTable dt = drop.getabb(txtFabbr.Text);
                    if (dt.Rows.Count > 0)
                    {
                        msg.Show("Department with " + txtFabbr.Text + " alreday created, Please try with another");
                        return;
                    }
                    else
                    {

                        int i = drop.insertdeptmaster(txtFabbr.Text, txtFname.Text, ipaddress, Session["userid"].ToString());
                        if (i > 0)
                        {
                            msg.Show("New Department added Successfully");
                            grddept.EditIndex = -1;
                            fill_grid();
                        }
                    }
                }
            }


            else if (e.CommandName == "Reset")
            {
                string pwd;
                GridView gv = (GridView)e.CommandSource;
                int index = Convert.ToInt32(e.CommandArgument);
                string userid = grddept.DataKeys[index].Values["userid"].ToString();
                string ip = Request.ServerVariables["REMOTE_ADDR"].ToString();
                //pwd = userid + "@123#";
                pwd = "4a685863e2e4f13fe9e12c523781f4941a7f6fd0bb58a8ad6b93eb7b05e9f245352913884fd02cb800a8ca5d20bd94a8e6de47138c970f32bcd96796007b2daf";
                //int temp = qury.ResetPassword(MD5Util.md5(pwd), userid, ip, Session["userid"].ToString(), Utlity.formatDatewithtime_PostGres(DateTime.Now), 'N');
                int temp = qury.ResetPassword(pwd, userid, ip, Session["userid"].ToString(), Utlity.formatDatewithtime_PostGres(DateTime.Now), 'N');
                if (temp > 0)
                {
                    fill_grid();
                    message msg = new message();
                    //msg.Show("Reset Password is : " + userid + "@123#");
                    // msg.Show("ems@123");
                    msg.Show("Password has been reset successfully");
                }
            }


            else if (e.CommandName == "Cancel")
            {
                fill_grid();
            }


        }
        
        catch (Exception ex)
        {
            Response.Redirect("Errorpage.aspx");
        }


    }
    protected void grddept_RowUpdating1(object sender, GridViewUpdateEventArgs e)
    {
        string deptcode = (grddept.DataKeys[e.RowIndex].Values["deptcode"].ToString());
        string userid = grddept.DataKeys[e.RowIndex].Values["userid"].ToString();
        int index = e.RowIndex;
        string txtEabb, txtEname;
        txtEabb = ((TextBox)grddept.Rows[index].FindControl("txtEabb")).Text;
        txtEname = ((TextBox)grddept.Rows[index].FindControl("txtEname")).Text;
        try
        {
            if (txtEabb == "")
            {
                msg.Show("Please Enter abbreviation of department");
            }
            else if (txtEname == "")
            {
                msg.Show("Please Enter Name of department");
            }
            else
            {
                string ipaddress = Request.ServerVariables["REMOTE_ADDR"].ToString();
                int i = drop.update_deptmaster(txtEabb, txtEname, deptcode);
                if (i > 0)
                {
                    msg.Show("Department Details Updated Successfully");
                    grddept.EditIndex = -1;
                    fill_grid();
                }
                else
                {
                    msg.Show("The Record is not Updated ");
                }

            }
        }
        catch (System.Threading.ThreadAbortException TAE)
        {
        }
        catch (Exception ex)
        {
            Response.Redirect("Errorpage.aspx");
        }
    }


    protected void grddept_RowEditing1(object sender, GridViewEditEventArgs e)
    {
        grddept.EditIndex = e.NewEditIndex;
        fill_grid();
    }
    protected void grddept_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {

        grddept.EditIndex = -1;
        fill_grid();
    }

    protected void grddept_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string userid = grddept.DataKeys[e.Row.RowIndex].Values["userid"].ToString();
            string dept_abb = grddept.DataKeys[e.Row.RowIndex].Values["dept_abb"].ToString();
            string deptcode = grddept.DataKeys[e.Row.RowIndex].Values["deptcode"].ToString();
            Button btn = (Button)e.Row.Cells[4].Controls[0];
          
            dept_abb = "hod"+dept_abb;
            if (userid == "Create User")
            {
                btn.Visible = false;
                HyperLink hylink = (HyperLink)e.Row.FindControl("hylink");
                hylink.NavigateUrl = (md5util.CreateTamperProofURL("Create_User.aspx", null, "dept_abb=" + MD5Util.Encrypt(dept_abb, true) + "&deptcode=" + MD5Util.Encrypt(deptcode, true)));
            }
        }
        if ((e.Row.RowState & DataControlRowState.Edit) > 0)
        {
            string userid = grddept.DataKeys[e.Row.RowIndex].Values["userid"].ToString();
            TextBox txtEabb = (TextBox)e.Row.FindControl("txtEabb");
            if (userid == "Create User")
            {
                txtEabb.Enabled = true;
            }
           
        }
    }

    protected void grddept_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}