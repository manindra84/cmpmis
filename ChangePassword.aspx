<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" 
    Inherits="ChangePassword" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container ">
        <div class="content">

            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-12">
                    <h4 class="clr-blue">Change Password</h4>

                    <table width="50%" align="center">
                        <tr>
                            <td>
                                <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword">Old Password:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="CurrentPassword" runat="server" CssClass="passwordEntry" autocomplete="off"
                                    TextMode="Password" AutoCompleteType="Disabled"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword"
                                    CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Old Password is required."
                                    ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword">New Password:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="NewPassword" runat="server" CssClass="passwordEntry" autocomplete="off"
                                    TextMode="Password" AutoCompleteType="Disabled"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword"
                                    CssClass="failureNotification" ErrorMessage="New Password is required." ToolTip="New Password is required."
                                    ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword">Confirm New Password:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="ConfirmNewPassword" runat="server" CssClass="passwordEntry" autocomplete="off"
                                    TextMode="Password" AutoCompleteType="Disabled"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword"
                                    CssClass="failureNotification" Display="Dynamic" ErrorMessage="Confirm New Password is required."
                                    ToolTip="Confirm New Password is required." ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword"
                                    ControlToValidate="ConfirmNewPassword" CssClass="failureNotification" Display="Dynamic"
                                    ErrorMessage="The Confirm New Password must match the New Password entry." ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <td>
                                    <asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword"
                                        Text="Change Password" ValidationGroup="ChangeUserPasswordValidationGroup" OnClick="ChangePasswordPushButton_Click" />
                                </td>
                        </tr>
                    </table>

                    <br />
                    <br />
                    <p align="left" style="color: Red; font-size: 14px">
                        1 : User has to change his/her password after first login.
                        <br />
                        2 : User has to change his/her password atleast once in 30 days.
                        <br />
                        3 : Password length should be minimum 8 characters.
                        <br />
                        4 : Password must contain atleast 1 Alphabet(a-z/A-Z), 1 Number(0-9) and 1 Special Character(!,@,#,$,%,^,&,*,_) .
                        <br />
                    </p>
                </div>

                <asp:HiddenField ID="salt" runat="server" />
                <asp:HiddenField ID="HdNewPass" runat="server" />
                <asp:HiddenField ID="HdReNewPass" runat="server" />
                <asp:HiddenField ID="csrfval" runat="server" />
                <script language="javascript" src="JS/Sha512.js" type="text/javascript"></script>
                <script language="javascript" type="text/javascript">
                    function SignValidate() {
                        if 
        (!document.getElementById("<%=NewPassword.ClientID%>").value.match(/^.*(?=.{8,})(?=.*\d)(?=.*[a-zA-Z])(?=.*[@*!#$%^&+=]).*$/)) {
                flag = true;
                alert("Password must be of minimum 8 letters long and must contain at least one numeric,one alphabetic and one special characters.");
                return false;
            }

            var NewRepwd = document.getElementById("<%=ConfirmNewPassword.ClientID%>").value;
            var Newpwd = document.getElementById("<%=NewPassword.ClientID%>").value;
            if (NewRepwd != Newpwd) {
                alert("New Password and Confirm Password Does Not Match");
                document.getElementById("<%=ConfirmNewPassword.ClientID%>").value = ""
                document.getElementById("<%=NewPassword.ClientID%>").value = ""
                return false;
            }

            var current_pwd = document.getElementById("<%=CurrentPassword.ClientID%>").value;
            document.getElementById("<%=CurrentPassword.ClientID%>").value = Sha512.hash(Sha512.hash(current_pwd) + '<%=newsalt%>');




            document.getElementById("<%=HdNewPass.ClientID%>").value = Sha512.hash(Newpwd);
            document.getElementById("<%=NewPassword.ClientID%>").value = Sha512.hash(Sha512.hash(Newpwd) + '<%=newsalt%>');




            document.getElementById("<%=HdReNewPass.ClientID%>").value = Sha512.hash(NewRepwd);
            document.getElementById("<%=ConfirmNewPassword.ClientID%>").value = Sha512.hash(Sha512.hash(NewRepwd) + '<%=newsalt%>');


        }

                </script>
            </div>
        </div>
    </div>

</asp:Content>
