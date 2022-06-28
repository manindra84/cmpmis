using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Collections;
using System.Threading;
using Npgsql;

public partial class EnterDirection : System.Web.UI.Page
{
    Dropdown drop = new Dropdown();
    DataTable dt2 = new DataTable();
    message msg = new message();
    Random randObj = new Random();
    Int32 UniqueRandomNumber = 0;
    MD5Util md5util = new MD5Util();
    public string viewonly = "";
    string SQL = string.Empty;
    GetData objgetdata = new GetData();
    public DataTable dtfill = new DataTable();
    public List<DeptWiseModel> deptModelList;


    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (!IsPostBack)
        {
            //ViewState["RefUrl"] = Request.UrlReferrer.ToString();

            if (StringUtil.GetQueryString(Request.Url.ToString()) != null)
            {
             
            }
          
            if (Request.QueryString["pcode"] != null)
            {
                hfpcode.Value = MD5Util.Decrypt(Request.QueryString["pcode"].ToString(), true);
            }

            if (Request.QueryString["taskid"] != null)
            {
                hftaskid.Value = MD5Util.Decrypt(Request.QueryString["taskid"].ToString(), true);
            }

            //aarush changes
            if (Request.QueryString["view"] != null)
            {
                viewonly = MD5Util.Decrypt(Request.QueryString["view"].ToString(), true);
                //for Activity > View List
                if (viewonly.ToString() == "view")
                {
                    tr1.Visible = false;
                    tr2.Visible = false;
                    //aarush_uat
                    //tr3.Visible = false;
                    tr4.Visible = false;
                    tr5.Visible = false;
                    tr6.Visible = false;
                 

                    lblheader.Text = "List of Activity in the Project";

                }
                //for Project > View List
                else if (viewonly.ToString() == "noview")
                {
                    tr1.Visible = false;
                    tr2.Visible = false;
                    //aarush_uat
                    //tr3.Visible = false;
                    tr4.Visible = false;
                    tr5.Visible = false;
                    tr6.Visible = false;

                    lblheader.Text = "List of Activity in the Project";
                }
                //for Activity > Add New
                else if (viewonly.ToString() == "add")
                {
                    lblheader.Text = " Assign New Activity in the Project";
                    divsubprojname.Visible = true;
                }


                else if (viewonly.ToString() == "deletetask")
                {

                   DeleteTask(hfpcode.Value, hftaskid.Value);
                }
            }
            //if view in query string is null
            else
            {
                Response.Redirect("ErrorPage.aspx");
            }
          
        
            filllabels();
            txtdirection.Focus();
            fill_grid();
            fill_Department();
            fillSubProjeName();
        }
       
    }


    private void fill_grid()
    {
        
        DataTable dt3 = new DataTable();
        dt3 = drop.getdept_taskmaster_2(hfpcode.Value);


        if (hfpcode.Value != "")
        {
            dtfill = drop.getdept_taskmaster(hfpcode.Value);
        }  
        if(dtfill.Rows.Count > 0)
        {

            //grdprojview.DataSource = dtfill;
            //grdprojview.DataBind();

            if (dtfill.Rows.Count > 0)
            {
                deptModelList = new List<DeptWiseModel>();
                deptModelList = (from DataRow dr in dtfill.Rows
                                 select new DeptWiseModel()
                                 {
                                     taskid = dr["taskid"].ToString(),
                                     taskname = dr["taskname"].ToString(),
                                     pcode = dr["pcode"].ToString(),
                                     deptcode = dr["deptcode"].ToString(),
                                     deptname = dr["deptname"].ToString(),
                                     enddt = dr["enddt"].ToString(),
                                     earliertimeline = dr["earliertimeline"].ToString(),
                                     activityremarks = dr["activityremarks"].ToString(),
                                     subprojname = dr["subprojname"].ToString(),
                                     subprojid = dr["subprojid"].ToString(),
                                     serial_number = dr["serial_number"].ToString(),

                                 }).ToList();

            }

        }


        for (int i = 0; i < dtfill.Rows.Count; i++)
        {
            //rows for which due date has passed current date, will become red.
            if (dt3.Rows[i]["enddt"].ToString() != null && dt3.Rows[i]["enddt"].ToString() != "")
            {
                DateTime endt = Convert.ToDateTime(dt3.Rows[i]["enddt"]);
                if (endt < DateTime.Now)
                {
                    //grdprojview.Rows[i].ForeColor = System.Drawing.Color.Red;
                }
            }

            //fill revised timeline dates for activity
            string taskid = dtfill.Rows[i]["taskid"].ToString();
            dt2 = drop.get_revisetimelinelog(taskid);
            if (dt2.Rows.Count > 0)
            {
                for (int j = 0; j < dt2.Rows.Count; j++)
                {
                    //grdprojview.Columns[3].
                }
            }
        }
    }

    protected void btnsbmt_Click(object sender, EventArgs e)
    {
        try
        {
            string ipaddress = Request.ServerVariables["REMOTE_ADDR"].ToString();
            string userid = Session["userid"].ToString();
            DateTime edate = DateTime.Now;
            string officerid = string.Empty;

            //aarush_uat
            //if (txtboxtargetdate.Text != "" && Utlity.comparedatesDMY(txtboxtargetdate.Text, txtdateofissue.Text) <= 0)
            //{
            //    msg.Show("Target Date Should be greater than Date of Activity completion date");
            //    return;
            //}

            DataTable dt;
            string query = @"select * from  taskmaster where taskname =@taskname and pcode=@pcode ";
            NpgsqlCommand cmd1 = new NpgsqlCommand(query);
            cmd1.Parameters.AddWithValue("@taskname", txtdirection.Text);
            cmd1.Parameters.AddWithValue("@pcode", hfpcode.Value);
            dt = objgetdata.GetDataTable(cmd1);

            if (dt.Rows.Count > 0)
            {
                if (txtdirection.Text.Trim().ToUpper() == dt.Rows[0]["taskname"].ToString().ToUpper())
                {
                    message msg = new message();
                    msg.Show("Duplicate Entry Found , Activity cannot be Same");
                    return;
                }
            }


            int result = drop.inserttask(txtdirection.Text, ipaddress, userid, hfpcode.Value, "P",ddldeptnodal.SelectedValue,txtboxtargetdate.Text,ddlsubprojname.SelectedValue,txtactivityremarks.Text.Trim());
            if (result > 0)
            {
                //Server.Transfer("Project_details.aspx?flag=view");

                Response.Redirect("EnterDirection.aspx?pcode=" + MD5Util.Encrypt(hfpcode.Value, true) + "&view=" + MD5Util.Encrypt("view", true));
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

    public void fill_Department()
    {
        Dropdown objddl = new Dropdown();
        DataTable dt1 = new DataTable();
        //dt1 = objddl.GetNodalDept(hfpcode.Value);
        dt1 = objddl.GetAllDept();
        for (int i = 0; i < dt1.Rows.Count; i++)
        {
            for (int j = 0; j < dt1.Columns.Count; j++)
            {
                //dt.Rows[i][j] = Utility.getstring(dt.Rows[i][j].ToString());
                if (string.IsNullOrEmpty(dt1.Rows[i][j].ToString()))
                {

                }
                else
                {
                    dt1.Rows[i][j] = Utlity.getstring(dt1.Rows[i][j].ToString());
                }
            }
        }
        ddldeptnodal.DataValueField = "deptcode";
        ddldeptnodal.DataTextField = "deptname";
        ddldeptnodal.DataSource = dt1;
        if (dt1.Rows.Count > 0)
        {          
            ddldeptnodal.DataBind();
            ddldeptnodal.Items.Insert(0, Utlity.FirstItem());
        }
        else
        {
     

        }
    }


    private void filllabels()
    {
        string str = null;
        try
        {
            DataTable dt = null;
            //new function
            //dt = drop.ViewDirections("",hftaskid.Value);
            dt = drop.GetProjname(hfpcode.Value);
            if (dt.Rows.Count>0)
            {
                lblprojectname.InnerText = dt.Rows[0]["pname"].ToString();
                //Label1projstarteddate.InnerText = dt.Rows[0]["startdate"].ToString();
                lblppcomdate.InnerText = dt.Rows[0]["enddate"].ToString();
                lblnodaldept.InnerText = dt.Rows[0]["deptname"].ToString();

            }
         
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }

    public void fillSubProjeName()
    {
        Dropdown objddl = new Dropdown();
        DataTable dt1 = new DataTable();
        dt1 = objddl.GetddlSubprojname(hfpcode.Value);
        for (int i = 0; i < dt1.Rows.Count; i++)
        {
            for (int j = 0; j < dt1.Columns.Count; j++)
            {
                //dt.Rows[i][j] = Utility.getstring(dt.Rows[i][j].ToString());
                if (string.IsNullOrEmpty(dt1.Rows[i][j].ToString()))
                {

                }
                else
                {
                    dt1.Rows[i][j] = Utlity.getstring(dt1.Rows[i][j].ToString());
                }
            }
        }
        ddlsubprojname.DataValueField = "id";
        ddlsubprojname.DataTextField = "subprojname";
        ddlsubprojname.DataSource = dt1;

        if (dt1.Rows.Count > 0 && viewonly.ToString() == "add")
        {
             
            divsubprojname.Visible = true;
            ddlsubprojname.DataBind();
            ddlsubprojname.Items.Insert(0, Utlity.First());
        }
        else
        {
            divsubprojname.Visible = false;
        }

    }


    public void DeleteTask(string pcode, string taskid)
    {
        List<NpgsqlCommand> cmdList = new List<NpgsqlCommand>();
        NpgsqlCommand cmd = null;


        SQL = @"delete from task_dept where taskid in (select taskid from taskmaster where pcode=@pcode and taskid=@taskid)";
        cmd = new NpgsqlCommand(SQL);
        cmd.Parameters.AddWithValue("@pcode", pcode);
        cmd.Parameters.AddWithValue("@taskid", taskid);
        cmdList.Add(cmd);

        SQL = @"delete from tasktimelinehistory where taskid=@taskid";
        cmd = new NpgsqlCommand(SQL);
        cmd.Parameters.AddWithValue("@taskid", taskid);
        cmdList.Add(cmd);

        SQL = @"delete from taskmaster where pcode=@pcode and taskid=@taskid";
        cmd = new NpgsqlCommand(SQL);
        cmd.Parameters.AddWithValue("@pcode", pcode);
        cmd.Parameters.AddWithValue("@taskid", taskid);
        cmdList.Add(cmd);

        SQL = @"delete from cmdirection where pcode=@pcode and taskid=@taskid";
        cmd = new NpgsqlCommand(SQL);
        cmd.Parameters.AddWithValue("@pcode", pcode);
        cmd.Parameters.AddWithValue("@taskid", taskid);
        cmdList.Add(cmd);

        SQL = @"delete from actionmaster where pcode=@pcode and taskid=@taskid";
        cmd = new NpgsqlCommand(SQL);
        cmd.Parameters.AddWithValue("@pcode", pcode);
        cmd.Parameters.AddWithValue("@taskid", taskid);
        cmdList.Add(cmd);



        long[] InsCount = objgetdata.DeleteTransactionalData(cmdList);
        if (InsCount[0] > 0)
        {
            string msgStr = "Task Details Deleted  Successfully";
            //string redirectPage = "EnterDirection.aspx?flag=" + MD5Util.Encrypt("no", true);
            string redirectPage = "EnterDirection.aspx?pcode=" + MD5Util.Encrypt(pcode.ToString(), true) + "&view=" + MD5Util.Encrypt("view", true);
            string script = "alert('" + msgStr + "');\n";
            script += "location.href='" + redirectPage + "';\n";
            Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", script, true);
        }

    }

}