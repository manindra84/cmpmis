<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EnterUserDetails.aspx.cs"
    Inherits="EnterUserDetails" %>

<%@ Register Src="~/UserControl/Header.ascx" TagName="top" TagPrefix="uc1" %>
<%@ Register Src="~/UserControl/UserDetails.ascx" TagName="userdetail" TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>  
    <script type="text/javascript" language="javascript" src="JS/JScript.js"></script>  
    <link href="App_Themes/MainStyles.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <table width="900" border="0" cellpadding="0" cellspacing="0" align="center">
            <tr>
                <td align="center" valign="top" colspan="1">
                    <uc1:top ID="TOP" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right">
                           <asp:Button id="btn1" runat="server" Text="Log Out" OnClick="btn1_Click"/></td>
            </tr>
            <tr>
                <td align="center" valign="top"  colspan="1" >
                            Please enter the User Details and click SUBMIT to proceed
                                &nbsp;<input id="csrftoken" type="hidden" name="csrftoken" runat="server" />
                           </td>
            </tr>
            <tr>
                <td align="center" valign="top" colspan="1">
                  <uc2:userdetail id="userdetail" runat="server" />
                    &nbsp;
                     <input id="Hidden1" runat="server" name="csrftoken" type="hidden" />
                </td>
            </tr>
               
        </table>
    </form>
</body>
</html>
