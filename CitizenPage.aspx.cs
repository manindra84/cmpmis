using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Npgsql;
using System.Data;

public partial class lgcmrelief_CitizenPage : System.Web.UI.Page
{
    public DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(Session["OTP"].ToString()))
            {
                Response.Redirect("Home.aspx");
            }
        }
        catch { Response.Redirect("ErrorPage.aspx"); }
        
        FillData();
    }

    public void FillData()
    {
        GetData data = new GetData();

        string SQL = @"select A.donationid,name,dop,mobileno,bankname,transectionno,paymentmodetype,amount,to_char(dop,'dd/MM/yyyy') as pdate,address,districtname,statename,emailid,
	                    A.status,statusdesc,rd.remarks,rm.rejectionreason,to_char(statusdate,'dd/MM/yyyy') as statusdate from 
	                    donationdetails A Inner Join StateMaster sm on sm.statecode = A.statecode Inner Join DistrictMaster dm on dm.districtcode=a.districtcode
	                    Inner Join Paymentmodemaster pm on pm.paymentmodeid = A.paymentmode 
	                    inner join statusmaster smt on smt.status = A.status 
	                    Left Outer Join reasondetails rd on rd.reasondetailid = A.reasondetailid
	                    Left Outer Join rejectionmaster rm on rm.rejectionid = rd.reasoncode and rm.statuscode = rd.statuscode
                        where emailid = @emailid and mobileno=@mobileno order by dop desc";
        NpgsqlCommand cmd = new NpgsqlCommand(SQL);
        cmd.Parameters.AddWithValue("@emailid", Session["EMailId"].ToString());
        cmd.Parameters.AddWithValue("@MobileNo", Session["MobileNo"].ToString());
         dt = data.GetDataTable(cmd);
    }

}