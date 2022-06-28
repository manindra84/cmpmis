using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EarlierTimeline : System.Web.UI.Page
{
    string taskid = string.Empty;
    DataTable dt = new DataTable();
    GetQuery objgq = new GetQuery();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.QueryString["taskid"] != null)
        {
           // taskid = Request.QueryString["taskid"].ToString();
            taskid = MD5Util.Decrypt(Request.QueryString["taskid"].ToString(), true);
        }
        else
        {
            taskid = string.Empty;
        }
        FillGrid();
    }

    public void FillGrid()
    {
        dt = objgq.Gettimelinehistory(Convert.ToInt32(taskid));
        gridrevisehistroy.DataSource = dt;
        gridrevisehistroy.DataBind();
    }
}