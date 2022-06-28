<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true" CodeFile="ResetPassword.aspx.cs" Inherits="ResetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="container ">
        <div class="content">
          <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-6 col-6">
        <h4 class="clr-blue">
                       Form To Reset Password</h4>
          
        <br />
        <div class="form-group">
                                <label for="exampleInputEmail1">
                                    User Id*</label>
                                <asp:TextBox ID="txtUserId" runat="server" class="form-control" placeholder="Enter User Id"
                                    MaxLength="20"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="txtUserId"
                                    ValidationGroup="SubmitDetails" ErrorMessage="Please Enter UserID!" SetFocusOnError="true" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtUserId"
                                    ValidationExpression="^([A-Za-z])+(?:(([A-Za-z\s]))|(\.[A-Za-z\s]+))*([A-Za-z])+$"
                                    ErrorMessage="*Valid characters: Alphabets and space." SetFocusOnError="true"
                                    ValidationGroup="SubmitDetails" />
                            </div>
                            <div class="form-group">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit"
                                    class="btn btn-primary" ValidationGroup="SubmitDetails" 
                                    onclick="btnSubmit_Click" />
                            </div>
                 <p align="center">
            <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </p>
            </div>
            </div>
            </div>
        </div>
        <br />
</asp:Content>

