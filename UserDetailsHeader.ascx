<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserDetailsHeader.ascx.cs" Inherits="UserControls_UserDetailsHeader" %>

<%if (dtUser != null && dtUser.Rows.Count > 0)
  { %>
    <table style='font-family: Verdana; font-size: 10pt' border="0" width="100%";  >
        <tr style='background-color:Aqua'>
            <td>
               <b>User Name :</b>
            </td>
            <td>
                <%=dtUser.Rows[0]["username"].ToString()%>
            </td>
            <td>
                <b>Designation :</b>
            </td>
            <td>
                <%=dtUser.Rows[0]["designation"].ToString()%>
            </td>
            <td>
               <b> Mobile No. :</b>
            </td>
            <td>
                <%=dtUser.Rows[0]["mobileno"].ToString()%>
            </td>
            <td>
               <b> Email Id.:</b>
            </td>
            <td>
                <%=dtUser.Rows[0]["emailid"].ToString()%>
            </td>
        </tr>
    </table>

<%} %>
