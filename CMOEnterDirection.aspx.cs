using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Collections;
using System.Threading;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;


public partial class CMOEnterDirection : System.Web.UI.Page
{
    Dropdown drop = new Dropdown();
    message msg = new message();
    Random randObj = new Random();
    Int32 UniqueRandomNumber = 0;
    MD5Util md5util = new MD5Util();
    string viewonly = "";
    GetQuery objgq = new GetQuery();
    DataTable dt = null;
    public int taskid1 = 0, pcode = 0;

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
           

            if (Request.QueryString["pcode"] != null)
            {
                hfpcode.Value = MD5Util.Decrypt(Request.QueryString["pcode"].ToString(), true);
            }

            if (Request.QueryString["view"] != null)
            {
                viewonly = MD5Util.Decrypt(Request.QueryString["view"].ToString(), true);
                if(viewonly.ToString() == "View")
                {                
                    lblheader.Text = "List of Activity in the Project";

                }
            }      
            filllabels();          
            fill_grid();

            if(!this.IsPostBack)
            {
                dt = objgq.Getrevisehistory(taskid1.ToString());
                gridrevisehistroy.DataSource = dt;
                gridrevisehistroy.DataBind();
            }

        }
        
    }


    private void fill_grid()
    {
        DataTable dtfill = new DataTable();
        if (hfpcode.Value != "")
        {
            dtfill = drop.getdept_taskmasterCMO(hfpcode.Value,rblstatus.SelectedValue);
        }
      
        if (dtfill.Rows.Count > 0)
        {
            trheader.Visible = true;
            lblheader.Visible = true;
            grdprojview.DataSource = dtfill;
            grdprojview.DataBind();
        }
        else
        {
            //msg.Show("No Record Found");
            trheader.Visible = false;
            lblheader.Visible = false;
            grdprojview.DataSource = "";
            grdprojview.DataBind();
        }
    }





    private void filllabels()
    {
        string str = null;
        try
        {
           
            //new function
            //dt = drop.ViewDirections("",hftaskid.Value);
            dt = drop.GetProjname(hfpcode.Value);
            if (dt.Rows.Count>0)
            {
                //lblmeeting.Text = hfmeetindatetime.Value;
                //lblissuename.Text = dt.Rows[0]["taskname"].ToString();
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    lblprojectname.Text = dt.Rows[0]["pname"].ToString();
                    hfc_pname.Value = dt.Rows[0]["pname"].ToString();
                    //Label1projstarteddate.Text = dt.Rows[0]["startdate"].ToString();
                    lblppcomdate.Text = dt.Rows[0]["enddate"].ToString();
                    if (dt.Rows[i]["nodaldept"].ToString() == "Y")
                    {
                        lblnodaldept.Text = dt.Rows[i]["deptname"].ToString();
                        hfc_deptnodal.Value = dt.Rows[i]["deptname"].ToString();

                        lblnodalname.Text= dt.Rows[i]["user_name"].ToString();
                        lblNmob.Text = dt.Rows[i]["mobile"].ToString();
                        lblemail.Text = dt.Rows[i]["email"].ToString();
                    }
                    else
                    {
                        str = str + dt.Rows[i]["deptname"].ToString() +",";                     
                        //lblotherconcerneddept.Text = str;

                    }
                    //lblotherconcerneddept.Text = lblotherconcerneddept.Text.TrimEnd(new char[] { ',' });
                    //if(lblotherconcerneddept.Text==null || lblotherconcerneddept.Text=="")
                    //{
                    //    lblotherconcerneddept.Text = "--";
                    //}
              

                }
            }
         
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }   

    protected void rblstatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        fill_grid();
    }

    protected void grdprojview_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string pcode = (grdprojview.DataKeys[e.Row.RowIndex].Values["pcode"]).ToString().Trim();
            string taskid = (grdprojview.DataKeys[e.Row.RowIndex].Values["taskid"]).ToString().Trim();

            //HyperLink h1 = (HyperLink)e.Row.FindControl("hlinktaskname");
            //h1.NavigateUrl = md5util.CreateTamperProofURL("CMOViewAll.aspx", null, "pcode=" + MD5Util.Encrypt(pcode, true) + "&taskid=" + MD5Util.Encrypt(taskid ,true));

            //HyperLink h2 = (HyperLink)e.Row.FindControl("hlinkassignto");
            //h2.NavigateUrl = md5util.CreateTamperProofURL("CMOViewAll.aspx", null, "pcode=" + MD5Util.Encrypt(pcode, true) + "&taskid=" + MD5Util.Encrypt(taskid, true));

            //HyperLink h3 = (HyperLink)e.Row.FindControl("hlinkduedate");
            //h3.NavigateUrl = md5util.CreateTamperProofURL("CMOViewAll.aspx", null, "pcode=" + MD5Util.Encrypt(pcode, true) + "&taskid=" + MD5Util.Encrypt(taskid, true));

            HyperLink h4 = (HyperLink)e.Row.FindControl("lnkbtncmoview");
            h4.NavigateUrl = md5util.CreateTamperProofURL("CMOViewAll.aspx", null, "pcode=" + MD5Util.Encrypt(pcode, true) + "&taskid=" + MD5Util.Encrypt(taskid, true));
            
        }
    }

    protected void btn_dwnld_Click(object sender, EventArgs e)
    {
        expgrid(grdprojview, "List of Activities");
        //DownloadGrid(ddl_dwnld.SelectedItem.Text);
    }

    public void expgrid(GridView grdview, string filenam)
    {        
        Response.ClearContent();
        Response.Clear();
        Response.AddHeader("content-disposition", string.Format("attachment;filename={0}.xls", filenam));
        Response.Charset = "";
        string customHTML = "<div width=\"100%\" style=\"clear:both;text-align:center;font-size:12px;font-family:Verdana;\">" + hfc_pname.Value + " (" + hfc_deptnodal.Value + ") " + "</div>";
        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);        
        htmlWrite.Write(customHTML);
        grdprojview.HeaderStyle.ForeColor = System.Drawing.Color.White;
        grdprojview.RenderControl(htmlWrite);        
        Response.Write(stringWrite.ToString());
        Response.End();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }

    public void Download_pdf()
    {
        
            HttpContext.Current.Response.Clear(); //this clears the Response of any headers or previous output
            HttpContext.Current.Response.Buffer = true; //ma
            HttpContext.Current.Response.ContentType = "application/pdf";
            HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + "List of Activities" + ".pdf");
            HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            grdprojview.HeaderStyle.ForeColor = System.Drawing.Color.Black;
            
            grdprojview.RenderControl(hw);
            StringReader sr = new StringReader(sw.ToString());
            Document pdfDoc = new Document(PageSize.A2, 20f, 20f, 10f, 0f);
            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            PdfWriter.GetInstance(pdfDoc, HttpContext.Current.Response.OutputStream);
            pdfDoc.Open();
            string Heading = "List of Activities";
            Paragraph p = new Paragraph(Heading + "\n\n", FontFactory.GetFont("Verdana", 20, Font.BOLD, Color.BLACK));
            p.Alignment = Element.ALIGN_CENTER;
            pdfDoc.Add(p);
            htmlparser.Parse(sr);
            pdfDoc.Close();
            HttpContext.Current.Response.Write(pdfDoc);
            HttpContext.Current.Response.End();
        
    }

    //protected override void Render(HtmlTextWriter writer)
    //{
    //    if (Page != null)
    //    {
    //        Page.VerifyRenderingInServerForm(this);
    //    }
    //    base.Render(writer);
    //}



    protected void imgbtn_excel_Click(object sender, ImageClickEventArgs e)
    {
        expgrid(grdprojview, "List of Activities");
    }

    protected void imgbtn_pdf_Click(object sender, ImageClickEventArgs e)
    {
        Download_pdf();
    }

    //public void FillModal(string taskid)
    //{
    //    dt = objgq.Getrevisehistory(taskid);
    //    gridrevisehistroy.DataSource = dt;
    //    gridrevisehistroy.DataBind();
    //}



    //protected void grdprojview_RowCommand1(object sender, GridViewCommandEventArgs e)
    //{
    //    GridView testGrid = (GridView)sender;

    //    if (e.CommandName.Equals("action"))
    //    {
    //        int rowIndex = int.Parse(e.CommandArgument.ToString());
    //        //Get the value of column from the DataKeys using the RowIndex.            
    //        taskid1 = Convert.ToInt32(testGrid.DataKeys[rowIndex].Values[1]);            
    //    }
    //}

    protected void grdprojview_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridView testGrid = (GridView)sender;

        if (e.CommandName.Equals("action"))
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            //Get the value of column from the DataKeys using the RowIndex.            
            taskid1 = Convert.ToInt32(testGrid.DataKeys[rowIndex].Values[1]);

            Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('EarlierTimeline.aspx?taskid=" + MD5Util.Encrypt(taskid1.ToString(), true)+ "','_blank');", true);

           // Response.Redirect("Updateofficerdetails.aspx?flag=" + MD5Util.Encrypt("16", true));
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('EarlierTimeline.aspx?taskid=" + taskid1 + "','_blank');", true);

        }
    }
}