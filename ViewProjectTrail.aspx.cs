using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class ViewProjectTrail : System.Web.UI.Page
{
    public DataTable dt = new DataTable();
    GetQuery objgq = new GetQuery();
    MD5Util md5util = new MD5Util();
    string pcode = string.Empty;
    public string enddt = string.Empty;
    public string endtime = string.Empty;
    public int i;
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.QueryString["pcode"] != "")
        {
            pcode = MD5Util.Decrypt(Request.QueryString["pcode"].ToString(),true);
        }
        else
        {
            pcode = string.Empty;
        }
        dt = objgq.Getprojtrail(pcode);
        //endtime = dt.Rows[i]["edate"].ToString();
    }   

    protected void btn_dwnld_Click(object sender, EventArgs e)
    {
        //FillData();
        Response.Clear();
        Response.ClearContent();
        Response.ContentType = "application/octet-stream";
        Response.AddHeader("Content-Disposition", "attachment; filename=ProjectTrail_" + DateTime.Now.ToString("ddMMyyyy") + ".xls");
        //divPrint.Style
        divPrint.RenderControl(new HtmlTextWriter(Response.Output));
        Response.End();

        //using (DataTable dt2 = new DataTable())
        //{
        //    dt2 = objgq.Getprojtrail(pcode);
        //    using (XLWorkbook wb = new XLWorkbook())
        //    {
        //        wb.Worksheets.Add(dt, "Customers");

        //        Response.Clear();
        //        Response.Buffer = true;
        //        Response.Charset = "";
        //        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        //        Response.AddHeader("content-disposition", "attachment;filename=SqlExport.xlsx");
        //        using (MemoryStream MyMemoryStream = new MemoryStream())
        //        {
        //            wb.SaveAs(MyMemoryStream);
        //            MyMemoryStream.WriteTo(Response.OutputStream);
        //            Response.Flush();
        //            Response.End();
        //        }
        //    }
        //}
    }    
}