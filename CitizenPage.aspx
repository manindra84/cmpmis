<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CitizenPage.aspx.cs" Inherits="lgcmrelief_CitizenPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%if (dt != null && dt.Rows.Count > 0)
      {%>
    <br />
    <h5 align="center">
        Details of Donation</h5>
        <table align="center" width="80%"   style='font-family: Verdana; font-size: 10pt' border="0">
        <tr>
            <td width="15%">
                <b >Mobile No.</b>
            </td>
            <td>
                <%=dt.Rows[0]["mobileno"].ToString()%>
            </td>
            </tr><tr>
            <td>
                <b>EMail Id</b>
            </td>
            <td>
                <%=dt.Rows[0]["emailid"].ToString()%>
            </td>
        </tr>
    </table>
    <br />
    <table align="center" width="80%" style='font-family: Verdana; font-size: 10pt' border="1">
        <tr style='background-color: #0b2d4d; color: white'>
            <td>
                S.No.
            </td>
            <%-- <td>
                Receipt No.
            </td>--%>
            <td>
                Name
            </td>
         <%--   <td>
                Mobile No.
            </td>
            <td>
                Email Id
            </td>--%>
            <td>
                Donation Amount
            </td>
            <td>
                Transaction Ref. No.
            </td>
            <td>
                Date of Payment
            </td>
            <td>
                Payment Mode
            </td>
            <td>
                Status
            </td>
            <td>
                Reason
            </td>
            <td>
                Remarks
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <%if (dt != null && dt.Rows.Count > 0)
          {
              for (int i = 0; i < dt.Rows.Count; i++)
              {%>
        <tr>
            <td>
                <%=i+1 %>
            </td>
            <%--<td>
                <%=dt.Rows[i]["donationid"].ToString() %>
            </td>--%>
            <td>
                <%=dt.Rows[i]["name"].ToString() %>
            </td>
           <%-- <td>
                <%=dt.Rows[i]["Mobileno"].ToString() %>
            </td>
            <td>
                <%=dt.Rows[i]["emailid"].ToString() %>
            </td>--%>
            <td>
                <%=dt.Rows[i]["Amount"].ToString()%>
            </td>
            <td>
                <%=dt.Rows[i]["transectionno"].ToString()%>
                <br />
                <%=dt.Rows[i]["bankname"].ToString()%>
            </td>
            <td>
                <%=dt.Rows[i]["pdate"].ToString()%>
            </td>
            <td>
                <%=dt.Rows[i]["Paymentmodetype"].ToString()%>
            </td>
            <td>
                <%=dt.Rows[i]["statusdesc"].ToString()%>
            </td>
            <td>
                <%=dt.Rows[i]["rejectionreason"].ToString()%>
            </td>
            <td>
                <%=dt.Rows[i]["remarks"].ToString()%>
            </td>
            <td>
                <%if (dt.Rows[i]["status"].ToString() == "2" || dt.Rows[i]["status"].ToString() == "5")
                  { %>
                <a href="Certificate.aspx?DID=<%=Utlity.Encryptdata(dt.Rows[i]["donationid"].ToString()) %>"
                    target="_New">Print</a>
                <%}
                  else if (dt.Rows[i]["status"].ToString() == "6")
                  {%>

                 <a href="DonationForm.aspx?DID=<%=Utlity.Encryptdata(dt.Rows[i]["donationid"].ToString()) %>">Edit</a>
                  
                 <% } 
                  else if (dt.Rows[i]["status"].ToString() == "4")
                  {%>

                 <a href="DonationForm.aspx?DID=<%=Utlity.Encryptdata(dt.Rows[i]["donationid"].ToString()) %>">Re-Verify</a>
                  
                 <% } 
                  else
                  {%>
                  --
                  <% } %>
            </td>
        </tr>
        <%}
          }%>
    </table>
    <br />
   
        <% } %>
</asp:Content>
