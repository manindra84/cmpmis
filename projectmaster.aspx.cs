using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Threading;
using Npgsql;

public partial class projectmaster : System.Web.UI.Page
{
    Dropdown drop = new Dropdown();
    message msg = new message();
    MD5Util md5Util = new MD5Util();
    Random randObj = new Random();
    Int32 UniqueRandomNumber = 0;
    GetData objgetdata = new GetData();
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //if (StringUtil.GetQueryString(Request.Url.ToString()) != null)
            //{

            //    if (md5Util.IsURLTampered(StringUtil.GetWithoutDigest(StringUtil.GetQueryString(Request.Url.ToString())),
            //    StringUtil.GetDigest(StringUtil.GetQueryString(Request.Url.ToString()))) == true)
            //    {
            //        Response.Redirect("Login.aspx?id=0");
            //    }
            //}
            //UniqueRandomNumber = randObj.Next(1, 10000);
            //Session["token"] = UniqueRandomNumber.ToString();
            //this.csrftoken.Value = Session["token"].ToString();

            fillpcategory();
            fill_grid();
            txtpname.Focus();
        }

        else
        {
            //if (((Request.Form["ctl00$ContentPlaceHolder1$csrftoken"] != null) && (Session["token"] != null)) && (Request.Form["ctl00$ContentPlaceHolder1$csrftoken"].ToString().Equals(Session["token"].ToString())))
            //{
            //    //valid Page
            //}
            //else
            //{
            //    Response.Redirect("ErrorPage.aspx");
            //}
        }

    }

    private void fillpcategory()
    {
        try
        {
            DataTable dtpcategory = new DataTable();
            dtpcategory = drop.getprojectcategory();
            ddlpcategory.DataTextField = "pcategory";
            ddlpcategory.DataValueField = "pcid";
            ddlpcategory.DataSource = dtpcategory;
            ddlpcategory.DataBind();
            //ddlpcategory.Items.Insert(0, Utlity.FirstItem());
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }

    private void fill_grid()
    {
        try
        {
            DataTable dtfill = new DataTable();
            dtfill = drop.getdeptmaster();
            if (dtfill.Rows.Count > 0)
            {
                grddept.DataSource = dtfill;
                grddept.DataBind();
            }
            else
            {
                msg.Show("No Record Found");
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }

    protected void chknd_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chknd = (CheckBox)sender;
        GridViewRow gr = (GridViewRow)chknd.Parent.Parent;
        int index = gr.RowIndex;
        if (chknd.Checked)
        {
            CheckBox chk = (CheckBox)gr.FindControl("chk");
            if (!chk.Checked)
            {
                msg.Show("Please select Department.");
                chknd.Checked = false;
                return;
            }
            hfnd.Value = "Y";

            for (int i = 0; i < grddept.Rows.Count; i++)
            {
                if (i != index)
                {
                    CheckBox chknd1 = (CheckBox)grddept.Rows[i].FindControl("chknd");
                    chknd1.Checked = false;
                }
            }
        }
        else
        {
            hfnd.Value = "";
        }
    }

    protected void btn_submit_Click(object sender, EventArgs e)
    {
        try
        {
            //aarush_uat
            //if (txtenddate.Text != "" && txtstartdate.Text != "" && Utlity.comparedatesDMY(txtenddate.Text, txtstartdate.Text) <= 0)
            //{
            //    msg.Show("Target Date Should be greater than Start Date of Project");
            //    return;
            //}

            if (Validation.chkLeve28(txtboxdesc.Text) || Validation.chkLeve28(txtpname.Text))
            {
                msg.Show("Invalid Inputs");
                return;
            }


            string deptcode = "";
            Dictionary<string, string> dictionary = new Dictionary<string, string>();
            
            for (int i = 0; i < grddept.Rows.Count; i++)
            {
                CheckBox chknd = (CheckBox)grddept.Rows[i].FindControl("chknd");
                CheckBox chk = (CheckBox)grddept.Rows[i].FindControl("chk");
                if (chk.Checked)
                {
                    GridViewRow gvRow = (GridViewRow)(chk).Parent.Parent;
                    int index = gvRow.RowIndex;
                    deptcode = grddept.DataKeys[index].Value.ToString();
                    string wnodal = "N";
                    if (chknd.Checked)
                    {
                        wnodal = "Y";
                    }
                    dictionary.Add(deptcode, wnodal);
                }
            }
            if (dictionary.Count == 0)
            {
                msg.Show("Please Select Department(s) Concerned");
            }
            else
            {

                if (Validation.chkLeve28(txtpname.Text.ToUpper()) || Validation.chkLeve28(txtboxdesc.Text))
                {
                    msg.Show("Invalid Inputs");
                    return;
                }


                DataTable dt;
                string query = @"select pname from projectmaster where pname ilike @pname ";

                NpgsqlCommand cmd1 = new NpgsqlCommand(query);
                cmd1.Parameters.AddWithValue("@pname", "%" + txtpname.Text.Trim() + "%");

                //cmd1.Parameters.AddWithValue("@pname", txtpname.Text.Trim());
                dt = objgetdata.GetDataTable(cmd1);

                if (dt.Rows.Count > 0)
                {
                    if (txtpname.Text.ToUpper().Trim() == dt.Rows[0]["pname"].ToString().ToUpper().Trim())
                    {
                        message msg = new message();
                        msg.Show("Duplicate Project Name Found!!");
                        return;
                    }
                }


                if (hfnd.Value == "Y")
                {
                    string ipaddress = Request.ServerVariables["REMOTE_ADDR"].ToString();
                    string userid = Session["userid"].ToString();
                    int result = drop.insertprojectmaster(Utility.putstring(txtpname.Text.ToUpper().Trim()), ddlpcategory.SelectedValue,  txtenddate.Text, ipaddress, userid, dictionary, Utility.putstring(txtboxdesc.Text.Trim()));
                   // hfpcode.Value = result.ToString();
                    if (result > 0)
                    {
                        //msg.Show("Project Added");
                        //Response.Redirect("Project_details.aspx?flag=" + MD5Util.Encrypt("view", true));

                        string msgStr = "Project Added";                   
                        string redirectPage = "Project_details.aspx?flag=" + MD5Util.Encrypt("view".ToString(), true);
                        string script = "alert('" + msgStr + "');\n";
                        script += "location.href='" + redirectPage + "';\n";
                        Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);


                    }
                }
                else
                {
                    msg.Show("Please Select a Nodal Department");
                }
            }
        }
        catch (ThreadAbortException TAE)
        {
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }
}