using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class lgcmrelief_testemail : System.Web.UI.Page
{
    message msg = new message();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnsend_Click(object sender, EventArgs e)
    {
        Email obj_email = new Email();
        if (obj_email.sendMail("sakshi.kohli@nic.in", "", "", "sandy@nic.in", "Test LG CM Relief", "Hello", ""))
        {
            msg.Show("Mail sent");
        }
        else
        {
            msg.Show("Mail not sent");
        }
    }
}