using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;

public partial class OfficerList : System.Web.UI.Page
{
    string flag = string.Empty,dptname = string.Empty;
    DataTable dt = new DataTable();
    GetQuery objgq = new GetQuery();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.QueryString["flag"] != null)
        {
            //flag = Request.QueryString["flag"].ToString();
            flag = MD5Util.Decrypt(Request.QueryString["flag"].ToString(), true);
        }
        else
        {
            flag = string.Empty;
        }

        if(flag == "10")
        {
            lbl_pgheader.Text = "List of HODs";
        }
       
        else
        {
            lbl_pgheader.Text = "List of Nodal Officers";
        }
        FillGrid();
        if(!IsPostBack)
        {
            FillDropdown();
        }
        
        if (IsPostBack)
        {            
            dptname = ddl_filter.SelectedItem.Text;
        }
    }

    public void FillGrid()
    {
        dt = objgq.Get_officers(flag);
        grid_officer.DataSource = dt;
        grid_officer.DataBind();        
    }   


    public void FillDropdown()
    {
        dt = objgq.Get_dept();
        ddl_filter.DataTextField = "dept_abb";
        ddl_filter.DataValueField = "deptcode";
        ddl_filter.DataSource = dt;
        ddl_filter.DataBind();
        
        ddl_filter.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--All--", "0"));



    }

    protected void imgbtn_pdf_Click(object sender, ImageClickEventArgs e)
    {
        HttpContext.Current.Response.Clear(); //this clears the Response of any headers or previous output
        HttpContext.Current.Response.Buffer = true; //ma
        HttpContext.Current.Response.ContentType = "application/pdf";
        HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + lbl_pgheader.Text + ".pdf");
        HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        grid_officer.HeaderStyle.ForeColor = System.Drawing.Color.Black;        
        grid_officer.RenderControl(hw);
        StringReader sr = new StringReader(sw.ToString());
        Document pdfDoc = new Document(PageSize.A2, 20f, 20f, 10f, 0f);
        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        PdfWriter.GetInstance(pdfDoc, HttpContext.Current.Response.OutputStream);
        pdfDoc.Open();
        string Heading = lbl_pgheader.Text;
        Paragraph p = new Paragraph(Heading + "\n\n", FontFactory.GetFont("Verdana", 20, Font.BOLD, Color.BLACK));
        p.Alignment = Element.ALIGN_CENTER;
        pdfDoc.Add(p);
        htmlparser.Parse(sr);
        pdfDoc.Close();
        HttpContext.Current.Response.Write(pdfDoc);
        HttpContext.Current.Response.End();
    }

    protected void imgbtn_excel_Click(object sender, ImageClickEventArgs e)
    {
        expgrid(grid_officer, lbl_pgheader.Text);
    }

    public void expgrid(GridView grdview, string filenam)
    {
        Response.ClearContent();
        Response.Clear();
        Response.AddHeader("content-disposition", string.Format("attachment;filename={0}.xls", filenam));
        Response.Charset = "";
        string customHTML = "<div width=\"100%\" style=\"clear:both;text-align:center;font-size:12px;font-family:Verdana;\">" + lbl_pgheader.Text + "</div>";
        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        htmlWrite.Write(customHTML);
        grid_officer.HeaderStyle.ForeColor = System.Drawing.Color.White;
        grid_officer.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }


    protected void ddl_filter_SelectedIndexChanged(object sender, EventArgs e)
    {
        dt = objgq.Get_officersD(flag, ddl_filter.SelectedValue);
        grid_officer.DataSource = dt;
        grid_officer.DataBind();
    }
}