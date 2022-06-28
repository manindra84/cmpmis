<%@ Page Title="" Language="C#" MasterPageFile="~/Master_sitemaster.master" AutoEventWireup="true" CodeFile="Updateofficerdetails.aspx.cs" 
    Inherits="Updateofficerdetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
    <link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/themes/start/jquery-ui.css" rel="stylesheet" type="text/css" />

    <div class="container">
        <div class="row">            
                <div class="col-sm-12 col-md-12 col-lg-12 col-12">
                    <br />
                    <div class="form-group">
                        <center><asp:Label ID="lbl_pgheader" runat="server" class="col-form-label" Text="" style="color:#0b2d4d;font-size: 25px;"></asp:Label></center>
                    </div>

                    <div class="form-group" id="div_userid" runat="server">
                        <label for="lbl_name" style="color: #0b2d4d;"><strong>User ID</strong></label>&nbsp;&nbsp;&nbsp;
                        
                        <asp:TextBox ID="txt_userid" Enabled="false" Width="50%" runat="server" class="form-control" MaxLength="30"></asp:TextBox>                        
                    </div>

                    <div class="form-group">
                        <label for="lbl_name" style="color:#0b2d4d;"><strong>Name of Officer*</strong></label>
                    <asp:TextBox ID="txt_name" Width="50%" runat="server" class="form-control" MaxLength="100"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="tfv_name" runat="server" ControlToValidate="txt_name"
                        Display="none" ErrorMessage="Please Enter Name of HOD" ValidationGroup="1"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regex_name" runat="server" ErrorMessage="Enter only [A-Z] letters !"
                        ValidationExpression="^[a-zA-Z\s]+$" ControlToValidate="txt_name" ValidationGroup="SubmitDetails"
                        ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div> 
                    
                    <div class="form-group">
                        <label for="lbl_desig" style="color:#0b2d4d;"><strong>Designation*</strong></label>
                    <asp:TextBox ID="txt_desig" Width="50%" runat="server" class="form-control" MaxLength="100"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfv_desig" runat="server" ControlToValidate="txt_desig"
                        Display="none" ErrorMessage="Please enter designation" ValidationGroup="1"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regex_desig" runat="server" ErrorMessage="Enter only [A-Z] letters !"
                        ValidationExpression="^[a-zA-Z\s]+$" ControlToValidate="txt_desig" ValidationGroup="SubmitDetails"
                        ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>

                    <div class="form-group">
                        <label for="lbl_mobno" style="color:#0b2d4d;"><strong>Mobile No*</strong></label>
                    <asp:TextBox ID="txt_mobno" Width="50%" runat="server" class="form-control" MaxLength="10"></asp:TextBox>
                    <%--<asp:RequiredFieldValidator ID="tfv_mobno" runat="server" ControlToValidate="txt_mobno"
                        Display="none" ErrorMessage="Please Enter Mobile No" ValidationGroup="1"></asp:RequiredFieldValidator>--%>
                    <%--<asp:RegularExpressionValidator ID="regex_mobno" runat="server" ErrorMessage="Enter only numbers !"
                        ValidationExpression="[0-9]" ControlToValidate="txt_mobno" ValidationGroup="SubmitDetails"
                        ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                    </div>

                    <div class="form-group">
                        <label for="lbl_Email" style="color:#0b2d4d;"><strong>Email*</strong></label>
                    <asp:TextBox ID="txt_email" Width="50%" runat="server" class="form-control" MaxLength="100"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfv_email" runat="server" ControlToValidate="txt_email"
                        Display="none" ErrorMessage="Please Enter Email" ValidationGroup="1"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter valid input !"
                        ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$" ControlToValidate="txt_email" ValidationGroup="SubmitDetails"
                        ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>

                    <div class="form-group">
                        <asp:Button ID="btn_saveHOD" runat="server" class="btn btn-primary" Text="Save" OnClick="btn_saveHOD_Click" />
                        <asp:Button ID="btn_resetuser" runat="server" class="btn btn-primary" Text="Reset Password" OnClick="btn_resetuser_Click" />
                    </div> 
                    
                    <asp:HiddenField ID="hdf_userid" runat="server" />
                
            </div>
        </div>
    </div>
    

</asp:Content>

