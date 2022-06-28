<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true"
    CodeFile="Create_User.aspx.cs" Inherits="Create_User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-12">

                <div class="form-group">
                    <center><label for="lbltitle" style="color:#0b2d4d;"><strong>User Details</strong></label></center>
                    <br />
                </div>

                <div class="form-group" id="Tr1" runat="server">
                    <label for="lbluserid" runat="server" enableviewstate="false" style="color:#0b2d4d;">User ID</label>
                    <asp:TextBox ID="txtuserid" AutoPostBack="True" OnTextChanged="txtuserid_TextChanged" MaxLength="15" Width="100%" runat="server" class="form-control"></asp:TextBox>
                    <asp:Label ID="lblMessage" runat="server" ForeColor="red"></asp:Label>
                    <asp:RequiredFieldValidator ID="rfvtxtuserid" runat="server" ControlToValidate="txtuserid" Display="None" ErrorMessage="Please Enter User Id" ValidationGroup="1"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group" id="Tr2" runat="server">
                    <label for="LblUserType" runat="server" enableviewstate="false" style="color:#0b2d4d;">User Type</label>
                    <asp:DropDownList ID="drputype" runat="server" class="form-control" OnSelectedIndexChanged="drputype_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvutype" runat="server" ControlToValidate="drputype" Display="None" ErrorMessage="Please Select User Type" ValidationGroup="1"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group" runat="server" id="TRDepartment">
                    <label for="lblDept" runat="server" enableviewstate="false" style="color:#0b2d4d;">Department</label>
                    <asp:DropDownList ID="ddldept" runat="server" class="form-control" AutoPostBack="true"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvdept" runat="server" ControlToValidate="ddldept" Display="None" ErrorMessage="Please Select Department" ValidationGroup="1"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group" runat="server" id="Tr3">
                    <label for="lblusername" runat="server" enableviewstate="false" style="color:#0b2d4d;">Name</label>
                    <asp:TextBox ID="txtname" AutoPostBack="True" autocomplete="off" MaxLength="50" Width="100%" runat="server" class="form-control"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revname" runat="server" ControlToValidate="txtname" ValidationExpression="^[\sa-zA-Z0-9&.(),-]*$" Display="None" ErrorMessage="Invalid Characters In Name"
                        ValidationGroup="1"></asp:RegularExpressionValidator>
                </div>

                <div class="form-group" runat="server" id="Tr4">
                    <label for="Lblcontact" runat="server" enableviewstate="false" style="color:#0b2d4d;">Contact No</label>
                    <asp:TextBox ID="txtcontact" AutoPostBack="True" TabIndex="4" autocomplete="off" MaxLength="10" Width="100%" runat="server" class="form-control"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revno" runat="server" ControlToValidate="txtcontact" ValidationExpression="^[0-9]*$" Display="None" ErrorMessage="Invalid Characters In Contact No"
                        ValidationGroup="1"></asp:RegularExpressionValidator>
                </div>

                <div class="form-group" runat="server" id="Tr5" visible="true">
                    <label for="lblemail" runat="server" enableviewstate="false" style="color:#0b2d4d;">Email Id</label>
                    <asp:TextBox ID="txtemail" AutoPostBack="True" TabIndex="5" autocomplete="off" MaxLength="50" Width="100%" runat="server" class="form-control"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revemail" runat="server" ControlToValidate="txtemail" Display="None" ErrorMessage="Invalid Characters In Email" ValidationGroup="1"
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                </div>

                <div class="form-group">
                    <asp:Button ID="btnsbmt" runat="server" Text="Submit" CausesValidation="true" OnClick="btnsbmt_Click" class="btn btn-primary"
                                    ValidationGroup="1" />
                </div>
                <asp:ValidationSummary ID="vs" runat="server" ShowMessageBox="true" ValidationGroup="1"
                        ShowSummary="false" />
            </div>
        </div>
    </div>  
        
        <input id="csrftoken" runat="server" name="csrftoken" type="hidden" />

</asp:Content>
