using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DeptLogin : System.Web.UI.Page
{
    GetQuery objgq = new GetQuery();
    Query objqry = new Query();
    DataTable dt = new DataTable();
    DataTable dt1 = new DataTable();
    DataTable dthod = new DataTable();
    message msg = new message();
    string flag_send = string.Empty,flag = string.Empty,rdb_value = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.QueryString["flag"] != null)
        {
            flag = MD5Util.Decrypt(Request.QueryString["flag"].ToString(), true);
        }
        else
        {
            flag = string.Empty;
        }
        FillGrid(flag);
    }

    public void FillGrid(string flag)
    {
        int deptcode = Convert.ToInt32(Session["deptcode"]);
        dt = objgq.GetAssignedWork(deptcode);      

        if(dt.Rows.Count > 0)
        {
            Gridviewdata.DataSource = dt;
            Gridviewdata.DataBind();
            if (flag == "add")
            {                
                gridheading.Text = "#Click on Serial No. to Enter Action.";
                Gridviewdata.Columns[0].Visible = true;
            }
            else if (flag == "rev")
            {                
                gridheading.Text = "#Click on Serial No. to Revise Timeline.";
                Gridviewdata.Columns[1].Visible = true;
            }
            else if (flag == "view")
            {                
                gridheading.Text = "#Click on Serial No. to View Action details.";
                Gridviewdata.Columns[2].Visible = true;
            }           
        }
        else
        {
            gridheading.Text = "No activity is assigned for this project to the department.";
        }
        
    }

    protected void Gridviewdata_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridView testGrid = (GridView)sender;

        if (e.CommandName.Equals("action"))
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            //Get the value of column from the DataKeys using the RowIndex.
            int taskid = Convert.ToInt32(testGrid.DataKeys[rowIndex].Values[0]);
            int pcode = Convert.ToInt32(testGrid.DataKeys[rowIndex].Values[1]);
            string duedate= testGrid.DataKeys[rowIndex].Values[2].ToString();

            //Response.Redirect("Action.aspx?taskid=" + MD5Util.Encrypt(taskid.ToString(),true) +"&pcode="+ MD5Util.Encrypt(pcode.ToString(), true));
            flag_send = "add";
            Response.Redirect("taskAction.aspx?taskid=" + MD5Util.Encrypt(taskid.ToString(), true) + "&pcode=" + MD5Util.Encrypt(pcode.ToString(), true) + "&flag=" + MD5Util.Encrypt(flag_send, true) );

        }
        else if(e.CommandName.Equals("revisedt"))
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            //Get the value of column from the DataKeys using the RowIndex.
            int taskid = Convert.ToInt32(testGrid.DataKeys[rowIndex].Values[0]);
            int pcode = Convert.ToInt32(testGrid.DataKeys[rowIndex].Values[1]);
            string duedate = testGrid.DataKeys[rowIndex].Values[2].ToString();
            //Response.Redirect("Action.aspx?taskid=" + MD5Util.Encrypt(taskid.ToString(),true) +"&pcode="+ MD5Util.Encrypt(pcode.ToString(), true));
            flag_send = "rev";
            //Response.Redirect("taskAction.aspx?taskid=" + MD5Util.Encrypt(taskid.ToString(), true) + "&pcode=" + MD5Util.Encrypt(pcode.ToString(), true) + "&flag=" + MD5Util.Encrypt(flag_send, true));
            Response.Redirect("taskAction.aspx?taskid=" + MD5Util.Encrypt(taskid.ToString(), true) + "&pcode=" + MD5Util.Encrypt(pcode.ToString(), true) + "&flag=" + MD5Util.Encrypt(flag_send, true) + "&duedate=" + MD5Util.Encrypt(duedate, true));
        }
        else if(e.CommandName.Equals("view"))
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            //Get the value of column from the DataKeys using the RowIndex.
            int taskid = Convert.ToInt32(testGrid.DataKeys[rowIndex].Values[0]);
            int pcode = Convert.ToInt32(testGrid.DataKeys[rowIndex].Values[1]);
            string duedate = testGrid.DataKeys[rowIndex].Values[2].ToString();

            //Response.Redirect("Action.aspx?taskid=" + MD5Util.Encrypt(taskid.ToString(),true) +"&pcode="+ MD5Util.Encrypt(pcode.ToString(), true));
            flag_send = "view";
            Response.Redirect("taskAction.aspx?taskid=" + MD5Util.Encrypt(taskid.ToString(), true) + "&pcode=" + MD5Util.Encrypt(pcode.ToString(), true) + "&flag=" + MD5Util.Encrypt(flag_send, true));
        }
    }
}